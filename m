Return-Path: <linux-kernel+bounces-50695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4071E847CF7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E07289F2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9312D75E;
	Fri,  2 Feb 2024 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qPY0Qgsp"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE612D751;
	Fri,  2 Feb 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915397; cv=fail; b=eYOrHc7CBZWYLR0ymxVVEchLZJkROjb5IrHTr0q94SUOtyVX/8aLTAAyj1cDMW1dXc8qmoIxY3+oi6nAthwNAb9tHhhvoD4VoM7NYpbwQsus+jXKKo3QU0x462FkeybiIEYmWGI0IBpz93sjv+QCFnbeZQeVq9Utxv8cO1xH3XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915397; c=relaxed/simple;
	bh=UleligJ+5dWLrDcWdg4rHYSCFQexdlcwQ9GqmxEeMXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N2kRzzE3cWYAZ+SAnisn8XDAG2RnJ3eDEniEqtJzegmHmyUctOoBl/iGsTl4C3qjbOlRcc0iW1Iy5Erz3Wl4WMRss6E6JUOtdAKMzMwSFBVeRTUdA1TTDEdU5C6oBnb0XhuBVcoqCIN4h/XSCSEURHoQtK1xI6Dw75pqwhlxC2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qPY0Qgsp; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKScq9qDETF4gtHzzRJ3APzHmtGVf9FQ/JzA4mzfDSOoQKOInVeGjLF0F4Ypyo7U34gRdFP1HFkbybsNaJzqob6pZHE9xa6XpnRQQYduLVEu2PfvdHzx/rNzGj6emYj/2qrt3kYw3CUkPB76gLm8YrPSa7Zh9a1WVqD+L3AhsveZ+/EZ3wl3oJvt4w8po4UtfNY4YSoPdeekA0Gj/nxrnOgzOtF5Wyj4V4GuDdemy+QCefwo41r0kXs1kUwg7TwxUPV4VKggbtE5QL4LXX3729e5VkNWIDOSnOkw6HukwzOT+BzdDjYd886lMAc56//lAs/B+PEMRSyAD4iKaSQ1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDK4qrtnr5XVTe+ocNEiDTpD8I6wdwaixxJbj5SM/h4=;
 b=ADHOaknL+rTBr1U2Eb/ClCdYGj8sqz6I2E9QHpghRn8/IJjfSsqyimBkLkUFaOHPu4iBN98fhQ0NiYCl7QeE8thtrm8LJAw41+c6ZVbAjHxpyuRdlgFq5AiXk80bGxDUoiWkwYnegOPyk/v2UBTbYr52mO0QuLKQfOogZxLoF/6+KP2a6hETA9ntO81EVIife62Yr0IwhsBHnWQy8dSSM3C5WEznM1oNrHNBhmP8QLMZ81LK6voF8VvngUb01T4h2ynwbbRbGfoXGdkA6QH+PGhUnS6E31VQIOC0/nqMusqvparhzP1Pqc1yG8LLj/tfaOtbCwD230XjMcoaJ3lzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDK4qrtnr5XVTe+ocNEiDTpD8I6wdwaixxJbj5SM/h4=;
 b=qPY0QgspN+kt40p38NCGhKemvJyV0fy2nvPM9+1yOzS51jR7xTGrRNEWbKBe5B/XWFSbK1W6Q6ECFn0fTVxuQTjAE0g+0nPgQN4VewqryWs4QHesq4980vXonH3w2FLTXoMiHsOEXa03BTu8pxHpmTcxzPJz2shpXHwsQqDwI5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9997.eurprd04.prod.outlook.com (2603:10a6:20b:67c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 23:09:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 23:09:51 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v6 2/8] dt-bindings: i3c: svc: add proptery mode
Date: Fri,  2 Feb 2024 18:09:19 -0500
Message-Id: <20240202230925.1000659-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202230925.1000659-1-Frank.Li@nxp.com>
References: <20240202230925.1000659-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9997:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c3e499-75c3-46e1-e93b-08dc24440f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ycFaO0ReHd4Jfyo6y4wWfTqmdNpyuIvSZ+zlGf0CwQh+9Pd5P+dca+l/dvp0cZ/NnBXbVcZzzJkeGCKhkC7o6N2xaPfBfnw9r8Q/2G+ylcDqcmlLqozSv7NC1Mc6TboUiT/ggvase/VfCImjz0ZPL5rEF5CXvgqJsRk1iHauJQCzNrcPSLs2mmBT0XOEbFh5h5tveOXH7IdpSr5hOZjkgU2DRBT+akw7bIeQkBO8Yzvno2M2nqzD/2wwaOlQMIum99S/B9zOQ+7cbaz1/atNjbFB3/GIoihxNkEHONRlkyiKJK9pYAxIW/kwFv/lgq7E5n8JhWoO9sKQbicZUarZ+tAA4qxWKl1P0am/TnQtjZAzKPHlGNqLiZb4DkQGzqiL8HJ7ZrU11SrcP2RCgYaOUAGxWJ8aZiPpYml/HGnD8ssppIFjruxnYJiwDjhC8gUj8x/nYQ4ph2XxYvP13bk6XVZxvm3sVS2oQ4/RXY8SL7dAuWpXSkPVD7wV4/jqApS2ckggEBCxSnkxGNai9nAConBRBBZoQJ/fR/Ol9wpK6QRDXhnLeNQg+PFFbDeM1r60k5LTZV7cwoT9WbMMWq+M15IS4ErsgsPOFngo7N0BCpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(1076003)(41300700001)(26005)(38350700005)(52116002)(7416002)(6512007)(316002)(36756003)(966005)(37006003)(6506007)(83380400001)(6666004)(478600001)(66556008)(38100700002)(66476007)(4326008)(6486002)(2906002)(86362001)(66946007)(8936002)(8676002)(34206002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kbWFu61svf5ax4arVYotsnKcvRCMlFbdld2joycmIKUHjlUsVqvCmq4xjtHI?=
 =?us-ascii?Q?4BEPMQ7yZVoNudbKqkfSFtMjaV6ewY0DhLDMcgLevCRwAIfHWS0J2a1Q5YeR?=
 =?us-ascii?Q?2SxpUHMv8ELehAF5/c9oQaoZNEtqH7TGNaOgWQ0g+ShY/PdQNR2K148kcrCk?=
 =?us-ascii?Q?LQSHBg8ZvdIhkXHifHBdc/Kl1rWvAc1EDOY8/XZiUxib4q+Wv8Vu0wepXEJq?=
 =?us-ascii?Q?AUk9KKCs2JEtiQmmlBNBSe2i1j6Yh80t9LD8woUD9WGdX/Y3LbqxtOvbPzUT?=
 =?us-ascii?Q?/cahttPnBJoTJKF2dFu+nNSd8IgxWw2QCJ5VWYLTMWyIkecW25igHADHAC34?=
 =?us-ascii?Q?Y6b/ItVZgT5SrmvCPpnRDqFBo3zDdAusTPYxn6+3sngEjra6gQBjQEjAcyCu?=
 =?us-ascii?Q?xxUVePJLADowc5BqvPNDu646+pMbkfnBKj5LTmXhKhuMYZg2hwJFLasCuheP?=
 =?us-ascii?Q?nIOicMBiPmrKWaFnXd6qRuwIZKyxt/fZtspVUsnBtihlWKedDtBbJE+Ll7Fr?=
 =?us-ascii?Q?y7zpOF+7vyJZ9EbvkDYdZBDJlXvnC5MpXDhbaQhnCek0DpI/p5NFO5qpVwz7?=
 =?us-ascii?Q?mUcBDp/UelU9e8zMNzUGmpgjpxDN4y0xcrIBoEyhRo1V0DTHDhGUugOMRyUQ?=
 =?us-ascii?Q?pThPPnNMO2cUWZJwwnxv11NHFEjcFgzWHnrw0diWgLuL6e8YHzoQPj7a3kBK?=
 =?us-ascii?Q?2qvg2uxCVNg+lPmKzsbvp1uevqbUpU+2gY6A+nbj57syNBJBhd9L9M1VkgMr?=
 =?us-ascii?Q?clBfXvPmghrjQmm/fpqIxYdS3qAX7ItJpo8XlUYX3n5z63GLyBAp4MzU6882?=
 =?us-ascii?Q?SstnhjOj6/t/pB2+oCJTtLYeoyUj6n9KqgFlEiPXnyZOInG8oAn/LptMMfHW?=
 =?us-ascii?Q?qd974joJyncDZNiG6ygyPOp6T5tfsek4x7SjcMj73EDcqQWW5vb77GbEEXHM?=
 =?us-ascii?Q?1xjW31iiWt/M0zEsz8fob47iiSeMYArzpi4ZPzNSliz1ooono/y4C2MBsBlo?=
 =?us-ascii?Q?paVV6MOap4NPmfJ/SCLiVpqL6PVRh8xdV0dbPut1bQix8F5qzjK0/J0YM4CG?=
 =?us-ascii?Q?HyvSo2JTZz5a6vwcRmXsGeNGaQxJECXDEsCy9KQKxHZ3FwoYw8NgOCJ6Zj3u?=
 =?us-ascii?Q?rITXEQs7X+TXyVBBa/+fZeuqJcX+XTozrDKrihmNw6eYRxO3qWlPIvIM42sg?=
 =?us-ascii?Q?OL0ois3lWc2x9vRgLrf2INVTvx7wp7wMH6J1vxIGM1QwkQggHlMKqxhCP0lj?=
 =?us-ascii?Q?JKnLGevFI1HF79AKqMWGKJ4+dS8Syxo10qoWRe8CVbugDo4Is1QPBaKSdKrv?=
 =?us-ascii?Q?1rCsJuyqSMlEvksqFfOgGJWzdV56Wf4ue/h0+vhw5swqzM1X67IaE7PAsLWK?=
 =?us-ascii?Q?W1aoJYaDsDQisnYnki86k/Rdb6I7/8xy18q/h6psVi3YXjSMoYfjCWBkVUBh?=
 =?us-ascii?Q?2UTnDuOOhJT52ifvFn8NbpRRLLgbfKCTUP/fvqXZThjq+HdZHIiIucQHUFdN?=
 =?us-ascii?Q?dNKofnCfbnbh7Be3hH4aqxsJ4bsML1/e1Guon4JwSMUkaqlU3l9+4fgBpZYH?=
 =?us-ascii?Q?s2JOsayEFEwfyVGj4JS6OWh5a1gs2veiKPcPhTrz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c3e499-75c3-46e1-e93b-08dc24440f65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 23:09:51.5690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: US1NvB4p52DA5e5b4j5a/D48E7qcUwZ0heweyzixp1OY0vMN1CydUp9+/SO1SaplFicLU2LE7bnr1BGipj4g6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9997

Add 'mode' property to distinguish between 'controller' and 'target' modes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - add Krzysztof Kozlowski's review tag
    
    Change from v3 to v4
    -fix dtb check error
    
    Change from v2 to v3
        - using 'mode' distringuish master and target mode

 .../devicetree/bindings/i3c/silvaco,i3c-master.yaml   | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 133855f11b4f5..3af77d143f018 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Silvaco I3C master
+title: Silvaco I3C master/target
 
 maintainers:
   - Conor Culhane <conor.culhane@silvaco.com>
@@ -22,6 +22,15 @@ properties:
   interrupts:
     maxItems: 1
 
+  mode:
+    description:
+      Tells Dual-Role I3C controllers that we want to work on a particular
+      mode. In case this attribute isn't passed via DT, I3C controllers
+      should default to 'controller'.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [controller, target]
+    default: controller
+
   clocks:
     items:
       - description: system clock
-- 
2.34.1


