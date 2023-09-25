Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5079A7AD2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjIYINB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjIYIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:12:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D483115;
        Mon, 25 Sep 2023 01:12:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D510CDA7;
        Mon, 25 Sep 2023 01:12:39 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.93.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39C503F5A1;
        Mon, 25 Sep 2023 01:11:59 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v4 18/18] Documentation: EM: Update information about performance field
Date:   Mon, 25 Sep 2023 09:11:39 +0100
Message-Id: <20230925081139.1305766-19-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925081139.1305766-1-lukasz.luba@arm.com>
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,TVD_PH_SUBJ_META1
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model supports the new information: performance for each
performance state. Update the needed documentation part accordingly.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 3115411f9839..da3619c0b98a 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -125,6 +125,11 @@ runtime static EM' (system property) design to a 'single EM which can be
 changed during runtime according e.g. to the workload' (system and workload
 property) design.
 
+It is possible also to modify the CPU performance values for each EM's
+performance state. Thus, the full power and performance profile (which
+is an exponential curve) can be changed according e.g. to the workload
+or system property.
+
 
 3. Core APIs
 ------------
@@ -326,18 +331,18 @@ EM framework::
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 This section provides a simple example of a thermal driver modifying the EM.
-The driver implements a foo_mod_power() function to be provided to the
+The driver implements a mod_power_perf() function to be provided to the
 EM framework. The driver is woken up periodically to check the temperature
 and modify the EM data if needed::
 
   -> drivers/thermal/foo_thermal.c
 
-  01	static int foo_mod_power(struct device *dev, unsigned long freq,
-  02			unsigned long *power, void *priv)
+  01	static int mod_power_perf(struct device *dev, unsigned long freq,
+  02			unsigned long *power, unsigned long *perf, void *priv)
   03	{
   04		struct foo_context *ctx = priv;
   05
-  06		/* Estimate power for the given frequency and temperature */
+  06		*perf = foo_estimate_performance(dev, freq);
   07		*power = foo_estimate_power(dev, freq, ctx->temperature);
   08		if (*power >= EM_MAX_POWER);
   09			return -EINVAL;
-- 
2.25.1

