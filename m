Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0374776B91F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjHAPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjHAPw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:52:29 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B871727;
        Tue,  1 Aug 2023 08:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fENrpYtreZXj7UCepNf7HPPHYkyfaD4zDPeNVZqKUYpxEuXCJSZuzPfedu3uvOlLSsHDnLOkmMST4XeOb4TVzd1vrROnphfhQPh11/BVhi0fhcFMd5ZO/oAejLHCx1ZWUlK5fPUFxHMSjRRJDj/V0pLvC/Lcp/6wT1ZwCvBMFYKm5T6OeJeHpQswaxVhTDvnKaprTtnKY4ndZcwNYnWCtTKZ66Yh7CXcgldErMqrGCt5DFB19HHC0pmpRQ6kyD9tQ2RmgB8hD7bd03eAWDmh+PpZ7zKVPLW2BDrYQduFMsSO5t3gxordJqcb18CZJsKi+H8fH5fl4wscGq0NJN39sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cyQV9XYzLibW0/kJZg+RWZaSLK07Fpi1Zh/C5TwZCg=;
 b=Zb04mW/MtTQGCsaPHOLZ5Uig5kxUYand9kKVIO48qwPu3RTwMmoDiUt68OSJ/QWi1pvw+8IySLnBWbpGSXpa2R+DD/Eym8QveTe6USuHhS6MrxnhFAxGodugEJOJPUq6H3d/unhbxXGZg3FDIRoiF7kM9+WGLaN7p58V2jyUuraapNvBDxk6HYrKK5uLQNkwS66OOsGmhhJuTbfJj+ca2RZFTP6Rq7pjmGXcwU4JcpkYpkXKKRxD+413oQLCV0Pm+cpwnt0lBcMdM13F9UXexyV7A1zdMV3ziqXKLkNAmqJDKQLmVAsHlCcAsH3MM2Ejjw4Kbwaw23bu04l1av3LpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cyQV9XYzLibW0/kJZg+RWZaSLK07Fpi1Zh/C5TwZCg=;
 b=mM18VN33JJg8wRMGsNlwff/MTReeX5w+mGP8dvnGmaBqE/29xkUWH8eZfr+K93+YmNMB+bKtBE61gQdT5PUTRfhey/d+dkoJIsJhh7ELbolhuGzbJB8pR6631SMN95kPCjl0x25JA2RSBPgX43FbRSoIIHjCvXjo2Os/78G6rj1F3Gs7aJ+FFINB8QU6cIZhKrDFJO1mQAr4IvHgnZKnfluB/ofI9OU4pskIKXypUQtyBE2JtXK1GvNH88709wy+IU0TLd4YuIsUNPKn3GlvwkxDBZ9jksvVOysHcbMDsHY18hRoRupSzyaB2/w0D8QVDJvpXRojmgUaQi6zaP+atQ==
Received: from SA9PR13CA0093.namprd13.prod.outlook.com (2603:10b6:806:24::8)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 15:52:25 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::d1) by SA9PR13CA0093.outlook.office365.com
 (2603:10b6:806:24::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Tue, 1 Aug 2023 15:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 15:52:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 08:52:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 1 Aug 2023 08:52:19 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 1 Aug 2023 08:52:19 -0700
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
Subject: Re: [PATCH 6.4 000/239] 6.4.8-rc1 review
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <dc31666a-5bf7-40c5-b907-8f0dbd1a2af4@drhqmail202.nvidia.com>
Date:   Tue, 1 Aug 2023 08:52:19 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cf84ab-56e9-457d-b9d7-08db92a74cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1DtaOg2VY6mw0GGEsk5ZTfkBSW/O+eOw5S9MwYBvcKYn6QlekvyaY85iXvT/Z1i37BZBF2eQYOcekSJJiJJYJmup3tTXkXzlOQEdDwTmth7PsrYL+i+Oj4pvS93uAXvbf2GzUOmpe7IsB4wiuLQ8YueiYhw4mhEr8zu1VvRpEHTRbgo1NeqrX46H2iL4q+t/o+l7sh1Yd3TxF9f2bvDb/7Ff0NZ0JqO/HGGxv3UR1+oNv0cwDopGvSmgD8XaZt6X4olSBEbjjkRUNvOZJl35Am2Xn7bmz2BlyP1vIf62RwQCXYc5Bz7l5rcQv1jE7HfyI59jZjY+Ze1aRs73Hnj6+Ms14b/6XP/nnT7b2mSXJCU26bCRALuANglQrCa/GuzodFPxAOSn/IZoOK8v2QwlhiT/ZQCoWWEO5E04/b51Pdy9VdDR1rsLWkksFI6j6TTtY1Y5hoDmcV6uBSnifj4J6Y4Xlzc7V7n+AzRWFyMYHkJLHZfA1n/W3OPqeewb3vqzdNRXLkHgqeA5jW2L56DYkaTrYhJD+cjCvOZFgmCFl9bYf6mJy648rk0ENmR3/ouocOK99RHHUXJaUEXNhUyDM5IjM9aoTiH7A9ZUvplDO9p9JtP11oOoWA2Qc0oo+aUFjDcidnUr1E+b0qHDMD9j13B3qGCwkwggjD5uOl7qJraF6P006SDUvoIz02/aXpaB1Trs2Gao7kUzxbriSxSIFd6P1qpryTJHJY9tnVNfM58+ZgMSJLSkFuq7VxL3G/X97qNFPF/5h0w8LtHV+ClPJ6J5T2ln9w/PinpkPrfaew=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(70206006)(7416002)(36860700001)(5660300002)(70586007)(4326008)(6916009)(40480700001)(356005)(7636003)(54906003)(40460700003)(82740400003)(966005)(478600001)(2906002)(426003)(8936002)(8676002)(41300700001)(31686004)(31696002)(186003)(336012)(47076005)(316002)(86362001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:52:24.9296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cf84ab-56e9-457d-b9d7-08db92a74cea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023 11:17:44 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    120 tests:	120 pass, 0 fail

Linux version:	6.4.8-rc1-g2c273bf138a4
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
