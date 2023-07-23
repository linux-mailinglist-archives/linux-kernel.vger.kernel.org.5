Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7503875E096
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGWJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:08:53 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D174D12D;
        Sun, 23 Jul 2023 02:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBJTkOXGUXPjCguXhvv/tgET24Y/ucWvX5/IkgyXlRu1VkYs297ekuDxI6lIb1cuTuYCph5EJb2FzhxQ99YhvxL8uwGBuSABGHCTHubWyEWal6l0bZDGHTlhLJiU2DWWucdGN7253DfSSBPdxkfpG9o46DtJwgix8NvcZwFg4kxtDAe+eIRyrp/VFCo5sTCruB1S+qJKamgOcrlqOyuds6TpgU7usbOKfLHJhYjNozAYbEFUCpFWBbtVY9ASLuIujhytTEkuiGnRSetOp0FcpIXuPfUA3IzlHVxsEL5E5fZuRaT7ZkrAFjGf9G5+S0ywyDWkC6sdKuKQovwGcn+AMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogM86xIj3TpGQi9A/yrJyYNvTidRVCruteMOgQOF2lI=;
 b=VhodIecCpAM/ClH/jvG0uy2bj58tSLT60KpjoA+3Hfy71vskNFd3MysBF8zAjj9mbRZ+oc1J9k/ePadA7+ejYxibLpHSuo0B042qbQGsLwUd/rKPiBiVWZlRh2ZLcxsTEzXk6xdG2Mcz5EjhCnmNCJCVmYorDZlzdeaRef8/kmpM3wial/qUc3sUvYwe18ltKfytTcgOU1qdxKJFR2DtDn99cgWLbkKlCk98f5JiBcxwF2N0Ue8P+STsqrShXJSiWL2gkjm4zssuUfbwUantGf27Eikx6wpgEaBQy9Wd2z993HqnnXiueVSliPuLhdRGqluTK80ywUTxptIe1d3adQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogM86xIj3TpGQi9A/yrJyYNvTidRVCruteMOgQOF2lI=;
 b=OaWsepcGpoqmYGM2MLBLekcvEtOWSknmNv3xpThQQ5K4mtrzb0KSGJCrv+fuUe5NEA1XkVZxr6PTABWw5dtQVLmtmnJGqMoK+lW++Z9zrL2X7pymA78xCMdv7wc+QChQoe/a1sk/ItqNejIRQmQn0P62BvHduJQY7+h7NV1RFln3JX/We57nK8VNc9IMQNcmtvliGgvKq13m3cJP+sJay2iH7rKjaO9oCRyFT2CCnZFd0awkA/eO6YLRaCcK4411hD43rhocF36bYjCF49QjngVEvNENhmbdZzffejz5d0UzNwUnQ4Y1YA+RR2y1/TAn1s8ErvTXBhJh1Qy6iGKUpw==
Received: from MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8)
 by CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 09:08:51 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::dd) by MW4PR03CA0333.outlook.office365.com
 (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Sun, 23 Jul 2023 09:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Sun, 23 Jul 2023 09:08:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Jul 2023
 02:08:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Jul
 2023 02:08:39 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sun, 23 Jul 2023 02:08:38 -0700
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
Subject: Re: [PATCH 6.1 000/223] 6.1.40-rc1 review
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6b83a926-01d5-4623-884c-bf6d9cd5ef2c@rnnvmail201.nvidia.com>
Date:   Sun, 23 Jul 2023 02:08:38 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|CH0PR12MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: 8334e692-6deb-4aca-0677-08db8b5c6e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWbBYcFDTAhFIX0Yy35GxDXTb6hNSPaDGyI0uXE/Gll6Ua1eeL/nfRKVyi/gusIKAX+PrK7+zTYR/ZZN3Md4aOms3iZNI2fS+jutNqTIzqaDlCrJxLRh/yaYVkj8d0oiUlVVH3ukimjv/bgUNYzSfpRJVkDkoEvwQ6v/dQ9RMjNf1wBy8Klvd9APjj1JH2l2VL34b2IB2HIZIv1cf1+GF7EvRelOwYRaf9EhsmYZiyLTdRGzxXA42GtCBvOeZ0K+6yI+lbikzLEjUE3Mj0zHML7ERZ5GH4K851nHSWwvNuSPSTH5ekbA/m+Lp0DDJsObPUDQ98vw82xjD2Zjo/Lw5fxQf+qO8NyrM0pJnyfg5V35/DAiKf+VktMl5oFKoIGmuQ0NgbBod9AKnhR+x9QKEDQpEHCMB4kgePP1O9WNqBJreptXLkO0Yk9QC+TkuvfL1iu+KJW4MiXS/el7z5FN6lP3bgZMK/1LflaRbM/i+X0MsfPMU1qcpe7D1Qlo5ghNB3hplIqoHL4vXLZ5MEExT01/mb4ykZ/1Xba2lxcDC/zfBS0yhVp5iU19EMwEW1ooizj5Bq34LQo3yv8jauXr1wGlzI75Qx5d17PeB3rIODgRADQO101IAHBSKVGxNx2lMm119hc1w7FIwBUXwWoNP2R2tBWL5sn66TUMjsUJSu2RIMg7504wllu+vB0bBZG0BFCgB/9HydsA1oW28qyf1Waf4iyinJ0OFLONcWsb45eiBeWTBlHTB5EDhuaJ7QMYayLXAWaveRK7jDUCOUGX0H/Gww/0tDIaRTD2k3rlVuE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40460700003)(7636003)(40480700001)(356005)(36860700001)(426003)(47076005)(7416002)(8676002)(8936002)(5660300002)(478600001)(54906003)(6916009)(316002)(70206006)(70586007)(4326008)(41300700001)(26005)(186003)(336012)(966005)(2906002)(31696002)(31686004)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 09:08:50.9215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8334e692-6deb-4aca-0677-08db8b5c6e7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 18:04:13 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.40 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.40-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.40-rc1-ge54fe15e179b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
