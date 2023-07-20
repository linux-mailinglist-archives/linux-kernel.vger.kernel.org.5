Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1AE75AAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGTJ2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGTJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2503349E8;
        Thu, 20 Jul 2023 02:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GliF0/WfzoemyqGXr2xWSb9k/WF32XFVlmKNAub8pF2q8IsSuAHEzUDbX/XI8ww5rKB4fh02N/4esEp9c584vACw+/6fsJKYN88i96OQv9qvfrOlGfkL7ejptMKE12FLMhD9ait2rAMcSrLCNLGAP1qh2eOZ1NY5zCJJqXSQzCrz4BfMFJrHLFR9Y/46TyiYx6XZQEnIsrGn1mj91/yxxQ0V2HT3zEHsV+F+f+I07yUjGLRUdazOnf7a1t5Gk/32HbzHG2vQOwrdGrswo2rDfv1TUvDZULnHDYOL+IQWQmFssjOvDw3pgeBW/USbvQ5hzduirivOs3pKrdJX7XUHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/iHQ5PAGcOgMJAor/F/ceCn44S0Z+sRfdH1VFdu5dk=;
 b=Zdy4AGFtHE3Ufcb8OH9tid3IhJsAmqrbVt2kjhtoLI+bNMcBxWKcEkaSCtQEjLgdmu5/e3S2+4nJfDC+SXqQThpwCZ45KQV9pNz4m8cszqLeJeDqU3NsFgKSd61IrDteedbKmfUtRER3cyzRr0CbqSTOMJfV7Wz1/7mglm7W31/n+HEVErkvj954WHVPi3RBYCwfMUVkx0feJRiJzcdoecRjzabPnm2+EdVcLAyoj6rteIPSnV/lbDZzCp+C6QX85DwX1CqrWYRY2l8q7eUuo4AhSCYHqn7Fl5R3fUmIVNPqJWKTmESK7ALuntHbE7tjYoN9m7VnK4VecqXFcJh1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/iHQ5PAGcOgMJAor/F/ceCn44S0Z+sRfdH1VFdu5dk=;
 b=gAbWEvjRddY9ZPDrRrvhbEqFXeNt47eEj0VClVEMfjgc64klyWM9Ulu67FY77TnmtEwNhP/UwfZv4wZB4/xA7mT/3rTZrwOAzYGT77ivPb8dR0jbYkk34QvEmBm/K5u2D09xg3FYf45dENnuIxLuoKpVc5rKFEKb5X9ai3BdpVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:12:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:12:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 6/8] genpd: imx: scu-pd: initialize is_off according to HW state
Date:   Thu, 20 Jul 2023 17:16:59 +0800
Message-Id: <20230720091701.517197-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720091701.517197-1-peng.fan@oss.nxp.com>
References: <20230720091701.517197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: cffc4795-ff8c-483e-1c0b-08db89017616
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mklc26hmLXDkKNW5E/Bgk0gimIw97AMzE8NYLgLWbRI7UpdWJD+AC/DT2hk6ubkAn5ulIBtmo0Snb7+QfiEQ00J2gs8KKha7O9q3IApj+ydddMqmyQ5QLnwDgMIsmfLMnydl8dpvmBxP7iM406nAg7p6WvZ29CI/JpAGU+SCUpGlYtnwtsenjVF+ZLZZbH3d9xYihbGuwX7disq6k65SMcLiAb7INvrBzidpbW9aTQ+NxE3x1kv26/wypendbFdzZKt3vI2npf/q+Id3UTLMinZXhFl44unkg+R/5B2DyPxuWpRMDlJ1NM2vspyQ2tTZi8HE+k19TQBIwp06256w++jRss/aQopz/pn6GyhTY3BoMSDfE6lLr8nv6MtIV8bGxmUkXZAwRGKEWed+LyMsuxNs24GvHJf9s27WJp+NFTFybAPSm26KF2IIov0bpK2wTZbfPRKLbfaws+T/8Ga28/FUj8ja2YHjLKT+CRz22inlqtJU+pafDKUW8/6c4o75ea8U9F03iKfx/AA7ts5GJy9JoHHyRThCM2+9Pw1NFgfUalW/X9GJorq6wyEpvmv6nNmXg6//Ff3jBqhTx3lVWNGmqxoqx6tnD5XUfpQye8pRm5ImEfNtSMIsV+DSn96J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66476007)(478600001)(41300700001)(26005)(186003)(1076003)(6506007)(6512007)(6486002)(6666004)(52116002)(316002)(4326008)(5660300002)(8936002)(66946007)(66556008)(8676002)(2906002)(2616005)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GFgN47Uuy54irHeimbP+26FtCsfG7m8yr/rudgIWcnUPmuzTjwbXXVZsOb4Y?=
 =?us-ascii?Q?smw8tTcTYd9MkOH1P/EJomUJGGb1GuVaHmdvPPSXWnGRTGs4YLbh8W2mmD3s?=
 =?us-ascii?Q?721hMc/dFDPkuz2OY2p3OkUn+hcmr1cY0XdOK5WGY7gghr/e8vFdxhJhIDf0?=
 =?us-ascii?Q?RLuEAVKk+rY3v41ousfNqhMCQBVWxQ9Sz7gWI7WZLLB2lSyJHL9m1FPODBRb?=
 =?us-ascii?Q?K+GdbJkp33Xcfxp1/QTEKmMEV73nj6liitqATDBwMwvfpBia8cdBv78JjV/u?=
 =?us-ascii?Q?lmeqyD4YQ5ab9Jmws20bGCOYnmkFfdFbTdGON/NYPrgWROfZfFWpOBB4mjyc?=
 =?us-ascii?Q?HKTvDYm+Ns9IuUtnraof8MrPU3i7/Bho9avIfHgMMmBqYL8QfuS5eb7p93dn?=
 =?us-ascii?Q?pr7Cra2CkP9xeYDj+nxh+EJwB5yYPmtDRuu1asJ30884UTspmjlDuKQpqGpy?=
 =?us-ascii?Q?HXwX8DFdABF6REj70dqAgvP1CPPtFgKhO93UVllDV86Arp34LycL6e/d0w32?=
 =?us-ascii?Q?lIi8L2GZKenU2NntXi6ZHzYpo3k5xL8vr6qkZdA33KZCa5TH9wEzzxm5mQiy?=
 =?us-ascii?Q?ODWxeq5rvbfifCuTHjaTb0RT/xgXOOZMjTi4tJZnatdAxXnzs2UaOjXpg4dW?=
 =?us-ascii?Q?IR/DAFo+o736fodoW+l8UhGS+q/HaQ0MtcFw2iL9NLLhKiHKbZ3HA2b5VBYn?=
 =?us-ascii?Q?WX6/4tmvpeCO6dlz4pWL+XXiZwMfFHOFcmNolqqb/kuMUxiN1UEShc0pDmKq?=
 =?us-ascii?Q?hjUC6fdi5OTiPIYebiQuHg6ajdm4tiMQxG/E0hDx8cjc4V+AbKNM0/Ohq+jW?=
 =?us-ascii?Q?cqUwFp88xi6wmrvyzMMQ+/cuemebFoOoNbwJlQlbSW9o/Nxjt5Qg7T7wfBtv?=
 =?us-ascii?Q?+ZEyaKJ4CNXX8RAetswXPOzUAZbIT1ugrHTUXKOeAuOE6rOTrxaAOBhKjbQp?=
 =?us-ascii?Q?T+Z5c4EhywP+N7hgSTg+GH7LViKM1z/uRXYqJ20glWG4Yd8FzSvPyAkWqs16?=
 =?us-ascii?Q?uzcvIIxYIW/goIJFllYVRGUBsmOiW2SD9p2BEs9OCYaLY7Q6IGfPccTqyq1Q?=
 =?us-ascii?Q?qn6e9wYh9rxS/mHB+0pFlK/9piU2vSe0cVk71V5gnGJ5QnPjV+IRPGmp/55z?=
 =?us-ascii?Q?QvNp/GbWr+AeXS61lCL0ECL3ybjcq8X1ybTlrKtbjoWuVfff6LwCXQFpfvNj?=
 =?us-ascii?Q?r/gbYFP4hcE4B1VZS0ynz0fIyc8FBemTbXJ5+6TdCjVcUTKxbh0qWQgou4f/?=
 =?us-ascii?Q?lyDp2VkTiDYElEvWIRDuZstpFy6wRXnLiKeIhizR3TJ+I5DYxI39dmnbGm92?=
 =?us-ascii?Q?iLGIjAnHopZ6dHNsgHaXnS+G7oDAnEzZOvOtImm0DULvVlH9S/vwiMfpfADQ?=
 =?us-ascii?Q?tyFT9TUT9xsXKpOaRE9InBOIomxEfRuCweJV2az/k+eHzCKZXzEr0cnE10OF?=
 =?us-ascii?Q?3zHcUJJo/FV39UQ/FBJVmouxFHaiFyRQMK66KwR/WOzp2MajqNF21wZGFhda?=
 =?us-ascii?Q?RjyE84B0pCCDEEC6ZZVmhPDnz9bZO6p8nogRK1xTydGfpOFhs4iArgAU7rc3?=
 =?us-ascii?Q?BaUce2icjXglyYLTyCm0IjyYTcwkPR+AKVgLKv3t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffc4795-ff8c-483e-1c0b-08db89017616
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:12:37.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfHoeA0rK3fsricPMbl1T7kRaUCBy1Cm0u0SzbEHHNDgEW6XnUbjACGbBd6grcrLgxRikuj6X4H37Toy5JVZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/genpd/imx/scu-pd.c | 59 +++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 9f8dac7950fe..763af1ac454d 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
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

