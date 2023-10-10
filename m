Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552197BF802
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjJJJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJJJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:57:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E799A4;
        Tue, 10 Oct 2023 02:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d75rPjGSO2tCTS3UrOiVSlKcZ+ZTFD2iwrCc5oEL7ErDk/4NNvMlCYGjm5I/IxUqV6YeO1I5gq70CVaYXHFio5/MXVPVamhY9ae9SrMIP1Yr939Vfs2/WLHn+gU5ZRC4S71rBkKGmM7aTwAJ+d0rclA8InDGEgswIA0Wd01xPFn3rhFNjqd1X0TRGNEJWYDERIfSP39zK77fGMEISpVIF+1hg+How+dBHCdvayYVvFP6PW+6iRquQ4RL2PZ2ntLquIj7RPxxG5euKLdZWzXT306UC1gIRtbLTVh9ebyw5LiWTPjcL/OsMbC6WrJhWSGSmhVzgBo3IPcdAilbWygo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8PN9t96HOz+b+jHaoWYEeNLvqvu6uW7K2pf1TEfyw0=;
 b=YXkttAmLc3P4E00txVj2GQJXB/QiV4mEhFbWeEreE5xMZZDCQu7S5w69TDZJVZ9z3oxgh1apLIG9AazQE/Jh8+QyTpkG8W6LKnjB2BaHt0//LlK+CIlyukinLaBKE0VbDj2kCOzr1NDbWFOOiUFaQLpOsY8ogjawI7cL99cOHAncAptDUYmmMfyAF3H8+OZxoTQ7o7SDHDu8d7m/jetg1PKyiv3x+2U7iowVU/FK0F0MTD+StCsgBXFMrAf7IEvIwUq3G6tCN65DpnpNy5LfxwM4rj0R1lgzdIlxndPvTCNx0AkPIKkXO4Pp3OZ3w6ry941aERtEH7FH74KQ9YWRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8PN9t96HOz+b+jHaoWYEeNLvqvu6uW7K2pf1TEfyw0=;
 b=s5iQvIvmPnaJ2MRwFPkoqutgG0xCvE1NXrf6ptLZPmN8xYI20mJQ0im/i0MdSfyWOQxp/KQvJ6Wsh2DC8KKQP6Y/V62+Kc+50iVONij8DECqsJ/xkzEoI1LGgyAsew/j3B0UI03yoYIXJnnxvy+2j4y6WTswxL0AIQ3RGE6Wi0LXXbWnLhAKTzocGhIn3LwF2mP+IsTky3g7i/ADbhzTlb+GUjcyeliTteNnpBntAV65jEI0YFVj7kWJXnU2fiHNuTlzikFhzFa7LvEvdDp5eVGeSQF28qOm4+MhVg2uzjiZaBDda6cFr+GDoHD+uX3fggfjyhgGqCE+uyMUC5ujDg==
Received: from CY5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:930:12::27)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:57:16 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::25) by CY5PR17CA0060.outlook.office365.com
 (2603:10b6:930:12::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 09:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 09:57:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:08 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 10 Oct 2023 02:57:07 -0700
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
Message-ID: <07a39914-c259-4fc5-8524-3fbe9171b191@rnnvmail201.nvidia.com>
Date:   Tue, 10 Oct 2023 02:57:07 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf4df9b-7599-4eb8-c692-08dbc97748d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXnOVtJqgaZjeK1owWYQJHjbN3lPsM0UC52LZxZSNkGtpMWukX0lfM6iIsr6QtIct5B81yFcLKg4n7Dq84nVexXvzygIXat/KeBTsMzHrnxRgHEmylNvuhVvhNSdpXcN4+mOmZy4Yo3wr8Oa9V5sGhSbEyW9Ct61WmCTJwVcpLut20UJj+xmj95qP0VZnOIelHZ0o0x60B5eFeKIWZXFUUG9IHh8iqb7awB8GpZPxWOSlTF58RoTNnOlzNSmbFofHR7Zkrwey9ONpcjPGgcKyjYi8y8yshcwDdRMvri2VpCw7rBiPfQWUqVaPGQlA6OWd+MNR1gG3uURoQjzGN6MQTbkMgTEeegvu+G7wH7LkcPallne1fXhA+AadJyr/LheXvm+kzsvxZFP/oegB5BK96gJ/BfLSLFhSUi4yd3Pi5WDetKqAiOtE2x9DbSbi3isTqd5EF37BCInF8XNMkfweEG5+qO1UIbNlRnF1wvND/UPQviUN3/kRHtme9GVMRoAnFju0nUHs+xT9iea4d9JuZbPitw2tqgtXEavnL0vBPXRYg3U787OjDIJPoPD85IUkQfpfmG7QghpJAiTdc4mFCTRLOTs6zqACE6iMk3b0+O0O/FU2ZfonHA8iY3rgg4nSEx2mLVgOr96W7lS/42+pk09d1qxfiXJArEtd7rf8Q4zjWs3vjPNPVoQEyDMVLKCTCWT8L6FF9ywTEv/EsR85gmM9vnBTtYZPvjpahchUk4CqtWRD6pDMTFNWTzL696QTiTj/lJWJqJAPuII5gtCqiU9ZIL/cy81IWR4BHv8PjE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(82740400003)(356005)(478600001)(47076005)(426003)(336012)(26005)(7636003)(31696002)(86362001)(40480700001)(2906002)(966005)(41300700001)(5660300002)(70206006)(316002)(6916009)(54906003)(8936002)(8676002)(31686004)(4326008)(70586007)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:57:16.2289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf4df9b-7599-4eb8-c692-08dbc97748d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
