Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADD578DF32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbjH3TZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbjH3LEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:04:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6BA1BF;
        Wed, 30 Aug 2023 04:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyE2T2lzg3MjX/bTA8NgggOBpzqxcNKzkOVrZcGalWEY1QVSkwfLabKMtJ3yFACK2tYyr3crYwZVAFQS3QnMKNoYeCRFhqKripAJj64zqvI5KAf1czXGRDvogbWln9N8NzMQEMVwPaxIdD4s5104hGnlAg9j4nq3wBvC9O0wFG6o94N1doDvlZdtTz9dM9VX2MRngaP8jYXMEpKy8qRXnnNQQwfxdg85PwSsp9jvi+oS6eeqHeo34SuZR2rpEvcSouFsnGKciJGlhZYoHHSL4C0vrrlzU4N62KfiFVzROHUE3tj64DnFoJ9ZmKKRXalfBBLPMb1EAvW/9HUEB9tHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nECEdp4aH3rrrc66HBxYenm/cIoxKv+pdMnAKHE6mUk=;
 b=Z6fKFjg04ucJXmdB3mUHWNwfR74rfr6XYZyLa/MzGima83SuEi8aKBsTpPzN0W5tHIIs0L4FTuIDyDaaBYU/IZcsBXf6+GqIwVbYzUXWn8P4wZy7I658qxz6tubpYRoq6pHBc5gdEmdYo8iLWGGrW06n0nVgPU0IcFnfSri+l6LLcL09LQca8pVyQ/TIp6RkSP5B7La/MTm5G6btXsPncDL7XqDMD0jW6R3v3mnrFNCu1JtJEk40Cy56z0kd4OHj6OCpUfMeuvZzRJ5RqBu9NOA+eDOF9dgzXuO+WWB6Qi1QcCJrkiccGZdZT6/si38pzXEfAM+kagjwffd4OVLCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nECEdp4aH3rrrc66HBxYenm/cIoxKv+pdMnAKHE6mUk=;
 b=oXvdmFIhEvA2P2KBy3PXaP9W/eQCKVNrCVvg9vyE09OEzU4mPzp6cOgFeJrxYgtaLnaq1rgNJHF8TQm8ky/OzPWeprQo3ZDS6k3JpXRfe21h641sEfqdVwXzuJ8fT5UGqHvyGGVIgofJM/e2F7jlqGav9Yr6Xw1aRfUgLBwCXCif22kDpAUUUmK7nbho0IbHxZyJYkKVSjv0hU1/qba7MqSXQJrv0tAETqy9fAQjAwiRDY046wmmq6QXN8XUYnBpNQHpQlLz36VoD6mYWKQFxoe0ixjrzPh/nuHqtUh+ejP1gsxzQ0sBe+LMQadCovMo1rzasinaL8BcODBwtyEhgA==
Received: from SN7PR04CA0020.namprd04.prod.outlook.com (2603:10b6:806:f2::25)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 11:04:30 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::71) by SN7PR04CA0020.outlook.office365.com
 (2603:10b6:806:f2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 11:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 11:04:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 04:04:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 30 Aug
 2023 04:04:17 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 04:04:17 -0700
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
Subject: Re: [PATCH 4.19 000/129] 4.19.293-rc1 review
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <20604021-9f6c-4c11-9335-cc9fa10d7c63@rnnvmail204.nvidia.com>
Date:   Wed, 30 Aug 2023 04:04:17 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d915380-e53d-4b71-107a-08dba948e298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9HqOhyjYziG+Wga7L65L5/rgysZezF/NBF9LOQv4Sp33ZBv+IrcsHRFLcvLVcYav/tj3N9AfO46r/khlbOeZ3H3hqn/TVs2nLW95ja1Q4YblwhRzA7rKt6fEHq2ydg+qACnTXiFMvB1s1aduh4p4mJpyZOs0i65PrSFHcgN/kl0jalx7Jtvb5khQGpK3SD8Z97Hug83qgubq2dQKHrz4DPYgUz8+63kE+fucYUxWz6xMTiWK324dJjzJmEHvW0dyUowxtrSa8vXj/KQ7WvfdcvDhTJdkny9nq0AQAZrlb60PjSilnht+ZkdLF+jh3Llynt7878TNUzJSupH0mZk4t3tTTFQKix4YwAP+c0MSBpZxEVzg1QgQLi143RmeeRrn8NYmxM1Tx/qSiJGJMXNHxrRG+GkYfsUHXlLDvicHvEKS/2xlNSfmbo1ktVBJeQ9La9CCu5iNAzsjQ/wFlYN2YSQL4MfrbShzmWGeVv90tjz8t9Om0dyQ7Ct/hQlyXvkJAxTmeRbqSqZZwNiIF/+7guDiCePsAYbDtHZ34YdAuQF6wxOYDXuYrKbEMjlqVkJLdw+rz5M0MGFdYEwe6JTjrv6aYWdUn6J7UO8pFuWngy/2CshS6LLpwhXk6uG7E55cqvJTIiSRGZ3Sjf/je7LOo+17LqcoVcOC/DkqjGjPDba8WZmi9BzzkAgNATm47Bf/VQb9zUrY4W4+I6bFip6KIuU0q3I/QLhpX9P9Nu+kKpSXMnpAsPWFbnN7Xbx+D1SmxfqOXZ4cueD0OWiUAIENXEmchGyYZlCmdJozj1c1Mc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(5660300002)(70206006)(966005)(26005)(478600001)(426003)(336012)(83380400001)(8676002)(70586007)(6916009)(41300700001)(316002)(54906003)(4326008)(7416002)(8936002)(40460700003)(31696002)(86362001)(2906002)(36860700001)(47076005)(82740400003)(40480700001)(7636003)(356005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 11:04:30.6006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d915380-e53d-4b71-107a-08dba948e298
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 12:11:34 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.293 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.293-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Failures detected for Tegra ...

Test results for stable-v4.19:
    11 builds:	6 pass, 5 fail
    14 boots:	14 pass, 0 fail
    24 tests:	24 pass, 0 fail

Linux version:	4.19.293-rc1-ga291d82603f3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Builds failed:	aarch64+defconfig+jetson, arm+multi_v7

Jon
