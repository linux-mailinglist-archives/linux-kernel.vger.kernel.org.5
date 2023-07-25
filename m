Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A985761E80
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjGYQ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGYQ1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:27:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA4F197;
        Tue, 25 Jul 2023 09:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHr59zuqj4VeRM50oW0E0LuOCr9Lt8yMmcbLC72g/t0smslKj9ggEvUrglF4M8OyxThgKEEAmpgCsz7EmgHMFDS6+77d9FIMQLm6Nb5f5Ror3wjvelu7DJYCHtKcsbh6pN1UtIMBTUTNJSLqBXD0fY3c+1PAApQdrfoI6kv2SvnIdEdA49wAQ2EPQIn+5GBxFzlBK2Llz9DUSEk0Vwea7mMTs21XWxBbVgt91tQrtpWEBwG1cdmEL3lFNvAKlWUGBm721GQW212lgxQK+WE+Nuxt3S4W0mgFVrPDz4se8nbmgt5lT6aXWyU4Xa1YdpMfEW2GgsyZVQAJSrJFLEvcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIQ9RkJW2NIXh4gnKDptigyTH2wPkVkJmJLkHBZJMTQ=;
 b=TCKhCqPN/eACLfyh6fFcnLfNWaHDuvz7YZRfn9sTu4sl6mt4EmLizzOKeVb9Q7yYL5qkpp96/50nQhyo4YzaJoTXwKebzn0tYVqKvMiAXqS4ax4c1zMc9Flzzi7ycu8CUsDq2yBu5wmQ7qKKQpwqLTpIdvF04wUtphrQv8EezNUIYI6s9xtL1HUiYYugyPQ2Qpqums5WS+uLJgWFnj1WzBD7XgLbZ55bN80WCvrsolu5ZX8JxtZOPZhgYvZtp5SPQEcRH/C5TaEjWjZS2IYlwsCQ88YOm56gNwncDA1BBuJDwNnE6x5GTyM2974q1EPlPyi89OM+CUOlPVudUU+qCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIQ9RkJW2NIXh4gnKDptigyTH2wPkVkJmJLkHBZJMTQ=;
 b=iRKxAtDIHS9p2VIoXqPkOmHXNheqaFZmEfMtleW0MxjCBA6l1T+4VeWvpVC4NnoznkLy65HCBJPeYscZxGBh4svKVEjybxgvdX7o72shCAUVPF3IT/2gfr1Qd7cxEtNNauAWfQlTuPnnumnXlxv3HYx5tQHEyWy2Q3hp8xpd9suEOIG6ngUTi9QJ+pO3jMD7lzOWckyj2btQ9qxk+D6C3ha6F0Wpyo3BjVIOT2R5M9siTp++s6vy/OYYMt8e2m7UZX6L7GX6YOd01kcK4rPLzvnjLJwLgSufQOWLkDROq2gGF+PB07tc/P1c9I4O5bq+85dcQr1uvhXLDbc9X0Wixw==
Received: from BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 16:27:48 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::1) by BN9PR03CA0767.outlook.office365.com
 (2603:10b6:408:13a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 16:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 16:27:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 09:27:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 09:27:34 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Jul 2023 09:27:33 -0700
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
Subject: Re: [PATCH 6.1 000/183] 6.1.42-rc1 review
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <fba9e2b2-dd41-4158-9d9b-124d72e54900@rnnvmail203.nvidia.com>
Date:   Tue, 25 Jul 2023 09:27:33 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|BN9PR12MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 88739eee-96e7-4341-f864-08db8d2c1580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jGDGUy4HZMB7bClaAklorbOsyBKC+4zvx4z6pybjAlLn2fZ7U4IwJm6/8bdaLlYaDKeuWCrNY1mA7wmNuIcmIwXOAoapgeXTLv4hsfTbNwXEpmMaoFyD6eBDRord9qNx6jacwIZeSlxqhRuvLuNlu1wYX6nd5n0WrvhaG+laEDBd7nqKhetaZtwznlhMMsvSGhidU2r421kfoMDaOwVrAKRm4vAx/EnBiHEgcGDtEU0jbC4YjYFUXdmdPU/FrCfzoWm1uBxHad7AnUlV8UsXVxhVljUPNAN8cA++svRy5IBK416y9rjLdoCGIs+VBvfwzSuV/M5mFhcCjxfbatSD/HQaP2V4UyNRFT2ZVrf0w9GVYzNmb5I2qcZnwrYyQP94NI3Fbv1scDe67Hpt5nMjWybPOZ2nIdiYt0e67kF2G1lJ6ZVLp1hatKj5995ZscuVNU1soR3B7kQTJq42m2GGEzgob8hdM+W/2IMO1DPbHOIagIVBEqy/pp3SIWCY97ebqPOGUgZbe3m9Nl4toQQKgtzCzRJprifBGgcK0KzZYvyQuQKtH/6TFgDyY91XBJ22hWBjCskyGu/Ez4UQ35Vj2mP9yaV2SlE9tWWKsISfjlYcfTowUg08+Cu3ahr/ajeGBbGkyG6c3PEBgxx5BR4P7eXU21pjdK5wOgPWnsyyJugnpOS8U3DZuubHQSInXilC1nuw5JY78afTk+Go11wjmRVE9AehIiocNUSFxuOPzvbfW+PZUYd3IYBD0Jpc/Ca56ARZ+nFL0AZQsfRmklE7YJ/vhxhVMxMBb2oFCOVFcw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(54906003)(2906002)(70206006)(70586007)(426003)(47076005)(82740400003)(36860700001)(40480700001)(31696002)(86362001)(7636003)(356005)(336012)(478600001)(186003)(26005)(40460700003)(966005)(31686004)(41300700001)(5660300002)(316002)(6916009)(4326008)(7416002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 16:27:47.9877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88739eee-96e7-4341-f864-08db8d2c1580
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 12:43:48 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.42 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.42-rc1.gz
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

Linux version:	6.1.42-rc1-gb3f8a9d2b137
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
