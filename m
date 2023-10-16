Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09707CAE08
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjJPPrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjJPPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:47:08 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2480FE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:47:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKz8g9SX+ugY25mhv1ZZr1kaclV9s6Y+1/0b6fGQexmz3OJs0Xb66zeMSH60bg/6ce7uhYV0dKNzMLiKPsOAZ0tt5rVlOpsZlU4tJyXNCZOp3D1adQfJ5vZYDueWYyROJRF9X3gYPkRP3dtTLo4eFIOuFUOoqSLzSoms5zu8EPEdi4MvFUsSl62JkR/aGzX8d9H5cUFwzSIVZEfMcN6gIWMrl4fFSNdfqsXzm/WthBlgYqdjljNszwPo9JRqX26XUjaZ8zy9UvdzNmNvdyJs/djGEbnT7RqqStRhLnvZICPghwr055eRnoWpyjZQT83MpBStVhbqBpo3P1Q/5ydmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr4HS15qL0Lr/tIXBZpHIbmsN7TKrO1OgsFr9lMg6OA=;
 b=jHg4dQXSSYYR0q9D2SGAeeUV/Br2C6IGpEBE+ak+wDv4XT1wI4cLD71SP0PVvoOWYgP9nmSXKZnHWQsR3+Y4KlptWhQS5GKY896awW/PzeQXDrJ7h24pKXrMnctWevUyFRpDqmBFFdwfCqr8KWVDiBVpqSwodu13rsCmsIAdtKdMb63gUy7750Qx3VV7m+BPg9Z2yY4NuavbutggohRbo4os9S5Qk5mh52vQwNWbEpe7+8Q9FlCqVt8OIwYnA0dkhoGfvnqoc+R6azgHUT+dZNvC6h9S+6SvAazoSWWAwg7PtABRVR9za9W5ZEilAp7B8/WBkssgCHPAS2bhFFRCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr4HS15qL0Lr/tIXBZpHIbmsN7TKrO1OgsFr9lMg6OA=;
 b=LXRe+7ms000qs+sOyh1LPEHpfMf3Xc8pFBfO3JxADVMrAOAPtiLbRqIXkR0ZZX0XwsKU0Wt/fZlIzSr8ECnSs/h/C4Mm7hGXBINBVpzWUCSFzQVGXUrN/LEC0G0bA24b3EB4xCQpuZqyku7dhUpZX2G0f0aJFsOZE1kIhZEr1fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Mon, 16 Oct
 2023 15:46:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:46:59 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 5/5] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date:   Mon, 16 Oct 2023 11:46:32 -0400
Message-Id: <20231016154632.2851957-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016154632.2851957-1-Frank.Li@nxp.com>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e822f8a-11cf-40be-f505-08dbce5f21f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfqJhnqUGNDaA6+YFVt6oS/spGgX26bblxho9jI2UtCMiMxfDh7iPhMYVa3o58cnoQgZR2i48wA4BW6WmyFxXKc8+SpFMHF5XGGlvTrIbt5ySY+/w1vtCNN9np11Qm2JoJG1qAqeLIv1Gp9i/MioIUZVsnT9R55HMT9dJscA4bFy3as93A3C7n+rsZ6I7hjkopDTrf/kJjkpM18NJluc3W0mtuUoHBiyNLGuIOwmMHKKtgUAQM65fSEsyf/Dc4KGDRwe67DbU0wmV9I0/YlgOxIgxGI9sh6UZ8avdFdb1gR5p98rkIy2v5+TxCnWg96L4jP0LrjJYxrGqa2fpFtLfvliiIRIR8mB5nYnBLqDlctf9FO0qk3CdRpDaZPjbA+iv0uItkah3JUgiS6y2/Bf7VlS8AjBB6ESp7xQZcJ9PM9Tk9CvOvDYXVh8x/mTBK1d52x6IO+TcE8R7AGxTrO6+VMi1s8oudtFoom78j71WGV5AQZM0nVWFZppS7ekOUMybV1TU6zTVe34qc1dZdf26wAfe57Co8fio7o7EmGN3MCoID8Wr2Tld0HexM1tg4OUx//27n2FNUuruUXSkFVkJ24ozkT8KYzomRoU5wrFVoKyzH5wk1RieUMKdGEJVxvq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(6512007)(6506007)(52116002)(5660300002)(8936002)(8676002)(38350700005)(478600001)(6486002)(1076003)(83380400001)(2616005)(26005)(66476007)(66556008)(66946007)(316002)(41300700001)(86362001)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wvZS4rMownKFy30Ttmq8onegMjl2kViS/IJ8ZfTOr11gvvSXEq6KXwRpRUmb?=
 =?us-ascii?Q?ni2U50Ng3xITwvWnUfJTbEJsJfSyv5KyRMcoUxqs0DAeh3Upb3mdoqJAt0rX?=
 =?us-ascii?Q?1mCu915QwjJyu+wwD7WPa3YAQ5wr2ZZO+EjI8I8Nkex7W4zjkWjNBlz68UG6?=
 =?us-ascii?Q?7JpOaFtqiWNX6oiDiTtboOKEI7S/5RuBFq9o6OdBsBhetLoonBmTa5H3soNS?=
 =?us-ascii?Q?/Ej1zYKjnSryfuoDOlbNercaNgiY8idA2EKhdakYWeB4KQ1oYhTv8AgCkhxI?=
 =?us-ascii?Q?XNXqmALx0zzGHh8sfuI6Aa2aBZ/lfLSXxH3MbQKCdKHX+/YLEKRUR4cqHODB?=
 =?us-ascii?Q?wvMvvVl08OtZtmaCx80yXAwEk2AlsJrnSZfXcERk+q4BQp8Z/7GrEcTdzRqp?=
 =?us-ascii?Q?2SMnrwrzDMRTItiZmHn6cz1lRAaZvoGCTE2Zk6LCFdL0QOIkWwkQ/jhUoTdH?=
 =?us-ascii?Q?KGIqWNrz42FKPnHCbP6m4VOQlMfJsH3sMvHP88U1HtCOFMSqqNgNFJiiE/3y?=
 =?us-ascii?Q?q/iNk+TqjRCYT+qRGPRYM+M66myEV0XdnKuH7xXTzq14ZupT5U9BYbIDK07r?=
 =?us-ascii?Q?Dy+RJbjqiOUE7buD0ZwqlpBwcNTFcfbliGDSTE1GAEb8HmVWbeuQDpkZIiWS?=
 =?us-ascii?Q?RIopvm6fLNchKW7rspMPjAjJIKeyFTOGiuBxoeSkCL5RVK9d9c64OSWMoG//?=
 =?us-ascii?Q?4aXywg136HwvxcyWI9vts8IJglfj8keZEdSQjdt4oBaEg53rkh0LQMoa8iyL?=
 =?us-ascii?Q?uT8P3zHRpuuiGtJNQbfhmSIFqaPuwWAsqjdOO0LuxSwaDZ/Sv1hRemx4k5Ca?=
 =?us-ascii?Q?o8YQVoLXUBloySxWjLCGlk2MjToECQD3rewUJlP6Y48AoZqjrJTDFY7LGEUm?=
 =?us-ascii?Q?64gLe137cPz6U+ZUIpgMGjQjjF8b9u4avQw1rWSlxW4KfWUdVLyxiOGwIorV?=
 =?us-ascii?Q?BGd+sgQu9OVaYkLvghI/ZliaA0DzLs8e4ooSZWC5SM57hl1kLjfSZxx4qZl+?=
 =?us-ascii?Q?xAI9JUrGC7V/9usaUpSeWubFjpXSIg9wK4Q9XSkSwmuZHuF8IleO2y/jSGUw?=
 =?us-ascii?Q?ahH3/uClhLuBbOqSun0a7KLC9skt2PuSYWTYkTQqI/axsuA61ZZnnqRjbh7z?=
 =?us-ascii?Q?Gtm6LwuGmdb6d/VsiIVul2DalQNHBUHGlfMq+dggopdE4JNnZNFVfo1OD7S+?=
 =?us-ascii?Q?+915THTLn13NiVNT04DOpVpCrsVykUNoNhZxnm4L03SmGYAR+URA7e8XOxca?=
 =?us-ascii?Q?6GP5fmXUCbCMOWpHfQdXw3d7Wtoz6jk5+EGZOUeb7jE9SZeEcwYqrn0XbcL9?=
 =?us-ascii?Q?X0syD3ovo1iuHNQJEGkdHszAzg1Q4lWFkxd+JpDTsUOqyKfGY2lU4N+/paIt?=
 =?us-ascii?Q?5lBFmz02xB9Y9rfruZEs1o7HlUL/EQtHwsiqbEleVK0B5ew5i0Vy7BIVQ56D?=
 =?us-ascii?Q?0MIXSQGsF/ss311yNBdLNATEnX8nvks+8/d7XhYhcIq+UKE7tXF3+dly37rB?=
 =?us-ascii?Q?nCzuw6jrd0Fp/q0EfSYkbdebLJLpCBV4nee3vPtdgEZTiShB6OX2ApfdTImQ?=
 =?us-ascii?Q?mAM61FZJi2F7B1t6CXk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e822f8a-11cf-40be-f505-08dbce5f21f6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:46:59.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeQ6TXz93fDbAFi8r/aBnp5ou9uTh7T6EqDbdedPEPJqsk64LpmUhgDs8nvEuRm1Y9MH2moiCjeMIxet3PK0Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329
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
 drivers/i3c/master.c       | 27 +++++++++++++++++++++++++++
 include/linux/i3c/device.h |  1 +
 4 files changed, 53 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 1a6a8703dbc3..0566ab9f1498 100644
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
+	if (dev->desc) {
+		ret = i3c_dev_getstatus_format1_locked(dev->desc, status);
+	}
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
index 908a807badaf..976ad26ca79c 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status);
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 08aeb69a7800..fa831721f305 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2840,6 +2840,33 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
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
+	format1 = i3c_ccc_cmd_dest_init(&dest, dev->info.dyn_addr,
+					  sizeof(*format1));
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
index f2fa7ee5d96d..212cdcd17179 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -344,4 +344,5 @@ void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
 
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status);
 #endif /* I3C_DEV_H */
-- 
2.34.1

