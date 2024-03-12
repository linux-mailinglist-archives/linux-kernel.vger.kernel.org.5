Return-Path: <linux-kernel+bounces-99780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFE878D31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368AA1F22357
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D88821;
	Tue, 12 Mar 2024 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="UfpkAiRb"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C31FA2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211933; cv=fail; b=Mq006+izQ6vAMxWwlnJqGf88Qw187auJg1fy6HAfo101xB7wmjWr4ihDzi7gJow8l1Ph/bTWtM+MrMmQH6nNeRW+yUvDczsh1vvvkNWGpgsLnGARSJdehPD5u13MX4tafSw8v4j8+iUouGvNh/BgXruSP7g53LDQIvsQbcs/D+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211933; c=relaxed/simple;
	bh=Lkn7LSLd3VnlMyWN0H9UAQa0xDee8xzoAPV8RIsD5k4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwZ9NM5TFAbUvybvciLj9dDsbYLJXy5+4Ua3xL3Cieqfac8/eqVUonw+wEqRJDaa05CvCgL8+Azppis60j1xnAsZtIh8Ds0RioHDUL0yCN7ZDEnQQPl1Db4Rt+AbsFH4FMsWkeZfKch6ppWCBEM55QBAYymChO2L8PPgjZL/qrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=UfpkAiRb; arc=fail smtp.client-ip=40.107.117.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGYpJx85niIaslTuYOMkxtquRbQrt15urxa9FXfdojxQaKVCOfhKPl5Wf09BHVM5zy0gwN/s+pjidOooTxZSawwgrYg7d/3mktFQXtvpzy76NQaJ4oeFScmcfkI2axBoXPEPzmemlPJjt+/mB0DUwQGrA/kgcDGnytwBiP6UVMTVxaI5NzoAHr8KkgtC2tuHd293O6v93VrXlallslvRoxGOXvADIfpOKBxoNTxQ7Dx9yH83mh1eQyjsiLCwuHUdGLqrOu4cY93Z1KsyOTUDpcfbrs52Qv7VFEyP7A53C+8IIOzIB94eW/HdqUT0vrBBWi0xCW/Px4jn1+Pv8m+2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lkn7LSLd3VnlMyWN0H9UAQa0xDee8xzoAPV8RIsD5k4=;
 b=eWoUc5LF1iyL87c8lJLrJ3fQfeRvNTy1hh3bnGygFIPjO2h9tR0mvD9mqNt0yyw9rhi0sCcxqERu+w90YqtKwo11QoEQxRwF37mIfOqXw3Cb2B5402AIUHrwkVL7yNOO0+V8JOZ3kGtcVeIRSR97QuKfYywgf1Dnuhh3H0XoY8y2SlQlh3PTLYO9rgKoJHcDKx3SatzrM0RMwE+dMg8xY68O+0lg599/XUjv78wbVxSczLEsdSTmd20NSK6xDov8JQoafxLorRwfsa08xt6KEH1OUkOxZebuP5xlZ6Ar8bWbCEH9wI3yfJY85diShAW9DQcgPZjLY3spMNssQ+ABQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lkn7LSLd3VnlMyWN0H9UAQa0xDee8xzoAPV8RIsD5k4=;
 b=UfpkAiRbkvdVEtIsmSvUCJs+ih9p3f33tZcNOvTmDGyVMNrb0PBqj+8WS4YYU+4tQ9Xm1ITtjCp4Q5wYObfbW3EVhw2/REopZDwb+nsN5cCVXaQjdMIvnDHZNo5/ehWfnMJnSRon5yeXXRW7hBU6whbHhhZpHJH515EbruZN5P4m4fTInJ72NSR+N5yXjsQ+Ex8AEuoLAqW6TUPnMMpwu6qF5u9uC09tUSfr+7vbjCVhCEf/EQmYBBOVA3Ltg7YM9LM4hWdvcDrv7XS7nuasdDbRlcCFFWe3+xeZgCPcHXDjdUM3ISeoSG8Nf1QB56YJ/PE/AZAC8SNP3DKMnyNz1Q==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by SEYPR06MB5303.apcprd06.prod.outlook.com
 (2603:1096:101:80::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 02:52:04 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 02:52:03 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: James Morse <james.morse@arm.com>
CC: "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "reinette.chatre@intel.com"
	<reinette.chatre@intel.com>, "rohit.mathew@arm.com" <rohit.mathew@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGZzL3Jlc2N0cmw6IFVuaWZvcm0gZGF0YSB0eXBl?=
 =?utf-8?B?IG9mIGNvbXBvbmVudF9pZC9kb21pZC9pZC9jYWNoZV9pZA==?=
Thread-Topic: [PATCH] fs/resctrl: Uniform data type of
 component_id/domid/id/cache_id
Thread-Index: AQHac4y6H5635aXxlkm66nOBJ0wPFrEy01UAgACKSeA=
Date: Tue, 12 Mar 2024 02:52:03 +0000
Message-ID:
 <KL1PR0601MB577382D132A25E055856C543E62B2@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20240311081839.937-1-rex.nie@jaguarmicro.com>
 <e731b262-c201-4294-9b1e-abfa0c6ac817@arm.com>
In-Reply-To: <e731b262-c201-4294-9b1e-abfa0c6ac817@arm.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|SEYPR06MB5303:EE_
x-ms-office365-filtering-correlation-id: eae34360-d903-44af-5db2-08dc423f6593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6Pb6ENLNw9TLh4IuVHwrxygLtMJlK2zubjcKzrdkPgVAY0bY1YpTztC6RiU+DeLjH/yuvvz2gpNcknhCxJ71dAtzYsRPv3IBvKjQYm7tuWkq0q8P34X5AmrNDER5gPw0Jy3o9ZYUkAVlwlf7Ciqn72b7wHZXFyU8kbdacmSd/LG+Q0RUHhYtvd/DZDcqpF7L1LCpHndAsTIszvxA03JKpD6oiimyu2Fl1sfflETVd9A4dZJdhtZVHPI6PCIsCb86NXsiK9dZjBmGOI8OOSFJ/Zjhvx3bkE7R0jIUpkpcHsUKaTbzZeh/yro6itlp7w+l5erxifaMX4WB1+ri5udZt+lgRa7cGyo9ck8VL2ZO4g/1BqcMpGdyNdnhQ4M6dq+BUByMrO45GguDHTvXcv+mmFfwQIACXCCHWq81Gs9S5+vac3UawNGeOI4ShU5EblSowe/EkQudJM1sOk8ydwn+s3TnEa02H6Gh1LCulmJ6GWskMGx/hlU2cKURzSo4omCx24735GDr2un9xYALLbU0UCrkKV98/ZAv9VkCNYotDq7nq5eW0/ZlB67kBl49zdmpg/tTmiW8wyrh47FkzH7Yf+2I/kKR5CNR4KzgLTV6PiMBPVqhU8z+MWfEsZQDQSIzUMFzl4mDUsx8iPfyjacByFybvDXiFEdnbfK+mZInVRM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHc4YUV3T0lxMkJlMHhFTDhocmtUaHFkdG5ubVRQQzFvWEMyQkpscDQ5RHVy?=
 =?utf-8?B?cDh3ZGc1cXZ6aFlwMVBjNk9hT0hTVmthZWFNeGY1dlE4eWVhb25RT01oRDgx?=
 =?utf-8?B?eE82UDNUd3VlTDFQYnUrMU9tM1ZvTlNSeXlUUnlnbURNL01pTStoekpIYlYv?=
 =?utf-8?B?aU1vMXlvZkZvZkNHUVF4YVBwVmFvbW9leCtzTjJxRVk4Y2JMc01yVVd3UHg5?=
 =?utf-8?B?L3FGNmUvenNvMDBEY0ZrL2toRkZ1N2ptbkhxVWVVZnJUMTN5dy82K2c4MFBx?=
 =?utf-8?B?LzZvaExXSUtyZGlheThjSVlxU1Q1aVprSlZqYmlYTklxMmRmQ25CMEFJdzJ3?=
 =?utf-8?B?MmFQeWtYcnloR3hwSjlBOHBsMTNWd3NiSUk1a0svVDk5OURaOUdPUkFpdEJC?=
 =?utf-8?B?VkJqVGdyV3p2ZWtoeTVJMU0vQWxaOFU0NzF1MXZFQ2J4RmUyQTh1MGwrbURt?=
 =?utf-8?B?cS9PSCtmNlpTVXMyWEU1WnduaXY0YzhZODlieGlsYWVnTEZraW9jd1NySEZQ?=
 =?utf-8?B?OFkzOW02c0w1d1JTcFd5MlVkUGd3QW5ZL083c0F3YThZam43SDBDYW5qazZC?=
 =?utf-8?B?RmZuYWFrdHp2RnBBbXhFb0dUcnZNR2xZRFJWYlhXZjZLcUlGWUxvNzZPbEZl?=
 =?utf-8?B?aGF2UDR6MEJsSmJxcGwxQmN4T0s3WHJRYnNXZ2xRYXZ3bmQ3VjYrMUt0Zmhm?=
 =?utf-8?B?YUN5ZXp0ekpPSXVaVmtqRlpMYmh6K2EwOUVXZTNSWEU1STFDd1dOaGh0aGVq?=
 =?utf-8?B?RDNldHZGaHdBZkhGSE1MQ2RlRFYyYnNIeVZQRlI2emhBanB0OXpwdDVOWHph?=
 =?utf-8?B?WE1aWTZpOHJ3UTI1aVBObEwyUUlZdnRvVlV5UVM1djNPbXhwYXRYS0NtaFVN?=
 =?utf-8?B?cTcyMGRiSFhkTS9peEdudnBPRmV0Wi9yVzMza0RBN3N6R1pFL0UyU3BMRXNo?=
 =?utf-8?B?Z3B5Zk1pckhDRFg5TmxDUVpyaHAwMWxHZCt0TUpmV0FmUGpWSnQvV3hjQnYz?=
 =?utf-8?B?OTRGRW81dUptR1ZjUEloQlZoR3lRZEM2QjArKzd2ZkppK29YdGJoVjZmMEFG?=
 =?utf-8?B?N082bUF0OXJSbWxvZTdKMjNTNEtLOXQySGQ0TVpjOCtiMDh2cGowQ0p0b1A2?=
 =?utf-8?B?M25CWTRzN1NXUGJDaTJpeEtwR0RLbDVJSGRYMFk1cDRaREE4OS9ZMW81SVB3?=
 =?utf-8?B?eFNSWjFQcSswV2JYamxyd3hybk8wOFFiQUNBYTRScHVSaldLaFdLcDUxdUww?=
 =?utf-8?B?Z3pSc1lEYSt0ZDJMR09lL0k4aktOUDlsU0ZCRUJ3K3RxL1hJdXg1T3VMZkQr?=
 =?utf-8?B?MEtwRnAreExoV3V2dmhBN05XK2FNTFIvWUhBeWg0dG1vOU5ibVl5SEQ1Zlh5?=
 =?utf-8?B?UjRISm5RakRDdWFZV1JJaFZDWEtHNitHc21tNzdtSzRJeE92R3g3ZGUrckY3?=
 =?utf-8?B?N2dLbnI5TjUyZk9lSStCVzlBRjQyN3hJSS9uT21mWFlyWmo5VFRveHFxQW1o?=
 =?utf-8?B?TkNDTys3b0Vjalo2VzhkM1NWQ2pXK0gwRVl6STNINklZOTFKUDZTeW5RaGRl?=
 =?utf-8?B?Y2RQZnREZlNxVWhPRFNPVmtHeGdmL0I1bmtWMDZYYzJOLytQNnlzWWNlN2dB?=
 =?utf-8?B?L3RtYjkzMVcxSDBJRjgrQ29jdGNqcXhycStQUUFxSU5YaTN5bXVDbG42Z3Uw?=
 =?utf-8?B?VHlwWlVXZktTTEw0NGFvTWtRV1JYTjFVYUlNZTE5UVowZzdFUW9NUUk5c0lx?=
 =?utf-8?B?Ri9LUitHMWVVUjFSMFVmUXQzUEVsV0dCdDFmZzl6TW9jTnByQmNjZWwyVlpq?=
 =?utf-8?B?SW14TmY5ZXg4M3JkUUFFaEVMcEgrU01YWTJ0QzVzMWNsWHNZMzFwNkoxcFZJ?=
 =?utf-8?B?YmV2OTg2S3dDVUsvdW5yU1RCYmlJVnVzSW90OTR0V1V6QXZuODdFRTZZckln?=
 =?utf-8?B?S2FKZnJuQXFtd1hNS0l4bS9XOXlBNnZNTVkzM1o2QXU5Vkd3TWJocHhWcWtz?=
 =?utf-8?B?NENPOHoybkRoa1paZElqbnR1R1dmU1gxenVVcnZuUFAvZ0VibUhaVEpqY3JC?=
 =?utf-8?B?Z2I5ZVlRWXlselRqWFgzOVZLYloxKzdYWVc1aE56dkFkS05uSzFOV0dRc3Mw?=
 =?utf-8?Q?ZetVW2pT+x4yQJOJWxMeDAKKz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae34360-d903-44af-5db2-08dc423f6593
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 02:52:03.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqk3emsQWnGPrOyXuBMC2rxUVnJ1XTHwMDlP+hdpapqI0GjZG6ljWVH7F1pmU7On7KLld02/+q3UsUEEHM3RMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5303

SEkgSmFtZXMgTW9yc2UsDQoJVGhhbmtzIGZvciB5b3VyIHJlcGx5LiBQbGVhc2UgY2hlY2sgbXkg
aW5saW5lIHJlcGx5Lg0KQlRXLCBjYW4gSSBrbm93IHRoZSBwcm9ncmVzcy9yb2FkbWFwIG9mIG1w
YW0gZHJpdmVyIHVwc3RyZWFtPw0KQmVzdCByZWdhcmRzDQpSZXgNCg0KPiAtLS0tLemCruS7tuWO
n+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogSmFtZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+
DQo+IOWPkemAgeaXtumXtDogMjAyNOW5tDPmnIgxMuaXpSAxOjU1DQo+IOaUtuS7tuS6ujogUmV4
IE5pZSA8cmV4Lm5pZUBqYWd1YXJtaWNyby5jb20+DQo+IOaKhOmAgTogZmVuZ2h1YS55dUBpbnRl
bC5jb207IHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb207DQo+IHJvaGl0Lm1hdGhld0Bhcm0uY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IOS4u+mimDogUmU6IFtQQVRDSF0gZnMv
cmVzY3RybDogVW5pZm9ybSBkYXRhIHR5cGUgb2YNCj4gY29tcG9uZW50X2lkL2RvbWlkL2lkL2Nh
Y2hlX2lkDQo+IA0KPiBIaSBSZXggTmllLA0KPiANCj4gKGZvciB0aG9zZSBmb2xsb3dpbmcgYWxv
bmcgYXQgaG9tZSAtIHRoaXMgaXMgYSBwYXRjaCBhZ2FpbnN0IHRoZSBNUEFNIHRyZWUsIG5vdA0K
PiBtYWlubGluZSkNCj4gDQo+IE9uIDExLzAzLzIwMjQgMDg6MTgsIFJleCBOaWUgd3JvdGU6DQo+
ID4gVGhpcyBwYXRjaCB1bmlmb3JtIGRhdGEgdHlwZSBvZiBjb21wb25lbnRfaWQvZG9taWQvaWQv
Y2FjaGVfaWQgdG8NCj4gPiB1MzIgdG8gYXZvaWQgdHlwZSBjb25mdXNpb24uIEFjY29yZGluZyB0
byBBQ1BJIGZvciBtcGFtLCBjYWNoZSBpZCBpcw0KPiA+IHVzZWQgYXMgbG9jYXRvciBmb3IgY2Fj
aGUgTVNDLiBSZWZlcmVuY2UgdG8gUkRfUFBUVF9DQUNIRV9JRA0KPiA+IGRlZmluaXRpb24gZnJv
bSBlZGsyLXBsYXRmb3JtcywgdTMyIGlzIGVub3VnaCBmb3IgY2FjaGVfaWQuDQo+ID4NCj4gPg0K
PiAJKA0KPiBcDQo+ID4gCSAgKCgoUGFja2FnZUlkKSAmIDB4RikgPDwgMjApIHwgKCgoQ2x1c3Rl
cklkKSAmIDB4RkYpIDw8IDEyKSB8IFwNCj4gPiAJICAoKChDb3JlSWQpICYgMHhGRikgPDwgNCkg
fCAoKENhY2hlVHlwZSkgJiAweEYpICAgICAgICAgICAgICAgXA0KPiA+IAkpDQo+IA0KPiBBaGEs
IHRoaXMgaXMgd2hlcmUgdGhvc2UgbnVtYmVycyBhcmUgY29taW5nIGZyb20hIFRoYW5rcyBmb3Ig
ZGlnZ2luZyB0aGF0DQo+IG91dC4NCj4gDQo+IA0KPiA+IHJlZnM6DQo+ID4gMS4gQUNQSSBmb3Ig
bXBhbToNCj4gPiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGVuMDA2
NS9sYXRlc3QvDQo+ID4gMi4gUkRfUFBUVF9DQUNIRV9JRCBmcm9tIGVkazItcGxhdGZvcm1zOg0K
PiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90aWFub2NvcmUvZWRrMi1wbGF0Zm9ybXMvYmxvYi9tYXN0
ZXIvUGxhdGZvcm0vQVJNL1MNCj4gPiBnaVBrZy9JbmNsdWRlL1NnaUFjcGlIZWFkZXIuaCNMMjAy
DQo+IA0KPiBKdXN0IHRvIGNoZWNrIC0geW91IGRvbid0IHNlZSBhbnkgc2lkZSBlZmZlY3RzIGZy
b20gZG9pbmcgdGhpcywgaXRzIGp1c3QgY2xlYW5lci4NCj4gSSBhZ3JlZSAtIHRvZGF5IHRoaXMg
aXMgb25seSBhbiBpbnQgYmVjYXVzZSB0aGF0J3Mgd2hhdCBpdCBpcyBpbiBzdHJ1Y3QgcmR0X2Rv
bWFpbi4NCj4gDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Jlc2N0cmwuaCBi
L2luY2x1ZGUvbGludXgvcmVzY3RybC5oIGluZGV4DQo+ID4gZGQzNDUyMzQ2OWE1Li5iMDBhODlh
ZGRmOTEgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9yZXNjdHJsLmgNCj4gPiArKysg
Yi9pbmNsdWRlL2xpbnV4L3Jlc2N0cmwuaA0KPiA+IEBAIC0xMDgsNyArMTA4LDcgQEAgc3RydWN0
IHJlc2N0cmxfc3RhZ2VkX2NvbmZpZyB7DQo+ID4gICAqLw0KPiA+ICBzdHJ1Y3QgcmR0X2RvbWFp
biB7DQo+ID4gIAlzdHJ1Y3QgbGlzdF9oZWFkCQlsaXN0Ow0KPiA+IC0JaW50CQkJCWlkOw0KPiA+
ICsJdTMyCQkJCQkJaWQ7DQo+ID4gIAlzdHJ1Y3QgY3B1bWFzawkJCWNwdV9tYXNrOw0KPiA+ICAJ
dW5zaWduZWQgbG9uZwkJCSpybWlkX2J1c3lfbGxjOw0KPiA+ICAJc3RydWN0IG1ibV9zdGF0ZQkJ
Km1ibV90b3RhbDsNCj4gDQo+IA0KPiBXZSBzaG91bGQgcHJvYmFibHkgb25seSBtYWtlIHRoaXMg
Y2hhbmdlIGlmIHdlIGNsZWFuIHRoaXMgdXAgaW4gcmVzdHJsLCBub3QganVzdA0KPiB0aGUgTVBB
TSBkcml2ZXIuDQo+IA0KSSBhZ3JlZS4gVGhlIGNsZWFudXAgc2hvdWxkIGluIHRvcCBvZiByZXNj
dHJsLCBjb25zaWRlcmluZyBkaWZmZXJlbnQgcGxhdGZvcm1zDQo+IA0KPiBJJ2xsIHBpY2sgdGhl
IE1QQU0gYml0cyBvZiB0aGlzIHVwIGZvciB0aGUgTVBBTSB0cmVlLiBUaGlzIHdpbGwgZXZlbnR1
YWxseSBnZXQNCj4gbWVyZ2VkIHdpdGggdGhlIHBhdGNoIHRoYXQgYWRkcyB0aGUgb3JpZ2luYWwg
Y29kZSBhcyB0aGVyZSBpcyBubyBwb2ludA0KPiBwcmVzZXJ2aW5nIHRoZSBoaXN0b3J5IG9mIGNv
ZGUgdGhhdCBpc24ndCBtZXJnZWQgeWV0LiBJJ2xsIGFkZCB5b3UgdG8gJ0NDJyBvZiB0aG9zZQ0K
PiBwYXRjaGVzLiAoVGhlIGpva2UgaXMgJ0NDJyBhbHNvIHN0YW5kcyBmb3IgQ2VsZWJyYXRlIENv
bnRyaWJ1dGlvbiEpDQo+IA0KVGhhbmtzIQ0KPiANCj4gVGhhbmtzIQ0KPiANCj4gSmFtZXMNCg==

