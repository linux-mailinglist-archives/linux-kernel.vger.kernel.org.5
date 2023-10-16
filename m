Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3957C9ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjJPFeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjJPFed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:34:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2409ED;
        Sun, 15 Oct 2023 22:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1Q7QKa3ruGA4rmvraQ3lEADNcz4L4ojGZBMA+o+rPKjDiP9Iu0WzfePYKvtJiwiscxIFu5ifauKh0H/wBURCpFfs0upOHQaijoZiqavPRGDRYrRc2CyFlnTGyYAzutzGLrcxqAGM+yzlYyLM0XrLpu2WMKCtyA4O5oWBLdK6v58qKp/P+xEluugswuaSP5U0JhsKrZVgKXKevkFVpq8+LmgZYeFYrHA3PfEIJX5WaQbKEjUujXSCIBoASymquAlWoVL4MRLe30nqMefYa30wGvkqCercKFFf0s+jPDdcz0dhMgNkqbi2pyOPBhdeqjzLRzKL9JJRobQjIC8PClNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEdGy8EGffjLOVahWgd5/Q4+67B31sO+LdNTQ+9iJ4E=;
 b=jOAv6Sa/y6ZcR6GtwSFoK7BDPpveDL4sMoTLRa2nt9Oipm+MgNG5uXn1785zE3PBjo/ud2oLkUGlEnAalvJe590jw3flt61qnFvl7aGVLpeWzFUZMZP4HQJ9UyvlCjzRl/f1A5GIlhc3FQwO+eaaqCtwGhWukpMbgckrr6Gyto82Yb5lwVlNJd89DKOQPEHRmY02GSNRIyHBjtCU1J/US+WJXCW+kpof3DufvNi0Y1gW8TMfg2HFDUv0uclXLd5iRPrSLPkfyM7xasX2KkdSNduxiMvKNd/PKk0g2uHwgZ+bqwQAuIIG3/lqK1i7xYBHjm5z/C0y1S0TNJli8JnzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEdGy8EGffjLOVahWgd5/Q4+67B31sO+LdNTQ+9iJ4E=;
 b=bzs6M8ZmSTXtpaf2Dbn2lIBvo4bUQnkhXy5C1y/l8bnyhhenWd/VSA957oQSDpK9Yl+Q5m482dhTwEPcFu3UeBu8fet20vgwo8DwnJuaUssBzRsR91DLaz0rrFWJLmVmMfGqYbpu1LfCp5h7fi7cv2peur5p40cEeybTXBtq5yJtjICkV3sV9bg6KWM/a0HjPbbfZvW+iNkiDPKgYtIR6RPXd3wfbSgdGIP0PwLYPuBjfZxjmhAOQNMgAEh+sFJunfBnRaJss2LO69jrdUx2ibHtyPBTXgdFfLb5MJwFbthEholgvxH5TEzOafHBJUpyxn+gxdqMij+W6AsNKEPDfw==
Received: from SA0PR11CA0079.namprd11.prod.outlook.com (2603:10b6:806:d2::24)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 05:34:27 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::79) by SA0PR11CA0079.outlook.office365.com
 (2603:10b6:806:d2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 05:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:34:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 22:34:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 15 Oct 2023 22:34:25 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 22:34:21 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <petlozup@nvidia.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v5 1/8] mm/util: Introduce kmemdup_array()
Date:   Mon, 16 Oct 2023 11:04:04 +0530
Message-ID: <20231016053411.3380-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016053411.3380-1-kkartik@nvidia.com>
References: <20231016053411.3380-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 532511ea-9c7d-4680-11ab-08dbce099082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIqjJSYk9cle5q0KrE6X1zbwBG4mHKYoAsBFKjjGY9LvyjaNaHf7jYGmx2rPwenjZilMZYZwqy3hPmJYZ+E1psL6VD0h6l9gc3NZ2nrkktG8Ma9ZDAGeZDamkcPfDPMr/Ggpf6+hSARsTWARpXoVbeUS4ZYnFndqKC+dDYVU1iy8T3WZmIJIe/KGHaeq+xWybOTCwuduHUBDbU7Hwd4wAQXQNMAi1Jh3ZN6ESlb5z/l+BAOF1a8v8xFLURYSLaEEqhYP4iYJd2L23QqxJCyyia8n//0NCulUU1jdARDHlSP8PHecWcEekasLdDCIAc5OCxwQX3X4oKX2liLnxrqkJJGjGO1vkFdlLbSk8PbAJ8U2xXj63KL0ZAhMc0qlkIZnBPQ6ScSxbzie8asew6eSgxXS2wIIKCP0jtQnG7ypfVzlRRkWkR4rpw/yeNpMIjsPW9uMavtu+3xyDZJTTIoM/SYfAFbzds6gIJphH+3ilTxJiuHZe9weKnv9nr1dmC/AwhP/1HWsEPJ9H9RWX9PNyrgN8qfwxffmWUm/Yvh0PpJ3iQzT9PL5l7J2wV2P6rkZwyrYgV6zjexNNsZRmsEy/muknAWG0SFRRecNhT+9M3CWF0eJ6uLzIAUEITlXNMpzCGl3AE8LMuM7UKTgE6N8hFRx3YoKtIJCltFS/XnJ6/yWM3v0xBuQSILXqSseYzcRvrSg0GJp1VzubKvX0vmrByfn6e/VzuYebmzM/IQGISwo5A3w/lHGAeNwzykHl5Kw0Jw1suRn0AB3Hl867d2YTA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39850400004)(346002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(36840700001)(46966006)(478600001)(426003)(70206006)(70586007)(316002)(110136005)(1076003)(2616005)(336012)(26005)(6666004)(8676002)(8936002)(5660300002)(41300700001)(7416002)(2906002)(86362001)(36756003)(7636003)(921005)(356005)(82740400003)(36860700001)(47076005)(40480700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:34:27.6121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532511ea-9c7d-4680-11ab-08dbce099082
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce kmemdup_array() API to duplicate `n` number of elements
from a given array. This internally uses kmemdup to allocate and duplicate
the `src` array.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
v4 -> v5:
	* Simplify the implementation by just returning kmemdup(size_mul).
---
 include/linux/string.h |  1 +
 mm/util.c              | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 3c920b6d609b..fcfa1062c79b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -180,6 +180,7 @@ extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
+extern void *kmemdup_array(const void *src, size_t element_size, size_t count, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
diff --git a/mm/util.c b/mm/util.c
index 6eddd891198e..8801446140d6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -135,6 +135,23 @@ void *kmemdup(const void *src, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup);
 
+/**
+ * kmemdup_array - duplicate a given array.
+ *
+ * @src: array to duplicate.
+ * @element_size: size of each element of array.
+ * @count: number of elements to duplicate from array.
+ * @gfp: GFP mask to use.
+ *
+ * Return: duplicated array of @src or %NULL in case of error,
+ * result is physically contiguous. Use kfree() to free.
+ */
+void *kmemdup_array(const void *src, size_t element_size, size_t count, gfp_t gfp)
+{
+	return kmemdup(src, size_mul(element_size, count), gfp);
+}
+EXPORT_SYMBOL(kmemdup_array);
+
 /**
  * kvmemdup - duplicate region of memory
  *
-- 
2.34.1

