Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7AC7DE869
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347432AbjKAW6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347154AbjKAW6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:58:33 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2EDB9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:58:31 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a82c2eb50cso4391417b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 15:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698879510; x=1699484310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k0IeS2aGdp15vS08AFa8OvRrkQNOjngbPieIhmhkWY=;
        b=IJ+fV339yMky4n0SaOgxnEYUAvEJUPGtWNZA4D+nacF7hMV0d4NQ8a7EgRErCQa7Y5
         ui5EZbEYgWAKMDweypSJvK7IPpIwX8H/3k/Kf8/KSIxdkLx/KyPPDO9ALphduoXdoDNF
         9lneFyPSBxoLNmgI2vK4Gez3Pb1wmvhmfwHQN6OOg5RzXVIqPP1w6eu+7nsOkkSSoybs
         ci53iRCH0dhVw756+oGE3rH2hEaSVyfcESPiawFawEXI9oAZqgrIMCsegtUL7JOVzz2J
         UygAU1aVBI5i7zbk3q0hnTWAavqxHpVmh5pNOeKTqhg5JZUukyuozupu4P34jlYURwyH
         DsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698879510; x=1699484310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k0IeS2aGdp15vS08AFa8OvRrkQNOjngbPieIhmhkWY=;
        b=N/BOn79s6a/k7yQgh1FHsoDIcRaDw2qlVi/WImUGH55TQty3GsDuElyjIj+ULNprxR
         X7ryWCbOdhv3jBGOidWrN4q7VVkdJkQ80cw32XK27W7e47YGgsFcTMEn9qaVvsszw1Kp
         dWO6OWN4hWmeHXeL/18k0jnuOxVi/qfjZexag53R6rCiXc+6tXxPDze9C1VZllEPtBOL
         afhTt8p1Nl6EeVsJPHZouIO8ZW2EmQ1TkG2P6fJdgm8IKClgd3UrXx5nxA7vQnvYU3YD
         hIuohw+rT9G/9mnAHw1oMUmgAAN7kFcOtDDpuLqFxuWRVE2Gep6jnOQuWEazpPT/3XV5
         BC9w==
X-Gm-Message-State: AOJu0YzFp8DF9tT7bMYAd0Of4x4pJJ7zcJvkpB1FRKbhtYK/qWrzNwyr
        sLO2sTSVHfal3CMXpxPkWTQ=
X-Google-Smtp-Source: AGHT+IHoBQkkXpFMyW6Pf4ikXQPtueOnCt4+iD4agZ9Ho67+ob6SzRX7ZsSo2JjSzlwCE2DyxXFaRg==
X-Received: by 2002:a81:ae63:0:b0:5a7:b8e6:6441 with SMTP id g35-20020a81ae63000000b005a7b8e66441mr14841928ywk.16.1698879510385;
        Wed, 01 Nov 2023 15:58:30 -0700 (PDT)
Received: from localhost ([50.221.102.30])
        by smtp.gmail.com with ESMTPSA id i13-20020a81910d000000b005a7bfec6c34sm529504ywg.46.2023.11.01.15.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:58:29 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/4] lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
Date:   Wed,  1 Nov 2023 15:58:18 -0700
Message-Id: <20231101225820.51342-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101225820.51342-1-yury.norov@gmail.com>
References: <20231101225820.51342-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the function is called with cpus_read_lock() held, all the masks
involved are stabilized, and thus any extra atomicity is not required.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index aa3f6815bb12..b1e7d9cc9da9 100644
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
2.39.2

