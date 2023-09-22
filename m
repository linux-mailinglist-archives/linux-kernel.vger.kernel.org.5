Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEE7AAEAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjIVJq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjIVJqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:46:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1936194;
        Fri, 22 Sep 2023 02:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arde1o3R7XGmDtcHhWW8uv2i4hhAz9qWGgN3mO0hmEO2nT3bD0LuRRLM7GyfgbBGoQSrVzHk6cdSsigjt42cEA4EgisKwhU7U4YCLbbxCptjguORf/793wdAOq7w0Hl7kwM5YRWH7n/3JrziAkH/PeFjHlkJv43ItpXkMph0Ic74nJKxDR2WN7o5P9Pzbqy4dgroVaTEsGao6JK169qizqlFHR9z2liCFySh6Fj/rbcd+inbNhxR0LJHB5IEsMVWoYw1ohXndIUkDHSLRtXkGCGcs/TxzzanlEUDqL0udIBEdx2JvoF2CxYflH1+WO9z6kjKtSg8VGNl485kStdZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYtOg16qSiJAna891j6bB4LdVULa8dKyoEwFE0+7KY8=;
 b=L6MLfVuSjgpWA4As9tXve/sRaKFamox6keTNHmix13dR3egWRWmd5so+wuC4UY5KxlTpaEs62TgqtCxRhJyscAhUj3+B9Mfxz/J4j3rIdMGnk/UzpDgYLpj4B01KzVOlNbMnGyB+gPr2UNR0F/iVHoqtOyqTJHrB7aAtbc0DIXJWKuRDy8wAR7YNPM5B12DzaCF5GPYZlpusxh99SiOoK+z0A9uaaNbKxCZSISdPDXuJ3mphbZqBZi9Vv8nbmFIdgFq8GI4v9BBblt5DH3DxNZdDMBY87mQBolB/qkMxD/l2dlew/h4YWopAddGiZBWSdL9fEL91LP7HAye03K+wdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYtOg16qSiJAna891j6bB4LdVULa8dKyoEwFE0+7KY8=;
 b=pNePm2zt51qe6UljWDCw+TneUtCXs0sb6/PFiVQ3hrLhPhX2dWgAtNvHt5o5nCmx3p41te0XDPXbOI2n5cAjwO1LOWOBCG+OR9Her7JITILKjzyI1tmlUOkaEK+o/c27ZR2kIFEwygDPmvien4rN2kATIXbxFdQ/5kaeODJrOeXApOXKXk/E1hKXZhW6taIUDbtbU5+DWDs1LOyVSXClWpJT26dvtCZG88iEU5YZHxKumo2Q1yTTbFv1ckT6bgARmjCMXGikQPPWN6z6JAJeBme8xb380Gt83Hyv9EbaFYPWDJfiE6aRO0P0UBiTTes1dTzK1o/n5Fhupbtw8XIeNg==
Received: from MN2PR05CA0032.namprd05.prod.outlook.com (2603:10b6:208:c0::45)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 09:46:31 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::78) by MN2PR05CA0032.outlook.office365.com
 (2603:10b6:208:c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.9 via Frontend
 Transport; Fri, 22 Sep 2023 09:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 09:46:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 02:46:18 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 22 Sep 2023 02:46:18 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 22 Sep 2023 02:46:18 -0700
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
Subject: Re: [PATCH 5.4 000/367] 5.4.257-rc1 review
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d0ae0219-c287-4f38-8f75-443e6b031543@drhqmail202.nvidia.com>
Date:   Fri, 22 Sep 2023 02:46:18 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: d90f01ff-6a76-46be-1634-08dbbb50cd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/ih3sbKLqCTuvL/ywmMYSsChsGOT+EvVR7lkWUxcMCgj6nb/zUMq0XXTacL8+tygUkHCio0pghQl1JEy86RmMF4mP9AVHEhRPc0jp1HV+3xerwCBrx0cNaGfMHVbLnQe7ntk+emZytUclWSAiiVCMsU0C50c7dkQtunfXnVOkoQAsilbTOVSTjGsSuwscNp/yDA4+AdtnvLsSkaMCO1N9u3IDtyw57KVj5bhu8SfiQHkDT7A3vJBQf2FDvycC+MBo4Bt1kjOUPMuGhWNxdjjkPDEWK85lE2RdEztDLa2FV2ujNV/AmXBe3LpR4G6jY5yEb7o1u7c0dCPbzXaOLDPSd1QZA7fHaEwBYFSAiX0fCdDaaJ50aQvok3NNsePfgvvIk4hOiDd7dNLigcvpgl54u83rSsfIDUKScsS2t1Tdv4GVIOR7W/yhlGJ49Uj9u7xO8D0vr32c0bfuM7CC5N8UwIf0gVOBb0UUE5Ue91ApiwRidQsep5uDMcDqGX1Ke+P4x7HqStuqy31I/l0nOcP2269YfOqf1zO5R4I5Ni9kWtwGgoPZ9axrWrLiHn8arGs+6aQbgR7szFa2awJmLWrENjpxjdXF8gC8YtD5B7nsLdBI0o666gnqujhuVlyfxB65yYMM5d5qVWOGWVzvCKHgsB+/pEpnjNmOMhBlR2tqLn4azTLV7qHwJbjR/P3HOjNn1x+OnoPYz67N06x7Rv4hS6hyV5py63V5Gcf9qSexyZW9AWu+kAtJVPejplzbrMua+P7yoBF4sHybER4KnQUqUH4H2/ielYAyUZcQ7OKntUF7KBdAirmC5QYAL395dv
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(230921699003)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(8676002)(966005)(478600001)(36860700001)(336012)(26005)(47076005)(2906002)(54906003)(70206006)(316002)(6916009)(41300700001)(7416002)(8936002)(5660300002)(70586007)(86362001)(4326008)(31696002)(40460700003)(356005)(82740400003)(426003)(40480700001)(7636003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:46:31.4326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d90f01ff-6a76-46be-1634-08dbbb50cd1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 13:26:17 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.257 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    11 builds:	11 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.257-rc1-g831ef442fc4c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
