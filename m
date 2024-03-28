Return-Path: <linux-kernel+bounces-123401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C458890808
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1945B22F26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43DC12F5B1;
	Thu, 28 Mar 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpLVOni3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F1446A4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649511; cv=none; b=Gdnz/+K48+ZSFfLBLX5gEsj/Zn5qsB+CLS+lEN4mBp0WtDTFeX8kWGT2Lpk6rlS5rYrqc1m1UPXc3scEk0c0I3dbqkFpki2fNkItVGNBpyy77DiyCrArZ9x8xViDuGXfqjBy8EMM9/cTjIODxMkSFE74JTQjWCtqAz0EcDRQDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649511; c=relaxed/simple;
	bh=8ERlPwQRmltkadYzho+Rro39TG8es6t+TgCTY0LtOY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT3cfmQwmtp2krWMoHgDe23tBBwdeaExijP1b46C6HobTj10hKbBSaPr/5qesAFNUtf7iw+Zxenpj/sBTpXb8KsQOQUmAWn8ma9vuEIWO4hhjdKFGQoOgJMsKWXbBdt0VAmGvqwJTtDwcAPg2JPqQ6xEwY4yWzVmoorfbPwZof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpLVOni3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7525FC433C7;
	Thu, 28 Mar 2024 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649510;
	bh=8ERlPwQRmltkadYzho+Rro39TG8es6t+TgCTY0LtOY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GpLVOni31qJBk2L7atKQfrCiSYuR67xOjIwCmPeg0B1vT1WPl4D+M6ICz8XoV4YD+
	 MCrreMSwGr+6u8xWzxQefYw+DNczGXnI1vpaueOnYaA1+kkXEx0M3aUQ+B1Kj44js8
	 3AaWMo5G/LAIWZGdiX4Y//OKXgbZO6vnmBz3UJqbNNxvRqOnYFYajNiWsWuQcNUNNE
	 zOcEpUZMH1TVeWdSnkOOCdQG1zyZK0s81fcJpC5oYU2NdBbptGXTbWVR4oXiM8H/Dr
	 NJ7HA6qv7qtBTyx7CDm6yWBNRQya2fC4BW74QLgsCRVbeNUp6Iq9xwgOUuleIwIvPA
	 J+6/jMRG4qrTA==
Date: Thu, 28 Mar 2024 23:41:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] soundwire: amd: fix for wake interrupt handling for
 clockstop mode
Message-ID: <ZgWy4M8nr7IFqpoa@matsya>
References: <20240327063143.2266464-1-Vijendar.Mukunda@amd.com>
 <20240327063143.2266464-2-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327063143.2266464-2-Vijendar.Mukunda@amd.com>

On 27-03-24, 12:01, Vijendar Mukunda wrote:
> When SoundWire Wake interrupt is enabled along with SoundWire Wake
> enable register, SoundWire wake interrupt will be reported
> when SoundWire manager is in D3 state and ACP is in D3 state.
> 
> When SoundWire Wake interrupt is reported, it will invoke runtime
> resume of the SoundWire manager device.
> 
> In case of system level suspend, for ClockStop Mode SoundWire Wake
> interrupt should be disabled.
> It should be enabled only for runtime suspend scenario.
> Change wake interrupt enable/disable sequence for ClockStop Mode in
> system level suspend and runtime suspend sceanrio.
> 
> Fixes: 9cf1efc5ed2d ("soundwire: amd: add pm_prepare callback and pm ops support")
> 

no empty line b/w fixes and s-o-b line please

I have fixed it up while applying
Also, fixes should be first patch followed by other changes...

> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  drivers/soundwire/amd_manager.c | 15 +++++++++++++++
>  drivers/soundwire/amd_manager.h |  3 ++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 1066d87aa011..20d94bcfc9b4 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -129,6 +129,19 @@ static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
>  	writel(frame_size, amd_manager->mmio + ACP_SW_FRAMESIZE);
>  }
>  
> +static void amd_sdw_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
> +{
> +	u32 wake_ctrl;
> +
> +	wake_ctrl = readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +	if (enable)
> +		wake_ctrl |= AMD_SDW_WAKE_INTR_MASK;
> +	else
> +		wake_ctrl &= ~AMD_SDW_WAKE_INTR_MASK;
> +
> +	writel(wake_ctrl, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +}
> +
>  static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, struct sdw_msg *msg,
>  				  int cmd_offset)
>  {
> @@ -1094,6 +1107,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
>  	}
>  
>  	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> +		amd_sdw_wake_enable(amd_manager, false);
>  		return amd_sdw_clock_stop(amd_manager);
>  	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
>  		/*
> @@ -1120,6 +1134,7 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
>  		return 0;
>  	}
>  	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> +		amd_sdw_wake_enable(amd_manager, true);
>  		return amd_sdw_clock_stop(amd_manager);
>  	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
>  		ret = amd_sdw_clock_stop(amd_manager);
> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
> index 418b679e0b1a..707065468e05 100644
> --- a/drivers/soundwire/amd_manager.h
> +++ b/drivers/soundwire/amd_manager.h
> @@ -152,7 +152,7 @@
>  #define AMD_SDW0_EXT_INTR_MASK		0x200000
>  #define AMD_SDW1_EXT_INTR_MASK		4
>  #define AMD_SDW_IRQ_MASK_0TO7		0x77777777
> -#define AMD_SDW_IRQ_MASK_8TO11		0x000d7777
> +#define AMD_SDW_IRQ_MASK_8TO11		0x000c7777
>  #define AMD_SDW_IRQ_ERROR_MASK		0xff
>  #define AMD_SDW_MAX_FREQ_NUM		1
>  #define AMD_SDW0_MAX_TX_PORTS		3
> @@ -190,6 +190,7 @@
>  #define AMD_SDW_CLK_RESUME_REQ				2
>  #define AMD_SDW_CLK_RESUME_DONE				3
>  #define AMD_SDW_WAKE_STAT_MASK				BIT(16)
> +#define AMD_SDW_WAKE_INTR_MASK				BIT(16)
>  
>  static u32 amd_sdw_freq_tbl[AMD_SDW_MAX_FREQ_NUM] = {
>  	AMD_SDW_DEFAULT_CLK_FREQ,
> -- 
> 2.34.1

-- 
~Vinod

