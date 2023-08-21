Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0664778281D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjHULlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjHULlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:41:06 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7786DC3;
        Mon, 21 Aug 2023 04:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBhFxsDCfODqePNgYFDuB3SJgVFZV/wmrMX6pfFQHXkRPk25IqderYg0EPaucYzpdHF0OeALGwr7icklOQuW72NN6E0SI3CXWLlyW0wldqRvzpP3G4SNwoH+lIZmoKswBqduC7KvqohBIbmasapNpELJcXeQG2iRS4XEqTBHbVTXw5fAlxsMo+Ppvtcqq+Cp/a9Ch2VVJgnex6tAKT2FrlGFRpAPvixsaMtI2binM+auP7DxlDztl64MZnooEr3hcAfY2eYV6/SCsjsiAqzW6IB6D/JL9RpsxRu9Kk8cvCEAkJGIy6SebWcMH8Cxl8xTygwCPWMWyZUC+COROsh1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNpcU2Z7c3AmgkTZzwM7oMflwys0oeSy0jsVGirIDbw=;
 b=Xtmuy3bJriG+ypebeh7qT2q7fh4PojA08lygypMcII9jitO1thiUqpGfu14vAwCcE7bmmlS8APgEeg673sRdLYMYcS+bIsk5IT0H6kblLy7fVbxDqL8GByJkGURHKkHzNtb+5NR1Vt/+zij7bFidILphWrg/RI4AISvj+MKSGmhK2FKg2H4UJT5uRWusy61Erhcz4kDtSQDFGxxEPk5114ADeNOxy5nz6HiNlY3OAYSjiFHzfgLdonBD5Ehsmck60NIBsrMj6U2NmuEUXtHe0rxYbXtKby3kic0V/fQCK+Eaf9nCZoNVwsbejq2sEzv3yZCMIfqEqFshwB9bWHQcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNpcU2Z7c3AmgkTZzwM7oMflwys0oeSy0jsVGirIDbw=;
 b=fMHw/7+LZVUR4Y7mneMUOtBPBUUeHAeHzSBmgHbzvti03XMI2ME45qASKtIdSpkrr0+c2LT9mwBcrN8NlxJ7ktpNSO5IIDBOf0ki/yYB77jzsh0wBXmOQ4dhV64zs8FE8nOompLxOdfA0D7jZMHIfzi2vRv7fSRNhxjWzVB/pGTBpTTGz6MZcmqfK4jpzarI3eMx+Esj52TvsiiFFyfN7M3eNJwbaPQ64cGrXaOu+OzsROlQButrcCg2JiaH4Mip1w+HQ4bCGDLUUtNZwJNWQkG1ZhPoBX6k5hzA75vIOWZJxBNVYwjvbyUbWUYivvrPlfgebcjONMcUHfKCMURhmw==
Received: from CYZPR14CA0033.namprd14.prod.outlook.com (2603:10b6:930:a0::20)
 by CH0PR12MB5313.namprd12.prod.outlook.com (2603:10b6:610:d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:41:02 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::44) by CYZPR14CA0033.outlook.office365.com
 (2603:10b6:930:a0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 11:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 11:41:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 04:40:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 21 Aug
 2023 04:40:46 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 21 Aug 2023 04:40:41 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <arnd@arndb.de>, <digetx@gmail.com>, <frank.li@vivo.com>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <pdeschrijver@nvidia.com>, <petlozup@nvidia.com>,
        <pshete@nvidia.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <sumitg@nvidia.com>, <thierry.reding@gmail.com>, <windhl@126.com>
Subject: Re: [PATCH 6/6] soc/tegra: fuse: Add support for Tegra241
Date:   Mon, 21 Aug 2023 17:10:33 +0530
Message-ID: <20230821114033.4446-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZN+Jzbsci3RLtEnW@smile.fi.intel.com>
References: <ZN+Jzbsci3RLtEnW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH0PR12MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 092004ef-7593-4156-46b5-08dba23b7ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4J3GWnlrlLfYdBhFcpGcsBBzm0lSqEWj/rV9sBzYvE6pqGZ4J72xgjiO+v/kiQVUCdlSHXQrNimKQT6ZMmtgbS4MN4dHnB8nlG6+iGVfhI3kMPwbcHErk7fa3979h+v5V9ZVbrDvrqEAUqMRV8bkurVRQaWrVojrmhXcQbkkhv++LZGhUP7kLTTHvsKjhfMxakhCAKec3M4spc6P5MPpmkhbifcz75p5E3gNaAEwaV7AyKmksYYpc8wkgldqVRMG9QYBGtkBZCWBgcX0RSgfLCtqwq8CGKYqmSOijaXzvRuVcKuCx8FT4D9lSakvXwJw9nsh/tXsoIDgpnBg7lcaeQT7YblZgXe6m2aNjbBRjdodKsKkNByHzPwUKX64pIVEfWI1Gj1RNMrPwh41nG2GPfgbc/dB7D9JflaNFt7ayBUk7BBPGNleyhgB7L46vDzIEOE6OTMvLKizAAlEwxUILDQ3OWUJN2C3cAhVY2R7WTqVYfrRVTs/621Gf7MtkxxOk0qDi/b5xwU4GaaQOLgf1KCvouSAfurZDJyAYb5b2cLEYoCtbCbT15e74fT2t6s+2d5aBoeMYBB+S1AhvexpHUlT5Aw6rWFUarMd/g67ZUQQDrUIGM7+49jkUwEmx5gKaF6JCBvcEW/NLY+BGtzSIvf9M2sbqIwvaLYWccNxzzOeNJKASkuyR7N55SVsWQab4F7vY2n0JRv5GhjKrFGJUELER0Fh0vfHjn69kl+HPb8fbPBiRIvR1xKYSk1Xusu
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(40480700001)(83380400001)(5660300002)(336012)(426003)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(6916009)(70586007)(478600001)(82740400003)(356005)(6666004)(36756003)(41300700001)(40460700003)(7636003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:41:01.6130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 092004ef-7593-4156-46b5-08dba23b7ed2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5313
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

On Fri, 2023-08-18 at 18:10 +0300, Andy Shevchenko wrote:
>On Fri, Aug 18, 2023 at 03:00:28PM +0530, Kartik wrote:
>> Add support for Tegra241 which use ACPI boot.
>
>...
>
>>  	case TEGRA234:
>>  		fuse->soc = &tegra234_fuse_soc;
>>  		break;
>> +#endif
>> +#if defined(CONFIG_ARCH_TEGRA_241_SOC)
>> +	case TEGRA241:
>> +		fuse->soc = &tegra241_fuse_soc;
>> +		break;
>>  #endif
>
>Have you tried --patience when formatting patches?
>Does it help them to look better?
>

No, I did not use --patience flag while formatting the patches.
Shall I post the next patch set using it?

>...
>
>> +const struct tegra_fuse_soc tegra241_fuse_soc = {
>> +	.init = tegra30_fuse_init,
>> +	.info = &tegra241_fuse_info,
>
>> +	.lookups = NULL,
>> +	.num_lookups = 0,
>> +	.cells = NULL,
>> +	.num_cells = 0,
>
>Isn't it the default?
>
>> +	.keepouts = tegra241_fuse_keepouts,
>> +	.num_keepouts = ARRAY_SIZE(tegra241_fuse_keepouts),
>> +	.soc_attr_group = &tegra194_soc_attr_group,
>
>> +	.clk_suspend_on = false,
>
>Ditto.
>

Yes, I will trim this list in the next patch.

>> +};

Regards,
Kartik
