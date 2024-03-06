Return-Path: <linux-kernel+bounces-93341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6DC872E48
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515B4B23BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0517BB9;
	Wed,  6 Mar 2024 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HhRzuAvu"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C07DDA8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702597; cv=fail; b=B9DjlVyST3WoYtpl+s1vBcCKybGKyDR3X+gpYOZh6mP5PKfZSXN5qgVrByiBuiT/Nm5c63QMimx6q2DHiiIti4Z91M6WJi0bpPB3c9NwDfkUSu4aGMKFJqgsIDLYnYqltnRWQAIr/DZcKVbHm21D3jn1KBtI5ZFAnusonk8wOrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702597; c=relaxed/simple;
	bh=2QludZnwUXCwCFeknaMvv2ioSJOybnaK9uNax8w2Ho8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VRU6jugnqgw2qyKQV5BbmHXr9AJli15qxZ7r8EZJZWKHDESBaZRfM1mEFMQxes0V5uSV4elmhEoYRTgci3vW4Gm0p/mRT/L7ldIM/xQDtlpQm8k0wdQPX609nNoNjajZQA39t61ZRgdEfWH6xir0JMuQ1DO6gPHXSWhHbmmig10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HhRzuAvu; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC0XeU60vAsX6n8EIuhWf2A5V0THDtlRb9tJN4tiL1TXUIvWAl0DCnVxK7n9C76oK7fwZX0fUOultmAuwN5PzpQqhvqtPYvmp9BaEhOJ4R4JimnEKp+M1xsh2CNMMAEVb7MM1upUzXwSvfwAcQ4buXrYw/Ob2zob1BxDDAExgikY08Vnqik4fhriAa89JFWuHQ60TCq8iizuQwggISkicx1QsQjQePU9EX0IX+gWH1bO8q7GRe9KO6Qvs/6/L4suzgUNiXSVEcvsaDU5vvBjqWNT8cW0imcW3N+ghoMFHRlCwXcyW8/hXN8WNL29VgnWBGMiNKdILLGt6T/6RQ6Bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QludZnwUXCwCFeknaMvv2ioSJOybnaK9uNax8w2Ho8=;
 b=Du69olwP8keLJYSmG+1vEEur+XN3mTtz8mHtnm14n80GdsRPfjA0V1XQVKdSdJYOi+rpbR+Ht7qwktcoPOLjDsSjk95UUcFygQEk9CoWpLDd1NEVzclVQOm3kP82GgGpbMuiotFMeOi3nZBZS4fhGjhvgTCzKVaMC2VV77QLASR8O7uP1/shF63JR7Km3H8cKbrXtlBe0Ts3k6qg6v0G7xjb+uANccAcGkDsN+UdNaHede9+BPqNzG8h6D40MZeBbW1T9/zAyvgUYyy2LXNN+4EhpSXUqNzKAQiGa5AwCjEJXYyUXvqzdiC66iaSv950B4jCy7fa+zwwN4K9ErDmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QludZnwUXCwCFeknaMvv2ioSJOybnaK9uNax8w2Ho8=;
 b=HhRzuAvukXjt4sA4ipiRY5X1i8b4STTbzD2OInXYMK34i8CEga8ZKKnLkYd1+6F0DWHHvflL1Q+pSJ7L6zr4Zit55af8ZA2+d8t58fyoXPEw63QDoOYGheaUNqwPOa1NDqPXWRLw8iCHXoUDaGXrYrKUXbWmqF/9J9Etk37rYYlbI/gZcOIA8pSRlKv2wQltdnw2OEIEKezEuEa2pb8ZZgSafm9q5qmII05saj+o+Kvk9ZEy4LQkSiu+fuwTDvYDHYjl+5fsXkREJ7oXZKIj6kwGUxDP8KwVd29n9rojRLvFYbarei3nuvrVRQwRNs9INhK4wVSG2/1eDgHYszr7rw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 05:23:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 05:23:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, James Smart
	<james.smart@broadcom.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] nvme: core: constify struct class usage
Thread-Topic: [PATCH 1/3] nvme: core: constify struct class usage
Thread-Index: AQHabv9N+Oz1ihH3AEu6ydsnG1QMpbEqLsGA
Date: Wed, 6 Mar 2024 05:23:10 +0000
Message-ID: <d0550f07-5b1c-4478-9063-f411b223788f@nvidia.com>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
 <20240305-class_cleanup-nvme-v1-1-c707fc997774@marliere.net>
In-Reply-To: <20240305-class_cleanup-nvme-v1-1-c707fc997774@marliere.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4431:EE_
x-ms-office365-filtering-correlation-id: a4a0bca8-8f10-428d-5550-08dc3d9d835f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oQ5xqJtOHWCB9KhqQbK/ukmUITIyfhOTndL6l0HlyLVPl6IthN56iUN9vfO1YqrAFAM+a8qhPDZEwlxl0we2XbilWT5udZxdcYl43nT0TcBqcd+zA1eOXFLkzqBsuxqNR4VFf0MhqxmuvxnDk3QPgKSMG+dvbpdWIF6/WUj3WqfP2gbL5mWB/0B4y+nkqV/ZylX4WN1d3ITvFGr8xht2MPbJzgJzdUPHi5h/JZqk4xDGzBLiMAyCfYLOZex1Wlsx1grXUJLyMRsX9QxqPu8d6usCMcp270vvcJBs409HylV8FNkdbnpSNTjxyEDBKh9MRRYb7kWbXr5MTl/y41mxJ3IJrPfXipSDCrquzFbonVe5hviPirds2nmpOfo21bd49BOh+YMYe7OttzK3kC8a73wbExWT11bUR5o3Wnvhr/7bYqstJjbadqatE06W8vWn2Ivy4MGvi9vPvhyey1AAlfbysg0LB7B4AKDjYOnfOzvStBvlVk9mRUXYJA56EWu1HiLaKm6S1QPWhX6Qu0GT2x59PZaOtVCqMVumRayYhwhMz8vmZBPxYczwe3FqttHl9p0ACKzif5eQpV4pXP9mZjk4PCqsU06CcGeEnI7GLurZ+ssh/3QaxuS0wZnsQN2uCqoYuw05qNPgXiBQmzfQ5c9feCYtQLqRAQ/RfCNaZ6WZIf03YHzrqaRLJFXL2o55l1Qt2uap1DEb1RsiOLx3m3325tQsvOAVScKhMQF21hs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnZNMmhXdkEyOU55M0w0ZzZ6cDhYYTNld1M1ekdoTms5ZkhzMWplTVFaaXA4?=
 =?utf-8?B?R3pyZ1dJcEZ4cG9uMHFHdUdaZHU4SmQ4SEtNWlo4NXVGNkZXMVlYQ05oeEZ3?=
 =?utf-8?B?d0lma1JNUVdHd2VOSW5Db2Iwa1NJdFBKNzIxTCszYURYVE41bVBXU0hKN2k5?=
 =?utf-8?B?SU9TUVZJVGQ5R2dYZUVXN3djZTByR1JMSTZZYkgxZkEyTGlFdXNib0xJTlZN?=
 =?utf-8?B?SG1uaGx6Y3NmNkZkbC9wdkNhRlo5ZG41YUgwWm5jQVNxTGdtQjk2TnhpOERK?=
 =?utf-8?B?ZnRYdEgwS204R2JFMWtnMG1abmFiS0M1cTgyNWE4QkhxTG1KRk5VRzVNeUdI?=
 =?utf-8?B?N1pmMmFyQU05eWhtdnZaYmpTbkNqek5kTEtCTXRPVHpsakJZN3NoMGw1dExx?=
 =?utf-8?B?dVF5YTcvTEdKbzRtMS9FVHlsekRUdEVWVVJFT3FXUnNmR09tSTlsZ25QVXJL?=
 =?utf-8?B?blFmclNZNG1aeXEwTjhGMlUzOHpVUk9nWEYyUlRMOGt5eWFVTWg5aGZpekxE?=
 =?utf-8?B?ekduUjYvZkJnUWxENUFwUnhwdnJDbDRybWhsRkJmS3RNSXc0MXBDV3l4NS9v?=
 =?utf-8?B?SlAzTGZkY3kzcUd3M0ZlT0hXT2Fib0JMM21BbnF1VUR6NEJCRWV1ZmhtQ0Jp?=
 =?utf-8?B?enBiVFNEanJyQ0t3dGE4VXY0SVQ5dHdLVlZscDZ5Zm5MVG9oczVweUJSamVZ?=
 =?utf-8?B?SUZlc2Zndm9WcUY1MHVvUTU5a3BJV0M3VTh4OThGbHFnR1B4dk9TQ0MrcnVL?=
 =?utf-8?B?UXozUlRwT3gzNmZmZitlMzd1QTNBWFpBWTdZbFlTcUFGdG5Ka29CbUdNQWRx?=
 =?utf-8?B?VjRyU2dscnVFY1BhS3ZVT2ZIMW1JOHhrdVp0NUU5ZlVuaVl0NlpOd1V3R1JS?=
 =?utf-8?B?b2VuZ2ttU0h2QnF4MU1qRjk0WDlBZFhsMFJBOUl2YlpUS2hzMG1kWEYyOGlm?=
 =?utf-8?B?TTlTdWFZT3p5djRnVDN6M1VFc2hsWDBMbmVNWFpkOW55cnlQbUNvZkhuSDBV?=
 =?utf-8?B?bGdjRVB4M3JFdUYwRzdyNE4yOXdrekN3WTVuTUNScmsrM3dPZnFWaFhJTURq?=
 =?utf-8?B?TTlxU1RLQUcrcHF2Mmx4UTZSeGl1ZEo0M3VHT3U2OUxkVGpqZEhkMnA0UHJW?=
 =?utf-8?B?czRubkpCWmFIbWNBMG03eEJ3S3VvZkZKdU1xRlF6SFRibWNBK2dhMWdYWndL?=
 =?utf-8?B?SlNQWmwzQThTbnJpM05tYjEycTV5V3R4YXU1dEFpaXVpem9EYzkvWG1nVVpa?=
 =?utf-8?B?NEh6WnZxZG02ZkIrNlVYaC85ZFo0MUI0RGwrck1zRlBxd1VJTWpVdzVQUzJ6?=
 =?utf-8?B?cE1MdC9MYWpDOE5SUmI2RVE2SzAwMmdxTFNzWldCZk1zK1FUMnJZblpwQlUz?=
 =?utf-8?B?Rk8yN1luV2dFVWovdGszcXNZWGlFZ1gxVmtiT2pDMGxnblBndXZ4cWoxT0Z1?=
 =?utf-8?B?TjlFc2k5d0tzTFpmVzNBVGExMjZ3S2VDVm83RVBydHMzSG5YVkJNQzRSZzNR?=
 =?utf-8?B?SEtwNnkxTU9zaEVock1rOGtWYnd6TUZtMHFydGtMd1dpZjJiOHpNc2JPTGxr?=
 =?utf-8?B?SEF2MTVHNVRjOFNyVG9vbWxFUTg4VEZWYjFHZ3JSdVJsdnM3ZWJvM3BjNVBC?=
 =?utf-8?B?QTUxMG1RWVlTY2RQNERjTmVjR2ZJRXZKNVNnK1R4OEVSUUViVk9nUlA3YnNC?=
 =?utf-8?B?eGFqTXFOdlpjL1MyNFlCYXJzaWVlS1NuQ1JOdHdYbnRUdFVzUmFiSGZmRlJE?=
 =?utf-8?B?UGFMMXlVRWM3Q2dvek9NLzNiVGQrL3FMR2dQT1dVMmoxZXRGWUVMNHFuZHB1?=
 =?utf-8?B?Y0s1VEVlYkVJTkg3RjdYeld6RWpPc0g0Q3psTHRmb1B0bDlhamdGQ3kwYzE4?=
 =?utf-8?B?UjZBNG80b0tDT0d3WVU2WXR0VmZRRk1sU3pPdExhM0hIR3FEZUNOK0s2S2ZY?=
 =?utf-8?B?NFBHMHE5MXo3YUllcWJNVllOSEdDcjBSZ1hsTEh6WWZVTk13VWlSRlRuazli?=
 =?utf-8?B?SkthQ3FzeUc3aE1EQ1pxOENxWlpjYk1OQ1JlT1R3N0N6MzE0ZzZQcXk0WVdv?=
 =?utf-8?B?aUpYbXJrYTBuM3d4RzIwSzhkVGIwV3oyWkhnTXZXOTJndGhNNmRCQzE5eCtm?=
 =?utf-8?B?TGRFbk1qRE1EZlhMcVphWkI4WlJZenNLajRQOTZ0bWREcjB0cXExditBdXli?=
 =?utf-8?Q?1BDALIeLioDPfdgbT3UdFWHJesBZjm/J1UG9KWeJg+jc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D2A8B51BFF72A4093BF672B487C5FB5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a0bca8-8f10-428d-5550-08dc3d9d835f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 05:23:10.2500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2126L+kQzogSalItPSp217AIVdliU7PuP5ANATLLfpr2P7PJS+olCtoIm1ulZ7jlTtMBMYz5j4FecvOXr+XOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

T24gMy81LzI0IDA1OjE1LCBSaWNhcmRvIEIuIE1hcmxpZXJlIHdyb3RlOg0KPiBTaW5jZSBjb21t
aXQgNDNhNzIwNmIwOTYzICgiZHJpdmVyIGNvcmU6IGNsYXNzOiBtYWtlIGNsYXNzX3JlZ2lzdGVy
KCkgdGFrZQ0KPiBhIGNvbnN0ICoiKSwgdGhlIGRyaXZlciBjb3JlIGFsbG93cyBmb3Igc3RydWN0
IGNsYXNzIHRvIGJlIGluIHJlYWQtb25seQ0KPiBtZW1vcnksIHNvIG1vdmUgdGhlIHN0cnVjdHVy
ZXMgbnZtZV9jbGFzcywgbnZtZV9zdWJzeXNfY2xhc3MgYW5kDQo+IG52bWVfbnNfY2hyX2NsYXNz
IHRvIGJlIGRlY2xhcmVkIGF0IGJ1aWxkIHRpbWUgcGxhY2luZyB0aGVtIGludG8gcmVhZC1vbmx5
DQo+IG1lbW9yeSwgaW5zdGVhZCBvZiBoYXZpbmcgdG8gYmUgZHluYW1pY2FsbHkgYWxsb2NhdGVk
IGF0IGJvb3QgdGltZS4NCj4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQo+IFN1Z2dlc3RlZC1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJs
aWVyZSA8cmljYXJkb0BtYXJsaWVyZS5uZXQ+DQo+IC0tLQ0KPg0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg0K

