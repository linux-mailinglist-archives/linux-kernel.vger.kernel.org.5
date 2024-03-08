Return-Path: <linux-kernel+bounces-96705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4366C87604A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE840284BFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CFC535A2;
	Fri,  8 Mar 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="FI89ULkT"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2101.outbound.protection.outlook.com [40.107.6.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA252F80;
	Fri,  8 Mar 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887980; cv=fail; b=tg4FgUtsj7ebrDdU7CLU6FgtLpMuNDT3tjiyd/QPQ3/k41PpQbrnKkLzuwvOSc/qnH+4cCWLO0gE/khmq/+DBFMeqoiUQtHqsLSZ6bU65LCEk5grzFNGyTKV0u31PoyXJtTs8EzGZPLDQACxUTl0eEMRESw8G180iprUm51BYFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887980; c=relaxed/simple;
	bh=u9QRTrWMJb2VH8RX+ps39SuL/EzhvOl/BQCZOrjL+ZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UI/oiDrv7YPX+CnWryZAs55CRA6bN014Tj6SyTsOLcitA/+KjoVq/xOlO3+cRQeDEf5wYFDU8+6e4VqVKYKnS8MpNSlMvo5FD39N4O7b7tn5KyrFOTE0GcxaelQl+TMnagkZeO30j/P6lC9/q1KEuQfvfoovKLlzcXCzZQxt27U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=FI89ULkT; arc=fail smtp.client-ip=40.107.6.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+nMJm2Xqf0rvFNFi0QW40WandIpQE9bGCUAOxu63xdiapAFr5Pmn3y/0fJbvZdSYO5WuppKGjX9Nat5g0rj2RQMLlSKzq91khZDdLp0yXEKKgwaFSUri2nRvdjEimAgokSnUowhjG5/KhjtmYuGvjuESM4t2GWd3RmiNUyfG4xiuBdwLcDB50x4WHBSsk5bHp7uKfTBgZ/cSve/IivIwvoMAa7WFw5yJqKyRTHoD1BcEKyIOZoeyqxXaxSZQqz2IvAOr9/eWSSZcyLc8T5V/Upo3P/f3PzXIIh0JuvS5iYaOnhYeIfjFYad8694pdG2joWTcjn6s+4zmM7N32IcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BkqQ4dOvk7yLhvzqDkcZ1PTRXcalauvyNlAG5fCuio=;
 b=Wusg+R0HlT6121ZJScmR5OiHIEgwRowVZTd1fRikawYbMt22jV/WFjDzUbwWlht3LjNmRVbxI+Mhz+B80qYbObJoSkIhxw86AY9sd1KqYzTMYlfdTPtf048U/WOLiTxjnWRkJrOoiHVvAe/25dcFnFJKL9PcLoHiQhHgJbsa2736th/BQNDKnPseddH2GXKJ65bKuIl2YNev4QHmB1V0qCanlHYM/vd24KZ2Ts9dSsKeljVDw1/E++bj4qfHwlCcGBUFmvzF3A5B//0LE+dAeZ6MX8feTjA8N0Ui8M0TGa+W/HwiWPupaCzs13kaxXyXtLufXuwIdee1rO/GCgnsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BkqQ4dOvk7yLhvzqDkcZ1PTRXcalauvyNlAG5fCuio=;
 b=FI89ULkTUXrvyMSYbmSzV2faqE9YvrhO8g9LXpsfaL8W+6R7yJ/8w1R+fEUjtC2wB0Osh7n26V6Atlbl2yK/L9RCEL196HYBIk4AjkQitdbNiS/YDleLSHGL0rQJO//xcTaScZirsznqPKecQHZ338q/JfRhKyPon5E63yd54rYgtdmkU7FA9QNWxD17gTz/uJuzwDcc6wmhLuCdDiOQ2m92tQFvhZm0MuXAhR01iqe2QRiisnf9Z/AvZHmXpfzMMxDXVjU+vvy6lg/weF+smV8IaAsrgZs3MrYWOwRqs/VWkE0qmGoH5LY0S2ETgL502CjyDojyE5PLiCdVKl+oJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com (2603:10a6:803:cb::15)
 by DB8PR04MB7131.eurprd04.prod.outlook.com (2603:10a6:10:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 08:52:54 +0000
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::8881:4979:e635:7fbe]) by VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::8881:4979:e635:7fbe%4]) with mapi id 15.20.7316.039; Fri, 8 Mar 2024
 08:52:54 +0000
From: Iskander Amara <iskander.amara@theobroma-systems.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	vahe.grigoryan@theobroma-systems.com,
	angelogioacchino.delregno@collabora.com,
	dsimic@manjaro.org,
	alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: quentin.schulz@theobroma-systems.com,
	Iskander Amara <iskander.amara@theobroma-systems.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: fix alphabetical ordering RK3399 puma
Date: Fri,  8 Mar 2024 09:52:43 +0100
Message-Id: <20240308085243.69903-2-iskander.amara@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308085243.69903-1-iskander.amara@theobroma-systems.com>
References: <20240308085243.69903-1-iskander.amara@theobroma-systems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0020.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::32) To VI1PR04MB6013.eurprd04.prod.outlook.com
 (2603:10a6:803:cb::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6013:EE_|DB8PR04MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f594da-8ed4-49e7-c02c-08dc3f4d24d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t3p+v2d1iI2QX54R5FdGBZGx4vr7cpP0QZVuRLnVM1CRi9wH90J5XSwx6lq/Joo5ippk8p6sB4dfXEqvy1m96g6ytS+cr/toLBaZDRtmPHCmOYfZoWuq/HX2UlOspHlY5k/12fd68s3biHXvkFeJo3RjNKCOD5XIdkye9vt2eWIzmRgUBO7eEI5ZiwCiCO3FSNCaTTUa7edetMEcY71qrbWxpSk1FB/X+vDWRkDbXkFKL+Jy6sfgn25Lv4Zb55vF83dj9t/fBSs1vijUAR1+HU2g1Gnph1wj1p/7tKsmEMhvbToj3AzbkPkcQ65YKWoiAZn3IKQQJuBrvYxK4iCf30kSW6ybfXefoUlKMfveyd2BVZob36tYB4JCnFs/7yOQ/4ZM4p7qXuHer1vrmo0sja6dZquLgZOGWZhWw7A9RYI+wyTcUonxxsEtqrHnit7lz8C0t7e2t/IXLyMu/giXXv921PSz3/bp4c7dsj+nPbnofV68LsJFiBjCX2dNwz0Yjtyovy2MrGBSj+O9LxtB9JYuN0Bn5AWTLNH0w+cVKs2AypIXGwSFc+4zAODtkcw3058GzA0HiLEYAi/rYpn+qURF7L/Vrk/Jyyz8DXZG9uWj0lcHKWeoFd2Bvw/U+oorgEwgGOnaPPtB/Rofi9IUbqZeqFxZvrBwFjitq8xrcUL2uBmTTHtU9oqYwHcfu1CNMbwRCOdQRuEkxuHyu21ygH7Fm343yBR2yw6ZZQAzOYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6013.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uEJP4ufdL2OE4aDH2licuRmCavh81ZNi0a8nyuImDjmyHAmuAsm4fdFbNDHl?=
 =?us-ascii?Q?kxCWQmK1hihX/uiT084eIs25KLtPn73MuGNCGCLWk5mW1Hv+z8ZDOggKqLLQ?=
 =?us-ascii?Q?Yvfkth+7QQQSZcyCIMWiAM9c2Hob8MS5D6qIljdAmcAZ7dl2vvrcpoz/MRjo?=
 =?us-ascii?Q?WRqCLoTQOCOSyNtaMiursB0WQx37ruQ/WoNKVB2NjZr+WCqPuICECsBxYzc7?=
 =?us-ascii?Q?igSHi3swDhMuqiLGIuywuUfXW1bDeimHfIhQnbBZPt8ZL/KyKDyHKXkbfHMl?=
 =?us-ascii?Q?hzrhZld+08Md7aeiZh3xQBIGDWCiXxOcYBYSuFh62xvSKvsxhjyuYMEC8M8L?=
 =?us-ascii?Q?qSd/j8nUGxLJ03bG+ijybOyxmbr9uKXZKEeQKM/j1HGcvY9LXy7fjB/6iy7p?=
 =?us-ascii?Q?KS6exEEIksfy/GQOdCR9cpbpQRlqK+ff2h6nlm0359U7zsTw76D6u3G/l4eh?=
 =?us-ascii?Q?nGFgEwgAw1i/4QibJCwuU/hTTMa7+Cg/5l/1pJ3Um8mdztlKpQT0MPDMJsjB?=
 =?us-ascii?Q?SXylXrlkOstMpGl+wOAd1YhajL+9Kerz8rmhsqzeRHfXi2+oUdLoqzfUv5ez?=
 =?us-ascii?Q?jh6zjGjk4nbH6SmKVkldEAPFgmWz5wV8sw2OLKCRTmXZn7x5oeTALABuOSE+?=
 =?us-ascii?Q?MydPqJl3qJzcVZTSLLY7w3/xUUKreD4+u9yvClNy0kmuU6LkSxeurKQlxO23?=
 =?us-ascii?Q?mdGuxETljDaCdW/dja1KmTMZ74rNinq4qygEnvTuX7qtqbOLuTnlzUnEvczc?=
 =?us-ascii?Q?mYD5elZB0SpJicjmp1vFoAEa1BXKY3MGPztkIDLfBTPcad0gxxr13e3D7bPX?=
 =?us-ascii?Q?tvUudaEqx/NLsNLeJy1S0gWMo5D2C+yqlvy4sU8T+im52iRwxakcm0v2VNkk?=
 =?us-ascii?Q?SUfjvHP2m5aajyBdW6spRg9pz5riD9bS1np0IrBfVF4JGd7yqpvnni1Tbpl9?=
 =?us-ascii?Q?tb769+zu0AVk3VKdsaZABbqmIDpztcgdp15pXd2m2qaG8fp69PNkpMXcxM3/?=
 =?us-ascii?Q?73MkWhz/lfvnPDb2THg6gUAondfPT5zJTtaQBiZNEvWM0zpZBPuvitmg2VAo?=
 =?us-ascii?Q?1I/DpPkubayj7pRG1bGRD7ylbBib9q0RRpERmhHgiiP1qtDfQ6M2axOtMZlF?=
 =?us-ascii?Q?tpDVw31eYl/2uNCI+saoob3jOxUj+uG7HvY4JPuNNYar2RYc+JhFuxja42z6?=
 =?us-ascii?Q?EdoQeviG8Nt1hsgqh0jGKhnOewCR6rSm8VxCP+fFwbu5Lcpk0cWq9vXox7sw?=
 =?us-ascii?Q?2237Uflk8cOtMs0FPGdbzL9pZb3HBv1WgqRhzUYVoWxwNqjbJ66LEEFtz9pc?=
 =?us-ascii?Q?c0Sckw5AsSCrOs2wQgQUwWX90ATbso4NCkkS7RMJKV3cssfqFwpzVYbYOxmP?=
 =?us-ascii?Q?Ctmkva7bynqbsgLspthfy3jgYdARad7X+boN0NEMWmBEognxcziOLn0Jw4Fg?=
 =?us-ascii?Q?80HzwUC1WX9d2hzytWK9m//2ZQj0KkZMe2SwhhNeIF3phaL/hzel8lI+Nh7x?=
 =?us-ascii?Q?ndhZNwN4PPlA+sw/2MKAl6yaiGsjbjl1Mq2TImeNEKByiG0yghPFdh61RMZ8?=
 =?us-ascii?Q?6/q4XnD8g8qepVI+bWGClw5Ef5xRvERBWaAVQt51mPdNeKNgdfEl2AXv9zGh?=
 =?us-ascii?Q?sbyHvc2TevOKBsk3/B7+Qs0=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f594da-8ed4-49e7-c02c-08dc3f4d24d2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6013.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:52:54.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vywGMBDBc5R+qduXm1UWlc5Am5uCE4Y7BijZfc8TyOARsI95HiJn+yNE5ct1RzAU56/hXjzL6Yh3h9OWAfa5xM/SWOk1CFMWmI+R49KgWYxGJldYVsStFaEmIBBlXri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7131

Nodes overridden by their reference should be ordered alphabetically to
make it easier to read the DTS. pinctrl node is defined in the wrong
location so let's reorder it.

Signed-off-by: Iskander Amara <iskander.amara@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 06f3e97af7cd..214ea62b24a5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -416,15 +416,6 @@ &io_domains {
 	gpio1830-supply = <&vcc_1v8>;
 };
 
-&pmu_io_domains {
-	status = "okay";
-	pmu1830-supply = <&vcc_1v8>;
-};
-
-&pwm2 {
-	status = "okay";
-};
-
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&q7_thermal_pin>;
@@ -473,6 +464,15 @@ usb3_id: usb3-id {
 	};
 };
 
+&pmu_io_domains {
+	status = "okay";
+	pmu1830-supply = <&vcc_1v8>;
+};
+
+&pwm2 {
+	status = "okay";
+};
+
 &sdhci {
 	/*
 	 * Signal integrity isn't great at 200MHz but 100MHz has proven stable
-- 
2.34.1


