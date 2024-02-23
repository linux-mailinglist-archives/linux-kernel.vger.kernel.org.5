Return-Path: <linux-kernel+bounces-77881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DEB860B74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7596B284557
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D314AA5;
	Fri, 23 Feb 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lh4iJg27"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4A12B6C;
	Fri, 23 Feb 2024 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674305; cv=none; b=nRuX1ZTYLRGj3IzmEVs1uGUUuwD52Y2Deu81bROcSUFzFKnD8Qi8kFVes+XxQ1JhC1Nd+cPCW3I1a6Bz83rFFA8UBSWBo5Cskqr+cVzR4OwrVSOcVCAvvm1e0yg7adDm+GwfGlftI8VPekMlT8bqHZUycv1vZqc3FNYy9A+d92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674305; c=relaxed/simple;
	bh=aZQtPzQPB1/AfUOCVilt9mDQ6+e6sJCSoNnzUrnCeiA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZRbllv4HJkJ2Y1RHVdVHbjplwieVTXbuFHKwgQwElvWgB8ldu7FbEWwb6bosx4dKpR34tdRev1fY4CW4lIUF0j2X8LMYQa6ur5i/VjhmvoyxHM4VIgFAPLMTkytpGyWRxvMpZbXO+oUsaQN1KyJPGp6dBHSjA6+UItGkW5KOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lh4iJg27; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N7ikl3086238;
	Fri, 23 Feb 2024 01:44:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708674286;
	bh=HbrV+ATuFW+OxTTN987BCVpEDxpaf0I7ZAX4hbcUxm0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Lh4iJg27t5o4sGcHRu8dchvGkFis1wz45NVIqZL+nMPGSoUStd6EZku7oNwJFG9We
	 CttwRpyKNvH9t8yBQNA+XAX3uOhBOF5PbSk6YLifluSZJ/EDEoSBEkTodiVh3nhb8C
	 kQVhW3bczkzT76hZAX3V7XUZbvSbVjlAnvc22jNk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N7ikYI023176
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 01:44:46 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 01:44:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 01:44:45 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N7ijXL100873;
	Fri, 23 Feb 2024 01:44:45 -0600
Date: Fri, 23 Feb 2024 13:14:44 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Rob Herring <robh@kernel.org>
CC: Vaishnav Achath <vaishnav.a@ti.com>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Jayshri Pawar <jpawar@cadence.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Changhuang Liang
	<changhuang.liang@starfivetech.com>,
        Maxime Ripard <mripard@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>
Subject: Re: Re: [PATCH RFC 04/21] dt-bindings: media: ti,j721e-csi2rx-shim:
 Support 32 dma chans
Message-ID: <jk7jsiws7ivxwdl4teoviu6qxp43fcj2raxj424m5jtep5dm2u@j3vpbetaimhy>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
 <20240222-multistream-v1-4-1837ed916eeb@ti.com>
 <170860471258.2476270.8232202066004725650.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dkpavki64dphg6yq"
Content-Disposition: inline
In-Reply-To: <170860471258.2476270.8232202066004725650.robh@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--dkpavki64dphg6yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Feb 22, 2024 at 05:25:13 -0700, Rob Herring wrote:
>=20
> On Thu, 22 Feb 2024 17:01:20 +0530, Jai Luthra wrote:
> > The CSI2RX SHIM IP can support a maximum of 32x DMA channels.
> >=20
> > These can be used to split incoming "streams" of data on the CSI-RX
> > port, distinguished by MIPI Virtual Channel (or Data Type), into
> > different locations in memory (/dev/videoX nodes).
> >=20
> > Actual number of DMA channels reserved is different for each SoC
> > integrating this IP, but a maximum of 32x channels are always available
> > in this IP's register space, so set minimum as 1 and maximum as 32.
> >=20
> > Link: https://www.ti.com/lit/pdf/spruiv7
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> > ---
> >  .../bindings/media/ti,j721e-csi2rx-shim.yaml       | 40 ++++++++++++++=
++++++--
> >  1 file changed, 37 insertions(+), 3 deletions(-)
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
edia/ti,j721e-csi2rx-shim.yaml: properties:dma-names: {'minItems': 1, 'maxI=
tems': 32, 'items': [{'const': 'rx0'}, {'const': 'rx1'}, {'const': 'rx2'}, =
{'const': 'rx3'}, {'const': 'rx4'}, {'const': 'rx5'}, {'const': 'rx6'}, {'c=
onst': 'rx7'}, {'const': 'rx8'}, {'const': 'rx9'}, {'const': 'rx10'}, {'con=
st': 'rx11'}, {'const': 'rx12'}, {'const': 'rx13'}, {'const': 'rx14'}, {'co=
nst': 'rx15'}, {'const': 'rx16'}, {'const': 'rx17'}, {'const': 'rx18'}, {'c=
onst': 'rx19'}, {'const': 'rx20'}, {'const': 'rx21'}, {'const': 'rx22'}, {'=
const': 'rx23'}, {'const': 'rx24'}, {'const': 'rx25'}, {'const': 'rx26'}, {=
'const': 'rx27'}, {'const': 'rx28'}, {'const': 'rx29'}, {'const': 'rx30'}, =
{'const': 'rx31'}]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list

Thanks will fix in next revision.

> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202402=
22-multistream-v1-4-1837ed916eeb@ti.com
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--dkpavki64dphg6yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmXYTOsACgkQQ96R+SSa
cUXppxAAiKve/pejPnfyEE6LI718RJadaeKyqDT2+qv/N6KmqzlLizyKRnfta4yG
04AOumjKIUJjXXZ6AuVHs1qXSCnan0ux6h1hTcBVeCnz4iWQchaJ7mwmO8puJRIH
rwABkD8TGxeAhBhMnBjfF7pyyCZsTLIJTzJw5Vtee5FlqY2Yz7xhCqdsqoBMpBTz
5gJoUOLv/HYfUZWI+nnxTOTw95UJEhTGq8Id40neo9AygAZi4h/3NdH9y44Ivy4E
sAbKaeVaGbjtfRu1HpfoEZGIyUPlp7j3g9z435+kS1G3agOVTE9qf71EgoJfGXu1
WvW7/gzZcG9ncU/38ekNxApqQm953BNNa9OOpGL08rCdZWMsA3l7sHHkf4H5vpga
ehyJLHga+6oGiViMojmUBBAS0AB24qOldB944cClRLdXcek32t1SmpP4SLL8wupv
ttISmAcxnD6ab2Cxz2FY1roA2UTADXyb6JbT+OJSxBhNNlLVyDxyUQ76HLTs1o6W
ZZ7n13bLOjs9gus0U0KTJhNXnwaAp8nYc//TGSiEqrAjJ+M4wystJdrbrrdbG+BF
/1rHPZU3iM1tEKhYxk6HBPhLIFih+bHmnRj5sKrYMig7W3LW4sHasLUr2mFE8Wlb
vTGMHEFlTXu+mQVBPx6PNI0RWS3o4xW+ThEH1IK5y9ap5+fkLWA=
=9a+5
-----END PGP SIGNATURE-----

--dkpavki64dphg6yq--

