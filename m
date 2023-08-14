Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BCA77BB5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjHNORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjHNOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:16:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C606D1730;
        Mon, 14 Aug 2023 07:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUiGo8ogQBK1DWzjQZJt8oZ45v2MrLW14jElMQNqaTb8WanpoeeIQis6WFNh4pXiVtYoF/FUtjqjXKeZSRMRpXamFJN5x/VtqgsmIBiKiHeN6DiODUsUgoHZ1xQWWNFFr6MI1BICGJCEka2SMoIFknxMPnHGuwhBvvdjSCWg895LgQQvSmjm5tB6UPt2hoGbrd2imHpQOG8pIB+ZJzy+RMXhYIq/6/wswTtVa0pnalCNFtfSsJhZ6R/2zPIFUyXGk6MDSaCtuDnWD626mh1pD/TpqrlxDfmFcE2T2KIqHLncsH9tnz8mHNCgYpgbbp+g+9UYtMQnlwAF64RYfVo0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83W80915y6mYcp1oi0fYotVyyxYf+m2Prc++Stzxxwo=;
 b=n6UJrE4X2TOhdmbwR3t0xT6McNQsO8eeFqgZGXPl6vCUUkFkzn8ti6sIbmW/LIhIF2bYVwMZZriSxLV1Op/K1gpk5w7Ljux+xVkOvD9AAS4x0a8bpiS3pbZL++dZARhn9aURXDOzuPenApOJEnNYWg+hbQW9Hsz9ZOou2Jgu3uT517O0/oOKT18riyaryuJ7IV3mrEDcTGmhcDeSbt6YxIyZu96UQJ9CSnWCVI4zpvGKoWP0tXezjzEDyZNXjZ8Zz3UNgALiGkf8HKncsHFcNqwjSw8ehz5EMQ9tda09fGRskTt9LWpOzJcR9SQ1VY83RlFS4MrDQjDT0N+S9l3V9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83W80915y6mYcp1oi0fYotVyyxYf+m2Prc++Stzxxwo=;
 b=r/eCShNC+Cej8kcavsO2wvy7OLyRB9LugJcqU5p6SLXidyhH6fZdHKlIZb+2/r4KGhFXjfUjtokmG7zDNaddcxmU/1u/FErGbmGl2uxkJCJ3bx0vljqARts1okf2Y82XPxI4xIcmnBMEEYMePfmIEafjpPxUccuBG7vRnP5/yPHR3BXLFG83owpA6tcliXnPzao3omyKhHZdR5eHuje2hEPez2ZSMF3c+nNvOwTBnoeiFt2U/f2S2jnhfNYm/BOKfdZX/WPx7jnq9MYXcD1bj5Lb3PbRDSRqIrFF/M8F6wyBlmfZJ5KxpMnVuO3MjsRVuqdlkhLP3AI097XqPjTnhA==
Received: from DM6PR10CA0011.namprd10.prod.outlook.com (2603:10b6:5:60::24) by
 DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 14:16:24 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::4d) by DM6PR10CA0011.outlook.office365.com
 (2603:10b6:5:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 14:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:16:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:16:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 07:16:11 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:16:07 -0700
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
Subject: Re: [PATCH 5.10 000/201] 5.10.190-rc1 review
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <ad604786-301d-4d00-888a-10179d5c2b39@rnnvmail202.nvidia.com>
Date:   Mon, 14 Aug 2023 07:16:07 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM4PR12MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: 768ce0eb-7d21-4b07-b796-08db9cd10ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw5FwN+ffGy3arRY9FezTrj1pSex3O6404lm3BdKIv/YF1eeMlkZsZ+KE7EXOWiwOrfyRN4+SrMUnn8P8SD9zwVSKtHsNsgqwTo9YnS5AzLpGZSyNCmZbzxNoAypBEpylqf8ss/+N4gyMYTKelf55oNGPzmTuyFS3MAeCYYmnJDpi1ipUdKdkomOUuFVqJp6HdgwPBYx4dA6fsPjbjsaHe+pMirVzUcrQTtJ6VDSxLEFri2iFVf1F3Kng+w+V+6M5hTOkY0TmsCm/YuFEsMUGFi0Zvb46Gx7R0UmGjnQP0Y6DeXfRTsb3p4YTgW7a8ShrXr8N8X/a3biE0Wp/fa3hD7XLEOF3d9g3J9Zf6aQYGWP7KEdKpsB5uebFCFZ45nuBDgtpZmWmeEpY4wf/RDxJNX9PckWLosHFB5kERUpiH3YzD+ISTmK7ZrbgmvsDElf11vcEp3Hmu1ioHeEdh8tHvednW26eJtPyn9ETAZa8+CraE/f3HLn2zp8so3T5iOWfYC2LgvQz7NWgjQn4qQl5Fxn75KWkPE3napihrC/BmU5XIJXKUD42mlpyDunzE1gAXl1/gwef2CgnlFIBfN90IVyJoYt8obc/z00mKZ3GxhKfeBYlC9OGd7OkQDW88MszJcK1ea9cLYBHamsDiMTk9In/er4EWkgPWLx+qeEbg2TbNDmTc0K+D0FwywcPkWB6A8a8PDZtVDAHP3tDAuHz07n8WWNq0VANTTa/otgPFRl7vO/ahQtGI1HoWQQOZmdUXkKHguaZ/zAGbji9WPOK4ry4np0s7BeDbiySYc9DL8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(82310400008)(1800799006)(186006)(36840700001)(40470700004)(46966006)(31686004)(40460700003)(966005)(110136005)(70206006)(70586007)(478600001)(47076005)(36860700001)(86362001)(31696002)(7416002)(40480700001)(426003)(26005)(336012)(2906002)(82740400003)(356005)(7636003)(316002)(4326008)(8676002)(54906003)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:16:24.5053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768ce0eb-7d21-4b07-b796-08db9cd10ac9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023 12:40:02 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.190 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.190-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-5.10.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.190-rc1-g0195dc1d1da1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

