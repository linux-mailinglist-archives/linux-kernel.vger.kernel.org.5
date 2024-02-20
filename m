Return-Path: <linux-kernel+bounces-72717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D6085B7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0091F298EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBAA65BD7;
	Tue, 20 Feb 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Mht8sSpo"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863F657CB;
	Tue, 20 Feb 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422019; cv=fail; b=kRVal6aIvWOm2rI0Pj1P4RLgNGtvI0QegvtqPZorDAKkvo5GmSGyt3eWhGmjgYHpl/zBwmFEo4AmPvZkZX4Rj1Oq6e+isqEVVIfcM9b6G7WcsagK+pOYr43YmVafbyrbBfsavW5RvKCwtYEp+gm2Ax1aCBGC43FrHs2eNQcKKM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422019; c=relaxed/simple;
	bh=ou+V5Mg+cQK/+nx6chzqIuN6MNQRuWnEU7n6yunl2Vo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=p7TZkIdCZtPozX48cvcpXKteWqNZmKzeNXey8h5MQPoeG1bI27gfgy/djeBA+sJEF0n8pNDkVKjjCjRQKRpWm0NMmtKJIjaiBAK2Pe0xntYKIiHn7E7tegVhGgJPH5tdRYcDdZsA4E0l21ek9zOujdqKatJIPoAlQPl+P4pl5Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=Mht8sSpo; arc=fail smtp.client-ip=40.107.21.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIMBx1WolY0Mmn3zYBb35/NEROcPigAlFjtJCYkGmcsREKiZGOOU1Bv0t1VgpaenGgSyT5uue6mbbIxoF6skGzG21GLXqieoCJNWGpWIX1xOZepUINH7NZYVT7P2oJbI/M8fx+pBAF7+yclYcpxn5UvbJIX50I+Q0cyxLcvsLYQ+/fBuJndy2RjVybEmG8+aCxm3WC/r8/5qNc88QqDBp2a795FAkSgSwyJu+cYT6XbHDy2hmryXaLJUsMPCiXpZFkY+Otqk5dpdx7fPv9pqNmBMPKFcfHXCJJ3vWT4iRpNmLyONocNy1KZVCrUFh3DRPvRSTkFecdYjfEiIjfyEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYHmj6K+Yw2I1Wxuq6WyAkSBG52uQ7q3/Hw6yocyE/A=;
 b=C48DRYD4xXpUjji6HyfqRl4KvK2apkvObqz/yZZeIxVRq1BiLFV/He4GvCSzoEmpjg2KlowpeCo4eXpAqUHm+KmGV0HQaT90I771lKDB+iEnkyjV/OTOcJvd3N+91q7SIKxwpVVUObFKHkUPYfWU8HJQy2foBqy4NLIYIigSOVpJX8lInkOlBuO5ECdcM5azU6w9UafdId/qVFScLHxqx10lEJcr3XToWaFF6FfmzsssgEuyFTRbAjv5MltSOtA/EmuBWic4YHYRKqBYk0bvjMsxfmr0dLrVoBapAUQAYrbRGE4oBufPpmqnZUZaCfGnDt8WGnwuMQfa1hxqv1WnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYHmj6K+Yw2I1Wxuq6WyAkSBG52uQ7q3/Hw6yocyE/A=;
 b=Mht8sSpo+/x8xLAavFwI41IlgCbA9Fe5MABFWvwVJzeoo8oxxdOd2Hz2tQVERIiDub8XLS4vR+gGuz7lI80GEYAL0WH8gcN7UnH7n3RtfFupnsRgOts6+S8yYJvfwq/gFILB8d/Hz87wJQ5uPXXL7GYDoHrmm1c5mqsPX7yyUlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB6763.eurprd08.prod.outlook.com (2603:10a6:10:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:40:14 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4%6]) with mapi id 15.20.7270.043; Tue, 20 Feb 2024
 09:40:14 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Tue, 20 Feb 2024 10:39:19 +0100
Subject: [PATCH 09/14] media: rockchip: cif: add support for grf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-v6-8-topic-rk3568-vicap-v1-9-2680a1fa640b@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708421995; l=2405;
 i=michael.riesch@wolfvision.net; s=20230803; h=from:subject:message-id;
 bh=ou+V5Mg+cQK/+nx6chzqIuN6MNQRuWnEU7n6yunl2Vo=;
 b=UhFzY5PlVTRDbx2zhAFD/+wl3qGXUYSTlRxtBvmokC5BVMJ/wBk1raT8A+xpQ+9ftwWuDQUIq
 es5posc4+TUBUXICGo60PEqVWxC2h8GdBb+5JO3+2rPDwdGcCJfqKx6
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
X-MS-Office365-Filtering-Correlation-Id: 603c4d07-d2aa-48cf-0fe6-08dc31f7f087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IS5Nu/mrRmrS/DanQQNS8u3lBnPujwwqp4e1yNVuDWfRdjJ120kF53yTmjbecyCeiN4Z7VH6TV1DEnRKgxfMwoMyqvbl43E1zH9AXVaIgEqR5w9wPVrC9c9lr8uyEH+vsO8c8W8ItAmIm7e/0THg5HqQAUajW51eyXUtArS+mkS2YKCwnmZPFp4KSQT2ZYKUBK3/GtTmpavghiTvFEn/+K4E/pRuqPhU2up1YqZHfmc9EeGwhO8JNmlnpulDoAv3h5msV6E/dnGs0CI8TU49LXA8VfKb763wtJdj9k+PUBevT43S48vu145+sHYmr+b/+gC3Rlx6fMZWe9dkKISVTthDjD5wyUs4P1t0Tj3/pmGnRYBXzl51LePW1edm8wlIGj0clLMVFdhQAfBwq5J5RNK83F56oHeZesDcWFEpN1a3v7mzQZ/El9T5gYgJK1AUHfg+WALVQcpc3kI3/ZOag5eIuAUH7tHKLYAFj1k+FnaL9qvy6CE10FV43Pw1m1IJN2vc0XLqFlj2lDZqh9/c00hcZ/h6NG+wo4F4HbwS3oRyIsu4pQYAR9ciPZ1V55Hx4eFWcPUQonjn/Ee08tDMlHReWPsOZp9JRBEXK2YpsOo/q8gANloElcpu3w2fILGK8+cpaKqTU+d0v8eszYXwGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkg4NEpuVzJFbWpwN25YcTJzanBtc1N6dTBGcGNyRU5LTnlUeWc2RmFUMzRu?=
 =?utf-8?B?aXk1ZDFMclk2NlJmUG0vd3VYaFhBWEtCMWJtS24zTlhOS2orQlNuM1J3enZ3?=
 =?utf-8?B?V0ZzczlUK3FzcXFiN3lDU0R2VmhXVzhMb0hCTWNxV2ZWV2YyMXVGTGdmMTVL?=
 =?utf-8?B?ZlJ0S3BYOW5nUnduUnNaN2ZIVVBSbTNmSVpjd1lIZmt3RzJWRmhyOVR2bHdi?=
 =?utf-8?B?bjhUc0VOMit5c0tweTQvRjc0TzFUdm9yMTZQRzlLb2txWVN1V0hmZFpHS3hS?=
 =?utf-8?B?K000OUxtR1NIaG1WVkMwWW8wSXdEZ0JISHdMc1lMbFZFMUxDL2VCT1BKTTM0?=
 =?utf-8?B?R0x5akhnLzkyTUJTTVFQMlZtRTY1SnFwRXR0Y1grUUxwdENWMzZ1U3hEZFpy?=
 =?utf-8?B?VFFtWjVYWmxzZXBaNGZsbjJuWVFOd3QwUzRZYXVkNG9NNkVHQWgvakc4NFJR?=
 =?utf-8?B?UnNJckhHMEtNTXNUaUdxMEZJeVBKaHEvU3JIK3FZUzBrUWk3QVp2YUJyK3Ax?=
 =?utf-8?B?LzlITG92dWQ1OUVxajBHc2YyTENQSjI0UWNaeGVjVnlJemlYdkJJTUdpNmlR?=
 =?utf-8?B?aHZaRzJTRFhlZEhLU1k5cUpQN29uaGRjdldhWC9RWmdodEFOK28wcnd5T2tH?=
 =?utf-8?B?OGdId0FMWkZXQlBXYjdUUHNZV3RjOTF2c0hucitNS1lNdndWeVRNUXZ2clRI?=
 =?utf-8?B?ZVIzMHlINWFOcE1Kdk1jNG15MzFyZktxSUkwUXhGMjRMb3hZNWl1anRxUHY1?=
 =?utf-8?B?Rk9oTlhISFBhb1E0L0ZXRWhJeG5yWm5FTWxUSnNaWkF4eUtabDQrM0ZKeklN?=
 =?utf-8?B?RDhvMW9PVGVtTW1TbjVaV1ZPSWZpcGVmUDhjOExaN0I2c25NbUROWXlNRnVq?=
 =?utf-8?B?R3dpQ0JQdXJHVFc1SWhqRUlLUTZrOENpRFU3YnA5Ry95Ujd1ak12S0FSaldJ?=
 =?utf-8?B?dGt4d05WeFJyVXF3R2RaOTI1NGtkaU55UXVrZDFlTzVjdXRYYjJraEpuU3Rj?=
 =?utf-8?B?ODFKWGpHcDVhbW9SUmZ5K3JyTFhBaVZhWm91VXQ5THNWR1VHVXFkUXppTWtv?=
 =?utf-8?B?VlNpTW5CNFgzd2oxOVpGZzVYRE1OUUFNUU52NkpPRkZqYTdKZkJVL1ZxV051?=
 =?utf-8?B?R0FRUVNnVGR6OW5DakpFMTVTQmplR3Z2YzI3M3BHRUM0QStiYW1jRFZlNHdl?=
 =?utf-8?B?eHhrSlFoZ1R5NnhjSzlnMWNlRVh3VW1NUTlqbUpYWmsvTnFaNXU4aE0xVjVy?=
 =?utf-8?B?a080Unc2eFdxU3lOazlSOE5rL0RHYVh6Zkplc0F6ZmVWRS84NFlLL3hvWnRt?=
 =?utf-8?B?YmVkYkhFSXpnOWEvSEdzL21Ga0twNTl2VHQ2VHNVbDdkb3o0clRodm9wVm9x?=
 =?utf-8?B?Q1pacGRJQ20rV1pIZW9INUpkZ04rRk5wK3hqVEdkR3ByN1hBelVqaXNaK3lT?=
 =?utf-8?B?WUhMbk5qVVlUNElWUzUxaDBqcWpXc2J2MDlEUG9KVUJGbVFGMUxvbENqQjVO?=
 =?utf-8?B?RGJwMklmZWdRQVl4MU14cmxTOTU4SEwvRDJZc2tCeWxiN2VvNTJjMENHRTNT?=
 =?utf-8?B?UDF2ZHo2Z1lOa3pIVmdvRXlTL2xucFI2ZjJmTUdKSUxkM25sd0FwOE45YW9O?=
 =?utf-8?B?dktxbDJsNERlMjRqc3NPelE2UDR1NitIY1V6UDM0WEhYVmp0T2tXWmFtMzFK?=
 =?utf-8?B?NGM2UUluc0JkNitaVjErdG42TEw5ZzQrbVpEWnozK2ZHRGlQdS90UkN3VUxK?=
 =?utf-8?B?N0oyMDBwa2l1WDBzdWJ5K2hGRmhZTjBsUEdRd0lUbUZxc3puTjlCbjE5b1NP?=
 =?utf-8?B?NlM5Q2JoOVh6dXNHSnd0c0JDd3NYZmZBSTB4ZjF0eTVJV1RUd2hTQXhJRHZG?=
 =?utf-8?B?Z2pjcWh4NTNDTFlHTWtWTW9WZE9FU3E0Z0ZIM1NrSzdtRVlQWlRtUzRjMENS?=
 =?utf-8?B?VVRIWHhkblhsdmR3alh3R3ZvbUQ0eWJoNnltVll2RWMvSktvL3dFR250c2hp?=
 =?utf-8?B?V2pKME5UdFNkWEtuR3lyTkJtbk16SlFWRUVKYmVPVVVrdDFhU3dHMnFwbGdO?=
 =?utf-8?B?anZxbU1Dck1uaWpNTXRhbWFqOGRaejFqSVpTL1RTYTJDVVBKOC9hMTd6U1JK?=
 =?utf-8?B?Ump0SklFV3RuckpyTHd6UDdCOGRveTdhRjhGT0kzQ295SVhFUGMxUVRaQVJ1?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 603c4d07-d2aa-48cf-0fe6-08dc31f7f087
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:40:14.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjtYwmDdpx0UER9CPusNJeZ77948ImjIjKQQvcGaxGMurQO96mwSIb4Gsaq1dZ49MDGiQiHAcQ0dG5JitktTir3Ren2p+IuUuol0Pr/YXnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6763

Some variants of the Rockchip CIF require the General Register File
for video input block control.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 drivers/media/platform/rockchip/cif/cif-common.h | 3 +++
 drivers/media/platform/rockchip/cif/cif-dev.c    | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/media/platform/rockchip/cif/cif-common.h b/drivers/media/platform/rockchip/cif/cif-common.h
index 34da800a0504..ae8fedeadd1c 100644
--- a/drivers/media/platform/rockchip/cif/cif-common.h
+++ b/drivers/media/platform/rockchip/cif/cif-common.h
@@ -11,6 +11,7 @@
 
 #include <linux/clk.h>
 #include <linux/mutex.h>
+#include <linux/regmap.h>
 
 #include <media/media-device.h>
 #include <media/media-entity.h>
@@ -96,6 +97,7 @@ static inline struct cif_stream *to_cif_stream(struct video_device *vdev)
 struct cif_match_data {
 	struct clk_bulk_data *clks;
 	int clks_num;
+	void (*grf_dvp_setup)(struct cif_device *cif_dev);
 };
 
 struct cif_device {
@@ -103,6 +105,7 @@ struct cif_device {
 	int				irq;
 	void __iomem			*base_addr;
 	struct reset_control		*cif_rst;
+	struct regmap			*grf;
 
 	struct v4l2_device		v4l2_dev;
 	struct media_device		media_dev;
diff --git a/drivers/media/platform/rockchip/cif/cif-dev.c b/drivers/media/platform/rockchip/cif/cif-dev.c
index c4282449a93d..b75b76508793 100644
--- a/drivers/media/platform/rockchip/cif/cif-dev.c
+++ b/drivers/media/platform/rockchip/cif/cif-dev.c
@@ -11,6 +11,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
@@ -103,6 +104,9 @@ static int cif_subdev_notifier(struct cif_device *cif_dev)
 		goto complete;
 	}
 
+	if (cif_dev->match_data->grf_dvp_setup)
+		cif_dev->match_data->grf_dvp_setup(cif_dev);
+
 	asd = v4l2_async_nf_add_fwnode_remote(ntf, ep,
 					      struct v4l2_async_connection);
 	if (IS_ERR(asd)) {
@@ -191,6 +195,9 @@ static int cif_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(cif_dev->cif_rst))
 		return PTR_ERR(cif_dev->cif_rst);
 
+	cif_dev->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
+						       "rockchip,grf");
+
 	cif_stream_init(cif_dev);
 	strscpy(cif_dev->media_dev.model, "cif",
 		sizeof(cif_dev->media_dev.model));

-- 
2.30.2


