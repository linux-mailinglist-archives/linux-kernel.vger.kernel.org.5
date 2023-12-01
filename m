Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B874E801648
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441840AbjLAWZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441818AbjLAWZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:25:53 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E094
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrTZy9azY07ipFoH8EyNf5YEfvSXVi75fjwBdVPfaQAtxgAQl2ioEi3YRm4k2f0n5MgPZc/1+Ez+WqF5VLUYuHEQCpsjOIbcOBhSV422NYsH6zcJN+5TsTM9EJs8oKe+gMwp+mDjcgNvmBEhB8sd8dvmm7BRMN1a7gCOgoMBrOP1uIQMUaYZbYhm8bxi3qmYkqt83JG3YKn7ty1HhMNyL0xUFHcfvBPrte3S4sfgI1UC5/xsEJ93f6mmRd1iFcdszs/DocWjEFz7MG6tUSSu5QKgQwFo58k6sSmEFVRikCdkHHK/4vPanz+SSDHYrLmIcDZ0er3Yu6aGI/iwsLv8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piRRPE5LWefhXJGz8Zoeuo2aGktvTAfCXdTndUIkNMo=;
 b=HzSSZv5ocsEBezOXa2Ca716u5z3HXrdyOcYlriQaUn9IGzuNuZAFP3e3ek91TqDwG2e3sJXEvHGBBfMBR3XnCTE4fbpHqVwnEVLXA5D9LgeJK8mg55GoGv2ezlbkDTbp+j6uzcsOyHCgFbBnOGk1faiDaNTNkdhd6xj96sgraz2tO+iS/VCZ5Bs8JsLYju6/rDxyG9+OUHPpeF2IEvUYrEw7z1kahqYo6OO6tKoS/SugsrkWQCKiMSP45rrjL/rJssapnFTOsWyGySeF20QXWzQ71qP+GLAUxX/8uHamr7CYJEz4CD0ud8A7+t71V2TqwwAhU8H/C3oZSxJmOtu29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piRRPE5LWefhXJGz8Zoeuo2aGktvTAfCXdTndUIkNMo=;
 b=lSQuoQewhEJtTxqNO4ElEeZiuy3bnvFGzIzm2f1JLbpUDZPNYYwzPaKAcJ+dmj7Fi2enSglcKhsyy8PCj1OPkWro+QjtF5Z++Mbw4MBVyAvQ/mH8Xf55krypT53CzBNvO9siscNdxtoBrh6wU8AjFjpyzte1Lwhb832T8xrUsSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9573.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 22:25:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 22:25:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: [v5 resend 1/6] i3c: master: add enable(disable) hot join in sys entry
Date:   Fri,  1 Dec 2023 17:25:27 -0500
Message-Id: <20231201222532.2431484-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201222532.2431484-1-Frank.Li@nxp.com>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS4PR04MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8a1bae-ecf7-4e7d-49d0-08dbf2bc7d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9rWT5ppyPQoN1Aken9WGUDuwIF/dmxOtx2jgN4C70iiTj65b41P3OuKztN13z6wnptcbuf2cTSs9biyqWh3eU41sfWlzC4Xb/mhaZwFDrpoWpAh+w0RN5om43X7/GNC+/yVIESODkalFqhPG5XqnPg4RJ1zLGjdjjSO1HAfBdqaff7vNPL0KywFZy5lsktKACUDVIum1OTnWgP/f7H+ac4RX0+qoolnXku4pE8gTdYOGT9LI4n6SqtC4wnVBY67OIsDwPWCNL9n/m8U2DvMwjS50J1Vr6ZJBVeehXz6w+2W9IxChb6Z0NHKR/ewX4C5jjtvI50LM0uNJ3Wz5oLWv5MLPo/g3xbUZ0E+pQz8VuzlOv5VxhRalX/UPOxB+MtnzV40AF9xYD+uS2FVMN/yCpEB8ZFYlu9uUI5PN/JvDgo2PP4ItrlAEEnPtx07vHGuhoIRhCom0wc+EquSwrooQsMfPDrDVm4v6zwB4eWsubiOQD/1auuqe00vQX9xOAN01VBl5q0yH2zg04SzrXXQLvWvdbv7RvG2SFu0kUXkuE2k6i9pNNFQzBQag4dcBPFnN565lJlPiaRAr2Me96ihE1qPf5gUi6H4LhqVWZxmOPeSks6xh0kF2ogC/MLEM5Ta
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(86362001)(6506007)(26005)(1076003)(6666004)(52116002)(2616005)(6512007)(41300700001)(5660300002)(8936002)(8676002)(6486002)(478600001)(2906002)(4326008)(316002)(66556008)(6916009)(66476007)(36756003)(38100700002)(66946007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RIhv5HcMyCvn/t2HFB+cJQLuLelGc4LBH9cY5TuXIEbFP0kUhpXMTK3GMRBS?=
 =?us-ascii?Q?Sd9E7TS8V/EiO1r9Th7JNMlvDxEmE+6w3aJItQCKXHBRWvlhlSiZb5Dbtont?=
 =?us-ascii?Q?WTN3/3Q/vK38FaV9XisqH1KeIDdweiODvJ1DM0qMxWfe/8PrucBERkDUuiEx?=
 =?us-ascii?Q?69u3m+VW+cR9+AcM8fxy4/NobOmuk7lAsTHl9aUGSVaF9DHtgUth3fkPntQC?=
 =?us-ascii?Q?nWL2Qbs1fK4yx6RK3+kBxdo1hatBbmbzK6N1kJqvSDTKaIQ9h+CUpaLl+NzJ?=
 =?us-ascii?Q?+7ZaaqgIpWT6mXVfM71n1TDmEV9LU4KpyZttOgMVJOqKNxJqTY9ipWekcj1G?=
 =?us-ascii?Q?0zafD/DQ+2aJkhlc8u3ysBkoz1FxTqOsPB4jOmg96FVrAEM29Ze1kHj2x8SN?=
 =?us-ascii?Q?/A0zGVuZIiXNJU/Mwn/HsmgPRk3osqkbQFi2XpEmvfxk29crMNr2QV2SryBO?=
 =?us-ascii?Q?Uhmw0gT76EwHjMxfFO/dwFK4P5cyza6bHc4gJWHMZ5vex/tPUPufmoXUszAJ?=
 =?us-ascii?Q?MAIE+MJ53LqyFtcll2qHnT/UVJ3DjFPj4x6ZOpHxtC4Wa48C1z7jmE3wYzt3?=
 =?us-ascii?Q?pq52a5rgT6OtjXgyc6iCkkMRLRvqL95QubybCPi849xlzhezaABnAbAgProg?=
 =?us-ascii?Q?wjXeDIsR729oKqnBOd1az18YvgQHD8mEBUbzjDo9t39xAAorS9Eo+q97/P5S?=
 =?us-ascii?Q?FBBnluwuKXeYNxbr+VDDSq++c/LJgMEPD1unucNhPjBNm5nz1CcmwBqq/fM7?=
 =?us-ascii?Q?g+mSRYdZdtfZJ2JNvlMnqXNCsskjU/OfSC2/KuWaUUa5cMe0J6XBytpeENIP?=
 =?us-ascii?Q?icc3NFO/OZWVE89HOmpkjNZqOqLrUuTDWBRxQRPKy2p4AzPOlUchAuoGO+zK?=
 =?us-ascii?Q?TFWTki0UjYouwgAHzR07a/ZOs5wHSzh8BeuKWvtGH+YkqoUnVWRdCPM086vE?=
 =?us-ascii?Q?SIBjB8rFfi6aBg9rhBXt6HS9kvfOnkmET7Paf10JaRzG6n3IFqtaHq/Mtig6?=
 =?us-ascii?Q?k8nHGhknF+o4bNnxS4zOdzGDE6lUWlCfS5lvFQkJAUf1CRA52A6bHBUyX9RO?=
 =?us-ascii?Q?NNAbm7wlpoziGMyr6NQaOiwstNqEwBGaab3OqrdiiUXXcC06PKFqY14AHy6N?=
 =?us-ascii?Q?sPn9e2Wxf+kuol78aMuLj/VXUR9jDXjyknvFXn0jqE8AabrE2alyrJEa4wUU?=
 =?us-ascii?Q?v3K9fMVGFN6uursbbw6iQazKD+WR7Qo8Xojeb3VSDb6uLfrFSIlCkKQu3rAv?=
 =?us-ascii?Q?86bJgQGE9pO9ktWuMIlokgBZO6zfid1wzsLei98pTW/kBM+83ecgVh7CrHeD?=
 =?us-ascii?Q?aP/wd1Pc+wuDGMAZ5nfpcSCKi63+U8j8sUsCQHgYSvdlHpn4oGGtpY51Hg6W?=
 =?us-ascii?Q?bn0oPhYc2MXtc0MsbVfLtxOtz6CSuFtH4tXUwzKtJAX4hh2qzlwla7D1UB6h?=
 =?us-ascii?Q?rB2i8k3pKnirQtvxawPhUMAdIsprSK/SM7jmNu2svVZ6dMJyD3CHei4xQncI?=
 =?us-ascii?Q?HuFyWnUq8PsYyDKRxINZzuGEzkHSDlg8rmGuT8/bdBbf1sb8UpG2+yViZFYW?=
 =?us-ascii?Q?BGTVaQsgDKtmqtQvglJVH2/GnLpujckxlFrT0p6Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8a1bae-ecf7-4e7d-49d0-08dbf2bc7d64
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 22:25:57.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZVIRm4zXdhDpAAMKyy/AnFeB05L6B7g6sT9IWs035GUU0rQSiAjT3K8Y1elCqOlL2hxB+72sUIsts1suXcnLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9573
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

