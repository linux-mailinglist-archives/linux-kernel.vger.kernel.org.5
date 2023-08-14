Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514977B6E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjHNKhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjHNKhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:37:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69DA10C;
        Mon, 14 Aug 2023 03:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/9F9nioAX+QQojKjta5xqrBlF3Ue5QofH9eBzq0RmbDccPwl7k3FgoJDw/TrW7uP2N7qUgZGQFhP6bEB7cRFIMXy38JOpGofyx641LagaDLXQzRgUbhbCzyiQNNkLyzbTKsazMZxpLc3ocVEfyThwF1pvqnawSgrN0nLAlLVX466oZK/y+sSiqD+rg7s7xbwUEHv+YNyW/HR2ytto0w/Y5/1BcT+Wxn7DWvsOFi+GCwRZW4bHwOwb8KH9BMeJg4XjCEQkPCC0HEhtAJTFfhyW2RKmXmxyAIQ9ey8TIqHI9utT6K8+d72en7Awm0DgurQSfktAzKroI9TybiH+Bxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnwPH3pq96T+Zzaklp2pSzzWTeNVi3Kc0UXMFo83+kY=;
 b=H/ZaroiXYhQzhCoCkqWt3OngRJY1DjO+TifDVVt16UnAJrp+HRPveJjiYoU/5/2aEaMddM2Z0tb6jDWYY5tDJTaslCVNRkYEQDyFIlZEHbvUxp1GJT+twOiOBWiUBzO653bAPMKpzdKozVRzthvOOXY/J4vnCzct+SizeSwPyKyKtPzaJJ20lxUmstoV1i4B5ymlOKI3lDRZXP6SNsHmG+LzjqSeSb8YPLH753Ai+d2pvviYw4FOBjRN/OO8xLboho4gO7h0uhe5N/BKeXf8fweHCtwiZpATFz6Al+vAkeOfity2D7BcY2xq1Ha9xY0FfSYZ591fxwWV0A7ivZxN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnwPH3pq96T+Zzaklp2pSzzWTeNVi3Kc0UXMFo83+kY=;
 b=liHdnMqhYxT62th/47qrZE+0v661GrK23la9eXjrtJ0q5lr4yGhRbJ1khfqB1Xx+ThUMnwujI/7j4yRH28broNyh15M5sBvTUvWLI0cPKuUZyocXzFrb2itHOc7doIOutkirw052TYr4vZCeLpn8AcTxgG09DVvuZ18frzlr5LE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:37:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:37:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 6/8] genpd: imx: scu-pd: initialize is_off according to HW state
Date:   Mon, 14 Aug 2023 18:41:25 +0800
Message-Id: <20230814104127.1929-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230814104127.1929-1-peng.fan@oss.nxp.com>
References: <20230814104127.1929-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a9d89e-8994-4d6b-e449-08db9cb26ad3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tNID4DbVpEchxwjB4dxGSNKOQfw7064mcWL0wFQx+OCoUeTpAKFyAoB1A62fdpLkN3yzXhWxaHsHyW1iDD1W5TaLX6Yawvch9yYlb9nsmirFnl4SWRc39Fjb9x5UZsNyp6YXKrffx+xvaVWcV5p5c5ywAa9bz+wT2KoOqMLsUqtsUkTEfUGozSDEIyhZDkQG7bM96evZKXSic2Y/ZA/qOy+22kDPDQAoPyKo7JvNpl77WX1OGxaRe+CqF0z9XDJrCe1fze/pMFvDbPeHyU8ceeX4O+kUsF28yxe1BHj9WjSzvPfn/kTya0lVy10ehbKzX0vNhs5LcDWgqjtnRnie+nDmVgmgyYWKRLe2UeeUVLle7+1Gp21vsWckdx1F2TZWPh0tbQFco8oBfV5NT/nZkN/sJN2YpcuhUXSf1UAyqokbx8ldCgXQ7s91ftM0zkeXeShmCFwVQXvo/iJN6QRdAfgnh4CGFtU8vLrQMkOmxBYiFKqRR0oMFC+Z/KRlm357NTggJye9ycyL4GBAp4nQUqiWbC15KDTzme55s/zQ7FT+lx2xpVJwLpN65C1qB5mCyfvLQrfa0sbuEoAkzDwpQYs2jxOFJo7ORva8DBBR6bzWPSWmW1GLwKQhxOfKMxR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(1076003)(52116002)(6512007)(2616005)(66946007)(66556008)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PgD0BYp1cDLiMF7Gdcgw/qaG8QdzZW4rlHV/3pwyg+SHw9CpwZl3U0M8HF09?=
 =?us-ascii?Q?3NAv7l680cXO7JCYx6DTFPDlvrAyWuX9TWKptOLTJdloMogz/Vd9rADgF/eR?=
 =?us-ascii?Q?23mXkc3FVAD0oR+XhzZ8dZzph2moRNY9ZcLaDtCEz8+Wi83aW/q8IO6WRU4r?=
 =?us-ascii?Q?8hgChYKQFwPr3JxyRve1tldlTDdShN87ybWLbk8XOpwkVIe9jYj69ZXlN5dg?=
 =?us-ascii?Q?4CtmMMGM7wW8+TpC6sALt1AmpvF2fYRRceaaATUov2bY02D5VsivypW0QcpJ?=
 =?us-ascii?Q?4QH2zXiVovdwJ8F9f0Qsg2JdhAJRY4PAtL7CbPEO/cJzwe5E5LZg5BEPVWns?=
 =?us-ascii?Q?OQuLjxpbecTiJqjvKXKTHXKN4Nrjfw9+S0bxQnwqJYWbX80C1RF6urngxZBq?=
 =?us-ascii?Q?hardgp2Twr3yBxQL5aGP0GemzBpBuLBLBO9bwjPl8FwsZ+lSfHVASqQnjG4K?=
 =?us-ascii?Q?680V9MlGQphRZUs8cdNej+LdH+F67/u6r4Ocj0FmVHDskoQYv3M/hZCPutZq?=
 =?us-ascii?Q?lYgrcZWNVD7KULeOewkJ15YXp4q6eIZmW1gY68Ms3MQbZ3tJXZmgUIfd/y2d?=
 =?us-ascii?Q?UH3OcRqnuWaHZmxXBUh6u2tnJ5QtpGVVBB6cHJur+pGQzcLHD6MfivZh1VO8?=
 =?us-ascii?Q?0wejmzbU1qDpXeARwS3lF7dFjtWD2+wFzPctgG1FD5JWZ2nbtgT3Kc66m+he?=
 =?us-ascii?Q?q9cgl279+78zwebrOwe8Cj/KP6xeNlMwlCAst+mXn2noiNP73JTF/fVZkrth?=
 =?us-ascii?Q?rHuOEuRqK+EkwhauUqnORuhYogmiatYstOnGCIqcbM/BgCg2UK87olc20twp?=
 =?us-ascii?Q?B0IqCQXcQVs98QtUXpr0s9hS+t9fQc0i8RjI+zbiJoDX9k2NA8jm6ZMmyamU?=
 =?us-ascii?Q?9ij4khFlTk8j7stgwwhHC0HqOZymwrfrT++HI+HdSvtC/3gDKSWave+jWtme?=
 =?us-ascii?Q?Yz08wfBlENBNKgv566+ui48M/spf74sHKZHN+j+a8B3rsG+Sm2bIXnDPECxB?=
 =?us-ascii?Q?4SFp+y5B9H8N4GfVqxlCuXkobaMNMYmh25aiwJng/5tj+eMdeilDPqXPZT/Y?=
 =?us-ascii?Q?NUPPBHA8SkIjKlT+L9aBnsGojUWGAIFQkv9ibIb0MptmqQkWe238j6ZTQhgj?=
 =?us-ascii?Q?P1e+fj3VFVcbF3KM1+bwhFrEOMQgAgoAJCtNC1/Eky+xMYJ92I+NEjuKQdTa?=
 =?us-ascii?Q?Zs1Ga7dHLVbjhcZ656nT3inBPt3oWAXQtx1QJrd73yMTb6/4t4WTX/395Q+S?=
 =?us-ascii?Q?GB3zwacMdHGNKX8iD6fApkK3dDE1SvZt6iEzcPMQCF+YWla7hC83jFnaA/XU?=
 =?us-ascii?Q?thforkn+KDQh0oarAFte47pSIugP+h51NZmyDpXyffTACNodVGgwAcZV0VkR?=
 =?us-ascii?Q?QBPDBjtn8o6SGYIiX2noh/DYjkbdEk0GYX5w2PTz1JS3dmD8nvVAUhLsKsSv?=
 =?us-ascii?Q?T8W7RYnOL+mf3gFws35Blg/uCnInZfVCFOlg4o3eFvVb2hkdHGbPbXqvxkko?=
 =?us-ascii?Q?j+txdkoLj3CnfKWOkiYMcNEE1pm3h1sMffKLV9lKY9s+TXq6K6XD8yNYocpV?=
 =?us-ascii?Q?sYrbXsJnK5VrGC9cYTWeN/OJxUOqXInbmK7/q34u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a9d89e-8994-4d6b-e449-08db9cb26ad3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:37:11.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrlqhbcNeUVk6ao5oNxxxBjt6ZFoDDfe5Ys5hHJWXD1WxdU6EkZW4yuHYB5AmsYaC8PzEPCaEQD6fJp3eB6/Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7216
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index fa840ebe38c5..2f693b67ddb4 100644
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

