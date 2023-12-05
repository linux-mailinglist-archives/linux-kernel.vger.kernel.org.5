Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6010680519E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376608AbjLELJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376756AbjLELJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:09:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C2C124;
        Tue,  5 Dec 2023 03:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9SYMGInUF7pOviwRq4uiBvHfOodW+vN/z60ENuu+TZ/7DejmYJVRocWX4BmxcZ6RSPJWBxBbUg5DTmBO+EiyWCyWEVPvTc8HwGicmb8ovKJiI4CLuiGDa1gTWlCICO7IizMfhlwAGaszYIhmsnedhl6nszqBZgWXC9j+vNSljtlaEcslX1uIGx3pzhJ2pUkssO2sB9XuO+waAdlNJPqaZL8IPzW4BsGKHfgA/PzoxvmDOP3MxlgPqz0iscDslfc5d+mQugvzvEYSoNKRQc/G4c1lBeU4UwqYcDOOmkCRcWcKLKut+bwhXRWxOceXAMDtle5IL4QCxN6A4dFxMlS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY8E5PMzGWiSdr5yE8H5GTQrI+2qrri/h6XMl0l8vDc=;
 b=BXT4ecZ58F2lUyC3EdBsVinhZ1zPZy1nf4ARXEeXrh50GHKLFmsGykKlmNTM0QmRoQGtsDdauyppzLwPJtKewPGXjWHLS/iChnhfQJUWYCq4DDIeEwL9rRl0C7QZo9E43Rs7DgJ1IiLxwNi2ubz2EeLXAsAIRx68aZE5VejtPdrM1u04L8dc+IDotD/W/tUr7donnDTkvXHoFAEjHn7vU96RwCWUav7NxfsPFDDFYNIsn1jZC9nM51mw5zc/Akdxi6lXRpjzwN3Ujb6uvxss3nXd6sUYHemkTB+oGSl+pkSn9M7s8kZ6CQAqa90KBp65iGxFMmQxobvnaa01vXR+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY8E5PMzGWiSdr5yE8H5GTQrI+2qrri/h6XMl0l8vDc=;
 b=qzo1MQ4qZr7SWgxwCOHwqbxyhH9yp/l0fiCDGZlmCbvgxM8ODtr86qlvO4h7iGpz/abR7KTcncJ6oVwS2ILTcc/W5LvaURdRH33d6GdiwIvGZhwAaa9WyTczVVpWF3d3QNfMqLPUnifzKQ0d36TIfk756dXxQ+tkaMHCaM/uT8xogOGjQFPAfiM2PBz4NLILGlknY1MmKBEl9PToKc7zDfXpLHdvKzjD9PE065okPc13f3K5RfImthVrEZ91ujmYR5j+Y+lUawQuL8GxBt2vWFrD6e6WV/y9UNvjzG+VUE1TGCQ1DyLjXD3hw0kov8/tDs8Wmtydd2Fg6RPmtHW8dg==
Received: from MW2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:907:1::19)
 by PH7PR12MB9068.namprd12.prod.outlook.com (2603:10b6:510:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 11:09:28 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::b1) by MW2PR16CA0042.outlook.office365.com
 (2603:10b6:907:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 11:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.2 via Frontend Transport; Tue, 5 Dec 2023 11:09:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:09:17 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 5 Dec 2023 03:09:17 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 03:09:17 -0800
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
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
References: <20231205031519.853779502@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d6b63c81-d424-47aa-a4a0-d89f85d98030@drhqmail202.nvidia.com>
Date:   Tue, 5 Dec 2023 03:09:17 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB9068:EE_
X-MS-Office365-Filtering-Correlation-Id: 82509bab-0906-4575-05b5-08dbf582a5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vY1WpSe2zcKQRlyTwC3GOaKrLPRGSpK+w5zpLsavQRlLONqzZhqZlyX9AuybEqzlhK4HrBK/05mkXOemE4aYZvwge5xMNX/54ozDN2Fs/WzGhKfSpapCywkJlXWzsxqMiN0LvR9+Wqe2T9zMLdBDe8pYkSppAqyAAsWaJWpe+uE6ITehKQj+mQN5bGgbwkQE/n/4FJtBdVtecO7ady9d+vcCvfTKHXKQ5WDVM/m7Iai+PrX5rJ+Vuhza+5Zm9tNqH6WfT899ybR1FpfplrQu/lp3J/ydFcGaOvBkr3Ng6+2d5EEW8YzX8SezjzGH+nDSnN/DRO4plppFdfpsSB6I7qklp7N6hk27PC1vUWkeIAItMhLEwVgnIurM8+0ZrOOWjsUSgTmCuqkW3CsJjgPMMb6mUro2L/3ly0wDj4W75ltpG61keJuzpTxRi90t2jSxs4dm28uRBQBSPyto2CpStscTfTXdzmOg5QgPuR+rtjEPJlmHnsHM0RMy9S0r+9amLSYD9AW1waepHsKwFvnut1ZO2A/m6JPl7s27AT60fYp2ncHQDP8Zm65yecqzIRxCD4bTKA0bOKC5gT65bjaHOnVAEn4u0AWmd9yjI37yeQdl86/0Pt/r2FY7zFjYewE2OnUh4tOOMfUIwN4rsu6EFbWLAYOsmCKlyLWR1M4KiXDJ1oZRgMkUgmG3M1+YKnlXqj8iFrkgoyGMbUymOjdmWC/vB8mPmNQMKX6Rb5Hl2PhrBBvJDZtP/nYAq1toYFNU8Za9CEBwVVn/rq51dbmsHNsCM2aU3SWT7+YsHKrc7Nc=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(31686004)(40480700001)(40460700003)(36860700001)(47076005)(356005)(7636003)(2906002)(5660300002)(7416002)(82740400003)(336012)(26005)(6916009)(966005)(70586007)(478600001)(41300700001)(426003)(70206006)(31696002)(54906003)(8676002)(86362001)(316002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:09:28.1455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82509bab-0906-4575-05b5-08dbf582a5fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9068
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 12:16:45 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
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

Linux version:	5.15.142-rc1-gbff845be423f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
