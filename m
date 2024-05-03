Return-Path: <linux-kernel+bounces-167321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31E8BA7DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E08281FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4CC1474D3;
	Fri,  3 May 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMoxFuP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DE139593;
	Fri,  3 May 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721705; cv=none; b=aLfS3hptG+p+W96FiVDmXpqqAqKHIvdVnLGhd3X8HkAjKGW4qsc5wx3Y9ZkTha5OyTKdI7t7to6oB5sej+9p9IoAOdcQpKZovskHAw71yADOZCjwCroEtJVMTLWWppgN3aYymnsenLVDb3WbXRemunldoTCr1swhXlJovwwTNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721705; c=relaxed/simple;
	bh=pC91j2Fk6CmGMbzSbYOZVVJ6XRNvvhHzHeGWZQeg3vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRhPErDBApxIqRrDEDwo71f+rZ3xBzvhxtU2AKuIK/A8is1ARtvdFBjVE9ibFRmP4lWc7y+WEixg5VLaij2gesKucglVlBx7tLsCuaNganLIRcmMgmMjmDsQ/FjcFMTdYRY2EE4RB08T7orp1sUTlUg8drNfoUVRrCghY1Y7BQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMoxFuP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831F9C116B1;
	Fri,  3 May 2024 07:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714721704;
	bh=pC91j2Fk6CmGMbzSbYOZVVJ6XRNvvhHzHeGWZQeg3vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMoxFuP/8+/tBjtlxuT32p4uAwKGR5ysEaMBdK5a794d6zYEnDCNTIfJ+3in8n4ww
	 7xpS7babtCyPdelDpyEfi3++9S3duQ0FKEUpy16u1+gyRQC8d35XUOFsy3/3eg9otP
	 S/LugJbaSia3gfi5Pphf2OrBcW2LFn+HLTjrrexO6KKUm7PFWv/Tyd9QC7G/SAQroG
	 z6eNRYzg1adI/HkHmE8uVh2Iv1mUqSy72Z6va5COtp/FBs+ch0yHeVLvEG5SKfiFTj
	 2wXbsDitdFtiY5PWoVnZJPZmpJDCZDEJ4MQ13D6BFGYVDolXPyRIU56NKG1feQQbYr
	 Wg/Av3N9cjVTg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2nRh-0000000040a-1OYn;
	Fri, 03 May 2024 09:35:05 +0200
Date: Fri, 3 May 2024 09:35:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Jaiganesh Narayanan <njaigane@codeaurora.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: Fix behavior in abscense of open-drain
 support
Message-ID: <ZjSTqfxgrox0IceO@hovoldconsulting.com>
References: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com>
 <CACRpkdYw8jzFH5n377G76iMqri70Tf-1Vc=P5D6ESU_U0qRXWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYw8jzFH5n377G76iMqri70Tf-1Vc=P5D6ESU_U0qRXWQ@mail.gmail.com>

On Fri, May 03, 2024 at 09:28:41AM +0200, Linus Walleij wrote:
> On Thu, Apr 25, 2024 at 5:46 AM Bjorn Andersson
> <quic_bjorande@quicinc.com> wrote:
> 
> > When a GPIO is configured as OPEN_DRAIN gpiolib will in
> > gpiod_direction_output() attempt to configure the open-drain property of
> > the hardware and if this fails fall back to software emulation of this
> > state.
> >
> > The TLMM block in most Qualcomm platform does not implement such
> > functionality, so this call would be expected to fail. But due to lack
> > of checks for this condition, the zero-initialized od_bit will cause
> > this request to silently corrupt the lowest bit in the config register
> > (which typically is part of the bias configuration) and happily continue
> > on.
> >
> > Fix this by checking if the od_bit value is unspecified and if so fail
> > the request to avoid the unexpected state, and to make sure the software
> > fallback actually kicks in.
> >
> > It is assumed for now that no implementation will come into existence
> > with BIT(0) being the open-drain bit, simply for convenience sake.
> >
> > Fixes: 13355ca35cd1 ("pinctrl: qcom: ipq4019: add open drain support")
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> I tried to follow the discussion but couldn't get to a verdict on this patch,
> should it be applied or not, and if it should be applied, should the Fixes:
> tag be dropped or left and considered a nonurgent fix as it does not
> affect current behaviour?

It should not be applied in its current form (e.g. as the commit message
is incorrect). Bjorn will be sending a v2.

Johan

