Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88B2761E83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjGYQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjGYQ2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:28:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1D8E51;
        Tue, 25 Jul 2023 09:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGxMq/MNsGvXfsZ+3pVQQKLNOJlwcaCG41vHyFu/wKaLDq5hBHkh5B3MT5hUCEkkTYdJJDyCCf45+s0dufiUV8HnV6UFXIt7iGYVZkFLHcJJ6ByA+VloSwYScOkUzbiht/q8mbq51uAu1w8lXZqWjdmweGQ6H/MmiWuLX3iIbESHYXXdfhyfqz0O4/SABOkdr+is9vLQp4cVFf/RVf6cacnYeCv8ZxtzcsTS4Xj3QpPDyeyz4w8Gx8wqJz+G9NgasBDvbtIIblY1t47k4w30r+ie1CMVZ7f7D+r0fI47cC5StkZB7FILUMyofG96aeF2rM77NjhsfeiVMnOw1joMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waTcKMo+jxZZLJxgL7+6ua8tlg5AsArOlk513JTriVI=;
 b=NF0wMCvi22WuIMFsmjz04TOHSBh4vxoXS/IiyHdeHcbaPFxQj5nwJ6ncZeCO3zEMB4/0B3P6YSyZsIUrFfIkOqCzEuMJV/MDHQtVUm4rqkUB1AoEKXdjpJhfG2z2EMdD4uq68uRPiq8VObILVzAcXpiX4n7iab/CVpMQKs0gbUfxPFnqG6VU1nqknf8e9Nf6zYLa8DdZtWvScdD99ptcXobO4CPWSoQGZwRQQUCSIpEAgjgnI71MMSEfWex3dBRniobKC++heIotfkJCGDhr/co8H2aCYWhDxIlbMHWdphymkYrtr8py1Ez6WfQwym6620CKBItT21Hw9y4ZpUaEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waTcKMo+jxZZLJxgL7+6ua8tlg5AsArOlk513JTriVI=;
 b=RjOsCiGUtCSBaIGUDnxouis+qJnsVfdfLSNdbfS/SoowaXIo3+nNlaQq4Q87h+k1ZjxwPMYXp6MLXdk7Sq0oJtqK0/EUoElChG4NM1oV1M/NHBlISQfvD6WbPOnqgmzvGNNn8is2//s5kTHu7K8Yk8heY1404au6gRAKRTFfvNA0Rm3x20VlPXFdaask2+DV2MP396JC6afDOTH6FwU/7UanGzvbpz7kl15TyNDubM67MjNBIb/xUGDe5StJu98T1meYpj5y6FeemrbI29rM0GDKN8yCc1dKgc5KUJBZDWsSghqB/151BS60oynoCl9aNOJi5Va0SDQEXGeX2krJDw==
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Tue, 25 Jul 2023 16:27:57 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::de) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 16:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 16:27:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 09:27:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 09:27:42 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Jul 2023 09:27:41 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b435fe4d-a6b8-4b33-858a-b4dddf9ce3e1@rnnvmail203.nvidia.com>
Date:   Tue, 25 Jul 2023 09:27:41 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad33962-8493-4b76-4e87-08db8d2c1b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZtA/cuWNuBQfU8QILekrXg0gxDoC7GLWkLWMnJECn97zZhm/mp82NyMBg/RfzmEiRckn/m2huYhIgDRzJE8MYamd8PMnJkl/hdS3RNregAO4XZ7bqpvdOW3E4SRiF9nhzKZIaFAAK+mq6lzbqhUIbmlikCuIg0B6RTf8CJwoQysQPOXdYjL5tOBxmagw6rdOLpXKtjR8jQXIqhoasAgea2D3oQcNAb+PXwzTAJ5kddTJ+avdLMAtv8qNbKWEpL64rgC13nLw02rHrwKYX9QvBkfH1n8KkhvCejlcrWPQxYaKVhoFwWht+nfofUuvhQ3hTuLZ+TK7av2AePxdd1+tttPCU5LrTn5JGK4/WKUF+6BKDJq5lb4PYnbCeucO/pJakrMJBcpaNZVQVFZ+8fllRkvrhV2HYVJp/dxwtGBdSo/s14hmfN5YoWbWENy6qzR/SLPqG/GrthHA/ZDXBsjyZlIrB0et/YfI10FPuEw5EBgBwnhAPcYA81fawuNYpUlQnOaoOxIVyBJPBNjxIphIrCo2wvSg0j6iOTmvnTcmcNcsssRc4LveOH32+E1xWbIRwx4fRWamiJBQSFV6x+JYImMlRCqFmLGuUeywDca/d7VvcSTO0Ff8f7C1YM0mFX5DaEomKU/WlASXibJKUTK82nljcW0pdxVFw6HqycmphkwYSUmOB5bklLF3fLfExJg39wuMn9kVtU74J1N9ZbO+PXopOJ0ETHs1kUWer7TsP9689BUkW7P9hnDG389vPI01fAo71Wq7T+m2ESgSKQF5UlV9zQ3/UJ2LEmcwr9KTm4=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(356005)(7636003)(186003)(336012)(47076005)(26005)(36860700001)(426003)(2906002)(8676002)(41300700001)(8936002)(40460700003)(7416002)(5660300002)(86362001)(31696002)(478600001)(966005)(70206006)(70586007)(6916009)(4326008)(316002)(40480700001)(54906003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 16:27:57.6443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad33962-8493-4b76-4e87-08db8d2c1b3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 12:42:47 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.7 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.4.7-rc1-g3c19c5641cce
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
