Return-Path: <linux-kernel+bounces-78475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D468613E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69AF285AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B17980629;
	Fri, 23 Feb 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R70UCjWs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FE6FBF;
	Fri, 23 Feb 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698109; cv=none; b=IqQ1Dds2g4ZV6wp8i+NlapcfEny69ow2tddvAFtW7sBKeGt5cifPCVqb+DH881rEHdLHSEvWPngnO+68ZKIMLkiIrEBskY9a5xWn22dCERPoeEyJG5THPBospB7Q36fU1pPRKaxMxtGm0TV9bfMkEwFfpkxb3YN9YNG8gmF01d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698109; c=relaxed/simple;
	bh=GITjPyU/6jMigNK1ZyHILoVv5+gvdYxOZ3RVFKuYVnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFC0QDXisdmynj/uMu9jxjXLhcUe/qg0X/OYvDwITHRIKRHptiMqANevQkZ5fYVbfgF6l1Rh4LyQXuYpkAObgL+1pN4mwGdRJmz5v3I5uvn9YLTXrFAN78who2paO3yuNjPCZhP/7wcw4WY0ed3tXVdZsS8TR3ze+GOA8SgAZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R70UCjWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57609C433F1;
	Fri, 23 Feb 2024 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708698109;
	bh=GITjPyU/6jMigNK1ZyHILoVv5+gvdYxOZ3RVFKuYVnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R70UCjWsObGZG+ZlxvBs/p61UxvAVIj7WCPF5uyACsIXigriAX/Dlyujzz4nH5ypC
	 ZDmO3qy3nKPkFppx93FrOxndf+Lm34+jHBQ/8b2CWUUHl2RZ2SQfA79difCwrRhMtH
	 o/RNHlz7JNNXwLZ3ubgnF+w9lzR22xIytIwlVKI/v7yvMKDUCijOzSYblko9ZH6SkK
	 +8j6nD1GoYy9hMo7Baa9Kt6VAWua57q/uKEa//W3g6iiEwfttlPqUjsUD3Ak1A/PWw
	 UoAvrzA++iA7xtRy2iSkaBmxfGPhITxlbPUISjcA53bsUXQfRCqOOL+s/eZa3dzDEO
	 Zzpxz26ASeXYw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rdWQy-000000004u4-2RdT;
	Fri, 23 Feb 2024 15:21:53 +0100
Date: Fri, 23 Feb 2024 15:21:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm bridge
 use-after-free
Message-ID: <ZdiqAPPTn9SvsjL8@hovoldconsulting.com>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <170868613914.4029284.5549880672870201262.b4-ty@linaro.org>
 <3c4246b6-431a-442e-8ace-3b0d0e67743f@linaro.org>
 <ZdiU2z8rzo542_Ih@hovoldconsulting.com>
 <d4049823-ad24-4426-887b-9c66cdd96318@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4049823-ad24-4426-887b-9c66cdd96318@linaro.org>

On Fri, Feb 23, 2024 at 02:52:28PM +0100, Neil Armstrong wrote:
> On 23/02/2024 13:51, Johan Hovold wrote:
> > On Fri, Feb 23, 2024 at 12:03:10PM +0100, Neil Armstrong wrote:
> >> On 23/02/2024 12:02, Neil Armstrong wrote:

> >>> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)
> >>>
> >>> [1/6] drm/bridge: aux-hpd: fix OF node leaks
> >>>         https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9ee485bdda68d6d3f5728cbe3150eb9013d7d22b
> >>> [2/6] drm/bridge: aux-hpd: separate allocation and registration
> >>>         (no commit info)
> >>> [3/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
> >>>         (no commit info)
> >>> [4/6] soc: qcom: pmic_glink: Fix boot when QRTR=m
> >>>         (no commit info)
> >>> [5/6] phy: qcom-qmp-combo: fix drm bridge registration
> >>>         (no commit info)
> >>> [6/6] phy: qcom-qmp-combo: fix type-c switch registration
> >>>         (no commit info)
> >>>
> >>
> >> To clarify, I only applied patch 1 to drm-misc-fixes
> > 
> > Ok, but can you please not do that? :)
> > 
> > These patches should go in through the same tree to avoid conflicts.
> > 
> > I discussed this with Bjorn and Dmitry the other day and the conclusion
> > was that it was easiest to take all of these through DRM.
> 
> I only applied patch 1, which is a standalone fix and goes into a separate tree,
> for the next patches it would be indeed simpler for them to go via drm-misc when
> they are properly acked.

But it is *not* standalone as I tried to explain above.

So you have to drop it again as the later patches depend on it and
cannot be merged (through a different tree) without it.

I thought you had all the acks you needed to take this through drm-misc,
but we can wait a bit more if necessary (and there's no rush to get the
first one in).

Johan

