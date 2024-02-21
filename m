Return-Path: <linux-kernel+bounces-75424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102085E884
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4691E280FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9552212BF0B;
	Wed, 21 Feb 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JyRv77H8"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE912BE92;
	Wed, 21 Feb 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544941; cv=fail; b=FBELu4sZiGH0lRUILRtXHwOSs4r7b4XPxanbAJl3Kv3Xo3NzJONc5po8N9z2d8RW46PNYjMj1wRp/V0PcX6U1Mur1djJF7IAWXgs4E0W6zuDZq89Uh+g12hy7Dga/sayzKjzy0PFqsVF1CDxt4+GJU2LjpjGzLGgccUU1E+Bq44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544941; c=relaxed/simple;
	bh=ftN8Pkl5vcQiazOKAVGKiZzn397xPLxbu1KY5ZUXJck=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=eIUcFPMWWGVLY7ucVpRFe2vZ0JG6foygT28WQN2REsQVH0yFputIWeMppk/yeJTjqysDIHUCAiFw9Xh3R8h37+SWnbZ/7w/58x7dEWg5W6orhcxqjLu8lC9zcP69qI7cY8CoPDhSI9LptA5Kjisna5WLmmif8wxUHNA9qJaILyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JyRv77H8; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw9Euc772rxc6uiyjotSpHXl/WErJir/UcTTY6/0y8rYaSjp9Gw9LuH82qG8u04W4PTr1DqFtGcVDvkmHO9Y7o83k1ldNMlLAAgdEEYSzbnCjtjJ+ZYxW2sQ+pvdFP2VBw8WsgCDhlaoDXRY52s5EosLNIAIQO5G2pt+W5G7gSCCVYcnP1KF7Bj1L6nwbq9WqHNfxwTvuiG1P3mgCxDhJK34IJixgqF101dBwruhr3SPuqw2fHFXg8/wTntCcqCX6upXaFMqe8ZugN/RZYs8y9hesMv61cp1W1a3z1XAQY0KCa7DXwV7fayf0a+HvY28O6RaTHW3xspHXz0keCgddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94bogod4vLpw1RJk0pG0LrVKAQEfBxtfyEalVrGqIPo=;
 b=ZYv5khLlvwAeX1UT0jzl5Wv6TDNvfYiecrZlYHIjEEiecKdxnxV0zI7BeD8khROY9Ik2l91SD+jyDilN48Tz4fS2vkFSjERpOFbrEOr4wo6CwdoQZkfyMCsLgse7hBkYltw3EfPHHYOyKfGefc5OZn4Bf9j+gIefNfMBUJZSOaoPiH0QI5FgalVoV04yFDYa0CzGQqBvqQgnK7tW8+NW4m/xZMK0Pywzld2e3Kgv0vV6XALstTCMMArYYvDz57IYJOtc7O46xB8e+SaqH1Z3bJN2rXSg8jFliWLNJZcDyh1R/CZbaibL95XGMbdZMsRN5/w09ScmG3Ah458PnnyoRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94bogod4vLpw1RJk0pG0LrVKAQEfBxtfyEalVrGqIPo=;
 b=JyRv77H8oBXh//UAe3bsWOHSg9Woi3CvIKXrhMJv7SjalQX7auXum1lxOkKwyOThsl+AUlTuMHPoyWqehjcc50xGljANSQan1AkLGgRzbTm/tfL0bcx8xQrkeCZSldT7XStyXwx8MlQFCNuZVL46XnTnXEeutucQMLtmP9FgGs1pkKTDWsKc0uW9Q4JISBGRuxAtUnpL69pCK3mqtNXmKxaQIoBQffljFU/IgfP7UNqTeTO0wZ82/SSVFMxRzkkKysXHS3xOuhla7IdBh/qzFYZXYjf4ejwotzLKTzDmbdCuAYZK3kFi9vs5+iSCSZuWyaRj2zqTp+Dui2Ekn0lKPw==
Received: from BL0PR0102CA0068.prod.exchangelabs.com (2603:10b6:208:25::45) by
 DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.22; Wed, 21 Feb 2024 19:48:55 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::c2) by BL0PR0102CA0068.outlook.office365.com
 (2603:10b6:208:25::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Wed, 21 Feb 2024 19:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 19:48:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 21 Feb
 2024 11:48:34 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 21 Feb
 2024 11:48:34 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 21 Feb 2024 11:48:34 -0800
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
Subject: Re: [PATCH 5.10 000/379] 5.10.210-rc1 review
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <94dc9cce-2c37-477d-8065-da2552601979@rnnvmail201.nvidia.com>
Date: Wed, 21 Feb 2024 11:48:34 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 43708cd7-8767-4588-bc48-08dc33162356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AwyPDVsElcpBPLLy1EypgQrYqLDHqnri8HzkzdHHRJ/2ce19nM/+B57rZWDwW7pwrAuRj7txBPP6I4G1KNWNbpeLsddcj543jiSYayXGFN9vY4uy3M8N0FZuTwAvDDNSjIao7BXdXWkOskkhT8dRWNM+b9dsaDGFng7ZgWRGM7qVjsEyN7Xp7xXLDnwl6R3yRtrlgS91Jkk3EpG/WO5xdOsMAJDYzW1Bej3E6f5zeCzaUqSbTaRz6+AbacCZopxaN7A7LTa1fg7duTw/AS0pHqvRs2FIHH1RKyq7k05C5WQcx33jEA65UzDaeyw70G9R/J1x5ho/BN2Nx6OYHPeYfJtspWAr2Rapl4usHc7rayG3wVL3bFImj/jD4HbiyCFmbuJnYaQol96ZZSWJQYTfGPO9bSr3kM6mZzAgb1hKOMc5IkU/gFQbxY25ZoGF3eAnkOsuMo4z2AFxgldo/WLAvpzmz6R8ixRFR1U7L6VnlJhs/hgKNpmud9RenqJOvP14EekJilckMtrRmtWrfOj11T8yRjFDaCSun1CAZSgkNNZoTu5DZSI56fwC3ymvmnyJskJSFXIksMMhtn7pEOrh6MyS1xgzHOilQz1BB/keX7mqGskKZplu4SpTf/rICrKxJHr3zAG/1AocQokwf4wG0yB+/puvRSHPPIgADqzjGl34f3Yrx0jK+swuMCG2YzRue2QDU0yPDYk4Cy0pFFlSTg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:48:55.2451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43708cd7-8767-4588-bc48-08dc33162356
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319

On Wed, 21 Feb 2024 14:02:59 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.210 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.210-rc1.gz
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

Linux version:	5.10.210-rc1-gd2880f0e0d6f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

