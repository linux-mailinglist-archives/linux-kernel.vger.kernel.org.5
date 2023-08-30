Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463DE78E027
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjH3TQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbjH3KYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:24:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC701B3;
        Wed, 30 Aug 2023 03:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9lihriOc5GEXIjESbicWyOI2nRsT3yzpzC/0MUq50oRI9h7+zlrXywOmdCc7/yf+pTxcYQtQTr6+ZwbGVzUnPYb+IixC/YDXO+8TQhZ+Sxhw8tosWYXTaArAyBpUxR9ppStZK+AATdxoKozZqM+81/86LMZd/p/4SvUJ7ai0c7TeOcJIwW4bY9EMXl7WHrcTWOxFq8P8u6NUX6gLh5Hq5HSFY8RJW5io6oa2sTQ8gS6gbOua0cxagZm2cnIVSMcPhw7EpAgMubayPweloHCKosgQeixakMaN6rydL1f2VauFHWCD29lDCm3iVgENN8FZSk78hrBUBMO/3mZl4oYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTd3XDY74rJ82hksQqm1lz5pYQv0fy5ZIHCiQSnAyX0=;
 b=nT6zQo4x8piGHPXAPs3f3tH2/UE5D113W/A3m1qRdCoehICd40EPPzR0IhdQOL3PWO0zD/KZy8RuDfCbQVUw0xrDHZy+BNfiq/jlHofpltf7Ewjsa0wIZeIlZ4EtZqWxDsgYyj6GBwUUsMZxV1i8H3jOhkYoTwjdwirF7hxRFaNQ4UzQWlNBZ6NiaUSciBSZia4AqOaJzt0HQJA4rA/uCGkpCbBvfu9aCJWuDJyHCvLZaM4Jm6gDpZIawoMiF7oXYppbJgNx7wdQ0+i2dTvrTQm4u0Z0Blkx03oOL92ZGFnrkF0CP4o1rfaAE4RMOMFcR7ftdlbRhN897MYfIOwQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTd3XDY74rJ82hksQqm1lz5pYQv0fy5ZIHCiQSnAyX0=;
 b=rDJ6SsIwN7DkYH/F/pqM9CBil8q5QrCsnx4wMYTH6Ld5oEjwFPIsufJP30TvkHelclLqwGSYltycNGt55V/ouuByG4YELGmP+TD/7XLIizelB8zjJZnvHMSqcoZybo1dO/TPItYz2Jw+l6HjlTXDMbMUNxMAOo5qB5LgVAfuCepYo/KLGKdPVsQscnSZ4gVvwdaNlXQRuRIOCOO7pDPc6xLZpLf7XPDsLa7KUiJEnt9J4i0nDTwsddOBpxWvMjTZfTTbCgx8GEFCTTMURb5gaZ2BhgtN848GRLO5AJIa1A3vSl426O/H9wxnlMhvcx3UNQ7VoXQv04lNAVMwkmyWSw==
Received: from MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::25)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 10:24:48 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::3d) by MW4P221CA0020.outlook.office365.com
 (2603:10b6:303:8b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 10:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 10:24:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 03:24:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 30 Aug 2023 03:24:28 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 03:24:28 -0700
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
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1ce29bd3-990e-4724-ae82-fa2c6bcf785b@drhqmail202.nvidia.com>
Date:   Wed, 30 Aug 2023 03:24:28 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: d68b9bc0-5146-4b35-9973-08dba94356bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QD2iyVMbaeBoJWEh7Ofz58lxb0lnzbVqifBJF3cj6/CoTaQPYPeP1Xvp/smKgeSb3x8tXfJHhv0ryiDAjwYUMhn77kH1hYPtHD7jac2UyL2Lc69p2oV4o+kozEOcR1wvs2dNp/aHY2JB2mv7B4eWo2OFA6PjKH88YlOaDELAZDmkEI1AVGzdYVQDJh+QYFdh90JIcbvZ5oMb8Zc2UyLA4qWAhiXJhYOc78Y34Tstknxxc41COqXtblm8B/63TzdMbfKezTINAgMcbo9ibpNSmzJYFgqOS92a5B1vHTddnNRH9zTZHCrE5wogIweQx1X+fOzPu2jekzgzbK50QxXzs9C+lKYPltzYvwLM7jhr4LugOFaREuIMN2u71gtUUALFAfBnKpuoszW+VATtetaVtGtG4L43QpTb43zaiddNuQHtYy9uohxHYE6MXI2ql2QYmw3TPUFteri7cpdshZoSQ5wHGAuJofx6orY7NnwJTZXAR6mqcjtr9ua0Q1wgdLXvg/zuccwUpAmv/nfNKKMWBdKM0Pg/gSulUxc5oWC4qxmMqXfm452Jd6E8XeIvXOa8/mHKpUmohfRCOOSAW+Sh3jGP8NaQL3OE/AXqwIlDdwOwvXbU9PAiJpzERGy6poFUi78KGSLmjYoUNk/KYKlE68S0D+xEZFWDNCwgLXQlXbSa4/k3g7CSbVpjp80xMnDCwKl0WTGLj3n3X1EyWJMYS/MuDjCa64pc+Z/EICQaIa1it7Lcrp9Oyjj7Zy+L7TS+zkl5wghd7vEAcFRo1Q7RfgN4Sfdaq3bCb6WtIWrfh2k=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(186009)(82310400011)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(31686004)(40460700003)(40480700001)(4326008)(86362001)(31696002)(7416002)(41300700001)(5660300002)(8676002)(8936002)(26005)(426003)(336012)(36860700001)(47076005)(82740400003)(478600001)(7636003)(356005)(966005)(2906002)(54906003)(70586007)(70206006)(316002)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 10:24:48.5223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d68b9bc0-5146-4b35-9973-08dba94356bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 12:11:19 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.13-rc1.gz
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
    130 tests:	130 pass, 0 fail

Linux version:	6.4.13-rc1-g8c2717f278c5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
