Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878A8067EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376937AbjLFHIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjLFHIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:08:00 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D271135
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:08:06 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fae4875e0eso6518988fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 23:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846485; x=1702451285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tXRlkucHpkEAT7gc9CxZr0co86T6E2IM6/eBoEInY0=;
        b=Jx/lkBz8h6HSeHUhPNN3O6VoSg4u/LGdfDxA3HJerZnoH4EXIzjmlTuSyj4qHaqimx
         BMeyBOS/dUHvW7WXhmFww0lZSCjJNgNK1w2t7yuzzecR2RqR0ZABH13lYIQOljmoQ+NJ
         rZpVcoqKfQMLWpgeLK8QCAjKi9x6r+fRakKuCkHsz2ZobvKyzYxXeobBsE+Cia8zxOMB
         I56JpUxDtAzu1f3XhIMbjf+d1/iXm7kKoxC3Kufo8SeL92HXRYlV2Dzw2wexAJRtzsTV
         ghqll2ILzJnYO1GkjvcyIrnqWONLhk0k49QXXopY4IH0nlA39phRYtI3gsQMdJMiJGqf
         DjgQ==
X-Gm-Message-State: AOJu0YwQ2O9tN75OMlF07eOp+lsmsOtK2A1S7/xw+9z3bLVFrafhgp6n
        jx1giFgehkeruUivPyiRXNV8p5Zbn9SpV33ClMnoZkmyP6RyF/k=
X-Google-Smtp-Source: AGHT+IGr9Bo904a9dE+Gs+KO+QjS93ly2KW3nYYDquxnEkK6A5WCw/LtT1RAUyXcFsTfz8HSFnYa3F4TdanDiXDwZYeasafIm6Tj
MIME-Version: 1.0
X-Received: by 2002:a05:6870:4191:b0:1fa:e182:4123 with SMTP id
 y17-20020a056870419100b001fae1824123mr481076oac.7.1701846485537; Tue, 05 Dec
 2023 23:08:05 -0800 (PST)
Date:   Tue, 05 Dec 2023 23:08:05 -0800
In-Reply-To: <0000000000001b9bed060bc75cbc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b9a89060bd203e3@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in __llc_lookup_established
From:   syzbot <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
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

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9c..58e0b8ab41b7 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -126,6 +126,7 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
+	printk("3sp: %d, %d, %d\n", skb->protocol, htons(ETH_P_802_2), htons(ETH_P_TR_802_2));
 	if (skb->protocol == htons(ETH_P_802_2)) {
 		__be16 pdulen;
 		s32 data_size;
@@ -141,7 +142,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 			return 0;
 		if (unlikely(pskb_trim_rcsum(skb, data_size)))
 			return 0;
-	}
+	} else if (skb->protocol != htons(ETH_P_TR_802_2))
+		return 0;
 	return 1;
 }
 

