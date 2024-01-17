Return-Path: <linux-kernel+bounces-28794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFE830318
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C8B1F258BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88CF21A0F;
	Wed, 17 Jan 2024 09:57:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473A021A04;
	Wed, 17 Jan 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485430; cv=none; b=HDJsW1J1z2hKXHVcBF2MHU2vBKB/7uQaeXY/itAc/VgQ8YJfmf81RHnzq+JLL0xVky1H2s9prSBekLKIHXGLEROdyXcIeFuIYCIElv/XfCXIeFbyZDRK0BjfcSCaCyH9HmTFZQRs1tUGHR3+FeT/OW3snI6rlF8HtjlBdkrPH38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485430; c=relaxed/simple;
	bh=A2H4bLvuCGFSPvwL6isvOpohvRIF8XsUro/bO9ezbw0=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=jBxhoyt61ZhT3V4+dvu+aWrb9Ak7rgsHUsUWKA5dSTERlXNQEZfoPUqQ0EcXERPfANzT1HOw/svBBYg2JK/c3mGbiL1QRlls3OOvq/mFdVypABKkPMbbi2mG909RXnT0kR6ct9iua10kmnBj5du69spuCl5+bPPL8GyRpibkmkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF672DA7;
	Wed, 17 Jan 2024 01:57:53 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 190F13F5A1;
	Wed, 17 Jan 2024 01:57:04 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rui.zhang@intel.com,
	amit.kucheria@verdurent.com,
	amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mhiramat@kernel.org,
	qyousef@layalina.io,
	wvw@google.com,
	xuewen.yan94@gmail.com
Subject: [PATCH v7 23/23] Documentation: EM: Update with runtime modification design
Date: Wed, 17 Jan 2024 09:57:14 +0000
Message-Id: <20240117095714.1524808-24-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117095714.1524808-1-lukasz.luba@arm.com>
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new description which covers the information about runtime EM.
It contains the design decisions, describes models and how they
reflect the reality. Remove description of the default EM. Add example
driver code which modifies EM. Add API documentation for the new feature
which allows to modify the EM in runtime.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 Documentation/power/energy-model.rst | 183 ++++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 4 deletions(-)

diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
index 13225965c9a4..ada4938c37e5 100644
--- a/Documentation/power/energy-model.rst
+++ b/Documentation/power/energy-model.rst
@@ -71,6 +71,31 @@ whose performance is scaled together. Performance domains generally have a
 required to have the same micro-architecture. CPUs in different performance
 domains can have different micro-architectures.
 
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
 
 2. Core APIs
 ------------
@@ -175,10 +200,82 @@ CPUfreq governor is in use in case of CPU device. Currently this calculation is
 not provided for other type of devices.
 
 More details about the above APIs can be found in ``<linux/energy_model.h>``
-or in Section 2.4
+or in Section 2.5
+
+
+2.4 Runtime modifications
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Drivers willing to update the EM at runtime should use the following dedicated
+function to allocate a new instance of the modified EM. The API is listed
+below::
+
+  struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
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
+  void em_table_free(struct em_perf_table __rcu *table);
+
+It will allow the EM framework to safely remove the memory, when there is
+no other sub-system using it, e.g. EAS.
+
+To use the power values in other sub-systems (like thermal, powercap) there is
+a need to call API which protects the reader and provide consistency of the EM
+table data::
+
+  struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd);
+
+It returns the 'struct em_perf_state' pointer which is an array of performance
+states in ascending order.
+This function must be called in the RCU read lock section (after the
+rcu_read_lock()). When the EM table is not needed anymore there is a need to
+call rcu_real_unlock(). In this way the EM safely uses the RCU read section
+and protects the users. It also allows the EM framework to manage the memory
+and free it. More details how to use it can be found in Section 3.2 in the
+example driver.
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
+or in Section 3.2 with an example code showing simple implementation of the
+updating mechanism in a device driver.
 
 
-2.4 Description details of this API
+2.5 Description details of this API
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 .. kernel-doc:: include/linux/energy_model.h
    :internal:
@@ -187,8 +284,11 @@ or in Section 2.4
    :export:
 
 
-3. Example driver
------------------
+3. Examples
+-----------
+
+3.1 Example driver with EM registration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The CPUFreq framework supports dedicated callback for registering
 the EM for a given CPU(s) 'policy' object: cpufreq_driver::register_em().
@@ -242,3 +342,78 @@ EM framework::
   39	static struct cpufreq_driver foo_cpufreq_driver = {
   40		.register_em = foo_cpufreq_register_em,
   41	};
+
+
+3.2 Example driver with EM modification
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This section provides a simple example of a thermal driver modifying the EM.
+The driver implements a foo_thermal_em_update() function. The driver is woken
+up periodically to check the temperature and modify the EM data::
+
+  -> drivers/soc/example/example_em_mod.c
+
+  01	static void foo_get_new_em(struct foo_context *ctx)
+  02	{
+  03		struct em_perf_table __rcu *em_table;
+  04		struct em_perf_state *table, *new_table;
+  05		struct device *dev = ctx->dev;
+  06		struct em_perf_domain *pd;
+  07		unsigned long freq;
+  08		int i, ret;
+  09
+  10		pd = em_pd_get(dev);
+  11		if (!pd)
+  12			return;
+  13
+  14		em_table = em_table_alloc(pd);
+  15		if (!em_table)
+  16			return;
+  17
+  18		new_table = em_table->state;
+  19
+  20		rcu_read_lock();
+  21		table = em_perf_state_from_pd(pd);
+  22		for (i = 0; i < pd->nr_perf_states; i++) {
+  23			freq = table[i].frequency;
+  24			foo_get_power_perf_values(dev, freq, &new_table[i]);
+  25		}
+  26		rcu_read_unlock();
+  27
+  28		/* Calculate 'cost' values for EAS */
+  29		ret = em_dev_compute_costs(dev, table, pd->nr_perf_states);
+  30		if (ret) {
+  31			dev_warn(dev, "EM: compute costs failed %d\n", ret);
+  32			em_free_table(em_table);
+  33			return;
+  34		}
+  35
+  36		ret = em_dev_update_perf_domain(dev, em_table);
+  37		if (ret) {
+  38			dev_warn(dev, "EM: update failed %d\n", ret);
+  39			em_free_table(em_table);
+  40			return;
+  41		}
+  42
+  43		/*
+  44		 * Since it's one-time-update drop the usage counter.
+  45		 * The EM framework will later free the table when needed.
+  46		 */
+  47		em_table_free(em_table);
+  48	}
+  49
+  50	/*
+  51	 * Function called periodically to check the temperature and
+  52	 * update the EM if needed
+  53	 */
+  54	static void foo_thermal_em_update(struct foo_context *ctx)
+  55	{
+  56		struct device *dev = ctx->dev;
+  57		int cpu;
+  58
+  59		ctx->temperature = foo_get_temp(dev, ctx);
+  60		if (ctx->temperature < FOO_EM_UPDATE_TEMP_THRESHOLD)
+  61			return;
+  62
+  63		foo_get_new_em(ctx);
+  64	}
-- 
2.25.1


