Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6367BB514
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjJFKZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjJFKZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:25:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42380BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:25:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b6559cbd74so363692966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696587927; x=1697192727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9fUuQgN+anlMMoJHDkj24MjGD80W1ske574ToiOc/8=;
        b=ZkZ1CATWo9pbiokQ7Gl/VQVPFbRNF5emwTWssOMI2SXJIqQT1Yhtm57MNjpEVMKdp7
         IC4nbL3upeOSJgRH764ZTuGtb61n5vVQZZuA1zd5Yx7BCnfwKG8YnGnLsf5aVcdi3kuJ
         YnHl87UM1S2/uol2p+geoRoTJKbTp+iK4715xYmrsv+UZc7wdcT9D2alOcHPB6RiDcoZ
         G24Lnj9Kn6taqYy9m+q/TlcHj2SuXWEjWXde5HVnu+0HbfsO5kMWoxDQRovDEU/U4q3Y
         kwmzMn7vtvpCoT/0rTYAgZN9f1Cjo/BKZ+iK2ejT7jQFP8j4j8AtHjvrJI1cs4i+nZsh
         FUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696587927; x=1697192727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9fUuQgN+anlMMoJHDkj24MjGD80W1ske574ToiOc/8=;
        b=t0fUXwAr8Q5gPs1O3iU5uU1K05XEyCiEu/96KjLYjaY+7i8R0q7LtysM+EL2iO0Bl1
         Eg3agO7iQDKOhB3dnteL+BxIHbZkSbRZGkO+yW2TMVr4kbtlOUaPGwu1FbQ9B51wglnK
         3ybzU8rX7Qe1LbKqIOQBLfRniTDwY4yQubZo/phMwDxsBSi3Cbi4PA0JJDq/iIbm/w9/
         CZzv3jRZauludIbHe/CX35NCpi4ROtssPHw0liC2lb5gFrPa6Wdk7pkD9bg3qOitJp8q
         Qejzx9TC6fYCwt2jHoUmy8bffFbIyfWoVlhhrB7n4NZGyp0Jj3pCgjVqwAnReJEDzLPq
         2esg==
X-Gm-Message-State: AOJu0YyKAWelbwMGDekL83u/J+B/inF1GvrVLAqMCc9xCavft0L6Ug+C
        XTDRxzoMGbxN7Utt3hai8z1dxhuo3vg=
X-Google-Smtp-Source: AGHT+IGSHseoeQrSC0c7L4JwWaGXS5uAIJEPsaXVerU/RKptcL+DVGafJDxO0uL79VlQ6yjClRngnQ==
X-Received: by 2002:a17:906:1bb2:b0:9b9:a1dd:5105 with SMTP id r18-20020a1709061bb200b009b9a1dd5105mr4735704ejg.50.1696587926979;
        Fri, 06 Oct 2023 03:25:26 -0700 (PDT)
Received: from kepler.redhat.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906379100b009b957d5237asm2613502ejc.80.2023.10.06.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:25:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/3] sched/nohz: Use consistent variable names in find_new_ilb() and kick_ilb()
Date:   Fri,  6 Oct 2023 12:25:17 +0200
Message-Id: <20231006102518.2452758-3-mingo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006102518.2452758-1-mingo@kernel.org>
References: <20231006102518.2452758-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'ilb_cpu' consistently in both functions.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8435179779e3..d4e90d15bd77 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11558,18 +11558,18 @@ static inline int on_null_domain(struct rq *rq)
  */
 static inline int find_new_ilb(void)
 {
-	int ilb;
 	const struct cpumask *hk_mask;
+	int ilb_cpu;
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
 
-	for_each_cpu_and(ilb, nohz.idle_cpus_mask, hk_mask) {
+	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
 
-		if (ilb == smp_processor_id())
+		if (ilb_cpu == smp_processor_id())
 			continue;
 
-		if (idle_cpu(ilb))
-			return ilb;
+		if (idle_cpu(ilb_cpu))
+			return ilb_cpu;
 	}
 
 	return nr_cpu_ids;
-- 
2.39.2

