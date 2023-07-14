Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6C6753606
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjGNJFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjGNJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:05:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32CC30EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmpQ1/UBky70x2zXowTDAfx10yP3QXul9IwdvxU6FAtFiZnposqfA4FPq4S4234vIg6/pSbz3HfAPKArmGjRyT2GPzR9luHW53MUgpTFn3H+f4CtdA7mWWOuSwVzB9UbsrXldLwI+ViKwN7TsW6EWfAjrpLwx8Gs0xga4X2MMBMWT2GLI7mMS8fPD/QkKTRRBHTubZOcx5Hr1+61Cy1w54ikKe9xjlH3gaaDs/iW2gK+oD/+BAgnKeksOuM9r9lVs6DE9jtFvRAQEgi3GO7hkor7zCIUYxcMKMlaC1AAzkkgfH8xCuz03urroYCNj1U3rSIsKTM70uTJyo7VmRYHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pne3XI7HNG6H4I8m6IhAalMSYqMmed17grQSAg3Z4Rw=;
 b=F1ZrgTfFHAasQt77b+RMysEaFezyB1aRr5cvl1IGviVF6maSGk/RpMt5h00HTH956c1w7pAmMUqpkgBxYtA1zGMRlxjLDBegwJavqSc6tK20KtNxyHE25Yvz7vWhPiSQzdoXG6Rv92Vz1Y5un5E6vOOg9BAmz37Ynjm/9AqKxgETrVSy8tA8O02czYpeE39deHw/4kazFwZ6nCIKIVyXgr9JyLWzS+Ngz+0mOAssTrPf4UcxSmGa8Kz3s/dhSWPsLV1BCq6q1GhgBPTtnfJVeRvOvJIrxqI9+Rdk8cAxE53MwX8qi2vTymIKBTXK8xAPh2rzOecg3/F8xJ11aiFabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pne3XI7HNG6H4I8m6IhAalMSYqMmed17grQSAg3Z4Rw=;
 b=bYS/xm94acGc/kEFpMULSNxTf46YSUbjtbpQDIXJPrc098euHDPoTgk2b5O5986hxVGTX8rCHe9nn1uCZOd14Uy1Q1WDGqJW0bIypRkSUqUXM7A71toDYWmKYS4DhyO/aiBP9K5P5J1g0D79L+B8Knhq+UEt9RtTEHxI/Gmvrms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:05:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:05:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/7] firmware: imx: scu-pd: initialize is_off according to HW state
Date:   Fri, 14 Jul 2023 17:09:34 +0800
Message-Id: <20230714090936.937344-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230714090936.937344-1-peng.fan@oss.nxp.com>
References: <20230714090936.937344-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 752a5484-8a2c-40b4-1064-08db84496ccb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npddWPRv0CBltL2AHhHY9byw7aUlvN/rh/ai68KbK0/eN78U5KodvJENBAy3O5XRQWANpztRPqZKCIw7ZJt0mweyIB6vp1aeFp0ljlvJZvflRy5kl2zNmcgX5X8b3m41Z0rQlwpCkHLkKesDOha05ZeRLwFci596ijCTTXH+UV3M3Cc8WJ6IH7e1WGnsZcqZmYj4RRLV27+rsbgO+r7wZBmOQBoTI2TuzFYjaQPMPM1qeGYlhXYfTUppjS3HoAp0nwTGSs3YAdGkLqxRH5nexPkdPbkHy9Rx4F6vm6BXq5LdrCUVbx25gA39IhUyR+MIgi15X6r+NAshT3elYjoBbb6zxTNhbq0M+zzWem5eomJWrfZ5LrwiqMh4aB/qaspZOSPBM4eJGG3i1x0T5t4QmWqxUgaHvTWdg/Lb3NokcKz7bmDnFMioYQPfWmrPDYDSG9suof2RhLfcLwycmhCXUF2jbffBzLbdpcw9/3WJwF1H6bbrpvSrU4MvXlQ6jvWp1XCS8+n8wThX87bcGpqluPitQ7uOlHTCvigLcbMzyOQzCIn3IEpbD7bofNfby82SBAcVB/u9FZ+uIvd3dc6dmoCY8L+EZGKqmdSObPa5DP1/YiIjK+fwBct+E0lT5jfV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(38100700002)(38350700002)(6512007)(83380400001)(2616005)(186003)(26005)(1076003)(6506007)(5660300002)(86362001)(8676002)(8936002)(478600001)(41300700001)(6486002)(52116002)(6666004)(316002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PEysbVDY8C6Myoz1VYSKXWzt+BbCya4Fw+fr0mT+j1Xq5VnAJkSB8h0z9qWd?=
 =?us-ascii?Q?vccITXvdjnHdQfhtYvqJy/qKObsjre+DGYb5/QP5QsXooLiRMrZQco4o6T2E?=
 =?us-ascii?Q?QvADGb1CHkrn8e9q1rFkMtcAsZQ+JdvyLVk9A97yHX9b6GqOtrN4nEaEw7OZ?=
 =?us-ascii?Q?tjwntePFmn8nZ1AxciiJ6v63T3k/lOOLLTAfskZGF1pEPnIU2JKqQTIeOYb4?=
 =?us-ascii?Q?LnQwyxx+Rchpk9DzX2+VIbxXBR7Q1MN3n1Ze5WnnM59yLGwyJP4LtwnA22VX?=
 =?us-ascii?Q?q/G0sMoh88YJNIZY19pLnPSJfx88kCM3h1jtj0M7n5B0kG7J/s8JRcHQLEzt?=
 =?us-ascii?Q?s5SZLYZSvNp1/hUZ3Q0wA0y4n7o89wKj3Q9qHVRNbGgCEbeNWI860bsZA10N?=
 =?us-ascii?Q?c45EM526aEpREejgze57jN+/KRHB5ApjHBKRkwBxwSg/UO6HIsJOwCEcPBen?=
 =?us-ascii?Q?ZlmpNrxVY3PeaEdTTPDCc58gOeDltKO3YwODyfH1qxNj4NaSuPIzFMtW9Ljz?=
 =?us-ascii?Q?Np0TTrqpXoNaHfB78UpVHWQg9sguFn0JIOxwwilcCzAdF7YWUw1t1mM7lIZO?=
 =?us-ascii?Q?KF9HcpMk5XSBbg+quM6xAzmligzUzFYWW0f9/pp7gxUOCLTFCM45+R+SAZzD?=
 =?us-ascii?Q?xv4qYhFvw/4fV8v624w4jqJNrkvu0/Kugh7iy2LctY95uFlHYI10YcNG/Rkr?=
 =?us-ascii?Q?uxteng8Wer2nSQmdKmpf1DbcVNXsYMltMHYYt1ZUyU1PDx/CecxAk67JBIVx?=
 =?us-ascii?Q?TnFH2kqL/eIFIBcT3NwbiKEM42px4KVTJBlHIYYXs25bCdbqIAPM9vXMK3t5?=
 =?us-ascii?Q?Uf8rjLNJUUzqsgD4gJ5jIv0j+DJ3b8LWdGSBJ9Ezb8KJg+n+7Yrim1FuZ0oG?=
 =?us-ascii?Q?gMyR/GsDk8O2wtlwu9VQibpdg69DJ5/w9m7/DWONX/uhbGFOk2RPZfmWaFxZ?=
 =?us-ascii?Q?CXIdxD2YEpoHvTvKj9IXHcotN5L37yXyBZ/mDsS6V2+KmTfkg8gWaop9/oPS?=
 =?us-ascii?Q?+pbST9/33X2ArtEfhqgAUldmOWRt8Gw+KMzNGxNEf1Etx7RoFqMtaj1520II?=
 =?us-ascii?Q?S+ieUBVjCXt1ORyAowjYDJ+7STZ+Mdeb6eCvcdmTlAe1cDisMsUj0noZdiQ4?=
 =?us-ascii?Q?oQZkwbnJO2KgqiAL2JgRNQq2GNHJGfOL3V3Idc1IvPxt7lJI7rV0PJKrSaBG?=
 =?us-ascii?Q?NVqHrqe43LxIvdGp7qbJwlguawapfVemybe9IT01B3QMbSKWV05i5XhQSyFk?=
 =?us-ascii?Q?Ee3zIozNw2TVTYfxhP50D0nCOs81OWlbZ09irWCE8nSe9rLOajRSRmV5uLK4?=
 =?us-ascii?Q?qQPECSPe0Y/z1rLEVjMKii0fMcSZtZI7urNuZi2n+X4Qfz8e1EELSLIiTciF?=
 =?us-ascii?Q?SJ80DODQnmPRB+DnJbq2hTLF42QoXHdNpG4aUHFYuQSkojySxTi5Td0+j9VG?=
 =?us-ascii?Q?GHhTC3DrCD/m5f8vjKqxxaSdPqYqOUEqsCGw0CNE6uq83Co9/Nch+1Lv8a7B?=
 =?us-ascii?Q?DKvZkw8BtpyCwC/I45IlYPU2k8LR4biOnlcjj1cdoSpb09vzlKpK6DMyAQi7?=
 =?us-ascii?Q?oZyw6/5figghR/VMcxB6+wK19gzFrXsXKGu9BFBf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752a5484-8a2c-40b4-1064-08db84496ccb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:05:09.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToDT/EMWzGUsEpj1ko95LiKU8Z9UgUIIU/6kNNlwDaDb04qn9n6QYlAiYv1Kkg0WZZ42WXy8nsNoHdOaCWE7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The current code default set is_off to true except console resource,
this implies bootloader should power off all the resources it uses.

But this is not always true, let's check the HW state and set is_off.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 59 ++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 9f8dac7950fe..763af1ac454d 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -72,6 +72,22 @@ struct imx_sc_msg_req_set_resource_power_mode {
 	u8 mode;
 } __packed __aligned(4);
 
+struct req_get_resource_mode {
+	u16 resource;
+};
+
+struct resp_get_resource_mode {
+	u8 mode;
+};
+
+struct imx_sc_msg_req_get_resource_power_mode {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_get_resource_mode req;
+		struct resp_get_resource_mode resp;
+	} data;
+} __packed __aligned(4);
+
 #define IMX_SCU_PD_NAME_SIZE 20
 struct imx_sc_pm_domain {
 	struct generic_pm_domain pd;
@@ -96,6 +112,14 @@ struct imx_sc_pd_soc {
 
 static int imx_con_rsrc;
 
+/* Align with the IMX_SC_PM_PW_MODE_[OFF,STBY,LP,ON] macros */
+static const char * const imx_sc_pm_mode[] = {
+	"IMX_SC_PM_PW_MODE_OFF",
+	"IMX_SC_PM_PW_MODE_STBY",
+	"IMX_SC_PM_PW_MODE_LP",
+	"IMX_SC_PM_PW_MODE_ON"
+};
+
 static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* LSIO SS */
 	{ "pwm", IMX_SC_R_PWM_0, 8, true, 0 },
@@ -308,6 +332,27 @@ static void imx_sc_pd_get_console_rsrc(void)
 	imx_con_rsrc = specs.args[0];
 }
 
+static int imx_sc_get_pd_power(struct device *dev, u32 rsrc)
+{
+	struct imx_sc_msg_req_get_resource_power_mode msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_PM;
+	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
+	hdr->size = 2;
+
+	msg.data.req.resource = rsrc;
+
+	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
+	if (ret)
+		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
+			rsrc, ret);
+
+	return msg.data.resp.mode;
+}
+
 static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct imx_sc_msg_req_set_resource_power_mode msg;
@@ -372,8 +417,8 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 		      const struct imx_sc_pd_range *pd_ranges)
 {
 	struct imx_sc_pm_domain *sc_pd;
-	bool is_off = true;
-	int ret;
+	bool is_off;
+	int mode, ret;
 
 	if (!imx_sc_rm_is_resource_owned(pm_ipc_handle, pd_ranges->rsrc + idx))
 		return NULL;
@@ -394,10 +439,16 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 			 "%s", pd_ranges->name);
 
 	sc_pd->pd.name = sc_pd->name;
-	if (imx_con_rsrc == sc_pd->rsrc) {
+	if (imx_con_rsrc == sc_pd->rsrc)
 		sc_pd->pd.flags = GENPD_FLAG_RPM_ALWAYS_ON;
+
+	mode = imx_sc_get_pd_power(dev, pd_ranges->rsrc + idx);
+	if (mode == IMX_SC_PM_PW_MODE_ON)
 		is_off = false;
-	}
+	else
+		is_off = true;
+
+	dev_dbg(dev, "%s : %s\n", sc_pd->name, imx_sc_pm_mode[mode]);
 
 	if (sc_pd->rsrc >= IMX_SC_R_LAST) {
 		dev_warn(dev, "invalid pd %s rsrc id %d found",
-- 
2.37.1

