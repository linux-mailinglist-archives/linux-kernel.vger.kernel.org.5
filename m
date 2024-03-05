Return-Path: <linux-kernel+bounces-92200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528C871CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4727F28582E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E15BAE9;
	Tue,  5 Mar 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cPX2o7GY"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B25B666;
	Tue,  5 Mar 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636310; cv=fail; b=qkzY4ZrCIGEmIjCHssuvoFxJ2zuyW7TBJvjT0bL70bh7q615N1zBJt8eP6mstQKEnQal9uA05fnWbEKuEtvyOYiXBo3SJP3jpPuV4cwgDzIPbi9TCUpBgh76f+8/Q9cwjED/wq3aXrV6uyqr7r4ecLYQTPeoJjMtHQ6aSc502Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636310; c=relaxed/simple;
	bh=/vVj5Mvu3YSM9r8K4uLNF3trK3ICfSfHZ+Y67Bo6QMw=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=U7S25zzCiZUpvo3OGC+lvgSPy5EJP/YC24Ofo3csz4XnRKOk++xN5iqYf/69QJZ9YBiBXm6hXMUmtqmRuJRbQcXWtVifZEb0WWN+WfkBnNrbAC9KKOU3COnFV9B+3b2jW54tSl6VW8grxRRyJLa0ISJ1gc6OwBe5NjL7dCaB7DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cPX2o7GY; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw+xNwR0thddoWWWgsZi/2GxTctuQrEFnuPEKizBBb0cpTlgUCJNhc3XSsUfmCiA1PYeEDIBw5ntTmfBLDZwXXt4zWCZM+QC2/kl6AJBK62snQqv8UKsuthBHLf4NJB7GS4WN0GZMOXKluZ1Lt12gNXmrY/F8F7563SsyGkQ7MD1792QPSmGtxIm5gI/6kaxErTGprnZgNu393TTPUjiczTwbt+ja9XIXavr4P8L5jKwcgobdIkvmhEBte52r1EmSplW7jge5GBrWAutAJphxUcQf3flSNGEWZqsHTip1651FhbKZCdq3ukFh1ka5qTFfjxENfVC6xiIsIWGYiuVbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze3eaA8PJmGL76LY3/ex7UnRfF6fKLgDfZF446J2ZgA=;
 b=jo/uoLTkV2ff+hTlL8P2dh8H0Ohdg5v+fusIbyz/NaN7sXRRjXevbLfK/ALwsdN/ZCxUNzz9OtyKoOavxkqc66rKEXfuzIbi6bNMymCGvAniMp1zuHWYTQ4L2XCB6WHFatnydem7pJRNnjpvsf280eHO7Z5yoOjPN3i5PCwK06KWRSTL3gcd7hCNYMuAVVS3riWyEdYPPGG7ugM3fxemwG0IQ4G619WYcE2gDri+e6d+ukdOFGp0J/tysKq4tTsiBVblHjOcQQy4cVKoVYi3s5d7mmQWp/c6302b4Y67vUXW5vkD5e6NrWjubgGsLIEBH6JpLKs/L8nf1RNKyCmnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze3eaA8PJmGL76LY3/ex7UnRfF6fKLgDfZF446J2ZgA=;
 b=cPX2o7GYWULPWxU1un2IMESMUGoqRpNkKIjuF9LGP7IlP5ruhrL6q6BVi3cory9dRPzKX9YPqj2B/8ZNx5kIGFWIgyYYqmt6RhGQEk1E5YF2QGpwAebrCKx4mS2H16v9MfcobdnljTvHrfpRIS3U7e34FJgI4Od2LdshgxUTHwSZDtOHy9YQNaghp2PZL22+HacgmS1c8+QGKT4cs0B7a3k5J9breqyDyAzYE/Q3XQ//rEeAYUP+QtSP2tKj1SuFowxNyzTCudWZ7PvkMcR9x1Y/3LDzKOazoms7nDk6baGvZWORaRPwXLQQg6TTsEjkMmmDGKHpZDM/zASKJxgBAA==
Received: from DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 10:58:26 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::5e) by DM6PR11CA0012.outlook.office365.com
 (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 10:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 10:58:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 02:58:13 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 02:58:13 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 02:58:12 -0800
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
Subject: Re: [PATCH 5.15 00/84] 5.15.151-rc1 review
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
References: <20240304211542.332206551@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5eb18358-4a5b-4c7c-ac54-12c3d91b269b@rnnvmail204.nvidia.com>
Date: Tue, 5 Mar 2024 02:58:12 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 943cb959-4df1-42bb-cb97-08dc3d032ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7qMr2LTQHz3RnQz3pGQIr14t2wjNmJneROT9jeSrMRkSZXMPRKwQtv/rFD4CMFpGsnYbi0BOgAfOr2bQpy6p0BifPV2UCYbtTk9850hUuUlhgxGoGvQKNlJlELw3JRXL00+4TtxxGNLUpnJ0YpaalBF9rSY3QHVaV8rHGdcRNQ5Qm6XbpBTEW7kUMT4XiXMW8MAUCH3UAxNbyU2SbTICQpHVTaax9/yfd6S41j5cGvEDDgAk9P7v51aTHFLCgopcbh1SmWTLpBadwK0JeEXLvOB5Mz6n7W0Xk4DClnV0hceM1zshU5esHj3xoEkSiow4UsFrUBVPvKzxFaWfoeMSdpyxxtOPQKPkBtGcWPavbV5tTMBytg6lpyKOeXsOOKcpA4YyPqh83XikuMxZVzl9hEaZUh98pVN/jniUMhGq8EnmNn7KyB+O7r+baRTZTOaWPiGF4Am6IfG6aHPBFhhbhrTbqURIzlhxidDlgpanuQ945Ge5ExTaNPzhKU3UUbzhiexvm8RP7zOkFG6H9xjAfirSexwOEFFzIXFtrEzeiCRdfUi1e9rivan3wFCKQ4WWTfk6fYbPtCAlbH8hVZBU3+8rC4o98jPjT43FgeY+EWj0mTSEqufO7jMwOkxrp/L9TNUMQ97MGrN6GeEA96yymjaRYSU1fzDJzd5FLJ1FMByeZNBTeXyfA75aACh1weJMO+CfFXB/c+QYsgUam/2gLL70lnyoKBsBX04OyH5CWCD++WKeuU3a/hy0+O5MEEJ4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:58:26.0680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943cb959-4df1-42bb-cb97-08dc3d032ef9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

On Mon, 04 Mar 2024 21:23:33 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.151-rc1-ge7cbbec10c6e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

