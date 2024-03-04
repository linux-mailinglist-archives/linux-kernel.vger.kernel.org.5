Return-Path: <linux-kernel+bounces-91061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93AD870919
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60131288553
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C396D6169C;
	Mon,  4 Mar 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="M2T2avYY"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2081.outbound.protection.outlook.com [40.92.45.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E447661680
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575692; cv=fail; b=rTGbuOskpdWUrdV/RshwrMGxEj19yjA1WvOgiM7uZyETHWGtU71e7rz9ldKQ0T4n0mGbOuTTb53e98nS9lThkoZBAvrTZzc2/tYaK2I0tVTr//mHh+oG/ZcCb6xdbnmYGTSGXYUXRphixhVJzxr5PmmsHmAFmN6uIh++k/aAH8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575692; c=relaxed/simple;
	bh=NkXtpnDtQVhiKCNNTRiudJEM58kWGVWlgb0FAhbBxow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sdTlhEoD61IsGvIUoIZS8O5fK4jlHgfySkm0uJimGmAHjB6Ljh90oW/Q+h2/N95CIQkZL+yl1qc5MKh4+JFSLGib5czKlWZOUgN45z8gYAYa53H9OrpBz08bFz5au0ocY3f/5baiG9qmyDlZVEhG9/apcwiUdTNen/fWYYBU50k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=M2T2avYY; arc=fail smtp.client-ip=40.92.45.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWIIhS8Op657XUOnHb8v17NUh6jXkW/oKz6dVJinoNCdmY29ywdhSNpN+Bk0sQaXwAbhsL6pFO2DjhF2CC4ULhEG45g/oSq+JNr0Vw3fGC+IgPjiCDawxbzccCWrz68mAsY1/a2omFg0laYCBlVtt0eX/0EPufdD1dkVMN2kUpLgHKpe0xeC5XqRswcWYKVh8UewCroDdl9yyYrPlaQ+egAZUM1F+YxMye/kP6FW39krOcLi1Ka1CFgCqEvauOplCKujF9ZluWiYqeQJ58D3aGZymK4LLGU4i+wS3UUWfKDvW4PtJ6DKha0pOuv0i8Zz9blZF4Tz17FbayV081MEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkXtpnDtQVhiKCNNTRiudJEM58kWGVWlgb0FAhbBxow=;
 b=Js/dkx2I8ItE77NA+fGBlHijgvolOtoJ/XH9XovMqwKaANdi/vz+zXqUiDRA9myBdf1UIMhixmawGF5yA5qO13KhOVa19xjnm5xhZqbCD1DLriesG7j3VJLFd4dZxi2tGOlSYhRz1/UxGw1qtX6kQU/tTQbHfJsNuwVZUm4gZ0/YzA/DhXmk39vHXJgI22A0iAfxvfptcjc09ABBYk35R03AcJXtnPhCx2GSfd9KJNlkFvmVd8BERWkTmLoDy+XSJjty0MSok92+uZXk1r7yqw74kTbAZHVNYoGMycX/GlEMQUNF8+RcKyUCSOa8CeE0+EYTy1SSZfhxyCfHkv8dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkXtpnDtQVhiKCNNTRiudJEM58kWGVWlgb0FAhbBxow=;
 b=M2T2avYYQtIXrK3SDmDGTlZ2RIbwY0CnjejFa5uhRBo3BRhF5ST6D5+o+JQnk5KU2sTwMVjzkqsbEk68Sz/841E+O0nOxDf5zMaX03FKTBJuyKPk/Vnjsd0G3k6pexRhiFMyhYJS3eGYdclKCH4kv7jR3L5/KFndzvF70oF0rLzDvPhhH013OkQQuzVzuEvoSTZNWB04FSRlYOWTpY6V6UXKEPENjUQZScPXJLfQMtc0mXi+HwfO/7EEx7YXDh2Y246QhkG+x0/f9Al1IILo0CtI/bQKQNXIaaM2CbtMeTrFOrc7QuiTT4aXZWCjCi4KwoO2PcQ1zYnuvonoXXkLEA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10301.namprd02.prod.outlook.com (2603:10b6:408:21d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 18:08:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 18:08:07 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Robin Murphy <robin.murphy@arm.com>, =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?=
	<petr@tesarici.cz>
CC: Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
	<kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
	<decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Topic: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Index:
 AQHaakuep9s0mIf3eE+om+sQlmyZtbEg06/QgAAR1sCAAG26AIAAIlEwgAADLACAAY/2gIAAGPyAgAAMowCAAA1wAIADuADAgAB+HYCAACvfAIAAJlIAgAAAVPCAABT9gIAACAaQ
Date: Mon, 4 Mar 2024 18:08:07 +0000
Message-ID:
 <SN6PR02MB4157C66C31129D09E19ACC3BD4232@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240228133930.15400-1-will@kernel.org>
 <20240228133930.15400-7-will@kernel.org>
 <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229133346.GA7177@lst.de>
 <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229154756.GA10137@lst.de>
 <20240301163927.18358ee2@meshulam.tesarici.cz>
 <20240301180853.5ac20b27@meshulam.tesarici.cz>
 <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
 <20240301194212.3c64c9b2@meshulam.tesarici.cz>
 <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240304120055.56035c21@meshulam.tesarici.cz>
 <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
 <20240304165506.49e3b2d3@meshulam.tesarici.cz>
 <SN6PR02MB41576F53BE9B88EB52BBDC10D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d7bd7dce-ead2-4c9b-bb47-d4029c3ce6f7@arm.com>
In-Reply-To: <d7bd7dce-ead2-4c9b-bb47-d4029c3ce6f7@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [/J5ZPUm3wP2IZBjc84lsOzh0SZlxc2aJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10301:EE_
x-ms-office365-filtering-correlation-id: f6bdb5d2-36d8-4bff-b142-08dc3c760b74
x-ms-exchange-slblob-mailprops:
 laRBL560oLTeY4B5Uu9VZYvGMTlNPOvpsrECZ3BciMY6cDnNp0A8hJ3fQJYECfhOU/0b7KcmyZVZa4EKw1xAeZnuNnWMmk14pHFdxSrCagr367CiepWJNyjr1LfC9pue12e2d0V/XL4zclpAuu632wi4/HiZ/brxeDozZOOtov0+PRw+SWwDmwv/yeagGsdsucz5WPeiEi8HUEPhAzy5WWZ13Lt7ToLzFl5cNGPdyikAhXaS8QR6oo8nSvsWjUUg1N0n9K/f5RofZ6n5Tw/359VJZoeYM33yiRFRjCUry/JdLQYMJVZGprcZQux8sWOipfTUsmJO+CsYL/4J9Oh/Osf/zFi/T89/85nlNB5YqdZOvrnu5eTO65j36o/PbKehvKZ5dXSlTujD/ilTT7qS9YoxfN3c35apQHdTGvbZMLHC4lGPCxgcLgWXOWbwOP/MMFbnxuFoaTcDjG8RzzpTo+ciTzFM9ippWN66LrFHDOnKMSP48Suo1Nz7r1X4SeTC2dPYKOtHQJVl+7ZcyPARGA36su9xkiNNLx54dH/AqRBtsR2ERyakf1W0bS6FZHcqPsRkfhKlV93DmNewkRxvbskUNVCWWT/zRViGPhe4KpBekwehXKvHL1H3inrL34KxJCGM7C8qsjbC+/9aJoNMqT4FUAqxUtditoHIQ8yfwFUHcst27Z4VROrFx1KJ5uKbpkVcQasK+nX1kFe6Hck+x+gYM+tssxVXiOxqHwUB9mjwNtR434i9i5W5cwtddQSTCgsbdoXD6GN//YQ0OkEis1DWSxgklZhU
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7EJepVj1cYMI+ioMAa+meV2eDyUVbcfxYBCwgcdi4bmZ5h9zww5sWJW34JdkibblmDWg49O0v6e8QY7qWnYwX4/QJJDFO9isLor86FJStzDxBrnNVsEwXi0eWa9cOE9t/eFVcH8261BY6XdR6FedhdwAlc/pM4iSSzrLI/BtcRo13D0p9HjYIWqYcPVRm/9ChUmGBc+cNozXL5Aei9mlAA+bT3zSXLSqwTSKozGvT6TDFJeuO2dZbkBPHRqOTOV15X8qLlMwtM4Q9I/S2KVnr6NItjVGCkkiSMjGW3ZYD5VAhcw/YGER8B6ZLhI3R8/rR+qOM4c210c6ad4oNnvkTI3NOVIyhfjcv5g+aQhlMqz9//aCwI/m27dueReU87RGU3r+nmkZSwY3h1fTX4R1VqEUUb24SqM8KeKbcb11qQApGTDcnt15euGx1xWK+XNorX1i5Egt6l9qhSWAiDjr6AVrPPgw78sxJPiZBAJ57Y2AbMeOo6ONlvYnUx6NeeG8q8h94CRwe57ZGhLMgLYhUtF9jUEKSifiCAMmUgvmPdeVuNYVzZ+9hSSECThgmB9I
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vlp2SHUvRXFscmRzcW1jM1U2L1lIaUs2QW9VdGQ2UDVGUTYvZGRqYnBFajhW?=
 =?utf-8?B?dStVZS8zN3A3SUxvV0cxYmJwMjkySE9jSzgrcXg2bStaaS9sTTlwN3ZlbGx5?=
 =?utf-8?B?a0hycHRkYUpNOGpBdm0wVzBsMU1UVFdCYmR6OE1rNFlnL3NhZmt2L0ZtV2l6?=
 =?utf-8?B?YzgrOG9Na0pLT2NEZy91djIvbEUrSWtXWWo3VXRjTE5NeENZcHYzY3k5TmdK?=
 =?utf-8?B?eDYyZ0E5c1U4ZlpGdkh0YTVKdnJVNTk2WGpqeWRTTDBtV2NCU2dBS2UwcjNv?=
 =?utf-8?B?NGdkaUo5ZlhMUjE3YTRTR2JxckVsVTNLb1cvWHhPTHlpdjdFSkVyY3UvU1NO?=
 =?utf-8?B?OEhpQXBzOWRudEU2L0JialFpelhWRTRwOGhYamJYT1RjZUE4a3pqUVJqUnRX?=
 =?utf-8?B?N3RmYXhQOWxhRm9ZcEsxa2Q5SHkzZVh0ZC95K2hieDVpcm81eDJBci9qVTVP?=
 =?utf-8?B?cnQ1UVFzcW9uc3kydG9kRjcvbDgzWjBhR3dQWU14K01wOFdQMTBoclRXT1Fi?=
 =?utf-8?B?bEtoSEs1dnFWa2NiL0FwNWRYTktHS29hMGJTSlpENUtReWM3SitHR3MwaXZO?=
 =?utf-8?B?YjN3ZWUycG1jSlR6M2g4VlFBMTVrUHRvankveHN4T2QwbWUwWEYxem9rRzc5?=
 =?utf-8?B?Uk02MkhTZnlGSnpZWkVjTjcrOTdhMitTU2o2RmtpWGRwM3Y2VHduYTNVSHZU?=
 =?utf-8?B?NktaRUVwMnZNSUZFdU9zRFVuNlhEUkc0cnVqV0VWbmk4WXVUMzZadnc0bnJj?=
 =?utf-8?B?aVkwUXAxdEE5VEN1YVBPbEg1cnAxdGQ5QVVWQnl4Y2ZsWHBYSkQ0TEEwOFNB?=
 =?utf-8?B?MzdCY3d2MUZHTmNleWltVkVSTHRJa0tHVi9HeGlEM2diZURDQnJLa29tTGhk?=
 =?utf-8?B?ODZwR0FEM0ZrLzVmK05FcFV3OEJTclpsRGhZazV1Q1BBN3haYm1CTW9BRHdX?=
 =?utf-8?B?SnY4ZGd1d3NkemFJbGlFekRWMUV5cTViaXJIS0E4TDBOaUhkTjlHTUF2UExW?=
 =?utf-8?B?ZExzeDhQSDdUUDhleFdVcjNNR1R6NGl2YUZuWXA1UXV1ZEQxUThzV3pVYVZO?=
 =?utf-8?B?OTN0bU9VK2h2N3VnUTJsZFJBV25JS3FtaHJuV0dnS0REc1B0WWJYbGJIRXY2?=
 =?utf-8?B?b2dyeUpyMGZ0VUUwUGhaMUxkZnFqbEt3Sjd0R1ZDend1Ukg2NWNZMlh2c0Vu?=
 =?utf-8?B?K1pwNVdZQ3g4QUd5RWo5eWlDZGtzS3UrSDZJaVdMOXhzeDN5UjhOVVR0U3Qr?=
 =?utf-8?B?MEZyamRDd2tPL0JoM29wWW8xeTAzVVpVVVpMQlhDbDIyQWZ2MkUrOTYvSEtQ?=
 =?utf-8?B?aWxkcXdESk85aXpnd3drdG1tWlV0K2JJTVFGYUprcTRMYWMyQmFLaWFWMXl2?=
 =?utf-8?B?Y0dXSjJSRk4wVyszUVJ6RmdBeHF2TGNtWml6cCtHcEJGd0JWWmRQaVhFaXg1?=
 =?utf-8?B?RmF2cVpMeXUvWkEvSFlnSUtlL0RVV3NjWWExR0t1cllKQkQ5TC9Ha2R5cHpT?=
 =?utf-8?B?dmE4NjlmVG1BUVhHRUJ0RlpnR2pNUVdrczdiQlVBbnVBTGJrc21ERWljbGVY?=
 =?utf-8?B?MndEbUw4VW83MHgwNlc2S3pMWU1lV2NyU1J6RkdNeDcvVlNLeUlQd2pOQUxo?=
 =?utf-8?B?ZnV1YXQraHlLbXB2UlZpR0dkNFFVUEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bdb5d2-36d8-4bff-b142-08dc3c760b74
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 18:08:07.5514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10301

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogTW9uZGF5LCBN
YXJjaCA0LCAyMDI0IDk6MTEgQU0NCj4gDQo+IE9uIDA0LzAzLzIwMjQgNDowNCBwbSwgTWljaGFl
bCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogUGV0ciBUZXNhxZnDrWsgPHBldHJAdGVzYXJpY2ku
Y3o+IFNlbnQ6IE1vbmRheSwgTWFyY2ggNCwgMjAyNCA3OjU1IEFNDQo+ID4+DQo+ID4+IE9uIE1v
biwgNCBNYXIgMjAyNCAxMzozNzo1NiArMDAwMA0KPiA+PiBSb2JpbiBNdXJwaHkgPHJvYmluLm11
cnBoeUBhcm0uY29tPiB3cm90ZToNCj4gPj4NCj4gPj4+IE9uIDA0LzAzLzIwMjQgMTE6MDAgYW0s
IFBldHIgVGVzYcWZw61rIHdyb3RlOg0KPiA+Pj4gWy4uLl0NCj4gPj4+DQo+ID4+Pj4+IEZvciAj
MywgYWxsb2NfYWxpZ25fbWFzayBzcGVjaWZpZXMgdGhlIHJlcXVpcmVkIGFsaWdubWVudC4gTm8N
Cj4gPj4+Pj4gcHJlLXBhZGRpbmcgaXMgbmVlZGVkLiBQZXIgZWFybGllciBjb21tZW50cyBmcm9t
IFJvYmluWzFdLA0KPiA+Pj4+PiBpdCdzIHJlYXNvbmFibGUgdG8gYXNzdW1lIGFsbG9jX2FsaWdu
X21hc2sgKGkuZS4sIHRoZSBncmFudWxlKQ0KPiA+Pj4+PiBpcyA+PSBJT19UTEJfU0laRS4gVGhl
IG9yaWdpbmFsIGFkZHJlc3MgaXMgbm90IHJlbGV2YW50IGluDQo+ID4+Pj4+IGRldGVybWluaW5n
IHRoZSBhbGlnbm1lbnQsIGFuZCB0aGUgaGlzdG9yaWNhbCBwYWdlIGFsaWdubWVudA0KPiA+Pj4+
PiByZXF1aXJlbWVudCBkb2VzIG5vdCBhcHBseSBzaW5jZSBhbGxvY19hbGlnbl9tYXNrIGV4cGxp
Y2l0bHkNCj4gPj4+Pj4gc3RhdGVzIHRoZSBhbGlnbm1lbnQuDQo+ID4+Pg0KPiA+Pj4gRldJVyBJ
J20gYWxzbyBzdGFydGluZyB0byB3b25kZXIgYWJvdXQgZ2V0dGluZyByaWQgb2YgdGhlIGFsbG9j
X3NpemUNCj4gPj4+IGFyZ3VtZW50IGFuZCBqdXN0IGhhdmUgU1dJT1RMQiByb3VuZCB0aGUgZW5k
IGFkZHJlc3MgdXAgdG8NCj4gPj4+IGFsbG9jX2FsaWduX21hc2sgaXRzZWxmIGFzIHBhcnQgb2Yg
YWxsIHRoZXNlIGNhbGN1bGF0aW9ucy4gU2VlbXMgbGlrZSBpdA0KPiA+Pj4gY291bGQgcG90ZW50
aWFsbHkgZW5kIHVwIGEgbGl0dGxlIHNpbXBsZXIsIG1heWJlPw0KPiA+DQo+ID4gWWVzLCBJIHdh
cyB0aGlua2luZyBleGFjdGx5IHRoaXMuICBCdXQgbXkgcmVhc29uaW5nIHdhcyB0byBzb2x2ZSB0
aGUNCj4gPiBidWcgaW4gIzQgdGhhdCBJIHByZXZpb3VzbHkgcG9pbnRlZCBvdXQuICBJZiBpb21t
dV9kbWFfbWFwX3BhZ2UoKQ0KPiA+IGRvZXMgKm5vdCogZG8NCj4gPg0KPiA+IAlhbGlnbmVkX3Np
emUgPSBpb3ZhX2FsaWduKGlvdmFkLCBzaXplKTsNCj4gPg0KPiA+IGJ1dCBzd2lvdGxiX3RibF9t
YXBfc2luZ2xlKCkgcm91bmRzIHVwIHRoZSBzaXplIGJhc2VkIG9uDQo+ID4gYWxsb2NfYWxpZ25f
bWFzayAqYWZ0ZXIqIGFkZGluZyB0aGUgb2Zmc2V0IG1vZHVsbw0KPiA+IG1pbl9hbGlnbl9tYXNr
LCB0aGVuIHRoZSByb3VuZGVkLXVwIHNpemUgd29uJ3QgZXhjZWVkIElPX1RMQl9TSVpFLA0KPiA+
IHJlZ2FyZGxlc3Mgb2Ygd2hpY2ggYml0cyBhcmUgc2V0IGluIG9yaWdfYWRkci4NCj4gDQo+IEFo
LCBuZWF0LCBJIGhhZCBhIGd1dCBmZWVsaW5nIHRoYXQgc29tZXRoaW5nIGxpa2UgdGhhdCBtaWdo
dCBhbHNvIGZhbGwNCj4gb3V0LCBJIGp1c3QgZGlkbid0IGZlZWwgbGlrZSB3b3JraW5nIHRocm91
Z2ggdGhlIGRldGFpbHMgdG8gc2VlIGlmDQo+ICJzaW1wbGVyIiBjb3VsZCBsZWFkIHRvICJvYmpl
Y3RpdmVseSBiZXR0ZXIiIDopDQo+IA0KPiBJIGd1ZXNzIGF0IHdvcnN0IHdlIG1pZ2h0IGFsc28g
bmVlZCB0byBwYXNzIGFuIGFsbG9jX2FsaWduX21hc2sgdG8NCj4gc3dpb3RsYl9tYXhfbWFwcGlu
Z19zaXplKCkgYXMgd2VsbCwgYnV0IGV2ZW4gdGhhdCdzIG5vdCBuZWNlc3NhcmlseSBhDQo+IGJh
ZCB0aGluZyBpZiBpdCBrZWVwcyB0aGUgZXF1aXZhbGVudCBjYWxjdWxhdGlvbnMgY2xvc2UgdG9n
ZXRoZXIgd2l0aGluDQo+IFNXSU9UTEIgYW5kIG1ha2VzIHRoaW5ncyBtb3JlIHJvYnVzdCBvdmVy
YWxsLg0KPiANCg0KSSBoYXZlbid0IHNlZW4gYSByZWFzb24gdG8gaW5jb3Jwb3JhdGUgYWxsb2Nf
YWxpZ25fbWFzayBpbnRvDQpzd2lvdGxiX21heF9tYXBwaW5nX3NpemUoKS4gIEJ1dCBsZXQgbWUg
Y29uZmlybSBteQ0KdW5kZXJzdGFuZGluZyBvZiB0aGlzIHNjZW5hcmlvOg0KDQoxLiAgVGhlIHJl
cXVlc3RlZCBzaXplIHdpdGhvdXQgYW55IHJvdW5kaW5nIGlzIDExSyAoanVzdCBhbiBleGFtcGxl
KS4NCjIuICBUaGUgb3JpZ2luYWwgYWRkcmVzcyBzdGFydHMgYXQgb2Zmc2V0IDdLIG1vZHVsbyBh
IDY0SyBncmFudWxlLg0KMy4gIFRoZSBtaW5fYWxpZ25fbWFzayBmb3IgdGhlIGRldmljZSBpcyA0
SyAtIDENCjQuICBUaGVuIGl0J3MgT0sgZm9yIHN3aW90bGIgdG8gcmV0dXJuIGFuIGFkZHJlc3Mg
YXQgb2Zmc2V0IDNLIG1vZHVsbw0KdGhlIDY0SyBncmFudWxlLiAgU3VjaCBhbiBhZGRyZXNzIG1l
ZXRzIHRoZSBtaW5fYWxpZ25fbWFzaywgZXZlbg0KdGhvdWdoIGl0IGlzIGEgZGlmZmVyZW50IG9m
ZnNldCBpbiB0aGUgZ3JhbnVsZS4NCjUuICBzd2lvdGxiIHdpbGwgYWxsb2NhdGUgM0sgb2YgcHJl
LXBhZGRpbmcgZm9yIHRoZSBtaW5fYWxpZ25fbWFzaw0KcmVxdWlyZW1lbnQuIElmIHN3aW90bGIg
YWxzbyBkb2VzIHRoZSByb3VuZGluZyB1cCwgaXQgd291bGQgdGFrZQ0KdGhlIG9yaWdpbmFsIDEx
SywgYWRkIDNLIG9mIHByZS1wYWRkaW5nLCB0aGVuIHJvdW5kIHVwIHRvIDY0SyBhbmQNCmVmZmVj
dGl2ZWx5IGFsbG9jYXRlIDUwSyBvZiBwb3N0LXBhZGRpbmcuDQo2LiAgVGhlIHplcm9pbmcgb2Yg
dGhlIHByZS1wYWRkaW5nIGFuZCBwb3N0LXBhZGRpbmcgaXMgbWVzc2VkDQp1cCBpbiBpb21tdV9k
bWFfbWFwX3BhZ2UoKSwgYnV0IHRoYXQncyBhIHNlcGFyYXRlIGlzc3VlLg0KDQpBc3N1bWluZyBt
eSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QsIHRoaXMgd29ya3MgY29ycmVjdGx5DQp3aGVuIHRo
ZSBvcmlnaW5hbGx5IHJlcXVlc3RlZCBzaXplIGlzIGFzIGxhcmdlIGFzDQpzd2lvdGxiX21heF9t
YXBwaW5nX3NpemUoKS4gIEl0IHdvcmtzIGJlY2F1c2UgdGhlDQpwcmUtcGFkZGluZyBpcyBuZXZl
ciBtb3JlIHRoYW4gbWluX2FsaWduX21hc2ssIGFuZA0Kc3dpb3RsYl9tYXhfbWFwcGluZ19zaXpl
KCkgdGFrZXMgdGhhdCBwcmUtcGFkZGluZyBpbnRvDQphY2NvdW50Lg0KDQpJIHdvdWxkIG5vcm1h
bGx5IHByb3Bvc2UgYSBwYXRjaCB0byBpbXBsZW1lbnQgdGhlc2UgY2hhbmdlcywNCmJ1dCBJIGRv
bid0IGhhdmUgaGFyZHdhcmUgb24gd2hpY2ggdG8gdGVzdCBJT01NVSBjb2RlIHBhdGhzLg0KQnV0
IEknbGwgd3JpdGUgYW4gdW50ZXN0ZWQgcGF0Y2ggaWYgdGhhdCB3b3VsZCBiZSBhIGhlbHBmdWwg
c3RhcnRpbmcNCnBvaW50IGZvciBzb21lb25lIGVsc2UgdG8gdGVzdC4NCg0KRllJLCBJJ20gdHJl
YXRpbmcgdGhpcyBkaXNjdXNzaW9uIGFzIHNlcGFyYXRlIGZyb20gV2lsbCdzIHBhdGNoDQpzZXQu
ICBJdCdzIHNvbWV0aGluZyB0aGF0IGNvdWxkIGJlIGRvbmUgYXMgYSBmb2xsb3ctb24gc2V0Lg0K
DQpNaWNoYWVsDQo=

