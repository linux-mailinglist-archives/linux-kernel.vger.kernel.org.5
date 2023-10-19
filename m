Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB707D04BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbjJSW1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346636AbjJSW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:27:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538EBCA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lv4cDGShXeR/1JmdmgHJ4dEt2oaDEIGFOfPICkkgr2HiiW2jswV25ppOZ4+9ReqfGmJYH4Y0SyXrfecOLWXqJbXnKLbV4qVu+CLfgS5HZWc1NmAki5dyO5AnBIOTr/qTj0t6AV8jCOfFZ3jpq8i6kSBYAvnqBIsZp6i03NUtyv20178b7l4IYA/wsl1ElhOMA5YDlwhKX1SmBzBMRLIJs5xsxijhxabLHlyrTzRatbVqZkSQhuiMFoPMZi7tMK1LBSHwXOAp03nadExsVU+UJEBJbC8CbftNfaekoxCeR20JwiKCUflgQB01rNgitA6C5/OQHGQbDca1y+l/tyNg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nayoLnZA6AxlXnKCCet/C/KGKXlH5vBlf4Xff954ehM=;
 b=iz6226LEgDWXs93yzs8TRrEvKZ1ZQv900LHlhjGL3vSmtEI5MqcR4O0fQUjL6OdOf0E5JsP7TmtyiWOYYURsT9Wry4gckc2iGcp5NiY7W1keBE/QKigLQAesfBSSm3L5eRzuVRExL+gQNqYUVJ8GxHfpf7EHthEqYddoI3iqhCohOO1IfGsteA5sz5LzF+RnHdU4SCCJ64k6aMmolkPhzxTKNut3XpUpOlaK0/zHwXUPBGlinNExx1H21mdKiD3fYLyRTYuv3OiHbV9gIQ4AOoyCS70hSs4A3pXPwojqxBIeSUSB9zQRDtxhMWCUykyvll+u4+8Ka8Mm5+KcTD43sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nayoLnZA6AxlXnKCCet/C/KGKXlH5vBlf4Xff954ehM=;
 b=Qron0qZvzh9R9lQ10mbL+NcL3ASOLaXPFXhCutOdPb6Yi5743Jbtwab82SgotNmL5IzjauCxs87mZmSR719v0LWAWsl7BjlPn4rFtKXhybwZvgHb6+f1i6Yk3D7XonKLgK/vm3e+Ou7h7GSpDddKSpcQhRMw2QMZecNkY1vGSU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 19 Oct
 2023 22:27:46 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 22:27:46 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] i3c: master: svc: fix wrong data return when IBI happen during start frame
Date:   Thu, 19 Oct 2023 18:27:21 -0400
Message-Id: <20231019222725.3598022-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019222725.3598022-1-Frank.Li@nxp.com>
References: <20231019222725.3598022-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:510:323::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b0df36-cc2d-477f-8eca-08dbd0f29ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rHP0is51NSlclkO3cW50Eri7HQoNqkzrrZJEKFKRrtuocnt9IAFlaLzerTFFAV/al+vs9PNyFKIhILf7DIYBhPbgyMlLKeGbXzmajNF88DJXkjyYR9riej1tQqPfnt2kcPYmX7hg7wOqrk2G10iEF7IjfFJ9yI8z7KptK8F9w6aoj1bMyu3mE8D/v5R/XACkpjqnhO2Al9JyPWr8DeSwEVSNpTIhsrMujddeXMlx7gPdaPKi0OlK7tbRMfYSuOCEwCwmo1sCiShKva5UEzlTySeVWV0G2IdxasjFIOWaRUWdVHnFkHh3f6NvlLZhEVys9EBQKizMulXzKbVQwL1TqRGH3/BFfFOMWQbQ79n9vZ6TwbTLKj9vZBmUjUdSti1CMecQY4xQz0VJlpYb8XyKtYtFBfF86Yk8Q409LcGgj3p/lLZ9XZ0eep1/J1rOMv1POntr8fWTNE4fYB3d71lEiWdDpGMUuukDNdzTM/DAygZDJZJBZbWGklxSHxmZXi5p65AqJuAbny/f2uXQi6NZPXblGlKFvvOZwamTjDnAQPVeDQd2O8hYqEnOwu1qHuK1AQt6MuulawyYIvxDfOxd6g8CbICnJ8e9Ft+aFDIOMF33EydA//57oFxFKl610YoyO49gXiaZC7lYuGmz8iWIjzDGZWutQmvXIMj8Vwkv80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(83380400001)(6512007)(38100700002)(478600001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(86362001)(6486002)(52116002)(2616005)(1076003)(26005)(6666004)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnV5QWVQWTRiUk9KRUlYbVhKSTk1VGpXUzhqcU5XL0JmOTV4M0g4dmR6L2tX?=
 =?utf-8?B?MEJ0M1llMStITlpBZGtGRzVQaUZVS1owMUpySURMRWxVV1M4TWxSQ1FlMEVy?=
 =?utf-8?B?VVVGVFNWY0FrZWxoSmJVemREdlZRM1hrVks2VVdDSC9TZVVPekQxREgvOGpS?=
 =?utf-8?B?STZYTUFuRUdoMkpPTXZ5czh2YjFxUjEyN0g1ajUwejFYdUJSTmpJK20vTmJx?=
 =?utf-8?B?MDkvcmRhSWdpL0t5ZFQ3a2JOZE1ad3JSTkpDaGp6amtvSzNNd0ozaW5NQ3B5?=
 =?utf-8?B?K2o1ckVvMlFFMDM2WWhncCsyWlJ5YmMvdGZva2F0azlhckJoUExmTnZ6V0ZK?=
 =?utf-8?B?TDFRTk5Lc1NTcHU5K0lDdkhuY3cyVmEzb2JqVWluZzJub2VuRklURE9CODdS?=
 =?utf-8?B?NFFJQzdhY1kzcWpPbXNSdGljR2JpcE1SYnIvTlAwNkM4OE1NQ09jL0NQOW9Q?=
 =?utf-8?B?UlZwcnZsdGJtdFdBNnRRWmVLUmNza0FrWStiKzdtVkNtS2RiQld5cndVSVZy?=
 =?utf-8?B?UGIwRmJtaGgvcUJzUTRyN00rK3E4VERVVkRNVG5xQ2F1d2tOWm9ldU5nOVlu?=
 =?utf-8?B?S1d0RFdNUlNZVWpmZGVYVkdEM011dVlOd29rbHltTXBVTEdVZ1lkbUk5ZkUv?=
 =?utf-8?B?TXdkRnpSVzh1MHhCZVhCWEVVbENzK0R2NkYyWkx6RWZNYTdHbGM4QzNiUlAx?=
 =?utf-8?B?L2pJRG1WcDZ3UVIzblMwMnZiK0FVR0drRlVPM2IxN3B3aWlMcXdSS2hGTmda?=
 =?utf-8?B?TkViTW9KU3lHeWtZNE5SZlNBaHJ6Umxld3hjT0xpWXZhaVExcHE1b01jVlB3?=
 =?utf-8?B?Y3dIREhBV2dwVktpaWZtMnRLcUMxUm92NlB2QUNQT245dHdoRXB3ZVZzaTVR?=
 =?utf-8?B?KzhTT3R4TE1Jcy9IRGxiK0N6eWt0c004eStJUHlsTkhoMS9OZDQxLzBJVDUw?=
 =?utf-8?B?b05UUXlSWnBiUW4vZ3lBYTlVeTVWVW4zdEhNanZ6cXZrK0JIU0Z2RkRZWkJY?=
 =?utf-8?B?QW03SUpkeUx6dC9STlhaUUNJOXM1dGFEQVlHQm5YQmtxa3lPSmJPRVFObWNG?=
 =?utf-8?B?UUdQSERjYXNNTmozVjJRWFg3Y3U2cVAwZmxhM1VOK0dPbkR0OTZ4SDcvcU8x?=
 =?utf-8?B?UzgrWkFlYzZET1I2NXBTaXMvN0QxQnl5Um1Za3BMR0pZOE9NY0tQMVc5eElo?=
 =?utf-8?B?M0hBWGNGaXFUVEI5UGtaWEpjOW1WdHdZa29BZXE5ZklSbDJGMEtvOUFpNHI5?=
 =?utf-8?B?UGVuTjNOWHNJa2ZIUXkvWkFEbmFzQ1psN0F5dUcwUlJUbkhSeGNNZjd2cVY4?=
 =?utf-8?B?dXhsc0RQS3UwY0FIQURNbHlaKy9NeUtBSytJSzk0TisvQ0xYZ0Vscm9hUjNs?=
 =?utf-8?B?YlIzSUl3cjZkclN2THhDR1FjLzlOc09maU9ZbVJuaTZ6WVphbVJ3b0RrUXhJ?=
 =?utf-8?B?alQ3U3ptY0lpeUtTUUl2NjhScURDNEx4d25USThpZ2N0NVFOZVd0Njl5T0kv?=
 =?utf-8?B?YzlqSitOWWNYMktsMFFaWCtoR0NHWGJldVBFNHJzeTlGdVIwOTY1bWVMMEFX?=
 =?utf-8?B?M1RETncrTHVwYWoySTJBczZsMnF5VVJqbXhDWTlITnFhcWMrSmdJaWRtRXZ3?=
 =?utf-8?B?NmlJR0t5cUEzL1BYbkhINmEvb1BXNVEweVhEWlJ0M3NVTUloZm1DaDJYeTk4?=
 =?utf-8?B?OGdxZTZUbzJOYUVyajdNMDViS2NxTGdjTUc4alIxSVovQTllSTVyRXIyUFhy?=
 =?utf-8?B?b0E2bW5abm5YdDlFeGpUNmJvSWw1QzdvcCs1bElFQWRxczdXRzFyWWtHSDh4?=
 =?utf-8?B?YWpYbGxIZHo5Tnl6RVkyZzc4V2VUZ2o5K2Z6c29mU210UzVZRTJUVjArTVNv?=
 =?utf-8?B?UzVEQWlnV2k0d0VXS3NIZVJnVGZtSzd6bFA5ZmFCRnRkU3BMOFNUSXRiWlY1?=
 =?utf-8?B?OGFKWDNCbHFIcDVYYXM4OWNubEYzSnJadXAzNVVxY0xLaDFCbzlycGVqRU11?=
 =?utf-8?B?MWJseERUWjJZZ3lDemcvWlhKMXhCSjZIR0tpMGlqZ3JKSjY5YStkdk9Gcitm?=
 =?utf-8?B?OVkrYjQrd01ZZExZNlVISEtPclRkTkQveS9LQVcxeC9DQk1MWTFSZVRtUE9Y?=
 =?utf-8?Q?wu8k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b0df36-cc2d-477f-8eca-08dbd0f29ea5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:27:46.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjWOuI190NzS7D4LU06fTE+PcM4B2/M2KE1OyCW32WX+PrrxRmTAWWf65gJJeTK8T0vROiMQ2PRVDkh4cTEw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

     ┌─────┐     ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┌─────
SCL: ┘     └─────┛  └──┛  └──┛  └──┛  └──┛  └──┛  └──┛  └──┛  └──┘
     ───┐                       ┌─────┐     ┌─────┐     ┌───────────┐
SDA:    └───────────────────────┘     └─────┘     └─────┘           └─────
     xxx╱    ╲╱                                        ╲╱    ╲╱    ╲╱    ╲
   : xxx╲IBI ╱╲               Addr(0x0a)               ╱╲ RW ╱╲NACK╱╲ S  ╱

If an In-Band Interrupt (IBI) occurs and IBI work thread is not immediately
scheduled, When svc_i3c_master_priv_xfers() initiates the I3C transfer and
attempts to send address 0x7e, the target interprets it as an
IBI handler and returns the target address 0x0a.

However, svc_i3c_master_priv_xfers() does not handle this case and proceeds
with other transfers, resulting in incorrect data being returned.

Add IBIWON check in svc_i3c_master_xfer(). In case this situation occurs,
return a failure to the driver.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - update commit message
    - fix typo yeild and falure

 drivers/i3c/master/svc-i3c-master.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 8cd708c965085..abebef666b2bb 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1010,6 +1010,9 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	u32 reg;
 	int ret;
 
+	/* clean SVC_I3C_MINT_IBIWON w1c bits */
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
 	       xfer_type |
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
@@ -1028,6 +1031,23 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		goto emit_stop;
 	}
 
+	/*
+	 * According to I3C spec ver 1.1.1, 5.1.2.2.3 Consequence of Controller Starting a Frame
+	 * with I3C Target Address.
+	 *
+	 * The I3C Controller normally should start a Frame, the Address may be arbitrated, and so
+	 * the Controller shall monitor to see whether an In-Band Interrupt request, a Controller
+	 * Role Request (i.e., Secondary Controller requests to become the Active Controller), or
+	 * a Hot-Join Request has been made.
+	 *
+	 * If missed IBIWON check, the wrong data will be return. When IBIWON happen, return failure
+	 * and yield the above events handler.
+	 */
+	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
-- 
2.34.1

