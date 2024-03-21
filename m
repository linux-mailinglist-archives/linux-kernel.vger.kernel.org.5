Return-Path: <linux-kernel+bounces-109851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6580885682
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60A2282442
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108FA5336F;
	Thu, 21 Mar 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="VdziMD1s"
Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11020003.outbound.protection.outlook.com [52.101.154.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341A125CB;
	Thu, 21 Mar 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013350; cv=fail; b=ZHSkP9RHP1Hn16jDqjZciZn2dfbskCEjU2T3oe05pykELrGmzTVa0zP0pTb+bH9r6osbJKd8RVZug9R8ToTFciT8tcsKEBotf6jjQaem0lyzPvpaeraEIyqR5oR0b45jKbPO/6jpt0lKynEGrJXjdteWnmq/mZMkDzGcD3OihxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013350; c=relaxed/simple;
	bh=8QGCPa4wBcvvZJegQSNewRXHMwUGdjuHjvv8zFMu4j8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVsw6cwhP3xdRwbqnUjk0FueCM0M5hH910cK3raFPZUNiY3vYd+DH1HF+CudV4ByWAtFDRBHNBLoXB8z3aTzFlPg1WRDoaM5xhRhydRCVDAebP/pI4/Xjm3pHwMJGaOcJkmmPP3xwYJNNvgdTbjNo1rtPqpdxeOKh00X+ox/3Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=VdziMD1s; arc=fail smtp.client-ip=52.101.154.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrcjaLbE+ybw/Hf3NadsSLPR00JgKb9vfK1xYpjC8Ayu4xeASQwZDU6fHg9W7TmygiDjrTHIuIz8DLzBP7hCXEWbCOTyp1AtjPnCQsvgsWFVyXhfNqZRdHiHD/Ybu4+pndRQjYfwC4oKTqCy+qgbUY4DMtpBtjVPUdf/pHC+gAHxIW7qyXZ0YZnOkojYOfCzKx5k2YkIpxk9/vkVDsSFVwdHB7d375EKIcw/nfddvbNAT5HYhksNrpCoploioBrHvVSAT62hquFwl5s4YTTmQChaBaEWMRhIlrRie8x6rxObhT0WHpSI95OtJXNVm1ASxY7zsXW4o2rp8O6yvkFhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhvfsOP65CjnZhLBcCbVQj8euo8EH7P+Qwk2ZDOoNbo=;
 b=Gfm2lMaVMKJAxCC2FUZWIpjEw9FA2O14L0XZAV7ifwIOyowmPMhoWsKt4+xuEtqH2IQ+6xKl9aB2gJW8mYNq+wvn+ZwyrjZBZnivKZSbTOHSDDcKzgEwgpYaoL4E81cnc/0OLZGb01diABQYRyReNWJARoLb2sWdgxoVJ9xEeXxDDLKWe9EVHnC9YhUh303mB2Y4hLwyR+JjQySKgzWCbJtVRGMjy/30LlXjJHRbsOp4W88QZH03I4ly8e7U8YmRfQgk3t0pSLwxen93ZyAa9NjYS5oThGYzaWP4FPj8NyTzoa+LXyNpb0uUznWkofUPeCAHxudexnGZEQSCwZV9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhvfsOP65CjnZhLBcCbVQj8euo8EH7P+Qwk2ZDOoNbo=;
 b=VdziMD1sOdjXk6Yq7d2jfjIFJhanMPOAVj6Rexu34GXkrSns54Y7nIl3CDgYgSetTqEEFWJJsdFgwMxCDNJxQkx4A8JWwMfQR4K+eis/Znug7AAykbHr7QQCtZ1qcHcuC38mCZiFQOW1hhkvfj6a5XyOV+1jPbc+ifk6Z5kaT5M=
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 SE1P216MB1244.KORP216.PROD.OUTLOOK.COM (2603:1096:101:14::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Thu, 21 Mar 2024 09:29:04 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 09:29:04 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: Brandon Brnich <b-brnich@ti.com>, Ivan Bornyakov <brnkv.i1@gmail.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, jackson.lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Thread-Topic: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
Thread-Index: AQHaekCTjJVqcNFgQEW+NkXMf3eCS7FB2LZg
Date: Thu, 21 Mar 2024 09:29:04 +0000
Message-ID:
 <SL2P216MB12468C7256CE2468EE088E7CFB322@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
 <20240318144225.30835-6-brnkv.i1@gmail.com>
 <SL2P216MB1246F7FA7E95896AA2409C90FB2C2@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <hpqhbksvyfbqjumopk2k2drxri2ycb6j2dbdo74cfymcd7blgx@kzomazfosfwg>
 <20240319210106.awn33cm7ex33g65b@udba0500997>
In-Reply-To: <20240319210106.awn33cm7ex33g65b@udba0500997>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB1246:EE_|SE1P216MB1244:EE_
x-ms-office365-filtering-correlation-id: 3920f9e6-c509-4d9b-871c-08dc4989598d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wBwAeizXsgTZ/I/GPUkV20kSlJyozIU5ZSPMHQkuyP+V0x/pHi53FBUXdBZB4WQTTGDuGr8yfnP13gyb6APDD7Zxykg5lhNjjAbGBUmUE+de2W85p7ZHYPuSQU4EfoP08NZ1va++vrd4JaVcPx3O59zji+VVD7zXYHn1XQmqBGMpaiv9ALhaGE1K1rbkoMSTs+bTUkF6cRB3rMguvh1SNkLRNTUe2OZDPOHSOY4LOsmkrXn7yvh6lXw60VwCkOsjtWogNlkeCDmq3dGOrbGqUb+w9Hr2niHgO8ZdlNAqJhp+/nsGaszleku6YbcRF8heT0xYz/vZ9rIomw4e1rQaFMsESJy8K0gGdcROJ4HLkg2SZTYv9/7waSHWWvQyRRX0LENtgQUpq3cEIUi3LKUtWE+hrrPAPTxHDLkOYwjXV2oRMEVxiTQ1oGH8ODdyevjpIVESUEpcnWKoOEtIzFa5n4CpgDgTHedwjJpVGwO61bDHKZ+cKNZjNiY8q6SkHTubXfsn5oqBhsNQmlbDWkNcjSkuN1zcUKZXSOMtF8XJxEnBdk6l5+rojv+v/91/25emrk2va2exH0PZIHJ35Ngtix6LDvxyRWKqJqIMcrogk3DdFn8NT7k9zipu4+MUL31uNJTiiheKcuZeccvr8ySwkgxFXxMz8jbtYWHjZuO4rvM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LNaMyYXKpGnW6hWrDiEEDflpkIWliw+iEdKNI4RVHBqsen1t9YW5qYBu/04t?=
 =?us-ascii?Q?WAxafYhL+Cw74uhOXepQ8+1ARcZkSvcGP/INzk7CpH7BpcphBN7hkkaT4ZoI?=
 =?us-ascii?Q?yERQGUgwGFIM4nhZBrHImogtXzH/7oTUdkpXB17uEHsuC1Hijc3k0bclg7jW?=
 =?us-ascii?Q?ibQy82PosidfgKDW1u/iC32+D4/kxCsLOaosY0FaG/amOO0AXmGPhOmC4nYw?=
 =?us-ascii?Q?qOBgiBoZ/ZcolvVl2sP9KvdUt6edh2RlksDIwgtFiSVq0PryMgAiS+KRyQNw?=
 =?us-ascii?Q?U7bI3aXzSuIvO69lUIdIBSdKwMCx8Q906A+iCPPZvVr0F9QnElbuGVaC3KXE?=
 =?us-ascii?Q?NO3dAfeBr8HWojONHRwvwnw71UIjOk9slb0RtZ7JaxykWv6CugTt2TdAWQ2t?=
 =?us-ascii?Q?aY0r6gh5JKc0bPV1prWc+E2Fz96jyRDHjDKSHPYGWnWR/xBHtLlHH5wwMTrV?=
 =?us-ascii?Q?RTk5lZMBjA4LlkUmmYTqgbFr1+6AyXPsoX3lCzAkaGGcdrEs9CKvfe4U9GKq?=
 =?us-ascii?Q?w2oMVi/l1oo2cW/Ipp6HSE2UniZ0PblweXZGDYKj6csjtFBsoJc0DLxAldHZ?=
 =?us-ascii?Q?diB41p3gd2/vbHGvUD041Pm8Dhtw8gZMVr0LS195PUe1Evxk/5sR/BzMtjYL?=
 =?us-ascii?Q?cqZGeSAdN8ERtARmXPS5LzzoaPxdLq/17FtzCiiDaNT7k3vGiNdnUUyiWrr9?=
 =?us-ascii?Q?GrQ6nli2nsLYsfdfVyrt7msPXM0au5hLKZA7jUoFno+y8c6mluKz4S7rC9Vw?=
 =?us-ascii?Q?0+osmZHsTb6xHZjuBXgHOo7Q54DPC9q6TUh38VAuUNUkNiVz0jHiTq8lbNqE?=
 =?us-ascii?Q?f0unZTThh14GlB1IujQWurI3DlslcOzHYt9GgMbwhj4C0ZIuYwsz0KOv0BGi?=
 =?us-ascii?Q?k4z0eEyaaZazqWK231OL2UDu5kQCFEKvlsFFEjMybrpH4eGTYgD5/YVJlFDC?=
 =?us-ascii?Q?CRyq2WSazFsACPNGmUZzJyrlTBzhq+OdjpZo8o+kklV7t9s9K20Vc9n2yXGz?=
 =?us-ascii?Q?j+OqAxecJXJM6yI4EJmOeacEio5Ei1owo8FheNQP11KWOumsX0WR9ahWpwM0?=
 =?us-ascii?Q?bgcvYoO7sr10lQ7RnUX7I5MSvaRTtiEkAb2MLSy7sOm2L1Oz87DHawX85CZl?=
 =?us-ascii?Q?eCxxMWxK3g3CnfEZ6E5ereo91sQuxu1EqnmjVbql/ayGDODCnPDQnbaPBTCH?=
 =?us-ascii?Q?wbLyW7jx42KsCKa7MlUEeTP/vdTpESD5ukQ+PANS7a8RnTKRyNBEUp5xvg0z?=
 =?us-ascii?Q?PzyKnmtUMi60LHFAfizyWY+tfitDBou6DDV96XtJuVkcM7/oS4RSgLuqRaXi?=
 =?us-ascii?Q?bs3jMJ3QO7LWfovA7MlsxJ51g/dxl8r3LTcyy+V5Scpom3GW7j0Kwk2xwXRu?=
 =?us-ascii?Q?OJwM43wadM170CiJbwVfMph6aqtI07HRELHu6lM5E+P/CZYl22aATmZ2zanP?=
 =?us-ascii?Q?q04TKMdsD9bMs6cHuWmSS4EQhIVpRjiuUElQdXZ2e4iZBkfcF6XNds9z0eso?=
 =?us-ascii?Q?We68A2/1eG2eNWMlhO2ikCc+nAq3EUTiZ6SjZKw+ud0FkNYEk4e+KYSYXoXQ?=
 =?us-ascii?Q?uHHvEgFjPPfb/bAk/6iH5JrrIEtDa+UwgACzuex5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3920f9e6-c509-4d9b-871c-08dc4989598d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 09:29:04.1399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRLal1GgKHRWXTSBnEWFXCni34TBOZWWaQvkA7HyJBR6daX5HKG5KhQWvirltk7Ixmvwri2UZCNeSYsO2Ohsm0MfmYR8hq0sULD6ouERRxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1244

Hi, Ivan and Brandon.

>-----Original Message-----
>From: Brandon Brnich <b-brnich@ti.com>
>Sent: Wednesday, March 20, 2024 6:01 AM
>To: Ivan Bornyakov <brnkv.i1@gmail.com>
>Cc: Nas Chung <nas.chung@chipsnmedia.com>; Philipp Zabel
><p.zabel@pengutronix.de>; Rob Herring <robh@kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
><conor+dt@kernel.org>; linux-media@vger.kernel.org; linux-
>kernel@vger.kernel.org; devicetree@vger.kernel.org; jackson.lee
><jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>
>Subject: Re: [PATCH 5/6] media: chips-media: wave5: refine SRAM usage
>
>Hi Ivan,
>
>On 14:24-20240319, Ivan Bornyakov wrote:
>> Hello, Nas
>>
>> On Tue, Mar 19, 2024 at 10:56:22AM +0000, Nas Chung wrote:
>> > Hi, Ivan.
>> >
>> > >
>> > >Allocate SRAM memory on module probe, free on remove. There is no
>need
>> > >to allocate on device open, free on close, the memory is the same
>every
>> > >time.
>> >
>> > If there is no decoder/encoder instance, driver don't need to
>allocate SRAM memory.
>> > The main reason of allocating the memory in open() is to allow other
>modules to
>> > use more SRAM memory, if wave5 is not working.
>
>I have to agree with this statement. Moving allocation to probe results
>in wasting SRAM when VPU is not in use. VPU should only be allocating
>SRAM
>when a stream instance is running and free that back once all instances
>close.
>
>> > >
>> > >Also use gen_pool_size() to determine SRAM memory size to be
>allocated
>> > >instead of separate "sram-size" DT property to reduce duplication.
>> > >
>> > >Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
>> > >---
>> > > .../platform/chips-media/wave5/wave5-helper.c |  3 ---
>> > > .../platform/chips-media/wave5/wave5-vdi.c    | 21 ++++++++++-------
>--
>> > > .../chips-media/wave5/wave5-vpu-dec.c         |  2 --
>> > > .../chips-media/wave5/wave5-vpu-enc.c         |  2 --
>> > > .../platform/chips-media/wave5/wave5-vpu.c    | 12 +++++------
>> > > .../platform/chips-media/wave5/wave5-vpuapi.h |  1 -
>> > > 6 files changed, 16 insertions(+), 25 deletions(-)
>> > >
>> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>> > >b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>> > >index 8433ecab230c..ec710b838dfe 100644
>> > >--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
>> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
>> > >@@ -29,9 +29,6 @@ void wave5_cleanup_instance(struct vpu_instance
>*inst)
>> > > {
>> > > 	int i;
>> > >
>> > >-	if (list_is_singular(&inst->list))
>> > >-		wave5_vdi_free_sram(inst->dev);
>> > >-
>> > > 	for (i =3D 0; i < inst->fbc_buf_count; i++)
>> > > 		wave5_vpu_dec_reset_framebuffer(inst, i);
>> > >
>> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> > >b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> > >index 3809f70bc0b4..ee671f5a2f37 100644
>> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
>> > >@@ -174,16 +174,19 @@ int wave5_vdi_allocate_array(struct vpu_device
>> > >*vpu_dev, struct vpu_buf *array,
>> > > void wave5_vdi_allocate_sram(struct vpu_device *vpu_dev)
>> > > {
>> > > 	struct vpu_buf *vb =3D &vpu_dev->sram_buf;
>> > >+	dma_addr_t daddr;
>> > >+	void *vaddr;
>> > >+	size_t size;
>> > >
>> > >-	if (!vpu_dev->sram_pool || !vpu_dev->sram_size)
>> > >+	if (!vpu_dev->sram_pool || vb->vaddr)
>> > > 		return;
>> > >
>> > >-	if (!vb->vaddr) {
>> > >-		vb->size =3D vpu_dev->sram_size;
>> > >-		vb->vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, vb->size,
>> > >-					       &vb->daddr);
>> > >-		if (!vb->vaddr)
>> > >-			vb->size =3D 0;
>> > >+	size =3D gen_pool_size(vpu_dev->sram_pool);
>> > >+	vaddr =3D gen_pool_dma_alloc(vpu_dev->sram_pool, size, &daddr);
>> > >+	if (vaddr) {
>> > >+		vb->vaddr =3D vaddr;
>> > >+		vb->daddr =3D daddr;
>> > >+		vb->size =3D size;
>> > > 	}
>> > >
>> > > 	dev_dbg(vpu_dev->dev, "%s: sram daddr: %pad, size: %zu, vaddr:
>> > >0x%p\n",
>> > >@@ -197,9 +200,7 @@ void wave5_vdi_free_sram(struct vpu_device
>*vpu_dev)
>> > > 	if (!vb->size || !vb->vaddr)
>> > > 		return;
>> > >
>> > >-	if (vb->vaddr)
>> > >-		gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr,
>> > >-			      vb->size);
>> > >+	gen_pool_free(vpu_dev->sram_pool, (unsigned long)vb->vaddr, vb-
>> > >>size);
>> > >
>> > > 	memset(vb, 0, sizeof(*vb));
>> > > }
>> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-
>dec.c
>> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> > >index aa0401f35d32..84dbe56216ad 100644
>> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> > >@@ -1854,8 +1854,6 @@ static int wave5_vpu_open_dec(struct file
>*filp)
>> > > 		goto cleanup_inst;
>> > > 	}
>> > >
>> > >-	wave5_vdi_allocate_sram(inst->dev);
>> > >-
>> > > 	return 0;
>> > >
>> > > cleanup_inst:
>> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-
>enc.c
>> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> > >index 8bbf9d10b467..86ddcb82443b 100644
>> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> > >@@ -1727,8 +1727,6 @@ static int wave5_vpu_open_enc(struct file
>*filp)
>> > > 		goto cleanup_inst;
>> > > 	}
>> > >
>> > >-	wave5_vdi_allocate_sram(inst->dev);
>> > >-
>> > > 	return 0;
>> > >
>> > > cleanup_inst:
>> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> > >b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> > >index f3ecadefd37a..2a0a70dd7062 100644
>> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
>> > >@@ -178,16 +178,11 @@ static int wave5_vpu_probe(struct
>platform_device
>> > >*pdev)
>> > > 		return ret;
>> > > 	}
>> > >
>> > >-	ret =3D of_property_read_u32(pdev->dev.of_node, "sram-size",
>> > >-				   &dev->sram_size);
>> > >-	if (ret) {
>> > >-		dev_warn(&pdev->dev, "sram-size not found\n");
>> > >-		dev->sram_size =3D 0;
>> > >-	}
>> > >-
>> >
>> > Required SRAM size is different from each wave5 product.
>> > And, SoC vendor also can configure the different SRAM size
>> > depend on target SoC specification even they use the same wave5
>product.
>> >
>>
>> One can limit iomem address range in SRAM node. Here is the example of
>> how I setup Wave515 with SRAM:
>>
>> 	sram@2000000 {
>> 		compatible =3D "mmio-sram";
>> 		reg =3D <0x0 0x2000000 0x0 0x80000>;
>> 		#address-cells =3D <1>;
>> 		#size-cells =3D <1>;
>> 		ranges =3D <0x0 0x0 0x2000000 0x80000>;
>>
>> 		wave515_vpu_sram: wave515-vpu-sram@0 {
>> 			reg =3D <0x0 0x80000>;
>> 			pool;
>> 		};
>> 	};
>>
>> 	wave515@410000 {
>> 		compatible =3D "cnm,wave515";
>> 		reg =3D <0x0 0x410000 0x0 0x10000>;
>> 		clocks =3D <&clk_ref1>;
>> 		clock-names =3D "videc";
>> 		interrupt-parent =3D <&wave515_intc>;
>> 		interrupts =3D <16 IRQ_TYPE_LEVEL_HIGH>;
>> 		resets =3D <&wave515_reset 0>,
>> 			 <&wave515_reset 4>,
>> 			 <&wave515_reset 8>,
>> 			 <&wave515_reset 12>;
>> 		sram =3D <&wave515_vpu_sram>;
>> 	};
>>
>> gen_pool_size() returns size of wave515_vpu_sram, no need for extra
>> "sram-size" property.

Thanks for sharing the example.
I agree that the "sram-size" property is not needed.

>
>"sram-size" property does need to be removed, as this was the consensus
>gathered from my patch[0]. However, I think your method is still taking

I missed the previous consensus for the sram-size property.
Thanks for letting me know.

>a more static approach. One of the recommendations in my thread[1] was
>making a list of known SRAM sizes given typical resolutions and
>iterating through until a valid allocation is done. I don't think this
>is the correct approach either based on Nas's comment that each Wave5
>has different SRAM size requirement. It would clutter up the file too
>much if each wave5 product had its own SRAM size mapping.
>
>Could another approach be to change Wave5 dts node to have property set
>as "sram =3D <&sram>;" in your example, then driver calls
>gen_pool_availble to get size remaining? From there, a check could be
>put in place to make sure an unnecessary amount is not being allocated.

Ivan's approach looks good to me.
It is similar to your first patch, which adds the sram-size property
to configure different SRAM sizes for each device.
And, Driver won't know unnecessary amount is allocated before parsing
bitstream header.

>
>
>[0]:
>https://lore.kernel.org/lkml/99bf4d6d988d426492fffc8de9015751c323bd8a.cam
>el@ndufresne.ca/
>[1]: https://lore.kernel.org/lkml/9c5b7b2c-8a66-4173-dfe9-
>5724ec5f733d@ti.com/
>
>Thanks,
>Brandon
>>
>> > Thanks.
>> > Nas.
>> >
>> > > 	dev->sram_pool =3D of_gen_pool_get(pdev->dev.of_node, "sram", 0);
>> > > 	if (!dev->sram_pool)
>> > > 		dev_warn(&pdev->dev, "sram node not found\n");
>> > >+	else
>> > >+		wave5_vdi_allocate_sram(dev);
>> > >
>> > > 	dev->product_code =3D wave5_vdi_read_register(dev,
>> > >VPU_PRODUCT_CODE_REGISTER);
>> > > 	ret =3D wave5_vdi_init(&pdev->dev);
>> > >@@ -259,6 +254,8 @@ static int wave5_vpu_probe(struct
>platform_device
>> > >*pdev)
>> > > err_clk_dis:
>> > > 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
>> > >
>> > >+	wave5_vdi_free_sram(dev);
>> > >+
>> > > 	return ret;
>> > > }
>> > >
>> > >@@ -275,6 +272,7 @@ static void wave5_vpu_remove(struct
>platform_device
>> > >*pdev)
>> > > 	v4l2_device_unregister(&dev->v4l2_dev);
>> > > 	wave5_vdi_release(&pdev->dev);
>> > > 	ida_destroy(&dev->inst_ida);
>> > >+	wave5_vdi_free_sram(dev);
>> > > }
>> > >
>> > > static const struct wave5_match_data ti_wave521c_data =3D {
>> > >diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> > >b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> > >index fa62a85080b5..8d88381ac55e 100644
>> > >--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> > >+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>> > >@@ -749,7 +749,6 @@ struct vpu_device {
>> > > 	struct vpu_attr attr;
>> > > 	struct vpu_buf common_mem;
>> > > 	u32 last_performance_cycles;
>> > >-	u32 sram_size;
>> > > 	struct gen_pool *sram_pool;
>> > > 	struct vpu_buf sram_buf;
>> > > 	void __iomem *vdb_register;
>> > >--
>> > >2.44.0
>> >
>>

