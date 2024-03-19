Return-Path: <linux-kernel+bounces-107362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B6087FB79
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8A21F22491
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E87D3F4;
	Tue, 19 Mar 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="C494AfRt"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020003.outbound.protection.outlook.com [52.101.154.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701467D3F3;
	Tue, 19 Mar 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842978; cv=fail; b=uSext8IIDJwI+KMAuh63hgVXncXMMOnXWkPs93wn2n2qj5DaqJ2u3AijvAHTlyT5vUsrKh5DwdWPfak6i2O2OS1WSDmkGUkSIed3SuaognWXzXBzLfJe6IzjyyVoALbhUjfe86yEl98EzSPwjAc/orsCg/1QymcRgnkcmhsn7pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842978; c=relaxed/simple;
	bh=NreBM692kpUMFx9SVpaMKPThm/S3tjPRv04tfYhzV2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuynL3OPmMXUS4tKlQgtNsV4vse0FDERmK4BKMpA30WFQanktwjQuLpC9C4IagLQQup0NVuxq6BmjYrJeP9o8KlDI7qS18EzjO0a+8fIjGW6540hSElKbVz1E2VPQmg0gu89mULV8Vki71QLnmPeprUgSkvcRa+bPKR57eWKPSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=C494AfRt; arc=fail smtp.client-ip=52.101.154.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CObwN20GqqJibGDKqXdqPLfy4pZdNu8dEe26oBv6Zo12gXW5Qax+QeCaxJiSPrATI8uEvYTiz16a52ACkdeLkpWep4DpW+N54QjgIKCWPZQdrgM8+8z2Q/PJBOtywBKSsahd9R6W09S7mn1D4NUJa9I+BjaWZbD67YT+3pj4bo5lNBmbe7Ewm8ym8FwOqhJs4cXHogm1ZFN0Y4WhAVaGHPPqarQnB3DgQp4plGPgg60HvalV72eb1NA4j41oDb1k2+VLGo9PZNu/FA7bIjPXuL1NtRLvX+f5hkzF/y/dYrND4PStlP09AfHOo9jEEgUbodHZ1zJk5ScRxipRkdlTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVVpaYHC02JCpLAsLbbu3mQeVx+GOF4AhkfhGrgaoqM=;
 b=iy84SJe4Q6boj5JMc3fZteFePgxmz6WkH+FlApHINvfUpZyMZIlM+BWsXpFjQTbXenVBFJHSLAjIElZ7LDtGnnzHWMkTVcm3HUQJyUtGWHIcotqN7VnL+qotqLm5XDPv639mi+U6P2rJ3XVrvrIIBwVqxKmQmpXtUhRnxn//x93WIzgfmgXxMzJu4Td7EmPmqbrF1Vv1Qpd+idmp5iy2TfMgJMvav8IUwT2B8m953fhmoCdJW2Gs7tL2D89pzn8lyDhf067TH8BGnvs6QossBAHDnRBTAK9K3Y1PWqK5WKH/xaL5Gn7wqI/vhonL7HfJBxH9K0BNgpNitbgMGbccTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVVpaYHC02JCpLAsLbbu3mQeVx+GOF4AhkfhGrgaoqM=;
 b=C494AfRtlVx+R2fCtgNGBesABiN8C90b0o+fAEUqDEF5QJQdTT8+GDMfHGbvomG0ryH6xqZ8IJbj5d5O5gMZgn/RS0WgKtmqgw6RbfaBaguiAGC1xDIfgs8n5ubFNxpAnjtdYSI2ZFeIFB3IVsuC6eqZFLmcfG3QIf9cEVO2jJY=
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 SE1P216MB1272.KORP216.PROD.OUTLOOK.COM (2603:1096:101:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.28; Tue, 19 Mar 2024 10:09:32 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7386.017; Tue, 19 Mar 2024
 10:09:32 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, jackson.lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH 1/6] media: chips-media: wave5: support decoding higher
 bit-depth profiles
Thread-Topic: [PATCH 1/6] media: chips-media: wave5: support decoding higher
 bit-depth profiles
Thread-Index: AQHaeUKavgcckUHy2EygGbh2NtXhZrE+1aEA
Date: Tue, 19 Mar 2024 10:09:32 +0000
Message-ID:
 <SL2P216MB1246E9790DF5FE273D555768FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-2-brnkv.i1@gmail.com>
In-Reply-To: <20240318144225.30835-2-brnkv.i1@gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1246:EE_|SE1P216MB1272:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jx+MyReY2HHakkaHe4qLQapFF4ocuhDRt5sMAhofJFjSj3Alh6pKY8MHduzz7w/EwICr3d5qOOCNdJq2Uhp/0TKFG2AvfgBrZdfAdlCUxFjWYWWKANmfoBXCb56WIcnKjjdYBBKpjGFmaUh4E+Qdu5jdQ3/EtILbu4BzsyIhfF+z2EEnaN+VsvsZCstFH69IqsI4Mc1Y+0b3Fl5mK/Skw7p5x+Gy23F9/j2vkeOVx890rGeVUGvXA56VP8gAeVxjHpvfVqvCQn3XO9jn/vWy9DqW+9SWvv5Obrm20HiqXoc8ETB/eD4HLgtzz+txWXUOas05F1rTLrj5EdARjmCn0exzDaJ6QLatty8NaODmSIijOPCYHcGM997pWjIpPM3bHS7YtRDs2R2yx8x7JnEtN/IpNgPNRZAmLpOCiyc+oJ+7holycXelCrk7YZyRy+IcqY9qzGYtHKnb9E2LvbJ7qfm7u0aepVbOVITQkdrUicTQTMDwU5E2HLNBaJhGEz08YfFTcoSiqUmzvXFQMi0nBtX90gnTp7EJ2dE/kkjlJOXjeFC7rv23D+PlxuvdDY1yRX0GSkeDAKhn8JewsG7Tl7yuzdXbnSxI2uRmLpRZq133IvLsmvoAZMjIezMjUirDQRLTxN2qk7qogPQU9JkNATkc11cEqlXSR/CYpMXsmic=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5K/bNWo5En52ygQlmCHn6CuRqCV0VxDLZ1JomXlqFlA/ZhPYlM+6m9epwlSU?=
 =?us-ascii?Q?rBNwXoe7G9zU0ac6jqtnBLIVsQaQb67/Cc8QWDv/sM7782/ZkRds7Oz0O5zR?=
 =?us-ascii?Q?l54TkSigqCeJ/uRjw93F6XndvtB0tCbbeGfs1uCP/ZwjmvcZjVv04DXlvHu7?=
 =?us-ascii?Q?Rkf24P9IkGu1WbVedVRNOvSLmSwJDlYduyyXtvqo5Nvn9PUPKAZrn42JwF+l?=
 =?us-ascii?Q?vJO5YMUh8mnWFwgGnVI5YSxl7p+89DZaOu6jvpGaBu3IoFDFinZNJZPveQYw?=
 =?us-ascii?Q?dIL5W73V8qy6gPmjO9/UkRBn8DJofzmvqT/5S+ahew7tnRqzhQS6InW4Z9QE?=
 =?us-ascii?Q?649w09I+WOi9d0FI23EWBXuLpQ+DJXoI8NOPKAasnW2XPcOh4UDjhHli14t3?=
 =?us-ascii?Q?N/UYBgl/GvV3BRgPKIQ08DQv4ZkZJsER6MizAvkD0gCuFNihhME1n2haTzTX?=
 =?us-ascii?Q?TpCcLtfA92H0aHFuBXry1ISn6mIBEmrxqIlzu4/WytkvsNR+qcBY19L9xw9k?=
 =?us-ascii?Q?dVF0JJuqvpVVH09rH3pBAAcd90JtxCGh011RIfwkTkrOnaUo3yC8wszdWCIF?=
 =?us-ascii?Q?+/bnv8ni0i63Znb/Jm9FfbuK1HAo5hKg0qc9w8FNVuzFh5FI16owU7BGWPn3?=
 =?us-ascii?Q?NLA91JM0S/uq9wN3AC6uVbyTCofj566pIQXy6kXKrz2vNdRJHafa6BN6W7PB?=
 =?us-ascii?Q?3X5MOyP+eAvRIsgytPsr573gfVN3mZXnqvl0SKFFNeRDRT/3g35WHpp2J3Av?=
 =?us-ascii?Q?5hXgOG8hpoBpyWvvrgRkuFbCc/6tzSc8xBRqNrPl+STY7TqdJ/lLOwlw/SCM?=
 =?us-ascii?Q?/JcIdy9tWk0AvoIor/mNuuoL6J2PlhSQyyVl+Z53XFngLG0GpDtldkFhv5iz?=
 =?us-ascii?Q?Vb7HV6HXO+GzaDlXhfz81jHxgJ5rvNTz0agyTjNHGRBQVQyZ1H/PbFc6nPje?=
 =?us-ascii?Q?NK+JXL/xvOuwhqERnjcFvNBR+6dOB19UYmz8O1VNPeahGy1xtradA+kG0zeX?=
 =?us-ascii?Q?8MBu6tUDzFblr7vFy0h/AfxOAIg2dxyk/MXM39yOrycj4mTsNMP2WSCPE/5z?=
 =?us-ascii?Q?KMhbRivuuVoTXiMXtBQ/waB2fXrz525tNr8rj2WnmH7BIPFmwiq8FVvkr8zX?=
 =?us-ascii?Q?o8PYapBG50hk+Y5lF2rF37Yiw0AN9WGH6FGDx0FmgQ78n7WcZgsg3zWx5jQP?=
 =?us-ascii?Q?4VzPKr7EC1z0tblXJfUdIka3clOoMuJiLCvBJ/WzrMeSU8852xnOfJd0Ca6c?=
 =?us-ascii?Q?3ZSHAcWG84k3Mb0szsLrMNPe5E/d7/aQ+zOI+eBmAGx8fvaQK0ROrwy9tsF6?=
 =?us-ascii?Q?tmNwcxBNBJCluM1PzwsaB9bqc4bTO+k8H6//faijoZGCr4D9HQo1go06b/hW?=
 =?us-ascii?Q?KDgUsjUenkWOgUsZm9Z+YJ+rp7YqHOwg/FZCVawGM022yzmMptcLmjFhp00c?=
 =?us-ascii?Q?cOTZej6X+8Qub6hxGM1iao8Ts2gctF3PUdmTIPaOcxSuVes6pKLiYDjB4xJ3?=
 =?us-ascii?Q?GFqdqVmZ1IwSA2TTVyyyzNEb5NNanc6oXsFs51AiIxDOuAl1pi6WK6Dc61Vd?=
 =?us-ascii?Q?bnq49dlq4ZDUMiAPoBPFEiVb6w4Sl3OLU2i9nIRk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2226b28c-4b46-4c10-a2d6-08dc47fcabff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 10:09:32.2617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwJQOwQuS/e/ssXcbd0Xg2fNLAHdhuGgxnG26K3cd3xmGXVegTlHs+pBbMnVgcWzEhd5ZpzZ7+RorAZBcrfZ+lzsD6x39CY3a65P0Yg5MgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1272

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
>Subject: [PATCH 1/6] media: chips-media: wave5: support decoding higher
>bit-depth profiles
>
>Add support for decoding higher than 8 bit-depth profiles by scaling FBC
>buffer stride and size by the factor of (bitdepth / 8).
>
>Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>---
> .../platform/chips-media/wave5/wave5-vpu-dec.c    | 15 ++-------------
> 1 file changed, 2 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>index ef227af72348..aa0401f35d32 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>@@ -1055,6 +1055,7 @@ static int wave5_prepare_fb(struct vpu_instance
>*inst)
> 	int ret, i;
> 	struct v4l2_m2m_buffer *buf, *n;
> 	struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
>+	u32 bitdepth =3D inst->codec_info-
>>dec_info.initial_info.luma_bitdepth;
>
> 	linear_num =3D v4l2_m2m_num_dst_bufs_ready(m2m_ctx);
> 	non_linear_num =3D inst->fbc_buf_count;
>@@ -1063,7 +1064,7 @@ static int wave5_prepare_fb(struct vpu_instance
>*inst)
> 		struct frame_buffer *frame =3D &inst->frame_buf[i];
> 		struct vpu_buf *vframe =3D &inst->frame_vbuf[i];
>
>-		fb_stride =3D inst->dst_fmt.width;
>+		fb_stride =3D ALIGN(inst->dst_fmt.width * bitdepth / 8, 32);
> 		fb_height =3D ALIGN(inst->dst_fmt.height, 32);
> 		luma_size =3D fb_stride * fb_height;
>
>@@ -1408,22 +1409,10 @@ static int wave5_vpu_dec_start_streaming(struct
>vb2_queue *q, unsigned int count
> 		if (ret)
> 			goto free_bitstream_vbuf;
> 	} else if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>-		struct dec_initial_info *initial_info =3D
>-			&inst->codec_info->dec_info.initial_info;
>-
> 		if (inst->state =3D=3D VPU_INST_STATE_STOP)
> 			ret =3D switch_state(inst, VPU_INST_STATE_INIT_SEQ);
> 		if (ret)
> 			goto return_buffers;
>-
>-		if (inst->state =3D=3D VPU_INST_STATE_INIT_SEQ) {
>-			if (initial_info->luma_bitdepth !=3D 8) {
>-				dev_info(inst->dev->dev, "%s: no support for %d
>bit depth",
>-					 __func__, initial_info->luma_bitdepth);
>-				ret =3D -EINVAL;
>-				goto return_buffers;
>-			}
>-		}
> 	}
>

TI wave521C version cannot support 10bit decoding.
So, We need above error checking codes.
How about adding support_10bit flag in wave5_match_data like below ?
static const struct wave5_match_data ti_wave521c_data =3D {
	.support_10bit =3D false;
};

> 	return ret;
>--
>2.44.0


