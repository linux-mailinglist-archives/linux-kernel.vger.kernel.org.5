Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A188051A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376800AbjLELKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346740AbjLELK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:10:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263DD11F;
        Tue,  5 Dec 2023 03:10:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXGjHICb37c1qW589abljOy1Iou4TILAd/Tyx5+J5buBshwpvi1CLwbtLSL+JV+Pgrn9JA80ags7hGUER3Y72T68oeW8qh4+zq41nKmYGI0IHpIbjQqrObAehLYb0hgUr/JvWvKD3FjyXG5NzvUCBMRAkxCyoKPWOKwxQFUjUvjIbUAEinKl+ASNu+NA1pomMvnOaUBuOky0cR8y0txxy9eLafs8n8Dof/N8S9k0mzrtnkHXAmscDVkH8PQr7wpY7XKjKlg3esCOOvld7pF43sHsBcZ7xY0FY07IokC0a36Bf5mQUZrxpkRwyjccHJ5eGecTImqEJRT99F5gGXBylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxXQPG880D12yc+5telXmZCWxDDcSQdealIeOuy8/C4=;
 b=Fs/xZW+naUW0YWiMDaTpX/8XgCFN8DGTmqOdibziwsXQPrwd8ZTXaNPwUemUaWMzUrtQv88OgY6bctx5YjNLrQCN0TMK//Os5B5RbfobJmcZltY8ryxw95wg5PapJ7Ww+xNDZaFmpYXQQkSnLcCzwqsnkxxGf20R1Pw4WKT4QPweup0jSNAB5fBf/9YPYGY69iKVTRTle8yvUYGbPRlSKUC2KeuWNPzsthO5kjtTGW9etSQs6wu/W6ZX/gLP62436FZpwKYAj2a4WIn0pSE7igUEXLo+ArBE8ZBFjomi2f+t1Y4/B9INmKi2SwLyAkqMlel9NTjggjYFKl6Yxh0GcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxXQPG880D12yc+5telXmZCWxDDcSQdealIeOuy8/C4=;
 b=Xa/PozpOrgR/rFfrRUt8ZhAma2vfi7FSA7mlgMnzOxg23V3HBYmG6Xjlj5Hz1oNzEKOQEmnsZFX2sx6qdI6trMmG8TqBn8Loa2byXs2nQ1lYFADI00Avzf8+Fin1B52gNIdglD6qOTsGDjXvcr2jDCc7D0qXVYPMI7RgiWUKjr1tJqrsByhQwnJdMEzTMOig4AALt3zGK77Je7fCIMTMnZZCiGgrhjPEg8D1imF+2/YUT6HZb64tt6yLcaKY2n79ry+6Mbp6UVKxNNxtGdAGDDuXUTE8ZtKwjGp6iJzPEM1fceQxAAG31xVS/m+n4OsQnmlqXihuC8rCLCHwCNVP0g==
Received: from MN2PR08CA0011.namprd08.prod.outlook.com (2603:10b6:208:239::16)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:10:22 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::1d) by MN2PR08CA0011.outlook.office365.com
 (2603:10b6:208:239::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25 via Frontend
 Transport; Tue, 5 Dec 2023 11:10:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 11:10:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:10:10 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:10:10 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 03:10:10 -0800
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
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <2034a732-37ef-490a-b0b2-05116709e99b@rnnvmail203.nvidia.com>
Date:   Tue, 5 Dec 2023 03:10:10 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: db28ff4f-869b-483b-c8fc-08dbf582c689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wS3TOhRJ7fyO4hYhheUV2KkE0N5b3t3Ghpjq/XrUXYzmQMaq9ca70QguioL9V1vcqrL3SDkWPikFm1qSYa1C4gDbqMrpTw1gy8BPL0/NOCXkCqGfiOYMiK8vtTuB/7KuLFYPR+swc1MpNC619upvWDbp4Knbyr9k+0DKivANtFtGd5ALM/RtDJSTf8AyRGS3NENFUSyx9rulXUa9tNdahhgZUecSRYDpytc4go3zNThEHdLOGOl9ndmPkGRiXXpTdhBwdgupeUmMDunZeUfbbxpnsKewLN/zaxAqB6zqA6DRKDq1FXa2sUYM/svs3ubfl3zsLbvV4SKdD0gOCtZnjFz043QPlSvrPYBry0UJE1l28vaw70SjRZ1BFpwYJGULjeGb+/9vZ84hEORkGLTycSUedqB9zrVThSodsCeHtnzdlVfdJtS7Vy5ihP17POOxQKqlWOmQAo3veVgr95+cwhb3UkyAczDXtZ/ZaixnX3DsrMjZ5Zq7pG+MQkSEyUixSA4x0sXpLNLH04FfGYBNbqdEnAH2Jo4Zo2L/8PB+xnhZRvrHJrhGMdv9tyQBqVmg3W800RShu82ya1bjO4/aGrJfSdtgGFTTHnC68l2y8xwRfOsVh614+8JchVXO/jAsg53IIkXwwCkzOtT4DA1HThMrSFA3va7arobmjkUBl3pWRbiaOIMAqDcpTMdjw1VZ8wJn1irjU7ZS++gSaI3D6acl8rkzcV/AvCbG+JOF5F8gkKqRQYAgCJRl9czqmT1XW8ZPyhPuGSdb4VN1poy6lskz/IxKIUuDFnTJzUemKb0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(478600001)(47076005)(356005)(7636003)(8936002)(8676002)(4326008)(70586007)(70206006)(36860700001)(54906003)(6916009)(316002)(31686004)(26005)(336012)(426003)(40480700001)(82740400003)(966005)(31696002)(2906002)(5660300002)(7416002)(40460700003)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:10:22.6498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db28ff4f-869b-483b-c8fc-08dbf582c689
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 12:15:35 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc1.gz
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

Linux version:	6.1.66-rc1-gc1e513337d8b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
