Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A32D8041B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjLDW2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjLDW2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:28:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45731CB;
        Mon,  4 Dec 2023 14:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDd6lSofm/AgHyQW8zqqtW9UPm9Fz1jzspR1km2tjv56PIJmPp+jNM7kEKN/rrrig0OjYvdyZfBY/0nQ0pAIntipjDxPdqkjPotD7O6dG5GqDv7Y3PIGh9S+GwCZ5HFfnkrHn1inBJX+cPlXKjobYv3eQojkjXHtYb+UFMfDHMi+r3nKBV//ZyJ4iYjqLyDSlx5KKBbZt4x/dLTnUXv3baLOOqgw4qfGqFbp0ly9//pRTVJde8SlTkdfllccZz1EOr2IsoC2GTnGzpFgX/9P4yq78rohcLjzEo+y5zY0iF1APHwKpju+OPET7U1LRTFBjTWQCECi6LkDfHlwaTHIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVwH/eAbVjxau961/+broYNye0CeNFiccsAD/ZyZpRQ=;
 b=SrY04zsMntFYht3tEveA7uibVTb+g6928EbehGIqJx5MFWlowYWtgbdgl9U7Tu0qC+00tHkHYCeWmkBTj+/662N1eRNrC39JWbgHH+4W+PyJAMEHDHyfi/gGuTi5dR/591CkpuAvh9JVFed77k7uE8AZU3ytyitPcZ40my83V0z356745jUZnWNPuDfJPfHWpgC9/U66cJU9cnrIMFUJhZSeTA4X3B3ozgHfzF+cAzpMXhrm9IfR/dQAnhvWK1SyTIbLtGb4UU/UHq023KguF+v1OQohjMb05KqrGbpz4FtOz5mg2kFwD4kJVjafyh7m3YAZ5WauDyC3u1BEc49WMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVwH/eAbVjxau961/+broYNye0CeNFiccsAD/ZyZpRQ=;
 b=M7XTSnpIvn9qAlPWUk/WeGuwCnGbBxw0F7otNdJ/Kj9oJ3wgorvzOKuCBabI3wZ/fYS9ZzXWBEardP7L4z+OARJ0c5eWkld64XXBUKCg1vz4Kyxzfu7QvaWBphIdbatWiEHoCA4c8HZsbZ3HbydtJc1V0r4uV6ZWe1q9/BFKRL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by CH2PR22MB1912.namprd22.prod.outlook.com (2603:10b6:610:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 22:28:23 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::388f:1cd7:191e:21ef]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::388f:1cd7:191e:21ef%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 22:28:23 +0000
From:   Garrett Giordano <ggiordano@phytec.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        w.egorov@phytec.de
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: [PATCH 1/3] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Lower I2C1 frequency
Date:   Mon,  4 Dec 2023 14:28:09 -0800
Message-Id: <20231204222811.2344460-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::19) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|CH2PR22MB1912:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8ea12f-361b-40ef-aa10-08dbf518536d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrDcwURCNQmFLam2y6xQxkVT+TEuk73p6jvZfHjz9tBjbFJIf+kNWAzsS2qn8SQcm1iWXWN0t5/5LRCit4WMGYvXnN0p9iZbyzi0miSBEYo31tdiNjQWG0cjfE41RY7Sxtxb70pN9N5caTGY67X53pYp4FDIQO7xtuzLqULT2G9Xcb4RkGxMTCVEnMUt2ZH1szNJTlNatCQT9DMfMczfzC7j1eB1XOfCicVAZTjB8auJhejHODTrfh5FaoTeP9szXvjmzHPLebP+iQEuQEprMwVjmOV/34NKuwOlGwIrz2JE1aJ57cskTru+gw6egXucIgWKFiBIzab5+gS+IXEWxbOZod0v1YPEN3wR3k0AM0b2bKgHwT0zE4r0cw+jhK8D6KSV3M9HLaKi2hkd7L1Jfnt+Kq+6WrwwSqujsMOcArRdcpbhJto5NlqTSci8ft0A8t2279uXrw70lbfB3pdpHzQOMxuytA7TZ8oEsoIINR+/L+h2Jr12lkcrv+xIVCt8Pz6sdqjiMcvz3JX0ZXkPYFzcjYuRGNkoPnGFTGe7jRUUdu4PtxYF8q9Mgfs8hvIu9TCYgz46MDiqItSTQQ/ssZxC2W0IEbRHhBFSR3qYU6wntF5kH/lbQ+BPEwkZ5B//
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39830400003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(4744005)(86362001)(7416002)(4326008)(8676002)(8936002)(2906002)(38350700005)(41300700001)(6512007)(36756003)(2616005)(1076003)(6506007)(83380400001)(6486002)(478600001)(26005)(6666004)(52116002)(38100700002)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DxRKkP1ZpXRkMM6mE9uKbriYHL7cGz9vLtL1unVxfMV5uXTfO+ibiJli5exP?=
 =?us-ascii?Q?dA9vidQURktdw5zkF2HDgnkklLbZPZQa42qqqJjtxTc1g7dyX9j/HKEHlYNJ?=
 =?us-ascii?Q?tUB+rg/tof6M0xGy4xN7VnFGGvHIZtIVhrj9y3kJgMrYlkp/HYEX9zvNzcSh?=
 =?us-ascii?Q?YJ4VRPzy8tKB5kKAOY7HLFvyyoFPyqTeTOckoPMwF4GVxx3jVscW+33nqvnH?=
 =?us-ascii?Q?2TqIEXSD4oq8w7nKbq3l4ox/kK3dssczPstV5qWAsJF5KlvBMx9cgjWxJ/Ck?=
 =?us-ascii?Q?Q6BuUGcZILdx82xW58LP5fyNZh3okS8cGWmdM183O21a0alfQYwMmZ0n7V6h?=
 =?us-ascii?Q?yIq30MTDj7dyScvPd7hqjx/vxLrMPE0vFCF059wiifITPgeEKFuYjfDh/zbO?=
 =?us-ascii?Q?yOpM18kS+HN7rj/3zuiftxArdpRVubnwTuWkZL4DJWGNn9y+GDJ+ErDG6uQm?=
 =?us-ascii?Q?XcrOQGgcbh40txd9ozv3PBXELIqAW5FanDTfz5Nzz4kkjREBAGsSwTyb4Hp+?=
 =?us-ascii?Q?DFS0VvcNo2ErSfhPRyaeBIWPKxcfsYP30XBpl6RNaxeye3VnsbgN58pI1inM?=
 =?us-ascii?Q?iDaziUEj0tQsl394+1L/qC6GGTYbYpZBdm04iGbl3/d32N9a+f99V5fixM2q?=
 =?us-ascii?Q?pnLUEZxq3AgOgWSbOgJ/841kpGHTnHdJAmtBopj2jXD4coS6+yrzSU8YIHS4?=
 =?us-ascii?Q?Obkb8vH+h47Je5Lg/Fc6+SIA6LWO8C6yG4EkyrzyhFHVo2uS0Vju66DzKe0j?=
 =?us-ascii?Q?k3q7iR0r4jc0EGOT9jLPYJjD1L1xLdcYG8HLxWnRPGL4Ms8cgAS8tP/FCODm?=
 =?us-ascii?Q?KUM+/Nkl/F3PlfzmumFQB0hMSoYL7yBA1Z8FAKQvaAS7GZT7FcX2ItVgacvf?=
 =?us-ascii?Q?9TWVhx60EbTkw5S+xrV0TU8f+W7eusUcFAiqsWMb0TW/Bid74jA+5weKQmZ7?=
 =?us-ascii?Q?7tX1hvOKJi+AfiEwlJ/YnF4HkU7m4I4S/iBdyzMYfKG9CAYsOWMib3+ao2QZ?=
 =?us-ascii?Q?cDZiw8VxT84QjDzoG+vZDk/7YQ+MN0quZOcdb+DIIQoOIz+dZ8MLoEXuImsd?=
 =?us-ascii?Q?qEDp6Wn9xuENd7v5GX3u4iLd0/JcdYeC69maoEkD334W+9GZOWkcG3mO1q0q?=
 =?us-ascii?Q?vxz0xgWHFuNbvLkkl0n+Gp+TtqZLETo+GjcLHuVh4zzSmM8PyYhauCpRbDbv?=
 =?us-ascii?Q?ncBj5Wdf+ZRtToocUkw6iI5UiqctFYRmNVxxp6JOR8EThVqSYoonewJQlez5?=
 =?us-ascii?Q?2nvDxzJ7gU0lmGip+2YgZxrWrCBsspx6p2DS2MFbzlWFd4Hmchff5KkCg64j?=
 =?us-ascii?Q?aosK5VhreBv26DClaPTrUJbx7IZYM1f+d07c4q3RPKucmSJ8M55zr3Jr4ZjP?=
 =?us-ascii?Q?241EHijM8IKrFir3e9tjwxJENxB2rfNtGtzRD5+N1Pg8Vcl3I2EzLLJnie5W?=
 =?us-ascii?Q?EJS1E/iznwQh0OR71dXj8/VLopNf+q10d7r+9psjliHT9FCVUCXd5dX5+d5c?=
 =?us-ascii?Q?+JLPMZ7Z+S0pGqYw371C97wFdepFdF7wELXSQPF+JZltfpaCJnXP5h+J+9NM?=
 =?us-ascii?Q?9xTezx3Koo/bVv3jr2Y4XMbgMBUzjUweUEsSJszf?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8ea12f-361b-40ef-aa10-08dbf518536d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:28:23.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J26LTgQQHBU9eFhCJqwD7ujnr/JEK3TEdtC1EZEtNcm5r96pqBO312h2CuoMHCeyC7MeAZQiOMb3Z6kgWU07A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1912
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio-expander on i2c-1 has a maximum frequency of 100kHz. Update our
main_i2c1 frequency to allow the nxp,pcf8574 gpio-expander to function
properly.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index a438baf542c2..171354b13e33 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -187,7 +187,7 @@ cpsw3g_phy3: ethernet-phy@3 {
 &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 	status = "okay";
 
 	gpio_exp: gpio-expander@21 {
-- 
2.25.1

