Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748FB7BF814
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjJJJ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjJJJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:58:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D537E99;
        Tue, 10 Oct 2023 02:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmYC+f0YbBO6Wi607txMYrGdBJBjjAJx4SAHVjkLWQ1iZJmP6DzxCsbNSpfntxGHCQnbqnLrdF+iutrTKdtCOz9BikDoxp5i0PyJjEcRuwKQyT19qRe6ysvcAu5VNnGMbsf9vAgiXk7SH3B39DADb9MNTgh/Uent8h5UM7YgaU4ozyY+VHg/7yy9N3XGimEnQYHKH/KToTXTTCATKrfwFc8md0A045Irlqhjf4CvYf/GdjK6Azd/av774cUKMZC6XSFF84/I2mfS68ORrtz1JUEBudKoxRMYwDaY5mKwQKpWUz2tusSFI3KZQDnnRCJ2JQgjh+pz4iIDPkk0FUmTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do8XDaC3f8ArsGZ2yeZdej9u+zgjGp5ycDNEwTTwbGo=;
 b=ftugiIxBPcsPngYD7Prw3lewxI+IfzKM/lCVvQR68L1rG4t7H/DraA4pWW+khCCkV9Ywwvq5fQR50UF7HEGXvesJMzMwvoHe+BRZvFWr72JydJInjmZwCwOHf3yOsWZg6Ft4fbUiLbUqjCyIaOmfstbzo4Yr7U+R64I0T54eNHaeNEi2wwo6LRQi7hwxEaNG/CKxkXzDR1sYYIFthKyjm0BlRlyfQKEOF5OTzqYOjJqoYE5JubLUA+unjoHma8eLjzkxF9AgzMuLLGQLIRWfyR/E13TFO1MEpEgEbVhqAj0nRZ0t9K1pJONBxQRRrPzUdseUgDbaejp0kf/RfvOFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do8XDaC3f8ArsGZ2yeZdej9u+zgjGp5ycDNEwTTwbGo=;
 b=o8rJAQg/v/0ZsfgnFtwuDeSvdrecM0tIR9TRK+4xKugbF50ttyWXwnNP5e1s41ZfIDUF3XxI6uajDXUuYr1g+z0X/pSLVGIC55++qrKhCQ9vCryr2pAn6NCAd448we9o3s4jMJhnMMag8K4j4Hu+w+5XejzntNfhw8xpYOgWFCBQjFPSBI+CM87U4HtwcaQlURk/EDIy83zIIclfzl39EionhHYIRDv02aMzVZe4lGr6yaGaGEAowTCg6cuN4J+u/vqZ/glt8wu9e2pozO89Z7HzpZ12JtbbTMIzBoLb1go50kZiOhg45sQGA2oGiq4ZdMg3hWLRhYvqNRGbxbGXug==
Received: from SN7PR04CA0171.namprd04.prod.outlook.com (2603:10b6:806:125::26)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Tue, 10 Oct
 2023 09:58:45 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::19) by SN7PR04CA0171.outlook.office365.com
 (2603:10b6:806:125::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 09:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 09:58:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:58:35 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:58:35 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 10 Oct 2023 02:58:34 -0700
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
Subject: Re: [PATCH 5.15 00/75] 5.15.135-rc1 review
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ef6dd155-a119-4637-a91c-e31ae530468a@rnnvmail204.nvidia.com>
Date:   Tue, 10 Oct 2023 02:58:34 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 749d20d1-ed24-4d81-533f-08dbc9777e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEjLh13VSMufdxgxKVJ8sbTUPCZO5vf158wc5OA3FElB8AdYnmQb+McXZ2XU0ifVsdwfE6tVQL5F3HbRsn25WgBvFdQOg5mQwnvvMAuv0Rsv3NiIo25WRHMzg/lw4wpXE8c1o6BDaWeMw8TIjzc009I1D59T6pK8HodkQdN24rmmafFcc85dDuoAWXCCZsBFctRkcLVPuZfZ1gKe+0bne2/MsBMWzHdsfPcmZq6uNsRdpPETwoREbNB+oz8GyAVuzdaQ57WcwbFyTVpU5XDjHRNFWohaFKEqkYg9S8eBreGVqIa5flvszPlwfzgTjsJ2tavU0gj9v/LQdLQ4zxcQ7qtQaZnqpPpkmkkcNFHz2lQ/iZGyy23OqyQpGByVlYxnZ56MtZWZU0DrqhvHVlNBuIpH8vAbHdt1pJTm3L3Me9CJ3oaMTuod7LB14ogsThmbT8f7FYuuP6B2Vw8H1lhZk9et42Mxx0vtYDXm+cif8JNeToYF26xNT/ZN4KN4yB7q3iPEKml1ov//JtOkIksb7DhxQ3SYOFrFDdA0SjVqbuDID5kaCbovFp7S0hKl+R/6YOee1gn5RKai6yifLa44orR9qpltdzR4SFssHOD3k36X6oBONLQxvpinveI6t1+8+7os9kcm8qzjQL8sicLhZ1lY2l3CEaXfxPPWewOvsB+LfX/jGakIdvEo92AugKpFqWGznlBhOUGO7XStjg8lD1lYjMwg6t7xlcNY/hK36JaaFBojAJcq2IV6daDDBXNOoWzEESRDJcttrDcwzdaE47+B0fmoPTzRDpuy5kZeuC4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(82310400011)(1800799009)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(426003)(336012)(26005)(47076005)(6916009)(36860700001)(70586007)(316002)(54906003)(70206006)(7416002)(8676002)(41300700001)(8936002)(478600001)(5660300002)(966005)(82740400003)(4326008)(2906002)(31696002)(7636003)(86362001)(356005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:58:45.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749d20d1-ed24-4d81-533f-08dbc9777e2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Oct 2023 15:01:22 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.135 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.135-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.135-rc1-gb5c772cb0884
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
