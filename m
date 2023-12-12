Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0B80FA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377766AbjLLWSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjLLWSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:18:38 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C9DAA;
        Tue, 12 Dec 2023 14:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJVW+FvGMMsSpLOt5PzZypINFEABHAH1ywtZim4P5qKQARpG9ld8caAArSKuSrj0vjHpWahegALXAPQFq1v/PbWbgNo0XI/WUf792jzQeSdEeEHvSLFcq9pWzRrZ8v+FfVv/OSdbLpMoFE5+f1yYI7BdasLP8YqLCmjw07NLn8nUM4S95DJ8DQUQFJmqjUMcI57yaqsHFTJNYbfnWI9SslLwjw8qwfIh6gbkhi4/ge6mZ03ke+WNKVCDYdXL26bJP/QrTocOca9KoxWE9fbtmZd+3FKQ9JTWH1CovrcGd1F1jPLVHM34QHbwKJEaEo/kSSX19dC3yXP0YDLkwseTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpdYe3ZMLf7fVQ9cJcwJqSvnx6knyR7RMxE4UsL6/g8=;
 b=J5aLSPLDzAH5h1vBjuHbR1F9J5Bhq5Ym7yJyVyj8YhoK6NJL384SEzCcmPTjSn4YPk5D3FQt9lcfoLSm2p/t0QaH5bXhpY4Ds407iGLJc7wU6TRSQof3cmSxLNGN9Ozz2VjwyK2C+K8t6nao4lmuunRSZXlG7vtyQtHgLUEsKUTRVuLVwAruShstdCDSmQN7Jzxi91zrtdk2wU9qLmjBkEIgvXDVDiF15l5eNbPQTeISrXWzsBekb80ruUdiTYgpcmmRM03tUa4HotXzBEHJYtJB+LBgNnmg5prf2BGxSz0kVtQ5t8RtUeABLJZh9OYDMZD2TqgayDoR6b6pbDMUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpdYe3ZMLf7fVQ9cJcwJqSvnx6knyR7RMxE4UsL6/g8=;
 b=jbmtwUByGklLLmss23J+irkmiCBZVdNpKkGo9QylpaxOCVyjH8npQZsaiDc48sNWke4rr/dRN7I77F/PxS3+36JxTgBski5YR2gx5JFk1CZGbOJzVVVwq6rQ1OWMm3n6gFPt6AFpAbDozKthIC5XIcwygEpdfC200ejgJNM1IAbUloeY1dGfJF/tsY+mtasrPhERupiMN7t+rm5SA+rz5Ql9K5ymjpTsJSttSb3S07CZOEtAkY2fnyBj8sFNTs7O8qA0l43aff9GVHSK8B75JKbmkYgXiMPoOhDUOpvtL9Y9RHlO39WE8sBvX0O6iZmkqfBlBCj4b8X0CIoZv6PIRg==
Received: from MN2PR16CA0034.namprd16.prod.outlook.com (2603:10b6:208:134::47)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 22:18:41 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::e2) by MN2PR16CA0034.outlook.office365.com
 (2603:10b6:208:134::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 22:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 22:18:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 14:18:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 14:18:17 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 12 Dec 2023 14:18:17 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/24] 4.14.333-rc2 review
In-Reply-To: <20231212120146.831816822@linuxfoundation.org>
References: <20231212120146.831816822@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ed91a245-88ed-4ac2-802e-3b417d5c9cda@rnnvmail201.nvidia.com>
Date:   Tue, 12 Dec 2023 14:18:17 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bb482f-8118-404c-848c-08dbfb604bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfZTCfzGfAuKEY4qEx1kpjcDUNUcS89jC/SbeNnGP7JASAZaKrLNv4EhLyWJS8b/Mqcjx61qkYkDcmMjBUpyzyruXKcSeTtNxJMVhRXXCYfWfPC2gqnxz6JW1WVkxI9vVAb+IptTevlO1I1L/OdPezbEjSdCj9b7g7djS/7fmYikGs0LYoeZalAqglV+uBmIn+6BpwuxgQ1yC3/Vu2kyyXKzrxQfrt24aN6OrEOFOsPlrwxEL7QH566dbQ8gMD/CmPxpvcu1KhrRVp9vLAFC04tBZ1NbIrLcbgW8FVWuIzt8Jjw4dfwFeO6eknqrHhnBD1JSJmSNxZL8QQRKNCfZ64X8k9G1qC2ZVSCKAc5huLZLrTWq7WozeXj8Z4r2MvL3PQul6URJhNdPjP/a+GWJT08KedieuFf1HbBX98MEekCd1bbv88ozT/dX9G1Cb3tLeBpc6CihjCXRrFogmMJabgh7vBUCqM5OT09Q+qEBDhkYjcuTiIIe/tppUwoRNCcghBJ1sQbROIvOvQvbYQ7icU5D4WdWjy9JNQ3r3uwyhwZvcOuN14d8N5TIwdPFH5pVJS+TApAgYGc9MneA1UJ46AoQjUXTP+YTBGq2hwhJivUoBuP9hFthdfRLINwYvv1pgdWHTOUld5wCP5T8WJAe2usmGU4QqPhfMxqtJiFtOEuQncE2ZFsN+0fx5bWMZL9LHpUu1r7o2LxIjXqzeR1AE0T6+ixdKsAEgmq2/QpxT4b/HotqrsVzRrR/W99Fe3qdx99XEvoFqsuMTJwFQakqqgpUH54jF6+IC0eVbOXKrwM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40460700003)(336012)(426003)(47076005)(36860700001)(8676002)(5660300002)(4326008)(8936002)(26005)(41300700001)(7416002)(2906002)(966005)(478600001)(316002)(6916009)(54906003)(70206006)(82740400003)(70586007)(31696002)(86362001)(356005)(7636003)(40480700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 22:18:40.8742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bb482f-8118-404c-848c-08dbfb604bd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 13:05:03 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.333 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.333-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    10 builds:	10 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.333-rc2-g68f9b81cad70
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
