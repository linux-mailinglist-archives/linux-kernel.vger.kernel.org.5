Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE54C77BC02
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHNOuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjHNOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:49:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E87FE7E;
        Mon, 14 Aug 2023 07:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ1IcUwvbB9+u46G2psL8CbLw9k1ZBE2ROaRetysEN+vvt0vW6wVXI+yLdZ0KISMgMaCtLtXpGTFmKnVn4gmFMTajmnmPJHot1lUxiqAKST3Uvny8ZgrGzHOE6oUua9gV5xUzDOh56rlNZTyB9WCGIj02pkhNBOpaiWKjn0mfNgQmp9XDUARnILyzlmrL/dxD8hSzB2CvyD8524FtjV22lVcBIGSPLTq8JMTtItMVUbB0G3YJFCilgbpuE/HDWoVrwPew9ETcmByK1nTCXhSizzZ8cpokj6LMtkJ9+DEPuHFFH8Dw6rOaXW4li1zzwj8P2Awl1X+5qJFf2HNM2tAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY1kEnn4TZe9Zg7MDXvzkupRdHm4Rhpahi2lRwLZzBk=;
 b=fHrSWUbBcgtq4XZw/LmpzeD3R+lVGxFk5f3qcv+aGTleKB/Y5T3H1LY7gaSvZnqRPwR71+hY06TDoVWsRouArtDfbFjnaomxLQwd43yMzJhKP6GzKPfXhMb3j2hpQ8OOP5Z94fXHUnKuTyBNG7uIMdleO6ZqYzA/gjChPZfoZRJ8+VgRXIyAv2kT2ZejJC7G+aTHizqtIc+tLzvnuJbx1wKyGgJMT4H33cSraFXkED/wmbFFSLtvD5RrK3EVYsrzrDd4AijH3L0FeEideC6nOpmBjfzpGjPiW83Z44vKQ4dspEdSosY/ofYZnrztR34Rqy6RAxlhTcLPE2r/NnMUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NY1kEnn4TZe9Zg7MDXvzkupRdHm4Rhpahi2lRwLZzBk=;
 b=EB59i8dsGzI9R7NqduoCKrE6YuU1I/HXYy6gu+3ES8G3PUSgg5PvbK8EUPc1p7JLUfSQgMYJAdYTyeQGHdz6g54P8DdcLjau+9CZEFpd19E+GI3pRI7nXt2NigaLI9eJcMAhwE4Ie00auOR7Ik5BhK5Zcs9nxDsNtJ5PY3TZTpZsgXWeebXD7TBN/4nntL8vBOAUEtAXZY0G3AZrToTMOABAlNxf1ycUpF6YE1dhzZ9zeCmqns/Wd4Ynh+WFer5JzNxKQUZdhPO+okiZiEznQ7QdE5ywjVrV1NQuUGaYKmi3JfPcZGt6OLvLG53YCYdbTSWdY8p8pOZdrSdgijauhw==
Received: from SN7PR04CA0162.namprd04.prod.outlook.com (2603:10b6:806:125::17)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:49:41 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::3) by SN7PR04CA0162.outlook.office365.com
 (2603:10b6:806:125::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 14:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:49:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:49:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 14 Aug 2023 07:49:34 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:49:31 -0700
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
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <29db626d-bc8b-4e09-a0bf-5635415b7a8c@drhqmail203.nvidia.com>
Date:   Mon, 14 Aug 2023 07:49:31 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: d426e670-22ed-4821-0d76-08db9cd5b103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaLpbvLbRLQuMIovN0rznRz5haHZI62Ryp+D22jIglsEBZLRMIjlIxxVnzRPqFPDn21d5vBlUxpSPAC9avrrpe6hyOMjRaPxvkDSIsntc5zeYtQ3ox3gkYgd+sgk2cohYuDmMvsxfqWO+iMK5TLVFUXM9PbNC7h/f/6gy3iBiN/zGi/hDEDjLzaMu4RF8Qov4xdDufwka9T3dbnerDCXp1a9GNL1uuLLJSGc5VxcKMEEvyAr/lBd4/GJuy/nGk+BmBHHxZkMhwYjz5RHjee509lk++RyLzAL8lbR4w7FvD24iBWbVngpRgHj2sCjU2KmAWYIIQkGZMQ5j/D0M3XxoqSUxL8Kt2c2gFpL5nbJBoBSayC/NKZY76CA8PGmKgzL4Q5UbdHgR2ZW5Pt4mIU/macee4rcFvacOO0UNSm+0N3nLIodZRxagpgQhf3gN6pBxoYVjv8uSPhTegeKglHJc2y5SWriSfVmHHMLkXZ50BlWjaxpF6GuE9abUKRN7SOevDMzl3Zavzsvo17xSw/1WiehYwQQ8gX14PjAW8NxQBfmVIcXWfmCe2Q0jTVH8TIvV3Vq0DPf7W4SClscNcWcYKPeNXxVnV4OWDlB0hNDi9qgfBlsm1zYP2UMjUxcaLc/TN0B5iqir2AerVva7qxEil/Js0XbBQdwflc8Vxpn9fni3ZKOF3tgWznP/eabCY116VJiBDrJIUawcYDvbXyN6ntnhSf4OiPlLMDNY1+1PUccemjJJ2qRw1pDLToaAndFj7IcsKBQ8dLZz1T9g02kj+pA2y6ciwNK2Z3AZAyTjuw=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(186006)(1800799006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(426003)(336012)(47076005)(31686004)(36860700001)(86362001)(31696002)(40480700001)(41300700001)(478600001)(356005)(7636003)(54906003)(70586007)(70206006)(316002)(8676002)(966005)(5660300002)(4326008)(8936002)(82740400003)(110136005)(40460700003)(26005)(7416002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:49:41.3541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d426e670-22ed-4821-0d76-08db9cd5b103
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 23:18:51 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.127-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-5.15.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    94 tests:	94 pass, 0 fail

Linux version:	5.15.127-rc1-gc79c1253de29
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

