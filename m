Return-Path: <linux-kernel+bounces-35690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F165383952B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984CC28C2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4A8612F;
	Tue, 23 Jan 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pctwk/L2"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567285C58;
	Tue, 23 Jan 2024 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028183; cv=fail; b=mZsgCmRvSRZNb04pcjkiPyLlYw5Ds2khK/0TnsNwTLkzXEtYwwi2m2GEdCsgilotPsSszZ+dUKWb8liKEqPqcy+S6V9zi0yPpDq1Z42Xcw48Ltg4x6CSYeGoDm21sGU/VqD9Mrkhikf5mgveAI8w6ROfv/apKzOCdLZqCxl4H+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028183; c=relaxed/simple;
	bh=mxcHtkuXf26AVKUZaU+qLwz5dPyB2PaNogj4EjGEECU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sLDwc7PdzsyphCcxN+xBifdku2aIxghlZmxDjTFPJFEBedIU+ZHuqzPmM5R8RTAsv/qvfwo+jY8HD43nHMn4sYMnG+hkTSn9DbsbSflM/hr8FG6yHIFHSzYyWLSLdxKMXXzugvF8J1I1Zb0z9gX4wSrg9ixQGy6WxLMfGUTfitI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pctwk/L2; arc=fail smtp.client-ip=40.107.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNiQfq9joQhKcgRjh/aCXnbfgcSsadWLZyEKNES4wDB59ImjiYo96qdX34dKuxMx4sZrWtlsGb3eS8fGn/1AAZ0OpJg+yZSeUl1T+nmIlpHffN4CwyeXg2v6g14rA1Fwn1rMLFZq2wneOXZso0cPfGbGkw6PRsiymFwQq41F5WbRjhNpswAKOHPGFLqd7ARKFjCV07Oj2vYmH/72M+GAUVz/9mjHMN+ygaLK1rthuvQnInWX+4aHHrSn9XheiYpUJ5NXK+w64WuS3NiKy2yqrON4xOVZ20CX6M4Jn8+DByd6DOK/2P2JeVsMeb0In+MGv4lVIY4TcoXs+loFCtU/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX3gDW2DtgtAqALYPPOYNP0q9o2+DhzDRbXP2yhukv0=;
 b=P949y2L39LgAKymdINa6RxQHRh9d0nmSxZKJxbl9BWp20BVA8DNh7U1ugM2NipSDHuBOJZXglD7/ehAa1P5UU6qVGsY90KQP4MW9OBj1jxXN2l6HMu0hnU/DOfKVXD+7EFHEfMAG9ekc9WnMElIjB/TwXuEfyp0ftwY94Ta7/dvbQJXeMpzaA9oh8g6Lg/nPapbLBB9Zsa5g6DnvY30flt6+wJcRzjRYifk9HLg3vy7LYDj5jnUP3UA815NNeoyeNfy68rFWWsmD55tC5JKFNgkNINiHQiIKCB81g8Kqc9JcB0DTlhbx0Tdy5t0F5k4qfqckJqvRhmbpXnbpvvjr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX3gDW2DtgtAqALYPPOYNP0q9o2+DhzDRbXP2yhukv0=;
 b=Pctwk/L2O2Pi0xXy9YW8+kPxxIvy8l34H2cavtjzqQRorqKRVee/typanLLWfR6CxUiGxHO0Hebzd2GuZe6Vl8OHxXkctySkEHzpWzHl0l7g7i9gHbaVfUaClNUErJPEfF7aPH6UqmScz26fDb+vZhKps28mwD+PP2CtSneWHuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 16:42:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 16:42:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: thinh.nguyen@synopsys.com
Cc: Frank.Li@nxp.com,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mark.rutland@arm.com,
	mathias.nyman@intel.com,
	pku.leo@gmail.com,
	ran.wang_1@nxp.com,
	robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com
Subject: [PATCH v3 0/3] USB: dwc:  Add workaround for host mode VBUS glitch when boot
Date: Tue, 23 Jan 2024 11:42:38 -0500
Message-Id: <20240123164241.3689109-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 06af8114-0553-4a1e-fac1-08dc1c325b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	80gdNs8i8S/IHQoHFdN+RUPPuznCYhFFK3DrmeIx243uBz9U6FIky1W1I+4cH2bGJU5JX4Es1FB1IPVLBLiSCWpoI5RsRjZLr3Ih7GbTq0Z+T+nDW0WwSX/Mwt8IuA0awTULAZl4WDdZzp5gt+YsGrxH57Ij0ZXLnpiARpjHE01F+6/Z8ThR6nrLO1+1enyHCemlHAaGYMlPxdAApBZN8TbOTG10Qf+MZcJAAg9+Rr870V/WzaGAfOhSycgV/DwB5lmbM/UqtEMLkY3+4j8k1fDNCEiT77xz1gOJ0BmUE1rcAQ2N2b08atUXbdhnOnGtP+2NtBS5xmXlkro3Xcr5NA2cDNaNQUKqo42l8wtnXayPZ3YJeg5mG5oIvLc9fyOQ72RMViuNZ0Vs6BkWilwzK0a0j38NmWGoangSSxr9dUK9X1+hQoRvMOtrTYI9XRJfIjLwmq8ECyXoYKPIEMO2yICLVggJWVHfm//qQqUwEHWXe0texHMaFMevvtrK1dLdWq4MeVwyBuQQfBqfCmd34HkP9aqhhOW/hHQxHyY8b6w2L25Ul0zDnT8rqnjgOW/qNo3KNj2PevwXBIgiYiZgms7ggZ+hgq4ro2ruPxaDMn4QeRJb9vd468EqT794qj296cpETXabwa21vY6dEItbNbqanTlLFV53kjBOiEKTVzU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(4326008)(8936002)(8676002)(2906002)(5660300002)(7416002)(41300700001)(38350700005)(2616005)(6666004)(6506007)(52116002)(6512007)(83380400001)(478600001)(1076003)(26005)(66946007)(316002)(6486002)(66556008)(66476007)(6916009)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VF7DpORSIOiixmp0Xmw0//I+9hZXrPhBUWA2WSZlxveJWp2ukijCsQ1ce8/5?=
 =?us-ascii?Q?KBCo3lXPbaA3ooKTBXfyhvtkah7r82EuEJ253PJIPNor+hIw6a4wE1UQ2H+X?=
 =?us-ascii?Q?Umdn/XqkfZ800+lCi4yhekOPQvQEdRhLRJlSCrzZGLNK3muoaIz68WdxJ0Hh?=
 =?us-ascii?Q?ZKbCiwZHymyKzNakAw/l2EuSZOtnhuIxD4ghz3wazktplkNVr/QUXBtCdvlb?=
 =?us-ascii?Q?ZWmALUlxmrt8rmKN189tf0SxVTVGykIlFCRcwzbqR8O3ZKs4sl4vekXlwXZj?=
 =?us-ascii?Q?yvmHuVZnIMaxytDvfW4zvNjujV8E9pG1oJRzQ93HjaJaFamaUJn7INGmlg6J?=
 =?us-ascii?Q?sJLak2ANmLs74VAN/BDj8nYKzBBxwVJvSQDcDDvSzhk0PslUvdQp2qfbZL1f?=
 =?us-ascii?Q?WCUez3l+2Hs3LQ1HwLFMHKbXtBpFIji82SqfYgR5X3HhPtHF0I0/DP4kKIgF?=
 =?us-ascii?Q?6NHPj/tz+UN1eveYrfZmiQA+x0bsGZ24oyFX2PrspkuVSJv1X+8LfCZNu4AY?=
 =?us-ascii?Q?M1fYOXlFOm3+Pq7Cy40fyHB0hmwhz2HpPU3mJnd35YCKSRxpGLRh5hf3aSw+?=
 =?us-ascii?Q?LR2j1PLCsgbRiCsMd6Szxr8sqSfx1VPlEPAbGKfYnbVHxAf53xs1wnZMUU2k?=
 =?us-ascii?Q?yZIngWFL0JwaQtcy3sIbt8K9Dl0lo6KZQuV0bTNyoiXS0fMQtTdt+/7dZbS4?=
 =?us-ascii?Q?YZMSCfWIL3aoYvnjg6QkmFMEtiLzsqGlkfsQ7dMeo/oB4EZ5xHpSb/edLeDA?=
 =?us-ascii?Q?Gq079iT4N3bcXX7LAXUw/I96a+PrnnE2aU9czUApVjS7yp5prae2VPzQ5mcf?=
 =?us-ascii?Q?dlYFzz8anjvkFut4HKXBu2F/KPgMBqB4vQwXD7PrHXSNqg6ImUlCLk9ubsMO?=
 =?us-ascii?Q?P/7YxHcS73A0fZv6dqufcGxowqL2d9DJPuvF0Q12PBEThg8K87AIZRaJwYaZ?=
 =?us-ascii?Q?6fqtqdtlcbcPDRHPx/yOw0Gpi/ETUyKx4fTsmITzMxZIH6dH6S4IWtlOpnJA?=
 =?us-ascii?Q?pKVOD0yTG2bd9EGqUjLcU/vbhYx8xv/JLEk/yS9gzidRGpRP5dDY0Fbc3DSX?=
 =?us-ascii?Q?XwJD7yZaXKVIfLpnpF+OzGRoYlA29stEDOxJZfPt6XYUgy6mpPWOlNVeyyEb?=
 =?us-ascii?Q?BYkdMfgLuTbX4lfViApyGDn/9Xq8x9ZUt3WRRjdoHud0DEJnz5OuviTL+0B+?=
 =?us-ascii?Q?udO5XC42O0Z1uKI9Cu94ia0glVxV2x1NvaI1VH2Kgaw/oGEDAOruYI1oIlvf?=
 =?us-ascii?Q?HkSnQeMm6IufVXani+Nw8daK+z1fZ6mqE6WE+QxMm3AlBfOj9k7+7mwgQ1wm?=
 =?us-ascii?Q?6gS09vmnYVprryoORgyHOp8TLu+c5DwOv8qEhA5NeuAqAsuXRBEwnvWLuHBE?=
 =?us-ascii?Q?gjaU4Az/qx9B1QhsevY8nrue+wD0pq9z7Unm269U+n65GnIxQcPbCmCeOVPF?=
 =?us-ascii?Q?eRZaZHL1ejkCW3WOV3DiQiKt53cj2K5Sp6Py02GImgQV5mBdJRQeXAey3cBl?=
 =?us-ascii?Q?MS+422v/i9RfwYnvcHUw/zzZ+chS3pGHZ9bm0ebt7aVYy/hyXx+doOiok7wo?=
 =?us-ascii?Q?3/MHvr73qsqANa4VCnU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06af8114-0553-4a1e-fac1-08dc1c325b3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:42:58.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WKUDe/zctzKNsZAEE3ywJ6mmjWUqNPLiJKuFxhiSFZDgFyymqtQljA1+/ZYjhi9sbLxFQ4trte9ziBECP2uZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

Chagne from v2 to v3
- see notes at patch

Change from v1 to v2:
- splite xhci.h to xchi-port.h and xhci-caps.h to shared marco.
- add quirk subfix
- fixed checkpatch error with --strict.

left one warning to align existed code style.

CHECK: Alignment should match open parenthesis
+	dwc->host_vbus_glitches_quirk = device_property_read_bool(dev,
+				"snps,host-vbus-glitches-quirk");

Frank Li (1):
  XHCI: Separate PORT and CAPs macros into dedicated file

Ran Wang (2):
  dt-bindings: usb: dwc3: Add snps,host-vbus-glitches-quirk avoid vbus
    glitch
  usb: dwc3: Add workaround for host mode VBUS glitch when boot

 .../devicetree/bindings/usb/snps,dwc3.yaml    |   7 +
 drivers/usb/dwc3/core.c                       |   3 +
 drivers/usb/dwc3/core.h                       |   2 +
 drivers/usb/dwc3/host.c                       |  51 ++++
 drivers/usb/host/xhci-caps.h                  |  85 ++++++
 drivers/usb/host/xhci-port.h                  | 176 ++++++++++++
 drivers/usb/host/xhci.h                       | 262 +-----------------
 7 files changed, 327 insertions(+), 259 deletions(-)
 create mode 100644 drivers/usb/host/xhci-caps.h
 create mode 100644 drivers/usb/host/xhci-port.h

-- 
2.34.1


