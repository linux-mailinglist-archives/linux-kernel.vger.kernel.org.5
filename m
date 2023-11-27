Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCB97FA5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjK0QIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjK0QIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:08:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25BE0CE;
        Mon, 27 Nov 2023 08:08:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D2162F4;
        Mon, 27 Nov 2023 08:09:46 -0800 (PST)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D48D3F6C4;
        Mon, 27 Nov 2023 08:08:57 -0800 (PST)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sumitg@nvidia.com
Cc:     sudeep.holla@arm.covm, will@kernel.org, catalin.marinas@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        ionela.voinescu@arm.com, yang@os.amperecomputing.com,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for AArch64 AMUv1-based arch_freq_get_on_cpu
Date:   Mon, 27 Nov 2023 16:08:36 +0000
Message-Id: <20231127160838.1403404-1-beata.michalska@arm.com>
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

Introducing AArch64 specific version of arch_freq_get_on_cpu, cashing on
existing implementation for FIE and AMUv1 support.
Additionally wiring it up with cpufreq_verify_current_freq to hopefully
eliminate issues when cpufreq_driver->get() returns frequency that is not
entirely aligned.

The changes have been rather lightly (due to some limitations) tested on
an FVP model.

v2:
- Splitting the patches
- Adding comment for full dyntick mode
- Plugging arch_freq_get_on_cpu into cpufreq_verify_current_freq instead
  of in show_cpuinfo_cur_freq to allow the framework to stay more in sync
  with potential freq changes

[1]
https://lore.kernel.org/lkml/20230606155754.245998-1-beata.michalska@arm.com/


Beata Michalska (1):
  arm64: Provide an AMU-based version of arch_freq_get_on_cpu

Sumit Gupta (1):
  cpufreq: Wire-up arch-flavored freq info into
    cpufreq_verify_current_freq

 arch/arm64/kernel/topology.c | 39 ++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq.c    |  3 ++-
 2 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.25.1

