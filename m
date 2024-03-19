Return-Path: <linux-kernel+bounces-107187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6113687F8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FA21C20832
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E98D54645;
	Tue, 19 Mar 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DqYSeLp/"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2117.outbound.protection.outlook.com [40.107.100.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7F1E536;
	Tue, 19 Mar 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835414; cv=fail; b=sNCDSg1CNMB6ohH6vt0LM2zy72pCtGzcniEiQrsuVZRLiwPDoAFBILOnEa5GC13ZSZSXc+38Ja4rJA+Sj3kCjDXcCK/Yii8VqDujTEP1UDhvHVD/qFRWBWXKk9LKi2VgnU0/f0s3egUwcN05aW5nd4AEwsmV2zzwGlr6E9Gv6cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835414; c=relaxed/simple;
	bh=ueqLpldj/EqCsaQupTOAg2VVEZvtjM0Sa23YUcf0dYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oN3gpnJgoGeRmp5i55dblaILhFLrJA1FhGkrOWXi5d78uwchLiPNIWc3JAO2jbbH629116QBwsyZDtZHeCy3doAYrZzE+QjEoqzdGydaeXJzEv8erzIlE7WxHTwP/IzOZcGEKgl5upEqyJ7BCuaq29i73McT7FRSSVazZNTmd78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DqYSeLp/; arc=fail smtp.client-ip=40.107.100.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxN9EefD7XOzYqmdpWqLNIggR8KUi1Lsq+DAm/0iYQlKUaPD9Yppv9D9jwLcibI2mk0XKHeIdljD05RdfiOWQ/DRfISSOX6GXtZPRfhKXhS+XopKjM2YPH4YnpHsMP9pQ8vV9fTcb4SICCuhAmIyvbuy2NGJm578sa3jaU1giOfjqfx8FEVuEH+mBW3Clm54iH9Xr4VKU4DYfzjPi5VPWSQGkzoq/RPU9bGq3cMMSB9PA9/FLLB0uJYn0mg5LdeaTPjPkh32caA20xnPVR98P7QEH/QRRR6k2RFyzLietmNySe36uYy80+EAOpXWLnxwiOaXhzZXVuWsYGJQ0zU+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueqLpldj/EqCsaQupTOAg2VVEZvtjM0Sa23YUcf0dYM=;
 b=NSvAZOPzNVi346h9ENOK3JMk1yVAKIwfWnLkN2XrV9kr8H46P825/Xppkj6PesDX/e/AQPGysgGvBVtYTzZGGICxhV+ORYAozfvargmM6GDmGEO7fRvosFiKl9+dF7HuS9nPZRYqfTjc52fsRcVAOgAQwMjtNlS7jbyLkaa7jFwO1VNaFMYzq+cpm43WY5Iv38svL8JqQQgnVY29scCBLhEHp+bUS7/IDT8pVYHX7daV4SAVeTyLzstVpEz0Jc18KbQzIceK4LTSa5dERetBarwJ8OZq/Bw5GXIntQMvfuLGb2MZ1to1BDo6+BGr5fmjsHgN4So4w7HguLu+ToEKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueqLpldj/EqCsaQupTOAg2VVEZvtjM0Sa23YUcf0dYM=;
 b=DqYSeLp/eBZftnIHhwtz0OMUOFgdNerJRNkxGqQg9BchU3PMsXSQyTt4km6yrZnuLnv8k28B6Behg1iODLQuAKBhxIZB2Sl7PTcWi7bqBDyUooMZ++huuxcr7U1wJw+QlG78XBwggNpswnaPD446ANvLSw9uxa7rPzOMhBE6VQw=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 08:03:27 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 08:03:27 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Petkov, Borislav"
	<Borislav.Petkov@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 1/8] cpufreq: amd-pstate: Document *_limit_* fields in
 struct amd_cpudata
Thread-Topic: [PATCH v8 1/8] cpufreq: amd-pstate: Document *_limit_* fields in
 struct amd_cpudata
Thread-Index: AQHaeRmT1c24D/wMTU2khtx9VYhQS7E9bxuAgAFE2cA=
Date: Tue, 19 Mar 2024 08:03:27 +0000
Message-ID:
 <CYYPR12MB8655911DBA1E09CDC606E3F99C2C2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1710754409.git.perry.yuan@amd.com>
 <0988fb808bf358c98f6ae8ad8f65cb0c7e1129b3.1710754409.git.perry.yuan@amd.com>
 <CAJZ5v0gEwpcsELkHVZMp_WTPc0sLa=e2wp2v=BFp6fHrg=bvWg@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0gEwpcsELkHVZMp_WTPc0sLa=e2wp2v=BFp6fHrg=bvWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=90358bd6-0eea-41c4-a200-33816aa9017a;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-19T07:57:23Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH8PR12MB6890:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qEUq4I5nBLDCYtGvv/0qmYHKdCYKhthpkMuCayerhgLcDQzSYLmFgC+COrVPpEqAm41Yt/zUqMSPRweoXskf3Kp+vT6UqtPv6gfpFTjmbwd+1PpAveW7ejEgNK/sl3R4nG3U9e6hUSo48MYfSnbYinwMwFgNM9f5IkTpUIIWYr/ONj8RRT6Gurc+fMHWRfs2xgrDHahTepKjhZhQJYpBePMxQ21p3cslgr3lsAnMBho/1KwBtoBzodxCmXncxhJfMhSOgA6SVXQ2TTeWZUe2/pKy/CiHB23geFbZew7d/HEU9b6VJgK6GVZ4/qrZ/bgkmc4nDs7JJimmSVbdA0scfx8U4Q/uoUwLzxZpEAJIB/GCb/1B5mzYIBaOgDHZROoWrqjyjOHYfjp+S62ThBq398944XI4Gjyz96rnNSMiIQx7eILXq1VFDoYa+wiPXHeoBjGP43kzI6XpHTNuLumVQ2xAqW/JWMq3oWd8azNW0T40vUQvy8NmRvWhioR1wiPLA3DIxePxqeK6El6jaALmKATeZckKeUHPRQoT23+HwZv+VfKNPpPBim0K/TKvk2V9by9u5Q3pqtxicz9z/eZ+ohsgzwrWurUvBTxUI4xAvgwzM7FzRIfliGsDMTp3YEkX7mnh3NukavaG+KBrYYkqXxDzo1Ni+AJEquYJj+/P49I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGNDa04rK2hVL0lLaGk4V2Y5YVpUWWFKOVBNb3I1dkVPWHAzUlFWQTQ1Ukpn?=
 =?utf-8?B?SEt2NHp4ekZiMzEvSmZRYWpGeGcvdHJCWHcvczM5OUFtbWVjdWFjOGNMTjBv?=
 =?utf-8?B?NmZ1ZnNEaExkRkpZWm5SMzM2eVdwL0VLZFlscWVMRjRWY2NyQUwvalAyYSt6?=
 =?utf-8?B?MzRQR0NDVmR4Z1hsRVNIbzVpMjluNTByRlFaellPUFBXbDB4Qy8yTGVhNUV4?=
 =?utf-8?B?NXZyNSt5MEZFeTY0WHQ1UzRKR3d2VmdsK2Fzc3pqR3pQcEJUdG4xd01ybHU0?=
 =?utf-8?B?R002eC80K3lzSnkxQTZQbk5hTm51S2NIZDllcllrbkdFb2x3amtEV1hELzVO?=
 =?utf-8?B?WkxOWi81SDA3Q1hBRHRxTWZkVGJUckNOME1uOVN0M01tb3JHRkcxYnp6c0dW?=
 =?utf-8?B?SC9kT0FTYjRNY1pvQWxkdlJhVEQydERwZmg5ck5VVnM2bFZVZVhBb3h6UC9F?=
 =?utf-8?B?NXpON1M5THoxbWZYQXdNRlFYakZNeXFzekd3MUk3S1lyaXdENVZUWWFjd24v?=
 =?utf-8?B?dnQ0bVlEMGdTQmYwZmJ2YXRyZ3JCSXlzOGhFMjh4KzJKbjdXQWdLbFpUUEdV?=
 =?utf-8?B?cHpvaEowWUx6VHZDbyt3Y1p0dmhZRlpCZGtPVHArdDQ4SjJoVnhmeFhLeWVx?=
 =?utf-8?B?eFVoeGlHRXl1anU1MktaWGdVbU9jL1RjNlBuVHQ4Y1Y3alIvMkorMnU3MmxZ?=
 =?utf-8?B?SnN5TDBKem02dGNiaXErSWhzM0lwVWVleEFOSm0wQnhMb3YrdWRFRkVTUjBz?=
 =?utf-8?B?Q1ZQa0FwZzRPS0lWQ0tjTWhVZ3FwYTVuSVRoNlNTUFFhMVl4OWEwWHFuTm1s?=
 =?utf-8?B?d3FWb3h6ZHF6Q1V0cmlmWVFrWnpKWHpJQVlVcm9YaWZTaHBhOWRZL2RGcGpn?=
 =?utf-8?B?QzNjOEdmRWlSMG5EZzdQRXpZdm1lVUNTYk1UREI3b2VGNkllT1FUb1FQL0ky?=
 =?utf-8?B?WlI5czltem5RNHJWS0xrVmpxUXd0ZGp4VW42VUZRWXpjaFlrMWZiS3Q3UHp4?=
 =?utf-8?B?T3N0b0swVVdMWjVjc2lsN1NEZUxmV1U3cGszRzB3c3F2Vmkvc21FTnIrc3Fz?=
 =?utf-8?B?OXZweERkRWwwTmpxMDF2ajNRQWFwMktaWjdqeElkSlg1UnF3dHhWSjJGRXFK?=
 =?utf-8?B?RWFZc0kxYVl3WDAxTG9jZU9COC9CRnE2RmVsVFpZNE4zT243RUhyYTNrRUVZ?=
 =?utf-8?B?Vzcra2hyZDg4Y291QzhlVTlXTk9JK3J1RS9rVFZNT1hydFFlRnNOYVdpa1Rs?=
 =?utf-8?B?bUpVVXVCSGowMGtJSGxodXdxek1kRnBONkRvOUs0ODVMeEF6K05OcVVaUm8x?=
 =?utf-8?B?dXUxenFCbmZOaFd3NnUrZjB6N1pDdnY2Q2k1SHdNZ1V2ZU0xcmExTFV3NlI4?=
 =?utf-8?B?cUR2bEJyV2RTdnZmenBpME85aFk1VUs0dFpnd3FWWkhWTkZWS0J3VGhYUG9I?=
 =?utf-8?B?eUlxaFZSNWZsc29ldEVrdVRIa09VQ2sxTlpjbkhiQ3BDUVVkQ2RtUVdkNGZ3?=
 =?utf-8?B?alI1eW1iTVRPRUw2OTA0c0plcklsR1RpTGNUQ2F6REgzcSsvaFdrcVRJVHlx?=
 =?utf-8?B?RURGVGE3SG0xV2tYNUlDNEI2WXpVazdJR1BacW5Ec1VUeTNxT1E1cDBlbWEz?=
 =?utf-8?B?OFRyMkRJRVZqOTNuUEJYU2tKSjh4UkFWRDRvTEhWS0xtcFAzNFVRTEl6WkZ1?=
 =?utf-8?B?MkM1amhrQXdINGRMK3l1SXNtYy9TSFltUFhISzNHNnRybzRKSnZEd05tMzZY?=
 =?utf-8?B?anFld2JtRVB5THlCNEREMHBBeTVrNGFUbHlTcVA1WmgvdUl4Umg1bW0ybWtL?=
 =?utf-8?B?NWxERHhNeUFOTVRSOHFucFRsWGlzeXhBczNtV0xEamcvSmxWMXh3VGFYVlRk?=
 =?utf-8?B?Zy9jekhkc3kvTGFGcDB2S1ZMa3d1SzlYKy9jQ0ErNyt3Tmd1TTBKSklFbUpI?=
 =?utf-8?B?QkIwZmY0bUIwaVdUYXM2SkltQVl3Z3paVllvUFcrZzF4cnlvNTU1MEVSdm5X?=
 =?utf-8?B?RDkwNUJyU2E0QVpudHNMZ2xKOXMyYjNqMll4MnpPaFpWTVhiaWZRM0EvWFFL?=
 =?utf-8?B?SzVwS3RiUVptU0pWYTlaZ0Vua3BMTzd4NzJxQ0lnUmZ1UWxBUWVId3RqQzYw?=
 =?utf-8?Q?/xEc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db9b243-42e3-4e9b-d4ba-08dc47eb0f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 08:03:27.6644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+hfyVWoYinU06S64K0vpqZng67ySlBHgtdaDYRN2uLdgnyJba3JRRaS4OaR0A8KKXuRXwKlyWCTXb0Ipgs3EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbCwNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTgsIDIwMjQgODozNSBQTQ0KPiBU
bzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gQ2M6IHJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tOyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGFt
ZC5jb20+OyB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJheQ0KPiA8UmF5Lkh1YW5n
QGFtZC5jb20+OyBTaGVub3ksIEdhdXRoYW0gUmFuamFsDQo+IDxnYXV0aGFtLnNoZW5veUBhbWQu
Y29tPjsgUGV0a292LCBCb3Jpc2xhdiA8Qm9yaXNsYXYuUGV0a292QGFtZC5jb20+Ow0KPiBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1l
cg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBh
bWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgt
cG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY4IDEvOF0gY3B1ZnJlcTogYW1kLXBzdGF0ZTogRG9jdW1lbnQg
Kl9saW1pdF8qIGZpZWxkcyBpbg0KPiBzdHJ1Y3QgYW1kX2NwdWRhdGENCj4NCj4gT24gTW9uLCBN
YXIgMTgsIDIwMjQgYXQgMTA6NDjigK9BTSBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+
DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogIkdhdXRoYW0gUi4gU2hlbm95IiA8Z2F1dGhhbS5z
aGVub3lAYW1kLmNvbT4NCj4NCj4gTm8gY2hhbmdlbG9nLg0KPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEdhdXRoYW0gUi4gU2hlbm95IDxnYXV0aGFtLnNoZW5veUBhbWQuY29tPg0KPg0KPiBTZW5kZXIg
c2lnbi1vZmYgbWlzc2luZyAod2hlbiBzZW5kaW5nIGEgc29tZWJvZHkgZWxzZSdzIHBhdGNoLCB5
b3UgbmVlZCB0bw0KPiBhZGQgeW91ciBTLW8tYiB0YWcgdG8gaXQpLg0KDQoNCkdvdCBpdCwgIHdp
bGwgZml4IHRoaXMgYW5kIG90aGVyIHR3byBwYXRjaGVzIGZsYWdzIG1pc3NpbmcgaW4gVjkuDQpU
aGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4NCg0KUGVycnkuDQoNCg0KPg0KPiA+IC0tLQ0KPiA+
ICBpbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaCB8IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9h
bWQtcHN0YXRlLmggYi9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+IGluZGV4IGQyMTgz
ODgzNWFiZC4uMjEyZjM3N2Q2MTViIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYW1k
LXBzdGF0ZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9hbWQtcHN0YXRlLmgNCj4gPiBAQCAt
NDksNiArNDksMTAgQEAgc3RydWN0IGFtZF9hcGVyZl9tcGVyZiB7DQo+ID4gICAqIEBsb3dlc3Rf
cGVyZjogdGhlIGFic29sdXRlIGxvd2VzdCBwZXJmb3JtYW5jZSBsZXZlbCBvZiB0aGUgcHJvY2Vz
c29yDQo+ID4gICAqIEBwcmVmY29yZV9yYW5raW5nOiB0aGUgcHJlZmVycmVkIGNvcmUgcmFua2lu
ZywgdGhlIGhpZ2hlciB2YWx1ZSBpbmRpY2F0ZXMNCj4gYSBoaWdoZXINCj4gPiAgICogICAgICAg
ICAgICAgICBwcmlvcml0eS4NCj4gPiArICogQG1pbl9saW1pdF9wZXJmOiBDYWNoZWQgdmFsdWUg
b2YgdGhlIHBlcmYgY29ycmVzcG9uZGluZyB0bw0KPiA+ICsgcG9saWN5LT5taW4NCj4gPiArICog
QG1heF9saW1pdF9wZXJmOiBDYWNoZWQgdmFsdWUgb2YgdGhlIHBlcmYgY29ycmVzcG9uZGluZyB0
bw0KPiA+ICsgcG9saWN5LT5tYXgNCj4gPiArICogQG1pbl9saW1pdF9mcmVxOiBDYWNoZWQgdmFs
dWUgb2YgcG9saWN5LT5taW4NCj4gPiArICogQG1heF9saW1pdF9mcmVxOiBDYWNoZWQgdmFsdWUg
b2YgcG9saWN5LT5tYXgNCj4gPiAgICogQG1heF9mcmVxOiB0aGUgZnJlcXVlbmN5IHRoYXQgbWFw
cGVkIHRvIGhpZ2hlc3RfcGVyZg0KPiA+ICAgKiBAbWluX2ZyZXE6IHRoZSBmcmVxdWVuY3kgdGhh
dCBtYXBwZWQgdG8gbG93ZXN0X3BlcmYNCj4gPiAgICogQG5vbWluYWxfZnJlcTogdGhlIGZyZXF1
ZW5jeSB0aGF0IG1hcHBlZCB0byBub21pbmFsX3BlcmYNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+
DQo+ID4NCg==

