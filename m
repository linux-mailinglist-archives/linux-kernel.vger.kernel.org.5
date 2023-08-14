Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8739B77BBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjHNOtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjHNOs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:48:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F23183;
        Mon, 14 Aug 2023 07:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M81JEDd8p9zvmWvDI9O+YsZMUmBlmKjAU/etiRmK2aWTItvlm68/EUrML94nsx+KxGh5nWCydi3xqIubwVEnKYAJpIbi9g5psPrRFF+THsFw6pHdE9a+qtQtZrRVi5p5FRQ2w883Iy7WA04Xb3WWnJjmWyC4cKgKDOyCnp+Qs+mDYSdDQPS02kP530Gd83HtQHsaO2ETRVi0CTeOkKOMuIx6jO51HaHQ9W8jjVwDkR3TXdxfmCMxu9nBIWb407OypYLRsm7QR4ccor35B7UhjqNqauS8ETn1Uy6JMgBplB5HkD6H7QwoRxhOFuMo44PGqOL8Jum5JgE/JtY6VS2qLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUosk8zsViY8Ty9vpiKtKoeylANeMjGa/fAQ/TN20to=;
 b=LIn1LFD3DMEi1r5Ounr8iR8O+UCaaPNd03ekAvFpekC3xqIMKAhtcDB2GN99u58puzSf2pCF3EF/Qm0UsmWuFB4wR+/9ML4Kb0J1k6zQgmMgg7HfVRJ6bQUQf1so/qXT/U4HKHMF2IvT56MYVSLecVA8R2+JLMOlcMDtfCTY/AvVq0ZBM5HPpGU4RZVF5TKi9v11oGj6fwPf0I926OdAJ9u8RTn9WjVYyB4X/N8CHtdxh1GvMlbpWmoI2RlbFTiA2cRtnb4uHkslqyzxTb3FN4uujqZPRfqKokA1/ztOS+ZYCLlv/HQjuIQV9f3GdR19166ib/5CqDfSy4fV/hQ2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUosk8zsViY8Ty9vpiKtKoeylANeMjGa/fAQ/TN20to=;
 b=K4n9I8ICYL7cAw04hGeby+Euw5fjXg8QJAnbmTe6fBKJ54mrRvt0DiZRqdJM9iWr2iN2FW0K2QF7do9WYzrDHQkj9a9QisEKZO+WrDa+6dRpkL6+C/L9OSb3ApgqercifhcyJmiznBSuxnZ6lGHeJAEznOCy6kSlbaifi5boiSrW+CmmHNUBAzL7mAEx1Q23NCF0QGA2iNhKfHteYeCH3w0cV5Kl2Pyue/RQwkcXgQKwmU/sGobfZoxcxaP76UQZ+81kQoj1GOjj6ZJonDilSKKNKLANaRrxzXtSqfizp/LjPbXm/R5LP07wcQR0rkuvNs5YdABsm9lN0rfTUQ6EJQ==
Received: from SA1P222CA0102.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::10)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:48:53 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::d1) by SA1P222CA0102.outlook.office365.com
 (2603:10b6:806:35e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 14:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:48:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:48:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 07:48:40 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:48:36 -0700
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
Subject: Re: [PATCH 6.4 000/206] 6.4.11-rc1 review
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <b716d082-697a-4ecf-9d96-549076879293@rnnvmail201.nvidia.com>
Date:   Mon, 14 Aug 2023 07:48:36 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 74519e51-6407-4b7a-e6ce-08db9cd5947f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uirhwayhp3vte9O/oIP9LKtDZ3G906uhCW4okikxdwY6/If+mOvW2iMHcqGFjBYxGGMArvSQmC9X+10Crk21xfj8rimUA9SxLMdSuMX8cWT/PCphwi3kTzwkctsPc20Zi8vU0s3Es31nXnQUnAbd96ZY7dWJxEC3deDg700Ndr/FIhIlPMfABl6Nzi2DrOHruRSiu+86E8h+6aCqViWTzVgKS7gxsHfCeWf5AMwtfImIcp66yl1L8sBxzziVNeFU8s2q94+VT2yW8Y5Oi5MQqlzEeF/YOpEIhL4pQTdsxyVhUiXdTkjp625qUZzLd9J8PJt40fon1gGIAdE2lX0cCj0eYWa7Cn7BIq4KpCHE24TGus71sTH4H0XOjhEMYRR2Kyw+/N9fp9t7FzNG6TMC4MFmeHhAsHK4Uq83URDSiLzu8wjgTfU1MuF9Q16v1h/AvIctfs8xq9kJ3APyGGaSp2nLs471CBijCZdWsHcuYqjWbrlEe1YCqC0LoKPOqRemTWXoAGeOqsuNyk8Ih+8p+wWArTQeOj1VP9z1tu5aIukxfJKhEMqH9Ks+hhtsZCBl4ZH5STHAqf1bmvcRHFwY9yg8TNFPhev+djdxsBzxHLfchhvwmgWKFvHCWGZ1GBkU54kLkcapDZeeCOlC1Ry2sXxheeaySNJ8sMQG3SG32lJ7+7Fx5QVi5UadSrkVnVQRMEdULTmLGNfGkvo9efL4cQPB1ZfURXm7G0/hdlcDTtAYfvogamtAguBSLbwhAXcEFb6aDY+tHmNdWBktH/TOpBlerrBCkXtW4ttefOXr+u8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(186006)(1800799006)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(36860700001)(47076005)(31696002)(40460700003)(40480700001)(86362001)(26005)(426003)(336012)(5660300002)(4326008)(54906003)(110136005)(316002)(70206006)(70586007)(8676002)(8936002)(41300700001)(7416002)(966005)(478600001)(2906002)(82740400003)(356005)(7636003)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:48:53.4871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74519e51-6407-4b7a-e6ce-08db9cd5947f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 23:16:10 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.11 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.11-rc=
1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git l=
inux-6.4.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.4.11-rc1-g00ae646d9c95
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

