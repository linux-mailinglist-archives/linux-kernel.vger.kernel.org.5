Return-Path: <linux-kernel+bounces-109700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488BD881C90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B740D1F225C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D91C52F70;
	Thu, 21 Mar 2024 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0qS/0ZT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A64DA10;
	Thu, 21 Mar 2024 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003216; cv=none; b=i+wuGhYsRJsDHlBYi6IVpSauQwZNyo4m3VJA5YN21ygw+1vJmqddS6la7NKlKCbBLMayXH3VMV4waNVykqlQHD5fG97PPPrxKuZyD1LXNvJaerSznO0cshc9lxmAW21h/uZMn0jk6yPh9RXR5+Xx9lTzvkt/qzkRaHkLd9BZ5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003216; c=relaxed/simple;
	bh=CHxCCG3lNujh8NKNGLSpylXtQrM9drveE37uO6wOlvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcMBu0NL70HH4UfgIoE0VMpG3feqCyna5Te9UYIzg9fitxwaypHTqy1bPOLK3qSEj/Qw42NIDRPx5jFlHarCmwXYIkghhvCPigT/A4drW98OOS0/9m2l9WKLB7VsJ3whOYMggnaFbtx9jzWm0DXQ7BIURGqDhniarAUR+zo31kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0qS/0ZT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711003213; x=1742539213;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CHxCCG3lNujh8NKNGLSpylXtQrM9drveE37uO6wOlvQ=;
  b=P0qS/0ZTuVZ/D3qxoaBappd1orLvgs3fB3BPmjRpF9s9NIjL/DFBhLc6
   tvSj2aAzFXRsEGd1CGkyF1DF3T1tF7Mhw3TOU14wIaOGC6JQCnkkOUaow
   PB0+oE8qZExuniiUnCmMwQbUujSEj87Z+bTnIqbTOzZqMPzmJzgKyMLid
   Pi2wfYdgIsXRV/VPIy7at1pHmLNne4K6WfofK6Qy4M5xvTq8uFxjMkr3G
   Ht1YQ//P8SEMne2oRhIuD0MtA8lWjF/t0b6HZN6K4qdesWXOMDSIFPFWb
   NQEcydsQxqyfPq4erYJDEHaR5kq74YEEEspa8Vsm4ZNxnCeV6sJwX0/Bv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16705046"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="16705046"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 23:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="19127605"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.210.179])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 23:40:11 -0700
Message-ID: <6e67269f-88a4-466a-ac34-430b82fac4ff@intel.com>
Date: Thu, 21 Mar 2024 08:40:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
To: Maxim Kiselev <bigunclemax@gmail.com>, serghox@gmail.com
Cc: jyanchou@realtek.com, open list <linux-kernel@vger.kernel.org>,
 linux-mmc@vger.kernel.org, quic_asutoshd@quicinc.com, ritesh.list@gmail.com,
 shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>
References: <CALHCpMiUfa0j46HcorZGPDPV5Zg5ZFdWukT+5jTediuKJuoB5w@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CALHCpMiUfa0j46HcorZGPDPV5Zg5ZFdWukT+5jTediuKJuoB5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/24 12:36, Maxim Kiselev wrote:
> Subject: [PATCH v7 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
> 
> Hi Sergey, Adrian!
> 
> First of all I want to thank Sergey for supporting the CQE feature
> on the DWC MSHC controller.
> 
> I tested this series on the LicheePi 4A board (TH1520 SoC).
> It has the DWC MSHC IP too and according to the T-Head datasheet
> it also supports the CQE feature.
> 
>> Supports Command Queuing Engine (CQE) and compliant with eMMC CQ HCI.
> 
> So, to enable CQE on LicheePi 4A need to set a prop in DT
> and add a IRQ handler to th1520_ops:
>> .irq = dwcmshc_cqe_irq_handler,
> 
> And the CQE will work for th1520 SoC too.
> 
> But, when I enabled the CQE, I was faced with a strange effect.
> 
> The fio benchmark shows that emmc works ~2.5 slower with enabled CQE.
> 219MB/s w/o CQE vs 87.4MB/s w/ CQE. I'll put logs below.
> 
> I would be very appreciative if you could point me where to look for
> the bottleneck.

Some things you could try:

 Check for any related kernel messages.

 Have a look at /sys/kernel/debug/mmc*/err_stats

 See if disabling runtime PM for the host controller has any effect.

 Enable mmc dynamic debug messages and see if anything looks different.

> 
> Without CQE:
> 
> # cat /sys/kernel/debug/mmc0/ios
> clock:          198000000 Hz
> actual clock:   198000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    10 (mmc HS400 enhanced strobe)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> 
> # fio --filename=/dev/mmcblk0 --direct=1 --rw=randread --bs=1M
> --ioengine=sync --iodepth=256 --size=4G --numjobs=1 --group_reporting
> --name=iops-test-job --eta-newline=1 --readonly
> iops-test-job: (g=0): rw=randread, bs=(R) 1024KiB-1024KiB, (W)
> 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=sync, iodepth=256
> fio-3.34
> Starting 1 process
> note: both iodepth >= 1 and synchronous I/O engine are selected, queue
> depth will be capped at 1
> Jobs: 1 (f=1): [r(1)][15.0%][r=209MiB/s][r=209 IOPS][eta 00m:17s]
> Jobs: 1 (f=1): [r(1)][25.0%][r=208MiB/s][r=208 IOPS][eta 00m:15s]
> Jobs: 1 (f=1): [r(1)][35.0%][r=207MiB/s][r=207 IOPS][eta 00m:13s]
> Jobs: 1 (f=1): [r(1)][47.4%][r=208MiB/s][r=208 IOPS][eta 00m:10s]
> Jobs: 1 (f=1): [r(1)][52.6%][r=209MiB/s][r=208 IOPS][eta 00m:09s]
> Jobs: 1 (f=1): [r(1)][63.2%][r=208MiB/s][r=208 IOPS][eta 00m:07s]
> Jobs: 1 (f=1): [r(1)][68.4%][r=208MiB/s][r=207 IOPS][eta 00m:06s]
> Jobs: 1 (f=1): [r(1)][78.9%][r=207MiB/s][r=207 IOPS][eta 00m:04s]
> Jobs: 1 (f=1): [r(1)][89.5%][r=209MiB/s][r=209 IOPS][eta 00m:02s]
> Jobs: 1 (f=1): [r(1)][100.0%][r=209MiB/s][r=209 IOPS][eta 00m:00s]
> iops-test-job: (groupid=0, jobs=1): err= 0: pid=132: Thu Jan  1 00:03:44 1970
>   read: IOPS=208, BW=208MiB/s (219MB/s)(4096MiB/19652msec)
>     clat (usec): min=3882, max=11557, avg=4778.37, stdev=238.26
>      lat (usec): min=3883, max=11559, avg=4779.93, stdev=238.26
>     clat percentiles (usec):
>      |  1.00th=[ 4359],  5.00th=[ 4555], 10.00th=[ 4555], 20.00th=[ 4621],
>      | 30.00th=[ 4621], 40.00th=[ 4686], 50.00th=[ 4752], 60.00th=[ 4817],
>      | 70.00th=[ 4883], 80.00th=[ 4948], 90.00th=[ 5014], 95.00th=[ 5145],
>      | 99.00th=[ 5473], 99.50th=[ 5538], 99.90th=[ 5932], 99.95th=[ 6915],
>      | 99.99th=[11600]
>    bw (  KiB/s): min=208896, max=219136, per=100.00%, avg=213630.77,
> stdev=1577.33, samples=39
>    iops        : min=  204, max=  214, avg=208.56, stdev= 1.55, samples=39
>   lat (msec)   : 4=0.39%, 10=99.58%, 20=0.02%
>   cpu          : usr=0.38%, sys=13.04%, ctx=4132, majf=0, minf=275
>   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      issued rwts: total=4096,0,0,0 short=0,0,0,0 dropped=0,0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=256
> 
> Run status group 0 (all jobs):
>    READ: bw=208MiB/s (219MB/s), 208MiB/s-208MiB/s (219MB/s-219MB/s),
> io=4096MiB (4295MB), run=19652-19652msec
> 
> Disk stats (read/write):
>   mmcblk0: ios=8181/0, merge=0/0, ticks=25682/0, in_queue=25682, util=99.66%
> 
> 
> With CQE:

Was output from "cat /sys/kernel/debug/mmc0/ios" the same?

> 
> fio --filename=/dev/mmcblk1 --direct=1 --rw=randread --bs=1M --ioengine=sync -
> -iodepth=256 --size=4G --numjobs=1 --group_reporting --name=iops-test-job --eta-
> newline=1 --readonly
> iops-test-job: (g=0): rw=randread, bs=(R) 1024KiB-1024KiB, (W)
> 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioeng
> ine=sync, iodepth=256
> fio-3.34
> Starting 1 process
> note: both iodepth >= 1 and synchronous I/O engine are selected, queue
> depth will be capped at 1
> Jobs: 1 (f=1): [r(1)][5.8%][r=83.1MiB/s][r=83 IOPS][eta 00m:49s]
> Jobs: 1 (f=1): [r(1)][10.0%][r=84.0MiB/s][r=84 IOPS][eta 00m:45s]
> Jobs: 1 (f=1): [r(1)][14.0%][r=83.1MiB/s][r=83 IOPS][eta 00m:43s]
> Jobs: 1 (f=1): [r(1)][18.0%][r=83.1MiB/s][r=83 IOPS][eta 00m:41s]
> Jobs: 1 (f=1): [r(1)][22.4%][r=84.1MiB/s][r=84 IOPS][eta 00m:38s]
> Jobs: 1 (f=1): [r(1)][26.5%][r=83.1MiB/s][r=83 IOPS][eta 00m:36s]
> Jobs: 1 (f=1): [r(1)][30.6%][r=83.1MiB/s][r=83 IOPS][eta 00m:34s]
> Jobs: 1 (f=1): [r(1)][34.7%][r=84.1MiB/s][r=84 IOPS][eta 00m:32s]
> Jobs: 1 (f=1): [r(1)][38.8%][r=83.1MiB/s][r=83 IOPS][eta 00m:30s]
> Jobs: 1 (f=1): [r(1)][42.9%][r=83.1MiB/s][r=83 IOPS][eta 00m:28s]
> Jobs: 1 (f=1): [r(1)][46.9%][r=84.1MiB/s][r=84 IOPS][eta 00m:26s]
> Jobs: 1 (f=1): [r(1)][51.0%][r=83.0MiB/s][r=83 IOPS][eta 00m:24s]
> Jobs: 1 (f=1): [r(1)][55.1%][r=83.0MiB/s][r=83 IOPS][eta 00m:22s]
> Jobs: 1 (f=1): [r(1)][59.2%][r=84.1MiB/s][r=84 IOPS][eta 00m:20s]
> Jobs: 1 (f=1): [r(1)][63.3%][r=83.0MiB/s][r=83 IOPS][eta 00m:18s]
> Jobs: 1 (f=1): [r(1)][67.3%][r=83.1MiB/s][r=83 IOPS][eta 00m:16s]
> Jobs: 1 (f=1): [r(1)][71.4%][r=84.1MiB/s][r=84 IOPS][eta 00m:14s]
> Jobs: 1 (f=1): [r(1)][75.5%][r=83.0MiB/s][r=83 IOPS][eta 00m:12s]
> Jobs: 1 (f=1): [r(1)][79.6%][r=83.0MiB/s][r=83 IOPS][eta 00m:10s]
> Jobs: 1 (f=1): [r(1)][83.7%][r=84.0MiB/s][r=84 IOPS][eta 00m:08s]
> Jobs: 1 (f=1): [r(1)][87.8%][r=83.1MiB/s][r=83 IOPS][eta 00m:06s]
> Jobs: 1 (f=1): [r(1)][91.8%][r=83.0MiB/s][r=83 IOPS][eta 00m:04s]
> Jobs: 1 (f=1): [r(1)][95.9%][r=84.0MiB/s][r=84 IOPS][eta 00m:02s]
> Jobs: 1 (f=1): [r(1)][100.0%][r=83.0MiB/s][r=83 IOPS][eta 00m:00s]
> iops-test-job: (groupid=0, jobs=1): err= 0: pid=134: Thu Jan  1 00:02:19 1970
>   read: IOPS=83, BW=83.3MiB/s (87.4MB/s)(4096MiB/49154msec)
>     clat (usec): min=11885, max=14840, avg=11981.37, stdev=61.89
>      lat (usec): min=11887, max=14843, avg=11983.00, stdev=61.92
>     clat percentiles (usec):
>      |  1.00th=[11863],  5.00th=[11994], 10.00th=[11994], 20.00th=[11994],
>      | 30.00th=[11994], 40.00th=[11994], 50.00th=[11994], 60.00th=[11994],
>      | 70.00th=[11994], 80.00th=[11994], 90.00th=[11994], 95.00th=[11994],
>      | 99.00th=[12125], 99.50th=[12256], 99.90th=[12387], 99.95th=[12387],
>      | 99.99th=[14877]
>    bw (  KiB/s): min=83800, max=86016, per=100.00%, avg=85430.61,
> stdev=894.16, samples=98
>    iops        : min=   81, max=   84, avg=83.22, stdev= 0.89, samples=98
>   lat (msec)   : 20=100.00%
>   cpu          : usr=0.00%, sys=5.44%, ctx=4097, majf=0, minf=274
>   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      issued rwts: total=4096,0,0,0 short=0,0,0,0 dropped=0,0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=256
> 
> Run status group 0 (all jobs):
>    READ: bw=83.3MiB/s (87.4MB/s), 83.3MiB/s-83.3MiB/s
> (87.4MB/s-87.4MB/s), io=4096MiB (4295MB), run=49154-
> 49154msec
> 
> Disk stats (read/write):
>   mmcblk1: ios=8181/0, merge=0/0, ticks=69682/0, in_queue=69682, util=99.96%
> 
> 
> Best regards,
> Maksim


