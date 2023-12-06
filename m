Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD615806413
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjLFBOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjLFBOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:14:47 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6CB181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:14:53 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b8b5b4edd8so4778421b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 17:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701825293; x=1702430093;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+ChXmEFDAIC815JXF2BVBznoutLyvt3bx+aps0Cz7w=;
        b=JnFvRz7/gDURl9k6zww5ak8WR1brnDdWh970JxefyRL/Sqa8WXUDDkrE52ab4OfMdI
         BODMI6hkW7IheXQJxvO+kPXEdYroSWFXrheuSr0oMGhZ8NBufqOzf3/Fm2rlcuE6BMWC
         Ce1Gc5Y4evHwEP5mW23k7i4XXGYrsevvdBZOhh4i8Q3m5UVZYmJM8ZQV6JkzGpn1Aqbv
         dH804YkLuoIxpyNqb1lzZPdk4dNSt9Nb3zUbKyUj39w5KzuTnbr/+3XbvABf1TYjOUQg
         x2g1yeLIn/kXcU16pwGkpTmUaNjbu6x5EJsJjlaHGh5M3R25hW15Wqh++pd/2Bij1/qS
         Ftuw==
X-Gm-Message-State: AOJu0YwYTUxFgfdFnV/Ldg3fXeH8DaeRmlWMmApmKGek7L+eDzZ2aG32
        sD5uQ2nnSxfdluPJTh9nrj6A1+KOKp+Ka9tVUOApMN6qRrn3eJ4=
X-Google-Smtp-Source: AGHT+IG6kxLsXvaGuuCIFp4oUXZlFVatOMBVwMDmXoy/qq9DL0PxKUJxZzbexafVKtVZN/39VtZIGEYmL+dhULvEBO5+9YEx9lr9
MIME-Version: 1.0
X-Received: by 2002:aca:1c19:0:b0:3b8:b1e3:c576 with SMTP id
 c25-20020aca1c19000000b003b8b1e3c576mr149070oic.5.1701825293314; Tue, 05 Dec
 2023 17:14:53 -0800 (PST)
Date:   Tue, 05 Dec 2023 17:14:53 -0800
In-Reply-To: <0000000000001b9bed060bc75cbc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013f13b060bcd149d@google.com>
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

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9c..58e0b8ab41b7 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -126,6 +126,7 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
+	printk("3sp: %d\n", skb->protocol);
 	if (skb->protocol == htons(ETH_P_802_2)) {
 		__be16 pdulen;
 		s32 data_size;
@@ -141,7 +142,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 			return 0;
 		if (unlikely(pskb_trim_rcsum(skb, data_size)))
 			return 0;
-	}
+	} else
+		return 0;
 	return 1;
 }
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index afa5497f7c35..bff910513fc3 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1900,6 +1900,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		skb->protocol = eth_type_trans(skb, tun->dev);
 		break;
 	}
+	printk("sp: %d\n", skb->protocol);
 
 	/* copy skb_ubuf_info for callback when skb has no error */
 	if (zerocopy) {
@@ -1999,6 +2000,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 		local_bh_enable();
 	} else if (!IS_ENABLED(CONFIG_4KSTACKS)) {
+		printk("2sp: %d\n", skb->protocol);
 		tun_rx_batched(tun, tfile, skb, more);
 	} else {
 		netif_rx(skb);

