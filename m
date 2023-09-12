Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D201E79D471
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjILPLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjILPLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:11:00 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83A11BB;
        Tue, 12 Sep 2023 08:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R39POmsYerO3f+pP2HC33/5F59r/FvhfiALtAPimMH0V485cfSQ2lr1MgwdcPfy9OWx+BikWIBv9b7kX8QV7MmuHlyu360F4PJEw1r3Mpl2W2nNmxowTXe/vXYH+lGZk9+VeXuXbt53dZPd+9n1kdheziQgp4/lruyzkEotX8k86bf4DA6xhJ3rSrnsHypl7i29zAFpY8yu1D0viZIlUnBwQoS1EcWfkwnjM1VjjE9glkufzBKgZNlIZz+qCUBpM1Zh/+tXXdx3cuJgYmzz/y6cpa2aVbPy3GxmvcBsz6REeZ+vOxQ9435fQpIQbvzbm6jmEE+Ybwas8FAHlfPHhHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IOODdBLU7lC8MoWrqO6fN6OP7g/UE89qX484PDmiwI=;
 b=VI+KMYZLcOHOd9Q8UCnC25Q1LrXoNCHSWYSpKXc7OK7dtL2n6Zhh7I0yIIySqD5v8//KIuAKfN0DamXEpMvlFX9U30VWmSk5ZvXAk1h+JoPBkjhjaqsFkfC5fc+8HpK7WJ7DDt5mz7jlH96Szi0eNvfrrD17SeX3pXdX2o41neQvliYblW4xEvr7V2qzBhdJ2usUAKAwkr7wnKWsIpELTKqs8U3/HOjjbnA2x8+HTg0HeEENH0FipcuQguVuUlVAEm7pwi0jDlbsia/Lz6NMu8wJJras5gsp1/61ziM9ZthTk8gfay1FKVwZ81JyRTN5371baWOdWsy3qutjaCEKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IOODdBLU7lC8MoWrqO6fN6OP7g/UE89qX484PDmiwI=;
 b=gy/eN+VnoLzfVC90+p+NgWCfwwsG77nfGrNhglsKEC8TJHri03cd4paZY3KY0XmRHZwAmNx51cGDpiTomxEn+PmP8bRJS271PIdkTKinNqoY1i027/g12DhmK1pUDNFD8gD/EO/7IMx8wnG/AQcvLlB7wiM9i5zT4QmKwJagT3QrV8HXWq7GCI9STCre940zRnz/cfxCsdO6Uhvvhk09R2IKGMitZRActw5p2s/8c9JFKZnwXKdOzAqrnbnShfAV9JQjjvN+V79gEHj7uvlRp11qNlpVICJM3rii8o2RZc3Sqcmoa1uXbdHLIeXlc0WYe82TZbXFHAaHyooybObooA==
Received: from DM6PR13CA0069.namprd13.prod.outlook.com (2603:10b6:5:134::46)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 12 Sep
 2023 15:10:50 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::13) by DM6PR13CA0069.outlook.office365.com
 (2603:10b6:5:134::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.16 via Frontend
 Transport; Tue, 12 Sep 2023 15:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 15:10:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 12 Sep 2023
 08:10:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 12 Sep
 2023 08:10:30 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 12 Sep 2023 08:10:29 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c90c1139-e99b-4996-87c5-affdf7c6768f@rnnvmail201.nvidia.com>
Date:   Tue, 12 Sep 2023 08:10:29 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: f45439d9-e021-499b-4043-08dbb3a2732f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PlRATZbadKrIUb+qSZG1P2PmRr2iP7jqVjIPnU/xKe1br7CK6aDoHlV4jsOnIIEPjwZ929bgz/A19uV0nl0QqBD59VbDdtO5r+7wWE6GkusoedDsw7tgJGE9STbFVkZHoSOAENoUUCYj9/jLW0PSFZsy0tPAcEXXnnsSijKK3fIB3y0Lpdt12A18MiMP2RzoqBDtFP4srHmOzG7YoD/KOlYqxgdFDdbqKeVyI5q+ObnWhWMGL9n6LOMu6rRnXOM3iuOmjshQDnQLtrchDix2F10kHjUW4gsIo814XC3ADPmEkrwr3ZzBQuNlGTFP/ZiWRWmM3iexkAaS5DnJEUguHD5cHVI+9Tr/d5FgHtYP21oH17x1RzrPImLG7ixfwshuhE03GRrQUfVf65tgyQuhGyh+08n72n3QbKfPxH/dQ4lpse9RpMV5qmWIzD2RvNclISHL/bmzdX18Yrzf+FiSBQlkl7JMhjAccSHqU6h8hxSYPG1OT9XdO3jxp3bhivmXQTyNT7Bjgg6YJcxUDn73OoqvlBtOM8fa5Duh9q5DwG4Q6ngrKmRW+bsnZDNWzxxC+iFP3DDyRTdRbVyB9OHHND96ZpHaeEGp4EURo4UBKWMqj0ydlHZh/RmdJlsCnMllnRYQD5bBTJeUPy0WH+KuTCn7uzeUGZRyQDN8Nc8dKUivaT80VvlUJQD5LdmWFP5DxKqi7ClQOYXvCTEIyJSrg828uNlM6rLCRegf4fUgWjZbfTfKnnznQFnAbGLLm06VE/6L+YrcCrPASdQW1iDX9YhOcr+TpARrfag56RNeYUw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(478600001)(356005)(31686004)(966005)(7636003)(82740400003)(41300700001)(47076005)(54906003)(316002)(426003)(36860700001)(6916009)(70586007)(70206006)(26005)(5660300002)(4326008)(2906002)(40460700003)(8936002)(8676002)(336012)(40480700001)(7416002)(86362001)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:10:50.0201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45439d9-e021-499b-4043-08dbb3a2732f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 15:40:33 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.53-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.53-rc1-g6e71673725ca
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
