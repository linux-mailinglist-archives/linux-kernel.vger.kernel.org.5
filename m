Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20E87FE2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjK2WNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjK2WNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:13:06 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A5172D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:13:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOcinrE5Q2bcnp1WngSndbSfwXsvOt0k35uVVAfQkVPm8lq4Y3SbmNkpY8s0OpfDl4Ldyz0aQaz6vrFn8vPEcUaX9O86GFuwO+Urvu2pSe/n6yz6WIcsoCh+mPKUJN+KeS5mrueIWGFHqz9ISJvLYhWU5nVqgIGVV5IzIU7sQMT2nC0ICn6I0Sw2n/TGp2WiRR523QiDF9KxpbDinPGobGyagHh5ESvBR4JGGcd4XivtZKWysGoNJhKqQiiOVcgekoeXQL1e5TgoNxB4sVPwSCZA70ZIE9FAU4/98vEH4LuHwMEKKsDJfLZg/UtBwyver/yyE3T/xEFymDNosHXGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPWQn2l7iuQDprEGwbhMq6laPM8yM/hxK/Z8Bbastmc=;
 b=McfJWlnwxlJWIHhz6TKUDUd8yiuZ/1JY5B7VK4mva0/XpMOF+XMhZlGcCIq0h/4XCG3a0nfZcQXavO6qTGvaBDyg54Zl6IjC2OKOCIiJDouGgNFKE6yRsRcAsWzzlJmg6XfF2JRA89mn3J7/g+NjKK1VKNOk0VZwcXlsa9MobqSkoyy+qZOjx5sVa/bitbcPZL76Kg4akSjJvmpSELxGDY2yiavnb5SwLINDQ5TMWh+Vu/TQb9CkUpuhKleaSIkqrEpO3d5EZAaoiK5nWE8HeeG57DgM+3zg1m+ToOqvv0aHDshfhjL6uF2s3x3jMeElnTMWe+UbJ48hjjW3HIaqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPWQn2l7iuQDprEGwbhMq6laPM8yM/hxK/Z8Bbastmc=;
 b=oIUt/M1U63K5xrZjQ9nJOrsJEz/2zh05RrJVADZfc4ANyTBHncU6phspWaIN8qOeAaQgchzS5iMM8A1O0r8kh1QqK5y6KpIinWFIZL+BOLa8dF8x6sXeOUPYDhSKuunIIYReCWSDwGyuMgTdtTBZgRDv9K7fL4/DiMhysZtZ5U4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9578.eurprd04.prod.outlook.com (2603:10a6:10:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Wed, 29 Nov
 2023 22:12:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 22:12:59 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com
Cc:     Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v4 6/6] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date:   Wed, 29 Nov 2023 17:12:25 -0500
Message-Id: <20231129221225.387952-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ec119a3-88e5-43cf-9742-08dbf12858c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRxqB7tA6jyw0QU+IMByfrrbJz2pUDseokMYLhf4DLjtJeQRDDYv56osvP+iRyr/udM8mXnrV6H8zUxyU8ZtV+rVOxT9ZqHiUOtVwmmEkRy40Aon+O4N5/z5VrZ8lE7MnGI/GB+Z3u24J/W/OnfM9X6jlgbOfxj9wVZry/bMHGuNk/Ibx7J9FBfuN5ZzBBfQKr+jSDNPIHLib8RAn/5DzhI9Grcki7up8Fl1h8bWmZx0rKDatkwDXEPpNQLJsKFvAMoqXtIEJvEwX4CK/O+EgokPZNIvwQBM4t6kB59pCpkVZI8eCLnbBRfpY/P3VpQiHBF10Z/VqweGsoY2nzuc2rS6glW5KShLwSCvhAU/IUAtbR4D/0OjVZFCW4cfNMpEuA5a9BaDbGnB7YRqkZNPnmYq4HJ709IrJiPl2MGAHZD6GqLyujalGlh+/pRCZZ1jqKA2zsaJDP54W+FZdKXe4ypKq9kxEK1iQIJXBJn5Uqbn6maLBW6JALXpuEMMji2MxSjoVtZ+ecKuHUuawFITJjwQSgLUEZ2eHMLBi5Fa/4ui2+F4xLmmdU2yOvjohOXCi9Tw2FcVys1pjlCXu0mA5pGKhJDVaq9TOteuwIWcsOWDbmDdU4W5qnTo6dk3kBuMQgSxPlUccmAGaMOde0k0QKQ9QzuWM5P2NBMUoITfqfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(202311291699003)(38350700005)(36756003)(2906002)(41300700001)(5660300002)(86362001)(6666004)(6512007)(52116002)(83380400001)(2616005)(1076003)(38100700002)(6506007)(26005)(316002)(66476007)(478600001)(6486002)(8936002)(66946007)(8676002)(66556008)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vAC3A2Bdrm5/uqw3WZVDX1nE87b6iXtQ4yoZ2jfMWsVRGhxQ18D+s9tefKn4?=
 =?us-ascii?Q?j9XSp3cOwxbsFKIOJbr2HWte7pXZFHm+QhUkOQdF8r5ISYI0jFQdHyG56Mri?=
 =?us-ascii?Q?o68FtEgOa9F1DYcGbyEnAXxOtP2klDFEJJOfGolA/SGeRIVDPd5JhIwI+A3k?=
 =?us-ascii?Q?A8VpH36GgH1+s1mjkvDSZl5iJ75RRVRmDEhvrV4VDOA/TPrN+xVj/c1kLFDs?=
 =?us-ascii?Q?HUUvHdfyM5uBPPMxildLQwB3iEIPe5qqI7bwQz6ATMAon/fAbyHTV6HBzhQ8?=
 =?us-ascii?Q?S+DihUnolZIOi+HvcgjoT95N8x5zHr0ZaTU5UjXubjJaPdLsqaDnIZcAHg0S?=
 =?us-ascii?Q?te0Nm+u/O+ZBwCcyEKVBJhK6Z8ps6XY0/MPWO6uXFZS13PWkHObJNMUNHp6K?=
 =?us-ascii?Q?c2G9rQUEfUsECXfM3GlOqQ8ZOLU5RCJSqB3vF86RaCuF/0YCGvEW403eCQ+P?=
 =?us-ascii?Q?zzcTpMFPAb8++OCGqqnj7qFPamafxoU+kT+M8moMu3r895kVLJo9My2Imzes?=
 =?us-ascii?Q?y9qc0T5BtyfM2vage4f1zHj93EVCmH18GtNIuE1y0/cDweZNrfb73kG1JRzd?=
 =?us-ascii?Q?tFf2YA9+BynmJMQRUXH5oRmlZO72owjEZO23g3uDaA2CO6NpCjwJP+6k0Ip1?=
 =?us-ascii?Q?Arp6nkLkTsisQYEFVFSQnA64z6HMRlr6XLY5OltOzGoLrxjVHOMlEWpRqQ1Z?=
 =?us-ascii?Q?M7OUjv7VhJ8VoYI52fzo27vjmU6QRKxlw96LefAct3smUEiwcHuB7MLrSzZi?=
 =?us-ascii?Q?jXekxo09HeQLBxqB8TaU+S+V9pWlPtsJP9/Y51/M5tFW2z8GjGkUuX/ppgGA?=
 =?us-ascii?Q?qQhH7p1nuk6n4deMXVQVoTTNWgAy7GnqYRZk68ZxzLUsPTjf5eLXQoDWIAVa?=
 =?us-ascii?Q?7GChc7j6saBf6AhuVidHYQdDI9P1EUenHWM8wbYJJbFr3hqch0TnQW7/HiN5?=
 =?us-ascii?Q?PRKdXLunOfgRJDNC3J45vFD/tmdxhdKyJni7OS2V+VhMS2LvhZDDNPgX25eV?=
 =?us-ascii?Q?AtPhe9wP0ezTSd4+LUUzwL37TTHgYjgNIKnVNnX5jca0BZdIe2WtdxfWJm8k?=
 =?us-ascii?Q?LBtyM8IvSdUV14Y8PVAiWL2ygutV3qCgf8UprgdWE3/w3NJcb7fBQJXNdtLD?=
 =?us-ascii?Q?iTh1237QjGG7H3rk26CHibA5MpgWmGYEWbm4PJxM2n1AtHd1UuzG1FFvuQF/?=
 =?us-ascii?Q?BbUqKAxeporlf30Pgd/VelEFOKJPajmoy28WDBoQm39zKrMhoH2p62uTxOye?=
 =?us-ascii?Q?GZxwJrLtE7CuacKNKyrgdmW31g2qWqXtciqKqQUSenvJeTYDWsJYMaa9eH/5?=
 =?us-ascii?Q?3+KkuUbKIvaf5FUrdUNkYkmuPiOzr5JVY1wXIv2SRDlVzTbRZoN08w8Omn/n?=
 =?us-ascii?Q?xCvcPnkFFF+Mh2aH51urh4EJOCM5pAlwyer8EP9f6PfjMGc33rH7IegsVUfe?=
 =?us-ascii?Q?MyTGaOQMSBXUjoeqfzjQyRIPlKxI1lumibzJK3SS1+CAHpvjy6veq65ySHhK?=
 =?us-ascii?Q?rvuQB+SnUKNbwseg1nZLvlESHkUXv936BemHCvgPOOYLK6oEaAB7wtBJOv0n?=
 =?us-ascii?Q?3utgJ9Ne04jWh3F6XOmc4wAc/71fGXiALBhh7MEA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec119a3-88e5-43cf-9742-08dbf12858c1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 22:12:59.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAlhJh+/uo36cs6bdEyPr0f6EauS45hPjoVWfFZv6ZQdLGH1lR4e4MvG1626woOvut3efu7Gh0conSjqJOZtSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

