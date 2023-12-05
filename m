Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427F08051B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbjLELLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjLELLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:11:12 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B138186;
        Tue,  5 Dec 2023 03:11:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oITyXKOlowqx3CFdKHkh2uSz/NGM1toFgJV2nhmI3Ah68jOLrT+0+ESjln3eCm44fXTyWvNDNHmme93i2Je/+zTUkpzU5HbmTHITNShUnxD/HS9rtjhQNoukrIIs4w0R8+QzC5YWE4gCCXdwFN94MWz2wn7VwhNO6VG6d0hFR/b+ufp1sDQtlIkMXuIj1Q37MnU9KX7T98iq+KvfbqGuqv1dAZf+jSXw9FAZ0QsWkSTeJcxYYVHOdS4nkYMz3bpPil8jJJK7pIR6CCFHaZhyPT/CmXpOu4eKQrgkdIhcs1MvHMYdwW4h8pLkbtTckzW96vKfzNp4NjUaTol/8eizNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBnNNS0InZ3ixYnpyDiMsO/TXexgFp1OfPRECDGHSQU=;
 b=HMc3kteCVHJVd2oF4pvQStyI5adnbTiRoOgNu3usjduuAsAODGIddX7LHXddG2t4gJf1JRKH25kulLuyHx8yLoQ/cSjhvy+8gPc17UWzZ1+ZEBsgBBFEHJAoUcr9k5/JfCbniUK9qNDIYKDhw1RytyTGKMEb3iSm2+qfN5CvLrRAfZlsyxXGAOhNzqNky5isqzz4A2nPN3/k2Mk1tEYYYNFjJjvclVIxht7XJAzhhHCKLuLyI06s4kffFO9SrZ+nKYRI58cBpvdVaZ+1L01ndann50zeuklTwOmUvM3phoWbunRoqrscPUOHZkhWrdbyL/rmEdt/SFZEnuKGyMD8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBnNNS0InZ3ixYnpyDiMsO/TXexgFp1OfPRECDGHSQU=;
 b=hTqLAx62VTFcvW5mRZ5pZ6sQP74bnYce7n745Aq9gbFkiGCGRGbfks2/ExiQqez3BIAW23qCVtRDXUKvgUVRV5ivXEOlUrj65sdphxrZTK5jGLSOnklHq2rC7omypbNPMXS5L5AZMsx6nbmk4I5glfvz5Z6kGJIPjNYP9K6Qx5UtjgquPs6fN2NOv8clj6vDUYlNN1GxTwv5r6dqBgj81wg5u6KQjpodYfX50YBH56cULa+AGo1j1Y2rXaGBKHhyrvfbEO7BI7tqawF4fB1R0KIdVpIUi9jC1+CLNj5grkwSOaMklbYkX+0lol9c7SbbxfKkdzFMaIYd44yM4IaUPw==
Received: from MN2PR20CA0042.namprd20.prod.outlook.com (2603:10b6:208:235::11)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:11:13 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::ce) by MN2PR20CA0042.outlook.office365.com
 (2603:10b6:208:235::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 11:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 11:11:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:10:55 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:10:55 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 03:10:55 -0800
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
Subject: Re: [PATCH 5.4 00/93] 5.4.263-rc2 review
In-Reply-To: <20231205043618.860613563@linuxfoundation.org>
References: <20231205043618.860613563@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7591e16a-5f8a-419e-a7cc-cb7cf6554e60@rnnvmail201.nvidia.com>
Date:   Tue, 5 Dec 2023 03:10:55 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3189d169-5ced-4f86-8fcc-08dbf582e40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwcO6TjgB1RAdOK3qC3y3eTIlH1bmEbd2F8Mnk/zPBDSiY7WnikySsYtAe7ZtOCfOOrTqX6x+hdb3LcmkD+vulEcHMw0l6OSZHktHsZMiw5uxWwHaSVssCIOlkxsPux0Ztspdt3XT/3SCaH5O682cOYMQnT7CEqyfZmtim5ZD/DGwxIZb2eVZsw12xvFfEreWiDVXCwB40PwUOd/PyRrrNZ/RfE+EgKJHsvpjRtj7e/V530uV+Eh2Cj2C4mDJc7yV0h9zUij1e10HCm0kXMSStgaIcxF74C5JgiHVPReRqoDbOX1D3OWbGBMtxkcOG0YSEGOusuD1hBCEErpjmv4DOngJcWoF5thkU1GzTRqvztMdGSnDhlYM9vr7ndbUh0Pm6iuWtQugKPb6Wk92Gl2ymXZE5kjRfZSEREsOfUF7m97+01T4h9U8fBSgu608GwapD4uJuyK09lca9wBV0qBkLgYSJl4IGD4CyCzWWNxzUXAN5WrlKGzlpY1xKqrXT6R1rPhT1tb2od7Z55QN/XlpifgnBxg27jWMfKAQSxLF+F8CXvZkAD8760gZyLQVyVaBrGjbt+bf7mWZWQQMjX76BVy7OasVAzVooC23TgFIVd/oq4HZZEuArButEkPu/8i6UHXhv03v0RHs1mhNb8vaPPcrY8z9dVbfAEM6VUxPRvGynAXT075zSlQ4OzZYvWXIYYVU/9zTNDIm4OQlNnHNoxXROm4ZmMEwiJk3N1rm0yvBgmM0D1JiLSMquPBiliYP12bLuFTBVYpZQV8RBmz+MKosRUHW9kolhwj36+T1ms=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(36860700001)(40480700001)(966005)(478600001)(54906003)(356005)(7636003)(70586007)(70206006)(316002)(26005)(47076005)(4326008)(8676002)(6916009)(8936002)(31686004)(426003)(336012)(82740400003)(40460700003)(5660300002)(7416002)(2906002)(31696002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:11:12.1804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3189d169-5ced-4f86-8fcc-08dbf582e40f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 13:37:00 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 04:35:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.263-rc2-g937c4bffd9eb
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
