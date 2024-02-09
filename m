Return-Path: <linux-kernel+bounces-59738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAACA84FB17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0442EB2A9E4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B0C7E770;
	Fri,  9 Feb 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LpzLy/DB"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06F7EEFC;
	Fri,  9 Feb 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500025; cv=fail; b=hNj0qQ8/EtR9tI1J90yw/v2YvzcwuXnxrVj65gUoT0frkCExUp2tKelJF2K5DUx4BHE7mQAyVfpPsweWRlKQ8h1WJaDh15jV8MHkUnlFgmraVYv/S0oTgF8Arj3E2ZnxyEdViRxAUx3/nobDBF6wJi8DyrqbKQaLG0BOGBG4R/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500025; c=relaxed/simple;
	bh=122yHwr/9vDKpcGTaULzhFU2pK1yRGhvXxWmkUNb020=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=phThx5M8iYyCmD2exV46G+sHXNwh96+UvWaaUrNRhbjUIuMba5XS/A1pAEAv5NX3vt7AiUp3Gr16fONYjbKP1WnUGVerzwq+i/RErZO9ENG/8XhnGv85NmhI5MitcFWhRAzFDx8RYYw9QofmPsAaldOkS55ss1MF5COnHvCjjk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LpzLy/DB; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzeToYrlyOd+Ye/mhnTBpYoEz4o/0z7vBOWry8QzTD5E6hxsvMi+MVBIyV36mX9bEof86f2OGU+YysgqkrNHJYvvrm0plyJF7a7DrXh8LANjhgL86xi1aFtjt44zBPUB+XrYoLtXb9zye9+rAcbDrG5GZgFgZw483mnuvjgybq8pnnNonbEbvvRG6uMs627IGlpn1ycH7/P3iN8h7S3uBtNzT49QTVnErzexqMZl1cqiQkZ7p6KXdZUzen8+DTfdxS2ZXrYYpzgt2KQ8ADl4pW5p2A5jzvh/HotIlTRuK4nQdD1jKpFTs1UJKj+FNSibShW09XEFRI+3dgSMcBwG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=122yHwr/9vDKpcGTaULzhFU2pK1yRGhvXxWmkUNb020=;
 b=JU/PGtyrD1TB/YYubTA4k484XtPYGPhJOL4qWUVQaKw216EWMX6jCubTsmQjaDgXesX86QjNacxSBSwcVD4khQmnV1p7NzyneYWK9y65ATra9QD0rk9IN+JbP2GZFN6ibm4EPv9EOhtTOfmFg4mZ+LxIGY1rcrR07DycFRSubQ42RoU3rVa2iqdmJFOTzv5HVLuhrRFgKy0+3Of15uZkr3Uks+GNOxONuAZam5ZtSTkCMVM5yRUXHTUohp0uuiNz1YmQOmF05g4nvBiGA+MVcS/GdQdVf5YGGyORmvUOJ7Lez73kaNR/vyVHnqBMKflS5UK5pdVZykEgggtMprmRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=122yHwr/9vDKpcGTaULzhFU2pK1yRGhvXxWmkUNb020=;
 b=LpzLy/DBvSufAMQlbqK5Nd5hi/JqDyYj3PdNtsonM2uD7zUpLk+Q5V8HNH6f5Fwh02GrdPowuj3HNkDGG0HPUWDR3/gn465aFd7NEd+qPpYM2nnogGRCObRE6qPUjSslPxlPPW+7WSeqj8e/hfHSZEGpXQapYmyc94udRgsH/5I=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Fri, 9 Feb
 2024 17:33:36 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7292.010; Fri, 9 Feb 2024
 17:33:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>, "rafael.j.wysocki@intel.com"
	<rafael.j.wysocki@intel.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)"
	<Li.Meng@amd.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/6] AMD Pstate Fixes And Enhancements
Thread-Topic: [PATCH v6 0/6] AMD Pstate Fixes And Enhancements
Thread-Index: AQHaWkIFWFeyqmVE9keWzTofk26Zp7EAPJwAgADWFYCAARhvgIAAGjYA
Date: Fri, 9 Feb 2024 17:33:35 +0000
Message-ID:
 <BL1PR12MB514496D92AE89A52D767192DF74B2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <20240208102122.GAZcSrIkbPJfIExdF6@fat_crate.local>
 <BL1PR12MB514409256AE93E5D13556F90F7442@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20240209155119.GAZcZJ92bTnwwO8l6Z@fat_crate.local>
In-Reply-To: <20240209155119.GAZcZJ92bTnwwO8l6Z@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=09787ae9-b293-4e0a-964e-495de255d975;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-09T17:25:14Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB7670:EE_
x-ms-office365-filtering-correlation-id: 1b0fd078-d8f1-4a5d-c5a7-08dc29953eb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hjunMYzeXkbsOnWjbuDKH68KcIOelW0nAGt2/oKPCd0jMFN1iVjB/9zeBO2wiTpOIyQPcbLb/1s2HzT5QnjFZejON1/2FpGfFRoMAOefYlNUaW8vs8KJBwk+xWifSGnb/GJbf6nQZWPUQKgO8nVldskRI1dHvfAd1EGx1VX3hHQ9HB69eqyUJhlb1Ydyr0jS21eMGjL7tMLpNVaMHub4wNu1pspcv1jxvgOdeY+K6UHOp42Sc5ZGLxOGUpEtfRQt66QEJuMq0Ozi12RURfVBvpFkLHBml36aQzs9vxpI4TBLjzMcTtiBrIZ/Sx9AXXqQybQsqsAwjg+o+PCmrNjxa6ryBE80fBWADEWouY41t3YMaO2wV/+Hni6szrvTGM+boUcqCIK2md0hsuh5RuNPNQtqWKEjO13ZCYS902gH2e9+SZkF4bHwxVATUsCR+Z87bSMjt2ena+0GGq1718MouDJXxAdB1qponkJFhayaTFlJ+/c2GY7DQhTsLTzW3hjChNqx0JZCns0dSxhIliOhO4Kp21zSQFjF0COZ5HNIYu8iR8xbqvdLbxnxf55vIXSWicd/JgZhBetmvq9cSEo5FjKQp6vjIOyXeQQ8J3YK1v8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38070700009)(55016003)(41300700001)(64756008)(66446008)(66946007)(66556008)(76116006)(71200400001)(6916009)(7696005)(54906003)(316002)(86362001)(66476007)(52536014)(8676002)(5660300002)(4326008)(478600001)(966005)(8936002)(6506007)(2906002)(33656002)(122000001)(38100700002)(53546011)(9686003)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THN2S1NJdWtmcHIvZ1JRcEJBUnVLaHlSRE83RVZCS3QyWlcxZjllMnQwK29p?=
 =?utf-8?B?WEtQN2lhZlRva1p3by9sWmNoODBBYXd4WFlFN1hwMDZadGM0VUR4c2tHRFQ0?=
 =?utf-8?B?dTY5Sm15R2FHY00rK0FNV1gzbENBRkZCZkVYN2R3UU96RUNmMGFiYTJFOXpm?=
 =?utf-8?B?blVoME43KzFPT1gxbkJNMUNtUXVBdGZWTXlhODVRSkdkTmlQdFFLa0pPMWho?=
 =?utf-8?B?N1VEZWJLRXMvdzdWeVhUOXExa2lWTFI2cTNUQzJtV2g5ZGZqdW9HRW5mODlR?=
 =?utf-8?B?RjZod1pCTXJtdzM1ekdsWm1TYWtvdUFzb2wwUnk3LzFaWVNpTkRQUC80SE0z?=
 =?utf-8?B?cGFDNG4wNXFiRExDNVptdDNtaEo5bjZVTFBDeEtIZUx5VGlyYm83a2oyZFZh?=
 =?utf-8?B?dHY3WStSUmFtVTNpR0QxeGs0cFR3Um5hbFNnbHo5aVlUbW50bDJ0YjB3dER5?=
 =?utf-8?B?L0swa1JzbDI3WGRYODV6Zm4rOXJnaGp4cHRFZWFYZkRoV3RaRElqa0pYZ3Za?=
 =?utf-8?B?OVNDNHdmaHp4T0lEWG5nSUxobk03WFFJOTA2d3FuaXdqZWoxVk0wUVJzcVNt?=
 =?utf-8?B?Mk81SVAzOVRmbGsxU2Q3Zi9pSXpqWTBBUHpMUElOeFRLNXhLTVl3eWovYWxY?=
 =?utf-8?B?Y0txSExqaThrZnhKajNBaWo5b0Y0dWJmaWJKMlFTSGlHejJYbmxhY1pmaWV5?=
 =?utf-8?B?ZFZmMmk3bTdTK0xBOHVSazBHWXptakllblY5YzlLWEhRMFF5WmVpQkJoeDRW?=
 =?utf-8?B?Nk80bmNzUFdMZzBkWFozUjVNM2dReGY1OHpFQ0xlK2NINlR6aUk2ZlpDUWl4?=
 =?utf-8?B?b05Nai9DeDdGdXp3b1FKcDZwbTY2L3d2OVJaYytYcXVOSkxYdFZ4L2tqV09J?=
 =?utf-8?B?ZTFXeDBKcExsNmhudk5uNUpPMWNQM0hWRFBsNXJINXAzMVEyU29wZks4OVZC?=
 =?utf-8?B?b3BmZVViaVNXVU9yWGRhTVphQWZnR01Pd2FPd2M4cjM0Y0dkclExTW1zajk3?=
 =?utf-8?B?Smd5ekpoTDl4eE5QUmxnNnhsTmJLWGxxVk5OMnVER3BGaVg1U040QW1EZG5O?=
 =?utf-8?B?cEFRaFpPb1QxNHdrVFB6Ung4VEVsbjlQY0pwV0dhdUhNeVg1QmNxc3kyMTBk?=
 =?utf-8?B?dlRnbU00SWdFWFhnT1NjNlE1TFpnV0tUN0lGejFhZHM1bENld282Q1hlQ1ND?=
 =?utf-8?B?UG5PUEQxWWVRTUV6WjlpbTltMzkyNzhCS1h3clkvSlpOTGdyRStiZ21PY01S?=
 =?utf-8?B?MytMbHg1VC9oZ3E2dEMvR21leHhJMnI0dVVqdEg4NkgvRUZMT1Bwc3g0dmQz?=
 =?utf-8?B?VHhFbFBNMEE4ZnFocUs4QWtmMUdraDBJWUdPa0oyMjhVUENWaDQ5bllVZlR2?=
 =?utf-8?B?bVM5VmF4MnhzVkV1R3RyZ09VbG9DUy9GNGk1bWJYRzhyUmc5aklIS0trQ1dq?=
 =?utf-8?B?dThOazlqcDBBc0VPMVoxQzR2WHVuOW5nRnRsOHZGc1hWcmZwZlFUWkZtaWpM?=
 =?utf-8?B?SDVrUVR6NnRyNWQ5RWFscGdYLy8xbjZ6NWxqRnpBNjhXLzFlL1VlcjgvRnlE?=
 =?utf-8?B?cmZQMlpLa096Tlk1TXo0Q2ZDcTlZdFZBQm95Z3NUdUVuWVhCdFZOb0N3dWdh?=
 =?utf-8?B?aXF4dlcrck03UnJnR1NkMFVaRGNyaUQwY2xIQU1SL0lrWlM5N1hoRjNyTnUx?=
 =?utf-8?B?dCtILzB1VDJYRXJDWGFyb3ZQWENOSWt2UEhpUTM3WDJlaFluenZMQysxQ0s0?=
 =?utf-8?B?amFMMjZrMzhxSWppWWNoelhFeFhLcFE5V3VKS1RtK01FSy9Vamk5c1FaQWxE?=
 =?utf-8?B?d3FJYURyU2ZYZ0xwV0laeVlYQUczT2JPYVE4QVArdWxoWGsyOGw5L2hhcjdw?=
 =?utf-8?B?dFpNbUxQUWxZZzBXUlU3NzBJREhyVm5yeEdTQjJiUVlEN0JZUTVYMjBJZWJH?=
 =?utf-8?B?Yi9UOXRZMnJScW9sNC9zRCtCQlUvV3h6Qm1zVFBaRHI5Y1FCNytYRWlEamZX?=
 =?utf-8?B?alVqZ3JQT21iZlJOMTh6MktySkxka25CTnAzSjUvRTM1SGJYMTIyalBNT2Jm?=
 =?utf-8?B?bzFJL0VOUWNJb1J2RWp6TW41eFhTZlBJQmZyUkliYnJQL0lzL2dQTjBXM3Vo?=
 =?utf-8?Q?y3l0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0fd078-d8f1-4a5d-c5a7-08dc29953eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 17:33:35.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W38CbOC9QHw51sGsynEMk5WVIHQ9u7D3KB0OpmjlyuqnkwQMZilQQQto6wOf/CV5qKfsVOApGIZfS10nTz0SIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xh
diBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSA5LCAyMDI0
IDEwOjUxIEFNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQo+IENjOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb207DQo+IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOw0KPiBIdWFuZywgUmF5IDxSYXku
SHVhbmdAYW1kLmNvbT47IFNoZW5veSwgR2F1dGhhbSBSYW5qYWwNCj4gPGdhdXRoYW0uc2hlbm95
QGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUs
IFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8
TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAvNl0gQU1EIFBz
dGF0ZSBGaXhlcyBBbmQgRW5oYW5jZW1lbnRzDQo+DQo+IE9uIFRodSwgRmViIDA4LCAyMDI0IGF0
IDExOjA5OjQ3UE0gKzAwMDAsIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToNCj4gPiBXaHk/DQo+
DQo+IEJlY2F1c2Ugd2UgaGF2ZSB0aG9zZSBydWxlcywgeW91IGtub3cuIFlvdSBzaG91bGQgc2Vu
ZCBhYm91dCBvbmNlIGEgd2VlaywNCj4gdW5sZXNzIHlvdSd2ZSByZXdvcmtlZCB5b3VyIHNldCBm
dW5kYW1lbnRhbGx5Lg0KPg0KDQpNeSByZWFkaW5nIG9mIHRoZSBydWxlcyBpcyB0aGF0IHlvdSBz
aG91bGQgd2FpdCBiZWZvcmUgcmVzZW5kaW5nIG9yIHBpbmdpbmcgaWYgeW91IGhhdmUgbm90IHJl
Y2VpdmVkIGZlZWRiYWNrLiAgSWYgeW91IGFyZSBhY3RpdmVseSByZWNlaXZpbmcgZmVlZGJhY2ss
IHRvIG1lLCBpdCBtYWtlcyBzZW5zZSB0byByYXBpZGx5IGl0ZXJhdGUuICBJZiBhIHBhdGNoIGlz
IHJldmlld2VkIGFuZCBjb21tZW50cyBhcmUgYWRkcmVzc2VkLCBpdCBjYW4gbGFuZCByYXRoZXIg
dGhhbiB3YWl0aW5nIGFuIGV4dHJhIHdlZWsgb3IgdHdvLg0KDQo+IE90aGVyd2lzZSBtYWludGFp
bmVycyBtYWlsYm94ZXMgd291bGQgYmUgYSBzZXJpb3VzIG1lc3MuIE5vdCB0aGF0IHRoZXkncmUN
Cj4gYWxyZWFkeSBzdWNoIG5vdy4uLg0KPg0KPiA+IEluIHRoaXMgY2FzZSwgdGhlcmUgaGF2ZSBi
ZWVuIGEgbnVtYmVyIG9mIHJldmlldyBjb21tZW50cyB3aGljaCBoYXZlDQo+ID4gYmVlbiBhZGRy
ZXNzZWQgaW4gdGhlIG5ldyByZXZpc2lvbnMgb2YgdGhlIHBhdGNoIHNldC4gIFdoeSBkZWxheSB0
aGUNCj4gPiBuZXcgcmV2aXNpb25zPw0KPg0KPiBTZWUgYWJvdmUuDQo+DQo+IEFuZCBzZWUgYmVs
b3cgZm9yIHRoZSAid2hvcHBpbmciIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlIGxhc3QgdHdvLg0K
Pg0KPiA+IFlvdSdsbCB1bHRpbWF0ZWx5IGdldCB0aGUgc2FtZSBhbW91bnQgb2YgZW1haWwganVz
dCB3aXRoIGEgbXVjaCBsb25nZXINCj4gPiBsYXRlbmN5Lg0KPg0KPiBObywgeW91J2xsIGhhdmUg
YSBsb3QgbGVzcyBlbWFpbC4gWW91IHNlbmQgdGhlIHNldCwgc2l0IHRpZ2h0IGFuZCBjb2xsZWN0
IHJldmlldw0KPiBmZWVkYmFjaywgd29yayBpdCBpbiBhbmQgc2VuZCBhZ2FpbiBhZnRlciBhIHdl
ZWsgb3Igc28uDQoNCkl0IGFsc28gYWRkcyBleHRyYSBsYXRlbmN5LiAgV2l0aCBteSBtYWludGFp
bmVyIGhhdCBvbiwgSSdkIGxpa2UgdG8gaGF2ZSBuZXcgcmV2aXNpb25zIHJhcGlkbHkuICBJIGd1
ZXNzIGl0IGNvbWVzIGRvd24gdG8gcGVyc29uYWwgcHJlZmVyZW5jZSwgYnV0IEkgZG9uJ3QgZG8g
d2VsbCB3aXRoIHRhc2sgc3dpdGNoaW5nLiAgV2hlbiBhIHBhdGNoIHNldCBpcyBmcmVzaCBpbiBt
eSBtaW5kLCBJJ2QgcmF0aGVyIHNlZSBpdCBmaW5pc2hlZCBvZmYgYW5kIGNvbW1pdHRlZCBzb29u
ZXIgcmF0aGVyIHRoYW4gbGluZ2VyaW5nIGFuZCB0aGVuIGEgd2VlayBvciB0d28gbGF0ZXIsIEkn
ZCBuZWVkIHRvIHBhZ2UgdGhlIHdob2xlIGRpc2N1c3Npb24gYmFjayBpbnRvIG15IGhlYWQgdG8g
bWFrZSBzdXJlIGV2ZXJ5dGhpbmcgd2FzIGFkZHJlc3NlZCBhbmQgYWxsIHRoZSB0YWdzIHdlcmUg
Y29sbGVjdGVkLg0KDQpBbGV4DQoNCj4NCj4gZGlmZiB2NS4udjYgLSBkZWZpbml0ZWx5IG5vdCBy
ZXNlbmQgb25lIGRheSBsYXRlciBqdXN0IHRvIHBpY2sgdXAgdGFncy4NCj4gLS0tLS0tLS0tLS0N
Cj4gLS0tIHY1XzIwMjQwMjA3X3BlcnJ5X3l1YW5fYW1kX3BzdGF0ZV9maXhlc19hbmRfZW5oYW5j
ZW1lbnRzLm1ieA0KPiAgICAgICAyMDI0LTAyLTA5IDE2OjQzOjI5LjQ4NzEwNDkzNSArMDEwMA0K
PiArKysgdjZfMjAyNDAyMDhfcGVycnlfeXVhbl9hbWRfcHN0YXRlX2ZpeGVzX2FuZF9lbmhhbmNl
bWVudHMubWJ4DQo+ICAgICAgIDIwMjQtMDItMDkgMTY6NDI6NTUuNjcxMzAzMzgwICswMTAwDQo+
IEBAIC0yMyw2ICsyMyw3IEBAIFJlcG9ydGVkLWJ5OiBHaW5vIEJhZG91cmkgPGJhZG91cmkuZ0Bn
bWENCj4gIENsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD0yMTgxNzENCj4gIEZpeGVzOiBmYmQ3NGQxNjg5ICgiQUNQSTogQ1BQQzogRml4IGVuYWJsaW5n
IENQUEMgb24gQU1EIHN5c3RlbXMgd2l0aA0KPiBzaGFyZWQgbWVtb3J5IikNCj4gIFNpZ25lZC1v
ZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gK1Jldmlld2VkLWJ5OiBH
YXV0aGFtIFIuIFNoZW5veSA8Z2F1dGhhbS5zaGVub3lAYW1kLmNvbT4NCj4gIC0tLQ0KPiAgIGFy
Y2gveDg2L2tlcm5lbC9hY3BpL2NwcGMuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkgQEAgLTI5Myw2ICsyOTQsNyBAQCBBYm92ZQ0KPiBt
ZXNzYWdlIGlzIG5vdCBjbGVhciBlbm91Z2ggdG8gdmVyDQo+DQo+ICBSZXZpZXdlZC1ieTogTWFy
aW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ICBTaWduZWQtb2Zm
LWJ5OiBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+DQo+ICtSZXZpZXdlZC1ieTogR2F1
dGhhbSBSLiBTaGVub3kgPGdhdXRoYW0uc2hlbm95QGFtZC5jb20+DQo+ICAtLS0NCj4gICBkcml2
ZXJzL2FjcGkvY3BwY19hY3BpLmMgfCA0ICsrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pIEBAIC0zNDIsOCArMzQ0LDkgQEAgJCBjYXQNCj4gL3N5
cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9hY3BpXw0KPiAgJCBjYXQgL3N5cy9kZXZpY2VzL3N5
c3RlbS9jcHUvY3B1MC9hY3BpX2NwcGMvbm9taW5hbF9mcmVxDQo+ICAwDQo+DQo+IC1TaWduZWQt
b2ZmLWJ5OiBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+DQo+ICBSZXZpZXdlZC1ieTog
TWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ICtTaWduZWQt
b2ZmLWJ5OiBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+DQo+ICtSZXZpZXdlZC1ieTog
R2F1dGhhbSBSLiBTaGVub3kgPGdhdXRoYW0uc2hlbm95QGFtZC5jb20+DQo+ICAtLS0NCj4gICBk
cml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIHwgNTcNCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tDQo+ICAgaW5jbHVkZS9saW51eC9hbWQtcHN0YXRlLmggICB8ICA2ICsr
KysNCj4NCj4NCj4gZGlmZiB2NC4udjUgLSAqZGVmaW5pdGVseSogKm5vdCogd2FycmFudGluZyBh
IG5ldyByZXNlbmQgb24gdGhlIG5leHQgZGF5IQ0KPiAtLS0tLS0tLS0tLQ0KPiAtLS0gdjRfMjAy
NDAyMDZfcGVycnlfeXVhbl9hbWRfcHN0YXRlX2ZpeGVzX2FuZF9lbmhhbmNlbWVudHMubWJ4DQo+
ICAgICAgIDIwMjQtMDItMDkgMTY6NDM6NTMuOTIyOTYxNTM2ICswMTAwDQo+ICsrKyB2NV8yMDI0
MDIwN19wZXJyeV95dWFuX2FtZF9wc3RhdGVfZml4ZXNfYW5kX2VuaGFuY2VtZW50cy5tYngNCj4g
ICAgICAgMjAyNC0wMi0wOSAxNjo0MzoyOS40ODcxMDQ5MzUgKzAxMDANCj4gQEAgLTM0MywxMyAr
MzQzLDE0IEBAICQgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvYWNwaV8NCj4gIDAN
Cj4NCj4gIFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4g
K1Jldmlld2VkLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNv
bT4NCj4gIC0tLQ0KPiAtIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA1OQ0KPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gKyBkcml2ZXJzL2NwdWZyZXEvYW1k
LXBzdGF0ZS5jIHwgNTcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+
ICAgaW5jbHVkZS9saW51eC9hbWQtcHN0YXRlLmggICB8ICA2ICsrKysNCj4gLSAyIGZpbGVzIGNo
YW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ICsgMiBmaWxlcyBjaGFu
Z2VkLCA2MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiAgZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0
ZS5jIC0NCj4gaW5kZXggNzdlZmZjM2NhZjZjLi44NzRkOGI2NjM3OTAgMTAwNjQ0DQo+ICtpbmRl
eCA3N2VmZmMzY2FmNmMuLmZmNDcyN2MyMmRjZSAxMDA2NDQNCj4gIC0tLSBhL2RyaXZlcnMvY3B1
ZnJlcS9hbWQtcHN0YXRlLmMNCj4gICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMN
Cj4gIEBAIC02Nyw2ICs2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgYW1kX3Bz
dGF0ZV9lcHBfZHJpdmVyOw0KPiBAQCAtMzcyLDE4ICszNzMsMTYgQEAgaW5kZXggNzdlZmZjM2Nh
ZjZjLi44NzRkOGI2NjM3OTAgMTAwNjQ0DQo+ICtzdGF0aWMgaW50IF9faW5pdCBkbWlfbWF0Y2hl
ZF83azYyX2Jpb3NfYnVnKGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkDQo+ICpkbWkpICArew0K
PiAgKyAgICAvKioNCj4gLSsgICAgICogbWF0Y2ggdGhlIGJyb2tlbiBiaW9zIGZvciBmYW1pbHkg
MTdoLCBtb2RlbCAzMWggcHJvY2Vzc29yDQo+ICsrICAgICAqIG1hdGNoIHRoZSBicm9rZW4gYmlv
cyBmb3IgZmFtaWx5IDE3aCBwcm9jZXNzb3Igc3VwcG9ydCBDUFBDIFYyDQo+ICArICAgICAqIGJy
b2tlbiBCSU9TIGxhY2sgb2Ygbm9taW5hbF9mcmVxIGFuZCBsb3dlc3RfZnJlcSBjYXBhYmlsaXRp
ZXMNCj4gICsgICAgICogZGVmaW5pdGlvbiBpbiBBQ1BJIHRhYmxlcw0KPiAgKyAgICAgKi8NCj4g
LSsgICAgaWYgKGJvb3RfY3B1X2RhdGEueDg2ID09IDB4MTcgJiYgYm9vdF9jcHVfZGF0YS54ODZf
bW9kZWwgPT0NCj4gMHgzMSAmJg0KPiAtKyAgICAgICAgICAgICAgICAgICAgYm9vdF9jcHVfaGFz
KFg4Nl9GRUFUVVJFX1pFTjIpKSB7DQo+ICsrICAgIGlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRV
UkVfWkVOMikpIHsNCj4gICsgICAgICAgICAgICBxdWlya3MgPSBkbWktPmRyaXZlcl9kYXRhOw0K
PiAtKyAgICAgICAgICAgIHByX2luZm8oImhhcmR3YXJlIHR5cGUgJXMgZm91bmRcbiIsIGRtaS0+
aWRlbnQpOw0KPiArKyAgICAgICAgICAgIHByX2luZm8oIk92ZXJyaWRpbmcgbm9taW5hbCBhbmQg
bG93ZXN0IGZyZXF1ZW5jaWVzIGZvcg0KPiAlc1xuIiwNCj4gKytkbWktPmlkZW50KTsNCj4gICsg
ICAgICAgICAgICByZXR1cm4gMTsNCj4gICsgICAgfQ0KPiAgKw0KPiAtKw0KPiAgKyAgICByZXR1
cm4gMDsNCj4gICt9DQo+ICArDQo+DQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jp
cy4NCj4NCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlx
dWV0dGUNCg==

