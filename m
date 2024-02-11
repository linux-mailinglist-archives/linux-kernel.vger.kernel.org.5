Return-Path: <linux-kernel+bounces-61027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DDB850C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594D9B217F2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E312C17567;
	Sun, 11 Feb 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H+aK+zcL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE3AD2D;
	Sun, 11 Feb 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707695672; cv=none; b=Ct3rw+o05e+zqq/CqZidXlUjGDtkNCkqI23XJj03aSvXziqzu+BWYDz1K7waPO65Hoy2s5vL/fhoU1jU9GKVchK+jdkLJj1NS/AKZd40L9wVAuTDX2wl/N3xcSLdaZK7QkqHV1cBSEGlXpyQPJ6VudoNBvcgA1fF80ul466IlfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707695672; c=relaxed/simple;
	bh=ovBI+uozlzSNIPcQOV2IPQFi3mWSCogjgpUAT5X2LTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD0QcYdQyDPlO6CmEMJRchGoujp+a+0erfb1fgaMNaPHIZMuoQmnzaA/8rT6lPwPdphjiyn2zDw9RETt30tajnsvfgYZb3d/1altt+t91QMz7KKNWTXUv9EWR04Z9hLvtdAyI2driafRfGUHVUCb9hZxvqHVvYW1mioG8IRSjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H+aK+zcL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707695668;
	bh=ovBI+uozlzSNIPcQOV2IPQFi3mWSCogjgpUAT5X2LTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+aK+zcLH30LUeJMhwmJsA0Psgi+FXPI4q+bHJ7MFBdJs8ZO3E1z0CPnGjMQb8sgE
	 7CHm+OZrCOQBfvElIJc8gUU5g+8oaBQx1QLUq0kaMZeFgcSkTnjZUkhifKrj7+SvUM
	 GyBZKh6Q24TXpJX6vUJ6eGWO7zUEtQ3k+65zWOipU/sbO2tBa9Our5TJ2BPxd/ngi3
	 M16lKM2Sgl6+enOKCEWDOVtZYhsa22vJnGEKBTvZUI5iFwAkfsPx/vp+KpX2iI9s0M
	 EqUFBLiqysTjsNawf1tpjmkjrFFGM11QPV1gXpb12yUlQHrsRuSY4ZH335xLEjZZ12
	 UDyfbKrlNdpVw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BEC6437810EF;
	Sun, 11 Feb 2024 23:54:28 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 370D4106043F; Mon, 12 Feb 2024 00:54:28 +0100 (CET)
Date: Mon, 12 Feb 2024 00:54:27 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andrew Davis <afd@ti.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 00/19] Remove pm_power_off use in drivers/power/reset
Message-ID: <iinovq4p3dn5pic6ipptqzi3minqz5dznfdzhzl2onttxb325k@l7bhoiibsxkz>
References: <20240208170410.67975-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vsdi4o5bg7tjzwfb"
Content-Disposition: inline
In-Reply-To: <20240208170410.67975-1-afd@ti.com>


--vsdi4o5bg7tjzwfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Feb 08, 2024 at 11:03:51AM -0600, Andrew Davis wrote:
> Use of pm_power_off is considered legacy and should be replaced
> with register_sys_off*(). Same for register_restart_handler(). Do
> this for the drivers/power/reset subsystem for all trivial cases.

Apart from the issue in patch 18 the series LGTM.

-- Sebastian

--vsdi4o5bg7tjzwfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXJXjMACgkQ2O7X88g7
+po+tRAAgCDIMC15ePLlQVTIKQd+OyONaoHDs6t6lhLgu8eFavGhqI0XqMvogDuP
hHbpzhPxUZP2+P+Sl7h8o/mKhujuR5YZymX3F+gP6aM7Wj8AWaTqSet4hvFxR/Sx
4xYY9gYnWAdPHuR+g9qwVZk5qPeNTwh5bEqGSPDl6hzyUAAG+DIa4652XAgF7xc4
QCcj82KH9g/+DNq9e1NDmIWY6bcrdSVH9UeQHzZbjlcmykiiKdtE35//hVS4nA7Z
dMNgh4xxz86RLEId4mqPbacv9jaNJmAAr/DEiEIwCsv51rIHPNEfHejR8C1Yowlh
9+u5AOJD/Dj1UlACIWBgoz/LYr3rxEX6vQxJkQq0L9QaqpeUwCYLGpxgF9DunAPx
86juxqF4keF/bxpiuDVsMh2hGPxbzf14MysCDF8cTuzR2rBUdUNUxZL3XVXKtmug
QIswLHjRiert6xEvEThVe/V0wd+Ts8Vd9NTPIP2+zWaagdGryLsQbmOxXJdpjzgT
IpdagnQaw8zOUqPLnI2WA1gLy0fTDttMoVtp63iE53JXSE6EPhp3njJiCCKg32js
URuI9Wr1hBs08KtLRZOj2EtREz+McEWKLJdBG0jsTS26zv1UHH2NB353nC2K9v82
fzHvACBM4kCbVyg5anS0GDmz5x8eddiJOcntikHGtYaVlKIF614=
=UK2f
-----END PGP SIGNATURE-----

--vsdi4o5bg7tjzwfb--

