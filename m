Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A881D792BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbjIERAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354375AbjIELIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:08:18 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBDA1AB;
        Tue,  5 Sep 2023 04:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge2QYSjn57Lh9+dFcUov/pudprZeMInx+rEfu0if7iQ6zJQVp0go5hDWdCDwp7ci7XAmoy4jOP4p1WCUNDE6+dQOr8VW2rlgfn6/By150BDRlSDmfcTH4fUOECzSuMViMtSXWDYraFhEyZS8sy3cewPE2IsWiTQZtKVxDJK20S3LMz46QKXwwSU5Grskx1qk3dHLBLGRHTea+pwnEe8KArvPIpYkH+KOJroGA2xd57VrOq2hY/C6kAirMv5auZRMoZg+fFSwqbFoEGeODMn3ycWMiq6W+cxcb0KK8piRWIpHxXXBst6tDe5qx7sQtGrDas30jaOuHIYoT1uxcTRSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/63/5LI+OR2/Qe8suMLA2eR6JvsyVY3e8vCVfMr3D0=;
 b=NMyVxa5M6TTtreLYmKORInCAQ/H1EDv3+NrgGHir+j1JZrZlNRUE9kcd74x6AbL5e1/Uk+S2tTcB45mbZ6T3IDsbj0ucAIoCmxRcIj0pSy8SmV+3FM2K7Pgts6Q2G+oQCZNzpKAxUBsxpMr4jknL4A4iUPGo8nqRqUnA93CkDPnur4pNrLCX3SPgu6eqYEQPAy2/tgQWU/yRoBNrRXVNVbXn8eT0gIfkZeVXIj1i+fKO39+EuZof3B7PhaEafVtEBCxRGoxl6rmrQQbx234gq3vi80b/n7Jbnt05Rw+lfwFWgyHPmokEvD6JjTOjUgdigUzJ1OfTLVqF4I0CkojlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/63/5LI+OR2/Qe8suMLA2eR6JvsyVY3e8vCVfMr3D0=;
 b=HvWVQdL/4CZJZ5Lw10MWCLQx8ZwW/UIsE3irxfbI930S8n1M2OoFnwc5LOsWvrluKil7A5Z8gHAneDJnK8RxF/zbL+6h6UtBYfhoTZG4IU37K6Xa/i8aXH6+7crVOpv2pjnfrodQK9xfrTVRmw+XPYukfQtl5cBvr/cxseRRPYM0IyRh0h8nyz3SRRbccwUCg4wwwyIlyZ3/TvXOCl/d0XNs2B72Xb5mSDhoWHKTrwq/oQGEH4p1f1tGJxIj9/MRbPg1+zmxVcXEPQo8yiBCApF68LIilicjo2noFUDtmCjwXV+EwAo3LZDT23D4cOALYffvtQoUIF/vRhjgndiJtg==
Received: from SA0PR11CA0193.namprd11.prod.outlook.com (2603:10b6:806:1bc::18)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:08:08 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::76) by SA0PR11CA0193.outlook.office365.com
 (2603:10b6:806:1bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 11:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 11:08:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 04:08:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 04:08:03 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 04:08:03 -0700
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
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
References: <20230904182945.178705038@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <4e9b3e34-640d-4048-983b-05410a8a6fe3@drhqmail201.nvidia.com>
Date:   Tue, 5 Sep 2023 04:08:03 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 786362ec-050c-453a-c864-08dbae0062c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25lhQoLesUL8+/59rAXjsCjVKNEo6n4Ul9peECpEqMr38g9qqD4ShgF70pWQRE7JWgOz+luD9ZLl/Bsw1tarRKe3JSeVSFp75/wWliUpotpfgJomW/mr8yEAxDWnNBTxzwpVpZYEtKZsRFpn+4XPHkc+ZQEgA0CMDwIma2phmP1kSluevuPWRV7W5wSA0TX0C1rlncUG2cPAcAGZ2LZixS0jQ6ADgF7/mN3zKFlZFnHxhcXVDW/EFc9PBsgt15Ez3TvKEnkY/7qVygQHqz2Qq8elj46qx3CHNh5YZV/1i9C3U+pevqGow5g5QwNwkFjQR3qJJxlVdagVmcGmxL7z4s6hljV2w9ys9dIMoYdFbFeTXyPvvcAlPiUa2ZEL1zi2+wvnEX1QkQLbAmqUve6EOI0a4U4ghLDlzTS5QBlCoeDY4vLoICG853QkPcZg3qPDIoJkRAQ+ct2vizfp2D2/zKDf01RkFRDL+q6YbQVyFb/TzMiiVkRZ/EVQaVXq2kgwpL2kLn+wFLjF9Ffh9TCOvgK/nvX+obpNKihxhKAaWoL4a9lA+u2nVkh+KveQ0feD09XS7RDEu6YP2OMKOGni0Y1zhFIAZCNL4MN5g17bCPVO08e3EMDxJGxKcbX5t5eoS7vJOPSXj/PHAkaJ+Kc+UuRyZlYmsVm1Iysf51jAFinABunmTH7pQRHeoy0xk0KFVs2vxF4Zp4dqHuoM8Eyqlcl4mcmOF6z2sBNWwdpzPWbJIeduDKG/qFaW/H3Tt2eGRzgGNJ3M2gsYanNeqpo/YVkIPEa1us2uwU6wMK15uWU=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(82740400003)(7636003)(26005)(478600001)(356005)(316002)(6916009)(966005)(54906003)(70206006)(70586007)(41300700001)(47076005)(36860700001)(426003)(336012)(31686004)(7416002)(2906002)(31696002)(86362001)(5660300002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:08:08.2365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786362ec-050c-453a-c864-08dbae0062c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 19:30:31 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.131 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.131-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.131-rc1-gbec292fb85c5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
