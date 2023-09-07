Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0604797AE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbjIGRyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245487AbjIGRyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:54:40 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DD71FFA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:54:11 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6490c2c4702so6934756d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694109245; x=1694714045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfgRO7mX/DO7BbGnDGP3r6jlXziqVhwRyC4fHRuMwY4=;
        b=liEdsonkUFHs+0vL9YNA76r3SQUBUXvVoSd99CNCLVjn1H9RuQU3VJXA7yFDpzfqP4
         f1GEtd+603tD6GiucJlIzcLvPweY/Pf8VfkQkdqzGwLJRKOpvq7Sud+afMenw7aVrFG6
         1eZ+zQjW7iXi/lx/+RmKhbizDy/39fuFKCb+d8Az72r5iD1PgL4s2geNoI05vYxIUCh+
         Q2TWc64iD2kDmKS9AhPN+rAMW666cbWgzgJ+s6yV6U0D2hL3jfgST/8Rw6/IPR7pXLkK
         RtSL4o/OgIk6fMAPip8Waw0mLeCYeqRfuAVRWCTGHtdvr5hwq+ViiEM2jRZNnr/lqtVH
         Q7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109245; x=1694714045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfgRO7mX/DO7BbGnDGP3r6jlXziqVhwRyC4fHRuMwY4=;
        b=ElZdSo+okiaraf0vWhjNMRpggu/xYjTQom/rEVoZNGyrZZbr0d9tXy1vrA5hdkcrJc
         sQTsy6V3EyDpTF4xttvqo6sI9J3+LmvXfaL3r4plV6gJPKHB98vYMLMXqeSeoyJNCIAr
         Lg72WoPIrJq2mnjGqX923iRITVphC9rPsXfb4ofaV8vXsLfTAYDs+NFqbZe+ZTPLH8Mr
         aCChIqk8wKVdv+Xd0+iyt9Im49rLA+M9j+WJmTBTzwb/PpmL1dU3lE0beMcAJ8jqYCwg
         +wcAbymnPcHf5OyG/r9xxTF1zJS8j4uuNdEkxN696PTTg0B1tWSQABYjYZofNdBDM51Q
         onEg==
X-Gm-Message-State: AOJu0YwwQ3MQ1Y4JNPMcAqVO2O0Is1ToMCJT03FxQEQfP9Y5zaRx7H0I
        1716bdMf4E3vxeL9q+2FNJuOKLGK1BfnzVbOH4E=
X-Google-Smtp-Source: AGHT+IFwqY6yWGRP5js7HsuyPsHlBJuvnZ8ps3dcUjD/I6KrKw5MNk0R91NZPddOPQvoezIZef4ZhA==
X-Received: by 2002:a17:90b:1a8b:b0:25b:c454:a366 with SMTP id ng11-20020a17090b1a8b00b0025bc454a366mr19193226pjb.5.1694097216276;
        Thu, 07 Sep 2023 07:33:36 -0700 (PDT)
Received: from local.. ([104.193.10.236])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090a1fc600b00256799877ffsm1641733pjz.47.2023.09.07.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:33:35 -0700 (PDT)
From:   Zhizhou Zhang <zhizhou.zh@gmail.com>
To:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, rppt@kernel.org,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        vishal.moola@gmail.com, arnd@arndb.de, wangkefeng.wang@huawei.com,
        willy@infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhizhou Zhang <zhizhouzhang@asrmicro.com>
Subject: [PATCH] ARM: mm: fix stack corruption when CONFIG_ARM_PV_FIXUP=y
Date:   Thu,  7 Sep 2023 22:33:02 +0800
Message-Id: <20230907143302.4940-1-zhizhou.zh@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhizhou Zhang <zhizhouzhang@asrmicro.com>

flush_cache_all() save registers to stack at function entry.
If it's called after cache disabled, the data is written to
memory directly. So the following clean cache operation corrupted
registers saved by flush_cache_all(), including lr register.
calling flush_cache_all() before turn off cache fixed the problem.

Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 674ed71573a8..03fb0fe926f3 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1675,6 +1675,7 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
 	/* Run the patch stub to update the constants */
 	fixup_pv_table(&__pv_table_begin,
 		(&__pv_table_end - &__pv_table_begin) << 2);
+	flush_cache_all();
 
 	/*
 	 * We changing not only the virtual to physical mapping, but also
@@ -1690,7 +1691,6 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
 	asm("mrc p15, 0, %0, c2, c0, 2" : "=r" (ttbcr));
 	asm volatile("mcr p15, 0, %0, c2, c0, 2"
 		: : "r" (ttbcr & ~(3 << 8 | 3 << 10)));
-	flush_cache_all();
 
 	/*
 	 * Fixup the page tables - this must be in the idmap region as
-- 
2.34.1

