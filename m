Return-Path: <linux-kernel+bounces-46110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A3C843A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C123284006
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AE96995B;
	Wed, 31 Jan 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LTnsVnkH"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C769956;
	Wed, 31 Jan 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692200; cv=fail; b=be1GI6PeGXDmZ5iEtrr2reGf2bD5osK457kbMmZmzfOcAW5XQhqw4C3GY8KpdI+5LBIktbmvYfTOJLtV7XWgcJMbZf/tXn7FEXy1HyyHWnGzlbit5xduvKhvItw6n1G2uSE7ZxxCOzxSmw4+9Y5iaqNLfHHFbc8GRv0g2N9gBrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692200; c=relaxed/simple;
	bh=C8FMhKmTZpkrqzX0CDk9XULPqMDW3grBNjFG86VBBYg=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=hgKNxnFPUZlcySm3pWsLPRj9vASS7Ez5j4hybZsm09A8iyoP2ThOxcKpfMzMQI+eA6lfxtC0dlep/26OsWXJSzERNsx3aN8whfufXKXB0xJXuy616EnFbvm7DGQqNtp/VQI5kWG1588fUUcD0g2VFCkDfA/P2SRDCFMy+fL1gfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LTnsVnkH; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABNRELBtnU6fNbfk2cZK403qB0IEo9UTuKg3D3zYz3Jsvk9uWa6ggj4R/BXHipu0VwsECm+vWVViNejtOTVSgAxlQIzvV9bmVI4tFg6W2u3pUqYwNb+0cs+cig/HXMkJ+9nVZucn9s6sybmMaK/8Ts4twll0M7Sdxr9E34K/iTjAuJA7DcTMTvN/lD/0siAYe4oiAInvMe5JdPZUhvmYNIj0gZODISXCK/9fNYhBJMZgPoCnGsi3i4PREpNP3P6IFX2tqS1ITc1uYAKjt2NZSpF9OiOuBzLYTYQSFyecHZDL/1BT28TpJifMKgS+khJDvOLqzOMgM2rOqog8gsrlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMsD9HdexhnzY16tUo+u9w2N6M/OmEgWMA8g7vKnSeI=;
 b=keQVA/hh/dYcgbnAKeYmzHzSaZynDTCFDqQ7NjaKTu8J5jvai6i8t5K8E7FAuP8g0dSlw0kISN4rjYrMuBqXMdcbY132piDrCcT/QVezS8HBM5PAHfOuobqWTygmy4yHZtqRW1yyiENep7HpgCN61YyCgnbd8M+5U/T/eBddsNJO5jtPI2Cg0KQngxb3eg7Z/ZtpNZ8s8mShqR/Kj/EdvyAkKSSk1pudqJuG4/3ulVURgBKVHzRIq41MrNnkGksKdJQTG0ohS5tlQV1PL1PaiZXqq/pWR6hBb/da9AUxdao9uysZxssKBXlA22mwx2AOmB2PKSv10dK/BItpd3dXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMsD9HdexhnzY16tUo+u9w2N6M/OmEgWMA8g7vKnSeI=;
 b=LTnsVnkHmb0ywPO5VWi6kIhJqbmzOXIhdv8NNH/UrRQ2yY2Xo+4yQGtftXrSTgRF0KDMIBq/3ZSsLrPTFHx3L5FpilYFlOoF4Spifx4Ec3gG9VuSjtNatzTXbJlzzhwstKIYVqeD3RXYJNbxQB+5MPrembJGb+cmlvfw6gtScZNYI/PN7oiQsLBjurIY9EzoSBSRq7G8Hq2DQ0snFEZbyZISXCGPRa7dCh6sBTDjcWARarLY4/I14xu2G/9GuwLl5OyrzlmWhzqQW5mbkHp50enMdzQ9SCTrwJL/sTtg2CQ+el7X1iAOAmQn01WDNmnMV2tHJZkKVP81ubzsEilKLQ==
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 09:09:55 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::da) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 09:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 09:09:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 31 Jan
 2024 01:09:40 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 31 Jan
 2024 01:09:40 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 31 Jan 2024 01:09:39 -0800
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
Subject: Re: [PATCH 6.1 000/186] 6.1.76-rc2 review
In-Reply-To: <20240130183318.454044155@linuxfoundation.org>
References: <20240130183318.454044155@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3d2829cd-4773-43f5-a231-c9dab2542fd3@rnnvmail202.nvidia.com>
Date: Wed, 31 Jan 2024 01:09:39 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: cec77802-b39d-4d1b-316f-08dc223c63ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zp77Mf3fIP3N0P8NhbVebnnlDZxbzdVUuxFKF2Nvsoe104Z5ORDppqzUytHV9PsN7VQdRJaJ/WK75AiBj8xxoDe+CvOfZeSd+DkodAGpoIbo9ZdA+3QrYVqlicdD+an9iYff9UeiZqH7k2IDCuDRJi5PMnoiCQ0cRAGnxdFmeGs8vP/x8p7pkIwswaFcVdQvUi5BTxDSy7yijonMOBs2CQpRSsGF7FqfSrhX0DxRx6Tt4u6M6MuMIDMnFJEcwp+4MYqDRmRH9nmUoKYzRWZ2O8vYpXLXVPeurZrnyfmZ6+beFofMtcNUv1JaLDlI+XY5PrjFB4hhtaB6UPuSBTGIHKt98tp0z7iY+Gf6faNGQXMb8cokysiv0xxeRWyq21lpVhipsmLwxKRLKWTKrJgtjmH2fE0bah3819zbQh0CarLr7mjULFa7DQroSfYl+TzC+NQ0gKRD1M3/bVllTGvoh21Ze+3FXAaN/lnMnVoBPv6wUYss4VF90PuG6rewucUI6GAlmA3LcyKW0a+5wmCTAzlhN/67MvGoyQu6hkQWJmDla4JA2REkOiMFhWat3F4gTuKw1eGpbDVeqE+91/oers1Ikk0WwOxM0Z9MDbSabRqyk2SZxjfECVBFqgY2mFt2oYyDQHTHyPOlQ0Ea7JGyHA4I3AvAgJXT/lYosoVLq2JpKugiczQH4jW+D8EjlP+j3qT/ApWtLGuWf/fMlA8IxpLEHi5/R4ER60QuH95QM0HWgWcw5RTPRRnrex6ivfcSILGxN8RIwqDruZVaHUgJxtKD5nfBxhq3opAtwt4kzOs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(336012)(426003)(26005)(31686004)(40480700001)(40460700003)(966005)(47076005)(36860700001)(478600001)(82740400003)(7636003)(356005)(316002)(86362001)(7416002)(2906002)(31696002)(5660300002)(70586007)(54906003)(6916009)(70206006)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:09:54.4376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec77802-b39d-4d1b-316f-08dc223c63ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731

On Tue, 30 Jan 2024 10:47:38 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.76 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Feb 2024 18:32:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc2.gz
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

Linux version:	6.1.76-rc2-gce3f6cd9e4cd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

