Return-Path: <linux-kernel+bounces-107430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D878687FC66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB89282492
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940127EEE6;
	Tue, 19 Mar 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="fQWUHAgT"
Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11020002.outbound.protection.outlook.com [52.101.154.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F77E571;
	Tue, 19 Mar 2024 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845788; cv=fail; b=f5BYBMRbsayrKCqNAKg4C+sNYxqWhVEd+ww/GHOKJvthJmVF8uP4Kkg88iAFRUDvQDBMtTKi6fVg/u1GY35MCaFPk4G4cGflGvLYkHapkaySrjBmDG9armP3i6bvRlcJnyn3Oc4A3y6MLWXXJl5IgjU8nsk03tAbpcaer8D9xwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845788; c=relaxed/simple;
	bh=6dhviL0r4xWC6QlrDXKWXOiwTNF6aXqw+SGJklWV/C0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gfTBGcV8FzPO63BerV80cMLmgwRBmCvHur9Xk5mYsqGFbnNNSTXHla6QeEqMIvAQg2ChwACj8xoY7Qz9iXJ+kd/hv8du4ocV09vIAr1z731+dTiITCuA2wtFqPMsC3m8jW/6g/HxIurEuMMsVkI+oYsdMsYJtZyGdvYt24AdatU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=fQWUHAgT; arc=fail smtp.client-ip=52.101.154.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn73V8RIIdTzmQl7CS45NAW5eGUqY4RQEZZFLqVnLPjdNpk4YaT2CekJj6i5rr8NQF/cOq26de09Ds4yeWBARVC8TcIidb8BDbm+YzgsXpyKMuz7diLaxjN3xUWHUHxjqzKSFyrYsuzhRBIWUfGvdcl4lOrRVsgbMK8jf61334U7HriayMFeCMUtYHEUU3wWv3/QrgFkNxapwYPZ0deVzMWdyw3gsAMGFIVM/Xg5nG+QuVbkg9YHnGp9f9z5O0ZRHtkTksYw24NqG43BpyVYl+H6rgezQxwgiFzih+GDQ9EF7JW/kSEvj7Hl6Dao5t88tjjrExvaRcTqLsnffAos6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEWvRhnZqb+rmnr5Gw9p4lb2OYDvEo5spr9OuPj35IU=;
 b=XdT76UDWPcj9drcU6YAQ8C+Ety5l4vUd4qwTWde24kZqYGq/Elo3zuYGaW4i9Ll9qls3GIEijzbQ5xlEyKEj8OUPf04ud8RsjTrhEenPX5ZdUgLwt4LmnE6/HM5wV1iTT5tL5799FuGJQUk2ymVsN+bvtUVC98jzpVbTK5/XjIrqg4XdbCPXNUDbBZo2iAduJwgtRzJ250QqJg6s6ouuJJ1so0yfAwuBBQHw/PPa5P4pUUOlT/cMo6hKt9cuDaJO+YtGD65v/S9vGkFfqM6opTpngybMWcjyHzHTx7HYDXRRBjcthfEBmOXiGDY0SLtl0dbUhe30T6ClYyIJnKXBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEWvRhnZqb+rmnr5Gw9p4lb2OYDvEo5spr9OuPj35IU=;
 b=fQWUHAgTNH4ZaE+o4lXFGQb9xA6JBU0MvWEiORcAGRUVnMkmlfblqrvQH3V+frW26NFdCU5gqjvmM8PVMaeu85g7PedgGWqqfHHXDGcPTh6aTVx5aEq35+atFa5q8KZScVl5P5iqTN9fQVM+9bgI1RlkmMNSIpYhdbZ8hA7p4ug=
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 PU4P216MB1486.KORP216.PROD.OUTLOOK.COM (2603:1096:301:cd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.28; Tue, 19 Mar 2024 10:56:22 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7386.017; Tue, 19 Mar 2024
 10:56:22 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, jackson.lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Thread-Topic: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Thread-Index: AQHaeUKgZLecalKvxU2rcLnTilDrELE+3QHQ
Date: Tue, 19 Mar 2024 10:56:22 +0000
Message-ID:
 <SL2P216MB1246F7FA7E95896AA2409C90FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-6-brnkv.i1@gmail.com>
In-Reply-To: <20240318144225.30835-6-brnkv.i1@gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1246:EE_|PU4P216MB1486:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LbJ+0UzG1p74K8RuD3tp4nx31qcpDFr+j6qnPauihPOBFSdi9ggO0eTniCfmXlnP8dg9XondcqOsINWexLdsfekv0CChbmSAROdLz/g7j0R33FeoY9reZ/LExpweflP7WlCyr3NhGkX45qRQrlKTz8JcbeF/nH7sIK87Z1GA50ZJ2wsEyF6t6xzjUN9oLyDMLsgkYgKZ4FGO40CQI+AQXFemfUUPlRKQVQE9z4A3UN/9YTvEn2SIJgRm+LcJhqJFmLHXtENDRZjxePMSdYD9JIxKTBANgKfbiVEP6OCsq0s3A2XCtdCuwA7DV46+h3p/mwPp1j5LSUtumt4lb92Z8JjKxwsqxdPOUlHKmZ9q5aOihpIspOwTgZyCjmXd+5a2OEttOuAUND7rZ85dxFoUpV8m+9nvcTLt6d0EdIKIy+HyVEmRzehHJY4Qtv0WW1j7sDZ+bPSGLEHbUxno5RMvO6wdg/NlWWizTAcoTr/ABXUPkvaM9zi0V1DKzcS4w1d3I3CImQ9YX9SMjd/IpLtIJJIPxsmNZineVKH4ZXzmxmI/+9JsTtDpe2wMfdIOVyoyeFLxkS+HXCgfDKU/+vATUQqqKzrYaZFFIsG3sTCcY+fO34EX8KUCXChPwx9jKnBzF2qlA2u12SNNffIGb2Y2qvI7ZeGzxnRicDlWCK1F8A0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uOHawIdD5Ok6s+6IrT8R9/mQbORGGtdHFp0OsT+ByWTIYB49+mn8uSsq8fZT?=
 =?us-ascii?Q?2qi5lBWOU/hXviOOG6SHlZHhlHeg5uWg5g5IR4E6NNL+fvNw8vYG9Rq1fwhg?=
 =?us-ascii?Q?teB2O2sfXML5kW2SAI+AeaOy5xih3+wFesfjM+LQ0+Ls6UWAx2+xBeW2y9In?=
 =?us-ascii?Q?FYg9te/AfZcnQYn8Sy046MOiX76letaKJfQB+xR65qKB+gOC89cqzihz+o+N?=
 =?us-ascii?Q?I/CJ/4o1iOr+19smbziZ4604rwMyLoJ/E2MF/VcYqtZJa7EzF4Q8rVS35cwb?=
 =?us-ascii?Q?/uIUc+eOQ4elBin3AxUIjd9xe62u1hEAWTEULnmvHnpZyG3X3fcb81qtJf8Q?=
 =?us-ascii?Q?s/TZet/T7X2FYojLCAMlOZnY4HrIu+4exHribS6QGqy+4fXClco49rVLO7IE?=
 =?us-ascii?Q?CYh8RbHqjKLtkQsvTnup7n+FnSvCmCvmgRNgJ0z0IXpz+N+jVd9B1WJ6FxWu?=
 =?us-ascii?Q?a2139jNwNSsVbY9/4GOBfI8hBIIPFn2RdA61wA4rKGKxV28bGLS2RASIBh/v?=
 =?us-ascii?Q?deXfptiRKr7FO4sbSi4jRbGybUiCfIQPhjJzpNcpNqCwwhpN4BdY+tcgIN0A?=
 =?us-ascii?Q?lm5GBeDddRh5fkpU4qrPsSAZ9XWWjw0MU6Mnegc9JWXi8OKc62fyP7CqYPR4?=
 =?us-ascii?Q?12ibsNokRBcOiU8Qb41KMd7kXnTK51kWe1BlqhrFbu9vmsAo+WaIn3f8M188?=
 =?us-ascii?Q?ZR/zmzwql+u6WKAJZ6qk0SSleUUsNEjQgzYl5BO1JDGIdzIPYcyTJl7dxbWN?=
 =?us-ascii?Q?OOSNHQD//5omqXF7DaQQaprfV4GLGdezZ7DZf5Vzn144nafmQbalz+OAJbTI?=
 =?us-ascii?Q?f2Yn8JvjQVAnxCOiQGIXML6zCVS49svqk/dW1dCPLgQwnzFPU8W3HH2Al6qM?=
 =?us-ascii?Q?zZs2bRnCdANkvSh30qvp2sbfB3zWEpLIPCdUeRN4AcsGUdlPfltVQVmwGc+1?=
 =?us-ascii?Q?kkUhr/YkPQAfMCT8SaYWdg6FoS4ZvNuwWFpfacZP+a+r2j3NjiPQkKmbUYUr?=
 =?us-ascii?Q?emnhcGTqYeZRnKsdZveP2Y7coxnWesIWKNg0jNASH1I83efltvH6CPGQ5icE?=
 =?us-ascii?Q?wFd9p8yY69WgYr1975RO1FQS3vkLgJfD1lMfygOpDFLQolisTbVUOGz4HEuL?=
 =?us-ascii?Q?ldkDNs366IFjIi2T8uEf2qzQV25yJ+uN+FERABXKZWWNdwLoAXqrjtYf5Tfv?=
 =?us-ascii?Q?tjfWlzgHBa7eWTtaBw+vqTKx0YRS0jspu6nO3RD2rgQKtQBhzbWLCl6PxJvo?=
 =?us-ascii?Q?Mc+e0MF9dd3qsnIUXR6u4x+/8BlJizF5sKcqtQ3qSOrhvjRqd3mE2ykC03rM?=
 =?us-ascii?Q?krT2BkClat6KJ0cMhFglx/gFe9vFIRT+OKroS8x8jHaegty6QSbkeXJ/tT0D?=
 =?us-ascii?Q?WatQ9/XR5fKbASCE2KXKkJffaFqv9aCddrqH48Ky+Halzy573N64PEakDPHn?=
 =?us-ascii?Q?oMoiQ3vay/NIe36hEWCmXCw+h2dQ3+pvNdJC+UIn7fIoF5JZWSNJzQNwH3uP?=
 =?us-ascii?Q?b39nlxCoqDq0Iznj7Pgg2KkQVtTOaOjmqFqGTeO/1v0TVkaf/MRzQ5+Hjnxc?=
 =?us-ascii?Q?LTW3Xzg8powMFQiXrHfMy8hRImh7jcZklwrLUZOl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6bcc3a-2b0f-4784-5069-08dc48033728
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 10:56:22.7075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 99KcoM/A+n6/XtdOeXn8Oi44ymZlTFJbLBdSiRFRbOms1UaCore+VQFErIXbb6IAGrM9IrmfCEi9IHtUJB7mml7G5CJ2Vj+HhbuQ/Erf26Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1486

Hi, Ivan.

>-----Original Message-----
>From: Ivan Bornyakov <brnkv.i1@gmail.com>
>Sent: Monday, March 18, 2024 11:42 PM
>To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>
>Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; Philipp Zabel
><p.zabel@pengutronix.de>; Rob Herring <robh@kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
><conor+dt@kernel.org>; linux-media@vger.kernel.org; linux-
>kernel@vger.kernel.org; devicetree@vger.kernel.org
>Subject: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
>
>Allocate SRAM memory on module probe, free on remove. There is no need
>to allocate on device open, free on close, the memory is the same every
>time.

If there is no decoder/encoder instance, driver don't need to allocate SRAM=
 memory.
The main reason of allocating the memory in open() is to allow other module=
s to
use more SRAM memory, if wave5 is not working.

>
>Also use gen_pool_size() to determine SRAM memory size to be allocated
>instead of separate "sram-size" DT property to reduce duplication.
>
>Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>---
> .../platform/chips-media/wave5/wave5-helper.c |  3 ---
> .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++---------
> .../chips-media/wave5/wave5-vpu-dec.c         |  2 --
> .../chips-media/wave5/wave5-vpu-enc.c         |  2 --
> .../platform/chips-media/wave5/wave5-vpu.c    | 12 +++++------
> .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
> 6 files changed, 16 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>index 8433ecab230c..ec710b838dfe 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>@@ -29,9 +29,6 @@ void wave5_cleanup_instance(struct vpu_instance *inst)
> {
> 	int i;
>
>-	if (list_is_singular(&inst->list))
>-		wave5_vdi_free_sram(inst->dev);
>-
> 	for (i =3D 0; i < inst->fbc_buf_count; i++)
> 		wave5_vpu_dec_reset_framebuffer(inst, i);
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>index 3809f70bc0b4..ee671f5a2f37 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
>*vpu_dev, struct vpu_buf *array,
> void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
> {
> 	struct vpu_buf *vb =3D &vpu_dev->sram_buf;
>+	dma_addr_t daddr;
>+	void *vaddr;
>+	size_t size;
>
>-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
>+	if (!vpu_dev->sram_pool || vb->vaddr)
> 		return;
>
>-	if (!vb->vaddr) {
>-		vb->size =3D vpu_dev->sram_size;
>-		vb->vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
>-					       &vb->daddr);
>-		if (!vb->vaddr)
>-			vb->size =3D 0;
>+	size =3D gen_pool_size(vpu_dev->sram_pool);
>+	vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
>+	if (vaddr) {
>+		vb->vaddr =3D vaddr;
>+		vb->daddr =3D daddr;
>+		vb->size =3D size;
> 	}
>
> 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
>0x%p\n",
>@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device *vpu_dev)
> 	if (!vb->size || !vb->vaddr)
> 		return;
>
>-	if (vb->vaddr)
>-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
>-			      vb->size);
>+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
>>size);
>
> 	memset(vb, 0, sizeof(*vb));
> }
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>index aa0401f35d32..84dbe56216ad 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>@@ -1854,8 +1854,6 @@ static int wave5_vpu_open_dec(struct file *filp)
> 		goto cleanup_inst;
> 	}
>
>-	wave5_vdi_allocate_sram(inst->dev);
>-
> 	return 0;
>
> cleanup_inst:
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>index 8bbf9d10b467..86ddcb82443b 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>@@ -1727,8 +1727,6 @@ static int wave5_vpu_open_enc(struct file *filp)
> 		goto cleanup_inst;
> 	}
>
>-	wave5_vdi_allocate_sram(inst->dev);
>-
> 	return 0;
>
> cleanup_inst:
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>index f3ecadefd37a..2a0a70dd7062 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>@@ -178,16 +178,11 @@ static int wave5_vpu_probe(struct platform_device
>*pdev)
> 		return ret;
> 	}
>
>-	ret =3D of_property_read_u32(pdev->dev.of_node, "sram-size",
>-				   &dev->sram_size);
>-	if (ret) {
>-		dev_warn(&pdev->dev, "sram-size not found\n");
>-		dev->sram_size =3D 0;
>-	}
>-

Required SRAM size is different from each wave5 product.
And, SoC vendor also can configure the different SRAM size
depend on target SoC specification even they use the same wave5 product.

Thanks.
Nas.

> 	dev->sram_pool =3D of_gen_pool_get(pdev->dev.of_node, "sram", 0);
> 	if (!dev->sram_pool)
> 		dev_warn(&pdev->dev, "sram node not found\n");
>+	else
>+		wave5_vdi_allocate_sram(dev);
>
> 	dev->product_code =3D wave5_vdi_read_register(dev,
>VPU_PRODUCT_CODE_REGISTER);
> 	ret =3D wave5_vdi_init(&pdev->dev);
>@@ -259,6 +254,8 @@ static int wave5_vpu_probe(struct platform_device
>*pdev)
> err_clk_dis:
> 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
>
>+	wave5_vdi_free_sram(dev);
>+
> 	return ret;
> }
>
>@@ -275,6 +272,7 @@ static void wave5_vpu_remove(struct platform_device
>*pdev)
> 	v4l2_device_unregister(&dev->v4l2_dev);
> 	wave5_vdi_release(&pdev->dev);
> 	ida_destroy(&dev->inst_ida);
>+	wave5_vdi_free_sram(dev);
> }
>
> static const struct wave5_match_data ti_wave521c_data =3D {
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>index fa62a85080b5..8d88381ac55e 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>@@ -749,7 +749,6 @@ struct vpu_device {
> 	struct vpu_attr attr;
> 	struct vpu_buf common_mem;
> 	u32 last_performance_cycles;
>-	u32 sram_size;
> 	struct gen_pool *sram_pool;
> 	struct vpu_buf sram_buf;
> 	void __iomem *vdb_register;
>--
>2.44.0


