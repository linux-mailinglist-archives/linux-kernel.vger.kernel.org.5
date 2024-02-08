Return-Path: <linux-kernel+bounces-58398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483A984E5F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23CF28E785
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4032086AE0;
	Thu,  8 Feb 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p5Nzwz/w"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C48613E;
	Thu,  8 Feb 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411731; cv=fail; b=n4vuWw7Z2H3Eo2RGQ9IgPVN0KqiHNu4gFH+C8FzYxfP2IT2Skovws1PZT10JErvLUtDSI2VLXCR6UOWazDlPTE8MbxCRgww86mBIkZnoAmSwUc108YNi+VKffltPpx50JYGa+IHGoI4qROsx2pGDjrOkqLeD51m0DtF6PH6YIoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411731; c=relaxed/simple;
	bh=qW3xZSPxV69HhCqaxH4lMTpKrUoMPbR7IONE/5QS6Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASQwel4bT95Y4XP9FGzHK47T7eYagvAGUe+s801pTh8rb5MLRS3kSaKf54+6l++HqwGO4iRHA4JF9LIB5oR55iDIsM8GnRZ0vzRRltvGnyh3RsJjs4sh3Vqdd5vC77o5L88CspSjipXSKQuMAs7K9GYxvdp8dbU28l3y9+ZuNgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p5Nzwz/w; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1pGIxUs4vWHQteM7sGj2PlT4A7s+tzqwG48AcL9H2q4Ble6V/EWgpLjCVCbkPX7ZMbefa5HjS6GD6EwFTBL4vmdIX0++oKG7peDVw1bNr+U3S9RvN9FbBC9akt+d9mWh0s1tcrD2UcauByHbfMJGY3pj1EUZGeGITHwJonBaAOxHn9/bAbUBg0Svc3CgO+lMwJIjjWpuGluyr7nDhqJqGKQWXloKFCAm8qqAPAfxYVnND4WJbISSRmdIcWVGryTS1YAm1bVWtdzgYoogyvmTI2QMGaVvOeH+SjGhogNUryqYAdEY5aTJVLbH8SuTGTOzDCxtW/OsYgAXnZR2dHkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=DA+9yvaR7gqDIjQuNzuLclYXTIyadZPyYXgNsU3ddZxCBSo3piRyNfJIOR/u0AxdfpJgfZdF4RtoV4D9iSHW71oVsCaJ5h4PUf25MCWeH0wGFKXG68nUFGGIt7WOGRQ5BnuQXRdVJx2altGmUP10D90S4iKVeCNyJKVkMtPeBmfzS29TnwKWzjWOlF8oWcDFeqf08y5r5HBweKEHW6eC2Lx1oFYA8ilOOg1OEFPIhCw0SsY6m3174CvAImukAK+tivyt/pfSJpetqxdacr1VsONZyC76qwhaaTKUtdHe1u9sAVKzcNfVGmv/1/tFnrx+qL3o38FEve7XQVJ6tqXMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=p5Nzwz/wxWpZ+qJVH9lN30usqP90zQuf3wlGKivXwTHEoOVAhxZPLEZJflpscHZW4vIEBxFC1qBDdxtD2PW5V4cg2Zi1d5XVBBFhG64ncBdzi0w2BX0wNBNB9jubED2WaMrRMMGHLPoZLuslPuTceAvv5h3QEuK/juiQxNq/FEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Thu, 8 Feb
 2024 17:02:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 17:02:06 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v8 7/8] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date: Thu,  8 Feb 2024 12:01:16 -0500
Message-Id: <20240208170117.798357-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170117.798357-1-Frank.Li@nxp.com>
References: <20240208170117.798357-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acd3f31-f953-4c79-0c75-08dc28c7adc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WBfaKCGHc+20t0mlC2aL1/umsqegpRuEd7xUvIHblXUia9GY8kppsirj+9S3YLUeogq23Awnncp1tWfx/qu4778pbRNR0W5WLMpAIlgMm4OO+Ancc7sevXZfLx2mw0Vb2tYJhxBrD1h3D8cQyRATBCETBt5Qqi8NIM3FGVJTiT1atku4IjRsDKfMJUu6OZGVmIRECx10BvMx6N2moogP0KTMnx0uWiZFxmsDQGNug1zk1CCG0eGKnDxTxErnwb0Abb517wGTG03fx/OpBmZrmZ2aIgJHKrEm4lLCtGSSfYCZSHvAfBEpahv4VrGVMTLeuJSS12f9gakg5FRcqK0vnnQFt0umSEyLKi43C86plv3N5psPdmvxKMrl/CWw6BMpSr7OJnLq/soB8UjvJs1oVbHWHekGtkF3201cIc/xCuYKgwwIOFbqLU7702pK5u1Qi+Ud//dYry9Qg7MJFbScPD8lmWwr1gpSzcgRYJvcwZUowwBhIx4rPHeIVNxwQ8ANjVepTSTacxQumLsi3W9WoVei3S2ix2e0/xcQflQAIDSES+YNutYe0NxDs/9kKcpLhdh07tg7xsktKWBVEXpnqtyz5qgnNC+SnbTzgbdXQYhCreXB0+xFtxeb5oldZkSf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(52116002)(26005)(6512007)(2616005)(41300700001)(37006003)(316002)(1076003)(478600001)(6506007)(66946007)(66476007)(6666004)(83380400001)(6486002)(5660300002)(38100700002)(86362001)(8936002)(7416002)(8676002)(4326008)(2906002)(34206002)(38350700005)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WvFXbk2/vy6e/aSWOZZG1DRcK5Hh964W0Tpq7Gkhs82/c4ayegFcjyZxAY7+?=
 =?us-ascii?Q?68BJ8eGVDhhjqZZietJbystgxW4MfNaDKBbuH80rCIGNYbq5QeyvbYo69fj2?=
 =?us-ascii?Q?Qu3rZS6/hwIixvMRRaPFAmZS8VUFWRtPv0cSY1dueeMr3THljnArMDPG6koA?=
 =?us-ascii?Q?X19QTpJahU+q+67x95maPpqhzj37a3HQk34/NHnf1OTgUXO30RsSOrpf1vwV?=
 =?us-ascii?Q?DrQ9A8qHKr1rEeID9HCfCM3536BRfHLnfYhyH3UU5Fj1QvLId1DI858kjuhu?=
 =?us-ascii?Q?0BFjpuTA6slHn2kPz+i2G44p3P55r2lp/2sKJUSGclKqF2VHR7amXEdTkTzR?=
 =?us-ascii?Q?HsQ8mCjW1hEUuZA/q8V0cdZTU1YlD65JRqHYGmt92dvjGM8H/cBf1HxzKyYn?=
 =?us-ascii?Q?JprGe5E9b5HG0khUQutu71BliWtuDyF2yWXK/2YPnxfrnanbvalRA9HNw/Jz?=
 =?us-ascii?Q?FJt8cpSKV3M7uwYllhSzJfWWWHk4JNNrSJo9gjzuvRY/gbQYI+KbQ7S0eXD3?=
 =?us-ascii?Q?Uj3KDBxNbS/DPsSeNINtGK581xzBZ69NxXFOtr66mN/PMiyjXMYVsw8XhIlS?=
 =?us-ascii?Q?JTS+QolbRzRBXYuzTsnAFcdU0SAWGozDdu68Q2bJn3dKxLQ6obQ/2x+JNLub?=
 =?us-ascii?Q?vs6ps3Bg19BYmGtTfn7u0qHESMmh1ZIk5DrxuXoo60OAKXSb1egmmrjMvuQP?=
 =?us-ascii?Q?Z2KfaTQjX5uuMNPv+8xUKuvN4FKpfLmzZAb1S13HKiuXXTNVOmd5IQvimUlJ?=
 =?us-ascii?Q?AV7ohLisUy+RKmYBjZaE2AHSaogMAkBWI7KNnybl3nbmWLqkLAkdKSZim8iJ?=
 =?us-ascii?Q?xtBrxb+pawD3CyWxbXs1EhuKpLRH/lzwPsbsTSgBxuR22Mw5RljPBkhD1mdU?=
 =?us-ascii?Q?43QEgKdfFZI34dZuCex9MzP+McchYds3BW0li82rS6wq0c1X9vKuUz0/USAI?=
 =?us-ascii?Q?K5tefzs2Cx/Zj6rznLPBZXaP8lyjdc3AkXfbgWAvgkuXaAWo/gtho8Wn111R?=
 =?us-ascii?Q?HfUn0HwuWkdyPAsjS07UTzFqQxdWGuTLkOfZvAxrOV7NsVocBGhByd/C/uyf?=
 =?us-ascii?Q?wfCxoW/NWklx2eyhC+9JfxQJ2F5LTEKzC2ImT0iFzuEAvYZBcnpBc7gOAC9S?=
 =?us-ascii?Q?Z6Rg/1kdXhYyINHLI52t001C5xF8fXDpQMmhGLak9hmulK9NIXYrTMbkd3Wc?=
 =?us-ascii?Q?zmdx8tz27w8WSQWVL6axCIQ93ztiLPqGoa/WJKb8LNlkaIhqFNyIfjgdgmGv?=
 =?us-ascii?Q?w1pXi5BNnkUJ6TZAN7U6IUWQ6/jS9B3llgDZ3/FaNuDyw2U+QvYCczJcXGAJ?=
 =?us-ascii?Q?CDXwwiR0LPlH62vaXPVdQaQAKer+EJ4IK4A7LfYaH0L7QDNKyxcdeyMbzsoF?=
 =?us-ascii?Q?RTOaD+Re5hJC+p2lOD0NQg+ElTMlyvPDxdGvb95FD1mCdDLfj7FaOINMqwGO?=
 =?us-ascii?Q?pJFjR1eplDq7pT+8ntUxxxGxnGcJzdKISlo/tfsY9XUyiQJMcpZaHp/lBJ/a?=
 =?us-ascii?Q?fCL0QCmzJEYVtQYb1iCZDnrhR1cNG8kCKVnibyUh7Vd+18Caz+nE8z8ljcBo?=
 =?us-ascii?Q?wJQK0/GZZGSgkVRK5NygdBhbVN8C7UmI1yjXJ4y9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acd3f31-f953-4c79-0c75-08dc28c7adc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:02:06.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt9EFhDvzkNKtyBFac9bAvexc1kuj6DWD0xK0B5lyQcyhRlZNKLJpK+bWcHgDX+0hoWporwgPpeb1XyKhLXV9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931

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
index 3afa530c5e322..ff61a218bcc6d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2988,6 +2988,32 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
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
index e119f11948efe..66920045ff042 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -345,4 +345,5 @@ void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
 
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status);
 #endif /* I3C_DEV_H */
-- 
2.34.1


