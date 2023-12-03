Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47680238C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjLCLyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:54:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D322BD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701604477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NsMMCvKq0Ewiy320Ly77st5H5qzHH4bDYVOsTjx5q7g=;
        b=iMIZzSnpWDjmrB1ZYgrjowyrb8jtStYoU144SlKeZ0/HkKD32anqVzJ+VOdEHupMmozEKi
        GXSnc8Tv2FaWnmEpDFYRgCxRk4FXFUDBsTyzdg8JngW/GV4LzwH2PwNCqTVUhRJYhYPntT
        2U7vIjldKSiEhoSFRxdV5kManaHU0no=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-eEVrfJxlOzK7ZjfpVF38DA-1; Sun, 03 Dec 2023 06:54:35 -0500
X-MC-Unique: eEVrfJxlOzK7ZjfpVF38DA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c65e666609so1298107a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 03:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701604474; x=1702209274;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NsMMCvKq0Ewiy320Ly77st5H5qzHH4bDYVOsTjx5q7g=;
        b=g5+r/ldyIR0cXDwe/6P4aToDgoie/1lMwAd+f/zEoPQUg7bTgummtO+1ksY8f+CNBQ
         FW6lwqZq+kJzkN5cqMZldGPDKGeuohas0ZxXhGl39jaWCmYERr+OB/Gd5Hg9c8hPKrZ5
         iZoa+7IKExBulbq5LhDrLfMHmZ3w7iIxfjt+Za4P3+EvR392P671dQ6S/lBhAQw9Ezy5
         LFK74qDFZHdv0XQiXcv6tHjXPygg75QpMfQDnrSMTXpmwvYU2N0KvR1+JJWSuOpw0wng
         R43uZaRzbHkR0lNFwdsCDiPwilbkdi5qVQJoAndYbX3hGYMXB8nzOlDB8urqU/g/kST0
         pBJA==
X-Gm-Message-State: AOJu0YxHqgG1dO/uQl1x2TRVEz/legKjXFHBGe3NLqi47sETzFU4EhQ6
        uJEYqMTpWK1poD+atRkFJKWAV4pRSJAY0D2kj5FcHqFCjsAeP4fxPCToHe4i9d1rCI1UrMag9Ib
        r5B/sGd4O08IXvy6sekl4tcmY
X-Received: by 2002:a05:6a20:7f8f:b0:18b:5b7e:6b9 with SMTP id d15-20020a056a207f8f00b0018b5b7e06b9mr3587797pzj.2.1701604474349;
        Sun, 03 Dec 2023 03:54:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNQD4hRia5373/pCV7PCil0Ivh433RqIJioYM+uHGkbMjdSNcnMOvby2PUm57PEGvQqDzUXg==
X-Received: by 2002:a05:6a20:7f8f:b0:18b:5b7e:6b9 with SMTP id d15-20020a056a207f8f00b0018b5b7e06b9mr3587789pzj.2.1701604474077;
        Sun, 03 Dec 2023 03:54:34 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:7d6c:1284:4ab0:52ee])
        by smtp.gmail.com with ESMTPSA id x188-20020a6263c5000000b006c31c0dfb69sm6132152pfb.188.2023.12.03.03.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:54:33 -0800 (PST)
Date:   Sun, 03 Dec 2023 20:54:09 +0900 (JST)
Message-Id: <20231203.205409.646024453190363727.syoshida@redhat.com>
To:     sumang@marvell.com
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [EXT] [PATCH net v2] ipv4: ip_gre: Avoid skb_pull() failure in
 ipgre_xmit()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <SJ0PR18MB5216A25BD74AE376FB1E536BDB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231202161441.221135-1-syoshida@redhat.com>
        <SJ0PR18MB5216A25BD74AE376FB1E536BDB87A@SJ0PR18MB5216.namprd18.prod.outlook.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

On Sun, 3 Dec 2023 06:58:19 +0000, Suman Ghosh wrote:
> Hi Shigeru,
> 
>>diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c index
>>22a26d1d29a0..5169c3c72cff 100644
>>--- a/net/ipv4/ip_gre.c
>>+++ b/net/ipv4/ip_gre.c
>>@@ -635,15 +635,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
>> 	}
>>
>> 	if (dev->header_ops) {
>>+		int pull_len = tunnel->hlen + sizeof(struct iphdr);
>>+
>> 		if (skb_cow_head(skb, 0))
>> 			goto free_skb;
>>
>> 		tnl_params = (const struct iphdr *)skb->data;
>>
>>-		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
>>-		 * to gre header.
>>-		 */
>>-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
>>+		if (!pskb_network_may_pull(skb, pull_len))
> [Suman] Since this is transmit path, should we add unlikely() here?

Thanks for your comment.

I traced this function and found that pskb_may_pull_reason() seems to
have appropriate likely() and unlikely() as Eric says.

I'm new to Linux networking. Could you kindly explain the background
of your suggestion?

I understand that a transmit path must be as fast as possible, so we
should use unlikely() for rare cases such like this error path. Am I
correct?

Thanks,
Shigeru

>>+			goto free_skb;
>>+
>>+		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
>>+		skb_pull(skb, pull_len);
>> 		skb_reset_mac_header(skb);
>>
>> 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
>>--
>>2.41.0
>>
> 

