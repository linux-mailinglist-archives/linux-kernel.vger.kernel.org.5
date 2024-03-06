Return-Path: <linux-kernel+bounces-94314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D020B873CF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863D9287056
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080CD13BAC5;
	Wed,  6 Mar 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YM2Nj+kT"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0949F13172D;
	Wed,  6 Mar 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745002; cv=fail; b=EN/sOsRlfA47qsuowu2E/Xtp4TlujxuxdcqF/AtLgBhvVZ/9/FOJBz865m8kRGlPIZZQHeHE58FzErt+177qKiUMSaooxozMDjuaWVHqjgd74o8pV3+y5QjrkxMpPWeKn5069S+50mAmUJwRF26yJhC7fBBTyisOaehTDICX7HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745002; c=relaxed/simple;
	bh=2nGUk/ECiDguHJAYj9dXZLan/0/h5EMHO0tTOm0EFq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KI4+CpN2W+GktsqskJnfU0bDrEY9fZuh94as9zBbLGIPkCDrloI/6nfLlY7TWlWlywWHg3Rm7ghBfsHB6UHyFfeuIlvr/m8aZZBvV77defZjGqCwVSt0Q7otCPXrd4xxX67PQ4Y5cYZfLYYQ4pryvvKhook9US47QYuzieqboOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YM2Nj+kT; arc=fail smtp.client-ip=40.107.95.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki3roOeEDQ+hH1lOJQd/DtxbF90nRzPljdItfjAP0cFKh5/J2kE79q26RmnoF4/Q0HXQiPSiW6ehrAHMOCsPDNvVQzB5gX+MkB4z8BNwF5XpNvq+9m8VDm+4L1AMkNj3nKFCKM+fjab+wi/gwRLIOPRt19l7Me7K2JDZjn0BpBvVf6/uLiyf3nWLvbUUGGkFIMBv5sr2UgIr3dEr5gxyfZQw45ulH/XsWnYY7GzvPaciH5Q77+Z4/x9xbL/8TITVJs1APMvz+J2+bieHb2g2gj2x18jtrDCtCwwa+X+8PPqryh+Ra3E1ViUji/TuT05r62BYnVYkFNAmGD7a+Q/6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nGUk/ECiDguHJAYj9dXZLan/0/h5EMHO0tTOm0EFq8=;
 b=Lvn3Tz40Ms7K1OCnMFrw0Ow0JUECOnnk0NOH4L4g2LsAeXZsFNLZgnfyL0ffbbAoGRYwMDJn6nc2UjHIJK7u2tHn3MF/8tX7iJDQOby2gvA1DLmcr1oQU+bRMVSV7IJP8O7oaKMosKtbC1XC7zSOHEJKpf8VSE0c5D+EhcCoCCDOrHLK/8zztFaJuLkzwTS/gXSUUpnwMm6R0nc6EAcRL7gzF9nWzJEecjwpC5yerhVpAP4SD5Pwn9Ls93upT2VO+8omioOPaEjkonwzC1YPq5WEHCG/Yq8+o5tXibWorDUQL8KGq0AP9eTnuPmYhljRLd+IQBbRaY/QKfFBYOI+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nGUk/ECiDguHJAYj9dXZLan/0/h5EMHO0tTOm0EFq8=;
 b=YM2Nj+kTr3HeQ7wZHEYc1w/kmxgXAux6rK5gZ86vt4fU7HwGopwLJwEJbqeyveCVOX5eHUnO/rxO75b7TvkH4JbjToD/X8/oEWXTtbiNhi5lOSxYE0SmR0rEMAss6nQ+wdTU7EbCkbkDALUSRo6uai+gBj44F6D6+iIyw8bmyy1fKpwJVjw7VqdEQeMPZyMh0a8srzB1zhjbu5sWls5Gu0GZP6zzZtGfUdXvM00SAWL8V83Q2re53V+SmQbg+cx/9i6TOKhwI0Q/RO3HuLLBROmwWELrLJj/urKUnLUheWdLOK97rwgOIPvvWMtyb2Iqo0tiVIDycoU9a5bbFQ22VA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 17:09:58 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae%3]) with mapi id 15.20.7362.024; Wed, 6 Mar 2024
 17:09:57 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "almasrymina@google.com"
	<almasrymina@google.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, Gal Pressman <gal@nvidia.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Leon
 Romanovsky <leonro@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"ian.kumlien@gmail.com" <ian.kumlien@gmail.com>,
	"Anatoli.Chechelnickiy@m.interpipe.biz"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
Thread-Topic: [RFC] net: esp: fix bad handling of pages from page_pool
Thread-Index:
 AQHabhlPr1Jip1r+TESj3iFnglf1YrEqCc2AgACn2oCAACZVgIAACraAgAACc4CAAAiJAIAACFgA
Date: Wed, 6 Mar 2024 17:09:57 +0000
Message-ID: <9a78b37abdf40daafd9936299ea2c08f936ad3d5.camel@nvidia.com>
References: <20240304094950.761233-1-dtatulea@nvidia.com>
	 <20240305190427.757b92b8@kernel.org>
	 <7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
	 <20240306072225.4a61e57c@kernel.org>
	 <320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
	 <20240306080931.2e24101b@kernel.org>
	 <CAHS8izMw_hxdoNDoCZs8T7c5kmX=0Lwqw_dboSj7z1LqtS-WKA@mail.gmail.com>
In-Reply-To:
 <CAHS8izMw_hxdoNDoCZs8T7c5kmX=0Lwqw_dboSj7z1LqtS-WKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|IA0PR12MB8327:EE_
x-ms-office365-filtering-correlation-id: 40f83c07-c1b9-4b87-d532-08dc3e004034
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SGvRQSYxWrobTlqoGr1eS8ybmDv4iMdiEq4PC6oSKR+1q/zK46ixaMydiQbcpkkVhjxH5hagaPuRP9AA9bPmBx890CiC8j1YBC22OpwX7hjoq6Y5/9DtGLoNpZ9rnfqZ6GNDNb/dUThnMzElGH1HRVpaEWyWWo+4R0ODKd22CkMOrMaXXx1DSStCSmYpBklCeRuY3bnVcmccJb+ZsAGED/96d4Ap7vHjd5VaxjY0r32j0+x05819ZFPfs5UEhAuWIjmJhRkEmGKs5xPQHDpGcVeD6T1IFLLfYqW76f23pBtgc8gKmqhZNBw3sF9FfTV51lq8Z667MdFE3outt0iosIu1uDkd6ADDhtBWlTLm+7/Vt+TQp8ylezd7XhiJeBkR85zbuGpe4hjkYvfvLZc+ahMuqnK5GB9/TcbgR+gLfY+B8dS1kyZJqj/3Khp/tynjLo2ZI88oe8gKem6flYHc5jc/t3BRNUVAZrHySbTLCLvkFi1P6SHe9gX1P7NPddzl4ZZ8t080RviF2d4ubg/N6Rj83zyL2piOUcLUwwSeL12v3DRUB1Ft5/SN72waLV62yST/bRFhn5ZJqerIy1bxcrVVpDINpB8K5lrjW9r5/kRmIv4R3Ze4nreGcnH/sM7MWOWylUcKBuIQ8tZOnyGd24ADwE5MzW1b3Bizi5ym7pnOFIXuJQtfbXiHqJjaNl8WOTZxE6kPcVrWOZlCu7mSvKYOznE9ee9hb8cajiS4Pnw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dld3MEorT3YxaUdKWW5MSFdMdVQ5QTR2MVNaK1laQ1pVMFQxbjhMZVFSemVx?=
 =?utf-8?B?K1o1RzR0bk9mbktSQzRTU1lRQjUvM1B3eVZEYUMyTEdUelg0ajNCN0tOWFA4?=
 =?utf-8?B?REtlSzFYWWFJOEpkMEQxR3BLQnRRQ3BIRmlMYi8xZTFEK0dYMU5pRU5KaktP?=
 =?utf-8?B?bWJZWEZtQmUvNUtoVkFHd3hyT0xuRUQybWQ2T25zRXU1dFNCdlZQMVhsUEti?=
 =?utf-8?B?aFA5UmhHY2lZNkFLaXEzcFcxaTJxRUN5cCtCNFBEU1VqdUpsd3I1d3Zoc0JZ?=
 =?utf-8?B?OGZROXp0UVdZRkdEc1ZvT3VldHJoWWNqVXpaZ1lyQmxlZTBoSjVYb1ZxM0pX?=
 =?utf-8?B?QnE4ejlGMmRpdEF5WndJYWFrSkpzajdCVHJ6S2FmRE5BbDhnWDFiZ0FFMUc5?=
 =?utf-8?B?N2dTczFsV1lGV1ByVTloeU00YTBpSjgvNko4Q0gweGV5UFJvRzdNR3FoOFFj?=
 =?utf-8?B?TzU3R0thSzYvQ01ZSnkySTI3bVZvMmZ2MkhQaktrTmk1azZNZE1iZ0lQaDlC?=
 =?utf-8?B?aURmbUNBRSttZ2dqdHFMRGYxd1RobUFVMjdxcmk2cml1cDgwRFl6dnltbDc3?=
 =?utf-8?B?ZXhmckowUjZ1NmJpUFN6ZVl4RkxpaG1lMFY5ejk4QW9YbFFuVTJvMGt3WVc3?=
 =?utf-8?B?enhmcllaVUw3U0NBeWdrWStwSWZKbDYrL2QrTDRweXUyMFZaTjFFRUpFeGcv?=
 =?utf-8?B?TEs0VlhPK0FPUkdlV1ZXUXNNd1RtNitlMHJNbDlMSlhycjFUd1pzZUVxeThO?=
 =?utf-8?B?Z0JHWUlFUElFeFIyZEQxWWpPV1puOUJpN2FWZ3VpdXg1czVqUjlZU3pCU1Nq?=
 =?utf-8?B?UVIydEhLQmc1WFFvMFVjUGdvV1JCZ05QK1ZsTmFnZ0lFcUtZLzlreUl3TUxU?=
 =?utf-8?B?Tk50RDhnQnN0Z3MrMUdBMlB4RzZrSnJjQjgzYUVwZUZudFcwQm1KR3NtMVBK?=
 =?utf-8?B?Zk0vZEdlejVJZXlVamJadHJ1OC9TUC96T0FRWTcrTDdVcU5wdEZoTEdiVzJo?=
 =?utf-8?B?cHYvVHVVdEtEZlh3bEJVcmZJSXRjMkxta0F5YThTdFFHbWN0TTZkVEF5NXFX?=
 =?utf-8?B?Nm5MWmVleUIxWHExaWdmQlhTZGFzcUlNTXBzaGFDdXpuVUxTd2M5aVBSbGJ3?=
 =?utf-8?B?OFlWYkZqU1JoVUVWcHJKL3hQTE1JWkpWSm9WZXVtVTVsTnlCOURleXhsWWM4?=
 =?utf-8?B?M0tpbHdrRmtIaFZkcTZKN2RTUXloV2U0WGdnMStLc3dFQ2ZIL3l0TmNWUExq?=
 =?utf-8?B?RGJFTEVPSFVCbldkV0JhT2hlNWkzY0VNd1JsWGdzY0NtRjJueERMVXVGd2lV?=
 =?utf-8?B?VFh0R3FBNk5oZnNXSVJYUUpnZmt2ZE5weUE2c0kvK29mUUdOeVdoK3czczZ0?=
 =?utf-8?B?dXdQZ1hJRmU2NnEzcWxyeDNaM1Y2QnlYQVJ4cHhNYlF0MEtaZWZwdUtBdVpZ?=
 =?utf-8?B?dytKajg3REtKVnpjbGtML0FSdzRyT3VFMnlUSUloNzNWa3QzSHhQQ1puLzlH?=
 =?utf-8?B?MWVnQldicWF6MEg0djJmYmlSakhBRmc2R3lER3I3Y21qZnp6Y3FTMG4vd1ht?=
 =?utf-8?B?MmZudG1ubUpGRnBPOCtXVC84d0x5ditrLzRzM3NLWGp1bGlWL3VPWEpaVHBV?=
 =?utf-8?B?WndYSXNyTGJ6czVBTGZHMFpvdmJ2ZHMvVkVidGpmT2VtcksrcEYxc0Nidkc4?=
 =?utf-8?B?Nkc0Q0ZtWEFUbG1ablNnQ0JheVp0SWdHM1FOWFBNRUo4Vk1Wc2l1anhCWWpP?=
 =?utf-8?B?a3oxV3RDUlRoN1QvdnMvZlJJRkl5YzczRVU5bXFtUUFKU0wvZVhSbEFaU3lC?=
 =?utf-8?B?VG11VnZXOUhJUGhMQWgrdkROcUc3dUNsazFzQ3REWlVQd21OcWpHVDh6SjNY?=
 =?utf-8?B?bWw3eFFGY2Uya2hjbHFpS0ViNC82cmF5RFpZU0xvUS9yTlVwUm1aejdxT05I?=
 =?utf-8?B?UzYwUkZERGxHamplS2p0UFQ0M2RxZTEvVlRhSGxEdkJpTmtRc2lybFFEREpp?=
 =?utf-8?B?OW40SFFVZUFQMVpNZG5jVS9rdzM3SnQ0WjRUYkVVdWNjenhxVlZ0Ri9ZRXdX?=
 =?utf-8?B?N3ovUGRiK2xGSGFXMUVkV01FaXZnUC91VFJNNFFIc0RLaC83Nm1tNlZBWFVn?=
 =?utf-8?B?bmU0bHRldWFpOFFLZm04aU9NdnJzTVZxK0RHQXYyN055VGJXVEN1UFZTdjZ4?=
 =?utf-8?Q?v1jJmmwlhZQhJfUfoTR/BpazyP2R/UHLyfo7xR5nwg/e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <506CFE4459A75D4AA0099D1998DD782E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f83c07-c1b9-4b87-d532-08dc3e004034
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 17:09:57.7700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLhE8O4VnDuE5dG1FIVAjAwOC7H4+mxXXWNAmiif+1hVHdcyY19p3oWZUbVWAE5WAfy3wRUxalneqCi7X2nvpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

T24gV2VkLCAyMDI0LTAzLTA2IGF0IDA4OjQwIC0wODAwLCBNaW5hIEFsbWFzcnkgd3JvdGU6DQo+
IE9uIFdlZCwgTWFyIDYsIDIwMjQgYXQgODowOeKAr0FNIEpha3ViIEtpY2luc2tpIDxrdWJhQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFdlZCwgNiBNYXIgMjAyNCAxNjowMDo0NiAr
MDAwMCBEcmFnb3MgVGF0dWxlYSB3cm90ZToNCj4gPiA+ID4gSG0sIHRoYXQncyBhIGp1ZGdtZW50
IGNhbGwuDQo+ID4gPiA+IFBhcnQgb2YgbWUgd2FudHMgdG8gcHV0IGl0IG5leHQgdG8gbmFwaV9m
cmFnX3VucmVmKCksIHNpbmNlIHdlDQo+ID4gPiA+IGJhc2ljYWxseSBuZWVkIHRvIGZhY3RvciBv
dXQgdGhlIGluc2lkZXMgb2YgdGhpcyBmdW5jdGlvbi4NCj4gPiA+ID4gV2hlbiB5b3UgcG9zdCB0
aGUgcGF0Y2ggdGhlIHBhZ2UgcG9vbCBjcm93ZCB3aWxsIGdpdmUgdXMNCj4gPiA+ID4gdGhlaXIg
b3BpbmlvbnMuDQo+ID4gPiANCj4gPiA+IFdoeSBub3QgaGF2ZSBuYXBpX3BwX3B1dF9wYWdlIHNp
bXBseSByZXR1cm4gZmFsc2UgaWYgQ09ORklHX1BBR0VfUE9PTCBpcyBub3QNCj4gPiA+IHNldD8N
Cj4gPiANCj4gPiBXaXRob3V0IExUTyBpdCBtYXkgc3RpbGwgYmUgYSBmdW5jdGlvbiBjYWxsLg0K
PiA+IFBsdXMsIHN1YmplY3RpdmVseSwgSSB0aGluayB0aGF0IGl0J3MgYSBiaXQgdG9vIG11Y2gg
bG9naWMgdG8gZW5jb2RlIGluDQo+ID4gdGhlIGNhbGxlciAoeW91IG11c3QgYWxzbyBjaGVjayBz
a2ItPnBwX3JlY3ljbGUsIEFGQUlVKQ0KPiA+IE1heWJlIHdlIHNob3VsZCBtYWtlIHNrYl9wcF9y
ZWN5Y2xlKCkgdGFrZSBzdHJ1Y3QgcGFnZSBhbmQgbW92ZSBpdCB0bw0KPiA+IHNrYnVmZi5oID8g
UmVuYW1lIGl0IHRvIHNrYl9wYWdlX3VucmVmKCkgPw0KPiA+IA0KPiANCj4gRG9lcyB0aGUgY2Fs
bGVyIG5lZWQgdG8gY2hlY2sgc2tiLT5wcF9yZWN5Y2xlPyBwcF9yZWN5Y2xlIHNlZW1zIGxpa2Ug
YQ0KPiByZWR1bmRhbnQgYml0LiBXZSBjYW4gdGVsbCB3aGV0aGVyIHRoZSBwYWdlIGlzIHBwIGJ5
IGNoZWNraW5nDQo+IGlzX3BwX3BhZ2UocGFnZSkuIHRoZSBwYWdlcyBpbiB0aGUgZnJhZyBtdXN0
IGJlIHBwIHBhZ2VzIHdoZW4NCj4gc2tiLT5wcF9yZWN5Y2xlIGlzIHNldCBhbmQgbXVzdCBiZSBu
b24gcHAgcGFnZXMgd2hlbiB0aGUNCj4gc2tiLT5wcF9yZWN5Y2xlIGlzIG5vdCBzZXQsIHNvIGl0
IGFsbCBzZWVtcyByZWR1bmRhbnQgdG8gbWUuDQo+IA0KQUZBSVUgd2UgZG9uJ3QgaGF2ZSB0byBj
aGVjayBmb3IgcHBfcmVjeWNsZSwgYXQgbGVhc3Qgbm90IGluIHRoaXMgc3BlY2lmaWMgY2FzZS4N
Cg0KPiBNeSBmaXggd291bGQgYmUgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9za2J1ZmYuaCBiL2luY2x1ZGUvbGludXgvc2tidWZmLmgNCj4gaW5kZXgg
ZDU3N2UwYmVlMThkLi5jYzczN2I3Yjk4NjAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgv
c2tidWZmLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9za2J1ZmYuaA0KPiBAQCAtMzUwNywxNyAr
MzUwNywyNSBAQCBpbnQgc2tiX2Nvd19kYXRhX2Zvcl94ZHAoc3RydWN0IHBhZ2VfcG9vbA0KPiAq
cG9vbCwgc3RydWN0IHNrX2J1ZmYgKipwc2tiLA0KPiAgYm9vbCBuYXBpX3BwX3B1dF9wYWdlKHN0
cnVjdCBwYWdlICpwYWdlLCBib29sIG5hcGlfc2FmZSk7DQo+IA0KPiAgc3RhdGljIGlubGluZSB2
b2lkDQo+IC1uYXBpX2ZyYWdfdW5yZWYoc2tiX2ZyYWdfdCAqZnJhZywgYm9vbCByZWN5Y2xlLCBi
b29sIG5hcGlfc2FmZSkNCj4gK25hcGlfcGFnZV91bnJlZihzdHJ1Y3QgcGFnZSAqcGFnZSwgYm9v
bCBuYXBpX3NhZmUpDQo+ICB7DQo+IC0gICAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBza2JfZnJh
Z19wYWdlKGZyYWcpOw0KPiAtDQo+ICAjaWZkZWYgQ09ORklHX1BBR0VfUE9PTA0KPiAtICAgICAg
IGlmIChyZWN5Y2xlICYmIG5hcGlfcHBfcHV0X3BhZ2UocGFnZSwgbmFwaV9zYWZlKSkNCj4gKyAg
ICAgICBpZiAobmFwaV9wcF9wdXRfcGFnZShwYWdlLCBuYXBpX3NhZmUpKQ0KPiAgICAgICAgICAg
ICAgICAgcmV0dXJuOw0KPiAgI2VuZGlmDQo+ICAgICAgICAgcHV0X3BhZ2UocGFnZSk7DQo+ICB9
DQo+IA0KPiArc3RhdGljIGlubGluZSB2b2lkDQo+ICtuYXBpX2ZyYWdfdW5yZWYoc2tiX2ZyYWdf
dCAqZnJhZywgYm9vbCByZWN5Y2xlLCBib29sIG5hcGlfc2FmZSkNCj4gK3sNCj4gKyAgICAgICBz
dHJ1Y3QgcGFnZSAqcGFnZSA9IHNrYl9mcmFnX3BhZ2UoZnJhZyk7DQo+ICsNCj4gKyAgICAgICBE
RUJVR19ORVRfV0FSTl9PTihyZWN5Y2xlICE9IGlzX3BwX3BhZ2UocGFnZSkpOw0KPiArDQo+ICsg
ICAgICAgbmFwaV9wYWdlX3VucmVmKHBhZ2UpOw0KPiArfQ0KPiArDQo+IA0KPiBBbmQgdGhlbiB1
c2UgbmFwaV9wYWdlX3VucmVmKCkgaW4gdGhlIGNhbGxlcnMgdG8gaGFuZGxlIHBhZ2UgcG9vbCAm
DQo+IG5vbi1wYWdlIHBvb2wgZ3JhY2VmdWxseSB3aXRob3V0IGxlYWtpbmcgcGFnZSBwb29sIGlu
dGVybmFscyB0byB0aGUNCj4gY2FsbGVycy4NCj4gDQpXZSdkIGFsc28gbmVlZCB0byBhZGQgaXNf
cHBfcGFnZSgpIGluIHRoZSBoZWFkZXIgd2l0aCB0aGUgY2hhbmdlcyBhYm92ZS4uLg0KDQpPbiB0
aGF0IGxpbmUgb2YgdGhvdWdodCwgdW5sZXNzIHRoZXNlIG5ldyBBUElzIGFyZSB1c2VmdWwgZm9y
IG90aGVyIHVzZS1jYXNlcywNCndoeSBub3Qga2VlcCBpdCBzaW1wbGU6DQotIE1vdmUgaXNfcHBf
cGFnZSgpIHRvIHNrYnVmZi5oLg0KLSBEbyBhIHNpbXBsZSBpc19wcF9wYWdlKHBhZ2UpID8gcGFn
ZV9wb29sX3B1dF9mdWxsX3BhZ2UocGFnZSk6cHV0X3BhZ2UocGFnZSkgaW4NCnRoZSBjYWxsZXI/
IENoZWNraW5nIHNrYi0+cHBfcmVjeWNsZSB3b3VsZCBub3QgYmUgbmVlZGVkLiANCg0KVGhhbmtz
LA0KRHJhZ29zDQoNCj4gPiA+IFJlZ2FyZGluZyBzdGFibGUgd291bGQgSSBuZWVkIHRvIHNlbmQg
YSBzZXBhcmF0ZSBmaXggdGhhdCBkb2VzIHRoZSByYXcgcHAgcGFnZQ0KPiA+ID4gY2hlY2sgd2l0
aG91dCB0aGUgQVBJPw0KPiA+IA0KPiA+IFlvdSBjYW4gcHV0IHRoZW0gaW4gb25lIHBhdGNoLCBJ
IHJlY2tvbi4NCj4gDQoNCg==

