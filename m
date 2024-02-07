Return-Path: <linux-kernel+bounces-56586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86D84CC12
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E821F2637A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB6577F2A;
	Wed,  7 Feb 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z1j9azM4"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A977F08;
	Wed,  7 Feb 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314092; cv=fail; b=E7F0Xp4pRxjDIyPZ1PFId60VU6Sh694NbqyYghGcc1hh5TJPJM7I8WP7h8GymFReMqHuioDqnUYe0GGk0mx7d33wIuoqh8cdhwBGCb0t5h9bxEri/zt9ihlSIgH1nZAKy8/qvSkOiBPqMqanOe8qDB1Blv9rut1Jdmlx2SAnwOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314092; c=relaxed/simple;
	bh=yinglcrRqxrZOgl+48+kPhzuuLHcjs9yNGQGpSyJzWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ghxqIzlcZTVLLdIM3fXO9XBKdBG+Faq2U8lht4x6Sjf1DjDfJxu6V30xKwJ3GySSDhQjDuZui/0jCBrQlEd29Pu9GFr6i0rdLBKpazI1Z81ZFgTpgQ7/KQIV0q/BLdnjxl0mxeoHNj693Wf24BQTZP9ENw5l4d4SZ2nqpkN0oOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z1j9azM4; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViZHj4V+3EFcylHpHri4VJGam07yP/X+DI7ZOqsmDZmsqXLUq32LpuT0h9xLJceE5Q58e1LpLZ+tDeAxbZCJR5sh7aer7c+47sGieKAP23zFsUc2dvxpcDSF0ECppt2PFbmw5YLO/e9EA81jjMJ97TkARzmWursofBLCDSo6sB6ep651F7ccwC1/VBBHrCXyiuIG3+6gVnForo8SpK3X98O3X57aMSlEGQx2mB9YbVBQvCr7aLynk9z+MgV3blogesKWxhA+PBZ4sLjVQrPrOLui/b+HbERzhx0atjHgJfV+3sJgtG4Wx2nFa3VxovyyBKBz+TNK7sZ6Lf9FokrNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yinglcrRqxrZOgl+48+kPhzuuLHcjs9yNGQGpSyJzWk=;
 b=IFIFGY/JV0hQyuwHRasYrmbJLkgEwPeEphYc9NySntcDhlUffPbgAlWbYurNK7rGNAwEpBdm/f1Cw++QVYXU2pAkaAmIKeEmM2vlb9C7ec/TDBM4BcesTWUTDHJucW+FWaNZ8hN/YQWZ8qPwmsuwfh62njV4VkoBr6DzApIIB0YRU5lFo5lQZmvb9xwD78stO12ajK8xgkBPUr2zZb3sFg6U0MsZcyJFa6CmTSwoDNWmc2x53ahd1tfj13fW4XdESHWVPaCn2RmUPcA20dQdqg1FhyaJ9IW7KDhv5I4cKrejt3XaudEYyX+TVY3vT4A+u/l2QKSIaYDp+5Kb4AChyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yinglcrRqxrZOgl+48+kPhzuuLHcjs9yNGQGpSyJzWk=;
 b=z1j9azM49BUTdb8vMvb8zUBj4fwo3aKAL47lkQZsgyL0NMls3pTuuwWCzr6/KnPFHLckqJ/QKsLRKVnJKunloW8dcHQClWAgyAh5NDzCryFxsriXJn/TD9vbr9p6V6g0tycSdw4JZ+9eo9LVPCh15lJyNAmxFe3d9xoxOis20yQ=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 13:54:47 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 13:54:47 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Tor Vic <torvic9@mailbox.org>, "Huang, Ray" <Ray.Huang@amd.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Oleksandr Natalenko
	<oleksandr@natalenko.name>, "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH][next] cpufreq: amd-pstate: Fix min_perf assignment in
 amd_pstate_adjust_perf()
Thread-Topic: [PATCH][next] cpufreq: amd-pstate: Fix min_perf assignment in
 amd_pstate_adjust_perf()
Thread-Index: AQHaWcbZToxr2u2/5kC03D3p3PrDbLD+3ddA
Date: Wed, 7 Feb 2024 13:54:47 +0000
Message-ID:
 <CYYPR12MB86558F397CA052AAAB772FDB9C452@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <41f82085-8ea9-4ffa-a93a-8e39ce0f4c27@mailbox.org>
In-Reply-To: <41f82085-8ea9-4ffa-a93a-8e39ce0f4c27@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c9e1a71e-860d-4d3f-95b8-f2f519746055;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T13:22:28Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SA1PR12MB7247:EE_
x-ms-office365-filtering-correlation-id: 8fd52dc2-4e05-49c5-9c6c-08dc27e458d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IXAATXPBR1ad5GzkZUGsbTVU7/Qtuuu0gl+FzqwEo//an50PIhocXr0+iQTVebgZab7eZgViUAQBe3G5TN3UGd9E3jCPuCrf46laYkINLUGD72hSwmK9dLrqHUDgSv5EGnwrUTuTtIDyGlAhCRZPmx8z9J7PAEh5VP3WMr+leO0BDjIpdqbpBtbUo4j9IoCef9tXJ07Xlhnl553zwB86HxOaQCqrBlNXwB67yCv75WyKsXRiicGZxv9YTqwoj6q0NAeDjDwzG9e/PQuLb5Di7vD/tpr8r2PymsWRZLpz/f0n3O910kkbl2/VO0vNGrIJ+DU3L8gCsP69bq3x1Br2OCy4Qqs0g9nxJz93cAvfSz8UFEcNbfrANGcELWcDuNvFrqJXE0HjF7tiwW4Oq6RsgRUkbDWi/6DhFktTZVRb8MnzpWSJkzz4CllQFqw9HIilMgnPReyjR8uNIo2RydgN16hu8vp4w3MRlhfaDi8ILcq8OpHBuuecw+EXwKhGUuS6A93+ApNjC6hMdQt+Cc6buZkctf6elEZ9VPCnOjyZPbhx1QTOZb10G+jAe8EnuNt2Ul8VRpwYGVJTfQmjwNXKZ9Ar7jkgLGFRaHlgvFH+lj1ltiJSxDhNIdIKw742kDR2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(33656002)(55016003)(478600001)(53546011)(9686003)(38070700009)(86362001)(4326008)(52536014)(66446008)(41300700001)(83380400001)(26005)(71200400001)(76116006)(6636002)(7696005)(66476007)(38100700002)(64756008)(66946007)(8676002)(5660300002)(316002)(122000001)(8936002)(54906003)(6506007)(66556008)(2906002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nkd5Y3hLc21aZnFCa3diT256enhUeHNMWkI1eTlTNnhYQ3VjMnUzUEtvR1k3?=
 =?utf-8?B?YUpYVW1WZEptd2tjZ2tJYlEzOFExNllsK05NZFF6cllVd2VYeVlPdU9Ud2dG?=
 =?utf-8?B?U3AzRFlnYmZ1aldXTXVpUkprK1pQU0dlYTlTbTdBS2ZwSDE5cmxGWjVWUDNF?=
 =?utf-8?B?TE1oL05LeXlid0pDd3Y1bzNpcmNTbnc0am5SMkx1WVlxYW9kR2thNjdDOWJk?=
 =?utf-8?B?b3Y0WjdnN0tIaE9CdXkvMndUTm5oVGhySW5oTGllZlUzalBqaXYrbmx3cjF2?=
 =?utf-8?B?OUdhREJYU1hlMHA1ekZ3eTd3Tmk2TE5XTnEvQTgxMkhKeDJuWlJkTVpCNmJT?=
 =?utf-8?B?T2I5cDlhRHNUMHpJcm9scWI1eGFjek1BN3FNa3hXKzZRSUd4Qzg3cW1ZNS95?=
 =?utf-8?B?ZXZubW1mOGE5NWMybCtBODBSZm1PK0N1N3M0V0M0bWo1SUk1WkszNktWS1Zk?=
 =?utf-8?B?OHRESWorVjBvMHRhNG5lK1ZQWnNpVTlMVHR0cHBxQ2VTY1NXclBLeUxlWVV3?=
 =?utf-8?B?VFRBK0lNMDgxN25sL1lrcSsxR29iNDFQZDVWaGU4L3BUSzhzQldYeWJrTG5y?=
 =?utf-8?B?V0lsMllnRkpSS29XV2VOeGJjaXN6RlFING80cWszaVYvaHRXZCtKNHN5YXpm?=
 =?utf-8?B?WnFXMElKT1NoVndYakxDR1JYMFJZNktPSWp0S3BaSURnVHo1cjdtQjRDajA1?=
 =?utf-8?B?QWsyMlR6TWwvNDVxOGYzRDIzOUJkNFdqTEkrMzBVcjMzV1BxbC94ZVlHOGY0?=
 =?utf-8?B?TURhazdMZ2pqZjZGcEZIcGJ3MHF4SzFHZ0lua3lFUlV2dmhGdDlBci9EQmhR?=
 =?utf-8?B?RXBPL0drN0IwY0VPUW9ycXVNYzdRejBTYWdONXBXMkxUU0JzR1lZMkM3WlBH?=
 =?utf-8?B?TEViby9YcjRhMlJkMEx1M2htK0tyK290WlZZMWtURXc1WWJNeEJzdUFVa3RY?=
 =?utf-8?B?em93T3VidC9paS9uU3FnQkhnRW5tT3E2V1ZzUHhjbFZlem9SMk44dFd3QmlS?=
 =?utf-8?B?VUZZT3l4c1orbmZtNkRIT0liZG5NRndlMEt2b2pTTjVuUmkxSzZPQllUdy81?=
 =?utf-8?B?dDNHYi9yQlo5T0U3L2Z6cUNvWFkxcnZURy9RLzRDaDE0S3NJYVdaeG5udUNW?=
 =?utf-8?B?Ym4xQ0svMG1JR2xRSjlUMzFLb05EaWM3MFFjL1VSeEVCSG16WmN0VDQ4aFJP?=
 =?utf-8?B?VHE5RW9KZENreUZiVnhiZ09JT29iTS8rWVpRenNXbkpSbXNlRUpCU3BCN1Jn?=
 =?utf-8?B?STFGUXg3OXJFNHBXWkRVUyszcjRsYUh5WUZJK3ZWeEMvZWVCS0xseE1wdjRl?=
 =?utf-8?B?UXdsWEVvRmdDMHMyRFZOU1VqNXpDT3RIMmEvaVFiU3poOVpJTmJ4SXZjS0lo?=
 =?utf-8?B?UHR1MFArcHpLbWFKcTJYMUJ1TWlmNngzTDlWejhURUNGRUp0Y2RxaHpTNE9S?=
 =?utf-8?B?YnF1Mk5OSVJxdSs0TldvZ1hUYVljNFlnQ1pnTjRZUnRBUnZrU1Bja2JUSnMz?=
 =?utf-8?B?Q0lERDdjMzlSMnhlMHVpWTI3VTNrbXhIVEVjNzVLb2MxSEJRbi9taFdSTEZK?=
 =?utf-8?B?aVl2c012YjBaM2JPTTZhcnlYc3dBZmx0b3ZxeEk4RWViMksxbVVrVldXZ1JC?=
 =?utf-8?B?amdkRUVZTC9Xd3c4RDR2bEJpbDFVNkgxcVFuRE5qUUZFbEVrWGZKOXR3VmxU?=
 =?utf-8?B?RWRrL3FkMFFwVDJJY0s4aTVIYUVPbzFNaSt0S0IrdmJmN3RJMG1mQjVidzlq?=
 =?utf-8?B?RldQTjZpcHc1b2Q5andnc2tWTE9mTy9neEx0Uk9kQlFoOWdBeU5kWGVrRVNS?=
 =?utf-8?B?clAxSGIrNUdwUmF4c2NVMTdDbTB0VVovK0JxRy9kczc5M000SGRESElSME5i?=
 =?utf-8?B?WWdlN2pXZjJuc0ZVeTgzRnVMQ2xURjdLdTdPSEE1MWFFTjhCMHZCNGZ4QTZD?=
 =?utf-8?B?aVl2WW9OVW9EYmZ0S01UclBCNHEyb01jRDNQbG5qS1lhQ1VhdVdwNzFsdU9s?=
 =?utf-8?B?bGllZG9NYnluaE16OXFCS2s3OGdJaGRLNFNqcHFRMHo2TXlnM0RUYVN1Tms1?=
 =?utf-8?B?NVRRSnM4S21xQkZZNE8xN3RkU0c1R2NDVHNrUHpGaFNEYXU2YVRkMmZkdnpv?=
 =?utf-8?Q?pbbc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd52dc2-4e05-49c5-9c6c-08dc27e458d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 13:54:47.5806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjuiwp7S8SWGF7S+ArKAngD9HYZakvBUR5JC5zK1o5xdN66s/9z8mwJc+2zCMXZcinpv/lzQznCKO5BDG8wgNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCiBIaSBUb3IsDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9yIFZpYyA8dG9ydmljOUBtYWlsYm94Lm9y
Zz4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA3LCAyMDI0IDk6MDkgUE0NCj4gVG86IEh1
YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgWXVhbiwgUGVycnkNCj4gPFBlcnJ5Lll1YW5A
YW1kLmNvbT47IHJhZmFlbEBrZXJuZWwub3JnDQo+IENjOiBMaW51eCBLZXJuZWwgTWFpbGluZyBM
aXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtDQo+IHBtQHZnZXIua2Vy
bmVsLm9yZzsgT2xla3NhbmRyIE5hdGFsZW5rbyA8b2xla3NhbmRyQG5hdGFsZW5rby5uYW1lPg0K
PiBTdWJqZWN0OiBbUEFUQ0hdW25leHRdIGNwdWZyZXE6IGFtZC1wc3RhdGU6IEZpeCBtaW5fcGVy
ZiBhc3NpZ25tZW50IGluDQo+IGFtZF9wc3RhdGVfYWRqdXN0X3BlcmYoKQ0KPg0KPiBJbiB0aGUg
ZnVuY3Rpb24gYW1kX3BzdGF0ZV9hZGp1c3RfcGVyZigpLCB0aGUgJ21pbl9wZXJmJyB2YXJpYWJs
ZSBpcyBzZXQgdG8NCj4gJ2hpZ2hlc3RfcGVyZicgaW5zdGVhZCBvZiAnbG93ZXN0X3BlcmYnLg0K
Pg0KPiBGaXhlczogMWQyMTVmMDMxOWMyICgiY3B1ZnJlcTogYW1kLXBzdGF0ZTogQWRkIGZhc3Qg
c3dpdGNoIGZ1bmN0aW9uIGZvciBBTUQNCj4gUC1TdGF0ZSIpDQo+IFJlcG9ydGVkLWJ5OiBPbGVr
c2FuZHIgTmF0YWxlbmtvIDxvbGVrc2FuZHJAbmF0YWxlbmtvLm5hbWU+DQo+IFNpZ25lZC1vZmYt
Ynk6IFRvciBWaWMgPHRvcnZpYzlAbWFpbGJveC5vcmc+DQo+IC0tLQ0KPiBJSVJDLCB0aGlzIHdh
cyBmaXJzdCByZXBvcnRlZCBieSBPbGVrc2FuZHIsIGhlbmNlIHRoZSAnUmVwb3J0ZWQtYnknIHRh
Zy4NCj4gLS0tDQo+ICAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDIgKy0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgYi9kcml2ZXJzL2NwdWZyZXEvYW1k
LXBzdGF0ZS5jDQo+IGluZGV4IDA4ZTExMjQ0NGMyNy4uYWE1ZTU3ZTI3ZDJiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ICsrKyBiL2RyaXZlcnMvY3B1ZnJl
cS9hbWQtcHN0YXRlLmMNCj4gQEAgLTU3Nyw3ICs1NzcsNyBAQCBzdGF0aWMgdm9pZCBhbWRfcHN0
YXRlX2FkanVzdF9wZXJmKHVuc2lnbmVkIGludCBjcHUsDQo+ICAgICAgIGlmICh0YXJnZXRfcGVy
ZiA8IGNhcGFjaXR5KQ0KPiAgICAgICAgICAgICAgIGRlc19wZXJmID0gRElWX1JPVU5EX1VQKGNh
cF9wZXJmICogdGFyZ2V0X3BlcmYsDQo+IGNhcGFjaXR5KTsNCj4NCj4gLSAgICAgbWluX3BlcmYg
PSBSRUFEX09OQ0UoY3B1ZGF0YS0+aGlnaGVzdF9wZXJmKTsNCj4gKyAgICAgbWluX3BlcmYgPSBS
RUFEX09OQ0UoY3B1ZGF0YS0+bG93ZXN0X3BlcmYpOw0KPiAgICAgICBpZiAoX21pbl9wZXJmIDwg
Y2FwYWNpdHkpDQo+ICAgICAgICAgICAgICAgbWluX3BlcmYgPSBESVZfUk9VTkRfVVAoY2FwX3Bl
cmYgKiBfbWluX3BlcmYsIGNhcGFjaXR5KTsNCj4NCj4gLS0NCj4gMi40My4wDQoNClRoYW5rcyBm
b3IgdGhlIGZpeCENCg0KUmV2aWV3ZWQtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNv
bT4NCg==

