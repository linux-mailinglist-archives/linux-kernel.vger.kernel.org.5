Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D447D7400
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjJYTMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:12:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40468BB;
        Wed, 25 Oct 2023 12:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCUe75/u/8MYrhig/3pKr/HD4a2sR0OE+T+0lkbbVATnJVr45rm8nHsdGBsRJYIdtzfE7JV+oLr9pUijUbGt0bZ0dmsGAzghlRcVVFDl1UOQ/mQcfWvEoZUmrKsjpZkM9i6JZWHolaDmT0pW4MX4P1Fj3hOga1LGnV4Kbo1INJ8zqer51RSvR1pMdtmlnBaU5/NbfIx6NGTp0UmmclGVzuQV8oJWDRat20Jsd7m/D2Xe+/dotVuEV0P0aEiEhAux2hZJDLKD32LQgGR7sIYVyLTacJl1kCAEz/wHeTOla0X3dZr8KA5oHlebd2cjkfsrakWtM9/3Baby4GE4pE20YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGZTWbe16FlEM8eEjP0poL7KwuGV9hnSbvKJqqdWZv0=;
 b=CaJZ5gTrEeT2TdQ35eN9y3zlq8UWI3X7p7373pGyLgTdHGwQ5qs2QjIm6MCncO+ZG9lGTpsrXxHIxvD8vKKeFfzjXnlH24ryvtraQS88pwvegWCTdZnFndDXcg+U+4acKBOd5ZxnSpZ5GBIrzgWrWTv6hlBJVdt50LdZIflc4N3eJH2e922QMfrSqEzfv/hooR8p6Dnx4XDJKQWuTqjmC/UvyIiu/re+VYa7MnJe5gzth+i+n//yV4UFa6hVmAJxuRm9m79/FCb0D59GuyOcVETevpsWW8TPBrOzNGcPXBRZSk/NrMeExvmfqt7nciZoGfyj4Ogin8hUHqXnaoRkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGZTWbe16FlEM8eEjP0poL7KwuGV9hnSbvKJqqdWZv0=;
 b=tgOepSRBocs4Omav8eRzWUr05eh7KA+/CZMnyfe0LSKGEFHoBPR58FhWGACsX8zyal8qT28OpLTAlLpWiDGZWZux9XxKZ+1HaD7FvW9KzwzsNIg/6VDWqluEwBEmZg4mqA59XnIrxbmpQug0K7659mHQKB5EKQiOX++bEtxHHfyyA4JUbSQM8w0JFseTNplindijbFRLAs9C+gGHPVb4hqlLk9ggM8NraH4dnH8DVOwmJk/mPFHtaX8AMEz+DJPmD0Q3ZLszkVUTVffiF/3aSsc9jM1lXzwwxOF76JwLIqjoTGdZAh9j9iIzqsSQJwZGSxUqLEspOZ0Sb7A2frBFdg==
Received: from CY5P221CA0143.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::13)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 19:11:57 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::27) by CY5P221CA0143.outlook.office365.com
 (2603:10b6:930:6a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 19:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19 via Frontend Transport; Wed, 25 Oct 2023 19:11:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 12:11:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 12:11:47 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 12:11:47 -0700
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
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2928ebcd-7bc5-4efb-8a4d-7de219df02a8@rnnvmail201.nvidia.com>
Date:   Wed, 25 Oct 2023 12:11:47 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|BN9PR12MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ac8d28-ce0a-4238-cf8c-08dbd58e41d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdO2gwKF/+j5lCqv5f+HeWa98gES2x+Ae3VX6LaQo8El3Pv9ptMlwUPll3t+b/z2skX6gpy7qZ93pBjLb1aVzfC2gcp7omnL328MBfgEgjtJxNHgtmlSLduJ0kxZ9P/DMx8Kk7LyZkm8zY4+4SqKArDQ3QWmS7IJH6c1oe1lDYiM4M+C6ec2o6j5GsWk/E4pAG5lNPrFPrYcGSiaobPvsx4CkxTP9N9RH9gl7h6PSQ9UBR/XeY4QzI3gdKkzd63a+a5UWcmD0O8Da9FzCgwk/FvE3vva1RMxUcPJ/uTd5G7QdFJL118BFDs5QrKnkVmIQEhNduAnIuWnr0ioktVZddr6KCuI3+lp8uYLhJoBzVnUB5GbZkjeDls35R1UmZx0rtfeshxUuIdptYbQH+HafjdzVIy/EusJ+VO/+EN4EctcdM3qBk/9udQZGtyQgpYr7JWiPUoaRES/422M4OOlrSFMgENzN//dGkcds+86uJxM+vohO0m5d8lRO2BIG2vRSZP6WNFRjFpTkk4JYVuju+mtmyvZm7Oiuy/+jwnxkBL49BL9Wzca4BMBjhkdLUwY5XsqjNTbRD0hP0KAvSYZ9Rql00+aAV4sGpsCDiIvQf51At4Le8YSRXA3lb5UOkp8jW4eqaCL9U8B2fi9zP4wEowty2UB8PyFkzztFO804hY+h1rSa2oIMBctSXEn+Q7p3BZnxsehYc3G2SH5E8VwSEAjwecwtIOC95SsNVIzZGF5HpdhKskjjuJh4rIDFpXw03/6GMLqF4unXqJ6cIuQHajWRmKLj5lqnmTRSFLPtl0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(7636003)(31696002)(40480700001)(82740400003)(426003)(336012)(26005)(356005)(36860700001)(47076005)(7416002)(2906002)(316002)(966005)(41300700001)(4326008)(478600001)(70206006)(8676002)(8936002)(70586007)(6916009)(5660300002)(54906003)(86362001)(40460700003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:11:56.8829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ac8d28-ce0a-4238-cf8c-08dbd58e41d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 10:39:43 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.59-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.59-rc1-g9b707223d2e9
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
