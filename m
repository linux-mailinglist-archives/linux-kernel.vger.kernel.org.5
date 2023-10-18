Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D027CE1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344737AbjJRPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjJRPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:48:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF8711A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afqTGQhBV+S01vmLED46XIzuai5p/fUBdGYFZg+zJTmUFIlHaz87EyVaKcDwzgoKJthCs87gmPNurfdGoqnKRmm7bjRco/BXUjBgGv/vHPJqtILG2p/RgMOCB/xa22jpfeTg43oqNodwaHeOxzBABLJsXP7zaB+SgNoFlFaF9Hd4pQaRqU5LcX1nRrkrTtZzKSsOhBc0t1Tjf/3ZoLAnTjgxcA/htgjhoMsVmarWui69OXU9uxQEWAwuvic5p7rO8dvuECmeXVK7nhtStQjxUDQbm23aujMFYCNkpNKxuO0WM0lXOlIJ/Yt+T1bL9GdIEolwnzLMPPLFbi1jJapCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nayoLnZA6AxlXnKCCet/C/KGKXlH5vBlf4Xff954ehM=;
 b=AZB8u7/PU5Esj3h0w3ySjWfj6elivLpYHUqpyJIS/lnjCTc/HfNlHE04BdbjH0JMMLbqHk6cK+mTAlyKsoK8vrNF6UDwgm8+cFy7uAO1TpQR7eJQqBdW3Hp8z0Lr/pxcYdxLd3JVmwG7qNYzuEF9GPaTqCo66dj/M/gCvbSsVJsttVVzBPdkrOtMxQF9rJLUch/qyufm1qoPIJC7t4HLN/X5GAiKA4Ev+QUpzI2NuMKqyJnKOJgT/VomRHYFJ/eMhFbNWN7YrGNm7I//DWp0lO5C4HIo6heF5GmMmJ6oA/YW+zDrZ5PQFXu7GpASFVwOK6EWwHKSjQ1GBuU0v3/VfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nayoLnZA6AxlXnKCCet/C/KGKXlH5vBlf4Xff954ehM=;
 b=BQSHst45l4vP3VRu43j9WQfpoakSpnUa3oogy+JyqHX+vnLO29cHCSpDQJfowaWGIBlsSjJin+EdhVpzGASes8Ll1Z8hajw2CVLPQtzBsmMZvSWqEDSEYhFdcCNEh7TbufPGsB6ht1q2OCU6AyZKh5NURR93xaDnOI9wvOK1Xj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:48:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:48:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] i3c: master: svc: fix wrong data return when IBI happen during start frame
Date:   Wed, 18 Oct 2023 11:48:06 -0400
Message-Id: <20231018154809.3304558-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018154809.3304558-1-Frank.Li@nxp.com>
References: <20231018154809.3304558-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e79c569-37fe-446e-ffbc-08dbcff1b00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3pPO8fogqbRA8hyuXJwsLvPDK4fJ5FAH5cfIv6U3kL6WBsfBMhl+SnwG/wXbtUYVvE7kn7fLcQjP/ihem5fyCsFdacu4OMoLtfDENfLR3pMjKV5vuuN0jAS4L5hYbOEImQxiN0jnszJNlq1jrEatMwsz6EH1daqB3vAQgkWEWExRvK5mY9rpsQ77ivUFTdNOraA4EL5l3I5IsydGJTj70j+Ng4vK6PD+jL2Wk/eljIlbS0tlX5l03SWzIw3V+u3DKz7GlxdIVEWNXuN3HWwphISmqHP2/1Unqi36HqjKjhVXvVIHvtXnuKvNznKsyUJP5ow1cRMUkqpLNZ+f3CuO3gQF4jJvunWNhQNIYiS9EsJgBu+n7IWcR7uO/m6pP3qaboMf7HmsQfgV2dhAMnwg3WM03hkklMbj/7O1ivU9ywd1hG8Vu6EF3qF6HkSkROvRcbM/8nADPF7/xfKD2sEs5UHC8So2y1Cg0ihdEWi14VD2q4/sFEOn33B9hzh4R0oPHOnEO8A9stFRRaGM3fCBjK5V5/ms375pWvWkkZSWaQbefJ11IvvT8JO3+fDGHz6plSTAWOGuFsbgNXH4YRuh6Wp5h/lrZ/PrQaMxz2/RLgNZmtb4L6xVXlDpbKB9yEv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38350700005)(52116002)(6666004)(6486002)(6506007)(6512007)(478600001)(66556008)(6916009)(66476007)(316002)(66946007)(36756003)(2616005)(1076003)(83380400001)(26005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNYQ05YUjZRZEpISFMwZzkyRENweEJwc2NoTDRzNStYbTZmWHI2Mlp5K08w?=
 =?utf-8?B?bk1jTkdyYWdWNmpsbko2NE9YSm5JMHBDdXNPNmEwMkptUkVBdEdTc0pta1ZN?=
 =?utf-8?B?WUlGblBoTzZCUFlxcGJYK3NMQzU4cmRqYXpiSzJrSGxOSDFuVThKbk9CemdH?=
 =?utf-8?B?dEdUc3BqbjZFVUM4aHBJb2lRSys3T0FPYzVyOWtZdWV6dGZweUVBT2dMR3Js?=
 =?utf-8?B?OU1OOVJ0aG13b1BlV2lLMUdiR0FrNmpxTjFGSXFoTkJLUXF4VWtDYlMydE8x?=
 =?utf-8?B?WTZQdDNHQ0xwelhOd1ppRlFqcW5iYS9KTEpjT0xCbFVQVzR6UDNsbzVTMU1m?=
 =?utf-8?B?QnovMmRHRXhnaDNIYzBSaTc1TEhIc2loTFhXd2Ura2VSNGdSS040aGN3WWJI?=
 =?utf-8?B?WE5BcldiRFp3a0ExeWM2VEVHUFl5OFJRWFRTWldldk5DMlNpZjB3QS9sdkRT?=
 =?utf-8?B?b2RPbEFxQW11U3BUd0lNVkdtRWlhdGpoMDEyZ3pzaWp4Y04zcHcwbnVPSW1h?=
 =?utf-8?B?TjQzYzBSVjBweUV4MTY0cWx2aUpjT3VCdE0rN1lmUTU1VUs2TGsxazVmdVli?=
 =?utf-8?B?QmhFZEZDU0FBSUk0V2hKYktnUEtKK0NMc0JrUnZmS210a0hZV1FIWFV5MVVP?=
 =?utf-8?B?QS96MCs1c2Z0WkxDNUZ5eHcxdWNzMERJUGpmMnduakxxSUN2SnpHM3RpNEVZ?=
 =?utf-8?B?UW5ZSHNTaElFVWNwL0hITjJDWkxEWEovUUlMd0x0TmZ5bGJVdS9uRlFsNjN0?=
 =?utf-8?B?WnppS1ZJdTdMYUFIVDY2dWZ2OUcvSzErNFJmNmRNc1Z2QXZmb2lKMTh3R0gr?=
 =?utf-8?B?YWJMNE5FNE15dk1rQ3I4TjRQRVJ4S1A3OXRMUkpKcjVYUUdhOHVnbkFNS3V5?=
 =?utf-8?B?ai84MkNEUElwanZkdEsxTFh3eDJDNTlKOHJCbytNeE1Fd1o1RFlXWEdPdnVY?=
 =?utf-8?B?Wi9wUnpDRVMvU2FqZW9WVzdtb2RRNUtCWkdrRzZDQlVzUHpJOURwTU1iV0h0?=
 =?utf-8?B?SForbGhBcWx6SWc0ZGJRZ2xuWTBEVFNuOVN6M2U1RkNldnZFREVSU2I5eHpo?=
 =?utf-8?B?QS91Z2dDdkJ5NGJjanFreXFPV2FqYzN6WkY1OU1tQTN2aTNJbHVYbXBLTjUz?=
 =?utf-8?B?TlFYS0FvcDE4Tk1uaGpXQWZPLzU3VzRSbjhEcDM3bDJUVllxRGRLNTBzWU9z?=
 =?utf-8?B?OHhyVm1XVEV2QkZZb3RtemtYY1ljVnRFb2hNcDBtZXI3ckhpc2pFR2U4NXBz?=
 =?utf-8?B?VGRWVVkrRFhJOHFweis1QmxGU3lrM3NuREQwVVZpTnYzZmJ6dkN4YzVBR3Bz?=
 =?utf-8?B?Z1BNNkZOODBqS3JUMGxCZnhYUWEybzNtNWhVUERnR3NRS3FPR2hxbURaSGdO?=
 =?utf-8?B?MytKbHNwWU83a1owZzlqaTVjVnJONk9JdGlZbDVQbXoxU0pDTTM3SW50bWcz?=
 =?utf-8?B?YzV4YVR0S0dsbEdOTTRMMnc4QktIWWw4TEptWGI3WmFCbHFOdVFRRmpTSXlW?=
 =?utf-8?B?dHlwWnh6bndWbG5hbW5HRUFQOEUxUDNoeWppUjN4SSswRGk4d3lLbEZhUC9O?=
 =?utf-8?B?d1hXQmZEVmlVVUx4aFNreGZML0tla3ZEalZsZ29yMy9JeEpDZHRJRTE4Ykh5?=
 =?utf-8?B?b1kxb0RNOENpRHJONnJ3Y0hycTVJdFBXRHJ2Zzd1N3Q4R1NwbjdpdkJtYytl?=
 =?utf-8?B?TDVQYjNlRDF6T1lNdDhKbXhuRUE0NDFwOUVHS1NyYUVxU3pCdVlOZHZPekl5?=
 =?utf-8?B?UHZ2T2lxcTVOdG5lNHlOYWZUaFYrUUM3dzJQMWY2SnlzTTNFM0RaZ0dTZ1Bu?=
 =?utf-8?B?SkdnbnZFbyttS2pFTitKUFZ1ZG9Lbll2M2hDTUkvVkViUHNGVVpPdHRGbkdT?=
 =?utf-8?B?WjhWeldGVlBWOGdESTBSVEhxaHJmV29PcFNoTWF0MGJreE1xYTRrVnhMSlBR?=
 =?utf-8?B?ejRUZjEzNER4ZFVvRTFnMHVHeVByZ2dBcytReGVGNWlWMFlGeUJ1bnV2Yzlt?=
 =?utf-8?B?WGhiWTNQb2VEUjIrMndzMjl6V3BRd1IyMEw4K1JlN0IrZkc3dzJ1Y0xjZUlX?=
 =?utf-8?B?dXlUMk1ibktYVzFJTnd1UWVVK0QyNjdqMUpVT0tiVGRpaGZrTThtYXovaklk?=
 =?utf-8?Q?d+Q7UmyT/HhyZMqDrAEuUi6R1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e79c569-37fe-446e-ffbc-08dbcff1b00a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:48:35.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zr8YtR3ICoQoXqSYGm4VOWefbS9VGz6RDy9MJDZM6fElBonGCflxgW34xSiKG6A6TldK2Wdld4A08LEwdIpq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

