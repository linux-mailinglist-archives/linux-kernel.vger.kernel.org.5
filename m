Return-Path: <linux-kernel+bounces-151693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4891E8AB229
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC4C1F245EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5A130A5C;
	Fri, 19 Apr 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ka0pMMog"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19010000.outbound.protection.outlook.com [52.103.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F1130A4D;
	Fri, 19 Apr 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541260; cv=fail; b=sXJdHWYvTERDIpmT+ncaixiTnq2KdWZxzNmZveC3JXZzfRz08ZJClc6t+NhRMPrSlx7NpqvKvU50pF2SvBD5IrX5OrgtVuque6lDpKdiCqYM8pytlRmz/kMILVl7jFJCKWxOlYMS1vdkVZ2YyV8Y5dzVEH2BG8eCQpyKYJz2Ph4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541260; c=relaxed/simple;
	bh=ZCZZewG2HTul4dll/38bVXYAwekM1ldgzxeNW7rCWR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MuUYNNYno+6e+RROhOIT/bXjCyGBrB02rzDL8aT2N5WItgJMj2F96Sut4/nxktof7AFM74nJDvktr797sCW3n4pJxK5OOxm7OcyyehySauW/H8B6dNyf2WOTJPTevaEc7bJHkpnkQww4VEzwtDrxDKHSUa2+51tXNFzRzk6QnKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ka0pMMog; arc=fail smtp.client-ip=52.103.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/8o204DSJl2TjUjTrC9POF9+YIdK6a1eJYgu9Hb79fU+Vr/1h5y07vLpuugY4Lf0rRKh/qgOkm8xdV1bgLyeS3HtZSr1HMzn6CFbC57FjrISuDZAaqLwvFpCDxEmrO7THWFA+oE1KSkbmJ/oDreyveqzjqkWHRpE4VuOe+CtVcVltXtDnl0lDDhPEpb63D7ZVceiv3LybJLlmgfQhayvrqO/Kdk9oM92c+ZVaOHrtLELWAiK8knc17WAhHrwDG2EVaDQukjTqx4MxA2c+cOjmhjz7SlUab1Lk1ADrXfBzr62gT4iu6uAFCax8fQVyi3quIY6OMGOgnmQ0PWxasLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCZZewG2HTul4dll/38bVXYAwekM1ldgzxeNW7rCWR0=;
 b=CQuvr/kgKeD8zEI+2pLQxFHRHulJ8FBz7dInCBDuGHeKswzgjIc/TNggmSy754Y8qLQLtocaL2LyYGwg8wSEped0KNWYpP5UUN8j+D85xeHKACdcdAo9aVDBTtUCGz0JvGfGJ2WCzXd/4fKbDByrFTAv3/Q/M2lpqp3/wp8LgcEkwHefeMh39Wn7jvqKczfSC2tqIF5mXDb3oaTNxQ/zGj/WD8fWQWa/ejLVm4qsPesdMXMof1PQ4wemGRKsWvYEvHXyDKsTunyY9E/dR4ZgivFbHUEaXTToWuLArb6JPcD5bjJpkq2ThYHVrQU4cUTDLOzJBWGO46+xAMCR291sDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCZZewG2HTul4dll/38bVXYAwekM1ldgzxeNW7rCWR0=;
 b=Ka0pMMogYseaehKk5DpLRnKSSSATdhuL5OTFtP9ylGZyjBfgeYBaLvlnH3sjvK9UUjxX8G+4+Gm1qFCFOo+cChPL1DPETCKqEHyR2CkjNTzsc3P7B3u7rmOg0xFshNrLPeKXTAqB3Dyxq+eNLWDD66ZMjxHBta+42hBrpAYH3SNNQqK8MgfMCcA09bOOvdwclraSXg3Z7Wo1AT6ZgWSgGR0wthY3HKi5V3nmR2J0Fx7nwGmBd5ZCWeBTFVg3cwHVwmW0uLozjVnIdc1rlhP7sT6uEXdAe1kccPUuHmAvR8pbxSAiOYHQU2aWUau0mxVTG0QT52nscona4ThAvnskTw==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYCP286MB2928.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 15:40:55 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 15:40:55 +0000
From: Qi Qi <ArcticLampyrid@outlook.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
CC: "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
	"james.schulman@cirrus.com" <james.schulman@cirrus.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
	"rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] ALSA: hda/realtek: Fix internal speakers for
 Legion Y9000X 2022 IAH7
Thread-Topic: [PATCH v3 2/2] ALSA: hda/realtek: Fix internal speakers for
 Legion Y9000X 2022 IAH7
Thread-Index: AQHakZMnl6GUz3RxgkmV9kw8BxeryrFuDjcAgAGuiwA=
Date: Fri, 19 Apr 2024 15:40:55 +0000
Message-ID: <5830451.DvuYhMxLoT@qlaptoparch>
References:
 <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB25359B61BB685A4B3110BB44C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
Reply-To: "ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com"
	<ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [OxaR2dtzbSKeJLXG2GdLqvRTtuGuXvWe]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB2535:EE_|TYCP286MB2928:EE_
x-ms-office365-filtering-correlation-id: 0c6197c1-75be-46ac-9b77-08dc60871a12
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n5wAwctJK9cNYCC8CiRsUARWcKR9AcJx/PmZPlsTS9f2d8ep+tV+auk4yD6uiHsat5vHIPCodsFsjifFLQY5meXtyg2oxAuKA9f/+zAl5flKWv4fKCQDt7Pfozd+cxkLyJj/9QH+xL9v8iBNlHsbPKT2sDER9eMND18ZoC0RnD7/WL4SG8A8EX1D5L8pUZTKkKJw8GE91dsHasaSUELpOKgBSIFNChnVlswaOUusvBhIUVLuf4on6bzeDg4X1X8TZ2Mr0IHzCJOGrzrvtl8ULobzuuNYKbpw7tzpNZA9IKO/de1ET3aA+sbyBf+mn/v7mmoPO5os8Vh4ckvfzBGtVTqYj0qWcE8KE3IX6Et1jk3sMkeKgwqty1EhIVWJKa/ZO2GCHuhR7Zms/pRZo9F5C5TDasQYZJvo2eeCa6dmWGZOGNegAUArvD1MdyMacKRL9ULjFmD8r3J9IMwaFt5w3sVjoKr0FNBN9ji7YN5aXePh4BhhqhMjpvxV+gk0/cZvgWrLWwhY3jKE6BihlIh3Le7pLXqiFttoEg0oB5qdvUkQAq8NZr8dAMJwPcx5jXG6
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWI2bWdCZWZkQ1QyeVB5Yjc1WjMxZENWSkRNTTMwdUUwc0VaS0hjb3dVbXls?=
 =?utf-8?B?bTNIQzBCRGd0NkVFYklLOGI1R3d2STV3Z09qazRNd01vMm5vdzJIN3NiRWdw?=
 =?utf-8?B?MjVyOUNDYVQyS2FiUXFPZUE4YjBxSXZsYlVCWVhaNVFaUVBDTmtTc3lLNnFP?=
 =?utf-8?B?VDAxK1pDOHJmTGx4SmsrR042MTh0OXV5U0V1R3lPSW1wd0FYbTBhUVFjeVM2?=
 =?utf-8?B?ZmVKQXZ3RncwK08yeTZZdzZUTTIya2NpSXVaaDNoQmk4YndWM1JuWit6VE1U?=
 =?utf-8?B?UVVYYWtCMTZGaUVYWjc2RUdRWklhSE81SjlTajAwVUtKOEZCUkdZcm4zQTNU?=
 =?utf-8?B?Zys0dmpnelJFaTFhUWV1SnJudC8vVXJOb25hQ1N5YUJQZDJGbkdmbmEvK0o2?=
 =?utf-8?B?cFpLUEhvcUFFTWp3Zk05RzdFS3lZVjNEMEZyMjlWVW9GSzVlcVJsYVZEL3Vn?=
 =?utf-8?B?OTVMK3EyaXJlempKd0QzNEZtZzFWOUNhc0liV28wVU9ualNEK2J4cHBQdTcx?=
 =?utf-8?B?TFRSeFcwd2JFWW1XSXNVWjlGSGVPQmhDM1JzK3lyZ2lHdkJBYW5GQzVwNjVK?=
 =?utf-8?B?S29DbENXWkd3K01hTXNPdCtJMHkxa1l5SUNtNzdpblVXUkxNL0VOdHg3ZHlw?=
 =?utf-8?B?QlRydGIzVGhFSFI1N2ZvZWUyQXBKbmJzSk1sVW1vWXVpSkpqRC9YTkdIUVJx?=
 =?utf-8?B?T21kYjNnTGNPdUdpUk9GVDBmZlk5a0diK3A1aWtYOUpYS1BqZW84OEI3Z2dE?=
 =?utf-8?B?Uk9NQ08wY1d3NUUrNmhlVlBMeURwMWQxc3NIaDRIVkNhSFp3R0Z6UHhxbG1C?=
 =?utf-8?B?YXdPdDB3U2hOZjhKcS9VWnc1bElDTS9NdllVSVAvNWllNGltVldNL1NhL3Zv?=
 =?utf-8?B?RTEvcU02azJoNlcwSDRsTGxNQW9SNDJQdVJUa0d2RWRaYVRTKy9kK0loY1JW?=
 =?utf-8?B?Z0hCcGJITTZWWUZKdUlRRTZ1MG1QZGtCNHZ1MWVpNmJaUDVIY0VIOEtGTjNr?=
 =?utf-8?B?Y1ZxNXZhcHhMM2hLK01Vd1FLaTJPbE8vUW1GVFc4S3Z4OUovYmk1TnJaNmZG?=
 =?utf-8?B?Wlo1MXRIQWx2dEw0c01lR1h3M0Zmd0lQOC9BR29rTzlodlk1eFVVdGFza1k2?=
 =?utf-8?B?cElwdWhTb3lLVEhvU04zdWttNElkQjRGSUFlSDZ6TGlkMWZJcWU4UFFzaGVF?=
 =?utf-8?B?USsrVzkvdU5nT1Q1eW9YbE9rUWtyQkF4ei9zKzRtTEhROGl5RERoVTBvZlJi?=
 =?utf-8?B?azZFQnE2UE4xRXhMUGtvbW9PdlpuS3ZaOWU2S0dPYStjQWtyRFBPRVI2b3dI?=
 =?utf-8?B?Q1pPSEhJNUlON0VDaXA2Nk14a2NZUW1RUWUya3dlemNCNk5XV21ibkpCeEdn?=
 =?utf-8?B?d3BOYTI1dDY5cWhMcVF0Z3AxdDNZbktmZzMzVi9iT2M4TEVLWmJqZ3ZORXRJ?=
 =?utf-8?B?SWxKTkdZM0s2U25zcllhMW1QUk44OGRRQW12dGUxRnkvWGdRZVQzYk5QVUpl?=
 =?utf-8?B?LzRZd2FJV3hoYXZ6VTFlelc1MDdFbzY5QWp1VVVBZWFTc2VQWFBZdFBrMHRU?=
 =?utf-8?B?RjBhcG4yMTJqYlpPdWhQelIrbkw2UlRPUU40Tk5BSmNBeGVRVXVFK0pIdXpy?=
 =?utf-8?B?NW5uTzJxZ3FtVGtGVDVkZHRRdm1uTTNrVERwUjQ2dzd6Q1M0Qmx5VjRKWURX?=
 =?utf-8?Q?oyB9702XWPg9kKI12jtJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B2B008B7DA13644970E24ED76682775@JPNP286.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6197c1-75be-46ac-9b77-08dc60871a12
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 15:40:55.3808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2928

SSBiZWxpZXZlIHdlIHNob3VsZCBvYmV5IHRoZSB0eXBlIGRlY2xhcmVkIGluIERTRFQgdGFibGUg
aWYgaXQgZXhpc3RzLCBpbiAKZ2VuZXJhbCBjYXNlLgoKQ291bGQgeW91IHBsZWFzZSBleHBsYWlu
IHdoeSBpdCBkaWQgbm90IHNvbHZlIHRoZSBpbnRlcnJ1cHQ/IElzIGl0IGEgCm1pc2xlYWRpbmcg
aXRlbSBpbiBEU0RUPwoKVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg==

