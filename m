Return-Path: <linux-kernel+bounces-90984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F01870805
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3160282D32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364505FEE5;
	Mon,  4 Mar 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QLNm07rc"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8539AF1;
	Mon,  4 Mar 2024 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572123; cv=fail; b=okA5OGTZWJq+9Oeh6bUFKLcLOP0aOQifAxwfnpvwu//uGz6hYTXqXssT84HmObxVjzcd5lznpCidqhoCIS4MDOIvt3E6ugicT43Uwx9Prw4XlEDPGjvTMR9I0i+ugWJC9grJ+YNcHc3VPRW9uJafUCdN4qUEUBfzIXxL7lILyQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572123; c=relaxed/simple;
	bh=DN8MJhZE/6ABuaOgDNbrslUWBDHWkr4DQN1q02HGp+I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=J99EYL7EyOvcSuTBtMEj4CGVj/JF7B3LILOoZEF+8zNEyE1x0M2BYtfKNDp2FUdq6MdNBAwTACBySi5cJEa9LGGG78tOHS8ho2p7P9JACGGP4RcmG/oR2rlbE3SKvrxZAZKIL2+5tH0Nh0uuneMEr0ABw1fgg3vZWIIPAog+7ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QLNm07rc; arc=fail smtp.client-ip=40.107.247.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO8JgW2Bo1B5ZpJAGyUE92QavnG+6fez8/Kuy9KRx4uUQNkSmZkbeJl3LdTamiSStLIcy0Lc9FYXvFO1oHazhf/DRluj4giPF4qY+c3J8mGfkHMbpnWS6TBhpsO3suoq/yXkmmUXH4ZdY9fDTUYdcRu4Tinc1/wbtyJRbvIeIDXTYxxS7+/QSmSS0IkEG30MUo30gGxulO8m/P0xeR2oRcElUR/N9TrbgPRqutX3em172LQdMMD+4+pB3rqtnkodD87SRnr8Np/OF0M+CDyG7v96auZpeGdQCF1e7tOhcjXJFYoN5ZKevvjpzMLzFlOo1bu1p8lkBD5UUx3TtELXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sGkO49KLFONWfFdi6QmW1EeesHZpy/3bqd+R/nBwTo=;
 b=HFC+QCU0qyAddE+GGg1DOyUfeJ7UjhnyLmLDUe7BhNkky0kZIKSPMS6RNTxT/XEis226g+F6yxH+k4i8WoY2vabQ3KRN6hqizYRxjr6OL8ebTUkyR8uLbTZvOxzWGx4G2UCb8Ip0nD+uzlEQFlKOe/A+4LkAb5nhG7JwUi/dllZxGzSg8kWNnSP7oJ0U8A8/Y0BjwOGgCYoZv4ybCYKCosIb5rJX+xSmBH917UPPTNafyuTLeJhnfLT5w6pmq8CZsNkFqVUipXQVuAEjvPSPciwmjiPVCClFNYTfMvBnXod5k6MmqEnjMTr7d4bTXtMsR7JEVkGgXYyNuoCFGhP6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sGkO49KLFONWfFdi6QmW1EeesHZpy/3bqd+R/nBwTo=;
 b=QLNm07rcqNJsMf027NP5jpq3HZ5f1ovkv+XK/J2HnFJcsij8zwBZf/I1L7y28vL1HB5U+dZUg7iRfR16IGwSdadUKBufqaBivEDRqf34CGhm4DkhNvYpq7778ukekI3lH4OnnXu3MhKA5tdBb9dzUejNJO5fWBmy8cC1T7mvwQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM0PR04MB6914.eurprd04.prod.outlook.com (2603:10a6:208:189::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 17:08:38 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::467c:e0d8:4d23:b87c]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::467c:e0d8:4d23:b87c%6]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 17:08:38 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	sherry.sun@nxp.com,
	neeraj.sanjaykale@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on startup
Date: Mon,  4 Mar 2024 22:37:53 +0530
Message-Id: <20240304170753.500074-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AM0PR04MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e3ff06-0a58-47d1-f399-08dc3c6dbbde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LYwUf9NjrKL8xgYHs3idqTIxhVh0+tsTZtEHNfV+2CjvuNpWShiG9XBAhQzKF6hZK6ujQk/ikxQHo3xDQSO5qV93vFIIKgTaGfUgM28qKgqJxM2UzD7+LMethkpt2UXaxXkyAOfni8e4fp1i60nfh6loPgWRV2DxqQeVLluRIowV1fK/b2LMr7IaE7XA25kxfSmkCIEWmppSDVJMb03pt9uxqOzoDU9u5aS2BZuxmSs8hbmQLkkP0yS2eA+qkzaZT/0kV099HR/PVp3auaKmZreEMOoT/j7elGlRmGbU6mMSlYgs0ypcUHQn2bQi4Q1gz3vt9508CLiDFuA6e0QarQy4Jo45H1UiXhhl2oYrNtb2JSa5fYhmrRum9APanfc1+8NzMaG2LiLIUW5PmeJTj7ws4nQsXAGzA1T0kVnFktlJ1EV3LktCbcPS7psSsTI/nrtxaa7VxfyxCAu+3qgWVCwm8SQPtHZoiWK8BJWICkZJHBiF+r2jK6JjNxqGuj2wAuV6qRD+k23fn99lo6qJ5onERi85Q3mE/0qLUQRjW7wRqCZ8FuNS8xr1+D+81/steGZNNCNydKLyGlqpglQJGHWBD10IHdZZPozkGw1R6WZ5wPqcvI5SMDp6IJt8D1FT5LthS0yIWoEqER9glooVgPhnQI0oHQcjEZ8oIZvQshTEfP5iCcIzBSQd8OguWfG0Vs03/8P/0moWmLDg6XxHHooMod0i1on0Tw+7p005Zgo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hlkcxNHeLm5E0SipEHiu8lU3bVCBjL7wl8uG7gCJqtKPpowOW/7fp0ANhCfK?=
 =?us-ascii?Q?qbpP3mFDt27Vw40NQ2uVzWJFBg7eAXIEVPLBkgnfAr8ky69zLkrzqz38PGv8?=
 =?us-ascii?Q?ffEuJAPb6sLEfKMka8cIjxAcReBP/F2PZve8oAoeRtVaCG1m2Qj9Rqe4+4aZ?=
 =?us-ascii?Q?lIy2u7vilpCWPwLzyaIak6Bk4MfjxLYgQRNWGwQChO83gnYj2lxVR3GsEhpb?=
 =?us-ascii?Q?gUvf0nq4ULNnDIlbadiT+oZjoA1ArrmIr8qGFG9n7tTtu1xpDIhbxDpO/mgr?=
 =?us-ascii?Q?Ke4FqdLPuS0lWtAdAWtTKdTPSof+51ePMIyYlJn305N3veerj7yOMsw144Wi?=
 =?us-ascii?Q?g3elJi0tHwx2t2RSyeZtHdSkRd1itibJR1AE/Ak6FMBtpjYADRGwWNXORfr8?=
 =?us-ascii?Q?sEjw6gTZCaPG+g3K12d/+UTGXudI86JgTsACD9rQoEHD9aPd5o/vjn8qWAoE?=
 =?us-ascii?Q?9bCsUvMkXdAFyzGwSA+MV+aWGjClBMs6J85gFDXXf03kNh2sSnB2/c7DWcHh?=
 =?us-ascii?Q?LnkVuSXjTwZNTRN0/ca5FVSAJcZ9DnrYu3CTXDVIa9SDEaK3bzZCaQc9UOMt?=
 =?us-ascii?Q?TCELnSZNy1YmrDGfpBqXj6kOvfpvAAbp9nwOUQvgML9GE1XIYxn+BGoDmSkN?=
 =?us-ascii?Q?f+9KLGsjsd/3l6nTITVKrlj1BkcqgByhLgmwg1ys18c3kw1OU2G7Msf0QpU4?=
 =?us-ascii?Q?dYNhKTkl1fNjAE/MnRcP6SdpD+f3iZKhAG+3BURqrQszJOnOkX0EcpwsD02i?=
 =?us-ascii?Q?KgB7CWnvcffAjZW0gr0E2vJi+fuUzk4phG/XwrM9LfHLmLj/Ra3LiXWvEgZe?=
 =?us-ascii?Q?fz2PupqOcjIrN2Iq9U4Y3HVjl5cM7xZxz0Qzh/e/b4PQhkgIjda2O7ogwBUU?=
 =?us-ascii?Q?AHabYdxc7umq3XLwEWdw1ZezBYmoqYwu8Em2RBxpEJt1Ltl4gQ+SQXdUj2wY?=
 =?us-ascii?Q?uk9Za5k3DUphOIwQflVtvZAkHI4Fs5ELE66/bfT4hTuV7q0EHMJPLzFioTqC?=
 =?us-ascii?Q?/2JDxJhfE3BEy4dwOw3sOX3AXyXsX8TALfk6oyDilZF7QeXSilwcWPthTxjN?=
 =?us-ascii?Q?cxbZ7DZz77zi7QOj7UI0LNiBFlY+l0in/3iX9DQWkY33TcbAkT/T/smj9gI0?=
 =?us-ascii?Q?58PkiLzMXwk315GNfBYuKKd15JLHuGcxR5fJwNbel66yNzNZwgtGmc3rUeN0?=
 =?us-ascii?Q?ZVZ9dWXICoDvkvW7+vPceyFAdQ/Unl1VdwEZn+/KtiYMbto1dRaeP6AjHdY3?=
 =?us-ascii?Q?noWHNZQsNP5juCBslNyk20BT29oJe3w2+y15UqQFaN9i1zphqj3C8CBVczyU?=
 =?us-ascii?Q?brA/yzM+o+Y1ebzH3sl+tE2xZVZJ+VAkJWCgXDEt+SXMXDDwQozK+MB0aD7P?=
 =?us-ascii?Q?O2b7cq3IrH9oihvr0TM3q/5ONikjiMc2UM/TNmMZG9XG+1eeHmeogzCx9k/2?=
 =?us-ascii?Q?YNFB6wvHZlLhfkSzkuJej1THuFpM4wSFKkNjXzTSQJWXcscoYot8TOT/rWp5?=
 =?us-ascii?Q?EEL05jCYsEbStnnKCgAiYtA/dYLU2K5tf3PhmwZN/V8AKIhjHzD6swWFulAy?=
 =?us-ascii?Q?TSk770jEwxw3b/T/QYQpJmOAHVdXiMw1hMtEyWDrIjAfg8JHEfeMbe84sprP?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e3ff06-0a58-47d1-f399-08dc3c6dbbde
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 17:08:38.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQ2c2XZNljULozdXUgz+pHDTT1EhJjUSL6ip4rjaotf9Sx7p9vJQ4PxmQx9CE/ZCvH7uMrgw+pSOA6MkKXNbZwkoT/M8bm5HP9gjEYq2Ptw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6914

This sets the default power save mode setting to enabled.

The power save feature is now stable and stress test issues, such as the
TX timeout error, have been resolved.
commit c7ee0bc8db32 ("Bluetooth: btnxpuart: Resolve TX timeout error in
power save stress test")

With this setting, the driver will send the vendor command to FW at
startup, to enable power save feature.

User can disable this feature using the following vendor command:
hcitool cmd 3f 23 03 00 00 (HCI_NXP_AUTO_SLEEP_MODE)

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Corrected subject line. Added commit reference. (Paul Menzel)
 drivers/bluetooth/btnxpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7f88b6f52f26..42e929f0d141 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -281,7 +281,7 @@ static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
 #define DEFAULT_H2C_WAKEUP_MODE	WAKEUP_METHOD_BREAK
-#define DEFAULT_PS_MODE		PS_MODE_DISABLE
+#define DEFAULT_PS_MODE		PS_MODE_ENABLE
 #define FW_INIT_BAUDRATE	HCI_NXP_PRI_BAUDRATE
 
 static struct sk_buff *nxp_drv_send_cmd(struct hci_dev *hdev, u16 opcode,
-- 
2.34.1


