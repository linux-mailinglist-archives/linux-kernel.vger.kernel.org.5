Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF932806937
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjLFINp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjLFINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:13:43 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99411BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:13:39 -0800 (PST)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b9ced51358so243138b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850419; x=1702455219;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSxsGQPxko/ZMV5fKP+i5TD+skQG039q9/33pyBhqxM=;
        b=bAcxncOXqa1VLd3Mt3M1dS3v7+Fkc4k206fitMsbMBleWlEP3NNZX6374YAC1EWb8u
         WX17Z/lfiz3HoDmS+PCnYhjGc2ikWsCItTeobYjnlR51IzjhRrdxBfUFC5qWFWjLqJxa
         g6Um8vKAv15hcVqvaJGh1EZAsGPr1ITwH36dNnoyrLzOcxA9CmsFv6p8z5F6mDN8JJK2
         V4HRykc7THF8hXoJifp6+/+JIqpDM8eHKk9RTIc7VU0ZMr/tn85NPHe3WKQI9zrl/Z8f
         iJlTpOAWHMOS0zU7Sce2/iPhBlOZ+06XJZunNzHA/gDvm3RDDWYvxQDILPZ4xe4ib8K3
         q87w==
X-Gm-Message-State: AOJu0YyYrlDZlE2l9RGMFZLEXcjEiW1wAInPqM+frjlbwqDSq/W27i1Q
        eeT+5aBjJW6WWam5iAEwmFAVbHRCfPs2u/M4rlPMGWTMBo0fl78=
X-Google-Smtp-Source: AGHT+IHChSqNcTDGNk7CsZ9s3YrUKx7OkUTCrSKiNT1rhrD0IcEqOfxY/uSq2+Wv+0Y1EWwpQRL9sDlKZKto42FyHVWSXS4cM0a4
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1522:b0:3b9:b358:f21a with SMTP id
 u34-20020a056808152200b003b9b358f21amr571520oiw.9.1701850418784; Wed, 06 Dec
 2023 00:13:38 -0800 (PST)
Date:   Wed, 06 Dec 2023 00:13:38 -0800
In-Reply-To: <0000000000001b9bed060bc75cbc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac31ef060bd2ed6f@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
index 51bccfb00a9c..ed1a2b59b40c 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -126,7 +126,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
-	if (skb->protocol == htons(ETH_P_802_2)) {
+	if (skb->protocol == htons(ETH_P_802_2) || 
+	    skb->protocol == htons(ETH_P_TR_802_2)) {
 		__be16 pdulen;
 		s32 data_size;
 

