Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A9C7AAEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjIVJqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjIVJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:46:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140A419B;
        Fri, 22 Sep 2023 02:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmqS+Mqi259inObY2Rjn/8O0c0jZ2avYyszz+R0nciI38uVDsuRaClG1jwmTeX/Xs7x5Zxpq/nnCtNAO+7p7oLD62VwlQXk8m5aYRMDajRlOmNckq6ASSie2u4LqaPij8HcCqYJbkNcIvkq+ypYtnYujBtH1M6/c3ohBu50+qb/yhrj0gUneVhiCKVb04p0bAPxDOgU5HHW3zlXeF1pRCZ8ovY1RZ0GxQdosDemCnF1xw9sPWuE7Wfu6UIssfSQzAuO69rlM3LT8y2NOjnPlP5h75WO7bXwfFYSLMSbmoEBGnUhevxltnEYJ1SQM/VtEOJhvP3JMrstJv/wH4N7h8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap/koHPqMVKIx1jfNKk7VWOhpJyZlpxzi4WqdPxgK3w=;
 b=jvntIupsLWhm5PZJLBXgq3JRae267HVX7oI1suudPuB4JJjtVBXgFN14wJjLnV3NcG67nDizuML38XTGLOB9IlV2qSdM3oZoQ1DYQjxa7EHMDH7DTrrvrLRBbgTwOnuASV6kL1i4o8S8J7xf2wXYAbGsdcm6pDb75g2l5nCze4UzEYnTkv6lZtx8NYEWiPsv+J7dEPZT8DHcy1NdSMWB86OYK5dRpzPmxZOVz1cVwipCnfHPVdo4T36jayHmMr3OSvwGSdR69vSDtDzJwHKfxbp9Ec7hLsW6rtDSuqahehFevo791DR8eLMfDHxV23UwkP1H1w3e7B26v87HKLVIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap/koHPqMVKIx1jfNKk7VWOhpJyZlpxzi4WqdPxgK3w=;
 b=RW6h496O3Vz4XNOfNPKKR3QTowHu5Mc6znnt9bJGtd0t27CH5mGJwLkHvMwAFNP9LEyDXzocIaKlqvAdk6+47dfhMEYYjAWt0e1B5282D/lqG8WH+HSKac6skpw6lKBb4hff/RnwoF8nH/umt4SpR/sbqMMsf+0ml0Pm5p/Z/iQNAqeAjM7LfKDH3XVxzh2Dg7z6WCIgDzgaEFFeTPus2ixcG1x0a5S7nLixWpBoRy6G/HGqHiXzQqL0whRl6Q2keM84Or5wpKV4b9bauvwfAo2X7WwO2Wzx/ZfIDgjUGQDCTsZMLEsdHMZNQ/x+nJwnU/wamAQocZP2ws2Z1Fh5hQ==
Received: from CY8PR12CA0037.namprd12.prod.outlook.com (2603:10b6:930:49::19)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 09:46:36 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::43) by CY8PR12CA0037.outlook.office365.com
 (2603:10b6:930:49::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 09:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 09:46:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 02:46:20 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 02:46:19 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 22 Sep 2023 02:46:19 -0700
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
Subject: Re: [PATCH 5.10 00/83] 5.10.196-rc1 review
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1db6dc81-da66-4d75-acb4-64ec28aa2571@rnnvmail201.nvidia.com>
Date:   Fri, 22 Sep 2023 02:46:19 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CO6PR12MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: 18391d39-9ab6-4a6b-46dd-08dbbb50cfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81fC73owx92JBWlk/EZNb+YMlgz90M4daZqNaQQiFVORgoI62OHpjlkB6rA+bhE+wUb+PtEhRLAeZ5Tgt4a9SkmQ/PGcALzeqkFdEDgzzEoI+pNrBTdvMVrkNKbBgFu+/QXvUNUIQSXdscWlyqIa9sz/wOyAd67Bg+TpdrZ6H5AsEl76yjLa6Vyav0yMEISdACSE53hMBYcOpcQ5nQs2rr4BS/9XQkzsw2lDlNqso4qwsZNBrFQSdq6X40VC+l7frJYinUpwxFHJ0OkG+W+MM0PYRWP2P2QotgoJf2Rovmkq1qBI4UtcFRxRqqxgkGY6fwlf4VzjlkTDheufiHv84IAIdRglteJEfe/NgOSLP5iL7vR//nqjUkPfHYkkitKckbbZ657DK2xWg7nqukYBpqrbG5iZkQgKbv7RAygpA4yY2j+jwEKkFCaZ5AA9/xlfuvndkSOlwN3qqddYOfZteCTcJjtA0Fn3XGOoBZte+LZAyJ7HdoaMMcw8Mk9QiWbB/SUzm0xukuSEwF7NzmcaV3bN1e4G41WXBHreRi4dDLPKqxjBDobw7fbJR/dto6vaJBP36KeERThmUv8qYd61X/WaGSMNhSlzOhG+x1CAunALCrBbwytelbv0aaP7OONJ9J7kedufn3yEA1rJwLvkn5aa8Cq23+dntyscL0xqF3aYWfy0kH1dATxV9rTvfnnPKbRuusRfgg/CnMBwwjYJDtnHEeNfRKoBLnOjPIp/wzam5oXOtljT6K0LygA4SGzYNpqDNtWl449lpgery4iJKPcMJUASYSS9nD8OoKgqwzhEPbdwfMGPxS5uZR6IJ53g
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400011)(451199024)(186009)(230921699003)(1800799009)(46966006)(40470700004)(36840700001)(86362001)(31696002)(966005)(31686004)(40480700001)(40460700003)(356005)(7416002)(82740400003)(70586007)(316002)(6916009)(54906003)(47076005)(70206006)(478600001)(26005)(336012)(2906002)(426003)(36860700001)(7636003)(8676002)(5660300002)(41300700001)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:46:35.9412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18391d39-9ab6-4a6b-46dd-08dbbb50cfca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 13:30:50 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.196 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.196-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.196-rc1-gf147286de8e5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
