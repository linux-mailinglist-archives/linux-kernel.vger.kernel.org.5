Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2472809283
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443937AbjLGUjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443913AbjLGUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:39:01 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDA41713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:39:07 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d7a47d06eeso12681877b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701981547; x=1702586347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6INlgZjI/rk3Hb4b9fsbV8+DsR4OZwnMfo8QGcQs8s=;
        b=DWbn/axiW8UwkzOroASm/q4/ycZikPr7mm/pCEFCPA+2NL6KsNH8EXmNrNBptxsBOO
         KCVbG8AqKBYzPvkdRo6I4jWBzauwVSy9oT+BVTelVbrx0qV5uXMtS4Nm5OxqJit2jZzF
         BWaWW1kcf8acUPRVskKQt7CoMaVlRC0oNKklYnTLOqFlbN2EacMELWepaAHwtOvyUvYC
         PIEJg/82hROW7B+uVV39u6GOdXxe07IrfiShuMYYRGCiOXUEqQ1TaKW3PAw8rv/5n/kB
         BKtGbP8xX8owPAyv/3KtFok3su+3TEjeJcZQvf/AEfbY9B0xM6f6O2lxbHE+1Tv9mR2U
         ivZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981547; x=1702586347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6INlgZjI/rk3Hb4b9fsbV8+DsR4OZwnMfo8QGcQs8s=;
        b=CdApIFlW/csk+l9S1xSCsd7rT59uvkrAhicByuObD00ycW7XWKuE3tE4/4N9afFrYi
         O1p4Ro3rnQhKU92wubNCgzmLGYd6AU31bQQEECO5XngLaG6VrLpPQW48s2qsH5kVH58B
         HE+pt2GwyJxFE3CLGTCIrOUKKtyJChE0RE8Dz41zJGz7YUhw2Z8hLff6cySxrxz7KNkh
         j+TNfPEuzLq6kk/7t5v0OhYSvK20cUBWTOqq4hvdCWwnCMkFwVPWgQsUuZjQLQ4PjaJY
         LQmrLPNaUl7Yd9RDjZF3LWVKjJK8K0jY96vLA+sAmRetUOodV0o4j8puQ9YaA8ggao2S
         1bGQ==
X-Gm-Message-State: AOJu0YxGanI8IHSdsisxhUr2pXdFsDza49mRLx/ykw4kg3k9t3KbPG9F
        pH6xnfTOutaf5XacWETr9pk=
X-Google-Smtp-Source: AGHT+IHIu9fJEqi+QBLPf7t0UdCT9e7RcHhX5A/4Hs+G96VMhRczxATgVX981Y4SyAQLJau2Pc/1pA==
X-Received: by 2002:a81:bd42:0:b0:5d6:c177:4a31 with SMTP id n2-20020a81bd42000000b005d6c1774a31mr2916183ywk.50.1701981547007;
        Thu, 07 Dec 2023 12:39:07 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id z20-20020a81c214000000b005d900a949ccsm141308ywc.97.2023.12.07.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:39:06 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 3/6] lib/group_cpus: optimize inner loop in grp_spread_init_one()
Date:   Thu,  7 Dec 2023 12:38:57 -0800
Message-Id: <20231207203900.859776-4-yury.norov@gmail.com>
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

The loop starts from the beginning every time we switch to the next
sibling mask. This is the Schlemiel the Painter's style of coding
because we know for sure that nmsk is clear up to current CPU, and we
can just continue from the next CPU.

Also, we can do it nicer if leverage the dedicated for_each() iterator.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 8eb18c6bbf3b..7ac94664230f 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -30,13 +30,13 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		for (sibl = -1; cpus_per_grp > 0; ) {
-			sibl = cpumask_next(sibl, siblmsk);
-			if (sibl >= nr_cpu_ids)
-				break;
+		sibl = cpu + 1;
+
+		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
 			__cpumask_clear_cpu(sibl, nmsk);
 			__cpumask_set_cpu(sibl, irqmsk);
-			cpus_per_grp--;
+			if (cpus_per_grp-- == 0)
+				return;
 		}
 	}
 }
-- 
2.40.1

