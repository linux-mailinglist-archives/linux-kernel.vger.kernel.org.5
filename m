Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA917839AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjHVFwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjHVFwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:52:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6759D7;
        Mon, 21 Aug 2023 22:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD4NCXOb+O5xe6rf2tobOqnb5D6oV5GGHr4c+DQs235WvXf7fnm+I4NqebVq4/Fi85JBgw2BC+9B1GlWNHk8dun9NX7VndUQnyt2bKjMB1Na67nUKmE6OfeF61zzajQ7Z7YTw3jJABTo47XYJz2prkppJniky4Yuyny3u2/Nv/CNeKk99FlP7Q8CCIlSbNnj4CU0wZLKeMOrEl0cB08qajXgYgtnN9I6RKk6gFPmcTkQNK++UYH9h8P8pmAEeBK/ULnlBatiJNlmEz7x5YHFAnYuEpMJJgeL9npGzRvFW707uFZs69cwStcHWVopWemJj3N9FprbK/OHtm23TXIR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJRABpw7K/3uM5GykpIfxlrlQRy9oTsdBnRJM9QM1FA=;
 b=cRIR0Fz8GJWCDtszPM+rFSKSc1MyBnBiyh5MjQ7c9HiVPU8HWvJkVw9xWXZpZ9mSrYejIhZI6bd9D5eI///rxhZ9r0WDaJ6O1LX2X6ZIsW+Xo6opkit4Fn5nSKKY4yUaLfku2K0DznGUdCKYgE+mXgz5tu0ygVwrpi3oZK8Z+8JvjC4fmEzQHfiRII1q6DD5ct/eaF8LvA8nTTe8BSlA8lahp/XKIMJg3sKd9iUCEEGKj7BsazJWnu7m+ap3YGiqfg7BfKIpSikp8TleL/a5GmfqorMhcv8cBbaClxX8xoI56rW4K776VbTCS3NFgHGbvJNQjF1b4pUIGM+qGIjjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJRABpw7K/3uM5GykpIfxlrlQRy9oTsdBnRJM9QM1FA=;
 b=Ln6r24mmzJ3U563lp5rTr7e83Ynqc5bCngpcOL0KKzrRurmrZHBxaWJ+e6QU9f7EJ2o03DuxeRTJuzumzLUviJpJi8HvfJ6caUIMb7lV3fN9Oe6VNKJCOWczRBojhKVJwEMZg/zvyls8M0oiodPYogABb+7YlmCfiTlabmPNIB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB7723.eurprd04.prod.outlook.com (2603:10a6:10:20a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 05:52:28 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 05:52:28 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: handle firmware debug message
Date:   Tue, 22 Aug 2023 13:52:07 +0800
Message-Id: <20230822055207.31575-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DBBPR04MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 6faeb4fa-6046-471f-d874-08dba2d3f785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQzdbCLpNxaNAW8nvM9xSnfDNf6OheiZzHzMcz5TKw+3eHpipjao16KOUip7XmBTTPqDvbs4v1EKJSEqEAO9+pSJRpHtcbe4lvkdeEDL9Nz/gBYv4lVAVMRDMySTCHUnJswd6v9RB9Ug4PfIYlCcWK73UMHN43RY9cc8uLauJtOPg+xQPUTyjX4NDG9z0b5tGr2pWUBvdDhu4jLXJF3CY8rFWyj0kNeFIvEzqerQS3x2l5eh9imLd/sh6t9S1SpP7YmyAFReYMhOJ1TNSBlUMf8ZrvS2vEFZn279QGOcfWVDQ96OC06bXLyExTPD+2H5NryqeKuwzaoNVndPB/hONlKIS3MUkAVMwEch/bW2nznJmFdU5BJkTS4IncUeQtaWh8+bEQJQPm+tsOPd47sEsWMBt8aPz/pAdsWxdPG6r/Rult0JaqO7BEDSPVoA/yYednZvhNvhxWzD8rY/vnJ2DIbD66LUtQHsw9pVI9KQPvVsz/TmxVsTREHkwBHouNbWPkQHy7A3jqTnknxh+8vJsMyztDe5mg8BWsnz0x/OaHr2kE2pSBiqjJOFGnoKC5YM2Vghw+FlHYp7ojeV5k5AyKlpQR21wb6xWXG/AYo3EiPrDfpjrp17ZuyjhQbNztij
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(186009)(1800799009)(451199024)(66476007)(66556008)(316002)(6512007)(66946007)(8676002)(8936002)(2616005)(4326008)(1076003)(36756003)(41300700001)(478600001)(6666004)(38100700002)(52116002)(38350700002)(6506007)(6486002)(83380400001)(15650500001)(2906002)(7416002)(86362001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9gkOB3iCd9/NZT+me+vwXwFyF0qF87KGuSLM4dKC1tqeeJhXLHtMHTHVAFEq?=
 =?us-ascii?Q?nmOdlC8xRH0e2SxtADW3JR3IdV7J1pWtB98Ly4i1Z8BcUNwvUWYIwHkxe7Cw?=
 =?us-ascii?Q?uELidpKKfHMDqVvnNe3AMwdEtn9H0yPDXqateB35q7/D8PdNiwd32llrsv9P?=
 =?us-ascii?Q?T6R8ebCKKctWuRwIPtxYoEl2ej4kWdRiM5PdA8pIhkVySpRGrmwzxiFYDHUU?=
 =?us-ascii?Q?qf6ebCbIvRUM49ucff0jOcL9/S+95XzsX6U3md9LsqlD56OAQ7ZYRtGN3CKf?=
 =?us-ascii?Q?XTIGg1X1zB84UE0qLeFooLcNfkccWv0Tq/UCUV8bqQT9d3DrIPRZMw1rzyZ3?=
 =?us-ascii?Q?bQ2kWURjKovN/xDHRlC59mUBUd/JQENRzWKjdC97QNcmspURQq7pK4ZUllBx?=
 =?us-ascii?Q?cGgzBMNb/FEnk0orTk0D0LvcX3qbjQiimxu6pjc8EnnxRfEiDLbxaLA+t9NP?=
 =?us-ascii?Q?FN5TpHsTC9VHyNCuQmMCQarqNAmSpnAff8VFwIkeySgrasDD5/QeTgDH9Ffu?=
 =?us-ascii?Q?ZbnM71qKjsh9c9YNuM0AYHviZwz5zY1iTGLVefca8irTZrORJlf8uorTNbBU?=
 =?us-ascii?Q?2tOyBe7Qy+VWBvlUpCBH6DVQ8aeQ7eaByy2oKnTbzB5GlJb4wZnlf9Orrmkm?=
 =?us-ascii?Q?/v1Tx6/dQcB3u/MAdfBldTZ0JRh5trYomd8ErM3biZsomtYdhuCnq1Ssy0N8?=
 =?us-ascii?Q?EOjKJJNnKfwBOugKaKfg3Vqow3iggVZAz6CewTuFsQ9NsGWeDMrohqGgoaY5?=
 =?us-ascii?Q?fBWCFTsFzpwP8DdA2jwvCCDHA9hbC/FWniU4MOqBso8YDOnYMtI/YhERVvac?=
 =?us-ascii?Q?UeAhmuAiQLNr2yRnccV5JMVt9n2BqS4t9q0uJCZwR1fWcypPWqi6K0e2N4oY?=
 =?us-ascii?Q?lmX6Es8vr9NF3CiHUJxvkDptrOGPMwuJqKBlQv7wh/bVZeQWRySUeuh/xKvD?=
 =?us-ascii?Q?sKVsKtqaZ4tg57pMUDMhT0Lu+gYYACstfMtYqrQwlrBMuAlfEIsISYbtxa3t?=
 =?us-ascii?Q?M55gdPSqE+tZfFPSL4TMqB8p9Ui1ynjBTX0R1DzF4TXXTSBib76Y8ett4ofI?=
 =?us-ascii?Q?TLXp79El3jJdw6k9s04bZNnrnhHtVf5sFk3AMaIKfEK8lCFaZtaLrwYSpFJZ?=
 =?us-ascii?Q?mVRLhkS4l7ExIZNzdicReR6FbO61xAaTgLioA5s4wrF+mU1JUUjmPSVIIky6?=
 =?us-ascii?Q?bJALMjzmcYeOAE6ZOvJ/mC2wDPEO5LbuhQ8J+Larr3lf1ZhYLAROwf7KZAOw?=
 =?us-ascii?Q?sXhyOmWmgt5WRPm0mKwIY7PeTGx9ek4X/rc4eND50v2zF6ZqHwzuZjbYW+NL?=
 =?us-ascii?Q?3f/5EP3tl+blBhY174UWIazL5brN2VhDm/ycjHz/O6ETHzJnbPAIiPap4JQ2?=
 =?us-ascii?Q?89LKgNfxcW9RUIOucfdzVEK5e5zvSeh18f95Kl1BDkqj0AVqjFr82tanpbVL?=
 =?us-ascii?Q?3WvWc8clwgkzj1Dmf74sWfIAiuHKG9/dVyuQ/tquUG7ijfvvGlsAmONUxxIq?=
 =?us-ascii?Q?KMQRPWLlO1P28fcS/l/dHTqB/tR0TOQ1NdDitte94OKHy/nkhesq05S01Ocl?=
 =?us-ascii?Q?ESvf4uZMBmwHJBtX6cfQPx4qIKknoXnG+scjy7YP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faeb4fa-6046-471f-d874-08dba2d3f785
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 05:52:27.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JImtRsbTjZWj8nwpLZoQkTpJ/1qUYksgFMAZWof/F+E0k8SSDNcuV2CqYGxO0T3kRz4LVzrD+7uWNgcJH7rtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7723
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

decoder firmware may notify host some debug message,
it can help analyze the state of the firmware in case of error

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_defs.h    | 1 +
 drivers/media/platform/amphion/vpu_helpers.c | 1 +
 drivers/media/platform/amphion/vpu_malone.c  | 1 +
 drivers/media/platform/amphion/vpu_msgs.c    | 9 +++++++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/platform/amphion/vpu_defs.h
index 667637eedb5d..7320852668d6 100644
--- a/drivers/media/platform/amphion/vpu_defs.h
+++ b/drivers/media/platform/amphion/vpu_defs.h
@@ -71,6 +71,7 @@ enum {
 	VPU_MSG_ID_TIMESTAMP_INFO,
 	VPU_MSG_ID_FIRMWARE_XCPT,
 	VPU_MSG_ID_PIC_SKIPPED,
+	VPU_MSG_ID_DBG_MSG,
 };
 
 enum VPU_ENC_MEMORY_RESOURSE {
diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
index af3b336e5dc3..d12310af9ebc 100644
--- a/drivers/media/platform/amphion/vpu_helpers.c
+++ b/drivers/media/platform/amphion/vpu_helpers.c
@@ -489,6 +489,7 @@ const char *vpu_id_name(u32 id)
 	case VPU_MSG_ID_UNSUPPORTED: return "unsupported";
 	case VPU_MSG_ID_FIRMWARE_XCPT: return "exception";
 	case VPU_MSG_ID_PIC_SKIPPED: return "skipped";
+	case VPU_MSG_ID_DBG_MSG: return "debug msg";
 	}
 	return "<unknown>";
 }
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index f771661980c0..d3425de7bccd 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -745,6 +745,7 @@ static struct vpu_pair malone_msgs[] = {
 	{VPU_MSG_ID_UNSUPPORTED, VID_API_EVENT_UNSUPPORTED_STREAM},
 	{VPU_MSG_ID_FIRMWARE_XCPT, VID_API_EVENT_FIRMWARE_XCPT},
 	{VPU_MSG_ID_PIC_SKIPPED, VID_API_EVENT_PIC_SKIPPED},
+	{VPU_MSG_ID_DBG_MSG, VID_API_EVENT_DBG_MSG_DEC},
 };
 
 static void vpu_malone_pack_fs_alloc(struct vpu_rpc_event *pkt,
diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
index d0ead051f7d1..999efeaebfd5 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -180,6 +180,14 @@ static void vpu_session_handle_pic_skipped(struct vpu_inst *inst, struct vpu_rpc
 	vpu_inst_unlock(inst);
 }
 
+static void vpu_session_handle_dbg_msg(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	char *str = (char *)pkt->data;
+
+	if (strlen(str))
+		dev_info(inst->dev, "instance %d firmware dbg msg : %s\n", inst->id, str);
+}
+
 static struct vpu_msg_handler handlers[] = {
 	{VPU_MSG_ID_START_DONE, vpu_session_handle_start_done},
 	{VPU_MSG_ID_STOP_DONE, vpu_session_handle_stop_done},
@@ -196,6 +204,7 @@ static struct vpu_msg_handler handlers[] = {
 	{VPU_MSG_ID_UNSUPPORTED, vpu_session_handle_error},
 	{VPU_MSG_ID_FIRMWARE_XCPT, vpu_session_handle_firmware_xcpt},
 	{VPU_MSG_ID_PIC_SKIPPED, vpu_session_handle_pic_skipped},
+	{VPU_MSG_ID_DBG_MSG, vpu_session_handle_dbg_msg},
 };
 
 static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *msg)
-- 
2.38.1

