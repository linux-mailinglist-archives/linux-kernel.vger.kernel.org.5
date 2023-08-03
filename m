Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8048A76E4E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjHCJs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjHCJsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:48:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5FD30FD;
        Thu,  3 Aug 2023 02:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzQqOrM1OhGI8KM46x3oX/fFfgjRydIc6YVT3b5ubgui+BPpv9xtCMGb6LgQ4HL90WvNvoo9Z/h8YpdPl9NCzLQ+sBKkyYmSeqndOJT8ItBdhJQsiRkrF3ReqgMyQX4zZl93jh97oYmE62Yq5wYBJrRHmobPVGSt9bk2C50qkC0C/kBeBBhdpQ4OT4PTuLkuV9QPeAW/qWv75gYvmkJkMdsOd2XITara+mOgbysD5RkKr8+PBYBAs74dT3pKDaEbFiKyoSigvfpgrV+qUuB434kKAq3gUZOcg3qnnFZtIfSkoFO0kNgSE3vvS7/cANOC8KaGPM+r8atdPv/d/42ByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C//fq13CR3epgikt3GI279IWcsong20vMOEv2/hJKIs=;
 b=nvIrEqXxZiuT/3i18hzFR6xjHbpnAaR4F2YlOUBrI96hFdULxsmPpTaiMgAgBfIYnt5s5A0MZ5gPIAdAH7wW3XOSmLGK50LoaPktRQIgznak+2ZzPRz54zJS/ujGjfrLB5d7YsnbOTs+R7NHE/XJYLB/WafQQIagmvYFerBfEA4EShrRyEXrzruimgZ+sqg4nH0599b76/CWYNOohbJUc/zC50zNqeiZfMWJDtLBtxY8XrkQvPgNjgjR63WCK12+JHA65WnCuj7OGJuI1KinQKQTDtXjKN2DOv8j/MgGOgUIY3/Kr+noisYUdVY3c96mtDJ9fvRioiTTrLEvui0cGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C//fq13CR3epgikt3GI279IWcsong20vMOEv2/hJKIs=;
 b=trPssQAMqP5fNgm6QOqej1mtvgZ9XyLUWWXLC1XsMjKjal7TPncKPNq4Jeofng+XwL9lz5BLFqivrfJ5C1yXcN/e+H+73rDzvv+IZkULkkByVlqzB9Qx1Jyiyugceaz8bc7V8HzGM5kPeqAi/GU/ioPFZk2u6AWnwdrCwu//m6/7sZ08SQebsxWyJI4Wli2Y6sQV6jGnOQX2a1x1v9eTDQTtAYI+j0iRlL+0Y04LrISuV83KTfoFDo29SDzfjQfCO93mLG9g9KI991l+tUDTupsoD9A9u5I52YrHxCiqVibvYyC3gVMZu735KO/2cJuKhbC4rux+WqwMqroD/JdxWA==
Received: from DS7PR03CA0220.namprd03.prod.outlook.com (2603:10b6:5:3ba::15)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 09:48:40 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::3) by DS7PR03CA0220.outlook.office365.com
 (2603:10b6:5:3ba::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 09:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 09:48:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 3 Aug 2023
 02:48:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 3 Aug 2023 02:48:31 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 3 Aug 2023 02:48:31 -0700
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
Subject: Re: [PATCH 6.4 000/235] 6.4.8-rc2 review
In-Reply-To: <20230802065501.780725463@linuxfoundation.org>
References: <20230802065501.780725463@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e570790a-ac82-4614-b17b-c290e573913a@drhqmail201.nvidia.com>
Date:   Thu, 3 Aug 2023 02:48:31 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbe0506-aa97-4cff-8c44-08db9406d0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WUwTpj9wo2IT98L+NHUcPM5xpZTs46UOvwHB9Yj5S80u45ZNqmXShnsB+blnxEni9oJew3j31NAsH5bEEDAVmnCMJSnoZXIedvlmjkkSMfxZAGvAPOx6J6Kua8ESwCL1IXwnqB9yp4J0rWZXT5ZX73/idcEOrJet7Ia+gKMAF5IBL739vRjxc5rHvEcKYKJ7frTXJOT3b0xMBmBU0nbZFQg8KD4tpGRchc+qj/mXnK11H4919zKGqO89N6JDZ3V+Yn/AkfuGZ+xMwlMfEjXZOEIpBFjVxgUiTIL/xZCOsuoCO4gYEjsjcEwf7CmLM8Hq6yjSTmkDCadsiCv5D+NK52hC18CARp0h6PzcxK2hojYth8DHWhUdC5DUJz/rOgxoctQFbcto+Xngv5bqQ+tl3mDS/Rk76plUTZalLqr3hB3fJ2PW3sJugk1AAlNPuqGLZz5VPM3coPAayucT02OyZqoKDfNKgF3h7xKBEIyv5v6cTe0MegyXuZfr4H+4FGEstauCc+LVDa4jDcrfx9INmfxToD9grwDvx6PX2v3OBXIbWb7V+atc51hw9x+1wcWLyHX/lVYVSIKqKpeZO+kGQQ3qSN9UK5emGC3T90HdFMVp3EhDcibZzrPLtNKc14j9x6XB3LK+abXn/r7l5gIJ+zyKCFYmjxXq/RzPWP25WslKZLCNe5MxKigD7GkOhYJI55gyaJ0l8doO+kLxXHqdr1QRnxGU9uXSE0mjB5mF4NW3IEQyQOs6E+vgmoQuQL2kbZTXkESwfWn5pKiRhJ0Da1p9/3onuSJjWgFIk5G7pY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(336012)(186003)(966005)(316002)(86362001)(478600001)(54906003)(7636003)(4326008)(356005)(31696002)(6916009)(70586007)(70206006)(82740400003)(41300700001)(26005)(426003)(5660300002)(8676002)(8936002)(47076005)(2906002)(36860700001)(7416002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 09:48:39.3541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbe0506-aa97-4cff-8c44-08db9406d0a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023 09:42:04 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.8 release.
> There are 235 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Aug 2023 06:54:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.8-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.4.8-rc2-g6a44ac630b76
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
