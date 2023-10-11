Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BEC7C46A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbjJKA2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbjJKA2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:28:51 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DDA184;
        Tue, 10 Oct 2023 17:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696984109; x=1728520109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuZcVqG1Y38jX5g59zUv7HtsOiRZ/8gim6olwT/sCKY=;
  b=ZSBua0anw1DmE5gSi/cZwOywlNHud/6p+0of1xlFIHDzkoGIzh2TWgM6
   JcYye8+VIpsNXEBDsoG89P1WAw+a/MfAV8dzUi8zd/dPyrTYz/j23pOQg
   5lVHHb20i11KQayPmS+BR+fbEg09Cowuk3VkrbT+ayP2MwWsrBuolB01S
   Q=;
X-IronPort-AV: E=Sophos;i="6.03,214,1694736000"; 
   d="scan'208";a="34964492"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:28:26 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com (Postfix) with ESMTPS id 7A7708047B;
        Wed, 11 Oct 2023 00:28:25 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 00:28:25 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 00:28:22 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <f.fainelli@gmail.com>
CC:     <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <kuba@kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <singhabhinav9051571833@gmail.com>,
        <kuniyu@amazon.com>
Subject: Re: [PATCH] Remove extra unlock for the mutex
Date:   Tue, 10 Oct 2023 17:28:14 -0700
Message-ID: <20231011002814.77527-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ab48efc3-9f40-4eed-bdb1-4ce04d3c55cf@gmail.com>
References: <ab48efc3-9f40-4eed-bdb1-4ce04d3c55cf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.21]
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 10 Oct 2023 15:51:13 -0700
> On 10/10/23 15:46, Abhinav Singh wrote:
> > There is a double unlock on mutex. This can cause undefined behaviour.
> 
> Where is the double unlock of head->lock (which is a spinlock and not a 
> mutex, btw)?

Maybe head is just confused with the preceding head2 as the two are
the same type of struct.  They are pointers of different hash tables
though.

bind()ing two sockets to the same 2-tuple will easily trigger hung task.


> 
> > 
> > Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> > ---
> >   net/ipv4/inet_connection_sock.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index aeebe8816689..f11fe8c727a4 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -597,7 +597,6 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
> >   	}
> >   	if (head2_lock_acquired)
> >   		spin_unlock(&head2->lock);
> > -	spin_unlock_bh(&head->lock);
> >   	return ret;
> >   }
> >   EXPORT_SYMBOL_GPL(inet_csk_get_port);
