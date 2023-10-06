Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76A7BB448
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjJFJcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjJFJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:32:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8142C9E;
        Fri,  6 Oct 2023 02:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqR6gy3YNITZIHMLzl9Sq9HClfhsgpqT7KBwSL9Ou+Al64QQD4ar2vO8T+f6QnB/K7zhkRtJqUwBwS4vwrlYPRLAnApB6SGEkdBdgX83RB38KcB8kfM1d3LiE/519wRS6jzg9deYeYSwFWzd9dReQmCZstNvF+PVAdkAZbxJIxJbK/JUNAmCaP3lpDiu4TMKKoHffn89eUB1bIz6K5I0/BsKyu0+t1m+BmjwmdaxSGtfBNVGAnJ1OXfuY3UyIwhYEjt7DIZUSR8JAW+UK7ggjnm2ySf1ovzRtspMqlBfOYfosEGoFgsHmRjibpHx283sljWScj5rg9Ksxx89TRiaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoRv7esj8dgnhjMgzlFth2gHPSFuqvw7LW0Z3ebbG7s=;
 b=E7HCbCCu33SpEKadZCmn/2+m3yVyyeJ8JQfLKCCGmTS01VItCV07VE/7uFk8KDWuAOBf+2Otu6KKk/Eo9cwwpJ0mB3kutYWNegohN+nfzBUXrEPxQrNgHE9lqXXD12FDo9KlvoD/NPZW/XSCZk/i9JPJ2lAgV9zBtNfUaVahij/BQf6LJCaCFefa0kTaL6SkpgoidQgQg6ndOruL2St9KS5kOHMkh0kPTJMLOhVJNDM3lfeQBRCsRXZm0Jgtd7Pl9auE9nWMYPbikom9ayNYJTS54P711plkrj69KVo9ciIvf8rmHSHMeXo7aIfR0pKMeoM3Ptb+96htiYQN+b5+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoRv7esj8dgnhjMgzlFth2gHPSFuqvw7LW0Z3ebbG7s=;
 b=SXICidU2x8flD0E5X27ncuhQ8GvdAV99WXwekP3qC5OfxWIggXDFtT5p0VITQXtBU3P5jsNszGeRKnUHYOyko0vyQw6A/lVKftD/O0/jxlrQhats39wGWFv1TizVPy7a/cDI8dACvTGCdBQe3ONGyIq5sg4T6aptW7TXY2M3ZWTx3NXIQFEIp/u/tqA0FDW3pZLUak8v5YMeUunmX6MQMk0H5LMUTpMguwI4sWJg3h9EsTvHw8rc7NuvCNfgaeaLSB7ticutO9V3al1Y30zYN/RbPWnWBAz9fr0hnSQCJoBCtLgyCTxgbjd648VPiSJFn/LGJTKFux1ZKdUbCcp9nA==
Received: from DM6PR05CA0038.namprd05.prod.outlook.com (2603:10b6:5:335::7) by
 SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 09:32:36 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::87) by DM6PR05CA0038.outlook.office365.com
 (2603:10b6:5:335::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.17 via Frontend
 Transport; Fri, 6 Oct 2023 09:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 6 Oct 2023 09:32:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 02:32:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 02:32:20 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 6 Oct 2023 02:32:19 -0700
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
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2fb9eeb7-0d39-4ae0-b708-af1efd654a78@rnnvmail201.nvidia.com>
Date:   Fri, 6 Oct 2023 02:32:19 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c4cd0e-6e67-47c8-3b89-08dbc64f2cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FU4Kf8D1FUBQ+vyzYfohZ82Z5LbrUSAIVoLmJLo7SdGpEtiqoNzY+Ya9K6geDD7yCwK5ar4TnaQvEsCfEGzQ4U37HKPfJNVnr/lPwIE1sEcvMyuZKBMM5Du20SE0r9kZwxzvSKEfj6UcbTW013sZpt00/icP5x7m5IrH5AvwCbv0Yx10NlK9TRmz4U4a2YQ1O5NyjiEpPoP8sS+QXeZQmiwKyGlY+QT6Fq3RIUgtzLH5Dw2T/47fAh4nTeMwtzmIPhxGsBsI2spXGDpJSP8ayiPBWKjvDlXsjRz1cJUkiPq1TQgzf/WH8XGrbPrrm956MlX3KoUWZS5kX+KYA6nguY6lcVdXDLuCjjCO4ihEWkxCz8D7FvpZYkc+9BsMkfhIZNa6vL4dKrSqM+ol+XyG6LKjRM/aSeeocskznbfLr1Nf59DDgs+53x1/fZnyZyXixugKPIIaVo6IfxWxD6NdfDV300SdDSg3x7rzKrsrDCNPUPg1N49zzgpI3orsGxPfyd3f99wXDFU5FGsa/g3NcxRj9uS6jBzLhpEUT9u1t1ecGEwQa8VNy+bZCLeSxcabj8203HdpA9HsSXkQV6RZarlJtH/z2HHCymNmKK5GjKac/DUV7SFmTkzsal7BMQ2zLxaiunrKf9M7rSx2Mc5Klvo0Sy+XuF+nujReasQs7ksS/0ItyBhzL1XvfElMJAsN9TF+vyfZqOABk7ocp4J7e3D96x/AdcGHbK6scG4bYAl0XpPpugCATanp+RkjYrN7tm2XAhgfsa/mERGXVUfFfuSXdBebK6dO28pXgf49NqI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(478600001)(966005)(426003)(336012)(26005)(2906002)(7416002)(41300700001)(316002)(6916009)(54906003)(70586007)(70206006)(5660300002)(8676002)(8936002)(4326008)(36860700001)(47076005)(31696002)(86362001)(356005)(82740400003)(7636003)(40480700001)(31686004)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:32:35.6219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c4cd0e-6e67-47c8-3b89-08dbc64f2cb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2023 19:53:51 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.134 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    94 tests:	94 pass, 0 fail

Linux version:	5.15.134-rc1-g6f28ecf24aef
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
