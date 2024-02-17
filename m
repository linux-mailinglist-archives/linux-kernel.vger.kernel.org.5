Return-Path: <linux-kernel+bounces-69935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BE859079
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48ABB2113D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362B87C6C6;
	Sat, 17 Feb 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU23ssNV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11369DE6;
	Sat, 17 Feb 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708183330; cv=none; b=fMDwNxEyhQ1o2t7anIQe+HqEL4bNNAmnNQsY6T2Uy8WyLUvJ4xuZTmJTu8XCaAFi95sBnxHAD7IyzkDdJH5ehwrIGGu20wVctlu9v+eea6WedfYaKqFg3kD/BHUtGU3vvhbIoqOOcrTAo/8RE5z83tfh93nkPOYyla9nnlpBfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708183330; c=relaxed/simple;
	bh=pnmjMtj6LUKSLk2ge6TNKEdB5HeEr+uuqdYKp1VAbK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ6N4XHCxmzPPh5nbBUcCIqcvDggv1XOpJbOTXMQBaiknBR3YF8qnp+Y5M75z2gW7tOsHCDU7AjgZ/yevnYXpCKBih58zTerph9WdEiTwLS5Q/bmDK76cZj73bjWAxsvqrJ7HQo0KKOxcaibTEZ1sAFzruxOV/l++9+QbrklI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU23ssNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BC7C433F1;
	Sat, 17 Feb 2024 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708183330;
	bh=pnmjMtj6LUKSLk2ge6TNKEdB5HeEr+uuqdYKp1VAbK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DU23ssNVRNEU/rAOjwOWef06YUBznmP6qaEPZeRmZHrV+pGneYJCIWEwsOnaXllcZ
	 tDfuHD234Qh/hGc/luVN4cqfJwpbk/AYuM/X//gxknluCTgMjU9csI8zjoG7VFd9y+
	 HSmx8CkAlukSPWwOsN2vvH1E4odRYx94ztQwk2y1wbP7Hr8temgVUKtC9SgaJjAI5B
	 BaG7OFD1ODbbyG3/JXRe+jL1T8vjq3ju4f2V66sndaPIcNTjE2wq6FZGxM2bpbEGnJ
	 ESmQ52WVUFg4ui4nPnUwdmsQBhq6hCY8Xw+XoaCj+wDat6PWn6val5QyD5Sqjh9A8B
	 1dJdW88kRPXKw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rbMW1-000000001dK-0sfA;
	Sat, 17 Feb 2024 16:22:09 +0100
Date: Sat, 17 Feb 2024 16:22:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: drm/msm: DisplayPort regressions in 6.8-rc1
Message-ID: <ZdDPISS5ntrWSPf_@hovoldconsulting.com>
References: <ZctVmLK4zTwcpW3A@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZctVmLK4zTwcpW3A@hovoldconsulting.com>

On Tue, Feb 13, 2024 at 12:42:17PM +0100, Johan Hovold wrote:

> Since 6.8-rc1 the internal eDP display on the Lenovo ThinkPad X13s does
> not always show up on boot.
> 
> The logs indicate problems with the runtime PM and eDP rework that went
> into 6.8-rc1:
> 
> 	[    6.007872] [drm:drm_bridge_attach [drm]] *ERROR* failed to attach bridge /soc@0/phy@88eb000 to encoder TMDS-31: -16
	
> and this can also manifest itself as a NULL-pointer dereference:
> 
> 	[    7.339447] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> 	
> 	[    7.643705] pc : drm_bridge_attach+0x70/0x1a8 [drm]

#regzbot ^introduced: 2bcca96abfbf

It looks like it may have been possible to hit this also before commit
2bcca96abfbf ("soc: qcom: pmic-glink: switch to DRM_AUX_HPD_BRIDGE") and
the transparent bridge rework in 6.8-rc1 even if that has not yet been
confirmed.

The above is what made this trigger since 6.8-rc1 however.

Johan

