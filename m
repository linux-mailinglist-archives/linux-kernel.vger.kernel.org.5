Return-Path: <linux-kernel+bounces-50027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53458847347
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760B51C22A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8441146902;
	Fri,  2 Feb 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vJ6eF6Cg"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC11468E8;
	Fri,  2 Feb 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888125; cv=fail; b=UqMImL3v81nZNqPiZK9tIbC5JL8Q76+33d2FQjC/qCFhYzpeSDxA3DWRrZQa+5lSo1FYFQSSZFNAkgdInsne38v/KJMNcIIPo1+rLNuqyYl/bz3IF84peUwxpyQuuOxf9N4YXWaqmKgjtN+4qsBp5u77R268KEsuv764GetEt3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888125; c=relaxed/simple;
	bh=zsJdvOIUMiwzWhT9pH/QhMz1qMnsP9WD6XkEI4inOQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ja3VCYzpuXqwaoJyj21J8prG4uxbIxw2MnrUp7R4bGGQKavx7/VchRY1UMqkF+wnpDeHNW0xvC8ZuzQJu7cAu19RiDIpu6RjGr/fjjTPvCmLkHste4vI/CSbA7TPAugVJC3E+uZg0ucO5qhagIh+oEoX7VBBXwNjq4dPT8cJAm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vJ6eF6Cg; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihOMaq1gMTcV5SQkUd48bK4HxZjCPfSgghAxtaqLkyiDGyoCiQeonQRziHtrZFzsT6zL1UEkcmprjCNUv39vWz2hp3B3orEIhI/vWQawsAkPUaTs7jijb1dDQnWNegUkPGkEeC/8G8eTS9G1V1R1fy+ntuFzvg95f+PgWazreYObpSnqkG+ZXLgp/AKbyTJsTl1XEGoeGaJ/5KC5HSHLHuG8hYo3KU7ahRrsDZnpo1SbvSnjFd4rgR7IWK9Hc82AFs1qsJjiuq/IqhVYkUaS8ogQqMsS37LdRBrE/A0hzQAGZi8iT4oG9+SiAxXl+/V610gu/QKxFIPKX96D/w1SMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsJdvOIUMiwzWhT9pH/QhMz1qMnsP9WD6XkEI4inOQI=;
 b=byxGX1GYWUAmig4d31Q4/MKBDa/EzOsRvtwpFkdfzrRFT/joAqNVNrHllYYX1fh1AVzm5BoKEiXGHofKtkWc/huu1MYi/Ir2wR/Wx18xH5egbjZa6e4E+22SLrxEHxEQBKWWcuo6oZ7S15lYjN+p2J9CzZDgz2gL14FvA26kdB+VnheXGheASAMjy/ykaY9cwd5IthOrNjQ4ro8HRfO77mCcAMmRUNdgOP36dSw0oUXvnbcR8icpb1qXqOK1czqN3m1L6Uwg7hXNAeaZV3ntTrHAxTf1m3wQCJ4lA5nUbhmVXjb4bYVpLTs1/NkEKNbDOpnFzUzG+iHO9O4iTHHNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsJdvOIUMiwzWhT9pH/QhMz1qMnsP9WD6XkEI4inOQI=;
 b=vJ6eF6Cgh6f/ZL30/KjTOBrdDbW8BvwXTJHh0EnR3yNi+1hfU5dzTjWy6sCAn0Ay9cMRuuBJ9FGyVZG5bdtv7XeF8mUSFY/jN716q52g2eGmZRbnFYSbj1byOoa+rDftCXng60FpKeV5LsUauF09NgkZB/EjjCa9zTRqPtL4nzg=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 15:35:19 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::b26d:fe6e:231:f6f4%4]) with mapi id 15.20.7270.010; Fri, 2 Feb 2024
 15:35:19 +0000
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
Subject: RE: [PATCH v2 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Topic: [PATCH v2 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Thread-Index: AQHaVbXxn3uZQDIUQEWAqG1gtcTZ8LD3Kj8AgAAEkIA=
Date: Fri, 2 Feb 2024 15:35:19 +0000
Message-ID:
 <CYYPR12MB865553ECA464FD9BFA57D1BB9C422@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1706863981.git.perry.yuan@amd.com>
 <8a55135d10cfc906616d3cd4530f9aac487c5034.1706863981.git.perry.yuan@amd.com>
 <097c6d94-2add-4c59-9ab3-8e8dbc7605c7@amd.com>
In-Reply-To: <097c6d94-2add-4c59-9ab3-8e8dbc7605c7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5eff0064-ba11-43e7-8c50-6c6d98325464;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-02T15:33:05Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SJ0PR12MB5610:EE_
x-ms-office365-filtering-correlation-id: 67eb40ce-f885-4147-588c-08dc24049024
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iDRxG1VEaf8TlcrkQc+dr1QZFOAMN9u9zce7ZBq//cZ4q1jdpXWubrRPUM+j1RwNmawEMdJIxv+Mvk32jTW7nWarQgxPdikYCVGyhmiMUtd24ASHw8UioOVwecNER+RxfyNj3yNsXTIY0yptZ7aVgoW3PcsRiek9oJiU1bHCHKp9+OZNVB6c/wZckgMH/wjG004roWkzmzkvU43dYreTrWkht5YH6fqoI7FYx/CUSNMWXzY1YXvF79n+qlEvwltFQhwl7HQxrCDeCS+YG8eOZ7a3qxeMpyNcUCTtYpdPDe4s0OToE/L6UdpufLfrvbZOAM5SefFp3B+rCFIkRtalJuTVYgWUvgbCNEs1OYnJaClQ21yQHWN0dJHgHu60Ki7HACmTF4g8X5zLSXTxBLUksYkaEz1QLNWgJJFJq1nleYSPz5n57S1tcm+3AMJ7d9cghW9yFwZonZrKH2rozpjIJHqn5M0upOeVMZIHzHUUHGHvM/FfU3y5iTN6qFSq/IsHiBceBQt2Q77X8Nx8STZtjUpeor6BiiYUYffGJ3aTQnpUx9kKHG3SkBde+M1hlKH9Ka0WyzLxRWUP23rXjccmyvNgIFExV6ggMLG5mBT0xCQPUhbTYxRITDKtQ5FpyS0N7WCyfOnGvc4mgNCH8X+Lpw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66946007)(8676002)(66556008)(110136005)(66476007)(54906003)(76116006)(64756008)(52536014)(478600001)(316002)(6636002)(4326008)(8936002)(7696005)(53546011)(6506007)(71200400001)(26005)(9686003)(2906002)(38100700002)(122000001)(66446008)(5660300002)(55016003)(41300700001)(33656002)(83380400001)(38070700009)(921011)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TCtMWFVyY1gvc2UyMkhhbXEvN0tDYnBUK2lkUitvcHNZRG9ENnVxUktrQUtt?=
 =?utf-8?B?K2cxRFlmS2dFMjRONU0xNlpFRVpRdm40eWZFYmZrNVU0OHVWWGhub0ZmWFpE?=
 =?utf-8?B?SUcreVlJL1o0Wis4ellQbldBenA0aHdaMmtEaHZmTDB1Ri9mVStITkVaQzdz?=
 =?utf-8?B?QkFoQmNqUEdMQlZLRUhwUDl3eVIxVkRad2NoRUNQV3grZGV6SjBwZjJnaUQ3?=
 =?utf-8?B?czVnOXk4c2lvRnBzYzNsdy9KM0dHRlV3M0NMNWUrNyt5VXI4QVB1V2dIRlk0?=
 =?utf-8?B?L1BkYXFsRXNENytIZEFjRE5Rc0ZFYU1pVlB5V0pjQTdnZ2ZMbTJwU1A4bXMr?=
 =?utf-8?B?NWpzYjNUVG1RK1Fyb1NwL3UyYVRQdE9yem5DUE5tVzQ1OWlwYVlQeExYTlI3?=
 =?utf-8?B?MnduLyt0WGRJa3pHZ0tvUE5JbC9tQlRXRHlUNGtGQTJ0and5MWRmaC90bkVY?=
 =?utf-8?B?R1lmSzRWbEtCa3piVXZ0VFFuUDA5NnRZZGZEU29rdStDY1NoclRlRjNHK0lK?=
 =?utf-8?B?dU1qUHJTYk4wRSsyRWdXKzgyOE83NStXTTBwWEJiUjlwQ3Rtb1ZiT2QyVGpP?=
 =?utf-8?B?NzhycW0wT3ZJTThRNlJxYzRVd1lIZDFVcFlYcXZtRSs0TjM0bmpIYUZ6M0lT?=
 =?utf-8?B?K0gvZUlVYzhQYjUyY3hpelBMRzFiNC9iNmpob3RzM1VqSk9sdUxyVU5lUWFQ?=
 =?utf-8?B?eFVKM0ozSGYvOFdwMEYrNnRzVHJJM1RweEdmV1JoWWozWmxUaXp5dzlXSkF0?=
 =?utf-8?B?dUQ1dWdEcGxVM3psMGVFQ1huQkM5K29pcVVoWG15M08vd0xXZ09LRDdxN2s2?=
 =?utf-8?B?czgycElCL1pSNXpVc29hd2E0bkdza284UmNXVEhMc2Z1N1ZKQlZLOTQ5dGk5?=
 =?utf-8?B?MndrVHRqOWV0NCt0QXpZYjBtbThDanUxSW1jWHpacHZpUWo0WDY1dWhkZnBp?=
 =?utf-8?B?bHdPZnVlTnlIVEcyb0gxcUxpSnpCcW1KWG1ibFdQaHlMVjhtWGdBR0R1OEt2?=
 =?utf-8?B?WGRFSlYzcXFwWGZGQlkzVk81QS9zUjVCcEphd0tvb1pzQVRPOGRyUTFVN0xv?=
 =?utf-8?B?TXc2aHc0cGNXL3U0NDFJdUViMzBFTXBQMTZiVXZNN1VhVVkvSHRFc2NGOEpV?=
 =?utf-8?B?UzVtM05SNjV0RkZxZDFNQnIyUWY1c2k5TkNFUDV3ODhZajkwVjE5MUJPVEZq?=
 =?utf-8?B?L0xjZXNIb1QxcjcxYlFpZVFYQVhuVVVyMk51ODJ0RGM2cnJwOWJxVkowT3lu?=
 =?utf-8?B?a1BrQVlrRFhaNlJtS09zV0t5TjRDeGM5ellXMFJFWGRmbXFCdDdSaHN3Z0c3?=
 =?utf-8?B?bVBmZm1iRmRpRHRIM2tWbXVtQnEzcXpxem5lUjJxSWlyVnRzMUZiQjRlMU9x?=
 =?utf-8?B?QUpDSi82Y3N3STRsUHdMZmNueHBFRFRDeWw3TlJhVjRTN09ISTdNd2YxK1Fr?=
 =?utf-8?B?U3BOdjVFa2Vkd0Q1aXVRVnJLemJvS0FQV2xjWWpkaFRpdG1hV0pISFlLb2pW?=
 =?utf-8?B?Wml6a2Z6T1ozY29NUEF1bldEbGVsc3ZJNDRIaWZZbHdmUmtvZTN6ZnBoVEpG?=
 =?utf-8?B?bWFHbW5qKzhEZ3A2THlTR21FT3VQeC80WWo3bnNIU21RN3c1RVhUV1dvNHhm?=
 =?utf-8?B?bnMwNlpkYmpQYjRUTmVVQWhxTTVCR2lNZ2RzZGcvMTI3ZzdYMEg3YnFLSk12?=
 =?utf-8?B?SXYzeWswVE9mTW84TGpMcnRZc1JGMlNIQ2xVRWF6VTQzeEo1SWJzb2pKK2ph?=
 =?utf-8?B?RlIyNnRtZUt3eUdvOVo0NkszR09BS1o3NSttUWtuZkdJZXZHVmVobmJJZ24r?=
 =?utf-8?B?ZVVqa0VIaDZJVE5VUGhLS2xhNExFT1EzS2FJTkVoU1Y4ZFZVNDYyQk41Z2tD?=
 =?utf-8?B?cFluUjlzRlVjWG9XcUNVUCt2eHdWbllqU0pvVENvekVUWWVXMUlXZTJFVXFF?=
 =?utf-8?B?ZnNnblpLeHg5T0Z6MnFBbEh1WUtJTGV2Z2RDNTVVNmZQM1RvYkZLVHV3d2s2?=
 =?utf-8?B?R0JENXJHWVhpZFdIckl1M2kwODM3d0h1WnZuMTg0WTJibGpmYVl2Q0FHQktZ?=
 =?utf-8?B?eXpKWm1Da2M3TFd0ckVKNU5yaENaNEQ1OXc0SDhnWVhKOUIycDJldFp5ZmNx?=
 =?utf-8?Q?llUY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67eb40ce-f885-4147-588c-08dc24049024
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 15:35:19.6347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTYsi6Vd2gfDHssmOcGKZ6gR17Z6KBilS5uhHe+jrf0XiJe55YNnHxiqMN1tiaD5xow2Ep0uPx3uPfIdBoIh3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCiBIaSBNYXJpbywNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMiwgMjAyNCAx
MToxNyBQTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOw0KPiB2aXJlc2gua3VtYXJAbGluYXJvLm9yZzsgSHVhbmcsIFJh
eSA8UmF5Lkh1YW5nQGFtZC5jb20+OyBTaGVub3ksDQo+IEdhdXRoYW0gUmFuamFsIDxnYXV0aGFt
LnNoZW5veUBhbWQuY29tPjsgUGV0a292LCBCb3Jpc2xhdg0KPiA8Qm9yaXNsYXYuUGV0a292QGFt
ZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9q
aWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVu
Z0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDYvNl0gY3B1ZnJlcTphbWQt
cHN0YXRlOiBhZGQgcXVpcmsgZm9yIHRoZSBwc3RhdGUNCj4gQ1BQQyBjYXBhYmlsaXRpZXMgbWlz
c2luZw0KPg0KPiBPbiAyLzIvMjAyNCAwMjo1NSwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBBZGQg
cXVpcmsgdGFibGUgdG8gZ2V0IENQUEMgY2FwYWJpbGl0aWVzIGlzc3VlIGZpeGVkIGJ5IHByb3Zp
ZGluZw0KPiA+IGNvcnJlY3QgcGVyZiBvciBmcmVxdWVuY3kgdmFsdWVzIHdoaWxlIGRyaXZlciBs
b2FkaW5nLg0KPiA+DQo+ID4gSWYgQ1BQQyBjYXBhYmlsaXRpZXMgYXJlIG5vdCBkZWZpbmVkIGlu
IHRoZSBBQ1BJIHRhYmxlcyBvciB3cm9uZ2x5DQo+ID4gZGVmaW5lZCBieSBwbGF0Zm9ybSBmaXJt
d2FyZSwgaXQgbmVlZHMgdG8gdXNlIHF1aWNrIHRvIGdldCB0aG9zZQ0KPiA+IGlzc3VlcyBmaXhl
ZCB3aXRoIGNvcnJlY3Qgd29ya2Fyb3VuZCB2YWx1ZXMgdG8gbWFrZSBwc3RhdGUgZHJpdmVyIGNh
bg0KPiA+IGJlIGxvYWRlZCBldmVuIHRob3VnaCB0aGVyZSBhcmUgQ1BQQyBjYXBhYmlsaXRpZXMg
ZXJyb3JzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8cGVycnkueXVhbkBh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyB8IDQ5
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAgaW5jbHVkZS9s
aW51eC9hbWQtcHN0YXRlLmggICB8ICA2ICsrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDUz
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3Rh
dGUuYyBpbmRleCA3N2VmZmMzY2FmNmMuLjRkNDI2NTE2YWJiOSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2Ft
ZC1wc3RhdGUuYw0KPiA+IEBAIC02Nyw2ICs2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgY3B1ZnJlcV9k
cml2ZXIgYW1kX3BzdGF0ZV9lcHBfZHJpdmVyOw0KPiA+ICAgc3RhdGljIGludCBjcHBjX3N0YXRl
ID0gQU1EX1BTVEFURV9VTkRFRklORUQ7DQo+ID4gICBzdGF0aWMgYm9vbCBjcHBjX2VuYWJsZWQ7
DQo+ID4gICBzdGF0aWMgYm9vbCBhbWRfcHN0YXRlX3ByZWZjb3JlID0gdHJ1ZTsNCj4gPiArc3Rh
dGljIHN0cnVjdCBxdWlya19lbnRyeSAqcXVpcmtzOw0KPiA+DQo+ID4gICAvKg0KPiA+ICAgICog
QU1EIEVuZXJneSBQcmVmZXJlbmNlIFBlcmZvcm1hbmNlIChFUFApIEBAIC0xMTEsNiArMTEyLDMz
IEBADQo+ID4gc3RhdGljIHVuc2lnbmVkIGludCBlcHBfdmFsdWVzW10gPSB7DQo+ID4NCj4gPiAg
IHR5cGVkZWYgaW50ICgqY3BwY19tb2RlX3RyYW5zaXRpb25fZm4pKGludCk7DQo+ID4NCj4gPiAr
c3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSBxdWlya19hbWRfN2s2MiA9IHsNCj4gPiArICAgLm5v
bWluYWxfZnJlcSA9IDI2MDAsDQo+ID4gKyAgIC5sb3dlc3RfZnJlcSA9IDU1MCwNCj4gPiArfTsN
Cj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgX19pbml0IGRtaV9tYXRjaGVkKGNvbnN0IHN0cnVjdCBk
bWlfc3lzdGVtX2lkICpkbWkpIHsNCj4gPiArICAgcXVpcmtzID0gZG1pLT5kcml2ZXJfZGF0YTsN
Cj4gPiArICAgcHJfaW5mbygiaGFyZHdhcmUgdHlwZSAlcyBmb3VuZFxuIiwgZG1pLT5pZGVudCk7
DQo+ID4gKw0KPiA+ICsgICByZXR1cm4gMTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkIGFtZF9wc3RhdGVfcXVpcmtzX3RhYmxlW10gX19pbml0
Y29uc3QNCj4gPSB7DQo+ID4gKyAgIHsNCj4gPiArICAgICAgICAgICAuY2FsbGJhY2sgPSBkbWlf
bWF0Y2hlZCwNCj4gPiArICAgICAgICAgICAuaWRlbnQgPSAiQU1EIEVQWUMgN0s2MiIsDQo+ID4g
KyAgICAgICAgICAgLm1hdGNoZXMgPSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBETUlfTUFU
Q0goRE1JX1BST0RVQ1RfVkVSU0lPTiwgIkMxIiksDQo+ID4gKyAgICAgICAgICAgICAgICAgICBE
TUlfTUFUQ0goRE1JX1BST0RVQ1RfU0VSSUFMLA0KPiAiRlgxOTkxMTAwMDAyOCIpDQo+DQo+IEkg
c2F3IHlvdXIgcmVzcG9uc2UgdG8gdjEsIGJ1dCByZWFsbHkgdGhpcyBpcyB0b28gbmFycm93IGZv
ciB1cHN0cmVhbS4NCj4gSXQncyBsaXRlcmFsbHkgYXBwbHlpbmcgdG8gYSBTSU5HTEUgc3lzdGVt
Lg0KPg0KPiBJIGZlZWwgdGhlIHJlc3Qgb2YgdGhlIHBhdGNoIGlzIGZpbmUsIGJ1dCB3ZSBzaG91
bGRuJ3QgYmUgYWRkaW5nIHNpbmdsZSBzeXN0ZW0NCj4gcXVpcmtzLg0KDQpIb3cgYWJvdXQgY2hh
bmdlIHRvIG1hdGNoIHRoZSBCSU9TIHZlcnNpb24gPw0KQWN0dWFsbHksIHRoZSBpc3N1ZSBzaG91
bGQgYmUgaW1wYWN0aW5nIGFsbCB0aGUgc3lzdGVtcyB3aGljaCBoYXZlIHRoZSBzYW1lIGJyb2tl
biBCSU9TLg0KDQpQZXJyeS4NCg0KDQo+DQo+ID4gKyAgICAgICAgICAgfSwNCj4gPiArICAgICAg
ICAgICAuZHJpdmVyX2RhdGEgPSAmcXVpcmtfYW1kXzdrNjIsDQo+ID4gKyAgIH0sDQo+ID4gKyAg
IHt9DQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUoZG1pLCBhbWRfcHN0YXRlX3F1
aXJrc190YWJsZSk7DQo+ID4gKw0KPiA+ICAgc3RhdGljIGlubGluZSBpbnQgZ2V0X21vZGVfaWR4
X2Zyb21fc3RyKGNvbnN0IGNoYXIgKnN0ciwgc2l6ZV90IHNpemUpDQo+ID4gICB7DQo+ID4gICAg
IGludCBpOw0KPiA+IEBAIC02MDAsMTMgKzYyOCwxOSBAQCBzdGF0aWMgdm9pZCBhbWRfcHN0YXRl
X2FkanVzdF9wZXJmKHVuc2lnbmVkIGludA0KPiBjcHUsDQo+ID4gICBzdGF0aWMgaW50IGFtZF9n
ZXRfbWluX2ZyZXEoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKQ0KPiA+ICAgew0KPiA+ICAg
ICBzdHJ1Y3QgY3BwY19wZXJmX2NhcHMgY3BwY19wZXJmOw0KPiA+ICsgICB1MzIgbG93ZXN0X2Zy
ZXE7DQo+ID4NCj4gPiAgICAgaW50IHJldCA9IGNwcGNfZ2V0X3BlcmZfY2FwcyhjcHVkYXRhLT5j
cHUsICZjcHBjX3BlcmYpOw0KPiA+ICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+ID4NCj4gPiArICAgaWYgKHF1aXJrcyAmJiBxdWlya3MtPmxvd2VzdF9mcmVxKQ0K
PiA+ICsgICAgICAgICAgIGxvd2VzdF9mcmVxID0gcXVpcmtzLT5sb3dlc3RfZnJlcTsNCj4gPiAr
ICAgZWxzZQ0KPiA+ICsgICAgICAgICAgIGxvd2VzdF9mcmVxID0gY3BwY19wZXJmLmxvd2VzdF9m
cmVxOw0KPiA+ICsNCj4gPiAgICAgLyogU3dpdGNoIHRvIGtoeiAqLw0KPiA+IC0gICByZXR1cm4g
Y3BwY19wZXJmLmxvd2VzdF9mcmVxICogMTAwMDsNCj4gPiArICAgcmV0dXJuIGxvd2VzdF9mcmVx
ICogMTAwMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGludCBhbWRfZ2V0X21heF9mcmVx
KHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkgQEAgLTYzNSwxMg0KPiA+ICs2NjksMTggQEAg
c3RhdGljIGludCBhbWRfZ2V0X21heF9mcmVxKHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkN
Cj4gPiAgIHN0YXRpYyBpbnQgYW1kX2dldF9ub21pbmFsX2ZyZXEoc3RydWN0IGFtZF9jcHVkYXRh
ICpjcHVkYXRhKQ0KPiA+ICAgew0KPiA+ICAgICBzdHJ1Y3QgY3BwY19wZXJmX2NhcHMgY3BwY19w
ZXJmOw0KPiA+ICsgICB1MzIgbm9taW5hbF9mcmVxOw0KPiA+DQo+ID4gICAgIGludCByZXQgPSBj
cHBjX2dldF9wZXJmX2NhcHMoY3B1ZGF0YS0+Y3B1LCAmY3BwY19wZXJmKTsNCj4gPiAgICAgaWYg
KHJldCkNCj4gPiAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gLSAgIHJldHVybiBj
cHBjX3BlcmYubm9taW5hbF9mcmVxOw0KPiA+ICsgICBpZiAocXVpcmtzICYmIHF1aXJrcy0+bm9t
aW5hbF9mcmVxKQ0KPiA+ICsgICAgICAgICAgIG5vbWluYWxfZnJlcSA9IHF1aXJrcy0+bm9taW5h
bF9mcmVxOw0KPiA+ICsgICBlbHNlDQo+ID4gKyAgICAgICAgICAgbm9taW5hbF9mcmVxID0gY3Bw
Y19wZXJmLm5vbWluYWxfZnJlcTsNCj4gPiArDQo+ID4gKyAgIHJldHVybiBub21pbmFsX2ZyZXE7
DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgYW1kX2dldF9sb3dlc3Rfbm9ubGluZWFy
X2ZyZXEoc3RydWN0IGFtZF9jcHVkYXRhDQo+ID4gKmNwdWRhdGEpIEBAIC0xNjcyLDYgKzE3MTIs
MTEgQEAgc3RhdGljIGludCBfX2luaXQgYW1kX3BzdGF0ZV9pbml0KHZvaWQpDQo+ID4gICAgIGlm
IChjcHVmcmVxX2dldF9jdXJyZW50X2RyaXZlcigpKQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAt
RUVYSVNUOw0KPiA+DQo+ID4gKyAgIHF1aXJrcyA9IE5VTEw7DQo+ID4gKw0KPiA+ICsgICAvKiBj
aGVjayBpZiB0aGlzIG1hY2hpbmUgbmVlZCBDUFBDIHF1aXJrcyAqLw0KPiA+ICsgICBkbWlfY2hl
Y2tfc3lzdGVtKGFtZF9wc3RhdGVfcXVpcmtzX3RhYmxlKTsNCj4gPiArDQo+ID4gICAgIHN3aXRj
aCAoY3BwY19zdGF0ZSkgew0KPiA+ICAgICBjYXNlIEFNRF9QU1RBVEVfVU5ERUZJTkVEOg0KPiA+
ICAgICAgICAgICAgIC8qIERpc2FibGUgb24gdGhlIGZvbGxvd2luZyBjb25maWdzIGJ5IGRlZmF1
bHQ6DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oIGIvaW5jbHVk
ZS9saW51eC9hbWQtcHN0YXRlLmgNCj4gPiBpbmRleCBkMjE4Mzg4MzVhYmQuLjdiMmNiYjg5MmZk
OSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+ICsrKyBi
L2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oDQo+ID4gQEAgLTEyNCw0ICsxMjQsMTAgQEAgc3Rh
dGljIGNvbnN0IGNoYXIgKiBjb25zdA0KPiBhbWRfcHN0YXRlX21vZGVfc3RyaW5nW10gPSB7DQo+
ID4gICAgIFtBTURfUFNUQVRFX0dVSURFRF0gICAgICA9ICJndWlkZWQiLA0KPiA+ICAgICBOVUxM
LA0KPiA+ICAgfTsNCj4gPiArDQo+ID4gK3N0cnVjdCBxdWlya19lbnRyeSB7DQo+ID4gKyAgIHUz
MiBub21pbmFsX2ZyZXE7DQo+ID4gKyAgIHUzMiBsb3dlc3RfZnJlcTsNCj4gPiArfTsNCj4gPiAr
DQo+ID4gICAjZW5kaWYgLyogX0xJTlVYX0FNRF9QU1RBVEVfSCAqLw0KDQo=

