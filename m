Return-Path: <linux-kernel+bounces-85121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FAF86B0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EC6B28CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056951534F6;
	Wed, 28 Feb 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rqn789X+"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDDA14F998;
	Wed, 28 Feb 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127763; cv=fail; b=TBafYkj/5eZ1lZ7DqKk7aWwpRvX1mchuqrTNd6ujVV61+uiFfiIINACpXZYwkvidXURXvnMJYYWiQMvTGUJKPqElpg+/uHLDQTFimN0tLM7BDIgnshHTH/iOkNe6CmFptlSyRgsmIMmHN4XpLUyYT6gheN+dLqtPoJs/cm9jZiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127763; c=relaxed/simple;
	bh=eSDjutmCaETej05CWW2v6HzTd54h5+kygu+lTYDU9sM=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=jKrMSk4bSoG4VB6lnT9P6uRLogF+yZGiBpPH8vg9OYIWWm6KqPCySaYyUalhlBPuwbqGe/8yLrPTIlXowH/ib5QsISTT55Grnue1NqTwlIJnMyqXFe63lZ2Xifwvls4uIatU3iGtwWpxo/+cKa5whTXYkY7HsscKjEfbAs1S8E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rqn789X+; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enMmNinVU25tv8pzwyjG4QbSkNlCUFmS+Nlpgjw5uqkZ1rClNv25Af+mW4sxU8L8adcjvJT7TzfL6N4kE4pLWYsSuCtEZjOQ/68soBtVbnwhMtyfhxMOmi8VLuR7kus/b/P80QDTiWYRIILZ0iLfs+SjGTjyb3I9FXpuuygLgCikZ/BKlAyZg8we551px6VtPZuA1MzVBviDrk1WQhHAV7vRLV4m7fsamwS/FfmWdEd3VK8gcjeLtcyb5Q++wapvVFnj+nG7YwLcq0VqqW8cXIgh50lGa/sGrKCipUHneT7PqJuQIjd1DJ4U/KJGKlflFerlu28AMcGxpdY1W12uPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxg6srTFXSTUX5SciJ7F0VEtJ+boJCh3Cd5dwITWNOw=;
 b=NseoG8Q7SoVs4lfWrPZ5WBfY9C5NM1LcVbXxfSqLKen6v+JiIraSyWQq//EaU8fAyd7/KIMJPu4z97zav+8sMo3hoFcfhUIyNHAh8SOsd2rz3hoXjN+kDmih4r4VofV5a289v4d2TLE8SQhAqj8Si+rLxTUB7XJn0Op2aZD1RMKEOkd74es2+UR52ZmYL68gLkXwNCcFFuRnnmJ09J2PPFjyBMd2sOmLjDAte6Qw8/wFWqqDnfXNlB4yg9oItRZLx3QLmaw3Qsqi/BL8kXhXITs02B2qtjYP+cdRpowxhX+jtyxk0KedFLvcJNTuKu9SPjqaYM5dOx6JchxoILfAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxg6srTFXSTUX5SciJ7F0VEtJ+boJCh3Cd5dwITWNOw=;
 b=Rqn789X+MVgfu/RItOi4WLEWt+gjsapgvadX6GD1C26t5H5i9fW4O1gyEldFYA26wr/xioyubOei0QgpigXEtQXQQMnonJNAZ9pzuRB2v2HV0y0eHJ19ZppZ32rZt65lnwXxVFTnuXCxipKjPYbhJhcawSOAX1SBtO2YOuplduxApvc+nA8YshW9zx0eZb0pIzjc1SiK07D3F3vLDs48wzAl5t5PasICL4Cqz4kyxh0ka1xldsJXMbsQSFddvLyrtgdoC8wKvCbU4ExWyfWgYnlewtv/DSE+d+TFcPK7MXEtyRppeoYeppwfFNfpu4KYJRGqdOL4hPOsZcJn5D0Zqw==
Received: from DM6PR17CA0033.namprd17.prod.outlook.com (2603:10b6:5:1b3::46)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 13:42:38 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::a5) by DM6PR17CA0033.outlook.office365.com
 (2603:10b6:5:1b3::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 13:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 13:42:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 28 Feb
 2024 05:42:17 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Feb
 2024 05:42:16 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 28 Feb 2024 05:42:16 -0800
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
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
References: <20240227131558.694096204@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <edb6e838-fd8f-4d78-9fee-dbef3e21aa61@rnnvmail202.nvidia.com>
Date: Wed, 28 Feb 2024 05:42:16 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: b5714ca8-47d0-4fe6-e460-08dc38632098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yvpmgo5NzMR2BLPqaonmZVlAHfs3APLbnbVrMFJo7FeDF8LEg2ETmlRfQ2oQaY3OnQN7vVmjNHkoy6hn0nzXZdylNmTlI56k775WWvUC+63KUyaWjwmBS5sYgKw2TYln/o02OGfc3F8tOD1MM5vxByHDKVoUsEyOQolPsXCdBfmZHyYR4DWxcRV/ensR6UHj31SCPnhyrhp6ShP6fjO0bc2W5avMz0Xz105ruqVSuZLEEvgjQCzg4slsnpHuV7NylhnP9HWK4Rho2CH7+nPaPlvQ7faZvLDigv5y12HcIJ3YaNt32Ip7yiDH4WH/Lb9FdbN6NXGcUOw7H1OakAA3v3zLuGQK+GSHX+deEfqjCMq0wf/X/HVUnwT6eCQC2L7ibH6G7n7s2VEQHBuS4yn4CkBSwUyHfcguwF/nNayvqIg7h0TjcgZwnMD9p6elXOEPD/ieCabaqgDJCPsR3/hh5dXBZ8B8kYUBnQ7cz8zkeYGCKPxmu4sPOILwwOzccoKASk6h2L+Snc7GK6nqjo4IrfSiCq8eLkVtd3nnkwRUyyoEzTzj6y/78xXLU3RGTcKLHZSL5nUAshBI5oYXmGiF8CRmR68nfzlrs+twr20x15Sf1FAVKIr3cB7i/o0bPd6hq4Kyy9W86OtZEyLCwa5nB2Q9Dcfjhc2fOUtNZ1OsmHoOHU33LDKg+BkEJ3iIO0GluVT+cAxDMmqJ4hShkIQVpPXHEMxmv1p8AJB0z1q7aowHGEpmf9I11WnMS3Ocah6ybu9/+H/fDuGuAZdpivtBO7YaTMQDt1V3eW19TWZAa0I=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:42:37.7701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5714ca8-47d0-4fe6-e460-08dc38632098
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073

On Tue, 27 Feb 2024 14:26:01 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.211 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.211-rc1.gz
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

Linux version:	5.10.211-rc1-g5d69d611e74d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

