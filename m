Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A97B809285
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjLGUjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443919AbjLGUjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:39:02 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196B51716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:39:09 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d74186170fso11258817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701981548; x=1702586348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfvFAKot0bp3HfeoPJ3dMZk7rFg3lsuy8X5EAYhpV4g=;
        b=MIScm2VvEVU4s1sy5ocmZstsmGKOmkh/6AYKwCPbDHLecICfLkOth+fXDtpsmimxc3
         GB0dSRmWxMlNtoAiDh/v8cMEnCI5bVfF/OF1NWWaDKMoa3Kej2VZi6eSZX/U9u9D+SJf
         KIvcwuJwPbHBJVQG2/2mx8ouxmv7NQ+v9lkgm+wlLnauwIBy1TLUbtzn1QIFu22L5luD
         qwFREiw3asBYiOG695ZWNxPPnkW5r4yN3eS4UM4L49HfjzJ0ad5UFbEELIB2HXbCYQkA
         JOiNb3nrnfl6Md7TIeJch+GFpcZTcBOLI3ssVx2EXsTMbt8uD3V6vO0nRVoGEotW0zdL
         k6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981548; x=1702586348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfvFAKot0bp3HfeoPJ3dMZk7rFg3lsuy8X5EAYhpV4g=;
        b=Mm2pfLlFOGT0+6Sr/G+laWXve1YCehSkup6yaCIUv6Xg2F6/Pj1DeS7grch+yIcCG3
         YStk6z/wsjvUvKuT1yrQ+QUmlnhZQYRLHGBRmMvCGsL3KO7+aQHYvCJhNcLJcCResYCx
         22qsW3jZ6ngHEdrFxO7Z18eaIB1hUJl7KZOyZ5DGNS7UIPHsJdfxVDxJg2GcHiBgr6Wg
         RccAJTad38oWFpcyY8jht78xfsej8wxl3fsJS7hreJSRRk1JaYqLmT4uAQraAfWMZv61
         c+k05nO6Vd2/5h9L/yin1ohxOXwaQBOBkoDM2gPlqaxL7LfkO3fGqht5jnZdGhXnOQRZ
         tnjQ==
X-Gm-Message-State: AOJu0Yy/ie5n6pixmUBJlg+c03IX3x2X4sOuR2hc6iSnv71kgDzh71N7
        1JkyROd6sgzck7wx/o0L12g=
X-Google-Smtp-Source: AGHT+IGmFQHx3KF7M+23G862JFjaqYcOuv0Ygu+9uk90EFQyWZoU+XJkeUEZ7rjuysLaaldDheenKw==
X-Received: by 2002:a0d:d455:0:b0:5d8:21f9:4efc with SMTP id w82-20020a0dd455000000b005d821f94efcmr2883577ywd.14.1701981548260;
        Thu, 07 Dec 2023 12:39:08 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id i9-20020a81d509000000b005d774946228sm141804ywj.68.2023.12.07.12.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:39:07 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 4/6] lib/group_cpus: optimize outer loop in grp_spread_init_one()
Date:   Thu,  7 Dec 2023 12:38:58 -0800
Message-Id: <20231207203900.859776-5-yury.norov@gmail.com>
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

