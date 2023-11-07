Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91197E3B45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjKGLoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjKGLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:43:51 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8D120;
        Tue,  7 Nov 2023 03:43:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/6skI6VhC41gFg2K0hMoM+ngc89lSmFO27zV+Cb3ozWZFdUQu20GB7XSyiztaBiOeu5fy+VUHi8XFQiffaM6gTh/wb9S9zX1dFFrF4ypZsCYVuJvA7PuKFgs42eO1IpmIU5QIXxBI6cRj6dgDNJeBPeNOg7Se2HvkKFkE/VwqthVb7JVJFKWhEbVzG3j62/DzTRkrICtfkGG7bX8hI9XB5RKL1S/xxao9jF0iQ3v7yCt+BilEmcwdLfdbsnTcHdSbDxaJQEWGvHU70mPSnc5/QDwcmt7Z2/9b5fWlGMOsWLR+/ekguj8uPOUHIdWuWwyNBh9irCV6KIX7jWK0lbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5koeZjf2o++UPcFnMGw8CPyRMF5zyCi0+qv6dNrcxU=;
 b=dCAG+cm029BpRIsgWEcWGWasxWCt8/cPk07265nux7yrOWrzaT/7cThkb/KNPa5J2NTVxRuoYv8up93WEhoSuuCBQ/hMeulKs289BIFjWh4tjyK7+raL4Kf4SIe1QrMz+jcp+W7+ZX0VR28/Wj8X6uPvqEM9czsS2/i7TL50zmGOKVU1gOWRQTfUSoWhznCbTvvES0NP2QeHYpxPy8qDX1fEw0pbDOh+2XnfVb/pu3BM1BBjKoyc4W71P7lhuo1oZ4X7TTJFyZToSjH9y5aecI/0U6FOB+VAS5KqkvtS0UKLVAIxlFlkws9doJggYWRt2ndh14BmBbmFRET1NnnTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5koeZjf2o++UPcFnMGw8CPyRMF5zyCi0+qv6dNrcxU=;
 b=STkf4lTIwrX5g/f7aPRzbNZciTgVZ9czLAOZtqtV0BmWIGGTlZT/8ZIxpR0IRbepJ4VN1gXue22i+hYTDJrBQn+AWKmELgNq8OV5hb5KMpUwuBnfnpBkJyWeyZ6zgWOjtHMRBekYf1zt9mTUG4kbHOaEI6wh06CaRZfX0zlKYjFAzVq45JJoYxphyFHCXbIukU1atncbUhwF+3rHuYsFij3y9rzJMAmkPrBGfyv3fg0SnJyEls7ol4cVujog1fyTF8SrHxGLx0fsBs7svfLRkIL33PghX1BFy4smGb/jhU7AGfwOVP4oofT7iyxVYCcR5d+xHwuworMgrO3UpzDdTw==
Received: from SJ0PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:2c0::33)
 by LV3PR12MB9439.namprd12.prod.outlook.com (2603:10b6:408:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 11:43:34 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::cf) by SJ0PR13CA0028.outlook.office365.com
 (2603:10b6:a03:2c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16 via Frontend
 Transport; Tue, 7 Nov 2023 11:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 11:43:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:43:22 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 7 Nov 2023 03:43:22 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 03:43:22 -0800
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
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <cf5f576c-1e7a-4c18-91b3-f7f9c0e26166@drhqmail202.nvidia.com>
Date:   Tue, 7 Nov 2023 03:43:22 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|LV3PR12MB9439:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0f5664-9719-48f5-4462-08dbdf86c595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwXa9TadqrCQMBA3CHBBw5CM8QA5dsdYDmwc7aqZ3P8bpOKjue8219ZiIdivgTRs71/09VHUheWCkbznETtTBzL4/IQffqxmGRqSItQVEwZHpIw4CAY4Q+Xv8d2/tfxpDDTqsnUtdUL9mpZvunnM5WmWwlkprJcr+cBygQfWKZc035G+mge3yh0couIoDUKCghmvGY2qI2RZAZWb94QTD50yMdMY7Y1FcAABJa0aLn4qGaXush+AYjdnhGcUwGNdKMJpCkyhhHEBbvVqUxRyzT4/4Dwm/0zaFsip5A/5fhi0tJ+ymAlgARdexbiwt9VJbauXFGXmOEDxZEuOWH/wkzp/HNGA21sXp6W/cj5h1ARzcCt+ogJSjvj7XxFs9HA7QdN97TZgV7I4i7FWGgvc98+xx3TxiFfTtwgAT1XwVGfY4OmurZ76D0P5yeb1qcYoG9o4xWm/eF+MY/Z+rpsRzrZVMlwgbStgc1hECcIff/33in3TaUfhcVFNBHVTG4fjwPVOtd6Nw5uc82OCEqhMzyrfWuz33Rf7YmleIhXGoTG0l85FGl41UIysGv3etuvGKzl3KSYCsiVZ3ksiOmkY5nzR+nH5VuLL2f2VRmoJAXHEzkZE1fFyVCDGTW/YLTJBP8K7zjWjOoritaNAE5g7VDnUPhsMPRusrNkuxYf4RdhCa/wrRgVdI9EEKhl8WpZ1l0WqA8sKrVATAel4kKy9VLj0Cp4vjgJu3WuPXlm3Zju2WhTAm49xuV10L8TUoEaggaaZk6odXhojOP/4aza5OPbhZ7JMeCwn2ZA5FMBbYV8=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(31686004)(40460700003)(40480700001)(426003)(336012)(41300700001)(7636003)(47076005)(26005)(356005)(82740400003)(31696002)(86362001)(478600001)(2906002)(5660300002)(7416002)(966005)(8936002)(4326008)(36860700001)(8676002)(70586007)(54906003)(70206006)(316002)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:43:33.5156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0f5664-9719-48f5-4462-08dbdf86c595
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 14:02:40 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc1.gz
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

Linux version:	5.15.138-rc1-gec134bfabca0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
