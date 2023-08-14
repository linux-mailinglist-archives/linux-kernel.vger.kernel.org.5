Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE48877BB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjHNORK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjHNOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:16:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1E8198D;
        Mon, 14 Aug 2023 07:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP3itTNVgLm/mqWsPhOsapbY/pwNUsM+boJEceoUZJNILsBmgGiworAoWsgOmpDWCqP8HbiMIkhXWSlUn+oZqBSIvW6pYBRf+GRUf9iJP1mc0bk/BO8epI+HIGcRoN3apT/ev1KXE6T9HIMOcep5FT+BVqd21xapi8HgqBMJWyIdoQbsqMfWJg9DUbFmB6pyAy2tpDC/q1EHjS+wACZHjQ8BMRzPqDcPU6kuc/BL/9KS0nvyiA9CSFU65Yd4d1lLhnVBqK3SETb0lVrNYmFTR/cB4EqrJffK2aYs6GvwtEOGb/PjTTmWrN6zKPDVs5NN1nWwaT7oNo+hQGGt+vMWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SFXbp+oY4eLTa46vOE4LuVmD8pVOHK/OztOkl3Mg+0=;
 b=fexKTT47BRTmb8Jyte1fynVhj/YjRhHVRR27yAGNnpHnvpF3R6wjO7fMAAN9rQCffEFyicu9sdf1hYX37Fuq4WbQsKiH7FQv6aAMl7dWKDDNsiuFpYOMwro99T9xzMCZrF9eDtXtvlEmmJ4H2+tyn5YqHEzttEGrQyPUEkvvnHK9pEUIrmW/NlXKOTmsnNBL4MOHFKExp/ZW6A+o92SSZbHdGLaGHpbIDqwir5lfgKqWMehmN8GfigpGXx0VzLUe8fpsKC9Li7nzderF0h+BI/BwjV4i/oFEgc1W2+2b7OQuV/bbMxeymeuoxjbg/Ula2H5C5jfvFQdIh1sD48CN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SFXbp+oY4eLTa46vOE4LuVmD8pVOHK/OztOkl3Mg+0=;
 b=hzt6WuUfF5PUWueUoMt/U2vBWY6v50yalggjLl+JNRfuiJPK8PehskxFVlcec96cJD9GXnK6XPIMcR0p1WSBLsIvFYnSoixLS4tU0eXY2oEDGS7ZyEZVdCKLqTj/+CSlWdTH4DaqY17A1lMAmm3yp0H45krNs1WdyLvEM3P2AFBv51joWSEmD8aTF+SZe4xUH29dDic36afERMDdvdl2hdh4DoNAWirgFR5FnRVDB6f3wfasA+xmZ9OK9/v6GYffkBMblnpu2oXplHKixPBQquCrZth9nYc3Tq7xe99/UoEdHYnJINxdwLyQVK8sA7ye2ox2WfwzpOrRiW7N7+dPhw==
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:15:55 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::f4) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 14 Aug 2023 14:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:15:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:15:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 14 Aug 2023 07:15:40 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:15:36 -0700
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
Subject: Re: [PATCH 6.4 000/165] 6.4.10-rc1 review
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <166c7946-f173-40e9-835e-2bd30e4ef8ba@drhqmail203.nvidia.com>
Date:   Mon, 14 Aug 2023 07:15:36 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: cb797ae9-e255-4ab4-d0b6-08db9cd0f95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5iQNyrh/DCcDBcYZ75tbmsKiPMm4vImcbCsoSkwbw+zD3c+T6mtAOdV1Jb8ZRqkNZQkq5mqN48RQhktS3mMHjJC0I/fXOe4hOUwZLE7F+vGr56QEX7RRfT3HC4t3JaJbATUjZBnpmVSVj5il/OAkBrCgFv/X4cA24Ua33td7VTl9OPApXkZtC6Z1dK4J/awSROTX+m03szTOwDpcvwkxJHb6B/K/kQQYezJaE7huiXfw8XI+eCpT57lWHt9PqiphCjEgp50TwO4vyfU+4hv/VmYsKYp7SJ6gHTVMLX6PE25uvmWIkiLNKXXRl0kNwWpFsdbsTVd8o6FxEMqNKoCEz1CiKhhU+qdyiWjkB2w8J8RkeiHXT5/Hx795K1Mm3WKvLT6w4EqXLADCESw0tX/FNEwNXJgZGCK7AWXVFAo0K43Y5Wqqfytpwoe7dUTj/gHYpXanIedeKCZxwwi6zyNkCsJ2Rp/1NEYhUcOzCSNUjpEWZelezhv3kMTplW2KPqsqTUJNjYT7VjleHYCyOfiY8RiWnxQKuUsE5N6UH6w+y/bRym/5TEhkwDdBZsvVzvuKgzEI+OGMWKVSPBLLCIYL96MNoOt5KWgqJZool2yLpHs55+uoGr7XasF9XcMAE45Z2DTw515/i/3ghqWzbIAaSqY3PZu71iNY02oYdAUqjlST4b+6fNQo8nMxk8sflmw6axGtfe/fn8xRth67K6TnYFznftA+LJrOiE3FjqVkdxrcr1AgKQ/AlxRlkv99W5bBqWJccaki6VXN+0lH4bEmzHspr7a9+6jqlImetpJVC0=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(186006)(1800799006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(426003)(336012)(47076005)(31686004)(36860700001)(86362001)(31696002)(40480700001)(41300700001)(478600001)(356005)(7636003)(54906003)(70586007)(70206006)(316002)(8676002)(966005)(5660300002)(4326008)(8936002)(82740400003)(110136005)(40460700003)(26005)(7416002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:15:55.3016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb797ae9-e255-4ab4-d0b6-08db9cd0f95c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 12:38:51 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.10 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.10-rc=
1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-6.4.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.4.10-rc1-g80226b49c77f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

