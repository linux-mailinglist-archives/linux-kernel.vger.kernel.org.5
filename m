Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C344796EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbjIGBva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIGBv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:51:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B33E73;
        Wed,  6 Sep 2023 18:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrUh+TdSJMMu/8kZh2sKc6UGppvJNGxBIMlyxhSn7sDtZoovLRwyB21jEI02G7Jhgg7yWR0g6vY9a0t1xGqBjwjkQsdMnSOJVDCrPdxYA2ZL55GuRAUEY3Dy3TCyhpFIpNIg3E1lyQo+g/HzUqvWRu6DrURRX5tEzrfATaWJe17vOC6dcXMnP8U+BSzucb/bAFxQLmMZ/66Q9FsqUCblCVZ7Zv6FNQgFmvPUJOWCoY93X99WDkzSfVa/jAbw6w4+NgQ5xSOwYmv+/5HQfZC51tAUyYJyCMQ4pgusndmKEqyE/WrPua9gLp3fa2YepAzdaD33J9Wa4MNZhhmsZQm37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp5GYzMlqIYvvXcN3F9wAnd9/VUoH+9Aq3Vyf15109o=;
 b=jQ8VvJfAsKsm9CxE7KSVfBAsl+YtfXQMi0Aj3L3iJ4kOLxdLvH+drrAet5NZ+/C4kyJ7ZvVR4H2dt2Q7CIeAJfOuxsdTYSgHHzDynlwuX8seIb++hzXELKtYSt8XaUsOBoe7VezfqKstSz+a1NwgFdhaXn5ih5i6E4EDEC/9BcNrEK95uIZj6oq63AOj5EOEYOr4Oe+gL/SiHWWKv6oPBxCzHl6jXDoZTg+e6mvGTuWWLbFXlGs2TxcRxNRso8LoZDcSwgncboUBThwFpo2LjvSbWcw2JopBPU5NIu8phaOhovQ1GpTrzGEI7lesf5HEO/J2oKb9F0djZdqr8/6BQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp5GYzMlqIYvvXcN3F9wAnd9/VUoH+9Aq3Vyf15109o=;
 b=rNyJhghq8H0nL5AmxlSU+vBF7GuDcm6cWqQac/PvRfcCqI7/54gPogIp8lAvsGrP5UnjPiDCp0ZN7lvHRNb/Tx/Bqge0J5eoz2/Qluii73TAUo+sWaLAX79xS4u3ePNVV9qt/a/9hiJB3SHj+8OVlQLHuALOMkCDtJfnHp5YoFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS8PR04MB8388.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 01:51:21 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 01:51:21 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] media: amphion: handle firmware debug message
Date:   Thu,  7 Sep 2023 09:51:00 +0800
Message-Id: <20230907015100.22881-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS8PR04MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: daa4209d-a07a-4724-ab92-08dbaf44ef92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/OJ8lUEzK9PcH8P0qQ6RuOo9gWJAy+EnXTk0g4pJAj4B4cb+FEmkNHVSl4XHpOHl0kdGnAO38GPQmIpRZ3GYXdAoa35GgGtzNpHktJhBl+8LVJ99Qk+/XtJR6NWFYLCYwFeQy4pwz2jPxfOkZvJCxHqAJWN606PKjOV2Wuhn6KZ/vofjmji9EKHPUdwd2pnNrmVcwl+XA/2ltCH2PX7kZ0BIcqDDMH+kcWdI0TQJsvZAiE9kTZO5tjgbVKvqA8M2HrsdupluGsF7htRtll979pa11I3nVWMlnEk+duwtF7+jE67t+cbZrbxDHHeIqS1KN3rA6pBqOfDl2Vd835YhWt5Mc6TsE7C4g+q/jrSZZCse2/35/2qstJ5rcgpz0Z9L/r3GCEorW1Jwq6AegNybz7UdMIWw6BtRxTmxfZ0srTh02W0p3vdjEPpNNotFbot0jXshU0hm5j7vcgT3zUx6YfWLOL7bAeWLOQofDkBAFsi7t7hrhQXqRXkgIp9NOXBWYu8FLJU/gm9VnzmVpjft0ozhaZdMjFWmhuzSWWdqQfKzF2uRMLMTQe6DmZCzoLZTSIC2qMzCdAGJUY0NTAl+wAXtevu7UJkVOIeyTsdG/a/dHp7yeRwqY3rowI/a71G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(186009)(451199024)(1800799009)(6666004)(6486002)(6506007)(52116002)(8936002)(36756003)(86362001)(38350700002)(38100700002)(478600001)(7416002)(1076003)(15650500001)(2906002)(26005)(83380400001)(6512007)(2616005)(41300700001)(4326008)(8676002)(316002)(5660300002)(66476007)(66556008)(66946007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQkvrbdFC63qVfY0J48M16CFnKOtPyyVwxBEkIcTvXMxiLuf20xZL8bVcoMc?=
 =?us-ascii?Q?uOOH8aNkyJolLehoLZCl1mjWvTFkcnW6U/Q58CqNSRw0TT7FElKqtsY9+J5k?=
 =?us-ascii?Q?l9jy9PoVUwVW8vgfCSALiGCRRNA07/3UCczRYxlP7OYDqcQ5XH8X7ZN75i7r?=
 =?us-ascii?Q?1xkEsMLUiZGBpWTpM1CHalrGdJADO0LAfNsTFsTmvRyadoNm2N4pi/warqEt?=
 =?us-ascii?Q?JdDw0b1y7r17g7ViUcxhU8HofJ7j9K3dYGx48EquzK1PB0mDI7qMsLelzg3I?=
 =?us-ascii?Q?p72C5oyhqNnO/BjCcNKJ/waMDwS193tWisvgLUUqgjYa3mjyDPshe/lObq9B?=
 =?us-ascii?Q?2ETVftkmi8Rfux1rbUG/Gf7U4LY++8Uh0LTPF/wVc++X/5NGZ1guP4WoalGt?=
 =?us-ascii?Q?l6xiAPe7KaXmwRyEIeNnfXpMEBFSCb32CJ18kFDNBUJpKys08vrmIVCQD+rs?=
 =?us-ascii?Q?srWPtXhtxcYhn5le8LiyiEsbbXwuQaEE9nD/UEPuV9zf3KKsbQX1Nr13WpVb?=
 =?us-ascii?Q?ncLE0T4B/YQ0XKnU8/D1w1tRCqaXpk9aqfW+vfZ8U1v6zqhvA/BC03h658+f?=
 =?us-ascii?Q?9DCEmv3zSXSESE1KrzXQMmpRHzlSWACnAkizOhoF/ihkuSMWGOIV1X2mHvxW?=
 =?us-ascii?Q?XVSFlkV4GnEww3zNcrcRKuPCj5c4asWNqCehadXo/yFZ3oaCn11BJ/t8Oltu?=
 =?us-ascii?Q?s2TP6d+3eQNfRpZtlwlZHa6guZEjAe/gi+BuoDY2CWHz1ZgV9HRMXH/m7rwf?=
 =?us-ascii?Q?mXYEVlB55tHBMveQp4WinsKB6PSpiXxsTvIQ7PyPUcuqXe95wqmB6Ew5oU8D?=
 =?us-ascii?Q?4JRIlylOysyYxr1tA18C0TksEMNKBi4LiAiHhCByxzmjJ5gDFIUs8VUDnUuD?=
 =?us-ascii?Q?pbdeiUDPDKniOZZGMrP0zOUqsxDOFmMiQxR+7JBH+0c5+DzqsR2i+7DgzRTs?=
 =?us-ascii?Q?vpkoAE4QiW6j7WZccZjEJr3mlCLbVN57EpGsRiE/iI8+nunS0nT77O9BvBvp?=
 =?us-ascii?Q?GOXH8EmvABuCeM06c/WrGUavzbOX7xrB2O8tL6VkzVa0ouMJ8/EyNbRb+C31?=
 =?us-ascii?Q?pXomtR4OUwZDVJ7/hT4aNTcE1BuQfZEHaiao4BEdg8bEgNfwHvmzjINMB0At?=
 =?us-ascii?Q?MM8NmGqJVoJTWhXT3WUBAfx9NV4FK+RikQw7loctpZpPHaX+cPT8aCviEEYi?=
 =?us-ascii?Q?WQZLPvtU98yflij28BfaDe76VIKn3PAoDWD0TrJg7C2aaxsGaAM92YxYKLmR?=
 =?us-ascii?Q?p3tuqNM/OMuUmOhnkl629aJe1X0K95+orqdN0kVnhfWk9sE1qZ93gDlQqDpQ?=
 =?us-ascii?Q?Qi5XuR8HnR5smk8+6iCZqqb3n/w7Nd+mzXBn2JetJ7/BqB4YwstFVp/bHQPP?=
 =?us-ascii?Q?H42RMkjcpcukKO/au6AVymOC/vMQ7MgoREsVa2W6cKgL+OhrOO+HPh/6hHGI?=
 =?us-ascii?Q?Wcm9ahC9PoJZfrzjyOj0kZMDgpfMzGBMftIj2BprfspThSWhVl0GLI5HLNvQ?=
 =?us-ascii?Q?HwmI8k/mur+k87Zp4CdO8zGNdzOMc1VAofhSHIkW4cMN1+8uaf5dnM4EOHhk?=
 =?us-ascii?Q?bNEjBrgqC9Hjctus/mU/BLSzG5JfATIfMmFXVYYo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa4209d-a07a-4724-ab92-08dbaf44ef92
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 01:51:21.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjB2m0kcROrEscHaT/X0b0dr0zUWnMBeODeI8cQA4juyu4J3PSRSpORRLzYWsh2l5y5FDuE5Xl2OEOTmRwyj8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
v3
- set the last byte to 0 only for string message
v2
- force to terminate string message data
 drivers/media/platform/amphion/vpu_defs.h    |  1 +
 drivers/media/platform/amphion/vpu_helpers.c |  1 +
 drivers/media/platform/amphion/vpu_malone.c  |  1 +
 drivers/media/platform/amphion/vpu_msgs.c    | 31 ++++++++++++++++----
 4 files changed, 29 insertions(+), 5 deletions(-)

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
index d0ead051f7d1..b74a407a19f2 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -23,6 +23,7 @@
 struct vpu_msg_handler {
 	u32 id;
 	void (*done)(struct vpu_inst *inst, struct vpu_rpc_event *pkt);
+	u32 is_str;
 };
 
 static void vpu_session_handle_start_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
@@ -154,7 +155,7 @@ static void vpu_session_handle_error(struct vpu_inst *inst, struct vpu_rpc_event
 {
 	char *str = (char *)pkt->data;
 
-	if (strlen(str))
+	if (*str)
 		dev_err(inst->dev, "instance %d firmware error : %s\n", inst->id, str);
 	else
 		dev_err(inst->dev, "instance %d is unsupported stream\n", inst->id);
@@ -180,6 +181,21 @@ static void vpu_session_handle_pic_skipped(struct vpu_inst *inst, struct vpu_rpc
 	vpu_inst_unlock(inst);
 }
 
+static void vpu_session_handle_dbg_msg(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
+{
+	char *str = (char *)pkt->data;
+
+	if (*str)
+		dev_info(inst->dev, "instance %d firmware dbg msg : %s\n", inst->id, str);
+}
+
+static void vpu_terminate_string_msg(struct vpu_rpc_event *pkt)
+{
+	if (pkt->hdr.num == ARRAY_SIZE(pkt->data))
+		pkt->hdr.num--;
+	pkt->data[pkt->hdr.num] = 0;
+}
+
 static struct vpu_msg_handler handlers[] = {
 	{VPU_MSG_ID_START_DONE, vpu_session_handle_start_done},
 	{VPU_MSG_ID_STOP_DONE, vpu_session_handle_stop_done},
@@ -193,9 +209,10 @@ static struct vpu_msg_handler handlers[] = {
 	{VPU_MSG_ID_PIC_DECODED, vpu_session_handle_pic_decoded},
 	{VPU_MSG_ID_DEC_DONE, vpu_session_handle_pic_done},
 	{VPU_MSG_ID_PIC_EOS, vpu_session_handle_eos},
-	{VPU_MSG_ID_UNSUPPORTED, vpu_session_handle_error},
-	{VPU_MSG_ID_FIRMWARE_XCPT, vpu_session_handle_firmware_xcpt},
+	{VPU_MSG_ID_UNSUPPORTED, vpu_session_handle_error, true},
+	{VPU_MSG_ID_FIRMWARE_XCPT, vpu_session_handle_firmware_xcpt, true},
 	{VPU_MSG_ID_PIC_SKIPPED, vpu_session_handle_pic_skipped},
+	{VPU_MSG_ID_DBG_MSG, vpu_session_handle_dbg_msg, true},
 };
 
 static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *msg)
@@ -219,8 +236,12 @@ static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *m
 		}
 	}
 
-	if (handler && handler->done)
-		handler->done(inst, msg);
+	if (handler) {
+		if (handler->is_str)
+			vpu_terminate_string_msg(msg);
+		if (handler->done)
+			handler->done(inst, msg);
+	}
 
 	vpu_response_cmd(inst, msg_id, 1);
 
-- 
2.38.1

