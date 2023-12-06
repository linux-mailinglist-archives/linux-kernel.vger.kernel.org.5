Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49E0806A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbjLFJHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbjLFJHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:07:42 -0500
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1C7D59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:07:48 -0800 (PST)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58daf9b195cso819551eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853667; x=1702458467;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zM+HO/CNAIOemtbijlOjCDoOsqDFzpSN4qUdV1TQLo=;
        b=So85v3PQeJYajyeyKUxi6X4YOvRTbHwttH+oDd2jcCoCIElPNpvD9xlJ9D+9fAOKot
         44Hi8iExgBSWU8DOgu87x9EgTPao+O31jfhxEIKDNOYUOCnsWrUPhDreKdqvRNy32cGn
         9AcsQLL4o/u9hpKVgb+3roF2ijoyBOtOSoxuRz9+wGGb7zNsbxO9yaCygJkU7V9ybez8
         5kgQ6KChD5nlfpyBX1j60Oz3BLpCR8dcEh9XCFJtbhPYoTOg3AjBxeITEs1SMbd1ALw5
         dEFfKgyWXkple0gu2Nxhr7CuoaTScCANKpPgeElrnT4nHEArRMAUtgI75MUJmQnLgg5X
         ic3Q==
X-Gm-Message-State: AOJu0YxGVM2xhXIL1orzgLIPW3007dL3BIOrpD54qHsT9RyrfnjFNx0B
        XJ44O/RdHh4fWeXnPV3iPfoS3G9t8jX8j2Vo7pEa6YzsY9G9qZ0=
X-Google-Smtp-Source: AGHT+IH/KVMp+kPIJ7BO+Kg5bl7EEOvtlgfUXIg3wv0DT1ZI0bz//bJreVUyukPgIhVAIrN1ay4rSIBeHTJGjccaw5zYNkvjtD4I
MIME-Version: 1.0
X-Received: by 2002:a05:6870:210e:b0:1fa:c4ca:d5e with SMTP id
 f14-20020a056870210e00b001fac4ca0d5emr674796oae.2.1701853667430; Wed, 06 Dec
 2023 01:07:47 -0800 (PST)
Date:   Wed, 06 Dec 2023 01:07:47 -0800
In-Reply-To: <0000000000001b9bed060bc75cbc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e991c060bd3af6d@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index 7cac441862e2..f4f24b5d9eea 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -126,7 +126,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
-	if (skb->protocol == htons(ETH_P_802_2)) {
+	if (skb->protocol == htons(ETH_P_802_2)
+	    skb->protocol == htons(ETH_P_TR_802_2)) {
 		__be16 pdulen = eth_hdr(skb)->h_proto;
 		s32 data_size = ntohs(pdulen) - llc_len;
 

