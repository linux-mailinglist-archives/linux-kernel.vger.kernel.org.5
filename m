Return-Path: <linux-kernel+bounces-120671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E34E88DB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C6E29AC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271432EAE6;
	Wed, 27 Mar 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="AhlAJs8V"
Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11020003.outbound.protection.outlook.com [52.101.154.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A445125DB;
	Wed, 27 Mar 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535661; cv=fail; b=AXHguHFz9+eC1dErAimm8BSSe/aWwEoU0dqpGnHjCgUJrWAKO8MFkkKYt2M8D1o8T/R6gTvPBJG8ttxhz9d5k3ebLOnFVhvVB0j+XW1vMuPq2AnBe20m/D0RCykcXuPHx5U3yDpnxGkjWYod2XlkEAjo9QkXMnkJkyjgtRfT5JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535661; c=relaxed/simple;
	bh=l7eBP2QgLyH92LCXHhRLiqE4zA8QpqUbFc0AyZi3UXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tuQTfrh9Od/AsR0zJcyIS+1pKxm43InG1CaOavrHzwn+am3FjCr7fvGIU7UDVTeV7kVFIl3uBphmlu3du6/OBTtqeS/sUwGmHWUA496QJTDk2bazM7JiHKjyw5OB9uXIJ1Gf3TeEjolEvQVGV2aro5i2fHBcCKI46+WaxqLTGSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=AhlAJs8V; arc=fail smtp.client-ip=52.101.154.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7YzFAFVFNgUAD9XCqt8mlzVuKbq0LUEH54Oj/8PZpAcEi5pbF1CYEGjb+yKT0Vy5B6YNpVuVQfXdQg9gMVR4UTcsWTLqbXqRRMtXbyS15vZqcg9nlTuks2zFqg+OsLnah5Ib8rh2rPOJOi6nnhwmPnAZb6WbvC/tcnDrdJjUEeRcm6TQaNq2n+UW74UZ5dWQysLCDGn2qpb2gYLWTG0C9Wc3ktvyNy7kkb7ZDwJ4mFINXDRMYuarFBwO2Wx2dxf3ElbdHXdFirVxoDv1qvB+ydvZDB7kn4nNGLtzdYSvhq7lamB+ll+4imCvyayPb2A+/oA+JcJKblXQUWMH5ouQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9GsraDNlWg4Iamx+ZjqvA2ht7FXQBHyDP+C2V0ogKc=;
 b=IjhvM2oNDki4PuZkBpnsEh31ntw9gU8eDZZLYafrCkoUqJPwBqohgEuhGDeUwZEO5THQnxRwHX16md/4HaE3F4Iw5eBbZpUPXX7AJ9di1Cn+vDTbcFYAFoyBNECbCNYl8ifSSTkdReNKLWe5rJ66xTFLXG/LKjfES36MBIlJ9HdwXj04g8BwXJ0f+dHkVv1XYzYQ47zrHlJ+dhwcr4H/uyUFJNkBmVre5OLewmJH68SL/ehTQmJ2zV7U9+561GDHftzmhOTB2vAYyuY9NHAgEnYk3s8qBczrgXYpZFb1rcVGLoVtHU7j/bddyNcHNoitFyozhl3U8iHeTNKx3gbe0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9GsraDNlWg4Iamx+ZjqvA2ht7FXQBHyDP+C2V0ogKc=;
 b=AhlAJs8Vb7fPstGhE5UfRolkXAoWLHVA1jo1aXNcpp4eVfvq8eo24j6QISGVuEyrzqbxnjCk506Ij7Pbe/jJjQAfHIZKET63l2I1zGEF+RDmN8LzjfWUu4ubZ9DTNFroT7D2ZcA5hcEOIspKy+EHd1sJc9YDUN3oyuHcaxXDWI8=
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 SE2P216MB1796.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Wed, 27 Mar 2024 10:34:15 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7386.025; Wed, 27 Mar 2024
 10:34:15 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>, jackson.lee
	<jackson.lee@chipsnmedia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 5/5] media: chips-media: wave5: support Wave515 decoder
Thread-Topic: [PATCH v2 5/5] media: chips-media: wave5: support Wave515
 decoder
Thread-Index: AQHafn96jA2roaXczkWuog85ls9hWbFLZdGA
Date: Wed, 27 Mar 2024 10:34:15 +0000
Message-ID:
 <SL2P216MB124656EF7AAAC5FDF4F1C0E6FB342@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
 <20240325064102.9278-6-brnkv.i1@gmail.com>
In-Reply-To: <20240325064102.9278-6-brnkv.i1@gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1246:EE_|SE2P216MB1796:EE_
x-ms-office365-filtering-correlation-id: 96e377f3-3f7f-4ac1-1c27-08dc4e497332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S3yiGxNwkWvejn7pUio1Ryc9lhMBn6Pl2rLR++DOw+lbW9p5giO4064jpRUIhZ1EDtm930qak13GtVFFasjIAF4/sYKI1VEWxwK+WmJCjboBpD0f1zIhp0IUo5/haArErAistOJdWKE6TIq4YTc5AzYUTsEBWPD3bLNXFUJLD2voG+dUX7EDJkdSONV1ecOHYqN558X7jlGB3moX+GWUPUMYWzinF6pMdSA8uMSHokC64qdltMLZeV5IAIKx5uMH3kDMI0odoEkMAbCk0SR6QT+rF1UXyG5HBcmhODn/8mfIlL6UEaEANQYlw10DFaz04w+jFuUZ9FnKBUN05oa3LlLRb3nG5rOKjQYOYDlOKj1k8t3HvgYboRV2jWsJYaUj7Ty342XPKGTIlMMTfSAzNcgtd1ql4Evb10bW54GmJy8Hv227DEInwr1CtFflWgRRqDW7/KBpH9uTEOxSL01cNrb53CVWx4cyayhZ55knACGN3HU1QV346InQSna7iWOxXqHjNtWAQdOaHozQjDxV/Q2ngZPvkfsXtu8Qg3ll0swiw8SQA1tM2FwoGUn72AfBlKHXRJU95DBT5mw+hYg90oh6COP8KuTpjo2OKYGtnk8WGFsQVfq+Ftua78/TJJQwPF9ajSGxgUJkHsGjKziZRLEuuoYI2OCkSFiRTYx+c+Pbr6TekV17+npEU2VKv7n0atu1CZ1wwdrNrQFbXRNx4HHXy6eqSmFpi1KWlhKXZe4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QWL0gH+HZkWikQhCUEp8b+7saUP/B4MbQ4axX507lCcGyX3HiDk2Ao8I9K6M?=
 =?us-ascii?Q?egRI6Ls+WnhWNRw8IKQCSfQ0G3hpu43IhLpF/GlsK0JW2CTQBm70ko7bjt7k?=
 =?us-ascii?Q?5InSdkd/AnPymPQN496X4WdudbzAYxoeVpoN1zZoTvz4/iU0dhCJG5mWbNQ3?=
 =?us-ascii?Q?62kZOE7HZtYR/e+HIAqsnGP9XnMKuNwlxgVYTdnZPC7+38RMzQ5Le2cHgRuW?=
 =?us-ascii?Q?g+xqHceJjL7z8KIBRRw5b1d+POxmtBxgp0TE4TvNURKYqcjRZrNLvNAVH8sb?=
 =?us-ascii?Q?3anCKj1sOJUaU2lvy+xciJ8ULeju+IQ9lVKy4+dDWc+G+KZcJgqYy6A1GNUG?=
 =?us-ascii?Q?6MKQpP++Rya7VBgMsmgeRb5KvpM8iQTeDuw6YqaaTXsNSU13SbDcyQvgDDTH?=
 =?us-ascii?Q?h8OkFTX7E1IUMEJJgTG70s8q6jlnHcISyso/y6a6FFHf8MQjgOtrM1lPbCVB?=
 =?us-ascii?Q?zhDRWenFEwLFd/DToBL9kMI2x2/ayEwtOxb5GFpkxohmdN28Mi+lT+LbdIVC?=
 =?us-ascii?Q?b1OG/mhJesmiBh+zd5EA6WuLXu9SRx0gmsXhtMIZOqaN9X/BqKIxZO0K/1Oq?=
 =?us-ascii?Q?bQbuGW7gWK+t6w4z15RobB2lRgSLEwW1tYAN2PyzqE2mmBd9u8ECbcuM0N3Q?=
 =?us-ascii?Q?uL9voGish07URvQ6SSyWBIPctTkRgtCLGZF81XQDVUcm85E28/z7+hE3xdgz?=
 =?us-ascii?Q?3nltO2K+g/6WLsgWw9sSsrC1jHJV1lKgDk50Eu82Y3WeDpOlgxEHacsmom1C?=
 =?us-ascii?Q?3bomqu//WAWzMb+bfVI2tPXgpjNrCv1OAkhnE0DLreDCZ+HPpsUFf5Y5iHQu?=
 =?us-ascii?Q?z6ekHyhIFhR98638rBpU7lo0Tz0BJ9BoUwH50NjGuTaKNy1F/2w9TEyTCmTJ?=
 =?us-ascii?Q?8fEBKqOpjQqxZ/tLgs4CKJguoHlrgwekKvBOp7Z7Gd0y5J3rtoTIvb67FZch?=
 =?us-ascii?Q?retC9TurxdrGJhpBv5iBS4lSWi2ewgRdl8LtQE74A7e5Iq1zF0ym1KzqFufa?=
 =?us-ascii?Q?8gEfmgZRweCWYETViMrhZyvCyG1gIz/65ejnYHZiYQRivjX+mu6fGWfxNYYp?=
 =?us-ascii?Q?Iopgp6skkrFjkNJJme36n2SsZ+vJ2i4qzvWpBXWZV4lb6hSU4t8y4+MEcQ6V?=
 =?us-ascii?Q?WrqCupzID87urYHAUevZrNV55O1fMeyzSuxgEeFRygMl+ddYhwXKOxw7vEMK?=
 =?us-ascii?Q?uJQxr7wEoVDkeD7IN82sPhTZmTKcdIVBHgNrFzTiWVX1SnX1i4epradz76iT?=
 =?us-ascii?Q?Lt9f/1DafCfXmpu6it9amWQWaovk7JHxqHNPw796NYL5yqFRxmvvgq7aaUOx?=
 =?us-ascii?Q?iZ30CSt6zJxUi3737S1TCdlVcEN0O27Y44sPYa/UTk2akvbG/XT8yNUx7bBR?=
 =?us-ascii?Q?QdjT12bmFFymilsPRzauZoqkHlJ8AEMi5kFFxmHGQOUdeSrua6yUVmNXQXxK?=
 =?us-ascii?Q?XpEaezMRnE0pidnWgVFVlA2h5imuBOcqQmsjoJVKPev0es8mwqhK+/WazaJP?=
 =?us-ascii?Q?s7T5Ns2neKZFSFNsj7/r8bT9dDBYz6q/Uv+dxEwslkts2CpBFPRVXzoUEfw9?=
 =?us-ascii?Q?WaieIB/FccipzpyBdgUHd7JDjKDVZAA4T3yvKX+N?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e377f3-3f7f-4ac1-1c27-08dc4e497332
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 10:34:15.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJayV04qrCuAOZRbY0RnCVAVnMaUxO3E7kq0m34XqQCfHYuPw+toJTNPKHbkVE8w8d3lBLzNo/4db6gR96zLwa3Dl9rcBIiPtitlcMz6OUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1796

Hi, Ivan.

>-----Original Message-----
>From: Ivan Bornyakov <brnkv.i1@gmail.com>
>Sent: Monday, March 25, 2024 3:41 PM
>To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>;
>Philipp Zabel <p.zabel@pengutronix.de>
>Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-media@vger.kernel.org;
>linux-kernel@vger.kernel.org
>Subject: [PATCH v2 5/5] media: chips-media: wave5: support Wave515
>decoder
>
>Add initial support for Wave515 multi-decoder IP. For now it is only
>able to decode HEVC Main/Main10 profile videos.

Thanks for your updates.
Could you share some test result for HEVC decoding ? (ex. Fluster test)
As you know, wave515 can support VP9 and AVS2.
Did you have any chance to test VP9 or AVS2 streams ?

Thanks.
Nas.

>
>This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
>Users of the real hardware with Wave515 IP will have to
> * provide firmware specific to their SoC
> * add struct wave5_match_data like this:
>
>	static const struct wave5_match_data platform_name_wave515_data =3D {
>		.flags =3D WAVE5_IS_DEC,
>		.fw_name =3D "cnm/wave515_platform_name_fw.bin",
>	};
>
> * add item to wave5_dt_ids[] like this:
>
>	{
>		.compatible =3D "vendor,soc-wave515",
>		.data =3D &platform_name_wave515_data,
>	},
>
> * describe new compatible in
>   Documentation/devicetree/bindings/media/cnm,wave521c.yaml
>
>Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>---
> .../platform/chips-media/wave5/wave5-helper.c |   3 +-
> .../platform/chips-media/wave5/wave5-hw.c     | 245 ++++++++++++++----
> .../chips-media/wave5/wave5-regdefine.h       |   5 +
> .../platform/chips-media/wave5/wave5-vdi.c    |   6 +-
> .../chips-media/wave5/wave5-vpu-dec.c         |  14 +-
> .../platform/chips-media/wave5/wave5-vpu.c    |   8 +-
> .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
> .../chips-media/wave5/wave5-vpuconfig.h       |   9 +-
> .../media/platform/chips-media/wave5/wave5.h  |   1 +
> 9 files changed, 233 insertions(+), 59 deletions(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>index 8433ecab230c..c68f1e110ed9 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>@@ -29,7 +29,8 @@ void wave5_cleanup_instance(struct vpu_instance *inst)
> {
> 	int i;
>
>-	if (list_is_singular(&inst->list))
>+	if (list_is_singular(&inst->list) &&
>+	    inst->dev->product_code !=3D WAVE515_CODE)
> 		wave5_vdi_free_sram(inst->dev);
>
> 	for (i =3D 0; i < inst->fbc_buf_count; i++)
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c
>b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>index cdd0a0948a94..e38995de6870 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
>@@ -24,8 +24,10 @@
> #define FEATURE_HEVC_ENCODER		BIT(0)
>
> /* Decoder support fields */
>+#define W515_FEATURE_HEVC10BIT_DEC	BIT(1)
> #define FEATURE_AVC_DECODER		BIT(3)
> #define FEATURE_HEVC_DECODER		BIT(2)
>+#define W515_FEATURE_HEVC_DECODER	BIT(0)
>
> #define FEATURE_BACKBONE		BIT(16)
> #define FEATURE_VCORE_BACKBONE		BIT(22)
>@@ -155,6 +157,8 @@ static int wave5_wait_bus_busy(struct vpu_device
>*vpu_dev, unsigned int addr)
> {
> 	u32 gdi_status_check_value =3D 0x3f;
>
>+	if (vpu_dev->product_code =3D=3D WAVE515_CODE)
>+		gdi_status_check_value =3D 0x0738;
> 	if (vpu_dev->product_code =3D=3D WAVE521C_CODE ||
> 	    vpu_dev->product_code =3D=3D WAVE521_CODE ||
> 	    vpu_dev->product_code =3D=3D WAVE521E1_CODE)
>@@ -186,6 +190,8 @@ unsigned int wave5_vpu_get_product_id(struct
>vpu_device *vpu_dev)
> 	u32 val =3D vpu_read_reg(vpu_dev, W5_PRODUCT_NUMBER);
>
> 	switch (val) {
>+	case WAVE515_CODE:
>+		return PRODUCT_ID_515;
> 	case WAVE521C_CODE:
> 		return PRODUCT_ID_521;
> 	case WAVE521_CODE:
>@@ -349,17 +355,33 @@ static int setup_wave5_properties(struct device
>*dev)
> 	hw_config_def1 =3D vpu_read_reg(vpu_dev, W5_RET_STD_DEF1);
> 	hw_config_feature =3D vpu_read_reg(vpu_dev, W5_RET_CONF_FEATURE);
>
>-	p_attr->support_hevc10bit_enc =3D FIELD_GET(FEATURE_HEVC10BIT_ENC,
>hw_config_feature);
>-	p_attr->support_avc10bit_enc =3D FIELD_GET(FEATURE_AVC10BIT_ENC,
>hw_config_feature);
>-
>-	p_attr->support_decoders =3D FIELD_GET(FEATURE_AVC_DECODER,
>hw_config_def1) << STD_AVC;
>-	p_attr->support_decoders |=3D FIELD_GET(FEATURE_HEVC_DECODER,
>hw_config_def1) << STD_HEVC;
>-	p_attr->support_encoders =3D FIELD_GET(FEATURE_AVC_ENCODER,
>hw_config_def1) << STD_AVC;
>-	p_attr->support_encoders |=3D FIELD_GET(FEATURE_HEVC_ENCODER,
>hw_config_def1) << STD_HEVC;
>-
>-	p_attr->support_backbone =3D FIELD_GET(FEATURE_BACKBONE,
>hw_config_def0);
>-	p_attr->support_vcpu_backbone =3D FIELD_GET(FEATURE_VCPU_BACKBONE,
>hw_config_def0);
>-	p_attr->support_vcore_backbone =3D FIELD_GET(FEATURE_VCORE_BACKBONE,
>hw_config_def0);
>+	if (vpu_dev->product_code =3D=3D WAVE515_CODE) {
>+		p_attr->support_hevc10bit_dec =3D
>FIELD_GET(W515_FEATURE_HEVC10BIT_DEC,
>+							  hw_config_feature);
>+		p_attr->support_decoders =3D
>FIELD_GET(W515_FEATURE_HEVC_DECODER,
>+						     hw_config_def1) << STD_HEVC;
>+	} else {
>+		p_attr->support_hevc10bit_enc =3D
>FIELD_GET(FEATURE_HEVC10BIT_ENC,
>+							  hw_config_feature);
>+		p_attr->support_avc10bit_enc =3D
>FIELD_GET(FEATURE_AVC10BIT_ENC,
>+							 hw_config_feature);
>+
>+		p_attr->support_decoders =3D FIELD_GET(FEATURE_AVC_DECODER,
>+						     hw_config_def1) << STD_AVC;
>+		p_attr->support_decoders |=3D FIELD_GET(FEATURE_HEVC_DECODER,
>+						      hw_config_def1) << STD_HEVC;
>+		p_attr->support_encoders =3D FIELD_GET(FEATURE_AVC_ENCODER,
>+						     hw_config_def1) << STD_AVC;
>+		p_attr->support_encoders |=3D FIELD_GET(FEATURE_HEVC_ENCODER,
>+						      hw_config_def1) << STD_HEVC;
>+
>+		p_attr->support_backbone =3D FIELD_GET(FEATURE_BACKBONE,
>+						     hw_config_def0);
>+		p_attr->support_vcpu_backbone =3D
>FIELD_GET(FEATURE_VCPU_BACKBONE,
>+							  hw_config_def0);
>+		p_attr->support_vcore_backbone =3D
>FIELD_GET(FEATURE_VCORE_BACKBONE,
>+							   hw_config_def0);
>+	}
>
> 	setup_wave5_interrupts(vpu_dev);
>
>@@ -403,12 +425,18 @@ int wave5_vpu_init(struct device *dev, u8 *fw,
>size_t size)
> 	common_vb =3D &vpu_dev->common_mem;
>
> 	code_base =3D common_vb->daddr;
>+
>+	if (vpu_dev->product_code =3D=3D WAVE515_CODE)
>+		code_size =3D WAVE515_MAX_CODE_BUF_SIZE;
>+	else
>+		code_size =3D WAVE5_MAX_CODE_BUF_SIZE;
>+
> 	/* ALIGN TO 4KB */
>-	code_size =3D (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
>+	code_size &=3D ~0xfff;
> 	if (code_size < size * 2)
> 		return -EINVAL;
>
>-	temp_base =3D common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
>+	temp_base =3D code_base + code_size;
> 	temp_size =3D WAVE5_TEMPBUF_SIZE;
>
> 	ret =3D wave5_vdi_write_memory(vpu_dev, common_vb, 0, fw, size);
>@@ -436,9 +464,12 @@ int wave5_vpu_init(struct device *dev, u8 *fw,
>size_t size)
>
> 	/* These register must be reset explicitly */
> 	vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
>-	wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>-	wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>-	vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+
>+	if (vpu_dev->product_code !=3D WAVE515_CODE) {
>+		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>+		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>+		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+	}
>
> 	reg_val =3D vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> 	if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
>@@ -453,6 +484,24 @@ int wave5_vpu_init(struct device *dev, u8 *fw,
>size_t size)
> 		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
> 	}
>
>+	if (vpu_dev->product_code =3D=3D WAVE515_CODE) {
>+		dma_addr_t task_buf_base;
>+
>+		vpu_write_reg(vpu_dev, W5_CMD_INIT_NUM_TASK_BUF,
>WAVE515_COMMAND_QUEUE_DEPTH);
>+		vpu_write_reg(vpu_dev, W5_CMD_INIT_TASK_BUF_SIZE,
>WAVE515_ONE_TASKBUF_SIZE);
>+
>+		for (i =3D 0; i < WAVE515_COMMAND_QUEUE_DEPTH; i++) {
>+			task_buf_base =3D temp_base + temp_size +
>+					(i * WAVE515_ONE_TASKBUF_SIZE);
>+			vpu_write_reg(vpu_dev,
>+				      W5_CMD_INIT_ADDR_TASK_BUF0 + (i * 4),
>+				      task_buf_base);
>+		}
>+
>+		vpu_write_reg(vpu_dev, W515_CMD_ADDR_SEC_AXI, vpu_dev-
>>sram_buf.daddr);
>+		vpu_write_reg(vpu_dev, W515_CMD_SEC_AXI_SIZE, vpu_dev-
>>sram_buf.size);
>+	}
>+
> 	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
> 	vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
> 	vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
>@@ -493,29 +542,39 @@ int wave5_vpu_build_up_dec_param(struct
>vpu_instance *inst,
> 		return -EINVAL;
> 	}
>
>-	p_dec_info->vb_work.size =3D WAVE521DEC_WORKBUF_SIZE;
>+	if (vpu_dev->product =3D=3D PRODUCT_ID_515)
>+		p_dec_info->vb_work.size =3D WAVE515DEC_WORKBUF_SIZE;
>+	else
>+		p_dec_info->vb_work.size =3D WAVE521DEC_WORKBUF_SIZE;
>+
> 	ret =3D wave5_vdi_allocate_dma_memory(inst->dev, &p_dec_info-
>>vb_work);
> 	if (ret)
> 		return ret;
>
>-	vpu_write_reg(inst->dev, W5_CMD_DEC_VCORE_INFO, 1);
>+	if (inst->dev->product_code !=3D WAVE515_CODE)
>+		vpu_write_reg(inst->dev, W5_CMD_DEC_VCORE_INFO, 1);
>
> 	wave5_vdi_clear_memory(inst->dev, &p_dec_info->vb_work);
>
> 	vpu_write_reg(inst->dev, W5_ADDR_WORK_BASE, p_dec_info-
>>vb_work.daddr);
> 	vpu_write_reg(inst->dev, W5_WORK_SIZE, p_dec_info->vb_work.size);
>
>-	vpu_write_reg(inst->dev, W5_CMD_ADDR_SEC_AXI, vpu_dev-
>>sram_buf.daddr);
>-	vpu_write_reg(inst->dev, W5_CMD_SEC_AXI_SIZE, vpu_dev-
>>sram_buf.size);
>+	if (inst->dev->product_code !=3D WAVE515_CODE) {
>+		vpu_write_reg(inst->dev, W5_CMD_ADDR_SEC_AXI, vpu_dev-
>>sram_buf.daddr);
>+		vpu_write_reg(inst->dev, W5_CMD_SEC_AXI_SIZE, vpu_dev-
>>sram_buf.size);
>+	}
>
> 	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_START_ADDR, p_dec_info-
>>stream_buf_start_addr);
> 	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_SIZE, p_dec_info-
>>stream_buf_size);
>
> 	/* NOTE: SDMA reads MSB first */
> 	vpu_write_reg(inst->dev, W5_CMD_BS_PARAM,
>BITSTREAM_ENDIANNESS_BIG_ENDIAN);
>-	/* This register must be reset explicitly */
>-	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
>-	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1,
>(COMMAND_QUEUE_DEPTH - 1));
>+
>+	if (inst->dev->product_code !=3D WAVE515_CODE) {
>+		/* This register must be reset explicitly */
>+		vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
>+		vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1,
>(COMMAND_QUEUE_DEPTH - 1));
>+	}
>
> 	ret =3D send_firmware_command(inst, W5_CREATE_INSTANCE, true, NULL,
>NULL);
> 	if (ret) {
>@@ -566,7 +625,7 @@ static u32 get_bitstream_options(struct dec_info
>*info)
> int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
> {
> 	struct dec_info *p_dec_info =3D &inst->codec_info->dec_info;
>-	u32 cmd_option =3D INIT_SEQ_NORMAL;
>+	u32 bs_option, cmd_option =3D INIT_SEQ_NORMAL;
> 	u32 reg_val, fail_res;
> 	int ret;
>
>@@ -576,7 +635,12 @@ int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
> 	vpu_write_reg(inst->dev, W5_BS_RD_PTR, p_dec_info->stream_rd_ptr);
> 	vpu_write_reg(inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
>
>-	vpu_write_reg(inst->dev, W5_BS_OPTION,
>get_bitstream_options(p_dec_info));
>+	bs_option =3D get_bitstream_options(p_dec_info);
>+
>+	if (inst->dev->product_code =3D=3D WAVE515_CODE)
>+		bs_option |=3D BSOPTION_RD_PTR_VALID_FLAG;
>+
>+	vpu_write_reg(inst->dev, W5_BS_OPTION, bs_option);
>
> 	vpu_write_reg(inst->dev, W5_COMMAND_OPTION, cmd_option);
> 	vpu_write_reg(inst->dev, W5_CMD_DEC_USER_MASK, p_dec_info-
>>user_data_enable);
>@@ -642,10 +706,12 @@ static void wave5_get_dec_seq_result(struct
>vpu_instance *inst, struct dec_initi
> 		info->profile =3D FIELD_GET(SEQ_PARAM_PROFILE_MASK, reg_val);
> 	}
>
>-	info->vlc_buf_size =3D vpu_read_reg(inst->dev, W5_RET_VLC_BUF_SIZE);
>-	info->param_buf_size =3D vpu_read_reg(inst->dev,
>W5_RET_PARAM_BUF_SIZE);
>-	p_dec_info->vlc_buf_size =3D info->vlc_buf_size;
>-	p_dec_info->param_buf_size =3D info->param_buf_size;
>+	if (inst->dev->product_code !=3D WAVE515_CODE) {
>+		info->vlc_buf_size =3D vpu_read_reg(inst->dev,
>W5_RET_VLC_BUF_SIZE);
>+		info->param_buf_size =3D vpu_read_reg(inst->dev,
>W5_RET_PARAM_BUF_SIZE);
>+		p_dec_info->vlc_buf_size =3D info->vlc_buf_size;
>+		p_dec_info->param_buf_size =3D info->param_buf_size;
>+	}
> }
>
> int wave5_vpu_dec_get_seq_info(struct vpu_instance *inst, struct
>dec_initial_info *info)
>@@ -747,22 +813,27 @@ int wave5_vpu_dec_register_framebuffer(struct
>vpu_instance *inst, struct frame_b
>
> 		pic_size =3D (init_info->pic_width << 16) | (init_info-
>>pic_height);
>
>-		vb_buf.size =3D (p_dec_info->vlc_buf_size * VLC_BUF_NUM) +
>+		if (inst->dev->product_code !=3D WAVE515_CODE) {
>+			vb_buf.size =3D (p_dec_info->vlc_buf_size * VLC_BUF_NUM)
>+
> 				(p_dec_info->param_buf_size *
>COMMAND_QUEUE_DEPTH);
>-		vb_buf.daddr =3D 0;
>+			vb_buf.daddr =3D 0;
>
>-		if (vb_buf.size !=3D p_dec_info->vb_task.size) {
>-			wave5_vdi_free_dma_memory(inst->dev, &p_dec_info-
>>vb_task);
>-			ret =3D wave5_vdi_allocate_dma_memory(inst->dev,
>&vb_buf);
>-			if (ret)
>-				goto free_fbc_c_tbl_buffers;
>+			if (vb_buf.size !=3D p_dec_info->vb_task.size) {
>+				wave5_vdi_free_dma_memory(inst->dev,
>+							  &p_dec_info->vb_task);
>+				ret =3D wave5_vdi_allocate_dma_memory(inst->dev,
>+								    &vb_buf);
>+				if (ret)
>+					goto free_fbc_c_tbl_buffers;
>
>-			p_dec_info->vb_task =3D vb_buf;
>-		}
>+				p_dec_info->vb_task =3D vb_buf;
>+			}
>
>-		vpu_write_reg(inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
>-			      p_dec_info->vb_task.daddr);
>-		vpu_write_reg(inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE,
>vb_buf.size);
>+			vpu_write_reg(inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
>+				      p_dec_info->vb_task.daddr);
>+			vpu_write_reg(inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE,
>+				      vb_buf.size);
>+		}
> 	} else {
> 		pic_size =3D (init_info->pic_width << 16) | (init_info-
>>pic_height);
>
>@@ -999,17 +1070,24 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw,
>size_t size)
> 	dma_addr_t code_base, temp_base;
> 	dma_addr_t old_code_base, temp_size;
> 	u32 code_size, reason_code;
>-	u32 reg_val;
>+	u32 i, reg_val;
> 	struct vpu_device *vpu_dev =3D dev_get_drvdata(dev);
>
> 	common_vb =3D &vpu_dev->common_mem;
>
> 	code_base =3D common_vb->daddr;
>+
>+	if (vpu_dev->product_code =3D=3D WAVE515_CODE)
>+		code_size =3D WAVE515_MAX_CODE_BUF_SIZE;
>+	else
>+		code_size =3D WAVE5_MAX_CODE_BUF_SIZE;
>+
> 	/* ALIGN TO 4KB */
>-	code_size =3D (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
>+	code_size &=3D ~0xfff;
> 	if (code_size < size * 2)
> 		return -EINVAL;
>-	temp_base =3D common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
>+
>+	temp_base =3D code_base + code_size;
> 	temp_size =3D WAVE5_TEMPBUF_SIZE;
>
> 	old_code_base =3D vpu_read_reg(vpu_dev, W5_VPU_REMAP_PADDR);
>@@ -1043,9 +1121,12 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw,
>size_t size)
>
> 		/* These register must be reset explicitly */
> 		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
>-		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>-		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>-		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+
>+		if (vpu_dev->product_code !=3D WAVE515_CODE) {
>+			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR,
>0);
>+			wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>+			vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+		}
>
> 		reg_val =3D vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> 		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
>@@ -1060,6 +1141,28 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw,
>size_t size)
> 			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID,
>reg_val);
> 		}
>
>+		if (vpu_dev->product_code =3D=3D WAVE515_CODE) {
>+			dma_addr_t task_buf_base;
>+
>+			vpu_write_reg(vpu_dev, W5_CMD_INIT_NUM_TASK_BUF,
>+				      WAVE515_COMMAND_QUEUE_DEPTH);
>+			vpu_write_reg(vpu_dev, W5_CMD_INIT_TASK_BUF_SIZE,
>+				      WAVE515_ONE_TASKBUF_SIZE);
>+
>+			for (i =3D 0; i < WAVE515_COMMAND_QUEUE_DEPTH; i++) {
>+				task_buf_base =3D temp_base + temp_size +
>+						(i * WAVE515_ONE_TASKBUF_SIZE);
>+				vpu_write_reg(vpu_dev,
>+					      W5_CMD_INIT_ADDR_TASK_BUF0 + (i * 4),
>+					      task_buf_base);
>+			}
>+
>+			vpu_write_reg(vpu_dev, W515_CMD_ADDR_SEC_AXI,
>+				      vpu_dev->sram_buf.daddr);
>+			vpu_write_reg(vpu_dev, W515_CMD_SEC_AXI_SIZE,
>+				      vpu_dev->sram_buf.size);
>+		}
>+
> 		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
> 		vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
> 		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
>@@ -1081,10 +1184,10 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw,
>size_t size)
> static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake,
>const uint16_t *code,
> 				size_t size)
> {
>-	u32 reg_val;
>+	u32 i, reg_val;
> 	struct vpu_buf *common_vb;
>-	dma_addr_t code_base;
>-	u32 code_size, reason_code;
>+	dma_addr_t code_base, temp_base;
>+	u32 code_size, temp_size, reason_code;
> 	struct vpu_device *vpu_dev =3D dev_get_drvdata(dev);
> 	int ret;
>
>@@ -1114,13 +1217,22 @@ static int wave5_vpu_sleep_wake(struct device
>*dev, bool i_sleep_wake, const uin
> 		common_vb =3D &vpu_dev->common_mem;
>
> 		code_base =3D common_vb->daddr;
>+
>+		if (vpu_dev->product_code =3D=3D WAVE515_CODE)
>+			code_size =3D WAVE515_MAX_CODE_BUF_SIZE;
>+		else
>+			code_size =3D WAVE5_MAX_CODE_BUF_SIZE;
>+
> 		/* ALIGN TO 4KB */
>-		code_size =3D (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
>+		code_size &=3D ~0xfff;
> 		if (code_size < size * 2) {
> 			dev_err(dev, "size too small\n");
> 			return -EINVAL;
> 		}
>
>+		temp_base =3D code_base + code_size;
>+		temp_size =3D WAVE5_TEMPBUF_SIZE;
>+
> 		/* Power on without DEBUG mode */
> 		vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
>
>@@ -1133,9 +1245,12 @@ static int wave5_vpu_sleep_wake(struct device *dev,
>bool i_sleep_wake, const uin
>
> 		/* These register must be reset explicitly */
> 		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
>-		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, 0);
>-		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>-		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+
>+		if (vpu_dev->product_code !=3D WAVE515_CODE) {
>+			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR,
>0);
>+			wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
>+			vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
>+		}
>
> 		setup_wave5_interrupts(vpu_dev);
>
>@@ -1152,6 +1267,28 @@ static int wave5_vpu_sleep_wake(struct device *dev,
>bool i_sleep_wake, const uin
> 			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID,
>reg_val);
> 		}
>
>+		if (vpu_dev->product_code =3D=3D WAVE515_CODE) {
>+			dma_addr_t task_buf_base;
>+
>+			vpu_write_reg(vpu_dev, W5_CMD_INIT_NUM_TASK_BUF,
>+				      WAVE515_COMMAND_QUEUE_DEPTH);
>+			vpu_write_reg(vpu_dev, W5_CMD_INIT_TASK_BUF_SIZE,
>+				      WAVE515_ONE_TASKBUF_SIZE);
>+
>+			for (i =3D 0; i < WAVE515_COMMAND_QUEUE_DEPTH; i++) {
>+				task_buf_base =3D temp_base + temp_size +
>+						(i * WAVE515_ONE_TASKBUF_SIZE);
>+				vpu_write_reg(vpu_dev,
>+					      W5_CMD_INIT_ADDR_TASK_BUF0 + (i * 4),
>+					      task_buf_base);
>+			}
>+
>+			vpu_write_reg(vpu_dev, W515_CMD_ADDR_SEC_AXI,
>+				      vpu_dev->sram_buf.daddr);
>+			vpu_write_reg(vpu_dev, W515_CMD_SEC_AXI_SIZE,
>+				      vpu_dev->sram_buf.size);
>+		}
>+
> 		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
> 		vpu_write_reg(vpu_dev, W5_COMMAND, W5_WAKEUP_VPU);
> 		/* Start VPU after settings */
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
>b/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
>index a15c6b2c3d8b..557344754c4c 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
>@@ -205,6 +205,9 @@ enum query_opt {
> #define W5_ADDR_TEMP_BASE                       (W5_REG_BASE + 0x011C)
> #define W5_TEMP_SIZE                            (W5_REG_BASE + 0x0120)
> #define W5_HW_OPTION                            (W5_REG_BASE + 0x012C)
>+#define W5_CMD_INIT_NUM_TASK_BUF		(W5_REG_BASE + 0x0134)
>+#define W5_CMD_INIT_ADDR_TASK_BUF0		(W5_REG_BASE + 0x0138)
>+#define W5_CMD_INIT_TASK_BUF_SIZE		(W5_REG_BASE + 0x0178)
> #define W5_SEC_AXI_PARAM                        (W5_REG_BASE + 0x0180)
>
>
>/************************************************************************
>/
>@@ -216,7 +219,9 @@ enum query_opt {
> #define W5_CMD_DEC_BS_SIZE                      (W5_REG_BASE + 0x0120)
> #define W5_CMD_BS_PARAM                         (W5_REG_BASE + 0x0124)
> #define W5_CMD_ADDR_SEC_AXI                     (W5_REG_BASE + 0x0130)
>+#define W515_CMD_ADDR_SEC_AXI			(W5_REG_BASE + 0x0124)
> #define W5_CMD_SEC_AXI_SIZE                     (W5_REG_BASE + 0x0134)
>+#define W515_CMD_SEC_AXI_SIZE			(W5_REG_BASE + 0x0128)
> #define W5_CMD_EXT_ADDR                         (W5_REG_BASE + 0x0138)
> #define W5_CMD_NUM_CQ_DEPTH_M1                  (W5_REG_BASE + 0x013C)
> #define W5_CMD_ERR_CONCEAL                      (W5_REG_BASE + 0x0140)
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>index a63fffed55e9..78888c57b6da 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>@@ -18,7 +18,11 @@ static int wave5_vdi_allocate_common_memory(struct
>device *dev)
> 	if (!vpu_dev->common_mem.vaddr) {
> 		int ret;
>
>-		vpu_dev->common_mem.size =3D SIZE_COMMON;
>+		if (vpu_dev->product_code =3D=3D WAVE515_CODE)
>+			vpu_dev->common_mem.size =3D WAVE515_SIZE_COMMON;
>+		else
>+			vpu_dev->common_mem.size =3D SIZE_COMMON;
>+
> 		ret =3D wave5_vdi_allocate_dma_memory(vpu_dev, &vpu_dev-
>>common_mem);
> 		if (ret) {
> 			dev_err(dev, "unable to allocate common buffer\n");
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>index 5a71a711f2e8..65a99053c5e8 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>@@ -1869,7 +1869,8 @@ static int wave5_vpu_open_dec(struct file *filp)
> 		goto cleanup_inst;
> 	}
>
>-	wave5_vdi_allocate_sram(inst->dev);
>+	if (inst->dev->product_code !=3D WAVE515_CODE)
>+		wave5_vdi_allocate_sram(inst->dev);
>
> 	return 0;
>
>@@ -1897,6 +1898,14 @@ int wave5_vpu_dec_register_device(struct
>vpu_device *dev)
> 	struct video_device *vdev_dec;
> 	int ret;
>
>+	/*
>+	 * secondary AXI setup for Wave515 is done by INIT_VPU command,
>+	 * that's why SRAM memory is allocated at VPU device register
>+	 * rather than at device open.
>+	 */
>+	if (dev->product_code =3D=3D WAVE515_CODE)
>+		wave5_vdi_allocate_sram(dev);
>+
> 	vdev_dec =3D devm_kzalloc(dev->v4l2_dev.dev, sizeof(*vdev_dec),
>GFP_KERNEL);
> 	if (!vdev_dec)
> 		return -ENOMEM;
>@@ -1930,6 +1939,9 @@ int wave5_vpu_dec_register_device(struct vpu_device
>*dev)
>
> void wave5_vpu_dec_unregister_device(struct vpu_device *dev)
> {
>+	if (dev->product_code =3D=3D WAVE515_CODE)
>+		wave5_vdi_free_sram(dev);
>+
> 	video_unregister_device(dev->video_dev_dec);
> 	if (dev->v4l2_m2m_dec_dev)
> 		v4l2_m2m_release(dev->v4l2_m2m_dec_dev);
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>index 2a972cddf4a6..fc267348399e 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>@@ -60,7 +60,13 @@ static irqreturn_t wave5_vpu_irq_thread(int irq, void
>*dev_id)
>
> 			if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
> 			    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
>-				if (seq_done & BIT(inst->id)) {
>+				if ((dev->product_code =3D=3D WAVE515_CODE) &&
>+				    (cmd_done & BIT(inst->id))) {
>+					cmd_done &=3D ~BIT(inst->id);
>+					wave5_vdi_write_register(dev,
>W5_RET_QUEUE_CMD_DONE_INST,
>+								 cmd_done);
>+					complete(&inst->irq_done);
>+				} else if (seq_done & BIT(inst->id)) {
> 					seq_done &=3D ~BIT(inst->id);
> 					wave5_vdi_write_register(dev,
>W5_RET_SEQ_DONE_INSTANCE_INFO,
> 								 seq_done);
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>index 975d96b22191..601205df4433 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>@@ -18,6 +18,7 @@
> #include "wave5-vdi.h"
>
> enum product_id {
>+	PRODUCT_ID_515,
> 	PRODUCT_ID_521,
> 	PRODUCT_ID_511,
> 	PRODUCT_ID_517,
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>index 9d99afb78c89..b4128524fcfd 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>@@ -8,6 +8,7 @@
> #ifndef _VPU_CONFIG_H_
> #define _VPU_CONFIG_H_
>
>+#define WAVE515_CODE			0x5150
> #define WAVE517_CODE                    0x5170
> #define WAVE537_CODE                    0x5370
> #define WAVE511_CODE                    0x5110
>@@ -21,12 +22,13 @@
> 		((c) =3D=3D WAVE517_CODE ||	(c) =3D=3D WAVE537_CODE ||		\
> 		 (c) =3D=3D WAVE511_CODE || (c) =3D=3D WAVE521_CODE ||		\
> 		 (c) =3D=3D WAVE521E1_CODE || (c) =3D=3D WAVE521C_CODE ||	\
>-		 (c) =3D=3D WAVE521C_DUAL_CODE);				\
>+		 (c) =3D=3D WAVE521C_DUAL_CODE) || (c) =3D=3D WAVE515_CODE;	\
> })
>
> #define WAVE517_WORKBUF_SIZE            (2 * 1024 * 1024)
> #define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K, AV=
C
>40K
> #define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
>+#define WAVE515DEC_WORKBUF_SIZE		(2 * 1024 * 1024)
>
> #define WAVE5_MAX_SRAM_SIZE		(64 * 1024)
>
>@@ -52,16 +54,21 @@
> #define VLC_BUF_NUM                     (2)
>
> #define COMMAND_QUEUE_DEPTH             (2)
>+#define WAVE515_COMMAND_QUEUE_DEPTH	(4)
>
> #define W5_REMAP_INDEX0                 0
> #define W5_REMAP_INDEX1                 1
> #define W5_REMAP_MAX_SIZE               (1024 * 1024)
>
> #define WAVE5_MAX_CODE_BUF_SIZE         (2 * 1024 * 1024)
>+#define WAVE515_MAX_CODE_BUF_SIZE	(1024 * 1024)
> #define WAVE5_TEMPBUF_OFFSET            WAVE5_MAX_CODE_BUF_SIZE
> #define WAVE5_TEMPBUF_SIZE              (1024 * 1024)
>+#define WAVE515_TASKBUF_OFFSET		(WAVE515_MAX_CODE_BUF_SIZE +
>WAVE5_TEMPBUF_SIZE)
>
> #define SIZE_COMMON                 (WAVE5_MAX_CODE_BUF_SIZE +
>WAVE5_TEMPBUF_SIZE)
>+#define WAVE515_ONE_TASKBUF_SIZE	(8 * 1024 * 1024)
>+#define WAVE515_SIZE_COMMON	(WAVE515_TASKBUF_OFFSET +
>WAVE515_COMMAND_QUEUE_DEPTH * WAVE515_ONE_TASKBUF_SIZE)
>
> //=3D=3D=3D=3D=3D4. VPU REPORT MEMORY  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D//
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5.h
>b/drivers/media/platform/chips-media/wave5/wave5.h
>index 063028eccd3b..57b00e182b6e 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5.h
>+++ b/drivers/media/platform/chips-media/wave5/wave5.h
>@@ -22,6 +22,7 @@
>  */
> #define BSOPTION_ENABLE_EXPLICIT_END		BIT(0)
> #define BSOPTION_HIGHLIGHT_STREAM_END		BIT(1)
>+#define BSOPTION_RD_PTR_VALID_FLAG		BIT(31)
>
> /*
>  * Currently the driver only supports hardware with little endian but for
>source
>--
>2.44.0


