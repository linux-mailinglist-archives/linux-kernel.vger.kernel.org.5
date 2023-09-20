Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B837A74F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjITHza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjITHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:55:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE2AAB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5041335fb9cso532403e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695196517; x=1695801317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp0b1o9g+PpYZByhHPBV5mXBlVfc9hIIqUxUds48fFY=;
        b=pz0YYAki58qMYyHhoypI6ekyY+s8qoiOIaDLRx2kE8d7edG/rYfuTuqvYBCzLGrMgF
         5+Oh5Nl4yjrOUmg3lbLapDWgdjQhBQ4zKXhlMstmwb7hMZ/yG8Y0oD/uoxVCsIQr8ImT
         Q3pUXEpKRmnsRzk4kZXgvhZiA6VGS3sGXopLNIVEEEGgUL44T1ZnWlx1CT2VdRb/xoQO
         HcI0sCNvxiaOUufVXMqOGWXpk1ZxlDIAlT0EoAuqVF+VG2R5WfZhLGNCuzWDvLJlX4Wk
         leN56a6ChEE+VV+0/FXHB38THhaoCQU1GQS8vroNAfx3gUhg4Ajh5MiaRNJm3otHGRvP
         pltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196517; x=1695801317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dp0b1o9g+PpYZByhHPBV5mXBlVfc9hIIqUxUds48fFY=;
        b=gwas6oCoBX854XYaj9oM5q+cCE5OuhT7lCfLGXS5iYiohbQfxL2JajnXk39p8sKfo6
         JTG/1RpwaNfDwi4dM4a4/pi0Wd8/GtTdME2S+MFxWbFBtSiAp079ELLQ0OtrPvPSdmqA
         fBNVi6N7nf3yBL9zANozZXbqPMI+0JWj77+x7GfZO6/qqX9yvcrHh3IvOGc32Qegbmkz
         wj7p1Kduuj0tDTBS1N1KUesFanSuxGD0XwiQzndhXaEXaCELhQqPqfRDD+YePLAGHzja
         Km/DbUyv50xDIEs0O6daa1SKPEUJ/K3ZkwSDuAR7lsEUebvE3NVZjqtXr6MyBPYtB4Be
         /e0Q==
X-Gm-Message-State: AOJu0YwRfv7GRkpdHwfuh6E1DeYiuvjgPzKYF39eT7UdTvpbjlXohmt2
        Ym+RlqW2jrBHa809CepxGz5yjvOblAel/M4rz4xFfw==
X-Google-Smtp-Source: AGHT+IH1KiwFHBI5ax0lkBY8FLQFTsXSNMqUPbbuKanTrs9I2ZibluGCw6QDkjf+tYKu0Qcn0ux4OA==
X-Received: by 2002:a05:6512:2f6:b0:4f9:6842:afc with SMTP id m22-20020a05651202f600b004f968420afcmr1454497lfq.64.1695196517306;
        Wed, 20 Sep 2023 00:55:17 -0700 (PDT)
Received: from brgl-uxlite.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id d9-20020a05640208c900b0051bed21a635sm8481981edz.74.2023.09.20.00.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:55:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/4] genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
Date:   Wed, 20 Sep 2023 09:54:58 +0200
Message-Id: <20230920075500.96260-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920075500.96260-1-brgl@bgdev.pl>
References: <20230920075500.96260-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The irqnum field is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd76323ea3fd..f5ebb3ba6f9a 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -19,7 +19,6 @@ struct irq_sim_work_ctx {
 };
 
 struct irq_sim_irq_ctx {
-	int			irqnum;
 	bool			enabled;
 	struct irq_sim_work_ctx	*work_ctx;
 };
-- 
2.39.2

