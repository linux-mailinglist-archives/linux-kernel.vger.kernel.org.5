Return-Path: <linux-kernel+bounces-98452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADBA877A51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DF0281FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F257469;
	Mon, 11 Mar 2024 04:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="Mqt1FlQy"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022019.outbound.protection.outlook.com [52.101.154.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE3187F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131102; cv=fail; b=TSpqVndQ5jQ9LtMgVJ3tioVqFN3ARhKikieqv22BZ+b1FxcX6z08o1kX6QCDE0FYYYVK/GX3V+JXBlScgR+wKQJfbHR2Z5Sc8QAMx3uIdUwmzc83nscP1DD4nNJ6mekqSTYwVx6u6fDnFZgkCf80pTxzQFT9XVFKZpwkH86zxfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131102; c=relaxed/simple;
	bh=E0IPmZ0SjnzbyJAJ9OgqR5+8wA1KtmbDCkCOeyM2cDA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ASTwpJnyyJadj2AB+ShAsTN4KxPVGvye7TkZdPMVcNg1RjSYDYMux7MNo1c6V8DHgZdWm8/EaCY70992frFYEXMdnxisPm8qxdTaiEdktfZxS0AA2FEZ9eaohSoWUMB4RQ7euCUT1r+t/Zdb722I834b43KVmdBQxCqFt4rotGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=Mqt1FlQy; arc=fail smtp.client-ip=52.101.154.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pri5wSUMa/3+XR/JGSFjD7nsnLbcon+RmKoZLDXIlc572cr0w7YWm+ELyka1YDAAbRgfsDUpPVNICnlgSB0BUzzQJ9/MULljdbtLpW4+or1dz4a/gh2M0eudJPPk5ORphCVAV7uhhBRBdwH/cO4q/FOVrd55OrtGgwKZoYl3jmIcR41hJe6tQ72LeORZmQTfEth+SIV2Rp0rjKF2w/p9311RYKY9x0fGonyeoydeuin+uhAbhUOcYiU/JjMVgBEHR6UUt8kTmhOlLf4Xuwv7ZToxfh1mineEdi28N6/+r7x/VmHuyfda0Fx61NjFaCux0TR32MJ8iUvdJHWNOppnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Djyg/XsCTOBRehODvaycVE6N13/xQaWPHsBW1001/w=;
 b=Oy5pkW3anQp5suhOCz98mp4JgbIkoVWDlsQn0m51/kE8V5W62T6r1XHzdp4mt6gLOSkSrkOrxC80iBR3NAgAjJV/CYEEmqiwEbkHUUQbA0Gp6yi2CBqoSWBlCt5kFWL0Yf9+7h03p5+cUqdZBPDerOpVrVdfPVavqHeiECb+GCV7a8Tmfe5LbmIQHHQ9NjADZddL1qFs/fIreOq8RsheLz1LjJpIZp4MMS9klMSF6hNVjuRHklLZhCnK5E9g36D+vjb00U0uw6QCqA+pXRtti/GFkE1uZwcP/x0uRMAwdVhUSyPlhHbHM9JUv5YxAiSKl5IYMAj4RHx0QLUV4V41yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Djyg/XsCTOBRehODvaycVE6N13/xQaWPHsBW1001/w=;
 b=Mqt1FlQydlsQjMX9E0jlNt5yBvDsS6UXhvk8/Ms82hMFnUz/weKAM6AyyNefUNpHGtbalOuHc3t+TXaMoGRLKO9YZYQlIgmu4TYHbfyXYj8n83Ara1Ctj/unjftwwzY9zJx4CvbjuOykYlTLxtCefvYwwPSp052wLXwSY+ZqU7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB1997.KORP216.PROD.OUTLOOK.COM (2603:1096:301:12f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 04:24:53 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::ebb8:2043:fd53:303a%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 04:24:53 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [PATCH v2 0/4] wave5 codec driver
Date: Mon, 11 Mar 2024 13:24:38 +0900
Message-Id: <20240311042442.10755-1-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:100:55::29) To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|PU4P216MB1997:EE_
X-MS-Office365-Filtering-Correlation-Id: 8868ab7a-0d69-4ffe-8666-08dc4183333d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OPYISe1qbduiEOtT3mfd1wBcIr/zpB1jjQ/QPdi1J6lMu5lzgy7WDlvXrl2i/eaKj5kUoRsFvjuaLJzOnOuKzy0ozbt8Ry74hsCft8Ix+V+uxvdkpC9R8HKehr6kOm+ei2fYBz89uREpDXrWOyKY2AvjqMIjdYQ+xtjWf8tRPlvbX3E3jEray8p2087UAvDWp3l/vyMcnLszWJm4fu4SxSpGfCM+OZyqA4Q6BnsIBCpLD0WIhcnNY7hpX/UK4tzAAxutWpspc2Q0pFHCG52aksZhKf3CQGVP7R4uHLOxmBuF0+e2iviryS0g2F6m+k6NpQL2R6r91Yq3uSVcJQ9t9bGjT5vFxRpy+rc8w4gMxarVgasgydfZxG9M/uglkDtuQ2rCMRbg+YeAcCcIkKuqhAAqPsnxsOsA3/BIyZPkIIce578ldk57mZKiq1FBYmTYGY2NMM2asZS3eEHvv2/YyweiHjR1xAIbZAqlS2XgWPYShZD9QoQJSjx1RNN8I6kPmfCsvnN70/4knKu4i4NW1BZOyOnTcVCeaEk67zlX62aY7i9H77aVKtlYL1vovnTAQOq8pOrp0vD/LX+3QuK+8jc7yYNXpRNKhPs21ocDPm/R6NZ30VJujOa5xwiB8bwkWIT6zTe5jAi5Qx7/oRZX8HxBYogAnDQec1kaLqq3YH9E8j5bGkdi6R81kgmDQZjN61hdgatrce4flOS7EYWCqwAsE9r27TDO75/BmhGI6T0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YIPIw+SWq4Z/XgYWRGhtiyna2SWq3TyhjsLKKK2V5FVNNEgD3IXCyeUZmxlP?=
 =?us-ascii?Q?Ni7Xkq4EplUN9n0vxTk1R0K1cvQr8kiu+H6kgawPGq2oNmDcoNfmkUmQeVz1?=
 =?us-ascii?Q?BIp36SDvWG1tduZEfadPHhVCE3CV2FxHc5LQCpUuijpVWbw1UXDbdD2h0XIo?=
 =?us-ascii?Q?Z3Axyd9fT0niafmw3VIaPrv7X1NUiSzQ25SkukbGgvUxDdsySKOFmkUazr+R?=
 =?us-ascii?Q?UerqEuavcG1pywZ7tGKwnaIUpG1pJM6bbyPoh+i8eQyWNj9O5Tc2dxGIXSrM?=
 =?us-ascii?Q?4FtF8WGldE8I/7bHjgKlXprxeYcd0aO+gYg8gX8AssQdDIJj8yNOIrINorB+?=
 =?us-ascii?Q?RtqMX0ayaxr2GaL1IaCeutcbxo5Y2BITC5E67DFd0IOeKkF7Pa6SLUjpchLV?=
 =?us-ascii?Q?WT5ZSaol/D7yN2wVSo+uoEzCLZ9AJ4n0y1QBca7YnmTL3OYoNgejGaoUQqIy?=
 =?us-ascii?Q?V0HeD7CrYz/ufm/r0YTZzkKC2VX4ZyKnReZdRD4Mv7yGhvnoTF2PNFajkIfq?=
 =?us-ascii?Q?ZePXCYKrQbi9m3iUSUodifXPs3x7p9OReJVpHGJlnWNquWP85m5LjhfUQyVk?=
 =?us-ascii?Q?KLONUuhnJWMW7VWhRO1wO64OUEJy+Pns/WyaolsBDmnVHNAA28aD6rqszsNa?=
 =?us-ascii?Q?QtdzdCsxfqbaWIkRl0nzgN5T8yODh+KOxhNNMsqhPKtahQJgspIZWysPcFKh?=
 =?us-ascii?Q?5Dj9M288qmooEUEzwv0VZ/x7DUtHvHsSah9kaWGkGcOk7TPiuxbWFlsIAfvW?=
 =?us-ascii?Q?/Dp1FSwmlFUAL26Os5LCea5UbC0Qca6ngQHXxrEnLdlDi8lXw2MTi/+KB0VA?=
 =?us-ascii?Q?4TelFgeeAHIhs4NjPmPi1drypDp6avh6oEXrgToXPfwzIJz+Hs3cTMFhK3b1?=
 =?us-ascii?Q?7Dj3jtf7UaFW87snsxdl273VvSQay4CUkDakKZh9nKfxItpihL3+sLicoPjO?=
 =?us-ascii?Q?y861Hu0KP/YpQHK0FFMBU/4m3cruMSb9/YyOJEMFuvTZ/kQJjRyqoWHOplQb?=
 =?us-ascii?Q?amseUqURg3BFRJJgJjvwrbLMO8YlF396TsZRHpqyTh1PkATGmW5DjwD5vulM?=
 =?us-ascii?Q?gTb56rE6JnelqN6PxZPYruivX6ZBV+kUWj2yM0EWtTcqsLaiK5lZT9o5F76j?=
 =?us-ascii?Q?9HHNd35iwWxyKt61LgurhWd5iNGasYG0vfcY+ldNPjXWP7v9e0SrxIvo9iPw?=
 =?us-ascii?Q?Tz8FqqWVBOVcKrELUOJZDJwH88BmB703ZZLovRvVFcu8lIgvNVqbVL5dPaVN?=
 =?us-ascii?Q?6+YEHQOw4EwavQSw+RXXBIt6IhItNFYAWPzlOotvXZHChW1wP4/i9J7ie47O?=
 =?us-ascii?Q?ReqnzazFxzzpubHKunC0VWeuagU2/38eGhie8Q8d4As5CNTGMSxdx8PdzkP5?=
 =?us-ascii?Q?Wz6RSeLp2y1g2QfRK3NKMDF/0+oQ9hXBUIx5SyYFtDfMkpAkjxpOP4Vwa2ud?=
 =?us-ascii?Q?m1fm4kTs0JCDYKpG01dhoUpFf0ZBOmI05nCy0omfFQwxIB/31fZs4elXRwIt?=
 =?us-ascii?Q?9TSLiFUiq+ivhSggBrKRpesymrWMKJm5O2B2ovb95jGIwdIcQkgACb4XcAou?=
 =?us-ascii?Q?hQdWu08dHf5w4MbXhB4G698DD2MoObNYZ6KdELyKcfTPOxnLt+hVFWuVEMeD?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8868ab7a-0d69-4ffe-8666-08dc4183333d
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 04:24:53.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf8Ni/pRn0ULUiMaIpEiexUeST7WLOLPi55IKogEl6zJx5zxRqMPVI2LvSNQqtw3w1diecpwCPnyesUSKBBv6DsrKAutDyse/rv+eW8TNSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1997

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

The wave5 codec driver is a stateful encoder/decoder.
The following patches is for supporting yuv422 inpuy format, supporting
runtime suspend/resume feature and extra things.

v4l2-compliance results:
========================

v4l2-compliance 1.24.1, 64 bits, 64-bit time_t

Buffer ioctls:
	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
    test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
    test VIDIOC_EXPBUF: OK
    test Requests: OK (Not Supported)

Total for wave5-dec device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 2
Total for wave5-enc device /dev/video1: 45, Succeeded: 45, Failed: 0, Warnings: 0

Fluster test results:
=====================

Running test suite JCT-VC-HEVC_V1 with decoder GStreamer-H.265-V4L2-Gst1.0 Using 1 parallel job(s)
Ran 132/147 tests successfully               in 94.782 secs

(1 test fails because of not supporting to parse multi frames, 1 test fails because of a missing frame and slight corruption, 2 tests fail because of sizes which are incompatible with the IP, 11 tests fail because of unsupported 10 bit format)

Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0 Using 1 parallel job(s)
Ran 77/135 tests successfully               in 37.364 secs

(58 fail because the hardware is unable to decode  MBAFF / FMO / Field / Extended profile streams.)


Chnage since v1:
=================

* For [PATCH v2 0/4] media: chips-media: wave5: Support SPS/PPS generation for each IDR
 - define a macro for register addresses

* For [PATCH v2 1/4] media: chips-media: wave5: Support runtime suspend/resume
 - add auto suspend/resume

* For [PATCH v2 2/4] media: chips-media: wave5: Use helpers to calculate bytesperline and sizeimage
 - use helper functions to calculate bytesperline and sizeimage

* For [PATCH v2 3/4] media: chips-media: wave5: Support YUV422 raw pixel-formats on the encoder
 - remove unnecessary codes

Change since v0:
=================
The DEFAULT_SRC_SIZE macro was defined using multiple lines,
To make a simple define, tab and multiple lines has been removed,
The macro is defined using one line.


Jackson.lee (4):
  media: chips-media: wave5: Support SPS/PPS generation for each IDR
  media: chips-media: wave5: Support runtime suspend/resume
  media: chips-media: wave5: Use helpers to calculate bytesperline and
    sizeimage.
  media: chips-media: wave5: Support YUV422 raw pixel-formats on the
    encoder.

 .../platform/chips-media/wave5/wave5-helper.c |  24 ++
 .../platform/chips-media/wave5/wave5-helper.h |   4 +
 .../platform/chips-media/wave5/wave5-hw.c     |  23 +-
 .../chips-media/wave5/wave5-vpu-dec.c         | 261 +++++-------------
 .../chips-media/wave5/wave5-vpu-enc.c         | 260 +++++++++--------
 .../platform/chips-media/wave5/wave5-vpu.c    |  43 +++
 .../platform/chips-media/wave5/wave5-vpu.h    |   4 -
 .../platform/chips-media/wave5/wave5-vpuapi.c |  14 +-
 .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
 .../chips-media/wave5/wave5-vpuconfig.h       |  25 +-
 .../media/platform/chips-media/wave5/wave5.h  |   3 +
 11 files changed, 329 insertions(+), 333 deletions(-)

-- 
2.43.0


