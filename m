Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2F87D73B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjJYS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjJYS6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:58:02 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD361AB;
        Wed, 25 Oct 2023 11:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgAHPkqvfwCRLaWlcmYFMPN0GbHGTWMUXXDg4TkiNRYxpTMSarCn/nWx95FmgFY0KhQgCCjxyRzYJfbVi3TOKwg/Y/QQdIIK2l/0f2P/eeOrsOlE/1t9RnmJA0tRf3ZzY8JKoTacPie2Q7bF1g7gl6y8sIDVc5Z7I8esX/pZS3KdljXIR+zxzvixd+ufRt/ZdXZpw+hLPpZqBJ1/n3Qnufp7FYRHe7KR0E2Hjh9PvMiRq8W+KJbBLZ3cul+QFGvnZ9AE3MijSIxJW56NgCnIyjW52b7BS1596TchFRJHldnHVFg0rT3Rfdv7ipKleglJxghhjh5n2wazFfuis+1aTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6thVCJ23DbrfqroSJNs2iKOQQjoSF6p43GKFW2pU8d8=;
 b=FE7pZlGoc7yoBMm1e8pQaXzvEgRrA5pLMWnBswshNbd9CYPZV30lxsYvKLEdBKMApdy2Q5gx2qz2nx6bJy41VwrYk39tzJVMVuO0RdesEnVTRxwpLBSc1KzfXBvorWb6kftBdc1Jxg/pG2k6PQmweyOCF95yaglitAkfvqln7RK6qkF3KpHi1rxTinmcme9HnrNCPxihuo/fZbMzFX+YAcWQE05jzK/DaOLr9W/XGvpsl1dbVqz/EKFI6rxDOXcpRcTu6uOYyZpi8r4Q6g1mrA+tTH3Ild/g/gRBSEo5FqOsSzZMFt/EPGb6HYg/CfZ6Al/LYImLDrPf/0bOakyxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6thVCJ23DbrfqroSJNs2iKOQQjoSF6p43GKFW2pU8d8=;
 b=KYDWB7GaGF42KRfd6D4ULx1vgljjc+sfz5FiQ3pK41S8HPiUL004sMDvR0DAZK5f/uhPcoG20lH0EwUKkV98WDho6ay9HdchlImYpb2De6Z9QAmnv0APdrYUKWY9yZqwgrseNUrMiEVU6sv1IWx//LgBg1IS5Ee+JzMf7MZMUyI3zhxLoCiibfa7FH+drsZoXpDR/Ahwo9QbNdqFxDh23VxMHvd+hHShCAepQgVNYtpoVHTU7gI6WfeX44osRAErXjUVHi6jO09ah3Y1G/yCVq8gfL1Kjid4MGrorA172rdOKlUtApCai/03zVpRJtxwjrp82gyrOE2MwetzpjlxSQ==
Received: from DS7PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:3bb::34)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 18:57:56 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::fe) by DS7PR03CA0089.outlook.office365.com
 (2603:10b6:5:3bb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 18:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Wed, 25 Oct 2023 18:57:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 11:57:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 11:57:45 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 11:57:45 -0700
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
Subject: Re: [PATCH 5.4 000/123] 5.4.259-rc1 review
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a6ebd9b0-7872-4800-97f0-6d4cedc20ac6@drhqmail203.nvidia.com>
Date:   Wed, 25 Oct 2023 11:57:45 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: bab4d28a-97a5-43af-cbdb-08dbd58c4c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pIZVFAjFDCPXMbIiOcoh2sdhnqPnv1XDuFbV2LSJ9KEke/K3HdmFZfL4VAVj8UYCOsuUo9+P6zW/fAj+62sJJyl43GQDhu1SS7a4JaLfuK8DOIq1DMQN8dJE8m4AJc3z2+1vHyCc82G2MQT74vSAYN8Xz2zSv/Wgf+S89pjn1WPMwbp3LdK4MVYaTGZMAEsqq+krKCpSxj4Q2iWILTs2r0sLcYXo77wmxr3SC4sqyVbJhckKe4J7EShgOMl/vv/7LxAnUmflEulo8+yPnkPvnTJ8Uskk6rUv76nFuwz0DR1Z54wjIOYBX7FiJJmkuxdvNmQRxJSyqrcbyXyBaflWZQVFTMe6LLNvJxvReLeMMfCStKAlRhOAtbW0q/rIr06QP+fN/M83ORH4xHGVyf2ZKOWbif0PQpZl899ok4tsFnyVLLXXNDf6TkE9nxAZaVWovzi5j4W2hs4/i6vDDJVPC8UGUuzVroDtwf7httWM6ENslKUk2HDBa7Nv3BP0YprB+lTbHGHQ6a0jGTqiRHSB7nYH5hkVdyCtVXMAsx/LtR647/EWlMuaWO+4zTKsZfo32V6n0/YdKBtk2s/ifjb3LvitTfT7m+Nc4sWoNSIox2qRN5ar9bQ7pmOQmZLejS/nfJijHUcKrC0wpyNGHe9uBiAv6+SgpJoBar0YRgS32ReY5X3tX9nvZSNEUCkQbolQwdmtCot1QN8s/6VeP9HezhML0z/JeqSTHxKP8dSgk6jL/V/sDEmPCexGb5SVRsqoxiCCtAWFHm5QuJiDrjHGpUfQLOxeLoeHC8hqIsfuOY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(478600001)(70586007)(70206006)(54906003)(316002)(6916009)(966005)(86362001)(31696002)(36860700001)(47076005)(426003)(336012)(82740400003)(26005)(7636003)(356005)(8676002)(8936002)(4326008)(41300700001)(7416002)(5660300002)(31686004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:57:55.7756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab4d28a-97a5-43af-cbdb-08dbd58c4c87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 12:55:58 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.259-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.259-rc1-ga8161789be4b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
