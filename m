Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01607A4A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbjIRMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbjIRMuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:50:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2926010D7;
        Mon, 18 Sep 2023 05:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz+Ni5/5EmT2ZLLerdoQujSrdYEq7u4YpiSh6nAcObqs8V+jhNNhLJ+pJi45k3PV93ielddzZ4w4dx1KWsd0sCgLVIT9dA2c3y9ybTQc82EPDxh/yajT4ZiT6Q9feVKRRiRoBgUHgTGsdCzQwzWEaTEIAROp3jUJrI/fX02ZButxN5/f3pcm+RxLbr+2jAY2NLTHDH5fMMJgMFxQgYtdcA+MAiGXoQHwHaX5sG6eeuJf/0Uhes6/6FWPG14BvLzjwRN3Q5ULyfdcOQWZoSBGZXKYu638g5K2dh3DPMKeA/IgsGhVOxuN8L79nsw2r5IEvGlgsGHBMqRBCy0T5pATzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI1/WxtewABaB9qDB6HlCOCughSeyFwrResW5BOBfIE=;
 b=LDDEdKpWe43ktH1w/1LLWC7lkJ6VrY2SV64Ihx4p85mcRH8fU/efgTd9tML8eXD6HFr58rv0PqiwHMfn3SG/sV5PQIk3ydb6hzkjZWEWSrH18htQx8bh+bS1UTCS3ja1FTNNVmFZjrVMSAzd20VMmOI68/h9KlFKUA635bHt9TYZCwHeYLcMYe3nRmjUAmCpGGn8mUuRlCWkn0N1cL1Oxcb3BcLPGJBpYR9HeTZapkda3vucpiSq7bUrpyTpWveJSoA5Ne0Mx/BE+wbqE0CsEDXW8z+/JrV7aGNZh06cZYqchoM32T7nQlSGACvKkXjGXM3UZjt8jZRvWDotZquOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI1/WxtewABaB9qDB6HlCOCughSeyFwrResW5BOBfIE=;
 b=ih1ZFokQ1lFcjQuDGCyJ3j2SLciiDHTXFqqkLITd67/76+CL4LCf4uvUZ2Zb/n31/5CdVDCMBbz5t142L3asHxP8twjOdobu1tGZ1jIM6QQm+JxisLI8UoQEurHoJr8wI3Y6wMRKwzA5A1IYjONouA2wfwrVwtwqSfjcXmp0V1ndGiy6/ukn52OpgZnGQ3hQ1iBx/D2FDuCy3gr0FXCr6rwnBZ2EleWdv+zWGxnpdu6RFCetenh2NDs3dDU4AB1AZmgbnU3Z7DjU5xDYhZZ1dYB0sBWZiD4NcJJD4GYkzeySSxnB0kT4ybo+ubaqXaIVhryJtf6ovZQvzrI6p+NExQ==
Received: from DM6PR07CA0070.namprd07.prod.outlook.com (2603:10b6:5:74::47) by
 SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 12:48:50 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::f9) by DM6PR07CA0070.outlook.office365.com
 (2603:10b6:5:74::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 12:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 12:48:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 05:48:37 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 05:48:37 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 18 Sep 2023 05:48:37 -0700
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
Subject: Re: [PATCH 6.1 000/219] 6.1.54-rc1 review
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5b0bef9a-b16d-4d84-9d44-9cc33afbe74d@rnnvmail202.nvidia.com>
Date:   Mon, 18 Sep 2023 05:48:37 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb4f35f-f231-4cd2-33d1-08dbb8459b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aslwn48C6rBKAE9dnJJqVnmpoyzGyC6Z6JxltQWnag+5YQKtCT0otjk10+FdNEYYX2A3HIJ9EXJ6XtqowpBq4g2jW3aCNuLIwLOGNacQvVYlGOTBxo6GGejIcS/00jYOKwu2QchDSxCxxgYfjW42i4Xbq6SQ4fWRUfMwWSrXVsT7x2cvY5uXvDLfh402uStlFWWyox2YIpiSCYwgeei2RoWRiUY1EsVGuN08jvMzmx8bCTMksi9EHdfJD8g4vxWcf/MTKE8tsr1fLl/XKMUP+yaPH08ZRZq5gHf1BtmsAIuLjyx1aruw2WGtIyJfTsH1fGE9rQ92zvQ6NnIamAulm7t+xn3H2I1ldxeKbRtlKs1iKFwMOUHJArBvyBzjzmBDkkchCsrVTiuVIBXr2XuV3OICh1m3EVldRf+ycWCYu5peWoYoTTkgfLmscfm9lU0X2R5dBJexCFJFikZLGblI3LxE2/tthVDdOwFKob9mV5Lixt17M/RxoziWN/+LKtC21xrcU5PY2DaCTJI6P+Cy8k/aNN9qwfa+73Hb/nSYHYXXtWao0NSDCXoWXtvHGWLBYR3qCw1Vn72e5ULXPKRDT9xDmYrOyx3uyY50jq6y/ZH8ZC9Bpf+U8ekT3RU0N+81lSa28MsgGlt0QsJWeiVjuYmAhM1BJ0Pb2MXtzEJKVrjR/eaSw5QkpcCvsi7qePB7t7BGOw+73nce6gWh97taokJag6YE+8ueZXQgGwxKdWHR0WE29HO0NotULyxMQVAP+scYmh8JEvqR33KAy6WxZd8MA61EqA4FxBp7d1vXsKY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(70586007)(70206006)(966005)(54906003)(40480700001)(6916009)(316002)(41300700001)(31686004)(478600001)(4326008)(8936002)(8676002)(40460700003)(26005)(5660300002)(47076005)(36860700001)(7636003)(82740400003)(356005)(336012)(426003)(2906002)(7416002)(86362001)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:48:49.6549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb4f35f-f231-4cd2-33d1-08dbb8459b21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Sep 2023 21:12:07 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.54 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.54-rc1.gz
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

Linux version:	6.1.54-rc1-g89fc7c511aa5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
