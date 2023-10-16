Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7D7CB50E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjJPVJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:09:24 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849B2A2;
        Mon, 16 Oct 2023 14:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkTbC8BN772dsetA5PXyzRJaGhbaA7WDKdaHPahAuGIXN6oTtSEmXLtwgy4hqXzfEPz1DRSDFZRPkvKeUU+m/3byUvUqbRgzTi5fl7mQfs8amHf08pxxaOoGrk+t5vTOGUIHJ7H4rqm4xmvLa+a7cQiMHw5dEIGjqVKsA125cc4X5/vDZJk/M6GNTdGwEiMDwqVQhfN18fexGfJdimdE/eKX2tldFlMjtp+d74jhrAgqpf/fPVAfkZ6PG6/gT1WDZTAEn/507LNHVVHYh9bnFyYdkB25/hrPqgmGzx307d0+yO5RkmC4cM+2uMVvu8tiVB29yatV8QbVDQC6I8KvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQHFAkhGDk4OpUaHh8h8U0Popa3kOR8Ntyjf7+zn7MU=;
 b=HNbzZ1wEL+a67FSUkSUNP+y9JHAwunamyrzMWEEeWzNdJDU0P/dgZYUzNx5YJtmBje6dDXQ6IpKx4EHvSYKiOFKFLt7UDuGZW7S7AE+xvm+P0i5W1RJa54QQBD+xcBTZoGYbXJ9NqqGkBTJ8RyjDRl46N+IXJ12x/xe72xxfUiydaUC37uOHF4EZ4G5IonMjFdZ5EAxPSIlYA7JMiEDVcIvBHXIS04dxtgQAnElIGB07qIgpvqPvXil+vuH2waT+cc/7FIEsEXJTtIZkqlMhrZzt1JOYHRswN2wufADWKD6DD9EQyvSN5uaADfQ+L4O64ruU3ghoWDEgcXboorSw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQHFAkhGDk4OpUaHh8h8U0Popa3kOR8Ntyjf7+zn7MU=;
 b=HLKa2bNwghkJwJIzwFHq0Yz8MUlCqOXNeWD6tg3c2NKHEYK7JriT6ymLDElt1lRyTYFwany2ze6YRXK27mdmfO63J7Oc1uP0/vZkzQT/cEeijryejP91GzIAltF0U6WVnAHyRjbvuaSc6eXkFdWKTkBsqqdsjU62AtDKnGOCAxcN6wWhYAbvKfPUy1aUEFVAXu9ancErgdYY6howKGJO2emMV67CxybKhsxGjdixI0J+zEDmFTq5SvV+5oRCwIUo8wtOVDVWXsVN2VUgTrVxSudfhYPhKY2JzPu+rNOvHUZY/yKx5+mtHyvm3K8JkDuHNPQRS/v7Rhdz08XLpxjo9Q==
Received: from CY5PR15CA0017.namprd15.prod.outlook.com (2603:10b6:930:14::7)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 16 Oct
 2023 21:09:19 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::28) by CY5PR15CA0017.outlook.office365.com
 (2603:10b6:930:14::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 21:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 21:09:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 14:09:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 14:09:09 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 14:09:09 -0700
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
Subject: Re: [PATCH 6.5 000/190] 6.5.8-rc2 review
In-Reply-To: <20231016185002.371937173@linuxfoundation.org>
References: <20231016185002.371937173@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6de3d276-b407-47a8-aabe-361900cdc8e8@drhqmail202.nvidia.com>
Date:   Mon, 16 Oct 2023 14:09:09 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: bed3c046-470e-4e17-78c1-08dbce8c29f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUOe67zIOAIaUI/lCO9xkxUwANa9vc3OBTvwjWwHj1HPS++xVo75wLpOnEhXCl6o7HkLu5rfs5vVxIKhmUMZZc4AGbl4xTe6YSGzcic3XVjwhjQhPZ89kwobi0kJw0RNyXKVzqaOVjlIGZgw+2fCrqFfE1PATHzl26FiDijLHcOI5HONit7lkyXiS8KKlzPIS+oEOv0M5z30OPyvnR9TZKXvt55cS2au71OodalROD+7fc5MppA3iMYZOW8CUsGCuVYvqFNnj4wJn3u0/cmxVUpyq0t7PVAS/dwOqcpObm3wf7OTqDKNCXR28NzgYc7/ZY4OkQeVtiBLTZ4589PPqyD5jfSwmkPhLtGfkr9YoJ6ZKxi07VWw/gfCNrYg+/X+UZGjXb20RkU+T1ejjcYxwuQCTPkZpMzm126yW06jC0mMxcnDQBGlpfsClSx2PpRyojqHbwQBQpLqG05LogcQTnWmkmA4tJOi0NGw6hGwmgbpIRnlwT/Zf9e3AOovrj7Pc5mcRRl4R+JoFIWMDek1blI+CRKD8VkDeLaG/Vo/y2i4uJ+P7LxVgiQ3f3IPjM40PtFX9N8twWb42IeswP1rtvbXoG1LfDgOyM4425N5hUgydjTMSWwGiY//oPzzD4JY9ESpBaotPUjagKER8XuVafZLA40mRthST8nGxz4vLKBJXV4NeC9Gxy4QD213MNqaixNY0CKQ/OE1d+y6GxcwLyucZrwUjlybkdb1Wj4eZgyfDhhELjqFTVlqUyU9pnHVkSCcNuqD8c+TJ8sLlqWj3PwGOIo/zcg7vxOHKhU+E48=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(31686004)(26005)(336012)(426003)(7636003)(356005)(40460700003)(36860700001)(40480700001)(86362001)(82740400003)(2906002)(4326008)(478600001)(54906003)(316002)(7416002)(47076005)(8676002)(8936002)(6916009)(5660300002)(41300700001)(966005)(70206006)(31696002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 21:09:19.6881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed3c046-470e-4e17-78c1-08dbce8c29f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 21:48:57 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.8 release.
> There are 190 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 18:48:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.8-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.5:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.5.8-rc2-gbe4ec7370801
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
