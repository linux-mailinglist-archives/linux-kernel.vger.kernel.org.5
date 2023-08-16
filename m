Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F241577E692
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbjHPQh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344851AbjHPQhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:37:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F41C2724;
        Wed, 16 Aug 2023 09:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MShFF08GYapZ0FnS+DXCG0bKC3VdamsCZvIJEonAKLraiAp+dVPxi04Slh/dnzMyEiSCxTtcmwmpzmp6pEtcjRxUQ1TZZwTQtABpAhjWAndETfMWcLgUX16z3rgodv/V6iM+WdOTYsaa5SWFGSmi+1PClYYnYhB7mhDTYnXUMZF/hqO7JXqL9KisGIG1Vkxz7/t1D1mNwZQVikj+wF9NEPoHwz/BToJXDY7VDUwOuk0o5OO8d+xqCMdrqlywAUPY2q2BSaceAMc+RoUYK+2xmjMJBw/EzPJjrZB8MW9ihteTJpArJHAsLXi4EX6ceOLcOoRf8sUSmFBa0JI3S3KYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkR74BTEcSe6D8aFH4bv7M0SkZPl+ZuHgvW+U/LM4ac=;
 b=b5w6Ab709+Us7sPf3HK6t1xSB2gAD0KqRPZpAlHkevmp3X3viWRj90H9/EwfDlThrW5EscrpYkAfVcD1vWGkXCKiTw+tLEcrnQ+lZ10NUsTesr+mKGTWM2ZZzsnJNEpF9nOII06Af9x+b+6myJGeP8sCsCx56enWBHmsv4WV+EdgxFYxbfWj4orOYs7v5UHFigP3zcGxBKu0nIAe3mC23AaSH6o1cuUE97PwTX7FY0dl+PItZ1ufLAPmr8wGIR16iZg0S0oWUhUTPC58rElYeDtLq7bvL6wlNKgEVA1zPRbm54VckWp+oh4X06PLRdiPvE7K0TJRBuKk1+l0wOl4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkR74BTEcSe6D8aFH4bv7M0SkZPl+ZuHgvW+U/LM4ac=;
 b=Nl17idLRd4cXzdiR+zPhYgiOdHpwkNXSJoHYM4L+5bTWVh/HSqow8JOUQpa3cZdGgX3oCxlzqybMmEYFcZN/ZcXpJAQim2WweXUL6GaiGR1PFJuaVtjGnqQRFEqE2Nu6CQIDuu/Ry08r9H0u88MrCqtZ7lttGZG4j2tXL24EM7zWUZm75Vxk25O+EGEnCZzOuzVCZTrSOpa1ZPLXpNng5MYdgesd1b1APRmIba48rHAciemlQ5O0+T4rAFkL5HtqwIsxaH8yR4AIBawcbHEP74MLvKjYpzPlHkOwqpMBHAlzIcdNOKUYX0rZMtvpfgK9Cw+klbcs1b6pEmma+w5Jhw==
Received: from CY5PR13CA0055.namprd13.prod.outlook.com (2603:10b6:930:11::7)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 16:36:49 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::db) by CY5PR13CA0055.outlook.office365.com
 (2603:10b6:930:11::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 16:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 16:36:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 09:36:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 09:36:34 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 09:36:30 -0700
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
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <474472ed-c85f-4d93-b6e3-10fb8ecfe203@rnnvmail203.nvidia.com>
Date:   Wed, 16 Aug 2023 09:36:30 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d63ab2d-6ba2-407b-6c8a-08db9e76fcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL5fnQftx3UNlk4p6KYR2AuJHzwicRcBSPY0j9fGIviYnZjw+0mgwHMI36me5QHebfr+fVzYt+ISJLY/QGhtnlwsI2h5i1Lx9/uOaKWCdDqP748XUu8dCh0aVib76PiedEtJ5W1L2ElsYy0DRvJrFyNvCaVy6+fFoFAqxfuMrWwxPstX+R/hToV6EmHDFE9HfF3HzTCG/Uhr+2kjw2o2feHbNRFwH2q+u8CFsKlbJe28P1mHBwHk/cPsfJJmYzZ64Pze5jKuKgugNZmZrVSgFhsPGFi2CoPDaqnDeA6qUqdIujph2uqKc4+UdluZl3t6WBUjWB83pAQMcwta3liFRbrgZnMrrZpEwR1UhibL5FOUcYXdCh4vOe9ickUR5UQvsRqJUJCJnA0nyCKbO39kEWUqnKoB+aSMKG89QIJW1hUiXJpRfKZCxLK54JK139MVKdq9Vk+zhrlUcBpX/edSBuZLvl5hX8zmT9tRNnb957qGUrNB6nmfW5qcQbcG74wok9QjqFQ+IzfF8ZFhPz1dAiI1sAybPdlGTEXGeoYx5cIYpU+TPCos42Gy1HrhGMR6/4pB2fNiEtq7bgSGtSYyIknPN0AeyaF15MGa2Owlxp7FioSXNW+qauZKSkTwqMxrwXqTeg0O9mq8JO0ikZj/RIQwasbXtYuAR7H3LnIUMnhXfHlT5/pjju6zuQGzqvzbgNt7UILJfurOmUaINF+857KYJ4a9KJy/xfQYdJm9MBIXDdHkIVVgEdVS658itZ9OKEkfotoYZds27c+udDJDCdRFJthqe0B1FySW4btFRYs=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(7636003)(316002)(54906003)(356005)(82740400003)(110136005)(70586007)(70206006)(966005)(36860700001)(41300700001)(5660300002)(47076005)(31686004)(8676002)(4326008)(8936002)(2906002)(40460700003)(26005)(40480700001)(478600001)(426003)(336012)(7416002)(86362001)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:36:48.8464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d63ab2d-6ba2-407b-6c8a-08db9e76fcee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 23:18:51 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.127-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-5.15.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.127-rc1-g952b0de2b49f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

