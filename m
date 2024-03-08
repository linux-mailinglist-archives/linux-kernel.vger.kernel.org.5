Return-Path: <linux-kernel+bounces-97292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17787685D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5C51F2232A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C257865;
	Fri,  8 Mar 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D+fYz7D+"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103D4EB54;
	Fri,  8 Mar 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915175; cv=fail; b=c33xGe3/geKoK+HugC6ibcPKt02R5E7HBBHU+Bqsy9NcvzMZus0FUsErxGKcF05XKX/0yM64rZ9cpdhDN+FtmllTs3FuGNhNpDpkiOyqEeCOf+Xon0zMTIfwpGQfyPFRaGtTwwKZjI//jLJmJXlHrZs6kQCrUlWTjHklhrwIBso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915175; c=relaxed/simple;
	bh=Pu2py3MzeHWKZMrHR2Zye8AlThfwK4m0Da4QqUYO0w4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuiU1fAR3NXAwgmT521hY8TRp+EwwbM3EJ553rCiJHHWWcT/d9bc9RRK/zweG1O0K69TYxFARytSa3HXuftmU9rt+hilkJEYonoLH8blvWDLFYqtICMEnng78Rb1VqpJumP17Gkz8FEudJz5wrWx66r3JJ7Cb6vP3btKu3lzARo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=D+fYz7D+; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgB8IY3+N+BSXVAp/yspFIA2dVIjwM6TJhdlDU2dxJVWk4mfEyS5OQXVhCq2f/L2KoDRGzXJG8gMFCH4ndKKTF/5Co6RDVvbB+7EIaEVwV3ehNMzbuNaPJBLggLQpN2RT9Y3wryD/guDoBw89qRqW4NgjDamgdDb2t37IDZIUv2FprqBCdQE1ceGpVeXFAzYJ3mcOduOrMR9CE/QjHkHYoRp0ueG+Y1UG6eUL8v1tEeu1O8TBBoBU3bnOMqbS3D/uUgfZ/RFULkBtrkvB/mnNEoNiJGqcYvTuivxDNVj7n9AcsaCfdH9E3PN/EeJBf0xP11Xl1ChNaGb5dypR1DI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcoW8o6oEq2d9mnm2NMy6isoGC0GF0nEtBDeGxk3UXs=;
 b=jQWJarThTFZXkd7Wl9qWia6ml9Y5EU9RSzI3X+vvKuP2lm1r6i4lqVnVh6iweUY9uFnYzkPzvsxyY9cmaVcJOWpvW3GWfeeHZo9WPmC43rqIkXVmkc98Jgpueig54/p6VhfRUryYnKTmpRxdGaVPUaBx3qWHPF4V9sDXyELmkvI8WZ/zJLAgUJT6N6u7LfVmf94GeVwp/Rc6WWdJJPoTv0AdYyn5qReJTNXD/yPaN/efJXWM32gzoa3nK9wNDbkxCVgYywh200n9G1YKBFvtbQFH087tf+MfNr1J2w7kXt4XjxL5vbWpuudj4VZreMlk6P+ML/MfUZthnIT7tXPBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcoW8o6oEq2d9mnm2NMy6isoGC0GF0nEtBDeGxk3UXs=;
 b=D+fYz7D+ba/hPrqfb/NA0irvaI47bqgEmoIRjPlKQfEcnCBzCuB6fNoBbZdgXB/emP6zDb8xdxQCo7mo0NJDuBQcsW19A9ZHaU5x863kvhJZrf0sLezHBbTMk+Isfs5mdhDWSvs7oykt5xknYlZnsGSKwO1o43w1qWmpyHU5ISI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 16:26:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 16:26:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
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
Subject: [PATCH v9 2/8] dt-bindings: i3c: svc: add proptery mode
Date: Fri,  8 Mar 2024 11:25:12 -0500
Message-Id: <20240308162518.1615468-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308162518.1615468-1-Frank.Li@nxp.com>
References: <20240308162518.1615468-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 2faac0fd-ef11-4684-207d-08dc3f8c756d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J+0wbNqTPiQscK90j2WgBYq6Z2P2l3VgqrMOXnM9FD1HsEu1Y/OHWr+YE1KK+wU7nk1FeNITAZ7SLYg+w9Co+/IrwFKO0ttOjQXX2oHx86U7FnNWai+9ms6RXiP80ayBb+/vXqX5GBVrmLmY6WewOKdBzvAnuMPe0fWFVFrYh4XWa3wIqepU5ZsAixwaPjllpaVxg7EJXAt8svjKL4wRGtOqZor6UUwNu9rcNUnjmvI1Mcd0diIMx+zv5fPQrhnXC19E121FT2MUEEl7EeBAlvr09bncJrpeWkCxU3CahinzbdvHE42k9TcmFnxQlawXZzFThX9ollvzQbOA7OShMP5BjP/AEQE1d4+xTJx6cMmEQkU7SUSf3ktAniDSqQJ+oRhvWRsyUNpHs/C6g9vaMCy/nvzBKbtrIFv+6VXFRgGG/Jyf9yuApYvPw4lZ5XLATtNbOKft+IwDOLLTCv3NU8ZaA1fz/uLEn3+VLdtYRbtzm/rZk8iyAEnH/g0ZJ+pV3K2g8sdA/xsLhixpPbxCvSXJdBFpqiOeKBmh3CIznxhcVCCyDXmDK3R+IvcZYP5Bl4+tUsivg6B1FyRZV2B2kTfYMcH3RFsqzugY1miocQrm19QBT2NBl2hoi9Css/JrmBqQVhhkjpUkPGXBNnUH6/cP7UjwL+0dGF0hOCbVy6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uO+WGrYARNVSZq3Mutd3axzQhz33/qiCcXsaIfjVx9BZP7wZsRWBhaAhOXKu?=
 =?us-ascii?Q?vq2kmRR+NICKZzjZk72UY5l9kd87qp0t1EzYq6k6zVdAHFHpQ736U34QAvbZ?=
 =?us-ascii?Q?aP4O4A19wgbhpSGHTY1x0TucsHdiD/ZkYk0IIV0epbYXtKmD7X/xM7l06E8S?=
 =?us-ascii?Q?pFCgxvQySHmuxw+VBqLQNFANuKLmeEOu3dSg0hyUuxX0N4J+04sxEaZU31iI?=
 =?us-ascii?Q?kA2bLAah1rKkplDRG+yhpdgbQPwqM+r2fY0ygJRfJT1tJbOg5+6GcFeVJ8Nz?=
 =?us-ascii?Q?EVc+/6dCyx9TAQx8kncQlsmfKJa8X0p4aiYMiLZGB5FM1sLT7uzPUsjN8gWJ?=
 =?us-ascii?Q?P7g9rH8/bgTPVIESE1s4BiT4oSgeg1qbRcdWW0SSviqv+6vcj06vZ+a4MZb9?=
 =?us-ascii?Q?aFgrONCF6EDCF4JA9Yohd4D6YPDPD40IILtHeJDfc34tog3BvSlkOU194mgu?=
 =?us-ascii?Q?G6CP+1SMjiOLFckKDzQAzEx9Xy46BeJ0mvhz3/mBOVMUQUux3nsf8DZGO5Gv?=
 =?us-ascii?Q?8bfiKmVS0bDv8cuGJyJr3GD03a1mCqh5WU/PP+fgIxhLJJ/wiTfLK5RD1Iyb?=
 =?us-ascii?Q?zuMv+cxNtpY9i6XB+PwfrqzPigT+h14TS3LGrSFRlhcBqOUshLW3RRxjWIal?=
 =?us-ascii?Q?jUvNti3Ajoz2/xwhFT0uG6Aoy5sk7FDklNog5Z689rQjcmEriY0N/X5oo/7s?=
 =?us-ascii?Q?0nv4TuIaMJzTjr0Eh3dCFi/irXaUaklgRyapUO4G/TG00rQUr81KHes9Fkag?=
 =?us-ascii?Q?eRE7zrL8xsKweeXeGD1ghwIHNvnQnmNDgbPYfVBNNP2Wpbuh/G9RaAT++K0u?=
 =?us-ascii?Q?9BSbs3hLXvcnL8u2Ff7QXvl1aF/yoiyrBc+pk3UfOpZEgGSfmE6sIafaP3ln?=
 =?us-ascii?Q?FRtYzLUmAlo2l171wyoE9UCEyRwL+3kOAbB2+4leNGVYIrDrNKtac5/BsHys?=
 =?us-ascii?Q?yZXRcT5JxHEtapGrmSAZi1Z66PtBN7yWXrzBt/o7NZSc+UMSfJoJ0ceC5apg?=
 =?us-ascii?Q?diYgQ1q5asmTE+CHMiI4AtM8OjS+TbuCbM/vqrZ3Pv7dYhiRg2h/A66c5kjM?=
 =?us-ascii?Q?Ya0CaQ3cHUh4jh8KCvJ2VEodxLPFuQOnS9zW8XzzTFyrGBhJ4O7L+1YCJisQ?=
 =?us-ascii?Q?QvSoEvy5axlpxi8nmoEM8Bqn5KzdYksvawR3qZRtHAGU0gZOeseRUkls+YrY?=
 =?us-ascii?Q?L8thFM8O7CxnaJJWdk7+pdeF/xrbIydSudIV2fLbvgC3iSYz/QphxFQoStfM?=
 =?us-ascii?Q?4T5E9sRS9oYPz9m8H95eyPcH0UuJ/ZQdmzEV7zRfArW8J4NoK5/RhSeaX0mM?=
 =?us-ascii?Q?sG7znkjWg5OO98qkOxgkWipKXCskPXJkNDP3gP2mhZuNtmEnUJaGJwxMTHvv?=
 =?us-ascii?Q?MX4dZZQ0zFejbmV2JylPOWfis3csV5tkx6xDw4kDLUyu9QMKfCWxJ6g5tKrK?=
 =?us-ascii?Q?Lc2TZE4fvUNrq0VEk8/HG4NZnklWTLaWMv3u+ZlPFq/DG5GFN6UJpXik/dpq?=
 =?us-ascii?Q?l1gwMx0Oj2e3JW1QkFtVu2Cq2ZXhgLBrMvE/pX82xN4I+pqgZNsmQ5W9K/LY?=
 =?us-ascii?Q?McHXfBZk0KjFaWcquOmbEnOWZHX2Km5CzBwvIpPC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faac0fd-ef11-4684-207d-08dc3f8c756d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:26:07.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syBfbc9UOKlQ3TUV4OZT4FhCGmcUWs/6ZR7KdIDwYogYBVtYdDzUjSdPLZucDKxB5GgeSpOWCFWn44fXq5OHNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

Add 'mode' property to distinguish between 'controller' and 'target' modes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v6 to v9
    - none
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


