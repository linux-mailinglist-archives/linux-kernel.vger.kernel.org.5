Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD017E8515
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKJVcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKJVcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:32:06 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683DC4205;
        Fri, 10 Nov 2023 13:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699651924; x=1731187924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqcEiMovyEdWADV3nVvr7tGxPcK5AkK82nsGuLxcaeM=;
  b=gy55nQLLiHNCjYJO8oZ2fpeUwT+ymQR5EjJbs6D6sden9BzAn2vPvYyq
   BN/Pw1f/6jxg5gGvYJHQLnZXgNnJXOH0ZHl41UdmEFkEdLigNORAlYp2w
   UpqBIx/F3qIh9ptHCgRahEgrvejFYCdvDEci3+yuJaP1w0mh0fAzNDW/Q
   s=;
X-IronPort-AV: E=Sophos;i="6.03,293,1694736000"; 
   d="scan'208";a="367405578"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 21:32:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id 452D2A0D1B;
        Fri, 10 Nov 2023 21:31:59 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:42729]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.85:2525] with esmtp (Farcaster)
 id cc3de777-ea4a-4c4d-95f7-1c856f0df8d4; Fri, 10 Nov 2023 21:31:58 +0000 (UTC)
X-Farcaster-Flow-ID: cc3de777-ea4a-4c4d-95f7-1c856f0df8d4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 21:31:58 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Fri, 10 Nov 2023 21:31:55 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <bragathemanick0908@gmail.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-hams@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <ralf@linux-mips.org>,
        <syzbot+0145ea560de205bc09f0@syzkaller.appspotmail.com>,
        <kuniyu@amazon.com>
Subject: Re: [PATCH] net: memory leak in nr_rx_frame
Date:   Fri, 10 Nov 2023 13:31:47 -0800
Message-ID: <20231110213147.68823-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231110173632.2511-1-bragathemanick0908@gmail.com>
References: <20231110173632.2511-1-bragathemanick0908@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.8]
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Date: Fri, 10 Nov 2023 23:06:32 +0530
> The condition (make = nr_make_new(sk)) == NULL suggests
> that nr_make_new allocates memory and returns a pointer.
> If this allocation fails (returns NULL), it indicates a
> potential memory leak.

If make is NULL, nothing is allocated and leaked here, and
your code will never be executed as "if (make)" is always false.


> 
> Added sock_put() for make which can potentially solve
> this issue

Sounds like the patch is not tested with kmemleak.


> 
> Reported-by: syzbot+0145ea560de205bc09f0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0145ea560de205bc09f0
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  net/netrom/af_netrom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
> index 0eed00184adf..7d7cda4ae300 100644
> --- a/net/netrom/af_netrom.c
> +++ b/net/netrom/af_netrom.c
> @@ -970,6 +970,8 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
>  		nr_transmit_refusal(skb, 0);
>  		if (sk)
>  			sock_put(sk);
> +		if (make)
> +			sock_put(make);

Also, make could be uninitialised here if the first two
condition is true.

   if (sk == NULL || sk_acceptq_is_full(sk) ||


>  		return 0;
>  	}
>  
> -- 
> 2.34.1
