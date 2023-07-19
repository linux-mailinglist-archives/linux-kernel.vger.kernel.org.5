Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8408759BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGSRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGSRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:05:04 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D1510CB;
        Wed, 19 Jul 2023 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689786303; x=1721322303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n3xuV25OzbskrlT52LWtJFNWdqbbfavJdeAVLDvE9YI=;
  b=ABkJ3+EhI+BnK7bDkvCYxCH+vy/K4j/utwNEGM5r2staL0z2TC16M/Di
   mS7VTynCOIV9AFMVNgZaHwef3ZdE/vgvJc3j7YRbZAclaK+OrylZ1TIWr
   4wtPjiqoiiFaUqqlKeHpJhFIhfbuIL2Jh+cdEgTQom8e1d0EzbKs0ZCt9
   M=;
X-IronPort-AV: E=Sophos;i="6.01,216,1684800000"; 
   d="scan'208";a="227505479"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 17:05:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id DF90E40DA2;
        Wed, 19 Jul 2023 17:04:58 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 17:04:57 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 19 Jul 2023 17:04:53 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <leitao@debian.org>
CC:     <alexander@mihalicyn.com>, <ast@kernel.org>, <davem@davemloft.net>,
        <dhowells@redhat.com>, <edumazet@google.com>,
        <kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
        <leit@meta.com>, <linux-kernel@vger.kernel.org>,
        <lucien.xin@gmail.com>, <martin.lau@kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: Use _K_SS_MAXSIZE instead of absolute value
Date:   Wed, 19 Jul 2023 10:04:45 -0700
Message-ID: <20230719170445.30993-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230719084415.1378696-1-leitao@debian.org>
References: <20230719084415.1378696-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.21]
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>
Date: Wed, 19 Jul 2023 01:44:12 -0700
> Looking at sk_getsockopt function, it is unclear why 128 is a magical
> number.
> 
> Use the proper macro, so it becomes clear to understand what the value
> mean, and get a reference where it is coming from (user-exported API).
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9370fd50aa2c..58b6f00197d6 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1815,7 +1815,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  
>  	case SO_PEERNAME:
>  	{
> -		char address[128];
> +		char address[_K_SS_MAXSIZE];

I guess you saw a bug caught by the fortified memcpy(), but this
doesn't fix it properly.

I'll post a series soon that fix the issue and another realted one.

Thanks!


>  
>  		lv = sock->ops->getname(sock, (struct sockaddr *)address, 2);
>  		if (lv < 0)
> -- 
> 2.34.1
