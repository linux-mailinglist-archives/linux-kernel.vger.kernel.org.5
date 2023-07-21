Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29CF75CC94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGUPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjGUPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:50:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5CD24204;
        Fri, 21 Jul 2023 08:50:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3F22F4;
        Fri, 21 Jul 2023 08:51:20 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.0.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FDF03F738;
        Fri, 21 Jul 2023 08:50:33 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, mhiramat@kernel.org
Subject: [PATCH v3 12/12] Documentation: EM: Update with runtime modification design
Date:   Fri, 21 Jul 2023 16:50:22 +0100
Message-Id: <20230721155022.2339982-13-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721155022.2339982-1-lukasz.luba@arm.com>
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new section 'Design' which covers the information about Energy
Model. It contains the design decisions, describes models and how they
reflect the reality. Add description of the basic const. EM. Change the
other section IDs. Add documentation bit for the new feature which
allows o modify the EM in runtime.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 150 +++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 10 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index ef341be2882b..01d4d806a123 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -72,16 +72,70 @@ required to have the same micro-architecture. CPUs in different performance
 domains can have different micro-architectures.
 
 
-2. Core APIs
+2. Design
+-----------------
+
+2.1 Basic EM
+^^^^^^^^^^^^
+
+The basic EM is built around constant power information for each performance
+state, which is accessible in: 'dev->em_pd->default_table->state'. This model
+can be derived based on power measurements of the device e.g. CPU while
+running some benchmark. The benchmark might be integer heavy or floating point
+computation with a data set fitting into the CPU cache or registers. Bare in
+mind that this model might not cover all possible workloads running on CPUs.
+Thus, please run a few different benchmarks and verify with some real
+workloads your power model values. The power variation due to the workload
+instruction mix and data set is not modeled. The static power, which can
+change during runtime due to variation of SOC temperature, is not modeled in
+this basic EM.
+
+2.2 Runtime modifiable EM
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To better reflect power variation due to static power (leakage) the EM
+supports runtime modifications of the power values. The mechanism relies on
+RCU to free the modifiable EM perf_state table memory. Its user, the task
+scheduler, also uses RCU to access this memory. The EM framework is
+responsible for allocating the new memory for the modifiable EM perf_state
+table. The old memory is freed automatically using RCU callback mechanism.
+This design decision is made based on task scheduler using that data and
+to prevent wrong usage of kernel modules if they would be responsible for the
+memory management.
+
+There are two structures with the performance state tables in the EM:
+a) dev->em_pd->default_table
+b) dev->em_pd->runtime_table
+They both point to the same memory location via:
+'em_perf_table::state' pointer, until the first modification of the values
+This should save memory on platforms which would never modify the EM. When
+the first modification is made the 'default_table' (a) contains the old
+EM which was created during the setup. The modified EM is available in the
+'runtime_table' (b).
+
+Only EAS uses the 'runtime_table' and benefits from the updates to the
+EM values. Other sub-systems (thermal, powercap) use the 'default_table' (a)
+since they don't need such optimization.
+
+The drivers which want to modify the EM values are protected from concurrent
+access using a mutex. Therefore, the drivers must use sleeping context when
+they want to modify the EM. The runtime modifiable EM might also be used for
+better reflecting real workload scenarios, e.g. when they pop-up on the screen
+and will run for longer period, such as: games, video recoding or playing,
+video calls, etc. It is up to the platform engineers to experiment and choose
+the right approach for their device.
+
+
+3. Core APIs
 ------------
 
-2.1 Config options
+3.1 Config options
 ^^^^^^^^^^^^^^^^^^
 
 CONFIG_ENERGY_MODEL must be enabled to use the EM framework.
 
 
-2.2 Registration of performance domains
+3.2 Registration of performance domains
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Registration of 'advanced' EM
@@ -110,8 +164,8 @@ The last argument 'microwatts' is important to set with correct value. Kernel
 subsystems which use EM might rely on this flag to check if all EM devices use
 the same scale. If there are different scales, these subsystems might decide
 to return warning/error, stop working or panic.
-See Section 3. for an example of driver implementing this
-callback, or Section 2.4 for further documentation on this API
+See Section 4. for an example of driver implementing this
+callback, or Section 3.4 for further documentation on this API
 
 Registration of EM using DT
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -156,7 +210,7 @@ The EM which is registered using this method might not reflect correctly the
 physics of a real device, e.g. when static power (leakage) is important.
 
 
-2.3 Accessing performance domains
+3.3 Accessing performance domains
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 There are two API functions which provide the access to the energy model:
@@ -175,10 +229,37 @@ CPUfreq governor is in use in case of CPU device. Currently this calculation is
 not provided for other type of devices.
 
 More details about the above APIs can be found in ``<linux/energy_model.h>``
-or in Section 2.4
+or in Section 3.5
+
+
+3.4 Runtime modifications
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Drivers willing to modify the EM at runtime should use the following API::
+
 
+  int em_dev_update_perf_domain(struct device *dev,
+			struct em_data_callback *cb, void *priv);
 
-2.4 Description details of this API
+Drivers must provide a callback .update_power() returning power value for each
+performance state. The callback function provided by the driver is free
+to fetch data from any relevant location (DT, firmware, ...) or sensor.
+The .update_power() callback is called by the EM for each performance state to
+provide new power value. In the Section 4.2 there is an example driver
+which shows simple implementation of this mechanism. The callback can be
+declared with EM_UPDATE_CB() macro. The caller of that callback also passes
+a private void pointer back to the driver which tries to update EM.
+It is useful and helps to maintain the consistent context for all performance
+state calls for a given EM.
+The artificial EM also supports runtime modifications. For this type of EM
+there is a need to provide one more callback: .get_cost(). The .get_cost()
+returns the cost value for each performance state, which better reflects the
+efficiency of the CPUs which use artificial EM. Those two callbacks:
+.update_power() and get .get_cost() can be declared with one macro
+EM_ADV_UPDATE_CB() and then passed to the em_dev_update_perf_domain().
+
+
+3.5 Description details of this API
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 .. kernel-doc:: include/linux/energy_model.h
    :internal:
@@ -187,8 +268,11 @@ or in Section 2.4
    :export:
 
 
-3. Example driver
------------------
+4. Examples
+-----------
+
+4.1 Example driver with EM registration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The CPUFreq framework supports dedicated callback for registering
 the EM for a given CPU(s) 'policy' object: cpufreq_driver::register_em().
@@ -242,3 +326,49 @@ EM framework::
   39	static struct cpufreq_driver foo_cpufreq_driver = {
   40		.register_em = foo_cpufreq_register_em,
   41	};
+
+
+4.2 Example driver with EM modification
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This section provides a simple example of a thermal driver modifying the EM.
+The driver implements a foo_mod_power() function to be provided to the
+EM framework. The driver is woken up periodically to check the temperature
+and modify the EM data if needed::
+
+  -> drivers/thermal/foo_thermal.c
+
+  01	static int foo_mod_power(struct device *dev, unsigned long freq,
+  02			unsigned long *power, void *priv)
+  03	{
+  04		struct foo_context *ctx = priv;
+  05
+  06		/* Estimate power for the given frequency and temperature */
+  07		*power = foo_estimate_power(dev, freq, ctx->temperature);
+  08		if (*power >= EM_MAX_POWER);
+  09			return -EINVAL;
+  10
+  11		return 0;
+  12	}
+  13
+  14	/*
+  15	 * Function called periodically to check the temperature and
+  16	 * update the EM if needed
+  17	 */
+  18	static void foo_thermal_em_update(struct foo_context *ctx)
+  19	{
+  20		struct em_data_callback em_cb = EM_UPDATE_CB(mod_power);
+  21		struct cpufreq_policy *policy = ctx->policy;
+  22		struct device *cpu_dev;
+  23
+  24		cpu_dev = get_cpu_device(cpumask_first(policy->cpus));
+  25
+  26		ctx->temperature = foo_get_temp(cpu_dev, ctx);
+  27		if (ctx->temperature < FOO_EM_UPDATE_TEMP_THRESHOLD)
+  28			return;
+  29
+  30		/* Update EM for the CPUs' performance domain */
+  31		ret = em_dev_update_perf_domain(cpu_dev, &em_cb, ctx);
+  32		if (ret)
+  33			pr_warn("foo_thermal: EM update failed\n");
+  34	}
-- 
2.25.1

