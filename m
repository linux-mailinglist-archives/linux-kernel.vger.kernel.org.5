Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70F277BC21
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjHNOyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjHNOxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:53:52 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D85F183;
        Mon, 14 Aug 2023 07:53:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duNuobRczhnOG5v9fvKeRez1G0TkTS/dRk3m8xkfeC3Gm2WkMm5S6+8FpRDJzM87dDsqtgAglYDv+vTGcV/9DOt3Gmk4qxvkfUNcTu3C5Eq8ReQuEsk71eZATUIsqn3hJ6HN6G0MufOxQDgRm8/sc+KuztnD3YNIT3iP6ozDtCd+fAPz/o3sJaB9A82bb7PogHXTsvU+MRAbER2x3lspWlq6e3I24jRJ3spJiTMcs2FAiw17K2T2AgN22nppy6c9sV/kVHsndzaw5k+ZpKyHCZyDXTOp4yyZIOUSt3dQwgCUyGDcJEhuWfskEWPO45C29uBmCmXqGLxdQOvJJeBMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2waVhNSbLTqwSkt6ppyX21fcTle6uMWKvEBIrHZcp80=;
 b=WlfkF07F1VouxuiOc1Nvkux3Cq6/L7X7CTxgh91vebTLfaAz3xF0Y5r0nUnGJNgS7fXxP3io7NgzIFHx8vlqanB0DjrkmsiDL8lhz0TCEn5fVpBcpalVK3zWAjMZkvD915DG6DLj34qF5ltF0iveDp3YwSjsxJwdDHjrHJ/tGnD5juLOPyOFu8QWC2Jp8oXfcSNkuW4SdP+i844bmklK4vYzPl7NUu1bF6U7P2Bcixz9bH++PRGlw+WR+ZUSZedyQ+Qtqs5Onre3Rk6rGNxk/nt6vXU6WIMrWDOqgYsnWJCk87KKPvELcjNrv1F7Qz54jjaFjahGaRHxuivaPHNttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2waVhNSbLTqwSkt6ppyX21fcTle6uMWKvEBIrHZcp80=;
 b=QG1vGRkoJq3fNuODFcI6d4npao/hF9betB5mRwZyu7A11DvdJO5+h1s6OmMsd6QPcOIP/7ZJ1xuIuMXA4jO+pWiFgXQIKWqvhIlPLRvGbFe8N4f1vOFlqPOj+pk86uFdagG8x1FbbNmchF47b8WJ7KhKdcwBbMkGE351Klc878w0YnYmGvmRQrSY2QUVoDTfR9N2XnZ6kK1EYDUrzFOA8GvIFlYREAy/Kjxa9tpBIdHk5/Sfd6dGgtEvtaZI7fY5D+zl/FkggiBeXMdAcnize7vdUnCZP0hnh9c2i/MDsMnS0HncynAxgLEKXYftuqreqNolYZHUk36o2Xx0/uPBlg==
Received: from PH8PR21CA0021.namprd21.prod.outlook.com (2603:10b6:510:2ce::15)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:53:48 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::eb) by PH8PR21CA0021.outlook.office365.com
 (2603:10b6:510:2ce::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.4 via Frontend
 Transport; Mon, 14 Aug 2023 14:53:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:53:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:53:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 14 Aug 2023 07:53:33 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:53:29 -0700
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
Message-ID: <b23ce529-0c79-43d5-bc25-56715f581a19@drhqmail203.nvidia.com>
Date:   Mon, 14 Aug 2023 07:53:29 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3eae1c-0ed9-4585-07c0-08db9cd6441a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEmVKJVfrWuuevzTkqmNdNHAh7l+Jx1JXatcybifsE8wzouqH96QMGu3buqU1llbrk/GmWWS6kX85oYsq9PelHne2hUrQnIQ2MN4r3cE+q9oM4g9NXV2KhYbPjMEKutpPNugH/W1LZxM0/9TgTsIqizOzh2+CsqAznmi4usp8gj4WCtCIJzp6QGO3yUS0rQk6Z6DOhIA6GFft3aG3604rIJ+UlvJ9BMuP9uOP+ZXbsTw5wDjPDByJ+478a1LPLEsoYPBivI7TsYjP98M3BbQAnGGWRojpR2sL9veLDMYpjqsZJRoADVsGseEeDfh1Bv9VZmrNeumk+Z9hEDw7pd8h5X7Uhr4QCJjJY9ICfvb+jVUHFt4lOiEyya4vnSlJtgNaLNzpp2zsy85CwUpzsir1q3dRjHqNLVPTXsBu0tQXaLAvlm8tiHo6OoKJinOF4Z6tlDR58YWxDMo8bzjw8kwKvUn9nMx+uaZSKs9eC4iE8vNIFV3qHCShq9/VA3uNnkHOutyIYR0ArxKNG5OYARNnFPRuDqPQuZ3SKR2LrEfLxjvwrSLx1yRFQtd6RrLLO3kD4joNdPszyNnoxzxAb7pGiJquZQTF2W/B3PYE9JegJDW2XVCAIcqFebym/3TPVKulXBYRSiSsn2uYYnZtb/LFH/5U3kfnkcscUUnflcMdMF4tdfKd/BmSMZaVzyk8UYtGV9S9fz7CigbduUxLStrRyEBQhCJs5RBtXnf7X1nF6v/APuuiWIXQZ21u00db07MaX/10BGZ/SQ3troYIDstuvZn2jNSUQKBE6Rf6+ej7t8=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(186006)(1800799006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(426003)(336012)(47076005)(31686004)(36860700001)(86362001)(31696002)(40480700001)(41300700001)(478600001)(356005)(7636003)(54906003)(70586007)(70206006)(316002)(8676002)(966005)(5660300002)(4326008)(8936002)(82740400003)(110136005)(40460700003)(26005)(7416002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:53:48.1298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3eae1c-0ed9-4585-07c0-08db9cd6441a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
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

Linux version:	5.10.191-rc1-ge3154e1b14b6
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

