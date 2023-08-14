Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8063B77BC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjHNOxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjHNOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:53:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1B10C1;
        Mon, 14 Aug 2023 07:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrgOd0LWT1EJ/fH9g4VRRDp21pgJCJpEt9RCz6TsmzK4geQnl4jQg9BErxjE0CZkiEfmajKEE6fc5pcCtqNZ2X6vW0Y+lgBDA2ojtqihd53k8n8qLQ9AjIuLX/Jrcy0GcMIBl8OKoy8Em8Vv9sJoLM8SippBTFVHF6XYNxVta81lD3459jTqomMtpHiVz+L0q5uII0ng60NI8gfOkpG4bTyARcJTQY2t3TyPnf+KSXl21Rw7DbEM1QddZrZGgjsqwN3klnV3wGDRr0MikNUfKPqCiyDMrQoMZqL4Tnvf+KyCfNJh8bMpdvwgC9hi3IVpKaWv8oFnFOZxt7TO4vIfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJIknBhlBbW40+XhoKjERpc30PNMEO/tutReTOnNC9o=;
 b=KV+/H121y6WuY41ggV1oJOZmL9JL7jsX5p+TNFAZchNQ8t0Qh3/sHqLL0iFPcChRelcUGNphcEL7lXIuCbCUjwuGNT0dcF08ln9U6/MnF1+IOHtrG22QEQpoo756qg2nU3rOO+x9WicYx+sG6cb37V3hJaAy0hjEUkzfEAiYH3dYpYmUONStKKMcCNQ00rRUOXmHaYSw7DFIRxDMy/c1n0a6qFMl9IZLiMT+dljNZ/hjwVLTHyKwv8eqkbGuqZ59U4Acy8qXyPIodfdM/S044Zsy/xw9outa9n+qtbOh6c7vSpq5gOF/pVpf+UTLUcetRlfc/LGV6YBfdTSzSqN06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJIknBhlBbW40+XhoKjERpc30PNMEO/tutReTOnNC9o=;
 b=Phult9Tr3Ni2mbGuzNI2QHy1KoFV69Tj/DwodRKDvUwRbDam+zZsy10ERdY25ht/o856BWZJua8KrlPtClfEMxlrWRhY5ES0BbqlRBoc6KODZCowyIVmnMNtvgpdBPHTgMhBv1Oyhx+CtPSc26Do8Jq+h/2oODCUDHJUPr6OutXJx+i8K8pQB9fxSZGqZxNxMUmIe2o53yAELNIdH25NFU3GATMiriRDS64gvBYPknUXrHmIo67T4Wo0ym8aTxZhqo2KbRdKHUmfYte13C5MZc7MQcQMqMV2+9pyNL6FHBmVDwf9DESEwciLjoOdlfWepOBSzdexOafqk/Jk+5Svxw==
Received: from SA0PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:d3::26)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:53:22 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::c7) by SA0PR11CA0021.outlook.office365.com
 (2603:10b6:806:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 14:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:53:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:53:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 07:53:08 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:53:04 -0700
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
Subject: Re: [PATCH 5.4 00/39] 5.4.254-rc1 review
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <e2bc9c19-e3d2-4960-95e2-f1c57a17af15@rnnvmail203.nvidia.com>
Date:   Mon, 14 Aug 2023 07:53:04 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: acbbb30a-decd-4c96-a8f7-08db9cd634a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqIOwGAbZuUZrmmqYzE0Ac5TmbJiP4eDmnXIMz3kOga8v6Utn/BIaOqxhJq9Cw4U4EVYMUh3nFn9QJfhXnLqNv8xukd6GmHWlqLOOk4uejkcMgiFVqOujkF2Ueb/WO2fBZjuFy12SP7sRTWnsb05o3vosbod2zIt7hCkNhOybijBDs6rrsiTUYQvoV/GXKT4B0uY5si3aeynLy4SYmAdd4bk46ITMf4fN2qN6mdGrF1mJoqOO8ZhhKHcxEBcwCSaq2Lxto7akRWuiKGf8aAMk3sfHEwgCUeD230h0+5dyyrQb+/RuR0bOz1YevyzsN0RJnNOI5v7+t9v6rFtVDf8xBefhOJxjLpZJ6XyvEjYbkzkqEE5+Qypu9bPY7HpBXKg/Hti+ca5pw7GoJvoT3i7iR0r/9yZCLfz2pkkR0F2N8y20pSEVmqFqRRDyIYA4Yw1OPJCkIkQqYRsXx50MiXeifaXRxiINq2Mbh0EfG5TmPZaBtTwRO5kh8PyZdooq1LrTiG3zqG8L4YZQK/tdFiImOI4bj2CDjStIaAHK3p6mjCobWbUh+nIN5hh2YZjcEMxEWsFXI8iVAfKC3W3+qO/2i4IV+HnoyiiWykXkKQl/+tMqy1LxTL8ikLTt6twWaAVIQ4/g+QK96FKO2z1/y3ueIMM6mUbSpOeZIA0AuFimkT9prSOg7B/1dGOPyPpQobSkawC3CcVmHosZO1KW2inNmGfUqjG/6cjOLX7jx4okKhrX79R+l0IdOA/W9fvUm3/ANYI5SHnhds6ii4M47t93I6RnWJ9eFNFx2xz5rGdi+Q=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(82310400008)(451199021)(1800799006)(186006)(46966006)(40470700004)(36840700001)(40480700001)(54906003)(110136005)(40460700003)(478600001)(7636003)(356005)(82740400003)(7416002)(5660300002)(2906002)(86362001)(31696002)(4326008)(70586007)(70206006)(41300700001)(8936002)(336012)(8676002)(316002)(26005)(36860700001)(47076005)(426003)(31686004)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:53:22.1882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acbbb30a-decd-4c96-a8f7-08db9cd634a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 23:19:51 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.254 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.254-r=
c1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-5.4.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    11 builds:	11 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.254-rc1-gcbf271d98b86
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

