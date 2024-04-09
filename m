Return-Path: <linux-kernel+bounces-136694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64789D72D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28811C223C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896686278;
	Tue,  9 Apr 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="BAs60okR"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2110.outbound.protection.outlook.com [40.107.241.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BE8564D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659263; cv=fail; b=HZRCXaFTO4PUwKjDNPi+mpV8aJU6GPNZTSAFO7iLOlrGlmWwEoHqN7G18utx8kRUtM4Mj6yqeUT17nwAvuveb7zrjv/VZWLJ6LRJKbaoKW6Px9qqmH65SV6vJqyXIjYARhKxqKlhTgaXnefw4P2LFmO7cV714wVW/AKYq+qaLtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659263; c=relaxed/simple;
	bh=bdIWmQucm8z4VwgndE/yc9OVYLz1IUf332wwrfsmXR0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bNx2U2Ra0NRPSjLNSA+w6L6iuzGQ9w3zISojuB1ULoB4sQlAhij+R7njloajuSQ1ehXWoBMQtVZLDqc5DbIJEgXKadLj9l7nKEKh7zI+gcWLJYPwQ0DFtN8tIB69h++HM6GWzVdv9aRCPZoq6RInMzZoWRYnoKQP/FHQ30bxeOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=BAs60okR; arc=fail smtp.client-ip=40.107.241.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEkq0Z5+HY8Aig+aqZCRjUE5ywYJISksaPGxIGM6oLo67OdaIOrHiYig8oiQCIJyk4OcZ1JaMudqFROnOhDlh8sh7ju9V+r06YNa8RCEeiNjX1zYrqqia29lPzACIvlNFwulqxAmwTd3jllFd+ON43BvevpgSitWcxSZqxT2WCdhUwEpCzWtH4uqpjc6JqUTEOuWilhtjev9QZI2f3+siQWksWNqt9NkZKTgvTpUz76WSRJ8jKUr6qDm15I3gPt30ceujRjSYOPmEP4bZOiTjXfuIa2ZkDgeHcWjOa+kXocdplMkwVmFQ8iy21hyPCOhGkmxJzvMY0aW9m9jQL230g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxAKihY49H3Kks6+DXRKr+2SGOCPjqQwuEUbKZZuLAw=;
 b=UB+iVE+11AL8FY2ScDHIMMV613CGdHftyNakHmmDMWrzsIfW8qamXRrkZsRMVMBeSHSQgZMEO77U8X6WJGdC7kSNZJK+9Xq7bu823HDTyRkHfjEg/qB2eUU0LQHlKLBKM+/EcsijO5PSpD9mctErwgb2d96ZovAzxeV1ziY3udZm7xAWKj43ETgEs0KSBa4G9ikZINs2l415/mHRXq3/aJVF0igQcbqiL4gHI36TgqUVJ+HYKCsKC6xCZdfekFMyH1vqytkypkfSgc7DWEBXO6COkItiGhGShGjtniKVrmg/TE6UN0avXSkNUWe+VjIlH6deKzjJPYoudUgYwl54gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxAKihY49H3Kks6+DXRKr+2SGOCPjqQwuEUbKZZuLAw=;
 b=BAs60okRYkp45+fw31evAtTckGFQ2xB8fAB4U9p8koOXedtH/xGpOLOPSLWEvlW+/lvDLV+QSS3TclvkD0u5p0KzLr2VCUjMSou+hMSQEeEaT5uVt339Qqn9z+15GEDIP7iSy7sWBuyWfgoy0waxwuQjNbWHSQ337of0B2N/YEI=
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS4PR08MB7506.eurprd08.prod.outlook.com (2603:10a6:20b:4f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 10:40:56 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::b205:5d9c:7c5e:21f5]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::b205:5d9c:7c5e:21f5%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 10:40:55 +0000
From: Gerald Loacker <gerald.loacker@wolfvision.net>
Date: Tue, 09 Apr 2024 12:40:41 +0200
Subject: [PATCH 3/3] drm/panel: sitronix-st7789v: fix display size for
 jt240mhqs_hwt_ek_e3 panel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v1-3-f9ccf6e7a881@wolfvision.net>
References: <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v1-0-f9ccf6e7a881@wolfvision.net>
In-Reply-To: <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v1-0-f9ccf6e7a881@wolfvision.net>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Gerald Loacker <gerald.loacker@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712659250; l=842;
 i=gerald.loacker@wolfvision.net; s=20230502; h=from:subject:message-id;
 bh=bdIWmQucm8z4VwgndE/yc9OVYLz1IUf332wwrfsmXR0=;
 b=yVcx3dfcg0oxf3J2yeFuqHMf+zmh203EiGKdHptGql8tdqT3qAEnc3eCGHJUbXmERPe7QwBGc
 Yc4O8nCNH9aCgZAOo/5ZTZ0+XW0bZVh+z2MHE5Oxtd9IJnfQ2vZo5sE
X-Developer-Key: i=gerald.loacker@wolfvision.net; a=ed25519;
 pk=UXhp+obGMUOjknszonesnb29P6a2Kk/K5eBuz62ggVE=
X-ClientProxiedBy: VE1PR03CA0002.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::14) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS4PR08MB7506:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jj8YetDuO1gFYDYBZwfl6cceFJkuHNf0yc3opsPomXCzYTmwbBT3txVdHY8oitCy+PFlcLX1TZWYu2ROdT99UBwd+2BCblESy//AYAPD1uufTIPtlx9bqMd91myP993zYvghdRlIF4XNnV40fjeVlVSbhbyVaqDq6o9V/1SxfxOqFl8Sl1VXuvUZhcvlld+7AMF6ySCn/95zqxiTKBhaaC6xdEmvmktYFAHNKCF7TioT6VwwwcMi+3qAI8v5gn4ALaFEGxNWxE9Xd1k8cXJGFgNOQXX9megdsMsuoKGZSrRNmTCOto64iuBVFO8geev3s3ldRABDgcLsPN71xnIKfvUDfHP9bCzVqy8G/fwNyzvphSDfZuuvX4K/Bew+Ms6cn0fCv67Do35iGOuQr45ID++9dVpolNjwrfUc5Vl3y4K/cFuquhs0wlm/dAm0sanQqPvM535wRyYm0FoOOfz2cKr1/PFJEjiIPDiV08KBcjko5zNDcB70qj1AnaqUSDKSzW3r7Goc6OUwt6HC4NGzhs/7jawq9/XS8hZ846GBprU+NT0KmCHzYugNYICY2+6scQBDnf2KPkreejGOcx8lQvJbWuB+JWLwKjvYccRx3q1v3ArYv3SbmP/vlG289yVhVmqRdWbfaZ0Gtns3THLZXWWN9zKIFL6a6/0WfayxHzvJH7W6hTl3RyYQQ4fQo+dOuX0Vb19XzXzIliZBJ2L0toxk3JIAJKB6zzD9gElDZjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDRPRWNRRXNuRE1hZ3pzTVp3cW84cE1uZ050NEhMcUJkcHlSVVhQWE9KdDNT?=
 =?utf-8?B?NmhiLzJTUjYrYjh6VnBhS0Jlbi9YRjMzZE4wTjREbnFOdTErWFMxTHJqR0xN?=
 =?utf-8?B?K1AyQXowNHpHMkVPektKUUVnVkZZbS93N0k4VTl3cUZCWTNrWkR3NDBKQzlH?=
 =?utf-8?B?ZEtTSXd5OHBwS1NoU1hNNDk5Tmp6c28wL1dTeGs3MUY0VHo4ZzB0RjU5bmJ1?=
 =?utf-8?B?a1V3cHJLLzVvS3pHN3doaGZSUkhWcEtPeGtXRC92OURneit0anQ5ZlBJdnBm?=
 =?utf-8?B?b1Y4UC9VUXF3QStpTVhqNnNqUWhXZkpoRlBLaytyT216bXZQYVcycUNvbWpl?=
 =?utf-8?B?WnM3cVozNVBVRVBEYTdTUVBoSE94Zmhib1F5b0hPN29zR09lRzliT3ZMdDZz?=
 =?utf-8?B?SGtzc3VUMkd5aTJsMFJ4VVBpSEh1WTk5Mk5wTmhhRCswajVVOHp6c3VSdjE4?=
 =?utf-8?B?bWV0QXlOd3MxVDlqY3FGb0drbkZmMGVRREloZ1hQZDJRcHoyb2dQMHlqUmFG?=
 =?utf-8?B?ZVkwdnpISTFjakYxbkpsdFpvZE5vN1ZwUkpsaDV4S3BZaUJPY0ZkdmNYSnpY?=
 =?utf-8?B?MG93bU1vNmNUVUhna0w1L1R2WkxNYUxVOHRXanhaekpwcS9MNVA2YmtvVWQy?=
 =?utf-8?B?NFVxbFMzb0UrZWhxaHdxbDNON1dmcEt6cklJRHhIUGlTMEEwYWV5TW94MVRx?=
 =?utf-8?B?Y2p5eGYxS3dlcWJ5K2hoUjl0MmRiTEllSy9xSjVPS2t5NjZNQTh5ZmJQTldx?=
 =?utf-8?B?ZEc5OGg5aWEwZWp6L3N2WXFGMlkyTWNUZEhLWGdQZWtlVFVEdHZHTitTdWM5?=
 =?utf-8?B?bTBsRGRabUkrTWN0WHI2VDNXN1NOUnduc1FtU2x2ZFBVL2dveWIwaFBRQnBU?=
 =?utf-8?B?WGdJTDQ1UEZSVDVhdmhQYnMvbTNaUkJGd2lwakdZelMwZ1JVR1VOVEpwb0k4?=
 =?utf-8?B?ZXVTcTJicEdkekRXblRsZENmd2xLQm1BdXlOYkx6RFdVczJCYU5iT2ZBcjdi?=
 =?utf-8?B?VUJRQVJJeEs1RUgrOWkyK0VPdWxScEtweEE5cmgxTjZ3K05ZM05YSFJrbCtX?=
 =?utf-8?B?MEhyUktHWjdnekMxdFNFTDBPc09ib25YZkNhb0NBVnd2MWorQmFGSzh3aDVy?=
 =?utf-8?B?djlvbWZaMDBJYW5ySTBPaTZYZUJ6a1c0dHRhNHhjOXZyRmdZZ1ZBSU5SL0dU?=
 =?utf-8?B?TmYyalZHMkNaT0FMT3FWMFRCbm5jMkh3eDhOWVg1YVIyZ1FjTlY4TVdtREJH?=
 =?utf-8?B?YWNjL2x4VVJaUmJVZlZVMm9LeDJ5RHVMS0RqRUhkQTJWTmw3ZzF1ckFtSUFk?=
 =?utf-8?B?RXlrT29OcHJZYk1rbmZNVC9pT1lIUkRWcmRnTEl1aGthdUdSM1hYM29DQ3N0?=
 =?utf-8?B?QXJmVTB2TFVQV3JXT0wwK2l5NDZzbWk5cDJhMEFLUmxFRjk4Y0Z1d1ViT3cr?=
 =?utf-8?B?c2M3a0QvdlRxcnNYc3RpNkZJVmlxRVozM1lPRDJNRFJNMXhRWWpkOHdmOGdp?=
 =?utf-8?B?TFpxVHQzOGJOU3Y4SE5lOU43MjlFWnl3c1lYNjF6T2h5ZGh6TmY0eWdQNUpK?=
 =?utf-8?B?ampsbUlROHJZaVhSZVNwRDlhUDJQYzdSYlJXYlpndFZSMGtlTmtFMnZBK3lF?=
 =?utf-8?B?MHhLMUdQQjFlV2V5OU5nanRHMktYT1pmZzZURHVNTlZKUUFaOVRTYkpTSGN1?=
 =?utf-8?B?STBpckUydnMrY1M0WFNjV2F3c0dGYkxJRHl3RkhXdXM5MG9RQ1lKSXp0cElG?=
 =?utf-8?B?UDhHQVVENHNybnFPd1lXejlSWDdMQ1hNc2lWcXlOYkZva0YzSlZBYk1BYnNY?=
 =?utf-8?B?UENCRHhWMTBBQUdWNUJuaEtLVzNPa2Jad1dRMGpCSEN3VllaN1JWMng5M3Qz?=
 =?utf-8?B?NXd5eDZBc3Y0V1Z4ODVxd1FGVGNHMnd1RkVkMHRYaDlyamZOdmw0ajU0WHZO?=
 =?utf-8?B?QkRmdThXYzZXcDcxcHNzc1lldTBYQVIwbkhlbnNiS0Y2RnI0bnFzT0tmUzZU?=
 =?utf-8?B?d0JTM0tDcGlySE11Z1cwTEoxUVljeDdIM1MwMWpya1FCa0lqeGtPSjd3aW5U?=
 =?utf-8?B?YkhxVmJZTGVtK1RvUjRSM2xEOWZrYkNybHBaNW53Skthc3I1QVdta3FoQytn?=
 =?utf-8?B?dXJYbkVJVGNqekRrRHZoMjBMRS9zNS9aME9uNXVKS2c3bzM3bXlMeElQRDQw?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1f7585-db4f-4558-736f-08dc58818714
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 10:40:52.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gSJIrZVHNyZC9CFbwu92k8pRaa806iDr27YP6oobr4HReq+brXWHUxo3ZYdJEUCWD7Tqg3mh3ruZOtnwZiNvzWBAX9LwSF754XGyY0QEVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7506

This is a portrait mode display. Change the dimensions accordingly.

Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index c7e3f1280404..e8f385b9c618 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -289,8 +289,8 @@ static const struct drm_display_mode jt240mhqs_hwt_ek_e3_mode = {
 	.vsync_start = 280 + 48,
 	.vsync_end = 280 + 48 + 4,
 	.vtotal = 280 + 48 + 4 + 4,
-	.width_mm = 43,
-	.height_mm = 37,
+	.width_mm = 37,
+	.height_mm = 43,
 	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
 };
 

-- 
2.37.2


