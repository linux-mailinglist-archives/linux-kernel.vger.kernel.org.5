Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A43F7DFDE4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjKCB6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKCB6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:58:01 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8730D187
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:57:59 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b56a1374afso2191337b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 18:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698976679; x=1699581479;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wzMcKPL4fPBrYqdbtb30IyU69l06HPG40miK5awj14=;
        b=KHt9hF5Kq0rpCDKvhbAiUytePsKS1Ce4Zz0b8UYVYo5AktbxwxVGQocmoscEZduIpX
         BDSNjJnxfNq1It+R9eyqSMxBHjfNwk+YmscnpGLUoFdfV/wlTuejFs3FMDY9veZ4OVMH
         fA3J/dyNbqzq3goPlDPxkBFPleP1clMXYwF++YPfyKRdjaIlbCQdeQKyd0QZnkc2zsKC
         R+c+SBc5mcfojXD5Y7TTJHXLBZk94BgTc9Rn7Zo5ALzFY70aEClpijBJd+ZtzRXIS3r4
         TMNtyLtgZqlF3MFzjib9JwlpaWn83o5t0cI8fIG200O5V+5WAVi2AGgKJMxlkj2UcsBD
         95bQ==
X-Gm-Message-State: AOJu0YwyhFXOroMxfBXhgUB316tRuKnyGVfurDxWER8FhpGHtdZ7Tk8I
        8Ysn2sU5LNZ5b7+hEZ7Pcg+EtbCxmgUW0AyJDtNgmpPv9Npggs0=
X-Google-Smtp-Source: AGHT+IF11yoS9SloHF7IyknaQNRDHZi5Rt69+P6ZF4u7P9hpYPhkI2kkDwjTKg20vTPXTAt6D6EOZTfC06KIY/TKU7rm1v0ng5cM
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3295:b0:3ad:eae0:3317 with SMTP id
 cg21-20020a056808329500b003adeae03317mr6216732oib.5.1698976678935; Thu, 02
 Nov 2023 18:57:58 -0700 (PDT)
Date:   Thu, 02 Nov 2023 18:57:58 -0700
In-Reply-To: <00000000000008b2940608ae3ce9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e02eb060935d5e1@google.com>
Subject: Re: [syzbot] Test for 0c8ce1da0ac31abbadcd
From:   syzbot <syzbot+0c8ce1da0ac31abbadcd@syzkaller.appspotmail.com>
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

Subject: Test for 0c8ce1da0ac31abbadcd
Author: syoshida@redhat.com

#syz test

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e22c81435ef7..dc65dd4d26df 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -130,6 +130,8 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
 	hdr->dst_port	= cpu_to_le32(dst_port);
 	hdr->flags	= cpu_to_le32(info->flags);
 	hdr->len	= cpu_to_le32(payload_len);
+	hdr->buf_alloc	= cpu_to_le32(0);
+	hdr->fwd_cnt	= cpu_to_le32(0);
 }
 
 static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,

