Return-Path: <linux-kernel+bounces-166780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EE78B9F6E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D4C1C2228F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85516F91B;
	Thu,  2 May 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aNELMN+c"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2137.outbound.protection.outlook.com [40.107.14.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81B13C820;
	Thu,  2 May 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670693; cv=fail; b=fdOFTz1h3bsiv+dwdKwaC9hWhlrjrr/dbkO510wQhj8WXfU6khYtBxyTWzx1z7En3BqhTKQtmV0mQeDduynW9ZV4DrxySGxgRNtvE+n5rtMAQ8+gi0jcHbpulqB9rHyIxJxqT2LW6Fsz4vyYACJzTpSn8mZ2bWSnA0dfKqWiPsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670693; c=relaxed/simple;
	bh=p8OouVJoWf+ZQVq8B1HdAMnvZPXorJHazR5tnL+KIzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VXavPjKUerS9hxbaZ81vBgPTzoAwixCXonJdu81TA6wCfD5+h42brrbpPqc06cdvKuATlk8RTEq2Q05vC2bfedrH9oOLbq0TvAzSrUcdf2L12lPdhqYvUyXByh6rwlzdst7GI9qMwUOIZBbI/6YwV4BsLurP0KGIiV5kbF7BTrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aNELMN+c; arc=fail smtp.client-ip=40.107.14.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOA18RTiX864k2aF4BenK7X7KEcpfwtgVllc33w+WK3I/JHcT1MSFSH7TbrBHE1mDcp2noGDvwmq8WtDSu2Xp8ImbIjdIAuoRGT3zqgoMFwpDhVmpy8gexjgzq7zXYK0YnCzOr4TtEG76U8aO/uNV8zlQYODAwYCut1VAm/GxcD9yWgi84Iq5jMfC2QXQWJusouryIBLFSMQAjzMjo/N4CfjJIYw53v6iqHVR4VCKnI68qzI1L18YGxVNm9ycW4RvzFCq3ZPp6c/rDUVHu+h3wympmXNIDocqMDjLPgTSdE8UaXML+zcTV0zyHRQ5QVrJ2y1WIeseyDU3veaYdhKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8OouVJoWf+ZQVq8B1HdAMnvZPXorJHazR5tnL+KIzY=;
 b=f/UGtzzCE456bqS4o4XOQaZZS1Gprj4vDEjq5IykcTl0uaiju7lLEF8PYvf24fsVFcVtOTAVTjF3tRpXzIN2FUh3O4Ipv5lCnSivD7Udm4LrQrePRWDTxSrig5Wbb8FeVIxBe0n7OnKNWhLcmxQT68KEvjJmQTEw5Spw1ceTKKjoD1mIImxLWdMlSMoY/6c5xvs0EZsrp+l9/u4BtpxoROOiS5g1+zYjb0ggdz2WULsIhw5SyRDLrmgeH5reALgSaZRg32ZyxjFeDcOXZdRUYQZstHuH7NZCCQhtUlMejtAwkCiU3lsAZpsD7dChG+bEsxJNuwvOoMDjYyY4DpYXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8OouVJoWf+ZQVq8B1HdAMnvZPXorJHazR5tnL+KIzY=;
 b=aNELMN+cARY4HVZWk++n0Nl/mEyyEcp+KecEI4mFyq27OL0AizBytICovlUVjaPrVTwssl/0uGrFKaRXqo1WUabNQbVId01SowSwcMAOgsI8jvqmwyrhRWt0lwZFFtYPO810uUBMP+i3oLj7MYvS/NnSY8nNxcsRs2Y8Nu0yLEE=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8315.eurprd04.prod.outlook.com (2603:10a6:10:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 17:24:47 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 17:24:46 +0000
From: Josua Mayer <josua@solid-run.com>
To: Rob Herring <robh@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Topic: [PATCH v4 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Index: AQHanIzFj3t0e7qcckiINn2lwLvOULGED0sAgAAi3AA=
Date: Thu, 2 May 2024 17:24:46 +0000
Message-ID: <772ded45-9c92-4607-ae03-d8bc32744ea5@solid-run.com>
References: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
 <20240502-cn9130-som-v4-4-0a2e2f1c70d8@solid-run.com>
 <CAL_JsqJGO9W5ysX_OWhP--8TGXiY19d5TeDL7Ne8rmj+GgWCcQ@mail.gmail.com>
In-Reply-To:
 <CAL_JsqJGO9W5ysX_OWhP--8TGXiY19d5TeDL7Ne8rmj+GgWCcQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB9PR04MB8315:EE_
x-ms-office365-filtering-correlation-id: 9b4cb1c9-dba1-46fa-eaac-08dc6accc3a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnA3TW42ZVFoem4wZmt1NHpwSC9OeG1FVkJQMFIxbVlIYnE4WlBwTGtsc3BU?=
 =?utf-8?B?ck1Ka0p2OVpIMit2RGd2L2U2MDk1SkJCTm1USjhaWE13ODdsYk01TXRvcmk2?=
 =?utf-8?B?Z3I2K0p4cXdPMll1SGlyelVTR2h3dXh6NXRBaS9lOFBxY2l5L3daRlI4U3d6?=
 =?utf-8?B?dEluQ0NENytYMmhoYXhjQWhKZWsyeC9aWXNSMTJHYlRuWFZhSEU2alh1Vi93?=
 =?utf-8?B?WVFmaG0wRFFuRWdtTU1jdXBndVdNbmtSUnFUR1BMR3dPQ3RjZTl1TldFOEVr?=
 =?utf-8?B?RW9UQTBxaGhvNjVoL0NCMHRwWkpoeEY1RkwrZTdLUk5KU1hYVFQ0d3VzTFlT?=
 =?utf-8?B?alNUcUJHUGFiNzAzSWduVk5NTXhmUDN4bHhDTHRoY2lOTHN1RThVekVPbi9I?=
 =?utf-8?B?UDRYcGdiK2tqTDJqUHluNk9vTWdQNXB5ek1rVXdHekJOcnQ3YVFkQ1hGRmZx?=
 =?utf-8?B?OGNnNit4VnNKWkZyc0FJNVErN0hPL2YzYWdQK0tQckJvNytycXFGczExM2o4?=
 =?utf-8?B?QzRqRU1rUDRvZXR6aWFQWlE1SUdXcm55VysvdENJZm43NTM2V3pxUmpuck1Y?=
 =?utf-8?B?RTFOZXJvK0hicnZtVEs2MGZtVUZadjdwUFVBMkMwMytFbFV4QmFKc0FnK0RZ?=
 =?utf-8?B?aUR6ZGIvbmsvbDYwY21TSzdkc0ErR3NVY2wzRHExLytQem1DcFhyc3did2F1?=
 =?utf-8?B?L3RGZTUzN0pVd1FDZmI5czJJUGgwaVlMVGlVVU00K2xvU3djRW14bGFTeWRw?=
 =?utf-8?B?RkFCcU5MeHN6MXByZmxPM1V1RmRJWUJ4N2Y0Y2N6OEVkdGNlQnNuOXNQMWd5?=
 =?utf-8?B?WVpJaC8zTFhOei9QY2ExamZLMlhlZXlxN0RNNjZZODZUS2JzT010UjgvS3l1?=
 =?utf-8?B?SUxIc09oRXFjUGYzZEV0V2VmRkRhYUVRVzU2L2daMys2UGdKblprR3dzczVy?=
 =?utf-8?B?alY2RGQ5NHhBckpwNVR2a0QwMjIyOSt2b2h5MHpsQnJhd0h6OFpVbFM1VkdY?=
 =?utf-8?B?WUduZE4yZ2lVNFRjZzdNZ05FZk5sM3NPSFNvNVdSNWRNQTB0eEFoMnB1anF1?=
 =?utf-8?B?REsydkN2NFZsVk9VYmg2aG9ZenlodUxmblV2KzZxVlRPWHZ5ejVsbVR1L0pC?=
 =?utf-8?B?dkl4MXdEUmE4MXFKdklXbUk5UFdvU1BFdlpUdGhNMzZSRDNmSm1PSFZBM2dF?=
 =?utf-8?B?NGo0Y0FiZkFwOG1XNWNpTEE1eUpoOUxKQWpUR1V6NUFSRHVKTmZqK04wRjJM?=
 =?utf-8?B?ekRVWWl0UDUwUkhFL0NTNnU5NEZqVlE4ZnFDQWpJUWp6T0ppT3p2QWR6NUJ4?=
 =?utf-8?B?ZEVlM0ZDRVJQeGJGZjN0QjVKSmppZUFMOWZaaGxtK0tYOHlRUFlZSWE2bWdu?=
 =?utf-8?B?M3IwbVBLMUhVSDZXSDBKZ0JQZE40blI4cEZMWlNGdXc3SFd4ZmNFK1dRZnFI?=
 =?utf-8?B?WHZYelNCNkVQeWxPaFBaVnN2UytCVWp3bU5IMUZxZEVUMzk2U1hQdkdvejhu?=
 =?utf-8?B?N09PdHA4N2VSTkZiaHZ5R2YrZGJVMjlWMUlXMDFSYW9qWnh1WGFUNHRjTDV6?=
 =?utf-8?B?RENlWW1DQ3oyNFhXRjNRWElLMWFXSlVaVW1IMnRXZjk4ZVZveUZoaVVJdEN2?=
 =?utf-8?B?Mk85ODJLb091QjZRSS96RTdLL3VNSHVPSzgwSnk3Q0lnQ3JUVkw1V0I2UXJq?=
 =?utf-8?B?Y014akxaU2JpejNIUVArU0hCT3lDRVVkeXNPWUh0WFpFSTdLS0xVcC8vUFly?=
 =?utf-8?B?d1VCZXZyNDgvbWtyUkovWUoxY05BNjRnTy9hV29KK09lOUtrMGI2ZmNYdlV5?=
 =?utf-8?B?ZDBKNUlWaHlCK1QxTkg3dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym1DQlMvSnlBYlBFMzRTckhIQ0MzZElhWTdWaG1IaHNld21weCtTTkRPNTZX?=
 =?utf-8?B?OWxxck54MCt4dWFEODdCVjNKY0k0WjJ6QlZhVWhaR2xOSCtDNmpWZE13a2o4?=
 =?utf-8?B?NE1nU2JkTG9HY2VaR2tzQW1YN2FjdFpSOHFydjk5dzVrMjdXU1p3ZzViaG1h?=
 =?utf-8?B?UVk5dm95ZDE4NmxJZCtqYVpVYTZGOUluVFBWc21FNnBJOGc2SCthTFpUSEhQ?=
 =?utf-8?B?cEIyWVlidEVFcUJXK0VDMjVxdDNINVBiUzh6MmUrdzUzTkVKSktPTGJ4SXIv?=
 =?utf-8?B?NEpUNHJmbTFoaWpJZFFRdzlCUjRCaE53MURHOFFuQUw2dXkxWlBJeUY2WUxx?=
 =?utf-8?B?bzVsRnZjOUNkNWYxNUc3aFdDR0FzUlRZSFBKV2lvVDJyMW5HSEEvUXRJeE1t?=
 =?utf-8?B?aXFqdUEwU0NueXBaSGNqMnhBYVFTc2g2N0ZWOGdpcnpTSEFQOXpKWmtCYWVm?=
 =?utf-8?B?bXI0Qk8vblN2MzIvVi9QZWlkamVVNW03OEdZN0pQRmxudGo1OXZFb3ZNRjh5?=
 =?utf-8?B?WU9zVmphV3BlQlptNlJ5ZlNwZGVDRGRlRmIwQ2F0NkhtbWJ5blVYOGliYkow?=
 =?utf-8?B?NHBROHFESFNpdm9EVHpZcXpSTW42dFdyVjI0N00zRFMzM1JycVd4NlQ5RDIr?=
 =?utf-8?B?V09KWjUwOFJCS2FSRGNyMXNHV0N2NUplSGdYQW9mdVFDbWN5ekZzTWZEMnN2?=
 =?utf-8?B?eTJtclhiWEdobDFxVmVsdkhBVzJQa2FLVEdhQUtmN3g4aU1LSTdrOXdxSGVp?=
 =?utf-8?B?MDZ1R2Q5cnFTRTRlenBPbUNZWjE1YjhhNXVVcEU4bFRpQkVWZ1dPREkrTmxW?=
 =?utf-8?B?bEVYSllya21nek1aUnkzZ2hrMmZlbzJya3BJeGVKcmI1MUY4WWd1am1yQWJw?=
 =?utf-8?B?RGhYOXQzOWs1azFBVnN3bkNHenJ6aTArdVYyRzNXdlZSNHhsQTdEN2tacjEv?=
 =?utf-8?B?dmVycHlidTc5RjlVV1FJa1dLRFgrVkgvRmh6cHhlU044NE11STlWc2liTUVp?=
 =?utf-8?B?dmswblptOFVubXNRVVdCTXpWcUF2dCthdXFzSGt4MGIwSDBBd3ZOTHIyS2kv?=
 =?utf-8?B?dzVuU0kweVo2cDBQdkI1ZGlQSTFmU3V2d1VZSnM1V21EYnFlSFlMNlVIWHEy?=
 =?utf-8?B?SzNNTG14bU5HZkRoUkVOUDhNUS9yTDNJb1U4RjBiaDE2d2NGc2l0cFQ4aGMv?=
 =?utf-8?B?czNFVjJVUnRjT2JNZDNiVVJ6RjM5STBVN2hoTFB0ckJ0MmJXbkFWSTVNcFN6?=
 =?utf-8?B?SW5WRUlTYTBWQS9JbFFRQnRCenJ3dkpkSVdBbi9HK3lRdTUyT01vZEwwbnNw?=
 =?utf-8?B?NGYwTThjRUZtTFdsb24yaHJEcmMyVmVoNDYzQWEzUm9CNjFYOFZTbi9iRXVT?=
 =?utf-8?B?TnBGM1phSTdwRFlpRmVETzFzcnhqQVQ3NW1mZDdlNnV6bCtLZDA1ajluNEls?=
 =?utf-8?B?TFRsTmdYZEJ0cVBiR29FdlJQUGJMWGNhTGgxdnJlcmZlVzFJdHJ5TGp5cUZL?=
 =?utf-8?B?ZTlyTklENllCTVJtb2ZBQ2M3dHZxUmtqcCtzQlRkd3V3b3BpUDdua3FIcFdz?=
 =?utf-8?B?aGNFRVM4RERMM1NnRmhjRUtBN1NJbjlyNmlrbmlCVUh6OFBKK0tkOTJkQnk3?=
 =?utf-8?B?QnBHQzlCOEdaSDU1MFpXc05ocnpwVG9QOW1GNlRVTjl0VDF3OVc1WXlhNXdp?=
 =?utf-8?B?Z1dpYmd0UE03eGlIYlcrWFF1SVNKcE90NDcvWktZcWlsQmhEWklwV21EeVFJ?=
 =?utf-8?B?SG55d04yeTdVamc5TWdlejBKc2h0cjR1bTFjanovQTVCbEw2L3FTa3BsVjM2?=
 =?utf-8?B?TGJTajRJRC9xaGduN0xoVDJuWVQwZ3NFYjFMWmx1U1J6eFRKQVRnd09TSVR5?=
 =?utf-8?B?QXlTck44WEYyTE5WcmUvYnpuY2VTekw2WmhrZytFYXMrMmdDMWxEMVBGeitr?=
 =?utf-8?B?ZHpQZGdUMmNRQnY5MU51aVFmUUVVZTdKcFBZZ1B3eDVHZlNYZ3pzRm5EZEtJ?=
 =?utf-8?B?TU53OTBwRGo1S3Njd0piVG1xaldKNDcwZE96UXErS2RHWG54YWN4VmduWmRU?=
 =?utf-8?B?RG40aGt5UW9mTmV0YWdCVVc3U2kvNXlrNTdYNGc0TTlRbEd2RW9lVVlWOVVo?=
 =?utf-8?Q?n8NtbCGNq/y64FXoPRySRGGwY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE4D3A1206DE784EBF0E2C3C65881FA7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4cb1c9-dba1-46fa-eaac-08dc6accc3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 17:24:46.7516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4/8uhSppDByBebwNCydKxAohb8icPx+0KkDj/fJq2P6BhACBmhSChX6yVpnEO2AQRmRGs+k8DgzcgANkPgxlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8315

DQpBbSAwMi4wNS4yNCB1bSAxNzoyMCBzY2hyaWViIFJvYiBIZXJyaW5nOg0KPiBPbiBUaHUsIE1h
eSAyLCAyMDI0IGF0IDc6MzLigK9BTSBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4g
d3JvdGU6DQo+PiBBZGQgZGVzY3JpcHRpb24gZm9yIHRoZSBTb2xpZFJ1biBDTjkxMzEgU29saWRX
QU4sIGJhc2VkIG9uIENOOTEzMCBTb00NCj4+IHdpdGggYW4gZXh0cmEgY29tbXVuaWNhdGlvbiAg
cHJvY2Vzc29yIG9uIHRoZSBjYXJyaWVyIGJvYXJkLg0KPj4NCj4+IFRoaXMgYm9hcmQgZGlmZmVy
ZW50aWF0ZXMgaXRzZWxmIGZyb20gQ045MTMwIENsZWFyZm9nIGJ5IHByb3ZpZGluZw0KPj4gYWRk
aXRpb25hbCBTb0MgbmF0aXZlIG5ldHdvcmsgaW50ZXJmYWNlcyBhbmQgcGNpIGJ1c2VzOg0KPj4g
MnggMTBHYnBzIFNGUCsNCj4+IDR4IDFHYnBzIFJKNDUNCj4+IDF4IG1pbmlQQ0ktRQ0KPj4gMXgg
bS4yIGIta2V5IHdpdGggc2F0YSwgdXNiLTIuMCBhbmQgdXNiLTMuMA0KPj4gMXggbS4yIG0ta2V5
IHdpdGggcGNpZSBhbmQgdXNiLTIuMA0KPj4gMXggbS4yIGIta2V5IHdpdGggcGNpZSwgdXNiLTIu
MCwgdXNiLTMuMCBhbmQgMnggc2ltIHNsb3RzDQo+PiAxeCBtcGNpZSB3aXRoIHBjaWUgb25seQ0K
Pj4gMnggdHlwZS1hIHVzYi0yLjAvMy4wDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5
ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQpjdXQNCj4+ICsgICAgICAgLyogVHlwZS1BIHBvcnQg
b24gSjUzICovDQo+PiArICAgICAgIHJlZ191c2JfYV92YnVzMDogcmVndWxhdG9yLXVzYi1hLXZi
dXMwIHsNCj4+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7
DQo+PiArICAgICAgICAgICAgICAgcGluY3RybC0wID0gPCZjcDBfcmVnX3VzYl9hX3ZidXMwX3Bp
bnM+Ow0KPj4gKyAgICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiAr
ICAgICAgICAgICAgICAgcmVndWxhdG9yLW5hbWUgPSAidmJ1czAiOw0KPj4gKyAgICAgICAgICAg
ICAgIHJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDUwMDAwMDA+Ow0KPj4gKyAgICAgICAgICAg
ICAgIHJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDUwMDAwMDA+Ow0KPj4gKyAgICAgICAgICAg
ICAgIHJlZ3VsYXRvci1vYy1wcm90ZWN0aW9uLW1pY3JvYW1wID0gPDEwMDAwMDA+Ow0KPj4gKyAg
ICAgICAgICAgICAgIGdwaW8gPSA8JmNwMF9ncGlvMSAyNyBHUElPX0FDVElWRV9ISUdIPjsNCj4g
ImdwaW8iIGlzIGRlcHJlY2F0ZWQuDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMgb3V0Lg0K
SSBkaWQgYWN0dWFsbHkgdGhpbmsgYWJvdXQgaXQgd2hpbGUgcmVhZGluZyB0aGUgYmluZGluZ3Ms
DQphbmQgZmFpbGVkIHRvIGZpZ3VyZSB0aGlzIG91dC4gImdwaW8iIG9jY3VyZWQgdG8gbWUgYXMg
bW9yZSBjb3JyZWN0Og0KDQrCoCBncGlvOg0KwqDCoMKgIGRlc2NyaXB0aW9uOiBncGlvIHRvIHVz
ZSBmb3IgZW5hYmxlIGNvbnRyb2wNCsKgwqDCoCBtYXhJdGVtczogMQ0KDQrCoCBncGlvczoNCsKg
wqDCoCBtYXhJdGVtczogMQ0KDQpJIGNvdWxkIG9mIGNvdXJzZSBoYXZlIGNoZWNrZWQgZ2l0IGxv
ZywgYW5kIGZvdW5kDQpyZWd1bGF0b3I6IGR0LWJpbmRpbmdzOiBmaXhlZC1yZWd1bGF0b3I6YWxs
b3cgZ3Bpb3MgcHJvcGVydHkNCmJ5IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZz4NCndpdGggdGhlIGV4cGxhbmF0aW9uOg0KDQoiJ2dwaW9zJyBpcyBp
biBnZW5lcmFsIHByZWZlcnJlZCINCg0KPg0KPj4gKyAgICAgICAgICAgICAgIGVuYWJsZS1hY3Rp
dmUtaGlnaDsNCj4+ICsgICAgICAgICAgICAgICByZWd1bGF0b3ItYWx3YXlzLW9uOw0KPj4gKyAg
ICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgICByZWdfdXNiX2FfdmJ1czE6IHJlZ3VsYXRvci11c2It
YS12YnVzMSB7DQo+PiArICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4
ZWQiOw0KPj4gKyAgICAgICAgICAgICAgIHBpbmN0cmwtMCA9IDwmY3AwX3JlZ191c2JfYV92YnVz
MV9waW5zPjsNCj4+ICsgICAgICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0K
Pj4gKyAgICAgICAgICAgICAgIHJlZ3VsYXRvci1uYW1lID0gInZidXMxIjsNCj4+ICsgICAgICAg
ICAgICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsNCj4+ICsgICAgICAg
ICAgICAgICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsNCj4+ICsgICAgICAg
ICAgICAgICByZWd1bGF0b3Itb2MtcHJvdGVjdGlvbi1taWNyb2FtcCA9IDwxMDAwMDAwPjsNCj4+
ICsgICAgICAgICAgICAgICBncGlvID0gPCZjcDBfZ3BpbzEgMjggR1BJT19BQ1RJVkVfSElHSD47
DQo+PiArICAgICAgICAgICAgICAgZW5hYmxlLWFjdGl2ZS1oaWdoOw0KPj4gKyAgICAgICAgICAg
ICAgIHJlZ3VsYXRvci1hbHdheXMtb247DQo+PiArICAgICAgIH07DQo+PiArDQo+PiArICAgICAg
IHNmcDA6IHNmcC0wIHsNCj4+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNmZixzZnAi
Ow0KPj4gKyAgICAgICAgICAgICAgIHBpbmN0cmwtMCA9IDwmY3AwX3NmcDBfcGlucz47DQo+PiAr
ICAgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+ICsgICAgICAgICAg
ICAgICBpMmMtYnVzID0gPCZjcDBfaTJjMT47DQo+PiArICAgICAgICAgICAgICAgbG9zLWdwaW8g
PSA8JmNwMF9ncGlvMiAyIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4gKyAgICAgICAgICAgICAgIG1v
ZC1kZWYwLWdwaW8gPSA8JmNwMF9ncGlvMiAwIEdQSU9fQUNUSVZFX0xPVz47DQo+PiArICAgICAg
ICAgICAgICAgdHgtZGlzYWJsZS1ncGlvID0gPCZjcDBfZ3BpbzIgMSBHUElPX0FDVElWRV9ISUdI
PjsNCj4+ICsgICAgICAgICAgICAgICB0eC1mYXVsdC1ncGlvID0gPCZjcDBfZ3BpbzEgMzEgR1BJ
T19BQ1RJVkVfSElHSD47DQo+IEFzIGlzICItZ3BpbyIgc3VmZml4LiAgVGhlc2UgYXJlIGFsbCBw
b2ludGVkIG91dCB3aXRoICdkdGJzX2NoZWNrJw0KPiB3aGljaCBJIHNlbnQgYSByZXBvcnQgb24g
djMuIEkgaGF2ZW4ndCBjaGVja2VkIHdoYXQgZWxzZSBmcm9tIHRoYXQgeW91DQo+IGlnbm9yZWQu
Li4gSSBkb24ndCBleHBlY3Qgd2FybmluZ3MgaW5oZXJpdGVkIGZyb20gdGhlIFNvQyAuZHRzaSB0
byBiZQ0KPiBmaXhlZCBpbiB0aGlzIHNlcmllcywgYnV0IGNlcnRhaW5seSB0aGUgYm9hcmQgbGV2
ZWwgb25lcy4gWWVzLCBpdCdzDQo+IGhhcmQgdG8gcGljayBvdXQgdGhvc2UsIGJ1dCB0aGF0J3Mg
dGhlIE1hcnZlbGwgZm9sa3MgZmF1bHQgZm9yIG5vdA0KPiBmaXhpbmcgU29DIGxldmVsIHdhcm5p
bmdzLg0KWW91IGFyZSByaWdodCwgdGhleSB3ZXJlIGNsZWFybHkgcG9pbnRlZCBvdXQgYnkgeW91
ciBib3QNCmFuZCBJIG1pc3NlZCB0aGVtLiBUaGV5IHdpbGwgYmUgY29ycmVjdGVkIGluIHY1Lg0K
DQoNClRoYW5rcw0KLSBKb3N1YSBNYXllcg0KDQo=

