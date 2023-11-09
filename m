Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5616C7E7243
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbjKITYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjKITYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:24:08 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E61FCB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:24:05 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc281f1214so11751705ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699557845; x=1700162645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdOGQoTtrLFPWGtWdyVRkq7yrLUktQXoPdSS6BIqcAA=;
        b=YFX9UnCqBfeYt9QUUcHWAL7n8YY7WQMtFOR36uXXfJHlGaeUkXATU0jDGgqvC5xtxS
         iHet3i35Ut0U2XwMJ9aeYhDmI5Idj5yads4hqoSyRYLsX43P9aCpMgD5A5mIhbZgMHpI
         QQOjnO6p1qiWhqnpN1Z6pDk3M6bKUeR0aIvio59FLrYfXzqlgSwVN7XgYgedQ98LBx1p
         A2HUMFxO15o4iD0AR8QZTQDXUbwG695gZ0w4Nj03QlMQeNCmcYzdOhmUKfIsWGOOrFD+
         hoM5pwal58l7Szt8I7CLOwURcDKtbgtGRSPIiLwMfAeTlLb7kcdG+TkWNekMo3yI/iUW
         gdjA==
X-Gm-Message-State: AOJu0YzjQODw7zYTHUyG4si1WrIYOf+0V5rjOglL50ug2m93X57euPuO
        WZiH84Sk8Y5d287RR+F5jwcksQd0U8wBC8FIWqt30fWD+fKKQFg=
X-Google-Smtp-Source: AGHT+IG1EZW9r41Jq9Zf5X5fLW78Lo3zDzF+E2xLNt4ultf8f+DrWl2aIIWkIILAf3PW1hKLbDmIs5ZkvozS4JxVbajF5rGpaDMu
MIME-Version: 1.0
X-Received: by 2002:a17:903:25ce:b0:1cc:bb7f:bd5a with SMTP id
 jc14-20020a17090325ce00b001ccbb7fbd5amr687695plb.6.1699557845492; Thu, 09 Nov
 2023 11:24:05 -0800 (PST)
Date:   Thu, 09 Nov 2023 11:24:05 -0800
In-Reply-To: <000000000000d078d30609b138ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7edb40609bd2506@google.com>
Subject: Re: [syzbot] [PATCH] Fix the null pointer deference in nsim_setup_prog_hw_checks
From:   syzbot <syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] Fix the null pointer deference in nsim_setup_prog_hw_checks
Author: kdipendra88@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 8de1e7afcc1c

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/netdevsim/bpf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index f60eb97e3a62..89206278b6cc 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -317,9 +317,11 @@ nsim_setup_prog_hw_checks(struct netdevsim *ns, struct netdev_bpf *bpf)
 	}
 
 	state = bpf->prog->aux->offload->dev_priv;
-	if (WARN_ON(strcmp(state->state, "xlated"))) {
-		NSIM_EA(bpf->extack, "offloading program in bad state");
-		return -EINVAL;
+	if(state) {
+		if (WARN_ON(strcmp(state->state, "xlated"))) {
+			NSIM_EA(bpf->extack, "offloading program in bad state");
+			return -EINVAL;
+		}
 	}
 	return 0;
 }
-- 
2.34.1

