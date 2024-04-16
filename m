Return-Path: <linux-kernel+bounces-146635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E0F8A6896
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689EA1C21542
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186087E0F4;
	Tue, 16 Apr 2024 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nAGvkjMY"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241B6BB30;
	Tue, 16 Apr 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263863; cv=fail; b=RsVM7Mni/FkOIDTsu40fiAUzhHby6ed0IZD44Yk4ShbDD4BjIolldHDYkoYfUhaamfJVkgex6NRr8GySO1sh9v0mndXgr9yu9/Uait4kd2mUw4ZM5a5hJTiUwlV6h+coZDjLr+n/3k81zix20ATMJ9C9Gnz+Lul22qj3DDspQhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263863; c=relaxed/simple;
	bh=NBLaSzJ2ml6DgzW98I+krOWt3mPW74PAFoajVLAdEzE=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=df/WvwkEficp9hSHvsjaDnBRY+aPawcmsCfGiAsNEs4fjDWszSengscWSWMVlZwbfwxuCyyFtYLaHrTlA+e1ohrXQ5kZBRreP+tAj4KUe2+guFfp3fUtnA0dRxj51gUc+XS9eVi5+nEB3OPu3Vl458eo0gzjZteZNwk4kI20OXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nAGvkjMY; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKxom8VzP9vhSU2REK6jTWQo/7YWeH+2qu9vyftrnnKT5AftZjREdVdlaxbtD9/NEHnpfmFrmBUkqVAXxMRSYmO6am/Cw8ceFWshWXDrXQDT5gtuYWCxEzFqoDkhxlOb8CE6bDrT0nv3Xb3LTta8V0Zr5neVJnpujdWV7Qv0SrTwYx1kSpRHMuhSFDmY1UN6SxMNZfmWYKVeXCS/Cu7nUiOocbTzcqEhLAf0InS2SWcuhllPMhVD7m+tEYoRL9XInzlBbyGojtaxl6SlT5YlWGNDkHtpeLihL+AcWGqTwadLDnBM0/2yFvLZX3hGy1BJzmYyxJhIKTW6jU9dVAzJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HefBnKZXLy90t/Ue70/4BfYppNM3DAVFwN5RgK02BKo=;
 b=a5pULuymkBrI816t60CXq67QEe2sx8nU2ROsEz+meAy2Gg91/42EUedURrca4aUcIGqPIOq9JIe4tsh4ZzqfuBUX2vRgopVEWNjSB0qZRKl5CwgB4Fp6F1haxXtGO6QKbs2Fj7pluAAzyzGfNrcbaUgIJMSOwTT+huM95xxo3O2cXS1ktq6ddF47RK6bHIqXMTssRKfwV3kpNpsJrRKFh96nk7MrwSgoxi8FLbCzRTKqyWQbHWQrDHeHdBvbFOBtxm/RydQ6Ph/RrDjDN4imMjh70D2Ww1v3LUGO8DqyyT6Qm19EVk9I3VcieK8rlkR+3W+3sNSJloNHysIbJ1d/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HefBnKZXLy90t/Ue70/4BfYppNM3DAVFwN5RgK02BKo=;
 b=nAGvkjMYmxbz8eK/1XFthDsAwEh63a6FaMqgAQHjRRsz4GjGVC0ezUUP+iZjsR9LxzidjkQCGglrVvjDgRXCca2cxbzV3ZSnSeqPS9rVXzwlGZdwS/BuJW7U/CztO+PEyTZ9i6tVJvAmW7YRkFmLrXdRrpaxqmLQJP2uJKKP4pvJmraoEDvDVAcZHlM9OAzcFONQup6APsjqH8iAK0YO0qq9L2FMyvnHLGvBxUgK5DHKXFV5IWiv94NNbXg0tvOZNNWrRAS303iJQgwaW0Z/KqnDbCg33B1gCKHnajK8S1Dbd4eGES54e4w+vnKY7N6iAn/DGMExf7I3XxPoUQmjLg==
Received: from CYZPR05CA0013.namprd05.prod.outlook.com (2603:10b6:930:89::11)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:37:36 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::98) by CYZPR05CA0013.outlook.office365.com
 (2603:10b6:930:89::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 10:37:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 10:37:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Apr
 2024 03:37:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 03:37:24 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 16 Apr 2024 03:37:24 -0700
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
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2c09dd53-a5e3-4b7c-9240-21eb9c10995d@rnnvmail201.nvidia.com>
Date: Tue, 16 Apr 2024 03:37:24 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8ab65d-f9d2-4cf7-1db4-08dc5e013b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NQxgWbZ11AZyT3pllwTzFBcRAlWlS/TmRXL5/4qt4hUppWdFnVb/s7cbRYhIBMYbR7q7wrj4DCoDinqK8CowipICJZ+J6BRC8d3pIn0M6NoUOYoHj4OMLK0cTI5rUuvyDS/Mbavky1fFKQsB2YiOtPA7lgz+1KTXeF4hlUmrpNA0bxnvVxKPR1j/IGGlMfXHpQoo4aP09k2h0MAw53jOiqWsk2+wt+q29yECSP751KF1TWcFJ2pMd/pDJfDvICbj+sXmCCJxD+1XXTmzOZuNajYLi7PiapeAR9EXEq4ZIgJVCa3o5+QMsEy0/+aRrjYCh64AExR4+E1Jmyxz1/lxWzfc5aQfMDwXvQ+BQS4UoF6kRVofx8Y8UlBFGgE7JRSB9LaPY61yiM/0Ov/Me/AjTkPqp4FGfa67+5YsMp0+5nK1lhG65jKnWULv/jIv0id8UI2+dcm/j70Gw6w5X/LeKns2l6iSk2GirmdbvDIZZzAj57cFS/W2JkeMJQ6wUnicf2Rb1vh8AGolO/9Jz4wWh9IFkp9DxWNoR4GcL7W0Pe4UoyGsfhNAHkUmj657uidKYBkOyFKDgKNhXQV7qS5XPUzXyM6v0AY6i0nZ+AV1j8tWLYKB2WZzikaq4mA9n5oRT+WUktf3BSveNksdN2j7CRoG1TIfiDJHXdX0cIZFI/neMsAob+KW79KqkkWPOVHGwLoBdMSnW7q7ooQuYU/jS6rc3a3lohJJkeCigYXDf1TwhNFE0acWebWNWqmoF7Dy
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:37:35.7407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8ab65d-f9d2-4cf7-1db4-08dc5e013b10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278

On Mon, 15 Apr 2024 16:19:25 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.28 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.28-rc1.gz
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
    102 tests:	102 pass, 0 fail

Linux version:	6.6.28-rc1-ga4e5ff353287
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

