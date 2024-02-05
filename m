Return-Path: <linux-kernel+bounces-52702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE759849BA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5C1B254E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EAC1CD08;
	Mon,  5 Feb 2024 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlhXqHQ/"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903020DD5;
	Mon,  5 Feb 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139123; cv=fail; b=SnZwxMJ/m7+SuVuY0HBVQDcHh4Q67S3cGhuF7CAZpZq371H6f3Uey0SBarp595W/vemG6/XciyeEj2Lxg/2/uphebFIXDESyj8vngrxvIwKPQX+w41h5Q6Et4JXeY7sYtR1K/YiYaAVlep+sy1RQptmqMb6iA0QDz+ogSwHQe1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139123; c=relaxed/simple;
	bh=6ZtkMI3m8o7pS0vPVtoHM8viW9+9uy2eyzejk0k0bL0=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=uQjfAYcKIluwZr1jlN9KkeD5oDvloJEJZiDGYuKZa1Jh6hpDJdcNm4vfNSwzPAzDrubUy3fpObrS1uyOaE4PSxG3HEwiZu+RiK09eUZJthtsiKoGoAdj+7+L4kx4rHDp0KY2/IH8qDDxelzw3lPULVHQwc6Cu3wwB67/aC7efh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BlhXqHQ/; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=docvOFBNOQmRqPFKclg9z3xJSGukkz/lXHP2m78jtQDAF1h39XFnsRe9Bi4VQ0yfBkU+9YLUZgvuCRlC+lQ5rNOAur1PR018rOi18+GtloQFveTac3qsm4RU2mQhiklLdKixu7lMPtBEvYLPz7v8ezTRD5NW+1vjDTfzNQfCXD2pZ3BG6HgZhHnbA7Pe6J1/8sqALPPVciRwWXERGqsnh4VElOFKyBvM8ZTselUz3L2mH2CP0ZXA1ctn1W2+XjiChDxEvP3ZSyyIK7BrVZ7apk6j+t4eEqEzNLhMOVdV3tFb5VRtBhIcHqbuIwxVon/KAF7bB/iVbqiHdCWFhZ9Scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j37nsCLUy9S/3bXGNhOVXG3muQw8XygdjaJMhU36cV8=;
 b=kSDtKGwiicnRPEgtgQaOw2Uw7BanVdZDQe+Qfsr66Yh3Z7feefUFhPYU0F8F1QbhN2s2Sehdy2o0hMBQbJe8ba1SQXrZhcRGEbRw2skErzXh+dxBvYlcZKSYe7LHsGiDeaLHBDYiDPrLJweskDPwUgIkoGsVEkLj+1T9JLj7VdQZXdj7a3ptsmRqUpZKxayyjZl2NByHpobl0DvJgj9HEaxV2Ovkn/gcP0dAnnNaShMaK9FS+Zv+OR6a0+eGZ9ScS85l1nJmKSGDr+8+K3It1ZIn9ADcAWt+m++aqDq4FSnzuw/DM5VulWo8oYYFX9/qSdkYU5DkPnWWavYWvD1GjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j37nsCLUy9S/3bXGNhOVXG3muQw8XygdjaJMhU36cV8=;
 b=BlhXqHQ/EURnt3chUUxT5HY1Pfbs25DsgT9xJm2Nhh+dAN+y74EuTl52ZnFNT4MavMtiIxeqiEmcDVfE2u+aSBtAp4sSBdJLCGHJAQ3xVT/WrmRorwDxnBvToY1ik1WVBqWXf3JOBt4nNHGaZJrk7d7y9RMCjdG0jFT6E/0J3k9dZLV+xg9jSCfqr/7NN0MZHjz07dw7TJJzImoRhJfosMzJWPaMgQndMLhQxzTzJ9xDyB/ZUlrzRWJvS2eWwL0VsXsBRvdq5zchyUmrdlMYkErSL76JDjJr45+pelGTSpj0aR+HlZI97mpPCw7sq9KSRu2WzqsnR2K2UBS9iDFtiw==
Received: from CH2PR07CA0046.namprd07.prod.outlook.com (2603:10b6:610:5b::20)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Mon, 5 Feb
 2024 13:18:38 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::9b) by CH2PR07CA0046.outlook.office365.com
 (2603:10b6:610:5b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 13:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 13:18:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 5 Feb 2024
 05:18:29 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 5 Feb
 2024 05:18:29 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 5 Feb 2024 05:18:29 -0800
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
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
In-Reply-To: <20240203174810.768708706@linuxfoundation.org>
References: <20240203174810.768708706@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <eb078591-3830-463e-964c-fc5c7fcbb570@rnnvmail204.nvidia.com>
Date: Mon, 5 Feb 2024 05:18:29 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: d88db003-36c8-494d-7ae0-08dc264cf6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iWqlb+nAuTfmwNxL9V8beEscZhu7ZGDkKh2jG5IxTDUsMMqhsitW6PvDyy5A5Z0a3kNIOS2vxWgaqQSeNEEmgR8yNSnIVFsI0knbHdLa+1A1OKXXTIru7WsU0E9gH2yPKGD5bssEWa5Y4+xFrVfABv+ffbxl2Ss3qtbtiocivSn0FuC8nPA6WXSXrS9gHTAS3YmJdrQZNPmm84hGImeu7mT8FsZcljwbgsUCc79H0NX9m1N+JBeraCkVEt7qCWsI5T4cQbvMxYZ0LXzY67+DLAy7I2iYTs9EKlBfAILnDzrYS6SttpN/dh1IGtXn7uSkBrcoEHILkyiMPIWvZ6oHRlHHE6xCaXXqNUgCn6Mbaqw1oOkGxxo7nbvYSo3PYIcoivUxyrGCdWuctSf7OGZ9jfiNhBFVd73GiHa8dgiq1ctX/9P8Isu0AVNzOf0+NiUWXDunYCg5WLCBfo459lS6mI9zsQA0LGJfVEj3aWMVgjAJNeWvs4VEGo04UUbZRYFLRPEcT7vjcVXEP4sYg32VDQLkhqfPJrZsZN0bVHs3PYDkcu1MFlAvoH21KXiSCeXqN1OHDTeQiiDZ32X6+yoE1oB3m/CMxgA+donP44P24MFGW2m14D6+82ZHWfsNVtxKhMNVAxcPgPMqcDmza7W1og3v2WuxB3pK6cu4F3Qm6L2U2NqMVAFTF4yUK/uUJmXurZaRShm26xouN7FGlCMKRJYn1HQkCnJzcXqfP/foH0CqmHenRe6USEBio4ppMggRda7ZJQSRmiHbOIey88HXEhy+NwxyLREpEwAPe3tFYuo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(26005)(336012)(426003)(7636003)(82740400003)(36860700001)(5660300002)(316002)(6916009)(7416002)(4326008)(70586007)(478600001)(8936002)(2906002)(54906003)(966005)(8676002)(70206006)(356005)(86362001)(31696002)(47076005)(41300700001)(31686004)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:18:37.8055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88db003-36c8-494d-7ae0-08dc264cf6cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470

On Sat, 03 Feb 2024 09:52:59 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.16 release.
> There are 326 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.16-rc2.gz
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

Linux version:	6.6.16-rc2-g8e1719211b07
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

