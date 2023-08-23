Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD17784ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjHWCjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjHWCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:39:08 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68032E53;
        Tue, 22 Aug 2023 19:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYvviisbEgxuJIvcE9h09y7s/l/67lhD+NVODcF3mXmwXD4u5lu/RRFTCFiF+jeQ3UtoiIvN9WHnY2lzpnXQIEpd2nizDphNu8zFy+KmRme0HZAFLH1qTPhWPIX9oELzVj7rlP07wypFTQZDYocpuol+83HBpbdNz2n0jfD+srn74OR9/PB2cqvkW8p039U7ZV7wLiGkDy8MYTWCgZD+sHD/C4bZNuOTpcOLKaSM2f7uXu32qQwAtiMUCAS52aZMgyF4J12wkBBgfulF/yUXOVBTNAPcfai9DasO28U1q/1PM8wjTyfv/JSonMML7oV/E9lxtRjXgoKEMbi6XeUAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0WUARG/58tR7sKywooSbppiIMGj3zIrOZsWFprl9po=;
 b=BWL3xyTu+mADoxRe4VgRsbGnnPUDDHd+tF56C9r5QCFQalZEuRsDOH3xNlpZuS2MD1AccBtQVlEe5Ie9wcuZv91fhRdXGI3Tk/FP8JnqVjg5sBeBbhDdmAuodNG5U1jZ9Mg6S1Iybrh2b9ertey80c+pbXh2LVgPa2wYkwlroWrrpsP220TYDFfKp6FSS9N6FmCoeTkjV1PAlNRAx0X7FQc2U84V8DFEQdMBAuQdPNz1byBYwKhrjokWOPni6trJwbPz0bCsIzknfd2/G+0dXxsY83tCc5SQ9AxysTZS7eAMdM9Z3DgwCAwXByRkNq5ImIwBo8W0K6tAd7HguSzVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0WUARG/58tR7sKywooSbppiIMGj3zIrOZsWFprl9po=;
 b=X7JR8LeuITkLT7b7qvZfjxZXDIOysNCZJKNwXX+CY0uTfD9xJPDBL/QzuKhboNaQggIDarkPjR4Dbt9BTsYov2RoWfO9cX//8EZJQ7I5+KrT0/e5XO4LifVXdqH9Z8NVjPnf3nQU5yyhpxCMMH4jcRpvn19w6b0Jwy/i87fOlJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB9219.eurprd04.prod.outlook.com (2603:10a6:102:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 02:39:00 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%4]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 02:39:00 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: amphion: handle firmware debug message
Date:   Wed, 23 Aug 2023 10:38:37 +0800
Message-Id: <20230823023837.23101-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b2877e-947e-44d1-b97d-08dba3821b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMDr8Fahz9NwQTKUTJbhpxhzvGnWScqk+8QmErzKDyw9qK4u6dLztd5XjUc3nXdX0FwwO8athn1os4U55XMMMHEXtHwUcsOuW3hllAGHX14U9WAIBdONHlmV+LtpR0va3u9kz4jJJiS6qBkNLRRGFAwPoD6WFL5bzVNXqCsxb1mDBREPNELU3WdPA2vwQY34wvZc1zBWZL2BCpccSpioikMGWfUuyfMcO0bq0tsLKPr5QbK1c7ZAzHLuXzjKpLGMRXdY1LxWGVp28UVUgDwRt4g0es06+WfNsroI6UX+uc8cZXulzxDyoG3vNwXnSnBHKctmg6/TUExOSuLOA7VQuSMX3f1uVu2/HM0nEk6Rl3WTEy6UTnqbzMFnj0YaYRpWLyMTcwkJWVUUNGiUJA5CB6jm4eYtVqagN5yaGtTKRREO9jTf2DJ9PbiPjNRehb1+HKDBjVyBKgTqj8zRVOoJuXeWJp0TMztQT0+B6shz/kxOL2rufbUO5DdfQa6MqCCHycsTaUANNFexV3z1Z3uNaOt9TqNeVKLeG6J0kfTet+YNEWKyn+a6hYi0ITHfQ3GaH05aPnwcyXFvyFC/Hb9egiSh96lIqDB5XmwXADkE7tfvaRt2iWSogex9cuTIheFN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199024)(186009)(1800799009)(15650500001)(83380400001)(7416002)(2906002)(316002)(66476007)(6486002)(66556008)(6506007)(66946007)(52116002)(6666004)(478600001)(86362001)(36756003)(44832011)(5660300002)(1076003)(26005)(2616005)(38350700002)(38100700002)(41300700001)(6512007)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XqrpQv8C6k2jUyS1f0U1hBbS3pOwS6/Uf7k0XiTXVrVPRqx04ipOSBqnPsbj?=
 =?us-ascii?Q?Mbo3dDvb/JX/BGb+DcF57xuaY4SicSMJvCNspYDMNsGiAi5texxEQKVBXF2v?=
 =?us-ascii?Q?XOyQq/lzwTP6qkDG7Lj2lxRuRsf913FXPYjZBiCS4cwrm2/sQ38u09FrKixj?=
 =?us-ascii?Q?wtrr3cfwX5DLz64tbF5f5IJdH7vzFVA670lZNchLoTJj1xpf5P69IvHnyZ2x?=
 =?us-ascii?Q?beDmYXlyaeD0q5+1pxdlT/d920FzzQpB/OtCBUK8qnAyifxWlXHh8vOoRYom?=
 =?us-ascii?Q?BhAWGqUuJI1YziW+HL9+EM9t1Gy9oMnLEomo7XaEPUjni6/aB1JfeuYfNDK8?=
 =?us-ascii?Q?naWtQZY8iaOy7hU60Ht1ig+4ETVxeRVKk2PP+m4E/UD1QEDTFlovg3ze8KmU?=
 =?us-ascii?Q?TlPVGHzzElMoH5Vvho4FwK+3W8kd5gQ9/fEmNCxPrRMIRUadIwI1FCSgF+Dn?=
 =?us-ascii?Q?wNDol/ADDv+9/3zmEoX9QQFBl/uLIR3Y/DJWr3tHL0+ikn6PW4or/hx78Z26?=
 =?us-ascii?Q?Y7n3QWigfwjRWtYMevwR4mYuzVmsDp/N1mhz8hOau+Qlwg3LCk9lvr9JxkTD?=
 =?us-ascii?Q?bHbGc8nOpreYPsFj7UNILLj0BgplZ/86jlg+KNF+7Uro/W8XZblTZYDC/NeT?=
 =?us-ascii?Q?j35zMNo4+JBz+qoZ9QtPf3YB7Cd1SGQoo4Z5VPVPfNCaKdn48bwQkaKu1GDJ?=
 =?us-ascii?Q?3c/DCvl54FzbZBTbFjkTLx1724SXpH9l+v/em+jC2+QQ9iovTqPn7WIoPLUJ?=
 =?us-ascii?Q?mJRJcLXz4DSAKwHz977YQE5/lPebCsk0fqDOAPjAOEgMi0Q8pUTaWizFJ8hM?=
 =?us-ascii?Q?ip0J+J0meYfgAqsikVbX9oPdz8WctLMKdpPzgA1Q/NdcAy/+8KTqtExjd+QQ?=
 =?us-ascii?Q?qFXSYOay6r/Gk6rC06PEtjPfgIlbBXrXoaGqKj1DttDErWWEmY7g4DI0vmGv?=
 =?us-ascii?Q?wx3YKIbqzjh+2ZN+b482UDaqRYrBaNpkBiWehWtlGcuke4JORyEpHf2JnyA4?=
 =?us-ascii?Q?qM5JRloIpm48CvIMJYWajolZ6eba09lD4ignsyRS1XNKV6YnosoepX8SRB8b?=
 =?us-ascii?Q?zYOtKWalKzOFX1Q+W35tnqUY2sOj83hJr3XMwqvJjmiY+a5gKHy9t1FY2are?=
 =?us-ascii?Q?Gl7VePqpbVDpuGvGw56MNLb5PJ2n4Dwum7PcJvrTQQ+6qAD+3i0IjvRV+rjo?=
 =?us-ascii?Q?EPZp0RiETQQn8trD/L7Thn//DJxiZYGIQFJK+CyKFPquvHavzD9ZdQHgYt/0?=
 =?us-ascii?Q?xKtrjzwj6iZ35dfcMr59VW/adMva6Zx/5iKdsPg6KEwyurXeX+EP6OZxykmg?=
 =?us-ascii?Q?CfLzd96WaWXcxpJ000JyK/9TdsAEE1dEX5v1pyNUzCwA1ZeuYFpCDIvgBhJD?=
 =?us-ascii?Q?p+pPrRyvytZ9TQ7pvEf5QMKF2w6/pxXiO+MMMv7xouTiNh9EQekBc3Dre8fc?=
 =?us-ascii?Q?PlBcKYdLYiWXDM8MpNqvZKpNL4i8oFir6HxImNmodlBvv0YOxgRsZrgZRUg9?=
 =?us-ascii?Q?2sfOEdbUh2Q4pvJa48iuZqHcOHY8EnLFMpGy2JmsOj7WTpELdmsI6w4RNeK7?=
 =?us-ascii?Q?wstwRiGpYX10LVBcV7x/cBVoDVVcRu5eXx8PWSaE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b2877e-947e-44d1-b97d-08dba3821b1a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 02:39:00.2909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4kE6rFBgG1tQZkpLKjxvt35vfW/S5LTd4YnkXu+NaaZfW2/Itd2IB9TLCUBB9urHai+q8+XENUbKD0prgtnlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9219
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
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
v2
- force to terminate string message data
 drivers/media/platform/amphion/vpu_defs.h    | 1 +
 drivers/media/platform/amphion/vpu_helpers.c | 1 +
 drivers/media/platform/amphion/vpu_malone.c  | 1 +
 drivers/media/platform/amphion/vpu_msgs.c    | 9 +++++++++
 drivers/media/platform/amphion/vpu_rpc.c     | 3 ++-
 5 files changed, 14 insertions(+), 1 deletion(-)

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
diff --git a/drivers/media/platform/amphion/vpu_rpc.c b/drivers/media/platform/amphion/vpu_rpc.c
index f626a9f835e0..8234370afee5 100644
--- a/drivers/media/platform/amphion/vpu_rpc.c
+++ b/drivers/media/platform/amphion/vpu_rpc.c
@@ -144,7 +144,7 @@ static int vpu_rpc_receive_msg_buf(struct vpu_shared_addr *shared, struct vpu_rp
 	msg->hdr.num = (msgword >> 16) & 0xff;
 	msg->hdr.id = msgword & 0x3fff;
 
-	if (msg->hdr.num > ARRAY_SIZE(msg->data))
+	if (msg->hdr.num >= ARRAY_SIZE(msg->data))
 		return -EINVAL;
 
 	for (i = 0; i < msg->hdr.num; i++) {
@@ -156,6 +156,7 @@ static int vpu_rpc_receive_msg_buf(struct vpu_shared_addr *shared, struct vpu_rp
 			data = shared->msg_mem_vir;
 		}
 	}
+	msg->data[msg->hdr.num] = 0;
 
 	/*update rptr after data is read*/
 	mb();
-- 
2.38.1

