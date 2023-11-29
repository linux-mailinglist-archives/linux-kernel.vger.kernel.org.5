Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15D7FD52D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjK2LLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjK2LKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:10:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDDDC1FD2;
        Wed, 29 Nov 2023 03:09:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8F0FC15;
        Wed, 29 Nov 2023 03:09:50 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.4.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DDB73F5A1;
        Wed, 29 Nov 2023 03:09:01 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: [PATCH v5 23/23] Documentation: EM: Update with runtime modification design
Date:   Wed, 29 Nov 2023 11:08:53 +0000
Message-Id: <20231129110853.94344-24-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129110853.94344-1-lukasz.luba@arm.com>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new section 'Design' which covers the information about Energy
Model. It contains the design decisions, describes models and how they
reflect the reality. Remove description of the default EM. Change the
other section IDs. Add documentation bit for the new feature which
allows to modify the EM in runtime.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 206 +++++++++++++++++++++++++--
 1 file changed, 196 insertions(+), 10 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 13225965c9a4..1f8cf36914b1 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -72,16 +72,48 @@ required to have the same micro-architecture. CPUs in different performance
 domains can have different micro-architectures.
 
 
-2. Core APIs
+2. Design
+-----------------
+
+2.1 Runtime modifiable EM
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To better reflect power variation due to static power (leakage) the EM
+supports runtime modifications of the power values. The mechanism relies on
+RCU to free the modifiable EM perf_state table memory. Its user, the task
+scheduler, also uses RCU to access this memory. The EM framework provides
+API for allocating/freeing the new memory for the modifiable EM table.
+The old memory is freed automatically using RCU callback mechanism when there
+are no owners anymore for the given EM runtime table instance. This is tracked
+using kref mechanism. The device driver which provided the new EM at runtime,
+should call EM API to free it safely when it's no longer needed. The EM
+framework will handle the clean-up when it's possible.
+
+The kernel code which want to modify the EM values is protected from concurrent
+access using a mutex. Therefore, the device driver code must run in sleeping
+context when it tries to modify the EM.
+
+With the runtime modifiable EM we switch from a 'single and during the entire
+runtime static EM' (system property) design to a 'single EM which can be
+changed during runtime according e.g. to the workload' (system and workload
+property) design.
+
+It is possible also to modify the CPU performance values for each EM's
+performance state. Thus, the full power and performance profile (which
+is an exponential curve) can be changed according e.g. to the workload
+or system property.
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
@@ -110,8 +142,8 @@ The last argument 'microwatts' is important to set with correct value. Kernel
 subsystems which use EM might rely on this flag to check if all EM devices use
 the same scale. If there are different scales, these subsystems might decide
 to return warning/error, stop working or panic.
-See Section 3. for an example of driver implementing this
-callback, or Section 2.4 for further documentation on this API
+See Section 4. for an example of driver implementing this
+callback, or Section 3.4 for further documentation on this API
 
 Registration of EM using DT
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -156,7 +188,7 @@ The EM which is registered using this method might not reflect correctly the
 physics of a real device, e.g. when static power (leakage) is important.
 
 
-2.3 Accessing performance domains
+3.3 Accessing performance domains
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 There are two API functions which provide the access to the energy model:
@@ -175,10 +207,83 @@ CPUfreq governor is in use in case of CPU device. Currently this calculation is
 not provided for other type of devices.
 
 More details about the above APIs can be found in ``<linux/energy_model.h>``
-or in Section 2.4
+or in Section 3.5
+
+
+3.4 Runtime modifications
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Drivers willing to update the EM at runtime should use the following dedicated
+function to allocate a new instance of the modified EM. The API is listed
+below::
+
+  struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd);
+
+This allows to allocate a structure which contains the new EM table with
+also RCU and kref needed by the EM framework. The 'struct em_perf_table'
+contains array 'struct em_perf_state state[]' which is a list of performance
+states in ascending order. That list must be populated by the device driver
+which wants to update the EM. The list of frequencies can be taken from
+existing EM (created during boot). The content in the 'struct em_perf_state'
+must be populated by the driver as well.
+
+This is the API which does the EM update, using RCU pointers swap::
+
+  int em_dev_update_perf_domain(struct device *dev,
+			struct em_perf_table __rcu *new_table);
+
+Drivers must provide a pointer to the allocated and initialized new EM
+'struct em_perf_table'. That new EM will be safely used inside the EM framework
+and will be visible to other sub-systems in the kernel (thermal, powercap).
+The main design goal for this API is to be fast and avoid extra calculations
+or memory allocations at runtime. When pre-computed EMs are available in the
+device driver, than it should be possible to simply re-use them with low
+performance overhead.
+
+In order to free the EM, provided earlier by the driver (e.g. when the module
+is unloaded), there is a need to call the API::
+
+  void em_free_table(struct em_perf_table __rcu *table);
+
+It will allow the EM framework to safely remove the memory, when there is
+no other sub-system using it, e.g. EAS.
+
+To use the power values in other sub-systems (like thermal, powercap) there is
+a need to call API which protects the reader and provide consistency of the EM
+table data::
 
+  struct em_perf_state *em_get_table(struct em_perf_domain *pd);
 
-2.4 Description details of this API
+It returns the 'struct em_perf_state' pointer which is an array of performance
+states in ascending order.
+
+When the EM table is not needed anymore there is a need to call dedicated API::
+
+  void em_put_table(void);
+
+In this way the EM safely uses the RCU read section and protects the users.
+It also allows the EM framework to manage the memory and free it.
+
+There is dedicated API for device drivers to calculate em_perf_state::cost
+values::
+
+  int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
+                           int nr_states);
+
+These 'cost' values from EM are used in EAS. The new EM table should be passed
+together with the number of entries and device pointer. When the computation
+of the cost values is done properly the return value from the function is 0.
+The function takes care for right setting of inefficiency for each performance
+state as well. It updates em_perf_state::flags accordingly.
+Then such prepared new EM can be passed to the em_dev_update_perf_domain()
+function, which will allow to use it.
+
+More details about the above APIs can be found in ``<linux/energy_model.h>``
+or in Section 4.2 with an example code showing simple implementation of the
+updating mechanism in a device driver.
+
+
+3.5 Description details of this API
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 .. kernel-doc:: include/linux/energy_model.h
    :internal:
@@ -187,8 +292,11 @@ or in Section 2.4
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
@@ -242,3 +350,81 @@ EM framework::
   39	static struct cpufreq_driver foo_cpufreq_driver = {
   40		.register_em = foo_cpufreq_register_em,
   41	};
+
+
+4.2 Example driver with EM modification
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This section provides a simple example of a thermal driver modifying the EM.
+The driver implements a foo_thermal_em_update() function. The driver is woken
+up periodically to check the temperature and modify the EM data::
+
+  -> drivers/soc/example/example_em_mod.c
+
+  01	static void foo_get_new_em(struct device *dev)
+  02	{
+  03		struct em_perf_table __rcu *runtime_table;
+  04		struct em_perf_state *table, *new_table;
+  05		struct em_perf_domain *pd;
+  06		unsigned long freq;
+  07		int i, ret;
+  08
+  09		pd = em_pd_get(dev);
+  10		if (!pd)
+  11			return;
+  12
+  13		runtime_table = em_allocate_table(pd);
+  14		if (!runtime_table)
+  15			return;
+  16
+  17		new_table = runtime_table->state;
+  18
+  19		table = em_get_table(pd);
+  20		for (i = 0; i < pd->nr_perf_states; i++) {
+  21			freq = table[i].frequency;
+  22			foo_get_power_perf_values(dev, freq, &new_table[i]);
+  23		}
+  24		em_put_table();
+  25
+  26		/* Calculate 'cost' values for EAS */
+  27		ret = em_dev_compute_costs(dev, table, pd->nr_perf_states);
+  28		if (ret) {
+  29			dev_warn(dev, "EM: compute costs failed %d\n", ret);
+  30			em_free_table(runtime_table);
+  31			return;
+  32		}
+  33
+  34		ret = em_dev_update_perf_domain(dev, runtime_table);
+  35		if (ret) {
+  36			dev_warn(dev, "EM: update failed %d\n", ret);
+  37			em_free_table(runtime_table);
+  38			return;
+  39		}
+  40
+  41		ctx->runtime_table = runtime_table;
+  42	}
+  43
+  44	/*
+  45	 * Function called periodically to check the temperature and
+  46	 * update the EM if needed
+  47	 */
+  48	static void foo_thermal_em_update(struct foo_context *ctx)
+  49	{
+  50		struct device *dev = ctx->dev;
+  51		int cpu;
+  52
+  53		ctx->temperature = foo_get_temp(dev, ctx);
+  54		if (ctx->temperature < FOO_EM_UPDATE_TEMP_THRESHOLD)
+  55			return;
+  56
+  57		foo_get_new_em(dev);
+  58	}
+  59
+  60	static void foo_exit(void)
+  61	{
+  62		struct foo_context *ctx = glob_ctx;
+  63
+  64		em_free_table(ctx->runtime_table);
+  65	}
+  66
+  67	module_exit(foo_exit);
-- 
2.25.1

