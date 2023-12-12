Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B89F80E340
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjLLEVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLLEVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:21:09 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3656EBC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:16 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da077db5145so4288155276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702354875; x=1702959675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcK8BvqeLnlnGvCjlzdUPO//8WS/BTL6dVTgbP4I0qA=;
        b=JN28sTpkGz87XAw+tUM9cVcgd2bhlaa4enrddq2IMAE07lKigzYXHEYGMDemtNEemd
         +TQlEoTK4LlmCI04xOAiSdnLWfPzSMkCy60Zss/dQQHuLuE8EYZkpR+hSzPnbNXHAg/A
         tmcpl8PxdVGaCnwddloNM+WsbqUETlXKsyRbZR2n/JR9ltIOLuYywepi1P9NeZibeZol
         oBqhYGH0QVZR9U1LfC6za8Sw3BSLWeKeF44aqUf+g7jXHvyymzlNF8GpyseQEIU1KwGM
         PXtqcEDaHPY86IxW1j5p9kx8NbhiLFyj+OKgLTOa2weJsh3FBPwXQU2/qJ2LVuJgM5WY
         RAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702354875; x=1702959675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcK8BvqeLnlnGvCjlzdUPO//8WS/BTL6dVTgbP4I0qA=;
        b=fN7xgkb8cKOnKRIlmNgwaMNm/t43z32ZQaWZAs1HIu2FnX534vaQYi6ZYZfsy3WNUU
         /H5b+b3obobNv4m9YuVOVK2633ZC5Cq7sKoG8+fS3bCnmkh9wMGgvBNXTbzDzmYmlq8r
         whRGUZUpWHmuvWZnRP9CVlIvG1l0FmZLqs5z1BiQPuWq2sMg7DlKpXPS7RPIzE5tcnk0
         PwyjoRV49j/oiha5bTgjxj5LGaUcul+hRILt762Qps86IX2MsySb/V+tJ+GTdXjY4Yo/
         g7ltYOY3zXhS2sTOCViuBwyGNlBcHqfqmwOQ1EbZC3UKfbTX1zsyanPf5cyjzjZJ6oC4
         3N0Q==
X-Gm-Message-State: AOJu0YxPOBxXGrTydHgQVgAH0FY9U5zO/P7RHiUDJNP+rA+ql3cd0hgw
        QqQqlKhyjWUjDuuh0/vPKF8=
X-Google-Smtp-Source: AGHT+IFRyIqy04++PSjU5C+NX9E24AEHWQZ6EgG62T/pPRCR9jQf9bIwn33Th5+YNGG7Sb8f9bMGTQ==
X-Received: by 2002:a5b:309:0:b0:db7:dad0:76c8 with SMTP id j9-20020a5b0309000000b00db7dad076c8mr3671333ybp.100.1702354875225;
        Mon, 11 Dec 2023 20:21:15 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id 13-20020a25040d000000b00d7f06aa25c5sm3008349ybe.58.2023.12.11.20.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:21:14 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 3/7] lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
Date:   Mon, 11 Dec 2023 20:21:03 -0800
Message-Id: <20231212042108.682072-4-yury.norov@gmail.com>
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

Because nmsk and irqmsk are stable, extra atomicity is not required.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 10dead3ab0e0..7ac94664230f 100644
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
@@ -33,8 +33,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 		sibl = cpu + 1;
 
 		for_each_cpu_and_from(sibl, siblmsk, nmsk) {
-			cpumask_clear_cpu(sibl, nmsk);
-			cpumask_set_cpu(sibl, irqmsk);
+			__cpumask_clear_cpu(sibl, nmsk);
+			__cpumask_set_cpu(sibl, irqmsk);
 			if (cpus_per_grp-- == 0)
 				return;
 		}
-- 
2.40.1

