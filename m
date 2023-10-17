Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D4F7CC85A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjJQQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbjJQQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:06:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6B910F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0IvWW1TOdAQszCIl60L+hnMPj3mp3Eg7w4DrQooFinyPgUtBsYHq6dPGKiNpB9/dmvExtD5d2eCA9QsuEIoXnojIfDwcPbziQHo0v2jslWxcNNz1d4YFS/Jm6BIMqS7uPiqn8HDYYC87KyAk2ks7o4ODHGeID2oMG8QIKror12fJvKvOlu7GCgSK4HO0D07R4BCDbll+8G5WtfXMosWv7t+dP1u7oaoNrOnDAfZCXaTIJ8G2KuNuF3WX2udsR6nVHq0U9jOQlgXHqeLa5IK2ypG9rgImkEX74AioI1srwr4j+nwLvyjvR7UtoOHwvVdCsCjaSMOxY+DXk/jYi0SFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSOdtb5blejHqbQRVH7b+62CpLy7az2PBTqLpGu+vQ8=;
 b=ToguDb8tFCl+Zr833cGYKq/rYFTAwRQoGnfceR3OveX8wqK2TaVBy7tgvrE2Y5JBikujhFMzgYnnes95u2iH4Iubgfq1h3KEzColLASPmvr6sRraWuYiawadV1KT1Vg5ldkxirIiQM/fMlwyKGQthN2/yznrbO5FOoBizeIgRE0Bnm3spsfw87keVMZfCUtm3Qu7fy8OSPeCuHB0GUFID0qXK1yZWYY5vlrRBuxmgeMrML4fRPHiGaKgZOgdq8JnFJGbtn2EbVHv6vAsfHbvlrxoV6zSjHsObivTgDE2Xr8sU621iFzE8NDIeNAwxwN05K4m5RmRpTD65S4Mz5aHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSOdtb5blejHqbQRVH7b+62CpLy7az2PBTqLpGu+vQ8=;
 b=P3sTjP58vWBMah6fR2LJ5dbgUhwm3p+7dyPEbYIHgufY+4FRmBp55a+286jSS5pmrMn/Rs7tq8ZPUvfDJTcgHUZXz7301Z3Yhac7G34mnWk11jgE9qICzyN56GmzNbVW3ARbIijLX4ymYHiahqAWqndrRJjpmq2ZgAO0uTcCVws=
Received: from DM6PR11CA0061.namprd11.prod.outlook.com (2603:10b6:5:14c::38)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 16:06:05 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::f) by DM6PR11CA0061.outlook.office365.com
 (2603:10b6:5:14c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 16:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 16:06:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 11:06:02 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 11:05:59 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <masahiroy@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <puneet.gupta@amd.com>, <Nipun.Gupta@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH v7 2/7] cdx: Introduce lock to protect controller ops
Date:   Tue, 17 Oct 2023 21:35:00 +0530
Message-ID: <20231017160505.10640-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017160505.10640-1-abhijit.gangurde@amd.com>
References: <20231017160505.10640-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c4468f-c8f9-4f68-38f9-08dbcf2af71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPHgiN2TifEqRC/PsfrDg2Tj/MB37mRixaDh0V/ylUFKZtbyZxf8VpukfFotGH1v7JK8/BK45as0//YVELVuUuhdGD4sOKE7fr3MJa7d/UxnWCqVvfFOJBhKAaR5q2YrXADDjLMOuC12CrRFOHy6uBZK9aoKrhwlydTVsOFQv0IR8rOxt1ZLM+LTQvPjvEXM8XpYVSS9fw4Y/TSNlFB3mgyQqMVmqvpUwktqe9w+DENHy8o7Z95ANiw1OeqV5pZA4zQL45E3olCFCKL4bpxFhqmMrR+bnksRktV0VcAHYraDIy6ZHORAkJCSJMGs4uXZIWiwi9L2/yRRxhov88yVLjjV3mFlY9i+MxqbVhkMwbyRMVnvzE98Pd6tZrcxN0KidWMYN2runDNcxRT3a+IozRdMb+0hNwViwusFcTd1386DQYMaXCWmjX5b4bExsb/fUg2mUyliL6Wl7ggQifVfBqjvz2ZM3QjnZzmZQb4uClLTOFyoa9y6nwGe7mQvhRauup53yN5Z04zoy2CoJ5NGHcaRhs62zHgWBxRlRfWz/+XdRu1ldlpYtS0kAgI8BnhS0MP2+7pLhk9j33B5bT2Ce/3wif0lhUz0aGmx2ZL5etht2724cT9wrYOw11iVvGCyuAXM4e3Fe0oX4WNyrmnPFBT6Po8RWiqIZGg6ZVVQWICbKUqVr4c3yt/RSfNsghqRnwcIvIjlMAXqrhFHbkPUAT8Q8JqDr58ASsnZe+VeZssNYS1V50uQH7RaETyRhTKDJ6p2R+GHucLl9Qi5P2Kpbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(54906003)(70586007)(110136005)(70206006)(36756003)(316002)(83380400001)(426003)(336012)(47076005)(2906002)(6666004)(478600001)(82740400003)(8676002)(4326008)(8936002)(36860700001)(41300700001)(40460700003)(44832011)(26005)(356005)(2616005)(40480700001)(86362001)(1076003)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:06:04.2580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c4468f-c8f9-4f68-38f9-08dbcf2af71c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mutex lock to prevent race between controller ops initiated by
the bus subsystem and the controller registration/unregistration.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Changes in v7:
 - None

 Changes in v6:
 - None

 Changes in v5:
 - None

 Changes in v4:
 - None

 Changes in v3:
 - None

 Changes in v2:
 - New patch in the series
 - Introduce new lock

 drivers/cdx/cdx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 0252fc92433d..75760388f5e7 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -72,6 +72,8 @@
 
 /* IDA for CDX controllers registered with the CDX bus */
 static DEFINE_IDA(cdx_controller_ida);
+/* Lock to protect controller ops */
+static DEFINE_MUTEX(cdx_controller_lock);
 
 static char *compat_node_name = "xlnx,versal-net-cdx";
 
@@ -396,6 +398,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 	if (!val)
 		return -EINVAL;
 
+	mutex_lock(&cdx_controller_lock);
+
 	/* Unregister all the devices on the bus */
 	cdx_unregister_devices(&cdx_bus_type);
 
@@ -415,6 +419,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 		put_device(&pd->dev);
 	}
 
+	mutex_unlock(&cdx_controller_lock);
+
 	return count;
 }
 static BUS_ATTR_WO(rescan);
@@ -538,12 +544,14 @@ int cdx_register_controller(struct cdx_controller *cdx)
 		return ret;
 	}
 
+	mutex_lock(&cdx_controller_lock);
 	cdx->id = ret;
 
 	/* Scan all the devices */
 	if (cdx->ops->scan)
 		cdx->ops->scan(cdx);
 	cdx->controller_registered = true;
+	mutex_unlock(&cdx_controller_lock);
 
 	return 0;
 }
@@ -554,9 +562,13 @@ void cdx_unregister_controller(struct cdx_controller *cdx)
 	if (cdx->id >= MAX_CDX_CONTROLLERS)
 		return;
 
+	mutex_lock(&cdx_controller_lock);
+
 	cdx->controller_registered = false;
 	device_for_each_child(cdx->dev, NULL, cdx_unregister_device);
 	ida_free(&cdx_controller_ida, cdx->id);
+
+	mutex_unlock(&cdx_controller_lock);
 }
 EXPORT_SYMBOL_GPL(cdx_unregister_controller);
 
-- 
2.34.1

