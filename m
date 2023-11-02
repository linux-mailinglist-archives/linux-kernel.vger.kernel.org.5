Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971C07DEEDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbjKBJ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjKBJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:29:31 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D9123;
        Thu,  2 Nov 2023 02:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YetczJZ0sISt192FeDe3g9hX5rcXz7aSzfoVN7jG4BBW7CD4SnSsJghSmy4HEkAxF569udeHb5HnVIH14KELyO3BypivQtxmknf72o5XjIt9ynxs1TtPsywTtrSUCp3hsQHQx0AwNW9wrxDB3s9++wz85lLHzXebGs1+Wr3iM8qCcSnlSJTuD6/x4ieNLiG83FWRm6Y1IyWRIkwoRg+0N2wj7qp1o8LLJnrNe1wGEkwM73UIrL+SPWBeJYwDgw1L8w02gf/D8PBQZ7kTWIenGNQYENoKVxz478/FJUFgK24XquXoFvI6ysB7sZ5Of8csOevjlomqVxT6yytW4bIXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOUIrVhZjEwKTHZvHPMIoZXgF5DMs2fZ9izxhQA+1Oo=;
 b=lSZ17gpYbOrBtq4IEabjGyennQhXhAE2Y6XcrSEvF/6UISqtyJzLtwGS18tg7FaRBDVwb1iMvv+FGmb5dVTBy0qRIRvl318MHY1jMuE9Hnn5+p5/tyqnqam9EDL+UbpTOWFA1dI4fZGNPyV3C44y35cl16k5yxxtIZJmXiAC64blDXZv+xfc9rQ070nCuUfs9yS93iqa12+5Sdxfy+YX7Zn+KuVQL6/EM7JpJnnQtPUlR1SaJrHrEPAdaWhxDLmvRM/fuKOvLkozCFx+uNMbd6VkHzGQbErV/b3RcxzkEn9D0bT31YnJGfY5F7ugEUNWkclHRVmK1Mb8xmYP/pS50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOUIrVhZjEwKTHZvHPMIoZXgF5DMs2fZ9izxhQA+1Oo=;
 b=Jm1Y99jDubyNokgYdxaD2QnNqc/bBz95gA81dEWmAiWuVFt/P9gmzb5BEmo5TQsVtczpdCFamvsFXYDNPMIjh6ZQ605jhCOqCSks/l35Ueo5aNy4L0439172PJyhc36c3mvCEmALyvMhRuGCwZRqinanhXG4XJPC0xyolz0HnaUwX3EbxQ4k3RsgNI6esARgoS0e8CRNHjxYnLNgn1N51ENcVsLvcE0/rT8Fx5yAn24ALL3FAL1/T7NPEbPoya0+gb1ZJpP6Lkx219LCp5QS3nRlMe4OTvXNb6gKTnF7DmSqrQLaL8jbyT05ZHJX5PG26eQXTy7iudzHK+mt+XZ9uA==
Received: from MN2PR16CA0044.namprd16.prod.outlook.com (2603:10b6:208:234::13)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 09:29:21 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::a7) by MN2PR16CA0044.outlook.office365.com
 (2603:10b6:208:234::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Thu, 2 Nov 2023 09:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Thu, 2 Nov 2023 09:29:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Nov 2023
 02:29:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Nov 2023 02:29:06 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 2 Nov 2023 02:29:06 -0700
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
Subject: Re: [PATCH 6.5 000/111] 6.5.10-rc2 review
In-Reply-To: <20231101120147.190909952@linuxfoundation.org>
References: <20231101120147.190909952@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <0e14c74a-0d85-404a-b2df-689d8e877769@drhqmail201.nvidia.com>
Date:   Thu, 2 Nov 2023 02:29:06 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c12ee80-a1c2-4245-e102-08dbdb8631c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: It3/ehIjxu5iJs93KT7SoTsyQHCId/iNnaMuLNusyrtLlwK3eEfRxwTFAHZ+uc7AGRpo0XqIaH3RBKPZvOcfS6KM26Vz7OAvS1BiY46MgXa0RF/IAxs0jaG2KzjjAsZ3Q28sAg8omdHtLGDNWLkni99IR7PEueN9fV4uu2flEo6+JJKFpVAZc1Y18GoCHwZ6S6YvXm/wh7/yk+DiUG+MCmtZ9sIQiQA3C1IRlz8H9OON8Bc8cGBjvwI5D2uvaafpxAGLOzyj/IWAu+4j3eYkOeMyGgxztlPT3V56uT5QClyN8JUcnm9EKDz39ao2GlPVgSftjsoZw/xmaVqDvuWTnZQZeHxqLnC0KRkGAja+d4/RwF4U4CiEjyNez0xP89sBUHmm8K4V24JubUIKOPUvE3vTNdPW0xTABBcjeqSPC8lJnZwEjaKXJDHTOmXjKBpDcUw9c00k2u/00LJ5eJw38SfmieqomsGHIWBJrNhALqO+LXr0jKnrrutcU1yvuJ2gEPk/kCvTPXHZUTRaBNYlDjgw31PJ/OxmEzraw9dGRvCc2JlkkYBaqQHDFxWhIq5T6Cv8LVOJ+w2WtNP5gk26Q54mF7pIDw/YYE75bYxfJ0qoOWhphShz7B3Qpx1x9ChTSB/8EopgNFx0MQpnr7IyFfyM+zNXx9CvqoqAQFqOzuIqDuEod2oo3feXlB63pS1m8A7p8ukL2APbA2u/BsG1hxzxh/TM9JyBDMwwZYTU/BNs3p3ZLGCieMBkk2B9rzN7D/pJSoqupJti6U//81xgnz/SIXN1bvp+gJO23xjNTTQ=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(966005)(31686004)(54906003)(5660300002)(70206006)(8676002)(70586007)(8936002)(316002)(6916009)(4326008)(2906002)(7416002)(478600001)(40480700001)(40460700003)(41300700001)(26005)(36860700001)(426003)(336012)(82740400003)(31696002)(86362001)(47076005)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:29:20.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c12ee80-a1c2-4245-e102-08dbdb8631c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 13:03:25 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Nov 2023 12:01:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.10-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.5:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.5.10-rc2-gb4d7fa7ca278
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
