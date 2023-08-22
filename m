Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1594B783B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjHVHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjHVHqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:46:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DF113
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbRCS8eCqU0b/QxSkub4MQx4FRgdzjd8YJCYwKMSXab80YJRDaaKG4clWJV+1CJofbz2AHRRoVfqNIMmYuO8qXPU7Gz5VW4zMj9m0e29W5RteSh9IMon5OE6vswCoP9GFAC8LeauqKMUxm/afiVkRMA3ABs/N5OSb3NKkOspH1+TfZ2MnFWNV6nPIAzXSJlCxjt+gvgG5zrmwoigxaLQZlrfSKvfucoPO8JwhF+sp/1WXblpKC096ppp3tLquye08dzGhDBzfQ9qAonocl2DSkIOcxIvPThuCe09e7Z3BxuSt3SmmK0FBzM45sjccThPGIJa02X9ECGgZvP1cPfHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+GOmL4frijaYZHKD8WiXFppO1VhDpzcsWAqgOwwBIs=;
 b=nJQzihlfz/0vhkap6dyTPE5mlQ83W4K3j4d1DpH5+ukvdqqHfQKCOYn613KCAActQESollpPe4b0ExZXYx3GxR2w1B3l0dowts6KnNy7AUwEq1JDX0TPtneBcY50RvX6jWzeNhLe2lGRDLbTdAU98ZGsTd8oeTAbGhKLJS9bWOHC2spT7jGUiJU6Ynj6hF+zdG5W4yhfb5s793QFGBq1B2P67bLpHDGh5ai7sTLoyg80t3ynK8iMIMpxfVs4DOFniXxAl/RyRkmJCUyEAf1yVy0ko6CGNIMjr7S2rRvQEAizG+Moz485yB/FOESuDqV+tIWC0knPK1P1U6cEw7iGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+GOmL4frijaYZHKD8WiXFppO1VhDpzcsWAqgOwwBIs=;
 b=Vge7kgkzgMfwtzrFtREVCH2+TeCXyIjvu7xjixJ8YBzfTwSI63JXQBNqkfrNu4Qvl9V4bDhj0YVYmHYRWmJGBpzg1JuEcziNZhfhfOFD+SJZtnbff/X831mW1/i2ZWZIX78yxzjlqLeZ92bC4Omz9gus5XaA3v/eZJM18v12HUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8082.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 07:46:32 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 07:46:31 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        eagle.zhou@nxp.com, tao.jiang_2@nxp.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] wait: don't wake up freezable wait by freezing fake signal
Date:   Tue, 22 Aug 2023 15:45:47 +0800
Message-Id: <20230822074547.8037-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0131.apcprd03.prod.outlook.com
 (2603:1096:4:91::35) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM9PR04MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 00dc79d0-1154-4495-1313-08dba2e3e6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkPTsm83buCaeLtxSKGpV2JOP26bN7jYqPUM+rzO6QRo4WKisOwkJuoU99haRHj5u4j4l5lWzin68R5BvmLn8lwl9M/1z2zn8GaFXfdE4F5ub0QwC5Iazmp8DYCQ8AWGS4jfllA5Cb9pfmU/RRe3Z5/5RADli5meWn5gtQNmEoE4EcQ6BdOiLqK/hjyXdQTJUbGH94KmI76ReFF2tkrlk+kMzJU5UM4GFgdMd/JoQk+Ah+TNkLbzVQLb3M0RyF9bMNfzJIBvMNhEjJS1M0LrRGhNDEzStiGGncqAIr9bwrNlgKnab0RV0eRj7DD0LRaTOqIZ/V8BWgseNekfkIMMT1wSru48Lw1BW/qtI5D3IGwUk+QtJTJzpOauw+QfFEEmLoru8OBGR/YFElFN2wnWa82E/aXk+XXtcyCeYQfad4th8S8/g4WkDxA2Rg3niLF2mlOaPay2ruIXWqRILQ98p+8Q2irjP9s0kqDyk4+AlZyuMjqtvl6MU8FFICwgDLGvFfL6a1PXk+Ukng6AeMf8gL4cL7I7YTzrTcMHdddjCDoe7AaD3rv1U/A65Atic0e6TFJPwr3tBRzMcVJIMXhfKa8RGorA2TgIyaU0PmxM8OFcMT3bvjx4IMXlmpLPNGzB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(52116002)(38350700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(86362001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8OPJxzKaCXd2ctf70BRWHAm8Nomk9e9+IwQTZ507A7h+4QdGip70FmG24Aj?=
 =?us-ascii?Q?RJgLh8FTvs9iBaTS505d5LhDA8TL35zak/vIB/dnJ1a0nCQHAy+SLotiQcqR?=
 =?us-ascii?Q?7joRCPFNL4KOQXhbluKI/lxoQ/glVZmjz8+4Y4MlkJSx8/eGPzHS4xKaKWoj?=
 =?us-ascii?Q?pHAj/DSyAOl3OB9d62l3AEs1VxyrMb0O8UuXw4OmZSZrY5KPIKYnwGLO8oMq?=
 =?us-ascii?Q?FU58XCXB3cIlq5hf3WlsR8Cn5KQQzp/CV3bJASgMbsaSnMgLvgBuSSIVPjgU?=
 =?us-ascii?Q?QaT23h/N/SEaSnMEyUy1S+d55TBonpnexjekTHjy97WRKs9GcXd4Bju65lhr?=
 =?us-ascii?Q?yKS8lVSYRnA/VrGw+U2Kh/Lg0eD1b146dJY/yz/nq9IzkcWlng+0Gctkf3ZG?=
 =?us-ascii?Q?6x6YbNSWvUsgkfEk6tO1oFz+aWcDz4b6UgPe5re5s5U84i07K5KXZ/uyy1oE?=
 =?us-ascii?Q?RT2Pg6Yvfb4BA824WFNINIszqSYLbHMtdRE2UXfSn1v8djfIO807GDvJgPr5?=
 =?us-ascii?Q?cd0Ma1ERMbEWcReDxpj3AbL9is20yrOEnf31p0gIduT+B1+sKcZDho7q3XpP?=
 =?us-ascii?Q?g5X/veMECoJU48kGpIwbrPN+Uxad+/bZipMuue4GigiiOjx4BMOY22Zbnvqa?=
 =?us-ascii?Q?AKfvGoLAVM8Zfsy9lRrimaj7QNslyPj1+0yYSV7XXLj1v2ZfNLqhA8U40KRq?=
 =?us-ascii?Q?KnGkVq4SahfA1dsr3/1ss/ZZKxnrDZAqsdM4uys/fcBFB+qq0MuABkbN0xXF?=
 =?us-ascii?Q?d+j/oePrl+WXEro/ilbAqM+tDBDxQ0V9XswpZ+3Jm2lJPVBB5OFAN1RSzRcR?=
 =?us-ascii?Q?HN6bGf9MVSFPVqXjWXNHXWlbnRWeD7MPuIpdJhascoTyS7dTWMVYh3FMUmeP?=
 =?us-ascii?Q?5UZWsMd1eN6MY4ujIYGOAANXJiqb8pf46uw4OX+qCfho7mw8cF1yo2RciG1n?=
 =?us-ascii?Q?FG6LYXiD5MaqxCepNzQGR0gBlNj9dHR5kP8XDYX+pDahSqMf48TlZa0cYYSP?=
 =?us-ascii?Q?ETcwh3Od2JbOG7Q21aam0R3zp4d6/xY3mYpdRFAdYwVXaLBZrBf9u8kM3Afb?=
 =?us-ascii?Q?lLricrWOn3vAUBxGXxIomAvP4OB2DdPOupdtkDUMfKtRVkOaL1Yzji9qXp++?=
 =?us-ascii?Q?QXTTtxcavZw9rOC0yF6mUBjmQAzt25+VEBANAI5JtyN52pWyfL540nZh0hEX?=
 =?us-ascii?Q?wckrZI/3mqf+8IE/jEzYLCcFUkFcdHqk6G5T1BwSEtxZjRdy3P99Qpajlr3z?=
 =?us-ascii?Q?3b8HIdkoeb9Y3bq7TfvejtUDB54tHpkcWkvPER7s54plBavmWfr8S+zIjVme?=
 =?us-ascii?Q?LCGJHTQZB1/AqF5tDLfd8b5PbCCmMi9dqCmc8juicQ9FYr2AsMVwXunICpuw?=
 =?us-ascii?Q?0m9VbcooKQ8cveykzQbuJNKsk/gxds2p7iqNfNDEMvEY2FmwYm1vcPOSbKaC?=
 =?us-ascii?Q?RxqdtTlJ4aHYRbqDz5oC2l5w+z52deYQYLcELi6NtjKSMShPAM3HRMFisF8W?=
 =?us-ascii?Q?djz5VoWJe+3hayMu07Mr4Fl+oXw7CmVLhZUIRYjYjKCamL670N4bM8CnQS0A?=
 =?us-ascii?Q?YQUaV6Z8ut6fEzq7ngpIMQGSYXzt6/6gTwhu4PpF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dc79d0-1154-4495-1313-08dba2e3e6dc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 07:46:31.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlLBJtcCME+Gmqch1zTaV6sXqp83/iNYWMIBvIzsfuYTc9BsA7FIsEdSwACRjoMEH4E0vduLI69YRsyFiVKcQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel may try to wake up task with fake signal when freezing task,
if the task is waiting event using wait_event_freezable,
it's better to freeze the wait, instead of breaking it.

otherwise the caller may need to retry the wait,
maybe like below code:

	if (rc == -ERESTARTSYS && freezing(current)) {
		clear_thread_flag(TIF_SIGPENDING);
		goto again;
	}

Signed-off-by: TaoJiang <tao.jiang_2@nxp.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 include/linux/wait.h |  9 +++++++--
 kernel/sched/wait.c  | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 5ec7739400f4..975ee67f259a 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -287,6 +287,7 @@ static inline void wake_up_pollfree(struct wait_queue_head *wq_head)
 	 (state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
 
 extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
+bool freezing_wait(struct wait_queue_entry *wq_entry, int state);
 
 /*
  * The below macro ___wait_event() has an explicit shadow of the __ret
@@ -314,8 +315,12 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 			break;							\
 										\
 		if (___wait_is_interruptible(state) && __int) {			\
-			__ret = __int;						\
-			goto __out;						\
+			if (unlikely(freezing_wait(&__wq_entry, state))) {	\
+				clear_thread_flag(TIF_SIGPENDING);		\
+			} else {						\
+				__ret = __int;					\
+				goto __out;					\
+			}							\
 		}								\
 										\
 		cmd;								\
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 802d98cf2de3..37c3b2bc1fc9 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -5,6 +5,8 @@
  * (C) 2004 Nadia Yvette Chambers, Oracle
  */
 
+#include <linux/freezer.h>
+
 void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *name, struct lock_class_key *key)
 {
 	spin_lock_init(&wq_head->lock);
@@ -484,3 +486,15 @@ int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sy
 	return default_wake_function(wq_entry, mode, sync, key);
 }
 EXPORT_SYMBOL(woken_wake_function);
+
+bool freezing_wait(struct wait_queue_entry *wq_entry, int state)
+{
+	if (!(state & TASK_FREEZABLE))
+		return false;
+	if (fatal_signal_pending(wq_entry->private))
+		return false;
+	if (unlikely(freezing(wq_entry->private)))
+		return true;
+	return false;
+}
+EXPORT_SYMBOL(freezing_wait);
-- 
2.38.1

