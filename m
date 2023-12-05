Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49B68051A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376836AbjLELJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376795AbjLELJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:09:27 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709DA116;
        Tue,  5 Dec 2023 03:09:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvQuB111s243+FqNy+ZeN/ASLIuJqQRUKpc+BojMi/NrbaBWriHKBrsqaXQ70QFyG/QzXwjcnvIdhXlBZKpAEbF4lM8/ItDP0XDWklM+kas2z4rYGwYXCisRMPAP6bJQcOzmP9xOWEq5HQO7CtVGTxJojxwTCapbR4NHkLHPSWYIRADoBEcbl9ATHyEMwuY++A/AdPXvSYbvTbgHzAXtumSJHLRozFR9ADRXyqqi/9TI3eExLaOimvtmNOLAH72bafPoepHdF1J9iO8DjH6zqQwjBoMFqDYnmOWsAQfQPNdJiGknroN1WjX1B8G1UaFM4sbEvy2lHqNdtIcBOAPZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x42QeUiLIkdu5+RXsW9dJZUf0jDoIUVn84Kr1+8PeHM=;
 b=GjHSW27yeYKxZ4Ffy0//+4UamtJ4vPVOz5OJzvEkmq+FlWXA3tUa92w6qS7hnsJ8qYoKmfvYcaVlh0S+6J5xswxCqUjfHgf3fz/afQW8vGxcIWxwnQ0NK/L74WQWwddcNoBEvPLD/qaSv610XBIu7SaM5it4F8MZ6wNC8Qu94uQ8OjmAqWfL+DdtgV9AxmJYWNL/1n0b73Nqqrr1FidcVQx/KgIDWHEpdH4ACPLdpEU+qcoz1QERlaCAV+uGEeE+KnYejbyAZzJj6TZtJgOlDktzYqSuCCMohGppUgTGnwbE66sZX5CDAVXmy5lPz79NHTIJ1lqjcNyRbkPex5z56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x42QeUiLIkdu5+RXsW9dJZUf0jDoIUVn84Kr1+8PeHM=;
 b=QQXB/zmu7yv9eL2qOCKRVNW5Oro/50BIpZl5T35YPTfJQlk1JMF0J5NCOJnn9EJtH4t8zljFk8l++SZtHN1xSnK0ldS+47fQGOua8TInUjcD1guoqBKnVVEkSWdosS2go6lzbbnRRmkRWuKMUFC48JQ+YhtwloRXi1boqo5rnOXTlvUUIftHDYUXsu5U5Tm409xc6uY1VXAb6HN5byj/Y7v8za/wcvyBAaIYXglvqFt9UyWp5UE7e52Q9iBsTXbhnAPUxVjoekv0NapPLPN6UCOv6Qjl8POA+XQhDEMnSKj/DeC0iAlTXb9/icRAyEDLIH7AX7n7YpsczGYYCz5Fyw==
Received: from MN2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:208:23c::10)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:09:29 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::ee) by MN2PR18CA0005.outlook.office365.com
 (2603:10b6:208:23c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 11:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 11:09:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:09:16 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:09:16 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 03:09:15 -0800
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
Subject: Re: [PATCH 5.10 000/135] 5.10.203-rc1 review
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <14426591-92fd-464c-b02a-e702de4607f2@rnnvmail203.nvidia.com>
Date:   Tue, 5 Dec 2023 03:09:15 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: b47146e5-e0d6-487e-4ba5-08dbf582a6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWptVC6c/ZDtroloS0Sy1aVN6x2o5FAg62k9kHN/SevrbYmXorDVF3bI3MS3aT7GjpGrIVH4x3ubLtNsUtkOKsCX1FLaK0zG965+Mhpmi8HRY5dTpqEiwtxcxMmKzXinasAU6VkNHvVuzQAna10x343mwgG72gOKj0P9ZpeaM85I0lKjGk1pLzzAeFPqv8+wF8sIVDEQNh3JQqhfQpCD0Aij02s+zJKA39F/fa4uLaDI1dL9z3PckvJvDVKJpAfgZ5DglvW7t9MxesBF95nSt+aqQvjzzg+CwqxTUw3Wi07TpdWh/tpka02QWWeCYepd7LQ4As8L9C96a4pbnx3niFOl+rHFEEddjd4GNFBm0aeo99db121mT34X3TuTjghPtB/8+UxOxPaV4UNEk3If32ZIsD+Ula28fYj+Smyxa+GqHG0nNwD+aj9JMQ0tZBV+9GNhbJcuzxmnu7qPucCuuUXdggpZu+ziN/8yG5mTmiMqtG1xpTh194SydY33US5oYWSsIvsWtmVve/x1JhrPpo10Z8xHPG46wbgJhZn7qhfbu/jYw22WRQmRh9eMHXSsDaKASwrdoaHmOxTauFhJYBX2d1gp7Fji4wIuGkYX8c497vqvXMxzOxqdP3Lw9gLyB2ZezZ+3iLQfipH9dHwovh4FIXEs2cALlRGY52It9Qt+DFQo8vrTs0jR0XAx3wHx5s7RJ2dUFftfC48FvYifGnYMNW6d2/RSpyX/8n3hNhon6dV+FA1fE0Ns7vulwADgMF9Ydzll9jKjgx3DtlP3NtBgMTYdC8ZJ5nQNEtXF9CQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(31686004)(40480700001)(40460700003)(36860700001)(356005)(7636003)(7416002)(47076005)(5660300002)(2906002)(82740400003)(336012)(426003)(26005)(478600001)(966005)(41300700001)(70206006)(54906003)(316002)(6916009)(4326008)(8676002)(8936002)(70586007)(31696002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:09:29.1914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b47146e5-e0d6-487e-4ba5-08dbf582a6aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 12:15:21 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	68 pass, 0 fail

Linux version:	5.10.203-rc1-g4fe324b75588
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
