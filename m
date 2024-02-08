Return-Path: <linux-kernel+bounces-57455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 909E184D94B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74CC1F21537
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD12C6B0;
	Thu,  8 Feb 2024 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjES6FN9"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604229CE6;
	Thu,  8 Feb 2024 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364714; cv=fail; b=Iq+sDR47bpxki/Nhuh5dkLZmVVs10dfPAChfqPqHGx7MnPPNgmNhkkEHm49xz7v4Tyh1+kZJoUSByDsL/JzNSFmFFK2emlYOSNzTLDh1pPj1iDuQSX0yhiHgp5vfjHT2XSGy2u0Fax76zjs//H3U8l+ycFuHKmLICNj8HlUBXUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364714; c=relaxed/simple;
	bh=hJRHOdRiSB9lGf5/27H2DNDmk33WSfmH4vVWCyjjees=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DptgiAa1V7SesBJkLWzxdIAKeVO4KrOWb9vDOSrsZtHS7RRaX4FiuU5JRs2nQJJskTGLfmDXYbkh5I17Ew4zYedxaYVwMTpMzUCOpQ8E6G3364r6oqOEN5+wIu4mrQQDH+PcqcNAI52mXt+dMgDeJUV5bi7q6fVKi0X6HvtaTGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjES6FN9; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af7qcH4VCUwhl5u/uGl8nqqtnzGj+zJjZFGIsGr6PPw6mjtwMrFmXCLiEoqdPmTcKGm0ouzcoh8gQ/WNQgdLarMAvE1UEV843yqObIltr4wH32WXsXs0qzRxp1AvsDb5SrImXceAh3NKDv8/ILEJ4Xi+171V1GydsBud8/KOKDXrmcZbkjcf21hicU0qJSbZz93nLStOX62NLXBqJZLhos2lC1DjtXoBuxip879MIqvFTC+QHto4X/uKTZrURkCmFhIXxxNARCG9PzLE2L57XbJ9lvSxAydawNS1fhRdv/d9V9dlYZ6gHEZqeZY27qfK5PuiC4CFxYYTY9dPSb65wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJRHOdRiSB9lGf5/27H2DNDmk33WSfmH4vVWCyjjees=;
 b=fRkYAlQxZ+593uJGk94u5nHS8ehpRYToYUs9Zbo9MDy0by5nYdU2RVGUkj1zB2RxMLwFYZZagUTgd+LR9MhiNw4saD346eaoO7I4RSk/w/+8Ponjswtet3MB35aZhv/vBPpmp4JcTiZtY/ab9eWFbHCyxUqA6xJswNg/dmMFIoP8u7FIjnYOwvU2/2KizA94RIl4P3LA7rFhLE2F6kliUqotpN6vPhIcYG57NxT4yVHhkadHmudm1PLsalrKubvoqyseMAw51NaPtCkNcWPVvwbMk3aDdude2JQcTKEwZUnKUEEVQ/krZ4iwa28xvoOsUA/FaB9Nl0dJNNEZ5UJAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJRHOdRiSB9lGf5/27H2DNDmk33WSfmH4vVWCyjjees=;
 b=yjES6FN9BL+CZT2YMOlfBWYFFP15sUSailZzW0tbyYbTgF2vk87C0KfrE4FzQxGuzMTW1Go9z/ApFrxfboK3ZI+nkOr8RHBCM5Fxyogk7mwjzOV2RO33V9L8aFDxBJU7A+5PamupZlBocnwzsaQKWj9csoLv8tQ2QJo79S7MCGY=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Thu, 8 Feb
 2024 03:58:29 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 03:58:29 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Topic: [PATCH v5 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Index: AQHaWXAsJgnJdVG4+0mgOMvzK5aC/LD/Xd6AgABzfxA=
Date: Thu, 8 Feb 2024 03:58:29 +0000
Message-ID:
 <CYYPR12MB8655F08276F5482A321562409C442@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1707273526.git.perry.yuan@amd.com>
 <ea6a2fcf27703d40957a53608d48813cb07f094c.1707273526.git.perry.yuan@amd.com>
 <c1d10162-af8a-4900-91a2-14f80f669abf@amd.com>
In-Reply-To: <c1d10162-af8a-4900-91a2-14f80f669abf@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0a37c912-6ccc-4690-8dc0-d75db8d5d03b;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-08T03:51:39Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SJ0PR12MB5661:EE_
x-ms-office365-filtering-correlation-id: 7fe20488-05ab-4782-f9e2-08dc285a35b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xgdIALqIRxnc4Z9HqgTt6HJQ6uFh929fh1InAFWLI1ePvTnsr6KELDW/9pA7xWkzdopob3H3ps3wuQKenNAPCP4cefSYXEHbLhNCBv+Tv1WLNT5faEpS0yIiSBDI5+O3B11hHfPV+3kpn558hvNk/PX++3UaUsMGnY/1UKU5KSwkxB2lO4atsWr4XEe6PY/CRzT8S0JospsDwISibRCX4qLf8vhtxJXsSpippIr2T4gotKAA2WXhFcPSJr+5puWbcqC/zBuRQt4gTwjrmVIummU1zx4pHsGRAN4tYxJmuPzRHMGRqHysm4lvq7FIOdjfEdlmm7caNVulsAy+h06RwEwfzFCuFJitNQC8/iQoW+IVOJrh0SAMJ7p7Ag+Ak9JndgURfSHMOTKM2uqZOpIfUOId/hMU7bFLIkPuyjo8hUNb9iRDexT1eVPHPy6vcR/rCY0bFMt9xp1bSVm35CyqWDgeGw8S/kGs7xMF2Z3uvl1+NWrtjlg2CJ/njo2AeLxvSrcDZiIEyesjY953Egv5ImuPBvEEahfktegYsdDxNMl9AU9KWWtrH4D5ZJ+dyfT2K0dwPe74LbHIfw27DY/jeTwgWiULSUdrk3yrgLBfYEsBgiukwXEHCUBBDKTIkzkr8lggDrKByc/tMCUL187jyQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(33656002)(921011)(478600001)(53546011)(9686003)(38070700009)(86362001)(41300700001)(8676002)(83380400001)(26005)(71200400001)(8936002)(66446008)(5660300002)(316002)(38100700002)(122000001)(4326008)(7696005)(66946007)(66476007)(76116006)(66556008)(52536014)(6636002)(64756008)(6506007)(110136005)(2906002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXBqS2x5ZGtuaU1Ga0lQRWRWQnRmWGdYbnBYUDVMd2VhczE5Y2hLcGpPOUo5?=
 =?utf-8?B?eDNqb0VJSkJnZEMzcHB4L0RVM0pvQ1B5VFdDUFdIVW1UaW0ySE41cjNON3Jo?=
 =?utf-8?B?RVMraEdWdkx5VEhaV1hyeXNuVXNkcHpBWENHSllUVDM2SVRKVDJuNlJvdmpM?=
 =?utf-8?B?N0dsS0E3RGFTcDg3V2tER3Zwd3huOUJzZHZXYjJWclQ0cmpKeHNoWTVMMEdE?=
 =?utf-8?B?ajY2bEY5SCtCeU96L3dyQTBUVGRCQ1hoK2E0V00zam54cVVWMUExWmlEMlRi?=
 =?utf-8?B?M0JZQWZESHpXeG5uZnNvUThtdzVYWkdwNHVldUtuZ0FxZHlOZkdtYXNFN1lP?=
 =?utf-8?B?RDBWUk82cU9Ba1Iva3JYbUVpZSt4aFROajZtbEpuWmZtcC92aXNtTmhqeE1X?=
 =?utf-8?B?eUozQkNOSC8vK2Y1NXNpdC80Q0hYNXVhYm5mTGVFTGxCeFkvNU1jUkw0RXpE?=
 =?utf-8?B?dFp6L0EreUdkN0ZSeDE3amFQcGErSUJpOFRkckY3RHdORTJzVHJocHJ1d0FV?=
 =?utf-8?B?aXpwQkVHZGlWbmc2ampJRWR3MVpEaHZKMDJOVTJybGpzcVNzQisyTys4SnlH?=
 =?utf-8?B?V2dDaUhTdkNtM3Vvc21ES1l4OEc0VndBU2dNMnRPeEdGTGdHd3ViTENoenR2?=
 =?utf-8?B?QmU5RExlK2ZrMllVL1JJdWttS0twRjk4bTFkcEIzbzFHQWhxTDROby93akE0?=
 =?utf-8?B?WGN3N08yKzVxNStHOEs0YzR5R0ZTTnZsNzZKc3lVL3YrTktvUjd5Um9RQUpK?=
 =?utf-8?B?TlRnMmRNeTZKdjJ3RVJnei9lc0w4NUd6d2RTTzVWcUtRNEFkYkZoYnpGaE5I?=
 =?utf-8?B?Wm5GSEVxcGJOdDVWS2RIZVpmQlVVQXdXa3lGOWdra1dHV29ESkE5MHJiRDVH?=
 =?utf-8?B?WVhXdTF1clRUdE1SUlVlbU1pRVduZVlEY1BEaG9meFNWaTl4R0pMYjdveXZ6?=
 =?utf-8?B?SitGU0tVUDAvS3MzcTVoV2dXOUY3SEhwSkFDQ2phZFZLNTdsTFlXclZhZXcz?=
 =?utf-8?B?UXl6L095UWYvU0FTVHF5Vk5xSFJwdFBHTlZWL3ZZNGwyVXdnRGpzTlcxR2Rm?=
 =?utf-8?B?di9CMVZhQ1prM1pvUWluY2RJVDB0MGdoRmVJRnlxeWM4Rmo4eTR4cUdvQkxM?=
 =?utf-8?B?QlBNeUtPMTg4VUJkSlJOSjhsZEJ2ZnovUHMxcHdyYnFEckZRYjMxaUpXZXJu?=
 =?utf-8?B?eUdWQ0Q3V0dsL1hWUVFSMFZBOHAxTGo0OGkwWWdTVmJDamw1QU9sa3U2Z1lX?=
 =?utf-8?B?ZHR4bHE1WlhwME9QaUZ3RXZwR3htUk1aeWNwR2FNT0FRTnRFeWRYQlZKdXcy?=
 =?utf-8?B?cnBod1BKeUFBbVlEcDlsNHZkK1ByK3VkL1FLVnRLMm5EeDNNRG8yVFFBQjcy?=
 =?utf-8?B?UmIraHdxbUhNTG9sSlhweW44Vk9Hb05rd3gweTE3U0tiaWsza1NwcHpRZW5O?=
 =?utf-8?B?cHRoWVpwYWJPdnI0NlZiY3FtK1pSNmJTU2tzNzRMK1o4ZjNwTyt4Mlh3RFRy?=
 =?utf-8?B?Q1AyaEVaZjFBYkZjNy9WYTk5WC9vSGtxUVMvUktyR05tdnVxQWR0NDN2MlJr?=
 =?utf-8?B?WEo3SGdzTkxmdHNPbWFRT2M5Qk5TRklDZzBwbFNTK3RhRmxkK2h4dGJjNGJ6?=
 =?utf-8?B?RTBCcE55Q1lPVWFlMXpPZ0s0b3B1ZXhKL0d6Z3hHdGhkQ3M5a2tQdHFpWWZu?=
 =?utf-8?B?aXJaRXhuVm8zZHBsWVZrT1hRNE95M1FUZ3hGQ2I1RVV1Nkg5Y0R4WkpnNTF2?=
 =?utf-8?B?UE5GYmcrSDlVRXEvL042ODM1NEZ1ZVFyS3hCMUxUMFhjREQ2SENCM01BWlNV?=
 =?utf-8?B?QS9NekRRWmkyUHhONVFtVnVTRG1udHUxUGFkQjlGL1lPMzRWWFgwYW9URklF?=
 =?utf-8?B?RE0zVGcyVlhSaXFhZjhZWlI5QjNIM0VGbmIxK0Z3QXJvRmZpNXlLTXdSenc4?=
 =?utf-8?B?aTE3VnlRYXhlSEx3d01hTVB2Z0JMMUM5aEgza0Zoam85eFR5M3NMeU85L2kv?=
 =?utf-8?B?YjRtVW12V2pqQ2ZBTTBGK2FOK1g0dnZ2QmdjZ1BXeko4Zi9xUmZpaHRoS1hQ?=
 =?utf-8?B?RlVzM2l6cmh3cWFrRERQcEY1R21LN3I5a1o2c21SMDZSTDRjekJWN1Z2YWlY?=
 =?utf-8?Q?uGA4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe20488-05ab-4782-f9e2-08dc285a35b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 03:58:29.3200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEXWVcSghWj+RzYl63NPpJU2vP4PwIltXKoRgDxwtLQHYkf+WfjJkCZ29cFxV2eOMxL74NNM7oE4t4V8dVRhYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCiBIaSBNYXJpbw0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDgsIDIwMjQg
NDo1OCBBTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOw0KPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJh
eSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBTaGVub3ksDQo+IEdhdXRoYW0gUmFuamFsIDxnYXV0aGFt
LnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNsYXYuUGV0a292QGFt
ZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9q
aWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVu
Z0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDYvNl0gY3B1ZnJlcTphbWQt
cHN0YXRlOiBhZGQgcXVpcmsgZm9yIHRoZSBwc3RhdGUNCj4gQ1BQQyBjYXBhYmlsaXRpZXMgbWlz
c2luZw0KPg0KPiBPbiAyLzYvMjAyNCAyMDo0NiwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBBZGQg
cXVpcmtzIHRhYmxlIHRvIGdldCBDUFBDIGNhcGFiaWxpdGllcyBpc3N1ZSBmaXhlZCBieSBwcm92
aWRpbmcNCj4gPiBjb3JyZWN0IHBlcmYgb3IgZnJlcXVlbmN5IHZhbHVlcyB3aGlsZSBkcml2ZXIg
bG9hZGluZy4NCj4gPg0KPiA+IElmIENQUEMgY2FwYWJpbGl0aWVzIGFyZSBub3QgZGVmaW5lZCBp
biB0aGUgQUNQSSB0YWJsZXMgb3Igd3JvbmdseQ0KPiA+IGRlZmluZWQgYnkgcGxhdGZvcm0gZmly
bXdhcmUsIGl0IG5lZWRzIHRvIHVzZSBxdWljayB0byBnZXQgdGhvc2UNCj4gPiBpc3N1ZXMgZml4
ZWQgd2l0aCBjb3JyZWN0IHdvcmthcm91bmQgdmFsdWVzIHRvIG1ha2UgcHN0YXRlIGRyaXZlciBj
YW4NCj4gPiBiZSBsb2FkZWQgZXZlbiB0aG91Z2ggdGhlcmUgYXJlIENQUEMgY2FwYWJpbGl0aWVz
IGVycm9ycy4NCj4gPg0KPiA+IFRoZSB3b3JrYXJvdW5kIHdpbGwgbWF0Y2ggdGhlIGJyb2tlbiBC
SU9TIHdoaWNoIGxhY2sgb2YgQ1BQQw0KPiA+IGNhcGFiaWxpdGllcyBub21pbmFsX2ZyZXEgYW5k
IGxvd2VzdF9mcmVxIGRlZmluaXRpb24gaW4gdGhlIEFDUEkgdGFibGUuDQo+ID4NCj4gPiAkIGNh
dCAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2FjcGlfY3BwYy9sb3dlc3RfZnJlcQ0KPiA+
IDANCj4gPiAkIGNhdCAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2FjcGlfY3BwYy9ub21p
bmFsX2ZyZXENCj4gPiAwDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxwZXJy
eS55dWFuQGFtZC5jb20+DQo+IFJldmlld2VkLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8u
bGltb25jaWVsbG9AYW1kLmNvbT4NCg0KVGhhbmsgeW91IGhlbHAgdG8gcmV2aWV3IHRoZSBwYXRj
aHNldC4NCkFzIHRoZSBxdWlyayBpcyBub3Qgb25seSBhZGRlZCBmb3IgQ1BQQyB2MiBzdXBwb3J0
IGJ1dCBhbHNvIHdlIGNhbiB1c2UgaXQgdG8gZml4IG90aGVyIENQUEMgcHJvYmxlbXMsIGl0IG1h
a2VzIHNlbnNlIHRvIGltcGxlbWVudCBpdCBpbiB0aGlzIHNlcmllcy4NCg0KSGkgR2F1dGhhbSwN
ClRoZSBmcmVxdWVuY3kgdGFibGUgc3VwcG9ydCB3aWxsIGJlIGluIG5leHQgaW1wcm92ZW1lbnQg
aXRlbXMgd2UgY2FuIG1ha2UgaWYgaXQgaXMgd29ya2FibGUsICBhcyB0aGUgcXVpY2sgc3VwcG9y
dCBmb3IgZW5kIHVzZXIsIHRoZSBxdWlyayB0YWJsZQ0KSXMgYSBnb29kIHdheSB0byByZWxlYXNl
IGluIHNob3J0IHRlcm0uDQoNClBlcnJ5Lg0KDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2NwdWZy
ZXEvYW1kLXBzdGF0ZS5jIHwgNTcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tDQo+ID4gICBpbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaCAgIHwgIDYgKysrKw0KPiA+ICAg
MiBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBiL2RyaXZl
cnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgaW5kZXggNzdlZmZjM2NhZjZjLi5mZjQ3MjdjMjJkY2Ug
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBAQCAtNjcsNiArNjcsNyBAQCBzdGF0
aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyIGFtZF9wc3RhdGVfZXBwX2RyaXZlcjsNCj4gPiAgIHN0
YXRpYyBpbnQgY3BwY19zdGF0ZSA9IEFNRF9QU1RBVEVfVU5ERUZJTkVEOw0KPiA+ICAgc3RhdGlj
IGJvb2wgY3BwY19lbmFibGVkOw0KPiA+ICAgc3RhdGljIGJvb2wgYW1kX3BzdGF0ZV9wcmVmY29y
ZSA9IHRydWU7DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcXVpcmtfZW50cnkgKnF1aXJrczsNCj4gPg0K
PiA+ICAgLyoNCj4gPiAgICAqIEFNRCBFbmVyZ3kgUHJlZmVyZW5jZSBQZXJmb3JtYW5jZSAoRVBQ
KSBAQCAtMTExLDYgKzExMiw0MSBAQA0KPiA+IHN0YXRpYyB1bnNpZ25lZCBpbnQgZXBwX3ZhbHVl
c1tdID0gew0KPiA+DQo+ID4gICB0eXBlZGVmIGludCAoKmNwcGNfbW9kZV90cmFuc2l0aW9uX2Zu
KShpbnQpOw0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcXVpcmtfZW50cnkgcXVpcmtfYW1kXzdr
NjIgPSB7DQo+ID4gKyAgIC5ub21pbmFsX2ZyZXEgPSAyNjAwLA0KPiA+ICsgICAubG93ZXN0X2Zy
ZXEgPSA1NTAsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IF9faW5pdCBkbWlfbWF0
Y2hlZF83azYyX2Jpb3NfYnVnKGNvbnN0IHN0cnVjdA0KPiA+ICtkbWlfc3lzdGVtX2lkICpkbWkp
IHsNCj4gPiArICAgLyoqDQo+ID4gKyAgICAqIG1hdGNoIHRoZSBicm9rZW4gYmlvcyBmb3IgZmFt
aWx5IDE3aCBwcm9jZXNzb3Igc3VwcG9ydCBDUFBDIFYyDQo+ID4gKyAgICAqIGJyb2tlbiBCSU9T
IGxhY2sgb2Ygbm9taW5hbF9mcmVxIGFuZCBsb3dlc3RfZnJlcSBjYXBhYmlsaXRpZXMNCj4gPiAr
ICAgICogZGVmaW5pdGlvbiBpbiBBQ1BJIHRhYmxlcw0KPiA+ICsgICAgKi8NCj4gPiArICAgaWYg
KGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9aRU4yKSkgew0KPiA+ICsgICAgICAgICAgIHF1aXJr
cyA9IGRtaS0+ZHJpdmVyX2RhdGE7DQo+ID4gKyAgICAgICAgICAgcHJfaW5mbygiT3ZlcnJpZGlu
ZyBub21pbmFsIGFuZCBsb3dlc3QgZnJlcXVlbmNpZXMNCj4gZm9yICVzXG4iLCBkbWktPmlkZW50
KTsNCj4gPiArICAgICAgICAgICByZXR1cm4gMTsNCj4gPiArICAgfQ0KPiA+ICsNCj4gPiArICAg
cmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5
c3RlbV9pZCBhbWRfcHN0YXRlX3F1aXJrc190YWJsZVtdIF9faW5pdGNvbnN0DQo+ID0gew0KPiA+
ICsgICB7DQo+ID4gKyAgICAgICAgICAgLmNhbGxiYWNrID0gZG1pX21hdGNoZWRfN2s2Ml9iaW9z
X2J1ZywNCj4gPiArICAgICAgICAgICAuaWRlbnQgPSAiQU1EIEVQWUMgN0s2MiIsDQo+ID4gKyAg
ICAgICAgICAgLm1hdGNoZXMgPSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBETUlfTUFUQ0go
RE1JX0JJT1NfVkVSU0lPTiwgIjUuMTQiKSwNCj4gPiArICAgICAgICAgICAgICAgICAgIERNSV9N
QVRDSChETUlfQklPU19SRUxFQVNFLCAiMTIvMTIvMjAxOSIpLA0KPiA+ICsgICAgICAgICAgIH0s
DQo+ID4gKyAgICAgICAgICAgLmRyaXZlcl9kYXRhID0gJnF1aXJrX2FtZF83azYyLA0KPiA+ICsg
ICB9LA0KPiA+ICsgICB7fQ0KPiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGRtaSwg
YW1kX3BzdGF0ZV9xdWlya3NfdGFibGUpOw0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbmxpbmUgaW50
IGdldF9tb2RlX2lkeF9mcm9tX3N0cihjb25zdCBjaGFyICpzdHIsIHNpemVfdCBzaXplKQ0KPiA+
ICAgew0KPiA+ICAgICBpbnQgaTsNCj4gPiBAQCAtNjAwLDEzICs2MzYsMTkgQEAgc3RhdGljIHZv
aWQgYW1kX3BzdGF0ZV9hZGp1c3RfcGVyZih1bnNpZ25lZCBpbnQNCj4gY3B1LA0KPiA+ICAgc3Rh
dGljIGludCBhbWRfZ2V0X21pbl9mcmVxKHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkNCj4g
PiAgIHsNCj4gPiAgICAgc3RydWN0IGNwcGNfcGVyZl9jYXBzIGNwcGNfcGVyZjsNCj4gPiArICAg
dTMyIGxvd2VzdF9mcmVxOw0KPiA+DQo+ID4gICAgIGludCByZXQgPSBjcHBjX2dldF9wZXJmX2Nh
cHMoY3B1ZGF0YS0+Y3B1LCAmY3BwY19wZXJmKTsNCj4gPiAgICAgaWYgKHJldCkNCj4gPiAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gKyAgIGlmIChxdWlya3MgJiYgcXVpcmtzLT5s
b3dlc3RfZnJlcSkNCj4gPiArICAgICAgICAgICBsb3dlc3RfZnJlcSA9IHF1aXJrcy0+bG93ZXN0
X2ZyZXE7DQo+ID4gKyAgIGVsc2UNCj4gPiArICAgICAgICAgICBsb3dlc3RfZnJlcSA9IGNwcGNf
cGVyZi5sb3dlc3RfZnJlcTsNCj4gPiArDQo+ID4gICAgIC8qIFN3aXRjaCB0byBraHogKi8NCj4g
PiAtICAgcmV0dXJuIGNwcGNfcGVyZi5sb3dlc3RfZnJlcSAqIDEwMDA7DQo+ID4gKyAgIHJldHVy
biBsb3dlc3RfZnJlcSAqIDEwMDA7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgYW1k
X2dldF9tYXhfZnJlcShzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpIEBAIC02MzUsMTINCj4g
PiArNjc3LDE4IEBAIHN0YXRpYyBpbnQgYW1kX2dldF9tYXhfZnJlcShzdHJ1Y3QgYW1kX2NwdWRh
dGEgKmNwdWRhdGEpDQo+ID4gICBzdGF0aWMgaW50IGFtZF9nZXRfbm9taW5hbF9mcmVxKHN0cnVj
dCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkNCj4gPiAgIHsNCj4gPiAgICAgc3RydWN0IGNwcGNfcGVy
Zl9jYXBzIGNwcGNfcGVyZjsNCj4gPiArICAgdTMyIG5vbWluYWxfZnJlcTsNCj4gPg0KPiA+ICAg
ICBpbnQgcmV0ID0gY3BwY19nZXRfcGVyZl9jYXBzKGNwdWRhdGEtPmNwdSwgJmNwcGNfcGVyZik7
DQo+ID4gICAgIGlmIChyZXQpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+
IC0gICByZXR1cm4gY3BwY19wZXJmLm5vbWluYWxfZnJlcTsNCj4gPiArICAgaWYgKHF1aXJrcyAm
JiBxdWlya3MtPm5vbWluYWxfZnJlcSkNCj4gPiArICAgICAgICAgICBub21pbmFsX2ZyZXEgPSBx
dWlya3MtPm5vbWluYWxfZnJlcTsNCj4gPiArICAgZWxzZQ0KPiA+ICsgICAgICAgICAgIG5vbWlu
YWxfZnJlcSA9IGNwcGNfcGVyZi5ub21pbmFsX2ZyZXE7DQo+ID4gKw0KPiA+ICsgICByZXR1cm4g
bm9taW5hbF9mcmVxOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgaW50IGFtZF9nZXRfbG93
ZXN0X25vbmxpbmVhcl9mcmVxKHN0cnVjdCBhbWRfY3B1ZGF0YQ0KPiA+ICpjcHVkYXRhKSBAQCAt
MTY3Miw2ICsxNzIwLDExIEBAIHN0YXRpYyBpbnQgX19pbml0IGFtZF9wc3RhdGVfaW5pdCh2b2lk
KQ0KPiA+ICAgICBpZiAoY3B1ZnJlcV9nZXRfY3VycmVudF9kcml2ZXIoKSkNCj4gPiAgICAgICAg
ICAgICByZXR1cm4gLUVFWElTVDsNCj4gPg0KPiA+ICsgICBxdWlya3MgPSBOVUxMOw0KPiA+ICsN
Cj4gPiArICAgLyogY2hlY2sgaWYgdGhpcyBtYWNoaW5lIG5lZWQgQ1BQQyBxdWlya3MgKi8NCj4g
PiArICAgZG1pX2NoZWNrX3N5c3RlbShhbWRfcHN0YXRlX3F1aXJrc190YWJsZSk7DQo+ID4gKw0K
PiA+ICAgICBzd2l0Y2ggKGNwcGNfc3RhdGUpIHsNCj4gPiAgICAgY2FzZSBBTURfUFNUQVRFX1VO
REVGSU5FRDoNCj4gPiAgICAgICAgICAgICAvKiBEaXNhYmxlIG9uIHRoZSBmb2xsb3dpbmcgY29u
ZmlncyBieSBkZWZhdWx0Og0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FtZC1wc3Rh
dGUuaCBiL2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oDQo+ID4gaW5kZXggZDIxODM4ODM1YWJk
Li43YjJjYmI4OTJmZDkgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9hbWQtcHN0YXRl
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+IEBAIC0xMjQsNCAr
MTI0LDEwIEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QNCj4gYW1kX3BzdGF0ZV9tb2RlX3N0
cmluZ1tdID0gew0KPiA+ICAgICBbQU1EX1BTVEFURV9HVUlERURdICAgICAgPSAiZ3VpZGVkIiwN
Cj4gPiAgICAgTlVMTCwNCj4gPiAgIH07DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgcXVpcmtfZW50cnkg
ew0KPiA+ICsgICB1MzIgbm9taW5hbF9mcmVxOw0KPiA+ICsgICB1MzIgbG93ZXN0X2ZyZXE7DQo+
ID4gK307DQo+ID4gKw0KPiA+ICAgI2VuZGlmIC8qIF9MSU5VWF9BTURfUFNUQVRFX0ggKi8NCg0K

