Return-Path: <linux-kernel+bounces-35571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6A283936C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9501AB2AAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167460DD9;
	Tue, 23 Jan 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g0o6Wm7Y"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB960248;
	Tue, 23 Jan 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024248; cv=fail; b=qwWfr+zK6nVAcOv2E97W8PyYd/d/UTg510BVGfOWPI1fLHed1T87UOE5YrX4MJy20BsxHBxaxe1iYBE+RXLlNrDlNltDQsjYSupkcQfa/Hl4F+kHjJoGc1aUUVRJ+GBsF3lNI91JvbxTLhMjoU6sIhkeYfuOsfY2JDV2PttskAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024248; c=relaxed/simple;
	bh=cJ/6+mPKcSUEUIoV5yTyt+H9ocr+JALmeZ5CZxyqQQc=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=fy/xm8LjwG9Wj95PdD0OG4DrvjfI8NjvYP7MGoIxRGsO9L7hwwkDhD7oZIaZz+CP8BAK+Q2Si5Tovwo4+G+233JXEgcXmtbOJX8FGID/Y9Boii+8LHHFQtOD+5te3kMDIpDTWq0KYyCiRZo6GeV/ViKlq/q0hpGYafsxO3wHpiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g0o6Wm7Y; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiidD96WxyHoR6xYrCgDUkAMIuLGhOjg58fczyv9klnoEROH+5F2nkkVx4uJ+5RZcLl/xSCqLvTyAM01nc/qhqiQ+FLcgCAssrmTtOAlPwcq5r+Ed3c+1n3t2xwLB8C2YjjrLSt4S92MEGyVEnCu8XbChM3yYIvPsPyOI0zLemM7c2pCWnDXCt2qzqKfKxrNe2s+lg/uPaVMwuu0DWasBOXmRAckJgyw5xTn2DpEIMtX0nciTqfApJiqSoU9qeOfyf4XgVGIgMrpl8G5hoDJxznRwiUr3JvOZNY5H6VCQqx2EaXMvyUxR26tolhOTlBvRpU4do8Bxr6an8MVF2GO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGaKtuhNoMmXNsaKJZrY+4UqA3IOYU9eHYxVxsNfp1g=;
 b=h34f8G8u/A9plCIwscVkKaYqdk4NL8V0pBWEND3MZzBS2YH065Waidh8amVQGGnv2tWjPWfOzsQ/AhxoSpeZuuhn0DW5ok5xHtJYMtt+UtDhvZn4eaGSanz52mt3goGrCW0wT4U8vrK0dFYHhLaxQqRjEsW/9PP/WbrxxJzTjly8s8Ak4R9aPjJnbT1oNJUW+2hbS75BTLVwfs2O8FAuXap7J408cHMl+cLRFEIBx1prWnoWymzWLX6PbeAuYi5ue9kVIVTF3z7oCxpOIJXAdVlhL3otYJfXizpkoo1+h0Zwq5cW+H5blOHmSimCcFX7phO/egXwM2KemWbiX5FeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGaKtuhNoMmXNsaKJZrY+4UqA3IOYU9eHYxVxsNfp1g=;
 b=g0o6Wm7YIHUOZuwEwe2Ft9hM4kRnjrHrEASLndgwLr6fxsUW7FXxsxTkbo23jTJSQNpbBZbZZnXOyuuNIOA7GVfWm0Z3j3CT82IAUEgQFeUll5M9QZcKQ5KkoMM91+O+x0DblFuJi3njCK8Kl4w+luPcFWDGM3TuWbNLxBhidVl67LAIPDuKMnpKLTSEUX+d0LNpyXyyT+B5vQC6C9jPpAwGkicHBwDwNcKnF5JGv4EDB9XujEbMs20+0Hiv3z6WaEij4ixbp7Jj7DlC7eLNGOgLy4YbmPyt+1b1haD458M0eqizaj9K0PYZdfZzEdk/1qxnZLt3CZdo9tlvOwM8/w==
Received: from MW2PR2101CA0006.namprd21.prod.outlook.com (2603:10b6:302:1::19)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 15:37:24 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::e) by MW2PR2101CA0006.outlook.office365.com
 (2603:10b6:302:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.9 via Frontend
 Transport; Tue, 23 Jan 2024 15:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.0 via Frontend Transport; Tue, 23 Jan 2024 15:37:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 07:37:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 07:37:09 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 07:37:09 -0800
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
Subject: Re: [PATCH 5.4 000/194] 5.4.268-rc1 review
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <738d182b-de0e-4f7e-b682-f15f0bb51df8@rnnvmail205.nvidia.com>
Date: Tue, 23 Jan 2024 07:37:09 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f059a5-b228-4684-fb62-08dc1c293217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0l7D6AYdyGj8ptz+Rhno2fK/m1+mdCnV6d/IGeZpE1tWqjuhKbjUzr/sw5wQkHnRh6UKbnWizFbwYDQvaug7QK0hkBhKGq2naDGObDuLvjxDNydkFTAwpdS8l6ZndHExlyHVYfE9Mu8Q+8puHkwIc+5Y1gyODAlHqoUHz9xubWLTZYKkoS88JPaZEbMTOAPIAXPXH0Mak0ir7XbFn0sqDdQA1mNtwjEMM6dl3VZSjZNXKCDDsk1+F4+oqONLk704ezJvhzSjwcJF0Wn/jK4K8ZbCWwLzpT2UfeF9bS9JnFASB7wAmCPurRtRY2vKDs9fGMgeJCJNwPYS78HgW1+pQyKx3U14oN0llSD1o60MPIYBbP52BhOik3KcfofSzvWOUGFPIqaRtpH0hDR2UNjPSC5MSblS4VLOCNc138ACrOe6rN1RZKz2a7uDfS4O1kLXB7G70dgD/64hiTGY3+KYydpicKA6qvKGmjs2CnkMsKMRnILHcREZU2G/PfjT16P21NYH9n75ftQkNaySfnV8OaLhZ8dp3rZ2Pk3oGjL1xNM0KbyAxVIQix+eon1VQrMB9Vj5GILhHisvb2CfJN0dnOGQTcKG9GkKbv+ca3SwCpjcKhuoGRA0lwal8stfElzBZ6sJ0weyHTx+u1oEn/y209bACwipdrOMyPBuaauGuzapGZucBs1vT008TEcGzxiIfDvDs5jxv1NxucShjVfwVdiPsrFPeNw/flN1L9FNx+VLYWRwBnVDkKGIl8reU6udVxcRblQrWjLjlFkrFCtiA3eud8l9GiDv04bkUF2zOvs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(40470700004)(36840700001)(46966006)(8936002)(8676002)(316002)(4326008)(478600001)(426003)(26005)(966005)(6916009)(336012)(5660300002)(31686004)(7416002)(41300700001)(40480700001)(40460700003)(36860700001)(2906002)(82740400003)(356005)(70206006)(70586007)(31696002)(54906003)(47076005)(86362001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 15:37:23.8499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f059a5-b228-4684-fb62-08dc1c293217
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353

On Mon, 22 Jan 2024 15:55:30 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.268 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.268-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.268-rc1-g982136305731
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

