Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3574177B76B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbjHNLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjHNLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:18:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA84FA;
        Mon, 14 Aug 2023 04:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpp561gFPZyvUthMpFOlQrHdL8SB//WvDTJxYp379kABV4S/AIBkUUb8BzTTxqPGYNKv7TNIMfaG7iNVD5l615yYTSClOrP2pEAJCqeYh3TChvnFpYcmWDo0xuPzUgvo+xKqMiV2GSvdZG/Np1wbc8ASzCCmT9T4DoF2POKOkHdKlhyCXlVHuBQoyJ691/JePShzHdAoxjuWbu6DDqr9Kna4i9Wgopw3JUYad183RJb6sv/nJUqFSKLSCRxENH+p96swZWvU64H2Il9t3CoLTZctNb4JvVrFl3kwOM6N/cr9xYgQmUo5XYZPN1iIuOLXW33qQTLm0dHFt7rxRVix1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbqboGGOY1QtWx0LD6R0d/DPLPgO1M3b0D8fQqMj29E=;
 b=CvhUH8PUt8j+j9TZEi3OmjhmWIKQA+m2dRD33HRTa0N+QQZR6QOYGVkH5OLqy9zeQpL3V0UGkvfaOHTmEHJMPqpEJYI+WlVJmBYzKz4j9C/kW1ODZ8N//5yK8OoZhauFJj1NmaqxKUzpMuwbunfXimr/UMOVlOjH0G6ldatSdCE7AQ+NLqiV8qqmZbOg72ctHTxDK4wObXFxiR/3kAh0dAA6xZPx+IDPPyvJcEBFjItzB9eXQwq7oT0qj/ZXSN+LPNre63+Ws7uc04mBTsQTcqOp+MBrzQ2TMWCiUB6tDJoZg67rR4s7vXZ/dYFuv2RO+JQEBe8U18tNqUn4BqyWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbqboGGOY1QtWx0LD6R0d/DPLPgO1M3b0D8fQqMj29E=;
 b=UrazDNrkjdjI+dtmaOljHrl/q88f2tXAtEumS2e6liRiCf6qxOrWGEum2SMSHklssyKaQT6M0SXApDOUncGjdMJku14UWzrt0m89HpXIw56spfarfjfGGDOcxDNVxb+oBZyAkAz9SuJPbnR+Gx4zjyqX8TQNyaA/FtjFbKciWLnwciroyXb51iBVjDmND71seShfzOsqvyR3X8JaNeakGI3oSVCWoogY7KNtrJ16tbVDUogFSgKn6f0UOUmrZWDlJA+ceHhZGVujwIH1GYPKTxLehtvcQ/aMX4CG1iNLXCSKzsVwocYIiGM/ivRZSLSNG2M2+kT8Awi6FPyzYnSmyQ==
Received: from PH7PR13CA0017.namprd13.prod.outlook.com (2603:10b6:510:174::13)
 by DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Mon, 14 Aug 2023 11:18:16 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::c4) by PH7PR13CA0017.outlook.office365.com
 (2603:10b6:510:174::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13 via Frontend
 Transport; Mon, 14 Aug 2023 11:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 11:18:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 04:18:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 04:18:04 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 04:17:56 -0700
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
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <c9ab182a-0dda-4e03-a55f-0b8b33388881@rnnvmail205.nvidia.com>
Date:   Mon, 14 Aug 2023 04:17:56 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DM8PR12MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: b22bba77-6519-492c-d5b5-08db9cb827a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHv1wP0syJdYDt5Oov3t6RE5XhmBCoLi1U+2MQH3J//owcAUNBGGBRISvkTAYfjHuIT2ZvTVdjhDG7J77E/mVIaPCBK317i52N5WxW6N1KohwFxBrqQq7c+B21b0Hm4upXOojWKfx2TxFPuk2gOaPBxjBm+GPp2/61evZ7fU/QYQXUyHdB14h39wXv53bbNYf4Zl8gj40tGn0mt6UL1jrWilanCpxdRgrftDKIVuCFXVUR4UXQ3p4Yg5JXbsS0mABBgNN22hZ+YvF+2oM2aLvv4/cq/zpL0ybkwyJXC/xOCFrDN9eZvlMx/BHpU4PszY88jaFByOs7bnMu0FK/URSKeFBxyQ4KtoHxqQqJcfT4zcBGc9FUHQDFHfAYH9ZO+8zL3ofCxk4Cd4JvRX8OJoWBl+wo5vJDRsWRMSaiLZn/2EWGuo5uO86UfbcaxEOpkzlPYiUFvMSsYrCUZIwe5BKA8nXu4Jzg1sKSJqAyhki2tcFiAPY4rnHFpBuYMNXZfBg51h7DIyuHIO93cLtBkvFlDoGnNW9Du7Z/o0dlifHqa01q6dleBPm6BMOBOn856kGZwe8h8rA/GricgR91M0Fh+6wDK7u6j5cQ9u0k8oqXdPixKw2v7D4/dQw6lfvVNcOuvq4HSjrS8H+KcWnl3Jesvy0UeUua06om9t6fKK8WXJop1bVKzA67LapT0V4OOiEDRmWdNJ+eQeDcYGJGWWyJDis6OT6BIkcc3hWE5I9zRIr9RLXuACbiQ7mT3yH2HLY2KmoRxPRJVfjaWZ4iHyv/k0SiSdqIwfEO1pkCf9Jxs=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(1800799006)(186006)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(478600001)(966005)(110136005)(70586007)(70206006)(26005)(336012)(426003)(2906002)(40480700001)(7416002)(8936002)(8676002)(54906003)(316002)(4326008)(41300700001)(5660300002)(7636003)(356005)(82740400003)(86362001)(31696002)(36860700001)(47076005)(40460700003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:18:15.4524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b22bba77-6519-492c-d5b5-08db9cb827a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5445
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 12:39:47 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.45 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.45-rc=
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
    130 tests:	130 pass, 0 fail

Linux version:	6.1.45-rc1-g02a4c6c322d1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

