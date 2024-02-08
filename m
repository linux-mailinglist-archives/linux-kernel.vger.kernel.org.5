Return-Path: <linux-kernel+bounces-58393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3336784E5E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C441C25FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784DE82883;
	Thu,  8 Feb 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OI5GbzEO"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2044.outbound.protection.outlook.com [40.107.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A7823D2;
	Thu,  8 Feb 2024 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411709; cv=fail; b=WrY8OsUVXdV7/2QOkvJarNlQ2eMf6l0lJs3LpkysUZ/MFOQ8ocYi3phyzRtW7fLwwAidACyr8kxEGCTUdW6r1koXiBog4eMqGSl2AilqA78nA5IgYORigfQifCE600srnc/GNLajqUUB2X9HsbyPj25TJ1nDLOVDEVCT6DQrCTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411709; c=relaxed/simple;
	bh=UleligJ+5dWLrDcWdg4rHYSCFQexdlcwQ9GqmxEeMXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CXDRiOBYB9OibTToikBI9mnNMMp0VPA4i1PMyQaz3qo7ghW3pkgCLRy6Bw6abo+nxPmbt+bF8b2CmIqgjL9rZB3DaUJXIl/T41EUwhX9jCGeGEUd3z/7q3/EI45mGh7P/zmEiPVpfpmH2arsxxAVbtyqe2aZG+THHsxKTxSr1zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OI5GbzEO; arc=fail smtp.client-ip=40.107.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yfom76iaAAn9jQRXerFbyG7+5Ft01e3LkQODOx5DdkljqaZpQqIRD83lk9+mewczLGhIFEwc52Sq3iYpujvFzHjWdNGirjIafgrRfzw1aCEJGZjufUD4alxd3HuYe9h1A40WZkrTQhgCQaHwnnYff3UqrMPc0pGnjUY+d0c8l9MQZHRKgcCrfCuZ+WelQWmUJJ+izUvDCHxlSdjnxQuOHxVE8otRxijpKsG2p8vcbo2TcVhgQFducaX0FFhATY1tYKTyorbiS/fsZWC7wATI1+3u0GOxNh2xV8gfA3fOQ90U8anUnqa77x8uSkjF4V5oL34XlF6jcOQ3m1Q24gMoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDK4qrtnr5XVTe+ocNEiDTpD8I6wdwaixxJbj5SM/h4=;
 b=RnQXix5lv52EyjYDghW6BcNelq48lAq6Y9cjMAbclXxXC745FUyXoMaC6gHEIxdGQ/jrenVswtdaISUD9a2b6uBnpgLlTwES+yWhZbFBIcnS1Sks1uQlKdXGVsLdopqEAtM66ydChQdpyivP2ZLXTJ0M53D8+Rh9wOU+EnnNvH+LtVfzAwBCZMbiTZsi218Rfjyt3rWK6/qx+r4Ham3pBvYAOY0pN7jCUTM6ssXLKQMuKhNUQzfj8rVjLJf18U5lAqncrtX5+zdA0znAlkKKmzoPCkor1tOKonpyoMivi2DAeNDl8MhzZqcDqCPL9U1w9B7GiIq+z5ho+MTdYeE5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDK4qrtnr5XVTe+ocNEiDTpD8I6wdwaixxJbj5SM/h4=;
 b=OI5GbzEOac6apg9AxhSyzI7gL0orfRfMaa2GigN33GPel304V8Cr3nnWvD7HN9uJ4yliU5ckeBWG+7unF7PzXyYpwIRp18nXvV4iImMwfdTFKjAEYrK2ZBgbddRjQgUjljSCk5HvsMm2L2779pV5GsIzL7sBpLiFrtzPwogiNG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 17:01:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 17:01:44 +0000
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
Subject: [PATCH v8 2/8] dt-bindings: i3c: svc: add proptery mode
Date: Thu,  8 Feb 2024 12:01:11 -0500
Message-Id: <20240208170117.798357-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170117.798357-1-Frank.Li@nxp.com>
References: <20240208170117.798357-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b15eeb-d6f5-4845-ee33-08dc28c7a0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t2RR4z4LncOnBh7EfPqRVfcTDT/SuJXDy3odGvA8ggvsImN5+1aXMUitRDareKUUe1smkRX0vaXx+XfnyofYTIqqZeUwmr0dWpWchjEfXGJYxDgDfnNVKJS6hSvCv+zvPVeFIevVSRwegRA+RgBR1mUnY/ktMojJt+TF4zAZefkQLCyQOL8SlCoepSnMhm0lpXA6K3SFRgJr92ytPBxMoKYFJHoJicE6kQQjNUhvS6u9vj4SEVZ4PNcCA1NXpJiTq6+IL8GA+BZfwKWfFCF3G1I1EY2OGIDIdnW1UmDnyZCV0tAy+sDmbbOYnRd+yO/+L8/yqTOtaraPaKonZA7IlnArs1Ll4iErwR47RoeuHZQ1GtgZvmz3+VXp15EItiGInlME8bpPqZMUYhDRpnt6hdaM4VhLMihRqRiukkW2H8yePvWrYjbbnHJyLEqQ3/3/UdomoshUWZp/7zRjk7h20rczeWpBeGPald574f1ExjE+Gjc50iGzk0NhRHnRrnln4pElQkhmWDiRz7Pjxjg+MzfcwIkQ2h+9pkvHIlQoxPdd7EWqIC8VMb0SxnDJCk1Zj+dGHaeI1YGY3LuOlYcIBWTglrTiiCIRyrLvHVyMK3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(6666004)(52116002)(6506007)(83380400001)(37006003)(86362001)(7416002)(41300700001)(1076003)(2616005)(26005)(34206002)(6512007)(36756003)(8676002)(8936002)(4326008)(6486002)(478600001)(2906002)(5660300002)(966005)(66476007)(66946007)(316002)(66556008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PhYQmYYlRZKYGtpRchv2uzgRg2kBtSKST4veaALJUA3GE6HTR0peByMBuEat?=
 =?us-ascii?Q?MVbhOeUnxHFxGsb6r3SVXZxirJejJlXeVggH1T1yz2hqGqiq+GtY70fBmh4g?=
 =?us-ascii?Q?f3CCVDNJRHeBrGtbwo3JaxwTtIidOaDTvLzofgnUe+BEEbL2M+qgTQwfOk40?=
 =?us-ascii?Q?wDK81kIg13wEWkVPT5rIuxH0STWVh+EpmRuxC8CNm5C/AtdUlQQNno9tiJRk?=
 =?us-ascii?Q?ejNjIRLwl/td4McRHfTbDLHeal/Wx47BjXPS3bmHefiDT5fEPkyN7MghCspz?=
 =?us-ascii?Q?gcIi47iTpnL5cHSEMgX2Ti0DcY0dZrbiTyBGobfUuKH5Qm0x5EU2stRjx+nm?=
 =?us-ascii?Q?2X/CcnRwF3YtZ+Jo0HPNUyz6er67j2dfhjfxwp+NHfUYGKkJBJ5SR1qGq4k2?=
 =?us-ascii?Q?KCVckVI73afgVAHwrdPfzFp7D9+UdpaBx6ZupVVPzoOcnTHW6j8JF0iQhdPK?=
 =?us-ascii?Q?heWc0DsuUF8V5m5l9gmmwLfOjZ4fqTNuLjEzHypZa1FdvlXjL6zrnAbJyMjb?=
 =?us-ascii?Q?cf6Ga92zmKjpl3P4RBbqpaCiQxoyyRAjqoCPy7qagZLkCZo9a1OBZNzkT9xj?=
 =?us-ascii?Q?IwSoY6aA4ZOQbhfROMQXLC5VXYlhbpo7xLwNw+AMk6yVuYgNcSVhn3I9xROm?=
 =?us-ascii?Q?OcmZsAqW7TT8Spw5MBV888l0WJ6c8qzreCwmjoeewrQ9QODPX4AjUDMrTSc0?=
 =?us-ascii?Q?Fyxop+qiFAmpPUAjQM0Rh5gcQX11F9U+zcGZEZpyvyIk5oQIKw7SGHEyyM+f?=
 =?us-ascii?Q?Nny9vN0Pj7CuMmdHVOF83ak0hJrtU2KigvvJwRCQuUqcvFzxmdKMg4DhFptE?=
 =?us-ascii?Q?rGJxv/ia/loww0F0Yy7kz7t4Jf4mb18HKvEbJGOCFFpD66yprp6geZRP68Fm?=
 =?us-ascii?Q?E3pDDu9WZDpKoOg5FoOeG/yG1yMEpiYzkk8gSu/3WC4LImZvxfoFEKcPKCT1?=
 =?us-ascii?Q?jJlBc6ruAJNGDm2pZCkdCx9tKKlWcc0/FDyd6U6EMxDwhFbvam/m7DOotUZP?=
 =?us-ascii?Q?GPpei2rFfl1j8VLF7Vxgr9wB680y3fsrtZoOESYmN9Sdk0QkWYNOBQ8143sD?=
 =?us-ascii?Q?53wCX1jJ2/d+dE9AMv4UXplEl5WbZMRc67584rpQJBBZ6kUlrXBYgmQe6g4f?=
 =?us-ascii?Q?Y6L9imlrSm2/pdkCSi7b45jA/vDhq8zLiCzAJgQ/oAvtjFopzm9daV7efgMf?=
 =?us-ascii?Q?rcVvEQuVK3WWEfB2gUUrrD39QIVchUaKrQNdzpPsP0vwJXWYB41jFwbpKBWw?=
 =?us-ascii?Q?SEpSJkLfd4/8pGIWHKx2Zz00Jtb8J8cjKKLwqMRRAR2S17SlETfBfOtOyith?=
 =?us-ascii?Q?HlOUKYSiKhPwG+RVejBKBpaYFP80uWekGvBWmX2dh3dG/ZAsX03Ho7Ew/XDy?=
 =?us-ascii?Q?e34hgvTlQIKy/aOnBY3TnLrp1Oo6pVcRiBcas2pC/jARN5n23o/EhOj4FKIs?=
 =?us-ascii?Q?oY2aCEhOuHXc+nieC++iuVdT4CZJ7INV5AAXNnQS6D8XJ9LWuTIzFAOaSG07?=
 =?us-ascii?Q?uTTOR0rYzI9TDldH1msnKacWpvQYAi3UoBzKkQKpVbMG3WP6zm/czAJf4+QA?=
 =?us-ascii?Q?u4L7ec2Xy5RASLpJlR6Ojb1CIKh2R6F0u96ttDgq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b15eeb-d6f5-4845-ee33-08dc28c7a0b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:01:44.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yjm9NSL8oYO0uv+nehDIpNaTH+SL+2nGzWirMLUs5gBjiwu8IFoOahuTu6+f7HL9LWzC3J0c5xtEPJMFmwLCJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

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


