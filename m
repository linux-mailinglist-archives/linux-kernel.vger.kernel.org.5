Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463157E6C75
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjKIOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKIOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:33:11 -0500
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924192D78
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:33:09 -0800 (PST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cc70f8a58fso9190225ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 06:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699540389; x=1700145189;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGY9Xnk8q9hi/Itl0v8kUP3AlbePOGS7UZt+UfLezIo=;
        b=XphRFBo93HOzvhspwc0OgzkLwGDn2YwzJ4g7PmH8qMVb86BTGhDlFfbyQJ0779pHhj
         PNQUfGFLbLeVfQ9Fug0DSBYI/AF8tayS65qlcCnyjovB1rGw87yBv8HwfyVRbZ+1ouCU
         bxbZQ63+sJ4MYP18rFIoCVWEjjzbsHELfQXnDDBpt0HbkDH9fTEI14eelPo6C9H0NbGn
         p9dNwBW+U7JEXo1hgEL4I+V+EH859ZesTttQxkRmGP9q+at3NND7d2cILoo+ltgFVA8v
         cCwtf4sQwdRSs19hpnpvGK1HqUnS3eNGL0UYmJNh2Un94l/uK/pxd/eW8L16vIriXmw9
         CXDQ==
X-Gm-Message-State: AOJu0YxTSeIVZYPWQrPnKQE1PnnqlrYxsm/wGZlqL4LKmJ/s1HGAUk6K
        9MYNozTC9glKMgT+HT+PdvuBaUT1j5h7RS1WJIn0PmZvha9Oev4=
X-Google-Smtp-Source: AGHT+IEwXTpEkcPGasTVOXHdo+MiK0UWkmKuTIE6CCelIke2fCuVu0LxiUqjHZlqMXstLEADgDd+DHgYweun4/I55DgcmbwJhCNI
MIME-Version: 1.0
X-Received: by 2002:a17:903:328e:b0:1cc:408e:1b0c with SMTP id
 jh14-20020a170903328e00b001cc408e1b0cmr441465plb.5.1699540389190; Thu, 09 Nov
 2023 06:33:09 -0800 (PST)
Date:   Thu, 09 Nov 2023 06:33:09 -0800
In-Reply-To: <0000000000007323f20609b7cfbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002de46e0609b915a0@google.com>
Subject: Re: [syzbot] [PATCH] Test for aea6bf908d73
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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


From d6bab181339771591ed9519dced29a8eb20ddadc Mon Sep 17 00:00:00 2001
From: Lizhi Xu <lizhi.xu@windriver.com>
Date: Thu, 9 Nov 2023 21:31:26 +0800
Subject: [PATCH] nfc/nci: fix uaf in nfc_alloc_send_skb

After releasing the nfc/nci device, nfc_llcp_sock->local should be set to null
to avoid referencing expired devices.

Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 net/nfc/llcp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..024cbba26fc8 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -102,6 +102,7 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 				accept_sk->sk_state_change(sk);
 
 				bh_unlock_sock(accept_sk);
+				lsk->local = NULL;
 			}
 		}
 
@@ -113,6 +114,7 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 		bh_unlock_sock(sk);
 
 		sk_del_node_init(sk);
+		llcp_sock->local = NULL;
 	}
 
 	write_unlock(&local->sockets.lock);
-- 
2.25.1

