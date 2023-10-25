Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2E7D73B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjJYS5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjJYS5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:57:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38EF183;
        Wed, 25 Oct 2023 11:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoBBlr+CzA+ucuIaNre6jIVgjRGGWYobfevwKAyU5k7dlKYbCxaPy01RMEHNQ0j0Pt94kj2ka1mPna1wuftv1iLdHAgA3kyEfcO81CzwZ5KePYNHlEiLyfLnu2CkO+vGO/jCqDP5H4OjJvAnw0aqjJe/KvG48VljDsNGM5SXmY/tyD0h8oHzgo5DrIQ9RCHtfqJvRElYVRZVpshnKHLz5hPwlIJGYBH1trK2sNFHpkybnOdHC08bnqoiLt9SqrrMxaIlpsO4GdTUyWHl7zZypbVTmR6Zxx7rIvvcNl467X5L3VKnXoUJPRfg0AFTtGOCDFnKVJqtxpK38r0u1UWGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znqemS5WifApjsE/B6HuX+Kc9B3mkQqmYtW+W5FKq1Q=;
 b=cKdEE7LGr1qgBY8NQYrTvuyzwRfS2F6bLF1jza73Sr7xUm0txfM+wTvG0+WC1hoq3zClR0wNIUWCM4I9V8LJkTkTxz8twNnEHDEnWFo9ZGIDIxnVOHRA260/TFZyO+kuPaN8oxbsccTseb0fHndVgFJaXYJv5ZmuM1UAU5x4gbrVyDXnysL5oF/IMkJ5EuMti9UdPEGTKuFPy++NUxvUpJE+IX+JslC69KOD2vBtO7+0aSsI+6lESoTTK2x96Yd+ujdZm4Pe3C2xIwKm7OyMOZM2ltoUXlncNvAJXKhBN+tD32fxjiYHVVMtF9QP4XAKkElQ+GplHFW/PyqgIT4rqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znqemS5WifApjsE/B6HuX+Kc9B3mkQqmYtW+W5FKq1Q=;
 b=SvSH6Y1kTpcVOBuSLmgT/CXJGQgtYON1fc3IDvO1NSOU5yedOrRqoR1IRElE7RjjzlB2Wi7v8vhWAU/CLSthJoKxgtG7J/xxhyRM1hmpvya/OaxpR7G3/2Iq4wrgOLDFJIht6NsrejjwRc95yRUfcq7ShfFSbW0YuQ+XTwzOxhbotdHma6OKsgFCzVQ4KwWL16hA7ByRWI353UlV9DbIJ7+HL7F9hc2pAMlolD97HWJA5AIDL9Qbi9ipUwoG2mI+wAmW96oogHC5TZx8fa+AeB6/WJcZec/ySQABAvswSOwKtc502SFfBfmD5GWUFqJXO0JV90Lcftdm9Ye+XRMtvg==
Received: from SN7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::9)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 18:57:29 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::de) by SN7P222CA0028.outlook.office365.com
 (2603:10b6:806:124::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 18:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 18:57:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 11:57:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 11:57:11 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 11:57:11 -0700
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
Subject: Re: [PATCH 4.19 00/98] 4.19.297-rc1 review
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <0f2885af-d1c7-4a56-b10a-c3dc927ce2a5@rnnvmail203.nvidia.com>
Date:   Wed, 25 Oct 2023 11:57:11 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ddf89b-674f-45fc-1b27-08dbd58c3cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5Ttgfav7soWsoJgswUjs7yK2UvaV8Rm45zgKtFUKig6gJowRSqNyJt/jJTVaar2LOF/x7vq8RVMTfyPPzcpu4WqdaMNJccIWP7CsNQn9kRxhoKCo6rzQRMcS+XE6iPxVyqyBZKKXyYfLm0ZrTiIC3SRCJ7fO8TR4iFMZcLj/6EcW+InEBY6/ivQLYPu8PxRSd5VK/cLLEPBOE0Cw9lFnrO2hbq7hWrdWtrQeb1hRmsTZ6/JASP0nseUzCr6HVJ2MweetglcnHvo57q7aASel4rPLiAku50z4+Ma8jIk6QGe2ooZj+tI7Pb4RdyLMgk45MMDc1mfL5HntVCVlikHuSIGrY8c33E/KcS3vCA+JCvwiCY2P4P4WFKG2lEHNFcXnVQFR01kY1LMdIqeTGBDVq7LIG+3TK/qvB40RrAbS/hcf+L7w20JXiAqWnO3akLJdcC6QLZjNLjPBDGyilRE3VqByXEFro+cZU6qpaYOI8h/kcNBdBvotDkX39r+t4EWlbmT0X7PshhIEhyMnlABO4hxAz2Skl5yJpviw22mDD9Yp7ELoyA78nQqYNKt2IfXenoqjONZ34SI3Lg9QYlsoDpc89G0mK+0QIFSn3x/C9rsIGP1t/LSJ9ElBDTKepgBTPLM2O/XgwW7OjVTIFpTkw3cZVOx3bZoWpqnlJxjppTTeHgnh8MokW+8fIegSbDSHEExXh4XICJ3xGFqVzTKdp/tFAdr2jpdpwH4GX3HzxzfaJMce6TEH32IQuMLFTMI0ulgFEdbWBnXjYoFg9Axwr3C4jT6i0LtAviX3/K7WQE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(7636003)(31696002)(40480700001)(82740400003)(426003)(336012)(26005)(356005)(36860700001)(47076005)(7416002)(2906002)(316002)(966005)(41300700001)(4326008)(478600001)(70206006)(8676002)(8936002)(70586007)(6916009)(5660300002)(54906003)(86362001)(40460700003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:57:29.3404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ddf89b-674f-45fc-1b27-08dbd58c3cc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 12:55:49 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.297 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.297-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    20 boots:	20 pass, 0 fail
    37 tests:	37 pass, 0 fail

Linux version:	4.19.297-rc1-gb3c2ae79aa73
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
