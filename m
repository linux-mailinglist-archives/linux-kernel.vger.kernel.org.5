Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE177E5585
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbjKHL2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:28:50 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB2A186;
        Wed,  8 Nov 2023 03:28:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGSDTp22P/rnb/nk3oI/vou0g67NXYX9UH95ADDV1b3Mhj7+7p5oCFNkBypVx6xrBGSOmWNIcGI8pdNgp+/CoeITEhlTEK11XdoduszDFhkAT6SLcXD9Jb03ZtrZ8Eua3dHzVQKLI5mThRlAkwJ9pQNVWmskCCUmyxA/2t5ILFzxSwQ6FeyDmsshaJJnAbYmKWPjBqyoLFY1xMNmtO87N5xxsGb3V/ooa5dFTcJwHhwwmqXDhSt+MUpS9JnkSptsyt9du0QGSHLtwaJHGr3tsz236iP+QdHV5yZ7JT10jEIH6JqqWaHlAbhnrh1AE/bLTnZ9ShfOPis/BcI4VbZ/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+IyskLYpiRZPEjQJhZjKfql1fqdsvcMyV7MNfCEO+g=;
 b=h3eHHv8KgXHDryPRujOPiUoY6kJsikM2eO8iIQJiKjSD9twqlEYE2bU2S2TwFYjVLlUIcDDhbLFtCfTgIBej6PBLb7+EvYxCsLccfefxjNWPGb+lzrY5FTXZkcpppsrqMOO+jakB5IOcUJ9cL2DoUlbydVwBCcjgaNFHDnRoh/Y/FdrgibuMNUiD2vFhyno+CD1aZ6bKN4X+qk+ZngKRQvlkVR5SVXEJT2Sv5LaJzzS4oVogcsW09eFHGVZvr6/Zgy5foxf4es0h9802pycsBLP8OWuWZxvRamrrfNfl8MpxO4x7pKqkSprbonNJfJHYvYwOzbgs4NCPScB7/DPtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+IyskLYpiRZPEjQJhZjKfql1fqdsvcMyV7MNfCEO+g=;
 b=RMUMCLJqZp6yQVXv4mwvjUjVo45KdgyPNUNQRXpHCMnVV5LRWWx07PHkdl0Sgk8XSakmpyQV5xmzi7UvatqAmy2LrmLhCkdIVUIS/CtbquUvpTgpDz8+hFoCnCSIn87x21y7YfU7ONRN64+6j157H3BPX3C3OJFAkeLtlCscQWn/dE8zEq6msOYY/SC6PSMd7Ts95x9h71YdP8jQnTOnBLfkW4pMdxjZNaZtgqDOhzkVy15TEeacmK2gmhgsRapNl76wJAtgW6w1hO7DorYZG0x8X0lqv0X2otio5OKuQoWiT979YF8bGbwIOgXEjZM+a5EM99aDCATu0YI2GtSHQg==
Received: from BL1PR13CA0241.namprd13.prod.outlook.com (2603:10b6:208:2ba::6)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Wed, 8 Nov
 2023 11:28:45 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::b0) by BL1PR13CA0241.outlook.office365.com
 (2603:10b6:208:2ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17 via Frontend
 Transport; Wed, 8 Nov 2023 11:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 11:28:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Nov 2023
 03:28:30 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Nov 2023 03:28:29 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 8 Nov 2023 03:28:29 -0800
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
Subject: Re: [PATCH 5.15 000/125] 5.15.138-rc2 review
In-Reply-To: <20231107202324.434534294@linuxfoundation.org>
References: <20231107202324.434534294@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d05ea994-03be-475e-afa9-f60ba862dc90@drhqmail202.nvidia.com>
Date:   Wed, 8 Nov 2023 03:28:29 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 15eb89c0-65f8-4f93-0c1f-08dbe04dde84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvOPCPHlRvgXUQQHIgJCqXOiJgYwz6I5qqfTVwW7ni7XsXUEVhIrGiHPjBXSzpk/zxJfCGgciH4uZJcZrhy2UGhUE05n+j9bRDv67DSyOjTU+CKNvy2ZAAJ+noSA81bYiOuFKHzEzafB2ReOwvp5af9fC+dHc0iO2KI08LDGAs8RBWmQV0PgktKW7kXK8yWsi8t/C64DBs2RHxGwQ5zm153qKn347KuVn/rZDdUevdMSdZxrFwq1wzfkTB+FmuwUKH+9JzkEVlzmz5dLuoFUM/COcHxrWTE8dUtDdlAAhlkkOGl6aA8ztOHart5pnXE1ut53/vPqC0UZdHzR6Z/6yvuG7+w+8BhmP4ucxFc+ipfwbNoz+xTP15WXZkJs791BiwrKxKtW1QCrnuo4tPyBgHGgf7p4m/r7pk5kOYs5Kerfz6kxln6pOuc+NbL37MmyX6gP3JIyEcrpO8a93FllTRiuyaQ09XshjHgfPQG2IEWsRnyRN3siY0uVDtODDSRTqqLeW9PV6zJv11RuQS0rpzEn/pJWlpjzJ2PPP7RxmD/KYqqyOfHbTanJ8e8SSbjhoCe/BH8nPyUMtd1EoVtkS75JH/g5E8MoqPYhwqR8SA6Se7UTV/lIUTv2m1SyvFtGveVdcV0Rk3SmSNjhjFVDUZinvTyCxECmG3bwo7RKwpiyWBCZnNQ5/93TVf/oXmcZKyHuXnpMnFsL/A4NWmUJNGVvWdNTQa/Y6iKzGiyWYM2BbGKZED7Y/FHQWhpvNmG9PiUOmcMsa0Vp7sEq/5/2J2tkxw9EdbTXnTbCFuyiWwc=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(26005)(426003)(5660300002)(2906002)(336012)(36860700001)(47076005)(8676002)(4326008)(7416002)(8936002)(478600001)(41300700001)(966005)(316002)(70586007)(7636003)(54906003)(70206006)(82740400003)(356005)(86362001)(31696002)(6916009)(31686004)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 11:28:45.1637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eb89c0-65f8-4f93-0c1f-08dbe04dde84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 21:24:45 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Nov 2023 20:22:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc2.gz
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
    102 tests:	102 pass, 0 fail

Linux version:	5.15.138-rc2-gf3efa02c9542
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
