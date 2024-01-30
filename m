Return-Path: <linux-kernel+bounces-44791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB6842772
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B443285002
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E35C86131;
	Tue, 30 Jan 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SLl40RIw"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46882D94;
	Tue, 30 Jan 2024 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626854; cv=fail; b=avmLAYvjyIiEq4nPkYhNP9banAEpgz6McZm3iZLwboZH3423K2yMr+DPXJyqvt5s09HPCox8cCMYv1UhLfqJudURwljz25MYFYgkUrqCr2KliDnL/6gUnLfkiPkp/bq+OzySaAL7xqMdsFpY7eWlP9zzhEZuh1tWNCGfkM21iHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626854; c=relaxed/simple;
	bh=0n/E937tP7elbMZfny/mIi6fbIYp1Yw8IOBqOZff+bU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t3l27vWr1mWeoiSUrFGD05CqL5mOcAN9NXSvWM7xw3AIPGybLd408cgxjPa3n1jTut52DmCreplt3R1FsU6xBjiF8pjxPmrRpjoIwBcVQ0ymGavShyrodtLAcbdoiU1OgUP2tv/N/Gcn2HioiDIHNlXV7pAG0J2z9Q1VokrSrg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SLl40RIw; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOUdD7JOcfz9R/ghHs+YDz2ibRzWFvfaXwk+A1QGRDPY+3DNIuKdD9vi0WcerdKrAuaLNaNP71laZltdE2CdH0FoLYncdEciZFS8E+znpvjZd9M+JPF5dJkzv/rcCQhQs8EXQoLPfV6wjdunPOTcLETXj1AoQ1ZQQmOulkRbE6FDfp+FjNODT93z9DumJi62JISfJ3djkICwR0SqRayiGDSX3cspwaCcwtMmAlksy0/qGX1QYYPByRkrgNW0NcBI/9FhzZSUu0YIN0jxdqDYA4IyuUNZZyKUur6dP+ZFrFkz11SRF50Bg6//wx4G/2YcRYU8w4PJwQzhjKV9OLDvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n/E937tP7elbMZfny/mIi6fbIYp1Yw8IOBqOZff+bU=;
 b=B4cWvkZo20xb+qZqe+NLTb/w8xGDsGeu2tBWEww7w5AVlomxHsJtuj0fi17irNDe9Ma3/c9WL41jHXxh0IzwWP3zOpxzJec+kql6fxxuDzPdqSlsdS7gDW7RFTr50IegmdhcYRWndYzI8kTSw38vIFFcFv6AoUoWEFl+UbeVd3v6ZxMOoGWDSmMXDJiB8cgYV6ld9toOWG+eGv9O6hSviwLD60lubwr/zFg0k8jISE1QJqa42KzrwWpC+UrTTyNJ0vPYZzLAOrpB58bczqBjyy72/Ptp56cCb2y9BdFMrDkhfV5GvSa69q/Ws7x8PlMMpilZWcnBpex+qzppDZrQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n/E937tP7elbMZfny/mIi6fbIYp1Yw8IOBqOZff+bU=;
 b=SLl40RIw+o6K9iAvxPJUU4ArrSX+McXRO9wAdwP99c1slaJGPSDtKtfXZTH/Ubuyk1+OJ8Td6Q5Uu06ZqoB0KQ7AO+oPZg1IJPXAIfL3giJNVp8eIMiSy0ivdLtpv3ubGTbhuHAmWEkyz4cvckpz5k6JzSJJAtz/iCmK7+5q9Ss=
Received: from BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 15:00:50 +0000
Received: from BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::4a52:8ccf:4402:e40]) by BY5PR12MB4241.namprd12.prod.outlook.com
 ([fe80::4a52:8ccf:4402:e40%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:00:50 +0000
From: "Cvetic, Dragan" <dragan.cvetic@amd.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Kiernan, Derek" <derek.kiernan@amd.com>, Jonathan Corbet <corbet@lwn.net>,
	"Simek, Michal" <michal.simek@amd.com>, "Erim, Salih" <Salih.Erim@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Thread-Topic: [PATCH v3] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Thread-Index: AQHaU3uqXvmDWUqQ10+miS+FSmdmO7DyauuAgAADIcA=
Date: Tue, 30 Jan 2024 15:00:50 +0000
Message-ID:
 <BY5PR12MB424156FCFE0E76DBCCE80862E27D2@BY5PR12MB4241.namprd12.prod.outlook.com>
References: <20240130125309.4019261-1-dragan.cvetic@amd.com>
 <8b01a23d-c5f1-474b-b69d-ef629d6d5f24@linaro.org>
In-Reply-To: <8b01a23d-c5f1-474b-b69d-ef629d6d5f24@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4241:EE_|CY8PR12MB7146:EE_
x-ms-office365-filtering-correlation-id: e8d48c78-7199-400d-797f-08dc21a43f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4L4tXjanW0J0s79bBLkwgUZsXLWS2HVfNT3StxB5H/uo1lCqx0uQ8Ya2EGTw30yO5h5ChcyCPHzkVsBZcKSNa517/Dqo3ugu5ru8c+In5YGsRHY0v0sTQkkuZeNLrG9Rzh2KT+4pleGyAiFyZYeFdqs9kZkh66LCKHPW8lV9SmMCs2yQX8LV+UYlWVBYoK1drjX7dsLrwI0L8S3hj7L58B3JiTpc5/XGUr9VTYT9T7ctbI3QwRfn+bf9AyCnLBBczCzBq0+6VqLSv+RvwOTii+y9QivRlBzEl27ddN9NXUrBTXLJNtQ3fQr3uhulQ7z2J+rYOoVql0oXMdZh8i5/qCv3SvxYkaTURUWPzfwUVN61khZHyFPheSJzPguJazCKVeZ3DvIpqgZCM7u4gmfctfzVrNbyrjH+4C2G8blw2E/fTz2v3x0RkIpo1J3rvICLMh8G2HWkOeA3/QWt8Y4fUj8t47OiSMixX1v89oPX4VAgON+6E4qpMeGRTCmnI0x1A8QIVyOftOuN3kKQyU8HRsKfnS849TszsRreWJ8efUJA0rDKCM33SduvZz5uR1P8SZthoBqmbrXZf+B7MEsopTN8F91y8ez51w6cG2cDKiWkhPbpJ+vgvexAVFNce+BucUlfPyb8kEG1M7uS4NS279Q8pIOnCJmTjScSil41F78=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4241.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66446008)(64756008)(316002)(66476007)(8936002)(66556008)(33656002)(66946007)(76116006)(8676002)(110136005)(83380400001)(478600001)(86362001)(71200400001)(5660300002)(52536014)(38100700002)(2906002)(966005)(55016003)(7696005)(53546011)(9686003)(122000001)(6506007)(921011)(38070700009)(26005)(41300700001)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUFvS2tZUml5R1pRUDhCVGk2RFpXcmFiWXNMRDBCZXh2T2VKeGRUY28rS3FP?=
 =?utf-8?B?WkM5VUFyQzdaRnErYngwWXFzT1UwZTc4WFkvdithZFhDSk9ObUpSVkEyR2dm?=
 =?utf-8?B?WTB5elJWN0VUOFhGMkFkeCtzNTcyRVBTRzFCdnlWNVgzOUpCUlB6TlVjc3pX?=
 =?utf-8?B?bG53MEcySmJMUXV4R1diNExhY0VqWC8wNXlWUnNGaTlBUEl2cXI2MWxnUVpV?=
 =?utf-8?B?STBHd2dqRHArMjk3RlhVMFpINFVHZkc0ZGp6RWFEUjBPRnRnMUZuVGFPazR5?=
 =?utf-8?B?MFBWanRuQ2duWFkyNzZoOGpSUzBZbFZJSXJvaVdCSEw3OUc1d0tXc0szUzFi?=
 =?utf-8?B?L1k0YnlYV2RKcHZFajROdVBUbjRqNjloSHltd2ZhNlpZbTkzenJTWGZVSFJm?=
 =?utf-8?B?U1hJblZnV3N0M0RQZHdkekRlcXFOY09WOVZjVEJiNWlxRWw1Q1ZHZXNMdm1i?=
 =?utf-8?B?UWsxK0lYS1NPaTdqWjhuaWxHOUNCWlpobi8xYnRXRWNNd0Y5Q0tkWmx4aFYw?=
 =?utf-8?B?eElpKzF4SnRwYUlMWmorSTdmcUR4L3Q3bEpRb29ESFBUUXBJeUwvRGhyczFh?=
 =?utf-8?B?TmhhQ1NLY1RXUWZwMG1YQTBsaEFZdnFBN0l1d0RRV0lpNGx1T3N3VGpRM1JB?=
 =?utf-8?B?RmpSbHpJVFdDdGVybC9zaEpVdllFUUZiWGY3eHRWL0IxS1JDTk4wQ09COVY0?=
 =?utf-8?B?MTVpbXhJWU43ZzJMcWFZNU1YM1hGWWdYSXpDNUpCK3YreGNSSkt4dFNrZzRu?=
 =?utf-8?B?Z0ZtdEZ6TWpSZnFaVnVrYUdEb29kYXVESHJoV3pYL3FoSGxnaEFRTEpweGtR?=
 =?utf-8?B?blhCNTQ0VmRQanVqMVRtY3NRaEl4UklRTURaOXY1cHhnSzFnZ21ZNEcrSk1G?=
 =?utf-8?B?cmpjRUx1MFJmU2drYk4zeTRPcFNOUFBrb0pFdm9BNEl0dFBvNEs2OHJGdUVq?=
 =?utf-8?B?L0RQZUZrNDBjMy93K0NKMHlwcCtLWUdiVCtocXlHbjZMQWxMSWlkbmNYUVRl?=
 =?utf-8?B?enZObDIrME5Ua2FIclBvYXlTV3BmVW5idEc0ZEZDZEUvZ29aM281OXhCZW1H?=
 =?utf-8?B?Y2dvTDZkMHFaUXVmaDl3cHQ4MFFjMWY5Yzk2M2FVZG92OUJReWdkTnl1Rk13?=
 =?utf-8?B?enR4MUFaTVlvWHNlRUUrSTBlKzNCVW05bDlNdnpwVnpCOFpXdGJvc2dBR1Z0?=
 =?utf-8?B?NnZrRC9YMStmZnFGMTlJVTdSN25nNXFsSW0xT1l3OUhyajQ3MmhkNHRQQmRu?=
 =?utf-8?B?VXBicWIveHRIVmkzc0lDVTJqTHV5TkViZHlaWU5VSUJNOTNqL3ZaSnpCZXBM?=
 =?utf-8?B?Q1hsN1BEK2daWDZEb3pMVzhzRHpZdFR2alhFSmNsTUM1blBHUEhvVGszMGtk?=
 =?utf-8?B?WFhSYmV0eDQ3NkZVK00yMXpOYVBMdG9LVHhIcWErOEQrYkF5dEl2bWRaTVov?=
 =?utf-8?B?Qzk1azd3TERDbU42cytCeGltNFl4S0RQVTM1bGNQQTZsdGErMmdvcjQ0eEZF?=
 =?utf-8?B?ZkdnZ1ZOOEJkTFVDbzZmSGt3NG5OMHFOSklFYTZXWFA1MDdLR1M3WGc2c0xJ?=
 =?utf-8?B?dUdzRmwrL0dHcDdmVmtKM1p1VkRTN1JhNUo2QXFwU0RUM0JlT1JFUjArcDNx?=
 =?utf-8?B?RXdvZVU4N1pxQ3R4NmFqVmdvOHBzbnlnNEl4OWlCUGMxYzcvWG5PZlR6U0Vr?=
 =?utf-8?B?ZHFGeGFCTEhYMTI0NDdZNGNaSnpKTkQzV1hLOERTMy8yV0p4azJVUnNZRitH?=
 =?utf-8?B?ZjZNWkVmamR3elpUOFZGQUpubXJIOFdsZi9JemVpTXljMlpxalVzNFl1YzhD?=
 =?utf-8?B?Unc2VTgrTnFTMEVDL2hLaGFqdVpFUjNicVcvUDJlM1AwRWhBaFJTb002RTVk?=
 =?utf-8?B?YXlmd0htNDFKdGJrTjJJNldPWkJoQ3ErUkxIaXNsNDNGaXo2cW5CMnFJaGdR?=
 =?utf-8?B?WWJNNndPVVpnaExVa1hFSXU1eER6ZWY0WFIyTUpGNHZTTHNrcmVUTzczS0M1?=
 =?utf-8?B?YnpCZ3dWdHFJUUdNVXpaVVBHdXNlZjh1clVGS0VYMS9yakdRb3RielRheUJ6?=
 =?utf-8?B?YkdHYkpUMXcyQk1JVHg4b1EzTEttTzdWMUtjMm42elBRdFdwWmtZcjBseDFL?=
 =?utf-8?Q?VVNU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4241.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d48c78-7199-400d-797f-08dc21a43f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 15:00:50.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYJsPLNtlfc+TMXySeF8OvvV2wbQWqleJRAJdqf5FwZTzdTxyzX+EFatiKxVDcXu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogVHVlc2RheSwgSmFudWFyeSAzMCwgMjAyNCAyOjMxIFBNDQo+IFRvOiBDdmV0aWMsIERyYWdh
biA8ZHJhZ2FuLmN2ZXRpY0BhbWQuY29tPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVs
Lm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyenlzenRvZi5rb3psb3dza2krZHRAbGlu
YXJvLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+IEtpZXJuYW4s
IERlcmVrIDxkZXJlay5raWVybmFuQGFtZC5jb20+OyBKb25hdGhhbiBDb3JiZXQNCj4gPGNvcmJl
dEBsd24ubmV0PjsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBFcmltLCBT
YWxpaA0KPiA8U2FsaWguRXJpbUBhbWQuY29tPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUgQU5E
IEZMQVRURU5FRCBERVZJQ0UNCj4gVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc+OyBvcGVuIGxpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgb3Bl
biBsaXN0OkRPQ1VNRU5UQVRJT04gPGxpbnV4LQ0KPiBkb2NAdmdlci5rZXJuZWwub3JnPjsgbW9k
ZXJhdGVkIGxpc3Q6QVJNL1pZTlEgQVJDSElURUNUVVJFIDxsaW51eC1hcm0tDQo+IGtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBkdC1iaW5kaW5n
czogbWlzYzogeGxueCxzZC1mZWM6IGNvbnZlcnQgYmluZGluZ3MgdG8NCj4geWFtbA0KPiANCj4g
T24gMzAvMDEvMjAyNCAxMzo1MywgRHJhZ2FuIEN2ZXRpYyB3cm90ZToNCj4gPiBDb252ZXJ0IEFN
RCAoWGlsaW54KSBzZC1mZWMgYmluZGluZ3MgdG8geWFtbCBmb3JtYXQsIHNvIGl0IGNhbiB2YWxp
ZGF0ZQ0KPiA+IGR0LWVudHJpZXMgYXMgd2VsbCBhcyBhbnkgZnV0dXJlIGFkZGl0aW9ucyB0byB5
YW1sLg0KPiA+IENoYW5nZSBpbiBjbG9ja3MgaXMgZHVlIHRvIElQIGlzIGl0c2VsZiBjb25maWd1
cmFibGUgYW5kDQo+ID4gb25seSB0aGUgZmlyc3QgdHdvIGNsb2NrcyBhcmUgaW4gYWxsIGNvbWJp
bmF0aW9ucy4gVGhlIGxhc3QNCj4gPiA2IGNsb2NrcyBjYW4gYmUgcHJlc2VudCBpbiBzb21lIG9m
IHRoZW0uIEl0IG1lYW5zIG9yZGVyIGlzDQo+ID4gbm90IHJlYWxseSBmaXhlZCBhbmQgYW55IGNv
bWJpbmF0aW9uIGlzIHBvc3NpYmxlLg0KPiA+IEludGVycnVwdCBtYXkgb3IgbWF5IG5vdCBiZSBw
cmVzZW50Lg0KPiA+IFRoZSBkb2N1bWVudGF0aW9uIGZvciBzZC1mZWMgYmluZGluZ3MgaXMgbm93
IFlBTUwsIHNvIHVwZGF0ZSB0aGUNCj4gPiBNQUlOVEFJTkVSUyBmaWxlLg0KPiA+IFVwZGF0ZSB0
aGUgbGluayB0byB0aGUgbmV3IHlhbWwgZmlsZSBpbiB4aWxpbnhfc2RmZWMucnN0Lg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuLmN2ZXRpY0BhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLS0tDQo+ID4gRHJvcCBjbG9ja3MgZGVz
Y3JpcHRpb24uDQo+ID4gVXNlICJjb250YWluczoiIHdpdGggZW51bSBmb3Igb3B0aW9uYWwgY2xv
Y2stbmFtZXMgYW5kIHVwZGF0ZQ0KPiA+IGNvbW1lbnQgZXhwbGFpbmluZyBkaWZlcmVuY2UgZnJv
bSB0aGUgb3JpZ2luYWwgRFQgYmluZGluZyBmaWxlLg0KPiA+IFJlbW92ZSB0cmFpbGluZyBmdWxs
IHN0b3BzLg0KPiA+IEFkZCBtb3JlIGRldGFpbHMgaW4gc2RmZWMtY29kZSBkZXNjcmlwdGlvbi4N
Cj4gPiBTZXQgc2RmZWMtY29kZSB0byAic3RyaW5nIiBub3QgInN0cmluZy1hcnJheSINCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IEZpeCBhIG1pc3Rha2UgaW4gZXhhbXBsZSwgc2V0
IGludGVycnVwdCB0eXBlIHRvIDAuDQo+IA0KPiBXaHk/IFRoYXQncyBub3QgYSBjb3JyZWN0IGlu
dGVycnVwdCB0eXBlIGluIG1vc3Qgb2YgdGhlIGNhc2VzLg0KDQpUaGUgaW50ZXJydXB0IHR5cGUg
aXMgc2V0IHRvIGFjdGl2ZSBoaWdoIGluIElQLCBjYW5ub3QgYmUgY2hhbmdlZCB3aXRoIGRyaXZl
ci4NCkkga2VlcCAwIHRvIGJlIGFsaWduZWQgd2l0aCB0aGUgb3JpZ2luYWwgZG9jdW1lbnQuDQpX
aGF0IGRvIHlvdSBzdWdnZXN0Pw0KDQo+IA0KPiBXYXMgdGhpcyBwYXRjaCB0ZXN0ZWQ/DQo+IA0K
WWVzIGl0IHdhcywgYm90aCAibWFrZSBkdF9iaW5kaW5nX2NoZWNrIiBhbmQgIm1ha2UgZHRic19j
aGVjayINCnYyIHdhcyBteSwgaHVtYW4gbWlzdGFrZS4gSSBzZW50IHdyb25nIHBhdGNoLiBJJ20g
c29ycnkgZm9yIHRoYXQuDQoNCj4gLi4uDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy94bG54LHNkLWZlYy55YW1sDQo+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21pc2MveGxueCxzZC1mZWMueWFtbA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5lZDg3YzQ4YTllZTkN
Cj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21pc2MveGxueCxzZC1mZWMueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTM2IEBADQo+ID4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4g
PiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL21pc2MveGxueCxzZC1mZWMueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogWGls
aW54IFNERkVDKDE2bm0pIElQDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEN2
ZXRpYywgRHJhZ2FuIDxkcmFnYW4uY3ZldGljQGFtZC5jb20+DQo+ID4gKyAgLSBFcmltLCBTYWxp
aCA8c2FsaWguZXJpbUBhbWQuY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gDQo+
IERvIG5vdCBuZWVkICd8JyB1bmxlc3MgeW91IG5lZWQgdG8gcHJlc2VydmUgZm9ybWF0dGluZy4N
Cg0KQWNjZXB0ZWQsIHdpbGwgcmVtb3ZlIGl0Lg0KDQo+IA0KPiA+ICsgIFRoZSBTb2Z0IERlY2lz
aW9uIEZvcndhcmQgRXJyb3IgQ29ycmVjdGlvbiAoU0RGRUMpIEVuZ2luZSBpcyBhIEhhcmQgSVAN
Cj4gYmxvY2sNCj4gPiArICB3aGljaCBwcm92aWRlcyBoaWdoLXRocm91Z2hwdXQgTERQQyBhbmQg
VHVyYm8gQ29kZSBpbXBsZW1lbnRhdGlvbnMuDQo+ID4gKyAgVGhlIExEUEMgZGVjb2RlICYgZW5j
b2RlIGZ1bmN0aW9uYWxpdHkgaXMgY2FwYWJsZSBvZiBjb3ZlcmluZyBhIHJhbmdlIG9mDQo+ID4g
KyAgY3VzdG9tZXIgc3BlY2lmaWVkIFF1YXNpLWN5Y2xpYyAoUUMpIGNvZGVzLiBUaGUgVHVyYm8g
ZGVjb2RlDQo+IGZ1bmN0aW9uYWxpdHkNCj4gPiArICBwcmluY2lwYWxseSBjb3ZlcnMgY29kZXMg
dXNlZCBieSBMVEUuIFRoZSBGRUMgRW5naW5lIG9mZmVycyBzaWduaWZpY2FudA0KPiA+ICsgIHBv
d2VyIGFuZCBhcmVhIHNhdmluZ3MgdmVyc3VzIGltcGxlbWVudGF0aW9ucyBkb25lIGluIHRoZSBG
UEdBIGZhYnJpYy4NCj4gPiArDQo+IA0KPiANCj4gPiArICB4bG54LHNkZmVjLWRvdXQtd29yZHM6
DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBBIHZhbHVlIDAgaW5kaWNhdGVz
IHRoYXQgdGhlIERPVVRfV09SRFMgaW50ZXJmYWNlIGlzDQo+ID4gKyAgICAgIGRyaXZlbiB3aXRo
IGEgZml4ZWQgdmFsdWUgYW5kIGlzIG5vdCBwcmVzZW50IG9uIHRoZSBkZXZpY2UsIGEgdmFsdWUg
b2YgMQ0KPiA+ICsgICAgICBjb25maWd1cmVzIHRoZSBET1VUX1dPUkRTIHRvIGJlIGJsb2NrIGJh
c2VkLCB3aGlsZSBhIHZhbHVlIG9mIDINCj4gY29uZmlndXJlcyB0aGUNCj4gPiArICAgICAgRE9V
VF9XT1JEUyBpbnB1dCB0byBiZSBzdXBwbGllZCBmb3IgZWFjaCBBWEkgdHJhbnNhY3Rpb24uDQo+
ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4g
PiArICAgIGVudW06IFsgMCwgMSwgMiBdDQo+ID4gKw0KPiA+ICsNCj4gDQo+IEp1c3Qgb25lIGJs
YW5rIGxpbmUuDQoNCkFjY2VwdGVkLCB3aWxsIHJlbW92ZSBpdC4NCg0KS2luZCBSZWdhcmRzDQpE
cmFnYW4NCg==

