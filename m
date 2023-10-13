Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41D7C80B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjJMItP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjJMItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:49:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0208CCC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:49:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so390342a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186942; x=1697791742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjra0WdYWK36KGusor5NGq8FRrUa/zXmRjm2tlyhEOI=;
        b=dVBG7CgmwOVdX0Q6tRMxDQHCe7vJKwugJ12eucHlErvu77dc9H9gbH41/UCtYo6lvO
         /57YJNjq95QSQfjp9hJHw+FTmzNpadKW9q6kJT+B61uJ5FzzTB1D4ehgImALPRuSrHnZ
         u9SezJZ4iG+3jPXaJHpXAeixqqK4kxwvFLUTKZAWBW+mbLO7U8kqh/if9sTdZepuBpqF
         pC9xgeQZpJMF7g4kbgMK7YHh/bdpeH/XYYCyQ+GGcCNBjZ2jTnJnsEU0UKawL7g5zmJQ
         N5zvrWB2d9FhnOyDwtREMwpgJPtn6LyNyOS+RrxE5zvclKo3MxThb1alp2nCVfzStpbJ
         yyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186942; x=1697791742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjra0WdYWK36KGusor5NGq8FRrUa/zXmRjm2tlyhEOI=;
        b=I+hrKYIKvHoExolc76vxVfV1L7wxOVzGaL97h8ubX/7vvgR83KZq8Ig3ZrTUqaHsuh
         2kmwujrdEyQiBnmqzLkZxpuPVaFaP1o/OjIvgmqbV1dgy0yjbNi9DA3V0sKuN+7sZRRW
         mLCMSgOY2l1K8ewFs4bqPwpzpMvlqpllMR8cexYy6gAC0jbaHMmMo/hQnSg42sZZ5EUj
         gsRd4DZd/UwufJXNiQyzq92aQfA81Son8oKagmHP72a/IwgysDQyV4Gi5HWFxaLIGn4U
         pwjLHNmbBQKFyPBbJ25FePgvplR/RlDSzt7nsTM4yd+NEZdweUUV0E223uzy5E4/lu7S
         jdQw==
X-Gm-Message-State: AOJu0YxMbi4wewSKZdHxS51STe6zOZyGUd80d2rRNTct0z1I/qyy9hR+
        F1Nu74y7+9pHh3vUAcc0RLVEFg==
X-Google-Smtp-Source: AGHT+IG41+b3yJXum4xwBP/+ABHsqzUFb6HvYHzaanfXBpdfqmBBj6O4RsroSNMhxFSQ+EiCBLZ8jw==
X-Received: by 2002:a05:6a20:3d89:b0:174:210c:34b0 with SMTP id s9-20020a056a203d8900b00174210c34b0mr6362313pzi.0.1697186942446;
        Fri, 13 Oct 2023 01:49:02 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id im16-20020a170902bb1000b001c5fed0b35esm3382039plb.300.2023.10.13.01.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:49:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] OPP: Remove genpd_virt_dev_lock
Date:   Fri, 13 Oct 2023 14:18:40 +0530
Message-Id: <afec94cb6515e79c3b336f74be8aa929a303b26f.1697186772.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697186772.git.viresh.kumar@linaro.org>
References: <cover.1697186772.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the config operations for OPP tables share common code paths now and
none of the other ones have such protection in place. Either all should
have it or none.

The understanding here is that user won't clear the OPP configs while
still using them and so such a case won't happen. We can always come
back and use a wider lock for all resource types if required.

Also fix the error on failing to allocate memory.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 33 +++------------------------------
 drivers/opp/opp.h  |  2 --
 2 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3516e79cf743..befe46036ad5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1089,12 +1089,6 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 		delta = -1;
 	}
 
-	/*
-	 * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
-	 * after it is freed from another thread.
-	 */
-	mutex_lock(&opp_table->genpd_virt_dev_lock);
-
 	while (index != target) {
 		ret = _set_performance_state(dev, genpd_virt_devs[index], opp, index);
 		if (ret)
@@ -1103,8 +1097,6 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 		index += delta;
 	}
 
-	mutex_unlock(&opp_table->genpd_virt_dev_lock);
-
 	return 0;
 }
 
@@ -1474,7 +1466,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 		return ERR_PTR(-ENOMEM);
 
 	mutex_init(&opp_table->lock);
-	mutex_init(&opp_table->genpd_virt_dev_lock);
 	INIT_LIST_HEAD(&opp_table->dev_list);
 	INIT_LIST_HEAD(&opp_table->lazy);
 
@@ -1510,7 +1501,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 remove_opp_dev:
 	_of_clear_opp_table(opp_table);
 	_remove_opp_dev(opp_dev, opp_table);
-	mutex_destroy(&opp_table->genpd_virt_dev_lock);
 	mutex_destroy(&opp_table->lock);
 err:
 	kfree(opp_table);
@@ -1678,7 +1668,6 @@ static void _opp_table_kref_release(struct kref *kref)
 	list_for_each_entry_safe(opp_dev, temp, &opp_table->dev_list, node)
 		_remove_opp_dev(opp_dev, opp_table);
 
-	mutex_destroy(&opp_table->genpd_virt_dev_lock);
 	mutex_destroy(&opp_table->lock);
 	kfree(opp_table);
 }
@@ -2395,7 +2384,7 @@ static void _opp_put_config_regulators_helper(struct opp_table *opp_table)
 		opp_table->config_regulators = NULL;
 }
 
-static void _detach_genpd(struct opp_table *opp_table)
+static void _opp_detach_genpd(struct opp_table *opp_table)
 {
 	int index;
 
@@ -2449,13 +2438,11 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 	if (!opp_table->required_opp_count)
 		return -EPROBE_DEFER;
 
-	mutex_lock(&opp_table->genpd_virt_dev_lock);
-
 	opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
 					     sizeof(*opp_table->genpd_virt_devs),
 					     GFP_KERNEL);
 	if (!opp_table->genpd_virt_devs)
-		goto unlock;
+		return -ENOMEM;
 
 	while (*name) {
 		if (index >= opp_table->required_opp_count) {
@@ -2478,29 +2465,15 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
 	if (virt_devs)
 		*virt_devs = opp_table->genpd_virt_devs;
-	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 
 	return 0;
 
 err:
-	_detach_genpd(opp_table);
-unlock:
-	mutex_unlock(&opp_table->genpd_virt_dev_lock);
+	_opp_detach_genpd(opp_table);
 	return ret;
 
 }
 
-static void _opp_detach_genpd(struct opp_table *opp_table)
-{
-	/*
-	 * Acquire genpd_virt_dev_lock to make sure virt_dev isn't getting
-	 * used in parallel.
-	 */
-	mutex_lock(&opp_table->genpd_virt_dev_lock);
-	_detach_genpd(opp_table);
-	mutex_unlock(&opp_table->genpd_virt_dev_lock);
-}
-
 static void _opp_clear_config(struct opp_config_data *data)
 {
 	if (data->flags & OPP_CONFIG_GENPD)
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index fefdf9845692..08366f90f16b 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -160,7 +160,6 @@ enum opp_table_access {
  * @rate_clk_single: Currently configured frequency for single clk.
  * @current_opp: Currently configured OPP for the table.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
- * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
  * @genpd_virt_devs: List of virtual devices for multiple genpd support.
  * @required_opp_tables: List of device OPP tables that are required by OPPs in
  *		this table.
@@ -212,7 +211,6 @@ struct opp_table {
 	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
 
-	struct mutex genpd_virt_dev_lock;
 	struct device **genpd_virt_devs;
 	struct opp_table **required_opp_tables;
 	unsigned int required_opp_count;
-- 
2.31.1.272.g89b43f80a514

