Return-Path: <linux-kernel+bounces-109590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A1881B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B55728240D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645D5660;
	Thu, 21 Mar 2024 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qOPj6e3o"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6C1C17;
	Thu, 21 Mar 2024 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987947; cv=fail; b=mkm+tsyzm/gtmrcJ53ewDqOqpBARoGY7ELJNnlTmiUAaFzC7w4676oKnqrga0QrLSft+skNUUMrCFLdxb77mtlTbHlUFK6Td7+nnRxEK4mUR9BDZ7YIT0dilKIXg0m3l3VDyzgTEiH7s/nVWupV9DSvpUwNFch+PZmnjtVJ6LF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987947; c=relaxed/simple;
	bh=+sgYPBtl1YGBvzDv1Xn+YLzUIhOTNNo3giZPOlFYR+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YUnu4esMSTTCYmzLaIEK2kqHpLfKYHWs24H2watWfe7ftgG3jgXMb1MP77UEyr8H7PxwHxiEw3f4Qpb2L03vsEMlO7HsbIPATgIp4QyBeBZWywmjJwf4MLRqceTNjhJmM0+qvdr5SQJzJmbwgnifD1LwgmRvsccUBCqp5jZscpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qOPj6e3o; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9M2uBMDypu/qMh61eYzmXVQfwUmIgZIZg2RsxDb4n/8y2y/rmFT/6si4LL03tyxLXPE5izfMcV0He9R8qUM3UACnJqWoDN4YuhmLuxjYY8bbM5up7Dq2gbvugefTOMJe9br2PxDJ3FAzFC+UplRKyTnjF7bWHnsBf5dgiM5YY2YeBDwDycf3wVL2QjvGEGPxPx6A87Wp/yFHYXdkynJj6jE4wwXxzLhsosaE3fzPIzgVrJrbsL9F28unLDHRRQEq3gK1QnpOCTElg2kFeKSR0ayHUa0aJdoe0rBBCnaHWM58c861HWQzNexBRprVjwpH6ASa4Db7dbRoaca9MlJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sgYPBtl1YGBvzDv1Xn+YLzUIhOTNNo3giZPOlFYR+4=;
 b=Ct+M44msBq0p94gJ2FE9GeO0Y7vmcS3vyXRUn6O2K22s4kQYA19bHuV3vharXTUvGIRr6PeL6zNXwNxS5gnZi4BhtAM7xs0z0rR9BFjDmmvKqskYHyB2eFyFVrVRP0dF+mCNQkT5FHIf2zSDQjzLZBZFh75Tn4lq6iiWRehGLtm2JLfkv1gyg2b+dBFd6gYBXmRO420Ht9VcS1ylKi17MeqZGukg596+HmHSw0A2TDLIJUegLw99zyM5iuH2Ik/irHCI9WyfXQd10AklCWbp9MmsfdpzZ0T8K7f9u1XAtYyq85Y2TykaopLtyEb2M6pRmeAxJTQ0sQu24AngngGDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sgYPBtl1YGBvzDv1Xn+YLzUIhOTNNo3giZPOlFYR+4=;
 b=qOPj6e3oR96t42xpDnEmVDZ/wHyph5jJVmF8Wne0DznXQPUF4cTl9vJbcuekFYoAhjTzOxZPtyGvwW7YrfGC+hfvm3oibzSXuWJasLkuASMor2KcYRbUwrKecVmKprOLuPbk2lWsKIpQLgNDQraBJMu1oA6isYjFoZNTqS49LSE=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 02:25:42 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 02:25:42 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Petkov, Borislav"
	<Borislav.Petkov@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/6] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into
 msr-index.h
Thread-Topic: [PATCH v6 1/6] cpufreq: acpi: move MSR_K7_HWCR_CPB_DIS_BIT into
 msr-index.h
Thread-Index: AQHaeRz8Qhv9XMt5VUiGfrC9o9qBErE9cYSAgAQKOGA=
Date: Thu, 21 Mar 2024 02:25:41 +0000
Message-ID:
 <CYYPR12MB8655C60EDB3B24832994357F9C322@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
 <8e617be2b0eef88781973e16a98aac6a4a08d664.1710754236.git.perry.yuan@amd.com>
 <CAJZ5v0gzq2eNWUAk0B93MdFgbsMfPeT4UM5CCmJ+9i1=dktTvA@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0gzq2eNWUAk0B93MdFgbsMfPeT4UM5CCmJ+9i1=dktTvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=671aefce-0721-4e23-b798-cb1287504b38;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-21T02:25:03Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SA1PR12MB6703:EE_
x-ms-office365-filtering-correlation-id: af8d9bfe-0e2e-46ec-c432-08dc494e34ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 062sUgAXBH3H4oERn6NRontZIAL5LgxrejYbc/zEi9hxhVAMvKyQQkulAf06W2z4xyLzLiYzfI3LC4IFFOT9IWpAxuVhmcTAeNKe9GdQOKnRRg+HqclvvurvdOzLx8VYWdDfbYD0p0/ftho04djGyrMRT7IUiKgbWH6YtDjFLLg2F85gXca8WnC0eQyDdme6jBiSS1R4m2tXL/Aczox+VXlfEt7WuaGs8JsFR8UWDj6BvQC9B664U8ZffhrZ9yAQwW4udSA0yfFi90rC8xtv5HbSm1/h4DvWsKFd3S+Vo0Vf2JNeHAgObW3J2Ui8c1WvsqSo1CBR2yHb0X9kvWA4rg/jma9nGyr6qjGOlLrhw17a2s2MOHnxJALO5M1Pf/X1xN8T2YQzHZMGMczofmkTCOArkkVbcAhTSg+I62x7h5ozSmR1WzP7qFBMGuUHflKtzKlSswHSW6BBzeFY9aLbPPSArQe1W2qMmzVor9IXkoSidVP3klCFjSzvJdqqPUy64y4rMcTxVhWfEUFDrpS4WpKK9EPoXrPXhxMVDXbdEL3gBxPYL5khrDq37C3vxoLIX3DMikIoyG5ZpI1ZGMJIc0oGxNfCZNv3vVCkj4CB7Sm1etgSwHSdj5O3Irr/gpZ3w07ShdhtSiu3EqsDjovMQzd5TKiCiU18PCCH0rCuoMoFwdm5h68pUWuFOhmHk/AKqZ3pI5FEE3V6mtK4RliH8g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjFlbU9SMFVWZUFmbE4yN0xKODNJbGVSTG1yeEozNWQ1c0FiQjJkVzNxVzU4?=
 =?utf-8?B?VmVpMHBrZUI3dm9RZlZXaVBYR3d5c3cxS3FDNHhkSXE5ZWhhV3l6QlJFVk1B?=
 =?utf-8?B?eStKWXdzY3RHcTBZSGtYNU1iMmo3bnhweS96dnJEMkdnVlI1aVpJM01iaWpr?=
 =?utf-8?B?MHBETG1FYy94dzlXMkxMODhTUzhvbXBKQ3loWHEzczhmTU9SUVFld1R4UGNF?=
 =?utf-8?B?VVN3UUYyUE1WVjBxOTRuK3FlRG1maGg1STFIdmd1YVFvcEpiRUI5b1dQbGwv?=
 =?utf-8?B?Z3kzZDE0NjIvdkp3ZG5peGtOQUhGQjI5cDdOTm5FdysvSjNmS0ZDWTN3SnQ1?=
 =?utf-8?B?M1JZbDZkbEkzS0ttQXFDbU16eDNaL3JucW9TNWw2d205U3VIei9WQWZyVUxX?=
 =?utf-8?B?WjJkazFkODdlVjIzRXR1SzdWL0FMbmg0NWVSODNsczZRd3JUb3grSldOS3A5?=
 =?utf-8?B?WVRlVTlqcUw3WDBUYkkxcjFydWVBMUIzYVJtVWUvVVBSVTRnT2Rjdm04dWov?=
 =?utf-8?B?QkpVRWt2aVROOXlZcjB5bzRrVlNHeWRCNHV1aHQvT2JLOUJJOXlFcmZqSytX?=
 =?utf-8?B?RzNDMXVhcXZDZWQ0cjFuVWdTdUVxSlpDVDV5OVREWEh1VmJIR2hjVUJpeGtK?=
 =?utf-8?B?QndIWjRLeUFtM2M4Y09OeW1jbG1rdjA3Y3pBdGdDckczZWhNY2JJVnJMN2FQ?=
 =?utf-8?B?MVVIa0lESzVYR211YkdVWHZFdmNleTlRYmRaWmVkNlBFY05DTnpyYy9oWGNn?=
 =?utf-8?B?TmhmLzE2VHpScDB2VHl5ekI3azUzQm9ZYU5YbUJ4WndhVmV1UHVWTWYwVDVu?=
 =?utf-8?B?eGhlQ292V3BlcEJGT2U5NlFoaVZoVU5MaXpTNlZyeHp2M3B1V0dBUmNDVUpO?=
 =?utf-8?B?Uk5BanJoVXFPaGJwT3k2ZDBvUXJTUCtDRkpYNFB3ay8rYVYwK1NyOTBHQlJt?=
 =?utf-8?B?dmVtR1NEK0NyWGpoeHUyZ3FDVzJyUmFWNGVyN2krMklVK0hGRnMxczVQS1Rv?=
 =?utf-8?B?R0laSzJ2SHBEaTZDQy9oWUZuditya1UxQVRpanpPWTU3U3pEdHEwZklYSkF1?=
 =?utf-8?B?bkY5c1JJN0JzY1RrTklmd1dQdkx3Z0dQVG84bTNNSWhRbmVnNFhOVXpncW9p?=
 =?utf-8?B?RlZUQk01V2dsOThEZEU1YnFhVlRJL0N2YmdmblRQRCszb1d1d0E4cDh1aG1r?=
 =?utf-8?B?NEVJMEVDc2VlNE1JSXhnV1BEKzhCZ2ZYZmh0dG80MG1Nd0s5ZUp6Q0lrc3RG?=
 =?utf-8?B?NTN4ZTc3U0Q5dnFYdEFtYUk4MkxLdVhpVmQ1R3JrTURtdXhUeGljM3JLUGZs?=
 =?utf-8?B?QmVKdkZ0YktXc1B5VGlpbFF1VklTMVZxU3Y2WmZidGdIWjZEMDVOZkdCdklP?=
 =?utf-8?B?YWRJOXVJRlRMQk9SbjNxdmd1cmJ3K253dFNYbEhlUWowSU5Kc0pPbUFSTTY4?=
 =?utf-8?B?Uy92WExCYUdEejM2WEI4dVRxVHBFS0FkeHMvTjNyNlhwVzZKVTBCNk5HTXpp?=
 =?utf-8?B?SjZ1eTBEd3BNUEd5WnNHSGJXeXVrUUllcFFvZUpwK3ZiTGw0YjVvMXlGYkRt?=
 =?utf-8?B?SmhzNzlRR3JvZng1SHFkWm5PdUVnV1ZBYzBjcGhpQTVTVVVCWDNwSUszb212?=
 =?utf-8?B?UzBMb1dKSk5jdmg0T2dFc2Rxc3FDODUyN3d3UG90SjkyeEs4VGhZWTd2Yk1S?=
 =?utf-8?B?aUszcWpPUmpYOVJwREplSGx6aEtUVmpXSU1vdDU1WThXN3poVmFZdnNPSXd1?=
 =?utf-8?B?aUxzcElqbTk0VGlhR2RUOHZaeExvbFVJMnVFVkRBcVJGRm1mVHNIaldOWmF2?=
 =?utf-8?B?SStjRHdtRGQ4SXBaZkd1VlM5U0hWZHZIU2c3SDNzTzhPZCtlakhKMWZDQUNv?=
 =?utf-8?B?TzhZcUVyejNQSzVsMi9PdHNRSjZrQWxiTENRMmhEczErL3hCcG9hTjViTEl4?=
 =?utf-8?B?OFV5Zm1ubkZ0c2dqUjBldkpDOHRmZzFyRDc4VGRVSVJkaFA2RWdsaWN2dlRB?=
 =?utf-8?B?bXp6aDdIVXRXdjQxbi9GTGNud0hFcE9pd0pXNmcraFdDM29WaVN3Y0hPTTFu?=
 =?utf-8?B?WnVCeEo3RWVRZ3lhSzRGRTlGQis5UWZQamp2Rngxdll0Vm0rWmQvZVJuM3Qr?=
 =?utf-8?Q?+p4I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af8d9bfe-0e2e-46ec-c432-08dc494e34ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 02:25:41.9782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfR6oFsty45YZXjLY83gQmV2zOX/HpWmTvRbXmpv1ZUboEnoARVi1UFI4gO5X+Ix0VNvTlyAGUhi1ZC5zDAsjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbCwNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTgsIDIwMjQgODo0MyBQTQ0KPiBU
bzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gQ2M6IHJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tOyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFt
ZC5jb20+OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJheQ0KPiA8UmF5Lkh1YW5n
QGFtZC5jb20+OyBTaGVub3ksIEdhdXRoYW0gUmFuamFsDQo+IDxnYXV0aGFtLnNoZW5veUBhbWQu
Y29tPjsgUGV0a292LCBCb3Jpc2xhdiA8Qm9yaXNsYXYuUGV0a292QGFtZC5jb20+Ow0KPiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1l
cg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgb2xla3NhbmRyQG5hdGFsZW5rby5uYW1lOyBE
dSwgWGlhb2ppYW4NCj4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLCBMaSAoSmFzc21pbmUp
IDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMS82XSBjcHVm
cmVxOiBhY3BpOiBtb3ZlDQo+IE1TUl9LN19IV0NSX0NQQl9ESVNfQklUIGludG8gbXNyLWluZGV4
LmgNCj4NCj4gT24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgMTE6MTLigK9BTSBQZXJyeSBZdWFuIDxw
ZXJyeS55dWFuQGFtZC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhlcmUgYXJlIHNvbWUgb3Ro
ZXIgZHJpdmVycyBhbHNvIG5lZWQgdG8gdXNlIHRoZQ0KPiA+IE1TUl9LN19IV0NSX0NQQl9ESVNf
QklUIGZvciBDUEIgY29udHJvbCBiaXQsIHNvIGl0IG1ha2VzIHNlbnNlIHRvIG1vdmUNCj4gPiB0
aGUgZGVmaW5pdGlvbiB0byBhIGNvbW1vbiBoZWFkZXIgZmlsZSB0byBhbGxvdyBvdGhlciBkcml2
ZXIgdG8gdXNlIGl0Lg0KPiA+DQo+ID4gTm8gaW50ZW50aW9uYWwgZnVuY3Rpb25hbCBpbXBhY3Qu
DQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IEdhdXRoYW0gUmFuamFsIFNoZW5veSA8Z2F1dGhhbS5z
aGVub3lAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxwZXJyeS55dWFu
QGFtZC5jb20+DQo+DQo+IFRoaXMgY2hhbmdlIGlzIGZpbmUgd2l0aCBtZSwgc28NCj4NCj4gQWNr
ZWQtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCg0KVGhhbmsgeW91
IGhlbHAgdG8gYWNrIHRoZSBjaGFuZ2UsDQpXaWxsIHBpY2sgdGFnIGluIG5leHQgdmVyc2lvbi4N
Cg0KUGVycnkuDQoNCj4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWlu
ZGV4LmggfCAyICsrDQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9hY3BpLWNwdWZyZXEuYyAgIHwgMiAt
LQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaA0K
PiA+IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgNCj4gPiBpbmRleCAwNTk1NmJk
OGJhY2YuLjQxNTAzNjQ3MTkyZSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9tc3ItaW5kZXguaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5o
DQo+ID4gQEAgLTc3NSw2ICs3NzUsOCBAQA0KPiA+ICAjZGVmaW5lIE1TUl9LN19IV0NSX0lSUEVS
Rl9FTg0KPiBCSVRfVUxMKE1TUl9LN19IV0NSX0lSUEVSRl9FTl9CSVQpDQo+ID4gICNkZWZpbmUg
TVNSX0s3X0ZJRF9WSURfQ1RMICAgICAgICAgICAgIDB4YzAwMTAwNDENCj4gPiAgI2RlZmluZSBN
U1JfSzdfRklEX1ZJRF9TVEFUVVMgICAgICAgICAgMHhjMDAxMDA0Mg0KPiA+ICsjZGVmaW5lIE1T
Ul9LN19IV0NSX0NQQl9ESVNfQklUICAgICAgICAgICAgICAgIDI1DQo+ID4gKyNkZWZpbmUgTVNS
X0s3X0hXQ1JfQ1BCX0RJUw0KPiBCSVRfVUxMKE1TUl9LN19IV0NSX0NQQl9ESVNfQklUKQ0KPiA+
DQo+ID4gIC8qIEs2IE1TUnMgKi8NCj4gPiAgI2RlZmluZSBNU1JfSzZfV0hDUiAgICAgICAgICAg
ICAgICAgICAgMHhjMDAwMDA4Mg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYWNw
aS1jcHVmcmVxLmMNCj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hY3BpLWNwdWZyZXEuYyBpbmRleCAz
N2YxY2RmNDZkMjkuLjJmYzgyODMxYmRkZA0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Y3B1ZnJlcS9hY3BpLWNwdWZyZXEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hY3BpLWNw
dWZyZXEuYw0KPiA+IEBAIC01MCw4ICs1MCw2IEBAIGVudW0gew0KPiA+ICAjZGVmaW5lIEFNRF9N
U1JfUkFOR0UgICAgICAgICAgKDB4NykNCj4gPiAgI2RlZmluZSBIWUdPTl9NU1JfUkFOR0UgICAg
ICAgICAgICAgICAgKDB4NykNCj4gPg0KPiA+IC0jZGVmaW5lIE1TUl9LN19IV0NSX0NQQl9ESVMg
ICAgKDFVTEwgPDwgMjUpDQo+ID4gLQ0KPiA+ICBzdHJ1Y3QgYWNwaV9jcHVmcmVxX2RhdGEgew0K
PiA+ICAgICAgICAgdW5zaWduZWQgaW50IHJlc3VtZTsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGlu
dCBjcHVfZmVhdHVyZTsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4NCg==

