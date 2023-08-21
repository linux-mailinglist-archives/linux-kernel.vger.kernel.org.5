Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDED9782815
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjHULis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjHULir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:38:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0CCC3;
        Mon, 21 Aug 2023 04:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGSHDCpqSH5qNDuKuPtZaCUFPhwVFKNxH1jvrjJkZFugmMDezaCxHoTqSaaK82MQIsaqjMJ3RV6Wc7ah2HzNjucE5/tLydWZw+36AkO/KMPtXinNa4dXhxtEse+98Ng1cQoGPHFZMZ1LVr4xdcdgVU0Z6Z9Ol2EMcF5/DvMYX5npVsuETLkWgjptRxycUOuC6SZjPm3hI2O+0DGYc2VG7JSk8ln4myr/+Ew/6MDDwdAzF1lJN7wDKzoYRryeYOUa1RaayHYD3YH3zrhYtskBysT4Lz5un5ljm/SVHOw1MUE2Jy3gVUaiBO7peGV7BGL9KVOCZAnk+4vBbKiFrWow5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTD+XaZWD4vhE1/FW7e1jPk/J2JxpPUpEIfob7U4Cds=;
 b=Q50Uicprcd6HpYSuPW4AiXtmRQRkK+CzIMe7+7FL9d+iB4ATnM3k8FweY2oKYHcCIMRvFQ4nadgX9nB7TrkGDQWnaBM7PTDupYMsrisL/UwYBeWiAe3BxYhM2g77ysznbjYwSEkoLyDLNXeULYUG7f+2IwAoZYGhUWauYE1y5YUAcYhxrzd5E4U7o6xDbLcskNx46c0mixr2uYJZlMDPg7SWmS1MB5EMot5rGsLZ0B5ZGK0Oi9jYqPacruR81thkkg0H6G9741bnFpuGY+PrRoj0Pw9O6p2lmMZ4dDMprOVKnBp/MVk7CKU67+IubwoSstn6jpYHpeSeILIMzmoEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTD+XaZWD4vhE1/FW7e1jPk/J2JxpPUpEIfob7U4Cds=;
 b=cnOKAaUH6OenfUlz+OC6CAwbzkRSNSrmBKxS09As7IBQHt0kZ3D76aeeEEHTwGUIJl0+9kFcQDcnCm7W0QtHLs8FdZ3eTSn6tr1WtEbb3VhtSpqxbntdXomeXh2rIlKCpgYQUU3RWuRWLqCnL5NJSXue/bOM5tOPOXeI3SPwgOFOJdMj6Pmen4NxAhMhUHMAjWWHbCW+zsM8RYv3EE+R2vrU7dDowH58WAJ6B0ou4wdcfJYkmXYH/AwU8m9HZoMc/mvD93y0Y64+pcuL0XnZElgZCxKKducIkcbRnOHijukoyr55hFCUURezFGn4rfJu+tNC+BINnDQXXmPqtE+wfA==
Received: from SJ0PR13CA0070.namprd13.prod.outlook.com (2603:10b6:a03:2c4::15)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:38:43 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::46) by SJ0PR13CA0070.outlook.office365.com
 (2603:10b6:a03:2c4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 11:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 11:38:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 04:38:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 21 Aug 2023 04:38:31 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 21 Aug 2023 04:38:27 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <arnd@arndb.de>, <digetx@gmail.com>, <frank.li@vivo.com>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <pdeschrijver@nvidia.com>, <petlozup@nvidia.com>,
        <pshete@nvidia.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <sumitg@nvidia.com>, <thierry.reding@gmail.com>, <windhl@126.com>
Subject: Re: [PATCH 5/6] soc/tegra: fuse: Add ACPI support for Tegra194 and Tegra234
Date:   Mon, 21 Aug 2023 17:08:19 +0530
Message-ID: <20230821113819.4400-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZN+JSrT1nH/XMnGu@smile.fi.intel.com>
References: <ZN+JSrT1nH/XMnGu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: c67aa2e4-434b-46a1-d60d-08dba23b2be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgWF45wviwNhRFEIKs0UilcwNN2W94otc7MWHdfeICxfWD5ctZ7sbhzo0n2AmWxGvDHmHLe5I6ZvYTNyc4f2KqnmMMpOcMZmVAvxB1yE+i0o00x8hwa3/2hDvFdlNDJGT188iM8MCJugCBZcs7pyhRzFXEG0i/dfskKVRYIKKLJuEBOCJXl/nz8qZpWGQt18W8BRaMxDtuRix9BYll2FUEgQiuvGf4x8zTkv6/eNzmL7J7RzPcMETiJxCiyu+xyTTiPtdkUeSfG3AUVHR/MDfpJCwJK2HfnlAxiuIqzf5lGdXK8EiznMdAsYRgPdoYVUUNrFeUFVRcLyj7RKhz38oE8yswifpChvy7HFoGouiMVF1tvqRho5ZqO1O2eX1PxjAeNeoVdCOk7sb+bEL/UXincUKKnVc/boAbD5jdmRh/HdhYr/udsXsafUKbaojPpO83ph+iSDFhTuW8nepBVggx3yh7ZlgLOEhfSKOWKjsjsttgu65Fvjz8JxsBPX4ePBQIY4GWQOcLM0FcmOzFhwimQcFi52PR2r0AH6cMcrZUsNzPrbH3mEQUzyx2ycDAwTDFPNeyV656ikCvvbFfJMO7FP0UAU1P14c7eyukxSTNpICLNzA90RCXECYK5GEdrJ/y91fGu/oAP2J8n7ECaYngcatNbXAWicNktA5gM6ltJVOTXdOPtHyglVSVPoFPZ+dUqsnlzXD+IX+3q3d7u1AG2fkSe5t9qtLV1vd8il36m/nDabzGXjvmw69HMzQ+FA
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(83380400001)(2906002)(40480700001)(5660300002)(336012)(426003)(26005)(86362001)(47076005)(36860700001)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(6916009)(54906003)(70586007)(478600001)(82740400003)(356005)(6666004)(40460700003)(41300700001)(36756003)(7636003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:38:42.5438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c67aa2e4-434b-46a1-d60d-08dba23b2be6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
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

On Fri, 2023-08-18 at 18:07 +0300, Andy Shevchenko wrote:
>On Fri, Aug 18, 2023 at 03:00:27PM +0530, Kartik wrote:
>> Add tegra_fuse_acpi_probe() to initialize Tegra fuse while using ACPI.
>> Also, drop '__init' keyword for tegra_soc_device_register() as this is also
>> used by tegra_fuse_acpi_probe().
>> 
>> Note that as ACPI subsystem initialize at subsys init, function
>> tegra_fuse_acpi_probe() also contains the necessary initialization
>> that we are currently doing for device-tree boot as a part of
>> early init.
>
>...
>
>> +#include <linux/acpi.h>
>
>You meed mod_devicetable.h and possibly property.h, not this header
>(see below).
>
>...
>
>> +static const struct acpi_device_id tegra_fuse_acpi_match[] = {
>> +	{
>> +		.id = "NVDA200F",
>> +	},
>
>Single line, no inner comma.

ACK.

>
>> +	{ /* sentinel */ },
>
>The idea of sentinel is to guard, the trailing comma ruins this contract.
>
>> +};

ACK.

>
>...
>
>> +static int tegra_fuse_acpi_probe(struct platform_device *pdev)
>> +{
>
>Why you need a separate function?
>
>> +	struct resource *res;
>> +	u8 chip;
>> +	int err;
>> +
>> +	tegra_acpi_init_apbmisc();
>> +
>> +	chip = tegra_get_chip_id();
>> +	switch (chip) {
>> +#if defined(CONFIG_ARCH_TEGRA_194_SOC)
>
>Can we avoid ugly ifdeffery?
>

No, the SoC data is defined only when the SoC specific config is
enabled. So, guarding these with ifdef's is required here.

>> +	case TEGRA194:
>> +		fuse->soc = &tegra194_fuse_soc;
>> +		break;
>> +#endif
>> +#if defined(CONFIG_ARCH_TEGRA_234_SOC)
>
>Ditto.
>
>> +	case TEGRA234:
>> +		fuse->soc = &tegra234_fuse_soc;
>> +		break;
>> +#endif
>> +	default:
>> +		dev_err(&pdev->dev, "Unsupported SoC: %02x\n", chip);
>> +		return -EINVAL;
>
>		return dev_err_probe(...);
>

ACK.

>> +	}
>> +
>> +	fuse->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> +	if (IS_ERR(fuse->base))
>> +		return PTR_ERR(fuse->base);
>> +	fuse->phys = res->start;
>
>> +	platform_set_drvdata(pdev, fuse);
>
>Is it being used?
>

Looks like this is not being used.

>> +	fuse->dev = &pdev->dev;
>> +
>> +	err = tegra_fuse_nvmem_register(fuse, &pdev->dev);
>> +	if (err)
>> +		return err;
>> +
>> +	fuse->soc->init(fuse);
>> +	tegra_soc_device_register();
>> +	tegra_fuse_pr_sku_info(&tegra_sku_info);
>> +
>> +	err = tegra_fuse_add_lookups(fuse);
>> +	if (err) {
>
>> +		dev_err(&pdev->dev, "failed to add FUSE lookups\n");
>> +		return err;
>
>		return dev_err_probe(...);
>
>> +	}
>> +
>> +	return 0;
>> +}
>
>...
>
>> +	if (has_acpi_companion(&pdev->dev))
>> +		return tegra_fuse_acpi_probe(pdev);
>
>Why is the ACPI so special here? Why you can't go same flow?
>
>...
>

We need to initialize the soc data before we continue the probe.
I guess we can have a conditional here for this initialization.
and re-use the same function. I will update this in the next patch.

>> +	/* fuse->clk is not required when ACPI is used. */
>> +	if (!fuse->read || (!fuse->clk && !has_acpi_companion(fuse->dev)))
>
>No, just make CLK optional and that's it.
>
>>  		return -EPROBE_DEFER;
>
>-- 

If the Fuse driver is probed using device-tree. Then we need to make
sure that fuse->clk has been initilaized.

>With Best Regards,
>Andy Shevchenko

Regards,
Kartik
