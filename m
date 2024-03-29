Return-Path: <linux-kernel+bounces-125233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD2892290
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37BB28A65A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1892E54BF6;
	Fri, 29 Mar 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="mKcXtHms"
Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020002.outbound.protection.outlook.com [52.101.165.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411311C0DC0;
	Fri, 29 Mar 2024 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732763; cv=fail; b=AwYHoU7bLkdRhkU02hEoTp3/Fw+O02BnTyY3/qq97CqxLLW0w0TQusQ2rukpeghURckaTIQsC+xoK6PduvMrFQA/2j058hDubllPe4dxp9mUi20/oYiBLoQosbDTdqKlaHpBH5XGzvJxSF4iXlUuvCXp2Ij1tz0FOM5bXV2Qn/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732763; c=relaxed/simple;
	bh=w0bZbs4HUM21y3aA0pxGF5Bx+r0SFtuPzFhnU8bgHAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=abs76BLhUuBYNytnl9+l9O+FkO6Sl9PbN1rpnxgcIBVhSvDQvZXo2w7yb1RdBd+uk7I/OYod77pfPNn0oeZI6roUr9rT+huSBDW/Dz5Yw1lGfpJhUOntSgdWYgK41FGngcdMx2lMFTrTq7VZg7T88pqWg7E7b6ENPJT2jr0SSM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=mKcXtHms; arc=fail smtp.client-ip=52.101.165.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma7QJkbCBamhtfOaYlSreUcNErDkwnS1V6CYUPSkIQTVrTywSCtPNsq7fvjp/EVuPQX+fof6iXNllTbbynRmC/d4NiVIpe8M2QDqdLx2zK7Sj1/Rv9LamYNoHcvg3O+Ui1S0pUZXvRwzbqmPk16XEAzuZkP8lBmmjdreYxm7docxGKSGaSFEhPknK0jxuZucoqVXiipZxrcs+lutPQQtfLEeF0YjEBUE4TI2jEPQZOye8oT6sr3406pTjHnE8W7V5lrLAlIshMGC7mbDbDMe/8MyZPi/4w3b8vQ0Syl7mICsuF4VYoGgQn6IiQ3jchHjywjEGL7TJ9RK6l86Ube8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0bZbs4HUM21y3aA0pxGF5Bx+r0SFtuPzFhnU8bgHAE=;
 b=ksI3ulHK6P3tIoU4UPMpJpI1lC5xdaW6t1uX7xeKLRaBwj01eKgSjybhWD021Qif4i+mguAyiCFFngZQ2qH8NN/+IQX5FxwoBLmWUQSMletu7DVU6KVnwon+LMq0prGBsWGmtPIcSZg0TKgnQlE42Hrrba2QsYPo2AVuHcWH1vW67+DKAqL+7X9aMh9WENJjUcdySI//QLlplMugFvmb4pwllfPPG+0sDp3qLkdIQvjKOtPjsVJmXvguVApAV/jrq12cEMzbJoF+l2oDLAQcihW6fy/tiBTPpdTnugF9HHt/36sV5VT7TT54+PFaizW7WzDHrrprIZS3GC7pKYYoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0bZbs4HUM21y3aA0pxGF5Bx+r0SFtuPzFhnU8bgHAE=;
 b=mKcXtHmsR+mjMeeLQb2f6wetbX0XdWNqWLGv9Y7RDYWdEHG8KUBk/iroFjUnUCMaI/WBY4LJTQXzIXGbBgQlv32Wf7D0MUOZuqLoUuOzKkIBYsUMd2sXBJ2oQEFvW67W6enSDJ75tdVMlEB+h/RpNJEXglVF3TjdA1Z1OCXna0eW1VxpdVmMj3dYNMjXdeRtSaHr3hG5jrkVMnzLLYqJQmrDzn+OJhrvQqgakdBGCJaQI9XcR1PS87inblgPX3Vfwvx/yTUgAn0GvTgkAtx27u5arB/K/9CHQSElViHUrwhBG2S+/nicEaEUebGjCu1OfO26acESNgsBX54Ljdxlmg==
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 PR1P264MB1440.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.37; Fri, 29 Mar 2024 17:19:14 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2e47:cba6:3e12:e310]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2e47:cba6:3e12:e310%4]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 17:19:14 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Yunsheng Lin <linyunsheng@huawei.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Howells
	<dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 01/10] mm: Move the page fragment allocator from
 page_alloc into its own file
Thread-Topic: [PATCH RFC 01/10] mm: Move the page fragment allocator from
 page_alloc into its own file
Thread-Index: AQHagRWNRntdns6D1ka4Naur16dCqbFO+EWA
Date: Fri, 29 Mar 2024 17:19:14 +0000
Message-ID: <b5fe4c81-a7e6-4620-b0b6-a56ce7a2c304@csgroup.eu>
References: <20240328133839.13620-1-linyunsheng@huawei.com>
 <20240328133839.13620-2-linyunsheng@huawei.com>
In-Reply-To: <20240328133839.13620-2-linyunsheng@huawei.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB2980:EE_|PR1P264MB1440:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Uk4lp2CHsEy8IN7V6DOKQCxdX710p8/1JXTHat047mg6Q1szH5FZvQWfsh0ApJn2GGFPoCD14/Qh7qKF3ZwQtCuzCr6GikcYLWx9iuDG5az0ihFTrJkMabrHczrsFtlmGYlhvqDLIr2eC25fmn2nPIZ5OCM90jUineVFrMEMV+pfd4JA+ss4d9ZOxzDlE3ASnTR6hHy1Ucv8VfHA82VK1X7KuIJ8k2AxyR0r4rL/d7BsFl8GaNqQx2bIqMMF+km3Oo/LITYxXCai94mnObtEFzI8xKkp69kEg0t7neZfGJDVW5MYTUY3KHWqWGFBr4az0TH56LphHQiSjEknNX5RpZ0s4Dz/93U1X9n85dQVQWSVaHe1rYgO2Lh6MhmywOBcNPyJXKdChp2e1gBTpXaB7J9iF2iESZSA0N2lWet5PEoCveb6gf5F5IEGLlvuefyIOm8ZGmOzoqQwLs6Tj02drD+4zOjcswtjnaQa8OerAaCtnicqcO3mJTpapA2DHndhiuVUuMQ2orulU2Cef1KhfsTPDWeYUNYWTd/iH9uwUC5bBYKAsITYKdaeskB0Q5AzPYe9vXm256pDj96ioNo8VFUfFz469543+7u2CI/B6vVdRL3ArRCiD1nLrJeUJzyF7FCZvNltlh1a+/hJuWD1fq1oPkZxOWbuYRmLyFOKZkQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWRaSGNMRnRQRXRwcy9rbWFrZHNBMmszUmdZeSs5YnRMbFY1SktPd0YxdzY4?=
 =?utf-8?B?SlRlZjVWUG1IZmkweHk0VjlRaGcwVy81d05WeUt3Q3NEeVVwRHc2NnhCblFH?=
 =?utf-8?B?YkJzZEpUaGZTZ3dYbTN5VXRvZThCaWxUZ1lQOFF2T080U2s1bWJ4eUUvM0s1?=
 =?utf-8?B?LzJVbldFaXIzWGY1SFNXenNEUm14S25HVDRlV1VpVGhqbk1JOVhack9EWGpq?=
 =?utf-8?B?bngvcWhOSEo2ZnNKNjBZSTlrOXFJWVpHaEtTdUhuSkU5YVNUcWlBMFlRMlRr?=
 =?utf-8?B?NFRHTWlMR016Qkg1ZEt6bExGNUNUWXNqbG16M3Bzd1IzdlltZm9ZZW9pZVVB?=
 =?utf-8?B?ZnpPZkNseDNyTmtxa0xwdTJmRjErWGdxL3ovYXVOTTRnZmFDRWJQME1GRkov?=
 =?utf-8?B?cll2MGg2RXBKRXM0a1QxUlNGZFpVTU1yYzBLOWpjejc4azNrV0hleXEvUXQv?=
 =?utf-8?B?RzhNMjgyS0JadWVXTDEreFFjd2tZR0xLenBnYStudnp6VnFBVmtXUE1ERElp?=
 =?utf-8?B?dzk3dVptVDZJYTZTVmZGcGxRQy9tYjlIaUxYaVpCaktqbDRmblFBVzd6cnhE?=
 =?utf-8?B?LzdUd091MlV3bWhUcXB0akJza1RlUWpIUnRoSGEreHlVM1lzamNIeHFURHRY?=
 =?utf-8?B?SDNIU3BPMTZuKzYzV21JdzU3cmdhMjJQWDcyUHZVc3pKdlgybFZFUEdLb2tk?=
 =?utf-8?B?UmVwOXNDT3JKNjBEMG55ZmJqSUhZUzNDYUIxWjRLbTgzMGpBZHEvZ3p5T0ln?=
 =?utf-8?B?MGl6MCtwbmk5Vmg4czJOQkMyUFFXWW9FaGxnakZpQXhFbHFiclpGRlUzdktI?=
 =?utf-8?B?TWJaa25XdE1oUG94RGlmd2RraXV1WkY0V0JycHBZdlBqSnhJTFdHcWgyQUJQ?=
 =?utf-8?B?M2M5TjVDNWlJVjUvQVpEdHA0Q0ZuUnFCRWpKdUQ3a3FDNTRSbm1DYUxhNllO?=
 =?utf-8?B?WURtSFloOE94akpWNWthSERjaUs2TVlIczBjc01wTjV5THY3WUZBd0NObGwx?=
 =?utf-8?B?dlFrWk1CVWsydzQwcFFiL004QUNOQWdVdm9FcHdPQkRPTHlYUERYb0JidUVs?=
 =?utf-8?B?cmZ2ZFpWckowVTI3SFdYMmo5RjNaR2hQUVQ4alpwN0c3UGlsVTZVMGNSS0h3?=
 =?utf-8?B?eWpSN1I4RTh1VVF6SnQ0bzhzcXBuaEdJY2RxQWJndG9KWUZGV2dTa3lJWVRL?=
 =?utf-8?B?bFZXYlFydGFPOFBGNVI5U2VOVzE2VkRxWXdhcUZxNGtCMnBROVdDV25ITWxt?=
 =?utf-8?B?QzBuOG52MmhBZW9BZTYxbXo5bGlieml3OWd5dy94blY3SHhITmlRZWVKUmUz?=
 =?utf-8?B?QmVOT3Vrc1l0UlRNRHdvMHlmZHF4bUxNMlI1b1d2cEYra3hJUE5yYjVxeXBj?=
 =?utf-8?B?QmEzOGxVbkI2M3VHTFR3K1BhZDRIZC9MNTI5dU1NeFlZREtBSitPUTIzekZ6?=
 =?utf-8?B?elh6QXNudGtUV2thdUgvWllsdHFwL0hUQ0l2VlIwN3JRdEZLRTlSTlZHMVU3?=
 =?utf-8?B?bVNoUHU5VDY0MG1FUFFMbzhMWjZZRDRJNENQVkl2UDIybFgwNVRDYTRDRzJi?=
 =?utf-8?B?Ukd1elJZL1REWCsrRXoyN09RQWVLQWFUVDRDeStJMEUrdklUajdjQTJ2bWtp?=
 =?utf-8?B?TGtTMHJ4czkxOUFzSVVXd0FjVXVHMGdXWDhhdm44UnlndmMxREZhOUxrdkN2?=
 =?utf-8?B?Zk51aG9nYitqUkd2Z3NYMVY0K0Rwd1ZoelFYNHNCQmRDUk80TlJ5Zks0VGxz?=
 =?utf-8?B?S21tejluVUhDV1Vrd1pUTTFTOVRTN25QSzdGdUI0M1VYSUZqZlBZVGRUazNF?=
 =?utf-8?B?V1dDRElIOCtaUE05MTRRV040QnFtQkdQN0Zad3Z1d3NXRVBHTmlpMU5heTRn?=
 =?utf-8?B?SlBGejZwTFhHRVF1V2g0MmRvY1kyV09sN08xNGdrcUxjbnIxanh0c3REQTVG?=
 =?utf-8?B?bmRZT3RvUFNsZ1Z5V3NTbStMTlYrejIrS1FnUVdUUWhsNkZLUmMxcUozeUdq?=
 =?utf-8?B?KzZDcVk5NG5RTmJiWHArQnQ4eTlPWE1PcmRRY2E1K1V5MFdjMklpM0REOHlQ?=
 =?utf-8?B?dHF1YlhqYmE3Zkx4ZCt3c3lWTmpLZzk5OHRJbXp2WVh2ckF6cDZXNGVGTWVI?=
 =?utf-8?B?K09tWlhTT3NpV3ZHSFl0RDRkNHI2SXpKSXBVcjJoSUxLeWNlK3RGUEQ3MkFw?=
 =?utf-8?B?VlFTOWRTd0taT054RUZNNzkrZmtTWHlxa0pOaUxob2VYZTUyMVVTVFRrYVV6?=
 =?utf-8?B?dlNrRUhDeGVQd1hQU2p4NW5ZRWd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83F1D1C49CF6894498D797968FAF05D7@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 252d1a60-2dd6-4761-1fcc-08dc50145b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 17:19:14.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aU6hG/OL/A+CvFquB6xJibE8QDeQHeNcw5cY9FTT/uJa0IOEdnLqTDXpX21a4AtyXzXz4JIsSkwfoJKUzeTOpB2EzNOG9zqepfysnxIfDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1440

DQoNCkxlIDI4LzAzLzIwMjQgw6AgMTQ6MzgsIFl1bnNoZW5nIExpbiBhIMOpY3JpdMKgOg0KPiBJ
bnNwaXJlZCBieSBbMV0sIGJ1dCB1c2UgZnJlZV91bnJlZl9wYWdlKCkgdG8gcmVwbGFjZSBmcmVl
X3RoZV9wYWdlKCkNCj4gaW5zdGVhZCBvZiBfX2ZyZWVfcGFnZXMoKSwgdXNlIFZNX0JVR19PTigp
IHRvIGNhdGNoIHRoYXQgd2UgY2FuIHVzZQ0KPiBmcmVlX3VucmVmX3BhZ2UoKSBkaXJlY3RseSwg
YWxzbyBhZGQgaXRzIG93biBoZWFkZXIgZmlsZS4NCj4gDQo+IEFzIHRoZSBBUEkgaXMgb25seSB1
c2VkIGJ5IHRoZSBuZXR3b3JraW5nLCBpdCBtYXkgbWFrZSBzZW5zZSB0bw0KPiBtb3ZlIGl0IHRv
IHRoZSBuZXR3b3JraW5nIGRpcmVjdG9yeSBsaWtlIHRoZSBwYWdlX3Bvb2wgZG9lcyBpbiB0aGUN
Cj4gZnV0dXJlIGlmIHdlIGNhbiBtYWtlIHRoZSBmcmVlX3VucmVmX3BhZ2UoKSBjYWxsYWJsZSBv
dXRzaWRlIG9mIHRoZQ0KPiBtbSBzdWJzeXN0ZW0uIEFuZCB3ZSBjYW4gdXRpbGl6ZSB0aGF0IHRv
IGRlY291cGxlIHRoZSAnc3RydWN0IHBhZ2UnDQo+IGluIHRoZSBuZXR3b3JraW5nIHN1YnN5c3Rl
bSBpbiB0aGUgZnV0dXJlLg0KDQpJJ20gd29uZGVyaW5nIGlmIHRoaXMgcGFnZSBmcmFnbWVudCBh
bGxvY2F0b3IgY291bGQgcmVwbGFjZSB0aGUgcGFnZSANCmZyYWdtZW50IGFsbG9jYXRvciB1c2Vk
IGluIHBvd2VycGMgdG8gYWxsb2NhdGUgZnJhZ21lbnQgb2YgcGFnZXMgZm9yIA0KcGFnZSB0YWJs
ZXMuDQoNClNlZSBhcmNoL3Bvd2VycGMvbW0vcGd0YWJsZS1mcmFnLmMNCg0KQ2hyaXN0b3BoZQ0K

