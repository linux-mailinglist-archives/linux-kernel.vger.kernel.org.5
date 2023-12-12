Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D89880E341
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbjLLEVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjLLEVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:21:22 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15628FD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:22 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5e180547bdeso8183077b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702354881; x=1702959681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhqx4gBGm5WucjtLuvVJR4mQPOrDNcNzK+o09f7n6v4=;
        b=aa0ltg7q1na+bhl2xIMKgJhC7szOWXRyrN85rbIhd5JJpSgcOeDPN9ZP4bukpK1U78
         4ha0vP0X+Gho+XHEcgzMz0wty/AXdtbYPo09Mjo4Hy+JzcCosKJ6RZlIP4W/iv15chkR
         rhibmo7DLcPCGuktvV7zOu+CkpIN0Hyh80bDe+TfytxJrAiNToy81YyJmd4cch9mQTRc
         0W6+AeYkfM3cLcpobGe5nL4uuQ7Dbl1H7we/LuNR9ROCLz+GcFfdXP+eEMP/MAARUFmM
         rRTboHyVE3LU9Uwpej2MuNjRRDBULHZ9a8W4TDObNn8/RXlGlRG7/egXVHcKmq1gZlyn
         GHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702354881; x=1702959681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhqx4gBGm5WucjtLuvVJR4mQPOrDNcNzK+o09f7n6v4=;
        b=TEh+bry36o/VGIiWfaOUc8mEHYF9cUwuHgBaNDv1Z/Lv7N2bIPA43Qi9l1eaUbLlB2
         77MAyq+yMaCDu6VXbJ/DZwhupZSkAiia7dcvpSDGmW55JfGcbdXWsgV0lAbEfAJHeH+/
         IEiP+ib3ZmYV+ReOS2xkiEamBL6NYxwiyqqi7CS6KJG5ZPErZ4GwPRG1IUqlcGYGSEnq
         70ecAuW4HZVDZuQhaLHEuV2ebJTivWxKL+vzGgyW1LJ0pNhyR0P/VDzJEGygSwHruY/l
         oYmYzRUdjRrLK9yOkSxJCox/D+28gBrPEQJ5Bl24u0qifQaZMfRNOzEfgmXq1QkpQo2w
         gopg==
X-Gm-Message-State: AOJu0YwfPsdljeGNmxT3YLnG8eSYnMDSh1tnNQHk23oqMjGXHH54m/1U
        FD7Jz5zsXXTcg003fNRj2a8=
X-Google-Smtp-Source: AGHT+IG5N2bPse685zyTRp1xN8khGwhlFoSDKrPeXSZF5CtDHpERvj72vHNfpPizip/QTwc1lMEJqA==
X-Received: by 2002:a81:784c:0:b0:5e1:8bd7:c66c with SMTP id t73-20020a81784c000000b005e18bd7c66cmr1002488ywc.7.1702354881171;
        Mon, 11 Dec 2023 20:21:21 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id c189-20020a0ddac6000000b005d1b2153b7bsm3526835ywe.18.2023.12.11.20.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:21:20 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 7/7] lib/group_cpus: simplify grp_spread_init_one() for more
Date:   Mon, 11 Dec 2023 20:21:07 -0800
Message-Id: <20231212042108.682072-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212042108.682072-1-yury.norov@gmail.com>
References: <20231212042108.682072-1-yury.norov@gmail.com>
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

The outer and inner loops of grp_spread_init_one() do the same thing -
move a bit from nmsk to irqmsk.

The inner loop iterates the sibling group, which includes the CPU picked
by outer loop. And it means that we can drop the part that moves the bit
in the outer loop.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 664a56171a1b..7aa7a6289355 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -18,14 +18,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 	int cpu, sibl;
 
 	for_each_cpu(cpu, nmsk) {
-		__cpumask_clear_cpu(cpu, nmsk);
-		__cpumask_set_cpu(cpu, irqmsk);
-		if (cpus_per_grp-- == 0)
-			return;
-
-		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		sibl = cpu + 1;
+		sibl = cpu;
 
 		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
 			__cpumask_clear_cpu(sibl, nmsk);
-- 
2.40.1

