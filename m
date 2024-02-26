Return-Path: <linux-kernel+bounces-81424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637918675CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A85B285D44
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC480605;
	Mon, 26 Feb 2024 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RWhzGh3Z"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DD7FBAF;
	Mon, 26 Feb 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952233; cv=fail; b=u5CMFDYF8wOSONpIg35tEB/d+mHFORtQ77xbvVgqAnEpg7dn6x5a5UTJrIQfVZqgcWvtgLyslNRqsNBYt6LxcGFlWq1DGtMwUGgx/ozHIV2i2VosaviimCYJZGvzSSQGFW0AODGySS863/eb2CtBGJ7DsV8k4a8JsVcylGjC8bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952233; c=relaxed/simple;
	bh=kiq4xW1h/8Ha0DIuogH3lt2zQcLlK1NRd3csEqXA0mw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=U6jxMKqic0c7rTpR0JDrxXnEn8ykGr50saZ+/YIdgs6hQI8QsWN4fhlbWOKdjNcJuasJDrWf/ykjz2tYCBkstU74/HzJlai5sgSF/welc0HweGRz+j0qCNVmu2dKnyTKQ0liA+fuLAUD49ReoddGvS/sCg4PSffNpzUDqtco5xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RWhzGh3Z; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akxzcJ+aE9Z5ZSo5IVRnIzPOGqoB+KytDp8zASJ12cH2CahJTFHE4sWlUAe4m2DVVQzXmWVfV7aKHDVcProlEhJUBUyNyKqZfnHHh8Hvne+6G/2XLf/P8PWN8kE8+npaLPL3eQgOTPkIVjyIhGhKI7ehHlsJj6qtO6zen2lTxSwdlUnbNsnB84nkXWO7e1gAklcYMe8WhUIw+7qvmBIJirOdQfdud8aeF8ddgOS0spS/Ywulu1zSUpV7lqSRei3MxWKHY78cyPgvnAY2CKPpHhHhqIuSgSKp699nCvA5nwZ8Vvf87RlGESW50FiJ/BQZI99vKX/JzxzWbGBUEX8O8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv+NYAXJ/d5425ZgKeqH/oKHU729QxvyX7jdybiofR8=;
 b=kFGJb1VintSGx7Qtd8fgjn3p3BXxYG7efs8cdXqkOu1DJLJdvYtjqHFTO0bVI6SwtVygTFN0BWOphCBYfcZyxdOCe9jsJJh/KS88BxJnSncaZGL88fuAhE6LN3sJts14oxjJLqFPlLO8Br52c8DojQY53D0xdJdhDbn3i9O3FxgbfETu52thJotdLMaYf4HVoNDIhSTEEBnsNsf2p/ADQ01HSEuCvIKTQvQSN8r9t0CUBOXRrWD+Ssr3hfYWodauNwHCzrWPZzRWxci8KlNFjxtwqKraelR4fmxaUkdG8CItrNLMbmI4tgcbib0Kw4XYncHb+L2bJwd1gAwfmAe3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv+NYAXJ/d5425ZgKeqH/oKHU729QxvyX7jdybiofR8=;
 b=RWhzGh3Z/7DO9vUZgSnI5/Zbpodi8ofVj+C25IeYY4fDck2/1ue7fuJoS0PMl1R6EZqmuDB4mavy3QNxwbxOvZ3BFMFEI/trJ68w91PBJCHy/5myK8lkh3a+1GESiv9QyGDvfBbN8RUnr5jnu7Z/lFwWp5VsfEMuuh9k305iQxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Mon, 26 Feb
 2024 12:57:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 12:57:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: tglx@linutronix.de,
	maz@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: l.stach@pengutronix.de,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: interrupt-controller: fsl,irqsteer: Add power-domains entry
Date: Mon, 26 Feb 2024 21:05:16 +0800
Message-Id: <20240226130516.3821803-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa140da-de1f-42c1-f66e-08dc36ca7058
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OBSj8zJee1FhT0/RagwY1DG6S0PAEq3BwcD0FGmKeXy5mmQdwTTYFoYnVCID73jFtq3FZorvht+otFKlESqBqpN0UCzJlFi8oVIyxiynPzKBqZSr8DDwpPo8Cmpkq/i3QqQPHc75KgMzlzkyI07/ks2YQomCijivj9tRqdsSZDDrYgRwFbk/i2JSbaYFcfaR6L+MECSm53jqlupEKQqFDY6aAqiBmmfZ0VzzooVGwZrKFpmAsGKiQHVZGXwwE491684MCW5IIAJOB1E1jhTkZb6LkypM99uriVMF/S9TGEpMjzuepMuHTCR60miTjW5H5HekgPZje161gQY40Xk+tEJQ+1iaCSLOgWgg2Scd3cGNdaNm1XDkRdrTFQIVWQSjxCUyiR98EDLR2wpg0kemdB+jFxLkjHbpl42/7uXdGcCdw0POc7UekCjYkQ+rCE0uVJpujBWufUxOvX5V5t0124T+A8nMXTJ9610I4D0pUCwRl+2E1bthq0Zjq4DqdLs9hQVvAaS9mgfiJqQDT17PPL0kxquqc2jaGVuHdGLArqI2+EHGheaNtvqb1GI4hevrU0dVbsXVxNYFXLR1+1jMc5CEb24Ff7L0PA2kSgtFIJlou7frpi3EXXsDiRWrEM3nx5GClOY6nUMz20FUApnspWlH95px1P49oxHiCe/YZRGVU9LEweThUmiR5m/3ECWCCC4GIUXGv3e7IzmEMeAV7S0/0YeMXESEIl3I3KqHjPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LxPpNmrjYQIa37Jx4lc6Ri6tu/ZlKok/PBggU7zj/KvY+jEbX3PsOFwEhj10?=
 =?us-ascii?Q?my0uqeISYzQcdQybqY5HChhJ3UstlaZlkH+kTpaKhw1UpvgKKvuR4JX2WYmL?=
 =?us-ascii?Q?Fbf8uTusJds/9XALvjiWCQvMdYp02H5yTfx7HTO//49jFzRQ8OvWBtUdX1+f?=
 =?us-ascii?Q?dX+ETGMdX8t5EmWOtNw/v6Psk/WWcKcPPyTpitryeTUdPEwUu52Fw5Wd58eZ?=
 =?us-ascii?Q?uRp4/vHUMjIDbu2XG1wlr7m2yO/QhhvVAY/zO82geVJW+Ubd9X5YPh2QmVha?=
 =?us-ascii?Q?wyzAsDgC4mC92StQa2ts985djameWC7P+3JFLQcw7Uf7LJvBysJ2tUpN+0YO?=
 =?us-ascii?Q?68mkDEqLv75U1IGx2cWfALwWnEO8dCqXV6J9IMhRUW3GksgXaYMRMf+LiKUD?=
 =?us-ascii?Q?DArXxIJcuIFv7NrVhz/IaaX9uQI1alLUrHZNEacROeVvbFvz2otG3NSb2DlE?=
 =?us-ascii?Q?SMNfSrI+/Lg88fi6ocwFiAFALgFXpNJ2bjEdbeRpzXv8ycsBucwgR2RFDKXK?=
 =?us-ascii?Q?Ny4ttZNzpJN8a+YpRkKQNcEYICjcbYJ/+j5zvfJ75wXjvEZRu+fvMveIcHsh?=
 =?us-ascii?Q?EZhWvB2PtoyINPxXN+7osdahi9q0h1s1JSj7KnuTbiamby/NcvK19LPdlbP/?=
 =?us-ascii?Q?4igHhnDUjKES5EoiRQsn9sMxeHZ7ndClgK0lMHJcMwdILhy1zM3K4QnO2GOt?=
 =?us-ascii?Q?z/1xy9zAVa5LLqNIrEwHU9Awbq3Ggv5miZY2M7tLRh9KKR4xpceKR7PlXx9T?=
 =?us-ascii?Q?7om6zyrV/+yVNBAaTSKGcVyWkEEsubMIBTa0SVQrdEKP7v7bTgDFWPZazSHl?=
 =?us-ascii?Q?ox7T1Smiu1hiBuJ69wY4d08r5aAsMdWXwMhQDbGsCmtrAMdO/HmiZ62f+t1t?=
 =?us-ascii?Q?Ne54CXpPBhI2lRvqeRRsCmd0KgjjYfFjxldOO+dZAQ+vkBFvxqjyd8n1auL+?=
 =?us-ascii?Q?9MDe1Vwn4eBZ6Rkg6+XHj+V2eqMwFwq/IyFnBWB4LmsICL5YoYo0czFkd72M?=
 =?us-ascii?Q?CEsH0gYc+fITr5Wpi51a4nRoBqLshNVYiLqxgk2zBfSr0WHymJcMpJdLTzXJ?=
 =?us-ascii?Q?fXNUl5Qv80XR950hTSgveXOGgkUHj10wcZWj6OQFXQ5rA5XmG37gZVoToe0T?=
 =?us-ascii?Q?385Hd4SxUdOr40Fm7dJfwL+vC2MXcnqH+ma9lgYvir9l1oGbgbesTWHgrOpX?=
 =?us-ascii?Q?P4/+jgdgPZIt3B58XqFb/HwIZOUaP7v8lK0IhWktuOv5vMmy3aKUjggzhYps?=
 =?us-ascii?Q?sLTexDi+Z5Q9oXYbPEmfLF71ySmkV4/JjS8rNIB6OcNFAJspaDuxgMi5Ygc7?=
 =?us-ascii?Q?n4M3jPgcUjkIyslk4oruxWynVY/W3QfXFO7OiA69jT+iePQk1VhCbIjSuDJU?=
 =?us-ascii?Q?at7tQ45IgQ02d7a7xTqHyO1fwfddRqrox/IMJtW5V5fCMZTqP55O2QF+MXPF?=
 =?us-ascii?Q?SyQwGjNKG46pvUSWil0zzCoNd9zB8lFHIfCvPXghgIj2qOCnOJgbVOfFf6e2?=
 =?us-ascii?Q?I0NunjaMbvh90O2hZFt6c3yDCN8T6rTVI+vM8jpL2uN1CJ96CeHruEkS9Pm9?=
 =?us-ascii?Q?MsE7XNjVUUNucXe+I7aNC4OWBGWcrqzqUhfaHk6b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa140da-de1f-42c1-f66e-08dc36ca7058
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 12:57:08.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tmfa8auOpXZmJzN013H7YgEU1Ca4MmWPnx1JtjKlUR96uB5FBxWdhM++HFU0r3ivzApda/NAxmIiFxUWIzirKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

From: Peng Fan <peng.fan@nxp.com>

Add optional power-domains entry for i.MX95 usage

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
index 20ad4ad82ad6..7ccbb96434a4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
@@ -59,6 +59,9 @@ properties:
       u32 value representing the number of input interrupts of this channel,
       should be multiple of 32 input interrupts and up to 512 interrupts.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.37.1


