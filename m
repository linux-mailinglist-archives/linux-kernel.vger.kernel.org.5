Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338417CE9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjJRVLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjJRVLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:11:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F06619BE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgIE5LBE0S9YAQVupmGoa8SessBxqLxSBfgSp48a8wQAnGPzWxxG8NJI+w1yHfCwFt4kSnDjNV9M+yc5L63momZ8ufZqZe5O9U62LevizFPI1zove8lpWEFQsJ5G2ABGN1SMHrbvNWOBiVEqZCR2IY9kiro0BonoGkMNHI2Y02fuu79QX/CrdzDqpXizSTJ8Py8WR3eWM7VELVeq8LV1cmZzgnOItgFEnjzfe9FT/ExzZJpbxMK6Rm4qRGkI7qn819R+2gncNFlSz3A9gJaQhVLt5c8BlpVZ4xicsmd8ee7Cut/YCsN45eQhcyrszgd7b9Iw2RgWnNgL4GJlqYPu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV5O+KnDC8aJlWmP/zQQ2IModh1TPKxQmPrXWRR1tDQ=;
 b=A6Cv6QgD/rg1XofK+gttbGXlfuKpdcj3L5oaQhzL9+PKYz8b7rmjCEorm/Ez+9z8ow0Tav9I9EUvYjYxNj9s7jV7BrNgYMH4Wh7zuAXGQzXl0Xn11r3B2Qty2GKQpKLmsddh7EyqN813037StQ0WwAvTj1DFLryZENQWimG2VfTqBPgRJYwvidR/BbQAmEKDkjs70u9LsNyvz2wtrAYDxmkXx9cM07o5TiZS86ETEvM+yhJZ4/drjL5Er9POPfUxqHu072KFMQ+4tSWmOT7tzt6HZVrmKYFRUCTWZ2t0rmjmf+p4Jq/mBIR9LoUe5bcvCtxAcAk3nq567X0k/pQfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV5O+KnDC8aJlWmP/zQQ2IModh1TPKxQmPrXWRR1tDQ=;
 b=DsCmD1IAMIbrZuMZW9R+P4H3FeRde37EYq0mvG4iojuEjflS666cHEQ26Zo6eBuQBKYZXbEO1nppJndpMklSH1EzfHSg81y/tH7FfZ2UNRiZMA0HV8D2ShL6I00xPqUbe2DSKlmrAftvSMKUweUIDbh8fBLCyOYxevk8k/ZR/VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 20:59:50 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 20:59:50 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] i3c: master: svc: add hot join support
Date:   Wed, 18 Oct 2023 16:59:25 -0400
Message-Id: <20231018205929.3435110-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018205929.3435110-1-Frank.Li@nxp.com>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d712d90-3c47-4869-ebff-08dbd01d2b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRITWRfH++9ljcii91JTjetSDkweRHm3zGi9YCT0HRyw6lnccX55VGtZuQMN1wCUhqDsHKkJNggfXQzrwWWbFeKYSQApfn3Fot8zS4l2oV/ciwHQjJGgTFMqmV9wv8Icg9W+Oln4ISMfCo3w7wEwgwqkdSlwByu1EKO+l5swzfZqUqy7rawFOkxXNbYxk4gKXcTCdNDEJhJhWNedYCf4LDy3ZIVjV0yfoCBzQ2qDA/iXSuLxp2r6bBHLRR3F7xe1giwuyXqennxG0zGA4O6DLpwDMtjSlwRAO+Optj1qGITfk1+2s3uvdl8kQrZAL0tTcDPieUgUkzb9jaMtwDMuchMfyfzqqA6RqqZ0sJsxbQSX3yRZrXV+fET552zyHNA6nSmjF05DUQrtMqhWHHmjWETrmuvrF/rXkcAJuLSCURI0ZWR/FzWopqQQgktCxKYViCGXh+RY5z+Ip7Oy9CKGEsDDfardgYccLHp39EgMbW9QFKVxyB+/6MgyLwoLTxyxUtox0r4vXZbpzx2mauL8/srnGx6wO0zT1RuIjbQDoPlyVCUV2q3IXqk7wI+GorMC/GY/L1zWeQGb6EfoV8aGdoFYN/V4JaEkQ2xEKqKtiBOGIuOGv2la/QZs2Wv2gG4Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(6666004)(6506007)(52116002)(2906002)(4326008)(41300700001)(478600001)(38350700005)(6486002)(1076003)(26005)(83380400001)(2616005)(36756003)(66476007)(66946007)(6916009)(316002)(66556008)(86362001)(8936002)(8676002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4oR+JQv6kj/xurRzPIelIvrmPF38BLfoALlENp7bleX51JRffNcMRy88ood?=
 =?us-ascii?Q?J5bGxkYv4coNqH2QvQhCHxpemg7YCY1c3LN8feT5uUhXRuw99YnSoWTmMKZJ?=
 =?us-ascii?Q?wzJhK5C3uiuJJIdW4W4APtXnalChf7BrrErS/k4u/5juEUw4WGKXb+dl7HWe?=
 =?us-ascii?Q?CjKDwCZIe0lFQI15iMmQnVDMRL94BXXDyVpoNqkelf5+M7Mpd44o+4r9iOWX?=
 =?us-ascii?Q?P5oL0iElTKdxsTHcUTBkMQMWT1KpnU9mhwBxHhyeNF21kGOXBebgFSXVgJ3D?=
 =?us-ascii?Q?wr2sSRfopRrwXh+IHkej15YKOpg/LK6SAzHbZ2FqiwoiBzPVEFHubPB4l7b0?=
 =?us-ascii?Q?SqSpzGV3Q8Ny6Mn03NMLmPwUjDwL6Xafx6niIYQKEKR2p+3s/1uoqcj7oSIk?=
 =?us-ascii?Q?F246mSCDgqwrpLIY2BmQzT6g+kvgjKeOKNmntKZhzjHSkO9b8wKJJp75F7lu?=
 =?us-ascii?Q?kPuS74CAcHTULLBsQXZxWMWZgvmzSwPOo33N71KfyAEuSxfec6mxcq5pMYbr?=
 =?us-ascii?Q?REQD/9yJGgr7Gp9QQAEwqm5peRaM0la0vJiKrVCkks2Ok5LIj21MaS3KwldY?=
 =?us-ascii?Q?aBrO31ln3Gduc9uMGl9OjpQxTTkxDqm77k9nItz2HK9J/ZtShaeVBtGkOMDe?=
 =?us-ascii?Q?pftWisimzfvp6LQ2M0SP4auXXGmZYiea1Ff+ZZke9lBAehWC9OlPT4n3hZeB?=
 =?us-ascii?Q?HOad6FEJ5+sgsT8AQoYzcKcPWdVuVih/L8aLk4/dxRKvBY26v7picBySV5t1?=
 =?us-ascii?Q?SwEXvpzLJ2tJOL74x2Xshu+3uP+7/ALcMC6DbebtsZVQRjybE8cfJBQssJIQ?=
 =?us-ascii?Q?+6PxZgfq4koJJjYkyRwW0j/85l/QweMx1bSXhcLn1ye1s5MSTslFKynyeJH5?=
 =?us-ascii?Q?X8yf6bnxtT2VRpOghDzlYXxv3UGiwzlSeuL3eOxFZ60CJFgmfh9sKuF5gige?=
 =?us-ascii?Q?aybOiu1bIFNtOoKmUuDm0Lo1rCJEgrt9uUGAeZrg5JRZUJynOtMJZGgxcmZy?=
 =?us-ascii?Q?UDEMFcmw6pj/M9rZXlmRb1bYk8WzEKaUaLvgPHIFtPxGbeoifknzhAuBAngC?=
 =?us-ascii?Q?sjSkndLPHW5wtszrusf+R/HcPgLiZwWZ/9OXlaGd3u7mo/p/G6Ynf9M431tG?=
 =?us-ascii?Q?Gxdj1cQ9yqYA4tqApt65OmvOqF3+akFrcJOCwz+2UzmPXP4RmciX+DGdWULf?=
 =?us-ascii?Q?8N/1/uXCLRnlB38WiskKmM+S8IuINZb9FC1BwCgFmnZBw465I4v5rMfyzC7+?=
 =?us-ascii?Q?+IAr90KInF3sWIBmjaXBNfg4J+VLQrxb7ZRA+omlJ2w26qKEKL+Xi7DVlUas?=
 =?us-ascii?Q?/bE4tHUDLruvFhO8VCgXE7ucjukz6I2rdl9Tm56pBswF+spFj73Pi9YQ5WTC?=
 =?us-ascii?Q?0mVRYXPbjKQhOTE9wCI+LBRuBRR9P7w4l/uhB7Eph1xGOZ2H/X1EGmkE61wH?=
 =?us-ascii?Q?rBjfF9rsr/GOkH/NUgayD1722mvS5Q2OPV/g+MYnSK/8R17OMH+a5NN4ZHZq?=
 =?us-ascii?Q?GVdMBeVooq9v9wTge6p2AlS9jrG4GvEhO9/kFs3hgqIgyCgjLTsL0qqDtI3c?=
 =?us-ascii?Q?umPPJvYmQHYXBqWxeHYYPt8c0ak6U/nyfDQ445jt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d712d90-3c47-4869-ebff-08dbd01d2b60
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:59:50.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WparO/SF9wvAAJoIe98kF2U0Enb+Cnz+oqqt09Nfu4jG9BOBZEPXaUxTp+qvu24u2GZRrBl/6RKIN2zwr9IfXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hot join support for svc master controller. Enable hot join defaultly.
User can use sys entry to disable hot join.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 57 +++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index fedb31e0076c4..d8467607602af 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -128,6 +128,9 @@
 /* This parameter depends on the implementation and may be tuned */
 #define SVC_I3C_FIFO_SIZE 16
 
+#define SVC_I3C_EVENT_IBI	BIT(0)
+#define SVC_I3C_EVENT_HOTJOIN	BIT(1)
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -205,6 +208,7 @@ struct svc_i3c_master {
 		spinlock_t lock;
 	} ibi;
 	struct mutex lock;
+	int enabled_events;
 };
 
 /**
@@ -425,13 +429,16 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_IBI:
 		dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
-		if (!dev)
+		if (!dev || !(master->enabled_events & SVC_I3C_EVENT_IBI))
 			svc_i3c_master_nack_ibi(master);
 		else
 			svc_i3c_master_handle_ibi(master, dev);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
-		svc_i3c_master_ack_ibi(master, false);
+		if (master->enabled_events & SVC_I3C_EVENT_HOTJOIN)
+			svc_i3c_master_ack_ibi(master, false);
+		else
+			svc_i3c_master_nack_ibi(master);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
 		svc_i3c_master_nack_ibi(master);
@@ -468,7 +475,9 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 		svc_i3c_master_emit_stop(master);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
-		queue_work(master->base.wq, &master->hj_work);
+		svc_i3c_master_emit_stop(master);
+		if (master->enabled_events & SVC_I3C_EVENT_HOTJOIN)
+			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
 	default:
@@ -1468,6 +1477,7 @@ static int svc_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 		return ret;
 	}
 
+	master->enabled_events |= SVC_I3C_EVENT_IBI;
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
 
 	return i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
@@ -1479,7 +1489,9 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	int ret;
 
-	svc_i3c_master_disable_interrupts(master);
+	master->enabled_events &= ~SVC_I3C_EVENT_IBI;
+	if (!master->enabled_events)
+		svc_i3c_master_disable_interrupts(master);
 
 	ret = i3c_master_disec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
 
@@ -1489,6 +1501,39 @@ static int svc_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 	return ret;
 }
 
+static int svc_i3c_master_enable_hotjoin(struct i3c_master_controller *m)
+{
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev, "<%s> Cannot get runtime PM.\n", __func__);
+		return ret;
+	}
+
+	master->enabled_events |= SVC_I3C_EVENT_HOTJOIN;
+
+	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
+
+	return 0;
+}
+
+static int svc_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
+{
+	struct svc_i3c_master *master = to_svc_i3c_master(m);
+
+	master->enabled_events &= ~SVC_I3C_EVENT_HOTJOIN;
+
+	if (!master->enabled_events)
+		svc_i3c_master_disable_interrupts(master);
+
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+
+	return 0;
+}
+
 static void svc_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
 					    struct i3c_ibi_slot *slot)
 {
@@ -1515,6 +1560,8 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.recycle_ibi_slot = svc_i3c_master_recycle_ibi_slot,
 	.enable_ibi = svc_i3c_master_enable_ibi,
 	.disable_ibi = svc_i3c_master_disable_ibi,
+	.enable_hotjoin = svc_i3c_master_enable_hotjoin,
+	.disable_hotjoin = svc_i3c_master_disable_hotjoin,
 };
 
 static int svc_i3c_master_prepare_clks(struct svc_i3c_master *master)
@@ -1627,6 +1674,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
+	i3c_master_enable_hotjoin(&master->base);
+
 	return 0;
 
 rpm_disable:
-- 
2.34.1

