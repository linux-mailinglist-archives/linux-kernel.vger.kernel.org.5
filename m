Return-Path: <linux-kernel+bounces-67357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6942856A62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60849285A05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E91136671;
	Thu, 15 Feb 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmGmXp9h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8408135A75;
	Thu, 15 Feb 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016437; cv=none; b=MQo26Eyi3IOhlNu5Q79k7w8JIkArQAShcCHWTK2egOGF/f+DrxYCpl7k/dLzNoF7S8wVVsAu3EhiragpxmpTH3M0lGPWV3h/saRhEza/af4eZrXGEECu0rS/SDFR3bby3p6uwJagwgbB2JNRceBQzNy4PLttQ6Canogbazuxqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016437; c=relaxed/simple;
	bh=ICrWTbldjX975W3btYUWwVrChRkDG1H5ULl0Muhb6hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnmD722Mhjo17AqAdy8JYblY8tXI7A/q6xbkfAiIl+6f4DIbKm9jjSwzHlEEDA2qFMo8nV59syfhwRDktRZSpaZm6k1OgeAOHmZ0ETIQp2g5CqA3v63xZO0KD+vrGYfQXc0nV1WscDoJgbBvlyJIxquwW1TmZY7Rk7LgBSCZANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmGmXp9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97159C43394;
	Thu, 15 Feb 2024 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016436;
	bh=ICrWTbldjX975W3btYUWwVrChRkDG1H5ULl0Muhb6hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmGmXp9h8/NmjOVvPq2UXmxKPbIo0y7BYxzGHZv6aadFtcdMuMdbnYUGmQlO913DH
	 LTVHQayO6nKjrvBtRy6BurVGNcoq50fnejWw3RpSLVwNtS8vG7I5ZeC3dhzezTTvWj
	 PtAfGth6k8UAVkcJof1FI/SJ+KQqZvejxnRQLyHepkvLDIrydcShyy37QCE6KdjkVP
	 IOOa+lwQgp72wkcYr+MTeUxXwNS1uOfUMaf/KovpVvgPVTmGsNbIzZIGSpjclG4Sr+
	 v6yr3ItVCPcBgyZI2j5Fo9KDpR2f8eDDK8ScCJbb9CL3PvQuNPBeygARTqQIjHAsAb
	 kWcK15ViP1wvQ==
Date: Thu, 15 Feb 2024 17:00:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 1/6] dt-bindings: display/msm/gmu: Document Adreno 750
 GMU
Message-ID: <20240215-trout-written-9ba8c929f9a5@spud>
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
 <20240215-topic-sm8650-gpu-v2-1-6be0b4bf2e09@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HZ+0T1NysZqNQ3hJ"
Content-Disposition: inline
In-Reply-To: <20240215-topic-sm8650-gpu-v2-1-6be0b4bf2e09@linaro.org>


--HZ+0T1NysZqNQ3hJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:20:23AM +0100, Neil Armstrong wrote:
> Document the Adreno 750 GMU found on the SM8650 platform.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Doc=
umentation/devicetree/bindings/display/msm/gmu.yaml
> index 4e1c25b42908..b3837368a260 100644
> --- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
> @@ -224,6 +224,7 @@ allOf:
>              enum:
>                - qcom,adreno-gmu-730.1
>                - qcom,adreno-gmu-740.1
> +              - qcom,adreno-gmu-750.1
>      then:
>        properties:
>          reg:
>=20
> --=20
> 2.34.1
>=20

--HZ+0T1NysZqNQ3hJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5DLQAKCRB4tDGHoIJi
0uvUAQCtCgC2eHupKQtPKFOnR5PFcNSjcf0kcLi4MhaYUVZEzgD/REr3WQUpQ8eD
moB3rhx2b3tSDbMaZ5ZNmayqfscT5QA=
=aBoj
-----END PGP SIGNATURE-----

--HZ+0T1NysZqNQ3hJ--

