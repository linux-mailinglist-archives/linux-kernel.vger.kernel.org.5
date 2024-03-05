Return-Path: <linux-kernel+bounces-92197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC5A871C9A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859C2285ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A265B209;
	Tue,  5 Mar 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YKg5Db/i"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EFE55761;
	Tue,  5 Mar 2024 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636304; cv=fail; b=MHvuvh81brRY337Dujr/u9dFNZsJZkz1RwxS4W+PjB/pv7oLJzuC9SPyyACrNKrxxeSDn5CfGnvyP/D1FF/WlCUOjY+sJfwbMAb4QiH4HaZQqReat10SiUOW95ljI73tsa/3gbQDq/CGHlpqUm/ClJFdotma9drcENdImnrDzks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636304; c=relaxed/simple;
	bh=/y3Naec5aS86TKAh8HKel2Mpuu4gG9MTFJFwAcNd8mg=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=XnlhiZekv8c5OMPfK8454bYCdGUzoH9131Z4F8yDJ0ig5nfjMEwjQStRY9kYzANy7aXhs+efn2BqCQ3CNnUefk0wRxPyEIRNL0FdTp7CcV/lFSJjRtXWxpH9yhdpk98txcq7O2JZEsmgyeuyO+dGlWe+2TiQ/MDEQXgVkT2J41c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YKg5Db/i; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTZXi7XGnu6Bzu90BLhffX3KmIreB7Y0FoON3yTiXz7RbwviwVwKVL90CL0LwAChpYtW6EC4qh179CwP8AvA2ByH1DXFtl1xsGqa+10o91B+p83NNRL3Mq3/DuO6+7oG6rnnv2c9t2UNq8BkzHt8DxLqelIsVRjLCxALxTQvQOR+R0beUkcuiWMwVlFZB7QaWX3eHakyUC0oYa0aDAZkl7yPw5/9nmK3AjBvgp0QuZTIbR8NDdXDgz8zs7+cmYuwOmN6t7JCzc2lQhfc8Dw8lVsTDBn8UWGZwjL9iiwhngHzcSGrCdxAkgMOHqOZfkANGZdb+s3Q1KCCDfGZtinAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxmFWXRUn0Xe7EWmKY/VRVjHzXb5sF16ZPJ5ML/GpkA=;
 b=Z8S/F6VRJiMefNJcPp7CGL0pDifBUJK2Yyvr3qIRV3JSewsd56s1dpnPwcWe7yvgYgmAo9aaIP7pFcHPZsBS1AtZVjJowW1/rzBzyT8FZsPWaoEv01K9VDVAYKSbq+qHed2dMyLrrNLEXacCbb+f7BNAl5Azb26iPFoTAEvtUg4pSRgTjrjCQCO4vGMXJUA1r6pazMYqItQuylPxjrlckXaiysdinkOExJcc7EYwzzLP+H6yJSrv9RmoIg5h2wB74mtECcOYD7UMXgyGEFtAzGoQHMLR6PzJnDjSouJdzvgXRrFedseFcb/mSQyCGBTmV734NSy6YmNeE9V607W7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxmFWXRUn0Xe7EWmKY/VRVjHzXb5sF16ZPJ5ML/GpkA=;
 b=YKg5Db/il47RcNy4UG3PXWjv1jh2i9Vj2AouVcojv+ATz4md4s/+hQ267d7rp30ga2RKwferAr4YoFhw8mOswhLZ8tUX8vbjT3qRRiAl8exGBtGcimdlpE5bSB6jvBGHzpDWVhUzxOSfTIZx6bXeEcNrGWLrbvJUd4lxq6aj+Ud8U0LW3YvQbGR8Cm1dQTLSUAhLfNonbakWcPWGp1bS8CFDNo0L7asCpZnz/GfAOV8ivMdBHtrf0BnPNiuojWqth300eER1mpEt7vj4WKCiB3ArOh4y98Kyz4AR3IzzLes13KQUFKF8srkRLIYqwM51EQ4nsShMAz0CcBp2DZFyUg==
Received: from DS7PR05CA0071.namprd05.prod.outlook.com (2603:10b6:8:57::14) by
 CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.38; Tue, 5 Mar 2024 10:58:18 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::72) by DS7PR05CA0071.outlook.office365.com
 (2603:10b6:8:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 10:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 10:58:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 02:58:12 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 5 Mar 2024 02:58:11 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 02:58:11 -0800
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
Subject: Re: [PATCH 5.10 00/42] 5.10.212-rc1 review
In-Reply-To: <20240304211537.631764077@linuxfoundation.org>
References: <20240304211537.631764077@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b28ed699-2018-4f58-a947-7898df22b31b@drhqmail202.nvidia.com>
Date: Tue, 5 Mar 2024 02:58:11 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a48ae87-1723-435e-32de-08dc3d032a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7MWNoH9XscsL7fUupv0I2L6gP4Ck7ewP4dOyUUtWz1PMGYA9fKPAq5CFPSeLwNHip++M8LkGEqqI50zms1qfK9G2LbwP+rrdvpjGbHzL/B5SSnDCfcvt8TlAQbjKASFB88p8ejNKytnACYPMV5lajhYyDZKK4DxQTk3g1uc6q/7OLTUOe0H9sPw71dZGd5YeEpozVUfYUCuw5unR3PpY2qLmXs3tiMCRcNnmoLYZdLRSW6WuDv8JHnmo/2fQu5EVSfLGeRd6GLYjy1ufd/NHOzgkGWxvGLZo7e2qHyZm7hRfhJPBmYeAxF4+bCEeKWSqvfQiWKykLgDzw3vJ9D5yOUVBVqUSFkntaNU/NxYPnw9JKGuxO30Z93crUMYIUZpBuAzARPmnspDUe53dTPWCDsY7yQwFV2uNws54wIIHtW1gSF/6Y7DR/QCjYsRy/zy1AoGsK5pimB0VZRpl2cfGX5/DSFQoN7/Ctokl9VDQvhruf/D+dgzKZ9a8X8g7g+UMyaFxV+KSFzEa/9Z8Lv17WaNACxbUV5EUaRXrm6c6k3ckgUwIfQ2RatWjki2Wm7CG+nrUxcFo2R/OjYGYXMiLAGGnKtN26tjYKnEIchBZiwCl/qjoQr7VB5ZBT63EF3p/JG3oFDc+WYqiquzayR1NWSL/Tiwx9MfDns1i/NS7L6pW1F6GePAtaytJKEa7JHe++5LY0Y8mt0/D/CKiVRg7UgSU15oGC9aq/UFtLKqvsT7LLG482cu1uNDi8x/uAz3I
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:58:18.2366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a48ae87-1723-435e-32de-08dc3d032a70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

On Mon, 04 Mar 2024 21:23:27 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.212 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.212-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	68 pass, 0 fail

Linux version:	5.10.212-rc1-g4b0abedc88b0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

