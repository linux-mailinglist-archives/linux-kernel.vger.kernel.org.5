Return-Path: <linux-kernel+bounces-165328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05388B8B55
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392371F21300
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636012E1F0;
	Wed,  1 May 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MFBNyC7H"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80712E1FA;
	Wed,  1 May 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570712; cv=fail; b=jb+kakkf155D/JierC8+8/ehhgq4N+wmLhqLhdOrhu9ow7VICjLhrVFXcjpT3O1RD3v2Q5BC0goZQoHqYa8UHG9EMG1xQEZCuD4nKXtG8WziSwJ/gdriMzGxCy5LnSGPyr435gb5vQGZaW9UDJZAPwGLtpIQO+kPSgXoPTrsj6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570712; c=relaxed/simple;
	bh=cqdvTXO6tmbeXW7f1R+9JB+6vUzuF6DPkiXPehJCcxc=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=cDL7pCUa8Hdspz3/TZreBSdf9W6lYE1oSfdTr8hhk7uImoCh60eUEAIQpgha7CW9o5cNbA+otkgfmIQ3i2l3uSbuooXdgzr3i7XBJ+rVXsIYOamfumxdl1dNUwMJdjIXYbmrqQanTWGlU/nKA1h80kfJ3SoGayuoCNPzzMOtrbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MFBNyC7H; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic2Hof3TwuPGjIh9dOofnTkrzWCgKbRB3igjMqN7mWZ6t4FpQSrXxdIKOLMEefLzNcekP/am8SDvR5llICOGhDuGxKhVNkE+WzQdlqmnFcEx5Fs8Hczz09bnf8yGzQqFm7Tvvz6EqcK+Jq2OF1CAn476FBFrTaOH+TcjdPCBoRooej8hvZowsa4iiejc4TOtxN4XIOnzPppSaIZC5mAajD5Z5H/PKwoG4rwp4F185DVhERLVV8mZQZ0E2OvaQ5qaOb5xJGa2GX81rFThfoFanfPvwmqeJ8KOddnWzNlCX+dkgM70czaWjxKIPLDqNDlnpnggz8DKaFM8pa1c3hT0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrwemlFpvr7O4XheSy0zFCFUjcREfKJ2rbLUWafwVn4=;
 b=LKPL1gvbCnPUhKBbTGH73zdxBcQ2PVZ24JO3jehd0swkV86ubi9783xX0GSUNu+ejZNqZdvR29IQ4gTvu4Qk2UPw7j25b1OFX1ZxIZ1K9cL+tY6Kvmr41SqumLdvI1ZYonDcrBzHaly1OvL1wk21Kg2ezde/4w/ledln8UMMREc+AI4tV4GJpBXtFSJBj8EJmUzU6PdGZI6XCuMaZ70IIDZ8YBvE2wTbGFl8KEAXFKyGmRM4bstHavY7RPoJrvcue3G+cSnbPGpb8JxWlJIDP7lBLfEKsBNABC1ttURK1cDcuEeLYhImocym2z0gh0zeg2VYZczJG7FYsL7eMVLD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrwemlFpvr7O4XheSy0zFCFUjcREfKJ2rbLUWafwVn4=;
 b=MFBNyC7HZfc1zKqFUyIfop7hDEa+x5xyhUp96QJuXywZr8RG86l6lC3R/YhlPaE7FpQTvpROVfWygu9XBtCXxBSR7Qh3jw6hfTwCcqqL5mrX1LJARqe6ndljX43LFiQVzFhuc3uGn5NkJsivsORFzjKfFci1ECJbWcPpqD/LRDMzUUxIPSdPkDL4TI5r3vpQDQOPAZpWXw6zwqjREQbeCOXijTXCYA7lqj9Izj1A+wn12D6DIhyulSpcT7axUI8xApLo+7ZSSoMHqUWFbEqD0vIUP2S+Qg2MKQ7scy34HAxPmAqOtHROsrDsbdUQxXD/MvOSTIaNO/nrZifKqPvb2A==
Received: from DS0PR17CA0009.namprd17.prod.outlook.com (2603:10b6:8:191::9) by
 SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.28; Wed, 1 May 2024 13:38:26 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::b9) by DS0PR17CA0009.outlook.office365.com
 (2603:10b6:8:191::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Wed, 1 May 2024 13:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 13:38:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 06:38:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 1 May 2024 06:38:14 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 06:38:14 -0700
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
Subject: Re: [PATCH 5.15 00/80] 5.15.158-rc1 review
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
References: <20240430103043.397234724@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <cbd948d0-398e-4b3d-8dfc-a39c71930ce5@drhqmail201.nvidia.com>
Date: Wed, 1 May 2024 06:38:14 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 43dfbc5a-3db1-4cc6-d2d6-08dc69e3faaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400014|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkVXQWw4ZkZkYWxoZGI2dnRzUW9WSlZHT2gzRVZ2ZE55ZkUwK2RFMXhLQUZT?=
 =?utf-8?B?ejVXWEhiTFdranRsL052eUxsT2VEdWFlNXhGVGZ3eVJYMHVmZEEzUzBNNDUv?=
 =?utf-8?B?b2lIclk0TlI1TGk0cHNEdXJFR1paY3oyRm1FcVFzbXkyMm9IUmZ1SFRlWEhp?=
 =?utf-8?B?UjNvZmp4MkZDUEtSQ3JqcGpsd3NMS1V3UkxiTWNLZGVFbStXdCtIczA5K1JW?=
 =?utf-8?B?eEpJYmJ4bnZ0bFFobE9RSVZzZzZJZkdveEUwYjhkZFVSS2tlTlZWb25OUElG?=
 =?utf-8?B?VUowNlhMcE9OS0NnUkpTTlYwWHlFVFJKTmhpQ2pqaGplOCtkVGZlTFpNd05Z?=
 =?utf-8?B?QW1lMFo3bzJKRVVRSU1CdnhRbGY0L25UZ3NDWVd1QjlFQ1RNL3hPZkx3MUNN?=
 =?utf-8?B?dysyMmQzN2k0cHdHY1ZjNTdqbHpkNDN5ekZrbFVGdXRPRk1pSnNIL3ViaEJE?=
 =?utf-8?B?b05IK2VBS0Zka1daZ21iQ202NVA4TFZKQjZuR0lseGdEKzlWeVNraDlGcjdx?=
 =?utf-8?B?OGNObERRRTIrVEQzcGhPa2hta1prUGVhT2tnTmpPZnNUczl6Y0F5ZlRsWmV0?=
 =?utf-8?B?a0lFallBU0hqMkJuMmFHUlNYMWlQNXBsU1dQNmdwWTRqMkp2NURWd3g2Rktz?=
 =?utf-8?B?VmJDakMyWVNCdlVWSHpGTDVXZFZkZEQreVNBbmlmenMxVWxZMEYwNU1rWkYy?=
 =?utf-8?B?N0Z5S3g5dllTa2NHQjBMaXNiSFBPTTRWV3hsRmk3ZFJIYkFhOGdaek4zUEc5?=
 =?utf-8?B?K2tjUXNPL3hTb0MvTEtXWmhhK0pWeURlYjV3S245dFpqL2VQTEUrUExSdVlm?=
 =?utf-8?B?YWxBM2FVQXBlUHpEa3lTaUdLK2lCUzdHRDIzR05tOVpRZ0dIa1dZc0xhSy9L?=
 =?utf-8?B?b3JsZEkvMUlDWkFsVHFFOGt5eWtZM2dXelJndEdsb1FFT2hvR1FiRStDcUhM?=
 =?utf-8?B?OG9PYStOcm53cXN4d3BVTVVkQTlDMTZoQ1pBZWlPNDlIUDQrenQ2dFB1Skh1?=
 =?utf-8?B?Zll1ZjlkVElvQlAwTWRVclFzWStpWkFROXg0ZVNlamVWRmdXTDI1QTU2WDky?=
 =?utf-8?B?Zy8rSWM2M0twSWNyR2Vkczl1L0ZDSjd0b3ZObUoxT0RRcmlmN0FJYVlKWitk?=
 =?utf-8?B?YjB3bSt1eEkzeTBvSUMwMEFXL0x1RVlpUTdmTlZEaGgwZGZQTHdNcklWYzBX?=
 =?utf-8?B?Y0QxMUFtRTVRcFQybnJDRXlYNlhha0IreG9pcWp0QWw1K1pjSFcyUk1mRjRl?=
 =?utf-8?B?OTZjZU9MaW5uWlZ4WlljYnMyNGcwOGxJVCtjY1M5MmlDZTNrNWsrcUZ4QXdF?=
 =?utf-8?B?RHhVSk85RzFERnVrQTJBWGk3S0hjc3UvQUxiYlNWdXBlSi9XcmtjZ2VnR2Ey?=
 =?utf-8?B?REdoSU1YMENpbGNucmxFbS9Yd0Z1QXZpWVNKUXRqVU5mek45UmpmNkVxckdw?=
 =?utf-8?B?dENMWVU2Wll2VDZGSHFDcGZuTitpTzRXNExmMUtFQ1kyQlJLZFFqNGNlenZB?=
 =?utf-8?B?clVoUW5uUzBhYTNIOFdYcDVBV3BTemdsTC84UmNFVkxNYXA4QkJ2Si9DSzgz?=
 =?utf-8?B?dFFzN0I2WlRoNGprbDUwM1JHZjZiZzVkVG12bWZwd1JMaWxoaXhEM01kVkZk?=
 =?utf-8?B?ZklycjN6SHpxNkkvd2RNUDNTTTF0by9qenJsRVRYT1VJK3F0NXdJZitIdG83?=
 =?utf-8?B?ZUExc0huTGZpb2FJd2t1SVVacFNVN1B1bVVxUGRGWnNRRmZla2pTeVpPb3Zs?=
 =?utf-8?B?aC8rclNNOVNGelhXekRoUi9scW9xNzRhTVdORGhtRzFDQTUxUmZYZGRaWWkw?=
 =?utf-8?B?UXF4bWdWTzM4dUFCK0psY2lEeHpLTnJCWGJHMTl4ZTBSTFhDbmJDd2FGV055?=
 =?utf-8?Q?1gbvws3eWn2Vi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:38:26.2523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dfbc5a-3db1-4cc6-d2d6-08dc69e3faaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844

On Tue, 30 Apr 2024 12:39:32 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.158 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.158-rc1.gz
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

Linux version:	5.15.158-rc1-gd6b90d569cec
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

