Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45C077BC09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjHNOup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjHNOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:50:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82C18B;
        Mon, 14 Aug 2023 07:50:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8tpPVKrRwSPyFuZ1vr1uQbgRB9KxjbJMihsH0uziZFGimBAbA8AjSIH9P4XuqeVRgkdDsZeBEch7jDYzVYeXyVWIpTXwhFSggXjRLgMNCKzAASQYaK2TQCnRDQ755/yh5SFLL+fiKKr/qP1kS6tCgkuYZCWEvpuYjJbHi7A779gbTjSbEtVqt9N090Tr+XL108IxIz2Y9Ogq9c1wmctOQc7bCAlayqoKMd5U1IjVqZFvPeaHTSvya5Z20/7qh1jfkAERNYrbo+lPSx4t8x10HGUa+5dKkM+1OulH+H+eRWjqdxNMJFKFAYvbp02FjPpNuOMRuCTfxwrW3Rsvs3G5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdLsmRF7sPC1jkNDcw8n9o26ocOwqBP+zay9gDrsc5Y=;
 b=CMFF0oWqiIj21f35+JcB31C3IFpuA1/D22fJdnXmrWYnO2Vh0N/A1xX11fDjPEcXOPJUFVqgzWelzk/dsuDq1tJ1acM68uoZho486PopHroPaH+/X3Y8rMAW5ZQ2fiKk+jDt7k/yvSJ7dXuVX2LsKlCLrR2ORJEbgXYwsK3LrhZV9TpkqUsh/zAMfUDlcB/+nF4zrBbZ2GEMRBitInwvSFmaHpyvpDEKMsXAfWXff17iwAb+pVI0ItwciJiFdYGx+QOj5zVG1cvBKIAStjkpoDhsFWAajQ2nc2OXbCre/p5u97Gw7XLzIDJ6vjVfbbEv8/Ik34a7TSX1tHbb9zdoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdLsmRF7sPC1jkNDcw8n9o26ocOwqBP+zay9gDrsc5Y=;
 b=Dh/uvMnspDwtIY9SNN/sbTVhIMgbUyScYQ1eDNVgGWukgmt9cSxDv/npKmBOF9OWWVlkAX3aqjABAo85EfGI3AVxBK0nKg6zg+4ajM2aTq2lyobH0OLjjcKdByXBjGJ8/kKuMTulyYRWSbGqOuxe7hcihCUjhRoXKTpWd7ILKvdEJcYPpOCgaA46TfflORynuoEiPwc8YZp2tBQNM7WAczo+oB57wkLrBAXFoLiL8CeBvW/lLGwzTe8Iro/WC9EzCXY3Wj+5TQhvE0L2DxC1os70ehjCnk6Y13raQvrBlMdl9XnQVHZ9ldMVoRFb7RRJq9WZgOTXmfmZI/zxpGY4Ig==
Received: from SA0PR11CA0045.namprd11.prod.outlook.com (2603:10b6:806:d0::20)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:50:22 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::c5) by SA0PR11CA0045.outlook.office365.com
 (2603:10b6:806:d0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 14:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:50:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:50:08 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 07:50:08 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:50:04 -0700
From:   Thierry Reding <treding@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <604ae3d4-3dd7-4d3d-b021-9ff390300021@rnnvmail201.nvidia.com>
Date:   Mon, 14 Aug 2023 07:50:04 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 953097ef-3433-423f-f525-08db9cd5c939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYuZs7qsT6tJrDKqAzKStGWB1LjNXKiyMksuuzPLgrrwP6BALoHiA+tpRVk36yV6I5rjbGlJwrkKFqvIPhrogLRkuhYttYUvosyN5Pvcn2pAlAXaLdrnp8aSTvRvSDeGpu2dRmhTCVSqyYIFc/aCI/F12/1ItXWnOnLKlbf4qKk445nojkxHXoFrm46XLHHpSofREge1av23kwM97HFIwScwlg2A3we9l3X/JLVbWcNEScDOCItu027pFW5y8kP4Pz11GcnAZzbVubrCUpNr/J6F4dt3juUuU5csbdz6uH9jYwWhg3vSnBIv5+R2cpe8H36AHvPyM+cDgHPD81p+cnN/961rnmpaYfqO70Lhg37GLR59D14VvIPazYrHv43sw5w8f7WqGVvTBZfpZRSb/fPkmz5vvpxWhPqFxapOoyxS0p6lg+6iIYy0aPn4hmqOXX7TqXZKvi9Y31IhDqqOjaX01Np0cT9dF+z5gXpcqAHxwQaMeIOuefZyPfYFtmtaXM3xVkgEFhOLDkb0TIlLP5iv18lldIP+dWtOdcAgjmaDF7/KtbIroXoG5qm1GbLsmmzqRrW2BrLP9WC2PEL04hW+6dEFBS5JCu6wbx+5flRgJrg3HsVK4jD2TWnGgrk9PDt/uNl769dcL6hLuHKVlJfqW4cz0t/Rmb1pPVirlLXNC5tpvKUCCmHMI1Ec9CAZP7/uDOKxEpCpB+RAOumvuY/zAUdQxxMnJHIbeZbmnq1qX+2qUFHHW4UfvVxS8vjuh6wpsfEQF5k913U7C92ua9bGLpK4q1UK6gXqXPIVJGE3ccsB9lO4swfvRHm2OlHGC04wb3K2zKGxxU5JJK7NuIzQ+ihhvjjYwgn45CA6Lr+33uAJ5mZ1Lx5JpQmaEpCO
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(82310400008)(451199021)(186006)(1800799006)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(110136005)(356005)(7636003)(54906003)(478600001)(86362001)(31696002)(966005)(82740400003)(41300700001)(5660300002)(70206006)(70586007)(316002)(4326008)(2906002)(8676002)(8936002)(7416002)(336012)(26005)(426003)(31686004)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:50:21.9636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953097ef-3433-423f-f525-08db9cd5c939
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 23:17:25 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.46-rc=
1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-6.1.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.46-rc1-g1ff6999c9334
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

