Return-Path: <linux-kernel+bounces-35692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4743D839532
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA621C25F28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943686AD8;
	Tue, 23 Jan 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bUPEC9w6"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E386151;
	Tue, 23 Jan 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028191; cv=fail; b=OUbZTv9g+TEZiCA5orq7XPdKJu3AA5JdvAb5ezcnKUP6HHmNUJt0WdXR5EKkJ3Zv2fqnJMCH+GTle9SL4ZacwAwk6f5IsgAUtI8myL79d4+/W0fKnDuAIW1i6PJ08AIwlcYnxCWHpBwW+qapjso/ULe9x+7QFqkaOw4caqjf+Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028191; c=relaxed/simple;
	bh=NqWfXzouQuD5pJi9v80L3T6A/gzQ0pETLZ1AH5q7uHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y5vGcg4Ld0tQdkjcjcTnhErx5DqfpRSicQe7qGEEfYVWc2MaWAIUr3b70pnokQboZhprL7Wl1gT+NiNw3zOV0NToaz0Lt+wKWDInRhnJ8OUrDRrsZopr0ODHTyVjCVn8eh1+t9R0Z0jjm0NHE4sT4fmr4FV8kA6WpVb+DcjwsJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bUPEC9w6; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/BsgjpNltpEdYhv0U/NLE5nxT4RUgKFMx4LmLpA78IebD4+vR/+s5vhgQWb77A9weXAGna7/9YhbCGDqyrgAW+2y0Wkees2/XqHxgEEAGUK+VDPqD4Gie3FlgviU2bD/lKfFcSaO17tHEe661M5iU9v1jhSJOUElAZbapmk5yuqhrV2VtTzhreGxBaBQLl3gpW/IdpUlcYnxHOLdMosFnbf0V96p2ejC1x/yQ/gllR/sGZV2eHNBKB2nGXjV9cW8bIysVu8oVHwDyFY27S6J4ajakUqe0YPebHe5fUe3cB1sAUpA9UfPEc3Zg6tO1vrIIeSLvi/iV0QOek9xkLW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDR8jTXkAo/LOx6kRR5GYFpIM24pu/gcbxUJRoGaIwc=;
 b=fm2Q4iFFNRgyOSIKvdKcmHNc1jOYJjCs2xOpCaM5oseNJK1VzQirpBe7LIvhX1ZBR/XOZta4dLsSMUm/hiCSSO5v9V/qVu8fh0jClAOSJqknXYFktIeQSpo2fjd67Oh+1Z56Tm87+u26BPy0tEdHAq7Ey8LhfPWDBlrm/i2Cg9VcT753yBhWRhFdFvIbP/MUAJqzovWXsd26bvDncgKdlJo+Tbm73tzeVlsup17q1GRGtRwLyEJjcR1G9A0WfqoqlIs8GRbdAqhBBdfAoWWZdjgkuw5pLgWpGIfZGyt75T+SgebvfxMC8XW/q0kXgzO2WfHR+NWqUgEthXoVRf6hvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDR8jTXkAo/LOx6kRR5GYFpIM24pu/gcbxUJRoGaIwc=;
 b=bUPEC9w6PNmC8PCGiAvfrCZKMAQBhGEIY60M6kHN/yPCGZMlfGEF1MhFua/YvfAuoZcU9cjMXSd960wZdX3YSnO+eWfA2ooBn6FR86iwWLJICmfzH3o25TlJomvrdUR3dRzJDU057NMpkoVb79+18l7wMkB0zDi9xdfY0i2u1L4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 16:43:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 16:43:06 +0000
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
Subject: [PATCH v3 2/3] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches-quirk avoid vbus glitch
Date: Tue, 23 Jan 2024 11:42:40 -0500
Message-Id: <20240123164241.3689109-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123164241.3689109-1-Frank.Li@nxp.com>
References: <20240123164241.3689109-1-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b4bea6b3-887a-436c-cc00-08dc1c325fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HUOEDI7ZRByyg96IU1Fod+0OlS3EkGk0ux8AOXgbxkb+IUJMq6A66jpbF5cY/jxYMQGKWOjmjZ1GSg25z/BHeFKE7wX0kLU9nfcso8GmaogTdt3O3QelNP86ICnUt9WTIFRP7BOPhCTn1nhEScp6JDknYydQiZJKb5O7Shz3TNuCV0x56UBooLygBZKfWHNX7rwxBIGoMd7gwBXtiKWKi9EyrMfHNn3FkHEx24WLxwblu4PhGHgTaZv5x0KnoqtDgLe9yOKGvA1bYZpd5g7OXKSeJiLsGRR9aIIPtQcVkfIv8H6oLs1TyX+sLu52x/GSfM7B2KfgRmSylzgNDfcXJmZKOurZdBodZBbNa5j1c+w1GEezJ8ynWqYVMe52txJBgkvF11m5tEC1eKCUoAVoNIcbgI9j1/hIxpdW3ke35JLzAHP1+Tvs0DFhPYzMUOXYDBvzdwwJF4ZqayOk35raTHDNjlvzuAOdJK1tDdqGS5QL319K3WdZFFjTf0HpyltIkxRt97d8WCTXHrnBVDAVjkb89yxPsq8AiU81O+Fe8eF/YeT6eGVMgxh/KvOanozGX8jAus8JUh9cdWC5M5DMpD3AIEA790rONfEH0DMqoiTtHzoVFOB5UiQMSqK2fPOkVGmJS3Tu9nDw2QT2hh4J2seVtfxqqRYcXaOnxUVFQgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(4326008)(8936002)(8676002)(2906002)(5660300002)(7416002)(41300700001)(38350700005)(2616005)(6666004)(6506007)(52116002)(6512007)(83380400001)(478600001)(1076003)(26005)(66946007)(316002)(6486002)(66556008)(66476007)(6916009)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WAHvafgmpZ11jZJbx/hmhR6BbbSLLogKlJFrh07lmAUhxNt4dUX6KtDJi8G8?=
 =?us-ascii?Q?nL+mRiDo7332PkQh2KSaqLm83z8Ix6ARTkECIl82ltkHm1g7uc7FhkCoKOcq?=
 =?us-ascii?Q?9f/SU9xZiAuZev7COT3+zgb3fgT3skR+g9OtdUFtM3ppWMTDT+mHH6mjpcR4?=
 =?us-ascii?Q?wJlz8VlzpYIy7ZSNPEIn9VBHz7RS4C3JW03UJKHOx0imHM+L/SmbaJLqlaOA?=
 =?us-ascii?Q?TFqYKq57q40oqkjNUVXekLszE7LrwCM6MTkqNLRkdtOHQc9/RW/+oZhBGsvW?=
 =?us-ascii?Q?upH9Dl+HYVZO5fo0h3XRDaL10QsTM1xyJBISCvTN2P6yKNwVK83L35HGkKy7?=
 =?us-ascii?Q?WIlsWg/zJzZS5ujIWW3d4L9Z72BcXZq3TED0TA390KEqILfOKA/kdm28iGVj?=
 =?us-ascii?Q?/TvjMO5iOt4g01LCe955Qz0LpOo//XEjJCNe+0RLjzgcYgBl0uxhZIMF3WBk?=
 =?us-ascii?Q?D2GBkzqaAEK2kT6tVw1cHlJP+L3BLyIefnM0X6j1xw/lmteYN1QX6RwvbBD8?=
 =?us-ascii?Q?QurIrFrUndVH9bMdGX+ryG83uvhpd/6zbZF00/3WLV+C+Q/4w5i8baUjKeFl?=
 =?us-ascii?Q?o1NI1eR1APnNI9A5DPUqZhsw5w61xLm0GejIfX61SG1PN45byXTob2Xeo4uM?=
 =?us-ascii?Q?fwbhZGWzuHYlHdX3oCWJCt+hTNjt8FwJ+YFZLqGRE7sH2EC1N/AG87Ex3KzH?=
 =?us-ascii?Q?X8KnRGB3JJbOP3Z+ikS2h8jFfGx0u+7A+FtyYh9zSt/92CsFgDsNXET1iCYt?=
 =?us-ascii?Q?xiXha+VCiKHOwUukiclDKcuEcJrW8guz3inD6O0pM5wW+KFjK+H7ni7dvkxd?=
 =?us-ascii?Q?QYDrAO0oTXVWu8wB+uHZtaHDtB5LOe28l+9wRW3uk3ZEzXw0bw5v5V0U0Ygx?=
 =?us-ascii?Q?BC37PrTQ1oTh54mm34iDKWgc9Cp0dVkjPT87YWQJc3gtxVV/1/zeGgQVjI3s?=
 =?us-ascii?Q?WoE73BKDit3+EsZ+hLUKBx/mNwv/ygUvSzhPl/dU5XiUPKv7yTqYwH2O596G?=
 =?us-ascii?Q?ZBFSO8LLNetndIx3DQJpyQYeFUNkRva3OyQiDYTXWdZW0XlssgyZs7h9pQ6G?=
 =?us-ascii?Q?EUVggtz0L6OC49O8HwMO7oY5d/ZbQc11ANyIfvbR3taQ9/Rx8i/wew/grBJ4?=
 =?us-ascii?Q?hAP5jHj3mRSDYUgb/6nn0vVZ01YHC9p+2cZaUQEwGc3Q6U3P4dIYM7+XI3+T?=
 =?us-ascii?Q?fqJYUhfmOgg3Cqc7CNjZgnX1phc5DUpHJQewIUzJPRlGxC8hSXJkt6/f5MbD?=
 =?us-ascii?Q?w2yw3hQTLKIzBf83ytnvB6EFkRBKd5K8o5llorxXEX9RAgLjzu3nGXkyvULr?=
 =?us-ascii?Q?D1iJ5WcE+D4tdj3NmF5TRJqmAVBDP5bNEqlfYgyb1Tx6rT+r9ACy+YHB+hrQ?=
 =?us-ascii?Q?1hHKlB0moZYdsPRcasW4x9ETrrLRAhTuIqgGiDuobQKTGjMrO4HVFXWUAv3P?=
 =?us-ascii?Q?XoPHpDS2a2s8aGl6CFup60tulJPaBjRKtwCGiYW4f9gZ/VfhM4DwUUfCjFyn?=
 =?us-ascii?Q?PwDODdr96xHOrdIAzzH2V2OJj1ddYhoJQC/gx+tB/OY+qJhtFuzQJd78uGZ9?=
 =?us-ascii?Q?T9bgD9obVENyxU1xF78=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bea6b3-887a-436c-cc00-08dc1c325fd1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:43:06.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i42KZJHLaB5JslXd6WjaZ1WePJf5bGhPDOFDqFySie8VDbFrWPkYBzytoYupmFKGY2sXOuGQ1PY7lXD1VO4eRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

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


