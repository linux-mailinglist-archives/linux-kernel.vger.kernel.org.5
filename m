Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7980E7DE86B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347463AbjKAW6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347479AbjKAW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:58:38 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DD7119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:58:33 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5ae143e08b1so4495027b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698879512; x=1699484312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m79oyGTD4QwukfG6ZorJJlId+7DO0Q4m7W/CpuSor88=;
        b=LBOKRM9NSa9hZe7fHhoF97QCVX77EfKSDJAapY8EJ4/Khyr+wsE/XjZwmFjitutAsN
         P2kDEncrLKJMrCfFo+EE8crL4dSMMHPBqAZJwvvVNyHBndcdAQbz/It6OWAH5uRxlJ57
         3WozknxUt8Si5Wdiy3uQRdFgfH5JFTOWUIuqSW8KurPDaJRKXAhXbCgpYKuYlMReptt/
         C+aH+6i2f697PlPRPTasCqjwJT6ZRdC/RueEre/KlhR71/l5wbWeAFyAWDenqTTNhxCX
         J820sRULHa6sEX8/tOI87X2qiyET0GwKy1J29e1E5UoiwN311IijV2qUjfdjO0jv0zwv
         ccSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698879512; x=1699484312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m79oyGTD4QwukfG6ZorJJlId+7DO0Q4m7W/CpuSor88=;
        b=vsr+7U/kZ+Ncu1FCI2xh4XgrCDziHOW24BVqppZmhdab3goNQzJfSY+EShzrqe3kPz
         ghR5BtTWzSx+Tb/W98OzLhoLr941I/LjY7cDT7RSjLlmzBGNJIOFhyKyyjqjFmO7aGft
         tv/hY4Ev0tEpeTVXD7pQQE/lHIFVe82NwF4lM7IyFBCPHuYGlGg4dQvOxo916RyJgua0
         4AXTj3YPHb01bm/XrWKxnf4GRgw6mOUIq/Aon3ZFrRBRhNKfDXJsNo7UPOKshGcEGlkZ
         y5YG+OjXK1ySxcpp4UWrkQSpiyzSdy6PZaR4aY/38yZXc1+rkf7fMd4OH/BMYUkxsbQl
         xpyA==
X-Gm-Message-State: AOJu0YwDJPp9z3nYyWPtnxj7xC+HIpTYbR2qhvTApiGpwAjBvxPUzNDm
        hhrLoJgavTZbXTe64m01Dss=
X-Google-Smtp-Source: AGHT+IGCukX3KGCpiMWs7pObu7bFh/sx3d2xRTa8GoLcKd9n7mlTXpGMbXiQ9fgLiNDC0zF81k814A==
X-Received: by 2002:a0d:cc44:0:b0:5a7:aaac:2bce with SMTP id o65-20020a0dcc44000000b005a7aaac2bcemr18888613ywd.35.1698879512112;
        Wed, 01 Nov 2023 15:58:32 -0700 (PDT)
Received: from localhost ([50.221.102.30])
        by smtp.gmail.com with ESMTPSA id r19-20020a81c313000000b005af81610bdbsm508017ywk.122.2023.11.01.15.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:58:31 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 3/4] lib/group_cpus: optimize inner loop in grp_spread_init_one()
Date:   Wed,  1 Nov 2023 15:58:19 -0700
Message-Id: <20231101225820.51342-4-yury.norov@gmail.com>
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
index b1e7d9cc9da9..8afe0c71d204 100644
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
2.39.2

