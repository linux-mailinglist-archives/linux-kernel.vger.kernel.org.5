Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6716777B7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjHNLzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjHNLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:55:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E2A10E4;
        Mon, 14 Aug 2023 04:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpXE4AOfhIdnRNgspf6PVSJ6uOJn7zWdxhERpupJcP/FacRwiWzQLT19GCrWunDP0VT7IVQi6RhcKLC0IgtLkM/w8oSSW6WpVg/8Tk/III56yU7ijPgGknrppcjqkLAO8KMs4f9gOlAqGy5pTiUFU/w6dIPBR8TbsFrE8chS4O01bIbWMxLjNQewb7vtW1TwX2kP4ZVe6I0al157sQ3mPdVMIx0uXrQdAJhMZv5trU2bGUoYioQtLN0i5I0803MHWbEY0xqOK3wnj/jBR2mKgSaFMfZYseUpPbNMPMpNJdIFCybpBmR7AH3VnH4v8JNFbxkQY+53JB0prsWjEta/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3boo8w0KibJlppLmBuMFMSN1CmvDFt1OPtjilujb3c=;
 b=GDO+Dl6PK0c5H7RLez/hha6wxT4wfGPj0EvirGbF/511dPTdal2LgUJhBLPDbjMZmdVRPVZkUW61wMCxjTfKDlGm8ryLH6cwlwsrIpM/oNht24MxnsijnMe2Zv8lPOY6/E/uRFNDoneofX/nzlIuUEoQYRZ4y4swC7elkd4DUsUdklUwLwUAvEbJSIeRx51oOe0ZXYGXpnJYAmg0jo3+8VaJcu4IlnzhvrePN2clUTc9hTNy7S5NASN7rxbjxy2PirI1vo67go/lAa4U81/u4Gxj83o/mbKWmRAEfOkAmg/DabPpp7ayvbxUpcjG69WqiY0NFD1WqBJMUYqEDJ21YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3boo8w0KibJlppLmBuMFMSN1CmvDFt1OPtjilujb3c=;
 b=NBr8RGxzuGYskg4ulsoNNPwVuGK7a3m6aB4PWMCT07mwcps6Djmm52c66kBlbxD7+hsdyEc5oO/IH9syjBcnVabJyB9ND1095cYYlFXCxkxNxKU71svJHpZl+ZxxyxhtJvYkNQoNVoJOmAkXd+/QjCTm7LUtTL8X/3zGgbrsJQKQWppHdGmVOkfKFefK4sMTtL8/2tvqV1xzzxu5Jv76GtppCbPEBYc1w0vI6IY04JB6k0f3MucbCjIJX8bYbgVT8dN8Rek6+WpHWsBw5M1gtykc/ZPJjU+hrrYMqo6WSBBIXxsznkg065Jw8+25+Sc/22UmqXRTOtdS4lQ0td4LMQ==
Received: from PH8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:2cd::16)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 11:53:47 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::f9) by PH8PR07CA0008.outlook.office365.com
 (2603:10b6:510:2cd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 11:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 11:53:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 04:53:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 14 Aug 2023 04:53:34 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 04:53:31 -0700
From:   Thierry Reding <treding@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.4 000/154] 5.4.253-rc1 review
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <d6234abd-2d6c-472c-bcd1-0c364e574232@drhqmail201.nvidia.com>
Date:   Mon, 14 Aug 2023 04:53:31 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: a58719b3-f2d4-4d69-a4a5-08db9cbd1e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RF2gw0YHznJOrqf0Y8ryPfoA39Z+EUdwmxy5/IT/hY0l9yRf+QFL8JHGgRs+1os4SVliCw9d1FCxrdUQBAk46XLLC3oHzi48Nj3ZQSzpwtlpcpWjUTJ4y0pNmLKE9XhMOhgkvI3bv1f62PfEDRzqYfq3UjdsrOu4lkONbiW0anXG0HGTxKMMjBY7BshNFizpBgXvQsASBxnvYGwRNlG0/P8oDGsJMkxDWRZVtIAt6QU/W0tMVqPRZLbNjErdOrYf2egrnOXGqO0alwuPaJRgSk6kWcVVymLbUVXVz9f71KxmGWUiEoxwvcAg1qczIIaI7aOZMCosBvXM/6mxuDhQS7kMsG7TT5XTuYOLKBJp9lEEkzwr3WUwwjfxpUruMwDTPTq1/vvYkqdY6ZHnPIbQsPAgGoGgoCkgRp6TjDb+L2RD7i0nTRCp8f3O64S7bZcUt3AzOApuqTmC4NIEV4IOAiWKReTEDZsm3wksgySUJL/P+CnxOw0dsBYeC4q0+1hf6RQmzDTDWGx/ZedvRg/hwfjKAZ0U1N+46q9oNT8lCs+EFb9NkuMPkhlXsDsAsTlRChWC+UGxctMb1f5OlT5ZAY3unh4o7h2aCnScS5aYwFf6jGuv1atPpeC5kJ/455wjlibbcnI3T9mWDnh1V7oVmsM3UQxrrWU9yNMd+f3wKkGhhmgd+g52e/B9fJfkDqLEhoKxQOaUPOkVaK4ZaEHi+nnXi1/5Y4XUE68QHAtUse+x0qROwWE89JQlgxgeEKItP4h+j+ROVgTzHdkKUkZEtxExoO3XdopNovf7/j733M8=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(186006)(1800799006)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(478600001)(966005)(7636003)(356005)(82740400003)(8936002)(8676002)(4326008)(54906003)(70206006)(110136005)(316002)(41300700001)(70586007)(36860700001)(47076005)(336012)(26005)(426003)(86362001)(2906002)(31696002)(5660300002)(7416002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:53:47.1522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58719b3-f2d4-4d69-a4a5-08db9cbd1e37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 12:40:31 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.253 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.253-r=
c1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-5.4.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    11 builds:	11 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.253-rc1-gb4a2489fa8b7
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

