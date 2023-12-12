Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432D280FA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377765AbjLLWUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377818AbjLLWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:20:45 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1ADB3;
        Tue, 12 Dec 2023 14:20:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcBVNoQ8xP09PcleES9GTzb2URmcQCYFms2/GSBibPVftpU93EF4ql6/9BDafE4XaG5gHhwX3swz45RjqIyypKB0WfBUoxfPd0vjkCgFZEaeU299mq382bvjbAj3HU/SJapk8erHkAItOVFp94xALf2eUQ6TXtxXdoZ4/4m8c/1BwwWQkOx8G1OrZHhCDhWNSj/+eHqtTowHLp7FO1eyyX5drjHB75v2N0HDYkb1xkXkh0wLnomFEZGHR0pGfzJ85YMsCSjzFqbW4fNP0fowR263AJUclqEh/CMWZj5Yv/2J3w//xzVwv8E0NVt4ju+Bvz55A5a8Hygk+DZpLp8B6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5impwLdXlZKd84f9hOOgl++7vhIn4VdPxlrfnk1Y/w=;
 b=IhEjmSJztBp6Toa+qIW6GO/DlKgvsDO60ZgCZa9T0HIJyWkFlsjQeQTAUts1u84ekk0ToSaWijUP4N7IDZnZMdvp7K1yBVpY565ljh7pcCCf7MSfro3/HqQSj3hkQctN9CxFxtI74H1porNdciBfElcvLuqv/8sxTrHSUrgM0famqyaFe7O1MJnhWqWEIfIga3jtuL07oe7vWF7JJbdqxNxx+mHALpkjqZT6apWy9ONsdT37WgfvzLTW2SI4lZ16GXoOml12iwO7nHt0rtytVj7GA04rk9X9uHeucyKt4kVmcrCklywRZu2CtxbgfiGW7Zs4c25thheP2qFN+4l6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5impwLdXlZKd84f9hOOgl++7vhIn4VdPxlrfnk1Y/w=;
 b=NLoaNTM8Oymfz4uPt+ohq+RiC3IeNu93XsEzz1t+gbAvAzQP4zhMJacRecO4OM5ByJ1Dml6hSQS8a8CtB/YD+o2Sq9jDWEgI66AnQRZ6tO5tgc/SK3eCr+HVlZqH2JSgKhUCYQuTSdTNzURwZChAFsE4NahIK5MuAMzPlXNpvtbVe3VwpIWoo9akMr8UBhmibhPROpsaydvXGNcFY9uG0nt4tpPLEyiRRpxglgvblz/90Ekxieb2F/kxZ2MkK5ebKH92wHawNKWgZ9zfYMZ28f2trdZLOLnRbIBYpusjHz6Yhsn7sCj+cSzrLj5hxdmL9gzLHDc1Xfj4BL/2CxrR9Q==
Received: from CY5PR22CA0098.namprd22.prod.outlook.com (2603:10b6:930:65::21)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 22:20:47 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:65:cafe::14) by CY5PR22CA0098.outlook.office365.com
 (2603:10b6:930:65::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 22:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 22:20:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 14:20:29 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 14:20:29 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 12 Dec 2023 14:20:28 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/97] 5.10.204-rc1 review
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c6f003b7-83a6-4c2e-84ce-31b2ba54fe7d@rnnvmail205.nvidia.com>
Date:   Tue, 12 Dec 2023 14:20:28 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: adee6245-d390-43c8-d421-08dbfb60971f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQ8xhy4b0h5EBXm0kBAOLH/WZXFQl6ZVNhWZ8m8oUSoMZQz4Q6KujqR5ULrt7M+c8BYZzcBradQR8uXFkizFM1aVBWZ71//v4vYqJvoEDnWOfqsXnF8w44TUSInDH0btSIOlyFju4wm8TjnCgjIvuO+UHzD/D+zuLc7Rhejw0ZcyDAu8CZXtLUQTuvGDWUxxCpiZmU2aDJmTmHECZpPFpop9+L+LipfLsDXuGB0BT55PlfUTim4SCFlRY7ur/VlAdtcnHv7MvEx4Gy/H2qFVnPQ+6iZs3IIvNWwypp1wGJk2fg91peM31x85n04JPaa0zAIEBebC46iW+pi3uiO5WPX0+P+beHEPdvWaapqc9k69mZupdQHwCobvK4L7EbE48cSawx7aVigrsYDHgx6OGYDCGT6Bmxi4Wr3UUVrbNQ6EkIcXrnYbBIIAU6caySIQxLyrfU0SmEq+Xr0Zyn/RLPPO1y3sKU/yMwGPENTSB9JoLvPqx/rhVe1ZbDdNXNhHWKlLybGkLikzMhLs7VaeJCkh5RxBxrTwvN3ukin838Eyw/gWhIkl3iS1r13lNpXZcnYpLB78D6SHYTFdqW4tQ6pbrQ1Hka0MKw6dus/BWqosyuQE7V8/7QqtEETV1NbMHW66+2IF9SrAHldPJQ4m9N6dDopWYZyGTsmcA6laFf1qm26zA0j1KPD6NjfzoNfEYC4XSEaBjDQv+Zz79YvJtKKRC6EMTWjlPqRklMEb+BaxOzc0QnLm2j1N6UfTvtkHDUZEC/SVAbmbOVY+ctlZlXw0+ZtWXstvkLA4wlTGnV0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(40470700004)(46966006)(36840700001)(31686004)(40480700001)(41300700001)(40460700003)(2906002)(7416002)(5660300002)(316002)(4326008)(8936002)(6916009)(8676002)(70586007)(7636003)(70206006)(54906003)(82740400003)(356005)(31696002)(36860700001)(86362001)(47076005)(966005)(478600001)(26005)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 22:20:47.2528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adee6245-d390-43c8-d421-08dbfb60971f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 19:21:03 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.204 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.204-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	68 pass, 0 fail

Linux version:	5.10.204-rc1-g670205df0377
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
