Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9579D47C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjILPLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjILPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:11:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAFD12E;
        Tue, 12 Sep 2023 08:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDNSrhezRO3O4Jk9xw7eJlBBNj/cbm6JEJfXcdz+e+6LQZtxk2ISDTTKXNIDzCAE+dD8OXsrakB2qGkEEIEQMDhPgmIRoMXjEr/NSRZditJYHTJjMjDQjdXSMY2kzsuAydmU7Zmob1lCXb3EOikNskfdlUK1Q2XYd9Rx5blwoonzSBG0hjFqn1tfWxQAVgHZBOGyk6nHbl1jll+URqowwlXjV6KOGa8599jsYJRmB0fGfKSV49DJoqbxTv4hS5KIa1fOuRwzVCUSBDXhpULsabOA1fTGNC6rB1m/WLTEVRgjJmOWzWzwxsjoYKVbKtXO0ehmLDA+wYbjxtq/BcM/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY7h7OH+dsdqAKv4S5RVvdPD2IxenqnYbZjLAMeOq1Q=;
 b=Mq8vnkCuHa2g4FrXfhFS7uqbg7kMUuNDP5t94FI2/bCNusAugwUbKBIrxOVZw4CfeuePZL7SsoIOdab5f9Ind2itLynRHgLwZISZRd+O6fdg9yPV8rzce7sif/OsND8U9Fumt6905iT9R2v+qePhwBA+Oos36aZZSBm4Zcn3Pzm3R6FUfMJrFCHpxKBGXPD0O+2q/Etxrc0rLTyVoAukTpxR9ZvE0Cl0RgNF0Ki4btjYCgbkJyOl8DU1bZYHtAW4X3Vc3Zb2HlKBs3/XH/2E9Vx7w7axA6JyU1qQMtKLooBG4G7pF7bXpp7qIDpLsJ6ERSbogDoLHChdsoVw+ReUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY7h7OH+dsdqAKv4S5RVvdPD2IxenqnYbZjLAMeOq1Q=;
 b=P/Yf5mAvic8OCRyrBKyOTHuFbUxgw3reG8QacK7lST/ESILqMJsjOgok95F18VanQ68J/wZHpdWbZLtReG7RmuP6WPZZLox4xU6t2RE+GZzC1niN1JKyTKZ8Ii9DZvASQ9NsWcp4840p+5dilphqNslXuuRTBK3uVydLCXN/ESIN/B4/9leXLZ9yAFi0Q16FU6JoyCk+pucefwqPVkP3s41hnyaiQ/gCKqHFXQJkgy5cHAGw7C3yKDS48V94V05cOb/MMCJzG/u2oD09IU5MV6ulDgI1Oktl7gfXuqHrDQNkHtlbvpE6J9FCK6htJ+wPFLDLnIA/OzJ/OxtzypI8AA==
Received: from DM6PR06CA0010.namprd06.prod.outlook.com (2603:10b6:5:120::23)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 15:11:22 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::5f) by DM6PR06CA0010.outlook.office365.com
 (2603:10b6:5:120::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 15:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 15:11:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 12 Sep 2023
 08:11:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 12 Sep
 2023 08:11:11 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 12 Sep 2023 08:11:11 -0700
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
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <52f5d4c8-d80c-4ef8-bc0d-2e4197d44408@rnnvmail205.nvidia.com>
Date:   Tue, 12 Sep 2023 08:11:11 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 843fffb7-b724-4d9a-b354-08dbb3a28673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlXjCpnLmIzLPZu4koJXGYLgX+Xmhx4JDpBzU2SSqy8pvDZ9FmQJYbybsT+CMAkNgBLXqqrFBt02N9ylaFG0jpJONYfYJtmX3WcWASn7hhOwftDpeyyFmcqWwIyEFFDcR9ohkGxtCUMghBwW0lLxQK12Cj1PtyR02jBwhlcYPJ+CIyyd8S/+ldvxlIvanWCnmqc1hSXgP1YT1T+zk3J9+ssDpSyrOtfVJQVc62CK4sQJuHPhbR2B0CHbtYNhYmdPP5ZoFakpPc26d7BxksrQqzl9XHjjrOFfDOnDWbqT+kApvTzjBTFoZLzDPkj0DRZD4tywEymxyApR4ZMwQpCYq2YMLMP0WZEJBz0s9btO4UsonP1dowQQ3TzI7vh2vRvvvG2pqYkbvQIBEwzKIBMAa19SO3Bw/r55o6ab4zJ75GHvol50O75HOF2R5CFswsagdDQqBr3UHoU7Kavw1vZiCAtx1NGcd/U7EaPqPU+lFm0g1fa0y1SnQ9D05E7xPbkFV0TFgVoYgTSXoYFkUQHihTDmmWmZyfCleCfzM1n6MfVziwy/CcJcccFYMUZLg8PQTvsepcI+eqDNwCJHZu6QmfTyZ8InXv/GJycL0u657teEoGUbVeMhocp35gw2/X7xQgfQCIT3nCOhXiFlPXP0P3Nn3NtRTH6rCfLVb+j+MqlemoQsVfrnPrbnlyGT9BnieXARtZfPHbh0ZW24rttftrB/AFEva5vrZa28Hl5WTrBdBHqhZQTE+46z2a0SGkTz97TvEcT87+Wis6lblk1p1tAWN/4dCQho4WWElEPIVjU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(82310400011)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(70586007)(40480700001)(356005)(47076005)(40460700003)(82740400003)(7416002)(36860700001)(7636003)(2906002)(41300700001)(70206006)(426003)(336012)(54906003)(316002)(966005)(478600001)(6916009)(26005)(4326008)(8676002)(8936002)(5660300002)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:11:22.3298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 843fffb7-b724-4d9a-b354-08dbb3a28673
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 15:36:39 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.5:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.5.3-rc1-g7bfd1316ceae
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
