Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86199806EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377775AbjLFLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377634AbjLFLti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:49:38 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3668F;
        Wed,  6 Dec 2023 03:49:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWDLwzeRSeuhyI66R6ohDQdhFg2q+kIvTCsaZIHAum0fN2qi6vQ58SQN8aAjw3Da0TCgCuHR7hFdiqYqPW+EjNXpNFdSBY+/XWg7CKNzgz8Tid/E3gF6jpn4+PHMYHc/t254KHv7CFISCh4C+NvaqJ8NuYix+PWZyxnHw5/8GcLRp028lMWrYWrvd8IbVTKxhdT7M+dw+ZMsNIfjT9+Mw2noHhC1w5MzI43HQfosodHfynf0piaCGp9R3XgrSYOmE9dwsrxSiJ1DAYoItDtT4iOfrRNb60zo383p53dsTy7nvxRnJTh/vqZnkahJgTX+LPLk/Ls2bFPiAOY5xXvhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TthpMvKGWktYcfjH4mr5Jbm3HDz+hnAjUtKCGMp19bs=;
 b=Y37FWjtz/I7u+yW2bCi8aqjQKUNNSRTy5/zD+nNmHYse9EtdZ8ZY2EPCky+dZiGn8bTalaMI37y+PYnzKn59ct0z8AVKCoyYwf6JnWZbUjffqnTLehNGWTsIA/tH68cDH8nQWh8PQcNw0hZdxCf9AbsRVT1gqaGkmcukHCVBnvwBXVMLJS9GvJeCDmBLw5EnVeTtXzIfFWXs532NHDNijU2ihmirrq6tzgsRUQBrcJ/orbo3AinRglp89zD0dEjP8al+rkXww8SgOxV+Y11lSCzY9t7jSSmoHpQegCXivlLmGAvNAXxuPBJf0v7qzzLJh8SROiA69eLSASNZ1jwVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TthpMvKGWktYcfjH4mr5Jbm3HDz+hnAjUtKCGMp19bs=;
 b=go4qKEWvlOJj234xlG0F4AJYu7DJGtrPlvl346LFFFZhZaML9W9hM2aWIpXwkUquqjmBNsopkD05YythexqadcigxwSN2i5AQCmb/rywugef7w6A2lheEGv6CH6l3ObsXx+vtuqufVwBZJ4D2mGNP+u/4iPtFWQGL/1SXC/9SHJpbrgcRo+H+ykZfbnUkRwodgm5iuR5JOi3XoZRpMSg0/FhHErUzKmjmQpcYFE/8PnNqSRrtbJCl/Sbs2L8ZO0EnRIfuDbTaBKRzt1DAInGscuzKdrB5zOTE2DCSDJl3MOqp0Mfuc9ldWmjmFRmZ10DocjldEN+sGBZ28Uw1Stm5g==
Received: from CYZPR14CA0006.namprd14.prod.outlook.com (2603:10b6:930:8f::21)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 11:49:39 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::88) by CYZPR14CA0006.outlook.office365.com
 (2603:10b6:930:8f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 11:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.26 via Frontend Transport; Wed, 6 Dec 2023 11:49:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 03:49:29 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 6 Dec 2023 03:49:29 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 6 Dec 2023 03:49:29 -0800
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
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
In-Reply-To: <20231205183241.636315882@linuxfoundation.org>
References: <20231205183241.636315882@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7b75fa54-0a77-45d8-945e-6769b6228091@drhqmail201.nvidia.com>
Date:   Wed, 6 Dec 2023 03:49:29 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be5a9e5-9904-4ddd-106e-08dbf6516dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r20Ff48+w47NQnt0bOGqUPgx6eqJXSavd2cHJTwdU0gNbT6bHtd31odR1mo49roe9H49dF8fhrriEulIzqPKJT1WCRJl0eQFpcSyAZrMSpKc4Dd4rqcZMN6DxpFFRf1f4Oi265b3uUGUcL+26ocZcpPnX2tB7Q++Z8+n+Oq2nJCZxdBsEVGyViNBdFREyhEIDdoiZmFYda6/zj+ax9BHGRY25XnWyXAvzbUpK6Ng3NpiLe/3NTetFq2dA5fVcla5JHGfGroPbHBup3vD6IqMLT2nX4LZCJA308wEZIS5iFx1bDIPYZpzROOT2zN7Cp0NiuQ8qeoi8gjwq8ikcv2HPMCrz/c2nx/jzcT9JilP8J4gBsiOhga0RoG3T3CaFwQn0DgEG4yRoTZTW7vlj7PCg5pkmYUARMzzpDvgx9/SsXEbuxYVpgdYHJ8+M4GfcthkyfyAqz9ryGmHfPFQgmdMNIjHsYCjxtyrOWd/9sFlh968VtpOBo0uiQ/M7FfYbbv3QTMiwTB2V5NctrK1X4Vxr+KhbroTPGYAZuATpFUmTJRVrkiBWDLVNOazlqhC2KMSwurQb5YcMiZ8EI+u1Rje/7LWAuA/V5B4SaxHl4mOB8LoxXnQ4C/7X0JRkfYrHj0tiXxn37RRQauB74zvuvWPI5Jx33IML/wWy4/iz/P8NgvZsxO/ZEcdtjT4D2uVffpeoOwsyAEA6DWb3Pftr31SfIVxrzPafzqm86vsIt+Ot4YoUaFv39Oo8lauTxN7p+kdRHaIJCjCVO4TcWK0OHJyLFUl8yRJCHJGMH4oqWGWOMg=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(31696002)(7416002)(40460700003)(5660300002)(2906002)(86362001)(40480700001)(82740400003)(26005)(426003)(336012)(966005)(478600001)(47076005)(356005)(7636003)(36860700001)(31686004)(8676002)(4326008)(8936002)(6916009)(316002)(70586007)(70206006)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:49:39.6993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be5a9e5-9904-4ddd-106e-08dbf6516dcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 04:22:16 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc3.gz
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

Linux version:	5.4.263-rc3-g97430ed51c91
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
