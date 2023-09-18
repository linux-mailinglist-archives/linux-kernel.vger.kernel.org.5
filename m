Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0F7A4A11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbjIRMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241670AbjIRMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:47:24 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1248E7;
        Mon, 18 Sep 2023 05:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAQx25/TC+zK8WtZ7OIGVaCS6WEz9aUDD2AuWbBjsx9t2cPBniOFejLK/Cqqv7/Wr1aXrpGIK4ozGHuoog+oYfdwCTFuXqTaTZ1lQonvzZ8MdKuCWPx+Q7YbGbV7fAokFSRQaUZSLNiLl+MGFkFaD3W376O91smqFb8rBdhQPsuA+uRmdELkqhHVC7yBJSfgbYn5DUyR2sKxn3HbDNCkFkzQklA+EuruSoU7mssBbnB+53QAViLqt3P19JQFFgI64jv5XU3Nipt2auEwZS5088ifv/TXYfpTbDgEtxdYnQ0bNkRmUBjA/CRCZ5mjQsTI5s7JxyFzxlgNz6D2Fv56yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDCj+JPMnTxWH78Dw85yw8BvF3h8DSuBJe5ZD0SotBM=;
 b=VE8tOL3KJzKNiw/Fl9m4J6Cy8JBXRyvKRkh3Jl8zfHPlypaj3OyQSZ+sguQ8A/cPfiGYpCoF5NDO3RxQjAtpoCKOW5etsk/wDMJDRYCthsi9ckr0f6S2JaNl2pMIA1dLOrV/vE0tpvzoBT9lK8VXOAHLMe/2jm6fo1nHLkZVYaItoX7l0Wuq0pRRby8XkCuxSQ3co9bRXkJl9YzuF9O6vIsnSbf1ty/B8TmGTyzEtOBHl9bytdhuspQLXLYqbYBD8YvTeTuNhGa3t2/xYOvwpZ6Py7u/DdEyt4pcqYd9qhs5aT5OTlmLaq2VbJ7jzoJZ64nbuVx/1DzD63a38TdBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDCj+JPMnTxWH78Dw85yw8BvF3h8DSuBJe5ZD0SotBM=;
 b=qPzO8Hxp1hoIfCP/OrLjm4k2HlLL3vcOkN8w3r9RL4QLw78riwjQl8k4zhFrvWqeWfziDNsuERO+JXV9VpPnvCQCj84OCvwSSzPv8jcFBRsro/Y+YYiedwbLnvuQu1U3BBxOiukQvysvkfzAWlk9+7vG7CKUA94X3rsRv6bEieVESFpiz8/C3iuPK2fCh8c5hv4D8VQr/a7UGOsRuy4EJxI/VFt+BIlwG6QW0mSKJUGUnEMR4xO0Y7LBqj6Bkojz+9uNG3IUsYFisk0xiXpC9zlPSYC+Te4XfXTdORTwfAvVrf9LZl9RSqdMgrimabXHBQxFRNrBZifIdZpVBWgmTg==
Received: from DM6PR13CA0003.namprd13.prod.outlook.com (2603:10b6:5:bc::16) by
 IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Mon, 18 Sep 2023 12:47:15 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::74) by DM6PR13CA0003.outlook.office365.com
 (2603:10b6:5:bc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 12:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 12:47:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 05:47:07 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 05:47:06 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 18 Sep 2023 05:47:06 -0700
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
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <69bd39e6-f8b8-4220-a217-44d3c947c6f1@rnnvmail203.nvidia.com>
Date:   Mon, 18 Sep 2023 05:47:06 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f347aa-362e-45b4-555b-08dbb8456290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8UlpBbtR1cv0SD/gHxlhXBE50Dr/hmMLC9JP4Qc1QZL9kgZFDRUy/GipnWMLcBMe+DU/cskDdiRWHc8bnc0j6fEob1hT8xqR7RXsoXooHsNrXDtccmwWytcvh32+Rh1o8JTVeRK9je6Ljwq6r4QwZ/43Eqa2v0RBQO2qCwhDAfyWyYJ2MhIcRpJ1kAqVC2HH9Hy944urPx/WANiPUwr8bQtD36UMH/BCBGN7/pIldL1HJDXXdsALO/n6CIA1gqGg7FHzNlQgod0PbdaUqUC9Ywk5gBfos2KUylrCnlTx6SzORa6Iozb5uWh0+ygKGmkrgo+P9504HWBOnFEDPQaQ4z3QRDxY3T/PurFIamIIiVYCStu4fpGn5pH7JcuA3aTP+ngThkIus1nl+1VHmYP67bN2teSpktkLGBaVftDQ6rhd5uYetilAoUJk5umXFAEBGlvf31zhfKC8njmaZmggfYQiY4ra1NXfcrEDz5X2e9XkskRp+xnVl1Wl1fTOkzyNWX3qHIbwLpTOx289dnwZU0SKn6yB9H2HA65+SKLtGpuqEqSb0Z9XFMftmOaHuzQyNWo0ndEKn9llJ9NJbO6EoTHOjS33tRY5nOveyoXpo0e/yn4ssVR4503Ww5Zkz5Gwqsn1guCzwG4s3PWABUY9nu0Mswx78t2iUm7n0UTyHeAD2mo5K9ytZBE+R8umkkQhSZ1QsssdUvQLeXasoi/YQGejZdlObhiPWufkIEtVgKWR6cMyD1kB6NFlPjLwnGonlcmrFq0LCIePX70Av2Vx8jXbdRZFAxnK9RhUCKORuw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(7636003)(356005)(26005)(82740400003)(8936002)(8676002)(4326008)(40460700003)(7416002)(36860700001)(2906002)(47076005)(426003)(336012)(31696002)(40480700001)(5660300002)(86362001)(966005)(478600001)(31686004)(6916009)(316002)(54906003)(70586007)(70206006)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:47:14.7531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f347aa-362e-45b4-555b-08dbb8456290
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Sep 2023 21:07:07 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.132 release.
> There are 511 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.132-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.132-rc1-gead88697522a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
