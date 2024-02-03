Return-Path: <linux-kernel+bounces-50803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45E847E10
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F81BB29ABD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53A215AC;
	Sat,  3 Feb 2024 01:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xHdRFkvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145210E6;
	Sat,  3 Feb 2024 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706922832; cv=none; b=i8SPQjHqwGOBFVdcYvGToIpc1dds0ofLz4lpLKwapCVvuAIGdTpbaAoEPQQd7jsZ5YSv8K8detaaESrl8lIM3ZV1Kiwgo7eovyiKlCa2R83hePokYJu0IzhNfTCh60lZJtr6TPSKwXU7BwTLrSdbGa0j/38+Reuc6+eExrjjTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706922832; c=relaxed/simple;
	bh=Mki4G/PAWSDHRLxwPPWCIKxidm5+6SE37JqhA10oRt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYwXG8xTmImR91c0n+IlhAQHvb8LuY8d2xptrtNaNPIwAm9SqSEfub+EecjhUvZMQXBx5NHTsenI8akSzhhcIkVQpkWxd8v/2PvrBjeXilEexcHcV63rH9MPKNV4FqEGmNYQpdPtrtgvpnYcgrmxdTWWqoRpVJolQg2lFEMQasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xHdRFkvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC9BC433F1;
	Sat,  3 Feb 2024 01:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706922831;
	bh=Mki4G/PAWSDHRLxwPPWCIKxidm5+6SE37JqhA10oRt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xHdRFkvALtklBzwDpKYAuY9ZrQ9J5QHzb3UQy25GSUmTVycjAOJLmt2V6tWFoaq+k
	 nZPfGZnEKbVSfuImC+mFY5NURYLZVFQRVLaWbOwfTFT09HaEFh4ytR607V2wdv2xAO
	 iYd04AbNIA64BFNP9BynIJ7msWxSR3lDOQxQHKAs=
Date: Fri, 2 Feb 2024 17:13:50 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: kovalev@altlinux.org
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, u.kleine-koenig@pengutronix.de,
	a.firago@yadro.com, sashal@kernel.org, zhuning0077@gmail.com,
	tiwai@suse.com, perex@perex.cz, broonie@kernel.org,
	lgirdwood@gmail.com
Subject: Re: [PATCH 6.1.y 0/7] ASoC: codecs: es8326: fix support
Message-ID: <2024020205-suffering-paparazzi-8a49@gregkh>
References: <20240130094708.290485-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094708.290485-1-kovalev@altlinux.org>

On Tue, Jan 30, 2024 at 12:47:01PM +0300, kovalev@altlinux.org wrote:
> These patches were backported from v6.6 upstream and
> are intended for 6.1.y stable kernel.
> 
> Patches have been successfully tested on the latest 6.1.75 kernel.
> 
> [PATCH 6.1.y 1/7] ASoC: codecs: es8326: Convert to i2c's .probe_new()
> [PATCH 6.1.y 2/7] ASoC: codecs: ES8326: Add es8326_mute function
> [PATCH 6.1.y 3/7] ASoC: codecs: ES8326: Change Hp_detect register names
> [PATCH 6.1.y 4/7] ASoC: codecs: ES8326: Change Volatile Reg function
> [PATCH 6.1.y 5/7] ASoC: codecs: ES8326: Fix power-up sequence
> [PATCH 6.1.y 6/7] ASOC: codecs: ES8326: Add calibration support for
> [PATCH 6.1.y 7/7] ASoC: codecs: ES8326: Update jact detection function
> 
> 

What exactly is being "fixed" here?  Was the driver not working properly
in 5.15?  What broke in 6.1?  Or has this hardware just never worked?

These all don't seem to be fixes, so what is the need for these?

confused,

greg k-h

