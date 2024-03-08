Return-Path: <linux-kernel+bounces-97192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D158766B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9E71F243B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB25539C;
	Fri,  8 Mar 2024 14:51:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C11DFC5;
	Fri,  8 Mar 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909511; cv=none; b=eUEBnIkLev569OYZ34FGTDDA7msvax4ID983LQRsWdcXY74uuzE22clbm0EH5VPd+d2ng8XYRWuDQnlPfeATObz9vIr9q3R2VkISMCh5A6LFKmJEs+iX2Hdn7d5V3DvD1au0+vH+tpfn2N/T1zD8BEgiAdB04la/tvchr16mTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909511; c=relaxed/simple;
	bh=Tz6KwaY4wnYO1nF9pvINazsOvVULoLiR0sNzUkZKMvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXFSHxBK+q0UX4RQVGNHlWSd/g0oaMJ5hVSs+AU3IPyhLip2aBbTFozGoFiLzR2UyBI2tQ3rpgFXH+O06EpvVnmqwZuKgYwHorhQb/pplgFAM2eb58xf6FinMHvHYVX8X6VXyZjYtV2fwab7ppAvW/36RIcy4womAHFbFHedHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0DDC433F1;
	Fri,  8 Mar 2024 14:51:46 +0000 (UTC)
Date: Fri, 8 Mar 2024 14:51:44 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux@armlinux.org.uk, robin.murphy@arm.com,
	vanshikonda@os.amperecomputing.com, yang@os.amperecomputing.com,
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <ZesmAO1jJfEjTwxd@arm.com>
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
 <CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
 <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>

On Fri, Mar 08, 2024 at 03:01:28PM +0100, Marek Szyprowski wrote:
> This patch landed in today's linux-next as commit 0499a78369ad ("ARM64: 
> Dynamically allocate cpumasks and increase supported CPUs to 512"). 
> Unfortunately it triggers the following warning during boot on most of 
> my ARM64-based test boards. Here is an example from Odroid-N2 board:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 4 PID: 63 at drivers/opp/core.c:2554 
> dev_pm_opp_set_config+0x390/0x710
>   Modules linked in: dw_hdmi_i2s_audio meson_gxl smsc onboard_usb_hub(+) 
> rtc_pcf8563 panfrost snd_soc_meson_axg_sound_card drm_shmem_helper 
> crct10dif_ce dwmac_generic snd_soc_meson_card_utils gpu_sched 
> snd_soc_meson_g12a_toacodec snd_soc_meson_g12a_tohdmitx rc_odroid 
> snd_soc_meson_codec_glue pwm_meson ao_cec_g12a meson_gxbb_wdt meson_ir 
> snd_soc_meson_axg_frddr snd_soc_meson_axg_toddr snd_soc_meson_axg_tdmin 
> meson_vdec(C) v4l2_mem2mem videobuf2_dma_contig snd_soc_meson_axg_tdmout 
> videobuf2_memops axg_audio videobuf2_v4l2 sclk_div videodev 
> reset_meson_audio_arb snd_soc_meson_axg_fifo clk_phase dwmac_meson8b 
> stmmac_platform videobuf2_common mdio_mux_meson_g12a meson_drm 
> meson_dw_hdmi rtc_meson_vrtc stmmac meson_ddr_pmu_g12 mc dw_hdmi 
> drm_display_helper pcs_xpcs snd_soc_meson_t9015 meson_canvas gpio_fan 
> display_connector snd_soc_meson_axg_tdm_interface 
> snd_soc_simple_amplifier snd_soc_meson_axg_tdm_formatter nvmem_meson_efuse
>   hub 1-1:1.0: USB hub found
>   CPU: 4 PID: 63 Comm: kworker/u12:5 Tainted: G         C 6.8.0-rc3+ #14677
>   Hardware name: Hardkernel ODROID-N2 (DT)
>   Workqueue: events_unbound deferred_probe_work_func
>   pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : dev_pm_opp_set_config+0x390/0x710
>   lr : dev_pm_opp_set_config+0x5c/0x710
>   ...
>   Call trace:
>    dev_pm_opp_set_config+0x390/0x710
>    dt_cpufreq_probe+0x268/0x480
>    platform_probe+0x68/0xd8
>    really_probe+0x148/0x2b4
>    __driver_probe_device+0x78/0x12c
>    driver_probe_device+0xdc/0x164
>    __device_attach_driver+0xb8/0x138
>    bus_for_each_drv+0x84/0xe0
>    __device_attach+0xa8/0x1b0
>    device_initial_probe+0x14/0x20
>    bus_probe_device+0xb0/0xb4
>    deferred_probe_work_func+0x8c/0xc8
>    process_one_work+0x1ec/0x53c
>    worker_thread+0x298/0x408
>    kthread+0x124/0x128
>    ret_from_fork+0x10/0x20
>   irq event stamp: 317178
>   hardirqs last  enabled at (317177): [<ffff8000801788d4>] 
> ktime_get_coarse_real_ts64+0x10c/0x110
>   hardirqs last disabled at (317178): [<ffff800081222030>] el1_dbg+0x24/0x8c
>   softirqs last  enabled at (315802): [<ffff800080010a60>] 
> __do_softirq+0x4a0/0x4e8
>   softirqs last disabled at (315793): [<ffff8000800169b0>] 
> ____do_softirq+0x10/0x1c
>   ---[ end trace 0000000000000000 ]---
>   cpu cpu2: error -EBUSY: failed to set regulators
>   cpufreq-dt: probe of cpufreq-dt failed with error -16
> 
> It looks that cpufreq-dt and/or opp drivers needs some adjustments 
> related with this change.

That's strange. Is this with defconfig? I wonder whether NR_CPUS being
larger caused the issue with this specific code. Otherwise
CPUMASK_OFFSTACK may not work that well on arm64.

> 
> 
> > ---
> >
> >
> > Original post: https://www.spinics.net/lists/linux-mm/msg369701.html
> > V2: https://lkml.org/lkml/2024/2/7/505
> >
> >
> > V1->V2
> >
> > - Keep quotation marks
> > - Remove whiltespace damage
> > - Add tested by
> >
> > V2->V3:
> > - Add test results
> > - Rework descriptions
> >
> >
> >  arch/arm64/Kconfig | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index aa7c1d435139..4e767dede47d 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1427,7 +1427,21 @@ config SCHED_SMT
> >  config NR_CPUS
> >      int "Maximum number of CPUs (2-4096)"
> >      range 2 4096
> > -    default "256"
> > +    default "512"
> > +
> > +#
> > +# Determines the placement of cpumasks.
> > +#
> > +# With CPUMASK_OFFSTACK the cpumasks are dynamically allocated.
> > +# Useful for machines with lots of core because it avoids increasing
> > +# the size of many of the data structures in the kernel.
> > +#
> > +# If this is off then the cpumasks have a static sizes and are
> > +# embedded within data structures.
> > +#
> > +    config CPUMASK_OFFSTACK
> > +    def_bool y
> > +    depends on NR_CPUS > 256
> >
> >  config HOTPLUG_CPU
> >      bool "Support for hot-pluggable CPUs"
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

-- 
Catalin

