Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5DC809284
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjLGUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443910AbjLGUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:38:59 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D211713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:39:06 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d4f71f7e9fso12608867b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701981545; x=1702586345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOAgpJU0JgXYQxB1eWGGjpttQzJCZxojyeFpRMgz7us=;
        b=Xqep590r941VZkOUVFs8NAvGcJyrybGQ+D4OK0fCdAIsOFEllsPu9MZxp6fCQyp8W8
         255bYY/qu202GuFgq/qxuasMGiC3pt90EczWSvSCqXW7yEpHLbaBe1MUhYAccGXzvCnm
         5iTP3+8rZsKmj5ZGsIzK++BGFc5cbb0d9hMfUlB4XW4egAaRqPgWehlX0yA+77mo1NCB
         W0w4II17E9M93yAnsBvi/biJHskcBg9wXNWla8tf+Qn7sGHwhz1pivRBg88bu17y0PJE
         Qr9COoYz0s5x5jFkEIJ86yQQRwhO4h9kBxvAA7uzhX5ONDlBmuFARoXrTNJkXLL54WbV
         mh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981545; x=1702586345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOAgpJU0JgXYQxB1eWGGjpttQzJCZxojyeFpRMgz7us=;
        b=Vd92i7AK2DbH2uzMKx+lwRyb7wSQCZyb+mlEXrgHkOiaBbrGELwDeXbC3K4uC5SrkB
         6v8XU4axNELi1c+84hZR5TbkydInQNoM0vgB2YWqZ47WMTzokjFcjJdbXZxnbpO/4gUm
         QPqhks5orE8MHDElS9p5uMBl8gkGOtG0vAa/obTuYWjPLCJN69EuYPaiaqo+YpyxtwjQ
         +ifSyxgCueMrrt+b6M8XAuIks+vOZplShyNsWcbLL1yV63wKYwkOVW+29oHtVpdv+V7w
         8Ihi+5ZTl9vJZAwnk72UTVi/LtL3DiREzmFXb4BXdwKvKMcC8AdSePG+dbYFm03AugbS
         35kg==
X-Gm-Message-State: AOJu0Yw042IcdAt32cPWgJYyvdIwuUekbLW6wkf9GpgZAmuX1YVhhjqt
        GhzJOkAAtROwU97VMDe0PJ0=
X-Google-Smtp-Source: AGHT+IHXPZzbcjXplvZRnh8mEoikxeqtF6BBIDzDme3gYh4PuTEDeCy6cGD0/5b0VYJznxPv52UDhA==
X-Received: by 2002:a05:690c:c0a:b0:5d7:3f4d:2e2f with SMTP id cl10-20020a05690c0c0a00b005d73f4d2e2fmr2972497ywb.14.1701981545421;
        Thu, 07 Dec 2023 12:39:05 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id g68-20020a0dc447000000b005cb7fccffe2sm139604ywd.126.2023.12.07.12.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:39:04 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 2/6] lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
Date:   Thu,  7 Dec 2023 12:38:56 -0800
Message-Id: <20231207203900.859776-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207203900.859776-1-yury.norov@gmail.com>
References: <20231207203900.859776-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because nmsk and irqmsk are stable, extra atomicity is not required.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..8eb18c6bbf3b 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -24,8 +24,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 		if (cpu >= nr_cpu_ids)
 			return;
 
-		cpumask_clear_cpu(cpu, nmsk);
-		cpumask_set_cpu(cpu, irqmsk);
+		__cpumask_clear_cpu(cpu, nmsk);
+		__cpumask_set_cpu(cpu, irqmsk);
 		cpus_per_grp--;
 
 		/* If the cpu has siblings, use them first */
@@ -34,9 +34,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 			sibl = cpumask_next(sibl, siblmsk);
 			if (sibl >= nr_cpu_ids)
 				break;
-			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
-				continue;
-			cpumask_set_cpu(sibl, irqmsk);
+			__cpumask_clear_cpu(sibl, nmsk);
+			__cpumask_set_cpu(sibl, irqmsk);
 			cpus_per_grp--;
 		}
 	}
-- 
2.40.1

