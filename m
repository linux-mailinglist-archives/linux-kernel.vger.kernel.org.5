Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C2A806EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377797AbjLFLuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377753AbjLFLuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:50:05 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC215D3;
        Wed,  6 Dec 2023 03:50:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WseDlm1tn5P/7esJP01BPeLyQa7TRhqBeQgCKzKghvx3LVeCFcVPdJj8SOT2z2Jb6VU1lIwsF4lGi1RufPSDG4pK3CtMCkDAZB7yVThcMk7N82ZCPeSkXpSCl9R36wQ4jC02tk39d340Fb4+0G0Ssbj7aqG0hkXaRNkb/L/AecjtcTcrSH8tVPG9taRLx3ZeOnXJkbQB8yLkf4okEpQ1IZxGJeYz47BYsKDomMQmqYgdzG4aAY4pYjhMmoAmO3Cn2a+0jJWBIJlZ9gLCXwXioWwdm/GJzH1iD90yYONFZo2Bm+lCB7t+uq21O40ogiCpIKvDR7XpvTskJ++ROUAZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwAunZFYAQK00uXRxpQoSwh6tAF6mu2isj9qbLlyXH8=;
 b=iEIli0hJpbT92aQUPcQITIAVneQOeTEGGo1LL06dpqLq6bA5/ueEDrcDH3Dw6sjS3FL7crlWDQf8mCcWBTsZ+A+UIVFt2F3+67fwKgZean9KDGaf43iJ/RDavzwrocXG9sfkf2ySqnOxOyIy/OBrmIz0vq1F9hS9zOLQ3f5pL2d9ZerjkmT6Nah726o9TGRG812OEFP1kDsdxCvRMgCHopPLCm7MpW+x4US0qfmrsC49Fq0NZFGh3B+VTWhuf+KjLpnDgaQF2aMoCA3x65mNefEB7d5LOvv26nG7AwqXZcTEAKcLJjsICdn9najUVIC5qASkn0MoumXLfYkM+aa6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwAunZFYAQK00uXRxpQoSwh6tAF6mu2isj9qbLlyXH8=;
 b=XRZawzgDizlARMOGCYgsj1u1bIYRtlXVu6ieKbKWD3SwhLXOvHPY9Y1yholnAHax/Hfy311BE8fwQ99NwLMpcLXLjI+lNl/kPWvIB2peCfXPColWxAGjF6I56UnbAdAyFAlRqvuzTkdS1omz4gon/l0Coa8q15HZRd2sx7uzxNGMJKZqxAFQITcIVglaNLJveOvLEK32J0U4p1zIx1U9dvNLAwAn19bib/twBCPmRdyn3f+t6AwaODWTKoHmeC/2nxKV/fTr8wyUf/O73bLBYMB1zu7CZDUq76MvI7sipbCazsPi7wmCIy8VtS41O/0N2JGsUoljqYyzuqok/MYbJQ==
Received: from DM6PR05CA0050.namprd05.prod.outlook.com (2603:10b6:5:335::19)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 11:50:07 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::1d) by DM6PR05CA0050.outlook.office365.com
 (2603:10b6:5:335::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 11:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 11:50:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 03:50:01 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 6 Dec 2023 03:50:01 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 6 Dec 2023 03:50:01 -0800
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
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
In-Reply-To: <20231205183249.651714114@linuxfoundation.org>
References: <20231205183249.651714114@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e47079c5-0651-490b-a8b0-5b42bb305a53@drhqmail202.nvidia.com>
Date:   Wed, 6 Dec 2023 03:50:01 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4d0b52-954a-411a-be67-08dbf6517e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nWAP1lNDAFk7jCO3mm+fL5n4f+ayOdakcIfOrGdhZ+pTyOxItk1u4BxDi2JeprDg/fEVLRcEGWc0PbVzbTgsXQAyumtdRMJoeu7bjgJYlDIQkrmemG8lIUqMOZxL4P69TptGAEj04/8SJVVxw9nLOr8wAuusR2RhJxE+2BRdo0PdB8s5bYsmrJiwLZsvumwf3UBqHoK4eeGlrxW11hncP55rWdUR3YxORIizyhz1+dzTCTSP0NXMUvMIhOo/zPlzEpmif1lHtwLGGRM4EWspoOiK42s5tX8oZl4BJ7LsNPc90NyMfBjsslZBq22Zk7h3vgrzhghEzhYDnxWkhSBOHXm4C24XLjPB7GddUmvLjs6+zU5CrszLAXddxHNHcDbl/URvELrz3JNgqZNwQ/zXFqTheCjsZ8rtWAa8t+pU6ftDG3Bmj1sL1k3OgxxjDzAdKP+lVMi/+WOKbA2nCMBHk6FTJuktFjPrdcqJ3oQNtiaKvYxYIkVWpv2V07Znw0sGM/oEQhtx6xXpXztF0Ef5WPnCMVQMK5FwecfCbl1NroR6+SKiq9Wq3JJvzF3QNVk0es8YuaUS9KMtsXhDKQbRC1eWdTwS5Xu1d6DGrWSO+CdN/biUIPxxSNUn9ftLFi0tBWlaqKRmQRlKuEEosVDroQmNoRfQOkgTISiViBdh8KsHSQ0x7iqAmXoagaDaisu/j2J/Or4tMPLN93an9Yod0TnIotzo3E6J3DRE8pj2xgmKHwXUSm2lvTLW8eJt1jubMfpn3dbRMWa55bi/y8iKbIlKwFeSIEALzXM7GnTmcc=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(478600001)(31686004)(966005)(26005)(426003)(316002)(336012)(6916009)(70586007)(70206006)(54906003)(4326008)(8676002)(8936002)(36860700001)(47076005)(5660300002)(7416002)(2906002)(31696002)(40480700001)(86362001)(356005)(7636003)(41300700001)(82740400003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:50:07.1346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4d0b52-954a-411a-be67-08dbf6517e28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 04:22:23 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	68 pass, 0 fail

Linux version:	5.10.203-rc3-g3e5897d7b363
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
