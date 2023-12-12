Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2769980F49A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbjLLR1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjLLR1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:27:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8954A1;
        Tue, 12 Dec 2023 09:27:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d32c5ce32eso13394155ad.0;
        Tue, 12 Dec 2023 09:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402061; x=1703006861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn4VwDYjNkD85ZVWjPPzSfZ086ShlP6kMAwWhA80/9Q=;
        b=hwjbdDt1O/UJWL+mAlcCuRSporlwunbYdqIYobRXPTbY+CsuZJ0nu/rqZ5H6XZK1Yx
         B2tANzCcDgFXTcNPnS+Mp9bU/7NuT4VABqL/KwfVkxbPGefRwGT70u4AhOfKzkegycO8
         5FEpVCrDSsGXwVTXPzvEwqdpVhfJWHCuMyqjlUKQY+W9ItQYAuAuW6zlbojkTVs2sKss
         a3v85Y4K8kffoFAYxY0mEyLCyEI70AO4E8BMRe7ATSVMFBf3Xq0kCT9n7VvXVEs31MfY
         cIsLkDsT0bn+sBvDGXTYkfxjF0WFc4eEoVsMvELQUjV7QcDSrtuyGB1u1Sdm6FV7V+jx
         KFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402061; x=1703006861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cn4VwDYjNkD85ZVWjPPzSfZ086ShlP6kMAwWhA80/9Q=;
        b=POSfohYV2tdmzjTx4B+nmWfRiMXmbRWTvjJsylFVOEhnR/PH55rs8z0ubqOqrK9Iiy
         OO92p5iYku8CvBUb1HoTv17Ch5pmE51gy77QBrPa/wu10rw+eTw68r9pTdXsGiY8ttVJ
         0IrburKnsaPi+1CBYmG6wsNrUTSDq1O8NjYF/IZeyQdVX3GZoK/G+KMm7ej65juHVQny
         ic/OvsD5jJLMvtxMz+HvJa8Z/osWXaaB8LXUVUXcLV8W5xDpB+elAOAwg3MybKAPLhb6
         q6C/UUcxz/HNJlLJHNz7qgWeATtr7L+Hx/rgCZ5CMYC033z58kxQR3dTtSTm3Lyiu3OJ
         QBjQ==
X-Gm-Message-State: AOJu0Yx9JqWxhRHpXim3wAwuQeiLyILI0sR95/O3JDjQbJ/jqe263GTj
        F2MBnb2O3/Tj780HDsV7nilbI7zyxN8k0LlB
X-Google-Smtp-Source: AGHT+IFZs+JB5hYaYxpCKaDVO+hzH3H9IIfhFRwa61QlJh+ZDnX9OI3Q1+wWJTWNAzF1pn8LBJozPg==
X-Received: by 2002:a17:902:7202:b0:1d0:5fd7:867c with SMTP id ba2-20020a170902720200b001d05fd7867cmr8234831plb.4.1702402060726;
        Tue, 12 Dec 2023 09:27:40 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001cf511aa772sm8863170plg.145.2023.12.12.09.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:27:40 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 4/5] doc: Mention address and data dependencies in rcu_dereference.rst
Date:   Tue, 12 Dec 2023 22:56:52 +0530
Message-Id: <20231212172653.11485-4-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212172343.GA11383@neeraj.linux>
References: <20231212172343.GA11383@neeraj.linux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds discussion of address and data dependencies to the
beginning of rcu_dereference.rst in order to enable readers to more
easily make the connection to the Linux-kernel memory model in general
and to memory-barriers.txt in particular.

Reported-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Reported-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 Documentation/RCU/rcu_dereference.rst | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 3b739f6243c8..659d5913784d 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -3,13 +3,26 @@
 PROPER CARE AND FEEDING OF RETURN VALUES FROM rcu_dereference()
 ===============================================================
 
-Most of the time, you can use values from rcu_dereference() or one of
-the similar primitives without worries.  Dereferencing (prefix "*"),
-field selection ("->"), assignment ("="), address-of ("&"), addition and
-subtraction of constants, and casts all work quite naturally and safely.
-
-It is nevertheless possible to get into trouble with other operations.
-Follow these rules to keep your RCU code working properly:
+Proper care and feeding of address and data dependencies is critically
+important to correct use of things like RCU.  To this end, the pointers
+returned from the rcu_dereference() family of primitives carry address and
+data dependencies.  These dependencies extend from the rcu_dereference()
+macro's load of the pointer to the later use of that pointer to compute
+either the address of a later memory access (representing an address
+dependency) or the value written by a later memory access (representing
+a data dependency).
+
+Most of the time, these dependencies are preserved, permitting you to
+freely use values from rcu_dereference().  For example, dereferencing
+(prefix "*"), field selection ("->"), assignment ("="), address-of
+("&"), casts, and addition or subtraction of constants all work quite
+naturally and safely.  However, because current compilers do not take
+either address or data dependencies into account it is still possible
+to get into trouble.
+
+Follow these rules to preserve the address and data dependencies emanating
+from your calls to rcu_dereference() and friends, thus keeping your RCU
+readers working properly:
 
 -	You must use one of the rcu_dereference() family of primitives
 	to load an RCU-protected pointer, otherwise CONFIG_PROVE_RCU
-- 
2.40.1

