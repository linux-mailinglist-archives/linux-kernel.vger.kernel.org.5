Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA3792AED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345604AbjIEQot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354376AbjIELIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:08:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58697132;
        Tue,  5 Sep 2023 04:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpDX3K7NJYzJKUbAl8CKnbDOhQ3ffBfrX0rPFpkLQo+bIbHyxpyXz8V2f+VY1AOGkhrAtIiFdBSvCckWlQUsBsPOv5C4WC2x2eXZgsy04I1Ch/TtXfC66dFUvrzG3FWaQFZXsRiNnmNwi0faojPXdff/cgocL/Hr0nfjb9v1nqKUsH6zRAlZouBfAncI1VvoSzsmFk6g9Xboz1O9/DlEMuJQMkz6fELOhGOGrvquXY+N0tvrBhXZ1f/X9n0Bx+h/RJBHRvCwu9YLb00T4FGSCtRFtwBDIp/XZEaw52w57WLDOGPhlYTbomkHv2HGoTD0AgUkZaz6Y/8UwyI4+cJbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8b4dwY44q3hEtH24PH1pPpq2Qx7ovUvt11OVLyc7lo=;
 b=i/Tnvqig0cGWScHOj1X9jJ5zmd1RS/1sylPzSl07M1nA1pX4+ufx5K9+kHxmrk/TrkBzPQgUFHlV6KmXtz8BEGUqOPFp97V8bpyv/m5bzZ1d5WrY+agh/mXuC4HDLQazUaxUdS05SNJX6Hw83ijbAKnI5KLoX9PfulOHy/CnVq1aQQzTGdQif4CVFHcJOVtFfkhqXJMfci6+ZvCZaRS59VI+FSgbIpZJ6S0wMsCkbXpLutSUXlUq/hhNRzpcV//VYSgGrX4QxiIBba7bZ8VoD3ECctMTXJtNtHA+tO66rYucw3dtSMYkmwzkjICItPYQVQ17CU4hZzRboDslsiZsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8b4dwY44q3hEtH24PH1pPpq2Qx7ovUvt11OVLyc7lo=;
 b=mhNPLYOBtH44vUp9k/iYohAQsVlmRdljLgVqO/vYyt+yRBoyJWL1YN7qgtCGCmrwC6JEygixCeFb/IZyd6ClJbxojBGzhPF8UkTmQRmkOZn3vPiLv50Z2lO5SQCYlQC2Nixz+Xl/MHrDBT8g1bAZQkoimyTneNu0d8SjoMYd6qzDScBPnDzSRP5aRLQKmKYZQF5HLpf71sD3UCkzcJROI/Q9NODgjkaOll+UqMbIGkmUBqqtacvoThz78hrLUM8pn8gggGtXyXuC2qL+DTHC/T5O+vC0SQUSLT2fwZNLtlhdRPJSXpIyqdxFa8Ucgzz5fJro9NtH/qdWDLpq8Rq18g==
Received: from DS7PR03CA0236.namprd03.prod.outlook.com (2603:10b6:5:3ba::31)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Tue, 5 Sep
 2023 11:08:24 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::7a) by DS7PR03CA0236.outlook.office365.com
 (2603:10b6:5:3ba::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 11:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 11:08:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 04:08:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 04:08:16 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 04:08:16 -0700
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
Subject: Re: [PATCH 6.1 00/31] 6.1.52-rc1 review
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
References: <20230904182946.999390199@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <23613465-f122-4566-ac01-1c0439da7d06@drhqmail202.nvidia.com>
Date:   Tue, 5 Sep 2023 04:08:16 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f89a0d-d028-4c6d-abb0-08dbae006bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkYWd8zfPvwmkbTiiBCvoDZBt8eCuNdORWuV9OtRvgDTHr9PW0ITbfgQn2XkUW47OybpIp+C62od8Z33ui+rJgcZJhYW7sxGped3pPvKH890HkqIzYx40KLEqbvz/mxkUfRVU1KiRipdaeYRNL6ZBOueZnqskH85XfUBgmu4VTbDTM8GpM9UNa0esWZV4Jq+zV4KMm8PqNLEL5rXorHD+jWMmY9ydL5Dq+HDf/FSRYMFSPupq/GwdzPXMOYD35mP3lioBjqHOP/GTnJCJSjorGXiWMyl36Z0MOT/d4um/z7ZCCTqYztPZH6Gvt1/S9hFKTPrEtivkuYcCQpk7jfekSpEc7xY35Za+ZjrK267BTceQbQ9n+9zSUzVdSZfYYSv/HfAPvHyKuBUd9O9UJBxHZ6ryLe4jbrOZLL2CjlFYeCEqyI9pnbb/DrtmUW9xlKetz3SnOalFjP0oXId78reJJIun5iJNCnbWkMr32Fg89sIPZa75JjutxwrGojyfAJCq8b/aWa+isiS7ns5zo/u62TmDjCz+hlcIi7gHfRRCAy7+mPByTvmBziNibgicCBzq7HDT6YFyTbXafZmxLl5ijqt60Qa4W53ElyYet9HwiehKeX4eSXfA2ZiqIYQ1gBpUbc1v6OjPB+YWGzS/YwJo1gFLli4frJVEnaOPyKmlD5cSLdqcq3Ctgs/LS/xjrwz7cHl2CmhaKNhJuF5sgvR09CnC4YOSkAfN3ORVGq5P7LJe0qs7AmIUk8abXUE/TZzvGaUBauEukl11ikBg7cgGEVBS334ho1Vm7tnhiUOTlw=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(41300700001)(478600001)(966005)(7416002)(82740400003)(7636003)(356005)(26005)(336012)(426003)(47076005)(36860700001)(70206006)(40480700001)(2906002)(6916009)(316002)(31696002)(54906003)(70586007)(86362001)(31686004)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:08:23.4245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f89a0d-d028-4c6d-abb0-08dbae006bd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 19:30:08 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.52 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.52-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.52-rc1-gd0abe9b6003a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
