Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE197FFEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjK3Wot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377228AbjK3Woo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:44:44 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8161731;
        Thu, 30 Nov 2023 14:44:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMb7Px7DzGm9QuNHUBEX9n5hDyt7AyC9pO8rqyo2k/VHKkkrXS8dwUK/i1hY0x9/+quHRbAaBpkGra/EEAXC5N3s/spB7+oTrCbx+KXAZESlcDgbFCQqOTvOQ3EAmsjs/7+SUcGbBQxieWQ2DnP3LYoGlmW0/avoXtj1vTnERLY5C3vk2fkSxAKLWM4vq2ZqBFlNzv+JBbofT1ylJ8d0pmOTB0CHUN49mKolEG91prDUB23cdgs8JfT3argSRET8USlWFU3ivl1V+yMx9LS6HdCR8Wc6xgrUV0ewQ2ZHMu8cMXr8eGrKLkrMD9P5pbyI3mg9S20o+hewTWJN9yyuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b176R2RF531nL60YMogkuUjnlG8fVTLufS2yB0DChwk=;
 b=Uphf+0W7V52tqyJ0jV0X8M/q4FGFXshKfnLW/cNi8nqbT0xwFpshgMinKVN+Cm7k87+XXO01M1fWMfte/0kANzTkoTr16iqTlmwICj5DgYzzB/X+hlzZF+uIcnOhYyJfMvSXytFr+3I347KoR3xwu9OuhEUIgZ/hjr16uIYWMIz/6RM0O7ly+FNRiG0p/visk+5m5NOW8kl4LUoXspL/exkKdD3LoYPZN3/4G4FKmMvu2Evet09sGa6vP8oEo8M9mKxtLF87UtJqzD0dp3fFawGdQrGBWp8SDhaH4pQjHXUJcq9hB+utTTVsB95xtMVChqiGnRDgDZGmjpMVzOEcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b176R2RF531nL60YMogkuUjnlG8fVTLufS2yB0DChwk=;
 b=Zyoc8FVc8k4zF+Ke7WIqdZdcAZp68aLNeBh715zw15uvobKRzeaV+6rrT5n/Gf4NLWZ4GhcaZZjKtp9a9j9FxrW0CNXGWT2nPddZg5iH/OxRJuKiumOpPHO+ovb5BRRvg+qCp4B35P6b2Jiaa9oHWo3KmnxV+21Fj3ASMgLNlsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 22:44:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 22:44:47 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v5 6/7] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date:   Thu, 30 Nov 2023 17:44:07 -0500
Message-Id: <20231130224408.3591288-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 665ac62f-6107-44b7-33e8-08dbf1f5f441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EipFGbCe+nmVQaqLJq7GJQF1vUugZxSxnMKsAsCein/8HxgN6GuT9DYyoiuvrCRuBHp6Ls0WHdgKNYbx8XR4aCCT8rWRt1k3Q/oxfzq/3aLtbms8uFmTk508gBLQTdT0ehWWHmfD2iXKCuBiyqAW1t3ekfOMDnzJYQEwrshs1rNZmYf/JqdSQDQx0Rcq2gY4tUcjBo3p5i52DAcrXuUYqulRJ3e9pVwtKmpJglMmSApeCQzeH6XR6VTJA+4bxBCdv4Qbcato0qhh506WE37OJQN4jIbcgrPiT2x3rLRRggsDiHA8/KJFFGcpRkx2n8lA2BThqEPRaiq6XG8zrHaRen8FwuNA8rgZQIaKLHHQkGF/RX/K3gtgIpS6qZJcJptYaEclrmBXgiWe4S3iUsaS0zn6Uigjn81qP8mCnknmA5qFX/vNaFFUjCY4V/02ZUraDuYKAZSBo/f5kiJTHy2+KxfjvKMolNfdeEfw7g/TdUCQ8PMslKrRKH14pwf4KUJJhHri7RFGj7Oak1Zj7BTgZgXHSoM7CIi3IK86ZuyDMCmWyVl0+G1uNKcGBq31qt+qtYjeSN0WSos4fOB0ogC4Lht4XzjIMwhW0u8jnxugZDUtf77azBJMXRvyAzPYC46JSitGHNTu4HnTh7ERtjVne6bqkPmMld3tN/Q2bsNEpb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(6512007)(5660300002)(36756003)(41300700001)(6506007)(38350700005)(8676002)(52116002)(478600001)(2906002)(6486002)(6666004)(26005)(83380400001)(7416002)(2616005)(1076003)(4326008)(8936002)(66946007)(6916009)(66476007)(66556008)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xsIVPO4ryE1EDW+4eDeYpj+Rgy6oxzxfNz5a+kI7N+peOTR5xKZHQmhcc/ax?=
 =?us-ascii?Q?rL1oReMFwc4sl3oecU3tuJW4DNN0sBlVbPl5RplCiJY3zKuoKoN4y8tpzUF2?=
 =?us-ascii?Q?yQcNi1Q0TZcOzsAD7fqi+NoeOxevljjb1VaaSsz8xUiZw5tauVgCS9s8LXGV?=
 =?us-ascii?Q?lwD8pmxO0F+Am/W/7kc2EyLHd6FltMZESmHcVx085JHwE/0fPs6NJKBUcXbC?=
 =?us-ascii?Q?2QJP4DwhBZONcJO81lWsRpuJUCE4x0B2FrCWQSY/C4PJ5fNUAEckGSYr78oU?=
 =?us-ascii?Q?3ezkgiJ/tbmTokfZGxgLTQbE0Ih07h03QocrdmAFdAkvkmyFRbIIKO9jyqom?=
 =?us-ascii?Q?XWOXFRiCD83/mcVo//CtDdznqckHVp6zMr0bgMPxrsWDqlBNixI36QLJt9bL?=
 =?us-ascii?Q?Bn1Lui1BGvur8ZgvTMR2uTHzadVizcvZnxbEeiHExJHCZHrWLOP294zy+j/X?=
 =?us-ascii?Q?379N6xuo5p9R/U39mEVZT/MoRbbHN7BFWuY/wZClX3Wx4Jz/o1eWPT9HyiN9?=
 =?us-ascii?Q?FqIAv/OLMMwy5bjvyT9mV4p5pjjeO+WrpPOZV+/B5PlETx0o9ASqcTZg5kgN?=
 =?us-ascii?Q?URRUj5+sGgipS8Blen+47d5+jRy4ZMdxwTvs2Nz67o98nZJKO/Jt8sfGePOP?=
 =?us-ascii?Q?8khai2xNcG1gK+ibock7oUEPKUG6Z78GTH56PmCBq1jd5Qrd/OflyllpzQcl?=
 =?us-ascii?Q?SGAn10/ZPYfnO/MRpzidHuG70k4zEOIOjnYIODO+7pKyR7FnJPK/WEds6LMo?=
 =?us-ascii?Q?fqmRtAYI7TVXg6o0gs4YeGn9ovv12xRTL8ctTX05LsRe5SWfXgOUXYShp6cQ?=
 =?us-ascii?Q?LbmCHCXSnRoLwPQSQQiigSjb3XaxF/Q8Vfs6zWC143GMnwI5L/CzjHkqMKW+?=
 =?us-ascii?Q?SYOsmxKX+NHgkt65BgxVFCtPVcCPhCiIS+/+YP5OCR7eebij0c8P/B6uJGWm?=
 =?us-ascii?Q?lsA2w+GKxiBjQvvg26RN6MQQc9XHw/maBwx/EZuAjdI+Uqz9O1aew/cFvueb?=
 =?us-ascii?Q?cQWPFL0y3bDjgX4uFHfbxwPDdlxR/bsxNzOiq0hKcyk9h8/wpAUGwm5MRR/2?=
 =?us-ascii?Q?LDaC5VxMKxX8jMeWV2wvgqE6cFpGNDOAm7AlTB+taxEBt8aGds0BCh1+NJnK?=
 =?us-ascii?Q?BlW5tKQZ/bgiZuCT6Do8d51g/5FJGlJQD7SU7+e2b0fjLztzgtYLsW7mXnR6?=
 =?us-ascii?Q?YL/SvdqiUNsYNPFeJ97InDXMNTtBu0/5NtEtqK1qUfxRCAtgzssE+zAziOhr?=
 =?us-ascii?Q?xSPdklo845QxWVMwlQ9vENiROPBcc8EZ8t4C317rRrBawq3WYD9z7aMJj5tM?=
 =?us-ascii?Q?6o7b0SVDZZBZTU88ngXOLgOekjj2gxxzNSf6zaO/kToCaDcy3cICRpREN54M?=
 =?us-ascii?Q?GYWdQjkTREme91Fmc4e/jfmBx719ijnproyS1MhO4h8rKM7bg/sU9fh9hhBH?=
 =?us-ascii?Q?c/+D+vnr5lUNjuErDQv2ZMhNE2BKmsupcbdQfKGxkJkdJNE7EJVpSPuc1yXM?=
 =?us-ascii?Q?EsZB273ZKXRwDDZPOQgq8y0qnaDYOOPl6eXcba8UN0kNcwL34woTAmg47neK?=
 =?us-ascii?Q?KHYbMQ0uQfr8VU7oO5kLIB3wyev65VQiebBRAuNB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665ac62f-6107-44b7-33e8-08dbf1f5f441
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:44:47.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kolQr8cS0D6vUzch39fsfxOl4FR2bFMRJnMpwtoWgbEAqcOM6Gi5wXDz6AZmVDToo5F5FNitSX0XegRUpfBkpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Notes:
    Change from v4 to v5
    - none

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
index d3b56c9f601e2..81611a3e3585a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2923,6 +2923,32 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
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

