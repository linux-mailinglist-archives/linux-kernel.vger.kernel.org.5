Return-Path: <linux-kernel+bounces-112321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947D3887856
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261FC28151E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2FA18EB9;
	Sat, 23 Mar 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ym7wp2f0"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D13D0B9;
	Sat, 23 Mar 2024 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195664; cv=fail; b=jSBPx67374v0T3Qm1oxGcs8DSkjTaYBEz9+uBeAVB5dqyJea4c9OPqJB6DcUuyDrQux24BolB78D6ESuFrEWA5tXYK3vZ9f/r1SLh+2lD2KH8BQr6eEJBbAkT/f1hfVF16Z5wbdEfPnZMSZHlCd4HkBgWC+5HiiHXfE8Vsc34cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195664; c=relaxed/simple;
	bh=6iY83JrrvGcb22Cnn615upBS9CMBA5OumWERxH8qfXo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Rvjas0/HcbFOLFqG/y0+ikmTGPJLz2O1IAWB/pIpBkdH58HJCuAayCC3dEZ1/6XSgTBnmrnkcqx5vz3EtWiyrGV7OXMnWzh3nQ2TV4QKA7osFvhVuDzyhStBofDL3HXRe9VTm1ElDXZ5HGxe3njw3iCDellZQcR57wm7Q0qud1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ym7wp2f0; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF+BuFG8KV/kRp0mScuUrc4ITUnD8Ph811M07N+NyDvRC+kk/l7pnGuEhc1f8iGWMOnFjzsCt/uDR3KfH2Uwpk4WKgwuME+Gq+ncfsAA7cOTvVxLJaH7Fv8DhR3LTlPbtdSMng3k7ariougHU/6VaGhRf/odP+IewKP1YdhxUGZkyfaWyZAMacolECqnez6jtZMZpgnyiGw2Rke3gsdpGH3QP4krMckiyRUs92x1hRNbvNL9d1ugN2cxEzYpE7TtWuebidwg2t+E0nDOYsxzhrw50ID0APWaeeZku7rAjWirIbV8f244FtIdW+3xlpAqnlYKA3eOXE5BtClq+EWFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W27TpMhgY/YI6AuFaAnNekWgbykmCcfjtmlhPY/368=;
 b=gKzCPGZQ2CbelzJdzFmD6StkOEMr7ISoH/xt1qblvRxj2sniNVkXp3R9lioCHI4u3icXQBHkUDdkUV6nKq+NxjG9C3TGBSk7VpVNzG6Tq66wwNynSJwGvvC3By2BeTYwUqqAEUewL5Qeyx5KLAJchl+iEWPsgIKpUpdm/1QFG7mdJp0TW/sT9sF5TH8EzbYZXD+SUU1670q54F7moDndH4oP1B1qzYeslDg2CWmOXZO7S/nbaV3m5ysCeCXLQz6ka3WEHOJwuzOHA3PCPNyM6kp4iS+s19Oi9nF4DYOFHUgJUCaWo24LzORETGGRZMmXyeZKbW53btEFQM3izeblow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W27TpMhgY/YI6AuFaAnNekWgbykmCcfjtmlhPY/368=;
 b=Ym7wp2f08M5nwBljyShW2I2kHO/KfH5snE6JFYJ1kALza6PXy2fZSQM1H1HyT/RvYsFv/n5ztxVlEtMepNBFl3oafAgjBuMZHQERHV5VFsWpOgJl/UoBPzSx6JsCJXMf/TIqwshX4xl+JWbTz5AZ48NY3lxvZauJBlopWQoMoDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9585.eurprd04.prod.outlook.com (2603:10a6:10:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Sat, 23 Mar
 2024 12:07:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Sat, 23 Mar 2024
 12:07:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 Mar 2024 20:15:16 +0800
Subject: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
In-Reply-To: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711196144; l=29007;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=8G94Udew3uI9UTCk8ZfwJwD1xyZ3uGcFc7OVM/iwQbI=;
 b=XghEVGNguvdXINQQRvFSQPrOHG1PizjcsyW+OcQlIJhnhTfDXPdkCLMYhFmfnEH2DrZ9snD7h
 l2vAve4CcaqBPJJEAKJYgM9n3fIcOlQFd132iUOBxQjYdHwTbItS7Vv
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d3b143-05cb-4841-89e9-08dc4b31d552
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ddI1N/xtvdr8EZv8RtZoIU7Te4Mmq89ZK/RTAUGWxK/ZvstPCevqgkDciIWfWj/Ln0v71XzxHFNUhu8D1CgWSFcYIIwEshQk1tnATcsUBfjxp2hTpb+4jwv5M2+t5dfnjJ8KOxfYyNpwaugA8U87uPKxKkIiylWyoDvIZd0VEgLvOlHnKs2PYD2HvTnOliNVeknNPJu8LObcYP9I6bIWTd2FLtpXj7Q1iDv2TTdxM9jZ4gYtnJcMPQeP39FnyWEkCU5Urcvhv/gdXVAtvcKzVzMHbGuefQoV4LdlVwackE44UTnusiE5VlphbapzRDWyQMNwwUPmp6irJE1gwoOsHhn5V+xb87VeH1gjx/8wCd11KYTct0wu8VOslujhCyTGE1J9ums5/XWJqo78/rw6mLvMgsR2Ihc0Mm6pH/2EmN0DWQYfnJP3vyYqQY2BCl8rRbD3uDP0qahB1UsSzcxWz9Qo3KlreowzgmtWAhlUWOdF0IKJ0E5rrhpEdNUYa9Oi97ODXIFS+MwsUwDmiEDk9sYY3p5qSUX0Qg+7l7xHEeHSR9g2rGO+penUPU8Ms4HJ6ItXmgZHhwoxrgyKOTxUceav4s9XkneucRwFRNG8Y2+PVy9B2hOfNFv0NIHjQoGudG8NyOPyCvYEZPpel799SPFNTIZxo1kCpCNJGRKzk5KM2Jol7B2kyMIC/9NHF9jfT+oZbdoT4Q70r9ISo+zA5yKSOuF/CbeeivRMRmYvbLU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0o3aS9uaVlMcStiRi9GRGxUak5XY09jV1NPR2gvclFKcFZ3TkRUbFJZZG1I?=
 =?utf-8?B?RmgrU0o5ZFhXK0pEZ0F4L1B6NTBNeVVUakhxU0V5OGVtb05mSGRFSDNCVHpO?=
 =?utf-8?B?anVKSjR2eVAzYnAwZ2JrVURKcWNPMExCWExuRDRZOTZ3c250QUxXRnliZTBs?=
 =?utf-8?B?aW4zNUxqT3crRUQyaHA4NjQ2eEh5bE1GajNtcm9CbG1FbVYwMm9qLzN5b0NP?=
 =?utf-8?B?eUhPbm9RbHRLcDViVzk0clVKQW1tUHZDMmo1NFk3Q0pvbm9JUGZzRkxVYlVS?=
 =?utf-8?B?SUNOTmNQRFRYaHlIMDdYSXU5OFJ1REF5bWFjTXFxeUlTc283c0ovdDhEYzJh?=
 =?utf-8?B?M0RWQm5SYndBdlJ0djFqalhCenBlVXljQnprbDNuTDErOGViVEFmckh3RGxx?=
 =?utf-8?B?K05uYkVpNG5MQ2wxcXNjUXkrRUVjSGRFc1lMVG1pbzRKd1dVUjAxUXFWVlZH?=
 =?utf-8?B?WXRNRE5za2dhSnpJZWJBR1ZMRUIxbWlzUisrQ1VBU1c0NjlyMzMva0NWbnU5?=
 =?utf-8?B?NjBRdGV0dUpyNmt4ZU0vUXBBbUZGaU8xYkhaYjZhRXNSd0lxK28vMjlJb2xV?=
 =?utf-8?B?UXk4QTJYdmt1YkxuZjhpeWFyY2U1SkFidHhNQW1GWlhEaFVicWR0eWNGWEVl?=
 =?utf-8?B?cm1MZlUveWplcGJvdUZ0ZUx4R1F6QkN2U2FFS3RSUTNtK1VvQjd4MFY5T05K?=
 =?utf-8?B?Z21DSTFON1FZQ3lIUFAwV2MxREhjTmtiK1U0eGVYWHM3KzlZOVdqOXNVb0lS?=
 =?utf-8?B?akZnOGplWCt2THloOE9jSGVKSG0wZjVYT29pUFlXd3pYNnI3bDVIUDhFK2FV?=
 =?utf-8?B?S05RS0M3Nmpscm41K1FEK1ZvRERiWk9iWFBXb2phZWdyZUFqWXZTRWdhcUlT?=
 =?utf-8?B?MlB5VXJEQUMyOFNEUzlmN001UWxRVDRES25oM25LbUV4T28vNDlCK0tLK0VM?=
 =?utf-8?B?dzVxR0haRzduZUkwNG53em9idnc0S1ZoMXBRRHE1M0tWU1B6NVlmV2E5UFB3?=
 =?utf-8?B?OFAybk9zOUg4M3VDMUNQejhLMFgvaUI5eDVVZUFYbWd4a0FqVktVK3p4bFRO?=
 =?utf-8?B?NmpZbWdBNXl1aEZDTVBNcGYrNE9JQlJ4LzUvMnUxQTFwMG5zK1pYZlFPelJY?=
 =?utf-8?B?SXkxa1NtME5iVVlER1l2VlROQUxwbGN6VVAwd0dCM05xbHQycEk3VlFpeVEz?=
 =?utf-8?B?ZXR3WlU0UXRUSnJQaXdmaHRFNDdaNUV2QUV6bDgvOVdrb1JEZ3JpbjlNM0Zt?=
 =?utf-8?B?NFpBVFB2UyswVzB2QmlwdUt4ckRSLzUzRkZ4eTlCbVRnQm9Ocmxocjg1Y1VT?=
 =?utf-8?B?UVFrT01uaHZpM0thM1M3eENkZ0ZZdFpDb2pFSE5nZ0ltZ1c4ejdXUEFYYXBu?=
 =?utf-8?B?UFBuZUVXbmVwM3BPK1FzbVVEbkt3M0g3bCszdWR0L1hSM2VIVUJzUDF6Z3U0?=
 =?utf-8?B?Tmxlc1Z1OU1lYmN3ZWVxZFJobjRkWDVvMTJtaHI2VHdaK1UzVlY1WXhPMGdw?=
 =?utf-8?B?OC82N1FIQXR3YTlQK1NPRUJhWnZHQ2lybTJOVzBSSVZqTjhFeGl0WGpQbkY5?=
 =?utf-8?B?Uk04YkR4cGtDMy9MbWdUQWZzUTZVS1k4TUhUTjRwaHpmZURPNVFwZDJRbEVB?=
 =?utf-8?B?YWhUWUpBRHI2bk5ib2ZoSis4cVdHVEdCRGFyQnZaZDFQMWxVSGpMdi9nUDdH?=
 =?utf-8?B?cUV5d1BzMGdQV0tUcGZkcDduNk9mdEZWaXBodU5ibTliNnpLTVNMcjFzMEVO?=
 =?utf-8?B?a1U4Z2VTWkRYTGMreUhITElreXphWWZNbzVuem5nT2tzMFYwSktzTE9ESnZv?=
 =?utf-8?B?K2tBeXhWNHdGVWJFUDZXYnU0RXhyUEpHcFFBZG96U0ZzM1pqQTdDd3hhMW1N?=
 =?utf-8?B?WXZKbjl5alAvdk5iNjBMdDMzOEo4UkhCd1Vvd0JOUm96T1kvbDZOTE1rN1d2?=
 =?utf-8?B?YzhqUFRzV2xiZEdwSXM1QjJycXV2SWVRamVnaHlrekUrN05raWY1T0QvRnpP?=
 =?utf-8?B?NmZTRmtsZ0IzTFZOSUxnY0Z4RnVJYnd3WXJ0WmJ3K2d4cDRITGZjWWt2NlJX?=
 =?utf-8?B?TDA3UDFFQWRndGp0MWxBK3JKVXNQYy9PdXQvRkh6N0tiV01qaFVUT1ZFQm8r?=
 =?utf-8?Q?/Uc0pDfpwEo4+sC/85YChkG6O?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d3b143-05cb-4841-89e9-08dc4b31d552
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 12:07:38.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fskmtEzB/r3AvVawzJZufKiz6erBc1hosnIlhRg6IGJdiB8ygarRgbPeVQNHPU69G6O0IK95hI7KminAwCZZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9585

From: Peng Fan <peng.fan@nxp.com>

Add basic implementation of the SCMI v3.2 pincontrol protocol.

Co-developed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/Makefile    |   1 +
 drivers/firmware/arm_scmi/driver.c    |   2 +
 drivers/firmware/arm_scmi/pinctrl.c   | 921 ++++++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h |   1 +
 include/linux/scmi_protocol.h         |  75 +++
 5 files changed, 1000 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index a7bc4796519c..8e3874ff1544 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -11,6 +11,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
 scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
 scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
+scmi-protocols-y += pinctrl.o
 scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 415e6f510057..ac2d4b19727c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3142,6 +3142,7 @@ static int __init scmi_driver_init(void)
 	scmi_voltage_register();
 	scmi_system_register();
 	scmi_powercap_register();
+	scmi_pinctrl_register();
 
 	return platform_driver_register(&scmi_driver);
 }
@@ -3159,6 +3160,7 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 	scmi_powercap_unregister();
+	scmi_pinctrl_unregister();
 
 	scmi_transports_exit();
 
diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
new file mode 100644
index 000000000000..87d9b89cab13
--- /dev/null
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -0,0 +1,921 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Management Interface (SCMI) Pinctrl Protocol
+ *
+ * Copyright (C) 2024 EPAM
+ * Copyright 2024 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include "common.h"
+#include "protocols.h"
+
+/* Updated only after ALL the mandatory features for that version are merged */
+#define SCMI_PROTOCOL_SUPPORTED_VERSION                0x0
+
+#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
+#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
+#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
+
+#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
+#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
+
+#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
+#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
+
+#define CONFIG_FLAG_MASK	GENMASK(19, 18)
+#define SELECTOR_MASK		GENMASK(17, 16)
+#define SKIP_CONFIGS_MASK	GENMASK(15, 8)
+#define CONFIG_TYPE_MASK	GENMASK(7, 0)
+
+enum scmi_pinctrl_protocol_cmd {
+	PINCTRL_ATTRIBUTES = 0x3,
+	PINCTRL_LIST_ASSOCIATIONS = 0x4,
+	PINCTRL_SETTINGS_GET = 0x5,
+	PINCTRL_SETTINGS_CONFIGURE = 0x6,
+	PINCTRL_REQUEST = 0x7,
+	PINCTRL_RELEASE = 0x8,
+	PINCTRL_NAME_GET = 0x9,
+	PINCTRL_SET_PERMISSIONS = 0xa
+};
+
+struct scmi_msg_settings_conf {
+	__le32 identifier;
+	__le32 function_id;
+	__le32 attributes;
+	__le32 configs[];
+};
+
+struct scmi_msg_settings_get {
+	__le32 identifier;
+	__le32 attributes;
+};
+
+struct scmi_resp_settings_get {
+	__le32 function_selected;
+	__le32 num_configs;
+	__le32 configs[];
+};
+
+struct scmi_msg_pinctrl_protocol_attributes {
+	__le32 attributes_low;
+	__le32 attributes_high;
+};
+
+struct scmi_msg_pinctrl_attributes {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_resp_pinctrl_attributes {
+	__le32 attributes;
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+};
+
+struct scmi_msg_pinctrl_list_assoc {
+	__le32 identifier;
+	__le32 flags;
+	__le32 index;
+};
+
+struct scmi_resp_pinctrl_list_assoc {
+	__le32 flags;
+	__le16 array[];
+};
+
+struct scmi_msg_func_set {
+	__le32 identifier;
+	__le32 function_id;
+	__le32 flags;
+};
+
+struct scmi_msg_request {
+	__le32 identifier;
+	__le32 flags;
+};
+
+struct scmi_group_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	u32 *group_pins;
+	u32 nr_pins;
+};
+
+struct scmi_function_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+	u32 *groups;
+	u32 nr_groups;
+};
+
+struct scmi_pin_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool present;
+};
+
+struct scmi_pinctrl_info {
+	u32 version;
+	int nr_groups;
+	int nr_functions;
+	int nr_pins;
+	struct scmi_group_info *groups;
+	struct scmi_function_info *functions;
+	struct scmi_pin_info *pins;
+};
+
+static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
+				       struct scmi_pinctrl_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_protocol_attributes *attr;
+
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0, sizeof(*attr),
+				      &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
+		pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
+		pi->nr_pins = GET_PINS_NR(attr->attributes_low);
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_pinctrl_count_get(const struct scmi_protocol_handle *ph,
+				  enum scmi_pinctrl_selector_type type)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	switch (type) {
+	case PIN_TYPE:
+		return pi->nr_pins;
+	case GROUP_TYPE:
+		return pi->nr_groups;
+	case FUNCTION_TYPE:
+		return pi->nr_functions;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
+				    u32 identifier,
+				    enum scmi_pinctrl_selector_type type)
+{
+	int value;
+
+	value = scmi_pinctrl_count_get(ph, type);
+	if (value < 0)
+		return value;
+
+	if (identifier >= value)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
+				   enum scmi_pinctrl_selector_type type,
+				   u32 selector, char *name,
+				   u32 *n_elems)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_pinctrl_attributes *tx;
+	struct scmi_resp_pinctrl_attributes *rx;
+	u32 ext_name_flag;
+
+	if (!name)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_ATTRIBUTES, sizeof(*tx),
+				      sizeof(*rx), &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	rx = t->rx.buf;
+	tx->identifier = cpu_to_le32(selector);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		if (n_elems)
+			*n_elems = NUM_ELEMS(rx->attributes);
+
+		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
+
+		ext_name_flag = EXT_NAME_FLAG(rx->attributes);
+	} else
+		ext_name_flag = 0;
+
+	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && ext_name_flag)
+		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
+					    (u32 *)&type, name,
+					    SCMI_MAX_STR_SIZE);
+	return ret;
+}
+
+struct scmi_pinctrl_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	u32 *array;
+};
+
+static void iter_pinctrl_assoc_prepare_message(void *message,
+					       u32 desc_index,
+					       const void *priv)
+{
+	struct scmi_msg_pinctrl_list_assoc *msg = message;
+	const struct scmi_pinctrl_ipriv *p = priv;
+
+	msg->identifier = cpu_to_le32(p->selector);
+	msg->flags = cpu_to_le32(p->type);
+	/* Set the number of OPPs to be skipped/already read */
+	msg->index = cpu_to_le32(desc_index);
+}
+
+static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
+					   const void *response, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r = response;
+
+	st->num_returned = RETURNED(r->flags);
+	st->num_remaining = REMAINING(r->flags);
+
+	return 0;
+}
+
+static int
+iter_pinctrl_assoc_process_response(const struct scmi_protocol_handle *ph,
+				    const void *response,
+				    struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_resp_pinctrl_list_assoc *r = response;
+	struct scmi_pinctrl_ipriv *p = priv;
+
+	p->array[st->desc_index + st->loop_idx] =
+		le16_to_cpu(r->array[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_pinctrl_list_associations(const struct scmi_protocol_handle *ph,
+					  u32 selector,
+					  enum scmi_pinctrl_selector_type type,
+					  u16 size, u32 *array)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_pinctrl_assoc_prepare_message,
+		.update_state = iter_pinctrl_assoc_update_state,
+		.process_response = iter_pinctrl_assoc_process_response,
+	};
+	struct scmi_pinctrl_ipriv ipriv = {
+		.selector = selector,
+		.type = type,
+		.array = array,
+	};
+
+	if (!array || !size || type == PIN_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, size,
+					    PINCTRL_LIST_ASSOCIATIONS,
+					    sizeof(struct scmi_msg_pinctrl_list_assoc),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+struct scmi_settings_get_ipriv {
+	u32 selector;
+	enum scmi_pinctrl_selector_type type;
+	u32 flag;
+	enum scmi_pinctrl_conf_type *config_types;
+	u32 *config_values;
+};
+
+static void
+iter_pinctrl_settings_get_prepare_message(void *message, u32 desc_index,
+					  const void *priv)
+{
+	struct scmi_msg_settings_get *msg = message;
+	const struct scmi_settings_get_ipriv *p = priv;
+	u32 attributes;
+
+	attributes = FIELD_PREP(CONFIG_FLAG_MASK, p->flag) |
+		     FIELD_PREP(SELECTOR_MASK, p->type);
+
+	if (p->flag == 1)
+		attributes |= FIELD_PREP(SKIP_CONFIGS_MASK, desc_index);
+	else if (!p->flag)
+		attributes |= FIELD_PREP(CONFIG_TYPE_MASK, p->config_types[0]);
+
+	msg->attributes = cpu_to_le32(attributes);
+	msg->identifier = cpu_to_le32(p->selector);
+}
+
+static int
+iter_pinctrl_settings_get_update_state(struct scmi_iterator_state *st,
+				       const void *response, void *priv)
+{
+	const struct scmi_resp_settings_get *r = response;
+	struct scmi_settings_get_ipriv *p = priv;
+
+	if (p->flag == 1) {
+		st->num_returned = le32_get_bits(r->num_configs, GENMASK(7, 0));
+		st->num_remaining = le32_get_bits(r->num_configs,
+						  GENMASK(31, 24));
+	} else {
+		st->num_returned = 1;
+		st->num_remaining = 0;
+	}
+
+	return 0;
+}
+
+static int
+iter_pinctrl_settings_get_process_response(const struct scmi_protocol_handle *ph,
+				       const void *response,
+				       struct scmi_iterator_state *st,
+				       void *priv)
+{
+	const struct scmi_resp_settings_get *r = response;
+	struct scmi_settings_get_ipriv *p = priv;
+
+	if (!p->flag) {
+		if (p->config_types[0] !=
+		    le32_get_bits(r->configs[st->loop_idx * 2], GENMASK(7, 0)))
+			return -EINVAL;
+	} else if (p->flag == 1) {
+		p->config_types[st->desc_index + st->loop_idx] =
+			le32_get_bits(r->configs[st->loop_idx * 2],
+				      GENMASK(7, 0));
+	} else if (p->flag == 2) {
+		return 0;
+	}
+
+	p->config_values[st->desc_index + st->loop_idx] =
+		le32_to_cpu(r->configs[st->loop_idx * 2 + 1]);
+
+	return 0;
+}
+
+static int
+scmi_pinctrl_settings_get(const struct scmi_protocol_handle *ph, u32 selector,
+			  enum scmi_pinctrl_selector_type type,
+			  enum scmi_pinctrl_conf_type config_type,
+			  u32 *config_value)
+{
+	int ret;
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_pinctrl_settings_get_prepare_message,
+		.update_state = iter_pinctrl_settings_get_update_state,
+		.process_response = iter_pinctrl_settings_get_process_response,
+	};
+	struct scmi_settings_get_ipriv ipriv = {
+		.selector = selector,
+		.type = type,
+		.flag = 0,
+		.config_types = &config_type,
+		.config_values = config_value,
+	};
+
+	if (!config_value || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, 1, PINCTRL_SETTINGS_GET,
+					    sizeof(struct scmi_msg_settings_get),
+					    &ipriv);
+
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int
+scmi_pinctrl_settings_conf(const struct scmi_protocol_handle *ph,
+			   u32 selector,
+			   enum scmi_pinctrl_selector_type type,
+			   u32 nr_configs,
+			   enum scmi_pinctrl_conf_type *config_type,
+			   u32 *config_value)
+{
+	struct scmi_xfer *t;
+	struct scmi_msg_settings_conf *tx;
+	u32 attributes;
+	int ret, i;
+	u32 configs_in_chunk, conf_num = 0;
+	u32 chunk;
+	int max_msg_size = ph->hops->get_max_msg_size(ph);
+
+	if (!config_type || !config_value || type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, selector, type);
+	if (ret)
+		return ret;
+
+	configs_in_chunk = (max_msg_size - sizeof(*tx)) / (sizeof(__le32) * 2);
+	while (conf_num < nr_configs) {
+		chunk = (nr_configs - conf_num > configs_in_chunk) ?
+			configs_in_chunk : nr_configs - conf_num;
+
+		ret = ph->xops->xfer_get_init(ph, PINCTRL_SETTINGS_CONFIGURE,
+					      sizeof(*tx) +
+					      chunk * 2 * sizeof(__le32),
+					      0, &t);
+		if (ret)
+			return ret;
+
+		tx = t->tx.buf;
+		tx->identifier = cpu_to_le32(selector);
+		attributes = FIELD_PREP(GENMASK(1, 0), type) |
+			FIELD_PREP(GENMASK(9, 2), chunk);
+		tx->attributes = cpu_to_le32(attributes);
+
+		for (i = 0; i < chunk; i++) {
+			tx->configs[i * 2] =
+				cpu_to_le32(config_type[conf_num + i]);
+			tx->configs[i * 2 + 1] =
+				cpu_to_le32(config_value[conf_num + i]);
+		}
+
+		ret = ph->xops->do_xfer(ph, t);
+
+		ph->xops->xfer_put(ph, t);
+
+		if (ret)
+			break;
+
+		conf_num += chunk;
+	}
+
+	return ret;
+}
+
+static int scmi_pinctrl_function_select(const struct scmi_protocol_handle *ph,
+					u32 group,
+					enum scmi_pinctrl_selector_type type,
+					u32 function_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_settings_conf *tx;
+	u32 attributes;
+
+	ret = scmi_pinctrl_validate_id(ph, group, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_SETTINGS_CONFIGURE,
+				      sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(group);
+	tx->function_id = cpu_to_le32(function_id);
+	attributes = FIELD_PREP(GENMASK(1, 0), type) | BIT(10);
+	tx->attributes = cpu_to_le32(attributes);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
+				u32 identifier,
+				enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_REQUEST, sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(identifier);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_pin_request(const struct scmi_protocol_handle *ph,
+				    u32 pin)
+{
+	return scmi_pinctrl_request(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
+			     u32 identifier,
+			     enum scmi_pinctrl_selector_type type)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_request *tx;
+
+	if (type == FUNCTION_TYPE)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_validate_id(ph, identifier, type);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->xfer_get_init(ph, PINCTRL_RELEASE, sizeof(*tx), 0, &t);
+	if (ret)
+		return ret;
+
+	tx = t->tx.buf;
+	tx->identifier = cpu_to_le32(identifier);
+	tx->flags = cpu_to_le32(type);
+
+	ret = ph->xops->do_xfer(ph, t);
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_pinctrl_pin_free(const struct scmi_protocol_handle *ph, u32 pin)
+{
+	return scmi_pinctrl_free(ph, pin, PIN_TYPE);
+}
+
+static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
+				       u32 selector,
+				       struct scmi_group_info *group)
+{
+	int ret;
+
+	if (!group)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
+				      group->name,
+				      &group->nr_pins);
+	if (ret)
+		return ret;
+
+	if (!group->nr_pins) {
+		dev_err(ph->dev, "Group %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	group->group_pins = kmalloc_array(group->nr_pins,
+					  sizeof(*group->group_pins),
+					  GFP_KERNEL);
+	if (!group->group_pins)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
+					     group->nr_pins, group->group_pins);
+	if (ret) {
+		kfree(group->group_pins);
+		return ret;
+	}
+
+	group->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
+				       u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->groups[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_group_pins_get(const struct scmi_protocol_handle *ph,
+				       u32 selector, const u32 **pins,
+				       u32 *nr_pins)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (selector >= pi->nr_groups)
+		return -EINVAL;
+
+	if (!pi->groups[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_group_info(ph, selector,
+						  &pi->groups[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*pins = pi->groups[selector].group_pins;
+	*nr_pins = pi->groups[selector].nr_pins;
+
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
+					  u32 selector,
+					  struct scmi_function_info *func)
+{
+	int ret;
+
+	if (!func)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
+				      func->name,
+				      &func->nr_groups);
+	if (ret)
+		return ret;
+
+	if (!func->nr_groups) {
+		dev_err(ph->dev, "Function %d has 0 elements", selector);
+		return -ENODATA;
+	}
+
+	func->groups = kmalloc_array(func->nr_groups, sizeof(*func->groups),
+				     GFP_KERNEL);
+	if (!func->groups)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
+					     func->nr_groups, func->groups);
+	if (ret) {
+		kfree(func->groups);
+		return ret;
+	}
+
+	func->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
+					  u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->functions[selector].name;
+	return 0;
+}
+
+static int
+scmi_pinctrl_function_groups_get(const struct scmi_protocol_handle *ph,
+				 u32 selector, u32 *nr_groups,
+				 const u32 **groups)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!groups || !nr_groups)
+		return -EINVAL;
+
+	if (selector >= pi->nr_functions)
+		return -EINVAL;
+
+	if (!pi->functions[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_function_info(ph, selector,
+						     &pi->functions[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*groups = pi->functions[selector].groups;
+	*nr_groups = pi->functions[selector].nr_groups;
+
+	return 0;
+}
+
+static int scmi_pinctrl_mux_set(const struct scmi_protocol_handle *ph,
+				u32 selector, u32 group)
+{
+	return scmi_pinctrl_function_select(ph, group, GROUP_TYPE, selector);
+}
+
+static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
+				     u32 selector, struct scmi_pin_info *pin)
+{
+	int ret;
+
+	if (!pin)
+		return -EINVAL;
+
+	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
+				      pin->name, NULL);
+	if (ret)
+		return ret;
+
+	pin->present = true;
+	return 0;
+}
+
+static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
+				     u32 selector, const char **name)
+{
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	if (!name)
+		return -EINVAL;
+
+	if (selector >= pi->nr_pins)
+		return -EINVAL;
+
+	if (!pi->pins[selector].present) {
+		int ret;
+
+		ret = scmi_pinctrl_get_pin_info(ph, selector,
+						&pi->pins[selector]);
+		if (ret)
+			return ret;
+	}
+
+	*name = pi->pins[selector].name;
+
+	return 0;
+}
+
+static int scmi_pinctrl_name_get(const struct scmi_protocol_handle *ph,
+				 u32 selector,
+				 enum scmi_pinctrl_selector_type type,
+				 const char **name)
+{
+	switch (type) {
+	case PIN_TYPE:
+		return scmi_pinctrl_get_pin_name(ph, selector, name);
+	case GROUP_TYPE:
+		return scmi_pinctrl_get_group_name(ph, selector, name);
+	case FUNCTION_TYPE:
+		return scmi_pinctrl_get_function_name(ph, selector, name);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
+	.count_get = scmi_pinctrl_count_get,
+	.name_get = scmi_pinctrl_name_get,
+	.group_pins_get = scmi_pinctrl_group_pins_get,
+	.function_groups_get = scmi_pinctrl_function_groups_get,
+	.mux_set = scmi_pinctrl_mux_set,
+	.settings_get = scmi_pinctrl_settings_get,
+	.settings_conf = scmi_pinctrl_settings_conf,
+	.pin_request = scmi_pinctrl_pin_request,
+	.pin_free = scmi_pinctrl_pin_free,
+};
+
+static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	int ret;
+	u32 version;
+	struct scmi_pinctrl_info *pinfo;
+
+	ret = ph->xops->version_get(ph, &version);
+	if (ret)
+		return ret;
+
+	dev_dbg(ph->dev, "Pinctrl Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	ret = scmi_pinctrl_attributes_get(ph, pinfo);
+	if (ret)
+		return ret;
+
+	pinfo->pins = devm_kcalloc(ph->dev, pinfo->nr_pins,
+				   sizeof(*pinfo->pins),
+				   GFP_KERNEL);
+	if (!pinfo->pins)
+		return -ENOMEM;
+
+	pinfo->groups = devm_kcalloc(ph->dev, pinfo->nr_groups,
+				     sizeof(*pinfo->groups),
+				     GFP_KERNEL);
+	if (!pinfo->groups)
+		return -ENOMEM;
+
+	pinfo->functions = devm_kcalloc(ph->dev, pinfo->nr_functions,
+					sizeof(*pinfo->functions),
+					GFP_KERNEL);
+	if (!pinfo->functions)
+		return -ENOMEM;
+
+	pinfo->version = version;
+
+	return ph->set_priv(ph, pinfo, version);
+}
+
+static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle *ph)
+{
+	int i;
+	struct scmi_pinctrl_info *pi = ph->get_priv(ph);
+
+	for (i = 0; i < pi->nr_groups; i++) {
+		if (pi->groups[i].present) {
+			kfree(pi->groups[i].group_pins);
+			pi->groups[i].present = false;
+		}
+	}
+
+	for (i = 0; i < pi->nr_functions; i++) {
+		if (pi->functions[i].present) {
+			kfree(pi->functions[i].groups);
+			pi->functions[i].present = false;
+		}
+	}
+
+	return 0;
+}
+
+static const struct scmi_protocol scmi_pinctrl = {
+	.id = SCMI_PROTOCOL_PINCTRL,
+	.owner = THIS_MODULE,
+	.instance_init = &scmi_pinctrl_protocol_init,
+	.instance_deinit = &scmi_pinctrl_protocol_deinit,
+	.ops = &pinctrl_proto_ops,
+	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
+};
+
+DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(pinctrl, scmi_pinctrl)
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 3e91536a77a3..c02cbfd2bb03 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -355,6 +355,7 @@ void __exit scmi_##name##_unregister(void)			\
 DECLARE_SCMI_REGISTER_UNREGISTER(base);
 DECLARE_SCMI_REGISTER_UNREGISTER(clock);
 DECLARE_SCMI_REGISTER_UNREGISTER(perf);
+DECLARE_SCMI_REGISTER_UNREGISTER(pinctrl);
 DECLARE_SCMI_REGISTER_UNREGISTER(power);
 DECLARE_SCMI_REGISTER_UNREGISTER(reset);
 DECLARE_SCMI_REGISTER_UNREGISTER(sensors);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b807141acc14..64043e269701 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -737,6 +737,80 @@ struct scmi_powercap_proto_ops {
 					  u32 *power_thresh_high);
 };
 
+enum scmi_pinctrl_selector_type {
+	PIN_TYPE = 0,
+	GROUP_TYPE,
+	FUNCTION_TYPE,
+};
+
+enum scmi_pinctrl_conf_type {
+	SCMI_PIN_DEFAULT = 0,
+	SCMI_PIN_BIAS_BUS_HOLD = 1,
+	SCMI_PIN_BIAS_DISABLE = 2,
+	SCMI_PIN_BIAS_HIGH_IMPEDANCE = 3,
+	SCMI_PIN_BIAS_PULL_UP = 4,
+	SCMI_PIN_BIAS_PULL_DEFAULT = 5,
+	SCMI_PIN_BIAS_PULL_DOWN = 6,
+	SCMI_PIN_DRIVE_OPEN_DRAIN = 7,
+	SCMI_PIN_DRIVE_OPEN_SOURCE = 8,
+	SCMI_PIN_DRIVE_PUSH_PULL = 9,
+	SCMI_PIN_DRIVE_STRENGTH = 10,
+	SCMI_PIN_INPUT_DEBOUNCE = 11,
+	SCMI_PIN_INPUT_MODE = 12,
+	SCMI_PIN_PULL_MODE = 13,
+	SCMI_PIN_INPUT_VALUE = 14,
+	SCMI_PIN_INPUT_SCHMITT = 15,
+	SCMI_PIN_LOW_POWER_MODE = 16,
+	SCMI_PIN_OUTPUT_MODE = 17,
+	SCMI_PIN_OUTPUT_VALUE = 18,
+	SCMI_PIN_POWER_SOURCE = 19,
+	SCMI_PIN_SLEW_RATE = 20,
+	SCMI_PIN_OEM_START = 192,
+	SCMI_PIN_OEM_END = 255,
+};
+
+/**
+ * struct scmi_pinctrl_proto_ops - represents the various operations provided
+ * by SCMI Pinctrl Protocol
+ *
+ * @count_get: returns count of the registered elements in given type
+ * @name_get: returns name by index of given type
+ * @group_pins_get: returns the set of pins, assigned to the specified group
+ * @function_groups_get: returns the set of groups, assigned to the specified
+ *	function
+ * @mux_set: set muxing function for groups of pins
+ * @config_get: returns configuration parameter for pin or group
+ * @config_set: sets the configuration parameter for pin or group
+ * @pin_request: aquire pin before selecting mux setting
+ * @pin_free: frees pin, acquired by request_pin call
+ */
+struct scmi_pinctrl_proto_ops {
+	int (*count_get)(const struct scmi_protocol_handle *ph,
+			 enum scmi_pinctrl_selector_type type);
+	int (*name_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			enum scmi_pinctrl_selector_type type,
+			const char **name);
+	int (*group_pins_get)(const struct scmi_protocol_handle *ph,
+			      u32 selector, const unsigned int **pins,
+			      unsigned int *nr_pins);
+	int (*function_groups_get)(const struct scmi_protocol_handle *ph,
+				   u32 selector, unsigned int *nr_groups,
+				   const unsigned int **groups);
+	int (*mux_set)(const struct scmi_protocol_handle *ph, u32 selector,
+		       u32 group);
+	int (*settings_get)(const struct scmi_protocol_handle *ph, u32 selector,
+			    enum scmi_pinctrl_selector_type type,
+			    enum scmi_pinctrl_conf_type config_type,
+			    u32 *config_value);
+	int (*settings_conf)(const struct scmi_protocol_handle *ph,
+			     u32 selector, enum scmi_pinctrl_selector_type type,
+			     unsigned int nr_configs,
+			     enum scmi_pinctrl_conf_type *config_type,
+			     u32 *config_value);
+	int (*pin_request)(const struct scmi_protocol_handle *ph, u32 pin);
+	int (*pin_free)(const struct scmi_protocol_handle *ph, u32 pin);
+};
+
 /**
  * struct scmi_notify_ops  - represents notifications' operations provided by
  * SCMI core
@@ -844,6 +918,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_RESET = 0x16,
 	SCMI_PROTOCOL_VOLTAGE = 0x17,
 	SCMI_PROTOCOL_POWERCAP = 0x18,
+	SCMI_PROTOCOL_PINCTRL = 0x19,
 };
 
 enum scmi_system_events {

-- 
2.37.1


