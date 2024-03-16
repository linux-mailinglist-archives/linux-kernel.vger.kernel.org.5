Return-Path: <linux-kernel+bounces-105154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB7987D9CB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C11F21371
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C1D12B71;
	Sat, 16 Mar 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFlut+ct"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31B101CA;
	Sat, 16 Mar 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710585706; cv=none; b=GUMsVxtz6nqaKEK5L/34LoGaUOdmcRVu4wKHXnzTob0mJg5PGjFjX17ERTuDOrb47rG0wv2a0lFpbhkU/rD/e5HQaiUrqgVxSTRUpV5TVnaLPKytSvvHBNAS6Pii+wYs1k+71+NFqNg/u/y/mJAESzcMT0rwSajZGtIFRubeO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710585706; c=relaxed/simple;
	bh=VvZZEADe/yjZo+gK5HdF8YmkQc3//fHA5cwRHHUoupI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvnGIPqLUuV5gboz7j1xwNPcxoIP8S8gpkG+WHIaewi7jxV9LZro/e9HrsZR+qp0bJ+1+6JnLSXTSiS0lrS3e/zWjsM3OFpyIIRMYHBzJeUoVpk1Q39VDLuT6r4LTnqj9MrY86m59evj+cadk6mpkHfUr06MmQ7I/D8ul2tXFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFlut+ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833DBC43390;
	Sat, 16 Mar 2024 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710585705;
	bh=VvZZEADe/yjZo+gK5HdF8YmkQc3//fHA5cwRHHUoupI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFlut+ctJhF18SbVxoUKwpANag+xrSwhU4G9rzBfcB0QYShA86thiC3nc5Glm6yzq
	 A88I4dyu6EpFFc8MMNgOBgiANqAFQIqzt6dw+PzuWfk9uT8DboNr5Ih3+pL8hGk/0D
	 3kHEf9bn8jWAH7JvcO9+qkhyUAmJ/fASoargC3F9Pw6Byx2fDKF2jZ1HEyo66zNDBI
	 daOHh4ZSSgtJcV+tmA9SRNQqI61WB95M1UOnt3aFf7MEuMpheEfpfOcnVxXkpzjfCm
	 zL7tzMHLggeBLsxDCdKG1CO2sGIYvE83Pxej0LgKljGElw+pv3f0GbADAT3iUzBhjb
	 pHQRVRZR8i5DQ==
Date: Sat, 16 Mar 2024 06:41:44 -0400
From: Sasha Levin <sashal@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: stable@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH stable-6.7] soc: qcom: pmic_glink_altmode: fix drm bridge
 use-after-free
Message-ID: <ZfV3aIjuV9PDplWn@sashalap>
References: <20240308090357.8758-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240308090357.8758-1-johan+linaro@kernel.org>

On Fri, Mar 08, 2024 at 10:03:57AM +0100, Johan Hovold wrote:
>commit b979f2d50a099f3402418d7ff5f26c3952fb08bb upstream.
>
>A recent DRM series purporting to simplify support for "transparent
>bridges" and handling of probe deferrals ironically exposed a
>use-after-free issue on pmic_glink_altmode probe deferral.
>
>This has manifested itself as the display subsystem occasionally failing
>to initialise and NULL-pointer dereferences during boot of machines like
>the Lenovo ThinkPad X13s.
>
>Specifically, the dp-hpd bridge is currently registered before all
>resources have been acquired which means that it can also be
>deregistered on probe deferrals.
>
>In the meantime there is a race window where the new aux bridge driver
>(or PHY driver previously) may have looked up the dp-hpd bridge and
>stored a (non-reference-counted) pointer to the bridge which is about to
>be deallocated.
>
>When the display controller is later initialised, this triggers a
>use-after-free when attaching the bridges:
>
>	dp -> aux -> dp-hpd (freed)
>
>which may, for example, result in the freed bridge failing to attach:
>
>	[drm:drm_bridge_attach [drm]] *ERROR* failed to attach bridge /soc@0/phy@88eb000 to encoder TMDS-31: -16
>
>or a NULL-pointer dereference:
>
>	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>	...
>	Call trace:
>	  drm_bridge_attach+0x70/0x1a8 [drm]
>	  drm_aux_bridge_attach+0x24/0x38 [aux_bridge]
>	  drm_bridge_attach+0x80/0x1a8 [drm]
>	  dp_bridge_init+0xa8/0x15c [msm]
>	  msm_dp_modeset_init+0x28/0xc4 [msm]
>
>The DRM bridge implementation is clearly fragile and implicitly built on
>the assumption that bridges may never go away. In this case, the fix is
>to move the bridge registration in the pmic_glink_altmode driver to
>after all resources have been looked up.
>
>Incidentally, with the new dp-hpd bridge implementation, which registers
>child devices, this is also a requirement due to a long-standing issue
>in driver core that can otherwise lead to a probe deferral loop (see
>commit fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).
>
>[DB: slightly fixed commit message by adding the word 'commit']
>Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
>Fixes: 2bcca96abfbf ("soc: qcom: pmic-glink: switch to DRM_AUX_HPD_BRIDGE")
>Cc: <stable@vger.kernel.org>      # 6.3
>Cc: Bjorn Andersson <andersson@kernel.org>
>Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>Link: https://patchwork.freedesktop.org/patch/msgid/20240217150228.5788-4-johan+linaro@kernel.org
>[ johan: backport to 6.7 which does not have DRM aux bridge ]
>Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Queued up, thanks!

-- 
Thanks,
Sasha

