Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D050806B55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377403AbjLFKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377386AbjLFKJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:09:25 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF71A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:09:31 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b8b6acbac2so6071102b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857371; x=1702462171;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW6vSeG1bb+ALsfd79lpv5PPHAPw85c9HA8gaaeBii8=;
        b=QvXja/2M/K6JPOefhaP9mS68K7ZRjvvcklCm3Dq/shmTX3eEJ2pech3Ij6NemAmT/E
         ugZy9ouDjn46Ewaqag7v977R28YVvsy9fIwrGj7SP6aVWi50kkk6bXUBsCoRIaeF5+NT
         NlbMxEKaqKOiSy40W99fMatr6w+F4l63ZvwlMPjJsZX8+e75EE4SFFS7r/rbhmzigR72
         yJvwX5IeOp25FzFc0NHPU9POivrmhcJG6zMhFZ+/vFC4/Gg10fvcxi8GLpIPmoAptW4T
         pM9ZOPH6yNORiCXPzo2o8LJSuhle3W3L1YqCi8P5ZuHohknnq2N3fSDxN/NZ9zS8BN+n
         G9/g==
X-Gm-Message-State: AOJu0YzioRpXZOCX4GBASL4EKn81IDUbnzCfIU/N1DFvlH/EOKqwpzD8
        MI1ITUEUGj0cBLq69Px7pHq5DQUchwPpiLIPT4DtLNjxzSbZL2c=
X-Google-Smtp-Source: AGHT+IFZV7aQ1hwHUlAVl+f70mdLy5YXWzfnLks61K3eCFiFiJgdxkZ8rWp0ARGqLJ1uLk9fRIzTGwF/pSrWbgV1B+av8Lqx7ZR3
MIME-Version: 1.0
X-Received: by 2002:a05:6808:23d3:b0:3b8:62f8:4c63 with SMTP id
 bq19-20020a05680823d300b003b862f84c63mr678001oib.2.1701857370897; Wed, 06 Dec
 2023 02:09:30 -0800 (PST)
Date:   Wed, 06 Dec 2023 02:09:30 -0800
In-Reply-To: <0000000000001b9bed060bc75cbc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d0792060bd48caa@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [net?] KMSAN: uninit-value in __llc_lookup_established
Author: eadavis@qq.com

please test uninit-value in __llc_lookup_established

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1c41041124bd

diff --git a/include/net/llc_pdu.h b/include/net/llc_pdu.h
index 7e73f8e5e497..cba149476e41 100644
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -262,7 +262,8 @@ static inline void llc_pdu_header_init(struct sk_buff *skb, u8 type,
  */
 static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
+	if (skb->protocol == htons(ETH_P_802_2) || 
+	    skb->protocol == htons(ETH_P_TR_802_2))
 		memcpy(sa, eth_hdr(skb)->h_source, ETH_ALEN);
 }
 
@@ -275,7 +276,8 @@ static inline void llc_pdu_decode_sa(struct sk_buff *skb, u8 *sa)
  */
 static inline void llc_pdu_decode_da(struct sk_buff *skb, u8 *da)
 {
-	if (skb->protocol == htons(ETH_P_802_2))
+	if (skb->protocol == htons(ETH_P_802_2) || 
+	    skb->protocol == htons(ETH_P_TR_802_2))
 		memcpy(da, eth_hdr(skb)->h_dest, ETH_ALEN);
 }
 
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 7cac441862e2..f4f24b5d9eea 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -126,7 +126,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
-	if (skb->protocol == htons(ETH_P_802_2)) {
+	if (skb->protocol == htons(ETH_P_802_2) ||
+	    skb->protocol == htons(ETH_P_TR_802_2)) {
 		__be16 pdulen = eth_hdr(skb)->h_proto;
 		s32 data_size = ntohs(pdulen) - llc_len;
 

