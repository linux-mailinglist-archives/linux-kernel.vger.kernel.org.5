Return-Path: <linux-kernel+bounces-107491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B1B87FD41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA721F22DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC8D7F48A;
	Tue, 19 Mar 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uTK6m7GT"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80B7F47E;
	Tue, 19 Mar 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849630; cv=fail; b=qxwaqtRP7R/lalua9fUSLuMRxVN04Fqt1Vwe0837x6KRWdFTc+q0hY51hXQjUr6Dx87wJ9Pus3jmu8wPNSG1Le3qevsFphU+qc3EVsD179P+7kLumDmgKHZCZPZI0Svdl8ezBYZJ7ysHx/8b136Qb+4E3XRS/uKbHZjFUHuksXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849630; c=relaxed/simple;
	bh=WGcGzkeNkmGnm2uglNPJYB6l42uxC2pkUczC0A3KYxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hkjp6yQxV/2UBcisJwjw33e9AVqT6X5u/Xh+xw7Pyq0wJpWHB2ANKcan9ZbftdI08LmPaGBysRPyOkDF+V6xLhqqeSJkxW5vUTUJoe+RIj/SjCwumj5oN7VbvsXzOv/DGHO3JQLpZTRklxHFgtPBaX31zHfzAOJS61Y8HgnsC8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uTK6m7GT; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcZ/VwGtNm7ohV8PCTgnLgS4tYBvHXKr6ocrjvRuzO2XmeZWho/n1cyI6VCrrq5djpmAWpaJ5yl8Cmhk+9ETAPsxhEE9e1MKgQKSQbs0r/wrkYS5HuKkBWRcAtG48DE4hfYaw4w685eAmiKwkSbjMkumPFdQ9r0Eg1U31hY+6p0UBv3b6JvSbYRNidFg2T+oVSoGjtoju+s2mcuOlhfpeXWf+Jxn9Rrvh6wjJEGRvdK0JiJ24xvt3dOSOZUP/CMCgRZeC7SCfILlr3rF9AR68Xnq64llCsH1uwuVMBUPT4oRX8L1/S7/7Pu6PvZnhoBPLt/CLgqaa2zFW3rHNy3HuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGcGzkeNkmGnm2uglNPJYB6l42uxC2pkUczC0A3KYxo=;
 b=CCp3wrpz2To8uR6SxcWbapMRc+41zDNXTCB/D4hZ2871lihAENfJOKQF+pT1XRhs2L+hsLg3Em35o/cP1fo2LI1OdpXwAOx4ziFOjwVlQQsYu6QTdDMkNgPQwXXtmCm1SOX7MAsNOEUDo3tEf2lzr90FHW6LupbUecTyY+ZR2h/drNu28afxdzv0eP+BhpAZ4JWlLmHGDNeDQiY2alyT2s1w6Xj1KJiJ/RzFQ5lKaSV6a1xdU8x1M/PD1dJeNJrNYQ6oz4BExnGx0k3APhqu0f3ieopHHAVj8l3tdpoqzZdmGI3uUGR3GLYims3jtbgdOAdfPgehFq38O8Ne2YoOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGcGzkeNkmGnm2uglNPJYB6l42uxC2pkUczC0A3KYxo=;
 b=uTK6m7GTq9I+/Z+gSeTyAmP2xyDY4VqqDF7ZlY0llvpwu74V2SYb5tuASGpvDBIt/Bm7Lyzlxz/fpmKj7lh6eSD+G07Tg1D4Q0hTD1cM85ZFDcfava74ggvPlnxbH5kaQFwI935L8zLtl/ubgFg+m+ZPIqsfuOxQ5WzHb5HhfpU=
Received: from DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Tue, 19 Mar
 2024 12:00:24 +0000
Received: from DM6PR12MB4217.namprd12.prod.outlook.com
 ([fe80::65a1:c4cd:8643:b58c]) by DM6PR12MB4217.namprd12.prod.outlook.com
 ([fe80::65a1:c4cd:8643:b58c%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 12:00:24 +0000
From: "O'Griofa, Conall" <conall.ogriofa@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Jonathan Cameron
	<jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Thread-Topic: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Thread-Index: AQHac9Ev4TnvwaW8Kky5a+tte9hg/rE3ZnUAgAAccICAAUgQIIAATygAgAXEcKA=
Date: Tue, 19 Mar 2024 12:00:24 +0000
Message-ID:
 <DM6PR12MB4217D3CB97450DDAE64DA7FC8B2C2@DM6PR12MB4217.namprd12.prod.outlook.com>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
 <20240314154824.37150a54@jic23-huawei>
 <a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
 <DM6PR12MB4217EAA1049F815F234EE6D18B282@DM6PR12MB4217.namprd12.prod.outlook.com>
 <3b481539-0c9c-4110-ad03-bd252e80efb0@linux.dev>
In-Reply-To: <3b481539-0c9c-4110-ad03-bd252e80efb0@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=93829192-c1ae-4fe6-a953-02ab0014b7ce;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-19T09:52:02Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4217:EE_|DS7PR12MB6333:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JEFGQlmOxD5UO79Jit6ytomqE4McnnS/audwAqHPZqdvZEg7wbd2OAAzJhLhTBHbXVdud7gynckRyl99561KmucXWrROV5Z6cE4jGfKte3sV+wPt31zPIbxO6yaffFWrN6L9/Z4gLDu34NofcwhWCu0TLJBitJkhcTAoS23/7c9T4WKdTYBi/keGYcHsARNDsOfp0002HI/tylR7yRW3D/GnT9Wl7LQ3PceXhEI9LuAK1FiT+kVi9DWhFT7lqRLK9L4CNUfNfz3KjuV1uyCIqtHYS5csMH1ec/GiTgLa6Tt5WV9/UWPO5f2fZWAmyvHzbE+6DhmPdtN5uCLV54ssj9mhf+NhOAmXuQ0Wu9RJLUybD79yxo7NadJDTH+Away5dHmIjrUeNr17HMk3NxnK26lmepjJTHlJfJL3wJ+/KAh2JViT4wdB6dNfp2NzInLYxGHwPbuY9CtuKpLebzg59MESGr++o4J2TIJBIXZcrTBHH4UJwFieAIrKXjI52oZMC4E6KOzYK/6c14IsQnoOaSPBNFUBReNzkQCE8WVWgymfB+9MODMq0gu+kO0tIFkwfRUsdUBHex9VXFDVkCPYbnRkTzQfQIODP0WHDngginA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4217.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1ZrSGM2ZVlnVkhjS3FBOHlRUGhFUzFJMzJBSFd6cklUZ01TUHlOK2x4ZC9I?=
 =?utf-8?B?Yi9ycnpJSUUvaXRWQlhKTStna1lEbVR4TnVqYVhaWXhDMGhFcTgxS0ZSR0hV?=
 =?utf-8?B?cEROZUhVNEVXdEUyK1BJaFBSdWVqUEpndWozN005YXg3MjE1RXgvbG9DM200?=
 =?utf-8?B?VDRhcXEwM1FTVG5XejZrRXJFZmg1ZG5HVTF3akF6M0tWbWtEK2Z6WW9NYXp5?=
 =?utf-8?B?UnFJYnhTM0FVU25KNUkxS2lESEJGRTh3bm1IMy92aUQ3NEhoMWxUZmhLTnFx?=
 =?utf-8?B?bzgyd3JVbGp3a3N6bVowWWRlV3B2ZzcvcWlGZ1NhUWZPTEhSYXl3MUhLeTNY?=
 =?utf-8?B?WkVDT1dwNTNlc2p6a0lXNndua2JFSW4xZUEvUUowS2JhTFRZVFVPUzA3dHkr?=
 =?utf-8?B?LzVJSzVmSmJJTU5pSlV1eFQ5SDRpY0Q4MCtWcElxdXh6VVM4bDNjUWNqYkdV?=
 =?utf-8?B?cm5lS0Z3czVOVlJ1Y2NtNXJ6US95Q1RQdWNIVHJ0bjZ6Tm9DbWM3amdOOXVR?=
 =?utf-8?B?T21GbndDMUR0Tk1kTTZzZUJVYUFRd2YxdW52bG9kcEl4SGF1NGtUN1FXY0xt?=
 =?utf-8?B?dDN3cm5tSkpaM3BhZHJQK2UyYTV3bzNsN055RDFwQVUrWWM0cmV2ZE9LMGV3?=
 =?utf-8?B?NVQ1M3czby90TkJVUk1DbnhOa0gzL2NNMXVab0NCVW8xeFpkRk5NbVRnS2Vk?=
 =?utf-8?B?QnBvVHhuQk04Vm1maXkzTWw5d2N5U0gya2xzZUx3emxVYllidUhNMW1PRFhx?=
 =?utf-8?B?dGl3eENSTlcxeGhnOWJaTWlTY2plZXVxSDhTU3BGS0pnenBKTHkvSVJQYkp0?=
 =?utf-8?B?dGtQV0VFVjV5TWdXU3dzUUlpbkhvV0w3dlU0VGdoMEJtRHFLQXppSjAzMlVQ?=
 =?utf-8?B?STI1Y2VvSitQWXNFTUd6YU5zc0g0NWtkM0VvNWxQK0ZNUUlPZ3NaY3NMY1Vp?=
 =?utf-8?B?UkF0cmpXQUR1b2tXSFBjempSNFB3eHNpSTZnY3BqdkoxbjNQQ2s0LzBDZVlV?=
 =?utf-8?B?MUxIK3dkQ242ZERvSWpSUEhDTExZdTlib0RsWkJOOWprdDBMWCtqNDcvNjcr?=
 =?utf-8?B?STcvQ3NSWlA1cndreHpZUzhiUWg5bkFSTnMxdEwrbjA4b25FZ2xBRDhLWGRG?=
 =?utf-8?B?V3EyYktNN1NzYzBSRjVYYjdxZHBiTitFemE3TkRVOVN6N0x1WXo5K3l2ZHps?=
 =?utf-8?B?R2cyS3lqemtSTHFpOFNqeEVzYlZYcFIxZElJRVQ1Z2JnZUZ0SGFnSHR4Qmhu?=
 =?utf-8?B?d0NsSThPaENKQnZsRHg3dnFRYWQxVjYvUEFSWEloZENncEVzTWV0ZzZqMnds?=
 =?utf-8?B?T0hjZklLWEVYU0hKeWo0QU9KVStLZVRGL01tQkw0VTFVT205TktLSXZabzJZ?=
 =?utf-8?B?MWdlYXcrT0NwcmNSLzdRTXpmM0hMVWk1UnB2K1lWeHdrME1YZnltTVFXcTlO?=
 =?utf-8?B?MWlhZWVReHNnMXJhTmc0cjdiN1NlUVRHNUVaSUFlcTFaUmw0NUpaZktncFU1?=
 =?utf-8?B?dDNjZ2MrWUtMZ3RMMHhYWUpJSDdtYVBQUWtoaDdOTWJCaTA2N0hxZjYzTzM0?=
 =?utf-8?B?M05hajJRbVVwUHVwdlFuSHIzRTNnUzA4OVJBeVNFVTZCQ2RtdVR2amcvWlU5?=
 =?utf-8?B?dW81cWRDNFFzWFdBU01pRS9lNU9Bc3NpZWFVa2h5UUY3YWw0elBTVVZGVzFy?=
 =?utf-8?B?bHUzbldlSW44d3M4c3Nkcy9FVitjRTdDeFdjbktWUVVCd3dVOUJ4cVFYZFV5?=
 =?utf-8?B?ZlphQjNuYm50emczZjJVbEpISTJReHJJbm5rUnFxSEMyd09hNFdISmo4ODhK?=
 =?utf-8?B?WUZ1Q2s1dUpzcVQ4U2lkMThGenAvaWExSEF5cmZkK1ptYi9GSGtZcE1xZXBn?=
 =?utf-8?B?dnp4b0hoSENjck5nYXViZFhiTVFuTlVIa2Q0NWMrNzRpOERSc3N6clNCRFpq?=
 =?utf-8?B?V0wyeTVJSXhkdEdDa1l6WEs1Y0RHbUk3SDEvdmJ6L1I0VTArbG9aS3BjUXdJ?=
 =?utf-8?B?aUxtNWJOeGlpb1Mzd0k1TmNiWitIZlJieHlmSUtuL0dwTUpKRXh4WUpqdmhx?=
 =?utf-8?B?QUZROWxrVW1JUklGRWxzcUlYYWx3OUFsN2xxYVcvSW9uTXVjMDRSYWtUMTkr?=
 =?utf-8?Q?bRP0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4217.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695a9a21-9d15-4ba4-afb1-08dc480c28f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 12:00:24.3808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6SGaUdJCPf7BGur11XndwFbvwQutcHYe/8/7JUuDXynhn1X7EvbE6pNmQ2cYW/Jb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpLA0KDQpBcG9sb2dpZXMsIEkg
bmV2ZXIgdGhhbmtlZCB5b3UgZm9yIHN1Ym1pdHRpbmcgdGhlIHBhdGNoLCBzbyBsZXQgbWUgc3Rh
cnQgdGhpcyBtYWlsIGJ5IHNheWluZyB0aGFua3MhDQoNClllcywgeW91IGFyZSBjb3JyZWN0LCB0
aGV5IGFyZSBmdW5jdGlvbmFsbHkgdGhlIHNhbWUuDQoNClRoZXJlIGlzIG9uZSBzbWFsbCBkaWZm
ZXJlbmNlOg0KDQpBTVNfQ1RSTF9TRVFfQkFTRSBlcXVhdGVzIHRvIDY2LCBzaW5jZSB3ZSBleGNs
dWRlIHRoZSBjb250cm9sIGNoYW5uZWxzIEkgZG9u4oCZdCB0aGluayBhbnkgb3ZlcmZsb3cgd2ls
bCBhY3R1YWxseSBvY2N1ciAoYXMgSSBkb27igJl0IHRoaW5rIHRoZXJlIGFyZSBhbnkgcHMgb3Ig
cGwgY2hhbm5lbHMgdGhhdCBhY3R1YWxseSBoYXZlIGEgc2NhbiBpbmRleCBzbyBoaWdoKSBidXQg
aWYgd2UgbG9vayBhdCBpdCBpbiBpc29sYXRpb24gaXQgbG9va3MgbGlrZSB0aGVyZSBjb3VsZCBz
dGlsbCBiZSBwb3RlbnRpYWwgZm9yIG92ZXJmbG93Lg0KDQpJbiB0aGUgcmVmZXJlbmNlZCBwYXRj
aCBQTF9TRVFfTUFYIGVxdWF0ZXMgdG8gNjAgd2hpY2gganVzdCBtZWFucyB0aGF0IGV2ZW4gaW4g
aXNvbGF0aW9uIHdlIGNhbiBzZWUgdGhlcmUgY2FuIG5ldmVyIGJlIGFuIG92ZXJmbG93Lg0KDQpQ
bGVhc2Ugc2VlIG15IG90aGVyIGNvbW1lbnQgaW5saW5lLg0KDQpUaGFua3MgJkJlc3QgUmVnYXJk
cywNCkNvbmFsbC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWFu
IEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU2VudDogRnJpZGF5LCBNYXJj
aCAxNSwgMjAyNCA1OjQ4IFBNDQo+IFRvOiBPJ0dyaW9mYSwgQ29uYWxsIDxjb25hbGwub2dyaW9m
YUBhbWQuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8amljMjNAa2VybmVsLm9yZz4NCj4gQ2M6
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExhcnMtUGV0ZXIgQ2xh
dXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpaW86IHhpbGlu
eC1hbXM6IERvbid0IGluY2x1ZGUgYW1zX2N0cmxfY2hhbm5lbHMgaW4NCj4gc2Nhbl9tYXNrDQo+
DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291
cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlj
a2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gSGkgQ29uYWxsLA0KPg0KPiBPbiAz
LzE1LzI0IDA5OjE4LCBPJ0dyaW9mYSwgQ29uYWxsIHdyb3RlOg0KPiA+IFtBTUQgT2ZmaWNpYWwg
VXNlIE9ubHkgLSBHZW5lcmFsXQ0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBJIHRoaW5rIHRoZXJl
IHdhcyBhIGZpeCBmb3IgdGhpcyBpc3N1ZSBhcHBsaWVkIHRvIHRoZSB2ZXJzaW9uIHRoYXQgd2Fz
IHJ1bm5pbmcgb24NCj4gNS4xNSB0aGF0IGRpZG4ndCBzZWVtIHRvIG1ha2UgaXQgaW50byB0aGUg
dXBzdHJlYW0gZHJpdmVyLg0KPiA+IFBsZWFzZSBzZWUgbGluayBmb3IgcmVmZXJlbmNlDQo+ID4g
aHR0cHM6Ly9naXRodWIuY29tL1hpbGlueC9saW51eC14bG54L2NvbW1pdC82MDg0MjY5NjFmMTZh
YjE0OWIxYjY5OWYxYw0KPiA+IDM1ZjdhZDI0NGMwNzIwDQo+ID4NCj4gPiBJIHRoaW5rIGEgc2lt
aWxhciBmaXggdG8gdGhlIGFib3ZlIHBhdGNoIGlzIG1heSBiZSBiZW5lZmljaWFsPw0KPg0KPiBU
aGVzZSBwYXRjaGVzIGxvb2sgZnVuY3Rpb25hbGx5IGlkZW50aWNhbCB0byBtZS4NCj4NCj4gLS1T
ZWFuDQo+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFNlYW4g
QW5kZXJzb24gPHNlYW4uYW5kZXJzb25AbGludXguZGV2Pg0KPiA+PiBTZW50OiBUaHVyc2RheSwg
TWFyY2ggMTQsIDIwMjQgNTozMCBQTQ0KPiA+PiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNA
a2VybmVsLm9yZz4NCj4gPj4gQ2M6IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IE8nR3Jpb2Zh
LCBDb25hbGwNCj4gPj4gPGNvbmFsbC5vZ3Jpb2ZhQGFtZC5jb20+OyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiA+PiBTdWJqZWN0OiBSZTog
W1BBVENIXSBpaW86IHhpbGlueC1hbXM6IERvbid0IGluY2x1ZGUgYW1zX2N0cmxfY2hhbm5lbHMN
Cj4gPj4gaW4gc2Nhbl9tYXNrDQo+ID4+DQo+ID4+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmln
aW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+ID4+IGNhdXRpb24g
d2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4N
Cj4gPj4NCj4gPj4NCj4gPj4gT24gMy8xNC8yNCAxMTo0OCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90
ZToNCj4gPj4gPiBPbiBNb24sIDExIE1hciAyMDI0IDEyOjI4OjAwIC0wNDAwDQo+ID4+ID4gU2Vh
biBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+IHdyb3RlOg0KPiA+PiA+DQo+ID4+
ID4+IGFtc19lbmFibGVfY2hhbm5lbF9zZXF1ZW5jZSBjb25zdHJ1Y3RzIGEgInNjYW5fbWFzayIg
Zm9yIGFsbCB0aGUNCj4gPj4gPj4gUFMgYW5kIFBMIGNoYW5uZWxzLiBUaGlzIHdvcmtzIG91dCBm
aW5lLCBzaW5jZSBzY2FuX2luZGV4IGZvcg0KPiA+PiA+PiB0aGVzZSBjaGFubmVscyBpcyBsZXNz
IHRoYW4gNjQuIEhvd2V2ZXIsIGl0IGFsc28gaW5jbHVkZXMgdGhlDQo+ID4+ID4+IGFtc19jdHJs
X2NoYW5uZWxzLCB3aGVyZSBzY2FuX2luZGV4IGlzIGdyZWF0ZXIgdGhhbiA2NCwgdHJpZ2dlcmlu
Zw0KPiA+PiA+PiB1bmRlZmluZWQgYmVoYXZpb3IuIFNpbmNlIHdlIGRvbid0IG5lZWQgdGhlc2Ug
Y2hhbm5lbHMgYW55d2F5LA0KPiA+PiA+PiBqdXN0DQo+ID4+IGV4Y2x1ZGUgdGhlbS4NCj4gPj4g
Pj4NCj4gPj4gPj4gRml4ZXM6IGQ1YzcwNjI3YTc5NCAoImlpbzogYWRjOiBBZGQgWGlsaW54IEFN
UyBkcml2ZXIiKQ0KPiA+PiA+PiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVyc29uIDxzZWFuLmFu
ZGVyc29uQGxpbnV4LmRldj4NCj4gPj4gPg0KPiA+PiA+IEhpIFNlYW4sDQo+ID4+ID4NCj4gPj4g
PiBJJ2QgaWRlYWxseSBsaWtlIHRvIHVuZGVyc3RhbmQgd2h5IHdlIGhhdmUgY2hhbm5lbHMgd2l0
aCBzdWNoIGxhcmdlDQo+ID4+ID4gc2NhbiBpbmRleGVzLiAgVGhvc2UgdmFsdWVzIHNob3VsZCBv
bmx5IGJlIHVzZWQgZm9yIGJ1ZmZlcmVkIGNhcHR1cmUuDQo+ID4+ID4gSXQgZmVlbHMgbGlrZSB0
aGV5IGFyZSBiZWluZyBhYnVzZWQgaGVyZS4gIENhbiB3ZSBzZXQgdGhlbSB0byAtMQ0KPiA+PiA+
IGluc3RlYWQgYW5kIGNoZWNrIGJhc2VkIG9uIHRoYXQ/DQo+ID4+ID4gRm9yIGEgY2hhbm5lbCwg
YSBzY2FuIGluZGV4IG9mIC0xIG1lYW5zIGl0IGNhbid0IGJlIGNhcHR1cmVkIHZpYQ0KPiA+PiA+
IHRoZSBidWZmZXJlZCBpbnRlcmZhY2VzIGJ1dCBvbmx5IGFjY2Vzc2VkIHZpYSBzeXNmcyByZWFk
cy4NCj4gPj4gPiBJIHRoaW5rIHRoYXQncyB3aGF0IHdlIGhhdmUgaGVyZT8NCj4gPj4NCj4gPj4g
RnJvbSB3aGF0IEkgY2FuIHRlbGwsIG5vbmUgb2YgdGhlIGNoYW5uZWxzIHN1cHBvcnQgYnVmZmVy
ZWQgcmVhZHMuDQo+ID4+IEFuZCB3ZSBjYW4ndCBuYWnMiHZlbHkgY29udmVydCB0aGUgc2Nhbl9p
bmRleCB0byAtMSwgc2luY2UgdGhhdCBjYXVzZXMNCj4gPj4gc3lzZnMgbmFtaW5nIGNvbmZsaWN0
cyAobm90IHRvIG1lbnRpb24gdGhlIGNvbXBhdGliaWxpdHkgYnJlYWspLg0KPiA+Pg0KPiA+PiA+
DQo+ID4+ID4gSSBqdXN0IGZlZWwgbGlrZSBpZiB3ZSBsZWF2ZSB0aGVzZSBhcyB0aGluZ3Mgc3Rh
bmQsIHdlIHdpbGwgZ2V0DQo+ID4+ID4gYml0dGVuIGJ5IHNpbWlsYXIgYnVncyBpbiB0aGUgZnV0
dXJlLiAgQXQgbGVhc3Qgd2l0aCAtMSBpdCBzaG91bGQgYmUgb2J2aW91cw0KPiB3aHkhDQo+ID4+
DQo+ID4+IFRoZXJlIGFyZSBqdXN0IGFzIGxpa2VseSB0byBiZSBidWdzIGNvbmZ1c2luZyB0aGUg
UEwvUFMgc3ViZGV2aWNlcy4uLg0KPiA+Pg0KPiA+PiBGV0lXIEkgaGFkIG5vIHRyb3VibGUgaWRl
bnRpZnlpbmcgdGhlIGNoYW5uZWxzIGludm9sdmVkIHdpdGggdGhpcyBidWcuDQo+ID4+DQo+ID4+
IC0tU2Vhbg0KPiA+Pg0KPiA+PiA+IEpvbmF0aGFuDQo+ID4+ID4NCj4gPj4gPg0KPiA+PiA+PiAt
LS0NCj4gPj4gPj4NCj4gPj4gPj4gIGRyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMgfCA4ICsr
KysrKy0tDQo+ID4+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+PiA+Pg0KPiA+PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL3hp
bGlueC1hbXMuYw0KPiA+PiA+PiBiL2RyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMgaW5kZXgg
YTU1Mzk2YzFmOGIyLi40ZGU3Y2U1OThlNGQNCj4gPj4gPj4gMTAwNjQ0DQo+ID4+ID4+IC0tLSBh
L2RyaXZlcnMvaWlvL2FkYy94aWxpbngtYW1zLmMNCj4gPj4gPj4gKysrIGIvZHJpdmVycy9paW8v
YWRjL3hpbGlueC1hbXMuYw0KPiA+PiA+PiBAQCAtNDE0LDggKzQxNCwxMiBAQCBzdGF0aWMgdm9p
ZA0KPiA+PiA+PiBhbXNfZW5hYmxlX2NoYW5uZWxfc2VxdWVuY2Uoc3RydWN0DQo+ID4+ID4+IGlp
b19kZXYgKmluZGlvX2RldikNCj4gPj4gPj4NCj4gPj4gPj4gICAgICAvKiBSdW4gY2FsaWJyYXRp
b24gb2YgUFMgJiBQTCBhcyBwYXJ0IG9mIHRoZSBzZXF1ZW5jZSAqLw0KPiA+PiA+PiAgICAgIHNj
YW5fbWFzayA9IEJJVCgwKSB8IEJJVChBTVNfUFNfU0VRX01BWCk7DQo+ID4+ID4+IC0gICAgZm9y
IChpID0gMDsgaSA8IGluZGlvX2Rldi0+bnVtX2NoYW5uZWxzOyBpKyspDQo+ID4+ID4+IC0gICAg
ICAgICAgICBzY2FuX21hc2sgfD0gQklUX1VMTChpbmRpb19kZXYtPmNoYW5uZWxzW2ldLnNjYW5f
aW5kZXgpOw0KPiA+PiA+PiArICAgIGZvciAoaSA9IDA7IGkgPCBpbmRpb19kZXYtPm51bV9jaGFu
bmVsczsgaSsrKSB7DQo+ID4+ID4+ICsgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaWlvX2NoYW5f
c3BlYyAqY2hhbiA9DQo+ID4+ID4+ICsgJmluZGlvX2Rldi0+Y2hhbm5lbHNbaV07DQpbQ09HXSBJ
IGRvbid0IHRoaW5rIHRoZXJlIGlzIGEgbmVlZCBmb3IgdGhlIGFib3ZlIHdlIGNhbiBqdXN0IGtl
ZXAgIHVzaW5nICJpbmRpb19kZXYtPmNoYW5uZWxzW2ldLnNjYW5faW5kZXgiDQo+ID4+ID4+ICsN
Cj4gPj4gPj4gKyAgICAgICAgICAgIGlmIChjaGFuLT5zY2FuX2luZGV4IDwgQU1TX0NUUkxfU0VR
X0JBU0UpDQo+ID4+ID4+ICsgICAgICAgICAgICAgICAgICAgIHNjYW5fbWFzayB8PSBCSVRfVUxM
KGNoYW4tPnNjYW5faW5kZXgpOw0KPiA+PiA+PiArICAgIH0NCj4gPj4gPj4NCj4gPj4gPj4gICAg
ICBpZiAoYW1zLT5wc19iYXNlKSB7DQo+ID4+ID4+ICAgICAgICAgICAgICAvKiBwdXQgc3lzbW9u
IGluIGEgc29mdCByZXNldCB0byBjaGFuZ2UgdGhlIHNlcXVlbmNlDQo+ID4+ID4+ICovDQo+ID4+
ID4NCg0K

