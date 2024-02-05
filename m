Return-Path: <linux-kernel+bounces-52007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8027B8492B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A510B1C21200
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF6101DE;
	Mon,  5 Feb 2024 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FZ6OYFdS"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2371C8DD;
	Mon,  5 Feb 2024 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102836; cv=fail; b=lu5SPkvuBp0TTMGWyAhzIQ37p17Ay7xVZ6UF395XMLgt8gYxOnBVAloLf6U/sc9CpgUzlvBFC7GU/cr04wwSM9J3OyfO/IpiUu1K3+VYKupo1t0ic0/oHzK/W084ToxyqfUd2ZnjV4Lz5817mlcIjqP4Dm4TFaSzV6RR3MiTDbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102836; c=relaxed/simple;
	bh=/P7Mh6+rGus4ZR9EnTfG2YKi9FwnzI5yc762q8IHZ3I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SXGeJrEM2G6A66HepjSpPbK9cZ2Rfl/fRL69KThWnI/Uk50o2tFtpE9zhODsd1c4SwqcE6tLCfMYHJ6tKu/3wg4q1UHoMRNLtJt9dnME8Fv4Np4vNVnrsqQFBR7vBwHPt5vlgwkaK8aYmVxz5nrwt8eTKUXIYh1QpHQRX8ckhFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FZ6OYFdS; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ1Op5R36Xp6WN1weBGNdP2oZgTj8DrqaYrlcuBcqeefDw1EqDko4f/0SmAoQIT5HrX9jEQ4dU1MOgqqwc11OHsPuP1Pvd9+fPJfonJy+hgEIqFo/PyxwiWU6T9vgEGQ/ZYQzdRWgTkoIVV16OJPDj7jI5SQ1gIAVaYPkQNS2o6HP2vYMFaZ6VwvH+HX81XjSAuBm2JFhVVpP9BnjWFdOUjWzqVsQVq+lDLFh0RPtFwVFRBIXjqOUv/4/O3V3w6NuZxQqZzHD3PJ6W7SapR7mw/4OuVwQ9Iv0VFRFxIwqZQFjWFrVNFnVCsJQm9N5EoCJl8hH50sFkdK7RKMO+ANPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojj9JFqx7/SKG+NtV4R+WN6A0aMY/vM2Wbiw0lOFvc8=;
 b=SWW6SCzpcPpivoYU5TLbOK1tf0kdI62m0JliiL4LH+ImKc2KyDGCNLtlMepK/gW0dsd1GNoYvujnUrPuGnzOuoS4vbGu+1bAKOQsjz2XLu0scpRnuu0RxRkkrlgx8fSWT/GqaJ5IWzbLucFfMucGiRUurO6exJjQRK8e6H5kUur4Zo0tAoIhD/Wq4/TDnrH6TKzsLhEkBuD8jR8zBrHV2cIIxH/0YSAdlNgW4gyWEuZ40ChM1/PRxakNV6vv3Wx4hmdNWI7j67B51Lh53B4q9TGIfoiG2J+tgb3/Ib7erBBfauRcmkeF+6LUx1FiqyNYuM9fRlaHf6iLaV7+A1dZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojj9JFqx7/SKG+NtV4R+WN6A0aMY/vM2Wbiw0lOFvc8=;
 b=FZ6OYFdSs/pzePz5AWs1G9e7AGJ+qgmmxV4fouDcYo/AIoe7bMx7sN1u4kCLa5ZbgzBLlVmGAnEmk0aP6kl2WeZJZkJz/5vWengG18d+BPchU/Tk02Qxw1+wm491RzPHZaSI1MYbxjnU2IKth95CPfaBjktevoWuWxdtTIu9sMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 03:13:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 03:13:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 05 Feb 2024 11:17:58 +0800
Subject: [PATCH v4 2/3] clocksource/drivers/imx-sysctr: drop use global
 variables
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-imx-sysctr-v4-2-ca5a6e1552e7@nxp.com>
References: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
In-Reply-To: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707103086; l=4899;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=S7w4NqGjFN883vSC1fzkHyfccuvNVL7NR4MRBDh8Qms=;
 b=bD9PSR8u6DgMlZb1CM7VZyCiBI8l5A6qOl3CSEuPxz8QpI3az80lzl3T1cdRbTKP3WyPKbXh/
 XB+QHefLv2hDPFbQdNVR7SsApbvIJMxpZrNyw3iDWwxaM6WNrs3CkVj
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2844ee-13e6-4f55-aa0c-08dc25f87972
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EqToun86n84hAFq31qRQA5jgCxHqTVzEoRNZfAyfDdiqpI0Oq8gymhvLuG32HejILzihv1rVxpvPiDrtyEU0tpGCVDndIjYCSp3isP2Q1kn6FTwfa6DDepS5nxW0JHDH8dQOlPEkbM0rS/N8eVV2WJmwXi0/7aA6r+T/M+JZPoQ7vUSI4SNYDGJDBJfEoK/p8xd+LeqsdeWMOf+n2vECeNdwTQVTkR/GLa0pBXBC5nOOst9ekk/yBOLL+g1AXDtr+UxwPVvahPL9b1vmRonfiox7qlq2lp2QkxT9FAEbCh9vurKXuE1Y084lPh+vQe+GjVZnzGRSJG9qsHaYPXir+Iy+hGUfwcJWq26Mu7R/ED00dMUitkV4r16TUGvTHjmZuH5Xu7U1fV/8X+odu61hNANcND9sZH3k9LaDqyjpbnnpMYeSRcb9wjfV2PX1J7kU5IdLzMtbzPznGBbYtulHhNOJC9cld2G2/+pMLNAvB1D4jTXF4PwonAjRrbwgaDrfjgZI8DaXl/25luTiBC9/XiynZWBW6h1Kjzt81penHg7KwHWpxAeRFgs2bh/CcGRWU3XHuq6F2yA+rwNtkZup2uGp9hp1/BUcDuKGukE7QtdDNGBVFgbKmx/MSnaJqn1efzL7Tg8Pdb4Wy2PaPGiOGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(52116002)(6506007)(83380400001)(38100700002)(26005)(86362001)(41300700001)(4326008)(36756003)(8936002)(8676002)(9686003)(6512007)(921011)(478600001)(2906002)(6486002)(7416002)(5660300002)(66476007)(316002)(66946007)(66556008)(38350700005)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1BoSmt1S0FWOWowSDZtZ1JwZ01nb21Pa1hGOGtQM0Foa2hvaG82N1VVNDdM?=
 =?utf-8?B?cVhWVmVFYkFsbm54eUttZWw0STkweEZTNEkvUTNxMERRMjRJNVNkaXZMeldW?=
 =?utf-8?B?MzFKUm4zWUhnblBjZkMxZ1R4VFdFQUtmaGJ0aUFCa2czSDBPQ1dCakgyWFlv?=
 =?utf-8?B?LzN0U1pXVUp1aU1ab0xidENLMjhEQzFmQkU0b1lJcithdWlHLzgzT2VPWFo3?=
 =?utf-8?B?dkJZZ2gvS0NVWW9GdEsrQU9wb1hGRURja05rKzBFM2R2Ti9jTHkrNjgyRWht?=
 =?utf-8?B?RHBOcjRDZmlEejc5My9NVHlXWWlLZ1hVdVRhS3BaZmRSak5SaVhMb1pVSUFY?=
 =?utf-8?B?Y0RPQXo0VFp5SmJLdTlLUFFjbEdzdC9lMEI5WFlMS2ViakZqWHYrNkxTcGtu?=
 =?utf-8?B?N3JleXd0R2tIdWRoMlQwU2FUeUs0VmdlUEQwSFVDNFFic0pJRWt3OUdueVF2?=
 =?utf-8?B?NE1TczJnVTF4NGNKZG9GKzdKNEJNb3RMY3E1SCtOaUx3R1FRYmNjb3VmT1RN?=
 =?utf-8?B?NjBHWlVHdUJ0RFp0cmdpN2dlKzEyUW16ZCtpeks4VEg4MER6NVp6cmYzbWVI?=
 =?utf-8?B?bUREVzFkTG5Gb2hsMFllaTNkNktJR1ZlM0xGUEx0dDhzOVlnbnl0eTNsTWk5?=
 =?utf-8?B?ZlBrT0dqR0lqWUJlOHpkekd2N1JBbGhwUU56YmJWRUJyMlRON1R1NjJ4RTJo?=
 =?utf-8?B?OW5QOENSSm5HTzF4eUNCTS9VMXBZa1plSVN2Vngzdk9oRFhJT3RKTjlUNUZD?=
 =?utf-8?B?ZmNHZG5wZDl0bG12UFU5MU9ENkxSOUwrSDY1a3o5Y1g2WE85SGxFbGlUN2N5?=
 =?utf-8?B?WVpQL2tqeEh5VEk2Y2dnSk51Y0pvck0xa29EbVFlUHNYQ2dUN2dWRUF4YlZv?=
 =?utf-8?B?NThsWkc4ZU0zY01kWXBHTDN3MlFPM2dXei8zSHc4cmUvR00yWHB6RlgzWWQ2?=
 =?utf-8?B?YjFpTEIzSWJiQnhscFI4ejR0MnVFZGxvcUJ3MDFWUkYwSnR5YzRDQ3VtaHZT?=
 =?utf-8?B?YkM0TXBpNVVkMzlIR3NPUzJBVTdtWFhmVm9SZU16ZDB2b1ozaHB0T1BWWnFF?=
 =?utf-8?B?SHpON2NzOHVncTlnaG5xTnZvNnkxSElsTDFFZlFJSWpmMGkzRGxIYnloL2ll?=
 =?utf-8?B?Uk5mSkRWaW1vazJEOWlBenlSd1hIRm52VDVxZHh1VlpvZGhUWUpiRFJJSXVo?=
 =?utf-8?B?dlNlRVVYblM4YVozT1lxVEQxN3p1QlNmZW9WejkydjF3SEp3STRrbFNWU3pZ?=
 =?utf-8?B?TkJBb092aVJjTVRudGhHSVdSNnlXWGM5T1BIVGxTNWt0SUhnN0k5ckd4SEs5?=
 =?utf-8?B?cVkwbkxqNWdzMmpUWExxTmtXTzB4RWhKWWxPSktENVNUT3N5ekZ1NnVxRmpu?=
 =?utf-8?B?SU9ZT2FRcWFwcDJweXRrbzUxYVJKYU9MT2p1UmJaUEhQUXVMMXh1dGxKVzQv?=
 =?utf-8?B?RXdNQUxzTW1EZHk4bFp5S1M5alQrd3NyWHViVmFPVlpSV0doRGh6K283enJY?=
 =?utf-8?B?azNla3owcHB3aHFjSXR5QjdUN0VDenA1TWdNbkFEeHYwZDF5RWdncXUyT3Rq?=
 =?utf-8?B?ZnVQb0xnV2loTVZPWkVDc2lld3JiWWQwVUwxUG51MnNlK2h5VXNUczR3R2wv?=
 =?utf-8?B?RGZZSGQwYzZNODQ0eTllVlZpT1Q4LzVPWm4xUkV6TFQ2aXNEVldJYzhNcGRG?=
 =?utf-8?B?OXhyZlZQSE5BQUd1RTkxK1VKbHJLMFZzVFcyN1VHRlZkSWNTeWlPN1lGRmNN?=
 =?utf-8?B?VlJQaENmVHNaZCtuN1I3SE9LREw2NDdVSWtiREhrdnp2SmhKOW5pMUZFNGti?=
 =?utf-8?B?dEJBNmp5MEJBWVpQNEVlRG9rc3U4cS9KQkxib3pUQ1d0ajZ3V0hjeHYxYzcv?=
 =?utf-8?B?bFVQYjZKVjVxczE1ZEtBcXlvZzFHbVJjQnRzVkRFZkZTMGN1UDAxek14TlJt?=
 =?utf-8?B?TWdDTFRxU2hISmlVOHFXbXQxZlA5UTlGTCt3MGxzUDhaSVdRUVQrVmI3aWQr?=
 =?utf-8?B?dDNkSitPMzIrUmxHUUd2TnJwYmVPTkdPZ1BEY2dlcjJrYStsWUREUVA5TCtF?=
 =?utf-8?B?dDFYa1hhWUUvcFR4endiendVV0N0Z3lOSnJSdWQ1ZHhOT3ZQWnVLZ2RQYk9K?=
 =?utf-8?Q?X7QKoS8F7I3JECerNauzNn/LN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2844ee-13e6-4f55-aa0c-08dc25f87972
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 03:13:50.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYGeEci0ei1IChQHyk6jVqdLMhHVoT+KjakphIEZm7mMsZmW9xDKdfD+M+bvSCLo4ph+n7C9jrapnzrY60utDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775

From: Peng Fan <peng.fan@nxp.com>

Clean up code to not use global variables and introduce sysctr_private
structure to prepare the support for i.MX95.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 76 ++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index 5a7a951c4efc..c075ea89a214 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -4,6 +4,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/slab.h>
 
 #include "timer-of.h"
 
@@ -20,32 +21,39 @@
 
 #define SYS_CTR_CLK_DIV		0x3
 
-static void __iomem *sys_ctr_base __ro_after_init;
-static u32 cmpcr __ro_after_init;
+struct sysctr_private {
+	u32 cmpcr;
+};
 
-static void sysctr_timer_enable(bool enable)
+static void sysctr_timer_enable(struct clock_event_device *evt, bool enable)
 {
-	writel(enable ? cmpcr | SYS_CTR_EN : cmpcr, sys_ctr_base + CMPCR);
+	struct timer_of *to = to_timer_of(evt);
+	struct sysctr_private *priv = to->private_data;
+	void __iomem *base = timer_of_base(to);
+
+	writel(enable ? priv->cmpcr | SYS_CTR_EN : priv->cmpcr, base + CMPCR);
 }
 
-static void sysctr_irq_acknowledge(void)
+static void sysctr_irq_acknowledge(struct clock_event_device *evt)
 {
 	/*
 	 * clear the enable bit(EN =0) will clear
 	 * the status bit(ISTAT = 0), then the interrupt
 	 * signal will be negated(acknowledged).
 	 */
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 }
 
-static inline u64 sysctr_read_counter(void)
+static inline u64 sysctr_read_counter(struct clock_event_device *evt)
 {
+	struct timer_of *to = to_timer_of(evt);
+	void __iomem *base = timer_of_base(to);
 	u32 cnt_hi, tmp_hi, cnt_lo;
 
 	do {
-		cnt_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
-		cnt_lo = readl_relaxed(sys_ctr_base + CNTCV_LO);
-		tmp_hi = readl_relaxed(sys_ctr_base + CNTCV_HI);
+		cnt_hi = readl_relaxed(base + CNTCV_HI);
+		cnt_lo = readl_relaxed(base + CNTCV_LO);
+		tmp_hi = readl_relaxed(base + CNTCV_HI);
 	} while (tmp_hi != cnt_hi);
 
 	return  ((u64) cnt_hi << 32) | cnt_lo;
@@ -54,22 +62,24 @@ static inline u64 sysctr_read_counter(void)
 static int sysctr_set_next_event(unsigned long delta,
 				 struct clock_event_device *evt)
 {
+	struct timer_of *to = to_timer_of(evt);
+	void __iomem *base = timer_of_base(to);
 	u32 cmp_hi, cmp_lo;
 	u64 next;
 
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 
-	next = sysctr_read_counter();
+	next = sysctr_read_counter(evt);
 
 	next += delta;
 
 	cmp_hi = (next >> 32) & 0x00fffff;
 	cmp_lo = next & 0xffffffff;
 
-	writel_relaxed(cmp_hi, sys_ctr_base + CMPCV_HI);
-	writel_relaxed(cmp_lo, sys_ctr_base + CMPCV_LO);
+	writel_relaxed(cmp_hi, base + CMPCV_HI);
+	writel_relaxed(cmp_lo, base + CMPCV_LO);
 
-	sysctr_timer_enable(true);
+	sysctr_timer_enable(evt, true);
 
 	return 0;
 }
@@ -81,7 +91,7 @@ static int sysctr_set_state_oneshot(struct clock_event_device *evt)
 
 static int sysctr_set_state_shutdown(struct clock_event_device *evt)
 {
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 
 	return 0;
 }
@@ -90,7 +100,7 @@ static irqreturn_t sysctr_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
 
-	sysctr_irq_acknowledge();
+	sysctr_irq_acknowledge(evt);
 
 	evt->event_handler(evt);
 
@@ -117,34 +127,36 @@ static struct timer_of to_sysctr = {
 	},
 };
 
-static void __init sysctr_clockevent_init(void)
-{
-	to_sysctr.clkevt.cpumask = cpu_possible_mask;
-
-	clockevents_config_and_register(&to_sysctr.clkevt,
-					timer_of_rate(&to_sysctr),
-					0xff, 0x7fffffff);
-}
-
 static int __init sysctr_timer_init(struct device_node *np)
 {
-	int ret = 0;
+	struct sysctr_private *priv;
+	void __iomem *base;
+	int ret;
+
+	priv = kzalloc(sizeof(struct sysctr_private), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	ret = timer_of_init(np, &to_sysctr);
-	if (ret)
+	if (ret) {
+		kfree(priv);
 		return ret;
+	}
 
 	if (!of_property_read_bool(np, "nxp,no-divider")) {
 		/* system counter clock is divided by 3 internally */
 		to_sysctr.of_clk.rate /= SYS_CTR_CLK_DIV;
 	}
 
-	sys_ctr_base = timer_of_base(&to_sysctr);
-	cmpcr = readl(sys_ctr_base + CMPCR);
-	cmpcr &= ~SYS_CTR_EN;
+	to_sysctr.clkevt.cpumask = cpu_possible_mask;
+	to_sysctr.private_data = priv;
 
-	sysctr_clockevent_init();
+	base = timer_of_base(&to_sysctr);
+	priv->cmpcr = readl(base + CMPCR) & ~SYS_CTR_EN;
 
+	clockevents_config_and_register(&to_sysctr.clkevt,
+					timer_of_rate(&to_sysctr),
+					0xff, 0x7fffffff);
 	return 0;
 }
 TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);

-- 
2.37.1


