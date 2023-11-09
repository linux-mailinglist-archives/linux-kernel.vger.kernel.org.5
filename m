Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D4C7E71E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbjKITEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKITEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:04:04 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FD2D57
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:04:02 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5bdbd1e852dso1312442a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556641; x=1700161441;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdOGQoTtrLFPWGtWdyVRkq7yrLUktQXoPdSS6BIqcAA=;
        b=vjH2P/+BfJUYXf9a9vywhUsP9pB+aEbjO2AUvPoCwEjk95FuwaOuSEPAZR4nXOyb/2
         3tjYceADn/tYki0sDz67upc7BMINzaK8Y58RFhLxug3q7H3G0gt+bfwvwo+ZayHPV9Pm
         IIReERggmtnUukOPVZSYMw2/y5gwMkzsH3R/04DzowsUuG2hT6VApYbLfoWPs73V3FCK
         Z6TRzHsI/vzBZU3sNQfp6acHWEV9+oibHV/Z9PAQkccBBMUQDQCj5FjH4mfM84OU66N6
         s3c8QkGIn50bunBiBGsbrndFRWKTN+O3PypGkY0JxKwXM+bss+DBhg9gGEqJGIqlwbE0
         /AwQ==
X-Gm-Message-State: AOJu0YyEJ0xKVFOzQIIiivQvf7eSIJI7SZ+tip9JG7MU7kL6BVt/rjF5
        amv4msCqJi4WdDb+aL94mlnHyy6PitJSQUT8kWChZfc1TCzXxPU=
X-Google-Smtp-Source: AGHT+IGiELXRo40oYworpkJcCT7s1C8/Q+c0Gl8iYbb4ugcl5NhLH4TL+T706FGtDuZAPTlBLSrby6VzzmupT+DtTtxTxhNedop0
MIME-Version: 1.0
X-Received: by 2002:a63:f314:0:b0:5bd:3b33:88c7 with SMTP id
 l20-20020a63f314000000b005bd3b3388c7mr571593pgh.0.1699556641781; Thu, 09 Nov
 2023 11:04:01 -0800 (PST)
Date:   Thu, 09 Nov 2023 11:04:01 -0800
In-Reply-To: <0000000000007323f20609b7cfbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8bf930609bcddfa@google.com>
Subject: Re: [syzbot] [PATCH] Fix the null pointer deference in nsim_setup_prog_hw_checks
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
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

