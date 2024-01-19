Return-Path: <linux-kernel+bounces-31243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B99A832B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B18B24343
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C4454659;
	Fri, 19 Jan 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0xJBXhk"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875553E22;
	Fri, 19 Jan 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673489; cv=fail; b=CKS3dUmW60G397Zxk3wRxfIJ6WrZzTEQ2MBAtNkrC6Jpwaq0J7rAMQiilGglzCDOJ+mmd+ZApsmMGxdt6X1LPqh35W+QTJ6zwtiPldiPpkeUB/ifXL2zwlQXFRoqB1JCRODNye2XpiWRL3BQ9xCxZ0HJSw+hx0HVdGOecK9zAUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673489; c=relaxed/simple;
	bh=ZHe3rRYeSzAjzALRyvg5K8aTl0pMI2qGW8K9KxEkwdg=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=Yhwuc6fwxLSXg7sgsxpscYg/N8x5KL/gQ7RsVMplAySD2Fwg/AH0z6mYulJ7uC4ckB7d6GDMHz1FCZTo1X32EQYyf2mkA+ySRt+9u6Ens8cDRMQdXgBLguOQ9fJKZ8sGDbXJ9R2mZznVRYVJv4Z0Wp1Q6UairO+dKiL8Xz5svWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H0xJBXhk; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwMGuyANyhWAuKbo/vqu6IWGgELUv8DnPikrLUQfiwc7ljfj8o3GFoRgSW3+yF6LSPMWq4PB1f3I4A28mbyLKXqpQM77ea2mIKYA4aR6CMUYRBIKjaRq9+WPIF7e2qsAjmzPRNHSKbKRdnF9AylCGHcah1J05WpvUxj4NWaJyki+mBNjVeHF6TMf7uA9GVd7ch36eKY5ETIfKxhDXJdLT3vpyDRcIGlFfptxNgc0mXs15jxO7hVIeNqyOS24VnnF7lJkheik44YAXOUsbuinEP7lKrSaglfLkVHhhEOtct1YlZNLiuiatiwEGmALLcWRUUM3SWNEKohboe45bhGF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaQeLztGu4Ze/uhpWxK6rRlZkNG2l9q0XAgvIyjzStM=;
 b=i11yeXMIRBQoSkjoGPXs7ezk3wSlaLsvryb/8zuSs/TUGU6Qhz38mMNldsZkXxIdZq01YanjJ7T3FdzJ9lu4vAtRb5VdsZh5NdxfAOfxCcg58AC9LMQ/WJYPD0knmPdBXZJgx4B5eioWdkNuPKCmQ7DoroXsce9bd/8Y5oFr6Vso+XAzVYCf4vlNuosUmHlv8cNdfYKWnS9wZcW8ZCOZd5jFIUBFc0QyuGlQtGjFJtO79+zRcdRuHhmpZBz4dvQhmMcmUZ2ZnQXTlbM+z35+hchFK36VzrCXrzNlrQKX+YRwRI8+nmkBUbvEGFZUjJD18QrXpKfu2hjGzPZPqsmQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaQeLztGu4Ze/uhpWxK6rRlZkNG2l9q0XAgvIyjzStM=;
 b=H0xJBXhkb71oR1ch/oyvGKHZSjbLn6AvFLO2CLsH8bu/22plUpJC9DGE3Ld0KNqf+FLPAikGtply5mC1xmNceDJ77upNcMkJzcvuXDVwxEs+OJxhE988G+cNKZ0Icmz/AxcuHrSsca3wfvpXq/DuIN+KsqLJ5VXyJVLQFk8qHXGRHuALwO1W0HXYroE8d1kQdY4gJKalxTjVMPxuqyneVjb1IcpWnDtcFz52nfPM+jWyVEt4PSVcDuJxoDKMjIfTAVq1/mluMywR/eii/5CO9UAO6/ZsN4yLcDR2lZtpA/OVqmEoCPLocgTM0DobAbzYdhYUMLqx9YZ+V8n7ooc+OQ==
Received: from PH0PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:e::11)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 14:11:24 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::ed) by PH0PR07CA0036.outlook.office365.com
 (2603:10b6:510:e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 14:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 14:11:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 19 Jan
 2024 06:11:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 19 Jan 2024 06:11:08 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 19 Jan 2024 06:11:08 -0800
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
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
References: <20240118104310.892180084@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <9256cdae-bcfe-4b0c-aa45-36bc2683b689@drhqmail202.nvidia.com>
Date: Fri, 19 Jan 2024 06:11:08 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 3488f101-664b-4355-2c18-08dc18f8854d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XC7IXWLoA9YlDFYb5K6yX2/EevJFtmk40RYvrAVkT3cRgMa4aC3RpZG+GU6oR1C+xjKtr9BJXMBat6KfQaNQBphvNPnQMn+2PlKO7Uq84zCxD9E9ds1WAKLLWyyUw6wrh7cEM3iF+VSEvktDUQxEd8e3b4Re6h3E3IezIG+QAZFADdjVjbGH06angh/yPBV0sBmXP30EWcF+k3BCmjXSLqNsZ1TquH10mCZRAiixJWPr2V9Vxn0OTjs6AEyxwM4bzsJPBC4GmOq5XpzUWx40MwDBZT/2S3BzoOUuZtolGrouSP2JWjJmBD2sjMOX6Bk1bULfxZpkRgEjZNOwPGRSeWNuToTQfnwt6l/OJMLcnk9SyoDKsMgrAJNj8JUtJGeJgXH3HmjCvVHD0/siD2pVSFZwp267uBBpvzQXXUB4aRD3thaSahBqQpYoqNZvZvoe1YEHc2mAVeAN1qOJb0QKzupsiSp4S2jcsgGaiAPo9l1WfQ6RvBIaFRoCGutVXi262UtkBesEwijkEBCH7VxDkn0Fr64xpfgq2bUMlIV99+62codczlBN5xRpyqgbKd8GM7/hnqwleMWX00xThJ2BPTicibolkJo3xF30pgZHs17ZsqCxTi9tvV4uz536LuALGR8T0Ztq5httOVTFtAwb+Qd2rDnK3bfY2t6xNbrlo7TydC9u2ovtFOIkWUMvRXMy3YVUaVnr743/MYpad6ry2fym0cl1nHLbk2QwiUsBNOtvwE2z+eVQ70Gncc6qQ69O4+TFsm8126QpIYWh3KR4uz0jDpwcYl1TKrZVNB5JNR4=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(31686004)(70206006)(2906002)(426003)(5660300002)(336012)(26005)(7416002)(8676002)(70586007)(316002)(54906003)(8936002)(6916009)(36860700001)(356005)(4326008)(7636003)(966005)(478600001)(82740400003)(47076005)(31696002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 14:11:24.5901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3488f101-664b-4355-2c18-08dc18f8854d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

On Thu, 18 Jan 2024 11:48:08 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.74 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
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

Linux version:	6.1.74-rc1-g1ffea4b3e361
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

