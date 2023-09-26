Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA57AEBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjIZL5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjIZL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:57:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B96DE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:57:36 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-565e395e7a6so4419029a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695729455; x=1696334255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsVwcIMcXgFsiUVKDmRKkuK9uYVF+Xg1uxYKZQZf4yM=;
        b=SuyQbBJhTKK2x+gD/9l6cIwrDrG6QfnC5UgJIJAQrf4t4yGQom1kfFTM4cgDAOxodh
         mJNIZj7tsP0ObMq+/B+z1NQk1iQXDbVe9IqaU8X4y+ElomJaQrzuvJQ+pWMmk3S8jvBV
         Z+oBhsOVX7HPY35QnVuUjh6AnvKicaNelAlyYnFH3orpExntFWMiPTBTR32Vt8V8rR20
         3QWuEvgPu1BO0+u4X+9KIX/DuxO7uibIPljbqtx03hVns8wvkolG0XcVNwQafmBLHY70
         3qZNjk8vv8QUPxXFNmNdh0Rff+WHJv5qPcFGp36k/Ec32lAV/KG+z3hmpGDLjGNmc2wn
         Afhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695729455; x=1696334255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsVwcIMcXgFsiUVKDmRKkuK9uYVF+Xg1uxYKZQZf4yM=;
        b=xDB51lA/avBGImw1fHxZCKEA6LQjtiuD1AgjMT3yrUYSFMHzhMwhGv14mYKPJKNbjM
         /MrhWYwrN04drnGvPRh4uf+Ern0pZ2RAKsW4l7i3jdxYdgzgVCCXuKID5cM4WM33gSoC
         J8SOG2ZxNLkyIztTy9MBXhOPVRpiik+igTYfmAZYCOb+KxhNJ5qD2qJfdes6Q3BmQZmw
         j0lT+x+5P4t1NESbfljUAFVPXrhGaM4bRG1b5ikhHuXWFUb0SIywbSgRu8VJeJscqU43
         4iECkz9TUIk/dohGhwypfqsirzcH5rgBskisGyv26weHioVfzYJatjSzWFu1qsCLO1Op
         i/Mw==
X-Gm-Message-State: AOJu0YwCAi2hNKyWJX7AI7lzFqg0V516wgRxcyHrQsrHgnf1iiIBFQxX
        PBhHmc6+XFMMrNLRe0cI6cximaR0fwgeECQylck=
X-Google-Smtp-Source: AGHT+IHlvz13p5veAwAEABBNomYYnINWlYRuT7vNXsoG/tmKRSMFTcFpT0CX6nK0HNaBIFL95UcbPg==
X-Received: by 2002:a17:90b:1b41:b0:273:4672:98b5 with SMTP id nv1-20020a17090b1b4100b00273467298b5mr6035749pjb.42.1695729455567;
        Tue, 26 Sep 2023 04:57:35 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id nn5-20020a17090b38c500b002749a99318csm9854533pjb.26.2023.09.26.04.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 04:57:35 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     hannes@cmpxchg.org
Cc:     surenb@google.com, zhouchengming@bytedance.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH RESEND] sched/psi: bail out early from irq time accounting
Date:   Tue, 26 Sep 2023 11:57:22 +0000
Message-Id: <20230926115722.467833-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925123106.GB347250@cmpxchg.org>
References: <20230925123106.GB347250@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We could bail out early when psi was disabled.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 kernel/sched/psi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 81fca77397f6..e74e14762d49 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1005,6 +1005,9 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 	struct psi_group_cpu *groupc;
 	u64 now;
 
+	if (static_branch_likely(&psi_disabled))
+		return;
+
 	if (!task->pid)
 		return;
 
-- 
2.25.1

