Return-Path: <linux-kernel+bounces-161310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA68B4A85
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9423328217D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1E750A7E;
	Sun, 28 Apr 2024 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OxDtMbq7"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527C2AF1D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714290194; cv=fail; b=sMJ6Zt3reUsCzt4QgGmr8c5bJVGnPqDvfjw1sKcZ2XcG9N7lJyAt9GGQNVM8z2U6iM0iR6qFoSWG1GAXiEv/t1DDn0WOxCvfGft0+7477tSRI6NSAUKup3pYWX8CMlP5gABY7ZA4DUSRCIteXJiPPpUFA2i1F2Q8AWRJGtr5JCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714290194; c=relaxed/simple;
	bh=mMdf0/9MsoFeFI3Mf4+lRCZqjh2786xKQVJfw7iZ0G4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A3AuEhXIBrG24P3aXTft5PFUgJsyimGaWnBAPIoPTl014AYjIfNSoWa7pvc8TPyBNUuOG9euJCipbPpbE0ETrU6CGJ7zDTiEPC3/WWhwOyeN/isl3Whd4TKCPnTNfXIOj3GHAq2wpx6j7zDlhjic21X4VygSVvaLBelt61LfjJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OxDtMbq7; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oApus0uzPsPAnmCz/TBolCXHqoBZIVIexBf4wcbAKFKnF2c1p2qusGdCI0zR8ImDJ5WXGfujwlicDr5CVwI70Vc3yTxDisMl0MInBy/Y1N+2YNBoo6QtCUnfpvdh2GboPB+uBN0Ai+5WuHsEifSFeB/KvYS4eE8LMO1wnLG34kmU3va/U1pZc4tp4dUVw2i9wPg6PGSkRgRbTF7TNCeGGOzpluj1UVnDOL9WMEp8gAjUrPjFYlHh0MvF+J81MosOebQppuStNspvEnl/1xNMU8epGprkxrFMwswmKteRYpa4V5Em19qeG7Lqib8nzyBPhHfuyDYCRpFFuN5CE84ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8kO9e3juCA9YXa4osI9oDkov7zVnxFdvjJXuuYlIso=;
 b=IlAx5af1UFHqigMpaozVfQ4C052cZQkBXE0c2BAI14ItmXdbczrwaHt2uM0ZUEuH8WbGipkPB2uuNO26/T9pY35Sk6Hj78FS1FRxcgcJAGzaafCEk0dZHfcW/wXHNiy2JTGNesKTbTo4HXKo4p8mcFbtJ93cuZSrrCMMEIVcs0enSdbnCmXYiqNu20+KKJLN6yUc1EbQi8rTwatll1D5vGzC28CaBX4hC7g2VVsK2jd7yYvgdvR6IcTvsg9jIfpD2+kL1HPLHTyJKtTM9OoeVlWgHg5kqB74Qvjaj2FpSrlP6ndj7fzkiruArvleA5mZhYDjiR/1wOrbiWbGJnEq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8kO9e3juCA9YXa4osI9oDkov7zVnxFdvjJXuuYlIso=;
 b=OxDtMbq7yZtcJtxfqfKYYrRqQNegS8S2Uti4NRXQaQQFtuNdPGJOSzp4HAW2JT4raUkmiqKiRpZEB8yddzA/9jd6+N6Ucu+w+A0YsT/c+tQbdsdcW5Du/VTd1cX5WpkhlRgitm3lPKnyZh8xxN01Ldw7pKrh4WXKiHot9f+1Wq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8188.eurprd04.prod.outlook.com (2603:10a6:10:25e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 07:43:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 07:43:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] firmware: arm_scmi: power_control: support suspend command
Date: Sun, 28 Apr 2024 15:51:05 +0800
Message-Id: <20240428075105.2187837-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: a11f623f-4afe-4752-819e-08dc6756d8e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n8kc+TvS9lyJyhh7I4qv5+PhaypVo0MCU0NtAyg0AP9H+OUhn/XsCHKbM1hO?=
 =?us-ascii?Q?llmfHf8aSVlEorWwMfDm6UjtxgPPZEf3KjEJCqNWquhi8gd+lWrCTb2xrX0U?=
 =?us-ascii?Q?nOvL7G2xDShoWuVzW5IKsRpqfufXkOX+jnXpUBiRld+spMQtXkPq0posdZ8b?=
 =?us-ascii?Q?xaYzSOmfrjj042gOXt5RGtEUwja347YcrE4B4ZP98GpEGg0G6wV1mnNr04BQ?=
 =?us-ascii?Q?dD5D1B6lAjWRVAWCjMr2vYMph4ma7HcgkCMRq/LjA9UNnRfcpF/Adwtj84E4?=
 =?us-ascii?Q?9uBEfvXRHLDFfyUj7F/FOkExXh3DJlcgGG5KYS91xl1ehXj8ml6Nwo48CE7A?=
 =?us-ascii?Q?WilyGwxaOtQp99HS09ncqw1gtBrs9gTdy2zKXj6NCE4jOvJVltPr657Oyiab?=
 =?us-ascii?Q?k2iTQQlKsxx/UabEO3nt13Ov8L0SSG5bMCWR+BgxmcY+KaHhDJMJosZJNEGl?=
 =?us-ascii?Q?+oXXNyNWXJfAbikv9Y2eceLtWtOtn4fmmdkMfUGGuPILoGfHcb7SW94x9nGe?=
 =?us-ascii?Q?ByqVAj8ZcA2iMAcU8y3SSA2+J2tZYwknklQADCkIc7e6CRBTPlVkvE+Bzlr8?=
 =?us-ascii?Q?UG4d+j4h+TFAawWXoPu4Q9z8JZ9AMb40VlALBwRAagE3wsC5YVv9oAmDerQF?=
 =?us-ascii?Q?Is61z/a+E7X30N6JYfjOLFFVwSJwckHqP5ZT29/nbrofqEPGpODSMT+he995?=
 =?us-ascii?Q?yudCwbnEfgBEfYla705wZKOHVxsY36EYpEs8A66D1LNzVpxZJEvEvZz7DdfH?=
 =?us-ascii?Q?lRp77NN5f88+TTWv0kZkhUbHVcSrct7WTRCeIDduf/fN98nBSejxfrMnlWU3?=
 =?us-ascii?Q?cB27txGEApxoehkpPXgWe71xcbzuk+APkGjLivNHkAI1jj5HSqVY4zSIUpLW?=
 =?us-ascii?Q?BbbOSP2HZuFA1Kk+XR91NioGNhpbZ7a28naHMIZ10aQEhSrE8cqgNw2Okf0R?=
 =?us-ascii?Q?l368zNPGIZ5edFCE26e2D+T0Rt6OVjb+QheBpfp93HMO5g18MEM8awTYdTh5?=
 =?us-ascii?Q?SwvkfEWnxMA+X7Xyiqak+/HSuLBXhy7VlUFFgy5HedXYERj6cphaMXGrya5p?=
 =?us-ascii?Q?WiM4ofE/+mo9z8aZbZRS2C2NFwn4sso0XwN+D+Fm71gP2MHuj3cxnl0oWJb+?=
 =?us-ascii?Q?nn7tH/N3hTu+djHmvughU+y2nCBQQhS3Ru/SBpf1v5e3Q+PjsOZ97Quu9Ump?=
 =?us-ascii?Q?xanqnYxWkQf06+SJMEOHLTB49r1DnJA170YI0GAAJ1YJlSGC7U4jiWyUgb1X?=
 =?us-ascii?Q?AyjPS+AXXa/2PqqqPxX+UfB3mapBHbuIbBxCX9lfyvWICeSzH0LZgUHHPb5M?=
 =?us-ascii?Q?NiSeQZrDlb2IdClrrZ3GMzPL/T/k0hcmuPdc88hJza7E5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d+svzKmmGp5yl8B7/O5DEcV4YshFPJ6/yjys+PRDQeChgLscAnVJp2t0RxB+?=
 =?us-ascii?Q?mf3VWnFBKbyk11NyMhs/0Yf3jkqcoAF3/eRHnEctrXE3PM5u9YhWGkpdGIxf?=
 =?us-ascii?Q?JWZPIZg4Ttr2Wh1WQ1Z7SkFZGq7hfLP0LWCy6Fu5npqoya29bInSouZFELzO?=
 =?us-ascii?Q?RFSBKm89ZiedLEgPrkUwC8dXk3GckqzV9hRfY7H9OsBwLA5Y1jeeimLUsaej?=
 =?us-ascii?Q?S27B6daQ3ZY3UPADam9GpYd2c241d7CbgImGE24da0C+AvOjJf9P0raZsDuf?=
 =?us-ascii?Q?Qd5s6sN8ov3B1CEyVXVG+cqvOaI9flwllfo+/eCnmbJVXshiOi82xM8kEE7/?=
 =?us-ascii?Q?CioznRhZ9PZUdKcvJBpIaNDvUXdiOj8Phv9yre4dT4QOlcgQXBmsZX0+oey1?=
 =?us-ascii?Q?1uLc9h6V373Sd5QKdC+Ewn+YkZ+4p7N5N1KBVYKB2lEJW7pzGH593aYQHZXf?=
 =?us-ascii?Q?zhMvscCJZnlUM5FILiRyjur6CCXUC05U82WXDW7Z9Qzada+eoaxuK2ccXn+c?=
 =?us-ascii?Q?MDI7LoCqE3OdJSQ56sX+SEudfou6SGtvoVO9yvrQVxVJEy52+D27+I5E3vfj?=
 =?us-ascii?Q?7LDIcBMllQuki+P30h8bpV7C/N9lIoEYtPxHnZR836OKg0AIh5pgejSAYFd9?=
 =?us-ascii?Q?AG02W9A5IXtrDj2G6kdOCs8anrvHTIv5z6IZB2ZRu8fNC7PkE6L9aa61nyqO?=
 =?us-ascii?Q?QAx7X/3e5ELFpthC/0WF9lItfEN2EcuhFPvAVwhpnqjo3MdekWjnIYRxwBzk?=
 =?us-ascii?Q?mhmhqyBtbTRH0WM9IkQggOIs0TBAaBCIFDgonBdKleV/CzvHjw9846Zvt5us?=
 =?us-ascii?Q?x4/XucLx7qV3843CXIsilpmQgp5NESXWmTAnqd4QKKM4nMU/zTFQP5GOe03W?=
 =?us-ascii?Q?Zx/G2EEdgsv0Ka+hdxGTlmUqkHXB/A21qLZdhQ7nN6pBN9bJpkRjdti3lJtD?=
 =?us-ascii?Q?UnXXitFYkXc/8wHQzkTRt+c7yXtpMhJC0gLk1vBhJRb+yKoHfBj/X+VK7Ael?=
 =?us-ascii?Q?h0Wh/1n95k/p4eK6WqpLZVuXogXCWf9ChaRdZAmRxbQou1EWTkAxCIDW69kp?=
 =?us-ascii?Q?L0UDI0gJaONF+l6vjhJU3lb5H5yIsFWl+kgCpED97mwu79Z5luUi7fsE00Tl?=
 =?us-ascii?Q?FXpG9H2q5RLkw2pnPaOhDq8KkbULt362m9moWRNij80PL/RyOeqWt4VBZ0R0?=
 =?us-ascii?Q?7dCh1/vNu+kQ25I+ZlqtQkId7s9QoZGNYvLN2fC5iT37uMgOSfv9jX1DOlGP?=
 =?us-ascii?Q?z+JFgsDTsA1tI3mYCy0sSkJEO8lv0Wdaf5tha11FnVRAKQd9Ve/sqE6oeRcs?=
 =?us-ascii?Q?IhW+X9L1S6apdmiXMWxrOOAs1d9OhmNsbN08NjtFrz7PiTbc71JywJzcl1ac?=
 =?us-ascii?Q?TLvjss02uhkoj07F3Q6wEI0weSBjsksooWZzRMbDOEK9hYLuN1Zel/yDVNih?=
 =?us-ascii?Q?Duv9Be3TzdxDRGCcHDzUGQF6W3kD9q2/fPZ0Vy8AsbQYRf+tU9we8Zix1xl0?=
 =?us-ascii?Q?9/ui03+yBp8JHT6NyBNApNfoicfE7Mux0BCG+7xWNPtsaHBgJBa4j8fvj1f2?=
 =?us-ascii?Q?GL85k3t16GazgQbWnTjNZD1xd2rXq5o8tz9VxsDc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11f623f-4afe-4752-819e-08dc6756d8e8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 07:43:08.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1HHs5CReBKjlSGSpXkP3qpgE7HWjf+v+fRl8/T/B2NNRZm+SAhGWDjmVpHE1GT4ZfxyT5vEP5GSIrqJvNCLXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8188

From: Peng Fan <peng.fan@nxp.com>

Support System suspend notification. Using a work struct to call
pm_suspend. There is no way to pass suspend level to pm_suspend,
so use MEM as of now.

- The choice of S2R(MEM) by default. The userspace can configure whatever
  default behaviour expected as S2R, if issuing suspend from userspace.

- The userspace needs to keep the wakeup source enabled, otherwise the
  system may never resume back.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log
 Add comment for suspend_work

 .../firmware/arm_scmi/scmi_power_control.c    | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
index 6eb7d2a4b6b1..21f467a92942 100644
--- a/drivers/firmware/arm_scmi/scmi_power_control.c
+++ b/drivers/firmware/arm_scmi/scmi_power_control.c
@@ -50,6 +50,7 @@
 #include <linux/reboot.h>
 #include <linux/scmi_protocol.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/time64.h>
 #include <linux/timer.h>
 #include <linux/types.h>
@@ -78,6 +79,7 @@ enum scmi_syspower_state {
  * @reboot_nb: A notifier_block optionally used to track reboot progress
  * @forceful_work: A worker used to trigger a forceful transition once a
  *		   graceful has timed out.
+ * @suspend_work: A worker used to trigger system suspend
  */
 struct scmi_syspower_conf {
 	struct device *dev;
@@ -90,6 +92,7 @@ struct scmi_syspower_conf {
 	struct notifier_block reboot_nb;
 
 	struct delayed_work forceful_work;
+	struct work_struct suspend_work;
 };
 
 #define userspace_nb_to_sconf(x)	\
@@ -249,6 +252,9 @@ static void scmi_request_graceful_transition(struct scmi_syspower_conf *sc,
 	case SCMI_SYSTEM_WARMRESET:
 		orderly_reboot();
 		break;
+	case SCMI_SYSTEM_SUSPEND:
+		schedule_work(&sc->suspend_work);
+		break;
 	default:
 		break;
 	}
@@ -277,7 +283,8 @@ static int scmi_userspace_notifier(struct notifier_block *nb,
 	struct scmi_system_power_state_notifier_report *er = data;
 	struct scmi_syspower_conf *sc = userspace_nb_to_sconf(nb);
 
-	if (er->system_state >= SCMI_SYSTEM_POWERUP) {
+	if (er->system_state >= SCMI_SYSTEM_MAX ||
+	    er->system_state == SCMI_SYSTEM_POWERUP) {
 		dev_err(sc->dev, "Ignoring unsupported system_state: 0x%X\n",
 			er->system_state);
 		return NOTIFY_DONE;
@@ -315,6 +322,16 @@ static int scmi_userspace_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void scmi_suspend_work_func(struct work_struct *work)
+{
+	struct scmi_syspower_conf *sc =
+		container_of(work, struct scmi_syspower_conf, suspend_work);
+
+	pm_suspend(PM_SUSPEND_MEM);
+
+	sc->state = SCMI_SYSPOWER_IDLE;
+}
+
 static int scmi_syspower_probe(struct scmi_device *sdev)
 {
 	int ret;
@@ -338,6 +355,8 @@ static int scmi_syspower_probe(struct scmi_device *sdev)
 	sc->userspace_nb.notifier_call = &scmi_userspace_notifier;
 	sc->dev = &sdev->dev;
 
+	INIT_WORK(&sc->suspend_work, scmi_suspend_work_func);
+
 	return handle->notify_ops->devm_event_notifier_register(sdev,
 							   SCMI_PROTOCOL_SYSTEM,
 					 SCMI_EVENT_SYSTEM_POWER_STATE_NOTIFIER,
-- 
2.37.1


