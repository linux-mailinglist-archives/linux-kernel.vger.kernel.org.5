Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4438B790234
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350630AbjIASqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIASqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:46:12 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A831CEB;
        Fri,  1 Sep 2023 11:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbJGIBQiNJVEIYi3dsQiyyHL7XZ0+Hc6ibgAqNrdqXNDyoUc+twK0zpUBSpvl4ss0LQ/tR+JCdtHE8F+IuFFq/u3fTQYPHk0b8XEKGwJvsKM+P6CLnVjWu0NodH2Ql9zFk0GfFHeCz+DQrnBLuXY8khaiA3duw5unUDs5IqXHSnAgkJjLOMIOY69f9qL/o3JzAAwFugLU2yUjqG3gyD74t+vTp+oHg3Vh4aaFkL54j5csIV3MN/NcciGAXtqE5zzqijSa2vwd8EE92c2FmInAgJmQLjBfu9Cpk/J331vbMHY4B1fbhnHFzhhG2ErocE9hzFzHevAacqzRsuVUumnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ek1Y+9qRGuCcCYaW4yIG/8yTVXEXTBzk2PEmXAUBkVY=;
 b=R33GOZRj4i7Ax4gARyv0wyQvtqzCtVrw4PVwPGUIgm6T4bQp6zwYeW7rSskZCM23d46bgeFBnY+BgJBU+zEcge53qXsoPjaWiGmAE42tcbKGkWi+RYNySHW77KBxaZ9mS0mW7QxpC33iAi9cJWkzeuxVfR5vbA3Q/m19AKogQKhGbdY+C1D5FvxgD+B2stceT1J2qOacd4e1WsxPq+RtCSlxizEuffUhRm6V7s9HBTVEWdPdLu6Ai14balKzN4Mm8XYQ0zPduympjYpyGHjbFDudDBCa8BNWtTSdZu+UZQ6OI9MBq4e0jG6pcJ2rCRWFFsqPpgVCpaaNXeTaAdlBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek1Y+9qRGuCcCYaW4yIG/8yTVXEXTBzk2PEmXAUBkVY=;
 b=XzKJtmLiLuCFAncc8mvY6grhQD7Ytnf5LEiq2jYZUipLhkb4Pl6+1MCOY9OA3ZINtAXtdVzxtgVqdkxSnpZ914bDKQgufuFEE/veAZzeB92WzxSDYD+AtITwkRmbUZtGhWRJ4SWP+MQwNQ/GcAcvLolqkwrH6DryGGWvwUxBDFuu7DmQzMIkGNBn5ST7R3IPATssWSb11MADrqNuwQK5A4j4JYpf2JagroiR9E2jWi5OD6bXBJ7V4Kh5qocjO1XfFgKimAAYtrQW8jen4s6gTwpd+3xVzrRCoujv5thAs00WbdFLG5sh6NsMT5IHTBFWt84h6kgFkxAfGsR5YS/Mnw==
Received: from PR0P264CA0168.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::36)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 18:46:06 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10a6:100:1b:cafe::68) by PR0P264CA0168.outlook.office365.com
 (2603:10a6:100:1b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26 via Frontend
 Transport; Fri, 1 Sep 2023 18:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Fri, 1 Sep 2023 18:46:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 11:45:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 11:45:47 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 11:45:47 -0700
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
Subject: Re: [PATCH 6.5 0/8] 6.5.1-rc1 review
In-Reply-To: <20230831110830.817738361@linuxfoundation.org>
References: <20230831110830.817738361@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7263a81a-a5ad-4f32-a5e7-0c41d0ba7168@rnnvmail204.nvidia.com>
Date:   Fri, 1 Sep 2023 11:45:47 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f35c81d-d68b-4619-831f-08dbab1bb237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0GgDgJOwwS5HnoPkJWroWsvKU58QF0TgTrFofyxqZHiiAQj0ePqDTloM1ESDX0buJI7vf3AeXeIVa/+Jo5VAD2mzdv5PstMj5w3bz+dcEY7wqwweGWIPxsnygkDK+6TiwEQbqlkwGimCUH7ntpQRdAIY43Ev3ODM33yh/0xLwn1OCueBJkE3Axvji0c9bswmrinoiI3IGXaE62K5nbL5xtLnN7+mRTnbBv1LIA+l0+w6SXkrMIlsLyxU1bXiufm9fyhfEMehzya9WFklkprd6zpY+/yDq2+52sM2TFn7Yrf8lfVVul4v17TgsH4pfMhd0ONCWA+dQSS0UxX7ceQD/dsdB059YE3MHgS0PoPFj6S7USvoDKzMvetDdA2XJxYdwJ1nBReqz0du7AfHFyCD4LN4IAd6K7e9cikplEViKazVQ9+7p7p7493Zp1JKCdOZvQFNyHfCY2xzBdb9ZtJuYHCglTHn1xsrV9mtKDHcB3f66HNlX9DeIaz4QxWVrvkilJijBNgBgAYvKlHmf5RXrf/iWxtXzMl+NvnIo68f9+nNk/qYxhTA36k7WwII6heq35xBxYxfU8K5mohb6l26plb2wlj5/mWqmDi1tDYtwky23kbX/3VB6FgxTeWaD6Fxj1L/8j+mBRjfpAE9+Dpr7PzI0yR2bFn3v0UxzUtDBRsMSjNwZMhcGXjfkpQExVPEA5iX32PWC2XcTo6iu6/+XQkWkkiGt3GZICE9yeohiK1PTzvJTkQfYu3/SCCYsDGMV1N4UZQfFVNUzsDUF7rK0TmBcItexJ2o4tHFBVt1HQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(966005)(478600001)(26005)(426003)(2906002)(7416002)(336012)(6916009)(54906003)(316002)(41300700001)(70206006)(70586007)(4326008)(5660300002)(8676002)(8936002)(40460700003)(40480700001)(47076005)(36860700001)(31696002)(86362001)(356005)(82740400003)(31686004)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:46:04.4100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f35c81d-d68b-4619-831f-08dbab1bb237
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 13:10:27 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.1 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.5:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.5.1-rc1-gc2d4e2d6c14c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
