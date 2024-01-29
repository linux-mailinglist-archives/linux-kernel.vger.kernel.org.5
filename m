Return-Path: <linux-kernel+bounces-42161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC49483FD48
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D6A1C20AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A23C680;
	Mon, 29 Jan 2024 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1maiZ1E4"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B43C689;
	Mon, 29 Jan 2024 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706503616; cv=fail; b=VKk3AlLy7GNMqy6qyQIgxLXdX8P401VkpRzS3qnSCyd3uOxFaXjMGeTG3ux7dcVYidGv1nyecf9aulynCApGbgKq8XL+bCpYF7pPHsl70E8m//QIbD27clJPK+/Sx02xvxZo0s9GqUnZVypIQdSjvSfMdSNuMbbVFcTWPKhKAnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706503616; c=relaxed/simple;
	bh=ZydHlg1zK+FOaB/qndHMcC8xg9g1QUgLCLP7ASj3m3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VKwmHQAl0oKaqsRhq9irB2N4LeQs2w03jEtX53fByhQl9E8mmhaH7Qr4a8r2Z6XdVIQnUDmoLSluujoFXJH9T2vZccv4am53RSCoq3ZRSTTWXHN9yunzLN+cVlwNHYObULyGwwiHduZAZAFz3c+mSFgYhufxnwEC595Wg7S7PCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1maiZ1E4; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOjtpAsSoZnpQWE4jwY9SbDsM6Cs4JO9XM4QV0/MoCg6kC1KyY+XjuD7rjrDQ6al/qTkNaF4v8qQbbVOPlRV1pyUlgiEFtupLlXwdALYYD06rf82A5XOJeWVp9wOLxCdQty36d1YplK2Xfs2iw7Rc3HJwcQTL2dcBwTY2InEWxtGrbEwtB3dUFoFUMaJZ5dY+Nb6ZroVsl6YQgrcwSvSY/9pqY1Pe6Xnaidq2DJkV75y5rykb4G7cX34MrKfRnxwyD7IHAJVg1i0oH0JIAwLpVfhCruH4GBPc8yBJwNpuBT3XCAVM12oqHBSiPpXqNh/158wqyh65H5Mida+JVjT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZydHlg1zK+FOaB/qndHMcC8xg9g1QUgLCLP7ASj3m3M=;
 b=Ck9gtKiS+7cOXo4dj7vyXJ5hcttPIMewo8T2vVBhPbgCY46wZZ+0BGGncHaCnKDIA9X9pvR0sGzwUJEkNtbQQLa0OGnK7UuXfXDjmJ7QoghAWESAbidjOiVEZ6TlzWKS0noPPYJ7LcdHqPj/6uktyBpAbDg91Ifx6lv4ZCJbR76dLIUPmLJSVyNJ3MhRER3MTwphXZO4TPMpK15bIWLIl2aiYlOevLCdgWXFAO1Unc5O+vkHwCjL4VhXhuUird0TvDajVKuBQInLapzgz5GcfWgnSYegpy77RoFrh45OGWPFSL56/EHyNmr1H2x6wn7fuQB4DHX789gM38xizda1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZydHlg1zK+FOaB/qndHMcC8xg9g1QUgLCLP7ASj3m3M=;
 b=1maiZ1E4b5C0aMyYWDRcYHUNX65x09X6nwz8lxn+1FpQv7o6Oprea1fD+/u8Xa1Bn3ewx7+9oHl3SDZCG3aHrcL8jzpY5wk8NudAVNg9w+scREliFOdIFRU3iYvsfNoXAoR7B8+emaPkY/6odI+mTB55tHPoxFysmRBmX02D2Ao=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 04:46:52 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 04:46:52 +0000
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
Subject: RE: [PATCH 1/7] cpufreq: amd-pstate: remove set_boost callback for
 passive mode
Thread-Topic: [PATCH 1/7] cpufreq: amd-pstate: remove set_boost callback for
 passive mode
Thread-Index: AQHaUDeXPHkNtlCGuUCQiOl91mfwZrDsPOYAgAP+uZA=
Date: Mon, 29 Jan 2024 04:46:52 +0000
Message-ID:
 <CYYPR12MB8655CAB5E3A351E8AC6917899C7E2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
 <3404e063b86a5517b70d497b066c3fdeb5d8bef3.1706255676.git.perry.yuan@amd.com>
 <ddc3bc6a-b120-4327-bc04-b1b88318610e@amd.com>
In-Reply-To: <ddc3bc6a-b120-4327-bc04-b1b88318610e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=93214a67-0819-4cfc-9c45-a4215b3f7124;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-29T04:45:48Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CY5PR12MB6180:EE_
x-ms-office365-filtering-correlation-id: 3c747983-0aca-418f-387f-08dc20854fe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U/1c6jfroD/vAJJNk3tcxBiNNJg0WHAjUH5Fm82GjORaWR58BAeq85vYhpjUhNQKtf3GQJb1Lq0Hklyeefj7koq0U14wcrTyg20LB7PoLPHUtRb4KDfKLRfjbsqE13tZkqdEtYOW5eXA4AlKUf3SbimMq4L28E3PsKIchinkRhuMcOmfW2inec7//kLEcrO14csXISlgoY70ktxdQFOFzYgmEsydUJgR2C/DvayyS5OGhv3gpCKcQitmcbIAEuUICl4niE5QQq6WTxoOdQN0CgY18fNdo1audLa5LJt/rhUk/NOj41XPganiyW4sqf6ai63fRWXOh2mvcG4vXw+tkFOQvyAK+QYkhLMwXp2UCviOdFYKVUEGQFIqPMdDHwReVCntXBBiWct9ospyzKRAG8p8IXuZieTej7L7d9J0v4MOOeaWoU8rvHLH+W/RUjQpqPKPhqNd9uxaY6QQTNB2RFap4b5kG17ykOMufSHoW3BjONiA+J79cUdjbQ9VmAAqcrTbkIDiEFv7ffBYiLqbEADiIedC01CWu5axrLrJLGnq1Rpsa0/vaO4/4fidMUrs86UYP7NCyJMGDjfkE6/BbN+sq3YUQk5gdNn35x3EINSCLIQBmgE/mprkoT30fZkHH8wXjJpWPdhAD4SILwW8Bw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38070700009)(83380400001)(921011)(53546011)(54906003)(6636002)(64756008)(316002)(66946007)(66446008)(66556008)(7696005)(6506007)(110136005)(76116006)(86362001)(66476007)(8936002)(8676002)(478600001)(4326008)(71200400001)(26005)(2906002)(9686003)(52536014)(33656002)(5660300002)(41300700001)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXJqVGpicHRyclRVaHVUMitTakU5VzJ6aXFyV3FXU2dYb2ZmZlNrUFA2Q0hI?=
 =?utf-8?B?akZ6UnlYUm94cUJPNzdtazVGalpxeHQ4MnQ0TzhsRDBPYzZqSEJNemdGL3da?=
 =?utf-8?B?MjJkK1AvamtwQjliaXFPMFNGUStOOUlZcW9LNm1SanUwOW1FVVdweEtEdGpz?=
 =?utf-8?B?eHE0WXUzcGRFY0x6Q3htay8yU1dUK1NpazlSWjFPam1EcmhucFpBdEg4bzc0?=
 =?utf-8?B?eHF5RmlrSW1WZ1BSVk0zcTR3VnJDdktkM092THE5aDBMQ0s0UjFRL0ZBa3Jo?=
 =?utf-8?B?cm9KOWVib2lBWG5WYkhEMi9HNm42T0U2NHpkNTZKU1czTVN3SGFpSG1VcG9T?=
 =?utf-8?B?M3FMS2tuaFlja01TZTIvMTRYTSsyMUFYV25ES1dtWmR4cHFWU2QwWFZvWERn?=
 =?utf-8?B?eGdPVkQxMXNGMEx3M0MrSCtGL1hiTFNBdUgrb3lNYjhxQ3lKMlIyTVhqYTNN?=
 =?utf-8?B?MFpHZFE4dDdEdUVzbnRHd3FieWtYZFFmVjBFeUNNSjhhamhtQ0pCRllOdWR5?=
 =?utf-8?B?ZTZDTWlHUFRRR3pqTjlwdXdkR3lzVG5mVXpGOHcyM29RdkgwcTFOcU41cG1m?=
 =?utf-8?B?bDgyOS9SWDJQZ0hGZG9US1BWOFkvemNFN212ZGVESEFidnp5M1RFU3k4TUFD?=
 =?utf-8?B?dkhjZC9WTG9Xc1YwcE93Qm5ORWt4WkdjNUJYdlVXdnZnYXpYaHN3RkNqVFlq?=
 =?utf-8?B?VUJxVDNLZUJWUUJMd1FhYllwLzVWTENXOXpWMXREZWhNcUIwZmpDN3pTM01v?=
 =?utf-8?B?eCsxb0lYWjdrZW0wZ0huaUFpczNXdzVtbGZ1YzZiNkhJTlV1VWpPVFNwZ3hZ?=
 =?utf-8?B?QmorMlhMNjk0OWZzUndjUjlrZkJ4R1NwR1d2WDgyRGpxeWJWU0F4clgzeVhj?=
 =?utf-8?B?ejhaeXoyYnp2bGl3Y0VyYW95NlBsUFFuQXErcExqb0RXUkxVTUhqckRqTVgw?=
 =?utf-8?B?OWJUVE16U243YkNpR2dGR1FHczR0UnRZL1poekpmUUZVVE4wb25DNk9RK1Bo?=
 =?utf-8?B?bkFDaDE1dW1Kemw5bkdQdy81czVjaTdobnF0TnhhUTlSSURSM2krTzkyVVFO?=
 =?utf-8?B?eXl5MGZGbE1XRzlGSDhBc0FUTCtlL3dZZWtrcnh6Ym9QUjRNdlBSNm5sdk0v?=
 =?utf-8?B?Z0FhN0xpbWI1U2U4MGdFbUtSSmw4eVhXZFVDVmdqM3ltWW0wNEVsa3V0OXo4?=
 =?utf-8?B?azVuQ3hYUGVzd05BY2hiNXEwbUs3eGFTdEhSYkhmbVlERU04VzZ5alBSSEhH?=
 =?utf-8?B?UU9uYXpjVFpybWlaeGJTL3Z4Sjk2UDRVS3ZZN3lQUUhCTVlsSzVSUzd1RE5u?=
 =?utf-8?B?a1RBK0RSSGlEekRBcTdmNHYyK3dLM1hWKy9XSkx0UTltZDY0b1BsT21qU1VN?=
 =?utf-8?B?dmpxTkxlZlhiY1d6ZjNMR3I3ajY5eFBUM2R3SDdWb0k0aHZlbFdEaTNtZVMr?=
 =?utf-8?B?a3dmS21lUWpJK0JJS0xXc25VWVQrRTZkZTNGRDRZb0QzRGpDR2o2V1lQMjMr?=
 =?utf-8?B?TmNwQWdJSmdSZGNiYUNtcC9ISFUrVlR4b0ZTaWI5UTNyYnd6d3A2ZW1mM0tD?=
 =?utf-8?B?UmNnMnlJa2RLWDBZdEZuc0swcnhyYU4zSnAzaVhlQzF6SktNYlptSldXZ21F?=
 =?utf-8?B?a21rMEF6VDNsRFB1VitIMjhXY2hMZG52bTJWZldxTk9qa0c2MC9kRVM4QnNp?=
 =?utf-8?B?UmYwSDl5d01CdE1qekp1SnBHTmlObDRrTGlMQ2h5N01aTG1vNmpLaWN5OWZP?=
 =?utf-8?B?SDRrNEowOVR4MldtUE9VWEdZeExNamZTcnVpa09leFBwbmpJb0wySHVhZWVz?=
 =?utf-8?B?a2IyV25sRnExdlAwWVZKaVhEeFBESTBFcEoxZ3FLZmFFS2hrdCt5SGFtQmlS?=
 =?utf-8?B?dVh1M3E4SFE0MzhEZlBZTjEzUzgxRUx4U0xQeUN1aWhNTTAyUDZwdWZpejE2?=
 =?utf-8?B?ZEd6YmJNOHVNS3J4WHM3cDhaUElrNmkzaG5hN3N4bmNHbm1vdXlEVEMxM0Rn?=
 =?utf-8?B?VEZSNldFYWZlZWNCbEkybU9SaURNc0sxNmo4aHpYVWNVU21MSTBaYXRBU09o?=
 =?utf-8?B?blhjd2xwdUh0MUlaOUV0NEsyUlZBUGI4dHNoZHl4YjRlbE5uc3lZU0k0VUsx?=
 =?utf-8?Q?LN84=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c747983-0aca-418f-387f-08dc20854fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 04:46:52.2531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R78ihiDFdKI5vfbSySDTuzUVnBfuoo8eqBY8g9loGyvYrhR0+a5DfyEbqc54OAAALuCKf8g2czhoMWbBE5ocvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDI2LCAyMDI0IDEx
OjQ1IFBNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb207DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywgUmF5
IDxSYXkuSHVhbmdAYW1kLmNvbT47IFNoZW5veSwNCj4gR2F1dGhhbSBSYW5qYWwgPGdhdXRoYW0u
c2hlbm95QGFtZC5jb20+OyBQZXRrb3YsIEJvcmlzbGF2DQo+IDxCb3Jpc2xhdi5QZXRrb3ZAYW1k
LmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2pp
YW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5n
QGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS83XSBjcHVmcmVxOiBhbWQtcHN0
YXRlOiByZW1vdmUgc2V0X2Jvb3N0IGNhbGxiYWNrIGZvcg0KPiBwYXNzaXZlIG1vZGUNCj4NCj4g
T24gMS8yNi8yMDI0IDAyOjA4LCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+IEZyb206IFBlcnJ5IFl1
YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gPg0KPiA+IFRoZSBmb2xsb3dpbmcgcGF0Y2hlcyB3
aWxsIGVuYWJsZSBgYW1kLXBzdGF0ZWAgQ1BVIGJvb3N0IGNvbnRyb2wNCj4gPiBtZXRob2QNCj4g
V2hlbiBpdCdzIGNvbW1pdHRlZCBpdCB3b24ndCBiZSBhIHBhdGNoLiAgSG93IGFib3V0IGluc3Rl
YWQgIkEgc3BlY2lmaWMgYW1kLQ0KPiBwc3RhdGUgQ1BVIGJvb3N0IGNvbnRyb2wgbWV0aG9kIGlz
IHRvIGJlIGludHJvZHVjZWQgYW5kIHRoZSBsZWdhY3kgY2FsbGJhY2sNCj4gZG9lc24ndCBtYWtl
IHNlbnNlIiBvciBzb21ldGhpbmcgYWxvbmcgdGhvc2UgbGluZXMuDQo+DQo+IEFsc287IGlzIHRo
ZSBvcmRlcmluZyBjb3JyZWN0PyAgSW4gdGVybXMgb2YgYmlzZWN0YWJpbGl0eSBzaG91bGQgdGhp
cyBjb21lIGFmdGVyDQo+IHRoZSBuZXcgb25lIGlzIGludHJvZHVjZWQgcGVyaGFwcz8NCg0KSSBt
b3ZlIHRoZSBwYXRjaCB0byB0aGUgZW5kIG9mIHRoZSBzZXJpZXMgYW5kIHVwZGF0ZSB0aGUgY29t
bWl0IGluZm8gbGlrZSB5b3Ugc3VnZ2VzdGVkLg0KVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2su
DQoNClJlZ2FyZHMuDQpQZXJyeQ0KDQo+DQo+ID4gd2hpY2ggd2lsbCBub3QgbmVlZCB0aGlzIGNv
bW1vbiBib29zdCBjb250cm9sIGNhbGxiYWNrIGFueW1vcmUsIHNvIHdlDQo+ID4gcmVtb3ZlIHRo
ZSBsZWdhY3kgc2V0X2Jvb3N0IGludGVyZmFjZSBmcm9tIGFtZC1wc3RhdGUgZHJpdmVyLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDI2IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjYgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IGIv
ZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRleCA5YTFlMTk0ZDVjZjguLjhmMzA4ZjU2
YWRlNg0KPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+
ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IEBAIC02MzIsMzEgKzYz
Miw2IEBAIHN0YXRpYyBpbnQgYW1kX2dldF9sb3dlc3Rfbm9ubGluZWFyX2ZyZXEoc3RydWN0DQo+
IGFtZF9jcHVkYXRhICpjcHVkYXRhKQ0KPiA+ICAgICByZXR1cm4gbG93ZXN0X25vbmxpbmVhcl9m
cmVxICogMTAwMDsNCj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgaW50IGFtZF9wc3RhdGVfc2V0
X2Jvb3N0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5LCBpbnQNCj4gPiBzdGF0ZSkgLXsN
Cj4gPiAtICAgc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhID0gcG9saWN5LT5kcml2ZXJfZGF0
YTsNCj4gPiAtICAgaW50IHJldDsNCj4gPiAtDQo+ID4gLSAgIGlmICghY3B1ZGF0YS0+Ym9vc3Rf
c3VwcG9ydGVkKSB7DQo+ID4gLSAgICAgICAgICAgcHJfZXJyKCJCb29zdCBtb2RlIGlzIG5vdCBz
dXBwb3J0ZWQgYnkgdGhpcyBwcm9jZXNzb3Igb3INCj4gU0JJT1NcbiIpOw0KPiA+IC0gICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IC0gICB9DQo+ID4gLQ0KPiA+IC0gICBpZiAoc3RhdGUp
DQo+ID4gLSAgICAgICAgICAgcG9saWN5LT5jcHVpbmZvLm1heF9mcmVxID0gY3B1ZGF0YS0+bWF4
X2ZyZXE7DQo+ID4gLSAgIGVsc2UNCj4gPiAtICAgICAgICAgICBwb2xpY3ktPmNwdWluZm8ubWF4
X2ZyZXEgPSBjcHVkYXRhLT5ub21pbmFsX2ZyZXE7DQo+ID4gLQ0KPiA+IC0gICBwb2xpY3ktPm1h
eCA9IHBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcTsNCj4gPiAtDQo+ID4gLSAgIHJldCA9IGZyZXFf
cW9zX3VwZGF0ZV9yZXF1ZXN0KCZjcHVkYXRhLT5yZXFbMV0sDQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBvbGljeS0+Y3B1aW5mby5tYXhfZnJlcSk7DQo+ID4gLSAgIGlm
IChyZXQgPCAwKQ0KPiA+IC0gICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gLQ0KPiA+IC0gICBy
ZXR1cm4gMDsNCj4gPiAtfQ0KPiA+IC0NCj4gPiAgIHN0YXRpYyB2b2lkIGFtZF9wc3RhdGVfYm9v
c3RfaW5pdChzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpDQo+ID4gICB7DQo+ID4gICAgIHUz
MiBoaWdoZXN0X3BlcmYsIG5vbWluYWxfcGVyZjsNCj4gPiBAQCAtMTM5MSw3ICsxMzY2LDYgQEAg
c3RhdGljIHN0cnVjdCBjcHVmcmVxX2RyaXZlciBhbWRfcHN0YXRlX2RyaXZlciA9DQo+IHsNCj4g
PiAgICAgLmV4aXQgICAgICAgICAgID0gYW1kX3BzdGF0ZV9jcHVfZXhpdCwNCj4gPiAgICAgLnN1
c3BlbmQgICAgICAgID0gYW1kX3BzdGF0ZV9jcHVfc3VzcGVuZCwNCj4gPiAgICAgLnJlc3VtZSAg
ICAgICAgID0gYW1kX3BzdGF0ZV9jcHVfcmVzdW1lLA0KPiA+IC0gICAuc2V0X2Jvb3N0ICAgICAg
PSBhbWRfcHN0YXRlX3NldF9ib29zdCwNCj4gPiAgICAgLm5hbWUgICAgICAgICAgID0gImFtZC1w
c3RhdGUiLA0KPiA+ICAgICAuYXR0ciAgICAgICAgICAgPSBhbWRfcHN0YXRlX2F0dHIsDQo+ID4g
ICB9Ow0KDQo=

