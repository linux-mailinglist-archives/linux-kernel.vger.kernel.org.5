Return-Path: <linux-kernel+bounces-82934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02354868BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EA01C22650
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4CB13664F;
	Tue, 27 Feb 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKVeki77"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C178130E48;
	Tue, 27 Feb 2024 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025308; cv=none; b=ppUbLS5rpfdql+IfsCKJ5ZyEJGnwQCxRdMQfy7LbURo5wYBSBWVcFTyNWz1lFBUIO9qo/ZUZ/uSKItyFQGzr+3Rdf4HzPMe6EvJ55V9JjYYIBvyzpXIPLq2xG1gk3JOqpvb1vvz+DF5CAjQQIIL06IAJVi2EYNOwVovugoIFu1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025308; c=relaxed/simple;
	bh=OjwlO1YDIYRy2SrU90fAQgq6NHCYBwyxJt2f+KcNtUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsZ0oruiiCMUiK3ilVJzswVF2zXGYOL6paw7t0MqStvSXmvKdKBvfIy7eRYZNcFibtmHlqgljoWyRRFuhUe363ySNThiUoh1eg070WJ70xyBVckXKnvm6MhKikPYvr1aHu+bmyYArFKrQnhxg+Qpotd/o68dpEqUDkRIYVqf3ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKVeki77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94890C43390;
	Tue, 27 Feb 2024 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709025307;
	bh=OjwlO1YDIYRy2SrU90fAQgq6NHCYBwyxJt2f+KcNtUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKVeki77rVnHBhTizyjJFkV+SqRRaZV1Ft/Z+fFec6r7poZ2WxeUrCRv67YodSdAJ
	 pnhBgltU5E7qXPC7vEGJQhshGWvkyYPVPNbVRhFonwy0R7i080d4Q3dksc5shCYqvH
	 x9p48CUo3ubQGj/60Y13ibsALWAdB1BOrikLQf4OoEamco5Gu/1FZyw9kuG7jEhAuN
	 HSvA7+HEOJoHD2jSqch6p/BaOz8xI6YvCqlxCzGs137q56sxVtKT87mrpsF2Xprozo
	 hGCZzuC6f61qsG7Es55nX4/kITIHriS1GMcMIooQPxiOqS5dFkXgS0opf1XPmLIJRg
	 n9axIMimTE07Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1retYM-000000002Uu-0Zij;
	Tue, 27 Feb 2024 10:15:10 +0100
Date: Tue, 27 Feb 2024 10:15:10 +0100
From: Johan Hovold <johan@kernel.org>
To: quic_bjorande@quicinc.com
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
Message-ID: <Zd2oHl0cVQr3mhmd@hovoldconsulting.com>
References: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>

On Mon, Feb 26, 2024 at 05:49:57PM -0800, Bjorn Andersson via B4 Relay wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> Commit 'e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable
> the domain")' aimed to make sure that a power-domain that is being
> enabled without any particular performance-state requested will at least
> turn the rail on, to avoid filling DeviceTree with otherwise unnecessary
> required-opps properties.
> 
> But in the event that aggregation happens on a disabled power-domain, with
> an enabled peer without performance-state, both the local and peer
> corner are 0. The peer's enabled_corner is not considered, with the
> result that the underlying (shared) resource is disabled.
> 
> One case where this can be observed is when the display stack keeps mmcx
> enabled (but without a particular performance-state vote) in order to
> access registers and sync_state happens in the rpmhpd driver. As mmcx_ao
> is flushed the state of the peer (mmcx) is not considered and mmcx_ao
> ends up turning off "mmcx.lvl" underneath mmcx. This has been observed
> several times, but has been painted over in DeviceTree by adding an
> explicit vote for the lowest non-disabled performance-state.
> 
> Fixes: e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the domain")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZdMwZa98L23mu3u6@hovoldconsulting.com/
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> This issue is the root cause of a display regression on SC8280XP boards,
> resulting in the system often resetting during boot. It was exposed by
> the refactoring of the DisplayPort driver in v6.8-rc1.

This fixes the hard resets I've been seeing since rc1 when initialising
the display subsystem of the Lenovo ThinkPad X13s at boot. With some
instrumentation added I can see the resets coinciding with the call to
rpmhpd_aggregate_corner() for 'mx_ao':

Tested-by: Johan Hovold <johan+linaro@kernel.org>

