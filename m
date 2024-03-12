Return-Path: <linux-kernel+bounces-99997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E959879079
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14F51C219F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA47826A;
	Tue, 12 Mar 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CgDszee5"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C06997B;
	Tue, 12 Mar 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235020; cv=fail; b=GqCJeqPLJlLzW7axlqiAVaj9kqU64xFjiIECWhCHQ0S5Sz0xLBdxbxbRJ0N5un0xHmR41NB/Gu1lhj5D3NYPD6OrJZgiurfzXqyp93zq2AXImYnQrQQBpsCnMrDXVPxowC3LPRb3pybrV7oTzVUK7+0kDHqxLIjaXAtZOC64QS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235020; c=relaxed/simple;
	bh=kUcXiNxR1qeitTi5ck+dOw2KGHL3jlbfl0978ZtRWnA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kYLa8LoVfWqzAm3nB8OkNspL3J33k+rindDDTGQUpjG4PhFaIKKB4AiidOEWoOmk9n7akNo3Il87esPqX4SxHQ8H4lWJnMoag4JuUsI8GJHT0WSXnFBAy5RF0/elZqMkC7vF/5vDS+mSRh3Xc6spiiq2yAAmeMcZEeTN1ihde7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CgDszee5; arc=fail smtp.client-ip=40.107.105.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRv4rVFWoYd4QZjZ8XUC/uO+oTGCDK07ftOGxgVyfeOik7lU5iRQRCNKK0OC7s2pVXOrN1kyFZ8Wbh40bUdu8cCR9SE9hsuKCh16KCMQImvnyggEja/CkYKNN60O16KWGxKaIP5+JY/WfmkojTlSd2gL1Y6m5gfAROc7cp9x9YT1WQgnsiyMDPVp0pxDHee9OkNrhrx4jmIM/ogbqeAkx6HG8jP8yA+zgAMlYc8xMPSSUtOTPtazYb46y0Ebo0OIrjUwfd1icKr8JCmIX9MLFKzRVnEcNEG3vMNzFU1cvhbQNJJreiofCzjj+bDWs2MlEpOQXR1Ie5dEwvhkMErm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlzOd4S4p8gXG7ZgEdu8HKJHotz0OIDe3L2E9fFsOp4=;
 b=lUjvndJIUuOtpklpqCLCQk71uXJRdZ+6iACpQxsyVHLJNwieiQahKp9TUwV7cHDiKeAL34wkvW+J2uBW7ZO0XsApx8Ih3uceKmoLOrMr8ivoFT3MDmYEg7p8WSbuNM2A06OKo10gFhax8ERxs/KrJrxUrPLVEOSiHLNvCKNXH2aTH6AoyCb3rtSUcnaFKL8usTlsePsqVA1r7rWwvWHLsPJr1MAXAnN9Khzeg6cYlZof/XBRCd71WxFbNKkphnijoGkpT1x9DqOSjcFFUnHyHh6k1FtslfMg+P+GxBtPrijbwev/GgKJfcpnKlQfAyeZsXo/hG5P0jDXMULIBhV3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlzOd4S4p8gXG7ZgEdu8HKJHotz0OIDe3L2E9fFsOp4=;
 b=CgDszee5OB2sG5mBuMXkesL7qoYV+GnQLKeMZMKoZOxpBD4NFGzKtkN+gYKlbYpiCNXTTW7r0DTY3AI5Qc0iEqRkf6b+PRZNjSorWr61XYs3qmDTJ8zv/mbsOfQOSBio108OyallCi05jSo/vv9MMDDKkdZEJYoQ9r8OG+62+/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 09:16:55 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:16:55 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/10] dt-bindings: usb: usbmisc-imx: add fsl,imx8ulp-usbmisc compatible
Date: Tue, 12 Mar 2024 17:16:54 +0800
Message-Id: <20240312091703.1220649-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: be155ef1-1013-49ed-84fa-08dc42752948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AtBtapKMzeUp+HP6CX1qGOJsPtspcyj1duePVHUYBnMZuLTfEHbUfz1LQVi9WyeLfQTfGnXpRbY3oshdTifBFctiILLyHE8xy92lBQ/lZaiyQyiDlvRDgD0uqrP0wiGNIh+6JeK/Ahsr9oimcAGpUOZNldaCeDTCCwpBLOjD7ZR/1yry3Oe8aChm9EC6sSNrI2/yx3pSTzlq2HZwoLwyuUIMyj6THO/9/KFSpM09DNwJ4XSM5Aqb5vGhxE7EoZDCvmnkdq2IC26OrzuGygFGjfxqt9Q0ARPld4WRyEjexVEtiCkTK1hQsKxXZYmZd3EewJo+4Z8Xbf7YemEbDb+K/mxGLTWuGocNbNSSAMPjMWlKfeVdcXI04cb9o6jfJYw8tzy+mJYWvuh/kjD/Fdbp5vuz2VUoECMuNI8KmOaK4mCn2Lg3TWH/Ug5lDdKQO+SMWNKGINOaS9TcbbVR93l7xItttH08zpPmFx/R1aevwnudHxiU1shx/wPh9ZvHMwd9srIHVapXXMIbuzF/J73tzuSROc7ElEHKqxxsXbyEhx7yZJh2VRD3wcajEdmcfYLLk2ASp6DD5G5CKRRl0d+8Y4tOHLhKZmfjWYTCfntXVwrdPy9kk1d/Y30PRf5adVnxDT9zGnzhDHpOMXQYPJuVolp6u7uV9cu3GNQvOyy/0WrAVgDxtbBnlZfEtl23CcakTspVLRQrmuLi0tsEH1ga2Iy3HKY/OQcKdh4uoX3jPAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8UBOo1Y8dwm0vDlWNW9ILzfvOOXrmQb+j2Z6g/SmULv2EcEWfNn6o9tP712E?=
 =?us-ascii?Q?R5549kRNKb27P14T3wN6LZahW66sTzHCnBF1XlUgwc9HYlSBs6TYfXAQpM/d?=
 =?us-ascii?Q?ft+q3DTGu2+VOqfTuFYxz1sLOnwHpGjp3QNe6Yo3Pj2W/tM4vjUU8hW/r++I?=
 =?us-ascii?Q?Muxrmq5hExeXvB9Z8wq7regLQ9yGowdfG7RynuWL28nnx8cuk1mUv8T+KC4h?=
 =?us-ascii?Q?3LuBiDQQFlcl6ajSlr57FwAlFn4czY1McxxsJL4vfCjV/TmHD21fwVCa7mOM?=
 =?us-ascii?Q?b2UcYxOMTA/oKDywDoS2qbBi9LlM/cF6MjtnUiUML4C27uBa0h8BLk/Hj5iJ?=
 =?us-ascii?Q?OfynRQ1fBI76jn555nXCxjyPNx9LvLdjQ0ITM41kv1Rbo3Ssqkrwm6ZVTS1N?=
 =?us-ascii?Q?6a4RkJ5llI0H1ARP56HsGSHr/AwwRRBWAW0UpjiIvhbWWuLQxMKZKDD1Eu0Y?=
 =?us-ascii?Q?FXvYhTn0+/V+BDTJhiluGs0g5yc8+7j8kd7sOwZ4Ety6UyB3E7jk/xFWmvI/?=
 =?us-ascii?Q?CLM4X23p2ILANTQCaGuEZdpRSL1yRrrEn55tdFH+b68aGPavgNmk8KCxaGyP?=
 =?us-ascii?Q?uc2xVnZcryjodyr4z9apJZJ9t6pdYhB+okfPU1Q2bdQYayaWEyj0ftw2Mz4C?=
 =?us-ascii?Q?NpArOamcM33q1QWaAe0MQM4g2D7JIvB3DmqDl73Nv/WdO1KIW+6dP/sPEnTy?=
 =?us-ascii?Q?yDu3L2FWGB/lpmH5DZnw9AYCRS1DnUe/zlTXPIBhPpackNU5HGu/ihCSlF7+?=
 =?us-ascii?Q?dNEC5t6XKYENb/UcPARHxiABzR7DxSq83iJ5rHST3yox4VRUyHPOw4dcgRIK?=
 =?us-ascii?Q?qy3nJnbFFCCPx6/FUR4mRAj1Dkb0saf+9/gQNJ/I/VkirlGAgNK4xZOJtWMt?=
 =?us-ascii?Q?LgGxJ9GRau5JsKUS3wnZ8J/SqeNzjdM6G2kCjBmCxzs0hAvpc8lRQxpJWWib?=
 =?us-ascii?Q?Fnh3jjUqXlo7RQRs3i9EB1uN1WLpsHuUk7tMZWocxEH5O5c9Q4GOr4mQkec5?=
 =?us-ascii?Q?yzL7SztSyPsZDf36en/xaoanuOoq6TxxDkz+JAz4dTdcfM+rSRgEyQQuUCKH?=
 =?us-ascii?Q?gPArdgBSZd25mfaJOIXUAApx/vui1brAtNttmqAvzmeRU3OeV6nD65vd3xPO?=
 =?us-ascii?Q?FENkfcNRSL4W0T3MCtag/1ee12Ye0k+j8p2BuJcQvl5EFE391djOqQJ69Mnv?=
 =?us-ascii?Q?IyseymY4tar7MvUR1cXGYTLYwexaiuHrTNq7ySS5f1CBDXxMfZ32TRZRsdo0?=
 =?us-ascii?Q?UNMEC7pSAy+RvJaE8/kBCNLd9OTaffZxjqp+40imTJ4alGIPDDCAP+83rk2L?=
 =?us-ascii?Q?rwF9v12SJSk8njwMuxoAdJ/Pwenoq7evgLs2yHTFdMmU/diVU0HVIz4q8Pe5?=
 =?us-ascii?Q?ahGFkPObCObbFvh60eG9vugARPeCEGiXGKndkHSWBmvrWpDqi/ku3cZf7ANF?=
 =?us-ascii?Q?HXFvpT3t8BCpwXqQL2ILR9+uUhhdOKJI0u6RAElaxrFM6XYW5eHLPK1dGRWV?=
 =?us-ascii?Q?Cd051GOFzy8dLQB4awwBxpZ7lExbl/E0rVrJDhlsHQZY5m49pueYu4xZ3ljR?=
 =?us-ascii?Q?vYyl3Hxig2assbp0yz0WGcz8qlWxuw9OtPS9+8J4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be155ef1-1013-49ed-84fa-08dc42752948
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:16:55.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGiFxBNPPFtW6qxrZfessU55KCqy9NJbwq+acy7/5UXKMwrM6WU4c+IeEKwtE1Zz9XGmv1Qz16iyFEm6sPMX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

Add "fsl,imx8ulp-usbmisc" compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v3:
 - new patch due to missed this little one
Changes in v4:
 - no changes
Changes in v5:
 - add Acked-by tag
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - no changes
---
 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
index 2d3589d284b2..0a6e7ac1b37e 100644
--- a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -33,6 +33,7 @@ properties:
               - fsl,imx7ulp-usbmisc
               - fsl,imx8mm-usbmisc
               - fsl,imx8mn-usbmisc
+              - fsl,imx8ulp-usbmisc
           - const: fsl,imx7d-usbmisc
           - const: fsl,imx6q-usbmisc
       - items:
-- 
2.34.1


