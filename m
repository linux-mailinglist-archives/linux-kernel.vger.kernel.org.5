Return-Path: <linux-kernel+bounces-72718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D2A85B7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3D71F2987F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9192664BD;
	Tue, 20 Feb 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="lOQdyYKz"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552865BBD;
	Tue, 20 Feb 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422021; cv=fail; b=dcqzSNboZ7U3Rw5TN5W6+7faIu5srbrF9N2RsMfjs17jNX5pmsU95QSs7lk6StVgf9TqR3aGJLnKX+hcUcluyUVBlLLyt1e1+c8SmOHXu1/6Ui8BnUQgpbI1oezeIDK0rISS5Mn1WiZpQq8wnmgwfZiOgU9Ye6/hrwtwGal1BSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422021; c=relaxed/simple;
	bh=yxvnetxzaHXZbGOMHByLMYoilZ4RD8drlFJrk+JeioI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SA90AP1n1MsbEdu7tiNXuCfFdBvcvz1vHl8m0kFmsrZOqtK2Je/DCgq3fQXl4eczlZSbF+Ahq+qDzC7Sf2V9ujERS8AEeJQwZJ0kucuH/2ywN33ZxVVER01CvhKNev3nJgLWo+HzGOzLCa0qZoGSziryLAnfuDuxCtdJcd2O8Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=lOQdyYKz; arc=fail smtp.client-ip=40.107.21.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Df5jUfft/nsyS6bXWy8D21yO5Y4BP/DKqi47Da0S0hgcogm8OzOQeE5wLF3nkr1EtuaqxxGeHbogbqHJfOXvvxUg/qh5U0jhDR/SCXiYfjwRL+AIfx9Q+4R+YNCtbolXGWY09mM/+JGgUGaIbl7490Jq8yxrd7qMQ4+CEzZsJfAbstliL6oYM5zQKg4BKDPVEijw9MQBXRKZxMHLvpSNM2AmGhLGS9SCYupgW/EyYIi9+N1jR4inkpJkbk00ASwWiKXVE6iCABzGlRhgOVDA4QveQxvL5j/s/xNRmVRP7sdP8DMfonpA9wG4SgQR10MkvEBKSk+mZtNnnGzOPPZKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkTvgcGVFEdoJI5SU3mp1RMsMu+o0r2GkRiBHATwNfw=;
 b=DSPocW5VIBv/GsWA4h005VWtbyC9f+nSiCJd2F86TgnGSdgAwhIDMNjGJLOAG7ViR+KDSewENX7jAq8zVSje4L2sizu4Eoki07gGUdgi5PRFmmlmyaBvn93Zd4fA8VJC7P91znT9BC+4TXkmPNT6KRvbg59tQFnnP9yf96vX4I2I62RsVurxbgI4cnPk/8OgBs1/ldvLc+3jPOcgOo1UBBHElbe3SnNZ+2kLNVo0lEonDmKW5Bqi+9uloZEfGnxHLQJ8O7VbHXvLT17x55tKTLXctH5f6D5YhgQ2r2WBnQjXYZZBFlLj8KNX/HkoXOXnaMT7EoKCuj1n96NS66uUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkTvgcGVFEdoJI5SU3mp1RMsMu+o0r2GkRiBHATwNfw=;
 b=lOQdyYKz9gHGgblkYFhC5+70RhaxgEQxnx401skJXAQVmJnHqHTp4VtfrB56+BICqyp+/vyGzaikZMxPPHnRng6dHo2nZ0SDBo2+RhOIbH/56kAP+hQ0Gq5bIo6ji5i5G2azXE8uBwgq0Mq6guL2ynNwMR0TTCn+mD4rhqhwm6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB6763.eurprd08.prod.outlook.com (2603:10a6:10:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:40:16 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4%6]) with mapi id 15.20.7270.043; Tue, 20 Feb 2024
 09:40:16 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Tue, 20 Feb 2024 10:39:20 +0100
Subject: [PATCH 10/14] media: rockchip: cif: add variant specific input
 format list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-v6-8-topic-rk3568-vicap-v1-10-2680a1fa640b@wolfvision.net>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
To: Mehdi Djait <mehdi.djait.k@gmail.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708421995; l=12621;
 i=michael.riesch@wolfvision.net; s=20230803; h=from:subject:message-id;
 bh=yxvnetxzaHXZbGOMHByLMYoilZ4RD8drlFJrk+JeioI=;
 b=V/vHX+ML5xC6knGUSZYfu5ybfpeU+hRjnXyhiGjxSe1OzdSYsQESQnCR/cyS2xv2X1AW+jY28
 GnwEImC6e0cDmWIzqpV15BA2IvHkAh6bOMk7b70ee1fv++3lWRfyJZY
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=9ral3sulLe95bLcbaiNXTgUTRiBayRBEFZ5OVIEHp+0=
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f4bfb8-8fe4-4233-1c0f-08dc31f7f1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tm5u1P1hTgdL+5T/yyzwR1k2Gu0IydJ9pcF/ea0uiDgWQAaT0R/cwxNseCEwHCa1DeRieYHAtGMSY0QV/eM3pd9jcOYj94qtB+zmXu59DP5ongOcqzEi3s5T656nfRu9wBPTIwIMPJeLnFWg2TIzr429vnrd3HMYbi6oDa53DouuRMQX+tRHTI2Z96Nwphhaa5SJ7RfMEEB5OI7XbUHW1ND1p9GAofbocnh8goJ1nrkh2jIAYs+9BWfAUpAGeWmHDQqBwEiRu+/PD15wpO7AWtZLMmVTwvYJlzhwbEpIM7ijB+zy0UBI5eWcfqUm0Ja/3pbgffCCKzDVVteLxdRM/FVoCx2y2llf+V45wXStslQMTMkU9pcUZcnUkD/649oUeFnwJQVuEdjwt6dHtZ/zMkcXL9we01B0HzPcxXpl7fuSe6Xyg5UbhM0ej8kubavHV5MEOo95Tev+p3QJIYtG/XbKg26rCsv+CZscZWGSgkdtHXGBI1k5nLxsp/j7Ft86MffrN+3nimAS/2OPvlyKaVaha2vU93oJwiz+ONS7yOMnY7l49RwH+aphtMYEEsdA5PYtaOztBhAI1SgM1pZO3y6PQmPL/KyBTooD9cLp2d8NIVU5iFXG934oCuEe3hqrA0ctDH0w0XdaLeyCd+dkbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmhFTGFDNnREYUUvZVZJMTQ1R2UxRjU0djhKWG9LZkFyTnI1bXdCSXp5RkJ1?=
 =?utf-8?B?MjAyRWVOOU85S2o0MzhBUlNMOUpsV1RMVkFENXpkZnh6VXJhenlzVjE1Z1Mv?=
 =?utf-8?B?WWZrYXBXbmFWMmQvVlgvc1lON1lEdVBCK2tYcGpLOWFYZ0UwTWJERlVVUEZ2?=
 =?utf-8?B?VUdvbWFFZ2xuNnl6RWdrVDBmZ3ROME8yVEQxMGk1azEreWZ0Z2JpbkhuTmpI?=
 =?utf-8?B?NDFUMFlsVFlJZHk1TDZQK1JUa3J3WFlNaDk5V2trbk41WVhXdUZZQWp1cXRV?=
 =?utf-8?B?ejlaTUFOWVZwSGlQeHpUL3FOQUtOckMzSmU5UkQrd3ZlTVgxenN0U25hV2VV?=
 =?utf-8?B?NXRuQ2IrdFBGbTdYVFJIRHdwOEFBSjdFcnJLRS8vYnhDZUFpdGNwQ0dSYUJo?=
 =?utf-8?B?THpyTmR3eXo1UE5kRkliQ2RDeHk5ZExHcDl3NDA2cnhaSE42ZDRRTlZkWVhB?=
 =?utf-8?B?dURhM0hUT01seXlwV0pxMnpOTDRFelRSWE1LVHgwaW5YdjNYNmp5VEU4aWhO?=
 =?utf-8?B?cXo3ZEw3S0R6bzZKU05sZjd0MUk0NUJuUWFxZkZLd240am9Ddkl4N1lRU3Ex?=
 =?utf-8?B?ZklOeDlwcHRQSlhhbnZoMXpMbllmM0pQa3ZGdngwZHlqWlZVaUx4WnVGZFVL?=
 =?utf-8?B?RDVTQmFkbjJlUFZtQUFMS3BNUHRySFhCZG9VQmpmR1VDQnRLSEJvRlNXK1Rv?=
 =?utf-8?B?SlFwQWNlQzFtdXlVWXdoM09zdmswUVZGSjNBRzhoNWRaMVIyd1FEd1lXSk8y?=
 =?utf-8?B?QjcyQTRjeTY4SnpCVldGMWhFRWpVTVZkNEJwL0RvZWs4aFA5RDdiUUZoZCtz?=
 =?utf-8?B?NzNRYUZZa29aMWdFRkNhMGR6V3piZGZuK0sveFA2RG1WNGI3bnJ2dkladHF2?=
 =?utf-8?B?MjZvRTkva0ZJTGNKelZxdXJEY2IwVkR6MU5WTnZBbXFRNkpHOWtUUFJVaElK?=
 =?utf-8?B?eXlPVERMWWxVOFE4Z2tCaWRGWlg4WHQ4K3hGN0VGQVlhTmV1UXJOSkk2SVN5?=
 =?utf-8?B?eENFQ2ZBYk0zZ2ZoeWpFb3F2U1NjeGNVSG12UGtNbW5rLzFOVTgrNS9kcU9i?=
 =?utf-8?B?ZDlxd3JRRnYrWjBjUVg4U3pvRnlwY3FScFFMSXFuZEVOR1RqMkpzS2hjeW10?=
 =?utf-8?B?cWRmUk5BNjdKUHQrWnNHOXFCMU9QMm1GRWZxc0hocGdYM294VThqY0NCVnNl?=
 =?utf-8?B?OFMxS2ZzTVppbFE2Z3ZiWGExMHhpdVY5Rk5rZHVMQXFuNStKMmFQZHYwQ1p6?=
 =?utf-8?B?MU4yNGR2V053NmdGbllZWm85UGdFTjFpUXdzRktMRXdNSEU2UVNNb0ZCWEVU?=
 =?utf-8?B?Y3dhUUZ0K2t6bU9oWDdVQWFDOUQ4enJ1dEZGUVpBY0NiRS91SEhiaXBUbUJ0?=
 =?utf-8?B?Rkswc2dSZkM3ZUZuSmNYRkJ1MUVJbHZ6L1VsSjhFYWhZRUY0OVltNFE2MllL?=
 =?utf-8?B?Wnc1Q3U1UjB3eEJzRWpkVEJZN3gveEZzUkdQaWFoQVYrNUEwZ1NmcmtSS1lP?=
 =?utf-8?B?c1FleE8wSWdrNEp1RkxlbHc4SW9nNGxlUEJlSU9YZmdXZVd3cUtGN3BrN2VX?=
 =?utf-8?B?RXM4RjdQK3BWWE4vdisvV1BIeVg3MHBuZ040bWZ1alJaYWwxSUt0TTFYanBG?=
 =?utf-8?B?MEdTOVV0Z2RURDFwbEFWKzkvSGJaN2h2cUNJSDc4S21Ob3I1dWpjNDk3RU5R?=
 =?utf-8?B?WXFjdFNVelNBZjhrcGE3aTMwcGgrUVJ2d0NJS05DSTFubjFEUXpaajVxRG5F?=
 =?utf-8?B?RjZDUWRlT1Y5eitLVmtxSU1UY2dtMHFZTHZER2RyZVZveUlFd2gvZWYyYW9Z?=
 =?utf-8?B?ankwc2l3NFZFeC9BZHFCUHYyQlp4d1RiZnZITnhvc3FrUENkQWJRUWJvUE5W?=
 =?utf-8?B?TmdXRU1MQVJ1bE0zdnVEUDFBcW5RaTJ3YUdSaVVoZXVaZ3MrWERhcW9yMFJZ?=
 =?utf-8?B?UzZRRmxvUjZjWE1TNjlaUFI4eDZydVl1bUZYRWt6cHFZQ3QwdHBiYVBkS2ts?=
 =?utf-8?B?YUF2SDBjaUhEZCtZaXZVZ1dLNW9rbEJZVittR1N1QkpMbmdHZVF4K3RmQ0dI?=
 =?utf-8?B?R0ZGVVNiOWwvam1rd1JNT3pQRUxHSEJMSzkxQmh3d01jd3RJWmY5MEdpZ1FD?=
 =?utf-8?B?Z0xIb1FaQUxlVm1QTjR0OWE3UTZxa2Z5S3pLamNTbStRSlRlZmhyczJvc2l6?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f4bfb8-8fe4-4233-1c0f-08dc31f7f1c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:40:16.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+3Yl6jmqvCquXdM2jvf7aWsDaFvT626mT58mi9UlkqkNPJV58I3w0RN1kEZczx6jHfCLTc4VSKdmursbD+/fgSdUhQIDjNJfNtFFfg/Njw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6763

The different variants of the Rockchip CIF may feature different input
formats. Add a variant specific input format list to account for this.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 drivers/media/platform/rockchip/cif/cif-capture.c | 154 +---------------------
 drivers/media/platform/rockchip/cif/cif-common.h  |   2 +
 drivers/media/platform/rockchip/cif/cif-dev.c     | 147 +++++++++++++++++++++
 3 files changed, 154 insertions(+), 149 deletions(-)

diff --git a/drivers/media/platform/rockchip/cif/cif-capture.c b/drivers/media/platform/rockchip/cif/cif-capture.c
index c80a52028a21..b26e6023c2b0 100644
--- a/drivers/media/platform/rockchip/cif/cif-capture.c
+++ b/drivers/media/platform/rockchip/cif/cif-capture.c
@@ -109,154 +109,10 @@ static struct cif_output_fmt out_fmts[] = {
 	}
 };
 
-static const struct cif_input_fmt in_fmts[] = {
-	{
-		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
-		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
-				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
-		.fmt_type	= CIF_FMT_TYPE_YUV,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
-		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
-				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
-		.fmt_type	= CIF_FMT_TYPE_YUV,
-		.field		= V4L2_FIELD_INTERLACED,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
-		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
-				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
-		.fmt_type	= CIF_FMT_TYPE_YUV,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
-		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
-				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
-		.fmt_type	= CIF_FMT_TYPE_YUV,
-		.field		= V4L2_FIELD_INTERLACED,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
-		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
-				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
-		.fmt_type	= CIF_FMT_TYPE_YUV,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
-		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
-				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
-		.fmt_type	= CIF_FMT_TYPE_YUV,
-		.field		= V4L2_FIELD_INTERLACED,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
-		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
-				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
-		.fmt_type	= CIF_FMT_TYPE_YUV,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
-		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
-				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
-		.fmt_type	= CIF_FMT_TYPE_YUV,
-		.field		= V4L2_FIELD_INTERLACED,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_8,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_8,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_8,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_8,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_10,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_10,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_10,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_10,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_12,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_12,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_12,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_12,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_RGB888_1X24,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_Y8_1X8,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_8,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_10,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}, {
-		.mbus_code	= MEDIA_BUS_FMT_Y12_1X12,
-		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
-				  CIF_FORMAT_RAW_DATA_WIDTH_12,
-		.fmt_type	= CIF_FMT_TYPE_RAW,
-		.field		= V4L2_FIELD_NONE,
-	}
-};
-
-static const struct
-cif_input_fmt *get_input_fmt(struct v4l2_subdev *sd)
+static const struct cif_input_fmt *get_input_fmt(struct cif_device *cif_dev,
+						 struct v4l2_subdev *sd)
 {
+	const struct cif_input_fmt *in_fmts = cif_dev->match_data->in_fmts;
 	struct v4l2_subdev_format fmt;
 	u32 i;
 
@@ -264,7 +120,7 @@ cif_input_fmt *get_input_fmt(struct v4l2_subdev *sd)
 	fmt.pad = 0;
 	v4l2_subdev_call(sd, pad, get_fmt, NULL, &fmt);
 
-	for (i = 0; i < ARRAY_SIZE(in_fmts); i++)
+	for (i = 0; i < cif_dev->match_data->in_fmts_num; i++)
 		if (fmt.format.code == in_fmts[i].mbus_code &&
 		    fmt.format.field == in_fmts[i].field)
 			return &in_fmts[i];
@@ -550,7 +406,7 @@ static int cif_start_streaming(struct vb2_queue *queue, unsigned int count)
 
 	sd = cif_dev->remote.sd;
 
-	stream->cif_fmt_in = get_input_fmt(cif_dev->remote.sd);
+	stream->cif_fmt_in = get_input_fmt(cif_dev, sd);
 	if (!stream->cif_fmt_in)
 		goto runtime_put;
 
diff --git a/drivers/media/platform/rockchip/cif/cif-common.h b/drivers/media/platform/rockchip/cif/cif-common.h
index ae8fedeadd1c..84a7545422e1 100644
--- a/drivers/media/platform/rockchip/cif/cif-common.h
+++ b/drivers/media/platform/rockchip/cif/cif-common.h
@@ -97,6 +97,8 @@ static inline struct cif_stream *to_cif_stream(struct video_device *vdev)
 struct cif_match_data {
 	struct clk_bulk_data *clks;
 	int clks_num;
+	const struct cif_input_fmt *in_fmts;
+	int in_fmts_num;
 	void (*grf_dvp_setup)(struct cif_device *cif_dev);
 };
 
diff --git a/drivers/media/platform/rockchip/cif/cif-dev.c b/drivers/media/platform/rockchip/cif/cif-dev.c
index b75b76508793..fb80e8f8dcab 100644
--- a/drivers/media/platform/rockchip/cif/cif-dev.c
+++ b/drivers/media/platform/rockchip/cif/cif-dev.c
@@ -132,9 +132,156 @@ static struct clk_bulk_data px30_cif_clks[] = {
 	{ .id = "pclk", },
 };
 
+static const struct cif_input_fmt px30_in_fmts[] = {
+	{
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
+				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
+		.fmt_type	= CIF_FMT_TYPE_YUV,
+		.field		= V4L2_FIELD_INTERLACED,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_RGB888_1X24,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y8_1X8,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_8,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y10_1X10,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_10,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}, {
+		.mbus_code	= MEDIA_BUS_FMT_Y12_1X12,
+		.dvp_fmt_val	= CIF_FORMAT_INPUT_MODE_RAW |
+				  CIF_FORMAT_RAW_DATA_WIDTH_12,
+		.fmt_type	= CIF_FMT_TYPE_RAW,
+		.field		= V4L2_FIELD_NONE,
+	}
+};
+
 static const struct cif_match_data px30_cif_match_data = {
 	.clks = px30_cif_clks,
 	.clks_num = ARRAY_SIZE(px30_cif_clks),
+	.in_fmts = px30_in_fmts,
+	.in_fmts_num = ARRAY_SIZE(px30_in_fmts),
 };
 
 static const struct of_device_id cif_plat_of_match[] = {

-- 
2.30.2


