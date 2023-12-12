Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B8180F4AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbjLLReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjLLRed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:34:33 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2302CF;
        Tue, 12 Dec 2023 09:34:39 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so4932404a12.2;
        Tue, 12 Dec 2023 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402479; x=1703007279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjqNPmTsqEqqrVWfas3u5VADPjrH7KEM9DoAzSldHo8=;
        b=C2efV6wnQoeNuG1XKhWn2EH7YE8h3aRgl0xJBF4kyooXrLhdy2PlNb+G+Jm2GRlJWK
         hmwtgBLvJgKYQ0csInWxFSh0nl77YYQ2uttXKsCjvUJruJG/CZQlLMxBKGp+fRO7qWJZ
         bztBfZqlK4RRejx5+/ricNkNK6sq0gka1j9emqOQ3AgGQZJD/+jqDmofRBNsVA/A39rX
         2rJLbQ1Vr2wnwS/7YfVSEXV4t6dnQijanazZJJM3w0HxIKCgfqbUkYilN7TD3eyVOsda
         HXeaUrAYZBpujWINircmBTHZkNIN9zpgROgy6MF9Hc5iQdgTLLGJvhUi8rDUcr8AWVMa
         pBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402479; x=1703007279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjqNPmTsqEqqrVWfas3u5VADPjrH7KEM9DoAzSldHo8=;
        b=QP/PsPXD3S/a4mPZ943bXuMeoWJrmNJQ+r/8VMRKtuAaYv/tnR6RSS9Q1Ccp06m/AB
         KifxfFhHS6P8mCpCxzfsTzI0NqCNCk4mcd7tEDu7XBrzbxbPXCzOJ4AkIg9C4/n0msBZ
         kXJsYzq9RZLTLPFJJd10cIQQKAEgE1dO3ilDMyl49uytY92ppCT/sc4iEdBN6HhxXVSC
         twuLXsLBpNAaRdgF4FiggsLDEP1BRqjw82i8OGDi1T9fTWEH4qLpvTshu4FHTqZ0M/pr
         fV4er5VNHqPsOxmUOQ2q/Auwd4E2oKoKavYaW23AGhdj8ImJ3YN+vOzXsAwJV3wTV+TE
         Wjcw==
X-Gm-Message-State: AOJu0YwTQnq0BxjSFgIgyorOVTrQlCgNxzmYH6z8lQJTniMMea4AZC8R
        u7Rn2pFrXfexWHVpFltem2t5O/uNTB2331NG
X-Google-Smtp-Source: AGHT+IGPcGz2GH8gwSM0o4jUtojz2k0rG0D390xUpeft6LaUWb2w/7moy+DHRW/sVfpXmxn2uNBtDg==
X-Received: by 2002:a17:90b:1e07:b0:286:6cc1:3f25 with SMTP id pg7-20020a17090b1e0700b002866cc13f25mr5109756pjb.92.1702402478556;
        Tue, 12 Dec 2023 09:34:38 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id nc4-20020a17090b37c400b00285545ac9d2sm9213862pjb.47.2023.12.12.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:34:38 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Zqiang <qiang.zhang1211@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 4/4] rcutorture: Add fqs_holdoff check before fqs_task is created
Date:   Tue, 12 Dec 2023 23:04:14 +0530
Message-Id: <20231212173414.11602-4-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212173334.GA11572@neeraj.linux>
References: <20231212173334.GA11572@neeraj.linux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang1211@gmail.com>

For rcutorture tests on RCU implementations that support
force-quiescent-state operations and that set the fqs_duration module
parameter greater than zero, the fqs_task kthread will be created.
However, if the fqs_holdoff module parameter is not set, then its default
value of zero will cause fqs_task enter a long-term busy loop until
stopped by kthread_stop().  This commit therefore adds a fqs_holdoff
check before the fqs_task is created, making sure that whenever the
fqs_task is created, the fqs_holdoff will be greater than zero.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 kernel/rcu/rcutorture.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 30fc9d34e329..a0b2520bd32b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3872,7 +3872,9 @@ rcu_torture_init(void)
 	}
 	if (fqs_duration < 0)
 		fqs_duration = 0;
-	if (fqs_duration) {
+	if (fqs_holdoff < 0)
+		fqs_holdoff = 0;
+	if (fqs_duration && fqs_holdoff) {
 		/* Create the fqs thread */
 		firsterr = torture_create_kthread(rcu_torture_fqs, NULL,
 						  fqs_task);
-- 
2.40.1

