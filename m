Return-Path: <linux-kernel+bounces-35570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65B839367
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D391C25660
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983EE60B9D;
	Tue, 23 Jan 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqdpq/w/"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA660B82;
	Tue, 23 Jan 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024225; cv=fail; b=H7KkS6/uo429Z6ehwJS7gweSpDaqwUeCdoZiVOVpUHR/6Z5jd0nF5JWz1dKnddqotF1PF2POwt/bQ0lpfq1iPSji14tZG3Rc9F/WOpjXeecroEDMRhz/PNFVvtskr/TNUa95h3iCwqz0o0kRggO5zNQKPWROc4JBlwZ7fw2b4Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024225; c=relaxed/simple;
	bh=Nhj8XeuafIeib8vHcFLbnzHP7jJzTGqwoGZbwLctq/A=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=InCDYNqbm2MUYGGSJV1XFVs06s99NEN243XjHGCv8iBO+9buCBm2VZ2f8TNWLiq3PKfjhVeqVzZfDVP5U/DLQ6ZxfNU4YEgO/eCpV7XysF53ykfSwTMyLKKigQowRm2jfyqFwT5tFFLqvby+2j06ifDgJN5Npo8GAXIVYTBxVJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqdpq/w/; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g82aidcGA2/pJfsRcWFzbFNHt7turvdHSsCF7SDMemZ+zfwRou/llZ02BB7bU7jl281+KvHvp3BBmRAvG/KAyXKhnbCrbLVEnql4KyDO1c7BdfoN7gZjvI+DPpk9Oayz9EQ0So/tQtJM5iKV+SKPQ80ikSTP3JY184yTskk1HNt5SFFE/4R/syR30NdyuGLQxKb/yG2KCjPage25bwrnBuAnJOQX3BVnQQ994wXUOJfGKFl7rIsXFFLwWpBqJeRbaYRyPci/ySDHwnPFqMY7PX8p+Ju0KFJ3WpoOqZvMg+XxwtqocICPkLNZpfEypkZNQVoqKFV50epWtqzBdiFuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBy7jxSfH7BOkMkpC4F9K66oIGxsEfc5ctOS9GK91AQ=;
 b=OBpa6eTXhMJ6bJyT4ybMAwCqBWlbg2soss/6yD0kpD8uvFx3NXnAtVx+nxplRYewiz88bSzzcwTKdZdp+OdGWm6yubJpXKAIn61AiGPAkPno3+VNbtNMtWjqHNcNMhoyPLPYN7wUe/q1mFrI6e3l0S/pb9SjXYMr5mYKjvPeN8dulTT+sWqBm6F3PlgF/NiPZBwMj9UUe+v4FXgO50zkr3+1IItWJ1YPfPBJDIV7WEMVkDrQAhJrzcXPSQ8tPzAns99Ge88GZOQURwpWOLZzJMiTQRmL+63NtQ6EYHrE/DK2Q/+YEIKohQGvGoRHz/Vyu5d/yNPJRpUxXSswodwtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBy7jxSfH7BOkMkpC4F9K66oIGxsEfc5ctOS9GK91AQ=;
 b=uqdpq/w/DmcZZDvBF8UCJX2KvNhMzGtkJMsH1yqsvfIduLChuEQMzJ7jjqk/8oHrnvicc34V1So+iqEWXvkj8PYpV3gCx9VkS2yYP8TVimXSxhGh0fTcZI/Ya0A+aqi22pwF2b8OYwbWdbSEOxGYzVcphJs90bcqot8zlFH6Gwi698O2zRNtYfrDCexFFuvPeMpCKXA8Q+FBP8iyohAKhWIDKNvigUodFpIvhRIACWjQ8ObfynP28UW6OislTH817fVLtFkOIIWqeC8cGA2KcAUV9jrxJLkX+rlXrXoCJgvJc5xzpft4LF9eR4ggo++GMBetwPNexlEEjz5gfYgS6w==
Received: from BYAPR06CA0022.namprd06.prod.outlook.com (2603:10b6:a03:d4::35)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Tue, 23 Jan
 2024 15:37:00 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:d4:cafe::67) by BYAPR06CA0022.outlook.office365.com
 (2603:10b6:a03:d4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 15:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.0 via Frontend Transport; Tue, 23 Jan 2024 15:37:00 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 07:36:48 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 07:36:48 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 07:36:48 -0800
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
Subject: Re: [PATCH 4.19 000/148] 4.19.306-rc1 review
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <9abc081f-48d2-4763-932c-ec29f961a178@rnnvmail204.nvidia.com>
Date: Tue, 23 Jan 2024 07:36:48 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0d0f1b-1633-4814-36ec-08dc1c292444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AjEsCpRFImepu688efCIWCOYk4DGYIbRQPC8fTVhxSH/zW93NDQ5kXxtRkbDsc7dGF56/vyabbg3oLNg3gZWCaZdEm3hfw3WjWR80MfjLLCsZi/A9zevv+5Poh8+8ocEMFtLvrmajTGif0rYdjYiNgF4awT3HKs8KRA6J5vlEJ8II8E4BGfqJK0mufSM1fmfI9ryUhIZDZsGPj6qi3XCq+hDmbjoPBOgEXki/wPvMpUbazVUQmAupz1GkKUeFP6/3SbmD36hMCA+VSAzWvs04u6e4UQ8/8vNnoJ0r1EYjqCPhdp3EFirbEBgaIxzuPqpSt0e2k7p1lDPO4G9EMzJsv1YHBY66n60xcQhqME7wFZ5Tjk+FNogV3EiR4W8nDib1NKaTXt/A9ArB7kXNASCLIqZopMoUX2AzkjfFXKoK1IMNHQNKV1zCTYDnEyiENeZDwu0F9/knii+VUbWCp0ggtHL6IGknCcyCU7T7q59xn+oD55uRZjRQR6RDA7Tu2U4wYUaKQ2JlbWdtffofVWDtz5bCY8+y/2pvtwGMZT5ezED3AXRMeKO+BY3aIn1KdqWY53nEWxQESz8qHyZDzdJbAR6pFkkvx+78l6sxu1vHSgif+uu99DCzcOZVRoW5Y4cynIlM8ewv+TTxYbcXj6i3EsgqohiWXVaPidf/c9kABsrYv2FbEUzlF4Ea5TA1JaRdcl7UXAr2xiPI4DOwJnYB7a52Novzken6IrFmCN1jso/xyDzT8KQnlHGvd8ZfGx6SB0UuzLcpicoDTa0kVmFGyQDdAxux5pFf/pwyFbRTLE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(31686004)(40460700003)(40480700001)(356005)(31696002)(7636003)(8676002)(36860700001)(4326008)(8936002)(86362001)(47076005)(426003)(5660300002)(336012)(26005)(316002)(70586007)(6916009)(70206006)(54906003)(82740400003)(966005)(7416002)(478600001)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 15:37:00.6517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0d0f1b-1633-4814-36ec-08dc1c292444
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824

On Mon, 22 Jan 2024 15:55:56 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.306 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.306-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    20 boots:	20 pass, 0 fail
    37 tests:	37 pass, 0 fail

Linux version:	4.19.306-rc1-g7d9c60a8fe13
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

