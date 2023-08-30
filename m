Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180A978DE62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbjH3TCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243223AbjH3KYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:24:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878B31B3;
        Wed, 30 Aug 2023 03:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izP/dXNpkveK5icVqVgEn9Lc0dr+IdWx8oQrwiDsYPvPFhbzr5Cz+bHny5GfJBbRrsQb6EpPtka+yo0UB5esaENeCEpICTz4VS9d3r6WY2IJOB/ReRvYoj8dbEW9Fq6w9oncp/Cd3nl6L6L5IMKTDDFtAv1D85lLmAjuRTIXQyJ1G+xSVGf1RkK1KWzkH04GGW9AHsaNKAZWJf9BcIXlyk3sDA659ww/WqUm+a3BgddmjkMErZa8uOhLktq7yM2FqJIprIs+SqK6VM+7X0YjpwwWpqbBJeAbJFhilX6uj9qrYCw9gf6klcetAgR5EH9VbofwcrCz7mJMmirFKP3eQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh0IrumrcB8XeHvFw7Z3qeUe3YtCEUywhn33ynVjrh8=;
 b=l+pJuGjvEpHJ3TGOg+Owo/KVwMGjRcnG7WavNpzFcxyeShrzU+fakZh2umOvWXCfjpr/Wkf66IkJVugvMUCOkStZkXoa2xXdDus+ik72GwSxgwPgkn71DDIdjCD6Di1Q9jJqRlVaJrr5+1/j7oX57R9gNcXal3ic9PAD4e7v7wzk1gw4yj0srBwiFGRWFcawd8QjUVEP7BiGlE98CH1XesV9YMfbd0UJySjvq4CaS0ryWnvOyZj8b+29hTHiAMi4+ITsidd8MmktkFUHwKd4zJNi+7wXA7wLoZSaYHaGcVWJRw1O4TiG+j8PZpZHCmlcMYIbJjxZJIhAi5wRqa2dyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh0IrumrcB8XeHvFw7Z3qeUe3YtCEUywhn33ynVjrh8=;
 b=fxOS1Aib2bedMPT05FiEmdN9SUNXMHyRLpI6wwVlj2P3uGDxWaiUkSYjapHZ0mKFn4jEFtGTcD4AOaLH/u90bKrb/9IE2i39Dx0XHC7Ln6fO6e0jpsZ1ZOdatWrFx/hEpa5W4qi9R+QtPaQzgy1kzSRZiG5y1C0xpcBJG0GjAVkgW4+TPg9M3vWJIdv3hyg8+XWr8phYzkSeM+zp1IXHtC0HEltqqAq6yH1RIwi5MpO+vBsHLMfBw4duONlZ//ONt1Po2sj2WLC3Nt7fmgg/pl+ZPjgLefuvWcfKsK3sUHj7GByn18Ig9Qy3/qkVr1fCwpz94HupO9FlGyPxv+ZtbA==
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 10:24:20 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::19) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 10:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 10:24:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 03:24:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 30 Aug
 2023 03:24:09 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 03:24:08 -0700
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
Subject: Re: [PATCH 5.4 000/158] 5.4.255-rc1 review
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <51d0398e-ed17-43ab-9e0b-1cad3d9a47d8@rnnvmail205.nvidia.com>
Date:   Wed, 30 Aug 2023 03:24:08 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0e28ef-0e39-4575-4e83-08dba9434595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZ9LeGJwwxxMwuq/mxHPPEAx4C/FyBddlb4+1mdnY3Zl+POpCvklHTlIrV3qXdprNzP1DtMcltTHFsSprPdSodWjUJ+7s7ulvx6ll/Qq8Ia5FCF5p4HixtNIHK6KNplkRH/xBOlrH4u9pLccjyPjhgjZfsD2o3bDDC/+RUmyf05Wbtwc6UEsw9LIAZ0uzM9PbMNQQLazMtI9urDk3jq/PwvjcYQ5A8kwznVpFE6aDTlgJku1hscHsxKYHzkd/TOV2SNh+/kNs3G0CcyYzujJ7kGLEtaiqZi6UskDBsRSZE7QJIl/XwrUeoIBuxc78BCfcYZPuA81GuQzdTwLOw543Sxfl/Yfb6UdAbylJKe2/L0ZmHyPSpg4yAg8fHRsbddy3oC0Tr1TDn9Niye63IV5m9OuXSs6gBXjsa7gkQgFz4QOeOonpYr2LRHIjfJ7Elvqdex1Erb3zslGJ7IBifp8UXAsoV490EuzHrIR/8amFdri6lpSCdndwuldTDfYDA/uJTIdW1rZRIuQMQ6xxaBhkpnl1AggwktqjHjK3tzeni7G///59IBKwPw3kZTRNz0VpkQDoBCIBNjSMwSnagtmjVN6dLymQ+MiCOAS9qVsTpW6tCUa9VX33+xJ7XIuMDLfc0151f3N0rHAmYzSdpabIU9VcmXSAwaL3ZzsET9krlx7q01rDCsUMnOMny6uOvfz01zrx/Q1uz/DDV9FQkcytaz8eB2ZKpZQxpxvpfhH4dxfETztbywyqcAmZK9xnLhBHhTgt/76hVndRJtWnytZ3YOfDe0v8HP35FKP1B5beCM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(31686004)(40460700003)(40480700001)(8676002)(31696002)(86362001)(7416002)(5660300002)(41300700001)(4326008)(8936002)(26005)(426003)(336012)(36860700001)(47076005)(82740400003)(478600001)(7636003)(2906002)(966005)(356005)(54906003)(70586007)(70206006)(6916009)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 10:24:19.6654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0e28ef-0e39-4575-4e83-08dba9434595
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 12:11:37 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.255 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.255-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    11 builds:	11 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.255-rc1-gf1f9b3b66b45
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
