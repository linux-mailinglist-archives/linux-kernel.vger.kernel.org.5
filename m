Return-Path: <linux-kernel+bounces-20093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E5827931
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F99A1C2317B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B443655E56;
	Mon,  8 Jan 2024 20:35:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1803D55E43
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13052C15;
	Mon,  8 Jan 2024 12:35:44 -0800 (PST)
Received: from bogus (unknown [10.57.74.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F4A43F73F;
	Mon,  8 Jan 2024 12:34:56 -0800 (PST)
Date: Mon, 8 Jan 2024 20:31:50 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 2/2] firmware/psci: Set
 pm_set_resume/suspend_via_firmware() on qcom
Message-ID: <20240108203150.cx2kswpfcfmouv76@bogus>
References: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
 <20231227-topic-psci_fw_sus-v1-2-6910add70bf3@linaro.org>
 <20231228102801.fzaubcjq5thfwgxg@bogus>
 <f34dd5de-9e56-4c58-b9bf-2356b41d17b1@linaro.org>
 <20231228115053.zlypgc5uxxvghi4a@bogus>
 <376d3040-b9ed-4574-90d7-fb864d694e3c@linaro.org>
 <20231228124348.mmtceqeuean7ly6y@bogus>
 <7e31d489-de96-42f0-a72a-a581859e7131@linaro.org>
 <20240103094442.mlh2pf3odof3ze3s@bogus>
 <5499a078-a4de-47fb-ad2c-aa478699eb77@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5499a078-a4de-47fb-ad2c-aa478699eb77@kernel.org>

On Mon, Jan 08, 2024 at 04:47:05PM +0100, Konrad Dybcio wrote:
> On 3.01.2024 10:44, Sudeep Holla wrote:
> >
> > But I don't like the Qualcomm specific changes.
>
> Is that because of the matching table, or due to the slightly more
> convoluted way of suspending the platform through CPU_SUSPEND?
>

I would say both. I don't like this to be Qualcomm platform specific
feature. Also advertising absence of system suspend on those platforms
as presence of some special system suspend. It simply is not system
suspend. The sysfs hides/abstracts and provides s2idle even when user
request s2r on such platforms.

We should advertise it as s2idle. I would do something like below patch,
just a rough idea, not compiled or tested. This avoids any misleading
or confusion IMO.

However I am interested in knowing which are these drivers that rely on
the pm_suspend_global_flags ? The reason I ask the x86 ACPI doesn't set
the flags for s2idle. Also the core code explicitly calls
pm_set_suspend_no_platform() in suspend_devices_and_enter(). What you
want conflicts with both the above observations. I would like to involve
Rafael and check what is the correct/expected way to use those flags.

Regards,
Sudeep

--->8
diff --git i/drivers/firmware/psci/psci.c w/drivers/firmware/psci/psci.c
index 0e622aa5ad58..b2559ae7668a 100644
--- i/drivers/firmware/psci/psci.c
+++ w/drivers/firmware/psci/psci.c
@@ -505,26 +505,42 @@ static int psci_system_suspend(unsigned long unused)
        return psci_to_linux_errno(err);
 }

-static int psci_system_suspend_enter(suspend_state_t state)
+static int psci_system_idle_prepare_late(void)
 {
        pm_set_resume_via_firmware();
+       return 0;
+}
+#define psci_system_system_prepare_late        psci_system_idle_prepare_late
+
+static int psci_system_suspend_enter(suspend_state_t state)
+{
+       psci_system_system_prepare_late();

        return cpu_suspend(0, psci_system_suspend);
 }

-static int psci_system_suspend_begin(suspend_state_t state)
+static int psci_system_idle_begin(void)
 {
        pm_set_suspend_via_firmware();
-
        return 0;
 }

+static int psci_system_suspend_begin(suspend_state_t state)
+{
+       return psci_system_idle_begin();
+}
+
 static const struct platform_suspend_ops psci_suspend_ops = {
        .valid          = suspend_valid_only_mem,
        .enter          = psci_system_suspend_enter,
        .begin          = psci_system_suspend_begin,
 };

+static const struct platform_s2idle_ops psci_s2idle_ops = {
+       .begin = psci_system_idle_begin,
+       .prepare_late = psci_system_idle_prepare_late,
+};
+
 static void __init psci_init_system_reset2(void)
 {
        int ret;
@@ -546,6 +562,8 @@ static void __init psci_init_system_suspend(void)

        if (ret != PSCI_RET_NOT_SUPPORTED)
                suspend_set_ops(&psci_suspend_ops);
+
+       s2idle_set_ops(&psci_s2idle_ops);
 }

 static void __init psci_init_cpu_suspend(void)


