Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475667E7E60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbjKJRoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjKJRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:41 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E12C7A8A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:39:02 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28001f80712so1633847a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598341; x=1700203141;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HpxX4EtaXQfPNzU8CuBURmPWvL0h5k4O4rZoBinMl8=;
        b=ljoBF9Ojcm7CY2UGWgikwcca+gSnCheHyzFNec1vgv4Su6INJmsHhOUsahBLFKp6H8
         ozBr/6rYbtls8cNgvqXXmvEVRmvmldxfngh387sQlxBETvACaU5gnor1GzQBKniYfizH
         MQ18iKdT8T1HfxTF/Cfj4WgzEFW8yLb88eQStLl+KdTLmBjTPuUcsr/8DEkiE1wntPpl
         a4icFNTjyuVyUZ8wlU8n/qyyj9dzAtlyMJlPPWTeCGyF6kQR8sV/TG2dzn1vyNx6ltZv
         8hkNsxmBnPW6vfotJjXAnL8aqyZxEawMlrSwib7s2RTHXpGOxd8J4FosHsTpyrZysCeh
         Q8sA==
X-Gm-Message-State: AOJu0Yw8YZM9kwSh8CQjJPu6hfC+04/59sU6mKxlfFQF97ymLd5bKOnF
        +X1qBmwpoCcxKTpwijBicGYoQhuXa173hq+AuwYOEmn6gRLJizw=
X-Google-Smtp-Source: AGHT+IHGWy6s1Tyvihr3R+Nn4vdy1NFlWQuO+IqdCn01zeGhaf5aJ2aO3aOWoy1WX74z7ZErgIVE3rKNsXchruakapGCuZQe05GR
MIME-Version: 1.0
X-Received: by 2002:a17:903:3246:b0:1cc:47d4:4936 with SMTP id
 ji6-20020a170903324600b001cc47d44936mr983479plb.1.1699591486743; Thu, 09 Nov
 2023 20:44:46 -0800 (PST)
Date:   Thu, 09 Nov 2023 20:44:46 -0800
In-Reply-To: <000000000000d078d30609b138ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4ad340609c4fa71@google.com>
Subject: Re: [syzbot] [PATCH] net: Fix the null pointer deference in nsim_setup_prog_hw_checks
From:   syzbot <syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] net: Fix the null pointer deference in nsim_setup_prog_hw_checks
Author: kdipendra88@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8de1e7afcc1c

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/netdevsim/bpf.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index f60eb97e3a62..e407efb0e3de 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -97,7 +97,8 @@ static void nsim_prog_set_loaded(struct bpf_prog *prog, bool loaded)
 		return;
 
 	state = prog->aux->offload->dev_priv;
-	state->is_loaded = loaded;
+	if (state)
+		state->is_loaded = loaded;
 }
 
 static int
@@ -317,10 +318,12 @@ nsim_setup_prog_hw_checks(struct netdevsim *ns, struct netdev_bpf *bpf)
 	}
 
 	state = bpf->prog->aux->offload->dev_priv;
-	if (WARN_ON(strcmp(state->state, "xlated"))) {
-		NSIM_EA(bpf->extack, "offloading program in bad state");
-		return -EINVAL;
-	}
+	if (state) {
+		if (WARN_ON(strcmp(state->state, "xlated"))) {
+			NSIM_EA(bpf->extack, "offloading program in bad state");
+			return -EINVAL;
+		}
+	}
 	return 0;
 }
 
-- 
2.34.1

