Return-Path: <linux-kernel+bounces-42191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9154B83FDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844F41C22740
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F6E446A3;
	Mon, 29 Jan 2024 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SSjoEXMo"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F44205B;
	Mon, 29 Jan 2024 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505738; cv=fail; b=riWJ2SM4V8lJ02I0UuE+az+SlybcFJd9nKoErf9CuBeF2xFpTdUJ7xi5+3WyrVKSqfh0fgWRMUdU45Hd7GLZo2kbeNkvU0o9dymt+F3I304lQ8cFcR3kznarlsaSIpN4lH80p+79enFtPknV7TvqKe9/mA2KMjxcjSPd/dks4cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505738; c=relaxed/simple;
	bh=OPHToFHX+DFGrnF4CSsdlHhHZWyyQMgMO01AIlorrXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gbmleojf/8FTzq6N2oJTb3KpckwpiSHR22ig3Q6uYJNMGCieY2Mx8hD5eYZjyjr47xTxnUKmsL15nKBFBmjUxwbJcIwZdlmaT1PWVW0vuRc6QldR5dDCZI9V/emi0ofWklT70ZEYcpU+/Bcdyjk8oNPJzV7JXr0Fy9uyQaUw0Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SSjoEXMo; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkSdGEWXutiLkXeT6GlhxK96HGzfoxNFEMjMf+93kJP1Evzr8/0Q8a6sACqCJq4smDG5fl/xpnI2lufSWu1J8jh7LLkG3A6BhzP91jacebCr2stpp/HiGKv+IpH/He0MN+mICYogDgCCbh/0ZPDobB/KgBrhR4opgTiUNDW8dBZ4r0sWTdZ7vtngP8j3i7tN5W9eXuL8AESDd9SxuiRcvhCS2oc8WSWRwNsCcRFvFiAqRzCRE49D7QccahGyHBB9M1TaVE0vs8xBB16PJMVxoB2EioZZSYq3m9iLSHZSLEiV1tpcOOpu85P8/7/V+BvQrDLaBk5Y/GN/uTabRNJ6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPHToFHX+DFGrnF4CSsdlHhHZWyyQMgMO01AIlorrXY=;
 b=BB7ofiazqpHV/3HIangE5e9zIujTeMj14wzWlnBq8M5Xpt6r1n+OLgYZzRF0OyB8r75Pi8+MJ+JY9BkU6YGVc+q9lL/x8lyLHdtf3K0wKbb4d+PYzGOCD69Y9trgE+1ECfojZyZIGoxj+RcwxSvyJ5dZhX08g56XlfmlIIw1IhM9RFgfNaG98HV6Fyq9KpkR8RYw8+xoC4+0G2gvaqbZcktyxM7E4FuMgi49u5zPUPtEM4f2JrCpVqQgrs1ai2e2nqZp6svBzaGM+F2q8dGObUN7al8+jwBSJXUyFjGFaHts+vWpZWKnMoqCRozJHoLo2VcdX7PaMdWu67pqBokKng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPHToFHX+DFGrnF4CSsdlHhHZWyyQMgMO01AIlorrXY=;
 b=SSjoEXMoRENuI3T+S08YmDbV6RA24vnW4fcSHrrEBCb7E7jcr7LxRB4koz6ecRcs0aLXAXocGFH5xw0Yn8jy7HEEd8YSg0TsTvNizMg2wsKQrNo8cFSzl8WuC3uAyNsWrMNIPFmvi5/o6c3abeHeaacsMsg+9zKhq+khAFp9fQg=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 05:22:14 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 05:22:14 +0000
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
Subject: RE: [PATCH 3/7] cpufreq: amd-pstate: implement cpb_boost sysfs entry
 for boost control
Thread-Topic: [PATCH 3/7] cpufreq: amd-pstate: implement cpb_boost sysfs entry
 for boost control
Thread-Index: AQHaUDeu4mzrcgPmHECEPOmyW9vVBLDsQBiAgAQEMXA=
Date: Mon, 29 Jan 2024 05:22:13 +0000
Message-ID:
 <CYYPR12MB86557BD948198DA1CAB646C79C7E2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
 <f94bfc67e95fca54a153e24d828ef27e26ee5c47.1706255676.git.perry.yuan@amd.com>
 <233100b4-e765-48e4-a1c0-88d01c621bd0@amd.com>
In-Reply-To: <233100b4-e765-48e4-a1c0-88d01c621bd0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b967505c-d0f8-40dc-9e5e-cee3a4820289;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-29T05:16:49Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM6PR12MB4497:EE_
x-ms-office365-filtering-correlation-id: 4318913c-99bc-4ea1-31ec-08dc208a4090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 psnUhlhYRg0IwcWex/DAstn0DBr+EzNbk67ivUwXJkUHZcymU+fmPZGDo8ao7mC8IETSKeCWWyXMdjzRJ8ekpk6T1oTakiaOdt2loS/HaebKFJAsrRF/R27lXaH1XyAq/aAt3fhPkLWTineHokp29cmZqe7xbZ6pcrRGMc39V2bJ5K1h0raJEnItp25iUQ2AhEAbhfKpFJQGqlCPyvueMcNnIT8IoYRCEP3n051AMJaKcq9JDBLc0z53TFX8UTd8PRdAsB3TvqF4d70jQBLsb3m9V+CQY0Y55lWRXwiZ7zfyUpMTUJAJiWbztoxnqufu64+l6cKIYG5x+c7HVTonBPLu/9iQjfnoCyjEMzJUa1svJxOetCyNE5g42Uw5ztsQeL7riXLbGhTuZwdSBi/E1q4KoUofZdg7fLQtrWTPFue2zbiuiue3IKcBbZQ2r949yCfIMSQkTR9JC+ttB9WpwyEpmA12XFjYSqWNLpdb4KUtBGpp6t//zIrdDl0k3sWDcylxLUKo7/qw6tEf5lj3MOA7JC3Gh+08gcCFi84093SRFmcMvL9GyjnaOIqwcFita0O6KHqJqexmh/YLnwlteVh1TH4y6M/r3kRGJXIWv8TyDmR9O+3c8QjooXy0xgDAnbN2WGRw38EYjdx3HS9f9A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38070700009)(41300700001)(2906002)(5660300002)(33656002)(921011)(66946007)(66556008)(54906003)(64756008)(66446008)(66476007)(316002)(76116006)(110136005)(86362001)(9686003)(83380400001)(6636002)(6506007)(55016003)(26005)(966005)(478600001)(71200400001)(7696005)(53546011)(52536014)(4326008)(8936002)(8676002)(122000001)(38100700002)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVBrbHZibDhPcktESGZiUkx1RURTUmVCcnM4c2Rtdk5raHhtU3ZaQU5VQTJP?=
 =?utf-8?B?WWRKcFA1QTQyWG5yR0dzSzBtajRLWGNWTEdVV1N6SWlPemhOM25pRzBtUVFJ?=
 =?utf-8?B?MVZSTUk1eUl0R25EbmwvNEZVNVd2VHJocEFNQUJTVm4zbzNFUGtmWlJ6a203?=
 =?utf-8?B?RjEyTmowZzZ2NmlXSFVXZWxnL1BIa01KbWZMc2YzTWI3Qk9rTXltYXUxSzBw?=
 =?utf-8?B?S1ZxcEtvK2NzZ3V5UG51Um16bXM5aDgrTmRIeEZ5cG5SM01pcm95N3pyRVgw?=
 =?utf-8?B?UStQcVQ4cWFQYms1RUt6M3dGVmZnZUhUcjFqSFgxMWREd2pWR2R4NHpVejVp?=
 =?utf-8?B?aTl0bUc3cVNCSWVlNlNHUEVZNkdqUHBPa1pQMVlQdU9QRUpZdE1Ma3RJWEJW?=
 =?utf-8?B?a1hnS3l1NVpWeWExQW1jcFBRRWdGRWxQTHpvTW51ZkxmRkRpaE5IVnd0NWhw?=
 =?utf-8?B?Rm15MWFiL1pwVHo1Nkw3dkhBcm5JZzJ3NHRHaFZNMTJoNFNiYitvUUczU3dq?=
 =?utf-8?B?L1oxa3RmNS94anRnSVlUM0hMNG1PK3JsSkhKUUtWcjd4blA0WHFYS0kyQWla?=
 =?utf-8?B?NVJjRVpSK0xmQjNZa1F6L2NqaUhBT0l4eG5hR1I5aituOG4relB5RStyTldw?=
 =?utf-8?B?RVByWDBYSGRMTkNoeGJYSXF3OGJGMnJpKzB1UEVCTkZQR0lSWktmYU95NUt4?=
 =?utf-8?B?NDRWVWpWazZ1UER5RFlCbjVMZ3NMVlYybE40MnJoQmRzczJJSGdSeXluZWxu?=
 =?utf-8?B?WmNFS04zVXFiOEJaeWVRQUE4VS9oV1NFTTdaVFJtM2x0S2JabmkydG83L0tv?=
 =?utf-8?B?L1poN0FKeExoSHVtbzFjRDhRczhTZDMwWlhHbk9tMmYrRjJjWjU5YWRQVmVG?=
 =?utf-8?B?eGdOTGFhUG9BSnBZQWN0eDVDcit0MDFWM0ROcHJOaEhKcGFIRG1IYzhIV0Ir?=
 =?utf-8?B?T3o1SE5VUVlGUm5LUCtia09rRG02ckhXK3FTTHpqVGtpT1dnQWkyL0FhUjBa?=
 =?utf-8?B?aGNxOXJCcThLeWlpbURDY3JGNWtaUWVOQm5aR1lNeHI5QmRHYTh4NktoSXlW?=
 =?utf-8?B?YXo4SVNjYldFSGNOY09MYXlScDNvbExKSURwQzNtUUZENDJsTzlWK2dGTEZm?=
 =?utf-8?B?T3AzSERzQnJMbWVJbGN4c1kxRGhCOEp5MElUZFhHdlF6cWhpNlc5LzhTWjFz?=
 =?utf-8?B?dzNUNy9CT2FSUU5zN2QxUW9HRTd3VWVOL2RDUmFEYVh4Mk9jRXJqeHhVYU81?=
 =?utf-8?B?VWE3Um1zRTZleVpNTVJBV2dxM2RMcHRTRjB0Q1g2ZWhtWlRKTVU1U1FvanNL?=
 =?utf-8?B?T3dkSy9qN01TdHJDZ0RuYk5sR0dPbXdzSHlZa05TZW8rOC9aMjVvREdpQkhk?=
 =?utf-8?B?RVJkNHFteUF1Y2ZiUlZycWRJYm9tVjZrWjVoMUpyZlZEK2VmTzBxb3FOOTB5?=
 =?utf-8?B?MWVTZTJRQmVYWHorbjlGMjhIUkp0Y2FBNlJ5aC9kUEErOHdhZmFRL0hOcCtx?=
 =?utf-8?B?QTZLMnpoT1Y5Nk14bE5CSThHdVY4ektISzBuSTBoc1BML3BudHA1dXR3aGg0?=
 =?utf-8?B?dldNTDBWQmx4MHQ4SjZvL013QnpJTmVjNHZnRTlRNmorK3k0Ym1Fc25ZS1lT?=
 =?utf-8?B?OStnRE04WTh3VXVHYUVHOXFNZ0tnT2xKWE9ZY3hsV01WY1FPK21DZFJTbDU3?=
 =?utf-8?B?MGNnSlJJelN6MHhCUjhacTJSVEplK21SUHVlMmtpbnBlU21iQzB3Rml0cUxB?=
 =?utf-8?B?dmk0N29YREVRVUJuVkMxVFBnQVJJMkRMS0pYdmg3TjdtQ09aVFVCZHcrbFEy?=
 =?utf-8?B?OERmYnY5d2dNc0xnQmhsdUh6SXQrVGVqUnRWbW1md21ZMDd1ZWdtTUF3eVlx?=
 =?utf-8?B?aEZvSUU5NEhUK1BZaXBYa1VNOENyWUNQSHlpTGV4TDZURlFoRXp2cTg2c0w4?=
 =?utf-8?B?K1JBWkJwTjJHWGVWSVBIdEUwQTVrTDYvQTQvMytRdzVqekJoUStraXVkaE5x?=
 =?utf-8?B?M0lCUDBQWGVkancvek14RVcyS1R0QnNmcmc0ZzVkVFpRbjUwc0hrelpDL0h4?=
 =?utf-8?B?Z1d4TUw5QnVueXhrWGdwa1haWG83YTBNbUhuMUN0TEtNb1ZkMGY0ODNRREJY?=
 =?utf-8?Q?0f6w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4318913c-99bc-4ea1-31ec-08dc208a4090
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 05:22:14.0033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeYcMv6aBG/DDbwgdptCkf0UIkyA+HOJY5IZG/I5Rk2WPp0kkHrxauW5VMNXeLVLbIlZwWn38xg2+F3eeP3xjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDI2LCAyMDI0IDEx
OjU3IFBNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb207DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywgUmF5
IDxSYXkuSHVhbmdAYW1kLmNvbT47IFNoZW5veSwNCj4gR2F1dGhhbSBSYW5qYWwgPGdhdXRoYW0u
c2hlbm95QGFtZC5jb20+OyBQZXRrb3YsIEJvcmlzbGF2DQo+IDxCb3Jpc2xhdi5QZXRrb3ZAYW1k
LmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2pp
YW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5n
QGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy83XSBjcHVmcmVxOiBhbWQtcHN0
YXRlOiBpbXBsZW1lbnQgY3BiX2Jvb3N0IHN5c2ZzDQo+IGVudHJ5IGZvciBib29zdCBjb250cm9s
DQo+DQo+IE9uIDEvMjYvMjAyNCAwMjowOCwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBGcm9tOiBQ
ZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4NCj4gPiBXaXRoIHRoaXMgbmV3IHN5
c2ZzIGVudHJ5IGBjcGJfYm9vc3RgY3JlYXRlZCwgdXNlciBjYW4gY2hhbmdlIENQVQ0KPiA+IGJv
b3N0IHN0YXRlIGR5bmFtaWNhbGx5IHVuZGVyIGBhY3RpdmVgIGFuZCBgcGFzc2l2ZWAgbW9kZXMu
DQo+DQo+IFdoYXQgYWJvdXQgZ3VpZGVkIG1vZGU/DQo+DQoNCkd1aWRlZCBtb2RlIGlzIHN1cHBv
cnRlZCBhcyB3ZWxsLg0KDQoNCj4gPiBBbmQgdGhlIGhpZ2hlc3QgcGVyZiBhbmQgZnJlcXVlbmN5
IHdpbGwgYWxzbyBiZSB1cGRhdGVkIGFzIHRoZSBib29zdA0KPiA+IHN0YXRlIGNoYW5naW5nLg0K
PiA+DQo+ID4gMDogY2hlY2sgY3VycmVudCBib29zdCBzdGF0ZQ0KPiA+IGNhdCAvc3lzL2Rldmlj
ZXMvc3lzdGVtL2NwdS9hbWRfcHN0YXRlL2NwYl9ib29zdA0KPiA+DQo+ID4gMTogZGlzYWJsZSBD
UFUgYm9vc3QNCj4gPiBzdWRvIGJhc2ggLWMgImVjaG8gMCA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2FtZF9wc3RhdGUvY3BiX2Jvb3N0Ig0KPiA+DQo+ID4gMjogZW5hYmxlIENQVSBib29zdA0K
PiA+IHN1ZG8gYmFzaCAtYyAiZWNobyAxID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvYW1kX3Bz
dGF0ZS9jcGJfYm9vc3QiDQo+ID4NCj4gPiBMaW5rOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5v
cmcvc2hvd19idWcuY2dpP2lkPTIxNzkzMQ0KPiA+IExpbms6IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3NjE4DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
ZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2Nw
dWZyZXEvYW1kLXBzdGF0ZS5jIHwgOTcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOTcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBiL2RyaXZlcnMv
Y3B1ZnJlcS9hbWQtcHN0YXRlLmMgaW5kZXggMGRjOTEyNDE0MGQ0Li5iMzdiZWE3NDQwYjkNCj4g
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBAQCAtMTAzNiw2ICsxMDM2LDEwMSBA
QCBzdGF0aWMgc3NpemVfdCBzdGF0dXNfc3RvcmUoc3RydWN0IGRldmljZSAqYSwNCj4gc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmIsDQo+ID4gICAgIHJldHVybiByZXQgPCAwID8gcmV0IDogY291
bnQ7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBhbWRfY3B1X2Jvb3N0X3VwZGF0ZShz
dHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEsIHUzMiBvbikNCj4gPiArew0KPiA+ICsgICBzdHJ1
Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSA9IGNwdWZyZXFfY3B1X2FjcXVpcmUoY3B1ZGF0YS0+
Y3B1KTsNCj4gPiArICAgc3RydWN0IGNwcGNfcGVyZl9jdHJscyBwZXJmX2N0cmxzOw0KPiA+ICsg
ICB1MzIgaGlnaGVzdF9wZXJmLCBub21pbmFsX3BlcmY7DQo+ID4gKyAgIGludCByZXQ7DQo+ID4g
Kw0KPiA+ICsgICBpZiAoIXBvbGljeSkNCj4gPiArICAgICAgICAgICByZXR1cm4gLUVOT0RBVEE7
DQo+ID4gKw0KPiA+ICsgICBoaWdoZXN0X3BlcmYgPSBSRUFEX09OQ0UoY3B1ZGF0YS0+aGlnaGVz
dF9wZXJmKTsNCj4gPiArICAgbm9taW5hbF9wZXJmID0gUkVBRF9PTkNFKGNwdWRhdGEtPm5vbWlu
YWxfcGVyZik7DQo+ID4gKw0KPiA+ICsgICBpZiAoYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0NQ
UEMpKSB7DQo+ID4gKyAgICAgICAgICAgdTY0IHZhbHVlID0gUkVBRF9PTkNFKGNwdWRhdGEtPmNw
cGNfcmVxX2NhY2hlZCk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIHZhbHVlICY9IH5HRU5NQVNL
X1VMTCg3LCAwKTsNCj4NCj4gSSB0aGluayBpdCdzIGJldHRlciB0byB1c2UgdGhlIG1hY3JvIEFN
RF9DUFBDX01BWF9QRVJGIGluIHRoaXMgY2FzZS4NCj4gVGhlIGxlc3MgbWFnaWMgbWFza3MgaW4g
dGhlIGNvZGUsIHRoZSBlYXNpZXIgaXQgaXMgdG8gZm9sbG93Lg0KDQpIZXJlIHRoZSBoaWdoZXN0
X3BlcmYgIGFuZCAgbm9taW5hbF9wZXJmIHdpbGwgcmV1c2UgdGhlIHBlcmYgdmFsdWVzIHdoZXJl
IHRoZXkgc2hvdWxkIGJlIGNvcnJlY3RseSBpbml0aWFsaXplZC4NCkluIHRoaXMgZnVuY3Rpb24s
IHdlIHdvdWxkIGxpa2UgdG8gZm9jdXMgb24gdG8gdXNlIGhpZ2hlc3QgcGVyZiBvciBub21pbmFs
IHBlcmYgZm9yIGJvb3N0IGNvbnRyb2wuDQoNClRoZSBBTURfQ1BQQ19NQVhfUEVSRiBzaG91bGQg
YmUgdXNlZCB3aGVuIGRyaXZlciBsb2FkaW5nIHRvIHNldCBhY3R1YWwgaGlnaGVzdF9wZXJmIHZh
bHVlIGFzIHJlcXVpcmVkLg0KSGVyZSBJIHdvdWxkIGxpa2UgYXZvaWQgdG8gbWFrZSB0aGUgaGln
aGVzdCBwZXJmICB2YWx1ZSBjaGFuZ2VkLg0KDQpCb29zdCBjb250cm9sIG9ubHkgc3dpdGNoIHRo
ZSB0d28gcGVyZiB2YWx1ZSBoaWdoZXN0X3BlcmYgdnMgIG5vbWluYWxfcGVyZiBhcyB1c2VyIHJl
cXVlc3QuDQoNClBlcnJ5Lg0KDQo+DQo+ID4gKyAgICAgICAgICAgdmFsdWUgfD0gb24gPyBoaWdo
ZXN0X3BlcmYgOiBub21pbmFsX3BlcmY7DQo+ID4gKyAgICAgICAgICAgV1JJVEVfT05DRShjcHVk
YXRhLT5jcHBjX3JlcV9jYWNoZWQsIHZhbHVlKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgd3Jt
c3JsX29uX2NwdShjcHVkYXRhLT5jcHUsIE1TUl9BTURfQ1BQQ19SRVEsDQo+IHZhbHVlKTsNCj4g
PiArDQo+ID4gKyAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgcGVyZl9jdHJscy5tYXhfcGVy
ZiA9IG9uID8gaGlnaGVzdF9wZXJmIDogbm9taW5hbF9wZXJmOw0KPiA+ICsgICAgICAgICAgIHJl
dCA9IGNwcGNfc2V0X2VwcF9wZXJmKGNwdWRhdGEtPmNwdSwgJnBlcmZfY3RybHMsIDEpOw0KPiA+
ICsgICAgICAgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgIHByX2RlYnVn
KCJmYWlsZWQgdG8gc2V0IGVuZXJneSBwZXJmIHZhbHVlICglZClcbiIsDQo+IHJldCk7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgICAgIH0NCj4gPiAr
ICAgfQ0KPiA+ICsNCj4gPiArICAgaWYgKG9uKQ0KPiA+ICsgICAgICAgICAgIHBvbGljeS0+Y3B1
aW5mby5tYXhfZnJlcSA9IGNwdWRhdGEtPm1heF9mcmVxOw0KPiA+ICsgICBlbHNlDQo+ID4gKyAg
ICAgICAgICAgcG9saWN5LT5jcHVpbmZvLm1heF9mcmVxID0gY3B1ZGF0YS0+bm9taW5hbF9mcmVx
Ow0KPiA+ICsNCj4gPiArICAgcG9saWN5LT5tYXggPSBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXE7
DQo+ID4gKw0KPiA+ICsgICBpZiAoY3BwY19zdGF0ZSA9PSBBTURfUFNUQVRFX1BBU1NJVkUpIHsN
Cj4gPiArICAgICAgICAgICByZXQgPSBmcmVxX3Fvc191cGRhdGVfcmVxdWVzdCgmY3B1ZGF0YS0+
cmVxWzFdLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb2xpY3ktPmNw
dWluZm8ubWF4X2ZyZXEpOw0KPiA+ICsgICB9DQo+ID4gKw0KPiA+ICsgICBjcHVmcmVxX2NwdV9y
ZWxlYXNlKHBvbGljeSk7DQo+ID4gKw0KPiA+ICsgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgc3NpemVfdCBjcGJfYm9vc3Rfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0
ciwgY2hhciAqYnVmKSB7DQo+ID4gKyAgIHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiV1XG4iLCBn
bG9iYWwuY3BiX2Jvb3N0KTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIHNzaXplX3QgY3BiX2Jvb3N0
X3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUNCj4gKmIs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291
bnQpIHsNCj4gPiArICAgYm9vbCBuZXdfc3RhdGU7DQo+ID4gKyAgIHNzaXplX3QgcmV0Ow0KPiA+
ICsgICBpbnQgY3B1Ow0KPiA+ICsNCj4gPiArICAgbXV0ZXhfbG9jaygmYW1kX3BzdGF0ZV9kcml2
ZXJfbG9jayk7DQo+ID4gKyAgIGlmICghZ2xvYmFsLmNwYl9zdXBwb3J0ZWQpIHsNCj4gPiArICAg
ICAgICAgICBwcl9lcnIoIkJvb3N0IG1vZGUgaXMgbm90IHN1cHBvcnRlZCBieSB0aGlzIHByb2Nl
c3NvciBvcg0KPiBTQklPU1xuIik7DQo+ID4gKyAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+
ID4gKyAgIH0NCj4gPiArDQo+ID4gKyAgIHJldCA9IGtzdHJ0b2Jvb2woYnVmLCAmbmV3X3N0YXRl
KTsNCj4gPiArICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4g
PiArDQo+ID4gKyAgIGdsb2JhbC5jcGJfYm9vc3QgPSAhIW5ld19zdGF0ZTsNCj4gPiArDQo+ID4g
KyAgIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpIHsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
c3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kgPSBjcHVmcmVxX2NwdV9nZXQoY3B1KTsNCj4g
PiArICAgICAgICAgICBzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEgPSBwb2xpY3ktPmRyaXZl
cl9kYXRhOw0KPiA+ICsNCj4gPiArICAgICAgICAgICBpZiAoIWNwdWRhdGEpIHsNCj4gPiArICAg
ICAgICAgICAgICAgICAgIHByX2VycigiY3B1ZGF0YSBpcyBOVUxMXG4iKTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgIHJldCA9IC1FTk9EQVRBOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgY3B1
ZnJlcV9jcHVfcHV0KHBvbGljeSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9l
eGl0Ow0KPiA+ICsgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgYW1kX2NwdV9i
b29zdF91cGRhdGUoY3B1ZGF0YSwgZ2xvYmFsLmNwYl9ib29zdCk7DQo+ID4gKyAgICAgICAgICAg
cmVmcmVzaF9mcmVxdWVuY3lfbGltaXRzKHBvbGljeSk7DQo+ID4gKyAgICAgICAgICAgY3B1ZnJl
cV9jcHVfcHV0KHBvbGljeSk7DQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gK2Vycl9leGl0Og0KPiA+
ICsgICBtdXRleF91bmxvY2soJmFtZF9wc3RhdGVfZHJpdmVyX2xvY2spOw0KPiA+ICsgICByZXR1
cm4gcmV0IDwgMCA/IHJldCA6IGNvdW50Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgY3B1ZnJlcV9m
cmVxX2F0dHJfcm8oYW1kX3BzdGF0ZV9tYXhfZnJlcSk7DQo+ID4gICBjcHVmcmVxX2ZyZXFfYXR0
cl9ybyhhbWRfcHN0YXRlX2xvd2VzdF9ub25saW5lYXJfZnJlcSk7DQo+ID4NCj4gPiBAQCAtMTA0
Myw2ICsxMTM4LDcgQEANCj4gY3B1ZnJlcV9mcmVxX2F0dHJfcm8oYW1kX3BzdGF0ZV9oaWdoZXN0
X3BlcmYpOw0KPiA+ICAgY3B1ZnJlcV9mcmVxX2F0dHJfcncoZW5lcmd5X3BlcmZvcm1hbmNlX3By
ZWZlcmVuY2UpOw0KPiA+ICAgY3B1ZnJlcV9mcmVxX2F0dHJfcm8oZW5lcmd5X3BlcmZvcm1hbmNl
X2F2YWlsYWJsZV9wcmVmZXJlbmNlcyk7DQo+ID4gICBzdGF0aWMgREVWSUNFX0FUVFJfUlcoc3Rh
dHVzKTsNCj4gPiArc3RhdGljIERFVklDRV9BVFRSX1JXKGNwYl9ib29zdCk7DQo+ID4NCj4gPiAg
IHN0YXRpYyBzdHJ1Y3QgZnJlcV9hdHRyICphbWRfcHN0YXRlX2F0dHJbXSA9IHsNCj4gPiAgICAg
JmFtZF9wc3RhdGVfbWF4X2ZyZXEsDQo+ID4gQEAgLTEwNjIsNiArMTE1OCw3IEBAIHN0YXRpYyBz
dHJ1Y3QgZnJlcV9hdHRyICphbWRfcHN0YXRlX2VwcF9hdHRyW10gPQ0KPiA+IHsNCj4gPg0KPiA+
ICAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnBzdGF0ZV9nbG9iYWxfYXR0cmlidXRlc1tdID0g
ew0KPiA+ICAgICAmZGV2X2F0dHJfc3RhdHVzLmF0dHIsDQo+ID4gKyAgICZkZXZfYXR0cl9jcGJf
Ym9vc3QuYXR0ciwNCj4gPiAgICAgTlVMTA0KPiA+ICAgfTsNCj4gPg0KDQo=

