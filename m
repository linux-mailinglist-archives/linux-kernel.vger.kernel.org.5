Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA357FE2C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjK2WMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjK2WMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:12:43 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D4A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:12:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6AuFl7HL60izem5MOw0aNv4ZIYzrepqbcoDusqE65B2rUxrJGOFFQlO8bU1Vw7qqEyan3RG+hxe0MShWjSDR97QsqRD3+UOuTZ9wwcMyvNKm6ipODs6iP5H4JUIua5xKFNXGgqxY7RTEkGXP4NVI0J6V/Imx3nmXrRkZWJJeNfCDRKHCPHgC/INmV82sNxlHBseZCRykrSUq2wuRkHhcYQJggIJt4rUq2REiCsggt21bz5GQtk8qSN1llEesGR8Y/jLPFnSpZGckxBUANh6yDIomGH1EwL2IbhnqrgFr/dj9t1QaX3wAUeDuZQx1kEsdXipZcokGiBsTO81qRdFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDlf4xSFouG1bOinSyyY0+9HL8i98T9MXvpDH0ZtEyI=;
 b=NhvNVmfRClD2Th/UrKVNq4aesI6+SRik/7BeduKRjE5Bc8l04FAbpTx7Nr2l2fE8DcsnBBBsevCapYTAJ0yiKxQ1mAmnUkOqSSvxA3teyPyq+F4IE976/5mbF9nxYEiQuD6XEWGb+8RV1m3KU5pYICisWiRqcOXQKbUWq2MNmUZX83rT71EwWm5YkhmRvQVZOfB9FxaIXUlMUnAcBEAWbX1g4/ybWM2ho1yXFVqKDS7T2WfJnNxHgwd4uPigiO2/wDE39cnBgR5fMAOU9Cb+31W6EsyO52+XcqhYqdSAlNxuQMKpOrAX1x9j6nT+jgEB82+w9C2IYOiNDLKRIQikfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDlf4xSFouG1bOinSyyY0+9HL8i98T9MXvpDH0ZtEyI=;
 b=pXgpmX5Ss+DIwAcDeTt2lXV7dzR0kRBsBeBVza52enzdrESUD4pIzzfdvW0YUgL5XVDoQxPLj8dRqKnTPuFhXx4VrpPI2JT3iIvbycdigXf16vh8TK1ji4azu2fzn6YZciBnVmmTx+c+QM5D1grsHEJPF7V80Hr4WfQs0f6tJmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9578.eurprd04.prod.outlook.com (2603:10a6:10:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Wed, 29 Nov
 2023 22:12:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 22:12:47 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com
Cc:     Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v4 1/6] i3c: master: add enable(disable) hot join in sys entry
Date:   Wed, 29 Nov 2023 17:12:20 -0500
Message-Id: <20231129221225.387952-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129221225.387952-1-Frank.Li@nxp.com>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:40::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: c56aadeb-5476-4a4b-b5ec-08dbf1285164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8T6UvqL72rIyTUg8dN18HgG6jDUJ66471hzNfWi4rBAHBtNeLEKaY8n5ysIqoWKvFyobVzmWIUrQda1xeS8ocov9vEInA7GRhL4+gpQQ3ESgMfSoRxP+N63iGKxtyArluV/7aDb9qQBPT02SmvBC7v3sDQhwdzFo6jeeXUiQR0uwmhNdGfveagwGTOYIeRIhfGpyU67YxF7Rt/uFbgwH2u2NZg+BkhrYr0nKJhaDn0062/IA8fjLZMYQoQx21OaMltLyxX7Z54e4XU+5ehLr9nE5tt5HXyVmlFZqNeKYPUPvl/03d6k1n6M+aF/Fv8rMnvWFdJiJOX6zZn6ZvLxfT7QRhUUPrpvxQuOvdp8/ivler5JknE5G8MuTNic2GjIWfns6H+3RRFBoNC6XYWhdN/QvqRzcWFyOutWPMXczMZ4QCDDKEopKdWbKe3PepGeP7npQPkh0RkLxssy6sGd0WvH4cu+1UzRUHMNVUhwq/8UZYVhuY8ec9Dl9nAgAAyMLC5KRjDetiKaKA51FmwTKZ6uCuDGlzz5fM0sLMgRTAbKJK0SJxAZEFPl2K7nRN0MSa5Qb4dIoSZu/aTsDdwofoNQox/HOHfByTUq80ywDDdfL6wt40q+PdUgiysL1SQL+yWnRaAkMeGeAt0aAUyukS8XTqzl3qHXXchMGKgFp4uVKezoYhERa8mPpDKBMzCFm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(202311291699003)(38350700005)(36756003)(2906002)(41300700001)(5660300002)(86362001)(6666004)(6512007)(52116002)(83380400001)(2616005)(1076003)(38100700002)(6506007)(26005)(316002)(66476007)(478600001)(6486002)(8936002)(66946007)(8676002)(66556008)(4326008)(6916009)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KFsGWnNOwltynlexzi5u2ESBFmm4iqjE1fDffTCeku7zK4UrrwfCnqGemHSd?=
 =?us-ascii?Q?Xw1rDaQk1lm+zk2LiAd8xro07rPGryobO051Tz6i71AO8/JuATTbvc9VPjwy?=
 =?us-ascii?Q?x+1S+Aqfm2jmf7y3grf7yWOEr2HYHDoJMIn9CD2izXqENzae1bi+GdXEdGBP?=
 =?us-ascii?Q?YgdT+OkqCUVQiR5xm7KY5C4cWr+ikVXfO9a+g7V9iYt6SrRnfSeCjluJaruf?=
 =?us-ascii?Q?fc+5lhbqkn88Lu67jNfjWNtvlJkjT+KaoABfnuV1/WLAr9oYPuZ4cIZnuoZo?=
 =?us-ascii?Q?yUdOcxmxqXQZ7Q1cQ01lXe+Ct8MjrpJgXSrk7v8daSuzwxFj8L9jy6UCQqhN?=
 =?us-ascii?Q?xdSEbs3oa3QRapJVO3Ateskb2hPvtUYy5oscULCtj1K2jHrgVX3L4ocbOeKr?=
 =?us-ascii?Q?oLlkho9r8+FOgOaXRT6RRTTnVzdjIIlsQTTnaSED+vwQdPh9t/yRi4mjG6zw?=
 =?us-ascii?Q?B9hPYdd+KCGCMuLg6l/u8INj+q1UV1RWR2zDzXsxP8IoPbp2Mgh2tnfJ0H90?=
 =?us-ascii?Q?WmKoFOI4zSoferkl7U6s59bIgcM+HBhrsjuFrOyuqcswszFw5UWwOqW8Tfah?=
 =?us-ascii?Q?hjkFEqkm51TWlLsO++dZcbjuNU+tTJ7dAcASzbTfQDL1I6Vtn+aspWOR7aoD?=
 =?us-ascii?Q?hl+JPqZX9dIMJaAJweWIVFvjmlGwL0GFM9CB0pyEaBbQPgmTbVawCCj0qIdt?=
 =?us-ascii?Q?YM64yTX/HXup5ZZwBoYTk7uKCQJFpisfA/WIQ+wnqomAKYyuiQEdIUP5c3M8?=
 =?us-ascii?Q?16vnCy1+FqKqiJ0cMCx2VMGOT5Hh22mJaV0oBQSwiMiuf8G4nh6KJDqqDihR?=
 =?us-ascii?Q?RvQGb2yiCwsFqhGNODltj5wv/MTP9J61XHgchg/tXnvUk+sgWS+Of89BUhdj?=
 =?us-ascii?Q?pGRLz426gZWJcKei69fMGK9ZdXcmjOAr1aUbNTiio9AskVlQIQtt9eSJyFqn?=
 =?us-ascii?Q?OfONktLrsUBb7T3C6g73j06oMrCWNAa4Bq7hS6SQ43/qQbvW3NLZpDM/j8wM?=
 =?us-ascii?Q?AsrBn7o9Yg5I3xVat+0OrmXAYZANg+DXdDZr8AvF9x3QNEdkS76eHALUREOM?=
 =?us-ascii?Q?X1LKIerVBR2SjPa6WfVJaYLJkxL0ioV6hiAuGQmqZul7mkGkTnY4WjNvspCd?=
 =?us-ascii?Q?AJYVgyS6+Z44poTXwAgERuonxBkaKytv8Dx+25Fc6WKPH5qQEFWpkuVCJtBU?=
 =?us-ascii?Q?I6yPaZD8Ao2WfmybazgpOOf2uE3YIQ7PbiLpMDDTnPSBsPvWh3CyeiM9eu3q?=
 =?us-ascii?Q?skze84Xh2JS5WKlUIQxYPRoEi6MIj+nUKWjx0+E3Do0jJ/WB0SnRrkd4ChL+?=
 =?us-ascii?Q?q9+ImbE2ce1yRDldW+n7qc5lsDJji16PCBAfwFKPFLOQ44lxIKNQcoThAkoX?=
 =?us-ascii?Q?+MGQyo4G1ak5mVSSTwTkPtn84e5DebWyXPM2rK2G5lM6nh9Mx3As6XNYMuCF?=
 =?us-ascii?Q?ujtoBZdn4PHULldxFw6KNkl2x672Pzhu4UZWV/w1jcKup+TYsU97hQ/7xsDU?=
 =?us-ascii?Q?+IvZDA4Ka+4wn3Aatf0KuoyZirCX/N+yWTe8NFpoclL9K1thtB7F7leTsrTd?=
 =?us-ascii?Q?qa7BnIBLgV2WIrY2mbOGwNVX/WrLLLWExd1EOWGn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56aadeb-5476-4a4b-b5ec-08dbf1285164
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 22:12:47.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /g/ITY229ayTGX/TLiZUaYMzBUSjufNblxgFEyJ/f8Qwh6gN2WQjjkTbOxy/eikPE7640u0sATSk7r7wOZEhyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/i3c/master.c       | 84 ++++++++++++++++++++++++++++++++++++++
 include/linux/i3c/master.h |  5 +++
 2 files changed, 89 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 08aeb69a78003..ed5e27cd20811 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -526,6 +526,89 @@ static ssize_t i2c_scl_frequency_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(i2c_scl_frequency);
 
+static int i3c_set_hotjoin(struct i3c_master_controller *master, bool enable)
+{
+	int ret;
+
+	if (!master ||
+	    !master->ops ||
+	    !master->ops->enable_hotjoin ||
+	    !master->ops->disable_hotjoin
+	   )
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
+	long res;
+
+	if (!i3cbus->cur_master)
+		return -EINVAL;
+
+	if (kstrtol(buf, 10, &res))
+		return -EINVAL;
+
+	ret = i3c_set_hotjoin(i3cbus->cur_master->common.master, !!res);
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
@@ -536,6 +619,7 @@ static struct attribute *i3c_masterdev_attrs[] = {
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

