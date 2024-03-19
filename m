Return-Path: <linux-kernel+bounces-107828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B78B88022E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D39FFB24410
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF0085636;
	Tue, 19 Mar 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNozJoih"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD718529D;
	Tue, 19 Mar 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865255; cv=none; b=fpluX5wvVqBi41vbkyFLi5kP0N2wdg6LbZNCXnR2kXitInDVIfXDY0eZF39ibtYQYnBsqFdN76YDVpBdMEGGvXFhWzstmeON6KpXNuTtICk32RGi6Joh57j2gS//M7AcRqsxO+yBdf+wRAT0l36RSYbVjcW2gFDXzWEZHnkF3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865255; c=relaxed/simple;
	bh=co6hlec6Z6Bk/daWW+J2lzrn1150wCdper8mRV+O19Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ny0Y3cZFWGkH/VJd6SB/b11OKfSXHRsoWiqySpmXd5T+n6g7C84eDouZQWvfu0q6s+8An5rUawn9+TGnQbURdJDrZ7QHPOQWcavHVokG1ospntF/PX2ymi59d0SAsGPscDMKUO50gQ+ocPDJEZmbuRunbpXSWqeEQllfTGGDVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNozJoih; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710865252; x=1742401252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=co6hlec6Z6Bk/daWW+J2lzrn1150wCdper8mRV+O19Y=;
  b=UNozJoihz80HTN1PBxDBJ7nBD6Hw0ielRfmOosaT13QnjQQ2vhRKRvQd
   HQjrZuLcCyLhUN5SMUVsQCPMnWOoZJA14gMJVCCf/aUOnnRTQowwc7RPO
   ry1hxBxWXAJh2E50Jye7/kxmeyZa2+TsSLWGbiP4iKVeagknk/+tAyG5O
   JKO3sXhhvx1DCJHqXEKkpRMd4pQtcomd/BU8R2g92KKQuDV9pQqSg+J0x
   tDAUK598JHvFKuxvsmN0tASz1pHtfJRGz68Bb+UHdrf7xtqKbO2XFacxw
   RxMclGSgRGNMUGY/+NumhvM0gXEClsKtMeAAnv3UAbmYy2VrOzjcE38Qu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17151717"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="17151717"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 09:20:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="13765334"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.47.203])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 09:20:49 -0700
Message-ID: <36198864-579e-41f0-baf6-917f0a7f4bfa@intel.com>
Date: Tue, 19 Mar 2024 18:20:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug report: probe of AMDI0040:00 failed with error -16
To: Francisco Ayala Le Brun <francisco@videowindow.eu>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org
References: <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/24 16:43, Francisco Ayala Le Brun wrote:
> Hello,
> 
> I would like to report a bug.
> 
> Issue description:
> After updating a GHF51 SBC to a newer kernel version, the system was

What was the older / working kernel version?  Are you able
to git bisect?

> no longer able to boot. Running the "lsblk" command in the recovery
> console showed no mmc storage detected.
> 
> System Information:
> OS: Fedora 40 x86_64
> Kernel: 6.8.0-0.rc6.49.fc40.x86_64
> 
> Relevant Logs:

Really no error / fail messages before the stack dump?

> [   10.920756] Call Trace:
> [   10.920763]  <TASK>
> [   10.920771]  dump_stack_lvl+0x4d/0x70
> [   10.920786]  __setup_irq+0x530/0x6c0
> [   10.920801]  request_threaded_irq+0xe5/0x180
> [   10.920813]  ? __pfx_sdhci_thread_irq+0x10/0x10 [sdhci]
> [   10.920843]  __sdhci_add_host+0x108/0x360 [sdhci]
> [   10.920871]  sdhci_acpi_probe+0x3a8/0x500 [sdhci_acpi]
> [   10.920894]  platform_probe+0x44/0xa0
> [   10.920908]  really_probe+0x19e/0x3e0
> [   10.930244]  __driver_probe_device+0x78/0x160
> [   10.930264]  driver_probe_device+0x1f/0xa0
> [   10.930273]  __driver_attach_async_helper+0x5e/0xe0
> [   10.930284]  async_run_entry_fn+0x34/0x130
> [   10.930296]  process_one_work+0x170/0x330
> [   10.930309]  worker_thread+0x273/0x3c0
> [   10.934639]  ? __pfx_worker_thread+0x10/0x10
> [   10.934654]  kthread+0xe8/0x120
> [   10.934663]  ? __pfx_kthread+0x10/0x10
> [   10.934671]  ret_from_fork+0x34/0x50
> [   10.934681]  ? __pfx_kthread+0x10/0x10
> [   10.934688]  ret_from_fork_asm+0x1b/0x30
> [   10.934708]  </TASK>
> [   10.940978] mmc0: Failed to request IRQ 7: -16
> [   10.943885] sdhci-acpi: probe of AMDI0040:00 failed with error -16

16 is EBUSY which seems to be used by __setup_irq() for
irq mismatch


