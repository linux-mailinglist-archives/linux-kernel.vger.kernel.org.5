Return-Path: <linux-kernel+bounces-116571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1788A0D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E1B1C36450
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5099154BE7;
	Mon, 25 Mar 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="DWuoj5QN"
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11020003.outbound.protection.outlook.com [52.101.154.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A292155396;
	Mon, 25 Mar 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711347563; cv=fail; b=cUmjdCL5Pew3T4e2iD5kPDGzfQfW0AsZHK8hXZZugioUbEJzqdjS8mBbR6TO0ms1QAgnMKKnCxQmXcmmcAtvr9FkcPuk+GXPrIgOP4ESTPlfYY9Ii0coZMrSfS2jyfQcy7+NskvzcP2vYqBCHYrjwqe7RR0lautQJdvBc5wkHrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711347563; c=relaxed/simple;
	bh=bkqgjZmX4jzqLsEqpBccsDAz6Vv2dw25yxIgKbxD/sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tdp9EZQPDYN49yHM5Ku9S+4186KO+BUqzWjMOmF9C4NKxKVToYt1Ft0/i4GuC38T5AiviMhQPcIOeXpdLmuJ+f0zqRswJ7ieAbnvsjJj1voteh9UcZayJkbxAqf2gLMobYa5SsqaN0uJltmLXRs4i1ocMJXDD5cgop+oD+d/G2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=DWuoj5QN; arc=fail smtp.client-ip=52.101.154.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDq+sSx2l0rgRHKFyIQk9hVOQMrfUDelY3AnCrKPwJPgILspxA7CRrm93lnscaUF2MddjeDtuyYAMd0/KxlCi/BoyRC95lzxY8HJOBCKaLyQHbsexz9nFQybUPzFBbfHFLXyFY4A8wMamj2lgheMJHlF2wE/Mta2F2CPcSIRYLyBsfdfDdegke9/hRbaHT6i7ri39qiVuzWqupmwunGWh+Aiwx0w0pArYhJkxzfT3g65qcS28punbETovd3obD1LonSJclMEztpJ8RLn9VDy9VgwbZHnusPi5iZK1IiJjpfU3xApyrRqfSykjGwuDjBv7GpBr5aSipGZye3Gn6ifCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP8sfWb7ZAvLUC8yjQ2pDACFzVBEdN8EA0+5GchMlqw=;
 b=LXh4AHkPH38QA9z/gZ3v7hIUynnO3lMU5Sv+Plz95AJlNFnaU4dw7e7qYKggRAdxqIoZreBSxIaH8tAmB22czOlXqdxYOJrkI31w4XXtZ1rb3eWWHg/8roelpZOVIwH9JBqGxISohzIVFtHbZmHUPjefH147TxOViIzDAamNQw03bQkx0zTwd8KYtIGQTGrbCD9HqbD0MAxAB+lv7CXba3JXSXVAVcn9Pu8UCrJG0MiI1xE6qYdHmOHOcl7WkZZlqhr0BQU6oqkc50A7IYpJnFQJQi/arurzXmFrzvo+Ecn41y5fhG71Ebe1JLonr5r410GimhaiM6rDseJQCPMbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP8sfWb7ZAvLUC8yjQ2pDACFzVBEdN8EA0+5GchMlqw=;
 b=DWuoj5QNwIy+TGEaxZrYL7ThJHcEmhF7OuZAtieU0N39ynGZaFnP0ouKt6q9XcOl6PJeTIEeW4h9WiCzcMy8TgnJITiv3zjT7znxOErS9wQ68+FaP3jR5QIdEfa7+q7S/kw/4Cog7Yj+H94ZeCgdhJAJGhEH42jDg1/VuivDdZI=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE1P216MB1671.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 06:19:14 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 06:19:14 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: "mchehab@kernel.org" <mchehab@kernel.org>, "nicolas@ndufresne.ca"
	<nicolas@ndufresne.ca>, "sebastian.fricke@collabora.com"
	<sebastian.fricke@collabora.com>, "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, Nas Chung
	<nas.chung@chipsnmedia.com>, lafley.kim <lafley.kim@chipsnmedia.com>,
	"b-brnich@ti.com" <b-brnich@ti.com>
Subject: RE: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
 format,SPS/PPS generation for each IDR                   
Thread-Topic: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
 format,SPS/PPS generation for each IDR                   
Thread-Index: AQHac6LGzHawQ158fESNuZ0k+bm+6bFIEONw
Date: Mon, 25 Mar 2024 06:19:14 +0000
Message-ID:
 <SE1P216MB1303D2A884C6F904553E4432ED362@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
In-Reply-To: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|SE1P216MB1671:EE_
x-ms-office365-filtering-correlation-id: 4fba020d-43e3-47d8-3b57-08dc4c937e43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mYrPEwSH6QCMEh+RiZ4qZaIhsFQj5k+t///XWYyiLJKCGGIz7YvGpuqGtbwRR7ZjM7FDmj2JjhBYy2td1Escz07GPAgAB7Wr0oVs+S1yBF90CX1QieHW3m2flzVEeQ5j6FwDRHsXzz/727d7N4bw3f/V8AGoXoHS4ovIQ9TMU3NDHDkFUnDmILLTFRCE23kWh4dXMcAIWhEWWwGJQKwoeKGcBG2+kTSMkYzAFMFaQKkbtopBLMWp7CfloiHrwR1P8tXPS6CaAcGukBlTdqAyjVBIaj3rudAObwAe6RDKOA1oXcSZfzL/A5EE3bKXjzccZjkRD8Fi3IVVan7f7pI+PJySh2ampV+1kMn26V5rIMDCCWL/JKD3Js5+4BfNHl2UE59bJ3id4H/zgheO+K45qDHZRg+mE7TaUI2yFPm4by490Dm6M02XskbwuYWqNv+/PfAWEU+Ql7d7I4LTEd56CZ4pum2gUIXS9LYVNN++P4UydbjjZJYRJ0kWcZJn3pE1Cx2bp5KnVoR9LiZ7ozFQ8N9vAGEgLZO2apW8v+cq309tn8kKTQbx4LgYGOfUQSrxYpJVf3zamU12xe148zDfOeRCGxWUn6Av+cESBz3gAIIz82QBl7y3MSrBA3z2wPqwYLQqWrkNEnj5Ff6pKyMzqSd7cJ0Uj+snp+ZohnMe3ww=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+5eirhN20hwFOS7TL0OK08UmUJUihGm6K+fZJ51lHnCzuyBiA5ncehhN6hcK?=
 =?us-ascii?Q?2l1G3KPcgm7qwvX+t8qHiWZXuyZ1epDasJzYVqRbn4ST10s9NtZmDvjyy+kL?=
 =?us-ascii?Q?vkUV/6aKTNDBJC/P5Efo+22nlp9xikyLl6N6y1YsSTDjk/pENhnnA8hc08Jg?=
 =?us-ascii?Q?QAHXvGqe4B8+sXgPKvNXdVd40grwMKw+gkv/3len/38D0PbWf5ig6ic801Yg?=
 =?us-ascii?Q?2/ualpEKr/o2UULF/lXhu++GNcaszSVwlB8theyWXBKu6syBj9bcHSiNa+D7?=
 =?us-ascii?Q?73VITn6n4ncS6qcdorG10by79IOcz3IAa3HnnysKI2WOdvA4+gcI3X8/9j+R?=
 =?us-ascii?Q?zC1yWR1nCKJaNIdzjX3a/97K2NRFtzCi2Axo+y6q/Kxx9BKx2htn1W1niOKm?=
 =?us-ascii?Q?myQlvLcB3vobZhE41GFE2cdr9CmpOZ+x/dOyuiqU4OZBZDNNwwqM1IZHZ5T5?=
 =?us-ascii?Q?oNCc7fm9fIQjGQHW/BJs0noRotcR+C9Wc82TS6jLhFRuw34fdfYNjdmU6YsG?=
 =?us-ascii?Q?NNWcuN+cYmKE1SMYUN4glvmq7MnIEBQTbH47tN0nu73tyDlfnBRk5NlKN8XA?=
 =?us-ascii?Q?mjhSB7m5kiOQ84g7OEE3mJ0iUIDM8dDFh7uPaUO4fDQlA5aK9q5hszwv5ta3?=
 =?us-ascii?Q?Noia+FSQ8cAa/rwV5Beh07vvR6aoAJJovtR9aANCihOvjiYrJSsIr2v3IfuK?=
 =?us-ascii?Q?d29D7xH5wFv9dRW7J9K/on9TRRmSarvkyQk7/Xqk0GABs0Tqq/cVuLtpAsLt?=
 =?us-ascii?Q?UboZltcZJ1GlJVor5TzPJsAqiZENfPKusGjgZ2DgAoStvr4tjF+tFCg4pCML?=
 =?us-ascii?Q?VF9t0VXSY7RHXf8chw/tdI4HCw5dt5psEyeHSyZ/qO72h8cLpj6dPiU+Hqts?=
 =?us-ascii?Q?KjDm6sroE8qO85Xih/l4vF1mRteerR6OwolEMp70P8XhdruyAh+/XtO2MZd+?=
 =?us-ascii?Q?T9jYISMLr5MZk3SXW+zS8QJJAUyQf7LfH+God62/Lyv67vKYc6zRwrhkt8zf?=
 =?us-ascii?Q?bwsqr4zo55diFZ+u63TShojidNKW/TBSY3VQHemtrI3VbZ/FU+HV4ur6Di+b?=
 =?us-ascii?Q?hwJP1523NiTvdOPlfqc1DKvd3Ls22om7cn0kjrZyi9Zp6fo+CFM0dpuBAIuc?=
 =?us-ascii?Q?f3Rl4kyaOSJNamMCm2y6cKlUkHdUDElXe/XFHVvOjUTNDcckGFE84+ShjNnq?=
 =?us-ascii?Q?6lclDnVkLruLADjrlQtX5iG3g+NbiYsLa5z3lQ3lfwlcNHw0XUlbY/9fZJSv?=
 =?us-ascii?Q?ixbdCfG/JQsAoXvnwWzqawCec1pUa4AeAWDz9kWxEU/Pc7xSM29wML3sHr5w?=
 =?us-ascii?Q?/R7dMDu0XO0h2rfFCDyX/S9x7e0BDZOW/d+s8ZbXv9WiCPKrMO+/xnoU8VrQ?=
 =?us-ascii?Q?MJFXw18vJIrgN4xRhT4HyvoC9d3cv7JhRGGyVVFpn7rf255lcQHdjNES42TR?=
 =?us-ascii?Q?yiZAXQJ8IUznh86NbPmNzE5/HOWRxaiTm0p3DFYnMS7loPwgHRb/9SgUiKcw?=
 =?us-ascii?Q?qImOoO6J82AjawLVTc8DhsO7Y0595s6vXelmkPnBk16gzIWy8y6PeXN3Q8ex?=
 =?us-ascii?Q?JCfwufUH6z6MX+IVIlrFYjECwiL8E5IfiYZrIYY1xHQbTDzP199FBgCkG/DT?=
 =?us-ascii?Q?vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fba020d-43e3-47d8-3b57-08dc4c937e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 06:19:14.1805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j74cYmR+ylDYmbbKHtVNbGld+oSHsd9U0JMM/PwCU9caLNIa7caIUvgH/eaHBSYJhxg+rQiFc/g26JylrVYWlr5g/H/fMfV8qiyWSGSHMkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1671

Hello Sebastian, Hans and Nicolas

Could you please review the below patch series ?


https://patchwork.linuxtv.org/project/linux-media/list/?series=3D12404


thanks
Jackson

> -----Original Message-----
> From: jackson.lee <jackson.lee@chipsnmedia.com>
> Sent: Monday, March 11, 2024 7:56 PM
> To: mchehab@kernel.org; nicolas@ndufresne.ca;
> sebastian.fricke@collabora.com
> Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> hverkuil@xs4all.nl; Nas Chung <nas.chung@chipsnmedia.com>; lafley.kim
> <lafley.kim@chipsnmedia.com>; b-brnich@ti.com; jackson.lee
> <jackson.lee@chipsnmedia.com>
> Subject: [RESEND PATCH v2 0/4] Add auto suspend/resume,YUV422
> format,SPS/PPS generation for each IDR
>=20
> From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>=20
> The wave5 codec driver is a stateful encoder/decoder.
> The following patches is for supporting yuv422 inpuy format, supporting
> runtime suspend/resume feature and extra things.
>=20
> v4l2-compliance results:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>=20
> Buffer ioctls:
>             warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not
> supported
>             warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not
> supported
>     test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>     test VIDIOC_EXPBUF: OK
>     test Requests: OK (Not Supported)
>=20
> Total for wave5-dec device /dev/video0: 45, Succeeded: 45, Failed: 0,
> Warnings: 2 Total for wave5-enc device /dev/video1: 45, Succeeded: 45,
> Failed: 0, Warnings: 0
>=20
> Fluster test results:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Running test suite JCT-VC-HEVC_V1 with decoder GStreamer-H.265-V4L2-Gst1.=
0
> Using 1 parallel job(s)
> Ran 132/147 tests successfully               in 94.782 secs
>=20
> (1 test fails because of not supporting to parse multi frames, 1 test
> fails because of a missing frame and slight corruption, 2 tests fail
> because of sizes which are incompatible with the IP, 11 tests fail becaus=
e
> of unsupported 10 bit format)
>=20
> Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0
> Using 1 parallel job(s)
> Ran 77/135 tests successfully               in 37.364 secs
>=20
> (58 fail because the hardware is unable to decode  MBAFF / FMO / Field /
> Extended profile streams.)
>=20
>=20
> Chnage since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * For [PATCH v2 0/4] media: chips-media: wave5: Support SPS/PPS generatio=
n
> for each IDR
>  - define a macro for register addresses
>=20
> * For [PATCH v2 1/4] media: chips-media: wave5: Support runtime
> suspend/resume
>  - add auto suspend/resume
>=20
> * For [PATCH v2 2/4] media: chips-media: wave5: Use helpers to calculate
> bytesperline and sizeimage
>  - use helper functions to calculate bytesperline and sizeimage
>=20
> * For [PATCH v2 3/4] media: chips-media: wave5: Support YUV422 raw pixel-
> formats on the encoder
>  - remove unnecessary codes
>=20
> Change since v0:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The DEFAULT_SRC_SIZE macro was defined using multiple lines, To make a
> simple define, tab and multiple lines has been removed, The macro is
> defined using one line.
>=20
> Jackson.lee (4):
>   media: chips-media: wave5: Support SPS/PPS generation for each IDR
>   media: chips-media: wave5: Support runtime suspend/resume
>   media: chips-media: wave5: Use helpers to calculate bytesperline and
>     sizeimage.
>   media: chips-media: wave5: Support YUV422 raw pixel-formats on the
>     encoder.
>=20
>  .../platform/chips-media/wave5/wave5-helper.c |  24 ++
>  .../platform/chips-media/wave5/wave5-helper.h |   4 +
>  .../platform/chips-media/wave5/wave5-hw.c     |  23 +-
>  .../chips-media/wave5/wave5-vpu-dec.c         | 261 +++++-------------
>  .../chips-media/wave5/wave5-vpu-enc.c         | 260 +++++++++--------
>  .../platform/chips-media/wave5/wave5-vpu.c    |  43 +++
>  .../platform/chips-media/wave5/wave5-vpu.h    |   4 -
>  .../platform/chips-media/wave5/wave5-vpuapi.c |  14 +-
>  .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
>  .../chips-media/wave5/wave5-vpuconfig.h       |  25 +-
>  .../media/platform/chips-media/wave5/wave5.h  |   3 +
>  11 files changed, 329 insertions(+), 333 deletions(-)
>=20
> --
> 2.43.0


