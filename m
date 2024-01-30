Return-Path: <linux-kernel+bounces-44664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3A8425A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642861C2830D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155CE6A347;
	Tue, 30 Jan 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fIKcCfB3"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7167751;
	Tue, 30 Jan 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619661; cv=fail; b=bncm4W+441DJ5wiSMSUEpSyVkuvrRd5kwkgFSwXQNIc6fFk3cJBJFNa2sauM9V8h69kajSxMDPyyKpAa4ifQAAcwt9qdTlTgSyAaYViaWZCGrEYC5XwshPFwPhWXireq/2CtanJ7eLC3x6+JEp4qvsiZeyVT38a29ZrTBxSadEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619661; c=relaxed/simple;
	bh=NmUXFr2R6r+QJuu9eqE0AYWva/PTxSmN9XuybCm63e4=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=iDeAOa0iI5F0ofVY5U1Tli8SPtDKCrqmXC7ujHPyZpTU1dsGDkaSRY42tlfgh/YMO+W+xmbwOZAgxyRVUeQ7S+ZyAYurMuqq/+Fn2Qz5Oqtmud7jgaJbM8NeSOmmAwXwc0YeRhyYKednD8CfxHIRdl5v2TcBFY2y+AOFEX+XNsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fIKcCfB3; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+YwImNzWUM/0MNBUY/t/w2LjmNk2xBhkCyIFN9K7TrrxpQce0AEUczOZBdAV0iBS/dOYMghOzrSsKKF7FJJ/nRSCZVjYXJzBgKbzzMPrR+BHgEXt6+ra7oQVsIc067sLUZtNm91Aig+3liRsw2nFJST8+nHwFqvEt3AcDvNVDcMjvpftr/UQZ9hs7xqOncPZZ/hB3QH1Wi4fRD7vVuVoQTFthgDGY5wXNhRIFyVxgH11GloaiD8wvn+nn5G1LFrOPm0V+gfmO605Wkd0nXDJlgGMzwT3MGmZWZu4v0Z5RL9/DcJekh4jvFAKGxpYHcYv5TMSTsPnvRDr0QDmZxFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJVMxkd8SRVYLJ+5bDOfetjDSpf2HzjCD4Wh74aYOYc=;
 b=S5NEE+Bpwjdzj6kHha+T6SGwEMu1ywtt3q+dN3coIw+793Ot0tbaigReLAJz4H9zc15toyyseoyxH6NN9yIIC5seKzbitZSZZO0QRLCBvgdHq76z1CCeXBi+qhdA7fhJk+MJ0o94enPSlhFDYdoEL94AvvjTRF/TYNtAoqm+nk35QIlzzFpKcLkZRjpZRYyqtHAB0jpD+VxSHIEmn9v/XyM0Pfv9Lcgu7+kWiCz+ZuVxshsXbljbvYHj4gmr6ojRSzF4JZs1xnM56iY68KA3kH2xTXhe65ZDbj20XALRT8cwohKdK3HbF5rjL2T9hJFUJZsUnbjMRWsbgzr+cRrJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJVMxkd8SRVYLJ+5bDOfetjDSpf2HzjCD4Wh74aYOYc=;
 b=fIKcCfB3iPrRXZOOKL9YqHiOUZZ+nFjV2k1R1iTZ4YL9o91bSElHGJ9BOx7A+Sai3+YeFcSveljvcXvG4iqjFDkpnrUhVEXaLAmnvGXWkSqda/VHfR94iUkbMazSg0dOv4vCI3Ynhyz1wNrTDRc58aWHh/ECpLJjbT2QGVI2d26s25dRWznVtGWbarQXnXvyKYG/QrxPbGJHxwJ4jP+5c8Hiq2dHhHcPoxZmHapr17tfGe6K3J61c94hqqQiZMJnSbmHXAGs0kImRvTwbjV/5+Wc0hr7ut8amgEpj5sTO/LPJBKY2mTG6bC22LjfNKAnJ0apN5sIThV/o0fF/hkevw==
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 13:00:57 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::c6) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 13:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Tue, 30 Jan 2024 13:00:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 05:00:41 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 05:00:41 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 30 Jan 2024 05:00:40 -0800
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
Subject: Re: [PATCH 6.6 000/331] 6.6.15-rc1 review
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <758684ee-910f-4095-a3ed-783ca40411d0@rnnvmail203.nvidia.com>
Date: Tue, 30 Jan 2024 05:00:40 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4a7d31-05d2-40ba-1451-08dc21937fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C1uA4yvhPmb0eV7AHVq+JU1qpJZYRhJxYEuzf4+hevlK6AG/2hAb8PGzTH6Vcu+YcEW1MjiHHGF8FO/Gkcds1Br7Sa1yKfz2PQdjYCGiVVGunqA1TXIMmU1Nkao8KpxzeW7+KR4SIAe86deiJs+186pDASPMxpF9JQiLyaNv2SGK5DQ8uXGozOJTmR7gqPMmjqw/4idUdn6uWvq9P78VFqHJlSw6/um7JAEUTaDLU5hI1iH9U6rmyYuY8iWf88/UzbnuYBuoLWLivWZyjUK6eteNSK7ZimqM6OVnpo4S5ykliQyUN+ElqjskmHbLukCkrwlVqmCclyCxuLD2W5FthrErQoqSSp5DevNUJyQUIdLXQKCTMjDg+S3Dsy4kvkERNo5C3MiHpsRSxRhArN7QcoY6JY839cljI992kOKDB6BExealpcTh1z0fzVWA1ItFuVxOk2PvzTIYRb6wwvKaPJEwjY3rJmKwxxgZgUuOz+S3pFtPu3UDQA1SrChShSQ6NXirlNJ4zb28BnC1475Jbr9cgS6NT1531wVMum84g82sFYcmBrWBs4tjQhsGtbmSE5x7Us5vw72iX5TPPGSIj1IQstkWYBTC/cV0FK/ILFQCM/C39oXlbDBAzDKVTL8fSjsxD98Spg6i3vilssdewzd3AKt6VvJPm8Rf2GClE2l2zaNFtb1kaAnJlSQ/xBEf5OEMxYPFNz8e7XHd6BTBPt4fmedEn0kc+jUv1bo8gQ+SB9F9yojSLILVKLRxn+c/4ult8uFioadpjTcFAalCOhrbpk1huhIAryFVJEOtOiI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(316002)(54906003)(6916009)(31696002)(70586007)(70206006)(86362001)(47076005)(40460700003)(478600001)(966005)(40480700001)(36860700001)(82740400003)(7636003)(31686004)(426003)(336012)(26005)(8676002)(8936002)(4326008)(356005)(7416002)(5660300002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 13:00:56.6482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4a7d31-05d2-40ba-1451-08dc21937fce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528

On Mon, 29 Jan 2024 09:01:04 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.15 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.6:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.6.15-rc1-g1ff49073b88b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

