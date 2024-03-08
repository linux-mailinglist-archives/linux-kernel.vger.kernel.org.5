Return-Path: <linux-kernel+bounces-97289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEF87684D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC96328466C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A172D603;
	Fri,  8 Mar 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tUodAHWM"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F01F947
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914918; cv=none; b=DswfGJXCGuwNf6PTYK8yIGxVy9fbkT6Evd1FIqDj9QCsYlbgoysu/gsVcuxrXPvdh1ixl/Kw4xJqjSf9U/4YuNGnfKZ9Z7BKiVcdWK1UspZUiU+8TfGhYR4jq2z6oN/RDT802tvjqGzXHQEHph6S5+jsAXteBimueiD8m3OiZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914918; c=relaxed/simple;
	bh=0nJKefeTOc95iDkikJJQZLpDLLqSGp9s/IuOY8XANHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tIn+1N/yAe+LlPQ8kcx4xLz0ftb12hE9KMLJyVvH2q8I2Xjup2UElhy4P8/QydLeynxTvBvoPB85LNL8M5rI7lsDj091GC2LrldN6jVHSi+AfqNKr27rD+hdKPfcTmsNGZNV4KabM2sp46kQ6/n8dzXrPj/yT44K2TynCWm4DHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tUodAHWM; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240308162154euoutp029813e1c8d4394de2e62bc3aa05fdc478~61o4pZQwG0790807908euoutp02j
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:21:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240308162154euoutp029813e1c8d4394de2e62bc3aa05fdc478~61o4pZQwG0790807908euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709914914;
	bh=RFXDc45mVX70UG2/7dXvmCglH/FRdihHVKwgmbuaLD4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tUodAHWMD2wtD+7zMVH4wfuEnIivKT3kq0cnidnhUZ8JtC7Od7xn/44BllSFy5GyA
	 IOehFLDl39k/FMdZsPJuZy2WAWFFuMfc+JdKuEHhR6hZG7F7nkHePu/UXUsjPy3fj6
	 ZzAZOS4HaY48Wtzeoi+hQHp5sggo5kTJrqiBuUV8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240308162154eucas1p2a00e09b9dc65bae86fd2f80c4ddc9bb8~61o4OI1oV3141231412eucas1p24;
	Fri,  8 Mar 2024 16:21:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 80.56.09552.12B3BE56; Fri,  8
	Mar 2024 16:21:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240308162153eucas1p29a884122c14ad15af19eeb719448d32a~61o31M_9p0504405044eucas1p2E;
	Fri,  8 Mar 2024 16:21:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240308162153eusmtrp2a0d244f3d750c1b017283e582ce82c34~61o30ZWGr2554125541eusmtrp2k;
	Fri,  8 Mar 2024 16:21:53 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-52-65eb3b21ebf2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 9E.FA.09146.12B3BE56; Fri,  8
	Mar 2024 16:21:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240308162152eusmtip1e46b58962dbbda1fead1ee169d926277~61o2biBLE1203512035eusmtip1G;
	Fri,  8 Mar 2024 16:21:52 +0000 (GMT)
Message-ID: <f160a532-1d31-41a7-b8ae-de8575c395e9@samsung.com>
Date: Fri, 8 Mar 2024 17:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, Mark Rutland
	<mark.rutland@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
	Kumar <vireshk@kernel.org>, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@armlinux.org.uk,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com, Nishanth Menon <nm@ti.com>, Stephen Boyd
	<sboyd@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZesmAO1jJfEjTwxd@arm.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0wTZxjOd3e9HoSyaxH6CYWy4q+JgEYl39C4Cc7csmzqHy5zWdCunEiE
	1vRAt/0ji664UjaporXjR8kUEDsJFcExnIqEgigixUIaVMJgSCc6rKiAKfN6buO/532+53mf
	933zUbiskIyksrS5rF6rzlaRwURj+3R3gmrdX+zK0SIcldbZSfR7hwY9qTIBVF1ahqGrf/bi
	aNRfJUa1lW4SOf5wi5CruZRE9+1zIuQragOoteQyQGf672BotuoFhh69vIWhsmclOLr294gI
	+d31BGqqmMbRuGeQQBeG2kl0eHAtKjrdKX5fztjL7YBxue/gzJXreuZw24SIcdR+TzKOp2Yx
	02GZJZgLpw8yk6Megil0DYgZ50ATxvgcMVtDPg9en8FmZ+1n9UkbdgXvMVtegX31qq/cbdvz
	gS3aCCgK0mvgiytbjCCYktE1AN692SUSimcAnjz2C24EQa8LH4Am30oe84aWgjIgiKoBPP9d
	MSaIJgF8aUnisYTeAMcqnASPCXoRPGvwkwIvhZ2nRgJ8OK2EDzwWMY/DaDX0NtkCYTgth56R
	ikDPBXQC7DEcJ/gwnO4XwSNj5wIikl4FjRPGQNMgeimcHjG+MSvhoYs/4bwB0v4geOv4JVIY
	exO8fGoKE3AY9DobxAJWwLlf+TTeUACgbfbBm+IogPljHiCo1sHB7hmSvxhOvwPrmpMEeiP0
	/lAnFg4ZCgcmpMIQodDceBIXaAk8YpAJ6iXQ6jz/X+y1nl78KFBZ593FOm9/67x1rP/n2gBR
	C+RsHpeTyXKrteyBRE6dw+VpMxM1uhwHeP1fu/zOqUugxjuZ2AowCrQCSOGqBRICjbMySYb6
	629YvW6nPi+b5VpBFEWo5JLFGUpWRmeqc9m9LLuP1f/7ilFBkflY7L3q1OdE/O2HIUO3Uw4g
	q3Ht/TZwsFJR2Rex1E9HffLeWJZ00+Yl+T/rri7OKbcOcy3Fi+LCNJUpBdL63TseRy80dCaZ
	Z6IMhdwT/2zavYRSV8mKuKbNnPRjpaLzrd/kJov47qCtIeaGNrbY7kx9Vd2S1wW9ytWaQ1Tz
	wx75h7LsH2NjzianDimWxZqnJN9mbFm2IkL02QlbX8HCaLfLVBvO0F9q1jweHt8W3jDcN9qB
	9W+n3+69AWZgw6e6csv6xjQDUYR3h3wQ+sUuWbIhuS9d5o/fmDtXEqHTfPQcG097ZHpXAU+0
	+1KG4+Ou22vSa/ZHWnbvSL+o6Bh6esyqIrg96lXLcT2n/ge6a2O0HgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xu7qK1q9TDbZcVLaYs34Nm8W+E8kW
	75f1MFosnzOXyeLAs0vMFk//LWO3WLXwGpvFpsfXWC0u75rDZnFvzX9Wi8+9RxgtDk3dy2ix
	9PpFJovfy74zWbz5cZbJYu6XqcwWBz88YbX4d20ji8X2+T+ZLV7eusNisfnBMTaLljumFr1L
	TrI7iHusmbeG0ePytYvMHvsPF3m0HHnL6rFpVSebx6ZPk9g9Tsz4zeKxeUm9x8ent1g8ui/f
	YPc4fmM7k8fnTXIBPFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2Nimp
	OZllqUX6dgl6GZNm/GEs2KhUce1IaAPjAtkuRk4OCQETiT3tcxm7GLk4hASWMkp07W5igUjI
	SJyc1sAKYQtL/LnWxQZR9J5RYsvfD4wgCV4BO4nn84+DNbAIqEisbPvHBhEXlDg58wlYXFRA
	XuL+rRnsILawQKLEq+0LmEFsZgFxiVtP5jOB2CICuhIX2qawgCxgFrjOKnH93mUWiG0PGSVe
	LNoBVsUmYCjR9bYLbAOngLrEzyddUJPMJLq2djFC2PISzVtnM09gFJqF5JBZSBbOQtIyC0nL
	AkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFJZduxn5t3MM579VHvECMTB+MhRgkOZiUR
	XhaLl6lCvCmJlVWpRfnxRaU5qcWHGE2BoTGRWUo0OR+Y1vJK4g3NDEwNTcwsDUwtzYyVxHk9
	CzoShQTSE0tSs1NTC1KLYPqYODilGpg0shMlN/zL31t64JD2veBCbeau6u8sOSGTy9YXF6lG
	6v8XMJrPqvQ2Z33onRCDfXe7Is2nbO76dKGva9Y7gyNeus5rpvB9/Fum2/KBw2vGsbuJT3n/
	i18PuDArJWLipQP6s+3UTXKdjELkVLvU8jsX+vwNUTzMw8nrVjgr+8nqPu6k/aoz3iQvnyz2
	btIt/3NGDBE7VDuluhtX86Tvql9w/dzyes3y1OebGm9P3f+MUShdSH9RtY3xv31JvmftT64p
	cFDTEaxhX6Bv0XczbMYSrjL/xxYWn2qFU2w4Wk/+Zyna/pft5DJ3o7scrH7J8zNabXe1+OvP
	4Zl+/YGho6w9X9Brk9+OjyP/iCb2K7EUZyQaajEXFScCANK1Uy2zAwAA
X-CMS-MailID: 20240308162153eucas1p29a884122c14ad15af19eeb719448d32a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
	<CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
	<c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
	<ZesmAO1jJfEjTwxd@arm.com>

On 08.03.2024 15:51, Catalin Marinas wrote:
> On Fri, Mar 08, 2024 at 03:01:28PM +0100, Marek Szyprowski wrote:
>> This patch landed in today's linux-next as commit 0499a78369ad ("ARM64:
>> Dynamically allocate cpumasks and increase supported CPUs to 512").
>> Unfortunately it triggers the following warning during boot on most of
>> my ARM64-based test boards. Here is an example from Odroid-N2 board:
>>
>>    ------------[ cut here ]------------
>>    WARNING: CPU: 4 PID: 63 at drivers/opp/core.c:2554
>> dev_pm_opp_set_config+0x390/0x710
>>    Modules linked in: dw_hdmi_i2s_audio meson_gxl smsc onboard_usb_hub(+)
>> rtc_pcf8563 panfrost snd_soc_meson_axg_sound_card drm_shmem_helper
>> crct10dif_ce dwmac_generic snd_soc_meson_card_utils gpu_sched
>> snd_soc_meson_g12a_toacodec snd_soc_meson_g12a_tohdmitx rc_odroid
>> snd_soc_meson_codec_glue pwm_meson ao_cec_g12a meson_gxbb_wdt meson_ir
>> snd_soc_meson_axg_frddr snd_soc_meson_axg_toddr snd_soc_meson_axg_tdmin
>> meson_vdec(C) v4l2_mem2mem videobuf2_dma_contig snd_soc_meson_axg_tdmout
>> videobuf2_memops axg_audio videobuf2_v4l2 sclk_div videodev
>> reset_meson_audio_arb snd_soc_meson_axg_fifo clk_phase dwmac_meson8b
>> stmmac_platform videobuf2_common mdio_mux_meson_g12a meson_drm
>> meson_dw_hdmi rtc_meson_vrtc stmmac meson_ddr_pmu_g12 mc dw_hdmi
>> drm_display_helper pcs_xpcs snd_soc_meson_t9015 meson_canvas gpio_fan
>> display_connector snd_soc_meson_axg_tdm_interface
>> snd_soc_simple_amplifier snd_soc_meson_axg_tdm_formatter nvmem_meson_efuse
>>    hub 1-1:1.0: USB hub found
>>    CPU: 4 PID: 63 Comm: kworker/u12:5 Tainted: G         C 6.8.0-rc3+ #14677
>>    Hardware name: Hardkernel ODROID-N2 (DT)
>>    Workqueue: events_unbound deferred_probe_work_func
>>    pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>    pc : dev_pm_opp_set_config+0x390/0x710
>>    lr : dev_pm_opp_set_config+0x5c/0x710
>>    ...
>>    Call trace:
>>     dev_pm_opp_set_config+0x390/0x710
>>     dt_cpufreq_probe+0x268/0x480
>>     platform_probe+0x68/0xd8
>>     really_probe+0x148/0x2b4
>>     __driver_probe_device+0x78/0x12c
>>     driver_probe_device+0xdc/0x164
>>     __device_attach_driver+0xb8/0x138
>>     bus_for_each_drv+0x84/0xe0
>>     __device_attach+0xa8/0x1b0
>>     device_initial_probe+0x14/0x20
>>     bus_probe_device+0xb0/0xb4
>>     deferred_probe_work_func+0x8c/0xc8
>>     process_one_work+0x1ec/0x53c
>>     worker_thread+0x298/0x408
>>     kthread+0x124/0x128
>>     ret_from_fork+0x10/0x20
>>    irq event stamp: 317178
>>    hardirqs last  enabled at (317177): [<ffff8000801788d4>]
>> ktime_get_coarse_real_ts64+0x10c/0x110
>>    hardirqs last disabled at (317178): [<ffff800081222030>] el1_dbg+0x24/0x8c
>>    softirqs last  enabled at (315802): [<ffff800080010a60>]
>> __do_softirq+0x4a0/0x4e8
>>    softirqs last disabled at (315793): [<ffff8000800169b0>]
>> ____do_softirq+0x10/0x1c
>>    ---[ end trace 0000000000000000 ]---
>>    cpu cpu2: error -EBUSY: failed to set regulators
>>    cpufreq-dt: probe of cpufreq-dt failed with error -16
>>
>> It looks that cpufreq-dt and/or opp drivers needs some adjustments
>> related with this change.
> That's strange. Is this with defconfig? I wonder whether NR_CPUS being
> larger caused the issue with this specific code. Otherwise
> CPUMASK_OFFSTACK may not work that well on arm64.

I've used defconfig with some debug options enabled and some drivers 
compiled-in:

make ARCH=arm64 defconfig

/scripts/config -e BLK_DEV_RAM --set-val BLK_DEV_RAM_COUNT 4 --set-val 
BLK_DEV_RAM_SIZE 81920 --set-val CMA_SIZE_MBYTES 96 -e PROVE_LOCKING -e 
DEBUG_ATOMIC_SLEEP -e STAGING -e I2C_GPIO -e PM_DEBUG -e 
PM_ADVANCED_DEBUG -e USB_GADGET -e USB_ETH -e CONFIG_DEVFREQ_THERMAL -e 
CONFIG_BRCMFMAC_PCIE -e CONFIG_NFC -d ARCH_SUNXI -d ARCH_ALPINE -d 
DRM_NOUVEAU -d ARCH_BCM_IPROC -d ARCH_BERLIN -d ARCH_BRCMSTB -d 
ARCH_LAYERSCAPE -d ARCH_LG1K -d ARCH_HISI -d ARCH_MEDIATEK -d ARCH_MVEBU 
-d ARCH_SEATTLE -d ARCH_SYNQUACER -d ARCH_RENESAS -d ARCH_STRATIX10 -d 
ARCH_TEGRA -d ARCH_SPRD -d ARCH_THUNDER -d ARCH_THUNDER2 -d 
ARCH_UNIPHIER -d ARCH_XGENE -d ARCH_ZX -d ARCH_ZYNQMP -d HIBERNATION -d 
CLK_SUNXI -d CONFIG_EFI -d CONFIG_TEE -e FW_CFG_SYSFS

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


