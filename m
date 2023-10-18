Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9855E7CE9C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjJRVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjJRVLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:11:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306AC111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnoHfGes6zd4u8U2AOxHG2CvtC3lFVkMvxmnFl4OYrPNvMJR0mMYoYSvs3/FCClORrlynCRhvTFDBl3kYCS9la8V4ggjQ7RXM+7fPO1X+79l6X2VREFoXrSxAsraLispuqc0TEXiLAiQImdSDBNvDcxBMlgsSnvmCUu/bV3JAcCu6dJdMJarV/agImCXB5skM4MRhBH5C1fDwHtBCx8HG0Oxm2V7iV0xxjPWGvzD+nHKjKGyIdwtreyF4HVHhSDk6zgA/ZYe1R+XyxAU4lcxeAUeRGuiZD5GxZBXQ6S4cTwXkrN9UTI9hg4M0XCTPcUWuXbc3TU8XcMeF3qRcSO/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDlf4xSFouG1bOinSyyY0+9HL8i98T9MXvpDH0ZtEyI=;
 b=ZSrHd3Kv2pxM7Buna4IKFGmK6BaayzbUyN2VocDevMDP/bzTvqtHe7IMegkOmD/8f+EY5PhB+V0wkJgHg5pJA32TRznNxLgYDXHeaM7CCq4T3t+Svfneb7l+4PxfvdNxm1ljir7wiX1L/86cufKhhz/N8Ic1io/RQclhOQqHH4aB3k1xiUNxemk7VBP0ebFKSU6jAelb2mvryD8R+/J8Qd8Fx+F5iQnEIfyfJdctyS2v0YacOizmE1zRc9BnNssoJHDs+dsaxAH9h0/jGyWVM5v2ZPJAGsMSLQ/j7MJOuy4uGKvF0vXqzBM/8bd8LgW+MNuROawcHUtep1zwa92+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDlf4xSFouG1bOinSyyY0+9HL8i98T9MXvpDH0ZtEyI=;
 b=qvM+vtYSVT7iqOG//bJgA0yG3dNGajkOnC8wfRPun2mtCUXeQwsbDCFkDFWT9oNMLAfns61iw1grQuqiY8CatZjdkpNaCeC1facGhapmQVBf40xAox9ECKuzLybCVFoKEEzdRuW23hkhujF+yGoGUBRMSRAgzvZs4eCxDTDE2YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 20:59:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 20:59:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] i3c: master: add enable(disable) hot join in sys entry
Date:   Wed, 18 Oct 2023 16:59:24 -0400
Message-Id: <20231018205929.3435110-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: abd18189-f3a1-4fc3-5fda-08dbd01d29ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RF09ZxiVNeSIRC55hGj8pNrI9yPilx+/CSCqq73QJggaocvl0CuCthZasWMBCwyDiDDnhSM9/D6M4Ak+/NzScVDSiUzIkbU9tjZaUmOuCaFWH0BZjnOedi16RF5tIuPcLggttyX93mgn2ifUaxNFeQnzNhZvgHnZsQLTqukl7MdZnUEIW3WG9C796WqkWCSa3MaUSSX9ZYK7qvEteiIVGw4Y4SO84cAIDLrktaTmvki26xnCezWlsWQPWDcJjXl2cQtlAgC/tzRUNPE1p4BQeU5k8uYw0mgXAf7jhcVD0Zotq5xZr+JBJRttoNaES6TnRXBv4z8Iedi+z9cr26KDaZF0Zy0mKkOIWTRjFUAjhInnKb93DLbI0nSNlRpR3jPNaa8Sgo2av7Ux08ua5xcendbAORNSqrIY39c04SGDsmrmyzeDwHd1AHeszpFjToAbwlBQkFg4GvC09ozt5pnEH2miArvV/zGn1C3jMm83DTUQS6tAUnb2/co2uU5iia2mjkCVxXu/eJFX3HKrVepncwipgNneUS+b9Y5kpGko3YCeC7hi2zE0CfnmzReWQWvFdnx5xSA58bgsNeKiYg4qc/7s5eA+DLP7D2L9RyLkVWsqwC/4OsYKUW4saSFsTQutb7pLJJz/sflet7fiD0TZow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(6666004)(6506007)(52116002)(2906002)(4326008)(41300700001)(478600001)(38350700005)(6486002)(1076003)(26005)(83380400001)(2616005)(36756003)(66476007)(66946007)(6916009)(316002)(66556008)(86362001)(8936002)(8676002)(38100700002)(5660300002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Px24vC+CvtzjwezD6mdI5X+kUJxf+XHoR9MF9z1PJWejZEDTy65opOKQaFuk?=
 =?us-ascii?Q?bMiJhNDXOsDmRM4Y231VSeG1lREGF3YkCWG9SV6vej4DVJgn55B6/KpjFZDF?=
 =?us-ascii?Q?cB2Zt4cDoB+Bb9adQnWgttF3sb/Gt7+nstWB8tnuhPijwHGQcSuPjeJUffGM?=
 =?us-ascii?Q?YDLDKDy0PNvSxg3aW24TRSXy9nD6rHWXgQabL+Xa4A49hVMCAUF9zTeZKjOM?=
 =?us-ascii?Q?0nYlmcqOoeRdfSot5z1Ljna62s4HmRv1/EEmFAJVgvWgZDrrdN88epBdTSyj?=
 =?us-ascii?Q?CgxuegulmJatB1IVF051or6g3q/dfEQ8tGFimQwFSQ8XyMRwEzsjjSbmjJTK?=
 =?us-ascii?Q?QGO9oPPmv9WiJDJqj2mIf/+ItJFzavbua7Covvq45yiPEsJTYQKhBkZCAuqQ?=
 =?us-ascii?Q?1MJ1q6Wmj7x8J2pRZctY1rwu7EbnuogyavTIQ7u27ecF0+ZJGzTe8p+WYQhO?=
 =?us-ascii?Q?afR9zXJnJc25nI+CssLbKhUbmCRCGn7p+RrxikKoz9ooFd56WtcCyurbNrZn?=
 =?us-ascii?Q?Wha5uN8NHlHWXOEymXSjZCgG77zNywbF9zncezGX1rZsjLWm72KRm95jyd90?=
 =?us-ascii?Q?x3HmwQEbvEKmI2S9q8KnOR+eZ31IAzhVczulA8e7UoZbiJboNHakp+9f1Rdw?=
 =?us-ascii?Q?RL+3cu41NTRJA+gMtn3Rap6mj2wQSIvytOmIeVAgqM63Ai0Lz5zBa3fMUC99?=
 =?us-ascii?Q?KuMzFi92ceelDYT6lB7rgy4+WeXDT8YcPSkThHiHtlXNmqTtN4O9KmFjJYMZ?=
 =?us-ascii?Q?pynDqRPvtVfwSD0ZqJXYW+iL4tLkaV++IfcAlEQvAVAQNF9YBKa57jHh1/Lf?=
 =?us-ascii?Q?T2ZUk7eHy5lhG8LyW1w6zzuiqr59wPOSXBmnpdZ7Z+uapnPusVYtJpBB4fjQ?=
 =?us-ascii?Q?mKSN7FBV0oHImmePCXvFB0IRyb84xPat0VKGcmgt1HfC2D0iPH/cq/wlw1Co?=
 =?us-ascii?Q?NojQyafHqruDHGiEisAgaMROAMqL7xv2/JM9RTW56z9L9OEyiHygyb7woxH0?=
 =?us-ascii?Q?U4ksHVJNYNoyR5VB6YwHZcbqi1OeSH7pRuMO/xB+yPyjoV4yiKnQcyqNA0eq?=
 =?us-ascii?Q?IVkv9c5v738Wp0yTpskBmgNKA3PYKrVoGXUSoV1RGtH9nQtKiqd119fMupVl?=
 =?us-ascii?Q?JOGors8QWUYgzf9oqlZSKZdzYkSeb9bSAPmeXK8JoqDfmDB384CBpgWQda53?=
 =?us-ascii?Q?5cN5d4n0LuTdHNa1dMlY6rQZsJEhhfkjUCaPUHHIvZI9Yr7wdq8SpbrChTxB?=
 =?us-ascii?Q?m14q42cewQXNeolR554x1jRVwcy5fViM7ze3/i3ifJ0oF2kRq10/VuQNNXES?=
 =?us-ascii?Q?rzoUJxv3x4jmP4mS/DEIuBPRUUH3vEL4Oj88Gl6A38UA4Pi+QshDYiPwjRkK?=
 =?us-ascii?Q?+VCP7KYIzJ8y6G4YqxbVneGrqC7ljiqq7nHaMkTzaedmnP/C16Gw7LDogbsw?=
 =?us-ascii?Q?NlWDLGzZZK3DFKSr/+4upzHK5Hkm6GS1jj23ziX1frtWs9iV7L5OTl6jOuSG?=
 =?us-ascii?Q?7/C3zeIYOeUZ//nxijgvmoWSbxhlWcXZZT6bMn98kF15MKEe1svfQAPb6f6B?=
 =?us-ascii?Q?Q6B7/abhgfSk0a4LLu0WJVMgP8dkAufjzBXMCdrO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd18189-f3a1-4fc3-5fda-08dbd01d29ef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:59:48.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSwioh/k6nRm/vdWr2UV6OEh9NiCbomkw+qXpzK3egcGYKFgPZEGKZqjlWvIZbWETQFybFWm616bVmgLBBAzMw==
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

