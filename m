Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE3577B6E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjHNKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjHNKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:37:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEB510F;
        Mon, 14 Aug 2023 03:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOI062OrkbK4gP4hav6CgFAie1HNj4jOZ6WFT4PEqOYHF3wA5KlZ1/TGxLNkjxUqyojw2ZwDtRkYaxTmyFFWZOOcv/ejqD/zlAn7TAKUaozm0SXvYY8URnn5eRvlmRMlnuKtpEXZ5WcYpcfZxym6vlg1VSePvEEbxVKMEOE/kak641KT7GIT4nJVv9VC2S27p0OL8BdrkL3NcBFFmKg38P4vbvm0W5Ct7Rm6NVCUJcqEQI3oBUUxagS/0cYreyGQKsCX9diG609iR7MNXBXh2hF7ZzD3EapeE0ubD42MCggUBKfJWevW0EmjJaNsE6z6cZntr7cAr47lFVoZ2lLyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTqXGAi4gv6df3uCGkaSZVTjEApwuAc+7+xXRdnwpqU=;
 b=HPfZ2CuRWnJEJ4G3o/YV4yNcwzePY5JF2dWUdpKCp0f8Q/8ZaXPxIPm/+w1qTxr76EKWJfolrJOmjYSBRZcmmw2mHoaduHXkXuFlbmbKT45+1nRG5UA/dMjyrbM2Hf98TMoa3AJ++DqVeHZmI0eQ6hZZswSWsh37m3f/HbabS131q7pa5hIth5X5QOqYK2aFlRFNGtzI1Le5ikC4OSZLzaVfDN2wRT/RC4xwYDwGX98K3+ZMIDqq8nlC8/BQA6O+mW+bGLClAnLvNYeHv1OuV1Cz3ekqskzv6Pvp11gxOUTd2X50bhQUpqz/DiGCLp9F33coT1HOpbq+kt+eHxyfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTqXGAi4gv6df3uCGkaSZVTjEApwuAc+7+xXRdnwpqU=;
 b=SbjOrr2yhabk5xCMA2cNqVd+EjJlMpvaTggDGM7tRlSUBgyEEQ9nIgJ4qnwS1BHAnxnONBnBLuOfomD010+G1qYSrCNi+9LxSpN9mMz0BxlntnH8jw/A1kJf8OSakFu8Bi4MveW93qm6zayBrzFkSakK5R8oI7Qcp8JA4l78sGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:37:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:37:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 7/8] genpd: imx: scu-pd: add multi states support
Date:   Mon, 14 Aug 2023 18:41:26 +0800
Message-Id: <20230814104127.1929-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 00f6d7d0-b45c-43b9-65ad-08db9cb26cd4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itTx81Fu9muAEzoC0x3T9krMJehDavYLSs2oaCDewnmJFBnL225kMTAsjKbdIyGmbO4Cmb4ElwkYdqIEaFnDNCCOGAOe97/8bOW3zU1G984cpNRJJZPtkNX1nlt0L53aqOF8c+1HPGkfZaEf/4R99sv4ziOU1aj3c82jwdKuGemu3HuPIyBiBEAoMuBf1gim75Eu/EtnzrBPPxU1XTyFvQDQQJZOxfa2Zkup1GLHmdCu9BD3SayEvvGLi9XdBR9S3igqVr49VXBJxR6K6FgbN4Gi1RYlDPVRgGxg76KaOEfs0KEmqI9JmYBObX5GLitr2NBTCtHmBmbGmxhZIOBS7dNSKjhGuS90khezqEpIedyvOxAwkns/IgOayv46TqoI+xFNg7smozZbnFszwkFx4JAXQoZLYAE1OPpVnkrw/r/W0m3sMyObaXrg+XsR43/U7I9G44f4m9pf3lKf4Lyxo1s85TqsYCj+pL4KtuD3Mjkn9z926ajBwi9TnthnhJyxHkyImLzLLoOU9yBY3pUnepDJYt1b6sS2+szkiw1uBHcoBM5f6AtGLdwzaT7IBu8X3qQbxrajdJ/D8q+KlC1dsq+NnGUOFbWFrzIx8S0CO/R41bhw7V88OAJy8qYoEPWi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(1076003)(52116002)(6512007)(2616005)(66946007)(66556008)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4IrxbJYx8LSwCpVPW5xmErbzsLXXG0lZXGjm1YRbUjTccIW/tNAU0v9W/C0?=
 =?us-ascii?Q?x9ozLQAoOJmdX8qolkqk+HxLgKyZQT6vB3OzvjnSOMxSRVgbW5W/cumUZuar?=
 =?us-ascii?Q?p5iqIiGZI4iRnOn/UOEiFbHxCjuaTJYFwr+zBGbI8/Q+GFmrFdxVZ+e9d6YJ?=
 =?us-ascii?Q?e8DJ0eItYmxuy9v7+5hnjaQ7TBoZd/0AcmxlTPaMM6DE8QxXF5qbDX0Qcjtv?=
 =?us-ascii?Q?zR5Wg2xKJ6J2wXtlOY7pHwqHD4aQhvQL2C/XhKKRsyBffCNLFa7LquhzngXg?=
 =?us-ascii?Q?CapkmP9T3/OjzaEQ71Vuwwx1oGlCZLTtkQ6pHx1hYaC6l+vrfcK/RQ3H//gu?=
 =?us-ascii?Q?KAfWoTBTyREz7S8wXiw8SUl+Db3XkLxlETAfwZl6tB3sgzWcBGjO4q1sOvWc?=
 =?us-ascii?Q?g4NmHQU66ph8ckWVdONF8rhOQMD9FF7XOCFMijhX6yqmyuPMYBJqbzuAgXT7?=
 =?us-ascii?Q?phj9pOJYCOiOhzfuuvLQL4oNfw8lYh/ygRipt10Ciix1/eWJT7+mj0h2Zvde?=
 =?us-ascii?Q?O2LMDx7qINR1/pKc459s2awKP9gcjv8b+qX6K5K7J0xbT2VEg53IEovhgU5s?=
 =?us-ascii?Q?LMDBq7SnEgbR4L415vgdz5/KB6QRdP3Sw3K3rh+o1eJHbcowTwZIbKm2VQ4u?=
 =?us-ascii?Q?WubbuKCZF5TMEODoC76hhGpOiSF6gKePDSGKkcnHkiTT5+xdTuCAfMec7V8b?=
 =?us-ascii?Q?SQ144hI4k0ADDUp/Hvj9OPwozgCgmpxi4fA0rK1N6eiw3tcz3YuAq1qIK92F?=
 =?us-ascii?Q?EhU0to9o12Z5Gv6ByAlXN/03E3/teX80fcVrQhPWdpxzJhfOOwJMJVmro2SD?=
 =?us-ascii?Q?OxcyHeXD7Up2/0j0HHJFGKOJbfGwpYqFYaLNp+9SY8zw87f3dLC/sgi0AYoD?=
 =?us-ascii?Q?sogQh42PsMXcVw7DVhqXD4LyNG0qVO0nElLjhgTKPacRBYuaCsqRKVNAyTR2?=
 =?us-ascii?Q?9aXk86RTq3cqPU5gYDSED7qfSpeGt1k4gK3f9w41gT4dyvdOnHn6ATCX3XfZ?=
 =?us-ascii?Q?Rs/UXHdRAXg/xJ0LmAd72L5ExbHHZGof/DrC8hHf310YzuO9R2snFufsSerO?=
 =?us-ascii?Q?4uHP5EsKTx/Jn22MehtNcM//msyWZfWvW+6/baRM8kuehpLz08VHVzcwbqbK?=
 =?us-ascii?Q?dtEd/oKDU9q+Kn8wwfTs29D5e5Dlz12wsKxnYL1QiMMzftlyBgL+66wLytS8?=
 =?us-ascii?Q?7mbMDr9jgmQFlaKn7971tcaqArcsZJE31Sjpiwt8/ubvgzxmf7J5tM2aytIK?=
 =?us-ascii?Q?NAZl39dLV/foQi715ORtnSsmAuuo2QOAHnVvr+q8HnDPrqEQINqvKZTuWhQ2?=
 =?us-ascii?Q?SreL2SHiLUEsg6vP7RXQUr1/eMnU71yVCqcPePJ+EjsmRAF9UdH6nhSMqbEK?=
 =?us-ascii?Q?3WgUIubZpvQn+28OzWFSrsIs+6xPvT+o0WFOdZvopokeNjAa0bzJbGv8m0Zs?=
 =?us-ascii?Q?pN4BrKvoB1GwGi5xdorvDk713h1Zgc+YvazPJtZwnHhopzp0BoWm3zNSQlgF?=
 =?us-ascii?Q?rI1O8LcRHVlACLTjEYfXgqHzcMPs0nwh0R0PwyaXuKxlDsilyaw27xN7x2Kx?=
 =?us-ascii?Q?piqik5FEVwilIgeUhYzr8vygRxgSN312yt/A5TpF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f6d7d0-b45c-43b9-65ad-08db9cb26cd4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:37:14.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hwYOa/B4Ev8raqPCMwnipfJs5Q6VpqN7HGR+fl22jg7hAQjAqgMISuI/sVhtuizubwkGnLbX/M3+krjzrfNHw==
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

Add multi states support, this is to support devices could run in LP mode
when runtime suspend, and OFF mode when system suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 48 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 2f693b67ddb4..30da101119eb 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -65,6 +65,12 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 
+enum {
+	PD_STATE_LP,
+	PD_STATE_OFF,
+	PD_STATE_MAX
+};
+
 /* SCU Power Mode Protocol definition */
 struct imx_sc_msg_req_set_resource_power_mode {
 	struct imx_sc_rpc_msg hdr;
@@ -368,7 +374,8 @@ static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
 	hdr->size = 2;
 
 	msg.resource = pd->rsrc;
-	msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : IMX_SC_PM_PW_MODE_LP;
+	msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : pd->pd.state_idx ?
+		   IMX_SC_PM_PW_MODE_OFF : IMX_SC_PM_PW_MODE_LP;
 
 	/* keep uart console power on for no_console_suspend */
 	if (imx_con_rsrc == pd->rsrc && !console_suspend_enabled && !power_on)
@@ -412,11 +419,33 @@ static struct generic_pm_domain *imx_scu_pd_xlate(struct of_phandle_args *spec,
 	return domain;
 }
 
+static bool imx_sc_pd_suspend_ok(struct device *dev)
+{
+	/* Always true */
+	return true;
+}
+
+static bool imx_sc_pd_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+
+	/* For runtime suspend, choose LP mode */
+	genpd->state_idx = 0;
+
+	return true;
+}
+
+struct dev_power_governor imx_sc_pd_qos_governor = {
+	.suspend_ok = imx_sc_pd_suspend_ok,
+	.power_down_ok = imx_sc_pd_power_down_ok,
+};
+
 static struct imx_sc_pm_domain *
 imx_scu_add_pm_domain(struct device *dev, int idx,
 		      const struct imx_sc_pd_range *pd_ranges)
 {
 	struct imx_sc_pm_domain *sc_pd;
+	struct genpd_power_state *states;
 	bool is_off;
 	int mode, ret;
 
@@ -427,9 +456,22 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 	if (!sc_pd)
 		return ERR_PTR(-ENOMEM);
 
+	states = devm_kcalloc(dev, PD_STATE_MAX, sizeof(*states), GFP_KERNEL);
+	if (!states) {
+		devm_kfree(dev, sc_pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	sc_pd->rsrc = pd_ranges->rsrc + idx;
 	sc_pd->pd.power_off = imx_sc_pd_power_off;
 	sc_pd->pd.power_on = imx_sc_pd_power_on;
+	states[PD_STATE_LP].power_off_latency_ns = 25000;
+	states[PD_STATE_LP].power_on_latency_ns =  25000;
+	states[PD_STATE_OFF].power_off_latency_ns = 2500000;
+	states[PD_STATE_OFF].power_on_latency_ns =  2500000;
+
+	sc_pd->pd.states = states;
+	sc_pd->pd.state_count = PD_STATE_MAX;
 
 	if (pd_ranges->postfix)
 		snprintf(sc_pd->name, sizeof(sc_pd->name),
@@ -455,14 +497,16 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 			 sc_pd->name, sc_pd->rsrc);
 
 		devm_kfree(dev, sc_pd);
+		devm_kfree(dev, states);
 		return NULL;
 	}
 
-	ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
+	ret = pm_genpd_init(&sc_pd->pd, &imx_sc_pd_qos_governor, is_off);
 	if (ret) {
 		dev_warn(dev, "failed to init pd %s rsrc id %d",
 			 sc_pd->name, sc_pd->rsrc);
 		devm_kfree(dev, sc_pd);
+		devm_kfree(dev, states);
 		return NULL;
 	}
 
-- 
2.37.1

