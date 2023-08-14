Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D074177BC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjHNOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjHNOzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:55:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A12183;
        Mon, 14 Aug 2023 07:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF12mdAlNv8vvvPRQ0xlLPGbqQx+c6aDqZurz89Vyau031uYsjz5kGl8TXuLOdLKyRofbOVdd2E0vVUmWsAszu2rtHtSuqi3zRcMKxl/fgvokFMBsHtcAHHQf/x5uEC3QjS5JzGvvDS42/zzq2w13Rq7ycomaoM/RTzbxCtljmMg44m9bg0X9/suA98M/EJMMyeDtJbWCR+WYcl/StSGMs5KqK2J5ZmQhx6qYANnbt/jLOAdiWVRbY40lUuBb1hPRTStl2U+HrH4s0yPrbtleK/IPgvyR1Iwy2wTUiiVst3IOuJ2sL7pCD6ZYS8jU49mIUJaR5Z7HUP90tk0JuutvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctaEZZxwNkLxppmX05kks1kEcurKPD6MAiMEbJIS+cI=;
 b=hH4D/InEARKWsm76F7hadP9LuhDx7V1761SFr0zi2fTG+vARr0zVpCajPYxe90vHPwxbmzh2dE+51uWDqUc9R9MMQRvoiGQAi4BXJYYcnjFi4LQgalEGIHPD0hYto+tzmmlLgo9hilp0AXZMaBHioDP1ZyFtaw1nhvfy0ZT2g233P9qZk/Z0SpoQXVKxsylaL3C+kUBpI7eQhN2Sn/OyWTIyl9RjNnotucwo6wLwkgZDi+NpRfLoXUQPTEUQscEEjE/dOqhTq2DbeisiAyEjv2JtGkOcWPyJQq/99OoURhLvqVhOxd1nZO2xkwQSHtjbn0PDPG3hpD+odlJMXuR7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctaEZZxwNkLxppmX05kks1kEcurKPD6MAiMEbJIS+cI=;
 b=JasAo7JjOh+MA9zJVsDmCa07B+nX8eWog1cofNkRXEBkMbVctcbeHwNW75uStW/LsuX98mr+C0coF4QEqWp6Qlo0NTLA3nPKrFy2lwyk1TPAIc7rZifGTuZ33O2VNA8l6N2sfgNMdwd2ffpaxScYmMsOllGg+7K3tcbfPKWCrD8OZqbOqfe+tPtzauegRe135x6j5w2bqzGrnCPD7esZJlqH4Y9AMLxG+YV9URtiYA4lV6TDzZeXg9JDrYTBf3xitW3mcgD/XLVu4S4QV0oZlMIrrYK372lpbW3380ISY25z6xkzRpG9lJaYggm4OfT4SThP0UtP30mR+LJ3xwVTkQ==
Received: from CYXPR03CA0091.namprd03.prod.outlook.com (2603:10b6:930:d3::14)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:55:04 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::f6) by CYXPR03CA0091.outlook.office365.com
 (2603:10b6:930:d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 14:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:55:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:54:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 07:54:57 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:54:53 -0700
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
Subject: Re: [PATCH 5.10 00/68] 5.10.191-rc1 review
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <b8e5ccc4-2ac9-463a-b654-c5fa27353a32@rnnvmail201.nvidia.com>
Date:   Mon, 14 Aug 2023 07:54:53 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 62066ecf-c212-46f0-4fa0-08db9cd6715d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9tarbSWF78jNWjbpzMAvb5fOHLRC9A0hJGXf/Do4LTu7b9NCMs/f+FR7jd4CCD3B1MoH0NW4MNEm3stk8YeMKboRLRiUTjmJTFJKj2UIeCbIscrvI/0aGelfJ1oFc+Nmkvu6f3xSmtYBB3hlLwyodctWnaoxRsHm4Hmtqa/yATixEz1YIcoQWVUoYJMbmJJg5FPdo4pl/96QGnd2+3NTe3UxGlDEu2zF8/fOpAaBraaeue529tiIUkh8wAPfgZI55H/mcQleJrY3ysPCB4Hl2VsaIL8+uk1+9bv8DvwAJTsSIprBKNIVNcMEl7Qb+yp1P+iAnX9yAMFe9pcMhq7exp5wHf6cB0UUUbavkmDpgZsIi4kHY7xsNBQP3zDVmr1QJHCUf1bTmc+jklgMTmOabHzwiVzju4q0zG/FXP6hmBfVkj6QdVvtxyE6MvVOHG9VAr5b2EHkbCsoE5vSIuyhM2LFtBoikRMOOrVhCvTpLY4AE6NuEyF6eSIJOO1xyCA8g6f61dpJYnUcA7aceXb3cYvpeqMMcGBNNxjMHrBiZMqkhZKiXqtLiuhEOZVvlb27bKTeOVbNoqiD58SEA/l0w3FidUgsn0NDSAjJFlXGThj515O8DegBjJGMqJD9sachpuMSbOnQr8m7NFiWLA6k10CKsMkvbUsNILQg4PaKJPPStfkZ3p66QgTVrWkYe8NQaOXvfZLWt4fCg9dsRAnL/5+pp8PFIiG9XZaI7AYcQy+V4vfAiiu2Ocv9+Nsfrx397QPihd/tkqXS9UPtMTDG02Ai/dxbBLLz239k+ubR58=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(186006)(1800799006)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(31686004)(966005)(31696002)(86362001)(356005)(82740400003)(47076005)(36860700001)(7636003)(26005)(2906002)(336012)(110136005)(54906003)(478600001)(40480700001)(426003)(8936002)(5660300002)(8676002)(70586007)(7416002)(40460700003)(41300700001)(316002)(4326008)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:55:04.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62066ecf-c212-46f0-4fa0-08db9cd6715d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 23:19:01 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.191 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.191-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-5.10.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.191-rc1-g5b1776cc14bf
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

