Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371657FAE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjK0X1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjK0X1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:27:34 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E30A10E2;
        Mon, 27 Nov 2023 15:27:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWEisRMlAuPxjV5OLOlcJTumpz/GSZ1oIhCGnAPqsKa513OdSe/c4rgbOoh0oXxibuK8RMCW9Q6nld2mVaD3PlHDzXOiKmgBys+MrbVudtsFhGbNVU1Q7qmd9G6b70rOhnqVugTbMltAImoDppEKfJp78JI5pqohVy1t+lYjg+aKK6TOd3EZFlzPyJSxI5dhcGFVxOR2UDl/ghYeEzhmhoPbRBZc+0ivj61fjNUjejm0c3pgjfcK59vBHyltPpxxjdNS/oclOSMVGPtO7AWZ95avev5GvGnCgvpcEBmh4C7HS36ql240iRVQBKZv4RvEhba2JQPw3eV+RyME4sp/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rNogeLukH6V7KGbz1F5sKcNvTQkRz1qgRIps/f2Nt4=;
 b=hCZ+0+9rpTiIuZAxjKZRqIzw48jCoeLPZB9pKRFJQEJXiAGSa3zfnzobkFlShu6704cSmkMm/HezEjHiBW5KECapmRlFoEhQv1DhT5CVtjXLBTckVVWwH4XSoFLDN6SKCdt6W1udFJ4+IfSnXlGiEQ3o44ABBmPZszj1C3E6qVRHBZlEssKRPDCl8wftKI4C29GlY0+SMv9M5+RzekIj/lHCKKV3X4xw8AfZgpss7luJBAGj+05OKumPHy0Mk9uocxl1V2b7WXggfQNOiK49XFTWJ0HgoNomHAMo/41kH+XWOE501FIcgMAnjSzLbAp7QhVVFPVN6JFIHFbAblXNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rNogeLukH6V7KGbz1F5sKcNvTQkRz1qgRIps/f2Nt4=;
 b=di2/eESRwuRZLsn4OogzHb/XWdtHsJREtNgM/jYT+U8gdxft4rg6wj2nXARFjLevcwNH23dlzUTb7qsEYU+gvEdulgF9iHfLOclEoY8WbeOr+iKDwy3O3XEuby8BQ4C9cdat/mRUa2AQGfY09ns6PORsMjxRGG1UbKtnrnCLlhcjt6GL/p4jOSGwYu3p3D4G5r3y9jxOa1BKfzVAFeLh5bGtWQvUNtozsxP8Es1vn7kWaohZ0bfHGgFzzt4AN/MslwBQSSQc+FYNceE4mcW2AFCOCnicI7QSQB4pTniY6Ra6Fn0wAm+tzY00VhRovluaw5KMEvTjPXtWMVuklcMDZQ==
Received: from CH2PR19CA0006.namprd19.prod.outlook.com (2603:10b6:610:4d::16)
 by DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 23:27:18 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::2c) by CH2PR19CA0006.outlook.office365.com
 (2603:10b6:610:4d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28 via Frontend
 Transport; Mon, 27 Nov 2023 23:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 23:27:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 15:27:10 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Nov 2023 15:27:09 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 27 Nov 2023 15:27:09 -0800
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
Subject: Re: [PATCH 5.10 000/187] 5.10.202-rc3 review
In-Reply-To: <20231126154335.643804657@linuxfoundation.org>
References: <20231126154335.643804657@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <fc421b26-ed60-48fa-a2f4-0fafcb44e91c@drhqmail201.nvidia.com>
Date:   Mon, 27 Nov 2023 15:27:09 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM4PR12MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 749e55fa-c6da-416b-53d8-08dbefa065d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R//GZnU7N4D6ehcMgaPtZYBwDNJQD6Tjv7JsxnMn5PhRd1xsVW4AdE6pzMy5zwoK8QIlt9SbXgUWBfxn8rT586UWPfsrC7aIzV/1BDKpYFQvqeBTHA3PIAvpNflABVfSg5JqqlVO/ifIDKhV+QmBeb38svCf1MQDyVhTXas8/Yh08nG7gDzydy3FibKM0HwP2qat1a/DglI9TX5I6c5t5sPtpn0HAuMdKm40fAINXyZU9XvpH57Vyze6GGAYYDpssjz4Cle3p3tqwCNq4+BjS/glDYfwiQ5f2WmhNF/hk5z8pAZ1FrR6P2olaDKj1+7aBvKDbrI9pa+3Gtmf5MIz3CgeG+bCrblC9YNFmIYkeTTbELBvbg95pXdnrPMp/nNwMe7pcolEInGzlykM1k7F1tGF9LyzXWUzUkyxlESA1NOxN+b3F8Q1/RohgSyOEERTH8jezGnKtGZSHsYWRWQWOB/ir67f6sBUvNDP/y4gq48alpG3wPlXLErq7JI3ok7+q2lSPAo0NBtTrlGOr+0G8zQRSJDfa8NynJ4hodbKH25S5gq7/j6H/NbULSW1twULXS0WMCnYlu6vd5QzYqQihcDn549/e3dh2nEsXOmZrukhb3WaC3RGIzDFh5B1dohpJlvKiSvBt6MRjcwdR70ebrTUTULs9A/kuH+OfscQ+wSxXKTYR0gqz4Q9UqpuPgck9hLmU/j6PjDr0N+04rQijDth9GiwXV4nk+I16mTttTiqrpOGIefu+xzn/Lye7cUes4fnWCZ75mPegXVOhz9rXemDhZkMHYx6YkNaeXDhOXQ=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(336012)(83380400001)(426003)(4326008)(316002)(8936002)(7416002)(2906002)(5660300002)(8676002)(70206006)(966005)(70586007)(6916009)(478600001)(54906003)(36860700001)(40460700003)(82740400003)(356005)(47076005)(86362001)(31696002)(7636003)(31686004)(40480700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 23:27:18.3805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749e55fa-c6da-416b-53d8-08dbefa065d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2023 15:46:55 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.202 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.202-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Failures detected for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	67 pass, 1 fail

Linux version:	5.10.202-rc3-g80dc4301c91e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra194-p2972-0000: boot.py


Jon
