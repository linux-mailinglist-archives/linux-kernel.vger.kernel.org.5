Return-Path: <linux-kernel+bounces-75427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9485E88B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA781C226D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287C12DDBF;
	Wed, 21 Feb 2024 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ujVBKRsC"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04212DDA3;
	Wed, 21 Feb 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544978; cv=fail; b=deDdZpIREttdhIueE9RUivMsL+M/vVME36w3NMm3qcQ6T+15dBDym4LYob9PJd0LqdEoGi3LxRH5DIw3nhE9kEplbk5TPVdE7dn31rj3s0EAIxqvdIH3R2p3vqj8ygEQBGO9bAOhE3yQgK5Ry/MQ70ojsRrPYGioCqd/YzhW6Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544978; c=relaxed/simple;
	bh=Su3VbTsWvXweSo6P/S5cht0h49elarkPg7ZKaOqihBs=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=ie7b0JNpou883/0RWF6tI8SV1L8EcyG+/iXRiaem1MsqWq2RuLhgLZ4IthgFk3WIt03NeHt6bIhZnHHxK5z6u1IiOVC6gKP/Im4XhsYOeccRNLVaiHr8PJoJrA/GgwFO5c7A965ESqKzJEHiyQLLGbDPT9N2Zl28N3xysc7cO3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ujVBKRsC; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRGNJHD/fYk+n2+d54QYQC/ZjPaYEWY2QbsHyQTQyLYwSY8+KnOcijvuSuyHvqqf5ON72Aba9Br0bouqqiV4dtG9oDoc3LIkhSgU5a9AXSQJVdZZQCFqWjVlyQCXcVffesqiyrFYdMIbcQ7TMMIt8v2pVGb/s9bTnK9A3xVAPTmbn+yputXmPyLA9U/WGeZh1bsXN3uyoXfFg3hvipBjteEZ6D6R8h5dd+dfpCsHyOQ7xuVDJP9B0vgkqGgAIY9vUXgAPHY024hxvYwf8xmpr2POe5Ff+S0njI0G65NIhBQyeVxI8Mk9YlyvuoIynAWGy7n1uA8oCM/H8jC3fhic+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsuV82kHM4ODMGEYDQ8syz1j7qZMhkgfNel+e2WMHdE=;
 b=eCmdvQvVe1VZQ3F4JpYTG3UZ4IOL+UarRRUN8kZD0PZl6KS4H0owjKTuSQ6WYg9X9Fmj4z1tHE9wq1sddlR64P4bAHPB7ctwMQrRqDfgtGWd0kopPVb/dqs+qVdj0z4KILHpvKNu26hVD+1IP2hlu0QREzc3ywxWdoecSLh/UsyzhezacPp/ytnjmevDmoZjmrPJekRdo19AnNZaCM69sSrvfU57EU3QA/G0LQDY4poFsHtt+Ek9Qh3mq6ALfWUH1PMnNVRc6kc6i63j8JuE9nqOMc3H/PZrVTVfrkWepzaoj7hOBCKOFU8CHkqhNd5zZSB6acP5WY/OsVS215XCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsuV82kHM4ODMGEYDQ8syz1j7qZMhkgfNel+e2WMHdE=;
 b=ujVBKRsCDAaPcI5Q6QQH2QKKCTZYMiNKyUH9xfTwr0o0jbouyCNmLugkEwGqodBW6NOOTPGl8eggrfsaj/dLp3qXkU6JMQo0BBV1A9JFk+8ryjW+dSHsyNnscbc/Ki4OBU/EuPdZnIbxkQ6nvcLnKmnGThRdPsOxr5XdB9yeSZ7UH9xMVRg3NgE5QLcL/EO22r7vpdhGXqRMsPAy3jah7r0Ez9oq+UZP8FmPS3pwHjmKTnOdEOk3VeyYIfqPcYb9iOsY0On+zPFrd8+n7whCEibXhyhp180ORrU3dmAiXNZySmYXCu8jE5I5pc34/TAOoYY3goCbWkifz5ih1D0FAg==
Received: from BL6PEPF00013DFC.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:21) by SA0PR12MB7462.namprd12.prod.outlook.com
 (2603:10b6:806:24b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 19:49:32 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2a01:111:f403:f902::) by BL6PEPF00013DFC.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 21 Feb 2024 19:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 19:49:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 21 Feb
 2024 11:49:13 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 21 Feb
 2024 11:49:13 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 21 Feb 2024 11:49:13 -0800
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
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc2 review
In-Reply-To: <20240221130223.073542172@linuxfoundation.org>
References: <20240221130223.073542172@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <81c783fa-5e5c-4a2d-acaa-d3190f774737@rnnvmail204.nvidia.com>
Date: Wed, 21 Feb 2024 11:49:13 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: ffedaf9c-4982-4d62-40ea-08dc3316394d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	esGha5lEZ6YIPkFgdON+fhnuIE7vbJTsOQ7+G18soxHpsknyTcpEb1xSCQTPVrd1/BgsLpDQnFgpypR3ZKEfHGadMG/al+O8b2unQxvb2QSFQueBWszyHbxcSU8B1ljwx0OhT60EJFgbAh0FG5muFtmfce09nUz+DKxWzJrOuJQsQUYMHz5RA+Zur8803RVKid28yYMqbpxTnJzYerqtMyuyTtrPB1xlnppNRCP1WY27IoBvqe00BJyHNEFMzpg6SCPEDOIYeqmkMn8xtTiMN6bzbYyh+t94BJ46vPjFBuCEgHJkg5w8R5rBiHAA+bU/Vzt9fQ3kJwk9D42lLKOV9KVJurSsF00IEpIiYWb7Xj8Qd5PI6fiD/9j2D9/ihEX8WKQcwvf62saub2gElhq6WB9YPiIZX1wjBt5+cZtN2/qRRVlBsGTMP7MsrTkZZJNcTzZje/XkNkoWqdxnaGCLelM25pVGxCmTGBMbN4WesNJbzGfvaGFA+Z5q1jgHYAnCaP4ERFSxJeGRK4t0jfqojIzp3f6AEjo8pC62sxlv/subAI64VnGpJDg+EeCRaSvAsDPjOpcuw+ISzK7xbXBt3IeIEJs3Snywa1hucE1n+YAjpSTHou5Ouewwxb5R/yzxh+EwOzicS2j00Z1ftCr0zyQLZ1M+GbqTCfYPW4W3FAVjFLozpkOhdaAGPU9FotL/l5VCoVKvmCqlkTpUICoL0w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:49:32.0772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffedaf9c-4982-4d62-40ea-08dc3316394d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462

On Wed, 21 Feb 2024 14:03:19 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 13:01:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc2.gz
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
    102 tests:	102 pass, 0 fail

Linux version:	6.1.79-rc2-g64fdfe5f1a1d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

