Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF3C7827FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjHULdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjHULc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:32:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79253DC;
        Mon, 21 Aug 2023 04:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abMAsgHvf8UTXvOqybpN5sEjZl8jUPrpB3hAiP2hUAOXQzygRVoTEtgjaIxSXApQiYbKUSYw6TlF87kPD3vumUXGqJbvmik/rZ1XuECeSBOU5DVC4Z/wIoCo8URA5PygdBSkkweuGM60SxELfBi3zfcynPoZkGmRvJNRpvikdvqqr0NcULRsm6wJV+OeLoP6/6YXZqcEfIBK2RKsY5YlXQxlxqVkybbAgUBqfZJCWNFgY8Z0CYHbRj8w5W+Y11PEwI+xFiHn9CAEhfy+5uSxancSg9uDdIaVFahYiLMqR3iJS7EZsb492F4uAuELZB2+7yn/FOGle6QgYpmkBHHZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj2k9QKhzk8ibs4jhXtOpYb4JC/CQI6Xgkeu2pfMvGQ=;
 b=JsO4pzZx2KIC1q75OImBVQPDsVDOpND6mXPkr68edwnKq70moQNqbZu5vLimm02zauOa1QqGJu/QFyTKDLvXZTKMe9AfI1HVFMoZgoZs2RvwD+WNo5aZi7yWPumgOZPgxYczb8h1i/m4MO3vFtiN1kU2ZUK+l70CxTOFABOoaVXzjfFvL75vlZSjGL9rzNwx6sA5Pc/wwjlKdFJtWa/DFkOAI8oRtpaoFf6qNLoTUkGNsWN5B/DTSRND+8R0eSIjT1XNHDv00Kss1gEe9uCzPYNgD9c2B0Jueg3IUUUZ5Zq/uafNiN8VGH+sI5PjK+o0NldkalPRSuNanp8Rw/1qWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj2k9QKhzk8ibs4jhXtOpYb4JC/CQI6Xgkeu2pfMvGQ=;
 b=Vx0G+79qFvkkZQ3RBpme1+DxyRk/z2tIIARA3ssWdAR8g2w1H6AwQvdTEUGO7YNljwAMWuKQcrzdSbrVQ6IJVag48iBwGBR76x6zF/y9IrLmJ4AvpzPl2jmrEIi1j0WchSUQ0+SLIIM6ioUK9392Yy6JmbUYA06lb54CTbWDtJWxeT7E+omRXQbT5TFYiRd5mx+/ACaPg40CGQXGZYWiIcOW6fZdhTHhRObHPfY37I7rLeSctg/tsXaNkn3m1PueQtk8vIPqRyMWBlEYgUvtpQuTS/MLZOEQZKTsv+1PGJur3nuyXZCmzbql3GWEsxrZEzEeu69aW+pFE0d2QeJIeA==
Received: from MW4PR03CA0300.namprd03.prod.outlook.com (2603:10b6:303:b5::35)
 by BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:32:54 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::1b) by MW4PR03CA0300.outlook.office365.com
 (2603:10b6:303:b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 11:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 11:32:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 04:32:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 21 Aug 2023 04:32:33 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 21 Aug 2023 04:32:29 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <arnd@arndb.de>, <digetx@gmail.com>, <frank.li@vivo.com>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <pdeschrijver@nvidia.com>, <petlozup@nvidia.com>,
        <pshete@nvidia.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <sumitg@nvidia.com>, <thierry.reding@gmail.com>, <windhl@126.com>
Subject: Re: [PATCH 1/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Date:   Mon, 21 Aug 2023 17:02:20 +0530
Message-ID: <20230821113220.4255-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZN9wdTLK1rwnVK/e@smile.fi.intel.com>
References: <ZN9wdTLK1rwnVK/e@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|BY5PR12MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd33289-f95a-409b-760c-08dba23a5c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVd23gkdr93hDSsRjXAyxFrtwdILQ1BP8fXlEnF1n89gTfQW+OiCyHt3qwXNhR+KlubEWV979gBKL3Us2flJR71K457FMRg46f3LRrjcIr+eAU5W/HNNVi7u0nSsq1n3PLtY5a2TwhWziJDmpuQvh4kC5+rDRz5t+TZgk5kw8p4U43QBJWribLq2dVTJ/63xo9jbWkT5rT5eMEYgxEnFjjabU1u/Gs2i9l4v+oj6mHxUX90OgVJeZLepd0Wy8d/IjEdhGB8Erh5eYq9iGNbkoP4xtSIhRzp/7qs1AhlLumnvYU6qtartRC+RMEKmqPHGDvdv8/3aHs2GDOaR55abADaR3MjNLHv+QA40aqR6pdzB5ymalb7hIYM4RORuhwI0t2vvtJKDFTSfpOgJdOFmq+7LT0rBMJ+6vOXIm+qoloeAWs0v3S55QaNUMvJoAfQyLV6wUBRG+JIbqFWH71WdeHJv0ckOoOcl7cmzy8KS/AViU/zadk9JTHCuhGDuocHI8z36d9miykKz+KEEpsuHWkGuZucqTbIQtKRe8PQ9W5emeMcxtskI540BVp7mgoWV/LVhitQkLsbLjFT2k11E0wgZNJtDqb7wjgor6Mz6atarnPP8KmaBa6KWvUrk1LGsOZqsWu/Q2of+ojuBoLhMtWUjlJSjtfPdCnJPVaPZEwR//lGoyLP9l0+Pmo2urcdjmtTX8Z1G4/R+qF1KdYJBbg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(376002)(346002)(136003)(396003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(2906002)(40480700001)(83380400001)(5660300002)(336012)(426003)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(6916009)(70586007)(478600001)(82740400003)(356005)(6666004)(36756003)(41300700001)(7636003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:32:54.1716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd33289-f95a-409b-760c-08dba23a5c41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the patches Andy!

On Fri, 2023-08-18 at 16:21 +0300, Andy Shevchenko wrote:
>>  void tegra_init_revision(void);
>>  void tegra_init_apbmisc(void);
>> +void tegra_acpi_init_apbmisc(void);
>
>Why do you  need a separate function?

Function tegra_init_apbmisc() is called from tegra_init_fuse() which
is invoked at early init and it also has `__init` keyword. If we use
the same function for both ACPI/DT, then we will get init section
mismatches when the Tegra Fuse driver probes using ACPI.

We can use the same function by dropping the `init` keyword. But
the way we are getting the resources for device-tree and on ACPI is
slightly different. Hence, I kept a separate function for ACPI
and move the common bits to a function shared between
tegra_init_apbmisc() and tegra_acpi_init_apbmisc().

>
>
>> +static const struct acpi_device_id apbmisc_acpi_match[] = {
>> +	{ .id = "NVDA2010", 0 },
>
>We rarely use C99 initializers for ACPI ID table.
>Also 0 is not needed.
>

I will update this in the next patch.

...

>> +	if (!apbmisc_base)
>> +		pr_err("failed to map APBMISC registers\n");
>> +	else
>> +		chipid = readl_relaxed(apbmisc_base + 4);
>
>Why not positive conditional as you have two branches anyway?
>
>...
>
>> +	if (!strapping_base) {
>> +		pr_err("failed to map strapping options registers\n");
>> +	} else {
>> +		strapping = readl_relaxed(strapping_base);
>> +		iounmap(strapping_base);
>> +	}
>
>Ditto.
>
>...
>

Sure, I will update these in the next patch.

...

>> -	apbmisc_base = ioremap(apbmisc.start, resource_size(&apbmisc));
>> -	if (!apbmisc_base) {
>> -		pr_err("failed to map APBMISC registers\n");
>> -	} else {
>> -		chipid = readl_relaxed(apbmisc_base + 4);
>> -	}
>> -
>> -	strapping_base = ioremap(straps.start, resource_size(&straps));
>> -	if (!strapping_base) {
>> -		pr_err("failed to map strapping options registers\n");
>> -	} else {
>> -		strapping = readl_relaxed(strapping_base);
>> -		iounmap(strapping_base);
>> -	}
>> -
>> +	tegra_init_apbmisc_base(&apbmisc, &straps);
>
>This split can be done in a separate precursor patch.

ACK.

...

>> +void tegra_acpi_init_apbmisc(void)
>> +{
>> +	struct acpi_device *adev = NULL;
>> +	struct resource *apbmisc, *straps;
>> +	struct list_head resource_list;
>> +	struct resource_entry *rentry;
>> +	int rcount;
>> +
>> +	adev = acpi_dev_get_first_match_dev(apbmisc_acpi_match[0].id, NULL, -1);
>> +	if (!adev)
>> +		return;
>> +
>> +	INIT_LIST_HEAD(&resource_list);
>> +
>> +	rcount = acpi_dev_get_memory_resources(adev, &resource_list);
>> +	if (rcount != 2) {
>> +		pr_err("failed to get APBMISC memory resources");
>
>(1)
>
>> +		return;
>> +	}
>
>> +	rentry = list_first_entry(&resource_list, struct resource_entry, node);
>> +	apbmisc = rentry->res;
>> +	rentry = list_next_entry(rentry, node);
>> +	straps = rentry->res;
>
>We don't do like this, we walk through them and depending on the type and index
>do something. The above if error prone and not scalable code.

I will fix this logic in next patch.

>
>> +	tegra_init_apbmisc_base(apbmisc, straps);
>
>> +	acpi_dev_free_resource_list(&resource_list);
>
>Not okay in (1).
>
>> +	acpi_dev_put(adev);
>
>Not okay in (1).

Yes, these won't be called when rcount is `1`. I will update this
in the next patch set.

> +}

Regards,
Kartik
