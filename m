Return-Path: <linux-kernel+bounces-128548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BCF895C45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E71F23374
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353DE15B578;
	Tue,  2 Apr 2024 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SGfwAwm1"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1D15B55A;
	Tue,  2 Apr 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085226; cv=fail; b=hCkvbS0BvfqS7xBpNBnC3J1f1ei1iWh6E76q8WEbiJtPUkDYq3kVal3kgH8dMlCtS9T1xe2EJh+AkZqyLePa4wOe7Ej+HcVuUgB/3dYng+7G9U8m3Rusr9qPE13YBtvXNHUzPjzlx3WWH2hXvIJAcjUvJkO1hvwJ1l+lcqDp2FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085226; c=relaxed/simple;
	bh=Xlc86Y1DdCPXdA/r5RjdmdeOIsODgLTQ1kKZG2eyVxI=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=Dn0WI1Q4KDCYdg2NEjDa7mwWwAT6thXfSntLoL3N3ROf8e4hO/S3NyGDo7JvH0AwhGyMY8PGxB8jeV5nRQMwswemM/P95mDckDlQ4tCQFt0V6tcf0XTqA02Z/ZO3Rivr91935DqjXiOzkPEQLU37C1UT5LSyeW03vq5tRkZalMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SGfwAwm1; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyI4z+9fZG/zBPh5vdWmO8cWCj8r4USVvHaKz77d1qG56twdBHs6Ezqs8eiBN8zQ4HK1Eg8cjPJxk/r/kYtCWBtrV9rOSeOA7mdAIzD4rL4NiM60CZseTNhFHxYkZtqR5N8bPHfRBHflEBpF3IIgcYvOAfZ58IHN0JaKfQ18PDXVSQUISrkQ9k7I9LfvCSU+uuArrgT032qsKcVReosVJLgPx2GudUMlPJOSqIE1/E5HMZkowSeAPSGNqFgEaJzD43Ahm/pkcdUPytO4sUsy6d9IZhRIALUkCHadW17n4eCAbrQZd4AKudhcoNPN1UnTcV2IXQio1vFgDEzeIefftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IWnozPjIVIkbSnTVElCYG5HRHFJZCO2moGoutiDRMc=;
 b=ANe8iB+MeW8lMllnaRl6VdX1gDZ2cXEjF8PhG4+rVXbwDSOEbyGbagC2HkmkUN5jxAUomQhFX977Uq5uo9CocKgaa4GPGu60p+kMwI1ptMsHWpftkVsXI81vR/pEE2B6aRrYE/q2FAW8A9woukIs5RAu7H0SZQceefypf7EgV2DMT8xBB6L1TK6tnoff5uJ2Mx8yZri4Bsu3AgauCOMduhJFsvE5ehNfo00j9dOZnND8LM4Eo7pLi9NVxu0G/9VjB0Kl3F+fzvD2P+ouF7GES4ewu63aMj2a85lkpFRtgcf5/CLwe2qY6piiSBtf682x8HcmEzXxIXlvoPTNya3PDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IWnozPjIVIkbSnTVElCYG5HRHFJZCO2moGoutiDRMc=;
 b=SGfwAwm1nydgJeNySsfXvTS/iYWbrhYcXPE8TVQTGhb3Hpe+bOkNxGzC/e1A1ICljk9k9eS+R+ur8bfRB+7KxBN/IHF+OboM6F+bsy2JNDksA4I7ZeEMdg4b2hzH1Uz578N6eS4umx5DIg/l1Z1WLIS0X9NXbmsymkaYjw9WycZ7nt0OtZf5RG2JVSBQ1mYz5917BUR+xTQneelQ+5g81FzztNy677Yj1iFeFaK6dBlIlLp4vpRFbxbHf7LyE8fKP34UR/NrVPuhjb155dCea5n+UXBDr3hzorudBqYCDEohZdhOGM9dGsF4MzfQpkZgpEmBsmI404OljSKLCacHhQ==
Received: from BY5PR20CA0018.namprd20.prod.outlook.com (2603:10b6:a03:1f4::31)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 19:13:40 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::57) by BY5PR20CA0018.outlook.office365.com
 (2603:10b6:a03:1f4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 19:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 19:13:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 12:13:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 2 Apr 2024 12:13:26 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 2 Apr 2024 12:13:26 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
	<broonie@kernel.org>, <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/272] 6.1.84-rc1 review
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <46af83f1-9a3c-4456-8366-821d75a194b6@drhqmail202.nvidia.com>
Date: Tue, 2 Apr 2024 12:13:26 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afe9358-d25b-479b-981c-08dc534901c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TRsu6iM5Yk3nS+yfB/SkdQ+4YLM5z8f/ZpGtBqxm0+2MGjE0YhX9o7JJLLn9aE6w0UQlYxMi1RNywTLLj+hvvjTEXLWLwmSjBozl64cqeOIr3N4W/h65d5d/1cemZA0vWX9vXDYy6pMg2gXnWOERIang7wl8TU/fI/GzbmSY5cSebHx0N0TCOLtrYRV1OAwBD0oQA7EaqTcIQPDnqojmIjJJcncyp9XREjAPrpwNUsuGWQsAfi89QvreL//f/ocHWubtZoNpogsyX9+bu2PsVqNI1verEoBC9SnQmvnPZ2YvFzjtUHsTpAdWeGyJaVbHoBezHzHwVsyi1bFhb/ybGDU8Kf941M0fe68yS7KLK7DpBSWd63D25jCWiaCE8nk/0j8JdDVyp1JadL96TbKHwTqhjGI+iBBksXJ+TNaQ0yUsI1A4GM7ey1Wy8hn36vck/WdMdjVZ3LYaYsKBgkZyg88tfFnBiijLe28At3VfL57TFWvbDw4c09F//h72DfoJv3iQuM/1rzRzqY77tVE0yQJct5e9g7ZghWVyINn6qqRqZ1eW9ssTn9KqCAN0lSg0qncW34TsrD3KAQdB/ovkc5mZkQq/bNQByVblaR1qAkaeRPtmKenU1s5hTuQIX5fDPkEG9jh+yJcOMcTvQiY+xzr/mahi6LJ/jy5kwdnT8kZaqSlKaKtFAkgGIUTzM7HtzMLJ6J1zcX08ODuPQctDnyH3fCqTi2W1BkaRn0S0xuk6n1nBby+KPk7dBm9ONWfn
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 19:13:40.6572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afe9358-d25b-479b-981c-08dc534901c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207

On Mon, 01 Apr 2024 17:43:10 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.84 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.84-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.84-rc1-gaa2042702765
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

