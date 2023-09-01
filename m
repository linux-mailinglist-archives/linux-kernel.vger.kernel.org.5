Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E262779023A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350643AbjIASqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjIASqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:46:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402CC10E4;
        Fri,  1 Sep 2023 11:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6pO72eBcEkKu9QhrtAcuJInuSzRAsOXjnb38uHapQFds9z3tE3scPTAXBjmNIHalqthQhgWl/AQaojRTCooZ/M3P1MTrcdgXLAjNOuNkm9kTqUKbOC98DM54ZeDJ1zhT8ZhQ4Hi/KZF801/hsMdBa9LWI+1deoZBdZkOkQ84yp/xlh2Tr3CDyyKoX2AaeTMZ6msEc9J3twjcah5Iuoc3SVn7gBfJ1AGFfu0PkptVZWMYVwDDNhienwG//MjBK58Gl/V2u6GJk3Kzi+3hXqAlypSAbYHFkxnVlLCiwDxlkE20xe9nj4tWVMiQSGgJe24dyEcVDA84I0wAqiSrSmOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sab0x31Zh+xEM9cH72LnoMjIqXnn+qJZoIjTdUMLAgo=;
 b=W+WNKQZeKGcHnemf+BB2oU0ysPtsduBuKbcNjIbvqledFK9ExEK6zM/XeVEBhJiLczMvlyNGaFmXJlDSOrDsdnVFp7Wx8HzvZQZHhdG8zpXct4nwySyUZIivir1z/8un8WbrwRaDjkYZ00RL2KPkfWp1bzwB0gXkx4yruVnNGfAygzf0Kif3fDEsrvAESICsWm1S7gQcJtYEMxB7I1iDUIck+X3kqu6ssUPfrwg+wzE/qO0DcDqdEemBq4Y7hiTCjsWfVRzeCMtCdasRX2fLFxD7CKhbzBHErJgOq1tmvNsxUup8PdydxbsRvJ2cYXfoC34NX6MbZ2jwtcjlG+Uwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sab0x31Zh+xEM9cH72LnoMjIqXnn+qJZoIjTdUMLAgo=;
 b=Xon0dc234PTVU9gWAkZOVcLDgEIhNYjM8DMHfdf2tp6tpWT4jDjisj2cZE9vMakWd9s83iEBM14CwjSk63HbeuNvsurrjnNlBICj4jRw29AEI7WY1Z4bU3B1stRBRaMjk7Fj7JZnbZ2AsI09x9/6dd+VWMSkXT/ynoDAGmofqMpkbHh8jh7t9KyqN8G9+gKGtDFDrcLIMp4zTk9Z6Kd70gFjIMHOdHDStwsSFdwlvfJOTwV2T1y+ai3FeT4aujOA5X249D6MEd6Lvl5zUNpqGClE3TmuojTXZbbtamT8F1tsW3uUMFWc3k/i3je6gm9RoxgUqsBi+vMjQcV3NUzq/Q==
Received: from DM6PR02CA0167.namprd02.prod.outlook.com (2603:10b6:5:332::34)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 18:46:40 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::30) by DM6PR02CA0167.outlook.office365.com
 (2603:10b6:5:332::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Fri, 1 Sep 2023 18:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 18:46:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 11:46:27 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 11:46:27 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 11:46:27 -0700
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
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
References: <20230831111127.667900990@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f5c10b9f-1951-4b4d-b7d9-992cf8770bbc@rnnvmail202.nvidia.com>
Date:   Fri, 1 Sep 2023 11:46:27 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 74709116-6b9e-4bc8-a9b4-08dbab1bc73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZ64AC7IilrsbjFflHZZPqqWQv4b0VcbkKhoYY90qHrBvNC/YSBwOQvZ7KD7wYLuTmsYryqkBPyEP/S4fmZjTBLjaOBfP8SB3u+UVdX4ESc/7MU9lR3IWa1B4O98xpD9EyvsgiVf6F3OLwmEuCN7D6K2dMBfYVkSuyIRxegVnOXx1dxRikFoH4KHpGsVTJ/Ngy5VmXOkAYdRC0cmBnACoBSQdNydJQ9LPJkq6OEnjakY834lJ7Wu1WRvCRKl6pfF69cMfiqQBaicKtN449bP/2gpI2ng0EQNnoHrnoq1q53+pWQ08cTUHj43BPohaRTry+W/UGpWCM2xhkwcIJkiQ0Ps3eU5RYKm9tw0dXKNdI+ERMOtVCoBmi2Zbgk02VnXJsm8N9vk7hj2/f3dp4riq3+Z/GsWsibXTdSj5gk+fDJDtgIqQd0yo4ou9hGV+Do3a4TaNlZtzRF/Y8zI7zM9pMS9zAc8UNbHi2rpW3oP/XWeVFukCeOU7RTGN7tFcLvOqhIi8yrAH3Gdr4Zj5U140dsUW/KoEL6l+Ge3i0ys5agiT6so/yu6//xMNCOWTG+4/42hWhOTBoS+e8v1X3ZHBLf+IiHctqybMdAYEFLPXXoTIyRIRuR03hdG5bnmdlJB/fYTCv5XP2ssP7N4VneMWqd+LTCTqZdkalfwEintqP+tlyAWk8+skb6Q87PQc4VIqqwgiICL0cQARkOBbplyaU5KynzuhBcxZQg79yhdmi9LwXkgHMxqBBnEeJj6xXbhkY8vwGmqdvcPw2xjWvY3PMT25RaDUEnm3aYjaFWM7Gk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(31686004)(82740400003)(7636003)(356005)(40460700003)(86362001)(31696002)(36860700001)(47076005)(40480700001)(2906002)(426003)(336012)(26005)(966005)(7416002)(478600001)(54906003)(8936002)(70586007)(70206006)(8676002)(4326008)(5660300002)(316002)(6916009)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:46:39.6799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74709116-6b9e-4bc8-a9b4-08dbab1bc73f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 13:11:27 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.14-rc1.gz
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

Linux version:	6.4.14-rc1-g499afdc4a899
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
