Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96927CB9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjJQFYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjJQFYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:24:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AA41A3;
        Mon, 16 Oct 2023 22:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d92GYu6v4EkoGmSE/EFtES/4pQEGUBPzmKSaUaSeY9BASUP2bUnatdqvhu+hpFzzz0qdc7XLO3lGLt02H4BAUacwBqc7KQnZh/B8D3/UeoKb4rnGS88HRkZdaQhApnzcvnWcsC0UreTK3o59mCqOumL2R4peQEM/as6C1DchCDAF8JIVpTCxwtPiaigaoJADx2rxnsv+Ce2LHiVxVm4VaH0LOvcmD0+Haj8vS8aiyy50wXc3Kw4BnN6cmZBC05XmYjb02JB60SPEtsW97C44tKmNdDamXPCYHXxvbJPt7TYCz0kAjbuwYTM6OkXIqdGC0HFqvuSuQyEhlzdFI6+KOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHIwuM6866zAfbyyHT2ZXww2CJga4UGqaGaLCAOWOUA=;
 b=fyeoDB9kulslDvxy8a+/IDhCZ5q3chSQgZ9dKWpCeKzLcFPQH51fD3Ul0WGa+7ZQWbutPJ8dK4V9TARTJbqcncvHJy2s7bT23r50o4ig453LfHkvy4WoC910v+ufWE1wOvKMhi2tOz73qm5zQLCBeyB10YvsG03WG7ZsfArr7+wG2vJxtgRYZQgnofVIVZT5C4ZYcd3oqySa6iIr16BWZpD1VGWjDwLgA51+rSAa+PZYTQx7td8vcEhJy1riMYDmXyn4cuPdThFYCx/2/+VJ8hPPcai8zLJHfiQlbm6B42h5OhkH3DDdpSVHWOB4XfC3V8A0QfG+MILztGmkIejP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHIwuM6866zAfbyyHT2ZXww2CJga4UGqaGaLCAOWOUA=;
 b=rtBeEib67tSkN5WQidH6GPWK12hp9Qjily8/53QG1eoTbcKimMnr91h7I8iSPIDlpSYl5IXqgValM7STCwcg1jadR167Adi4ISAW0WJ7CjS0AoRuCd6exMFs31ttHVojqsc6rITQiz+nOXYJwAQ6IvENoQBZ//zbF0CLmiMzOSr/RGJ6i+QDGWeD6j0ZhAbz/ylwZO4yjuqpf3PW6iKfSiFsLIG+OX4L2/WyoODKTk0GYDjtMYsuiW6SzCjPTJ4I53iuFnAeF8laHLYASJg8l4TIzr+2/MyzXh4rKEPpLmb5VtUUgzcQB6mR8R1uGKtX4VwzpuD6NiZ+Vq6sH+mV2Q==
Received: from BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 05:23:54 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::52) by BLAPR03CA0084.outlook.office365.com
 (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 05:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 05:23:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 22:23:38 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 22:23:33 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <keescook@chromium.org>, <andy@kernel.org>,
        <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <kkartik@nvidia.com>, <pshete@nvidia.com>, <petlozup@nvidia.com>,
        <frank.li@vivo.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <pdeschrijver@nvidia.com>, <christophe.jaillet@wanadoo.fr>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v7 1/8] mm/util: Introduce kmemdup_array()
Date:   Tue, 17 Oct 2023 10:53:15 +0530
Message-ID: <20231017052322.2636-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017052322.2636-1-kkartik@nvidia.com>
References: <20231017052322.2636-1-kkartik@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bad22ad-4cdf-4ca8-8fe6-08dbced14126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oD/qj1kOy01T0A6gB0LsuvAcQjQtwlgPl3KEW1eMB35Ti72z7RbwhWUODvk/+XZzLRO242Hck1LEfAVTczLEeHoDZp7Iuzd7RZZjbyE0MBfQ6PZ0yk1VjuKyIzfuP0FMK/xehbFEc/Gr/QqXRhaRWiWGbKYF1WqIdbxLFGQqQqvVvMcgAydya8dy8cJASuqIAwgDSZDsmEgfNAE28nb4y8mfR0XHy7RSmv6qEvrUHdTPtu7OUuV4BxrjVWSTmNKr/h8HeYqRBC22ARB6gGm5R7O9BMtAsi4ZJ5nRlutb6lFxQknFh+G5/1ze1NcmecN1s8Z1nxW2MR9AyxRx2KFxknKkvrzuCfxEuVAJUQnCVFQ9vCN7hpmjLwQsImSlvWkjhA2pQ/e/GCNeuC6oe9cSrr14HVS3jf1jvZidwAhRByJMQUkm0kh559pifMf6XJhT76OeJsMOC6nNuYW1UjxbECYvI04UygJifvywcf+0LsnEDYP4iqK6SLYVb+gi7aRMy/+zUjWm5l0nLLCI45vj5vNXwyw+opf1m60+npqeWzSk4VzvOkqIiCRHavU1eaJaJYe59XpASSmVANU+YXqF5EUDImfGgYcXgG6fPgu2ms/Zi5f79fOROiT5HZG3X6V11wnolmFS5rUF4j/ND2vHX/PRGE42DQNspc/aWxeuf4DggiYeQ7CQtOLJLLm7Yc50Z0L+1iYfa9U0cpt/JvQfJK2aPFfUArXYy/8gYz8ZCxS2rdEUfAQzy3TdRFD5gxRq2odRwPy01qdPtrKrlKeArAboUXOhDENHBaRoxksXlfUkgVqLPa/CiKILeLgPd/db
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(478600001)(70206006)(110136005)(6666004)(70586007)(2616005)(47076005)(36860700001)(921005)(82740400003)(356005)(86362001)(316002)(26005)(1076003)(7636003)(336012)(426003)(41300700001)(8676002)(36756003)(5660300002)(7416002)(2906002)(8936002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 05:23:53.7715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bad22ad-4cdf-4ca8-8fe6-08dbced14126
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921
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
Acked-by: Kees Cook <keescook@chromium.org>
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

