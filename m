Return-Path: <linux-kernel+bounces-118879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9B688C092
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BF73028AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489C15490B;
	Tue, 26 Mar 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+KMsQbL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB554747;
	Tue, 26 Mar 2024 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452258; cv=none; b=lBfvOoNXJGQ3amvwDIrrW+1Fe67c2y2frYSeNMWYOLexgerMIZKMDO4EssTqrRCtaTYz/6/Y88H/y+FItzYiXFSwSnQMy17sg8f+ZLbHFFpjQwJlhTWdD1I+omZZrSLSLqdwwfp3oEu+Q+xyCz1HKMPJ8ig6+Lcbb5+esyBORWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452258; c=relaxed/simple;
	bh=/ts1oCHhFSvAZEWne9JqXlu4VYc85iEvBKm2ILjRmrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPB4OD4osyTEnLV0mBpFvcKShNLsvCNtYh6BDUMqZ0zyUk2XOrO8zlnxHeuXx9/6Fbw8fWchKh4c50A5v7OsAVC40Oz2y1AkRDQMGfPA7fmjTYDHg0PweX+PhT/9CyHwD1fxb5GIhtNnGb+F/n63Si00FfOOlQ4vrOBil7S29vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+KMsQbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81402C433C7;
	Tue, 26 Mar 2024 11:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452258;
	bh=/ts1oCHhFSvAZEWne9JqXlu4VYc85iEvBKm2ILjRmrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+KMsQbLe3QIgj367MyWgv5P+1m7BI409Cx0JKMdxTjjk5QhEW2B3KaJkihe0bmLW
	 WLiEOQlpW66lXG0o6R7AGmD80bKx22DlVkkbFi4s5gj3XQPEt/Iq0iCQT0iyhZxpiw
	 kfaegRebyCd7Uu5rxm919wVgcFqWotqoE26ookthJCTVj+f8ErZyqOogHqEnfX+Rc/
	 KIZtzfdavI2Qpf1PDxS5zB8rjpa1IHATwtBgBZ1i763/X+TEbEtmfkNZm4Zme6N08j
	 /Mn7yzDwcDsK5LJbnA6jBAmrgGYjpUzMCZQ8NgmQy8fbtuB/4WVU/ep46gJaR8gMeH
	 3xVkZnPGT5wuA==
Date: Tue, 26 Mar 2024 11:24:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
Message-ID: <6d9fdecc-c420-4247-88a6-1c1f98fd3fee@sirena.org.uk>
References: <20240325081957.10946-1-johan+linaro@kernel.org>
 <9b2a7e9f-dbb2-4acb-91a7-fcc64d5cfabd@sirena.org.uk>
 <ZgJ2QHCYI4wfmfcr@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hc8gQ3lqQskYPlfA"
Content-Disposition: inline
In-Reply-To: <ZgJ2QHCYI4wfmfcr@hovoldconsulting.com>
X-Cookie: Equal bytes for women.


--Hc8gQ3lqQskYPlfA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 08:16:16AM +0100, Johan Hovold wrote:

> An alternative would have been to add new compatible strings for the
> derivate platforms and only request the regulator for those as I
> mentioned here:

> 	https://lore.kernel.org/all/ZgFGCGgbY-4Xd_2k@hovoldconsulting.com/

Ah, yes - that would be much better.

--Hc8gQ3lqQskYPlfA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYCsFsACgkQJNaLcl1U
h9CvMAf/TnvgweOOho7JYpCs6twOsPihnINiG68SDxShtJVTiJXg/XlJnIVEnr9F
h48uPQmchUF4aY4drFH9haiWVGNHvm+bAbKGyNwt1pbfny7xIaXdgwVQXCW/rMf7
FeGLB8vo6ial3N1YIWfHWW/8GjRms74XZmNd8GAspVNrtWrUcydP65FEK9csNmum
5BgNTfYD9jLrrc4OgJPoHF3cNYi8YMPtNzOXnNI5eOwokk5G7BRNkkhnA1CvK+o5
QHsAlUUEf65LmvODminV5zdSQNmtr/8MnNSSwykfcipg01Wuklic7D2oVM/z+85M
YEPLGgu6/qgpayLd/F+gi1yFTtC6BQ==
=mq/A
-----END PGP SIGNATURE-----

--Hc8gQ3lqQskYPlfA--

