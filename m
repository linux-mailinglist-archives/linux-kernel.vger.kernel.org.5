Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDFF7E3B38
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjKGLnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjKGLnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:43:18 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4534A120;
        Tue,  7 Nov 2023 03:43:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha+Ulxx+Yin4PW+jSjDpkVj4ZqMmiVZeJy0+L+Y58ovNUjl83mYGKXJp0fTAwAvbE83s5RgAxAjUEpISWrEOzXO4fg2QL/BRlUXXj13iTmzAdx2i3Jrq7Y3dO0EMWx+YqKdqo/++s8PyCTBZUlDRRAzm4bD/xGBOU+SK46Mqa2wetA2l326Zn+hRMR26zrfBnmhZZgM/nrxbgYL71B+KbMjeGp6jw7EbH+BbVbZsXkK0gRqRzHo+1SD17N6eu4KWIIXmkSkyDYmqb9Obp/qRoi1o2SDt5NJ85xrDQc7cMyrheAjUuhW3uW95AGJMy4yUjuP/33+JncB8HdE8bzulhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEc6hzfB85CkGKsRy7pDDZGpGerkwq+V5ovZLngUAB8=;
 b=QAKL0UCRM31XHdSjoaIMkkqkoWYznYIkyzwlx+f7ADwztEHPkpUK2+iADk3XFz4uOG9MYMTglqiv3uaspX7K4wMNgqkB1LdUnD61GsyTR/+tQ6W630yNPQV/DWVyC4YPkbKp5VdfINTIr/6sNwHFSB6wcRkQvyaD9l5ssWLm9ckTGgtNQTkgYIJiqRXY9qMvnQbiiBOxsuThXH3SYCyr1pjEyJxAFTvjo6ecxerV9Kiy234lgzu4WFjChoZQVmmyj1YTa7aP7SuJxVjjN8j8REzy8mLgWhufTUKta4WQ39+hiYCqYehZLzZbnBokCvT7CRb/bhT96r/DK4dQNW+l7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEc6hzfB85CkGKsRy7pDDZGpGerkwq+V5ovZLngUAB8=;
 b=NRPAPFaqN1NJE1illrkGSPYXKr/DGnBn8bu/BUjszKAbK7/aY+/szs5kAOFZbFiHNPQrClynhJc926Zc7H0oxvCYPqX+ul8n2ZtMEryal+FONCVgrXHN6su6w9YT9MmR77FSHnqfJzavOOW8TnSZCr/cIisZN+O4iBe56dIpvoVPdtfPhTsvTuzBR8TmrFouf0xoQU8eOxchYlQGDylvBlemDNWDj4ci0FrnWHMhAmsWXTGGYzgp2hSZyDkSt1ZFj6Ie8bCqfO21Wd44u96yU5f4mkOzKtX84by/R0M9UY32/I3irz1RJEryf9jibu45FuFCCm6cHHyqdo4/MGJ3gw==
Received: from DM6PR08CA0044.namprd08.prod.outlook.com (2603:10b6:5:1e0::18)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 11:43:09 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::62) by DM6PR08CA0044.outlook.office365.com
 (2603:10b6:5:1e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 11:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 11:43:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:43:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 7 Nov 2023 03:43:00 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 03:43:00 -0800
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
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b45d5fd9-3571-485d-9f19-4ef966025d8c@drhqmail202.nvidia.com>
Date:   Tue, 7 Nov 2023 03:43:00 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|BN9PR12MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4a45c4-cba3-49f8-116c-08dbdf86b6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZXvJ7SzBptEzM1YDNWAJuE/5liXbaghPuoX/yRx6bI63IhAfPJGil8FqU6zJLchpe9IgD8Uei8HnTf97PBtZBO/dvv5OgWd8DzbJBlOEf/fldBnXPnGjlQYh2vHOQBPYfslY7gDCakMYOgYjekfDaL6CHk4sPlp/4xi5cc9GrmrVfUDtO52fpPnkL7J46Q6lLgixj/F85z2Ql9gzWZXkKeKh1B2KmfA07eeWPGU4nn6y98KxvMbzO1SsbEVD1k2zVpOWgwo1noYyguI1+IBq7VRWuzdD/k9NQtKBJc1ZfHJ4cVloXoy78GLPMhIiVZpnbF0wEAfFtiBD3fHfw0QMFbqN45VbdRWVo2+1E8duANfVzizoLX5t0zYhXPxDqX+oRBGFKfODaOQ+3zyM6V/q82dnd/RUvt1kczK37XcydTvf4IZDM3rbkMdj/cwbHyANqGipSvqSLgv3/dMER1CLk19BRRfuNLka6UMNwGa7LFOYFqzf7ytFsO1wHxr9v4DTf5+62I5Xji+wdrswk6eBEl3DpLt4zdoVUKQQpmTPX+bzDJIkx2fh42B3Cd5pJ1nBudIQLc7RN6Lu3W6oJDWp+8csLT+vREU/wKVtGDVTGHUmNuhhL8NOuqfwJAQU/UbSFqk1FeB2CJvpNON87feNBKiOFP3Zj0G9Q+iB5dVXeKCxBk4+LffHR1ZFOhRwh6JG8QIjCYzGHBEu3svIiXIUmOCEstie3EWqiSf3L1z+LmE7kezEXTbNwXoZwDhVSih06Ttr7l4cJzSSxz1zFTSGgUm+hZlHtUTeczXP4bBshg=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(86362001)(7416002)(5660300002)(36860700001)(40460700003)(41300700001)(2906002)(31696002)(7636003)(356005)(82740400003)(336012)(426003)(478600001)(31686004)(70206006)(70586007)(26005)(316002)(6916009)(54906003)(47076005)(966005)(40480700001)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:43:08.5778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4a45c4-cba3-49f8-116c-08dbdf86b6b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 14:03:28 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc1.gz
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

Linux version:	5.10.200-rc1-gfed6441dbe52
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
