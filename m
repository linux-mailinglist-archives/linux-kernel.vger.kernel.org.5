Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCA8051B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbjLELLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbjLELLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:11:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D980134;
        Tue,  5 Dec 2023 03:11:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6BWde+PNB8yRTt5KL+d4U3Op8Un+8AjrefWcjJNmv6ojPhQN/M/bDs3emgVbUTZz8okoiVq2xr0AH6xyh9Nf4I1TXuOYiHZOAtrjHiqntfmXZ/zHTpNmTD1nZGWTzpcSlxB4ebEyhUZshNtFHB9uxO7rlWrB1N2cxdXR3gjKTPUr3rvqP/Jg2CLJ9W590xgKU7ytrkCjpDM6q+bIzghpYa1Nk1xHm0R8MEQBaydTT02zfVpC+w8HSXfYZHe+WmO0PI5n180qu8h6l6yu89aVPfuccHtYovpDYkFYNSMjLobkinWx0ST5FyoR90kotYmClo/5mrP8IuU2H7f6/E5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4xi4TTRNMYqEilJW2FCVn0Wz22xDQ/HzDWCYVsQAEw=;
 b=db7cdfZ5YJc80IIikflFuKEXET0rh1ydQwBmBKiTtGsNgKTylsIjBNAIV75Bt0oKbdlNFnxSON0uSjJR6jY2xIH+aupVqh/vPSwEpwC3JBdbPrHtKu3JsPxPfxiKpjRBiXB+9Jd4QoxFUtmUsqEC7NHWBPSW3qUpYQHKk6s2zU85t1QmzbSGpBjvSkgfXC/KYiPo1ElARgY9DWxR8seDpQAxcMA7zVP3Lnf2JhcIWKa07cpD9CM0hi9i889tHFIzigGgBfiR3843UpM2Eh2EHxwn1TPRpXOgT5hlc03wSo09BvbWRsJoLeQtNGreANCmr1V+3Ys0gwyJJHPvF6S5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4xi4TTRNMYqEilJW2FCVn0Wz22xDQ/HzDWCYVsQAEw=;
 b=MJ1rkvHBEIHalo65u+B94x0Y/egIeMJ9axZq1cYTHOpUbn7OFbEAwpCokCFj4Ca+cvBw2IbslW/coeEvy4sgfrLxhgmwSAXCHU65e0fDCZnMeDJiH2+wmyPZ7ylamw1m6p853scSQ71vGy0e1RlcFE4g/NZAZKJtVldFF1z3eVK8TcSVKMtMfq0GrXpiBUcEond3Ow5s5gvHdVTRasKI97lIKsfm+UC5GofkAO1QsnP8aAFiCd9snBbxdJ6GMfz24AgzJ3GTKi7ae6y63FNwQhqTJBNGJXqdeMIM0aHBvv+AXDNxgFdbA8k4aJ6XaGBI3LgoJxn7CSWmb0ZaOW9wfg==
Received: from MW4PR03CA0114.namprd03.prod.outlook.com (2603:10b6:303:b7::29)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:11:12 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::95) by MW4PR03CA0114.outlook.office365.com
 (2603:10b6:303:b7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 11:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 11:11:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:10:57 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:10:56 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 03:10:56 -0800
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
Subject: Re: [PATCH 5.10 000/134] 5.10.203-rc2 review
In-Reply-To: <20231205043610.004070706@linuxfoundation.org>
References: <20231205043610.004070706@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <57d2dd1f-7e5e-407c-ad73-c61ab7f0ec93@rnnvmail205.nvidia.com>
Date:   Tue, 5 Dec 2023 03:10:56 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1a04cb-7deb-4bac-3552-08dbf582e3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XlHbLPN2JkZf9fqKQ75nMzvmABFQooF78WxNoKFm+/pSkpXvgpPrdJbcx6y6VwnhC31yuIX1AWxMeuLxzOtIeNrtK5fhK9fvauJRxcUIL6eGwy8TQ/6aL6n2zjyfpIMZNXnFoly11SzErWURps7ofYHH+65usJSTIQQF2OYU+MzB7+TPylr8cLX4xqroPjxDTwp2/h9sRjB7rlSH8we49DEAKyNPHdRGs859ygiOtX2AdZGv7iznEXtpJz0dVmDMvHxmR50gNXw1KZesU91ig8VjhENkombkO+r0WGm6h0QThN71GGiot1eYQhEP53sEtUTFbUT/Saqn42BC/gNfCs0jgl4U4jxsz97YLiDIc77kNjw1XZ0VmdtjaVIs/mqEIY85wW27Xk3fk0nMVqieIBwIU5nuO+w7ESNXpX80HF0Hit3iNsp74Sy2aPI1Ycro/Ag/TFcan3ke9APW1B7T02C0CNH4io8gJNX6YqQp2o5tK697h13wfd0Otz1NpcayhGNwBM9zaf6bnse4T19u38xcMV9RuMQkpCNDWrEkDiqOF3hvjyuw1rHjazMVGFAWgWGN/t2EW2PqnsLbeMGZcf++gYp77jNACFgkd/VrIbm7CYnh33EeXgtz5ki2n6leLj0wlqhJBk3CvbTIaExwMDjI4/TK/TBuRtqlUs0sGFtPB7hngYvpTnuunm8XaEJapsSEsT299BiEyh+/E6+AZM/MTZ1GsZoBId3XJYZX5n8bjqCQGw1tGAKJCImB80DimN4I3i42vSBk3tyLzhzpV7C2Jc4sjjpKqxwANTK0qLw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(31686004)(40480700001)(356005)(47076005)(7636003)(2906002)(82740400003)(36860700001)(336012)(41300700001)(426003)(26005)(7416002)(5660300002)(966005)(86362001)(40460700003)(478600001)(31696002)(8936002)(4326008)(8676002)(6916009)(316002)(54906003)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:11:12.0606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1a04cb-7deb-4bac-3552-08dbf582e3ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 13:36:53 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 04:35:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc2.gz
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
    64 tests:	64 pass, 0 fail

Linux version:	5.10.203-rc2-g9245256c4454
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
