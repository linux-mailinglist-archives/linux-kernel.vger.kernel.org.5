Return-Path: <linux-kernel+bounces-92198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5D871C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C471C22170
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC085B684;
	Tue,  5 Mar 2024 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d8PieQsE"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AC5B5B0;
	Tue,  5 Mar 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636308; cv=fail; b=FL/xkzHaYtTbWuujnGTU6PSzEDjA/ookFlgvxGg4rXvRF6vEMshcx2Avo9Cbkki8AySfGGBjMbZFPpEmFPM7hkyxy8cp2pWmkVy6GJY2l+xehehdrrH3HBmcW5E0D0umeOZ/7adMif2p7GqXiOVloeCbYMatkqLPOddLbOZLJ4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636308; c=relaxed/simple;
	bh=rQEblhNfX9DjmGX9sSEdvIq8UaK/nrijevuEb+QQ5SA=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=TNgGp17WaagmTY2jheO2wP6W/08OSp2Mb59kz2eZtMWtK7ktVVd2Ylvb+0B1Kfpge20ofJeJW7cBQECYIHY13z10jWuWKuMJCufuhzPnDEVK0ijP+pdozAAygLIreUz+CyVZiGcgvT4fsQrF6YHGpv9OG8unxONdlRs1ArfOZPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d8PieQsE; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVBvzLkIHE7AqmlTmL4p+QkR8vlmnDFe2wnf4Z1HEqpOLc85jAPK8U0gEP5YLtQOTc00rOTGjAU8KDfHFZtrpG85nRdH+VwgBy+LB3Pa00mnItyh3I8h4LZJdekn+CFPfOUvC6KxQf5ynplKj7e1iicHjiJ35B+Zhu1MwPvWRK4B1451naAHCfdj+3AOfWpCAe9sFfY9uvFTpSevwv7MkWXkaKCMoLCH+WIi9dQYhN1Fu68aEL5fs/TyyoE2AZS7bDst1UXt2kzg3c6lDsZWblBaxCwDhXdnRxK1FbGqvBl5AY8gONoSs+tMz+NAvmrFNTbpNc4YA+8yp+tmyerc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF9jnfmDd3w4vype3Fy8YZ3n/Qv8dGEEIyoH9w8Z7sY=;
 b=i6OXi4OtydUV2cT8dQXPIp7QbtY6FewP90ly6n4vetmXbHOZVa5v/LDDAjGi0GdlcYvkWmcY9pVj4eub46vwlskT3bj2UJaV9+Yf8avUwJTbJfj0ypjBtOFinLPAvH8+L6zhWlFVUjXIG0fYIMnQcA79s5NMTIBX68ATYDm6ZDOgOoqUpm1K6QjpNtghil4fMjgLr7bNouaOZVbYxQw8AU0w4VO3fiXkcmh6rHs+zOSG3pz5E9Jb2VdVnauCMoj+1NrluMTXKaou8A2HwsDBzE9ONKyMhDAb6AwmxdrEDQdb2hLpBz2LmrscC/BKolT9VfXbvGZpDxR1wkTawY4nrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF9jnfmDd3w4vype3Fy8YZ3n/Qv8dGEEIyoH9w8Z7sY=;
 b=d8PieQsE3lzkQVMZXZHjcp+Jdj5FLpJJ3CPBVEERvd+dU2yv8M9gKfmk1Jme82vZPNx2qc6i91zXuZ4IKuEaMkEQfvC7WKm2jMziU+j1e0fOJ8exRzcGa7+yfZKgW7cjoRXzbi9Y2Ny5iFzpeYcoXqB/B0EhcVPuMPNC71wGL1qLu6+kd+Hka6X2gBFowg1JJV4yDS55i7vDVAVg/Q8w4S60Ag4d0tOu3q33BfHnjKQ0alcWxGb30jhJYNkmUPFf9U8OEUf72vjSC9iggxzZ+AwATE3MsFT7gS5MCSPnglKyjN1uXgkeY71jwoqMCichda/xA5JNhugs+S8X1mpKQw==
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 10:58:23 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::f8) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 10:58:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 10:58:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 02:58:14 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 5 Mar 2024 02:58:14 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 02:58:14 -0800
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
Subject: Re: [PATCH 5.4 00/25] 5.4.271-rc1 review
In-Reply-To: <20240304211535.741936181@linuxfoundation.org>
References: <20240304211535.741936181@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b886964b-f276-4edf-af14-4e22a52474d8@drhqmail201.nvidia.com>
Date: Tue, 5 Mar 2024 02:58:14 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: f827c5c6-02a4-43fb-b914-08dc3d032d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AStJwDL7jCZK4N/l0BKS05OB9orCIydCCyhQ9l2j3YOlyDxQ/iKY7D1m2BCqEWi4+Lu1XqcoGpUnTd1Od2l2Amp8fd9UgZ8a3u1yAQNzvC+ozql2yYgG8p252VtOJkTphgNLuwF3y4CA8OJQ61eorG7bt1rrdyvaAPEXrcAZpwfiw1rJvxY6iN34mpU9bhrw0xZcCoceeJ54usBCtSkolEfTiNsFlx1qlcwufZxHQ6CANYyv7vUPr8nuWe+FrJjb91+d88CnTzQcbs7yOH4PTBfFf/Y0Ob/0gvKN51DJUaJ7/BLcD3OO9UHU8kpDrewYWW+GJ/0Lo2mxPObeulS1RAEkMw3IhRBrSX5N8Wti2R3DlLlACUyZR7PP064KKbZCEiMBodxUp0imvzz8n5yujSsWSHt1MOyR4AHi3S4jIJwBezawTI7+12YSdaX2VtZ78zEtP2ZEoEFPhsIEh0E4nuY4iQ6Ba8zK66Z18w6JG60ttSq09ozJwgTckxFLQpZeObZ5xAPtfCdLJpcg1Xy6I1DAxgclL7Np5jR9+TkQ9R++Y6KYS9RnMkmcIMmGLshmfphYtiEni5BW8QhIX7cZOd1zZmi77KhW0whg/ahlhFeuyqrZAm65oEIYgR6JaTbNGSHey6lM0jO1j2BKpoFyDnOrkOT8shMduEt1Zk2jUQNWOHF/+ObvhFYpZoyq5cIOSj5m62AlIyZvnd+oOon3CCxAnqHSYfKQ2t4Bw0E+qAndLLL59Dv+V8aHEAQVKhLw
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:58:23.0831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f827c5c6-02a4-43fb-b914-08dc3d032d34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222

On Mon, 04 Mar 2024 21:23:36 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.271 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.271-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.271-rc1-gfe27532da81b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

