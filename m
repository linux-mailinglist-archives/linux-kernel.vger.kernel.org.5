Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2B17C51C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjJKLWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJKLWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:22:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF41270A;
        Wed, 11 Oct 2023 04:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnG7qcI0iKvwTy4Jy0Mznx0Mq0S51ZwFIl/pEtcv521pf+TPDolCAcl3hTCboABlMkY+FH5qPSUa0RPctnYFsw3Iv+EwYkdiOuP79tCIgNvYC60stKV8qEMysNYiEnbp2LQ3h5hyOG8Bo4SHV3hMqWZY/DlZW6S2pezUaRXkUqLdRi455+b6hiQNFwizeNLwb7W67weg5WZmH4+RAwr9jEG701bSrZ+A7g3SzLVH4/cveMNI/6oTCmVUMv4W8wrr3RUnYszXkMtefnGJYOQF8lvm9FaPtFkpay+88/Z1kBpKu+jBHnSG5Az7Urin/mUskMOiHxgCWtwGFvQ9+k/4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjcdraMhkz2+4CEx1js16TuZz4tICHNVMASThEZ7Mlo=;
 b=eSGqYZiimP2ONQmc5i7ONUdE7DeEeVj2LjPDL4IV+qqcQo2bgRYP3hNj5Jct2sh6tjQ05Nin/KzUltjJGyWCvYcRdaGfQaLyHKhnaqD1BGPBcImD4qOBQ88iZAiZY0ppZeotpQikMmqXA7OF24aVmEduS25UG+1J8oEL3JmmSu+XzhOWfH2jdCdbEdS/Idy3XxoptC+qz+YP3Rrd8oV35KbL1Xd/wXxJ8giY7oDgfJjts4L3ZvSRu0tbqBxVEyGTfUtUIGSOi09W4E+Heqg3mskAodIwz2NtZON2OAfz8r/QRsh1uefp0OM/c2nsMK3MshseymKJ+7CqAXZrwAnOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjcdraMhkz2+4CEx1js16TuZz4tICHNVMASThEZ7Mlo=;
 b=UDHXv9DIbS/683/hwqQjUa7nRfQimGsCDnE733qSBFsKcmWJQMwz/bRthf4cwF/4ZSl2VRivm9N08T8tNlByjKNUh8y2kAuCKU2xL5LgL0D2PcvLBt9Y+ike7A8KT3IuFnGSvfJbXvH1yEuuhgT5Q9k7QKPPrAJ/e8zNyGIGu62zsi/9J6q99zXdKgQtj7hfadyDCZwRnlb77hEPQkznOY57/tx4TmSmavHpbGSSuFooOiKfL9CvGBTgCm09+1kLJ+XP7DxB+WBV6AaXQCHCdRQfJIFKllu+xOc0ykeMkdxJCnMQfFVM/pDL5I9N9QvjsnjzaaVcEnwsAYnv9AtiBg==
Received: from BLAPR03CA0175.namprd03.prod.outlook.com (2603:10b6:208:32f::14)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.42; Wed, 11 Oct 2023 11:20:56 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::1a) by BLAPR03CA0175.outlook.office365.com
 (2603:10b6:208:32f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Wed, 11 Oct 2023 11:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:20:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:20:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 11 Oct 2023 04:20:43 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:20:38 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <arnd@arndb.de>, <digetx@gmail.com>, <frank.li@vivo.com>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <pdeschrijver@nvidia.com>, <petlozup@nvidia.com>,
        <pshete@nvidia.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <sumitg@nvidia.com>, <thierry.reding@gmail.com>, <windhl@126.com>
Subject: Re: [PATCH v3 5/6] soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
Date:   Wed, 11 Oct 2023 15:08:32 +0530
Message-ID: <20231011093832.8095-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZP7wDm5w/b5RIlIq@smile.fi.intel.com>
References: <ZP7wDm5w/b5RIlIq@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 997de3bf-b9a7-4edf-a436-08dbca4c22cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtcTbvUyKKvB28oSU+ISquHBNTCU+RlhKzOGK3CP9ZhBmxLFI6M5j4bSo3up/r2RnJGQrRiO2J/73h9hMPob6I2d3tjJr9fI3/oAB3M3+GQBab1QxNrV8ZxoYW83y5B5gaPACbanLYkzAsZtlCzaTOur8TM+6VaY6YzdKJtmTsC6emich8/yZfYlp8yhjWqGHYqMTu59xmGG7QTUpIUc90/PaWnTp4hQKAY2qk6Fu+zGY/U+t5bYohLS6qXXpA3hQtw44rQivL193ErDXuU3yV4NlKaxw8kLBwyenp2fS3S0DMZtgAVF4YWwo7ZsBnRaZBEggGeN3LCSMbpx7DkrO7IO99+0nQp415CRtvF/i4703UanwqRwZX6j5p2zsv7H2gYvkDfKXp3DAqlZDe3exrPTtYhj3aD+rUf7swXHgRu+/FMnVKjJkslEyBp6QacLpERj2WBVCiEFAPC9xlvZepx05rfW4T/4sirJPIAc4Mh27xjr/gTUZDwT9FZ1IzowX2JB1AWiW+RoMknNvbE+LMIQniS2oUbw7bsPO1+5Y56kZ8c2KU6BtAam97ehrARs/JKoY3JT1ELLFa+p09I0mVfSVPls3ysiiWwY1M7r+llwZY7Go1zLDcv0ob+PUM7Mha+1j6Qxp6eFW0si2fdOOzu0tX+eGXa80VsJv5fT5baJZWK96whg1tBbZY4ao528pA4qDFiyp3abQdDVF82VbvbcQuSlzOrlZdFc5Kl19BTIEgurCHwXFbQJWPjDagQi
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(86362001)(40460700003)(41300700001)(83380400001)(7636003)(8676002)(8936002)(356005)(40480700001)(5660300002)(36756003)(2906002)(4326008)(70206006)(478600001)(54906003)(316002)(6666004)(426003)(26005)(336012)(1076003)(82740400003)(2616005)(36860700001)(47076005)(70586007)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:20:55.1278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 997de3bf-b9a7-4edf-a436-08dbca4c22cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-11 at 10:46, Andy Shevchenko wrote:
>On Thu, Sep 07, 2023 at 12:40:51PM +0530, Kartik wrote:
>> Add ACPI support for Tegra194 & Tegra243 SoC's. This requires
>> following modifications to the probe when ACPI boot is used:
>>  - Initialize soc data.
>>  - Add nvmem lookups.
>>  - Register soc device.
>>  - use devm_clk_get_optional() instead of devm_clk_get() to get
>>    fuse->clk, as fuse clocks are not required when using ACPI boot.
>> 
>> Also, drop '__init' keyword for tegra_soc_device_register() as this is also
>> used by tegra_fuse_probe() and use dev_err_probe() wherever applicable.
>
>...
>
>> +static const struct acpi_device_id tegra_fuse_acpi_match[] = {
>> +	{ "NVDA200F" },
>> +	{ /* sentinel */ }
>> +};
>
>Where is NODULE_DEVICE_TABLE() for it? And why it's located here and not
>at the its first user's location?

Fixed this in v4.

>
>...
>
>> +	if (is_acpi_node(pdev->dev.fwnode) && !fuse->soc) {
>
>We do not dereference fwnode in struct device, use dev_fwnode() for that.
>
>...
>

Fixed this in v4.

>> +		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->clk), "failed to get FUSE clock\n");
>
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(fuse->rst), "failed to get FUSE reset");
>
>This requires a separate patch.
>

Pushed a separate patch in v4 of this series.

>...
>
>> +	/*
>> +	 * Wait for fuse->clk to be initialized if device-tree boot is used.
>> +	 */
>
>> +	if (is_of_node(fuse->dev->fwnode) && !fuse->clk)
>
>dev_fwnode()
>
>The second check is questionable. If you get it NULL, it won't ever appear.
>Did I miss anything?
>

If tegra_fuse_readl is called before Tegra fuse driver is probed, then
fuse->clk will NULL. Hence, this is required here.

>> +		return -EPROBE_DEFER;
>
>-- 
>With Best Regards,
>Andy Shevchenko

Regards,
Kartik
