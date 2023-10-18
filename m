Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC87CE9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjJRVMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjJRVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:12:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C1B1FFF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6Co+EHdWCanZ952ieyV9ceK7OTEHKBS/XL2zdqc/KQejQHz3YyFBIKDmGlvNkqXtw2/wTdJR0G0Nwdl9/ZRPVFg72CV/AkxnTQP+D1YC/w4mg9riJWIVvNv0ZizthOvD36uvv0/V6XzhnCikp4roA+bWENfZjGeHafjvHAab1fThmEGE5shHk5gY2s1iYVz4cOF2AXV4YYojOC2htkZriR1mKEMZlqRGO8iBiRHZwt0ZNcsh0cVdhFfXu+6/yrilO3/4c+xBhICO1YI/8EFQuD9CRAiZjXZ9SJQEzibGQ/BWQtFU9pH41Y/EOaXSH2dmdPHKxhK2tF6PhyqukhOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPWQn2l7iuQDprEGwbhMq6laPM8yM/hxK/Z8Bbastmc=;
 b=DLL20XYv/p6YV8lfZDC6isrRNpr5/rikRcHb+yG059cJpfiDLkvS/GlRJ0EBTHKAVEzu9ulW2ZW4/5A1mZUVUSt1M23YlT+TUZzirpmY38kPTcPKuRUpXaAqS3NaR2JEA7Z0RKrsCHqaV7GSMgJiFLaAoXuIp2stRNqnrkarilonBXHnqwC+JImaT0uzr/gmduCodWTcBHM5ZS4cm1cDFcmmMe6G1hdh8nXh3mdQPpyJ92+rm2G/LGH8ScWQ0KXZywEIHRbTk+yWVuwfVtpGK7GRfkE6+lgqrsr4Etr7AhfwnJd3mUia3Oxnm07t1nMmCENZfYrWjYo6+PLKbUXC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPWQn2l7iuQDprEGwbhMq6laPM8yM/hxK/Z8Bbastmc=;
 b=D5WJ5I4poDP9tr8NmTLdruEItVz1b/SI2Bz2I0+I3yIdge48PuBA7jAtkUdsQDVRLWTrzNcfl6FuK1H5arrG4y4B9iyLw/tn5NPLDZh4frYd+IlS8tBCnqNraR5/4YN3eKAFkzfXxSLgYekOX0HTeDsXH3UFZFVpH2IMV4EFoTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 21:00:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 21:00:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date:   Wed, 18 Oct 2023 16:59:29 -0400
Message-Id: <20231018205929.3435110-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c3db509-38f8-4d00-57d2-08dbd01d3122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXmQsfiEaRccNqVQh1deWn23RsXQyikL6+sim2T8w9bQhFls8NLAJDglbF5WfbtTFcVZn40Wp+cVpzAtc4+p7EY5io/41gmgHCW0x08z8dS1usmUc3NfbAI4bj/3OiZXCXsygcyz/BhwsLJCdI7i0syqRf/IL72CxftF8mmY24wj2tq+0mv4XzD85zI0KlLtQGMRakGTgKZt2wTKs3+jjREYImMTINMROSX78pZ86eDQ2eF4hmKTJ4JtWnCV4StR6r7AhQOCjf9V0WhzNc/fAatau6uRuHlGDy8m/mM8I9U78Mr/wnKtqwz2fU5CCn89Ez94Yem1LPijVTRVuUOqsPwUi+CTBt5zOAGmUvIwXfA75WdtDJ3kTZq38Y2BZTgqL9eZDL0ovp3Qjfyd9aWouzbtu0aRfnD5Y287ft5P1pcaIvMbY79Vy+Q2zji0eiOPx7B0MckgwNYfisHpKY12t6qb+HrLqK3KdyHV9l4ViazRFo/jG88525G/EGiL9ZAi8WL9O+BuItxqfxSdxw8KVucbfPb8SxIJqCn8wESc3SOnqKT8YgsDWN0wOtDkJKo4UslyKZOZfGgIylZzjeRkX7u6WPgOtGMzzGRNC/hS2M58TwkuPdi4dZ6K86yXRoxq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(6666004)(6506007)(52116002)(2906002)(4326008)(41300700001)(478600001)(38350700005)(6486002)(1076003)(26005)(83380400001)(2616005)(36756003)(66476007)(66946007)(6916009)(316002)(66556008)(86362001)(8936002)(8676002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pyA8avBN0jzIr9wrq6Ug5HsLAEyQFXanSeryQFBVRncnx3YNWfatVkZnZsrw?=
 =?us-ascii?Q?/yDYkYKgtSNXp/PaHf2h313s1DK9Ul4HFioxA6ph7baqxQeZOG858aF2ayGM?=
 =?us-ascii?Q?toslXIwf+BvA8bBJr52x5++zdyJfiQ+vvkCaouUwI/wOyYKLlBgTA0AKDxWZ?=
 =?us-ascii?Q?s1eO2xtZZszonTKDwU8AvYjamn6Dq9NpB73wUsDbI+xq8Q5kgepmn3KRLIWP?=
 =?us-ascii?Q?GnbHldcynAxGpvcFVlM+r6BaVMlLvJwVqfwiyHW1PWft7kqz4JXBcA69vwaC?=
 =?us-ascii?Q?wk5RHphyWSrU3qw+Nwb3JKMfFfMaXzZqP7QngG5T25lGBLmOXv2KQFgUWhJx?=
 =?us-ascii?Q?fc9C76y9OxELDkzs8+uaz4ph2uAqtt8D7GLViQhRwPrhwkdA18O3YdvsIkt8?=
 =?us-ascii?Q?sRMaZD5XKJAnyqgx9RsjDtbheJ8LugrdkRXaVcLLZsqFO2ZwFejMlp7nOmpH?=
 =?us-ascii?Q?Kk0nIvDZbW52rk1YEWUf7Dz5UJEVUvgjQg7Be8tYh4jhl9/I9DN6Z+bnEX4S?=
 =?us-ascii?Q?0m5E5AiXsqXSTSaRm4Gl32A+QY3ji5M9/i/l25rSg25CpBjijB6POFOzzB7r?=
 =?us-ascii?Q?eB1t4Gtf92vQ+hUq6rHcD8/7ul+5yxR6AXz+rAPb9Unsx7PQZVJZ0zJXi0EE?=
 =?us-ascii?Q?SWeX8RAukjQC11ihVBpTMFOJDFMzIFt8ExgzLhYJJGbzzQbwNv5El29/oriX?=
 =?us-ascii?Q?E4UMZVu6maXuVIDPghqPXZ4r8kfLE9joJF8YieBMoaBvT6kzmNNkgCzP7exO?=
 =?us-ascii?Q?rU3hO0XeKSCU9kxuDhhlp2igIWXqD8ROXErY7k4IWw4uTcAsECifbh5CT/+K?=
 =?us-ascii?Q?d2Id7EIqW7mFvvuVR1zZIwjtAO3nwJRViYOBUiAfn4aclv73C0DpEKyM1ajV?=
 =?us-ascii?Q?vUBYVxYv/9dRjz8hwvfv+zu0tqPLtcx/UWSrRDtXQazxCfrHkgiGrIbKYPIi?=
 =?us-ascii?Q?O1Kh4p9gimJObuHmnswcyRyFEdAlhJvlxtX8/PuvClEYbWNwxb0Zag8jJAN2?=
 =?us-ascii?Q?QPNJVZCW9loLkyzbOUfI3n6PwbG5nCFBocb1q8ci7V6mln3LgnJ6/iGT7aGh?=
 =?us-ascii?Q?EQYkpyXWzz90KXdQQlNlcbUxfHpSEfizeGdcswNSOX3ei/RUd316QjmPomZn?=
 =?us-ascii?Q?F/EiOA7afE/vv57hudmuVJRXWcvr8BoAokP6FwchIRpCASo0WJOAdOHplgmf?=
 =?us-ascii?Q?+JMpyrafxFV9N3eGLIXJnYUeCeWRO++8VmQBZfs1xhYuQtWtD+yDQ9CH7YYx?=
 =?us-ascii?Q?0iqgBS7c1aBBGf1MLAWYCW+wn5J+WB8DOkf+Hjp6MjUAJkhYKU3Yi9o/JQJL?=
 =?us-ascii?Q?J7er4KlDZmXQ4mOZCK6i8oVN4hNiSBoLc0nq3OHj0pXmsSlReKQIsvOKX3Dz?=
 =?us-ascii?Q?q7/lSlCEZf8Db61ROm4clsImqrAU/Cpa1lzZF73G2PX4+wb1G29QOKZCTO8S?=
 =?us-ascii?Q?KKqCuPclqta0PHUbEJbq0OahgtCzs2EbOOksWiVIo8lq60AzBheCYF/u56cm?=
 =?us-ascii?Q?G/y8saeWnPho6SxocmJ1stlaAhyDe6yAy9jl5TcDBAOhCvJdl88+E33f18XC?=
 =?us-ascii?Q?Abth0NawMBmXNl8hCys9ghp42acDIOjf9iGphf8C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3db509-38f8-4d00-57d2-08dbd01d3122
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:00:00.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5I2nE/qVE0L5o6XYqNPnaTP8GIM483Fefzids26mpLkQK+4GD7Md7f+4MC2B1TU602AECzpXJpjbBpvYKs1qrA==
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

I3C standard 5.1.9.3.15 Get Device Status (GETSTATUS):
Get request for one I3C Target Device to return its current status.

Add API to fetch it with format1.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/device.c       | 24 ++++++++++++++++++++++++
 drivers/i3c/internals.h    |  1 +
 drivers/i3c/master.c       | 26 ++++++++++++++++++++++++++
 include/linux/i3c/device.h |  1 +
 4 files changed, 52 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 1a6a8703dbc3a..aa26cf50ab9c6 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -196,6 +196,30 @@ void i3c_device_free_ibi(struct i3c_device *dev)
 }
 EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
 
+/**
+ * i3c_device_getstatus_format1() - Get device status with format 1.
+ * @dev: device for which you want to get status.
+ * @status: I3C status format 1
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status)
+{
+	int ret = -EINVAL;
+
+	if (!status)
+		return -EINVAL;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc)
+		ret = i3c_dev_getstatus_format1_locked(dev->desc, status);
+
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_getstatus_format1);
+
 /**
  * i3cdev_to_dev() - Returns the device embedded in @i3cdev
  * @i3cdev: I3C device
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 908a807badaf9..976ad26ca79c2 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status);
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index ed5e27cd20811..6a16ebdd180b5 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2924,6 +2924,32 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
 	dev->ibi = NULL;
 }
 
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_ccc_getstatus *format1;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	format1 = i3c_ccc_cmd_dest_init(&dest, dev->info.dyn_addr, sizeof(*format1));
+	if (!format1)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETSTATUS, &dest, 1);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	*status = be16_to_cpu(format1->status);
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
 static int __init i3c_init(void)
 {
 	int res;
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index ef6217da8253b..5f511bd400f11 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -345,4 +345,5 @@ void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
 
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status);
 #endif /* I3C_DEV_H */
-- 
2.34.1

