Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86797BF818
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjJJJ7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjJJJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:59:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F7693;
        Tue, 10 Oct 2023 02:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMAvXDok1xc9kpkzIoya934EZ8+yc6ivnvFTYZzrGgCh5KJCLK3D+SHLk8hPGNhiRo9urfG9dCahEKlAOm6CiQbAIqsH+pzai+4eliqImqOYS29wWc14WDYfJdWxCfx7RFijndqrPTfyqXelD94P538ensAqVcKIb84JAF688tWK+8GWScPtG59MRcT3pjoIZY/8jVufFIrR+jVg+ugMqevzPu6xeFbY+CBA5J+yu2cNdBACIteULQAaREOvj9vUEIAkOjwP37sKLFLiO4UH53FEbDVVl7WN0u5Am4rakpVojRbOvJfUihuMB63CfXC2hBEKeynV+6B0FZuioIDyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXPoLWV7jNvHNo6EQTYA5hPxnMb6zICAaRgbULAeZig=;
 b=YXcRD6kj0OoacHQOiKQnbNJCJNgkAbBpoBV/OKtRTDQePPJjH81j85csHd7RBcU9Pj3zjD4/ARrIFU+Kvslu6RduLtmgDt8bLpqxABBLrvVDV4da0urRHCv+hBEMYJHk9HzWGxXl5etSc6rcFN7tr7GuLnukjaZMAa2CJLLLdk3zEInvkfe+KYJg3ZsyV59nnKphjTsmq10Go1QTBvHXs2Hbb/YQhSftDfRFMkZ3fVCcdZaIJFkMh1w8SjL9JBivZ0zskeg4dqQnLh/GbIwGJD3uSCfPb0AcJ8M3XfhjAODtrdtliUYYdQRHQ/2UCkQwj7pLsX2N3w+8ZLB85bm7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXPoLWV7jNvHNo6EQTYA5hPxnMb6zICAaRgbULAeZig=;
 b=PNevAw5BmihdcPOen7QVefldWCNimCpM4Rz8m1Xod0I24AEuEGCmkpH6tF6/S4OvojC/VoVT5p/QMCJRIhao6nv8U2JpvjBY8gXnl4HcKRPridPLmug0LwJsykuaxx57DzYjyx3FMZLrrwYaOWp/vGSvbbOUcELSz9EbtNG+Z47/rT6wyPz2JBgzNuA5/vgCsV/IaohKhFlM2EuExE1HjrK0rxOic+pK/f4O8NKrZf2wAKK+zB1ApdDDSqqoanD7HoCnFecfgdNh5LPmyu4OChgvzqsb2tAdjg60ZmYqpYzBdkA6lgPP8e7/5WNS4iNric0SSJsCYIa+jktPU26omA==
Received: from MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:59:35 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:6a:cafe::49) by MW4PR04CA0057.outlook.office365.com
 (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 09:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.6 via Frontend Transport; Tue, 10 Oct 2023 09:59:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:59:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 10 Oct 2023 02:59:33 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 10 Oct 2023 02:59:33 -0700
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
Subject: Re: [PATCH 6.5 000/163] 6.5.7-rc1 review
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <18201a85-26cf-4e55-9d12-1a9766e13896@drhqmail203.nvidia.com>
Date:   Tue, 10 Oct 2023 02:59:33 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM4PR12MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: bed70199-ef4f-4e9e-9434-08dbc9779b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbK8hEJCabVDJDMGwaEsrjHScHHwZT0851J3UlL9ArvZBH7Qal3QuJwesNaE380IFm01w2ZKeBnm5d35Id3VD882XkkggJTAZKuWxHCFcClmLHuegJoYiymLauN1VCFizZCrtEZsvGPQfV3NVlurcrUDtzfvPX0FWL3UMyf9ysSb+7q8o1RkoTLE2s5Z6fk/xTGVS9yqfj2I6vlG6xHIuttA1TpEBbovY+vb23XNYr4Jvrv/4wiGy/io98ywqX8FKKFY/WAMaXJTu31npP62bI0wi9WuMKy0jdB87J/SH/Rl6FyM6Z6JItOrDlx+1CvRvXl/xKYLZs3T3EwvT5ITy7IJJvmSv/how4sQj1c85OtBj7GiFib9xguCRjW8IKoCDzyTA/NxnExKxBbSh3nm8udx9dWP5lG5/Cm2B+zhoFsVp3Grq7Na3iQr2jLbErCmCuNh0Cez4BtUDJOZZmaXZOqsaHzqGZgchHXmSmVCb7K6Dz7hIBgl3v1y8VlZGOkq3J0BkuKRkNwtqDicXHvqOLE2yHf4g/uVkHieGRCofJ2O3zgUg3ogxJqkASeO0fwJHuq2n74ztubLAPTdXEPYgNIuUt4wRxr/uoHiy1Ol1CC8GxGL8icuE5g3+y9sk+ThKCcByLQKMjXak9z4ClxapQpGN6JTlVu45wTvKAKvwiF28eLGbqB+LQ7VgtnqJTMZrki5liEfjm7PZO+23WwfHCqX0Nvr9RL5FOntpqmRfLP4qdjYeBFYr65qkyY6Q00y1U/8ZnjqBeNuQUNxhvQBwLCiDOV7McoFlMAudNkNeuc=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(31686004)(40460700003)(40480700001)(86362001)(31696002)(7636003)(356005)(82740400003)(36860700001)(26005)(47076005)(426003)(336012)(7416002)(2906002)(966005)(478600001)(8936002)(8676002)(4326008)(6916009)(316002)(41300700001)(5660300002)(70206006)(70586007)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:59:34.7470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed70199-ef4f-4e9e-9434-08dbc9779b64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Oct 2023 14:59:24 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.7 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.7-rc1.gz
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

Linux version:	6.5.7-rc1-g36615f3f3371
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
