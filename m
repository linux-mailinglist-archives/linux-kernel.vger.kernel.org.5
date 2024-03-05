Return-Path: <linux-kernel+bounces-92673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BA2872403
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E01B255EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497F12A150;
	Tue,  5 Mar 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ETGjPp5n"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47563128824;
	Tue,  5 Mar 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655729; cv=fail; b=hY41Wzv43y350KavAShlm+YZeVcM5Gqioj+5LFHGaERKgWHi+S+Jb8ezaQadEoxyNhczwiU8Dmz3y9motajksQrPKAatR5+s31PxVsraRxMdZiIdq5SrItqCxsqFt4CX83GEM5UK/oghmyALoUFeyL3tWUpd5gzF1OF1MVpGuV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655729; c=relaxed/simple;
	bh=e82W6vl3S+1Mzh/PWukINnuuTmUN3O9y+IVTO0cwjrU=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=HN7Ab18sbg7ODyJX6hlFA6DPQK2WFUo/ULK5dEA/vwYAahAP3GQOowBifM45Tc8vbnQZp7mOwk4/of/aPdyp+GDStnVX+EDzVfu1/PYattV3JQN5H8XHVMKnGnJye/QxFAzklWHBh9DJNzLsqCjHaNHg4HpjCJ7TAma2YAmflyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ETGjPp5n; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiaFv0aYHd0PhDW+uyVfrHiDC0hWAt7CAfdlTxXh2yQUUlGZrrdyXdEbg4h3rd6CcD97CvaJjKTyrFVI7OQ6ZsF8zQft8Dzhsl4Y/JvXnLp3fRO7UpwoFcYqm9Sy0KWWMyR4a4XraKbf6FrPsP9jo1zB3hezO3V/qtst5JMLi8IMksVCWX4eWlUQjuWZqSNM00kyYYhBwBPk2jmGUagNbAqgMmxarmBnogzYi+htDqV6bbJVJ5JYbDk0dy9NAyniwYWh2yY6DmdSYJR6Z0oAzsZ9I4phddh4QIzBzeFKTW8/oYI07iQZ7VC9S+xnx40/+zzRJQhkO/Ghr3In2gO7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m61mBGRLMDabyI7wp03bX2nV0Y5N7k61QpCvookCaV4=;
 b=eopAdRwsrMZSONUa3b7w3Phv4JJ9YB3XtPMZRzoD9XsC2Tr3WFoJZteNRQtxF2aZ5TEsXQPbG0pt1/Yroz+V8tkZ/zcHqK5P/XtOaNzzoMrHkaGvEBaTq8uuqZxFD1oYdeKFIz+K50R1gEpkJltJMzMzk7nQcnzHAU7Pzc3BSBCH8FSJsNPUhal38gB1tNak7jpS6jHibojVmpzU9sYDB+ikS0pOYuxs+TA018+8snP39P5qQk9kEVjDP0avQhqPLNZgkgvLS/68FDxr73qUwSnwQTyAT43SyeIjT7HTSfac3Vz7vbJmgUG4fItbiXMYK6VqroiuXYGH1GXbJSw3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m61mBGRLMDabyI7wp03bX2nV0Y5N7k61QpCvookCaV4=;
 b=ETGjPp5nITADnFsSC9S9S4aRFGqUiAn/eDIHRReGMITXvXpSjuR/FutPeMLqSiEBSl/U8DGj+SFZGznEuJaWOUnTwyBsM99sDIjc0iqNVT9cV+IEogFr+S9bgZ5wIbWhorDJS56gSXzLqvgihFpLj1IBC0cQ53+wlaAea2qEXdcXcSNHiaVD0t/C0EOxiWqDaOm9ejTup4HP9gLsA3KEKuGjJNAwxuvVVZrLp30vXxx71UaDiaCAWmB8DMsxC6V+HuBKBB+2torPHqbv3Ydk/XLJDu50rqFDwYqnDpyduIRiT+UGSzcxgsjwIgHuGzTshNMA+r/jETWbiiv804HlJg==
Received: from CH2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:59::11)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 16:22:05 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::ac) by CH2PR03CA0001.outlook.office365.com
 (2603:10b6:610:59::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 16:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 16:22:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 08:21:44 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 08:21:44 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 08:21:43 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
	<linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.7 000/161] 6.7.9-rc3 review
In-Reply-To: <20240305112824.448003471@linuxfoundation.org>
References: <20240305112824.448003471@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2394946d-a31b-49a0-ad77-0089f6db5380@rnnvmail204.nvidia.com>
Date: Tue, 5 Mar 2024 08:21:43 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb1b39b-ce1d-418b-d749-08dc3d306594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4UgMEhmMF4vansXDnRrYmUFcdtJaw/NZgxzwAm3qMA7nHIBort12D2ihFWr/T+E9wCkhgCJdSG7B8W2+xZeCb2GMzNtBzoMYD5c6JlanF6T+8th6oa6R9GKAxjiQ19iDK4C5SwK++r8x2xe5Zp55RW0iEsEx98ZOUervD02nMw1VMoaTieqI+1HM0I3GRXWjNppcj+YLVnDVTbdN+DIPBmCZPC3YTJGOlEHrSrCdF+/TkpqwhedYK1mfvw8rzHksnk/YT1UyV+g+x87h8p8fC43y8tRnNNXDFZsTUXQKq93Kuk/8ANokJfH+a7/A2OfrVkb7MIDeZU3r2x8YWX6LFcuwkq+lqlQKt5V0C5yRWNz2cQTwCP3btTiCfR/k1yMYKaDX21U3hEkDtWw4RryIR8C5YdzZ4sQYjvuhAxV4aYrFd/h6LsgxZ3f7971pRU3P52cjAqPazS5CXRi6yHQoWUpnHerXDzuC+9fJ/mX/8PPAGn4P0WkpKs3yk0v0jWxJvhLm4pem65lMGfDBAwGOKmZi/Jt51Xns9T8iV8OXXrwLgqbbZWXTNhYx2df1W9ibAFFdRDB4+loz0dC12yps1XRvNsSk2nrdxp/ouIO/eYJbb3mBOLJ+v2xnXkB6iB2XTy6R5fvqmgNLf4w4KjKLF6Bt/dWgQK+Rt4ltD+M4iG6SwTj/oZCldgOwtkJUdJ2Pf3Tsqs8hdnPA4NO3haReOJkyKQGXzNebnCvVvnlX50i4K2Ld3LPYYZSYQA2VBMNK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:22:05.0183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb1b39b-ce1d-418b-d749-08dc3d306594
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181

On Tue, 05 Mar 2024 11:28:47 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 11:27:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.7:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.7.9-rc3-gae550cce59f9
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

