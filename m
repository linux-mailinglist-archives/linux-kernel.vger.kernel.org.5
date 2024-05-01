Return-Path: <linux-kernel+bounces-165327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF408B8B51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18D31C2179A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A001E12EBCA;
	Wed,  1 May 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qb8y8d6Y"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12AC14F;
	Wed,  1 May 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570698; cv=fail; b=COkB65jzVMtN+VPSgQgsoNdBh4JyTLwDz+XXMNzFuq78g32tsb5RrKks0cwGwNAgQzNcbWw8W1i4WP1UBsr4HB8vHnMl/ppDV7OCPeOt5JT7f6KURk1Ruo6x4M/NGe/wKjDlJL0M3aqEPARY5sWh+0wOQIW6s8XDaNup98YKuEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570698; c=relaxed/simple;
	bh=mJ4H50uJqqL6Qe1KUhBBz2Nmg3+ErLAtHNrdxOYrgSE=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=AyQTySCc6gEkEB1szpu69CtacApyGLVssUzLeY/b75S3F7Me9AB8EISd+NnanjqunECLqN8X/AylcnaZyfzKd+j+6XytUWHamZGCP1tA304hgZxXx8Ee2BhtVV43rtyq8k0hDcpsQTXbfoS+6H1MDvfoE3WjkB54yUUruG9fDvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qb8y8d6Y; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFvpym6iVdcxiXU41XkNEcwuLrDHDQO0y6fqva1r4wjLvTIuw2VQ2J6GWVDJgF3m5g5dqw3pb7L8SPIG1c2egllkYiiJqeA2KuoU1HFGCu0fCfq7jv6FGnNyJ5rbYKKpnOScD3MF1qrARanr0n63PleTliREFmCOJSz6/YHZWtORXd4zv3651QQE5cc04MOGhZYS7cE3Xv0qn57oWtsXAoVV+rXqx7EqiyQGKCfAmwro06RG9O6IYg3C+ekgkvRUPTiC7P2eUqpIHi0AkLyt+7ajHUpTaUllTEgSCuF8nrJWLP2AnHpV+h+ZC/9dvC85raNbJt1TkUGqMUPIkl72vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV+slXA7Xb+fJgiG9jIy9dchHQKNOkUp6qtj3UJSNsw=;
 b=fjMdsW6vn/3RRJ3UkLdv0NcfPQUle9HUehkmDsDgkrAOw3XVAYt4xMzKAnb9deUgdPdNtfEVJ0gf6aODdWQYHc+VcY0LzQjXwz10fR++a9F5FiI/weD50DpdnOXw6NiwZwI4NxCFdK9UIdehZKkvX6oLA4Be9glq+N9UjDD4nTxrQUA1Mp44dAxTpfYWu/C9BmQgNLZYhW6AZPiscVDzJ3Wzsa8nv/LsHEwKNSF38pGZlC0kkJ9scgIZk1hYKA8Du6Y4pyzGLmcwyAjDJfW7ak5tzQKWBzGw3gU/3REiwLeDnKdxb9lAcxYKHwVqjp2P1DptBs+42s0CH/VrDT+TFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV+slXA7Xb+fJgiG9jIy9dchHQKNOkUp6qtj3UJSNsw=;
 b=qb8y8d6YngqtPIDaBs5c4urxlesPrf7+N2DlUUSkYOEkG1Q4PcbgXr8dMSYGZaeuSqsuFMSR3oMtGxxi03RCq1lLAGm8xheqtbaaH5u/WCgxDqwWVrFh09jJxkVRaVtW2sIsyZnfXaEhxX2N+cywM/cYhilA/GdzECS1VMlYeTB1Ono847adcUkQtyR/Ryh9y+KvHzPVM5Lqyvmwmo/7mo/Bk8sRsteTwcr8hl6fnO/sm87L9++mqPwo5aUMEisnvDOoyFiIcMeP+LXJj3t/D1ehRJzo9n6QbJ/TXEsRfEmgi64tlORd5GF6RSIutqUqYOOKQK0wW2KhQJ96yPpSRQ==
Received: from CH2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:610:5b::25)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 13:38:13 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::f8) by CH2PR07CA0051.outlook.office365.com
 (2603:10b6:610:5b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Wed, 1 May 2024 13:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 13:38:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 06:38:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 1 May 2024 06:38:00 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 06:38:00 -0700
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
Subject: Re: [PATCH 5.10 000/137] 5.10.216-rc2 review
In-Reply-To: <20240430134024.771744897@linuxfoundation.org>
References: <20240430134024.771744897@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <17c3262e-12b9-40a0-85a7-9f31177ff9c8@drhqmail202.nvidia.com>
Date: Wed, 1 May 2024 06:38:00 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: bccf422f-6d34-4556-6863-08dc69e3f2b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2dSYXZHT0w3Qlg1bGZYQmR4aWw3OVlmd0lQdHVaYVBCZFBwczNxUTFrMDN6?=
 =?utf-8?B?d3VFa0pPYnEzNmFVWGtpQzZxTHF2RTZyaVU4a3RwRkFmRGFqUXlBOEd0RVdX?=
 =?utf-8?B?V05oYVFwUG1uZ203bGZoejMyek1uS2VKUEFVOHlFL2toYW8rczJLQWlsa0lB?=
 =?utf-8?B?VTdXVUpGcEIyYmVJUU5KUHljeUVVK21xbktiMm16K3pHQXFvRjZrWmZTa0Jj?=
 =?utf-8?B?cHlrUHNoK21nUEcvN1lQNklQelhGWGFHMWs3cVlSa2FRYnNjUFVTZWZNQnpQ?=
 =?utf-8?B?cTJoaHRDZUM1VDVZbVY3RXVNZ3AxcmdNTHNkbklKSU1LaGhRZDNvL1pxam9J?=
 =?utf-8?B?QVpCVGVldEQzdlcrSG9td0dmay9lT3B4SGpRanBqVXlPeVliSlFHTXVTUXhu?=
 =?utf-8?B?RnNGOUZGemlvcGxkRDYrNDNTNVRrMTJaMENjcEJzbVZ2c1gzeXZFZGtUTFY0?=
 =?utf-8?B?OXQzdlVLTUFmQ0FiOHhJUlRhL1JZNmlqRlFkbVZ1QlNReXJDdHlzZXloNDBF?=
 =?utf-8?B?MHIvWUVLa0EvOEg5cmhTbjhtMHJYYmFvcnY0STMzTDRlVkd4TGg5T2Q3MFFI?=
 =?utf-8?B?SXVzWFdMcm5rOXJSRG51ak1UUjVQa1pDRUNhZWRNVFVucDhacmhmMnlxTjRK?=
 =?utf-8?B?RTZ0V1JvQ25YMUo1THd2ckl0eVQwcjVHQkNOalFBbmRHTHdMdWhGZmROaWFH?=
 =?utf-8?B?WUxleUVmYk5VR2E2UWg2T0wvT1JIckhpNmR0Z0Q5N0wxaURzMGRpb3U2MnJk?=
 =?utf-8?B?MDhQb3htNUtKYTNwZEthMzZKUFBvbmNQSi90K3hrWlQ4VTMrQklsYzJXTWRr?=
 =?utf-8?B?Vm9JSmtYQ2tKM0dwdnl1TmI4cXd3UU5GRnRHUWZrYk5OdnQ0ZzFKbnlQNjVZ?=
 =?utf-8?B?b2ZKeFh4SHRBNHNoaSt5YnNGZE1kTEphQUQzaVp5QWNhbHFpT3JiN2U2a3JE?=
 =?utf-8?B?TXp6Wk5hWHRqZFNKK0lJU0ZycUJ2VEprV0h2YTR6blBGbGFRYk9uaVhmZDYr?=
 =?utf-8?B?Qm1iSHBKSW40Z0twMU9BZVhQK1UxczU1NFVNZ3B6T24yendrNnM2b0JXL2Nz?=
 =?utf-8?B?TU8rc081QzVFOVZYRnpaVVVHMUZkaWdIRlIvblIzbTdSSVdLUEtKME5GaUVP?=
 =?utf-8?B?SHhCNmhrcExta0J4QXMzM0RuWGYwSXhoZEFxT2gzM3dxSGUzTndnM0R5NlFC?=
 =?utf-8?B?NDZ1OVYvYzFxS0Y5aXpMS2U1TFN1VzNMM25wZnNHYy9vSTc0cEdkbXdHVjZ3?=
 =?utf-8?B?Q08zL1ZKbmlzZHZZcStIak9Oc21lbHRGTTRvOE1vM2trNDM1QWYzbWRwZW9H?=
 =?utf-8?B?MXJGR2xxcGZ5WFIxSzJKb1QxWHljK0RvNVdOc0o1eXRzRUVXcHQxeC9pY0F4?=
 =?utf-8?B?L09BM3lsTDg5cE5JZUFNSzlTcGR5YXJkb1N3Ni9yVllVSnNQN201OVNCUkNx?=
 =?utf-8?B?Q2FpZDlDNTkzNGpNUGNSbUZwaUduV2Q2VDM0RldkN3ZaM0VZQjhpcE44SFlo?=
 =?utf-8?B?OE5OTDBkemhsd084M25mMGp6WkdrVzFWemJDVDMvSklKbHg1U1hmV2VCdW0y?=
 =?utf-8?B?OWxsa08xbmdRTXVpOXVHbjRCTTQ3c2R0RXdmeEovQVc3WkhGbWQxQzAzQjFE?=
 =?utf-8?B?ZW9sbmIyN2w2UkdiZUVEWDcwb1JzRW9mZFhoQUdBQ0RTYmxiWkpGdmwyTHFz?=
 =?utf-8?B?eXBCSTJQOEJ2bFlmNVE0TXNmd0FhV1Byb1NvZHNIL2p3UUlidTNKdWtwYUFP?=
 =?utf-8?B?Vi9MYURJZDdqRWpJMUVmaUx4Y0FMTDdGbDcybDYrWVI5cEVqOUJCZjc1TGg5?=
 =?utf-8?B?dnFoVklwQi9YdzRGYTFic1BUMTNDTnl1ZzhXRW9CWkdQM2hCNVNKWEZrTUVs?=
 =?utf-8?Q?udrI+NbPzjHUL?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:38:12.8516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bccf422f-6d34-4556-6863-08dc69e3f2b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109

On Tue, 30 Apr 2024 15:43:17 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.216 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 13:40:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.216-rc2.gz
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

Linux version:	5.10.216-rc2-g4d39cb0f1c9c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

