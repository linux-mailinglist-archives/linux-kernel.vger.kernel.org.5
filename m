Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA277BC22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjHNOy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjHNOyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:54:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B474183;
        Mon, 14 Aug 2023 07:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY+TQ8sBsjOaqoJ+Wi2VRkdCpM3yi7IUc2VBLQY0EzWuHdHXgjoIdTcYvuJR5HofcK2Htw+ODaYHRpL2SSHaFMbIOfAtHjKVvgybLyLbxkLmhBRNjLiYe67DmiUcmDvYFYXiRVXJHZyATzroY1KZ8056u/BVe4y8Gru1j5pYLImxgWPSQ6q+Op2/peoMe+sb45RKdYBfy1lLiSYzK0afAv7aSe5KQLGEQZUXDHrqnxQskWH6SHr9x6nC1eRFqII0T0ZhyY/elF5wAYZPC8VhDni/5WkFW0qfpZSCfIpoGV0B6x9MlvfTjEQgZdSesXWrkQ+ywYoJ/17uyBFtiATHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhaJ5CtbQPh5/YczHavIt42LG6h3lHqzHDKbCvKTsXU=;
 b=VN+cTfc83k/F4v50CYHWO5OECFwhqD5h4rdHBeQBOFXd2oiyFRLP+II50JZaeCH9G0mQJeHJZXZHnKwTiwYtGYYqXbkjc5+yn1nKpEkM6vg4Mh3Ppe2kWqoebDI/EzNNwMVAOTSCoQrJyb9r03sHFtl/wPRqixvXo6d+fnL6aB21FRyUh6CIBqB6GDWYXI6vJO+x1GY9jrDL3vKIDPXMgLLttlfw+jyo+Bg6MYRCiToNETb25JwuRNOAS/Mwhhxu7nzTq7LWlNXRuxcxjUG0gxsvD4/t65x9MaKM40ZfWskx9XzSW4rlyWhWs/RBRy1Z2RUM8kd/gXOOmOnFOfJAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhaJ5CtbQPh5/YczHavIt42LG6h3lHqzHDKbCvKTsXU=;
 b=ACEZIM37KEwDJwIAl+0nZvLNA9Rqwi702WunYqoVZOdK0lkTOQgjQM4C25IS1ySAMwdxH49M71wxLL577UJgpMCWCunAk1VuprTNTADufT2Ljg7XIISwYYZUVe0Bq9ZlNThWPnWBiHwvxNiXDF6SsSXkT9+U7IveC1TF0sibVb9znLfNfoj8gNHKVbJTzd3HwTbfdCtMXgGSuBpaowXFzgCzw0yjSglqB9YVARPxBAs8j/QZJ1Fd6G7iL6EYw9uRbTpwe7/FT4fv6iaWKg+Gj2DR1YXW2iEud8dOSvgTb+oBnG3n64nF+6xAFbQIEkz/PKzQEUp0iK/xgx/V0odqJg==
Received: from SN7PR04CA0234.namprd04.prod.outlook.com (2603:10b6:806:127::29)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.23; Mon, 14 Aug
 2023 14:53:59 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::58) by SN7PR04CA0234.outlook.office365.com
 (2603:10b6:806:127::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 14:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 14:53:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 07:53:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 07:53:56 -0700
Received: from orome.fritz.box (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 07:53:52 -0700
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
Subject: Re: [PATCH 4.19 00/33] 4.19.292-rc1 review
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
References: <20230813211703.915807095@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-ID: <e2b92a8e-7cb4-4f2d-b27a-08e45e67e3f3@rnnvmail204.nvidia.com>
Date:   Mon, 14 Aug 2023 07:53:52 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CYYPR12MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b50445-263f-434b-cb29-08db9cd64a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3wFjKuOXlxwxl6WbtzRjFBY/xme/iKyb0CtumdsxIL19p2/eaKbqXVl5gjvYoVnymnX5DUyJgp7wgtPbp7RJp+BWm9fw4Wq1B7CXsRLvRULjhXdUTBx8pec5Ha4S+YC09UUVLws8CCOrC562aOM2aPgquc2tpGRw+YqDrBDw1F3lAIfTGCtH8OWfUMTL/9HsCgU2XFA3XfBLyL9wGGeNnqtd8dDYMH5q7YmZ7yeNN9MwVuBEM24grLNehpdFXmNqx8Jr6dWR4h5snep6goGEfU4figSumYYLHNmsCe+spVgW/5Oif2JzRq2kieRgEEpajhyrox5/TiCj+dhQQ7ewsvufnIfxcH5mFFab2dfIl+1IAKjFBDLwFCY+0i+K6Y2bkysJNXgpalQBjS5yhOtIcwkW3RfIE/OmNkVNlDnGtcrv2soPazlwTwgWU4KlrnFHM9HsqMdsl2chZofKU1djBInNEwoCdI0aPDFmat2j0V6nbBJltq0SJsRCKPapd+w0uOflkDb/1PM/du7fTY9L7+iiLf1tWhL7VQbuAQHCZf+WyPZPO+nmZw6hX9ogQzfOHb6CGsNKLVL0D23xO958dSC8ZTqwpaX8in1gBYFcgUfaArEkQ4wf9EPbEM4jmuEjUDpPR2KTTi3qqUbeK+Xz7xMg2BUeHqWqowhIvpR5ACcWgIDMFlvaWXyDIoR7etq935dQpvv3Giaj35YNPgaP/pIHJ8zz/DI+S4usIPcYOfa/4iww9VGhjGD81vGqk6HuVpUC/yb/3BjSictEzEqiF4jt5BiksDzKgl3BNNRiYg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(82310400008)(186006)(451199021)(1800799006)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(7416002)(336012)(426003)(7636003)(40480700001)(47076005)(356005)(82740400003)(36860700001)(86362001)(316002)(41300700001)(54906003)(70206006)(70586007)(110136005)(8676002)(4326008)(966005)(478600001)(8936002)(31696002)(31686004)(5660300002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:53:58.9154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b50445-263f-434b-cb29-08db9cd64a87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2023 23:18:54 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.292 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.292-=
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

Linux version:	4.19.292-rc1-g3c7623350250
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Thierry Reding <treding@nvidia.com>

