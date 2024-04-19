Return-Path: <linux-kernel+bounces-151695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D798AB22F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D943E1F23A59
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999D12FF93;
	Fri, 19 Apr 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="REIU26rr"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19010000.outbound.protection.outlook.com [52.103.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DA4D110;
	Fri, 19 Apr 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541392; cv=fail; b=bD9HhrnlIFgPcprUt/5odsSpp2lxNJKE16daqg76bu4Zs2TIlITobhy6cnVsTwBy1lC/QhKLFt6cl56SLbQ0HUm/n5wYK1VD1cU1uan/fQXahunKQsn1+Ms0H7lyaMGhpp4+QIaR/fhWHxfUooQg9I37dao0h4CJ8kN9BAPm+xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541392; c=relaxed/simple;
	bh=ZCZZewG2HTul4dll/38bVXYAwekM1ldgzxeNW7rCWR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K67C4+j4t81LdGgR4jyd9gktInXGWmUJrrJ7HrVKnJ6dGoXVTQ9NM77HOf/c5qt08r5a4WTEtRfLXf7YDbawvYfiJr4vLC13Vc+tfDuSFQmW8OVEHL9puy/oRkizpilN6FCO+nm4+mzuq/LrlWFUdQF3zMmDjcLiu3nJIDQ/WK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=REIU26rr; arc=fail smtp.client-ip=52.103.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXDDVk4zR9erIb98RHWuKROnlVDYBSYZXGHMYUxsHsnZAv6esIH2tmHMNwhulu14XaR2y94hdFMQFlaeu5JjYo8I/tVy2pd1h/eDUGcc7WY+tb+7fHP2PTna3d9Gqh+bRJjdsg9Bi0FW40IUsK13WXGf7j8Aiz106uMEvyzOOIF7cckipbXdI0FYNFlPJYex3/0BM1a3e8zZ0AkDdkr1VMhrJqWgqc5twStLAuD4LLCBEfc9loYOcloVTyQj0Q1KRIno03rwxEJioSn4jsLEPLrqKIIvO0LiU+TBdlNjzXz3IsoSqqs450R+fjws1knQTA8e9zHAgPJT4QVGvu7R9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCZZewG2HTul4dll/38bVXYAwekM1ldgzxeNW7rCWR0=;
 b=TxLeuy8aRjvt7zx5WNH18e0i4iPIk04t+O9cBmTWDh6UfSHBMlmGnPem3nd+Gk8+ZjcVz2U7BSgAxT2yTH2opAbMroT4KoxoGJ/qhNEWMmm8y0fH4hKNI20S0C59zBnSTFpPenJjsGdVMqukQEcZY2nfm+H0wAhdcALztHVu81i1Sk1vBurCbhNduPV9V6bPfpEiC9eZvgJOtsNvR1WLjYceOwtiohPVerklu8A5J7/doBFFxjM8iwmUDpLeXAetv32r7FS+aRzLUr8byVG8H67AmPzI83kkAJFrObgZV+DFdHzKmq01ljoDfeh6ud2r6yds1WZ9I68vqZpTZsaEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCZZewG2HTul4dll/38bVXYAwekM1ldgzxeNW7rCWR0=;
 b=REIU26rrpxW4mU96xVbnheTTa4/2qCeMB3YVN40B6cuyYbNJFd8RmU7E5nhaiTV1B2OsD+PMj9X+yXIBrGf2cWZkBrU146SFZPROkE9xaAQTtZzux5XKrEco9TxNaDN+eUS7mFWHDGl+mQHBhQ/VpKPO9YlxJn/TVp0Dd8dwj8Ba6YY0nx0mHcJR0tpmUJf++oqyc2gJ22O4k9jk49KArV0yPJeMJp12KzRDyrAEcjQXf61CwjMSSyQcYbQmDzxhmXiQ1WohZ9fgxBN2W4pjWvpF5BdZ9GbkbsuLzNDcubqqHPattKcyOwRFekjmNTdACOGBLVlt+ONW9SOQCYKiRw==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYCP286MB2928.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 15:43:06 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 15:43:06 +0000
From: Qi Qi <ArcticLampyrid@outlook.com>
To: Stefan Binding <sbinding@opensource.cirrus.com>
CC: "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
	"james.schulman@cirrus.com" <james.schulman@cirrus.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
	"rf@opensource.cirrus.com" <rf@opensource.cirrus.com>
Subject: Re: [PATCH v3 1/2] ALSA: cs35l41: obey the trigger type from DSDT
Thread-Topic: [PATCH v3 1/2] ALSA: cs35l41: obey the trigger type from DSDT
Thread-Index: AQHakZMd5+USwrpJm0Sf8Mm6XyQ3xrFvtAmAgAAJWoA=
Date: Fri, 19 Apr 2024 15:43:06 +0000
Message-ID: <4618242.LvFx2qVVIh@qlaptoparch>
References:
 <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB253538FE76C93C032DB55212C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <004201da926b$986d8040$c94880c0$@opensource.cirrus.com>
In-Reply-To: <004201da926b$986d8040$c94880c0$@opensource.cirrus.com>
Reply-To: "004201da926b$986d8040$c94880c0$@opensource.cirrus.com"
	<004201da926b$986d8040$c94880c0$@opensource.cirrus.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [IQQaba0EElvmheryXv1AJSRzVvMFGWRT]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB2535:EE_|TYCP286MB2928:EE_
x-ms-office365-filtering-correlation-id: ca03c4be-2f3d-4164-0cae-08dc60876866
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cD0TS772jBH8/JxQnZeDzyFLpd2nGbhnH4n73T3m5c4CsSPcRVXvxZB6sSeLSm9tdPuD7AD1bEIz0mbygc/h+gQAXZoEJT4Yg2WaKPFHf57kvJZ63atktmphwiIsXgGVXdf5SFn4zvHDnEkhvx7LGvlUSbAA4vTGUTqJEo0xlnITzmYHiPMhvGz7yNMpKTeMl8PIcjFAosAtHWlDPuD8s0LF4DY3VAm6t/VHal+BtaMSxn5Gg/3zg4Ylti3MM5S7eZnN/9FWDTaJZIVS7qK2jV0jvvSjkgoxIgvFlHLoEBhcFscAC33z8SjvDEFurUzLrWZZQmE8unrhFkpQ2/uBtzb4SXPovyDq9Aifx85avZSkuXQrZSm8DCm4VO6aCXlVYBo6y3YYlG9hGdZHO9inLbSLVoNS3BkQ2vEus3wtGXJGqWZHTC480RXBtWLyy3yu+TTQMv1pc+2Ybsdry3+3lZ402q3ItK/JhxBB9Zf/WzP2bpUrHjeaNmZ6auTgRO0ipZAyJGAW4fEOmPNJDIguZH2vQM4DK+bVdBeaZwxbjrQzyfV6A/GGZEdSq6TvlL7t
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d05iekJwTUJTc3ZVTnpPL3JLYmZMZXl1MHZPakMxLzZmdFBYdGJsQnpqL0V3?=
 =?utf-8?B?cHBXSU1Gd2NXYXdPcFF5YWdvdUVCcDE5RWRwbWxUWjV5WGZvK1EyVVNsZVI2?=
 =?utf-8?B?TlFIaEpUN21jam1vU2FGZlJ2V05hYVdNVFFEVG5kTndoQjM3S0NKZ2hNK2hG?=
 =?utf-8?B?SUJHWFlnWVRkdUs1OU9IY1F6cFFkZURIWlkwVkV1TTFRVGJIRG1lRmdkeVda?=
 =?utf-8?B?bEFJbktsV29RcDNNcG1VZ0hCRzEzYnFmZXdTdW5NMFJpQkRHMGo3b2luVk51?=
 =?utf-8?B?Q0FDQjV0SWJ4RzVzSXJjT1Z4Zk83WHFWa1N1THNpV3lWR1crcmtQRUIxVUZt?=
 =?utf-8?B?U0d5K0FjK0trOVFKSlEyOWRqc2lYQi82ZmVXZWlua3g4bk5jYnNGNnFuNVVI?=
 =?utf-8?B?UXd4b3NPLzZmMFd0blNXdldnaU5xemhjTGlUeEU5bk96Vlp4R3ZWL0RzbHhn?=
 =?utf-8?B?NlVPWXkxbXdEM2tlVENZb21VRW9JMExodTdMWC82YXd5cUNiT0psMHZlT3Nv?=
 =?utf-8?B?Zis4UXROMGtCakVPNXNYM2Ntamlya1VUZ1dKYnhpZjM3YzdNWFM5K01OV0wv?=
 =?utf-8?B?blROZmV1bUROc2VaZ05nMHlZd3RhakZ1R1pPREtLMGNQVXl6MWUyL0hadmZ1?=
 =?utf-8?B?cnkrOWZka3RFWmQrcjQ4ZmN2YzV3dXl0enE5c0U2b3djb2xaWHIxN0dZcWRI?=
 =?utf-8?B?SWVtNmlzcDQ3U05LQWkycWppS0xjTDFveXBDUWdFMmRoUXpIMFNmaE1IQ2c3?=
 =?utf-8?B?V0dERjYwZGFxV251K1VDU1B2MXdzWHhJMkN6Ylhlcjd5T1VmMVRHci9pZmhp?=
 =?utf-8?B?QlFRNkhEUlQ1azJwOTlnZFZTZk8wbWx5VENEOEtQTzNHK3g0eWlHZG5DTzZP?=
 =?utf-8?B?NVJNd1oxVHhZU3UrVlFzUTMxSDRBWmUyMTlNK0FPeHBTRFNSb3luQTBlZFpT?=
 =?utf-8?B?RjRjeE5zcEpKSXI1ZXoycVk5dG1UdHdYeVVpZVF0bi8yNy9PYlNTMFhnejEz?=
 =?utf-8?B?Vm94T1l4OWQ0SjNkSmgwYWtyQVFiWW9ncHlzbVg3aGc4dHVjNXFCNGxsSEFz?=
 =?utf-8?B?cTg3YUs2c2VUNzVCeG8zYnhjL3VYbWpneWhjbWZNVzhYQTRDRmFOWnBjR0Vt?=
 =?utf-8?B?TWtWd3EydElZTXR4Z2IvbEt1Wlh5allwcXUxZzF4bFViUEZqd0xneXptaDVG?=
 =?utf-8?B?VXk2eS9DODNIaDh3ZGZjNjhkV2dON2NObjQ3aDJPMkptQlhqZytNVWR0S0t4?=
 =?utf-8?B?SE5EL3J1bXJWNEkwbzFHczEyY25kRmNjSTZiVXhtVHIzbklEUVFqWDJYUGE3?=
 =?utf-8?B?N0pjcldRdGxhUnBzaEZrUmVBZGNzZDh4elBlbkNxdzNFMmtuT05BTkdwYXpC?=
 =?utf-8?B?MHpVR0VCeDdJNkFxVTNNeGZoWXN5WEhPdWw3Um9PZEk1cThSVXhUc21MNFZ5?=
 =?utf-8?B?Q3RxUWpjMkUzKzA1VUVUbHJQa2pVR1VLQ09WMVdzeC9ZaHBYdkZ2bFJMTHFi?=
 =?utf-8?B?SEYvRzZsV3lYSnpvSDlXdC8yZmhlakhoSDVwV0FVQWF1S1JqbHd1UUppWTZN?=
 =?utf-8?B?WFNCRE5mai9uZUk5c0lBS3lQbm52Y1EvWE53Nm1xNSs3dXI3TndPdEVPQTNR?=
 =?utf-8?B?S3FVZENhTzIxb3VLVWQyVDIyckcyOXUyd213TmNwS0Y4c1d2UzJtVmtDNDhY?=
 =?utf-8?Q?DGZzIJPyPmfxYOYRbfya?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <368B05DC53FC0644B2F3223765B0FD20@JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ca03c4be-2f3d-4164-0cae-08dc60876866
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 15:43:06.7604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2928

SSBiZWxpZXZlIHdlIHNob3VsZCBvYmV5IHRoZSB0eXBlIGRlY2xhcmVkIGluIERTRFQgdGFibGUg
aWYgaXQgZXhpc3RzLCBpbiAKZ2VuZXJhbCBjYXNlLgoKQ291bGQgeW91IHBsZWFzZSBleHBsYWlu
IHdoeSBpdCBkaWQgbm90IHNvbHZlIHRoZSBpbnRlcnJ1cHQ/IElzIGl0IGEgCm1pc2xlYWRpbmcg
aXRlbSBpbiBEU0RUPwoKVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg==

