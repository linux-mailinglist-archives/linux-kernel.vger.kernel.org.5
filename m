Return-Path: <linux-kernel+bounces-58804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4250384EC45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0F328A65D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE725026F;
	Thu,  8 Feb 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wKShP/cw"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F350240;
	Thu,  8 Feb 2024 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433792; cv=fail; b=CSatwILeRtMMcBH61rpawdt4ziY3OD74T627iwQ7NIWD7AZos0DG6jTu1M/6sqPONVs76wfVk2M609FtcVwNV66e1agxonQhk3qu7mkNWoQROtwcVTJv8DIBWZidrMpT0kKVDpIgLAvGV5VdDJAhOQB1FxS4yIVCEaMgk1O2bt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433792; c=relaxed/simple;
	bh=bo/AHxNhJbQWwTjO4/LefVAysk829G+4e5CE22cE8gs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twKgSs8S/n9CNVS4u03eKMhTkKrYfKXLKR9IwXcDtevXXgsW3sFk20kWE2Rhdw3AJFvbIUjHeAGWJiz2XLYtjbiF+wWtquEixdVEOpGfaX06wEUyy71BfuyPl9V9Ux8U2KnPylruv06TmO8WmfXfjOEJW8c0dXsgSOqdURZRVA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wKShP/cw; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5E35TflT9k9oC/ikOBCiL4cCHYSyNP+1kBSyRWkDFqgK6gdAhx+zK7ZqmS5rU/jUbyRIV9rfQKyqnnm9cLytrH/MjMpSJfc+WsDAs7FxiZCAL30S4HLrm6qRs8GytP/KOnewQlH9sJFrJ08TAQc2U1ycsH22sI0mccyQnQIpA5KRdE34rPTTUMnCqY4IddNclWWrOJRbNM0Ay+NTddBLK/nRib7rfeP/ij8nyv4q8BTF2pcnrToV/WhOmhAHyxU7YA19zg6D38SR7svmfqQQNaeKTwexNecyVWkfJWqoATLPZTNNnk7CH+CW7m7dmPuN1y92d5fX5Ss+OZHS0SzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo/AHxNhJbQWwTjO4/LefVAysk829G+4e5CE22cE8gs=;
 b=h8qKSduWnbTusxYTCtdi/xfPufmJ1wW+3IKYBrE2R3Sq3BYNimxhXE+CC9KfFOx6fscupfyExZMzUlqhUSTCGlvxMuNP7n2Uwdpw1iTKUGEkLDcwFP+3PBDUGXBmYKbBWNrQPCbrieYVVLYq4nbaJykaoSjy1q4Xas2g2aU0VrLL1jdn40/+oKIjngqaHRB5/ivvgMHI+KA6+4g8MUb83wXnoJ2WvAWQSxtu/THOtK7smE/M7psGr9mGo71NQHTKDcCdEpfUV+dWJU2CyfuE8jLt9f30GmEXVBIwEzbGHBPpGxvKXxFxnNiSghKa6gAVfBH3n3CBmp+12UMYwZZKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo/AHxNhJbQWwTjO4/LefVAysk829G+4e5CE22cE8gs=;
 b=wKShP/cwnEsel3xfsEeyNMRYZtNkL0Ng/2TmAByrFkqmiqPJcGc2LbvvTc2LnqKWhhMOCLIyQXRiT+LSBhUuTvCLS21L0kwX9q3ozJUjBtxaC1TSY2FbUOmPTdDu/ZhZy0fnOYyNa6k+tfgVSeJ39DyYtI/GTweZZwGvDacAOlo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 8 Feb
 2024 23:09:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7292.010; Thu, 8 Feb 2024
 23:09:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Borislav Petkov <bp@alien8.de>, "Yuan, Perry" <Perry.Yuan@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)"
	<Li.Meng@amd.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/6] AMD Pstate Fixes And Enhancements
Thread-Topic: [PATCH v6 0/6] AMD Pstate Fixes And Enhancements
Thread-Index: AQHaWkIFWFeyqmVE9keWzTofk26Zp7EAPJwAgADWFYA=
Date: Thu, 8 Feb 2024 23:09:47 +0000
Message-ID:
 <BL1PR12MB514409256AE93E5D13556F90F7442@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <20240208102122.GAZcSrIkbPJfIExdF6@fat_crate.local>
In-Reply-To: <20240208102122.GAZcSrIkbPJfIExdF6@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ab132ef0-ba54-4f1e-a6c9-d2cc5f504ef6;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-08T23:07:35Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB7627:EE_
x-ms-office365-filtering-correlation-id: ebbad3c1-003b-46ad-681b-08dc28fb0b66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tkuh+3Nnq+s2iabFAjS6nMhqEmp/OhIKEDa5Cx3QFPbHI5vDPEXHW3UBlBOExBJULXql6g8+8vn5H2Tz7uwV8RXt2Qh9WTJDYzjLhzzAWt/rHNQJq1sm5emJVz46corcanEBAOivQmnbkR2Z/MPKWPgVDV9W5rLJbg2o0HWORMCnzLr7esIl6wgts8jK6UDqxLvuYgtjqd6MuEPypxulrKtjiFR1EV6XlUbttFmOYQJ+3DEsTfsx0a8vybIh4Y7oxSOu/GZJkTqlFCXLY16Tg/4PUPKajXYUSGg1hQLxkqXM75emXoLXAvA+c7Q67tcoGOizp0kpZsSQOVJK6YkuLSUO8lDsJ5HUqLrN/4XcAM4y/43WJL60WSFhsc+pr4dYLUCW3uUkcb6oIwb2vYvOWaSPjVoMijyFra1PQ2dHPOLdiELS5BcnIjGfmdwXwqYJ8W3NDOCzPuxFt2LqXCrBeh1HT9Q6lcmmjXMxNoRE0dNTaokq087+kE+smVQN0P0GPTr6t5q16XN8BiBW226nnhhsyfs9+7TVmiujG9LWOH8KzN1KSkbeIj3BQStoJUxMWEJM+DYPP0AWxkDHToFP8FjLPNRMQUyDftKPLDh5wm8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(53546011)(66556008)(966005)(8936002)(54906003)(76116006)(7696005)(71200400001)(66446008)(33656002)(478600001)(110136005)(9686003)(66476007)(8676002)(66946007)(6636002)(4326008)(64756008)(38070700009)(316002)(38100700002)(122000001)(83380400001)(86362001)(6506007)(26005)(52536014)(2906002)(5660300002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHFUamFWWk9RT3Zxd2hEa1dqZHMyMktyK1lpNHl6WGUxU3k4OS8yZDFOTytO?=
 =?utf-8?B?Y2pDZlRRN2F1NkJWTEZqM1p6Ujd1Y2VNVHVURTBta29jS0RRSDQwRTZmY0Fr?=
 =?utf-8?B?a0Fneml3UlVOZXNjVTNiYTBLRHdNWTdOVS9IdExZbjQ1bFRlcHFaTjh2WDZi?=
 =?utf-8?B?UlY1dnVkWE5OZm9UaGpvLzVYb2p0V0tCM01uQWJkWDc4TklMcldzci9qeXF0?=
 =?utf-8?B?MnhLWTBMSEpRS29sUWRMSW5VeURuV21KWDNDcHFyaHh6WlZ4S05NL2hSR2tq?=
 =?utf-8?B?M3VvNFY3d2ppU1ZoRDFueTQvYXNua1o1cVRXMHZhUXV5djB1OEdxdUZacnly?=
 =?utf-8?B?dmh4MEVqcHZCKzk1dkhiRHlrMkRnaE1vbHNsK1BsRTRubE5tRGpUT3lROTQw?=
 =?utf-8?B?NnU3c05FOGpjOVlQOHpoK0FSZTIvL1IwdVNQZXZaWUxzQjFDNWEvV21lSmZU?=
 =?utf-8?B?cUhTSGhSaC9tMTJydXpDZXdxOGJNODFVazVJcXE5N2pHRWt3eXg2Y2x1NU9z?=
 =?utf-8?B?MjdkeFpla2phWGFXVFFsbytneFdqdVBwT2dBUjZLUElHYkFMcE9XbUlaRTAr?=
 =?utf-8?B?WWNuS3JXcmp2Yk5pTjRvaHhtUnNVKzYzU0tpVzJ3YmVwSFZ3bUhDRXY5Z0xP?=
 =?utf-8?B?eHBVSDFmYk1kdjlUaDA5Y0dFZ2ZiQkdSZlFyNEtqdTN5NjFJVEF0UC9McXNG?=
 =?utf-8?B?RHY4dy9Lay9tdTlJcDdyL2txek12d2ZJMlIzN0hTNStMS0xxMEJmOURNTm9N?=
 =?utf-8?B?UjVzRXRiY3NndVp2MzUwQWF4cmFIQnNmTUhYT29DNC8wYlUyUzg2QU5zbmhV?=
 =?utf-8?B?R0oveEs5empGRm13UmNGZkQwbjE3OE4xRmoyQlJIeXJiMlVQK051NkhnODdB?=
 =?utf-8?B?LzRLYjN4bFIwQWEzMC9qM2s2OStWUzREN3NFOXAwN3JNMFN5RkRUem80N2Ji?=
 =?utf-8?B?bURGRVNYT1NWaWVKczFNekQ5Mkt3TERQeHdBSkd0ekpQQTlRNUxGenJXM1pX?=
 =?utf-8?B?bnpEdS9GdGhGY2dDS1BhRjhFNHRDM1VyL3R0Z2o5UTFvM0JOWGUzZVFMS3NB?=
 =?utf-8?B?RGc4SHlLRVFzQzBzbVdQU3VnUm1lUzJ0ZGd4cXA0NjVRWUxJbVlhVUtqMGt5?=
 =?utf-8?B?dFdRK0ZIakNycjc2L3hQcnd0SjRzK1lqcGphQ2R2MThIVHloaDR0ZDBORTBJ?=
 =?utf-8?B?Ti9ob25JdVAvZW5JV1U4d2JkN3B2cWYwU0ZSVlBoOEt5WWRCTnNNR1hCRFBY?=
 =?utf-8?B?OWhiQ3NqTnJSRjlVQTZjb04rTTRFSTcwQkpXeE5JNGEwRHRHd2dwd0pnL2lw?=
 =?utf-8?B?bWpKZlVOWW1lcXd2T1dKR2FhRHZUSWRIQXV3c3p4c3ArOE96WlcrOTkrRyt2?=
 =?utf-8?B?TlAxcWxxWE9HUGEyZHl5QkZkbUcxYlZWajNyZWRtV0I5S0hYTzRwYmh4RFhs?=
 =?utf-8?B?WUFyRDNoSzhoS0haU2NEWGhWYlB2L3Y1OEExb2xnOG13VDgrRkZ4OE9FRkZm?=
 =?utf-8?B?Z3BKVTFJcHdyd3Bma29qYm5MbzcxU1VNL0t4SmZpOE1SL0dWdlBBODU2RVU3?=
 =?utf-8?B?aFcvMjdQMGUwVXovaDFrbmxta1hsejlSdTViVSs4djdxMitmS2xvcTBsZUwr?=
 =?utf-8?B?UmhRYnUvdldpWnNqMVBrcTJzdksyUFFmaUFsY2VRcHJ0VEo0dU83cEFKWGJV?=
 =?utf-8?B?NE9ucUdQekcrU04wTUR4ZDFuMWNrUHo5V0s3amRLSktCeFoya1QwWEZYSEFq?=
 =?utf-8?B?ZERMM25xY010SWtvckZDc1VJNTRDUnB2cXRMRUxvSGJXK0FSN0VOc3crbnYw?=
 =?utf-8?B?UXpNVXdLUnRuODZFbXhEYzRaZEhaZURQYTBxckpsc0txQitLdmNVblZHL0hF?=
 =?utf-8?B?QUZNL0ZTcG1oVkk3NnZBcGlKY24wcGJId1ZGNzJNRjVPZXNnQkl0STNKSjZX?=
 =?utf-8?B?TlF6S0dKQWtJSmRzbUllRGVvNkdlNG5iVm4zNUt3MHJqZlAvL1k1ZjR5SXpB?=
 =?utf-8?B?T2dWWUsvdHc1eWk2Yk5ZZzlWTW5ZM3BmdEFNcnl0OU1vREwwVVZrdDI4Vk0v?=
 =?utf-8?B?aG9qRW1PZTZsc2Q0NE5BbklCU0lEUnQ4SzBGVDdCekxsRGFlMFJDTFRodmFq?=
 =?utf-8?Q?4BHI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbad3c1-003b-46ad-681b-08dc28fb0b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 23:09:47.2535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYYU6YKBVJUfogUH5PGn6xYR/25Srg9nWaPj3xuZdt51x7FAhHNTNo3XhXyzS4x8EkPSBty3MsK3GTlq/lSbew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6
IFRodXJzZGF5LCBGZWJydWFyeSA4LCAyMDI0IDU6MjEgQU0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQ
ZXJyeS5ZdWFuQGFtZC5jb20+DQo+IENjOiByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsgTGlt
b25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgdmlyZXNoLmt1
bWFyQGxpbmFyby5vcmc7IEh1YW5nLCBSYXkNCj4gPFJheS5IdWFuZ0BhbWQuY29tPjsgU2hlbm95
LCBHYXV0aGFtIFJhbmphbA0KPiA8Z2F1dGhhbS5zaGVub3lAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+
IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5j
b20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjYgMC82XSBBTUQgUHN0YXRlIEZpeGVzIEFuZCBFbmhhbmNlbWVudHMN
Cj4NCj4gT24gVGh1LCBGZWIgMDgsIDIwMjQgYXQgMTE6NDY6MjdBTSArMDgwMCwgUGVycnkgWXVh
biB3cm90ZToNCj4gPiBUaGUgcGF0Y2ggc2VyaWVzIGFkZHMgc29tZSBmaXhlcyBhbmQgZW5oYW5j
ZW1lbnRzIHRvIHRoZSBBTUQgcHN0YXRlDQo+ID4gZHJpdmVyLg0KPg0KPiBJcyB0aGVyZSBhbnkg
Y2hhbmNlIHlvdSBjb3VsZCBzdG9wIHNwYW1taW5nIHBlb3BsZSB3aXRoIHlvdXIgcGF0Y2hzZXQ/
DQo+DQo+IDEwMjYyNSBPIFQgRmViIDAyICAgICAgICAgICAgICAgIFBlcnJ5IFl1YW4gKCA6IDEy
S3wpIFtQQVRDSCB2MiAwLzZdIEFNRCBQc3RhdGUNCj4gRml4ZXMgQW5kIEVuaGFuY2VtZW50cw0K
PiAxMDQyMzIgTyBUIEZlYiAwNCAgICAgICAgICAgICAgICBQZXJyeSBZdWFuICggOiAxMkt8KSBb
UEFUQ0ggdjMgMC82XSBBTUQgUHN0YXRlDQo+IEZpeGVzIEFuZCBFbmhhbmNlbWVudHMNCj4gMTA2
NzE0IE8gVCBGZWIgMDYgICAgICAgICAgICAgICAgUGVycnkgWXVhbiAoIDogMTJLfCkgW1BBVENI
IHY0IDAvNl0gIEFNRCBQc3RhdGUNCj4gRml4ZXMgQW5kIEVuaGFuY2VtZW50cw0KPiAxMDc4Mjgg
TyBUIEZlYiAwNyAgICAgICAgICAgICAgICBQZXJyeSBZdWFuICggOiAxM0t8KSBbUEFUQ0ggdjUg
MC82XSBBTUQgUHN0YXRlDQo+IEZpeGVzIEFuZCBFbmhhbmNlbWVudHMNCj4gMTA4NzQ1IE4gVCBG
ZWIgMDggICAgICAgICAgICAgICAgUGVycnkgWXVhbiAoIDogMTNLfCkgW1BBVENIIHY2IDAvNl0g
QU1EIFBzdGF0ZQ0KPiBGaXhlcyBBbmQgRW5oYW5jZW1lbnRzDQo+DQo+IFlvdSBzaG91bGQgc2Vu
ZCBzdHVmZiBvbmNlIGEgd2VlayB0b3BzLCBub3QgZXZlcnkgb3RoZXIgZGF5Lg0KPg0KDQpXaHk/
ICBJbiB0aGlzIGNhc2UsIHRoZXJlIGhhdmUgYmVlbiBhIG51bWJlciBvZiByZXZpZXcgY29tbWVu
dHMgd2hpY2ggaGF2ZSBiZWVuIGFkZHJlc3NlZCBpbiB0aGUgbmV3IHJldmlzaW9ucyBvZiB0aGUg
cGF0Y2ggc2V0LiAgV2h5IGRlbGF5IHRoZSBuZXcgcmV2aXNpb25zPyAgWW91J2xsIHVsdGltYXRl
bHkgZ2V0IHRoZSBzYW1lIGFtb3VudCBvZiBlbWFpbCBqdXN0IHdpdGggYSBtdWNoIGxvbmdlciBs
YXRlbmN5Lg0KDQpBbGV4DQoNCj4gV2hpbGUgd2FpdGluZyB5b3VyIGNhbiByZWFkIGFib3V0IGl0
IGluIERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLQ0KPiBwYXRjaGVzLnJzdA0KPg0K
PiAiRG9uJ3QgZ2V0IGRpc2NvdXJhZ2VkIC0gb3IgaW1wYXRpZW50DQo+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPg0KPiBBZnRlciB5b3UgaGF2ZSBzdWJtaXR0ZWQgeW91
ciBjaGFuZ2UsIGJlIHBhdGllbnQgYW5kIHdhaXQuICBSZXZpZXdlcnMgYXJlDQo+IGJ1c3kgcGVv
cGxlIGFuZCBtYXkgbm90IGdldCB0byB5b3VyIHBhdGNoIHJpZ2h0IGF3YXkuDQo+DQo+IE9uY2Ug
dXBvbiBhIHRpbWUsIHBhdGNoZXMgdXNlZCB0byBkaXNhcHBlYXIgaW50byB0aGUgdm9pZCB3aXRo
b3V0IGNvbW1lbnQsDQo+IGJ1dCB0aGUgZGV2ZWxvcG1lbnQgcHJvY2VzcyB3b3JrcyBtb3JlIHNt
b290aGx5IHRoYW4gdGhhdCBub3cuICBZb3UNCj4gc2hvdWxkIHJlY2VpdmUgY29tbWVudHMgd2l0
aGluIGEgZmV3IHdlZWtzICh0eXBpY2FsbHkgMi0zKTsgaWYgdGhhdCBkb2VzIG5vdA0KPiBoYXBw
ZW4sIG1ha2Ugc3VyZSB0aGF0IHlvdSBoYXZlIHNlbnQgeW91ciBwYXRjaGVzIHRvIHRoZSByaWdo
dCBwbGFjZS4NCj4gV2FpdCBmb3IgYSBtaW5pbXVtIG9mIG9uZSB3ZWVrIGJlZm9yZSByZXN1Ym1p
dHRpbmcgb3IgcGluZ2luZyByZXZpZXdlcnMNCj4gLSBwb3NzaWJseSBsb25nZXIgZHVyaW5nIGJ1
c3kgdGltZXMgbGlrZSBtZXJnZSB3aW5kb3dzLg0KPg0KPiBJdCdzIGFsc28gb2sgdG8gcmVzZW5k
IHRoZSBwYXRjaCBvciB0aGUgcGF0Y2ggc2VyaWVzIGFmdGVyIGEgY291cGxlIG9mIHdlZWtzIHdp
dGgNCj4gdGhlIHdvcmQgIlJFU0VORCIgYWRkZWQgdG8gdGhlIHN1YmplY3QgbGluZTo6DQo+DQo+
ICAgIFtQQVRDSCBWeCBSRVNFTkRdIHN1Yi9zeXM6IENvbmRlbnNlZCBwYXRjaCBzdW1tYXJ5DQo+
DQo+IERvbid0IGFkZCAiUkVTRU5EIiB3aGVuIHlvdSBhcmUgc3VibWl0dGluZyBhIG1vZGlmaWVk
IHZlcnNpb24gb2YgeW91cg0KPiBwYXRjaCBvciBwYXRjaCBzZXJpZXMgLSAiUkVTRU5EIiBvbmx5
IGFwcGxpZXMgdG8gcmVzdWJtaXNzaW9uIG9mIGEgcGF0Y2ggb3INCj4gcGF0Y2ggc2VyaWVzIHdo
aWNoIGhhdmUgbm90IGJlZW4gbW9kaWZpZWQgaW4gYW55IHdheSBmcm9tIHRoZSBwcmV2aW91cw0K
PiBzdWJtaXNzaW9uLiINCj4NCj4gVGh4Lg0KPg0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAg
ICAgQm9yaXMuDQo+DQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91
dC1uZXRpcXVldHRlDQo=

