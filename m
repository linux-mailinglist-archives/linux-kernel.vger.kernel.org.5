Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B68676E4E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjHCJsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHCJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:48:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BDB2D72;
        Thu,  3 Aug 2023 02:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDqOKQN6nyNvGheKBwVQY+St3NzFhEtxU0wjuRJCH/5JQjM0GDaDHsIZyFrMrDfztGSBE3Pf1t6X6PGzbJij/7WHDP3eyjgJRZKsfNqz2GFtyNG8wChZ7m+yn+2NlvnHK9pBFXpwFZLvS1a96nDEg/VcPA81i8Z4kNYiVO591nqvXCo7OrCQoiumibn0cuaXY20f23Mu0xS34/rpbKvjpFgXB6ebMslnaYiuBmBPEW9cyBlOrZAqT+Cm36L/dHJY2crtKeLVzSGhSmMoYaG1ST3WmSfw3XIQLb0729iFqmoYfmrzOwxaw3rJM0LigyIcbQPRLykL0qaj6RLsDNKhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJjCvtghbRxDCBsk4NZFoxSbiD+y8jICmhH0/NJWfqU=;
 b=fVz9ePwe89W+nbKu9Q/IZfFFPyRXLO1oAgT2I4JeYHE6SgOpHN42TZqTDS/NvIO9qC/BPLJ1YLbXhD8f7CLnwu9n0yll9dYCceo6oybBBJPzfLmVvYWY7No3A60/GdR9hQfOpiOym3s4NtneDo46SRj1i75dYAAFzNggk3r3ajIxjOOyBBpK43peMDUx1bTkvjhMzdzfRN4nbxm8eH80b2HHyXd3BVUgmgfY5C+wovVL6RyQHaZoGECznjRzlkAhdRWqp6zDM+DqGRDGJJiJ3XNOJVrkMRIIOgjAJHftBcWGU5dFPEYR2Af32lXB8d7AQYHVNlR20ScFKOsa50aPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJjCvtghbRxDCBsk4NZFoxSbiD+y8jICmhH0/NJWfqU=;
 b=qEPBm6/Prp8rh4QjgGW5NnoX4V8or9w2ILer3nBWROxnMxwJl4X6INvFBEHqX/noUI6s78Rlk3/rDrDZb+vO7k8XLYQVa6LbTJdKkEG+s27F7glEAqmOwgf2ikM/8OXfVWqsDA5nPkNQF+6Q1hzDZ7L8lRpKFljHB9I8Krh7/k+N6Ydc+yKM6ZVbmp73A6P9uSr6VEac9Jv8cVwnJ2hqKKl8KKlGGP3K7JAp///OEZbYFne+yNv/ftoEBJ7nyB76m9q0BnuvStyg45ZiCVjTvStP92LV+ULglzhiIRapxcvUSGEazGjn7Eg0jmxeOhgnHGk7nBhU3mbukJrjeiRqww==
Received: from PH7PR17CA0042.namprd17.prod.outlook.com (2603:10b6:510:323::21)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 09:48:30 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::28) by PH7PR17CA0042.outlook.office365.com
 (2603:10b6:510:323::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Thu, 3 Aug 2023 09:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 09:48:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 3 Aug 2023
 02:48:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 3 Aug 2023 02:48:22 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 3 Aug 2023 02:48:22 -0700
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
Subject: Re: [PATCH 5.15 000/153] 5.15.124-rc2 review
In-Reply-To: <20230802065452.161574662@linuxfoundation.org>
References: <20230802065452.161574662@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c57f7495-9c69-4f12-ad82-0f229b2de45d@drhqmail203.nvidia.com>
Date:   Thu, 3 Aug 2023 02:48:22 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcdd273-b338-4ccf-d5a9-08db9406cb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+UMqC3qvLXfwg1lpnmwqjAO8146IAwqM5PH6Kht+9E5v2bGVnwr5TzQdytzGCBiN3tI3g5Y5q+J950qmn0bQ9ERKyIhHupnGjs23byXVBtbGa99jz2vXA3X1Zl+SqhyburVGKXw3Uy1J8WQZF8ZsOYMgaFWRB2P5y9A5xHl1GkW3mkGiLhceQzKooEvAEvGxkdS7TBlg320+65LMbiungnkAcsYU5670JmZkNozDtFIKEZbVRo/FWu7Z8Axw+CPPBXnsqjF0a+YzgdSKgbOw6Gf8JwvPyfHXXwVRJEtHGrp+9EbBdJ7PhPanzuusMVSI4EJkZE6RyhcoJVZiz5GQ0JKrPyXz50Ni2By5eTVko7D6RWKxOu9L2XiIjcohGfkYcpxITv8Q6etdShSPZVkq6DEtKxiIHYGIcPtglMrOTJBgN82+5BsteDC1mS/18/lMnd1n36YWd3kmjHjuYk6/+JabfuOHFR1MWqHVSk0E6Qs1Ttn02e/mp77GmsK7scxksqq6aoDG2GnQ6V5HdxK7mYcbYa5bLL2I9fDEYwh4v+7rPj/Bx6RW800e2FbnB9YgS3ybKwPbDkiktHbHhMaj9ZrVuUmeXd34QF6I61V4GIWa0C+HfhDhfWi5oZBSE66Qb3C1+oKPAwFW8VLmyRtF6DPtU5JWsTm/5c6nRvC0NQlWhZCYBHWUq/53gyfNVWWQ+Qmb8hKflP1tT/yneKa3nd6Wiq3DLpgC0TMqctOTW006u46NhVZRwcmPUhxqO48Sf1uXLn7qrvnRd0o4QAQjzpnAnZV5myk394IUJuOt/I=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(40460700003)(426003)(26005)(186003)(336012)(47076005)(36860700001)(316002)(2906002)(70586007)(70206006)(4326008)(5660300002)(6916009)(7416002)(41300700001)(8676002)(8936002)(966005)(54906003)(478600001)(40480700001)(356005)(7636003)(31696002)(86362001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 09:48:30.4511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcdd273-b338-4ccf-d5a9-08db9406cb5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023 09:41:43 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.124 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Aug 2023 06:54:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.124-rc2-gb261bd72eeda
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
