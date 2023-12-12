Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23BA80E345
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjLLEVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjLLEVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:21:07 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78130BE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:14 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-db632fef2dcso5149597276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702354873; x=1702959673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnIA3EnzQnW3AuT6MleWaZcP0AeUqS6iyw6BtYD4kcc=;
        b=OHfysT+epVFcBYHsdrSPc3m18F9K4ChXioYHGhxstZd27LcdgBb7Hbm6g5h/w+Q+uQ
         ENvPeOOKw6NBUCkoHDMYTuABJN/wanYTdYlhK/ORa/oNpw+pszDXyF+UF/HN1l/zNu/P
         svRJ+5qrFw7vyMQnnhkGTzp75HlqYJm6iaYQgL1zPoc3tI38euqUN54sk8PH7qan9mDM
         wQm55jXXDXWHFpFheSd8bqHgMrTuNqNwtHJ/QnNadAarEEen0xHXz4cazo3EgqNAFqRs
         bifPuMuPKoFcGVwg796itBtyZTfQNHoZ6jD6EveO8mmTnokCXIsw08DOBXDhgtmMUth3
         Z9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702354873; x=1702959673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnIA3EnzQnW3AuT6MleWaZcP0AeUqS6iyw6BtYD4kcc=;
        b=LjjmgiBg28RByHIMxn7cvi9/GcY91uztuAax6pYRtArkx5orSR+r7nlgdnAg8yc8t0
         GGuBYSmABPBCR8fZEV3xQz5TXXSswiyh1H6asVZqI3kP90qy25CzIiLofgiBWO7u2b2L
         iYNedYc4pvSTMONQe50Yf82jhPrL//Fv08xmzJJpFjVA1Qg285Ewxd26JWlYCJ8aV1uZ
         39TpPrmuoeF9NRj/3nEt00Pg+OyXIE510Z1nsa9b1yajbew688F7JcjKYfF1vPSsG+Wy
         Dbi9hAGMqqt8QnZIpmtmflcI2lxyLyZq1YCSE+Ia9xBOsuvyjki8uIp4rcUzloalJRKz
         JbJg==
X-Gm-Message-State: AOJu0Yx+uofILTXqfUnhh2Gce2USubWODk/DCiVnahWcERnJoRkALGY+
        pZIEEuuXalsdnmwa2xp12e0=
X-Google-Smtp-Source: AGHT+IH/dyVXmwJ7xvXoArsQoaPu4V0yLoTqqVrUMw4RHWw7ImGRHaaKsDJfxZLshP4EAOXWO7kwCg==
X-Received: by 2002:a25:db51:0:b0:dbc:b394:6ab5 with SMTP id g78-20020a25db51000000b00dbcb3946ab5mr1084932ybf.95.1702354873535;
        Mon, 11 Dec 2023 20:21:13 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id k15-20020a056902024f00b00d89679f6d22sm2917283ybs.64.2023.12.11.20.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:21:12 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 2/7] lib/group_cpus: optimize inner loop in grp_spread_init_one()
Date:   Mon, 11 Dec 2023 20:21:02 -0800
Message-Id: <20231212042108.682072-3-yury.norov@gmail.com>
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

The loop starts from the beginning every time we switch to the next
sibling mask. This is the Schlemiel the Painter's style of coding
because we know for sure that nmsk is clear up to current CPU, and we
can just continue from the next CPU.

Also, we can do it nicer if leverage the dedicated for_each() iterator,
and simplify the logic of clearing a bit in nmsk.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..10dead3ab0e0 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -30,14 +30,13 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
-		for (sibl = -1; cpus_per_grp > 0; ) {
-			sibl = cpumask_next(sibl, siblmsk);
-			if (sibl >= nr_cpu_ids)
-				break;
-			if (!cpumask_test_and_clear_cpu(sibl, nmsk))
-				continue;
+		sibl = cpu + 1;
+
+		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
+			cpumask_clear_cpu(sibl, nmsk);
 			cpumask_set_cpu(sibl, irqmsk);
-			cpus_per_grp--;
+			if (cpus_per_grp-- == 0)
+				return;
 		}
 	}
 }
-- 
2.40.1

