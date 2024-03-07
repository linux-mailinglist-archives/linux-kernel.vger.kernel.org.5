Return-Path: <linux-kernel+bounces-96122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668DF875761
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DAF28840D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4461EB56;
	Thu,  7 Mar 2024 19:40:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021C13698E;
	Thu,  7 Mar 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840436; cv=none; b=MKUeI/VJUJ61Q2ElwSedj8sJrNT1z4EQpBleKDf9jNs5aGkwGhzfbjv5pVhrJpkO4kSNYVOl420461QIC+KkZ8UN4lDUZQHffHddePRo4sjO9S+8a+jTximLz+aXmVvYchL3EiVHWayMA4hS+lCIGuLt9/c1y3d5tWt8J6IylyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840436; c=relaxed/simple;
	bh=exgzNA5Z6fXpJJJVKs7Evqn4MiTn4VUh1/o9dYksI7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THDabZIxc0UaNaII8RUAjWUMhdMtkX3uUlbi/FdeCze6yY6Z0FxrDoL9l//HVRDRDAi9+e+kINyqihuTnWgnTv88CckGJeTZwjkZo4Z7pwIIGKhGqOAiPEAbg+L3Lvt0ceNSldbcXEzfTz2xzioDC3qIS45s+37STvumFvkvm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9751B1FB;
	Thu,  7 Mar 2024 11:41:09 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.70.143])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BE883F762;
	Thu,  7 Mar 2024 11:40:29 -0800 (PST)
Date: Thu, 7 Mar 2024 19:40:26 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Message-ID: <20240307194026.GA355455@e130802.arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
 <ZeYWKVpeFm1+4mlT@p14s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeYWKVpeFm1+4mlT@p14s>

Hi Mathieu,

> > +	do {
> > +		state_reg = readl(priv->reset_cfg.state_reg);
> > +		*rst_ack = EXTSYS_RST_ST_RST_ACK(state_reg);
> > +
> > +		if (*rst_ack == EXTSYS_RST_ACK_RESERVED) {
> > +			dev_err(dev, "unexpected RST_ACK value: 0x%x\n",
> > +				*rst_ack);
> > +			return -EINVAL;
> > +		}
> > +
> > +		/* expected ACK value read */
> > +		if ((*rst_ack & exp_ack) || (*rst_ack == exp_ack))
> 
> I'm not sure why the second condition in this if() statement is needed.  As far
> as I can tell the first condition will trigger and the second one won't be
> reached.

The second condition takes care of the following: exp_ack and  *rst_ack are both 0.
This case happens when RST_REQ bit is cleared (meaning: No reset requested) and
we expect the RST_ACK to be 00 afterwards.

> > +/**
> > + * arm_rproc_load() - Load firmware to memory function for rproc_ops
> > + * @rproc: pointer to the remote processor object
> > + * @fw: pointer to the firmware
> > + *
> > + * Does nothing currently.
> > + *
> > + * Return:
> > + *
> > + * 0 for success.
> > + */
> > +static int arm_rproc_load(struct rproc *rproc, const struct firmware *fw)
> > +{
> 
> What is the point of doing rproc_of_parse_firmware() if the firmware image is
> not loaded to memory?  Does the remote processor have some kind of default ROM
> image to run if it doesn't find anything in memory?

Yes, the remote processor has a default FW image already loaded by default.

rproc_boot() [1] and _request_firmware() [2] fail if there is no FW file in the filesystem or a filename
provided.

Please correct me if I'm wrong.

[1]: https://elixir.bootlin.com/linux/v6.8-rc7/source/drivers/remoteproc/remoteproc_core.c#L1947
[2]: https://elixir.bootlin.com/linux/v6.8-rc7/source/drivers/base/firmware_loader/main.c#L863

> > +module_platform_driver(arm_rproc_driver);
> > +
> 
> I am echoing Krzysztof view about how generic this driver name is.  This has to
> be related to a family of processors or be made less generic in some way.  Have
> a look at what TI did for their K3 lineup [1] - I would like to see the same
> thing done here.

Thank you, I'll take care of that and of all the other comments made.

Cheers,
Abdellatif

