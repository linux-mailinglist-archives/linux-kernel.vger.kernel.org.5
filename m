Return-Path: <linux-kernel+bounces-150370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0C8A9E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CDC284068
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066A16C68B;
	Thu, 18 Apr 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeSevptl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361FD16ABEE;
	Thu, 18 Apr 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453149; cv=none; b=Jm86WvcOhM2vwlH3e2CMqRjXsAv8loBMk+n1Bdha7PhrthHrgf8GC9qH8uSupLNI1PWP4TGYJGpGTr1AzJ7OEI30uhl0xlDPWV1WSDhYKW0R50jFfrIShsK46OKXRi3CxzgHdA0EToa4tgHqhDnOGxwJxdMXHxKxPaYUvobr0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453149; c=relaxed/simple;
	bh=EwDk+acs40utZgqR2KMpvEatz3bas2MtIZ7ZVuGevL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewuu0t+ghb5KC/P2fHDpAqi7VnJYOQxxOxEDxLerdFOUlhOhq1sXnlCkOLC6B9WJt02Zv1w3I5vYpriv/pL5Me+ecsyzo00S/GGQacrHIEq+GILltdna3ofdczf9AFVp/e4DbWZQGJr07n3nerW0mzkR4Jx6bdb/CeOEFJEpHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeSevptl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E15C113CC;
	Thu, 18 Apr 2024 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713453148;
	bh=EwDk+acs40utZgqR2KMpvEatz3bas2MtIZ7ZVuGevL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeSevptlefNRiLs6nr2IrizdzKvBEPRi0LXFaXIzoZkqEtfTbs3hjC9rZzBhaqPDR
	 Ne4wRFifwbVdZn7uDz0CNmIzRF6sK+azDYtywG9BuHPZmizapHWzrdg8DU4VKQD8ql
	 hMAvg6FlWiGuPorvoCJQYTsX8HNrQ2wgjFrfUYnZdT+yehHZuOZoTqHLn6+Ef6oGTl
	 mAnDvcOt8Z3v9bfwDbHt2hdj5e/3BJE2B6QJ2N9qkD761sRSGxQ6L/iy/lu4TBHleq
	 DAVh8vGeeqpAEN53dnW7CZMvxC/YHclsPJzVi9WRPIadvu7+uuIVfUC6cJUDCxZVfh
	 cH7OnZ5VuJBbg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rxTR8-000000001QT-3nmZ;
	Thu, 18 Apr 2024 17:12:31 +0200
Date: Thu, 18 Apr 2024 17:12:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v3] usb: typec: qcom-pmic-typec: split HPD bridge alloc
 and registration
Message-ID: <ZiE4Xpjhv2llY4pG@hovoldconsulting.com>
References: <20240416-qc-pmic-typec-hpd-split-v3-1-fd071e3191a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-qc-pmic-typec-hpd-split-v3-1-fd071e3191a1@linaro.org>

On Tue, Apr 16, 2024 at 05:18:56AM +0300, Dmitry Baryshkov wrote:
> If a probe function returns -EPROBE_DEFER after creating another device
> there is a change of ending up in a probe deferral loop, (see commit
> fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER"). In case
> of the qcom-pmic-typec driver the tcpm_register_port() function looks up
> external resources (USB role switch and inherently via called
> typec_register_port() USB-C muxes, switches and retimers).
> 
> In order to prevent such probe-defer loops caused by qcom-pmic-typec
> driver, use the API added by Johan Hovold and move HPD bridge
> registration to the end of the probe function.
> 
> The devm_drm_dp_hpd_bridge_add() is called at the end of the probe
> function after all TCPM start functions. This is done as a way to
> overcome a different problem, the DRM subsystem can not properly cope
> with the DRM bridges being destroyed once the bridge is attached. Having
> this function call at the end of the probe function prevents possible
> DRM bridge device creation followed by destruction in case one of the
> TCPM start functions returns an error.

You're still not explaining why it is ok to move registration of the
bridge to after starting the port and pdphy.

Perhaps it's obvious to you but it should still go in the commit message
as such a change is potentially something that could end up causing
trouble (e.g. enabling interrupts before all resources have been setup
and registered).

As I've mentioned before, I'm also sceptical to papering over the DRM
issue in each and every driver registering a bridge. These late error
paths would normally not be taken, unlike the earlier ones which can be
triggered by probe deferrals and which we have to fix also for the probe
deferral loops.

> @@ -92,7 +92,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  	if (!tcpm->tcpc.fwnode)
>  		return -EINVAL;
>  
> -	bridge_dev = drm_dp_hpd_bridge_register(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
> +	bridge_dev = devm_drm_dp_hpd_bridge_alloc(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
>  	if (IS_ERR(bridge_dev))
>  		return PTR_ERR(bridge_dev);
>  
> @@ -110,6 +110,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto fwnode_remove;
>  
> +	ret = devm_drm_dp_hpd_bridge_add(tcpm->dev, bridge_dev);
> +	if (ret)
> +		goto fwnode_remove;

This is leaking resources and can lead to a use-after-free.

When looking at the driver, I noticed that the existing error handling
is already broken so I just sent a fix here:

	https://lore.kernel.org/lkml/20240418145730.4605-1-johan+linaro@kernel.org/

You should rebase on that series and not introduce further issues with
the new bridge-add error path.

> +
>  	return 0;
>  
>  fwnode_remove:

Johan

