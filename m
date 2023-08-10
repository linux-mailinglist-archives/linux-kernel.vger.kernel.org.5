Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FAD7770C8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjHJGyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjHJGyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:54:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD222694;
        Wed,  9 Aug 2023 23:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbRXsN/k3wjW0OizbBudVQB70wUtjY7qB2YuUSWYAVC9OOSVydAatNxIJWvX3fV/E8XcgukSQEIL8m5Ba5AoI9JatritCurYrH67+QOIgNX89yVb7QYfJzJ7pa1QOk2iyfKc8DsmAJWlWx9t80Yx+Yw4VQDFV/1EtLbKmelk16KWVYN4wGBxJBHNihjHVP0HfOoeOJb825ZHMjubCeyfrWTqpMmrJSnRevY47XkwSEAeR2Qby+dFJG//KUFW1Nh8b3Wgl+81/XvuYWqducjWdpkEmxKaymFY68+3udtDasssEVU3Ea5Ho5MU6pd6ti3FD/MxSMjocL7P85vrrOFm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l68YDekRZA/+OC3o8TGLUdCfr7AVAUPu6hPCFHZrsD0=;
 b=ZjZKVokrjrrz0xF6Duwo+lJ+rF3zBJkwdSJ0GV6KxOv8vHcRTg2MDg3sUQYODgtV8bnpS7/Opv51y0evnhxvHH0PvgY0vYHH6Lq0R+88HRFQBddLxMYiqbDGkc0DagmtucWaYYd7hZVKLdVx55rgcm2FjbVj4FblHHleovVZh5phKYHbSX33lZxQV9lZMPukAUcBjTyn6azTBsYI/v7RlVVi7zWVl2hsCGbJXfsxmk/oXF3tx1nz0dUOlkzyoe4EClyGEkiq3scaQ/vxgFkj/l5LeK35lZEEgOGU3h+5tgFp/t9sRouwp3Tv+vOtGtx6PBUdKRPE2uYTL7XTwr9bUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l68YDekRZA/+OC3o8TGLUdCfr7AVAUPu6hPCFHZrsD0=;
 b=DMsLlOdzhVNz6UFc3Wljao4niPE9V1rTG7IZgKoMtBBUeLCUjs1kvA4uNwLpafYTyMW8lQxi8pakQe8Cl8/irgkIB+Z1Pg6Y8zw46i2COceEvC42cYWsyWRBghTP6csTmGxRMw14EDkz15+RLZgZTMbwfQAkC1D00sJJCy60UJ421N42y6S3jT6TQOdl36L+yv4xYfeI0BDZlJkgAdZegQq1xX5kDaJCQZPD9DAcPNgG9Hxf3Cc1EcG2RQZh6/lFyS0Ms1ZW/HCTchBXP5oBKjAlMl8oy2d97mFXHfA5cLGnHjI4GDhrs+OkRH4hufThyKSATb4emYSPG6z8OONRyg==
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 06:54:02 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::af) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Thu, 10 Aug 2023 06:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 06:54:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 23:53:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 9 Aug 2023
 23:53:48 -0700
Received: from orome.fritz.box (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 9 Aug 2023 23:53:44 -0700
From:   Thierry Reding <treding@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.19 000/323] 4.19.291-rc1 review
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <3fdf50e1-5cc9-4aaa-9c4f-292da59025b0@rnnvmail201.nvidia.com>
Date:   Wed, 9 Aug 2023 23:53:44 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 471a5961-a215-4284-8a47-08db996e9479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQcnZDaENFpIvS5eTYvdgkn0DeMo83V9JBkXurnj3hbl2LXgbh2LwexerrJUYo530fAZslTY0iCW2IORiWCQEq8EmwBhdFP6qRjtwsdgzSaBAYXMriXQGjFVv9bXZxZgliixQGeoN3xHbU7bHKNJXJ6fy6dG/cUFpvirJIVKXqWIGpjd7vGGXUPtLPdCMue8TyarkS/taLtghexAmqdD5TQBThE5KH/l+FpbWbDCXqudmIdRWeVghzjR+UVm4wVpNhlcgwgg93o0Xr5IC1j/xxN32MSEERAOwy8bpue0hcv9X0vbPnYsHigS/elYXwm2UUMwr81smWNq3gbz8v59XxfTwe7xGK2qrrBt1KXSF2SnAEbeKVpL8LL1LS6L8FHGqT9fVVKocnBsUj1CZ2EQ0gZhQsYDeskJs+ps3XeqiMseFEX2OMoGYYtR7wNNhZkdO+ckbFIIXgUylfxzwiYff4S+Be+dtzisPPzPBqIHBnl3o4qkvpbteGIPpbYoVIHScu0sQxsB/3CS0tNBGTXkubUB/3Bcy7kK7g9ASoeqNPcRXVFNrGC9Y6odiD/tuAnduZwiP8j9/OxFC3aa/I5WoFemr2qdSVABXIqw1j7NOtRie6CKJjSfCHW9mqKgCBNycYdu4mHzaGeN9XJaw5IGh9C7cWc/45qvPbOoCLKgwRLUCOEmddBlPrj/t7O4lnjPVdPO6GSjmmBvuH8l6l5IPxi+oOVOMY3GthzbHZ3ZBUrZFbTK/A1bDGZ8kE6iKp1E14yoSVGFKvaZzaPCMslCeMJOX6XMQAmU41YTIszBn3c=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(1800799006)(186006)(82310400008)(36840700001)(46966006)(40470700004)(2906002)(41300700001)(40460700003)(426003)(54906003)(316002)(110136005)(4326008)(70586007)(70206006)(82740400003)(356005)(7636003)(31696002)(966005)(86362001)(36860700001)(40480700001)(47076005)(31686004)(336012)(478600001)(5660300002)(7416002)(8936002)(8676002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 06:54:01.7940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471a5961-a215-4284-8a47-08db996e9479
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 12:37:18 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.291 release.
> There are 323 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.291-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-4.19.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    11 builds:	11 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.291-rc1-gde1cde99fbfb
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

