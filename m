Return-Path: <linux-kernel+bounces-56555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14084CBA5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1644D1F2750D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9B77658;
	Wed,  7 Feb 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pkthOdMO"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55876034;
	Wed,  7 Feb 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312922; cv=fail; b=QLPgOCbyRE1OSQUlUybm4juCsav/jW+E34AEPUBHjHzAcV/QyRR+IH/x9/tbCYKd5IRMmk95RpncrDMVNpL93/7/Mk7Fxnd/LokNkSAamJDaGT0yOxx65hOZBe3ns8KO4FUuq0LmUD86VQAiXdINLoAxFbOvNqXBtu8bakFeu+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312922; c=relaxed/simple;
	bh=/OSsuYw1QxxjkLzZedF7KCqfQfyObEwrlbP+oxbJYWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbQGyCWFegPZVhbFBlQpJHoKRQamD9m+OflaoreDs84cfEcOK17rfZj63yKgUmihK0Vt3mEGMM60hlVBTte9yfOvbmRA6Bb4L4awV3BafC28Id2XCwEt2yIClTi+6MrG9rp+YqzAyQpdSDnUzqXMtISSJe3Q5TIU9nnNFFnYfS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pkthOdMO; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNQUY9pRkqDhIrzTxdhAOxE7MB77Hzp1BUOhWbfL3hv8l/utlPCB8MCyYq9D+9wmP7GaOYY2jlc1KMvkRyAwzb+XDRjoKP8Z14zwOiZ1BMnBWQ6kdgOdTS8q4UabfGLiFMb0VfM2fkyFEiv2hhv1fqI9bQAppGkWIHzqoc6c7aE2SxgzQ3E7eN6Zl8wQUSfZQwzB4dx1hVc/gVS1stSOmJLLfuJq5oAMIUCrUWOV3wNiFJu8B7oryRgjtBiawJUFPBzc1MlFi0dzAPdl9OJLibCqqqwKMYHLtGKHZlCRKzI3LrkAwIPMW4udkJnyqT25IYUn5iGqdkb2hLmN/3XoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OSsuYw1QxxjkLzZedF7KCqfQfyObEwrlbP+oxbJYWE=;
 b=FxiRqUn1eNGEtR3tdUUzvnRMo3TZh2gbkz/Gyj3cjC6lKbM/97Sf7zLjjOjjAgFjst5C+Cprqk9L+rdNkZyTNvvluq4kgCi01IELXN3wjEa/Rq6y4XiRmy3nq41/68kl3YAmjjE/7Y3yFMLmTpoE58RRh39rJOwj8saFODoSTNkna4GFPxg0SXJe26MZ4Mvn3DISyXsMiMk/EkELh1E1nXVMredQ2Rp0krCgNPPMpCSQc4gPLMtecUFh0YMa8fDA/HStTEfV9/bxSa43bdd8u0he6EUSpFthT5cwENA08UhIH5Dx9CtiblPbBFjsjLQQZXhitf6Q+2PLD3L36/XipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OSsuYw1QxxjkLzZedF7KCqfQfyObEwrlbP+oxbJYWE=;
 b=pkthOdMOTD2T2IVhPrDP2PGoaBSh14kSGoqVYKQop7SOZWGAMmP13x7pSM6yk2EUYsuEKOZ4hh/ppHABQ/Sv4vfVM7Y2ySxiFQO4QXif1dSU7ioeEBjo07/4Z7E6ZE6pp6MYR4kurh2PChjnwD6KaZgTm0q+TrHx3es3lXb/hhI=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Wed, 7 Feb
 2024 13:35:17 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 13:35:17 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Petkov, Borislav"
	<Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/7] cpufreq: amd-pstate: remove legacy set_boost
 callback for passive mode
Thread-Topic: [PATCH v3 6/7] cpufreq: amd-pstate: remove legacy set_boost
 callback for passive mode
Thread-Index: AQHaWadx9By+jykrAEaliStQ0Z5XkrD+qI0AgAAymfCAAARWgIAAAUJw
Date: Wed, 7 Feb 2024 13:35:17 +0000
Message-ID:
 <CYYPR12MB8655BC98C395122B49C9598F9C452@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1707297581.git.perry.yuan@amd.com>
 <2887380.mvXUDI8C0e@natalenko.name>
 <CYYPR12MB8655B6D156512E187F2A736B9C452@CYYPR12MB8655.namprd12.prod.outlook.com>
 <5065083.31r3eYUQgx@natalenko.name>
In-Reply-To: <5065083.31r3eYUQgx@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=973a6b41-7639-4480-a94b-3e7691ec200d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T13:31:59Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA1PR12MB6209:EE_
x-ms-office365-filtering-correlation-id: 9cb48d6d-4e4e-407b-f8be-08dc27e19f5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YMGJj+jDYKGDO9Yhfw591vNPmpfrdbbDmvaFkBLz/9nDUVuosNxjpL3DYcoxOhWH8553PrtU9GKnHDe0o9zeYLBG/ZsNRakxQz6nKNzziRQDjBKcl5kYF50CDUlwV+qlWLI4KQAeWJN8WAn/ei+iDcVhoqqcgndDw137CJL+g5da1JO3RtQIbiSJ119YqP6fs/ilDeoCwwjJ/NdQ6yphMVDDtvd5dvLPo4Eh43/+q9NTgP7jUA85Ol5XtqXbR0vgtp8g9HuIiTbhtzf18tE/t9tJZnKaebbd02+lE0Iq1miyY3pgf6rRnclviotNkmRFekDONj89z4zQ8q0GZBDvsMAO9DO3ZuMzyVA1YpG/bHY02iqM7CwNKNAKb1M4WZexElIUFHZu/rtORwvqMCpSuRd1weEoPCcaOvSfsCcpVzOtnJCtSukvrm2b+hCd49sOXZFqOxhdCCTYITfqJhfvU6eWu5QZzefhpN8V/cTo9MWzKdwiqsIDMnn43XqGP3QD3DPmsB9WkbagjYjvYGbXIoMlgN4m6bbbuKimkvbLpfwxzpk3NybR35nhHH0TUQcmFZtGpeMGGIKKfDzFE5/9adYGhFUsw1bvFHkmfEt0ekXx/rpOeTiYv/pu8yROXe8gW8NDYNMh79EvmJwMujedEA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(478600001)(41300700001)(55016003)(38100700002)(122000001)(83380400001)(66574015)(7696005)(9686003)(6636002)(6506007)(53546011)(8676002)(5660300002)(66556008)(54906003)(71200400001)(66476007)(316002)(86362001)(921011)(52536014)(8936002)(110136005)(66446008)(26005)(4326008)(76116006)(2906002)(66946007)(38070700009)(33656002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2xRWDdTN2dLMTBqbmlnNXhQRVVMWUV1czlyME9xWWZvZ3dubWFCb01Vbmdm?=
 =?utf-8?B?ZjNSUkp6MGJKYmhYSEU4M2EyLzRZdEM2akpnQTVoNzVBN2dKUXduaFJPZzBn?=
 =?utf-8?B?U2pra21abk15elJnKzRYSm8rV2lDa205cldZSjBlblRSSlZFZnk3OUlubEtw?=
 =?utf-8?B?a1pUMGR0aW5GQ3BrQXNUMjI2dENOV3ExU0NmVStrNWtub2lWTnQ2NzBVRnlN?=
 =?utf-8?B?SFUwOENRbUFldmd3UzNkV0wzV1hZbzhyU1NSdWJXaTM5Z2pzb3RWMXo0dTJy?=
 =?utf-8?B?MEJ0OUo2OFhHSUVHWkVPU3VOY1V3NzhaNEFUUkNMempqVnA2NU5zemJDU3Nl?=
 =?utf-8?B?a2lvWmI5ZXBsTDQ1enFPWVMra1RicVJ2Z2ppU0NNZGc4ZThubG1Wb0NoeVo3?=
 =?utf-8?B?ZlFzeGZZNWJQN09kTVR3WmIzNis3NTdpRVZCdE1LaEZwVFl2Rmt6TTVuQVVt?=
 =?utf-8?B?VU05SnpCYi9YRFErUlVrV3JXUDhOeVVFVE11ck92dnQxZjhld2pLNkU5Y1Zw?=
 =?utf-8?B?YWY3dmFmeXhwSXhqRlZlNTMxdHFxUWpDSzRHa2IxZ2xQSWxiRUFHRWdVUFo5?=
 =?utf-8?B?RHBvOEVLMkF6dHlSa1ZBUnBIZzhFWkNFVVJyMkdLN1N5TDFQaC96M1ZRQkYw?=
 =?utf-8?B?SHBnRVJYOU16TlkrMVZyaldJblRwSVN0OXRxWDRnakZjd0s5VHJOSmdrL3hw?=
 =?utf-8?B?L0s0Y0t4YnU1aHRSR0h1RDduci9EUk45VTF0bzJrRExpUjR5NGZscXFVNTNF?=
 =?utf-8?B?U3g2czQyQWorM25OT3c0N1c0VUNrOVVFOXpiMDBBOWFXTW1RM01FOEM4bE5w?=
 =?utf-8?B?NzBNTjRsajdEVk9LSTJNR2VpVkJjNmNIZ1FoRURtamZyeFNsNENFWlRxcFpG?=
 =?utf-8?B?Z2hPU3U0TnFySWJMWWFpbUNUby9BeExDSEJxdTdOVU9tcVpEVkZXa1lnRi9W?=
 =?utf-8?B?MSt3LzFOT2dBK2FxYkxDYnZ0eEtSOWUydzFVQ1liTE0yWThjTnlzMis1eG1C?=
 =?utf-8?B?OXJlb1FHV0xLTkNpVnV2MituK1FHNzN3dVc5WE9EZW52cnp3aThtQWNuZWNk?=
 =?utf-8?B?Z1NWTzVBb2ppc0hBZU5QWEpzcjVvUWQ1ODVqU25aVjZDc3VBVmZkWHc0NlAr?=
 =?utf-8?B?ZldsOFpNU0dCMWJTQ3QyNUo5V25nRjN2MmFvNFpyQXZraUJlbWVOQmZHYzJG?=
 =?utf-8?B?UVhRVmxZR3d2bmRCMGo2ZkxRdTRUYmlPSlZsSDU2YUZlanpjOFRtZ0FWaDNI?=
 =?utf-8?B?YzROdEE3cnBvUFI4ZjZjUTlSZmhMODRKVG0vbjdKYURocFZ3K1lNRjF1eFZJ?=
 =?utf-8?B?STk2VEpleVNQUGw1VXpmRklubStuSE5LYzEvOFZaUzJYeTNqdXN6M3pLTDhl?=
 =?utf-8?B?SFpJU3JyZ2IvcjNhdkUrNWtCME5hUXYrQWZSTXYvOVp5ZlZEWFJUL3BhQ2hz?=
 =?utf-8?B?WnQzTmpYamxpaVRWZFp3TVl4b3F2SlhnV0taUnkzZXJ5eXZsY2k2bCtBWjlP?=
 =?utf-8?B?T2IzRUF1azNBc2t3YmErVjdOMStQTkF3WWYxYnNMNzFYdUt3VXV3cHMyRDdE?=
 =?utf-8?B?eGVrRWVOT1k4NWdlN1VhdFlpM0YrKzUrVnkvaHF4bDkxL1pSUXBESVBpZWpN?=
 =?utf-8?B?eTFCMHlzbG90ejNaUndMUmxYZWRuaXd1ZTM4RjN1bEZOKzA1RUJ0ZSttN082?=
 =?utf-8?B?dENOeUZxbnZVWC9hOCtmS29KNkNoQzFJV0NpTVBVN1JHLzVOLzhxN3dnZHU5?=
 =?utf-8?B?eUl5RGdzcSswZ1ZDWFRwcmhhRUREbnh4TWFXbnFGZWVYN1hEL25HNnArNHUw?=
 =?utf-8?B?RFR0bVQ3U1hUaExnS3NNbml3QWtMMVhpeTg3aWswYXEreHVZVDcycUk0Z0Ni?=
 =?utf-8?B?VkozVDBYSFlxelE0blAyb0hvZUFFM3FSQ2haekdIbGVtYlErb0RhUjUrQk05?=
 =?utf-8?B?RG10U25WWUVHLzVxSUl5dmh1M21wTGRZRzluZ210dTM4T0dGWDdxS2F1b2xr?=
 =?utf-8?B?RW5ZbjNmV05DTGlld0QweWRnekZ2SXYvUDFjMWdtSkpTaE5tUHNESUFUZXFj?=
 =?utf-8?B?S0VnbmJXNi9GZUJwZ3Z4UHhwR3BKczZGak5mVVBZQk8ySCtjQnk5ci8yU1lV?=
 =?utf-8?Q?+pXE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb48d6d-4e4e-407b-f8be-08dc27e19f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 13:35:17.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VpFZoLHJ3gLxxQy7BWKA3J3XhfgrHFtLZlkNOJdK22V/OkYkOL/5vC45Y+1LV07cALLfje77lt0syC6tPSdXpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogT2xla3NhbmRyIE5hdGFsZW5rbyA8b2xla3NhbmRyQG5hdGFsZW5r
by5uYW1lPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjQgOToyNyBQTQ0KPiBU
bzogcmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb207IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFy
aW8uTGltb25jaWVsbG9AYW1kLmNvbT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywg
UmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IFNoZW5veSwgR2F1dGhhbSBSYW5qYWwNCj4gPGdh
dXRoYW0uc2hlbm95QGFtZC5jb20+OyBQZXRrb3YsIEJvcmlzbGF2DQo+IDxCb3Jpc2xhdi5QZXRr
b3ZAYW1kLmNvbT47IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+IENjOiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1l
cg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBh
bWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgt
cG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYzIDYvN10gY3B1ZnJlcTogYW1kLXBzdGF0ZTogcmVtb3ZlIGxl
Z2FjeSBzZXRfYm9vc3QNCj4gY2FsbGJhY2sgZm9yIHBhc3NpdmUgbW9kZQ0KPg0KPiBPbiBzdMWZ
ZWRhIDcuIMO6bm9yYSAyMDI0IDE0OjE3OjA2IENFVCBZdWFuLCBQZXJyeSB3cm90ZToNCj4gPiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogT2xla3NhbmRyIE5hdGFs
ZW5rbyA8b2xla3NhbmRyQG5hdGFsZW5rby5uYW1lPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBG
ZWJydWFyeSA3LCAyMDI0IDY6MTEgUE0NCj4gPiA+IFRvOiByYWZhZWwuai53eXNvY2tpQGludGVs
LmNvbTsgTGltb25jaWVsbG8sIE1hcmlvDQo+ID4gPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNv
bT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywgUmF5DQo+ID4gPiA8UmF5Lkh1YW5n
QGFtZC5jb20+OyBTaGVub3ksIEdhdXRoYW0gUmFuamFsDQo+ID4gPiA8Z2F1dGhhbS5zaGVub3lA
YW1kLmNvbT47IFBldGtvdiwgQm9yaXNsYXYNCj4gPiA+IDxCb3Jpc2xhdi5QZXRrb3ZAYW1kLmNv
bT47IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gPiBDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsDQo+IFNoaW1tZXIN
Cj4gPiA+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1
QGFtZC5jb20+Ow0KPiBNZW5nLA0KPiA+ID4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29t
PjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiA+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNi83XSBjcHVmcmVxOiBhbWQt
cHN0YXRlOiByZW1vdmUgbGVnYWN5DQo+ID4gPiBzZXRfYm9vc3QgY2FsbGJhY2sgZm9yIHBhc3Np
dmUgbW9kZQ0KPiA+ID4NCj4gPiA+IEhlbGxvLg0KPiA+ID4NCj4gPiA+IE9uIHN0xZllZGEgNy4g
w7pub3JhIDIwMjQgMTA6MjE6NTcgQ0VUIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gPiA+IFdpdGgg
bmV3IGZyZXFlbmN5IGJvb3N0IGludGVyZmFjZSBzdXBwb3J0ZWQsIGxlZ2FjeSBib29zdCBjb250
cm9sDQo+ID4gPiA+IGRvZXNuJ3QgbWFrZSBzZW5zZSBhbnkgbW9yZSB3aGljaCBvbmx5IHN1cHBv
cnQgcGFzc2l2ZSBtb2RlLg0KPiA+ID4gPiBzbyBpdCBjYW4gcmVtb3ZlIHRoZSBsZWdhY3kgc2V0
X2Jvb3N0IGludGVyZmFjZSBmcm9tIGFtZC1wc3RhdGUNCj4gPiA+ID4gZHJpdmVyIGluIGNhc2Ug
b2YgdGhlcmUgaXMgY29uZmxpY3Qgd2l0aCBuZXcgYm9vc3QgY29udHJvbCBsb2dpYy4NCj4gPiA+
ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQuY29t
Pg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCAx
IC0NCj4gPiA+ID4gIGluY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oICAgfCAxIC0NCj4gPiA+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiA+ID4gYi9kcml2ZXJzL2Nw
dWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDM1NzkxZWZjNmU4OC4uMWRkNTIzZGIzODcxDQo+ID4g
PiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+
ID4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gPiA+IEBAIC0xNjc1
LDcgKzE2NzUsNiBAQCBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyDQo+ID4gPiA+IGFtZF9w
c3RhdGVfZHJpdmVyID0NCj4gPiA+IHsNCj4gPiA+ID4gICAgIC5leGl0ICAgICAgICAgICA9IGFt
ZF9wc3RhdGVfY3B1X2V4aXQsDQo+ID4gPiA+ICAgICAuc3VzcGVuZCAgICAgICAgPSBhbWRfcHN0
YXRlX2NwdV9zdXNwZW5kLA0KPiA+ID4gPiAgICAgLnJlc3VtZSAgICAgICAgID0gYW1kX3BzdGF0
ZV9jcHVfcmVzdW1lLA0KPiA+ID4gPiAtICAgLnNldF9ib29zdCAgICAgID0gYW1kX3BzdGF0ZV9z
ZXRfYm9vc3QsDQo+ID4gPiA+ICAgICAudXBkYXRlX2xpbWl0cyAgPSBhbWRfcHN0YXRlX3VwZGF0
ZV9saW1pdHMsDQo+ID4gPiA+ICAgICAubmFtZSAgICAgICAgICAgPSAiYW1kLXBzdGF0ZSIsDQo+
ID4gPiA+ICAgICAuYXR0ciAgICAgICAgICAgPSBhbWRfcHN0YXRlX2F0dHIsDQo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+ID4gPiBiL2luY2x1ZGUv
bGludXgvYW1kLXBzdGF0ZS5oIGluZGV4IDQ2NWU5Mjk1YTYwYy4uYWI3Y2EyNjk3NGRhDQo+ID4g
PiA+IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+
ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+ID4gPiBAQCAtOTMsNyAr
OTMsNiBAQCBzdHJ1Y3QgYW1kX2NwdWRhdGEgew0KPiA+ID4gPiAgICAgc3RydWN0IGFtZF9hcGVy
Zl9tcGVyZiBwcmV2Ow0KPiA+ID4gPg0KPiA+ID4gPiAgICAgdTY0ICAgICBmcmVxOw0KPiA+ID4g
PiAtICAgYm9vbCAgICBib29zdF9zdXBwb3J0ZWQ7DQo+ID4gPg0KPiA+ID4gQXMgYSByZXN1bHQg
b2YgdGhpcyByZW1vdmFsIHRoZSBrZXJuZWwtZG9jIGZvciB0aGlzIHN0cnVjdCBzaG91bGQgYmUN
Cj4gPiA+IGFtZW5kZWQgdG9vIGJlY2F1c2UgZXZlbiBhZnRlciB0aGlzIHBhdGNoIGlzIGFwcGxp
ZWQgdGhlDQo+ID4gPiBgYm9vc3Rfc3VwcG9ydGVkYCBmaWVsZCByZW1haW5zIGRvY3VtZW50ZWQu
DQo+ID4NCj4gPiBUaGUgc2V0X2Jvb3N0IGlzIGNhbGxiYWNrIHVzZWQgYnkgY3B1ZnJlcS5jLCB0
aGUgYm9vc3Rfc3VwcG9ydGVkIGlzIG5vdA0KPiBkb2N1bWVudGVkIGJlZm9yZSB0aGUgcGF0Y2gu
DQo+ID4gV2UganVzdCBuZWVkIHRvIGFkZCBuZXcgc3lzZnMgImNwYl9ib29zdCIgaW50cm9kdWN0
aW9uIGluIHRoZQ0KPiAiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vYW1kLXBzdGF0ZS5y
c3QiDQo+ID4gVGhlIGxlZ2FjeSBib29zdCBpcyBub3Qgc3VwcG9ydGVkIGFueSBtb3JlLCB3ZSBo
YXZlIG5vIG5lZWQgdG8NCj4gZG9jdW1lbnQgaXQgYWdhaW4gYXMgaXQgaXMuDQo+DQo+IGBib29z
dF9zdXBwb3J0ZWRgIGFzIGEgZmllbGQgb2YgYHN0cnVjdCBhbWRfY3B1ZGF0YWAgaXMgZG9jdW1l
bnRlZCBpbiB0aGUNCj4ga2VybmVsLWRvYyByaWdodCBiZWZvcmUgdGhlIHN0cnVjdHVyZSwgYW5k
IHRoaXMgYml0IHNob3VsZCBiZSByZW1vdmVkIGxpa2UNCj4gc2hvd24gYmVsb3c6DQoNCllvdSBt
ZWFuIHRoZSBjb21tZW50IGluIHRoZSBhbWQtcHN0YXRlLmgsIHJpZ2h0Pw0KSSBtaXN1bmRlcnN0
b29kIHRoYXQgeW91IGFyZSByZWZlcnJpbmcgdG8gYW1kLXBzdGF0ZS5yc3QgRG9jLg0KVGhlIGNv
bW1lbnQgaXMgcmVtb3ZlZCBmcm9tIHY0LCB3aWxsIHNlbmQgaXQgb3V0IGFmdGVyIG90aGVyIGZl
ZWRiYWNrIGNvbGxlY3RlZC4NClRoYW5rcyBmb3IgdGhlIHJldmlldyENCg0KUGVycnkuDQoNCi0g
KiBAYm9vc3Rfc3VwcG9ydGVkOiBjaGVjayB3aGV0aGVyIHRoZSBQcm9jZXNzb3Igb3IgU0JJT1Mg
c3VwcG9ydHMNCj4gYm9vc3QgbW9kZQ0KDQo+DQo+IGBgYA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L2FtZC1wc3RhdGUuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiBAQCAt
NTYsNyArNTYsNiBAQCBzdHJ1Y3QgYW1kX2FwZXJmX21wZXJmIHsNCj4gICAqIEBjdXI6IERpZmZl
cmVuY2Ugb2YgQXBlcmYvTXBlcmYvdHNjIGNvdW50IGJldHdlZW4gbGFzdCBhbmQgY3VycmVudA0K
PiBzYW1wbGUNCj4gICAqIEBwcmV2OiBMYXN0IEFwZXJmL01wZXJmL3RzYyBjb3VudCB2YWx1ZSBy
ZWFkIGZyb20gcmVnaXN0ZXINCj4gICAqIEBmcmVxOiBjdXJyZW50IGNwdSBmcmVxdWVuY3kgdmFs
dWUNCj4gLSAqIEBib29zdF9zdXBwb3J0ZWQ6IGNoZWNrIHdoZXRoZXIgdGhlIFByb2Nlc3NvciBv
ciBTQklPUyBzdXBwb3J0cw0KPiBib29zdCBtb2RlDQo+ICAgKiBAaHdfcHJlZmNvcmU6IGNoZWNr
IHdoZXRoZXIgSFcgc3VwcG9ydHMgcHJlZmVycmVkIGNvcmUgZmVhdHVlLg0KPiAgICogICAgICAg
ICAgICAgT25seSB3aGVuIGh3X3ByZWZjb3JlIGFuZCBlYXJseSBwcmVmY29yZSBwYXJhbSBhcmUg
dHJ1ZSwNCj4gICAqICAgICAgICAgICAgIEFNRCBQLVN0YXRlIGRyaXZlciBzdXBwb3J0cyBwcmVm
ZXJyZWQgY29yZSBmZWF0dWUuDQo+DQo+IGBgYA0KPg0KPiA+IFBlcnJ5Lg0KPiA+DQo+ID4gPg0K
PiA+ID4gPiAgICAgYm9vbCAgICBod19wcmVmY29yZTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgIC8q
IEVQUCBmZWF0dXJlIHJlbGF0ZWQgYXR0cmlidXRlcyovDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4N
Cj4gPiA+IC0tDQo+ID4gPiBPbGVrc2FuZHIgTmF0YWxlbmtvIChwb3N0LWZhY3R1bSkNCj4gPg0K
Pg0KPg0KPiAtLQ0KPiBPbGVrc2FuZHIgTmF0YWxlbmtvIChwb3N0LWZhY3R1bSkNCg==

