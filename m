Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB0E7A46DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbjIRKXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241195AbjIRKXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:23:15 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F77121;
        Mon, 18 Sep 2023 03:22:57 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qiBOj-0005r4-FR; Mon, 18 Sep 2023 12:22:33 +0200
Date:   Mon, 18 Sep 2023 12:22:33 +0200
From:   Florian Westphal <fw@strlen.de>
To:     George Guo <guodongtai@kylinos.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tcp: enhancing timestamps random algo to address
 issues arising from NAT mapping
Message-ID: <20230918102233.GA9759@breakpoint.cc>
References: <20230918014752.1791518-1-guodongtai@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918014752.1791518-1-guodongtai@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

George Guo <guodongtai@kylinos.cn> wrote:
> Tsval=tsoffset+local_clock, here tsoffset is randomized with saddr and daddr parameters in func
> secure_tcp_ts_off. Most of time it is OK except for NAT mapping to the same port and daddr.
> Consider the following scenario:
> 	ns1:                ns2:
> 	+-----------+        +-----------+
> 	|           |        |           |
> 	|           |        |           |
> 	|           |        |           |
> 	| veth1     |        | vethb     |
> 	|192.168.1.1|        |192.168.1.2|
> 	+----+------+        +-----+-----+
> 	     |                     |
> 	     |                     |
> 	     | br0:192.168.1.254   |
> 	     +----------+----------+
> 	 veth0          |     vetha
> 	 192.168.1.3    |    192.168.1.4
> 	                |
> 	               nat(192.168.1.x -->172.30.60.199)
> 	                |
> 	                V
> 	               eth0
> 	         172.30.60.199
> 	               |
> 	               |
> 	               +----> ... ...    ---->server: 172.30.60.191
> 
> Let's say ns1 (192.168.1.1) generates a timestamp ts1, and ns2 (192.168.1.2) generates a timestamp
> ts2, with ts1 > ts2.
> 
> If ns1 initiates a connection to a server, and then the server actively closes the connection,
> entering the TIME_WAIT state, and ns2 attempts to connect to the server while port reuse is in
> progress, due to the presence of NAT, the server sees both connections as originating from the
> same IP address (e.g., 172.30.60.199) and port. However, since ts2 is smaller than ts1, the server
> will respond with the acknowledgment (ACK) for the fourth handshake.
> 
>        SERVER                                               	CLIENT
> 
>    1.  ESTABLISHED                                          	ESTABLISHED
> 
>        (Close)
>    2.  FIN-WAIT-1  --> <SEQ=100><ACK=300><TSval=20><CTL=FIN,ACK>  --> CLOSE-WAIT
> 
>    3.  FIN-WAIT-2  <-- <SEQ=300><ACK=101><TSval=40><CTL=ACK>      <-- CLOSE-WAIT
> 
>                                                             (Close)
>    4.  TIME-WAIT   <-- <SEQ=300><ACK=101><TSval=41><CTL=FIN,ACK>  <-- LAST-ACK
> 
>    5.  TIME-WAIT   --> <SEQ=101><ACK=301><TSval=25><CTL=ACK>      --> CLOSED
> 
>   - - - - - - - - - - - - - port reused - - - - - - - - - - - - - - -
> 
>    5.1. TIME-WAIT   <-- <SEQ=255><TSval=30><CTL=SYN>             <-- SYN-SENT
> 
>    5.2. TIME-WAIT   --> <SEQ=101><ACK=301><TSval=35><CTL=ACK>    --> SYN-SENT
> 
>    5.3. CLOSED      <-- <SEQ=301><CTL=RST>             		 <-- SYN-SENT
> 
>    6.  SYN-RECV    <-- <SEQ=255><TSval=34><CTL=SYN>              <-- SYN-SENT
> 
>    7.  SYN-RECV    --> <SEQ=400><ACK=301><TSval=40><CTL=SYN,ACK> --> ESTABLISHED
> 
>    1.  ESTABLISH   <-- <SEQ=301><ACK=401><TSval=55><CTL=ACK>     <-- ESTABLISHED
> 
> This enhancement uses sport and daddr rather than saddr and daddr, which keep the timestamp
> monotonically increasing in the situation described above. Then the port reuse is like this:

We used to have per-connection timestamps, i.e. hash used to include
port numbers as well.

Unfortunately there were problem reports, too many devices expect
monotonically increasing ts from the same address.

See 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets")

So, I don't think we can safely substitute saddr with sport.
