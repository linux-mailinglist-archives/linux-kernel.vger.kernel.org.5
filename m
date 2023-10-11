Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268E57C516E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbjJKLRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbjJKLRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:17:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D41F10E;
        Wed, 11 Oct 2023 04:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knrlJPkMCXmS3/S58/86J2FnPDcW4F98MLnMnADXG++gXcx0trb4krtlKElLqkBbQ0LfdI5lkF0KYMZQ6kaa4UIh5C5JEBUaVy0zbESPSv/xaGUXSpwqXE2cyixx5LAextmMGmY+qK3L2PF0t7BrPaKzkM9Pl+cJ4Ft0na1zH8ShVxBe4+AztN9Fq+ckumnlL86hv5/UqlKmi0qRaeAifxS/812zzXBS7S5m6CSlz+GwE9c4I86Hp6QF0GHa9OJUOOm+pv1tj6d2B4jDB9UdZad0yOEHrjWgPhhBuqVwrEevQdamElY7zACDw/6G4ITkxWpsS/YgYAIryRGBtmvhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsiujWidagjOqhBsIWaguiqwB5mEQ8hqRjmjmWpKUgc=;
 b=It1gYCVAyYpyjoY5v5knXMP7GAJKCED1TRcZ4nsDdCrKJVaZ+Qhs6wBaCSRBaDttA40rKyMEMfWLvYEX96rwOz5amnPVgomsPW1EQocvA+0etge4nRk2RByWE4WxaDfxpEzNpkclrHAmrioIKBxCQM+rvg1Cf1hjGJem5bQS8Pnz+zLsZNNZH+tI4tNuHMHlAG3hfTXuhm5HJr8BI3F1CvTeDAKuz6B+tqbpstdeKYBSOPSSa5azq7iVxSxoDkhrneT9McJ4jK7T/0IC2+v//eqQB2/VDkQ4GgYsVis1aCPzBueB+Lss8P0ceANGiB0/mlpVsPFlI6oNS0oY2tDO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsiujWidagjOqhBsIWaguiqwB5mEQ8hqRjmjmWpKUgc=;
 b=WrXbry7IboRukKA75bPwu6U9j1Z25t8OWC4PNJuzg9oorxmqsiCgRxr4bhJRhSMFbHsuMpu9RR7h66iwtChLvDK2DUK1Zm4i3kGa39a6Xxn5jkjFWnoIfOMiM1EtMsbIVBC5wNIVNCry04nkupMmuQ/CLnobDCGLrCN2ReCgi/qP/qNhFKupns1C6qUhquifJM+HsBbkc1x6Bv/eEZ1hJ5K40j56ndShkSYIr63g42D+oX9pJXEUc2UZUMYQanWvMg4BDabcPH2gBTWroCksCGHzW2HE05TLFWsD6XO0YhclHIxWj9ewKDuF31+F8xGkxEoXhFTmrwQJhes62W9Wdw==
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.41; Wed, 11 Oct 2023 11:17:05 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::d5) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Wed, 11 Oct 2023 11:17:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:17:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:16:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:16:51 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:16:45 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <petlozup@nvidia.com>, <pshete@nvidia.com>, <kkartik@nvidia.com>,
        <ulf.hansson@linaro.org>, <frank.li@vivo.com>, <robh@kernel.org>,
        <stefank@nvidia.com>, <pdeschrijver@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v4 1/8] mm/util: Introduce kmemdup_array() to duplicate an array
Date:   Wed, 11 Oct 2023 15:04:05 +0530
Message-ID: <20231011093412.7994-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011093412.7994-1-kkartik@nvidia.com>
References: <20231011093412.7994-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4edbb4-4a7b-49f0-af2f-08dbca4b99f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vvb/FlIwKidUBc0jPOY6Uw694zQgRhDyEu+bYGvNsOL4pT0oN588ZOXK5iI6a7FXIF9SWl5nyDGWJSWwxM53QtUylQmb6y+W4mtYBTiR20bn7Y1+ZV3PUcTnYNT4Y1y3R4eXEMqCKRPqIZhxpilonDQ0M489Yl909o4VyXNuUl6jud6L0r9sLhDmZbA6RrhWU9qRA5U0NOn9gkY66qTRAibovoxXXf2BfdQ0mv+A2hQGS1TKkyEjLYPoCRB3IJm7t68Eb4NKvrwhPoVC5b5SvcMFZyl5vehft1SWj5usE5jmDlrhLNyJUQe9e6S8EWelwD02+Kf9YvC9jrTqMLYlvbhA5LANHq0cdf0TZWWOUs+tGRERSyRHUEghr++685+P8eCzEvslD0A3LeWTO2+ctv7TzVF6/t1S1WZPu/mwGUWnaigG/ZuFind7n+rrYt4ENKuY0Wo4FnCL5CnD6Y7TBMFvznyzkjhr5Q9pK0tX6HrDiCF8WMJYPBRh3/phpAaxJE5tjXROqNeE/cXXVFQgIxunOnAECQvIc4K/AsxuXtAVRQDpCNzq08Z/bs9Xe9TG00pjYRDEu9N663AwD7bwGvSDCZN+vutF/3oW6r0e1Ccm1IjDFHgeB0rnPKN0QYiFdTov43T0/dgBFWQ2JflFwzrrGT1zXjKXBzFrwVesrhnnJnh3YOd44GnoDJuoWleBLl8F6mPVUKu3SoAuCP/p5/rqe6VnMxU1nFc3runKsWd9B2OiQowGxbI5hT4q/cp92DkvmPxB8F7cNj4D+HJNOP9EJyfBcKJxy5JffgDuvl79FP/3B2vfdNL5ViM4YS6f
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(83380400001)(36860700001)(47076005)(26005)(6666004)(478600001)(41300700001)(70586007)(70206006)(110136005)(1076003)(426003)(2616005)(316002)(336012)(5660300002)(8936002)(921005)(356005)(8676002)(40460700003)(7636003)(2906002)(7416002)(82740400003)(40480700001)(36756003)(86362001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:17:05.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4edbb4-4a7b-49f0-af2f-08dbca4b99f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function kmemdup_array(), that will copy `n` number of
elements from a given array `src` to `dst`.

On success, kmemdup_array() returns 0 and copy the elements from `src`
to newly allocated array `dst`, it also stores number of elements
copied from `src` array to `dst_count` parameter. On failure, this
returns a negative integer value containing the error value.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 include/linux/string.h |  2 ++
 mm/util.c              | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..6245a7918b05 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -179,6 +179,8 @@ extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern void *kvmemdup(const void *src, size_t len, gfp_t gfp) __realloc_size(2);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
+extern int kmemdup_array(void **dst, size_t *dst_count, const void *src, size_t element_size,
+			 size_t count, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
diff --git a/mm/util.c b/mm/util.c
index 6eddd891198e..a7c87a119be1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -135,6 +135,40 @@ void *kmemdup(const void *src, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup);
 
+/**
+ * kmemdup_array - duplicate a given array.
+ *
+ * @dst: reference to the pointer to store address of duplicated array.
+ * @dst_count: number of elements in the duplicated array.
+ * @src: array to duplicate.
+ * @element_size: size of each element of array.
+ * @count: number of elements to duplicate from array.
+ * @gfp: GFP mask to use.
+ *
+ * Return: Returns 0 on success, on failure this returns a negative error value.
+ */
+int kmemdup_array(void **dst, size_t *dst_count, const void *src, size_t element_size, size_t count,
+		  gfp_t gfp)
+{
+	size_t size;
+
+	*dst_count = 0;
+
+	if (!src || !element_size || !count)
+		return -EINVAL;
+
+	size = size_mul(element_size, count);
+
+	*dst = kmemdup(src, size, gfp);
+	if (*dst)
+		return -ENOMEM;
+
+	*dst_count = size / element_size;
+
+	return 0;
+}
+EXPORT_SYMBOL(kmemdup_array);
+
 /**
  * kvmemdup - duplicate region of memory
  *
-- 
2.34.1

