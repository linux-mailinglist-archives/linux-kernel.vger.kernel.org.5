Return-Path: <linux-kernel+bounces-136330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1720C89D2BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399951C2186A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE97C080;
	Tue,  9 Apr 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N4V68FhL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919F75809;
	Tue,  9 Apr 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645719; cv=fail; b=dh47xXdvIcLaym5HniGJakqIV/Qi5KUk0hxuB1BFadAMpvYUpawzYeu+8yPJtmNKzB3NCV3mqYLZA2bo+D4Y1LOo5gJoF08YxjVyPJ12fT/u2mfOs2RT1Fr1IJdx2IKNtjNmw1E92Oce40R0MqDbjvnJGfFj3wLxLHJkLYvXP7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645719; c=relaxed/simple;
	bh=QQXWxpjMbZuTY8bIR7rZpxr90dRk/ty71ldasPFknto=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=hX60gMWojRPM2qPrO7Vr9y04tAL/n6dZDFbOhe2Hh9C/VBIh2JIDdr9MuNPv0wsVjHSXCYQXJiY5TGE2ZkS6UsFkbuxc/utT1HHe55vTW/mzTfncYTiliyef9U5fNQq+HBGpxtSPW3ONW01+VuoNo6+vORPI1Y+fd04JlOQv+ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N4V68FhL; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0TZ5ojP4D5TQVqYMUojURfGNLoQFUFn/nPV0vF/JWVFPQpi9reAfG/6fk1CVTuxulqxKdQjN+VBziK/CRWJjAd5I5LSGVhjHrccbjyUUGq3ksbIYTWj/lpykFUPR1z0D76X3jWbqV+cHOSZiusHZBeWLJCcqvUf4BYtSphHk/NPlS7wrdcXWHouHOiHQHpKtwtobKUGbovWAtGF4ITlOvT8a+jGTkmNbT+zF7eRKj3ZcLau3GhrSilmhCiOFXGRtNnlTPVLmKL0qFK+F+SOj0TS1wpm7rvFzHLoM/2reaIiSRQO+Kj6eClgd6ENEjoQXSespjxxk6VBKe7sO76Bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AKfjPEEj0LCoIY0p103CKKCfUQiL3YhdYR6O1+J65Q=;
 b=mTMho3mj4i/9DTv4TP0RGlV3yekhZ6N+R2Of0K2sad7GPQhMmE1gu/+Of4wBbv3jR7CmxqCqqecatcbrrUQJi4XaT2MOOHjym+jcdbmE/nMVQ79fuPSJbrREyRh/+kiWDdjnRMumY6sDFI5FfNPM3UxKOefqKfSomM1aj7brwaNAHlmLH2ZCLdmtAGfbdqdfEdEgvWokr4UpXqTNnpuTHEu6YOPcQAnlApdzoT+m05s9+eRIQvOL7wPTYT+vffxsMNPlLzR+8wmXH2LUg1nJ6SitwXkWueVfpjGyenmwFZsuyMvpmM/1fNtAweiFwgbXhF1ailf4ScyatFai955XQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AKfjPEEj0LCoIY0p103CKKCfUQiL3YhdYR6O1+J65Q=;
 b=N4V68FhLYlAIx1PObxg8XPCEbU0YN5Ot989ykKfOl0sEjjMGhl3qz112X2seY3v+XFPwktw+ZOTIALYDDGNMntj8uoTLHq0WOFGuXDSFFAKF+3mKPtTrHhIc7mHWAxzgvyaH/KDXj3Y+msbklYFW45HEmUkG/45WS6y0vNXu1aISKgl7OEMw/p+xnNRteNq6m0BOaLvQcnV+pKCLzHPz0GPTOHJP68UZO8BgN+oc9h0anJkuIozVKzMoUvvYN7VAflqG2NlQWWVEl4QKOkETlS3/wq3Ewlqaa8xbVRrCuc91j4dhl+IkCbAUOQ4UC0UwJ+b7iLDIY5UpfJLECJ3FPA==
Received: from DM5PR07CA0051.namprd07.prod.outlook.com (2603:10b6:4:ad::16) by
 DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 9 Apr 2024 06:55:12 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::30) by DM5PR07CA0051.outlook.office365.com
 (2603:10b6:4:ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 06:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 06:55:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 23:54:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 8 Apr
 2024 23:54:59 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Mon, 8 Apr 2024 23:54:58 -0700
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
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <41acd8c6-0c28-475c-b5fd-0f7b92fd7c20@rnnvmail205.nvidia.com>
Date: Mon, 8 Apr 2024 23:54:58 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d95036e-047e-4113-79df-08dc5862012e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ef7t8Gs6ozcnIBfrYpOzmoAzmBAEgi9dZ48fKTaziXWnWez3k06DkSjJ1MK2yrFG5kUN+RUk1jQrfR7rJFo7ZbjBayWW1ekceexf3+93YQvMF+jrv9c+WE8QCfl9YWFX2vwY8FOEua6H0d0c/32XpZS01qPyWkgDj00iRtYVAu/XgUYfaU0A5SSjYCVQ6U6paz05abgu59e3mW4I9BPYy3+jcwht9pl0+uLjZ8HceLVmswmBaGC+/KE4Njb+Rvc4rXeZ2+xEM9ctBW0hYnERyfauaBDE22IaMvrgW6MzaWfyj1AljK8aYf+T+TU8TbLI18ZfcrCVvOmzbWRJEtajyS+t5vuX5/DMybo4la6wbEXPUAccX8FhPyvEpTkMgLvysAJiTKY/Dl2jSw2cyPtNCwqTkN+LgmkU27GahyI1dW6vYPxFp5h1Gobues9r62Hem2grUuMf9kFgyu5bPSWJoW99BoLT9NH+KhPZS8DzL5Y4OQ1yTdxz+xtzzwzq6lRuQ5OkPCtuUP5E22psjHjTTALXkXLQliJzvkBsTTJUUWBiRbjV0VbnEKB3MubyEdHpNzKxrVrH5JIn5V0ALodFUuG5kHTZ/8oDGBkgTpQtQOeXDoqD0nH8uZFRJp0BX76O0KQ8G4VDK9m0K29E2X8XtC40m15qEiYAF9cCGk/Lo1fGYeKRIFQr0f9SCn+ZRBSqFifrNSqTc8rM7ujcTIXCVuEhMtIkSDxmgvOLR8H1BktaJ2DjSe/aTCsTZWvB/wEg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 06:55:12.8067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d95036e-047e-4113-79df-08dc5862012e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254

On Mon, 08 Apr 2024 14:54:59 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
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

Linux version:	6.6.26-rc1-gec59b99017e9
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

