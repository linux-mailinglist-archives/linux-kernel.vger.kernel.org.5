Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7BA7FFEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377183AbjK3Wob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377178AbjK3Wo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:44:27 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED9E133;
        Thu, 30 Nov 2023 14:44:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1Tnr6CtkKJdDOMyZKLrx5RUMBKlZTUAkkqQ9R7PX7YdNopTkrdeuOD8iZfPUhk0G69ALWfKs0+vEZELGNs1LSg++Dp+EJfCoAbo6W6rFebFXYTCqJx/t8bp9kUvniDtTVsomZ4IputrlCIsY4K+m+nMPvcvesl0TbHirofLVKA/3qjRP5FwGJmdTaqDMKpZU9BNXggsdsuzxdePjGI7HBD3QvlANF46sjqymgn7hdvqP8Rnh1Qnp+xDblojuW8MXkgQGoc0gp/N6/DPB+qtRJZjL1tNNSpnRcGGuqZPcNf40f7E8ZTbTehoiLcSs4aaWjJ1xVOwZFfluGkDBn/vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piRRPE5LWefhXJGz8Zoeuo2aGktvTAfCXdTndUIkNMo=;
 b=HkVL368v8mxpgYDy/hf/xqExb9kVmohc0O1wieG5sdEl6EYiki5kINipEGZOiuE8IHv5qyukyqnxDaphMPZXvoZGTSfnVX8Az+7caneYbragLrAgUZlg1JxK4UdtNHvbwUKceL0xxqxkHqv5xsxk3tj7rndfhvRNmDwmCVwVN+LR/JtNRceAGAeAHIaz1T0sM6+Cfd0Vi7QC8YfW5ndP9CUXMzKYyUi4SZKFfkQXhOpPnT2Xdm/0rjM6lfwjRK5lDIm5Uz7Luo189LlwpfiVN1yQV+30FK5JAt4S9lkf6S13EDMeckfmbDmF9pPRrElNT7f79JYvLvwdacb3d4G8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piRRPE5LWefhXJGz8Zoeuo2aGktvTAfCXdTndUIkNMo=;
 b=HF4JB5zMU6MA03UyJTGBvokbvKrQNZ2twzXw7EUdq7f9y0vCi/r/gwrCZu7F8XCw0Cvl8fOOs4kmaLIJW+lEuqCrdnDbzTmIYQkuFzgstBvnWs/lz74HDZnqQXEYsx7kGHbb2Nm8JAxPwKtKF+Bq/MbzQbS+W3T/8FkJKW9It74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 22:44:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 22:44:31 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v5 1/7] i3c: master: add enable(disable) hot join in sys entry
Date:   Thu, 30 Nov 2023 17:44:02 -0500
Message-Id: <20231130224408.3591288-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130224408.3591288-1-Frank.Li@nxp.com>
References: <20231130224408.3591288-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0f1593-a1aa-4e26-54d7-08dbf1f5eaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/IsMfOfLZG5xMjJGMeKRFFahLm+7Y9CbQ+CvSySgNCnVe6Vym7OpS4MfYaNgRFPQN9Gfna0w2fysNg2DrURvcKFst5LEmEbuA8H2kACtTK8H/9JpRh5o+iOUNbeXaC0JzoMiXoqvrPSmDLCiImw4NR3KqNXVlsIB+ZhKx8cpL7GEARfpdE7L2H0bodEBR5X8wp26rkz7Bd+B7Lc2B4/tuEMDCXBKjS90KXOMC7MlTqDZdMgcFHY8r+GNK0q8Vyc+uRO3E4Y6xCfcaETuZIoX0IFLfHsl1LQKt/YsFdK89dJRPiE6hpxSinOx7feJxKIwoeip91/QQ3rrfDHdUnG6sV0S9S4ILUgwhW76XDqklacE3hVoBQNEZqi17J/Gc+Z0X6zH+T0xFUcmqvjDvjYqsvSeOKm6Pu0mFUN0xnsMTFVn8+tsdNes9Ukqm4UI/0DK7WQ/U3D5xhg0lTPICZ9jmZS/izlMNI7EC6bBZAXY+r2y3OfDFDb0XeiLGUaF56bm+/ql16PBUSUkb3Ph3JHvtjZi7yM7A4qCWPenQbio63tuvktAUdyoJpF5dy0IXnu1mPAnVw62eyYNeJ2CY6hLzwSM1O1FHDMztEOdnal3sshX+LT3XK9nWtDbUgie0kFMnQVjctYKSn1maSj2oR1qPRamxGwPw0s+dQ38NHPHNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(6512007)(5660300002)(36756003)(41300700001)(6506007)(38350700005)(8676002)(52116002)(478600001)(2906002)(6486002)(6666004)(26005)(83380400001)(7416002)(2616005)(1076003)(4326008)(8936002)(66946007)(6916009)(66476007)(66556008)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fyz3Wr0E6CxghMhdQtxaErEpN4Xq9xRk9ASI7wEE72sVXSOGANvD23vH4KRE?=
 =?us-ascii?Q?OjSvuqW2Pb9XLET95CtfNXSzya5z7bGmRRGhecDGeFI9jkU0tdzUbQoWqgnV?=
 =?us-ascii?Q?Jga67E0SVE8Nj1RdNYzWWWNLGIcS5lORxDhFcfTNdlaMHfg8F2oF0Je1A/G3?=
 =?us-ascii?Q?yBjxjQdzfF77FWFNUDuGu1Ue6J8GtzXTlm0x9sZezUb2jyphD5kDx1CoFNw+?=
 =?us-ascii?Q?/QTLtMJzqzZ0ulmLZCsscP3CV0en7i04A+Pg28DiB2xdWaQLmHYKY1huwzZX?=
 =?us-ascii?Q?YKSfRknU4c1nBhZ3YnP+KbRvsdfb4Xew7GrMygqiBRpBvY45kL+NPbCcXaID?=
 =?us-ascii?Q?iygvjAsqZar8VLQLU0UpeKQE4Vx0HojdzvJihdN1EOA/GD3rakGTGcRrDjCz?=
 =?us-ascii?Q?noj7AXV5Hmjs9e+6Nm8yNMFYM9ZW3PXHmOANAllGeCEAQlB0fRLT3v8/lVqe?=
 =?us-ascii?Q?2+ecmJxZU3z0o7owxOT8o9YewQAIr4BqkQgwfJaAr/keBZIK61bTliwMbsKg?=
 =?us-ascii?Q?oLskc4bL1pqxSo7nzEKcoty0dajeSdHRavRCC7zvEoEnA+TZy9WHiK7Ch2dw?=
 =?us-ascii?Q?1e6J5KYCL//MC7hars9XHaWmj3M8IsdqnzFs8ZSizX+5Q53r4KKJFKb3VXgD?=
 =?us-ascii?Q?za3Vcs0NUpoWoIKEOsGFoZmeFZaTQnCUjZn+w5u5qy+V1xf462qUcXsi61LM?=
 =?us-ascii?Q?tb+CJLdIRqlxq78Pw7r7VGL2a3M0vkQHYGLsvek9hwO+DVW+AV/pciOMGSsU?=
 =?us-ascii?Q?sO4ej7uaJ5g1ILbWM2WV0iVc8dEN0/9eMp7AFC2iXS9jL9ttT03GxpbYHTGV?=
 =?us-ascii?Q?l3BWHpMMyIgNLdD8tP8fWs9oct14pJB74TLpV8YB1TRpIdXqCX+rlJ3YfxUi?=
 =?us-ascii?Q?T+uJ2MzmyxnGCekofyf3MKciconD1BkmQmMYIncRrF2Ns49WUlJkvAxEmyjL?=
 =?us-ascii?Q?qH6NHhwiND4HyEw/+IVC1IMc2MeHh0txqxJMA2/FuaCRJAz3mnskqUg9yA0Q?=
 =?us-ascii?Q?7L4oye2uFuyP9lK3CvjY4y1B4xrlbn9VCXe0iX765VqpmvZbtDbzxoIO8iiT?=
 =?us-ascii?Q?qFCdQU683i61zPvAz/HheODBAjxPRGp9Fgn9sGnbHfjypQnSkTIah+Aks/mn?=
 =?us-ascii?Q?wJpyr9LXPBIPanRjU1vrOICjzcx/w5I6lfSs4VbcVdSnQyk6xsX4gUz62lrA?=
 =?us-ascii?Q?MgSWf8OD7qXwWtg6ZrZPK+ymIyyi7Z6W6qOPEIIhZiSxhv9bS8T5rQ/2Wx4I?=
 =?us-ascii?Q?GJegSLNImjrePvkAiHXZJBTgyQBrvD9Vqf4B70pcJWrxKVSxPRbG6G5/4kqv?=
 =?us-ascii?Q?DwhbWDJF1WEEjlIxLKijGGuypBpdm2JD2WX6Ac5bD7yEcmNJWXTO0meVHN58?=
 =?us-ascii?Q?3onVrmu2PjjRkO5ivDS8IEaff+AygfUEz4bMjZHWO1rsB1VgDssG05HeCeDZ?=
 =?us-ascii?Q?Oi1f5gUZYjvZQMAxuCIzYSNk9/PB919ixqVj79UAdQQ5fuENc8jcFtrY5CEF?=
 =?us-ascii?Q?dd3wPVDjypm/yOxVFr9sN7u2rhMvnWolQPyWYA7swxOp/Ls6yvVEJJd+lI6K?=
 =?us-ascii?Q?Z+2J9mq7SCeLVOyHK1nYj6vvi7Kd9xv6wA3BKt34?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0f1593-a1aa-4e26-54d7-08dbf1f5eaff
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:44:31.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fusjs34tGb2zGU9D/kHIBWBsU7uEp+GlIVIdxks3DOuXRazXygNhmz/GDu3xuTnGMfZRJiopjJhZIyyCC/2Dcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hotjoin entry in sys file system allow user enable/disable hotjoin
feature.

Add (*enable(disable)_hotjoin)() to i3c_master_controller_ops.
Add api i3c_master_enable(disable)_hotjoin();

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - using kstrtobool()
    > +	if (!master ||
    > +	    !master->ops ||
    > +	    !master->ops->enable_hotjoin ||
    > +	    !master->ops->disable_hotjoin
    > +	   )
    
    break into two if, which will be more clear. and one line is 101 chars.
    
    Change from v3 to v4
    -none
    Change from v1 to v2.
    - Hotjoin control by sys entry, default enable hotjoin, which standard i3c
    feature, user can disable by echo 0 > /sys/bus/i3c/i3c-0/hotjoin

 drivers/i3c/master.c       | 83 ++++++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h |  5 +++
 2 files changed, 88 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 08aeb69a78003..d3b56c9f601e2 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -526,6 +526,88 @@ static ssize_t i2c_scl_frequency_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(i2c_scl_frequency);
 
+static int i3c_set_hotjoin(struct i3c_master_controller *master, bool enable)
+{
+	int ret;
+
+	if (!master || !master->ops)
+		return -EINVAL;
+
+	if (!master->ops->enable_hotjoin || !master->ops->disable_hotjoin)
+		return -EINVAL;
+
+	i3c_bus_normaluse_lock(&master->bus);
+
+	if (enable)
+		ret = master->ops->enable_hotjoin(master);
+	else
+		ret = master->ops->disable_hotjoin(master);
+
+	master->hotjoin = enable;
+
+	i3c_bus_normaluse_unlock(&master->bus);
+
+	return ret;
+}
+
+static ssize_t hotjoin_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct i3c_bus *i3cbus = dev_to_i3cbus(dev);
+	int ret;
+	bool res;
+
+	if (!i3cbus->cur_master)
+		return -EINVAL;
+
+	if (kstrtobool(buf, &res))
+		return -EINVAL;
+
+	ret = i3c_set_hotjoin(i3cbus->cur_master->common.master, res);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/*
+ * i3c_master_enable_hotjoin - Enable hotjoin
+ * @master: I3C master object
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+int i3c_master_enable_hotjoin(struct i3c_master_controller *master)
+{
+	return i3c_set_hotjoin(master, true);
+}
+EXPORT_SYMBOL_GPL(i3c_master_enable_hotjoin);
+
+/*
+ * i3c_master_disable_hotjoin - Disable hotjoin
+ * @master: I3C master object
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+int i3c_master_disable_hotjoin(struct i3c_master_controller *master)
+{
+	return i3c_set_hotjoin(master, false);
+}
+EXPORT_SYMBOL_GPL(i3c_master_disable_hotjoin);
+
+static ssize_t hotjoin_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct i3c_bus *i3cbus = dev_to_i3cbus(dev);
+	ssize_t ret;
+
+	i3c_bus_normaluse_lock(i3cbus);
+	ret = sysfs_emit(buf, "%d\n", i3cbus->cur_master->common.master->hotjoin);
+	i3c_bus_normaluse_unlock(i3cbus);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RW(hotjoin);
+
 static struct attribute *i3c_masterdev_attrs[] = {
 	&dev_attr_mode.attr,
 	&dev_attr_current_master.attr,
@@ -536,6 +618,7 @@ static struct attribute *i3c_masterdev_attrs[] = {
 	&dev_attr_pid.attr,
 	&dev_attr_dynamic_address.attr,
 	&dev_attr_hdrcap.attr,
+	&dev_attr_hotjoin.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(i3c_masterdev);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 0b52da4f23467..65b8965968af2 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -452,6 +452,8 @@ struct i3c_master_controller_ops {
 	int (*disable_ibi)(struct i3c_dev_desc *dev);
 	void (*recycle_ibi_slot)(struct i3c_dev_desc *dev,
 				 struct i3c_ibi_slot *slot);
+	int (*enable_hotjoin)(struct i3c_master_controller *master);
+	int (*disable_hotjoin)(struct i3c_master_controller *master);
 };
 
 /**
@@ -487,6 +489,7 @@ struct i3c_master_controller {
 	const struct i3c_master_controller_ops *ops;
 	unsigned int secondary : 1;
 	unsigned int init_done : 1;
+	unsigned int hotjoin: 1;
 	struct {
 		struct list_head i3c;
 		struct list_head i2c;
@@ -543,6 +546,8 @@ int i3c_master_register(struct i3c_master_controller *master,
 			const struct i3c_master_controller_ops *ops,
 			bool secondary);
 void i3c_master_unregister(struct i3c_master_controller *master);
+int i3c_master_enable_hotjoin(struct i3c_master_controller *master);
+int i3c_master_disable_hotjoin(struct i3c_master_controller *master);
 
 /**
  * i3c_dev_get_master_data() - get master private data attached to an I3C
-- 
2.34.1

