Return-Path: <linux-kernel+bounces-91302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862A5870C96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29361F25B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C57A124;
	Mon,  4 Mar 2024 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mbtpq6cF"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A74200D4;
	Mon,  4 Mar 2024 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587609; cv=fail; b=SpPKWvLYrNdby3GdZ6F7YHfi/NDA9CWEuHliSHu6gYIiJurjdhTa9YqRfH0zezKEL+eknInwwbAtWlIZp+tlX8LkAlnXp57r3Vnlr6GciNF9B/w4qdKjtgM/29E/x1f40frPdnSVYw4INXsEseFgS1Biy1GnmCGP0hJnzScNy4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587609; c=relaxed/simple;
	bh=38bpVjv0MZ0OmyGT5EI/9FMiI+m5427aIZ+r8zWOkRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f1tRVdl1Dk+4um70wGvazRrTQt7RLtt7XhxMPYPKBsoOWoRRYOf1+6h7zmpttWOEBS0wrAmsVjcTXdo+37w+a6z7SPQl3orQfhNLMO8jczDpXryNfFFy5dNDooisT2RwmwSJrzwpscnwCMlt+61/blEuahUeSAgk6xTy0Z9wZ/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mbtpq6cF; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc73IyiykxpyukqcHFkw0CKwijTw9CnH4WZzMvJNnrBJULH3S5MF5/yjtDLCdSZNHQSIaQ+Pusd5SIcqQ2dJjXBSBXHvvSnV0E3A3l4MmXnhJotl2fM4TcE9OEGf0lOhps1q19EdBnsRSvB+K1N0Q67S2J3j++AgD9vVq5w6aVshgnqOPe0bt2eamlMFQWfH0yO8Gd4OyTXMxz4onMNFgFuPYLcdF7PcVB+ku7eXA9CjppR2WhVrR8e74YZpsNcaDjGQtN2HcaQJzwRhwHQUkqpniw0R6tzXkooRMvkub09rfH9JkyFFU9AFCa3jc9YZmMhFFjZEMnvE/lnaypx1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38bpVjv0MZ0OmyGT5EI/9FMiI+m5427aIZ+r8zWOkRo=;
 b=hpIN+WHZZhnB1+d+0YP232uBx1KNizaZopz1sY/SGG99dEsxT8qL7I6L4TN48BkzOtVmWrkr6mA4uuXWi5LvNEvYNzFUWt4l9406WkJ7ecEsHjGt1zhzBz3W3D1u02NUeoJIK15B4UizJ6xdXLJd/jpMJ1xC0hBv5n4zYvt52VlSU5mXP3theGobOLbIjMPk4T0HU5UGUTe7W1ClFFDv/4hApsc6a1v4PRfXp9B0YLGF/SPEs+PDGO3AHWGGnRh31Vsz3Al9lFT6QZnaHV+pS8yLFSDrxSUrrlazwT3YvWBeB75FEmaISQsCm5VCMQrHRVscdn08tSAnIbgM/kWfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38bpVjv0MZ0OmyGT5EI/9FMiI+m5427aIZ+r8zWOkRo=;
 b=mbtpq6cFnrPGWtuZLjFQ/GLkhnxVG2epRMB3c6AyWnS304Bzuy4jz1xxB3LcQ8drbXOkcS+0yn4T2Fry+2WANqKhtVau8OCKAJWiZYa6LTleOAJUcmyRUSXfs/m8+idUgn86qAA5TOgCH1IQuRorkqOnglvYGBa3v8LsxGlj2ZLPhfGpG8ndu0/rxDfWM4InbW/hn7jIE/aDMmAmPr0qEPAlrLIgDJ/q/dFdbe3MPxDlwjPxBIllVOUxvjScsgfoA9PxzYorbf2rxnDnGMEcujgsd/J9xfyfh5twbnl5RtWJrKHwgwHIOzD5nHmoxkeBjaEpFnpHL73NDURtSkfFnQ==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 21:26:42 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::122:c58:8a3:743d]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::122:c58:8a3:743d%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 21:26:42 +0000
From: Vadim Pasternak <vadimp@nvidia.com>
To: Daniil Dulov <D.Dulov@aladdin.ru>, Hans de Goede <hdegoede@redhat.com>
CC: Mark Gross <mgross@linux.intel.com>, Andy Shevchenko <andy@infradead.org>,
	Darren Hart <dvhart@infradead.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH] platform/mellanox: mlxreg-hotplug: Check pointer for NULL
 before dereferencing it
Thread-Topic: [PATCH] platform/mellanox: mlxreg-hotplug: Check pointer for
 NULL before dereferencing it
Thread-Index: AQHaaMPQt7JNWu3hzka2Jxj0r7zdwrEcuVSAgArHiQCAAJlNEA==
Date: Mon, 4 Mar 2024 21:26:42 +0000
Message-ID:
 <BN9PR12MB53815F52C9033DC526085827AF232@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20240226145442.3468-1-d.dulov@aladdin.ru>
 <BN9PR12MB538106C733D231B73FC1C1AAAF5A2@BN9PR12MB5381.namprd12.prod.outlook.com>
 <e34edced65e747c5870ee439e3c84457@aladdin.ru>
In-Reply-To: <e34edced65e747c5870ee439e3c84457@aladdin.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|DM6PR12MB4201:EE_
x-ms-office365-filtering-correlation-id: 584130e9-2228-4d45-f03c-08dc3c91c951
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hkaZhtISKdL0CkfBO/SmgB+qpx7H5DDzLo68miFuzTLTc5+slUBHrava0OtPqMQO4o0rGwiE3CdroYLivPhhl7sVTnZKv0PuH7h43Tm1fP2bMjSb0gaiGrg2FApQoTGZ3gwQb4QykOhc2Vww4xqMYr8iX2zs23TCLfg/BhHpL2e1kBzOulGYHoxV4kwVOn6vkz49RuJSxsGSQQ53GRnqAT0tdn3bFvVHgzIaVLVfcqOwiMI5RIisldiwtu3hNrekodLMnZdSzdWbw5nDqoz61yf1E8FS2KsQHgkhBBoYDHDSo60ZOvIjxuneeqbkBNMRgC5A+oq4R3KG1ZZjWSvJ7kzk9Vux/X1A7t16DOsGurqaLLkze56Op9CFxVwprzy29HUenXMmJS+fXz7z95eawtqWC1cddwEyeJ4wtbzWQg0uLBinPKOyXFkVbdu0ymKamwm8jbhGMybS5jvQj4arHt3emCdKR0KohOLZMsCKK5S5C8nTkyyFXnYZr87aM1Gdl6VebIh9DSKPRBlMJt+t1yEsbQEVP20PEv2AH5BnC55K6OS9JclBeWfjXiUZtsAwZm+Wq2If5EDvdV5POBqlzmc52HgDa7kZsefJBTRey/ta4apZ+2lnptU3TnHmQ26Wp3vJpdEvITW3ta4+u9FNs+ijV7d8LXDDCIHj2S6X3F9BT37SoyEsK2b89iCYydwFj+8SgXBmZXJVPA5U+ndlD7bR6owte+tTO7e55bcEX20=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjhqUno4ZHNBQ3BMZy84M2xaVStyR1RpM0EzVDBzN2l2VXRiQUZNSzVoMHp2?=
 =?utf-8?B?dWhFOURyRWRWSGhDZUU2Rnhja2FJeGllYWRIUVpZRjRaZ2xuZ2dRSkRKQnFD?=
 =?utf-8?B?YUlWc0dPMTlsT3plekR5cUZ0YnY5TzF4OWVFVnhLZGJ0NW1JT1RvN1BWRnJq?=
 =?utf-8?B?RnQyRHlyQUJvQjZvUDJNNGxRM3NycWdXQm01ZWpGanY1MVNndk9CVUlYclYr?=
 =?utf-8?B?NlFZVm8wLy9nV216NzZiamNSd21penhLWVZUbXVTV1g2ZGpSdkJoeWZzTzgw?=
 =?utf-8?B?Z0JIcnBRNTZva2l0V3ZOOTM4clVqeE5iMjBpenNCbFBNb0thNWx1WFV5VFBp?=
 =?utf-8?B?dTBVS2ZGRlg1NitEL1dRR2hvTm5icUdHbjNWYlMrOHBpZFNLYmxHSVRQT2RX?=
 =?utf-8?B?eFYxY1V3QUhzUWlEaUwyQ2tHY3NwUm15UEU2Q1cyOHFMNmNBczZyUzZMaFBt?=
 =?utf-8?B?Z0ZPRlJHYnM0Wk40T1FRMW92V2JSMDlYRzltVEI4RjZxcVc1SkhJMWxYQUUw?=
 =?utf-8?B?Tllxb0RHaXR0VlJtTXNBZERBa2tHM3FGRTdGOGo3b3R0T3BzeVlHcitCWVdP?=
 =?utf-8?B?RUFlMDByeW9YUjZQbHdHcUFsQ2pTS0dJeDhGOVNyZGJ5OEVFVitkZkVGdW05?=
 =?utf-8?B?U2tyK1lHSDIvOS9WMy9pQkUxdDA5NnJCd3lGTGpBVlFzcE90YURJWERYdCtl?=
 =?utf-8?B?VTgvQlFjYXlZeHU5ZGtZYVhOMHM1Uk1XaUIzUVd3UWI3L0laSHdLTjZNdHpr?=
 =?utf-8?B?THBtZTVNcmkvOGpEa0xBSVFhdlAzbkNUZkpIa3p1WVpaMFBwclA1Q2NiT044?=
 =?utf-8?B?QW1hVVJxTkptb1VUUnQ4OVNkMUtJdzV6aVdKRFRETTZuNVlabE9JSUlmcG5B?=
 =?utf-8?B?K0pwSi9Pa1lYVC9ETDdud0F1dFV6Z1VLMFdhMS9lMFViaEFwblhvREgrQVJ2?=
 =?utf-8?B?SnhVZ3YzRDRYSGFRekZOeittNUJPdE9ESVErVHdyZW5XNzN3Zmd5amIxMlJq?=
 =?utf-8?B?d2ZhRWRDWFVhWGtIWUpHQXdsK3RocUhkcnlNQ0R1RFRpMThscXByRHBEQzZO?=
 =?utf-8?B?aDcrVHNXclRXcFE0d2o3b001WSt3amJhY0pOUFQ3NERLcWxEZFZZcUtzUis1?=
 =?utf-8?B?YW40blJwRWpNZnRSUTJnZUlpNVNUTGV1ZzQxUVV3bkhJcHR6SE9ScEJmUlhG?=
 =?utf-8?B?c29TYUVwSUx5c044Mnlpd0FDVXc3bHY4VEczczVkU0hCbUx3Q0pNYVF6QTZi?=
 =?utf-8?B?Y2ova1lFMXJvQk9tRytrbWRCdmkwVGlxb2lFUU0zRVkzT2FITlAwTUNtTksr?=
 =?utf-8?B?UWNVQlJiQXVYTVlYQ2hQb2V1YzJ1R25KQzF2VVpSV0RYWXozVG1TeWpRRHkr?=
 =?utf-8?B?QzRQR0FiYTRZd2JwSVJ1bS9nbjZhLzd0enA3ZEQ1Rk91VjdPN3VicmtiT3M4?=
 =?utf-8?B?cWhuTWtyY3NPYUNtLzl5S3RmT2RSMnZPRTh3TmRrMnFWU0xqOUxvdzN3VUJo?=
 =?utf-8?B?b2o3eXlCNWQ2TGdmQ05qYnE2M2hMWjVCTzNEZGtWR1BwS3NtczlEYkRLcEVH?=
 =?utf-8?B?emZwblBtNWI5MllFc09zMm9yQ045bmpJVnVEL2U0bytKTWZTVFhYQWkxNnZL?=
 =?utf-8?B?L3R2MituUFdZeWNHbWJDNkIwTHJMUjZYZFUxY0RqQ1MxRGk1a2tER1VjcXVz?=
 =?utf-8?B?QVdLbDNCVngrK2VXVGNEV3p2M1J5ajZYdDR4YUUxYi9md0phNk1hRjQ4SVRk?=
 =?utf-8?B?SUpLUG94dncxWldWczgvNlR5QXNXenBuS1UreEh5ZGVGV2lHeXdSSno4Y0JY?=
 =?utf-8?B?ZmdaS2xMU1QxMUI1a1FISzZIS3ZuZUJCR1FSSkZCTlkzWmdhNm1xU0FlazBM?=
 =?utf-8?B?RkRNaE9nNkZZWEFoN2NpVHI3Ujk5L2UrNHpVbDc4MUFoRFRqUTg0emQ0ajM3?=
 =?utf-8?B?Z2F1eG1KTEZHa3NGRXZqS2VRcHJSWUlxZ01zd3hETWlzQXBObVF1VHh5WDZi?=
 =?utf-8?B?MTNpbVkxRUNpZEp0MHFGQVJoM3RWaDFwSC9rOFlLNXlIOWJaaDJtWngyUDE2?=
 =?utf-8?B?SE56cWs0MmdLZWM4cUkya08yTUNIU21XKzN2L0NBeU9OMllHS21YTUF0UWkr?=
 =?utf-8?Q?3NAph1R6Ixx/hfJVPjYpNGuKr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584130e9-2228-4d45-f03c-08dc3c91c951
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 21:26:42.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFTJkV1dpj10C4nwqEG9zLWsSDmklipnw5aigj9VORNd5rpMb1GOXAwpHSz+cmRakf0asMJ7eC8QurIb9ctunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWlsIER1bG92IDxE
LkR1bG92QGFsYWRkaW4ucnU+DQo+IFNlbnQ6IE1vbmRheSwgNCBNYXJjaCAyMDI0IDEzOjQ0DQo+
IFRvOiBWYWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBudmlkaWEuY29tPjsgSGFucyBkZSBHb2VkZQ0K
PiA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gQ2M6IE1hcmsgR3Jvc3MgPG1ncm9zc0BsaW51eC5p
bnRlbC5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHlAaW5mcmFkZWFkLm9yZz47IERhcnJl
biBIYXJ0IDxkdmhhcnRAaW5mcmFkZWFkLm9yZz47IHBsYXRmb3JtLQ0KPiBkcml2ZXIteDg2QHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbHZjLQ0KPiBwcm9q
ZWN0QGxpbnV4dGVzdGluZy5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gcGxhdGZvcm0vbWVs
bGFub3g6IG1seHJlZy1ob3RwbHVnOiBDaGVjayBwb2ludGVyIGZvcg0KPiBOVUxMIGJlZm9yZSBk
ZXJlZmVyZW5jaW5nIGl0DQo+IA0KPiBIZWxsbyENCj4gDQo+IEkgc3VwcG9zZSB0aGVyZSBpcyBu
byBzZW5zZSB0byBwcm9kdWNlIGRldl9lcnIoKSBpbnNpZGUNCj4gbWx4cmVnX2hvdHBsdWdfd29y
a19oZWxwZXIoKSBzaW5jZSBpdGVtIGlzIGRlcmVmZXJlbmNlZCB0d2ljZSBiZWZvcmUgd2UNCj4g
Y2FsbCB0aGlzIGZ1bmN0aW9uLiBTaG91bGQgd2UgcHJvZHVjZSBkZXZfZXJyKCkgaW5zaWRlIHRo
ZSBsb29wIGluDQo+IG1seHJlZ19ob3RwbHVnX3dvcmtfaGFuZGxlcigpIGluc3RlYWQ/DQoNCkhp
IERhbmlpbCwNCg0KSSB0aGluayB3b3VsZCBiZSBjb3JyZWN0IGp1c3QgdG8gcmVtb3ZlIGZyb20g
bWx4IHJlZ19ob3RwbHVnX3dvcmtfaGVscGVyKCkNCmxpbmVzIHZhbGlkYXRpbmcgJ2l0ZW0nIHBv
aW50ZXIuDQpUaGlzIGlzIHBhcmFub2ljIHRlc3QsIHRoaXMgcG9pbnRlciBzaG91bGQgbmV2ZXIg
YmUgTlVMTC4NCkl0IGlzIHNhZmUgdG8gcmVtb3ZlIHRoaXMgdmFsaWRhdGlvbi4NCg0KVGhhbmtz
LA0KVmFkaW0uDQoNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZh
ZGltIFBhc3Rlcm5hayBbbWFpbHRvOnZhZGltcEBudmlkaWEuY29tXQ0KPiBTZW50OiBNb25kYXks
IEZlYnJ1YXJ5IDI2LCAyMDI0IDY6MTUgUE0NCj4gVG86IERhbmlpbCBEdWxvdiA8RC5EdWxvdkBh
bGFkZGluLnJ1PjsgSGFucyBkZSBHb2VkZQ0KPiA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gQ2M6
IE1hcmsgR3Jvc3MgPG1ncm9zc0BsaW51eC5pbnRlbC5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4g
PGFuZHlAaW5mcmFkZWFkLm9yZz47IERhcnJlbiBIYXJ0IDxkdmhhcnRAaW5mcmFkZWFkLm9yZz47
IHBsYXRmb3JtLQ0KPiBkcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbHZjLQ0KPiBwcm9qZWN0QGxpbnV4dGVzdGluZy5vcmcNCj4gU3ViamVj
dDogUkU6IFtQQVRDSF0gcGxhdGZvcm0vbWVsbGFub3g6IG1seHJlZy1ob3RwbHVnOiBDaGVjayBw
b2ludGVyIGZvcg0KPiBOVUxMIGJlZm9yZSBkZXJlZmVyZW5jaW5nIGl0DQo+IA0KPiANCj4gDQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBEYW5paWwgRHVsb3YgPGQu
ZHVsb3ZAYWxhZGRpbi5ydT4NCj4gPiBTZW50OiBNb25kYXksIDI2IEZlYnJ1YXJ5IDIwMjQgMTY6
NTUNCj4gPiBUbzogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gPiBDYzog
RGFuaWlsIER1bG92IDxkLmR1bG92QGFsYWRkaW4ucnU+OyBNYXJrIEdyb3NzDQo+ID4gPG1ncm9z
c0BsaW51eC5pbnRlbC5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFuZHlAaW5mcmFkZWFkLm9yZz47
DQo+IERhcnJlbg0KPiA+IEhhcnQgPGR2aGFydEBpbmZyYWRlYWQub3JnPjsgVmFkaW0gUGFzdGVy
bmFrIDx2YWRpbXBAbnZpZGlhLmNvbT47DQo+ID4gcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGx2Yy0NCj4gPiBwcm9qZWN0
QGxpbnV4dGVzdGluZy5vcmcNCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIHBsYXRmb3JtL21lbGxhbm94
OiBtbHhyZWctaG90cGx1ZzogQ2hlY2sgcG9pbnRlciBmb3IgTlVMTA0KPiA+IGJlZm9yZSBkZXJl
ZmVyZW5jaW5nIGl0DQo+ID4NCj4gPiBtbHhyZWdfaG90cGx1Z193b3JrX2hlbHBlcigpIGltcGxp
ZXMgdGhhdCBpdGVtIGNhbiBiZSBOVUxMLiBUaGVyZSBpcyBhDQo+ID4gc2FuaXR5IGNoZWNrIHRo
YXQgY2hlY2tzIGl0ZW0gZm9yIE5VTEwgYW5kIHRoZW4gZGVyZWZlcmVuY2VzIGl0Lg0KPiA+DQo+
ID4gRXZlbiB0aG91Z2gsIHRoZSBjb21tZW50IGJlZm9yZSBzYW5pdHkgY2hlY2sgc2F5cyB0aGF0
IGl0IGNhbiBvbmx5IGhhcHBlbg0KPiBpZg0KPiA+IHNvbWUgcGllY2Ugb2YgaGFyZHdhcmUgaXMg
YnJva2VuLCBidXQgaW4gdGhpcyBjYXNlIGl0IHdpbGwgbGVhZCB0byBOVUxMLQ0KPiBwb2ludGVy
DQo+ID4gZGVyZWZlcmVuY2UgYmVmb3JlIHRoZSBmdW5jdGlvbiBpcyBldmVuIGNhbGxlZCwgc28g
bGV0J3MgY2hlY2sgaXQgYmVmb3JlDQo+ID4gZGVyZWZlcmVuY2luZy4NCj4gPg0KPiA+IEZvdW5k
IGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZB
Q0UuDQo+ID4NCj4gPiBGaXhlczogYzZhY2FkNjhlYjJkICgicGxhdGZvcm0vbWVsbGFub3g6IG1s
eHJlZy1ob3RwbHVnOiBNb2RpZnkgdG8gdXNlIGENCj4gPiByZWdtYXAgaW50ZXJmYWNlIikNCj4g
PiBTaWduZWQtb2ZmLWJ5OiBEYW5paWwgRHVsb3YgPGQuZHVsb3ZAYWxhZGRpbi5ydT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhyZWctaG90cGx1Zy5jIHwgMTYg
Ky0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE1
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0vbWVs
bGFub3gvbWx4cmVnLWhvdHBsdWcuYw0KPiA+IGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9t
bHhyZWctaG90cGx1Zy5jDQo+ID4gaW5kZXggNWMwMjJiMjU4ZjkxLi41MjQxMjFiOWYwNzAgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhyZWctaG90cGx1Zy5j
DQo+ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhyZWctaG90cGx1Zy5jDQo+
ID4gQEAgLTM0OCwyMCArMzQ4LDYgQEAgbWx4cmVnX2hvdHBsdWdfd29ya19oZWxwZXIoc3RydWN0
DQo+ID4gbWx4cmVnX2hvdHBsdWdfcHJpdl9kYXRhICpwcml2LA0KPiA+ICAJdTMyIHJlZ3ZhbCwg
Yml0Ow0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+IC0JLyoNCj4gPiAtCSAqIFZhbGlkYXRlIGlm
IGl0ZW0gcmVsYXRlZCB0byByZWNlaXZlZCBzaWduYWwgdHlwZSBpcyB2YWxpZC4NCj4gPiAtCSAq
IEl0IHNob3VsZCBuZXZlciBoYXBwZW4sIGV4Y2VwdGVkIHRoZSBzaXR1YXRpb24gd2hlbiBzb21l
DQo+ID4gLQkgKiBwaWVjZSBvZiBoYXJkd2FyZSBpcyBicm9rZW4uIEluIHN1Y2ggc2l0dWF0aW9u
IGp1c3QgcHJvZHVjZQ0KPiA+IC0JICogZXJyb3IgbWVzc2FnZSBhbmQgcmV0dXJuLiBDYWxsZXIg
bXVzdCBjb250aW51ZSB0byBoYW5kbGUgdGhlDQo+ID4gLQkgKiBzaWduYWxzIGZyb20gb3RoZXIg
ZGV2aWNlcyBpZiBhbnkuDQo+ID4gLQkgKi8NCj4gPiAtCWlmICh1bmxpa2VseSghaXRlbSkpIHsN
Cj4gPiAtCQlkZXZfZXJyKHByaXYtPmRldiwgIkZhbHNlIHNpZ25hbDogYXQgb2Zmc2V0Om1hc2sN
Cj4gPiAweCUwMng6MHglMDJ4LlxuIiwNCj4gPiAtCQkJaXRlbS0+cmVnLCBpdGVtLT5tYXNrKTsN
Cj4gPiAtDQo+ID4gLQkJcmV0dXJuOw0KPiA+IC0JfQ0KPiANCj4gSXQgd291bGQgYmUgZW5vdWdo
IGp1c3QgdG8gcHJvZHVjZSBkZXZfZXJyKHByaXYtPmRldiwgIkZhbHNlIHNpZ25hbFxuIik7DQo+
IEFuZCByZXR1cm4uDQo+IA0KPiA+IC0NCj4gPiAgCS8qIE1hc2sgZXZlbnQuICovDQo+ID4gIAly
ZXQgPSByZWdtYXBfd3JpdGUocHJpdi0+cmVnbWFwLCBpdGVtLT5yZWcgKw0KPiA+IE1MWFJFR19I
T1RQTFVHX01BU0tfT0ZGLA0KPiA+ICAJCQkgICAwKTsNCj4gPiBAQCAtNTU2LDcgKzU0Miw3IEBA
IHN0YXRpYyB2b2lkIG1seHJlZ19ob3RwbHVnX3dvcmtfaGFuZGxlcihzdHJ1Y3QNCj4gPiB3b3Jr
X3N0cnVjdCAqd29yaykNCj4gPg0KPiA+ICAJLyogSGFuZGxlIHRvcG9sb2d5IGFuZCBoZWFsdGgg
Y29uZmlndXJhdGlvbiBjaGFuZ2VzLiAqLw0KPiA+ICAJZm9yIChpID0gMDsgaSA8IHBkYXRhLT5j
b3VudGVyOyBpKyssIGl0ZW0rKykgew0KPiA+IC0JCWlmIChhZ2dyX2Fzc2VydGVkICYgaXRlbS0+
YWdncl9tYXNrKSB7DQo+ID4gKwkJaWYgKGl0ZW0gJiYgKGFnZ3JfYXNzZXJ0ZWQgJiBpdGVtLT5h
Z2dyX21hc2spKSB7DQo+ID4gIAkJCWlmIChpdGVtLT5oZWFsdGgpDQo+ID4gIAkJCQltbHhyZWdf
aG90cGx1Z19oZWFsdGhfd29ya19oZWxwZXIocHJpdiwNCj4gPiBpdGVtKTsNCj4gPiAgCQkJZWxz
ZQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQoNCg==

