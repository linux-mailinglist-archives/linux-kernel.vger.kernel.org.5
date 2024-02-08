Return-Path: <linux-kernel+bounces-57461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37F684D959
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4741F22FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA122D79D;
	Thu,  8 Feb 2024 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AWBG4JuJ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6452C6B0;
	Thu,  8 Feb 2024 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707365951; cv=fail; b=GbZ0Jmf+gQOJIvsdlbo9PwZq26Bu7mTZRfBUbneFJCIx/umWEHBynZBXrs5+QXpiO8Z4K7xO+4zSNAO+4zHByR0nBuAGtbytjvUyd9asen/Bvrl1+5ohrGcMdUBtVJW2ntP7Kz/8vnDswfqRjEeVs1V6y+AP00tyt3VGDumluKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707365951; c=relaxed/simple;
	bh=dsIf32hfAGm/FdtVYurbA8+ojK8OA2rfA68JQk1VYdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IuAMUCK8e71MKvqpjMhmim7vIvTyg9HOCk4JKeDtEbZcjB4ZsFAz5CfgwHR4QtiL5srsNqCVNu2sHgbyni3Quj05XeljRDWfIVSBZ3DIRiANB+ryZ74eZ6pCGUUPMOmrF44T994N/IFJ6oFTVfiHIMTIgmpBWP9rx1sFX5qdeXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AWBG4JuJ; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqxWWZ1qLV9JWb+94dv2zuYFBrvlEXhIRYa3osuvf0vDMCcWYnmEPIsagZJIxu5Un5eTSN56L1tHmnyMrZ7C5arMiJWLYQL55xzeljgDtW5F8N/I8Ukv/z/g6p7FrLhN3pGqrBPV0fQeJMnFOVac7MSobpIo94RuMUZ0kiHRFk6Hu9RpgD/W1siWTF6YsOjMTypJCswxdH+f3rt200NYeQ0HI04hUwTuQFGycLsPJUwVsZRv1DMEwVLR9wM8dcXtWnueUBT7MzxjsAKCEUCr7CFzFYuBg4QfCRu4c0KqGANxNipovCg+BF7SpOzK6Ri3WxdIK7rRDUu1FYmICpI1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsIf32hfAGm/FdtVYurbA8+ojK8OA2rfA68JQk1VYdw=;
 b=Gho2a7bWwUJoSosHhG/VgQK5gE8Url2ul2Nfatnaap24+VwnvPJtVui1usUKbkdPvDP0t7VS69A9jWyHWovbIM7poA+9sQ1NZ1OjaNC+rrIvBDsnab4cGjVPVFHRxJGGy2HP8UQEdvKLpE12aDZkJMDIDjCh4kbUfWPpKl5MWPbFguhuyowbf+bg1T7cnv2DIGU1Zgl35OEHrCoGBEetiueLyrgeo6TAsgKaS0Xr77PMaoDl4YlRKCG+LTtTaQQX1rQIJuada04oENXEQlAPtbg27Um/l29pgYW64bp4PcRM2q2GiWVfEb9zmqQlTkOrG+sxos7y5dz4ag9nxAr6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsIf32hfAGm/FdtVYurbA8+ojK8OA2rfA68JQk1VYdw=;
 b=AWBG4JuJ0RR6ENKmqpyLcCAi6P4JvbeXt1REkiYuiicHM/RLGLFAFj79ZN9a+uVssrIJ/OUvd60W12k8e3/07VD1fMZc6zjdD+iEcTlezfuz7ahWWe5rd9PlqCGYgsb7fjG4Tt06SDHeiM8oJDkaBhSPIv8/uzwI13d0qDRooWI=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 04:19:07 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 04:19:07 +0000
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
Subject: RE: [PATCH v3 1/7] cpufreq: amd-pstate: initialize new core precision
 boost state
Thread-Topic: [PATCH v3 1/7] cpufreq: amd-pstate: initialize new core
 precision boost state
Thread-Index: AQHaWac/ydw8URPdEkmUYNXV3AH7srD+9T0AgADg0mA=
Date: Thu, 8 Feb 2024 04:19:07 +0000
Message-ID:
 <CYYPR12MB865529A69033D2E7655D333A9C442@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1707297581.git.perry.yuan@amd.com>
 <b4d4ced021e608268e87d630de9ed271cf5f3277.1707297581.git.perry.yuan@amd.com>
 <2047184.tdWV9SEqCh@natalenko.name>
In-Reply-To: <2047184.tdWV9SEqCh@natalenko.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3d23c572-001f-4796-a88d-219b18071864;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-08T04:10:00Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DS0PR12MB8814:EE_
x-ms-office365-filtering-correlation-id: 75f0fdad-ad8d-4fde-ec1e-08dc285d178b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ObchzuRt9m22NPDuLqBBPtxGZrWMognBTp0E09Wo9t7UVOMaCphG+ek3Ir8OcMA/ia65JhGR70QH4wG4K5TZbXsuhiBCOgQxgjB4GWcoafIQC+t8I4oCRAXU6gxF6Oh/n1u1BcmjGT3L/Cagj/i2APj8d0Q4n4qO8KahKhFgO8WL5NaB0B25RURQPe2orXCT5sgqXxLCh4+2BKM8ZJm2yNI543KqG9m08v8r9NBwFhhB3pXFpxArz7RvrHMyDx6n28S6VrA6LXpY0EnnMBxR2LvsYelRJVhVRXGv2v5DM4LOuwYszBr7KOBwQi6RMCGUEqP061UQsH8kHK+m23gSoy8caZyGVvRUegkqLHyaGpGWUbX5k3fG8mQAXUKiJTFIO6bS0GKAObKKReAm+fi8+0eAnXh5cj7xjzohBpJJ06hkb3+WUHSaO9tl0biP2OY9s3bcl3+5OLxNaSfAoKaz4k/8DqMN+1MZF/C0jJhtna/nTv5rO8wQf46ttIfSE/4t8hRZ5IEfFt2YAJwG6+WjMSM55NljkxdH9YeUTo3C22SM2MxqW3nINAeWbPMdXtQUF28kCKR13O28dvlk5p+fx/+4YD2Sz2FRvsZ5ZdSiDXeCK7b7DsmhnNATOSZNnfYP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(122000001)(33656002)(26005)(66574015)(83380400001)(478600001)(966005)(7696005)(6506007)(53546011)(9686003)(38070700009)(55016003)(86362001)(66446008)(66556008)(6636002)(66946007)(66476007)(316002)(4326008)(8676002)(54906003)(64756008)(8936002)(110136005)(38100700002)(71200400001)(76116006)(52536014)(41300700001)(2906002)(921011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2JRTWFoSk5Sc096U3BsNXJSWU9XUVowYVBYNkdTQXIrYXlTTHJqTnRCSUh3?=
 =?utf-8?B?WXY3NURTYlZvTFZPRGVRTGxnckR4R3V5Mnc0QnQ3dE1iR2ZYYUIvaGFOVXRN?=
 =?utf-8?B?ekdHcjZYNTFjY1lhRWdmVitmb21iNklvMGU5clhTdFV1ZDk5NjMyaVQwcDFT?=
 =?utf-8?B?OFJ2N1JMeGZhNUZ6bUkxMThXaitMRmNUdEQrRm1qL2VUTmdVOGdiZCtlSTlW?=
 =?utf-8?B?QXMwQWRvR0E4Y3VYV1pKbUNhRnNVRmtzSnF4NlJ3NUpOY3pBWk50TE9EU1dZ?=
 =?utf-8?B?STJKOW1LTVlEc09RT3VGMERQZnVVMndoVnZER2laSTJYNiswaXJ3c1c0MHhw?=
 =?utf-8?B?aHBSd2dJWU1qV0ZFR3NYRHlXVy9FYytZVm9BSlM0a29lSG5kcEJzcjhnR05j?=
 =?utf-8?B?blJ4M3NXY1pFWGtVeXVOSzRXTTJiZTMyN0dYaW1QdnF2VFBvZkpWQkVYSkhX?=
 =?utf-8?B?aElZZlhOWGFwU29CMjgvN1ZWMDhSRXVqaW82M0o5K2F4ckZZTy9walBhZ0JJ?=
 =?utf-8?B?Y2VmVTlUK0lpVnV6OXdtV3k2aTQyYUtRdlJEeTEwVHFEeHdLU3M1VVFLUjd1?=
 =?utf-8?B?WHJybmtRa1dMWlQrbUlDWGcybm1JTHNXREJnU1BkK0sxS2FRbEVXTGNaKzZn?=
 =?utf-8?B?Zlo2TGtUNEw3WVBSZHpXRW9aQVJBcU1IL0tzNzJpTkJnYllYUHdHdG1HaFh1?=
 =?utf-8?B?RHFjc2tkWkFrd3J2c1lPQUdXQkN6NDZmaEtJNi9OcE1kZ0NmdHE4aDdRMTgr?=
 =?utf-8?B?WmpjMDdIVmZRL1dzQVAySmsrTS9sMG13Zk9rOEtRUExISTBFTkNlYzVFaHJl?=
 =?utf-8?B?dk9HK2dicUl3M3lQOTRQOXZtbHNxUXkzUGRWVDcxRlFSSW9mUFF5cEFGalA2?=
 =?utf-8?B?STFOOTFrMFMybDd6ZHM4ZkdUWlIzMExoVXR4RmJ6NnluWmh2ejZweGRxL3JY?=
 =?utf-8?B?czAvRWl2dzM3N1lKOWgwNkErSDlIdFBNQVZDNG0vZDk1WWFJU3p6dG01ZXA2?=
 =?utf-8?B?NEwxQm5Jd0lwNHdZeCtjT2lsVjAycmp0dEtEWUpwdXBXZXNPYVBBR3BKa21I?=
 =?utf-8?B?TXNQT0h0dEgySGQyUjZncnFRRHNpcEtwUStsWVZKRjNvaUQvWHYxWkdRajVj?=
 =?utf-8?B?WGQ0akdaalFFRkFKSWhoYWlSbkc4SzhyemdjUUNQbG9FMWJ5Ri9QQWpTTUQx?=
 =?utf-8?B?cm5TM2RvZk9DeDNmTCtRN2w1K09nQUJPYzNnK0hMK1pJaUVORVJBVUt2UWFs?=
 =?utf-8?B?eXl0cE5Kc3p2SjhVRm40ZjgzYTV0WjZBcVVQaXdNZDVhMGdsdUpWeGJkb2Ev?=
 =?utf-8?B?SHkvKzdpa25TSVlwc1hDZnFld093UVlzSlROSVRYRlNwSTlPQXByNEt3UFg5?=
 =?utf-8?B?YzJQU1p2RGt3K1RheWp6ZUNWVHJWT29uNmNBU1VFeko4UjZCcTMwdkVWcW1K?=
 =?utf-8?B?eTVJOEx1dklZYjlxNGwrdmw4QlAwTXN5N0RacFNVcWRDL2tlZDlZTGJNQlhk?=
 =?utf-8?B?UUJnWW83TUVGb0NuK3ZkSHdESXppU3U2R0VVOTdiejhJQXBsc1J4anVXeW54?=
 =?utf-8?B?Zk5DTGQyTm5EUlN6RERId3RaSDNUZ2J0clhNVzBGVnpFMEZvUXEwOXNZMU90?=
 =?utf-8?B?bFY4OHlGSU5oblJ1NUVtUlAyUjlyRFlMWVJZUWZmYWhlRmVycWV4NnpES1Fw?=
 =?utf-8?B?bmVINHdLUUNwOEtGcWJoSWN3QzN2OW9XT0Q0NnFwcXNvcFdQa01ZUEc5Mks5?=
 =?utf-8?B?aVhOblA0dHhRTzJQWnk1a2xtenpDTWRyc1lvSExxbzJWc3ByVEZxaVpBUTA5?=
 =?utf-8?B?dVBaeXplVTUyZmVpaU81V3hEQWU5Z0JaUUpkZ09zV2cxa1RzNHBScUxNL2JH?=
 =?utf-8?B?Rm1oSmdVMElWYVZ6b21lSzd1YnBoSEN5bldPUG1vYVZkb0RqaDgrd2lXcmF4?=
 =?utf-8?B?R1U3N0dDRDJBMHM4QVFDOFA0a0h2dkZZUllEaHpVR2JRV2NyYU5WamRTVXRr?=
 =?utf-8?B?R1QwTStSUTRFdkdNN0JxSFRWZ0pWMkxCeEpWTGNNd1MvMUxKNXE1QzFYTmxV?=
 =?utf-8?B?NmJxWHRtUzFlclBDVm5KZXA0SWJaVXhoMmFDS0QvWlZIdnh0RGp0WmowcEpZ?=
 =?utf-8?Q?jwxk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f0fdad-ad8d-4fde-ec1e-08dc285d178b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 04:19:07.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mljRcRyeBcipCQ6+3+83s8m3+/+Zduakjvs9dozEywCSgauiYrwocOke8JWx82dwKdW+TSgMxrmvAlX7vb0nXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogT2xla3NhbmRyIE5hdGFsZW5rbyA8b2xla3NhbmRyQG5hdGFsZW5r
by5uYW1lPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcsIDIwMjQgMTA6NDUgUE0NCj4g
VG86IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tOyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1h
cmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcs
IFJheQ0KPiA8UmF5Lkh1YW5nQGFtZC5jb20+OyBTaGVub3ksIEdhdXRoYW0gUmFuamFsDQo+IDxn
YXV0aGFtLnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNsYXYuUGV0
a292QGFtZC5jb20+OyBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFNoaW1t
ZXINCj4gPFNoaW1tZXIuSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlhbiA8WGlhb2ppYW4uRHVA
YW1kLmNvbT47IE1lbmcsDQo+IExpIChKYXNzbWluZSkgPExpLk1lbmdAYW1kLmNvbT47IGxpbnV4
LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzddIGNwdWZyZXE6IGFtZC1wc3RhdGU6IGluaXRpYWxp
emUgbmV3IGNvcmUgcHJlY2lzaW9uDQo+IGJvb3N0IHN0YXRlDQo+DQo+IE9uIHN0xZllZGEgNy4g
w7pub3JhIDIwMjQgMTA6MjE6NTIgQ0VUIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gRnJvbTogUGVy
cnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiA+DQo+ID4gQWRkIGdsb2FsIGdsb2JhbF9w
YXJhbXMgdG8gcmVwcmVzZW50IGN1cnJlbnQgQ1BVIFBlcmZvcm1hbmNlDQo+ID4gQm9vc3QoY3Bi
KSBzdGF0ZSBmb3IgY3B1IGZyZXF1ZW5jeSBzY2FsaW5nLCBib3RoIGFjdGl2ZSBhbmQgcGFzc2l2
ZQ0KPiA+IG1vZGVzIGFsbCBjYW4gc3VwcG9ydCBDUFUgY29yZXMgZnJlcXVlbmN5IGJvb3N0aW5n
IGNvbnRyb2wgd2hpY2ggaXMNCj4gPiBiYXNlZCBvbiB0aGUgQklPUyBzZXR0aW5nLCB3aGlsZSBC
SU9TIHR1cm4gb24gdGhlICJDb3JlIFBlcmZvcm1hbmNlDQo+ID4gQm9vc3QiLCBpdCB3aWxsIGFs
bG93IE9TIGNvbnRyb2wgZWFjaCBjb3JlIGhpZ2hlc3QgcGVyZiBsaW1pdGF0aW9uIGZyb20gT1MN
Cj4gc2lkZS4NCj4gPg0KPiA+IElmIGNvcmUgcGVyZm9ybWFuY2UgYm9vc3QgaXMgZGlzYWJsZWQg
d2hpbGUgYSBjb3JlIGlzIGluIGEgYm9vc3RlZA0KPiA+IFAtc3RhdGUsIHRoZSBjb3JlIHRyYW5z
aXRpb25zIHRvIHRoZSBoaWdoZXN0IHBlcmZvcm1hbmNlIG5vbi1ib29zdGVkDQo+ID4gUC1zdGF0
ZSwgdGhhdCBpcyB0aGUgc2FtZSBhcyB0aGUgbm9taW5hbCBmcmVxdWVuY3kgbGltaXQuDQo+ID4N
Cj4gPiBSZXBvcnRlZC1ieTogQXJ0ZW0gUy4gVGFzaGtpbm92IiA8YXJvc0BnbXguY29tPg0KPiA+
IENsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc5
MzENCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA0OSArKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgaW5jbHVkZS9saW51eC9hbWQtcHN0YXRl
LmggICB8IDE0ICsrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9u
cygrKSwgMzMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVm
cmVxL2FtZC1wc3RhdGUuYw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRl
eCAwOGUxMTI0NDRjMjcuLjM3NzJmNzFmNTI1ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nw
dWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUu
Yw0KPiA+IEBAIC02Nyw2ICs2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgYW1k
X3BzdGF0ZV9lcHBfZHJpdmVyOw0KPiA+IHN0YXRpYyBpbnQgY3BwY19zdGF0ZSA9IEFNRF9QU1RB
VEVfVU5ERUZJTkVEOyAgc3RhdGljIGJvb2wNCj4gPiBjcHBjX2VuYWJsZWQ7ICBzdGF0aWMgYm9v
bCBhbWRfcHN0YXRlX3ByZWZjb3JlID0gdHJ1ZTsNCj4gPiArc3RydWN0IGdsb2JhbF9wYXJhbXMg
Z2xvYmFsOw0KPg0KPiBEb2Vzbid0IHRoaXMgcmVxdWlyZSBgRVhQT1JUX1NZTUJPTF9HUEwoZ2xv
YmFsKWAgdGhlbj8gT3RoZXJ3aXNlIHdpdGgNCj4gdjYuOCBJIGdldCB0aGlzOg0KPg0KDQpXaWxs
IGNoZWNrIHRoaXMgd2l0aCB2Ni44IGFzIHdlbGwuDQoNCj4gYGBgDQo+IEVSUk9SOiBtb2Rwb3N0
OiAiZ2xvYmFsIiBbZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUtdXQua29dIHVuZGVmaW5lZCEN
Cj4gYGBgDQo+DQo+IElmIHNvLCBJJ2QgcHJldHR5IG11c2ggcmVuYW1lIHRoaXMgdG8gYmUgbGVz
cyBnZW5lcmljLCBzYXksDQo+IGBhbWRfcHN0YXRlX2dsb2JhbF9wYXJhbXNfc3RydWN0YCBmb3Ig
dGhlIHN0cnVjdCBuYW1lIGl0c2VsZiBhbmQNCj4gYGFtZF9wc3RhdGVfZ2xvYmFsX3BhcmFtc2Ag
Zm9yIHRoZSBhY3R1YWwgdmFyaWFibGUgbmFtZS4NCg0KTGV0IG1lIG9wdGltaXplIGFuZCByZW5h
bWUgdGhlIHN0cnVjdCBkZWZpbml0aW9uIGFuZCB2YXIgbmFtZS4NCg0KVGhhbmtzIGZvciB0aGUg
ZmVlZGJhY2suDQpQZXJyeS4NCg0KPg0KPiA+DQo+ID4gIC8qDQo+ID4gICAqIEFNRCBFbmVyZ3kg
UHJlZmVyZW5jZSBQZXJmb3JtYW5jZSAoRVBQKSBAQCAtNjY5LDQzICs2NzAsMjEgQEANCj4gPiBz
dGF0aWMgaW50IGFtZF9nZXRfbG93ZXN0X25vbmxpbmVhcl9mcmVxKHN0cnVjdCBhbWRfY3B1ZGF0
YSAqY3B1ZGF0YSkNCj4gPiAgICAgcmV0dXJuIGxvd2VzdF9ub25saW5lYXJfZnJlcSAqIDEwMDA7
ICB9DQo+ID4NCj4gPiAtc3RhdGljIGludCBhbWRfcHN0YXRlX3NldF9ib29zdChzdHJ1Y3QgY3B1
ZnJlcV9wb2xpY3kgKnBvbGljeSwgaW50DQo+ID4gc3RhdGUpDQo+ID4gK3N0YXRpYyBpbnQgYW1k
X3BzdGF0ZV9ib29zdF9pbml0KHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkNCj4gPiAgew0K
PiA+IC0gICBzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEgPSBwb2xpY3ktPmRyaXZlcl9kYXRh
Ow0KPiA+ICsgICB1NjQgYm9vc3RfdmFsOw0KPiA+ICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gLSAg
IGlmICghY3B1ZGF0YS0+Ym9vc3Rfc3VwcG9ydGVkKSB7DQo+ID4gLSAgICAgICAgICAgcHJfZXJy
KCJCb29zdCBtb2RlIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhpcyBwcm9jZXNzb3Igb3INCj4gU0JJ
T1NcbiIpOw0KPiA+IC0gICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IC0gICB9DQo+ID4g
LQ0KPiA+IC0gICBpZiAoc3RhdGUpDQo+ID4gLSAgICAgICAgICAgcG9saWN5LT5jcHVpbmZvLm1h
eF9mcmVxID0gY3B1ZGF0YS0+bWF4X2ZyZXE7DQo+ID4gLSAgIGVsc2UNCj4gPiAtICAgICAgICAg
ICBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXEgPSBjcHVkYXRhLT5ub21pbmFsX2ZyZXE7DQo+ID4g
LQ0KPiA+IC0gICBwb2xpY3ktPm1heCA9IHBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcTsNCj4gPiAt
DQo+ID4gLSAgIHJldCA9IGZyZXFfcW9zX3VwZGF0ZV9yZXF1ZXN0KCZjcHVkYXRhLT5yZXFbMV0s
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBvbGljeS0+Y3B1aW5mby5t
YXhfZnJlcSk7DQo+ID4gLSAgIGlmIChyZXQgPCAwKQ0KPiA+ICsgICByZXQgPSByZG1zcmxfb25f
Y3B1KGNwdWRhdGEtPmNwdSwgTVNSX0s3X0hXQ1IsICZib29zdF92YWwpOw0KPiA+ICsgICBpZiAo
cmV0KSB7DQo+ID4gKyAgICAgICAgICAgcHJfZXJyX29uY2UoImZhaWxlZCB0byByZWFkIGluaXRp
YWwgQ1BVIGJvb3N0IHN0YXRlIVxuIik7DQo+ID4gICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
PiArICAgfQ0KPiA+DQo+ID4gLSAgIHJldHVybiAwOw0KPiA+IC19DQo+ID4gLQ0KPiA+IC1zdGF0
aWMgdm9pZCBhbWRfcHN0YXRlX2Jvb3N0X2luaXQoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRh
KSAtew0KPiA+IC0gICB1MzIgaGlnaGVzdF9wZXJmLCBub21pbmFsX3BlcmY7DQo+ID4gLQ0KPiA+
IC0gICBoaWdoZXN0X3BlcmYgPSBSRUFEX09OQ0UoY3B1ZGF0YS0+aGlnaGVzdF9wZXJmKTsNCj4g
PiAtICAgbm9taW5hbF9wZXJmID0gUkVBRF9PTkNFKGNwdWRhdGEtPm5vbWluYWxfcGVyZik7DQo+
ID4gLQ0KPiA+IC0gICBpZiAoaGlnaGVzdF9wZXJmIDw9IG5vbWluYWxfcGVyZikNCj4gPiAtICAg
ICAgICAgICByZXR1cm47DQo+ID4gKyAgIGdsb2JhbC5jcGJfc3VwcG9ydGVkID0gISgoYm9vc3Rf
dmFsID4+IDI1KSAmIDB4MSk7DQo+ID4gKyAgIGdsb2JhbC5jcGJfYm9vc3QgPSBnbG9iYWwuY3Bi
X3N1cHBvcnRlZDsNCj4gPg0KPiA+IC0gICBjcHVkYXRhLT5ib29zdF9zdXBwb3J0ZWQgPSB0cnVl
Ow0KPiA+IC0gICBjdXJyZW50X3BzdGF0ZV9kcml2ZXItPmJvb3N0X2VuYWJsZWQgPSB0cnVlOw0K
PiA+ICsgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgYW1kX3Bl
cmZfY3RsX3Jlc2V0KHVuc2lnbmVkIGludCBjcHUpIEBAIC04NDgsNiArODI3LDkgQEANCj4gPiBz
dGF0aWMgaW50IGFtZF9wc3RhdGVfY3B1X2luaXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xp
Y3kpDQo+ID4gICAgIGlmIChyZXQpDQo+ID4gICAgICAgICAgICAgZ290byBmcmVlX2NwdWRhdGEx
Ow0KPiA+DQo+ID4gKyAgIC8qIGluaXRpYWxpemUgY3B1IGNvcmVzIGJvb3Qgc3RhdGUgKi8NCj4g
PiArICAgYW1kX3BzdGF0ZV9ib29zdF9pbml0KGNwdWRhdGEpOw0KPiA+ICsNCj4gPiAgICAgbWlu
X2ZyZXEgPSBhbWRfZ2V0X21pbl9mcmVxKGNwdWRhdGEpOw0KPiA+ICAgICBtYXhfZnJlcSA9IGFt
ZF9nZXRfbWF4X2ZyZXEoY3B1ZGF0YSk7DQo+ID4gICAgIG5vbWluYWxfZnJlcSA9IGFtZF9nZXRf
bm9taW5hbF9mcmVxKGNwdWRhdGEpOyBAQCAtODk5LDcgKzg4MSw2DQo+IEBADQo+ID4gc3RhdGlj
IGludCBhbWRfcHN0YXRlX2NwdV9pbml0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0K
PiA+DQo+ID4gICAgIHBvbGljeS0+ZHJpdmVyX2RhdGEgPSBjcHVkYXRhOw0KPiA+DQo+ID4gLSAg
IGFtZF9wc3RhdGVfYm9vc3RfaW5pdChjcHVkYXRhKTsNCj4gPiAgICAgaWYgKCFjdXJyZW50X3Bz
dGF0ZV9kcml2ZXItPmFkanVzdF9wZXJmKQ0KPiA+ICAgICAgICAgICAgIGN1cnJlbnRfcHN0YXRl
X2RyaXZlci0+YWRqdXN0X3BlcmYgPQ0KPiBhbWRfcHN0YXRlX2FkanVzdF9wZXJmOw0KPiA+DQo+
ID4gQEAgLTEzMTAsNiArMTI5MSw5IEBAIHN0YXRpYyBpbnQgYW1kX3BzdGF0ZV9lcHBfY3B1X2lu
aXQoc3RydWN0DQo+IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpDQo+ID4gICAgIGlmIChyZXQpDQo+
ID4gICAgICAgICAgICAgZ290byBmcmVlX2NwdWRhdGExOw0KPiA+DQo+ID4gKyAgIC8qIGluaXRp
YWxpemUgY3B1IGNvcmVzIGJvb3Qgc3RhdGUgKi8NCj4gPiArICAgYW1kX3BzdGF0ZV9ib29zdF9p
bml0KGNwdWRhdGEpOw0KPiA+ICsNCj4gPiAgICAgbWluX2ZyZXEgPSBhbWRfZ2V0X21pbl9mcmVx
KGNwdWRhdGEpOw0KPiA+ICAgICBtYXhfZnJlcSA9IGFtZF9nZXRfbWF4X2ZyZXEoY3B1ZGF0YSk7
DQo+ID4gICAgIG5vbWluYWxfZnJlcSA9IGFtZF9nZXRfbm9taW5hbF9mcmVxKGNwdWRhdGEpOyBA
QCAtMTM2MCw3DQo+ICsxMzQ0LDYgQEANCj4gPiBzdGF0aWMgaW50IGFtZF9wc3RhdGVfZXBwX2Nw
dV9pbml0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gPiAgICAgICAgICAgICBXUklURV9PTkNFKGNwdWRhdGEtPmNw
cGNfY2FwMV9jYWNoZWQsIHZhbHVlKTsNCj4gPiAgICAgfQ0KPiA+IC0gICBhbWRfcHN0YXRlX2Jv
b3N0X2luaXQoY3B1ZGF0YSk7DQo+ID4NCj4gPiAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9hbWQtcHN0YXRlLmggYi9pbmNsdWRlL2xpbnV4L2FtZC1w
c3RhdGUuaA0KPiA+IGluZGV4IGQyMTgzODgzNWFiZC4uNDY1ZTkyOTVhNjBjIDEwMDY0NA0KPiA+
IC0tLSBhL2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51
eC9hbWQtcHN0YXRlLmgNCj4gPiBAQCAtMTI0LDQgKzEyNCwxOCBAQCBzdGF0aWMgY29uc3QgY2hh
ciAqIGNvbnN0DQo+IGFtZF9wc3RhdGVfbW9kZV9zdHJpbmdbXSA9IHsNCj4gPiAgICAgW0FNRF9Q
U1RBVEVfR1VJREVEXSAgICAgID0gImd1aWRlZCIsDQo+ID4gICAgIE5VTEwsDQo+ID4gIH07DQo+
ID4gKw0KPiA+ICsvKioNCj4gPiArICogc3RydWN0IGdsb2JhbF9wYXJhbXMgLSBHbG9iYWwgcGFy
YW1ldGVycywgbW9zdGx5IHR1bmFibGUgdmlhIHN5c2ZzLg0KPiA+ICsgKiBAY3BiX2Jvb3N0OiAg
ICAgICAgICAgICBXaGV0aGVyIG9yIG5vdCB0byB1c2UgYm9vc3QgQ1BVIFAtc3RhdGVzLg0KPiA+
ICsgKiBAY3BiX3N1cHBvcnRlZDogV2hldGhlciBvciBub3QgQ1BVIGJvb3N0IFAtc3RhdGVzIGFy
ZQ0KPiBhdmFpbGFibGUNCj4gPiArICogICAgICAgICAgICAgICAgIGJhc2VkIG9uIHRoZSBNU1Jf
SzdfSFdDUiBiaXRbMjVdIHN0YXRlDQo+ID4gKyAqLw0KPiA+ICtzdHJ1Y3QgZ2xvYmFsX3BhcmFt
cyB7DQo+ID4gKyAgIGJvb2wgY3BiX2Jvb3N0Ow0KPiA+ICsgICBib29sIGNwYl9zdXBwb3J0ZWQ7
DQo+ID4gK307DQo+ID4gKw0KPiA+ICtleHRlcm4gc3RydWN0IGdsb2JhbF9wYXJhbXMgZ2xvYmFs
Ow0KPiA+ICsNCj4gPiAgI2VuZGlmIC8qIF9MSU5VWF9BTURfUFNUQVRFX0ggKi8NCj4gPg0KPg0K
Pg0KPiAtLQ0KPiBPbGVrc2FuZHIgTmF0YWxlbmtvIChwb3N0LWZhY3R1bSkNCg==

