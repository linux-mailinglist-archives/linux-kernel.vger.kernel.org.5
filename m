Return-Path: <linux-kernel+bounces-35578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A938183938D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CE31F2A67D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A060277;
	Tue, 23 Jan 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q49MeEOg"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA45FEF2;
	Tue, 23 Jan 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024515; cv=fail; b=BaDdEgqaoTuddrkacBfAZeBHzuetacgTXeM88nyUClCUmI8VpHe9U8047FqEGDU/8b+yxn4Me8GglByaLwqWaia/0JHO0lAfRHu7X2rMf5+OAdcuX8/f/ozl4c1Gtd3kXop6E76FOFztA3UrMbsMgRp0PVrG/tq3CNtDhwaq67k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024515; c=relaxed/simple;
	bh=pwrtSjjiH06Z2+qDtR19lusizbSGDavaYyocFLELCh8=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=V9dSbJkKS/obSRbfZyXn+G5dI24wnfbxt+8h+o7Eo99UQnEC75eQaPC9yPdupcGiO/PolEpnMoz3VSCntDHUjKJHxK9wPgrUunlhPBB+Tn4lTo+SVaxfY3s3piTF8tqSHQ4JDyDKTpS9CUGLVqDhEadUhCIm8luTGwstautXd0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q49MeEOg; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/mAH3awuzhc/7IfZOnnH/jj3jkrwxsPuPmKfvszQvEeCIESFnhH/8/yn01eK4h4OxmHGqyYAFV/01LyIXF8PUAnaNJz+iuf6FsYWvvGuHklwyuVomuqIuQHP8tIjO/ymWn9ZA/W4MJ9K0VGl+f2fLfxLhi+JDpSBjq8khTo9g5iwycynEzcThWiBWW+iiy2tO/T1RZYPTD2DIH1k6TCO0idglFivzXvg+73EPbY2gxa6Ntfw4utPOHTPpam5i6/vYISe97lTS7xH4HtVVLkqlHXeonMIVJQjGvaVZp8b1QssHVoRrG/MqChtRrIXmppAw49Nt529QgGp+vPQ6irCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU2UWRd91C804UoxP6GZbJ4MzILG2v4F67MdTWHp+eA=;
 b=X/2a6bwgVVEnnIbIerJvXFG3OvE9RHSS/F/KvRx1V5w4Rbs9cWXcOGy5h/+9U4ydmVn91y0kR4B1CNP3V0+MP3vhx+pJhIBfZOgTeX6Mi0/sNkkeEj5NrJUcr3gI7XYuhXQJE7mvPbh/W9YQwSEjvSEWym47Oxrx6OESOHFmWSD132XP9gc9fk0fwmN0d78MEo425NtzHv6fOpLceDelaD0Nb/jNXPqlGpgHpnjbIAohuV7k4mx5hEBO77PD1R1Qe/rg7jJhWjNf7kD77BeYcI3pFP8ZgZ24CjPmepGZj6va7BdZOz73CJIOsA6DGH0yD8JGXTDUegTX6ymxUqxoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU2UWRd91C804UoxP6GZbJ4MzILG2v4F67MdTWHp+eA=;
 b=Q49MeEOgcq+DHMJdH/qtRxoLJdsLefWnCC+cAe8YnStGzquRap2T6CA+cP7z2QiQhuFcagKYfBe6igb0Rbhu6WLJAzF0eHsqzyUz2u0VZ+z7F6U6FYv1aqmINbGwy9hRUmssqKR/Ul9/AkpFedUWb9dq+OORfpm6hIgYAVTXtz6vAmaCG+EqFqDtjJYO7AXuXLVbBMD6WInWjdrLu88obT3EzQmE6tjSRTX48rh/s/gsJpVitmY7MGikQvdurZCB/reXBwMNJDF5/LCrofhHfGYRGClGEp93UmKBd8jUufU2OPR/bhn/gaZ0ezmmEF4RKNNVOaTpj+TbaUAP9B2keA==
Received: from MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15) by
 DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 15:41:47 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::da) by MW2PR16CA0002.outlook.office365.com
 (2603:10b6:907::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Tue, 23 Jan 2024 15:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.0 via Frontend Transport; Tue, 23 Jan 2024 15:41:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 07:41:29 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 07:41:29 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 07:41:28 -0800
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
Subject: Re: [PATCH 6.6 000/583] 6.6.14-rc1 review
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <cf5f09c2-2de8-42ab-a688-7460fdfe3b5b@rnnvmail205.nvidia.com>
Date: Tue, 23 Jan 2024 07:41:28 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 063d57e9-0af3-41e4-1f60-08dc1c29cef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EBbWMZQc0FsFDuFjtTvaNSEkC0fx3106c5Gsm3CTTrrVRuETm0FegEdvX4bTtDfu5priABIu55ajbXsq/6aK1TYBgnVEb8jGaILCWC7KpdTxoxUPDfW84QMMB1yGa1pAN8b7n4f2I76Nmn0qP8VAEvAChR5QQ8NPi/Z//vUvuCu5UsquEquCryTjFke8fPpaZfRz8DqaHvDIUxuUvcQ2CgBM6r/S7y8QEGMOxoyY1UoHwG8Y3wXk4j3Ppk0Ksmo1zEnRTdQd7FPbGbWQYa8D4ynC9h4+gWYr93JUlDaVraAIZSLT4Py1/Fhzv90gvvNCyFtTMc5dMKGsHbtG1+rbd4PISs1qKFHD5lApWvtqt+2fq//Ewmcr9WMLAR73yFlJJ7664TLEKfNY/TvG4P2xJz6axWBwIGrrXD7+SG1IIxuXesWHnXttFT4ekYP7SCpAHxJVjysEHAEFwzqsnG1GXaITSa5DcEZLl5bPzJrn4Fr9ZgCbWW0wW27pEEOeCcNnY7xVgm50L9n+ZaV17JdLnBB9yMCt5lS20k3sC3cZEr4XEEeqQzawpUgaNUp6EYprIWRFydS6I+oKEExnQpHH/1Pzv07uCULPN2/HLuKgtZdBE0VUPy1u1xGgfLUHGRk7mNMF8/l+zoazhDDYfJid34fgizIuE1VqWSCQHNoZ8ckiMG/ZuhkyEXtzlJKm/dAR+sxEhhxqzeA5gjAFfMbFvS6F5NyAlIsJzoF8NT9GNX3xhwX9ps93TdQFp1esv88NW+VvsvDbKYGJ1FKLAiZaq6OKs4n7bHJgs8IcHwCkulw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(336012)(36860700001)(426003)(41300700001)(26005)(7636003)(356005)(4326008)(8676002)(8936002)(5660300002)(7416002)(2906002)(478600001)(966005)(70206006)(54906003)(70586007)(6916009)(316002)(86362001)(31696002)(82740400003)(31686004)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 15:41:46.9481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063d57e9-0af3-41e4-1f60-08dc1c29cef3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861

On Mon, 22 Jan 2024 15:50:51 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Failures detected for Tegra ...

Test results for stable-v6.6:
    10 builds:	10 pass, 0 fail
    28 boots:	26 pass, 2 fail
    96 tests:	96 pass, 0 fail

Linux version:	6.6.14-rc1-g8f8e522b6a7a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Boot failures:	tegra210-p2371-2180

Jon

