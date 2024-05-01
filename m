Return-Path: <linux-kernel+bounces-165332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF618B8B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C751C21631
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C68112EBCE;
	Wed,  1 May 2024 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mdMvUS6b"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E78433D4;
	Wed,  1 May 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570752; cv=fail; b=C60sRCBL4El0QHkwFJyFo5ZQJOVvfSVZloVkO14GfiaMDgbuxBWAPETMnvt52TSpRc0KQDeC3UDFt6NpScqvaz43fff6hLxXAUyJYlSxF34ub5gEcUqW4iktDyVefCgbUQIMLp+BAbKbYRsN2N62feoH9EMDpsLoMDSdBQ8tI+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570752; c=relaxed/simple;
	bh=Xv9MY1CSzct8cyKZgWCxbYfw5+DVZnzs1L4qe18Ya0U=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=HQC7L66fO0Q26qdNolwqrJkgZoGJN8zZQhiuFJKIbFL6hqLUs23QB0PDYLuAqKLmcDrkIaeOKziheeDjBQmnRAJYKPi8OSS45mVFQ4KeACFz/Vaa5SqqlBkwMwETgK0VlRMQYFeZ9T72d5yij+97BiOG+vdgLOcVWBGMaNLwlPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mdMvUS6b; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvevOQCujYXUqEMkmYeNLp50Jh23kT8jT77bTQ3KkMFZHSVPP4T/XEK/XNpS5YRUcsTtQHe/7Um1j0kj2XYOcmaflw8OGpmY3jCU5FGy6C89qJn0Ft5tWaHOrCD+W2B1fDEEldn0ICOZp49ceFwdz8dbZNkS7pZo05qmFM+Igu6Gb9mMjoOn9iFZ3/NvbB/RUfcaiuFCPPjtfSYhTaguA0JMq1M7LX5MMy0v+DNOV5VQZ/OxiETBWNv5M6OcnNgHoh4KoJJPYvOhDtlMJbOei91FV53PEP+F6Qffy4+68UdUFh99O4FiBuCPT1Hk46uQ9IHCHcv+H1yUQUKhqbjnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHIxjo+iju+eFuBkxwVUboOB/BcuL2HIMOM2DFw78Uk=;
 b=n45SQv5ceoczBNHX0W8/qZECyKDyXpMq4mfvyPxw36xqfPGZ4Q7JMYoPEuz4jsz4l5QaLyJlrStnlZjdwFh8/hHuMIl09CcGzfW1Nl9bsq3SozcvgU4tBr/71z6wgHzI+S3DP8j0NxdmTMwQMFz8AJxB+dBUBhfbboWod45IcIVSxhEFlLmVgzskP4W6YufSxS0OMzX/7t5lcdJnHy4O/lAX5x3ZEtWFf+5hZj/Kk/jHzeTwIugwz6ObXOeC9irgPDnfJhHxuFHhK67YHlGO4UYnX6LymhPs63mxUUD2Nn4I7kS8TGPiXATc37m+Zrm32yoehMkimTQAEE+9l7IaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHIxjo+iju+eFuBkxwVUboOB/BcuL2HIMOM2DFw78Uk=;
 b=mdMvUS6b01dSv87wx0MbAmoJ/6SJOQJUqgR8MkZzkwUSeMZb0ALhKU8dztIRYpfIOuK2h9//PSkg9iYcCWQY62lAmYuZxNyEOzam8pnVNzQJRSQv/UnIICJuLHlmeMNgxkRPSPfZrYAsDo4cLsPNtdFECq/GhNVPZnGIuCHg7uxzCL7iFOhRo8oqyAqU3x1PB9lEit2FX6kqL32PbGlW4NyzHPdaxaU2vLPAIXiibR0nq29CCuNOFfV+OIkJ5HC9M7HW2BgIeYBCk3Eb8+zqMYEnr3W2rghkyaYA5j2YzhA8MM2y05D3eYBq+dURJv2Kr4KAsZa11gy6PPsLQAqAJw==
Received: from BL1PR13CA0277.namprd13.prod.outlook.com (2603:10b6:208:2bc::12)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 13:39:07 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::ed) by BL1PR13CA0277.outlook.office365.com
 (2603:10b6:208:2bc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 13:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 13:39:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 06:38:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 06:38:45 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 06:38:44 -0700
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
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e3190495-05c8-4bd0-abf8-cd52a01d6335@rnnvmail205.nvidia.com>
Date: Wed, 1 May 2024 06:38:44 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c2afcf-2fb5-4d73-9572-08dc69e41354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmNKeGQ5L3c5K2xwUlg0T3ZmYktRU2E2SHJDNUg0ZWRsRFVLd2ZQekxuMmhx?=
 =?utf-8?B?TXJJU0JRaU54cnZ5aGxrRWIvcmVaOGtJc0xSUkIraDh2RzB3U3FCQ3MrYlVG?=
 =?utf-8?B?Skc2MS9ZM1B1SGtUZUpRdW1jN2JERGRxUUpOWWp0cnhDVTJsQnhsQU43ODNi?=
 =?utf-8?B?MjBOL3ZIUWZqOHpBZU9nbS9rekRQRDc2NkJQbllwY2xBMjdMN1VrYjB4VVR2?=
 =?utf-8?B?Z1F0K0RBZjM3aHo2c2dndEhndmVyYTl4WGRrM3BmajlnekpFMGtFUDFHWE9s?=
 =?utf-8?B?VVREZHBTSHlnc1VqcS8xUzdBbVJEOVRwT0hVWWhwcnY1Z29nVDdCWHF2UEJp?=
 =?utf-8?B?N1JwdSsxeVhyWVBaTEZiRnF3SlcwbjdKNVZoTlprMGo3SDdDdm9XUzdPSlJN?=
 =?utf-8?B?WVBrOExEZ0srMzQzcCtYbFdaMFdZN2djeFJmNlFaWUFSOHdUQVpaSDhnZkJn?=
 =?utf-8?B?Z2lJQnl2cWg1ZDRxOFBISTU0cmFaRWtYcEdvWnF5RllHNXBCVVBQYjd2K2lX?=
 =?utf-8?B?K3BvWkNOOEVvU3FXSkg1Mk1KZG9mWWlPSEM4VkVsUVRSZFlsTFZ5TzM4U1BB?=
 =?utf-8?B?bnJyUG1wNkhzek5VcUxuSXBiS0Q5WmlqSXV0OWVMSUZxOFdzMlNvV2h3Lzcr?=
 =?utf-8?B?VzZrRW4wdzdVZ2lITUtTR242eVNsNHFKSW5wajdFalNRM0tISzFpWUpNOTZ1?=
 =?utf-8?B?OTZQbFVOWDBDZmJmdkcwcTVoNEQ3M1B2SGwxWmJPUzVZYXJocFhVa2xjL0hh?=
 =?utf-8?B?QUxNR3pidjBuSjFETVdrak9hR2hKYTdteDBSaStpR0RybEJsZWExb2lGZGYx?=
 =?utf-8?B?bUcwYUZnVTRLaWdzWXlqS0V0WDJ1WjcvbHV4aVUvMGtBQUZSYVd0SGRQOG9J?=
 =?utf-8?B?T0RzYzZtY2RkS24ycnhlUWxwMUhCdTg0dXo2M3dhbTdyTVUzZzg3cTVRT1Zy?=
 =?utf-8?B?QmFxOVFiNy9vMFZqTzhBdWFWMUt0cVRVc2s2OE1FTmtBV3pnQkhKVElzVWdX?=
 =?utf-8?B?dmg2OHh3R09veVBZWGlZODU0ODNDVWhLbXJrRm9sR2ZXVmFtbE9XLzc0NHA1?=
 =?utf-8?B?RWswQlI4enhGUWp2ZzZNV2k3YzQwUzcxU0NwN2ErNDUzeXVPbnlYZnB0WWIr?=
 =?utf-8?B?bjlLWlNVaEsyZHZMcWphZDZtMWVycVNwL0NRZFFSdVo5MkZIeVNvQVlhYUFT?=
 =?utf-8?B?OTNRRys5STBCeHdRTzNKdm1lNXNFV1B2QlEvUG1Yakxjbk0yVlU3UXRlNkhq?=
 =?utf-8?B?YmE3QzNHRTBJYUMwUDM0QldBSHpTVnAyY0ZrTGJEa1lDUVFoZFNSd0JwcFFK?=
 =?utf-8?B?Wm1VRG1LMmlpNXoraVplaXNpeDFveE1rSEtBWU9UNFFrYUpjdUlGYjFYdlRX?=
 =?utf-8?B?N1VRcjU3S2p6dXI1ZWhzNDBPM3pBZk1LRlpmQnQ0Nmhod1dybGpJM29mdzVU?=
 =?utf-8?B?Vi94VVpPL3RtZHRUM3hrRjhPdDl5QkJNWFc1Z2VzeVNXaDh2UEN5czdtMzQx?=
 =?utf-8?B?QTdYOStsdzAzVmhoUXVvVXhJa1ozRDRNdHdFMml1bXV4Mm9LVllKQnFRbjhs?=
 =?utf-8?B?RkdSUHk2VUduSHhYUWhnNGhMelJyMkhCSm0vMTVpWUFwZ0V5LzlSVVRYUktC?=
 =?utf-8?B?MUh1Y0VnbVJYblJvWWxNTXJBZjFJUlk2QUcwWXR5enlHUUxvekpFcTZoWmZr?=
 =?utf-8?B?cHpneEc0em54UTMySjR6d3RPMmw5QXcrTnhFeG9KRWU0OGJzY3d2YmREcU1k?=
 =?utf-8?B?cXBkYTAzU3pQMVRMQzh1MDdGR1pwSXBFZnk3NUtUVmdFOTFoQklMNjFDaEs3?=
 =?utf-8?B?aXV2VnJMZEl0WjkrckNBTitIUC9xQ0c4Y1RkdXcrb0ttMlRwK21NWVVsaTA2?=
 =?utf-8?Q?+OhKjDu6ITM+/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:39:07.5663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c2afcf-2fb5-4d73-9572-08dc69e41354
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344

On Tue, 30 Apr 2024 12:37:32 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.30-rc1.gz
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

Linux version:	6.6.30-rc1-gf679e6546f84
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

