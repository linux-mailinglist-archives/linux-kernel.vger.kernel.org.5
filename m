Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF677BC27
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjHNOy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjHNOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:54:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA681705;
        Mon, 14 Aug 2023 07:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+PdU4ZJnXRHL+b2c4do4kevVARNhxDSV2ZDFb9u4RenFH17jXxkvw374kDNA9FrXqvm/7XaGuLwkG3lc8Pls2Qo1gFWG5Ga/syCHnFfUk5NZdYj22/GetX/NjLHFQJjVZ1inxNds0vVlUJ2lc0t/QIMWXkBcMA+1LmOLVj/gJQhV7bULCTLSRoNTGt6wGa3RGkwOsuvdIo4sHgzjB+RJFqJVqwaTJnTUwJGHLGX4gk86RiIutMeq8LcVfBOB1hHR+1pyUnAfpFFyiiZjtqU3vrDAJ+aAfKHg1NlKHbNS/eiaQXGLESycY/xvMbEV84JZSHfTeAMAHKTM1wU5nsozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv5FsHNfDLHb4PVSDWFebY2tuNCQExev6CcpMKeUDHk=;
 b=JEubg43PTqoe4eoerZkEUnApEqlbyLz9KH1XX0ueEFHkrJFHVl8+79rJUuzmjP4aySn9cgEuihUmABNXIXrzL2kPwQbB3RwJzUWAY0WRULjPKXuvxUBouMrxr5qGCT/nezRR/fU4kkFGkzVKjUofrh0gt0NDzP6v1FgIeeZCy0Yv6Y1m1tJSE2Wn7KzFNTZwJOz0yeJQd0/VbIGNZKEr//KyZrfA2XscEAIVSfj6+PwG/KeFdW1kMymEQPrIVJjXmAIoS1OZmcsbBtGZkHWQrpmsg2Y92koLuj5PvYtsdUY66p/0gyzaQ/7fHDg9ToQWQsO+NOvEUnzjY6EMz5I7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv5FsHNfDLHb4PVSDWFebY2tuNCQExev6CcpMKeUDHk=;
 b=aFtxVm2s9bLFhaOHpw5GLDR1J112eJIDZWJ9P+b1/bie9zO30g7AjYQ4OBoTK7e5+d4kxkB5YeQH4VZZQrdhwgvQuB1i4doOoPKJfkI8x0IqNLj1HBENR3DMVrsJPCa875gjcUYnQKW2p4pBjlabYSYS+uMUpHiThuWltaYwYjW5MUK/tSXhcKnmMx/ZnqYgOEJInNY1tGIvCYO4Kii50vByJ4HaYVB4z7vy1k9VGPGwVqqwWfF8z0ExC2y+nfloFSPSNVfYqvTXUXla9gtkkN04Kouj9/1XrSUwqJj6K67XReIXRB6fw5a71Ib5BAL5Sb5s2GVurVHuCpW+nPPhmA==
Received: from SN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:805:ca::16)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:54:38 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::4d) by SN6PR16CA0039.outlook.office365.com
 (2603:10b6:805:ca::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 14:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:54:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:54:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 14 Aug 2023 07:54:27 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:54:24 -0700
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
Subject: Re: [PATCH 4.14 00/26] 4.14.323-rc1 review
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
References: <20230813211702.980427106@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <413147d4-f8ee-4773-92f7-c6d2beffacd0@drhqmail203.nvidia.com>
Date:   Mon, 14 Aug 2023 07:54:24 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BL1PR12MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: 84946781-ef99-49b7-d857-08db9cd661b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0Ig8Wy++9Py3xenca9FMzUZP8XxuzMPvCVS3g5J8DnroEcpWMT+0A+l6LtjobJ1cfgjXijbvO7qTPLJOOvgpN8LtQ5DWLftOAvttxIQCpfD1+RiDtF4NuoMEazHHIJfh0dF0HI+oX6FQVSFxUr96uy16bUf/K0W/vk6V4q8+sSuKQK/TXtr3l81210w/CNvBfhMDavajaFadoE6NxEuOP54q3fOrD+MSrWkTXEb7hfqkgY2x9bY6g+j561GpX7QmN2FYMKRBN7Ub4IZIbmhQFdU7QtzG8LLjIqiMOXZgmMmdeNNzxbHCRlvTt3lOryy5OcURIYG7/cqCdOX0b4xNCh15OelHrI4H6ZKNfmiqaawhIgaGokUo1ccxfEOvbI+oVjjt9bxWwaNOFTvHowqlFqZB67wq5ilqh3BtkFqZTUAI5wuIqQD+O/eKP7moUCHPNLkcSDD85EI9+qnCUtKHZlFc86ieX8NpKMI+FFWMx5IrEK1iwHJWS8r0xFijUNOM817zkXgX5aZSTbstkIahprkH83rj50E/jwxI7RipVyHAKzn/bQH5V/Lm1bzZmnAwiupGYNiJtwBqFxuAHudN61v+GR3NQoc9vlcc4XJAbNWz0LTUBBoxxZf7jC+DzG7A1gR6wBwQH1mGi3epAnF6gGXITN0bcAx+SN5yP5ridQkbjt1vZPY07MIb2CbEJ2MTjAE3BkABtrahfqUQpDrGk/1QyqvtcspQy4PGOHnuvW0dIWr+kj9FSHCbYayxBoLxYPAB9YphgDVLTlkXkMlOpEitfF2R74yav4tciRMkLk=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(82310400008)(451199021)(186006)(1800799006)(40470700004)(36840700001)(46966006)(40480700001)(110136005)(54906003)(478600001)(40460700003)(356005)(7636003)(82740400003)(7416002)(5660300002)(2906002)(86362001)(31696002)(4326008)(70206006)(70586007)(41300700001)(8936002)(8676002)(316002)(47076005)(426003)(336012)(26005)(36860700001)(966005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:54:37.8180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84946781-ef99-49b7-d857-08db9cd661b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 23:18:53 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.323 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.323-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-4.14.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    11 builds:	11 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.323-rc1-gc2d79804d11f
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

