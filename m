Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE27BF80F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjJJJ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjJJJ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:58:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A59B99;
        Tue, 10 Oct 2023 02:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkNrtKwPlHWmTmFp1EUXyYzLzm/8RolCbksE9cH5mBRrtOsthWMA86OTJRU7n2r5PNowbwz+46N5WtFW3aAjfTfBB5K8PtAkzkCP1eIMAmBpv7m5dDs5fwqjHUCrRmJcKywHXlEhA0hAqYBH5QnHiLbFoHnQavusCai/qKsmPC6S3SjlufbnApYrAbSidPoyWJZpK7gqWfzWH1n0PXL3ef/omUUydGakkvkeTWNKqTdwFiT29RCXC1mprBbpi0pIrt3DXwtxbKQqBinN8VGHnne2q9ZYlfMCghaEboaWFZestsLDX810r7Li/pDGbgkrDc+JhW0gt+OvX426CzMJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8PN9t96HOz+b+jHaoWYEeNLvqvu6uW7K2pf1TEfyw0=;
 b=I5ojMSFBSQGe1og3isHkJ/ODcGiYhkb+efR2IPsDznK4/C/rHjXZVoq7aYYnOCnuUZbwAfW4sP0j4aacOD/aJJJUwUgNeKm6t7hXJIZqnjzVUxG1lTIxK1YAZyGikGf4IDPOkThi7L84xLX62rCj13ntNAh8xnl4dpj2FHz6U2pL58h8llmf1A/8h5j5K0RPJK/0y2NF5sRmzQzzOddaghRFoEvV1JuJCm3mQdnpXfVQ7BNbWBDhy3RJwfjMZaj23TEKfHeQXHgDgjQTtkkilsnZAyHXGtyDEa1LdxSbZvh9qTO8gOT7zq60x7aB6GwH23eGVIhSNHxUqivBMXMXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8PN9t96HOz+b+jHaoWYEeNLvqvu6uW7K2pf1TEfyw0=;
 b=mV4NGaLaJYdQ9VW+xydx65v83vgAlC8JyYHfK2Y2ptdtLe8ZXrm0PfuagFb8AHcGzYXlLzc95f5Yt7odct//HgtYFsjb2ryn38G5leG6E3skrQ76u92NILp92DUhVnqcXBcjbQhUdsLDS4/BRwe3ZEvQufjDqK9/LnoaSJ7anfMmq2kM5o/lNgqOpk+YEMJIgayTG1/iqYKAypfzp7yN3Cw/rv2TT1BhryBXHeYdOn7LmUw28acLI/7N2S2rHNB2hzPN8y5ebAhwZBj+bfmlQbl5WoDoGchRbpDX/XAgsjK6mrl0qqPJz5sUCxKp0pLCMbgBz7g5qMuRmk1hDvDASA==
Received: from CY5PR10CA0022.namprd10.prod.outlook.com (2603:10b6:930:1c::28)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:58:01 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::22) by CY5PR10CA0022.outlook.office365.com
 (2603:10b6:930:1c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 09:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 09:58:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:52 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:51 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 10 Oct 2023 02:57:51 -0700
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
Subject: Re: [PATCH 4.19 00/91] 4.19.296-rc1 review
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <0a5f447c-b5c0-4293-877c-137be5355533@rnnvmail204.nvidia.com>
Date:   Tue, 10 Oct 2023 02:57:51 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e24bc7d-7353-45ff-4796-08dbc97763c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7lwo/aSAJlwWMtRIPbx0TF3gbjZJ/NcHiXwP0mjVnliB4oKlMpjBMtQpcn8pF6179OgpFnctWY3ZyX8WPbYa4wNvXGf47/zAe+TYi2NXd17YpvnoJJfttIX/9GYkyPkhtpj23ghF62wMFct7H0hK0jnybJRGppNENrUklfEL/Vkr+hjfurMa4TaaIMz/N8bWm+R+dvIgFS2HtuY6rCG5EIHJxHRXCF81TZOi1/B4/H14o42fH2jXLeQ4JBj5jDyezfPHMx5qGb1N9WxlTL/sFoSVr5Q7KoV2+mHhktKPEW+u7We/wF6XAkR7qeUjdVNt9w4paI6WrCYwSMXIUhOaxicBcU51Cy4tcxvwUVZ0p2iOkWUh8YbKy64ZAwQ+74SgVn+03njmuWkHAohXGBw+IGedCMsqHId7DIRK7O/LsuZJMxlUFQTrpls20kZBeelcUhwU2AeSaWueljp3t5+9sVgOnL/9eJfDlJQS8vaM/6fSH4j0hd0hO1ojK1VvsnHpAsXwV5u4PBjZJEHC9kvoiat2H4+8IjWCo4+HtS1WiggXipcq0FFqn6izfEigJSNIU3BgKjoQXrjhl20/4WxkoxCn7XrjSYtlmWXYYAPOWz5a8lOss3+Nu4iHRS8AClNjvYPPkUNsmvaerYK8uAolZEg49TFUlhEdxc5ALnWt2hPnZngQl3l2kpWSkhPE3TLfb59im/VEFTrEx/u2zl8EOJyAFeIXSNtId3S0IobuJkjBpLoQhsVx1HWB7UD3PIwJZSW+efrAgp0LbMq2+w67641JlrgGA+yiEnm6E5IayY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(26005)(40480700001)(40460700003)(426003)(336012)(5660300002)(36860700001)(478600001)(966005)(31696002)(86362001)(47076005)(41300700001)(70586007)(70206006)(54906003)(7416002)(316002)(356005)(6916009)(2906002)(82740400003)(8676002)(8936002)(4326008)(7636003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:58:01.3931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e24bc7d-7353-45ff-4796-08dbc97763c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Oct 2023 15:05:32 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.296 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.296-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    20 boots:	20 pass, 0 fail
    37 tests:	37 pass, 0 fail

Linux version:	4.19.296-rc1-g1d560dafb2e3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
