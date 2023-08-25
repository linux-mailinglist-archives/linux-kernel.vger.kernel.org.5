Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8160C788483
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbjHYKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243310AbjHYKOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:14:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378E42710;
        Fri, 25 Aug 2023 03:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9K35MYtodZALGuvMVhSM2y/2E65c7P+WDgeB8DE/V1eEzuwOhe83Rsq8UdcGW0xBGdszzua/7GQyxCl0erhwv8KxgLAvRnFXlUIZAFj9EqSROpSNVALFDwOFwSkG2nbRxAQ2mAzugmqhCrUNh7rx++wfQ8Bdg7lKysoXX0siJuf6yb2erHVvvarNxpFMLKb8qg12t3a8SAeMy4Af9VrfFmwiOZPvxhubwB2jVP2AVKsP3X8ivMLE1VRXoK9Vq52YcoBizk1+K7if8a1bi/Tr4uaf+TwmdjJaH6YXTaR242K+iRhZfx/0cOLEwYHcabwUeGzUr785apQglvS4V205A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iM2YM2TI4VmZsYnOh1TTMuQPAUygxSqB3z6n8qTN20M=;
 b=FVbaNLDZnziaIcnLYgmkTFYNpgJTQmS7FomvMUm3duFegRCqPFtYU27ib2/ACvBOiaF+3X8AamUMOmKRuFGiWoyDLjbJ75bpck0twieId0Uq8BSDg1gLuCXTt+SotZFgV7sz59Mweb3QvhdYS+knXFE0mwlzuLOiWNYKz4bR0rr7bpz9A+ZLCBuRxow9Xi67BWHmkTd+ERVjeT5GftfNbphwd0rp1ycTA92VyYK1cxoxZ+JeWKbFNYu7ymZyqjIrH6/y6r9Ow1+nBReZb1Qh3dF8PLvUE8WW1qH/y9tlA67HziwkQfprcQ0V0zNPiYKBHErhWWyI6jZSMUPa7qKiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iM2YM2TI4VmZsYnOh1TTMuQPAUygxSqB3z6n8qTN20M=;
 b=C7bwVvNg9YLz/66a1/83MJzeRAQhDeXihkeFhHYfgXOtO2Nl63tzQzsa02p/oUY/dl1yAWbiyacTAyuFWskjXRKcVTbYeogkldFUJOhBdB2gejvtz8R8yXhlaoU5kFDlGaHQ455mHBxLkZQnEWsDE2QVvSi+amVDx4OgGOmAXStSTCJkFaRAKCcFyDNtqUA74eh0SjMgZn5aOrELFJYo2RObeVCXvTL5c5IcJOaMq23PC7a+H/baPoqHrw/kHkOaxhFpujSfbLCPGfvMZZr8PtpprdhofxPj8QUln1NmU/zSZJ95ZRELa3WjTuh3bq+8sgyYD/gWFT1hwyVbapFwsg==
Received: from DS7PR05CA0012.namprd05.prod.outlook.com (2603:10b6:5:3b9::17)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 10:14:19 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::3b) by DS7PR05CA0012.outlook.office365.com
 (2603:10b6:5:3b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.19 via Frontend
 Transport; Fri, 25 Aug 2023 10:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 10:14:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 25 Aug 2023
 03:14:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 25 Aug 2023 03:14:04 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 25 Aug 2023 03:14:04 -0700
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
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <826b587c-c622-4f30-b584-dc8cc3756313@drhqmail201.nvidia.com>
Date:   Fri, 25 Aug 2023 03:14:04 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 63116770-ae9a-4ea4-59c0-08dba5540b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUDfXm31JV7J6QT5pzjppQhOQoqR//E3mYvRn/Xyk6sMHU8uTY8khba+atJpDIhEo2EYgbgLhQUE8ShoT4jl3tjl3rW3G00AVApbr5ljtLRWUNUYDMHu2ctOqeNe3zKzRaoqWEvastLW7SCNpYvY8HVh6hIGND4XXVqdOByCFUTzrEusY3AGSxP2xfiF1R8B3ttLAS9ybRs4N9l0jPvNTdsCHFxgAR8S42zy5E2val763pjGav9cJN6nBFyNim7JgJp91S4dyrcpniQqpzOaUrYoxuXfXRWtiFBjUC9OErUxAMCV7mBNsZO1LLv2tXp5Pe8JWBZVDzUIozxVEKfpD8OGR2Hs2t0i0XWQxkRYm/rDIyi+59Cc68IQVTSRGZlX8rKGmqbg5QZjazytwqIRSdxfX13VJ1la2nVWGEIoHlzXD24m5y094jUEBGvLOzzxTyWgZsTWQe6eFcZR13r+xasSlY57kFBHi2CAD9nEOMGCo8HUb27L/uTBatTU0lPnPINETa7iuvaGLt4o8xuQgn2r4sdKrhysA0GpKpUF0QLt3sGkyJozbBo84MjfrNeTMmx1WQRZpXx4a1JW6EGETTNf4gI8r9qNssZzqpqlZUmHA21fNM6OGKMIgSPufesJq7Or+QPuSriOZdzPTN7fUiDEFtE0vKGYv0ryWb6yKunOsw7Qh/sdTA1ciPClMGRv8HzqGI0nUeBMTf0WnGX2KChnAgD1Yvh4drX/2q1epEfjYYW1SQfwFo54wZqgq0r7mXUqf+rIaoQnOTbUeJxBlrg3LHaUWgCkWNBnYnE34Ww=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(31686004)(356005)(31696002)(86362001)(82740400003)(7636003)(40460700003)(478600001)(966005)(5660300002)(70206006)(316002)(6916009)(2906002)(54906003)(4326008)(8676002)(8936002)(70586007)(40480700001)(426003)(336012)(26005)(36860700001)(47076005)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:14:18.5829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63116770-ae9a-4ea4-59c0-08dba5540b30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 19:07:52 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.192 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.192-rc1.gz
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

Linux version:	5.10.192-rc1-g78bdf347b342
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
