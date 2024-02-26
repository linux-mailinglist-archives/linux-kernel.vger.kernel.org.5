Return-Path: <linux-kernel+bounces-81777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4EE867A01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C741C2B134
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC9512FF66;
	Mon, 26 Feb 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K4Wa1ORq"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729D12BE87;
	Mon, 26 Feb 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960521; cv=fail; b=oY8dFgYL35aUZu65Tv7O+TjvaNR+5e86BBGIR4vIWMd7utNAFc1myJZ703fuaBdprtHpW4/xedNwYmclbZfDTYazyqE3IKm+SQX+TCdumti3vFE2tBknj2tylOc93ioRzWqcSr5dA0qLvvodM5d8j9hwJULtPCs+iLBLUYfHMGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960521; c=relaxed/simple;
	bh=CfC+lgCqChRcOs0pSs2goI5OUZUYlWOSv7Wqv1JEYlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r2/fgEBhziQCE+lDmW8GfbKrufCH/UMaiX0zyqYVN3ewLf/m/328rpe2KfPnZHFIzfulpED+DXrQuYlSXnLkGzu2cFAM6I5sc3RKPNLnuYk6x8KuLCSwvNhq3k4Mmlg819hrgcSRhsfp2mTTySPEMD+tqDPtshpN3OvYmJYKpPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K4Wa1ORq; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D77NeW9nwj5AV5ZnvLetT+XrZHcWPuRs+WlFe2RsqwHJGTDZGS+VbITJTqwMAzdwbGbUSs5WGWefzl/rPwz47uPgdEnzjz+eX7tkjYMaRl0030aObEb44w7U/U91dkzWkji+PR5WFGqvrYW7JZ2qj6CtaLoSjm+4Nw9sfxfGbP/Dhafm3g20qzAvFdnlm52xlpGFdiVf2KmngUqVlq1yg+I6k3tiyklrpnV4XcssCn2bDUjVaC0ax7a48m81SAB5kb7T+EhgbiHrEn/3bPPMUg1DVfnOy+Le+y1tZr0ZkGa/NteRUVUNYjoXXiAQQWJ8Zsbr9SZRxbuu368baATOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfC+lgCqChRcOs0pSs2goI5OUZUYlWOSv7Wqv1JEYlM=;
 b=QlZdbzBJN5KIfR/CxUMxQSC4NPgnUN5spgLt/2M/cHLWR6bjaMAtbmgzmj7V1ObXvbAv0r01tr3BYpgW8kUWjJ7rN9X5w7FiI2cUsregQH9qMfE+jkUS9aG8az7kGbJHVkdfTBpMmHmJMfVAmY9QLEht+61Kj9Opq2mGj0jzUNyJwmSa/r5YcfxOrJeC8BpTYYj12VbH1JWKbrAx4r0OifSQYeUwo4d9mNO2oHxzj6o/acRCHCdgZbEExX5YDgz1FEu+dRFPefkijj2ESULJPju1SEYVzjTw+MMmrGRukQmfYmVEwXPaJpU5Te5zp1AS1Z6Cfl3xQDZkGkHzVrhpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfC+lgCqChRcOs0pSs2goI5OUZUYlWOSv7Wqv1JEYlM=;
 b=K4Wa1ORqCUcwzYAoA7B2J9SzFcEEZyPH/nACRUJxPkuA1a7BiAdjiBZvF7IOutg05NhWciQh3YS3QjuiLLsU+QZVkvrIDFNsENiP/7jQ0I+mwsPq2insKkPSyzoISLoNYHCb5qpiaBQELvcp21Z6JVsGASgpbY15OExynVYJZ0HA0wdSmDnXnUiMj1kRgZbPdBp3kn/osyKYR9BCv6hQBZbPsMq9RlBnsLBGgJtM9wZGWLy0n+iSHNavkQpzl0TaLqcWnu5S9FSL98EgYVSu3iRioZS9yHUr3feV5aFECpjk5EywgJZQ0QUSSv+wOSF+ST5pVyeVfITt9SHXOTkZJg==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 15:15:14 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::122:c58:8a3:743d]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::122:c58:8a3:743d%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 15:15:14 +0000
From: Vadim Pasternak <vadimp@nvidia.com>
To: Daniil Dulov <d.dulov@aladdin.ru>, Hans de Goede <hdegoede@redhat.com>
CC: Mark Gross <mgross@linux.intel.com>, Andy Shevchenko <andy@infradead.org>,
	Darren Hart <dvhart@infradead.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH] platform/mellanox: mlxreg-hotplug: Check pointer for NULL
 before dereferencing it
Thread-Topic: [PATCH] platform/mellanox: mlxreg-hotplug: Check pointer for
 NULL before dereferencing it
Thread-Index: AQHaaMPQt7JNWu3hzka2Jxj0r7zdwrEcuVSA
Date: Mon, 26 Feb 2024 15:15:14 +0000
Message-ID:
 <BN9PR12MB538106C733D231B73FC1C1AAAF5A2@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20240226145442.3468-1-d.dulov@aladdin.ru>
In-Reply-To: <20240226145442.3468-1-d.dulov@aladdin.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|SJ0PR12MB6831:EE_
x-ms-office365-filtering-correlation-id: fafb2e27-e3f5-4929-501b-08dc36ddbb9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5dUUYhkN7rrIVxtA/S2V+UAS7TEGrnqb9hV7rpKFeNQ8oUN+pJpWefSRE1bq+5RHJVpU92MSDKCF92ty/K1ePyYMUQ4YUqVJsIzQV8ey6bjPJDN1mkt2g/j1TetBkzu4pJDwGre7XWP32DeCHhHCcXcZKISp/jHNwu/LzjmXIC8ec6rAO6zLPKrRPD9tvtvoKYPZ5X4W+2bBzruko+N1Ln1bc2nvlCGlHk/4ITSPf0thpCzciQcEoYo8kPc1YMMBzG9m9aXIk6Poy4ue96aTCHYravjefjCIsfuSHD73MGiaR4KRTRMUBwkeJEy68aVqWvGJu0CBiFYd0jxbgM0C69+cU8MskeStzbREkUVkl8WqUO+pyfQPf5fnfSNRKm8rBOOX4+i1vgOMRBmHJkSFKhMixV8dNiJ+oJEVIiVAWSmexocAwGTM4Y5Yds/INV2Q38kalInjMDj3sFqJrz8G7+GiFgYTDX8iG3ndOi5XXV88dG4jbz4R8IAnrCfSW2tkvpQLSqsj7GaFjlf8f/LSKvuqjyVOXOSCp/i0USFyruNLyxfHM8bxJSXR0X8qPw88APVPWA0ddUNlxSZ4FoWdhUKW0K010Mfq93c58+C6PXgUeWpwOpdXdYz+BTDnqq+4SffOQqugZN5cl3DaZrNoK3dWaAyHOolbKzmTngT7pp2XvFt38qoXgc8Ri2nDgzTsqdtRmKHJpkf038s0RbmtmkbDK7MTnfdFiYxsy+fnvSw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDUxSTZCeFVIbDNaR0tiOUJucnZMaGo3T2F6RlpkaFAvWVZnNkFVNEd2Rkti?=
 =?utf-8?B?YXdWUkhEaTYza0J1UXFoTW9FZCsrdTB4cEVYTlh2ZVVFZXRLL1VyQ2hGSnJp?=
 =?utf-8?B?VUdSVWRvUFRSUmpZZUxqS003TTFiZmF2eGRJRFBTSSsyN0x4VmRkeUhsUXU5?=
 =?utf-8?B?dW5yVUFwalQwemh4U0k3Zy9TdlVxMW8yOVV4Qy9JNEhZZWM5Z2pKUUdPRmww?=
 =?utf-8?B?MVZ2ekRoenc2RzlUS0V3aVNjME9RS2lZZjYrMVRlQXczSFV6aXpkK1RFdUlU?=
 =?utf-8?B?UTNLdHhFdXB5MFlhSDB6ZTJuUSs4bldIVnFsSnRJYXVxKzRtUWp3a3BSb3Y1?=
 =?utf-8?B?bGh5SVBGMnpHdXhFdjZUUFZWOEJvUTU1akhRSXZzcE8wZkE2RnduMEFORDFZ?=
 =?utf-8?B?RWIxdW5nM2hOMEgyZmNRMGtDRzZlVUFVNk5zTzNLLzdieFJ3Z1hoOE9Ud2w1?=
 =?utf-8?B?SThtaDFvVkY4ZWlFZ0ZHSnc3aHp1eWVMQWtQQWMxRlZqUlh2djNwUnU3bkd3?=
 =?utf-8?B?WS9LNGUvR2VodnJKNnlOSmJFUGQzc2RQb3JQcUFFK29TQWdoeEVyaEE1RUto?=
 =?utf-8?B?blZoaDZhM21mY2VocXY4N29Qb0t2RHlPL2tIVmZ5eS95cnRCdDl2L2pyYXVa?=
 =?utf-8?B?Sm13bHJlUHhjc3c0RTN2MmNPRTFmYXkxeFVGZXl6T1cwenZXWE1UbmNUVk5C?=
 =?utf-8?B?UHc1S0NPMVBjeW9lSTB6d2F6NElmb1JOTklHUktrallndzliMTZNNVpGUXJx?=
 =?utf-8?B?SWpOeUFRK05xMFZkR2M4dVpOWkFCSThHV211czE1RDB3SUVNeUREbTlZeU5U?=
 =?utf-8?B?V1BPemd3MWdxaU5Qa1RwbnNrTUlGNVdhRXQ3a0RDSDFkM2MrSEFsSVRCMzlp?=
 =?utf-8?B?bi9wTVJ1QTgwUThoVk9Va2ZxNTBKQ0FXTlh1TGlhSCs5MXh3bFgxWXBBZE5V?=
 =?utf-8?B?VFpjY2pmMytLVzBiWmRJNkE4NnJTU2RHRkluT1FyQmw3NnozTGxkZDRBcTNV?=
 =?utf-8?B?YWlqVjVFOHNmOVcxeDI1eElSczdvZEoyay9ZVFM4aWpqakJlL2xKUExRL2FW?=
 =?utf-8?B?d0t5Q3NRbDNFNFh0TFQzSUhmQm4wSU51aUNGTmdtN3p3N0t6ZmJMcndTemp1?=
 =?utf-8?B?dmRZTFVoMFEyY2srMmJnbmZTeHlXTGJ6QWxjUWtwVDNFQzFmV0lBajNwaHU5?=
 =?utf-8?B?S2hpaGd2UlFXbmJVS3pEV0E5MlZFNUhTM0NaWkFZeFBaZFNXUFowMGdzUDQ5?=
 =?utf-8?B?Sm4vS0g2RlBtd2VFdVFma2VtZVBuWmdvMm11a0QyeXZBcWFDUXZJUTErT0R3?=
 =?utf-8?B?YVFKVENtWXZtQUxIVXM1UXdaUFJoYW1IQ0UrL3RZQytxVHBOV0lRc2FEOHhJ?=
 =?utf-8?B?ZisxQk5MMG5hRzJFSFgvWk91VnBiaURqZ3J5dTJKYi93VG1yYmw3ODlsajVP?=
 =?utf-8?B?UDhBQ216cGlsTml3VmZTZ21kVml4eS9iSTBadlNreCtSUFd0QWpFcjN3bHhS?=
 =?utf-8?B?cGFISlRZQlR3aE9UaXZGbmFlT0NMOTM3dDMwd3BZazdVU0NZY2RVV2ZBSjB2?=
 =?utf-8?B?QW1ZQW01MmNXRzVteS9udlgwT1FWbWFtSk1xT3lpSDN0NE03Vkw0LytrdkpR?=
 =?utf-8?B?REEveGpFVW1VZ2NkSElKalNxVDQzbFMyRjIxdFprOFVoYU5ubGh6NnE5Y1Vi?=
 =?utf-8?B?eGVKNEVvcUFIbFl3NW5ZR0lzekNKMk1Oa3o2NHhIMHFEaGtTWUN0em5lalo3?=
 =?utf-8?B?QWlIRjZXeFVaM0lHK1ltV254U1lmSUUrTVhWRXVxanJKYUNBbFdaTytaNmVu?=
 =?utf-8?B?OE1UNTAyN3JVZHdmeVRoS0FFTm03UHUrZlhTaCt1d1dRQ0xEbFA2ZFBET1RF?=
 =?utf-8?B?V3BRRTRRUy9aZHNqYmpmTVlpcFh3d3Q5bCtjQkhJY05pTXdnU0pkUHJ6MTM3?=
 =?utf-8?B?Z2NRMjF2NFVGUFU3cm9yTzFPemFtSzBxMmdTQ01JdkgyUExPcW8zVXhibWY0?=
 =?utf-8?B?eWY1RVVBZ0dVRXk0QVhBZ3A0ZmhyS2M5TlJJV0p5N0k4eVFEVm1uVHNpK01n?=
 =?utf-8?B?TGhwcUlSa01BRFYvMTUrSFFaWmI3UENRQ1N3ZG1zck9pVEp2bzMwY0V6ZWZH?=
 =?utf-8?Q?jemZMAooDOB2ewh8LSdJRJojb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fafb2e27-e3f5-4929-501b-08dc36ddbb9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 15:15:14.2673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUrRiJrpHoJT2dm/03DCRw7pqoVEQI9SJAalfZw4wv+nRLTcJvGeFLESoLzOzG4Z8jLuTcjIrd65NtWlgTqdtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWlsIER1bG92IDxk
LmR1bG92QGFsYWRkaW4ucnU+DQo+IFNlbnQ6IE1vbmRheSwgMjYgRmVicnVhcnkgMjAyNCAxNjo1
NQ0KPiBUbzogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gQ2M6IERhbmlp
bCBEdWxvdiA8ZC5kdWxvdkBhbGFkZGluLnJ1PjsgTWFyayBHcm9zcw0KPiA8bWdyb3NzQGxpbnV4
LmludGVsLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBpbmZyYWRlYWQub3JnPjsgRGFycmVu
DQo+IEhhcnQgPGR2aGFydEBpbmZyYWRlYWQub3JnPjsgVmFkaW0gUGFzdGVybmFrIDx2YWRpbXBA
bnZpZGlhLmNvbT47DQo+IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsdmMtDQo+IHByb2plY3RAbGludXh0ZXN0aW5nLm9y
Zw0KPiBTdWJqZWN0OiBbUEFUQ0hdIHBsYXRmb3JtL21lbGxhbm94OiBtbHhyZWctaG90cGx1Zzog
Q2hlY2sgcG9pbnRlciBmb3IgTlVMTA0KPiBiZWZvcmUgZGVyZWZlcmVuY2luZyBpdA0KPiANCj4g
bWx4cmVnX2hvdHBsdWdfd29ya19oZWxwZXIoKSBpbXBsaWVzIHRoYXQgaXRlbSBjYW4gYmUgTlVM
TC4gVGhlcmUgaXMgYQ0KPiBzYW5pdHkgY2hlY2sgdGhhdCBjaGVja3MgaXRlbSBmb3IgTlVMTCBh
bmQgdGhlbiBkZXJlZmVyZW5jZXMgaXQuDQo+IA0KPiBFdmVuIHRob3VnaCwgdGhlIGNvbW1lbnQg
YmVmb3JlIHNhbml0eSBjaGVjayBzYXlzIHRoYXQgaXQgY2FuIG9ubHkgaGFwcGVuIGlmDQo+IHNv
bWUgcGllY2Ugb2YgaGFyZHdhcmUgaXMgYnJva2VuLCBidXQgaW4gdGhpcyBjYXNlIGl0IHdpbGwg
bGVhZCB0byBOVUxMLXBvaW50ZXINCj4gZGVyZWZlcmVuY2UgYmVmb3JlIHRoZSBmdW5jdGlvbiBp
cyBldmVuIGNhbGxlZCwgc28gbGV0J3MgY2hlY2sgaXQgYmVmb3JlDQo+IGRlcmVmZXJlbmNpbmcu
DQo+IA0KPiBGb3VuZCBieSBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcu
b3JnKSB3aXRoIFNWQUNFLg0KPiANCj4gRml4ZXM6IGM2YWNhZDY4ZWIyZCAoInBsYXRmb3JtL21l
bGxhbm94OiBtbHhyZWctaG90cGx1ZzogTW9kaWZ5IHRvIHVzZSBhDQo+IHJlZ21hcCBpbnRlcmZh
Y2UiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5paWwgRHVsb3YgPGQuZHVsb3ZAYWxhZGRpbi5ydT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seHJlZy1ob3RwbHVnLmMgfCAx
NiArLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE1
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFu
b3gvbWx4cmVnLWhvdHBsdWcuYw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4cmVn
LWhvdHBsdWcuYw0KPiBpbmRleCA1YzAyMmIyNThmOTEuLjUyNDEyMWI5ZjA3MCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhyZWctaG90cGx1Zy5jDQo+ICsrKyBi
L2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4cmVnLWhvdHBsdWcuYw0KPiBAQCAtMzQ4LDIw
ICszNDgsNiBAQCBtbHhyZWdfaG90cGx1Z193b3JrX2hlbHBlcihzdHJ1Y3QNCj4gbWx4cmVnX2hv
dHBsdWdfcHJpdl9kYXRhICpwcml2LA0KPiAgCXUzMiByZWd2YWwsIGJpdDsNCj4gIAlpbnQgcmV0
Ow0KPiANCj4gLQkvKg0KPiAtCSAqIFZhbGlkYXRlIGlmIGl0ZW0gcmVsYXRlZCB0byByZWNlaXZl
ZCBzaWduYWwgdHlwZSBpcyB2YWxpZC4NCj4gLQkgKiBJdCBzaG91bGQgbmV2ZXIgaGFwcGVuLCBl
eGNlcHRlZCB0aGUgc2l0dWF0aW9uIHdoZW4gc29tZQ0KPiAtCSAqIHBpZWNlIG9mIGhhcmR3YXJl
IGlzIGJyb2tlbi4gSW4gc3VjaCBzaXR1YXRpb24ganVzdCBwcm9kdWNlDQo+IC0JICogZXJyb3Ig
bWVzc2FnZSBhbmQgcmV0dXJuLiBDYWxsZXIgbXVzdCBjb250aW51ZSB0byBoYW5kbGUgdGhlDQo+
IC0JICogc2lnbmFscyBmcm9tIG90aGVyIGRldmljZXMgaWYgYW55Lg0KPiAtCSAqLw0KPiAtCWlm
ICh1bmxpa2VseSghaXRlbSkpIHsNCj4gLQkJZGV2X2Vycihwcml2LT5kZXYsICJGYWxzZSBzaWdu
YWw6IGF0IG9mZnNldDptYXNrDQo+IDB4JTAyeDoweCUwMnguXG4iLA0KPiAtCQkJaXRlbS0+cmVn
LCBpdGVtLT5tYXNrKTsNCj4gLQ0KPiAtCQlyZXR1cm47DQo+IC0JfQ0KDQpJdCB3b3VsZCBiZSBl
bm91Z2gganVzdCB0byBwcm9kdWNlIGRldl9lcnIocHJpdi0+ZGV2LCAiRmFsc2Ugc2lnbmFsXG4i
KTsNCkFuZCByZXR1cm4uDQoNCj4gLQ0KPiAgCS8qIE1hc2sgZXZlbnQuICovDQo+ICAJcmV0ID0g
cmVnbWFwX3dyaXRlKHByaXYtPnJlZ21hcCwgaXRlbS0+cmVnICsNCj4gTUxYUkVHX0hPVFBMVUdf
TUFTS19PRkYsDQo+ICAJCQkgICAwKTsNCj4gQEAgLTU1Niw3ICs1NDIsNyBAQCBzdGF0aWMgdm9p
ZCBtbHhyZWdfaG90cGx1Z193b3JrX2hhbmRsZXIoc3RydWN0DQo+IHdvcmtfc3RydWN0ICp3b3Jr
KQ0KPiANCj4gIAkvKiBIYW5kbGUgdG9wb2xvZ3kgYW5kIGhlYWx0aCBjb25maWd1cmF0aW9uIGNo
YW5nZXMuICovDQo+ICAJZm9yIChpID0gMDsgaSA8IHBkYXRhLT5jb3VudGVyOyBpKyssIGl0ZW0r
Kykgew0KPiAtCQlpZiAoYWdncl9hc3NlcnRlZCAmIGl0ZW0tPmFnZ3JfbWFzaykgew0KPiArCQlp
ZiAoaXRlbSAmJiAoYWdncl9hc3NlcnRlZCAmIGl0ZW0tPmFnZ3JfbWFzaykpIHsNCj4gIAkJCWlm
IChpdGVtLT5oZWFsdGgpDQo+ICAJCQkJbWx4cmVnX2hvdHBsdWdfaGVhbHRoX3dvcmtfaGVscGVy
KHByaXYsDQo+IGl0ZW0pOw0KPiAgCQkJZWxzZQ0KPiAtLQ0KPiAyLjI1LjENCg0K

