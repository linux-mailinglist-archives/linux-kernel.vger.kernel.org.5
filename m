Return-Path: <linux-kernel+bounces-163241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA5F8B6790
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446281C20FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716F211C;
	Tue, 30 Apr 2024 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="PCy0MIHF"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022018.outbound.protection.outlook.com [52.101.154.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B1DF6B;
	Tue, 30 Apr 2024 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441163; cv=fail; b=IV7Ee7yrhhX34NZNJ29lsgo0bXGc7wBI86XHLaVgSKnu7KAytuRfr6fWbFHZArHsmWPBx8m62BoAYkfGl2vhfIiZ2hnqR5x650s0U+1TfPxtpP6F65URZx2qL550tMvXWl+pIuIXQaa6xGxM53zQGUxb/0O18vMgDoMsa4GcjZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441163; c=relaxed/simple;
	bh=fWMfOKl0WaENi/wH3IETIAGpgBhq3z+Q0r3lFOIfvT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KH2zWvAayoniOANYr5LQ/Ab0YdezaV7GITszyZ6swggkhjeKyx2omFFGQqo4Bhv0qqp1AXghFnSKDfVPN6ieDAGtV3soL9RcXjku7c79s5mmtc/xIyTGes8Yt9PrwWLqxVgZhcp1n/fwp0NYqKOyiwpkT2ox9KiUwVUcrysfxIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=PCy0MIHF; arc=fail smtp.client-ip=52.101.154.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1iaLd43KAy/lIapi6tIWxYyh25t9qEeJaHVVgTPJ4QAa71O/sH0ii89wyIAiVru23xEmuXbPEhwMdYpGUne+r2l/aMTbEm5OiHWM3qyFLFa55syIXVRBKSKAowa0CXhuDluIwOcXT+DcYa/kAXBJRrlLwFn1yQXhqksk6V2j7kWJPkfYKi4gj8PHQ9hZxzUGuYo6LJ2xp8vC9jC+HJN/LADDIVhLcJGxkdceY9ocaLPDBlu359bkA0jvSRN1RxUpdMebwmJI3dmnjG9kzkBggSxTPCc2I6wGD/U0D8DhrXCcZ8hLmb0xai1EFZm544oaZ4mGCgypnTwuswfUuxmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMpRAJuDXeAL/jDdaHyv14CvGuT1qCcCjG8+V8gEFFs=;
 b=BJoplyZrwsPcFGble+/c49tLccl7KoQ8SkdB1fKLEo0IqW+S2ORXAPZV7+t7Zscn5HQwNBNFpJqtZUnMZPe4zyxRGqrki70Y9ArCpXqtSEZLfqMcLsF46Horg2/S+zUMmqf295lntoyIq9ppKnJaiK0oEbTuwkInqw23mbKDbXPM7t5/C8s3+wvMJ7EEZCI8Na2IGXAAHSdRQBXQMY6zlTxqMIkk7MtXlWmNRxalktOqEAiMP6ZziAaZHYKdxNwNpL5GWQx45hsSfUEC/+m+urw/BCjkHiPO49ZDLVnmOpmAWIo4jIdu1Aq4rjmtw6Je7lLK9/wSNU8aDoH8/IUXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMpRAJuDXeAL/jDdaHyv14CvGuT1qCcCjG8+V8gEFFs=;
 b=PCy0MIHFGv+9wqbm2Ly41IcAQ1B5PvDdtc9PXMCLwyTj383OYdgs5GRkorgVIxaCu+Yd0scOnXgdtMXN1y7IidiP4oiVdQsB8g3we5ZFlytVvKLlRiFvOuBmKOTUz7e9QaIJgyXVF3X+oHWymIrVcaPRIbGzdlxJqct0ggs3tb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 SL2P216MB2195.KORP216.PROD.OUTLOOK.COM (2603:1096:101:150::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.36; Tue, 30 Apr 2024 01:39:10 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 01:39:10 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	jackson.lee@chipnsmedia.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [PATCH v3 3/4] media: chips-media: wave5: Use helpers to calculate bytesperline and sizeimage.
Date: Tue, 30 Apr 2024 10:38:59 +0900
Message-Id: <20240430013900.187-4-nas.chung@chipsnmedia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430013900.187-1-nas.chung@chipsnmedia.com>
References: <20240430013900.187-1-nas.chung@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0211.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::19) To SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2P216MB1246:EE_|SL2P216MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: 35202a82-af80-471a-c944-08dc68b65563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uSPIZTSwx/PDEopb5jxBLuSf9vpmeD9Hv6oiNIPvGhJXWSdxcWHIgLYXVuqb?=
 =?us-ascii?Q?mH3/5XQpB+doPWG2b7+jGnzsGsG5SJ+7/GRjNXBoNBy0/syW+2CnbC0LQ7iq?=
 =?us-ascii?Q?NqBEMEq9mjCuZMPEI1mRIk0mFETBDFnzOz5GDJOVnIxQpgfCgA7lYpoF4CSb?=
 =?us-ascii?Q?DoofI8JjuSmS7ZiproUi/tWI2baOMNgEY0XNIFHIVVULSFTtF2NYbB6YxY2b?=
 =?us-ascii?Q?KvvikMHiAKzFmXWA891LRc35pgk8V9/NyBr072hp37hsKgCLFxL0xWFcwQd4?=
 =?us-ascii?Q?NO6+2vW3/rd1iHxOPDK5dwOnNV0gAjztMCLQkAUZK9L5w9O2x1PkNdxZsRF/?=
 =?us-ascii?Q?YDPQpJnamxHU7nranHOsLG+o3NszM7E6OKuAicQQkDJEgxGmNCvoym1aZSUp?=
 =?us-ascii?Q?tmDC8Lxfe7QSkkY5S+j+kxhIQewsemqshxniKhoqne9vVZFsiOGkSfXPOxPy?=
 =?us-ascii?Q?MNdEr3/estkNWV3GI05o6ROYl008QX5qOkJmgmT8KofrXS/eYDUiDwC4qz7a?=
 =?us-ascii?Q?ArDxJP9PR0nSs5JwVFaxLYv3mauUOPzz2oSLXrv1C0xRZCMpTDmqWoYtW5up?=
 =?us-ascii?Q?4RxKegOfFJYRb7CElrWekhfekuj+AnXUtCLkp8rV8rZpjn7B7MLXfw/NSyso?=
 =?us-ascii?Q?ttkvGLBkEbrea2LLi34Zxab0clHSDApV+lunBdaPDTm38eo4XIyMk4n1hOEJ?=
 =?us-ascii?Q?Z82odbFDBNdVwZocpgeiwJ6OHjcBZN8I6d+xsJ3be48Cjca99byXsLsVQ+5F?=
 =?us-ascii?Q?WiXJwHcsLGD2MfmjqMf5hil1BNMZpmRleXQ9s7FLEO6wUTs5CRVeUA5/yWjn?=
 =?us-ascii?Q?fkyydOWA3QpzTNS00UkIhZP5Kz8x1zIP8qrz9mwFz4YtdaLkrVumtcu3cpO/?=
 =?us-ascii?Q?TcTc80TUlsaKRCJJS/DX3yTstLG4P1mj0I2eFvtlsYhXx0Db26wBfbh50mZ9?=
 =?us-ascii?Q?HV+Vkf7Av697pUlksuw9sQ4o5CsfdMLz1MtI3259x+4JZgGtq4MDsx2mHl8u?=
 =?us-ascii?Q?aXjL5ueoWwPmC5EMbZp0Yzbh6Pjf1uFr+kGFe+/fFqdSJYzBzD2n8s9mZXK8?=
 =?us-ascii?Q?Lf/aSixbF3uU7G0WvP3jxUGEoz0f8mRpOT0c4RQvqnc1e2NVTWJgQofh0g/f?=
 =?us-ascii?Q?kLO66imcGYBFHTChKDd0N9HUkz0+rVvMgbJECLL30Cyr86TMKMoNVNhYCpHG?=
 =?us-ascii?Q?pD6GSQU2V9mxq7Yf6fAANLOed7al1Jx2tFAzLJJ0pWPQwRIEJYaTC8z/hAT8?=
 =?us-ascii?Q?t9a/7I26e12vQocM/hZCG7MYSPYZB/LcrU0VnjdES6o/ro4oVirhXwJ1s8Ky?=
 =?us-ascii?Q?ICFfQ4rI1YSz4zDYD3xg3IlBJpt3BXAPq5TxXxXSZ0uFnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M5O2GamFEUL0f6utfNTCOLAwGWPOBn3k5piX43msr6ZukIlJ45aUXBUCUj52?=
 =?us-ascii?Q?MJ/0mdmAh1wVqimeqQFx8rtXodUsCJTQbvIBNxC3JuB/TDLyRvx0X1HhzyZK?=
 =?us-ascii?Q?8Xum7BWT1YZB9b3cHniwqKTZW4Hoi8a7SBWhu+MevLz7yvfzuNQNM3uLRFcA?=
 =?us-ascii?Q?14xGM90CHI3fnfWipCKpANd4peWjMm/Gr2UZRjyFI1rNVFQVZp35lrVjRI7G?=
 =?us-ascii?Q?WLuIGzYOlE0OpYICuoD2CLOR0Zy8/QvHb2b5EXmmlqSCWkHDuMiJtpXioylX?=
 =?us-ascii?Q?gdrmM96lc1NccoIZigJPe9mIV/UfOAEdLPZuB21N0Vr+jxkIqtlp62OTCPVY?=
 =?us-ascii?Q?Nrg9UOYGec+n0k0VOxmtckqlKchy0ksWHjxqDsHuLjTqYJW0i552CSQkn97n?=
 =?us-ascii?Q?BLsOrZfKnlhd3zUVI7lEJK9jVZ7dZA5Ryo/bdYBTJNG/dFTC2spX60C01I48?=
 =?us-ascii?Q?ewgHMGx0TeHiS/e7ZeTvw7b0JodB8B2SZyZqm+a4mW/HlTx+g0G5ZSzY4/oO?=
 =?us-ascii?Q?3J8c5XrnqHr6yLjaeQIaILLz2rKYTiQWS+QYFUlSZQUioDmJayJQrdZmOjsz?=
 =?us-ascii?Q?FXzjAj74I2T8iGBcmJl4Y+QRuaskQfwvTWk3u2ZGfhIuWdOz0EQPEtr4b0lP?=
 =?us-ascii?Q?FtoWRozcs8IsyBJ7UwEEXwA+927qzhBA56mOLPLvTwmqJAUnV6V3kBfYpSTJ?=
 =?us-ascii?Q?YTndp4dmEtpMvzq9soFnRz+VOTIwnfBTVsf41s2Lr/mFIAhxUCQOEDuFMtXb?=
 =?us-ascii?Q?VZlFxHUA8w4TkTUEG/i4jNpyFk5MgHtpgKTnS9rLTdBJuLdce80ZryeSr17c?=
 =?us-ascii?Q?0ej5s9VrOsLjuOsh7OUfJb4+/r1sKCg15kttRZE92pRbBHpiTKcqw8XvdW8v?=
 =?us-ascii?Q?vgHYaZdedtqRKvyq55J7DHgrG+s3uQQOkNva89eC5OjTgPdKsdSTEFEVrLyC?=
 =?us-ascii?Q?rIGIrk3cXzY6UbMnPYc71O6MITnCrtS9oyhrjoaHQWVRo2TriaEAolZ46ZwW?=
 =?us-ascii?Q?EqfR+saYsu3uZyJG/NpxLDAaljePG1duGctjcbPO6opvSRhGnwcVPmHoRer/?=
 =?us-ascii?Q?xGkdw2EUhCmQTcONMjEusRKlMgwEaM2uNof6t+4UwVgeQ+ax1wqqN9F0zOrR?=
 =?us-ascii?Q?i2Ww7TfUWA0irtUIbupt0BYI2jsyEdy+31rSdn+gDHvQeHFYA0DZ4qh22uUV?=
 =?us-ascii?Q?ta+a0xiWtEWIDYnzaU1dP+Q/g+tqCkrkQePMk1zg9e3Ztuz2kkgixfhEuW3T?=
 =?us-ascii?Q?fEx07IXXI9Dixw0+Z0oQmzxhuwBjycWN9NOe/6UL/sNM1nuO6DKEiE/wGyVP?=
 =?us-ascii?Q?dJdDOLQ5k1YWuQtzJ8Zx1UxXTQ/hE+cRJvIDM8GKDFq+xqvs5Ne3AIS7E1BS?=
 =?us-ascii?Q?gtuVYNNWmPR3iM0mrWVq+yDNF/8Dg805F/rNTQFNM5c1YAhn81TxqzbkSN8P?=
 =?us-ascii?Q?ASSpjNeDYX5zDcgxi6KFUeGyKlUOB51B5k728WXXQXA42HbvQYkaI53+WaGt?=
 =?us-ascii?Q?dSugK0hZc41CeQb0F1jDppEhOwNeDKyq2EuI9L8sKAVVd0WKqaKRcZwS/OMC?=
 =?us-ascii?Q?gP1+ylp7J4OCbVAuppZT515otcghmaw6Q2Gke/dPWYctmHPptANWgnQN1GVc?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35202a82-af80-471a-c944-08dc68b65563
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 01:39:10.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO2eVBMea5gLZ89mWPyLZ+GsDtacm7YaS8Lsm+ltTMOSUKAz5/N/XKGJ+dytLxzAOqY6/29FCi4CpAcXSqFbeYaVujaZZpvDL9fSkgFWvA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB2195

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

Use v4l2-common helper functions to calculate bytesperline and sizeimage, instead of calculating in a wave5 driver directly.
In case of raw(YUV) v4l2_pix_format, the wave5 driver updates v4l2_pix_format_mplane struct through v4l2_fill_pixfmt_mp() function.
Encoder and Decoder need same bytesperline and sizeimage values for same v4l2_pix_format.
So, a wave5_update_pix_fmt is refactored to support both together.

Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-helper.c |  24 ++
 .../platform/chips-media/wave5/wave5-helper.h |   5 +
 .../chips-media/wave5/wave5-vpu-dec.c         | 298 ++++++------------
 .../chips-media/wave5/wave5-vpu-enc.c         | 197 +++++-------
 .../platform/chips-media/wave5/wave5-vpu.h    |   5 +-
 .../chips-media/wave5/wave5-vpuconfig.h       |  27 +-
 6 files changed, 238 insertions(+), 318 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/drivers/media/platform/chips-media/wave5/wave5-helper.c
index 7e0f34bfa5be..b20ab69cd341 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
@@ -7,6 +7,8 @@
 
 #include "wave5-helper.h"
 
+#define DEFAULT_BS_SIZE(width, height) ((width) * (height) / 8 * 3)
+
 const char *state_to_str(enum vpu_instance_state state)
 {
 	switch (state) {
@@ -224,3 +226,25 @@ void wave5_return_bufs(struct vb2_queue *q, u32 state)
 		v4l2_m2m_buf_done(vbuf, state);
 	}
 }
+
+void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp,
+			  int pix_fmt_type,
+			  unsigned int width,
+			  unsigned int height,
+			  const struct v4l2_frmsize_stepwise *frmsize)
+{
+	v4l2_apply_frmsize_constraints(&width, &height, frmsize);
+
+	if (pix_fmt_type == VPU_FMT_TYPE_CODEC) {
+		pix_mp->width = width;
+		pix_mp->height = height;
+		pix_mp->num_planes = 1;
+		pix_mp->plane_fmt[0].bytesperline = 0;
+		pix_mp->plane_fmt[0].sizeimage = max(DEFAULT_BS_SIZE(width, height),
+						     pix_mp->plane_fmt[0].sizeimage);
+	} else {
+		v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat, width, height);
+	}
+	pix_mp->flags = 0;
+	pix_mp->field = V4L2_FIELD_NONE;
+}
diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.h b/drivers/media/platform/chips-media/wave5/wave5-helper.h
index 6cee1c14d3ce..9937fce553fc 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-helper.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.h
@@ -28,4 +28,9 @@ const struct vpu_format *wave5_find_vpu_fmt_by_idx(unsigned int idx,
 						   const struct vpu_format fmt_list[MAX_FMTS]);
 enum wave_std wave5_to_vpu_std(unsigned int v4l2_pix_fmt, enum vpu_instance_type type);
 void wave5_return_bufs(struct vb2_queue *q, u32 state);
+void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp,
+			  int pix_fmt_type,
+			  unsigned int width,
+			  unsigned int height,
+			  const struct v4l2_frmsize_stepwise *frmsize);
 #endif
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 861a0664047c..b20cec5d8fdd 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -11,111 +11,96 @@
 #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
 #define VPU_DEC_DRV_NAME "wave5-dec"
 
-#define DEFAULT_SRC_SIZE(width, height) ({			\
-	(width) * (height) / 8 * 3;					\
-})
+static const struct v4l2_frmsize_stepwise dec_frmsize[FMT_TYPES][MAX_FMTS] = {
+	[VPU_FMT_TYPE_CODEC] = {
+		{
+			.min_width = W5_MIN_DEC_PIC_8_WIDTH,
+			.max_width = W5_MAX_DEC_PIC_WIDTH,
+			.step_width = W5_DEC_CODEC_STEP_WIDTH,
+			.min_height = W5_MIN_DEC_PIC_8_HEIGHT,
+			.max_height = W5_MAX_DEC_PIC_HEIGHT,
+			.step_height = W5_DEC_CODEC_STEP_HEIGHT,
+		},
+		{
+			.min_width = W5_MIN_DEC_PIC_32_WIDTH,
+			.max_width = W5_MAX_DEC_PIC_WIDTH,
+			.step_width = W5_DEC_CODEC_STEP_WIDTH,
+			.min_height = W5_MIN_DEC_PIC_32_HEIGHT,
+			.max_height = W5_MAX_DEC_PIC_HEIGHT,
+			.step_height = W5_DEC_CODEC_STEP_HEIGHT,
+		}
+	},
+	[VPU_FMT_TYPE_RAW] = {
+		{
+			.min_width = W5_MIN_DEC_PIC_8_WIDTH,
+			.max_width = W5_MAX_DEC_PIC_WIDTH,
+			.step_width = W5_DEC_RAW_STEP_WIDTH,
+			.min_height = W5_MIN_DEC_PIC_8_HEIGHT,
+			.max_height = W5_MAX_DEC_PIC_HEIGHT,
+			.step_height = W5_DEC_RAW_STEP_HEIGHT,
+		}
+	},
+};
 
 static const struct vpu_format dec_fmt_list[FMT_TYPES][MAX_FMTS] = {
 	[VPU_FMT_TYPE_CODEC] = {
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_HEVC,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_CODEC][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_H264,
-			.max_width = 8192,
-			.min_width = 32,
-			.max_height = 4320,
-			.min_height = 32,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_CODEC][1],
 		},
 	},
 	[VPU_FMT_TYPE_RAW] = {
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV422P,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420M,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12M,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21M,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV422M,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV16M,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV61M,
-			.max_width = 8192,
-			.min_width = 8,
-			.max_height = 4320,
-			.min_height = 8,
+			.v4l2_frmsize = &dec_frmsize[VPU_FMT_TYPE_RAW][0],
 		},
 	}
 };
@@ -234,74 +219,6 @@ static void wave5_handle_src_buffer(struct vpu_instance *inst, dma_addr_t rd_ptr
 	inst->remaining_consumed_bytes = consumed_bytes;
 }
 
-static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned int width,
-				 unsigned int height)
-{
-	switch (pix_mp->pixelformat) {
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-		pix_mp->width = round_up(width, 32);
-		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height * 3 / 2;
-		break;
-	case V4L2_PIX_FMT_YUV422P:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		pix_mp->width = round_up(width, 32);
-		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height * 2;
-		break;
-	case V4L2_PIX_FMT_YUV420M:
-		pix_mp->width = round_up(width, 32);
-		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[1].sizeimage = width * height / 4;
-		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[2].sizeimage = width * height / 4;
-		break;
-	case V4L2_PIX_FMT_NV12M:
-	case V4L2_PIX_FMT_NV21M:
-		pix_mp->width = round_up(width, 32);
-		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = width * height / 2;
-		break;
-	case V4L2_PIX_FMT_YUV422M:
-		pix_mp->width = round_up(width, 32);
-		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[1].sizeimage = width * height / 2;
-		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[2].sizeimage = width * height / 2;
-		break;
-	case V4L2_PIX_FMT_NV16M:
-	case V4L2_PIX_FMT_NV61M:
-		pix_mp->width = round_up(width, 32);
-		pix_mp->height = round_up(height, 16);
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = width * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = width * height;
-		break;
-	default:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = 0;
-		pix_mp->plane_fmt[0].sizeimage = max(DEFAULT_SRC_SIZE(width, height),
-						     pix_mp->plane_fmt[0].sizeimage);
-		break;
-	}
-}
-
 static int start_decode(struct vpu_instance *inst, u32 *fail_res)
 {
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
@@ -389,6 +306,8 @@ static int handle_dynamic_resolution_change(struct vpu_instance *inst)
 	}
 
 	if (p_dec_info->initial_info_obtained) {
+		const struct vpu_format *vpu_fmt;
+
 		inst->conf_win.left = initial_info->pic_crop_rect.left;
 		inst->conf_win.top = initial_info->pic_crop_rect.top;
 		inst->conf_win.width = initial_info->pic_width -
@@ -396,10 +315,25 @@ static int handle_dynamic_resolution_change(struct vpu_instance *inst)
 		inst->conf_win.height = initial_info->pic_height -
 			initial_info->pic_crop_rect.top - initial_info->pic_crop_rect.bottom;
 
-		wave5_update_pix_fmt(&inst->src_fmt, initial_info->pic_width,
-				     initial_info->pic_height);
-		wave5_update_pix_fmt(&inst->dst_fmt, initial_info->pic_width,
-				     initial_info->pic_height);
+		vpu_fmt = wave5_find_vpu_fmt(inst->src_fmt.pixelformat, dec_fmt_list[VPU_FMT_TYPE_CODEC]);
+		if (!vpu_fmt)
+			return -EINVAL;
+
+		wave5_update_pix_fmt(&inst->src_fmt,
+					VPU_FMT_TYPE_CODEC,
+					initial_info->pic_width,
+					initial_info->pic_height,
+					vpu_fmt->v4l2_frmsize);
+
+		vpu_fmt = wave5_find_vpu_fmt(inst->dst_fmt.pixelformat, dec_fmt_list[VPU_FMT_TYPE_RAW]);
+		if (!vpu_fmt)
+			return -EINVAL;
+
+		wave5_update_pix_fmt(&inst->dst_fmt,
+					VPU_FMT_TYPE_RAW,
+					initial_info->pic_width,
+					initial_info->pic_height,
+					vpu_fmt->v4l2_frmsize);
 	}
 
 	v4l2_event_queue_fh(fh, &vpu_event_src_ch);
@@ -548,12 +482,7 @@ static int wave5_vpu_dec_enum_framesizes(struct file *f, void *fh, struct v4l2_f
 	}
 
 	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
-	fsize->stepwise.min_width = vpu_fmt->min_width;
-	fsize->stepwise.max_width = vpu_fmt->max_width;
-	fsize->stepwise.step_width = 1;
-	fsize->stepwise.min_height = vpu_fmt->min_height;
-	fsize->stepwise.max_height = vpu_fmt->max_height;
-	fsize->stepwise.step_height = 1;
+	fsize->stepwise = *vpu_fmt->v4l2_frmsize;
 
 	return 0;
 }
@@ -589,14 +518,10 @@ static int wave5_vpu_dec_try_fmt_cap(struct file *file, void *fh, struct v4l2_fo
 		width = inst->dst_fmt.width;
 		height = inst->dst_fmt.height;
 		f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
-		f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
 	} else {
-		const struct v4l2_format_info *info = v4l2_format_info(vpu_fmt->v4l2_pix_fmt);
-
-		width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
-		height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
+		width = f->fmt.pix_mp.width;
+		height = f->fmt.pix_mp.height;
 		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
-		f->fmt.pix_mp.num_planes = info->mem_planes;
 	}
 
 	if (p_dec_info->initial_info_obtained) {
@@ -604,9 +529,10 @@ static int wave5_vpu_dec_try_fmt_cap(struct file *file, void *fh, struct v4l2_fo
 		height = inst->dst_fmt.height;
 	}
 
-	wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
-	f->fmt.pix_mp.flags = 0;
-	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	wave5_update_pix_fmt(&f->fmt.pix_mp, VPU_FMT_TYPE_RAW,
+					     width,
+					     height,
+					     vpu_fmt->v4l2_frmsize);
 	f->fmt.pix_mp.colorspace = inst->colorspace;
 	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
 	f->fmt.pix_mp.quantization = inst->quantization;
@@ -719,6 +645,7 @@ static int wave5_vpu_dec_try_fmt_out(struct file *file, void *fh, struct v4l2_fo
 {
 	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
 	const struct vpu_format *vpu_fmt;
+	int width, height;
 
 	dev_dbg(inst->dev->dev,
 		"%s: fourcc: %u width: %u height: %u num_planes: %u colorspace: %u field: %u\n",
@@ -727,20 +654,19 @@ static int wave5_vpu_dec_try_fmt_out(struct file *file, void *fh, struct v4l2_fo
 
 	vpu_fmt = wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, dec_fmt_list[VPU_FMT_TYPE_CODEC]);
 	if (!vpu_fmt) {
+		width = inst->src_fmt.width;
+		height = inst->src_fmt.height;
 		f->fmt.pix_mp.pixelformat = inst->src_fmt.pixelformat;
-		f->fmt.pix_mp.num_planes = inst->src_fmt.num_planes;
-		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_fmt.height);
 	} else {
-		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
-		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
-
+		width = f->fmt.pix_mp.width;
+		height = f->fmt.pix_mp.height;
 		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
-		f->fmt.pix_mp.num_planes = 1;
-		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
 	}
 
-	f->fmt.pix_mp.flags = 0;
-	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	wave5_update_pix_fmt(&f->fmt.pix_mp, VPU_FMT_TYPE_CODEC,
+					     width,
+					     height,
+					     vpu_fmt->v4l2_frmsize);
 
 	return 0;
 }
@@ -748,6 +674,7 @@ static int wave5_vpu_dec_try_fmt_out(struct file *file, void *fh, struct v4l2_fo
 static int wave5_vpu_dec_s_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
 {
 	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	const struct vpu_format *vpu_fmt;
 	int i, ret;
 
 	dev_dbg(inst->dev->dev,
@@ -782,7 +709,14 @@ static int wave5_vpu_dec_s_fmt_out(struct file *file, void *fh, struct v4l2_form
 	inst->quantization = f->fmt.pix_mp.quantization;
 	inst->xfer_func = f->fmt.pix_mp.xfer_func;
 
-	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp.height);
+	vpu_fmt = wave5_find_vpu_fmt(inst->dst_fmt.pixelformat, dec_fmt_list[VPU_FMT_TYPE_RAW]);
+	if (!vpu_fmt)
+		return -EINVAL;
+
+	wave5_update_pix_fmt(&inst->dst_fmt, VPU_FMT_TYPE_RAW,
+					     f->fmt.pix_mp.width,
+					     f->fmt.pix_mp.height,
+					     vpu_fmt->v4l2_frmsize);
 
 	return 0;
 }
@@ -1005,6 +939,7 @@ static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buff
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	struct v4l2_pix_format_mplane inst_format =
 		(q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt : inst->dst_fmt;
+	unsigned int i;
 
 	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type: %u\n", __func__,
 		*num_buffers, *num_planes, q->type);
@@ -1018,31 +953,9 @@ static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buff
 		if (*num_buffers < inst->fbc_buf_count)
 			*num_buffers = inst->fbc_buf_count;
 
-		if (*num_planes == 1) {
-			if (inst->output_format == FORMAT_422)
-				sizes[0] = inst_format.width * inst_format.height * 2;
-			else
-				sizes[0] = inst_format.width * inst_format.height * 3 / 2;
-			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
-		} else if (*num_planes == 2) {
-			sizes[0] = inst_format.width * inst_format.height;
-			if (inst->output_format == FORMAT_422)
-				sizes[1] = inst_format.width * inst_format.height;
-			else
-				sizes[1] = inst_format.width * inst_format.height / 2;
-			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u\n",
-				__func__, sizes[0], sizes[1]);
-		} else if (*num_planes == 3) {
-			sizes[0] = inst_format.width * inst_format.height;
-			if (inst->output_format == FORMAT_422) {
-				sizes[1] = inst_format.width * inst_format.height / 2;
-				sizes[2] = inst_format.width * inst_format.height / 2;
-			} else {
-				sizes[1] = inst_format.width * inst_format.height / 4;
-				sizes[2] = inst_format.width * inst_format.height / 4;
-			}
-			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u | size[2]: %u\n",
-				__func__, sizes[0], sizes[1], sizes[2]);
+		for (i = 0; i < *num_planes; i++) {
+			sizes[i] = inst_format.plane_fmt[i].sizeimage;
+			dev_dbg(inst->dev->dev, "%s: size[%u]: %u\n", __func__, i, sizes[i]);
 		}
 	}
 
@@ -1564,20 +1477,17 @@ static const struct vb2_ops wave5_vpu_dec_vb2_ops = {
 static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_fmt,
 				     struct v4l2_pix_format_mplane *dst_fmt)
 {
-	unsigned int dst_pix_fmt = dec_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt;
-	const struct v4l2_format_info *dst_fmt_info = v4l2_format_info(dst_pix_fmt);
-
 	src_fmt->pixelformat = dec_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix_fmt;
-	src_fmt->field = V4L2_FIELD_NONE;
-	src_fmt->flags = 0;
-	src_fmt->num_planes = 1;
-	wave5_update_pix_fmt(src_fmt, 720, 480);
-
-	dst_fmt->pixelformat = dst_pix_fmt;
-	dst_fmt->field = V4L2_FIELD_NONE;
-	dst_fmt->flags = 0;
-	dst_fmt->num_planes = dst_fmt_info->mem_planes;
-	wave5_update_pix_fmt(dst_fmt, 736, 480);
+	wave5_update_pix_fmt(src_fmt, VPU_FMT_TYPE_CODEC,
+				      W5_DEF_DEC_PIC_WIDTH,
+				      W5_DEF_DEC_PIC_HEIGHT,
+				      &dec_frmsize[VPU_FMT_TYPE_CODEC][0]);
+
+	dst_fmt->pixelformat = dec_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt;
+	wave5_update_pix_fmt(dst_fmt, VPU_FMT_TYPE_RAW,
+				      W5_DEF_DEC_PIC_WIDTH,
+				      W5_DEF_DEC_PIC_HEIGHT,
+				      &dec_frmsize[VPU_FMT_TYPE_RAW][0]);
 }
 
 static int wave5_vpu_dec_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 703fd8d1c7da..75d230df45f6 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -11,65 +11,60 @@
 #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
 #define VPU_ENC_DRV_NAME "wave5-enc"
 
+static const struct v4l2_frmsize_stepwise enc_frmsize[FMT_TYPES] = {
+	[VPU_FMT_TYPE_CODEC] = {
+		.min_width = W5_MIN_ENC_PIC_WIDTH,
+		.max_width = W5_MAX_ENC_PIC_WIDTH,
+		.step_width = W5_ENC_CODEC_STEP_WIDTH,
+		.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		.max_height = W5_MAX_ENC_PIC_HEIGHT,
+		.step_height = W5_ENC_CODEC_STEP_HEIGHT,
+	},
+	[VPU_FMT_TYPE_RAW] = {
+		.min_width = W5_MIN_ENC_PIC_WIDTH,
+		.max_width = W5_MAX_ENC_PIC_WIDTH,
+		.step_width = W5_ENC_RAW_STEP_WIDTH,
+		.min_height = W5_MIN_ENC_PIC_HEIGHT,
+		.max_height = W5_MAX_ENC_PIC_HEIGHT,
+		.step_height = W5_ENC_RAW_STEP_HEIGHT,
+	},
+};
+
 static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
 	[VPU_FMT_TYPE_CODEC] = {
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_HEVC,
-			.max_width = W5_MAX_ENC_PIC_WIDTH,
-			.min_width = W5_MIN_ENC_PIC_WIDTH,
-			.max_height = W5_MAX_ENC_PIC_HEIGHT,
-			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+			.v4l2_frmsize = &enc_frmsize[VPU_FMT_TYPE_CODEC],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_H264,
-			.max_width = W5_MAX_ENC_PIC_WIDTH,
-			.min_width = W5_MIN_ENC_PIC_WIDTH,
-			.max_height = W5_MAX_ENC_PIC_HEIGHT,
-			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+			.v4l2_frmsize = &enc_frmsize[VPU_FMT_TYPE_CODEC],
 		},
 	},
 	[VPU_FMT_TYPE_RAW] = {
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420,
-			.max_width = W5_MAX_ENC_PIC_WIDTH,
-			.min_width = W5_MIN_ENC_PIC_WIDTH,
-			.max_height = W5_MAX_ENC_PIC_HEIGHT,
-			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+			.v4l2_frmsize = &enc_frmsize[VPU_FMT_TYPE_RAW],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12,
-			.max_width = W5_MAX_ENC_PIC_WIDTH,
-			.min_width = W5_MIN_ENC_PIC_WIDTH,
-			.max_height = W5_MAX_ENC_PIC_HEIGHT,
-			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+			.v4l2_frmsize = &enc_frmsize[VPU_FMT_TYPE_RAW],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21,
-			.max_width = W5_MAX_ENC_PIC_WIDTH,
-			.min_width = W5_MIN_ENC_PIC_WIDTH,
-			.max_height = W5_MAX_ENC_PIC_HEIGHT,
-			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+			.v4l2_frmsize = &enc_frmsize[VPU_FMT_TYPE_RAW],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_YUV420M,
-			.max_width = W5_MAX_ENC_PIC_WIDTH,
-			.min_width = W5_MIN_ENC_PIC_WIDTH,
-			.max_height = W5_MAX_ENC_PIC_HEIGHT,
-			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+			.v4l2_frmsize = &enc_frmsize[VPU_FMT_TYPE_RAW],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV12M,
-			.max_width = W5_MAX_ENC_PIC_WIDTH,
-			.min_width = W5_MIN_ENC_PIC_WIDTH,
-			.max_height = W5_MAX_ENC_PIC_HEIGHT,
-			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+			.v4l2_frmsize = &enc_frmsize[VPU_FMT_TYPE_RAW],
 		},
 		{
 			.v4l2_pix_fmt = V4L2_PIX_FMT_NV21M,
-			.max_width = W5_MAX_ENC_PIC_WIDTH,
-			.min_width = W5_MIN_ENC_PIC_WIDTH,
-			.max_height = W5_MAX_ENC_PIC_HEIGHT,
-			.min_height = W5_MIN_ENC_PIC_HEIGHT,
+			.v4l2_frmsize = &enc_frmsize[VPU_FMT_TYPE_RAW],
 		},
 	}
 };
@@ -106,46 +101,6 @@ static int switch_state(struct vpu_instance *inst, enum vpu_instance_state state
 	return -EINVAL;
 }
 
-static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned int width,
-				 unsigned int height)
-{
-	switch (pix_mp->pixelformat) {
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height * 3 / 2;
-		break;
-	case V4L2_PIX_FMT_YUV420M:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 4;
-		pix_mp->plane_fmt[2].bytesperline = round_up(width, 32) / 2;
-		pix_mp->plane_fmt[2].sizeimage = round_up(width, 32) * height / 4;
-		break;
-	case V4L2_PIX_FMT_NV12M:
-	case V4L2_PIX_FMT_NV21M:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[0].sizeimage = round_up(width, 32) * height;
-		pix_mp->plane_fmt[1].bytesperline = round_up(width, 32);
-		pix_mp->plane_fmt[1].sizeimage = round_up(width, 32) * height / 2;
-		break;
-	default:
-		pix_mp->width = width;
-		pix_mp->height = height;
-		pix_mp->plane_fmt[0].bytesperline = 0;
-		pix_mp->plane_fmt[0].sizeimage = width * height / 8 * 3;
-		break;
-	}
-}
-
 static int start_encode(struct vpu_instance *inst, u32 *fail_res)
 {
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
@@ -360,13 +315,8 @@ static int wave5_vpu_enc_enum_framesizes(struct file *f, void *fh, struct v4l2_f
 			return -EINVAL;
 	}
 
-	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
-	fsize->stepwise.min_width = vpu_fmt->min_width;
-	fsize->stepwise.max_width = vpu_fmt->max_width;
-	fsize->stepwise.step_width = 1;
-	fsize->stepwise.min_height = vpu_fmt->min_height;
-	fsize->stepwise.max_height = vpu_fmt->max_height;
-	fsize->stepwise.step_height = 1;
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise = enc_frmsize[VPU_FMT_TYPE_CODEC];
 
 	return 0;
 }
@@ -392,6 +342,7 @@ static int wave5_vpu_enc_try_fmt_cap(struct file *file, void *fh, struct v4l2_fo
 {
 	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
 	const struct vpu_format *vpu_fmt;
+	int width, height;
 
 	dev_dbg(inst->dev->dev, "%s: fourcc: %u width: %u height: %u num_planes: %u field: %u\n",
 		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
@@ -399,20 +350,19 @@ static int wave5_vpu_enc_try_fmt_cap(struct file *file, void *fh, struct v4l2_fo
 
 	vpu_fmt = wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, enc_fmt_list[VPU_FMT_TYPE_CODEC]);
 	if (!vpu_fmt) {
+		width = inst->dst_fmt.width;
+		height = inst->dst_fmt.height;
 		f->fmt.pix_mp.pixelformat = inst->dst_fmt.pixelformat;
-		f->fmt.pix_mp.num_planes = inst->dst_fmt.num_planes;
-		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->dst_fmt.width, inst->dst_fmt.height);
 	} else {
-		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
-		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
-
+		width = f->fmt.pix_mp.width;
+		height = f->fmt.pix_mp.height;
 		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
-		f->fmt.pix_mp.num_planes = 1;
-		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
 	}
 
-	f->fmt.pix_mp.flags = 0;
-	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	wave5_update_pix_fmt(&f->fmt.pix_mp, VPU_FMT_TYPE_CODEC,
+					     width,
+					     height,
+					     vpu_fmt->v4l2_frmsize);
 	f->fmt.pix_mp.colorspace = inst->colorspace;
 	f->fmt.pix_mp.ycbcr_enc = inst->ycbcr_enc;
 	f->fmt.pix_mp.quantization = inst->quantization;
@@ -500,6 +450,7 @@ static int wave5_vpu_enc_try_fmt_out(struct file *file, void *fh, struct v4l2_fo
 {
 	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
 	const struct vpu_format *vpu_fmt;
+	int width, height;
 
 	dev_dbg(inst->dev->dev, "%s: fourcc: %u width: %u height: %u num_planes: %u field: %u\n",
 		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix_mp.height,
@@ -507,21 +458,19 @@ static int wave5_vpu_enc_try_fmt_out(struct file *file, void *fh, struct v4l2_fo
 
 	vpu_fmt = wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, enc_fmt_list[VPU_FMT_TYPE_RAW]);
 	if (!vpu_fmt) {
+		width = inst->src_fmt.width;
+		height = inst->src_fmt.height;
 		f->fmt.pix_mp.pixelformat = inst->src_fmt.pixelformat;
-		f->fmt.pix_mp.num_planes = inst->src_fmt.num_planes;
-		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_fmt.height);
 	} else {
-		int width = clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt->max_width);
-		int height = clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_fmt->max_height);
-		const struct v4l2_format_info *info = v4l2_format_info(vpu_fmt->v4l2_pix_fmt);
-
+		width = f->fmt.pix_mp.width;
+		height = f->fmt.pix_mp.height;
 		f->fmt.pix_mp.pixelformat = vpu_fmt->v4l2_pix_fmt;
-		f->fmt.pix_mp.num_planes = info->mem_planes;
-		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
 	}
 
-	f->fmt.pix_mp.flags = 0;
-	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	wave5_update_pix_fmt(&f->fmt.pix_mp, VPU_FMT_TYPE_RAW,
+					     width,
+					     height,
+					     vpu_fmt->v4l2_frmsize);
 
 	return 0;
 }
@@ -529,6 +478,7 @@ static int wave5_vpu_enc_try_fmt_out(struct file *file, void *fh, struct v4l2_fo
 static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_format *f)
 {
 	struct vpu_instance *inst = wave5_to_vpu_inst(fh);
+	const struct vpu_format *vpu_fmt;
 	int i, ret;
 
 	dev_dbg(inst->dev->dev, "%s: fourcc: %u width: %u height: %u num_planes: %u field: %u\n",
@@ -568,7 +518,16 @@ static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct v4l2_form
 	inst->quantization = f->fmt.pix_mp.quantization;
 	inst->xfer_func = f->fmt.pix_mp.xfer_func;
 
-	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_mp.height);
+	vpu_fmt = wave5_find_vpu_fmt(inst->dst_fmt.pixelformat, enc_fmt_list[VPU_FMT_TYPE_CODEC]);
+	if (!vpu_fmt)
+		return -EINVAL;
+
+	wave5_update_pix_fmt(&inst->dst_fmt, VPU_FMT_TYPE_CODEC,
+					     f->fmt.pix_mp.width,
+					     f->fmt.pix_mp.height,
+					     vpu_fmt->v4l2_frmsize);
+	inst->conf_win.width = inst->dst_fmt.width;
+	inst->conf_win.height = inst->dst_fmt.height;
 
 	return 0;
 }
@@ -584,12 +543,17 @@ static int wave5_vpu_enc_g_selection(struct file *file, void *fh, struct v4l2_se
 	switch (s->target) {
 	case V4L2_SEL_TGT_CROP_DEFAULT:
 	case V4L2_SEL_TGT_CROP_BOUNDS:
-	case V4L2_SEL_TGT_CROP:
 		s->r.left = 0;
 		s->r.top = 0;
 		s->r.width = inst->dst_fmt.width;
 		s->r.height = inst->dst_fmt.height;
 		break;
+	case V4L2_SEL_TGT_CROP:
+		s->r.left = 0;
+		s->r.top = 0;
+		s->r.width = inst->conf_win.width;
+		s->r.height = inst->conf_win.height;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -612,8 +576,10 @@ static int wave5_vpu_enc_s_selection(struct file *file, void *fh, struct v4l2_se
 
 	s->r.left = 0;
 	s->r.top = 0;
-	s->r.width = inst->src_fmt.width;
-	s->r.height = inst->src_fmt.height;
+	s->r.width = min(s->r.width, inst->dst_fmt.width);
+	s->r.height = min(s->r.height, inst->dst_fmt.height);
+
+	inst->conf_win = s->r;
 
 	return 0;
 }
@@ -1151,8 +1117,8 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 	open_param->wave_param.lambda_scaling_enable = 1;
 
 	open_param->line_buf_int_en = true;
-	open_param->pic_width = inst->dst_fmt.width;
-	open_param->pic_height = inst->dst_fmt.height;
+	open_param->pic_width = inst->conf_win.width;
+	open_param->pic_height = inst->conf_win.height;
 	open_param->frame_rate_info = inst->frame_rate;
 	open_param->rc_enable = inst->rc_enable;
 	if (inst->rc_enable) {
@@ -1456,20 +1422,17 @@ static const struct vb2_ops wave5_vpu_enc_vb2_ops = {
 static void wave5_set_default_format(struct v4l2_pix_format_mplane *src_fmt,
 				     struct v4l2_pix_format_mplane *dst_fmt)
 {
-	unsigned int src_pix_fmt = enc_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt;
-	const struct v4l2_format_info *src_fmt_info = v4l2_format_info(src_pix_fmt);
-
-	src_fmt->pixelformat = src_pix_fmt;
-	src_fmt->field = V4L2_FIELD_NONE;
-	src_fmt->flags = 0;
-	src_fmt->num_planes = src_fmt_info->mem_planes;
-	wave5_update_pix_fmt(src_fmt, 416, 240);
+	src_fmt->pixelformat = enc_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_pix_fmt;
+	wave5_update_pix_fmt(src_fmt, VPU_FMT_TYPE_RAW,
+				      W5_DEF_ENC_PIC_WIDTH,
+				      W5_DEF_ENC_PIC_HEIGHT,
+				      &enc_frmsize[VPU_FMT_TYPE_RAW]);
 
 	dst_fmt->pixelformat = enc_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix_fmt;
-	dst_fmt->field = V4L2_FIELD_NONE;
-	dst_fmt->flags = 0;
-	dst_fmt->num_planes = 1;
-	wave5_update_pix_fmt(dst_fmt, 416, 240);
+	wave5_update_pix_fmt(dst_fmt, VPU_FMT_TYPE_CODEC,
+				      W5_DEF_ENC_PIC_WIDTH,
+				      W5_DEF_ENC_PIC_HEIGHT,
+				      &enc_frmsize[VPU_FMT_TYPE_CODEC]);
 }
 
 static int wave5_vpu_enc_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
@@ -1733,6 +1696,8 @@ static int wave5_vpu_open_enc(struct file *filp)
 	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
 
 	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
+	inst->conf_win.width = inst->dst_fmt.width;
+	inst->conf_win.height = inst->dst_fmt.height;
 	inst->colorspace = V4L2_COLORSPACE_REC709;
 	inst->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	inst->quantization = V4L2_QUANTIZATION_DEFAULT;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.h b/drivers/media/platform/chips-media/wave5/wave5-vpu.h
index 32b7fd3730b5..3847332551fc 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.h
@@ -38,10 +38,7 @@ enum vpu_fmt_type {
 
 struct vpu_format {
 	unsigned int v4l2_pix_fmt;
-	unsigned int max_width;
-	unsigned int min_width;
-	unsigned int max_height;
-	unsigned int min_height;
+	const struct v4l2_frmsize_stepwise *v4l2_frmsize;
 };
 
 static inline struct vpu_instance *wave5_to_vpu_inst(struct v4l2_fh *vfh)
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
index d9751eedb0f9..8e11d93ca38f 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
@@ -30,10 +30,29 @@
 
 #define MAX_NUM_INSTANCE                32
 
-#define W5_MIN_ENC_PIC_WIDTH            256
-#define W5_MIN_ENC_PIC_HEIGHT           128
-#define W5_MAX_ENC_PIC_WIDTH            8192
-#define W5_MAX_ENC_PIC_HEIGHT           8192
+#define W5_DEF_DEC_PIC_WIDTH            720U
+#define W5_DEF_DEC_PIC_HEIGHT           480U
+#define W5_MIN_DEC_PIC_8_WIDTH          8U
+#define W5_MIN_DEC_PIC_8_HEIGHT         8U
+#define W5_MIN_DEC_PIC_32_WIDTH         32U
+#define W5_MIN_DEC_PIC_32_HEIGHT        32U
+#define W5_MAX_DEC_PIC_WIDTH            8192U
+#define W5_MAX_DEC_PIC_HEIGHT           4320U
+#define W5_DEC_CODEC_STEP_WIDTH         1U
+#define W5_DEC_CODEC_STEP_HEIGHT        1U
+#define W5_DEC_RAW_STEP_WIDTH           32U
+#define W5_DEC_RAW_STEP_HEIGHT          16U
+
+#define W5_DEF_ENC_PIC_WIDTH            416U
+#define W5_DEF_ENC_PIC_HEIGHT           240U
+#define W5_MIN_ENC_PIC_WIDTH            256U
+#define W5_MIN_ENC_PIC_HEIGHT           128U
+#define W5_MAX_ENC_PIC_WIDTH            8192U
+#define W5_MAX_ENC_PIC_HEIGHT           8192U
+#define W5_ENC_CODEC_STEP_WIDTH         8U
+#define W5_ENC_CODEC_STEP_HEIGHT        8U
+#define W5_ENC_RAW_STEP_WIDTH           32U
+#define W5_ENC_RAW_STEP_HEIGHT          16U
 
 //  application specific configuration
 #define VPU_ENC_TIMEOUT                 60000
-- 
2.43.0


