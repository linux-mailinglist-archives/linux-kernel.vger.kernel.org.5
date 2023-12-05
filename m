Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EC08051B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376933AbjLELKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346764AbjLELK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:10:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8386181;
        Tue,  5 Dec 2023 03:10:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDqa2hWWdNYLiiqrA7xzTF4hcMY33wcJGCa2pcctUEkjDAbbVFB1U8BUT1dawtiTi25qc6Vqy6nwoKRyWUslozBKDvogbKABWS47bd/ugGo0Lo8SGlKkuDSda59ILJEEigbg7PASz2ZdFQCQcYUyLBM6P2Ir/t6aV++zkK9HpbfV/Yqb1h415/AXmTPlHLCfEX/cWmkHw1LNRCYqSeeBEMSvyxGzlGWRGatvBHfdTcuNthZwKXdQZtO3wksRzSgThJFwFs4ATzXc5/fUV7NAG5BrPZ4PTry8OyfXwQSUWj0ii/5UzN/70w/CfDu9MUaa6BoGYKAc0/yU8gZU1pwmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or2eo0qCUXAUXhVIGjzDjhf4BrSnURngCTYFkBDdnB0=;
 b=dEBIZzMqQDDTe9ly7/Hu0azTdbZ5UDualXs3m74zyi/WdRdBuCGytV/vMTBnxEWCvwSVIKcUDqrAycyeoeU6LPzFtPZX1KqXpRr1mMD0Pti6AKPTf7eIXaICj34qXIRbv+tfHlXsNVQ4D46TwexGae1b40YYAcgpGh5JXvE2LA59W/Ncl2UdQTsq4btNnGi+Mvl7a1R85qVZ6ewgq+B+HZIh33epRfr7I83RT/AwvcQrnkKvJdAgz7JNBNwFvE9mIc3al4kbWS3t9zQ9KyPz89+UiQlm5/V/ccSFhGwyQnZ8os8FumJ1reMbkqYv/9ezpAyu0gTXQYY7fjlJWP3vSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or2eo0qCUXAUXhVIGjzDjhf4BrSnURngCTYFkBDdnB0=;
 b=HUXunLhrtz244VEYCyo3yRzG4vCvCJElAr1nLl3UIxb/aj/5UCsMeYjZG4SHxpdEJWnFcqa8HNSD+j5gh/yKHdYgMJC+znLATo4IOkgrvsdUyB17Iu5qTKv4wZU46T/tnDtoW2WCmCZTSP8f8fyGWIYMWgweKpw6UmMcqe5WYdIFYT/LkeuNl23M4c0RsoQoho8p5PeCkRUHriWSy1Y4kVVzvNVvaAJ+ooABh38yJsice4sEVen1bcULPGfiOL2w6kUy1UU9u20X8vCJXcv4mBhVGTVU4ge2YEXcy+8dOXYR7Cwo0+eST3WKoFV2fbwFPHiQqbKdJ9PM/A37Q496ug==
Received: from BL0PR1501CA0008.namprd15.prod.outlook.com
 (2603:10b6:207:17::21) by LV8PR12MB9153.namprd12.prod.outlook.com
 (2603:10b6:408:185::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 11:10:27 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::df) by BL0PR1501CA0008.outlook.office365.com
 (2603:10b6:207:17::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Tue, 5 Dec 2023 11:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 11:10:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:10:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:10:13 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 03:10:12 -0800
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
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1114ff0c-f1ab-4d7e-825e-991f322899e1@rnnvmail205.nvidia.com>
Date:   Tue, 5 Dec 2023 03:10:12 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 54238117-cff0-421b-ce5b-08dbf582c932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riXU2BznCdiLXrqIWr9vSgvyB/41HKV+wvkWOJSBRhoZKnde/wyIb87hpjVo0/QBz/Apeuon+0MWarB/FAUavdvOcsMvbW1HTdvoBRcQSGDxhR9Ktyv32UXwFapAolyAh7dfhdyRumQFItHa8V9xaqNQ0aWeyPrrO/7zXyov0+CwJ8PDXt/JsiXJwAt0AWZESSeGcZPVqP2Sq0bX6iL7BbsVatuGUvfNHiEWKt63hmbkONDdhcvu2m+5ROY4iQe7McpwXJB/fPB4HWTFsicU3/YGkJFIhbYB0QAAMmn8d+Wid52OTdescRKF3D0L1X4UKLcisB3s4WJi+5SMRr5CGnHgfWgFl9wC1Y+37IpI5Yj6VjVZI0I9cqfcKkuHEkkGu34WvVUxM6C9nJw3zquya8DvYuQAZGEpXUpoBVe1mxduXjpKZlMQvsA1C/p7DXX2/DVTff65IoaYqfYKzyPHl1sJAgngrPyn82s/O5rJ5+y4b0iEXxgJvbCdenHJbLy/lOCB7irdotZnngsComWV+PzK1vXjYrFe70x09/OplAhh4lzthuq48TvarKcm2bszA++6L6Dfm9J2kHJrLgvW6x1sLrMpTU2SKjjmPUi9u5rItKdMhQp4mN7sLbry0foo5Da34bfrsYoWphXv9VGO1f1l03uMMYjiARxpSSV8k7Ny5nK1VN9hOOEzMMgpy2fTqkI2G9oifpoUgOj9uvOIxRRRWjhkE9VGTEqjdFJzVFaMKUs3tOpDdSsUrQL0Wk29WB8hGOXIc7xsD0082H2TqVNhf5Yue8oj99UkJcgk//g=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(31696002)(5660300002)(86362001)(40460700003)(7416002)(4326008)(8676002)(8936002)(2906002)(41300700001)(40480700001)(356005)(426003)(82740400003)(7636003)(966005)(336012)(26005)(478600001)(47076005)(36860700001)(31686004)(316002)(54906003)(70206006)(70586007)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:10:27.1129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54238117-cff0-421b-ce5b-08dbf582c932
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 12:14:32 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.6:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.6.5-rc1-gb0b05ccdd77d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
