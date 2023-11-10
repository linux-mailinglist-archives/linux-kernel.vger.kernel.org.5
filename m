Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B728E7E8331
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbjKJTqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346622AbjKJTpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:45:46 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4AD2F372
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:26:03 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc274dbbc6so20312765ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699615563; x=1700220363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndwpFkXM+pkZS2SSSy1Rs6keC3D9FSacvyrcggd9+44=;
        b=fx9b5C74rbjtipK8CbMw5ydJfENFf8H+zXso6RsixNSf12j1Gd9g1alz6L1z3POdu6
         8EhvtZK4aXzVxPOEeG25jwIYC1JWWiClkUQd76eSKtq85Jr67PjT7UvWf2i3luioYLdS
         zyKmqGGGC/FniNAaMJAxcEZjZg1uMCAvO8GtS4n/oPNKRB9iOHnfAAcV6uZJx8dAnbTL
         Y3aXWEht93CR645QG95dLTDcVl2YRbTw0NcR7tvdYlWeVBXHAsmYE5Hlk1smVQ97BRd0
         nergXz3879j2vsjvEDUwbSz8LyYB5fW4GNIHJYiarFIEegupd10s6OROeDTNf+9gCsP1
         vN9Q==
X-Gm-Message-State: AOJu0YxojqcjlFH9m+MELbGbJF8zEiskR8DvEvEp3WCNjV3529OOk2y0
        UhLUCqXxOhTM0EfY711IZXFelMaB//EOiY82oNPGlhhoILYGF/w=
X-Google-Smtp-Source: AGHT+IEeonVcSSIGev7U5Z+9nmR8zuilwqvqXFbFnD4BTEVgBm1nqi+VCoXRaBww5WatxPsgAfweeyDjc2wSsGghiT6LndnaewN7
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4c2:b0:1cc:5db8:7ea5 with SMTP id
 o2-20020a170902d4c200b001cc5db87ea5mr1370236plg.3.1699615563550; Fri, 10 Nov
 2023 03:26:03 -0800 (PST)
Date:   Fri, 10 Nov 2023 03:26:03 -0800
In-Reply-To: <0000000000007323f20609b7cfbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb97f90609ca95c3@google.com>
Subject: Re: [syzbot] [PATCH] Test for aea6bf908d73
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
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

Subject: [PATCH] Test for aea6bf908d73
Author: eadavis@qq.com

please test uaf in nfc_alloc_send_skb

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git aea6bf908d73

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index e2680a3bef79..f5dd2d7e41de 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -738,7 +738,8 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 
 	pr_debug("Send UI frame len %zd\n", len);
 
-	local = sock->local;
+	local = nfc_llcp_find_local(sock->dev);
+	printk("finded: %p, d: %p, %s\n", local, sock->dev, __func__);
 	if (local == NULL)
 		return -ENODEV;
 
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..8d47f17da904 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -299,6 +299,7 @@ static struct nfc_llcp_local *nfc_llcp_remove_local(struct nfc_dev *dev)
 	spin_lock(&llcp_devices_lock);
 	list_for_each_entry_safe(local, tmp, &llcp_devices, list)
 		if (local->dev == dev) {
+			printk("deled: l: %p, d: %p, %s\n", local, dev, __func__);
 			list_del(&local->list);
 			spin_unlock(&llcp_devices_lock);
 			return local;
-- 
2.25.1

