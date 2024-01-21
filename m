Return-Path: <linux-kernel+bounces-32204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564DC835826
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652DB1C20FC7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39539875;
	Sun, 21 Jan 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kce2WTuO"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CF38FB9;
	Sun, 21 Jan 2024 22:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875898; cv=fail; b=ny2uUMOhWWMu9fmlsfA/UPjAVSt8W36tesipJmK3MIzthxkdfQHXjcPyKY1fPki1Ysfcg+GF1aSvePj2l6OZZf18rB3zOzlqoBWDJlZrEOYjxheVPoXXzgnFAvlZCw2oxG+JHTjT9woM04xIEUufK1zGzYzycZLinlcSP2vidjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875898; c=relaxed/simple;
	bh=NqWfXzouQuD5pJi9v80L3T6A/gzQ0pETLZ1AH5q7uHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1TksvUR5xPBEG5LsLytgBqgPtnvhs+EH6NNJKBkrpnMImeFQyD8O8dx1/gz0snp6QMh+AvBH7NJROlNT2SXkVlZCVf6AZ1bZsymDXw7v7NvpU2cac/q17SmUhstvwuEbfJnot28GsGMTZwY1rgynS3ziREdrkL7s44rKemDGZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kce2WTuO; arc=fail smtp.client-ip=40.107.6.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuFP9xWUFZzvMA2KB1hmXX2q7nfoonFHMaUenYHSkI+oMxoqWPZorWwvi4asFPGnM5yj4jVYCMfS76mFtHYjPXahzA0m8y83tGq9g68KpYfOz5zZrt9xoTphfQk5oAlv3GXnhUxHe3JW+zowNLwtCinFxJ3wwZ++buwlvsU4NpDEqWckRybBXscCN/JyApnq03u7GzV8SibcV6l8S7A+9S98HYZ8FgEeUgK9OGTg6XsUBNktQeHu8z2T3FAjXfv6YTYsqMQqbPFnDfOjcwV4Qg5DFo7aHRtudIXLi4fyLhw5jR4r/3VKXIMVOUGt93Z/P/z6pTHMfYHUw7sUHElLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDR8jTXkAo/LOx6kRR5GYFpIM24pu/gcbxUJRoGaIwc=;
 b=f36rKWB3GmLWGiPuvQr2rCeBSBQqxD0Tpq3wPy0Qq2V30spB5O4Na0CCZJQUFSu2eQVF2y86JJWZmlE5sPT0GMXelwvNPTh3O4mWTAxKcptQhUKKPP2Pn7ZWbRLgnoglo7sabgXI9aFZD639DdVVyQv+T6od35gNV+ml7hpo9qA7YdmYO75E39M/G5kixRiqAj0+unemtmGOaPGCeCtM1qKKL9lamyHWs+Jg3pxQdtpH8DJNLd8pUhnd/kHRbGxis5JxgRt+xGQPCo8y8SzYOxPoufGpVJkSSdBvmDZC2l0ZNYM5Vkd/D1hlQVPvsvHQN/16yrEB1TSjfrneGfzwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDR8jTXkAo/LOx6kRR5GYFpIM24pu/gcbxUJRoGaIwc=;
 b=Kce2WTuOMRBJ03/gjHk81XqgYlY7+ShFYwNMxSPjwjt+fa/AKfpJ+qALy+04C8mO3ZIiclB6hGyH9wJktGez+fI7Ca0hOYuEBzlf1yK2CPPGy/rSKF5uLOgAJA1BFjetE5w7+1ly+ezwg9qHmkVKkfZq2Zgw0BdYamQmSkBz82M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Sun, 21 Jan
 2024 22:24:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.031; Sun, 21 Jan 2024
 22:24:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	mathias.nyman@intel.com
Cc: Thinh.Nguyen@synopsys.com,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mark.rutland@arm.com,
	pku.leo@gmail.com,
	ran.wang_1@nxp.com,
	robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com,
	imx@lists.linux.dev
Subject: [PATCH v2 2/3] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches-quirk avoid vbus glitch
Date: Sun, 21 Jan 2024 17:24:27 -0500
Message-Id: <20240121222428.3396428-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121222428.3396428-1-Frank.Li@nxp.com>
References: <20240121222428.3396428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: c59cf9b1-3371-4ac0-f40b-08dc1acfcafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LDueyT37gXQhHstyqGXelUqgp12BSrRgufxO85USGY/3r0yb89A/VhljCPzFLhULHFltl0XvIgnZpWml2Upz77P7ykAWoTqsRlatTyil/XXEqx6ok9Bbd7yxidigxzBFlONl+igKvMFZ6zB8bK6ytkGfJtv9BCt0wjLaU1Ddcaqwq/UrHi7XwTLaHPg/gkcV51J8opN6H7oUdXyWaW7LX0SEBGt/JDjwrmOaxoxkWzGrwk2HA3ZDiLWE+C+zPpEJcHM7rzN/K/k1ybR3nNcb2UGNvZdN/BUXEDfqZt0Wq1TZQk45CWfZoWfFha0tn99sQkiHuZUoTwPstrPRSajxaajQzY77gqSTFRYz+fsurQHrKhZgEvRB2lxYbEI22LpYNE/has9A5xxEa/UneXxuwqKrxEQYHfHP5GWSZ/wvISt7DJMM/Hn2IfQv+G6XnSE9VKEG+1C0ezWr+udZ2YtbJky62/8PxfudeMxE+SuzjJkspbaRY7hcK8Hghsfq6nJPfxWhJsN8ZJl9ldMAIKkZVPgyE0EFXynTO4jhnhRFf+g+bdB3bOsyIo84AV5AqQyv10dPFDXvL3L5h2JbgzcETiixFRfz/6l9ZY0mCkjl/5Sp/1MhuUU2jIQ3yBSyyrvpx9lQds+g04d/Rjhv1kfl/yRctI5yQ8P1B+YUr3orAFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(86362001)(8936002)(4326008)(8676002)(316002)(66556008)(66476007)(66946007)(36756003)(5660300002)(6506007)(6486002)(2906002)(41300700001)(52116002)(7416002)(38100700002)(38350700005)(83380400001)(26005)(1076003)(2616005)(6512007)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5jPHQSlzNqx2wA+fBBd/L7yZSYigDKsl3GRluCk0VBQh/9MpATP8kdJ7Ubyw?=
 =?us-ascii?Q?OKAvT/4Hx9p6NZuuLYFGwXVlZwQJjBTmkX+UZwL3JrS/ut7rfpsxZ8/+EwBH?=
 =?us-ascii?Q?lTGQOQIUpWiAkEYO4/n1MDgFebaQfVRoJ2vXuQ0S27giHEbflqDkZbvky7Nw?=
 =?us-ascii?Q?sqU2KwyKnI3ndlcOCDCvr7wQMl2XA1Z4XR+U3D/FWj+KKxfKW6Al5jDLWpg1?=
 =?us-ascii?Q?FYGu9TaE3biaGlWI70pXwIyfhTWozhuA4NGD6Xn2k/Q9EL24iVQtI64JMBF4?=
 =?us-ascii?Q?YTSWPUpjOcCBFtmPUDv/1F9LfuiWbJoe1p3RsQI4VJdsrmx6Uneasy0OJUJG?=
 =?us-ascii?Q?Qt4qJHZ+/gDtPWiUJdoSnhVgU99M94tGPnuR2Qg5WcU7qxO/mc8nE0tV4iRT?=
 =?us-ascii?Q?8e0uL2QBB5UyEjsM55e0lfktWKYy1nVoR6jmarqpprn6jvWZDqSbUb/xAcO9?=
 =?us-ascii?Q?zNhv9dBUQCQ0cvKhZ7KPCxEL0P6D24F2CBFmZXbFD6Ub1yAnf/nVkT5CgNaa?=
 =?us-ascii?Q?sz5/rE6pHaI60iBKxcDAiY/cjZCXOEkD0QkkkJl19kGXxBSjd8vp5R6nBU/i?=
 =?us-ascii?Q?3MWIQ3fFXRW1O3Y/sdHDcXUwyLAXyh3WONtQ2FmiKxQsEMcG4cVrSa4QWuuc?=
 =?us-ascii?Q?JUYuPi8/9wMOL3btrbQYTs1ILUGHec5r7E7xCkC3teNjBynN514xnn9bY/2u?=
 =?us-ascii?Q?gKdel/oQn7RRk+hdAG0FsvSmXs3yOWGMQYwfpGfvMjt16toOw+EoKxcTQVCk?=
 =?us-ascii?Q?tq4GMYDAcUjGs01QC7uTyamWcE7Dr9N33wcqsdGohXbxQ6rBH7E3xbc+Q4Fs?=
 =?us-ascii?Q?YIoEUR63IDs+QmtyQYi0YgKol3S1qfiA/Ea+N7wynQPS6S/UyRURWLnYDwLV?=
 =?us-ascii?Q?jzSTFhLbH4NagJFW7BY9H0B8FvZA96u/+nu/cGAEXtZOOgXw/y0tBKCPrZlS?=
 =?us-ascii?Q?4gSaQsFJsrfnTamM8X2BWubSxzFBbb9xZ5B9lfaRj2xvG+kVY94mNb2/TA2t?=
 =?us-ascii?Q?vuGo+pBr6oyzfnaNm/kU5WmPglb12C17vjlNuxNV3zr3SyHMP7KPgjbWiLAF?=
 =?us-ascii?Q?4734HHJNge1V2XruOowM1ep7X1rDjBkYPcdHMRo8tz/0nTQDPRffZu4v9c5r?=
 =?us-ascii?Q?nrmcqEd6WrbrZcvsgrn30G+1CMggNXOZVNs78jgpCdFrwJRoBuNCo0wefZAI?=
 =?us-ascii?Q?t4jk1svSlBYMvj2dY42bLQ1Si7PYM6/yLx54Fnif/4+UGt78LRS6i2eSWl5H?=
 =?us-ascii?Q?ttTxLJ/8RVRBefV4YniUX/SchGmMsLg8NEtFkpR8kfPai3gigHi+aE2zI/yl?=
 =?us-ascii?Q?ufaOrfTrwhYff09GtHU3+D+W2goTS3TuxAR0RXmTSB/roeRkTzV13VZi0Jjb?=
 =?us-ascii?Q?SHWafY7v/aOhTDQYkyJ2oWl7vdaOMbsE88/sYOvcQWD8JQrA124ZKgZEhlsI?=
 =?us-ascii?Q?clh+XDJa4h9YHD4YVkDpfgBWzDDb5sX1bPUG++xAI8fQTC5zU+zJUd5RqTbF?=
 =?us-ascii?Q?dwp8Ut8OAQeSD55U/8NwSN5BVLed//cs8FYj2rBK8vGWY2l1fcgGGsvRLA2d?=
 =?us-ascii?Q?zXLJIIQtU6KlZ9CNo2U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59cf9b1-3371-4ac0-f40b-08dc1acfcafe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 22:24:54.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilwekou36ExUzkwM3+2BY6wKytfs1/4s2dGMfKRjwCdJL8nbKB+8GOIf/sy7a5iMyTs4ewQaOZSh24w6yshCRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074

From: Ran Wang <ran.wang_1@nxp.com>

When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
(or its control signal) will turn on immediately on related Root Hub
ports. Then the VBUS will be de-asserted for a little while during xhci
reset (conducted by xhci driver) for a little while and back to normal.

This VBUS glitch might cause some USB devices emuration fail if kernel
boot with them connected. One SW workaround which can fix this is to
program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
host mode in DWC3 driver(per signal measurement result, it will be too
late to do it in xhci-plat.c or xhci.c).

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 203a1eb66691f..8f5d250070c78 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -273,6 +273,13 @@ properties:
       with an external supply.
     type: boolean
 
+  snps,host-vbus-glitches-quirk:
+    description:
+      When set, power off all Root Hub ports immediately after
+      setting host mode to avoid vbus (negative) glitch happen in later
+      xhci reset. And the vbus will back to 5V automatically when reset done.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.34.1


