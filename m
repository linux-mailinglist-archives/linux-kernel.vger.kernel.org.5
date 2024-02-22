Return-Path: <linux-kernel+bounces-76034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5C85F235
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454E0283789
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038D17BBA;
	Thu, 22 Feb 2024 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FiYq0gJN"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415C17583;
	Thu, 22 Feb 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588539; cv=fail; b=hropDEfHJfaDxY6YgtbnkXm+90BqI8odb9XGietDqfeU9oLZXU7tITRocwMAsm1AZ308zIi9jCTZGtfzhqMY2mf8bfHGAAtN2yHrs/2O2cTMea/3CMhLZuI9PEU6egTvzffUDMc3GDbDUJAsT9obrTqU+rGyBblBi87jDEhqGE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588539; c=relaxed/simple;
	bh=slTHjc4nRUhdsCK86Zv2HfQe0nFRBP2IbNQE2mQIthE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iUD1twrtMZVqyIGXYrKPHGBZtZhu07vutJl8XbbxHmlmlPcsrPzF173YPPQb9Kc4+kxIE+wkP4++RxT1SBHN4viHGR8R2ly30Wtg/x49LKjU7g3fz3Uuh9BrgFvVk3SFDPYDVoEqd0oaZVaB/eBfO9uPa1QxKEaokYHt6TXDWEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FiYq0gJN; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWH50vSqCQypRGMsotrVh/S2ylJaLQrEECiyFf0m5+7CbMBQj0PUHCEopljWw2WHbXo9/o+9qIm//oN5oUS3tCDmJ89J1FaHwPzZq533jY8mbo5YX7lWIunx1Xi1NhPD3vznb16z1conP7+rkEH/H5CX2tG2j8GSn1Qq/0d1U2g/tNr2vDagf3JWQginCl4sE6MGJkSWVSRCt3E/8MKsAGGHcl9DWnsiCSsXaQfxBew2W3AOOmcGOSGzP3H9Lz5/rDphEyNZ0CA28vM5X4A/8OMILq+wK1ysr+NBNii7ybG5bUaiCyPelGorpyBvDE9ppnrTgvckz3h8hZxUdFyTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slTHjc4nRUhdsCK86Zv2HfQe0nFRBP2IbNQE2mQIthE=;
 b=Zt7pPZF49+C8VpI1hduug+tZY8xtaCjoS9t9DlITfrbCs3BPJXiUfdXS8GOiZOD7xzqZ/Kaa1U96KnQhRkiHrYxzEU1/9jVACXAcyvOK+qFWijXop7tn3AlTKTGBydxnLqWi8BFpevzgefJp5S/T72RzbVkJPfkqbYaCrpDsC9c3DQNnrCEpUbrpFdU/yAIwqV7YD32EFlyv2Xd38uoeq1VkRNhLLmMwoxUqWf9VJynVr7yZOVYt/ZwQL3wJvRX/r10Cx8kuI/KuIEwaQBd7lgeRnXYKfYoz+D+ahx9hDbxPmTHyw3mYK0/RyjimVuunp/fcGCFc13146qLMgOS0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slTHjc4nRUhdsCK86Zv2HfQe0nFRBP2IbNQE2mQIthE=;
 b=FiYq0gJNFAG5LeyvARCIHPrU+1wVNaF+onO27+WpQNnQ1HOg0tdBS3unitRAzHYr6Lks61y9W/oszNUnTmRXZe9eAa4Si4lGWAQi0r8/g0vfzZl+PfBEx/GRsM8zoNju8pV43mVcVAmjlk7iQhZDCyp+G3yhXQFCemht8pyVRexUyGspbk90AB20jxefhVBdJrl9O0WMeRsB+FsOln/OTvyOaDoql5dPzjQdMIM47QDhYDyXW+Xiaec7aLh02aHOJ63MbLAAe/gAg+iwybyzCzEp+XndaBPi4pEggwT9LtTa7FMokgPx0ClG1DyM4gg9bnxXJPz4C1ZoxH4Oaei+vg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 07:55:34 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::89d3:24a6:587e:51f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::89d3:24a6:587e:51f%4]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 07:55:34 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org"
	<sre@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] power: reset: restart-poweroff: convert to module
Thread-Topic: [PATCH RFC] power: reset: restart-poweroff: convert to module
Thread-Index: AQHaZO3fdSvNdjfmzUuXjfeFOMKscbEVYxsAgACcD4A=
Date: Thu, 22 Feb 2024 07:55:34 +0000
Message-ID: <80dc4e2e0c7e0fc6f224e704b8594c0f12d0afe9.camel@siemens.com>
References: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>
	 <f8e3a66f-20a3-4819-ab1b-d0f163a2e95f@lunn.ch>
In-Reply-To: <f8e3a66f-20a3-4819-ab1b-d0f163a2e95f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7165:EE_
x-ms-office365-filtering-correlation-id: ce0f20c3-c4da-432c-5e19-08dc337ba626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qHyYhUZGM60Gy4RlTvWbjs2Yoqh8lG4UtuKBVwTc2jiSeMrT6h1D3wSc0W5wep7lTSSkxkR8ZCMw6Wq52RUgDrixpjsRZVQquCg5SCmzg+PpC0LdsLVX5y22kHdR1Ly3p58dWe3ApkDWsrJgwM9YZROt0VjeeNAwWeHY2G7bH55v+STxTraYuJIBP7JTOJccs3lyKiXk8naNGRh+tO6V45qPGvqaRe5eiKwKn2oY9CtuuMESiZhIzbiq0NoqQrNvkCHe55Rm6oo4B7JY1xbLFSpp310osRL7G4go8GoGdQeiCsfG5pYPMWsMELMDBCmHIph6BblyV6UT2ab7CL8RGpddkHxIMM7UHgc1LE42wOV4CUHDJIdEF+6s4xIYHvfwxiNR1bXPX5obXkrNtpga1YwDTTEjv/SZsI61XMX/LXU/KUOMDJxR+Q3vDFsERzU3GC5dOR569YKT0Z3BC/874kzklM7IcqZKqvAxu3K+CXsNO5I24MECIQOCWGEwj3rU71dLXQiS3997AG145UXPX9H1mIin1ZrkbCZe7Hjz1b5hUBIQyRMbnCyZkbCVRTiM3iKAnp1bdyNdRVhEBN1RP6wzNwW/0enbVUbmTFc1RBE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW8yOFlRVkdzSzBpTXBwaFNmTyt3T3MvN1MzSTh3ZE1JeisxL1V4cHg1YTRi?=
 =?utf-8?B?RmNTMlhoc2kxRzA1aW9zb2lpekU2cjBWQkZ5Qm1idi9Nais5Qjh1RE5KdkE3?=
 =?utf-8?B?THdvSko5RS9xWFhFWHBFc3BNWTV5UXJnU3U2eWE3WFZpZ2NxUklXM3pUWjhr?=
 =?utf-8?B?TUdKZXZkdGZpdEs2UVJLNlRxelUrSVdzMEQzZ0FqWFYwRXZHYkV0eDlET2NE?=
 =?utf-8?B?bVdvMUE3K045TGJoYXoybkFucHF3RG5ZVkJrZkFIaUw0c1A3eXJ2YzhSc0sr?=
 =?utf-8?B?WFR6Kytta0piY21xcjBvSGhYaitrakZaajViOEROL1Z2SzlkVXZ0ZWNsRm9P?=
 =?utf-8?B?M05IdDJkL0hITlBmd2xJQXNpWHFLZ0g4TFdVSVNkTzJldlNRZkVkZlB3VUNL?=
 =?utf-8?B?Vzg3K2xBWGpveGhKUGZnMDF6Wk1sNk9HSXo1WklEYStJb1lXMzBkZ3l0Zmx0?=
 =?utf-8?B?SVRYbFFrMHJFQTJRemRTZmhtOTRjbE9yeEpLMjVCa1ZXTTdocjRONXZuazRM?=
 =?utf-8?B?akxFYlh3NjgrL3p0OG53QXFZNm52WTlaSmFVa2FKdUVtdGZqb1ZUaEMwaWMy?=
 =?utf-8?B?MW43VGVLemZPQVZ2cno2dnFjS3Q1RWtqTU1wMXNEbUR5alpDR3BablJPUGFs?=
 =?utf-8?B?OU05TXp0N1JYK1ZXNkdaS1NMWjdIZGt1dWdRVlpGMUIzVEQ1WmxYMjQ3a3lk?=
 =?utf-8?B?RFpITmcrY1Fab3dPUzhtVDZ6N25zaUxuRUVXZ0I5NkFLaUd6M3ZVSlJrN2ll?=
 =?utf-8?B?ckY3OWsvTlExU0ZvYk01M3hHSUhjRnJhVCt6WHF3djFWOEUzL1NjMUV4UW1G?=
 =?utf-8?B?bUh1QTB3aUV0b2xmME9hK2pDNmhlOHpUN3IwalgyR3hDM0owTWxPZnIrczNW?=
 =?utf-8?B?NTdKM0xyV2gvQTJhaTIxcmlZOWE3M1JrQ1lhMzRsRVZRcm9lZlV1OTZ6dlN3?=
 =?utf-8?B?ZklqZFRxWnZveUQ3K1U3bnlrQUFIVXY3dnRxYytlTXJYYUFyR3lTcFAzbGRl?=
 =?utf-8?B?UlZEZzFlUVE1cDNYUUNvQWROZUhnUGdJcXR1MFpORDZKeWg1M1h2UUUyVU5X?=
 =?utf-8?B?TkVaSWRtdU5IMlJYYkRLSmlLQWY0cjlpNlpGV0s5UDNvR2tYaFpZVHhETWJo?=
 =?utf-8?B?NFovTXRXUnhGSGtVandZbjlHRDROanM0bEdqeXFZK0xyaG5QQ3IrL0pHMXpJ?=
 =?utf-8?B?aHMxdW5oTmF1NmhTWnpzTkxQdDlMbW9NMVpvaVFjSDlpWGd0ZnVoeEsxVlkw?=
 =?utf-8?B?MGFGL01yQkZyUE43RFJKN0FieUhqNlFhRUhHbnoyY0F2NFUwTTNBTUxnTWY4?=
 =?utf-8?B?Uk4zNjBZZWh1ZnJ6MWt5QWJSd3lLaHlaOEkxd3lZMDZwM29kcW5wVTRkT2xJ?=
 =?utf-8?B?Z21PbjJyZDMwTW5tR3NScGZtTlREM0w1VGdZTnhmVTNnZ01yRThVS0ZQaEUw?=
 =?utf-8?B?ZWl4ejZGajM4N1pFQjUrTDRiTFNteG5NQWl6S0JXQ0puRnBvLzI5bjh0OXdx?=
 =?utf-8?B?a3E2UVZlU1RiaE00RFVaMWxCOGZxRVBRUEErTFhSOS9uVjRPVG5pRXozWFQ4?=
 =?utf-8?B?NEQrYUJKRFJFbGlhTUcyMVpySkEySmgvWlQ2RWE1N0pTTXU4ai9LSWh4NWMz?=
 =?utf-8?B?ZFcvallJZE0rVGtXeTZvV2FLWm0vU3g4YnFmUGxGQUJFM1crVnRFU0ZoOVZJ?=
 =?utf-8?B?ekY0NXJPL1U0SWQvWG4xbXVHb3pVTnV4SitIVUprakxhR002TUllQlBBNGpy?=
 =?utf-8?B?V2UwcVROaWlrQmFHQUVUaHpTaDEzKy9PRmlQcjRVa1U4SUVsL1FCODA4Y1Ux?=
 =?utf-8?B?cHFGZkViWGFFTnk0MHF3dnRoRytoRWFkbnNZRVozMi9YanpTeisyT3U1bHdw?=
 =?utf-8?B?S0RWak9nVmZ2ODFUY0dKNnV0WFJmQXJ3OThFOThoVmh6aGp4R09Ud2RKd2FB?=
 =?utf-8?B?ME1FWnZEd2Y3SXNLM1lmZmF0RGg2UnpibU4yZkZNQ080cGhRcjRISG5Sc1pB?=
 =?utf-8?B?YkFBS3RrNlZqTFBXMHdFVjB1U3U5V04yRW5qcEk2dk1FMWxLRWxxa3lHVHNk?=
 =?utf-8?B?ZkRyZ3BVMEZSd3E3OTNjNHM2NzMxTGVGL3VwUU5RUDJwTTYrRkowRTRBRVZV?=
 =?utf-8?B?VUJSd2E1U2xnRmxMcWdtUFJabG12TmVhTW5wL2NZV1g1cHBSOWtrRTFIdVZT?=
 =?utf-8?Q?J1+ik6C9Sh29cEVju5Vzaxw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20A9E1FAFEF2F24DB6F2E0656D61D47A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0f20c3-c4da-432c-5e19-08dc337ba626
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 07:55:34.0779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQ2IeHAKMTjPbgzr3cmI85+s5aVRaoqg8yOr9/f4omgOAaTAA76D4SebpS2cK5jg3O0c7H/6DypZtQNxlIv2wUVitnErvKvCIUGe64V3vFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7165

SGkgQW5kcmV3IQ0KDQpPbiBXZWQsIDIwMjQtMDItMjEgYXQgMjM6MzcgKzAxMDAsIEFuZHJldyBM
dW5uIHdyb3RlOg0KPiA+IFRoZSBuZWNlc3NpdHkgb2YgaGF2aW5nIGEgZmFrZSBwbGF0Zm9ybSBk
ZXZpY2UgZm9yIGEgZ2VuZXJpYywgcGxhdGZvcm0NCj4gPiBpbmRlcGVuZGVudCBmdW5jdGlvbmFs
aXR5IGlzIG5vdCBvYnZpb3VzLg0KPiA+IFNvbWUgcGxhdGZvcm1zIHJlcXVyZSBkZXZpY2UgdHJl
ZSBtb2RpZmljYXRpb24gZm9yIHRoaXMsIHNvbWUgd291bGQgcmVxdWlyZQ0KPiA+IEFDUEkgdGFi
bGVzIG1vZGlmaWNhdGlvbiwgd2hpbGUgZnVuY3Rpb25hbGl0eSBtYXkgYmUgdXNlZnVsIGV2ZW4g
dG8NCj4gPiBlbmQtdXNlcnMgd2l0aG91dCByZXF1aXJlZCBleHBlcnRpc2UuIENvbnZlcnQgdGhl
IHBsYXRmb3JtIGRyaXZlciB0bw0KPiA+IGEgc2ltcGxlIG1vZHVsZS4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5z
LmNvbT4NCj4gPiAtLS0NCj4gPiBUaGlzIFJGQyBpcyBtZXJlbHkgdG8gdW5kZXJzdGFuZCBpZiB0
aGlzIGFwcHJvYWNoIHdvdWxkIGJlIGFjY2VwdGVkLg0KPiA+IENvbnZlcnRpbmcgdG8gInRyaXN0
YXRlIiBjb3VsZCBmb2xsb3cgb3IgcHJlY2VlZCB0aGlzIHBhdGNoLg0KPiANCj4gU28gdGhhdCBp
cyB5b3UgdXNlIGNhc2UgaGVyZT8gV2h5IGRvIHlvdSB3YW50IHRvIGJlIGFibGUgdG8ganVzdCBs
b2FkDQo+IHRoaXMgZHJpdmVyLCB3aXRob3V0IHVzaW5nIERUIHRvIGluZGljYXRlIGl0IGlzIG5l
ZWRlZCBieSB0aGUNCj4gaGFyZHdhcmU/DQoNClllcywgdGhlIGNvZGUgaXMgcGxhdGZvcm0taW5k
ZXBlbmRlbnQgbm93IGFuZCBjYW4gYmUgcmUtdXNlZCBmb3IgZGVwbG95bWVudHMNCndoaWNoIG1l
YW50IHRvIGJlICJhbHdheXMgb24iLiBPbmUgY291bGQgYWN0dWFsbHkgZXZlbiB1c2UgaXQgd2l0
aA0Kb2ZmLXRoZS1zaGVsZiB4ODYgaGFyZHdhcmUuIEJ1dCBpbnN0YW50aWF0aW5nIGEgcGxhdGZv
cm0gZGV2aWNlIHRoZXJlIHdvdWxkDQpiZSBhIGhhY2suIFdoeSBub3QganVzdCBjb250cm9sIHRo
aXMgY29kZSBpbiB0aGUga2VybmVsIGNvbmZpZz8NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4N
ClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

