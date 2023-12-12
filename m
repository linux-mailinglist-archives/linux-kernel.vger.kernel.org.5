Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901FA80E344
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjLLEVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjLLEVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:21:10 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640CBBF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:17 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-59067ccb090so3240739eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702354876; x=1702959676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfvFAKot0bp3HfeoPJ3dMZk7rFg3lsuy8X5EAYhpV4g=;
        b=nGV5ZDxr70D91ac+T6LqL8u3ojak+2fWxoTFlSoCTx3A9EXgpYNgjkIMN+wEHM30jH
         IkL5aDwYTG1BsCF0/VG/DWrr9JULuYCxT1R+/4IA8CxftbJrTVt5V8m0ydaJGKWcty9a
         TGpec6p6evfw+K801vNqDNlTLaMzFKCeigNUY5O85fW675gVFe38VV32mIFmiqzAeKoM
         o/buveCT4PxWa7yGqy+oNSVWj1Fu3RW1dbQMoRRDxJTBNgG7NwXQ0X2nIq2mA1VKqekc
         qYxFk+8X2OxG5h0VjhnbqdVvGZmfKkwY0Df5dzvicy5vggb5v6rvulsl9DOA1y+t6K+b
         a8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702354876; x=1702959676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfvFAKot0bp3HfeoPJ3dMZk7rFg3lsuy8X5EAYhpV4g=;
        b=wI+6EWXHVdVeuqL3bYdM/Qtg2BaG9EF7HLytX3T7/nm5VxQ9/93o+CrLvUSWH58KrD
         b9gizSb7T3O9AhnlW7AGTxKLT7a+WRL7HqTJqdhmwJcILtEUpF12k0AxXuRgPoPXoUpU
         m8aCT5eZrauGnFgAkMIFJu+luQlxWsLKk7sHqthyYRQRaPCjWb477X9TAddKzKqUvRq5
         Qvg5WlaEvBTwKpUAlgjRFYYWkYFz0CCMHsnKnxGH4cagKDyB0M64E42EvgbLZ5sEK/Yp
         2Ra5siquBDNcuyZOKPUrwh5QTM5et0ApWzWgmY+Ab+gBIHQEf6gVCjIwsVLM8806l9PO
         trrQ==
X-Gm-Message-State: AOJu0YzQoitEZ92VwebKKkyr7KtckFyJ2+wMkGkEefDTZtG9mh1ifmeo
        GyvOO3LO3urg/yp7U6DrZOs=
X-Google-Smtp-Source: AGHT+IHtPBBe0oc/SwS4zRYwzLNnU7oeIKh41ypn77HlaZZ4UfICRn76rQMWuKxSuSM02lrwwpsltA==
X-Received: by 2002:a05:6870:4590:b0:1fa:26b7:af18 with SMTP id y16-20020a056870459000b001fa26b7af18mr5327160oao.17.1702354876515;
        Mon, 11 Dec 2023 20:21:16 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id d201-20020a814fd2000000b005cc5f5aa533sm3499620ywb.43.2023.12.11.20.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:21:16 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 4/7] lib/group_cpus: optimize outer loop in grp_spread_init_one()
Date:   Mon, 11 Dec 2023 20:21:04 -0800
Message-Id: <20231212042108.682072-5-yury.norov@gmail.com>
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

Similarly to the inner loop, in the outer loop we can use for_each_cpu()
macro, and skip CPUs that have been copied.

With this patch, the function becomes O(1), despite that it's a
double-loop.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 7ac94664230f..cded3c8ea63b 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -17,16 +17,11 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 	const struct cpumask *siblmsk;
 	int cpu, sibl;
 
-	for ( ; cpus_per_grp > 0; ) {
-		cpu = cpumask_first(nmsk);
-
-		/* Should not happen, but I'm too lazy to think about it */
-		if (cpu >= nr_cpu_ids)
-			return;
-
+	for_each_cpu(cpu, nmsk) {
 		__cpumask_clear_cpu(cpu, nmsk);
 		__cpumask_set_cpu(cpu, irqmsk);
-		cpus_per_grp--;
+		if (cpus_per_grp-- == 0)
+			return;
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
@@ -37,6 +32,7 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 			__cpumask_set_cpu(sibl, irqmsk);
 			if (cpus_per_grp-- == 0)
 				return;
+			cpu = sibl + 1;
 		}
 	}
 }
-- 
2.40.1

