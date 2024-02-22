Return-Path: <linux-kernel+bounces-76553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9EF85F912
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D25BB233B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE43C480;
	Thu, 22 Feb 2024 13:01:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460FC3D97D;
	Thu, 22 Feb 2024 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606904; cv=none; b=u8/GMYN5AY+N672Vok6qGMqie+y+PciSCShybUF3Qb05ucaHvJMCuBT1U/jguGrX0NZIQJq0X2eJFlycMgNDu+rtTaMo6zE7GIV7A8GRBF2MfUfoeOw6MeO7LbEEq+D0hWzCQDbr9LsdHz9qoOpMiyQpYzNH0YjlZmsg77DSKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606904; c=relaxed/simple;
	bh=tkg3Wb8+dE9AAHQzem0FuYsgW3iotGcQZJvFUflkWCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvHby2onbkn0YosP3nnVD3JnVNd38elovFz807QD2fL88jEjnUOCeaU5SzPr9nHqOZvbvVkfqRx/f+5UJhPhZ2vloRu2IRFflSQF4jEPXeMVEDdThziPeuP+Lee+78ZW4QiX+DQJLlz30W1vbLe1LuN33MtMXam8IkbQmQKPr0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2727DDA7;
	Thu, 22 Feb 2024 05:02:16 -0800 (PST)
Received: from [10.57.10.154] (unknown [10.57.10.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39A963F762;
	Thu, 22 Feb 2024 05:01:35 -0800 (PST)
Message-ID: <e42b76a9-fc5f-4ab7-96a2-629261a9c983@arm.com>
Date: Thu, 22 Feb 2024 13:01:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/25] genirq/irqdomain: Remove the param count
 restriction from select()
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Frank Rowand <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish Patra <atishp@atishpatra.org>,
 Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>,
 Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-3-apatel@ventanamicro.com>
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20240127161753.114685-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/01/2024 16:17, Anup Patel wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Now that the GIC-v3 callback can handle invocation with a fwspec parameter
> count of 0 lift the restriction in the core code and invoke select()
> unconditionally when the domain provides it.
> 
> Preparatory change for per device MSI domains.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---

Hi Thomas/Anup

Currently when booting the kernel against next-master(next-20240222)
with Arm64 on Qualcomm boards RB5/DB845C, the kernel is resulting in
boot failures for our CI. I can send the full logs if required. Most
other boards seem to be fine.

A bisect (full log below) identified this patch as introducing the
failure. Bisected it on the tag "next-20240220" at repo
"https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git".

This works fine on Linux v6.8-rc5


Sample log from failure against run on RB5:
------
07:03:06.985934  <6>[    1.727034] Trying to probe devices needed for
running init ...
07:03:16.905972  <6>[   11.624040] platform 998000.serial: deferred
probe pending: platform: wait for supplier
/soc@0/pinctrl@f100000/qup-uart6-default-state
07:03:16.906250  <6>[   11.636743] platform 1c08000.pcie: deferred probe
pending: platform: wait for supplier
/soc@0/pinctrl@f100000/pcie1-default-state
07:03:16.906400  <6>[   11.648976] platform a90000.serial: deferred
probe pending: (reason unknown)
07:03:16.945462  <6>[   11.656490] platform 1c10000.pcie: deferred probe
pending: platform: wait for supplier
/soc@0/pinctrl@f100000/pcie2-default-state
07:03:16.950476  <6>[   11.668723] platform c440000.spmi: deferred probe
pending: platform: supplier b220000.interrupt-controller not ready
07:03:16.950635  <6>[   11.679800] platform a6f8800.usb: deferred probe
pending: platform: supplier b220000.interrupt-controller not ready
07:03:16.950781  <6>[   11.690778] platform a8f8800.usb: deferred probe
pending: platform: supplier b220000.interrupt-controller not ready
07:03:16.950923  <6>[   11.701761] platform leds: deferred probe
pending: leds-gpio: Failed to get GPIO '/leds/led-user4'
07:03:16.989720  <6>[   11.711226] platform f100000.pinctrl: deferred
probe pending: platform: supplier b220000.interrupt-controller not ready
07:03:16.994769  <6>[   11.722567] platform 18591000.cpufreq: deferred
probe pending: qcom-cpufreq-hw: Failed to find icc paths
07:03:16.994929  <6>[   11.732573] platform
b220000.interrupt-controller: deferred probe pending: (reason unknown)
07:03:16.995076  <4>[   11.741438] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to 1d84000.ufshc
07:03:17.034092  <4>[   11.749935] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to 1d84000.ufshc
07:03:17.034331  <4>[   11.758430] qnoc-sm8250 16e0000.interconnect:
sync_state() pending due to 1d84000.ufshc
07:03:17.039326  <4>[   11.766916] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to 1dfa000.crypto
07:03:17.039482  <4>[   11.775495] qnoc-sm8250 1700000.interconnect:
sync_state() pending due to 1dfa000.crypto
07:03:17.039623  <4>[   11.784081] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to 9091000.pmu
07:03:17.039759  <4>[   11.792389] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to 90b6400.pmu
07:03:17.078467  <4>[   11.800705] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to 1d84000.ufshc
07:03:17.083560  <4>[   11.809198] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to a6f8800.usb
07:03:17.083720  <4>[   11.817508] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to a6f8800.usb
07:03:17.083866  <4>[   11.825825] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to a6f8800.usb
07:03:17.084006  <4>[   11.834140] qnoc-sm8250 16e0000.interconnect:
sync_state() pending due to a6f8800.usb
07:03:17.122721  <4>[   11.842456] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to a8f8800.usb
07:03:17.127829  <4>[   11.850766] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to a8f8800.usb
07:03:17.127989  <4>[   11.859076] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to a8f8800.usb
07:03:17.128144  <4>[   11.867388] qnoc-sm8250 16e0000.interconnect:
sync_state() pending due to a8f8800.usb
07:03:17.128286  <4>[   11.875706] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to aa00000.video-codec
07:03:17.167089  <4>[   11.884733] qnoc-sm8250 1740000.interconnect:
sync_state() pending due to aa00000.video-codec
07:03:17.172232  <4>[   11.893760] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to aa00000.video-codec
07:03:17.172404  <4>[   11.902780] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to aa00000.video-codec
07:03:17.172564  <4>[   11.911805] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to ae00000.display-subsystem
07:03:17.172705  <4>[   11.921359] qnoc-sm8250 1740000.interconnect:
sync_state() pending due to ae00000.display-subsystem
07:03:17.211346  <4>[   11.930932] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to
17300000.remoteproc
07:03:17.216527  <4>[   11.940758] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to
ae00000.display-subsystem
07:03:17.216694  <4>[   11.951113] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to
aa00000.video-codec
07:03:17.216840  <4>[   11.960935] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to 8804000.mmc
07:03:17.255721  <4>[   11.970059] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to
8300000.remoteproc
07:03:17.255962  <4>[   11.979795] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to 884000.i2c
07:03:17.261054  <4>[   11.988021] qnoc-sm8250 16e0000.interconnect:
sync_state() pending due to 884000.i2c
07:03:17.261220  <4>[   11.996242] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to 884000.i2c
07:03:17.261366  <4>[   12.004465] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to 884000.i2c
07:03:17.261506  <4>[   12.012691] qnoc-sm8250 interconnect-qup-virt:
sync_state() pending due to 884000.i2c
07:03:17.300099  <4>[   12.021008] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to 884000.i2c
07:03:17.305306  <4>[   12.030029] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to 980000.spi
07:03:17.305467  <4>[   12.038254] qnoc-sm8250 1700000.interconnect:
sync_state() pending due to 980000.spi
07:03:17.305613  <4>[   12.046479] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to 980000.spi
07:03:17.305754  <4>[   12.054705] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to 980000.spi
07:03:17.344314  <4>[   12.062927] qnoc-sm8250 interconnect-qup-virt:
sync_state() pending due to 980000.spi
07:03:17.349541  <4>[   12.071244] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to 980000.spi
07:03:17.349701  <4>[   12.080272] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to 990000.i2c
07:03:17.349846  <4>[   12.088494] qnoc-sm8250 1700000.interconnect:
sync_state() pending due to 990000.i2c
07:03:17.349986  <4>[   12.096713] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to 990000.i2c
07:03:17.388758  <4>[   12.104937] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to 990000.i2c
07:03:17.388993  <4>[   12.113158] qnoc-sm8250 interconnect-qup-virt:
sync_state() pending due to 990000.i2c
07:03:17.394156  <4>[   12.121473] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to 990000.i2c
07:03:17.394314  <4>[   12.130504] qnoc-sm8250 163d000.interconnect:
sync_state() pending due to 994000.i2c
07:03:17.394458  <4>[   12.138733] qnoc-sm8250 1700000.interconnect:
sync_state() pending due to 994000.i2c
07:03:17.394598  <4>[   12.146958] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to 994000.i2c
07:03:17.433035  <4>[   12.155179] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to 994000.i2c
07:03:17.438301  <4>[   12.163405] qnoc-sm8250 interconnect-qup-virt:
sync_state() pending due to 994000.i2c
07:03:17.438461  <4>[   12.171722] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to 994000.i2c
07:03:17.438607  <4>[   12.180742] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to 998000.serial
07:03:17.438748  <4>[   12.189235] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to 998000.serial
07:03:17.477464  <4>[   12.197719] qnoc-sm8250 interconnect-qup-virt:
sync_state() pending due to 998000.serial
07:03:17.482759  <4>[   12.206299] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to 998000.serial
07:03:17.482918  <4>[   12.215592] qnoc-sm8250 1500000.interconnect:
sync_state() pending due to a90000.serial
07:03:17.483065  <4>[   12.224084] qnoc-sm8250 9100000.interconnect:
sync_state() pending due to a90000.serial
07:03:17.483207  <4>[   12.232576] qnoc-sm8250 interconnect-qup-virt:
sync_state() pending due to a90000.serial
07:03:17.503624  <4>[   12.241158] qcom-rpmhpd
18200000.rsc:power-controller: sync_state() pending due to a90000.serial
------


Bisect log:
------
git bisect start
# good: [b401b621758e46812da61fa58a67c3fd8d91de0d] Linux 6.8-rc5
git bisect good b401b621758e46812da61fa58a67c3fd8d91de0d
# bad: [2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e] Add linux-next
specific files for 20240220
git bisect bad 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
# good: [d0427d6bc95f2dae2595859f39c2de343479c909] Merge branch
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect good d0427d6bc95f2dae2595859f39c2de343479c909
# good: [4c165a847139a6564d28e0f4d8e9fc9c67f22359] Merge branch
'for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
git bisect good 4c165a847139a6564d28e0f4d8e9fc9c67f22359
# bad: [4dfc8ee8540b799d604551c41c82a9e07089e20e] Merge branch
'tty-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
git bisect bad 4dfc8ee8540b799d604551c41c82a9e07089e20e
# bad: [1fad63263f1650f15d5bd174391a53d3e600c327] Merge branch
'rcu/next' of
git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect bad 1fad63263f1650f15d5bd174391a53d3e600c327
# bad: [0ced0254dca0bc06b09cfe31d6af411856379ea0] Merge branch into
tip/master: 'x86/vdso'
git bisect bad 0ced0254dca0bc06b09cfe31d6af411856379ea0
# good: [218b13db258c091e646857fc962ef45fe2163054] Merge branch
'x86/core' into x86/merge, to ease integration testing
git bisect good 218b13db258c091e646857fc962ef45fe2163054
# bad: [0b1902960678524b91f9ee3c94fc6561cfa1ead9] Merge branch into
tip/master: 'timers/ptp'
git bisect bad 0b1902960678524b91f9ee3c94fc6561cfa1ead9
# bad: [fa4d750326d50e3cc7801ada3d641daf14a4cb9d] Merge branch into
tip/master: 'irq/msi'
git bisect bad fa4d750326d50e3cc7801ada3d641daf14a4cb9d
# good: [9e04f6432c7ebaf33d5ce9a6e15bc544da316e54] Merge branch into
tip/master: 'irq/core'
git bisect good 9e04f6432c7ebaf33d5ce9a6e15bc544da316e54
# bad: [1a4671ff7a903e87e4e76213e200bb8bcfa942e4] platform-msi: Remove
unused interfaces
git bisect bad 1a4671ff7a903e87e4e76213e200bb8bcfa942e4
# bad: [ac81e94ab001c2882e89c9b61417caea64b800df] genirq/msi: Extend
msi_parent_ops
git bisect bad ac81e94ab001c2882e89c9b61417caea64b800df
# bad: [de1ff306dcf4546d6a8863b1f956335e0d3fbb9b] genirq/irqdomain:
Remove the param count restriction from select()
git bisect bad de1ff306dcf4546d6a8863b1f956335e0d3fbb9b
# good: [15137825100422c4c393c87af5aa5a8fa297b1f3] irqchip/gic-v3: Make
gic_irq_domain_select() robust for zero parameter count
git bisect good 15137825100422c4c393c87af5aa5a8fa297b1f3
# first bad commit: [de1ff306dcf4546d6a8863b1f956335e0d3fbb9b]
genirq/irqdomain: Remove the param count restriction from select()
------

Thanks,
Aishwarya

