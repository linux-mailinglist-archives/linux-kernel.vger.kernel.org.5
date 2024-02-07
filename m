Return-Path: <linux-kernel+bounces-56059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB96784C57D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7110B288576
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439C71F606;
	Wed,  7 Feb 2024 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LkFdiVcY"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3011D551;
	Wed,  7 Feb 2024 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290035; cv=fail; b=tR9a50ir5HMUg7zd3yjw8dHjY3knf8baO18T4M2ftWUlWr09FUrm66VVtmljHGezf8sQ4oxhXaSWG+a85ofFJPuMhGsjf+hTJHIn7jcNojw3Qeh7L/SUUZLlbYO7Qid1W/z3B1EmAxKCZ7CagpI5GxU5OnK18ZKzcfrfwFOtFGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290035; c=relaxed/simple;
	bh=caDonI1DlIdY9xHChhGWMveibKjpAklqS6tlKaAR19Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2aNLdQyRYXvmlm/UNmDpUgU44AMEduULZCg8UB0xNxve4kaKUVtS/QuwSEemDPI64ug725lfuXwyMfu88LQQBQlPovAE3fSb4Lg32ruQJr9hAGs6vpq2BOEQ2PcRtkldMWGqOAo/1HsD6JnTxcujD15KhKDvINKsbIGnt744T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LkFdiVcY; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWZHLwZ3ByWK9D0pU7JWnW4S34KxOyggQ7kjyISDejr4JrxqhDa0/cvmlgciAzktspE7snyHJn8M0MRBoLUOOizD9rxgZTlw7OpEljV4maqTz+i40LULKE+VUWJpktKqj7D5ezXgrYTw83N5yw/WJcTWqyWIGVQtlGqp+RkZlwZaFRSDgKISwKBKfVNy5S/6Qe0+A1r65PmNR9JQfLhyniaeBzzk/Ey28GyzZo0tLYv+QTvpJrspVFd/vsevkiuTznHrlilJeF388yF1lga30XtM7KXyXb3OvlbBnBY7voGew8dYOIiTFMlTwtxMz1Uhbjs8N44QvSM8ge8U5a/gNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caDonI1DlIdY9xHChhGWMveibKjpAklqS6tlKaAR19Q=;
 b=cgVBPa9fVzH0Yh8odTgXeeOUsqWIuZe8ASz6I0aFArFbiSUkj8AKR06xq2zHKJrBfBcPebVSGf5YUXG7oksSg5gMDFPdZtWpKff2pm9yalJNOZSJf3jRbsbJDVr7blFwosRxkLffLq5hS67QGPpvav/nCNrFGQpWQSqcraAho1qUGEgrKdM/Kr3r2mdVTYs5fazjf8OfKYXp1gsGZKV1tK4p2IOYOA7hzokqCxOiIg0l42/mZIRF/MnWZxC4ZFoFmCPTQgxZJlHU/Ew0jbXJVEef5YD+uVWuLA+2yVLQQyAAyLnZorDjFCyI3IHCxG838vM92kiAu+iWoSrM1Drj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caDonI1DlIdY9xHChhGWMveibKjpAklqS6tlKaAR19Q=;
 b=LkFdiVcY6L0wIeFoRRzw1RSF6TE+pdt+JeMU6zotZY+L5S9OIl7vWWj6q8+/v7K1s/OpOHTSDz8DEMl+xps3hYaRtKQuhenca/BzZEZRRbCuifm0NwnLSIlTJMQB4PdCAv9kqWeNubYLhsPChZkXAcTDst2ov1eeBrVRv5X7T6Q=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 07:13:50 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 07:13:50 +0000
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
Subject: RE: [PATCH v4 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Topic: [PATCH v4 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Index: AQHaWLYiGrUayShRCkqOAOV0lIk/pbD9da6AgAEArFA=
Date: Wed, 7 Feb 2024 07:13:50 +0000
Message-ID:
 <CYYPR12MB86558DBAAEB1E514D7F80A7F9C452@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1707193566.git.perry.yuan@amd.com>
 <4626a4aff50921be3b7a0345ae51e5aa246504d0.1707193566.git.perry.yuan@amd.com>
 <80c4a2fd-d24b-468c-9aae-1a4ef509babc@amd.com>
In-Reply-To: <80c4a2fd-d24b-468c-9aae-1a4ef509babc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f890cd21-a928-48b1-81d2-d7cfc2bb709a;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T07:04:26Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA1PR12MB8468:EE_
x-ms-office365-filtering-correlation-id: 38fe1c39-7e46-4295-8f02-08dc27ac55b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0d84NPRCjPYhcmJwYkfpmAHD8ke6w1ZKJGhpf6bCSzOxyyD2Hpp4PTo/VRsWiczOWP4ZsT+qmqaey8aeLRr8p8SD97iaHf6g/Uz3B2bw3Eu9Fympz8zfMjsVXD3wEnqEAZcw4wGDlqb69tLKZ+gVga0HXpobknr00v7yCVkTGwNagoLxprx1uZLmT8PIY0a9R/LMLdA11evDq1MPxBlGanDST4+G66R7vguKf2QJP0Ay4LomOeWpBeUJVlYG8XrmIOIXujLaLIPlubh3Jz4G6H5Yyy6kOZGhgzjx/fStQXhdmNiedGCm4DWQLkBcEVrcCb/acqjnMl5GHr/UJFZ7zrGZR/SWrooC2sVkOnTnIAFKBnOP9aj0JxiS+FCS9bZukfE751DDNbqIdMtVEMjrnauQFPdboFQHa06Ap4z/E00N5k0GJ6/easu8aL5NjPflAAMZY9+MLE2So/US/c3QQLxn31bZ0WFNMObePvJPix/tOrqpHEPVC6Y7WqzlnlWYro1oG8YjRLvdfzkav2M2tixzHWq7hqyXmJiub4MXgqfJmzBlgra68zMnN1OssiMdhdsw6YRoyhv6sb4Nq9l9a/x0izgDbN0SEw/LMLzj3jqZ2+Xua+1f3vKl0tGQAvfDBd+64BwnVpJWnzArsrcmFQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(122000001)(9686003)(921011)(26005)(33656002)(55016003)(38100700002)(5660300002)(478600001)(2906002)(4326008)(53546011)(7696005)(86362001)(83380400001)(71200400001)(6506007)(76116006)(8676002)(316002)(66476007)(41300700001)(66946007)(66556008)(54906003)(8936002)(6636002)(52536014)(38070700009)(64756008)(66446008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVlVRFJwWEJNcU91MmNDOGR1cHVHRVNYZzhMN1IxZjRpdFp4NzFYMkQzYW1F?=
 =?utf-8?B?RG8vVWsweUp2akJPZk9WQ3RNRlFEcFd3NnBya05rdlB0YTE3S1VHeDg0d1Ur?=
 =?utf-8?B?c2hWRFBiTHpZbUpJWUNnKzhzaGZmTkNmK2pCUm9SL3k3UDd4aEtqT3FEYW83?=
 =?utf-8?B?c2pGSHhSZWRIclA5NkY3TnFvbjZxZmtWdFNWbDdDZlRwQW9yTURSeTBWcGxV?=
 =?utf-8?B?b1FXVjhMYlJBSFdxdFlKSVhUcG9SWlN3TkVuMXg2M25FdVBBdXZxa28yYUFC?=
 =?utf-8?B?VitEZDN4WTJBbEZ6L2dtWmpQWnBkbXVxWG83U2JSZnZUQS9PWThZRm5Pelgx?=
 =?utf-8?B?OVM3NVpGWFhVV2xLdGRJNklqcXVmSzYzbW9QcDdwTGZHZkVMYWx2UFI5a3F2?=
 =?utf-8?B?aDRPdTBFc0ZjMElsNU5HaHIvR3pjeXpjanFMdHUzbTZmQzJHbEt1V3RYYzN5?=
 =?utf-8?B?c1VBU2laNnBuNS9KQkZRdDhvb0hLS1dzcnVFRENOUWdycnZRZGdvWU9IY3JG?=
 =?utf-8?B?UFlIamllbGRKVWxUUG1MWHRmTzlOMlBRbUVYVHB5Sm1RQXNxREQxUTc2a3I2?=
 =?utf-8?B?NGo2M0J4WUszREJQNTJnT1R4c0tnMzM0dVN3ZG1DNVV5ODB4dG9OdzFLZ0ph?=
 =?utf-8?B?anlNV3FZZHFCMUZxSlprNXdLWDgzaW5XaGNOcnhDNnRwdGpNWGk1Y3YxdkIy?=
 =?utf-8?B?eW1TM1kyeEtoOGFsTjlJUmdtQzlSbi9pTmw0OUhxNXpCK2tsZmhpUlVhenBV?=
 =?utf-8?B?ZFZsM2p6bWdjTmZ2Tk4yTlpBWDdvb0Z4cGVwVHZtZWE4cnhzRktnRWFuVUU4?=
 =?utf-8?B?M1RIUnNZd2RJQmN2TkdHMTZiYWt2OGNMU3VPV0ZtcU5VdElkSmxFdTNEUkZq?=
 =?utf-8?B?dUN2K3o5SUphUDJvTm1WWUhhZ2h6bHMyWTZ4djRDeHd0UWwxMkFyMldMeEdL?=
 =?utf-8?B?ajNDYk84OXZ6N3RKQVl4RFh0VGlaTDN4aEJCUFJyQ0V1TS9NSzE3TEtSbXE5?=
 =?utf-8?B?cVVQSjN2TmpuR25COWlVUENVN2pHZVdUZkdjTHBEOEx3cENxYU5Oelc4SU1l?=
 =?utf-8?B?c2lPb0QxRnRpRkt6TXZvbW1xWk0zTUVpY1I1MXFSbUhLbmFZSm5oLzAvYmdW?=
 =?utf-8?B?YWxuMEhwNCs2N25zVzMyZEdvVFYwb2dXUkJOUFkva0ljenNNYVdxMktVeUMw?=
 =?utf-8?B?YzRUOEYvSU5IR1lBc1kzODF4MjI4OVFtSk82RkZKSHZUek5DMTFCYXdRYVF6?=
 =?utf-8?B?N3ZITm1CN01jNnNqWVdpdW1sV1A4TlhtcENmT2Z5c2E3OTdoZTZRTGZhVGRy?=
 =?utf-8?B?ektDSUVDNnhEbVhZWDh3MUE1d1ZERXZWdHB3YXVHd2NsendRdDZuTFlPRWx4?=
 =?utf-8?B?enZjUkJuUXgvaHZhTU5UQTRmbk9YTEQ2bDNMdkxUT21kUVRyZVNVbk1KeFE2?=
 =?utf-8?B?WGwwbHFLK2NtTCttaURZa3Y2YTgraUVqWWlkbVBudFR3d3VpMFNSKzZaWEk4?=
 =?utf-8?B?WmwrcVUwZHBpbEswUW9ESEtCYjhGMjZNbjFFNHdReCtkdjdjTk5VTVd2a1hD?=
 =?utf-8?B?VHBhTHdKYzErQjFzL2xFRHJXY2lOczI3RCtpdGd5Q0MrSk5BRHlQajNsWkhU?=
 =?utf-8?B?VTRxTE8yLzhQNlQzbXNlMkRJdk0yRmJZTHBVZy9kcm9FWXl2c0RFNkd4bmp5?=
 =?utf-8?B?MmZBUUZ2Vzh2Z29hQldEYVBrN2tKRWpIQTZMbUhMOVBSUkZIcjU4WFpybkhB?=
 =?utf-8?B?eWM0WHNqMitKZ3d4bkZxdzd0emd3d3ZYOVp5VGpLanBvSllEa0lBMlFBMis1?=
 =?utf-8?B?eWdCN01QRkt5czZGU2hOV2J1TXE2WGpZcm9ZaGtlNHNFem0zdmdJMi9tWENo?=
 =?utf-8?B?aDdYYXpnZ3p5am02M3I0Q3RPalJqR1ZaV2MwVjZrZSsyRTdDMmRJU2VQTHpo?=
 =?utf-8?B?eVVRVE90UUVhMjhndlVsZThvYkNWc01PbC9FNkF3WFFSZWV1akRQaFpuQU14?=
 =?utf-8?B?VWZzQnY3RFBZWTBDOXppSjVVREtHMU8yb01nM1NmbEs3VUd4bFBSdUx0TnJD?=
 =?utf-8?B?dlJGaWFSSTBlSGpvNUNIMmRLOTRlM2I0cVF5bmVmVGJwSW90Mm9wRlhnbjd1?=
 =?utf-8?Q?lLNk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fe1c39-7e46-4295-8f02-08dc27ac55b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 07:13:50.5696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoasXWzSxXrIW/yjjeyiHV1biYpHjfIzkz8GRlxYr5U19gNln9qEeSX2Ea2vTiO3n6qKxsRT/rXI97F9VWsxxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgNiwgMjAyNCAx
MTo0NiBQTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOw0KPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJh
eSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBTaGVub3ksDQo+IEdhdXRoYW0gUmFuamFsIDxnYXV0aGFt
LnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNsYXYuUGV0a292QGFt
ZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9q
aWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVu
Z0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDYvNl0gY3B1ZnJlcTphbWQt
cHN0YXRlOiBhZGQgcXVpcmsgZm9yIHRoZSBwc3RhdGUNCj4gQ1BQQyBjYXBhYmlsaXRpZXMgbWlz
c2luZw0KPg0KPiBPbiAyLzUvMjAyNCAyMjozMywgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBBZGQg
cXVpcmtzIHRhYmxlIHRvIGdldCBDUFBDIGNhcGFiaWxpdGllcyBpc3N1ZSBmaXhlZCBieSBwcm92
aWRpbmcNCj4gPiBjb3JyZWN0IHBlcmYgb3IgZnJlcXVlbmN5IHZhbHVlcyB3aGlsZSBkcml2ZXIg
bG9hZGluZy4NCj4gPg0KPiA+IElmIENQUEMgY2FwYWJpbGl0aWVzIGFyZSBub3QgZGVmaW5lZCBp
biB0aGUgQUNQSSB0YWJsZXMgb3Igd3JvbmdseQ0KPiA+IGRlZmluZWQgYnkgcGxhdGZvcm0gZmly
bXdhcmUsIGl0IG5lZWRzIHRvIHVzZSBxdWljayB0byBnZXQgdGhvc2UNCj4gcyxxdWljayxhIHF1
aXJrLA0KPiA+IGlzc3VlcyBmaXhlZCB3aXRoIGNvcnJlY3Qgd29ya2Fyb3VuZCB2YWx1ZXMgdG8g
bWFrZSBwc3RhdGUgZHJpdmVyIGNhbg0KPiA+IGJlIGxvYWRlZCBldmVuIHRob3VnaCB0aGVyZSBh
cmUgQ1BQQyBjYXBhYmlsaXRpZXMgZXJyb3JzLg0KPiA+DQo+ID4gVGhlIHdvcmthcm91bmQgd2ls
bCBtYXRjaCB0aGUgYnJva2VuIEJJT1Mgd2hpY2ggbGFjayBvZiBDUFBDDQo+ID4gY2FwYWJpbGl0
aWVzIG5vbWluYWxfZnJlcSBhbmQgbG93ZXN0X2ZyZXEgZGVmaW5pdGlvbiBpbiB0aGUgQUNQSSB0
YWJsZS4NCj4gPg0KPiA+ICQgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvYWNwaV9j
cHBjL2xvd2VzdF9mcmVxDQo+ID4gMA0KPiA+ICQgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1
L2NwdTAvYWNwaV9jcHBjL25vbWluYWxfZnJlcQ0KPiA+IDANCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA1OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0NCj4gPiAgIGluY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oICAgfCAgNiArKysr
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+
IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRleCA3N2VmZmMzY2FmNmMuLjg3NGQ4
YjY2Mzc5MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+
ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IEBAIC02Nyw2ICs2Nyw3
IEBAIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgYW1kX3BzdGF0ZV9lcHBfZHJpdmVyOw0K
PiA+ICAgc3RhdGljIGludCBjcHBjX3N0YXRlID0gQU1EX1BTVEFURV9VTkRFRklORUQ7DQo+ID4g
ICBzdGF0aWMgYm9vbCBjcHBjX2VuYWJsZWQ7DQo+ID4gICBzdGF0aWMgYm9vbCBhbWRfcHN0YXRl
X3ByZWZjb3JlID0gdHJ1ZTsNCj4gPiArc3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSAqcXVpcmtz
Ow0KPiA+DQo+ID4gICAvKg0KPiA+ICAgICogQU1EIEVuZXJneSBQcmVmZXJlbmNlIFBlcmZvcm1h
bmNlIChFUFApIEBAIC0xMTEsNiArMTEyLDQzIEBADQo+ID4gc3RhdGljIHVuc2lnbmVkIGludCBl
cHBfdmFsdWVzW10gPSB7DQo+ID4NCj4gPiAgIHR5cGVkZWYgaW50ICgqY3BwY19tb2RlX3RyYW5z
aXRpb25fZm4pKGludCk7DQo+ID4NCj4gPiArc3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSBxdWly
a19hbWRfN2s2MiA9IHsNCj4gPiArICAgLm5vbWluYWxfZnJlcSA9IDI2MDAsDQo+ID4gKyAgIC5s
b3dlc3RfZnJlcSA9IDU1MCwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgX19pbml0
IGRtaV9tYXRjaGVkXzdrNjJfYmlvc19idWcoY29uc3Qgc3RydWN0DQo+ID4gK2RtaV9zeXN0ZW1f
aWQgKmRtaSkgew0KPiA+ICsgICAvKioNCj4gPiArICAgICogbWF0Y2ggdGhlIGJyb2tlbiBiaW9z
IGZvciBmYW1pbHkgMTdoLCBtb2RlbCAzMWggcHJvY2Vzc29yDQo+ID4gKyAgICAqIGJyb2tlbiBC
SU9TIGxhY2sgb2Ygbm9taW5hbF9mcmVxIGFuZCBsb3dlc3RfZnJlcSBjYXBhYmlsaXRpZXMNCj4g
PiArICAgICogZGVmaW5pdGlvbiBpbiBBQ1BJIHRhYmxlcw0KPiA+ICsgICAgKi8NCj4gPiArICAg
aWYgKGJvb3RfY3B1X2RhdGEueDg2ID09IDB4MTcgJiYgYm9vdF9jcHVfZGF0YS54ODZfbW9kZWwg
PT0NCj4gMHgzMSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgYm9vdF9jcHVfaGFzKFg4Nl9G
RUFUVVJFX1pFTjIpKSB7DQo+DQo+IEkgdGhpbmsgeW91IHNob3VsZCB1c2Ugb25lIG9yIHRoZSBv
dGhlciAoMTcvMzEpIG9yIChYODZfRkVBVFVSRV9aRU4yKS4NCg0KTG9va3MgbGlrZSBpdCBtYWtl
cyBzZW5zZSB0byBtYXRjaCBaRU4yIGZsYWcgYW5kIHNwZWNpZmljIEJJT1MgdmVyc2lvbi4gIFRo
YXQgd2lsbCBjb3ZlciB0aGUgYnJva2VuIEJJT1MgYW5kIENQVS4NCg0KDQo+DQo+ID4gKyAgICAg
ICAgICAgcXVpcmtzID0gZG1pLT5kcml2ZXJfZGF0YTsNCj4gPiArICAgICAgICAgICBwcl9pbmZv
KCJoYXJkd2FyZSB0eXBlICVzIGZvdW5kXG4iLCBkbWktPmlkZW50KTsNCj4NCj4gSSB0aGluayBh
IGJldHRlciBtZXNzYWdlIGV4cGxhaW5zIHdoYXQgaXMgaGFwcGVuaW5nLiAgRm9yIGV4YW1wbGU6
DQo+ICJPdmVycmlkaW5nIG5vbWluYWwgYW5kIGxvd2VzdCBmcmVxdWVuY2llcyBmb3IgJXNcbiIN
Cg0KTWFkZSBzdWdnZXN0aW9ucyB0byB2NS4NCg0KPg0KPiA+ICsgICAgICAgICAgIHJldHVybiAx
Ow0KPiA+ICsgICB9DQo+ID4gKw0KPiA+ICsNCj4NCj4gT25seSBuZWVkIG9uZSBuZXdsaW5lIG5l
ZWRlZCBoZXJlLg0KDQpGaXhlZCBpbiBWNS4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGNvbW1l
bnRzIQ0KDQpQZXJyeS4NCg0KPg0KPiA+ICsgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIGFtZF9wc3RhdGVfcXVpcmtzX3Rh
YmxlW10gX19pbml0Y29uc3QNCj4gPSB7DQo+ID4gKyAgIHsNCj4gPiArICAgICAgICAgICAuY2Fs
bGJhY2sgPSBkbWlfbWF0Y2hlZF83azYyX2Jpb3NfYnVnLA0KPiA+ICsgICAgICAgICAgIC5pZGVu
dCA9ICJBTUQgRVBZQyA3SzYyIiwNCj4gPiArICAgICAgICAgICAubWF0Y2hlcyA9IHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgIERNSV9NQVRDSChETUlfQklPU19WRVJTSU9OLCAiNS4xNCIpLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgRE1JX01BVENIKERNSV9CSU9TX1JFTEVBU0UsICIxMi8x
Mi8yMDE5IiksDQo+ID4gKyAgICAgICAgICAgfSwNCj4gPiArICAgICAgICAgICAuZHJpdmVyX2Rh
dGEgPSAmcXVpcmtfYW1kXzdrNjIsDQo+ID4gKyAgIH0sDQo+ID4gKyAgIHt9DQo+ID4gK307DQo+
ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUoZG1pLCBhbWRfcHN0YXRlX3F1aXJrc190YWJsZSk7DQo+
ID4gKw0KPiA+ICAgc3RhdGljIGlubGluZSBpbnQgZ2V0X21vZGVfaWR4X2Zyb21fc3RyKGNvbnN0
IGNoYXIgKnN0ciwgc2l6ZV90IHNpemUpDQo+ID4gICB7DQo+ID4gICAgIGludCBpOw0KPiA+IEBA
IC02MDAsMTMgKzYzOCwxOSBAQCBzdGF0aWMgdm9pZCBhbWRfcHN0YXRlX2FkanVzdF9wZXJmKHVu
c2lnbmVkIGludA0KPiBjcHUsDQo+ID4gICBzdGF0aWMgaW50IGFtZF9nZXRfbWluX2ZyZXEoc3Ry
dWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKQ0KPiA+ICAgew0KPiA+ICAgICBzdHJ1Y3QgY3BwY19w
ZXJmX2NhcHMgY3BwY19wZXJmOw0KPiA+ICsgICB1MzIgbG93ZXN0X2ZyZXE7DQo+ID4NCj4gPiAg
ICAgaW50IHJldCA9IGNwcGNfZ2V0X3BlcmZfY2FwcyhjcHVkYXRhLT5jcHUsICZjcHBjX3BlcmYp
Ow0KPiA+ICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4NCj4g
PiArICAgaWYgKHF1aXJrcyAmJiBxdWlya3MtPmxvd2VzdF9mcmVxKQ0KPiA+ICsgICAgICAgICAg
IGxvd2VzdF9mcmVxID0gcXVpcmtzLT5sb3dlc3RfZnJlcTsNCj4gPiArICAgZWxzZQ0KPiA+ICsg
ICAgICAgICAgIGxvd2VzdF9mcmVxID0gY3BwY19wZXJmLmxvd2VzdF9mcmVxOw0KPiA+ICsNCj4g
PiAgICAgLyogU3dpdGNoIHRvIGtoeiAqLw0KPiA+IC0gICByZXR1cm4gY3BwY19wZXJmLmxvd2Vz
dF9mcmVxICogMTAwMDsNCj4gPiArICAgcmV0dXJuIGxvd2VzdF9mcmVxICogMTAwMDsNCj4gPiAg
IH0NCj4gPg0KPiA+ICAgc3RhdGljIGludCBhbWRfZ2V0X21heF9mcmVxKHN0cnVjdCBhbWRfY3B1
ZGF0YSAqY3B1ZGF0YSkgQEAgLTYzNSwxMg0KPiA+ICs2NzksMTggQEAgc3RhdGljIGludCBhbWRf
Z2V0X21heF9mcmVxKHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkNCj4gPiAgIHN0YXRpYyBp
bnQgYW1kX2dldF9ub21pbmFsX2ZyZXEoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKQ0KPiA+
ICAgew0KPiA+ICAgICBzdHJ1Y3QgY3BwY19wZXJmX2NhcHMgY3BwY19wZXJmOw0KPiA+ICsgICB1
MzIgbm9taW5hbF9mcmVxOw0KPiA+DQo+ID4gICAgIGludCByZXQgPSBjcHBjX2dldF9wZXJmX2Nh
cHMoY3B1ZGF0YS0+Y3B1LCAmY3BwY19wZXJmKTsNCj4gPiAgICAgaWYgKHJldCkNCj4gPiAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gLSAgIHJldHVybiBjcHBjX3BlcmYubm9taW5h
bF9mcmVxOw0KPiA+ICsgICBpZiAocXVpcmtzICYmIHF1aXJrcy0+bm9taW5hbF9mcmVxKQ0KPiA+
ICsgICAgICAgICAgIG5vbWluYWxfZnJlcSA9IHF1aXJrcy0+bm9taW5hbF9mcmVxOw0KPiA+ICsg
ICBlbHNlDQo+ID4gKyAgICAgICAgICAgbm9taW5hbF9mcmVxID0gY3BwY19wZXJmLm5vbWluYWxf
ZnJlcTsNCj4gPiArDQo+ID4gKyAgIHJldHVybiBub21pbmFsX2ZyZXE7DQo+ID4gICB9DQo+ID4N
Cj4gPiAgIHN0YXRpYyBpbnQgYW1kX2dldF9sb3dlc3Rfbm9ubGluZWFyX2ZyZXEoc3RydWN0IGFt
ZF9jcHVkYXRhDQo+ID4gKmNwdWRhdGEpIEBAIC0xNjcyLDYgKzE3MjIsMTEgQEAgc3RhdGljIGlu
dCBfX2luaXQgYW1kX3BzdGF0ZV9pbml0KHZvaWQpDQo+ID4gICAgIGlmIChjcHVmcmVxX2dldF9j
dXJyZW50X2RyaXZlcigpKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRUVYSVNUOw0KPiA+DQo+
ID4gKyAgIHF1aXJrcyA9IE5VTEw7DQo+ID4gKw0KPiA+ICsgICAvKiBjaGVjayBpZiB0aGlzIG1h
Y2hpbmUgbmVlZCBDUFBDIHF1aXJrcyAqLw0KPiA+ICsgICBkbWlfY2hlY2tfc3lzdGVtKGFtZF9w
c3RhdGVfcXVpcmtzX3RhYmxlKTsNCj4gPiArDQo+ID4gICAgIHN3aXRjaCAoY3BwY19zdGF0ZSkg
ew0KPiA+ICAgICBjYXNlIEFNRF9QU1RBVEVfVU5ERUZJTkVEOg0KPiA+ICAgICAgICAgICAgIC8q
IERpc2FibGUgb24gdGhlIGZvbGxvd2luZyBjb25maWdzIGJ5IGRlZmF1bHQ6DQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oIGIvaW5jbHVkZS9saW51eC9hbWQtcHN0
YXRlLmgNCj4gPiBpbmRleCBkMjE4Mzg4MzVhYmQuLjdiMmNiYjg5MmZkOSAxMDA2NDQNCj4gPiAt
LS0gYS9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgv
YW1kLXBzdGF0ZS5oDQo+ID4gQEAgLTEyNCw0ICsxMjQsMTAgQEAgc3RhdGljIGNvbnN0IGNoYXIg
KiBjb25zdA0KPiBhbWRfcHN0YXRlX21vZGVfc3RyaW5nW10gPSB7DQo+ID4gICAgIFtBTURfUFNU
QVRFX0dVSURFRF0gICAgICA9ICJndWlkZWQiLA0KPiA+ICAgICBOVUxMLA0KPiA+ICAgfTsNCj4g
PiArDQo+ID4gK3N0cnVjdCBxdWlya19lbnRyeSB7DQo+ID4gKyAgIHUzMiBub21pbmFsX2ZyZXE7
DQo+ID4gKyAgIHUzMiBsb3dlc3RfZnJlcTsNCj4gPiArfTsNCj4gPiArDQo+ID4gICAjZW5kaWYg
LyogX0xJTlVYX0FNRF9QU1RBVEVfSCAqLw0KDQo=

