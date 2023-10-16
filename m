Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7092D7CA504
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjJPKPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJPKPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:15:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FBCB4;
        Mon, 16 Oct 2023 03:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brp1goxherUTvXjigjYHIXVe/3ts2rmHaoX/gUveGopy9xFxv7nobfZLH4DPhdKRhxWNdv6R+gybXdCGQ0AXxCgJ4CAuqxmWGnjaa9dhEmVYAHTrA+VCStl6yshM59uo8CEPfExs4riT3OimhHGamp6fnRvj+7YOgTtzGR8Qmp0dBnTRTRlko1y3jtuR8MbEbD23qwJbrdJNUbXjgeI1K5Mb6ve8SjhurVq2s1NnAzYf3nu/3MNJIDvoY6intWcXZOLLcR8ayFyiX4tnJ+lRIgHQjyxPxS8n0xyQDomJatjnt2NG1ApPmuFSVWgXerYFOA+POQ003XdNHobj4rYEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEdGy8EGffjLOVahWgd5/Q4+67B31sO+LdNTQ+9iJ4E=;
 b=m/CuS/nWXj5jZxTDQDSW+ZMO/7Ytk8NFIjzhDoBd4mEoWHaQ+IrBaXLBzrYO5v84OdCf9qpiKyx2aYFKITnOm9sJdWcjkhITq1g1JNE4G5gOdrB7CNRgSxuIDjyKAvBTfh3sh4Aw86lG6zanGRDwZQbdIm/gH0lCzuqXO46PCrA7jvpbET5Jy6aLG7tvElnpbH2EvHLxb174o4uXZN6bOTPTCNu5cNnqH5afqG0rZKnmmW3Qv/8Mo+OqFo1UqLU+tURJ8pl8sQad4RTGZjZbUG3ensx1jx+RUg9JSPI2xZ+SkD1fzZ9giEZKZsLMAF2pcY3VpLGj4P5thgEfitJQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEdGy8EGffjLOVahWgd5/Q4+67B31sO+LdNTQ+9iJ4E=;
 b=gJ3gKZ9yYBTXIcovyvumvZiE+7OZNwlSS8Ooa1LmQ/yiLDNeeH5Fr4JED2/Uvk2u1PFRTALe6KCN4bLyVDz57G6h60dJghad5Hj9yXPKVCa3h5p/nx1KhUnJfwTWGYRP67qdonwW0j+BIO/ix8eTRVZCNvE2JaVgs4RDs1ZHpt3hXsiGYSDDueHftSYvkax8ch1tQvOW/08Jc7HuyfuasgcbSZXc3wtbRrUdfZihzcxq07yAphKxBbZ6EFAe0LN/USD+Uzkdd/oAgvRGEi6zBIhjnbHTXgAKIc9d62gVk/rLtwOR7pVvnsaRRruR/xDbf405lLJKn96ZOvkmTXHCoA==
Received: from PH8PR20CA0004.namprd20.prod.outlook.com (2603:10b6:510:23c::12)
 by MW4PR12MB8610.namprd12.prod.outlook.com (2603:10b6:303:1ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 10:15:11 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::26) by PH8PR20CA0004.outlook.office365.com
 (2603:10b6:510:23c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47 via Frontend
 Transport; Mon, 16 Oct 2023 10:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:15:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:14:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 03:14:53 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 03:14:48 -0700
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
Subject: [PATCH v6 1/8] mm/util: Introduce kmemdup_array()
Date:   Mon, 16 Oct 2023 15:44:29 +0530
Message-ID: <20231016101436.7146-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016101436.7146-1-kkartik@nvidia.com>
References: <20231016101436.7146-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MW4PR12MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: d45218c2-e495-45fb-af4e-08dbce30c7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpagbLjOp2taghtHhDTj0N33hrJXhtUQHXamHhyNq4e82xMSq1rYNx/ABbVpmOdN9iyAhxYNAd0W/8cSP8WTIYpKXG2+o1+NdMoGfIzbQkwjEA5EoxR2d9owOb0btVpLwSkh8Fu/WwrRLIo8KbGFHKOl6EhQtrKC/S81j78EDXhM/anNghP5DT/eUxuOf0r+239KxNEGyulwWn/fNbGZvl9kjA7SDmpaIfJm3FSqBrFH2F35I1Z4spwb7k+MgBiVriCw8g4rg0BNpCbG7Ejyrb/JPQiNeS0M55gq4pHH6zkvazCEzsaibQq96BTBzzJ5vss447BnJq2pC1Q2QGIG199fcDrLOCJVIaTp/xuH2ThLaaTvzzlwpM0xl3iGGV+JH1tB97pyl65iyAWk4+16P8wHK26CHQS/d0jpaKK9LNM+jF9nkYh/tVHugcfblpDnv6LxV/mEOTin8ts3pk59NuwSHRVVSNy+xnuYlDW4768nxK0Ypiljb1ClS/5hPuSiJ1CkqcEBUIdm+ZyfjI3yGiSWzNvd22QmXSVbtVkhthYbBh7l+mAKg+iRLb3MSRfzpSiHW3vi/yoA5h0UnrB8wmbqvWvsyJ/EHnI+Un5FePrRyUd+8AaNt/DXd5au0lqPciI7Zw/AZBKYjkJSZea/Yd5bL8xT78fDqHKgxYfX8EFnABi4Plgp4eqd+FhPzW6IqUXHvzbSiWhQC6dxu0err7ETAsn1eYO882+v1j9J3uwMtZdR/fsqZAOaaja6dtLJedIhyFGi+j9mqoj4dPGuYN3Y8y0Dv+LoEs6wOORhSso4mPoutOUeCZhoBDjRTerG
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(26005)(40460700003)(82740400003)(2616005)(426003)(336012)(40480700001)(8936002)(7416002)(86362001)(2906002)(5660300002)(8676002)(6666004)(316002)(70586007)(70206006)(110136005)(36756003)(41300700001)(1076003)(921005)(356005)(7636003)(478600001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:15:10.9580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45218c2-e495-45fb-af4e-08dbce30c7ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8610
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

