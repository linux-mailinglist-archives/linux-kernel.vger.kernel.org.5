Return-Path: <linux-kernel+bounces-158489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D08B20D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4CC1F24F19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302212BE86;
	Thu, 25 Apr 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssZnt+F6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9884E0E;
	Thu, 25 Apr 2024 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046535; cv=none; b=LcW0FfjMglvyzK+P9A/2sz74AdHpYZmk5W23chi8/ocY6Zr0YqfEc3pSE8wNWy3kC8V0qKfSzW2l1Hh5Y8t3sghl9iw9AGYZabyX1rF85fUULVADoEXJZ88FPHWoxqh9l2YDE15UsooloBDRSMfP8wiqa1D1SNyEtIeIUDrwFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046535; c=relaxed/simple;
	bh=IsokxEzMjspQdJ6vbgSWEZO+bwVScekTaycFJ/Dr5nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FadfTfHAfGLJboiZmGniFIpW3JDMjvoVp1tz97fGMXMJCyqZ0CPWQZF0JgxOdvuxheheGOuFau418tbZWUudqyLz1xiDV2tSKpulI37YCX5Vw+G/cH5wyyPuOEl5NecqKd6V3iKZiqwyOv7BRzk+Im4hqxuajuZG6lxafkPjaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssZnt+F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D7DC113CC;
	Thu, 25 Apr 2024 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714046534;
	bh=IsokxEzMjspQdJ6vbgSWEZO+bwVScekTaycFJ/Dr5nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssZnt+F6c5C7fMP2Rv+zpjBsDZUzPNNQxiUU3+aKm/gMy76wi/kViatVTn0CwizWF
	 GKQmIY/KZtpsqcd3hGGWRqVBKFxKqfg/qhEFgvkPtoQ1Ivpaij54PeyWnWD86GOw+a
	 ETQQ/q97VlYlkalLlE2f1QK8rzoFmCIfRROFKBF8GkTtOEAtg3pTvxbwd7F6CjYsDs
	 wYIImnz+C3zwgR/vFCMBBUwSGAHZyw9Ar48HwrAeH/dS3xzUEh87u1PeUlPfub/0qb
	 ADx988KGvC5r/QxV6gr3xd8jHidY7Afv0fAUZA3fRMj9svI5UE6nozaR80ECjOqEnn
	 GH0q3p3x2sheA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzxnq-000000001yQ-0MAo;
	Thu, 25 Apr 2024 14:02:14 +0200
Date: Thu, 25 Apr 2024 14:02:14 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Jaiganesh Narayanan <njaigane@codeaurora.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: Fix behavior in abscense of open-drain
 support
Message-ID: <ZipGRl_QC_x83MFt@hovoldconsulting.com>
References: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com>

On Wed, Apr 24, 2024 at 08:45:31PM -0700, Bjorn Andersson wrote:
> When a GPIO is configured as OPEN_DRAIN gpiolib will in
> gpiod_direction_output() attempt to configure the open-drain property of
> the hardware and if this fails fall back to software emulation of this
> state.
> 
> The TLMM block in most Qualcomm platform does not implement such
> functionality, so this call would be expected to fail. But due to lack
> of checks for this condition, the zero-initialized od_bit will cause
> this request to silently corrupt the lowest bit in the config register
> (which typically is part of the bias configuration) and happily continue
> on.
> 
> Fix this by checking if the od_bit value is unspecified and if so fail
> the request to avoid the unexpected state, and to make sure the software
> fallback actually kicks in.

Fortunately, this is currently not a problem as the gpiochip driver does
not implement the set_config() callback, which means that the attempt to
change the pin configuration currently always fails with -ENOTSUP (see
gpio_do_set_config()).

Specifically, this means that the software fallback kicks in, which I
had already verified.

Now, perhaps there is some other path which can allow you to end up
here, but it's at least not via gpiod_direction_output().

The msm pinctrl binding does not allow 'drive-open-drain' so that path
should also be ok unless you have a non-conformant devicetree.

> It is assumed for now that no implementation will come into existence
> with BIT(0) being the open-drain bit, simply for convenience sake.
> 
> Fixes: 13355ca35cd1 ("pinctrl: qcom: ipq4019: add open drain support")

I guess hardware open-drain mode has never been properly tested on
ipq4019.

> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 2 ++
>  drivers/pinctrl/qcom/pinctrl-msm.h | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index aeaf0d1958f5..329474dc21c0 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -313,6 +313,8 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
>  			*mask |= BIT(g->i2c_pull_bit) >> *bit;
>  		break;
>  	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +		if (!g->od_bit)
> +			return -EOPNOTSUPP;

I believe this should be -ENOTSUPP, which the rest of the driver and
subsystem appear to use.

>  		*bit = g->od_bit;
>  		*mask = 1;
>  		break;

Johan

