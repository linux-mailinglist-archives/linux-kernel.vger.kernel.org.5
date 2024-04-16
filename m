Return-Path: <linux-kernel+bounces-146744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7C68A6A33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050A71F21897
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423612C481;
	Tue, 16 Apr 2024 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PLjpz6id"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2812AAD1;
	Tue, 16 Apr 2024 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269045; cv=fail; b=I5EbtoBVOUW3hpmji2nEu0zbSicbnDWZS8hoirEdDoa7IVn67tQoXfK5THQEqsv2KneOKYsZjp5uoZ1jhgixXFOpVp2SXnRJ1pkY0sw+dihBR84yDlCPBjKZ7nJLp4GgKd1u76gqIT1u2ehf8BwPuskFs81rnjlngmUd/pgEMJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269045; c=relaxed/simple;
	bh=yL8RZ9UscTuWVgj0irSVb18wLcUKmPVe+EJjeY1OdmU=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=AoZvsDOsfp/07Y2hKRtxcZ1awnFCUZf3TSN+MwSgdZPcrd8ClUJGMGBZkhWE9J/galC7HtPZHQG0FKAZ1Sb5EnKCzuAgUg+KVv91yb7zE+kiqHwS34r6b+i1YGK6cboLfazKxblCsUzfDR+P8QSyKpXaL4oxJmeCjUdAyXTuoas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PLjpz6id; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng1iUh/C8uZHdbesc3lR+9XX6sYr1niP2+WTvLhHnAIj4VIfnRER2geNNxWxlL6Giq7rWK7SlV9zHOIlcRv/1bi52W5pNXYk5pTXTWUqiinVoE69g+FRQ1R6PDsvkBJ1spx1jFCEi6fv2eFwNp9Nf0OCIUnNQpK+NNHJE9HDGsygmolFKvxJroNYcJaF8piXQE1PONGRx1nR7CS6WK57jJyagp69SQNDNqQJ/jmToWqA1lQm81+WlBAADhm6IjbdHHIVDHgALbZH6SXbJXhEJLiSF2/an6KeO7xCYuCXIF7iM9xapBjeI/RkIuYsA1v5r5Dt7YZh/a34l6vL5K9ttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcqjYueOorQFe/UI/65+gC8EfL7IjCpZVojvb7TLPKw=;
 b=O26FwMEq1r2TgaHPSG/8397JiFEyHwQSl0y76E0XXimR+zS/x05mSIW2qEAljbDMTKih5yJnS7N35Pgqf3uD2fup1A9uFWH5hG78nq6SNyn0wgXnWzKCa7oauCwEbcwdmEUf2VPpydcU2PV4pY5c38XcUqnv7D+GXY1P2RT6ELcFuZm2PngBj68XmYlv10UkEkYNozK5S6beBdg3s66QCNGbQ67SO6fQb51RbjsYBQjSTwlcnxDDs9i8W8SPICkgYDWHrCsaHHnxz5WwG7/md/z2UQUL/IX7ag5aSHdKnhp/iSO0vDZIqNp9DXOAoYRiZu8Ja6DleEStlJJRryx25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcqjYueOorQFe/UI/65+gC8EfL7IjCpZVojvb7TLPKw=;
 b=PLjpz6idMX5k24EN1BqNbXW9L41TFBrI0yaq2kLH7D4mbUhbLV9XFoKwPCVxVDv2H2gXTTgk5qveI8Ko051j20Bg6Js7iACKwhsHyKpNdnJgDchPoDA5KBqF32Z4inJBomyCWXjmVgBEJ5SIK5IpPRo4xgM+L0EL49nsmN8c7AkJ6HiYLeVymKNlB8n8FVlS1HVcmHgM2YeYNuyuXewzleIl1aFRVLnLTEsFaqb+cG3kmFCntvW2zcpfvW8HwCSbynA/x7GyYic6wpp6Lp2+JBCD0rBL620nY+/2cO7dL2ua50XIuMdlMXT/RmKQYJEbj36DuZ0Uhglot/isVQ18Lg==
Received: from CH0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:32::12)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:03:53 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::10) by CH0PR07CA0007.outlook.office365.com
 (2603:10b6:610:32::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 12:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 12:03:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 16 Apr
 2024 05:03:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 16 Apr
 2024 05:03:34 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 16 Apr 2024 05:03:33 -0700
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
Subject: Re: [PATCH 6.1 00/69] 6.1.87-rc1 review
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
References: <20240415141946.165870434@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c4e3f69d-5c16-410b-b511-dad537d5d6ee@rnnvmail204.nvidia.com>
Date: Tue, 16 Apr 2024 05:03:33 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa5bf47-8b7d-455a-b54b-08dc5e0d4906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZWMU5aMENiVmZ2L3QrMGUvbVdKdS9EQzdTbXlja1dkaWwrcW51VEsvUVpV?=
 =?utf-8?B?azV0MzBBSUxGd1BVQnFORDNWbEVzcWU3N01BVmtycXJxT2pQTXB0c1FBWmZW?=
 =?utf-8?B?ZVV6UjVMa3hZSVNzNUNVS3Z4Y3QxZlJGZjM0OXVlRGo0L0xCajd3WmhTVUJi?=
 =?utf-8?B?K3pkN1NFWUFwdnZxZFdYWnFrSmNQMmZqYnVvR3p6UDh0dFpqZFJGUkkydHJP?=
 =?utf-8?B?M25zTGNNY2tISS9Ec1RWbm9uOTJUSzd3anFSQzU5SXUzK09WL3pJV2pZNU9i?=
 =?utf-8?B?YlBmQVFpVWVWQTFKeUMwL3M3QXdiaTRwdFFaNldkMEpicmp2OVNVKy9UWTFY?=
 =?utf-8?B?YWtEODFZWW5kdGcvL1BnakZyU0VkQUVicjc2NHhadHZIaThNdWdlcjkzOWNN?=
 =?utf-8?B?Uko3Q29QOXZDSHBkMlJSWFZ3a0hkTVhtQ1RoYlZaTXc5UnlyY1JNSDZNQU41?=
 =?utf-8?B?Y09rT3NsZFA0dXJZQzZQN0RicUZUUnN0TlJaeGRPL0V2RFBXZ1gvcHorK1M1?=
 =?utf-8?B?YWRVRWsyMS82QnkrcC80a09vNm1ic093WjNtZUR0R2VWNE4xMnBPa1ZIWDdR?=
 =?utf-8?B?dFc2RlN3VTBJaXZQWjZCbE9LOHc0N3hKUlFrU3cxV1RIMlpQWU5DTjN4TDNX?=
 =?utf-8?B?NmM1ZTlOL0kzczRmdmFFY0RBRkI4WTFKV3RxbkRnVnFITU5KRUQzQnBZZld5?=
 =?utf-8?B?TmVpYy9ZTTJBMXUyUnJ3TWc2UkZ3QmZYMEo0aE1sUm5OZTM3a0tmTmJPQkRu?=
 =?utf-8?B?NjlHRHJzMUpKT1c0RmZ0VS9pcmpraWkxa25kSFdCdFZKNmlnWEVNT2MvUDRI?=
 =?utf-8?B?V1hVc3NxOEpzcm01eklNUURaVHIvSUh1cDNOa3I4enlrRU8wM1JWcVRQZVhz?=
 =?utf-8?B?QlRHQWtOREo2VmpVRUZUYk14MTBuMmxhd2NVdXdrd0pKSjVjNXJHdTdPZzNu?=
 =?utf-8?B?U2pxVGtKcE1uOWlJNWdXTndnbkxkaHJZMGFsaU1HYk45ckR3TUozVUg5UHhO?=
 =?utf-8?B?OHo4d3lmZnBFMnJRZWJ6MzlieStsNGVOR24rUkpJMmp5Wnp3Vi9ReTd1R0M3?=
 =?utf-8?B?YTRtaU5PcTROVDlYOEFhd2lpSWhkOXpaOVlWRmtyWFhGODl2Qm8xeUREOHBN?=
 =?utf-8?B?V1pENzhPamdjZ3pCbU05UTdveEIvYWYvLzZrakNDTFRKbUVQVEtRZlJKSCts?=
 =?utf-8?B?V1hsOTA3R1VGcStXVWRYS3hhK3lCZTlFQ2pnYklKQ0ZYRStBQ0Y4NkZ6bTRk?=
 =?utf-8?B?Z1NWeXR6T1RrSW5IMkdBdnBDSWt5dFBTMm14UHVNdy9XRUVoNDBQS2dvNmhL?=
 =?utf-8?B?bnlEQTNhMFhtZXNCTm90eUNMcTg2ekhoeU8xdi8ya3VtbXloY2s0ajdVcVZ1?=
 =?utf-8?B?azMvaGFuaXBkNEo4SVh2VUJhc0FSR055UkJwZ3BhOEFoQUxBNWRtU2lKeWRV?=
 =?utf-8?B?SE1ibjNCWVJTZ29Ud1JGNk5DejJpdENjVDlPdGxqNU9rRk9MYTc5ck9nTXBP?=
 =?utf-8?B?T1dSZ2xvdmtsckpVZVpXZWxxWmVuRkpHb0szSG1JbjlNa2NtaUhqNHBaZ1Qy?=
 =?utf-8?B?eXlGZytDWXVDeTN5VUlPeW9rcktQWU0zRkxtK0s3VFNHTERrOFpJUEdqYWlu?=
 =?utf-8?B?UDNTVTFZUjhzSUgySnhKTDFWRlRiTDZoZHQ4RmpQdy90VzIxcHk3NndFWkVH?=
 =?utf-8?B?bGUxczhwc1BNemRUUW5yK3NEbm8vK0lYOUJDNWJxdDJSK1R3Y3pqUERJQUw5?=
 =?utf-8?B?VThMcllhU3NMZkNqNmVlZHNYTFpWTmhublRSRWxteDlBODY3Unc4aTd6ZFk4?=
 =?utf-8?B?a2JSMnZObnBVc3ZMVWRJVVJUMlQxUEM3MW9JaFJOSnZ6VHpFcC94RE5EV01J?=
 =?utf-8?Q?mge0c7W6g2qS8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:03:53.0654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa5bf47-8b7d-455a-b54b-08dc5e0d4906
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116

On Mon, 15 Apr 2024 16:20:31 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.87 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.87-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.87-rc1-g6745a5f2c806
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

