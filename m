Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510647C51CC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbjJKLW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjJKLWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:22:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503641711;
        Wed, 11 Oct 2023 04:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9WEkNB0A1R24vZ2NkUmJbPc6HhvFmDHF67DNVTPKam+vvc0tUUpLQt90LIbNIF/OE8XuH3Hust3g4zBjUn4WOU7Gd96AJi462hGymNufDhjIfj0h0RH47Evx6uHP2YsajtpaN27BJOfp7dhIdp/XjO9wQrFtohQ9fclCWqzilUdiPAAmJZXYL/yaqf/5ApOEaKYEO+8ReePMDWv6cRcZ5XEc5aWk5gdrNDlxkQYkX11P8DwZp97azIxDxHCyGEEjvCsX1zylWDJaZRZlk18J6mjl/cnvx+CdCwIOQgmCA72KoNMnURjKMMdMGYk6Mbt7xO+9Mx5pHj5nblxWzObbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySQxSkMqX2cVLrApeef+aZMlI6JRa3HfBxOGOKPSRcA=;
 b=gJfEz59zZJAhQmdYyKj2H5y4DNTuBMPbSfDMBL+Nt3s8Wc6Uq91G6MhkyYPzsgt/GIuQZga4CY762+yJW+FORh53tiDIstJdVOY4MgRmYWSTW3r9alPU/Ygl8lzVHvkBmngPjbFHyan5fRgrLuL3LCRh22t3Yi9AIF419L7BeWvXQWr7eLXOR43oW7Ix7/XOHQTqIedjrxC0ehnJiYjAQb5Z6NgQsKQlffMO+KetPElCIrUH4Rzyc/3wUkEtEQuo/HcA6OMlTvnZOSckXHwsaneoA9Qqb/lBB7YyQv8oXLWWXgwNRU6THs82AoG2Or3A0RsrKKDu2yoQXq035zaGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySQxSkMqX2cVLrApeef+aZMlI6JRa3HfBxOGOKPSRcA=;
 b=fxqE1ylGVpEUFuLj6qvvWLQDrhtA1cnm6rrDCy4kPVxbpUlciy7ch6uyqcmlovmTHJFEiIKc0bNhXg/BIJhVrYNbzsdI0ytBWXuW2xuKRGNx5Oyi3lP2kfqoZuUEYDE8OK/WsXOEDRxWHBDMWFyOV3smOETv6dXH+kSpzBqW27f+Od8A3/CPZe6eg+y2DBf/KtXYnC0pr7C3FLAjuRPhMPu8He82ZHnM++YeNI+vz/zhr/U2lDhY+xLH7QzUiF++FtuFnzQ5gWy5+HL9CGje4UofonclG/eYCnZ9f28yvlIWMiEntIu7iH5nKdf3tPZkXR89XtN9qLZZzcOyIrSzGg==
Received: from CY5PR22CA0058.namprd22.prod.outlook.com (2603:10b6:930:1d::9)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 11:20:06 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::e0) by CY5PR22CA0058.outlook.office365.com
 (2603:10b6:930:1d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Wed, 11 Oct 2023 11:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 11:20:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 04:19:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 11 Oct 2023 04:19:51 -0700
Received: from localhost.localdomain (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 11 Oct 2023 04:19:45 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <arnd@arndb.de>, <digetx@gmail.com>, <frank.li@vivo.com>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <pdeschrijver@nvidia.com>, <petlozup@nvidia.com>,
        <pshete@nvidia.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <sumitg@nvidia.com>, <thierry.reding@gmail.com>, <windhl@126.com>
Subject: Re: [PATCH v3 3/6] soc/tegra: fuse: Add function to add lookups
Date:   Wed, 11 Oct 2023 15:07:35 +0530
Message-ID: <20231011093735.8069-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZPnfmxqI12OsQRPA@smile.fi.intel.com>
References: <ZPnfmxqI12OsQRPA@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|BL1PR12MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: 97df51d5-8721-43ec-7df2-08dbca4c055f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKpc9T6vWvXC74yS9kRvP/2moZFvQ2k8WPOXE//4RWhMxkzSF58RrzxzRkCmB/icr+kTBH1tGvVM017pJDPHrGniuN09vTLm2IWmhkIFSKzWssL0OL+cYMi+kTtAS2nhC9cqiXvTMpVIInHcmJdGkJw2QL2Bq7ZlXd1HWThE9MdXsjn+ePqzFaHkUIQm9kIyjKbL48C5YxAdKeZPQGu9S+4FDcBUG9f1+e2Vp84mSfmBv3+7Cz8AwmZ40p/BdmS4PReg6GOLHXE1uZfzevvu/I5SccTCsZY/Zoq4RpYQMWNiWKbN5xgODiChGSa26mBkzLIrmJnRiH5S5nn+yonyhHvcQpnuuxZmZTQlJKCPlDrNO2i17ZKoExGC3cNNumG406cy52gQNLe7rS/FYdNqZLg56lFIMKz66mRvZ6ksi9Q1wsEbdC/wBpHDIyU9i9iUI66W0fo8ebigovOVLlw1n9kFj9VRyuO0F/6/2crkmyBSgQTvqlvSLRw7EPtLrICYVkh3vu9O5vSZvfowdvNe6rLxrzyPFEYCeKaVlwaVrR+gM6m0J0inPFZzZCRelLa1PjBJf3u2rQY5i7fNaUBfbo9Zo7csktxLIR1xxWpONCxQiev6RkJAr8oVZDGD+3eCB6ntxiOi1R5Cz76dnUYef6elEhZtFoXCzdXjvmnmUx/7u8JG4e9pYG/nxNC9Z5IjVrPUGT7rEmDgq6eM9BaMpEOb/W0/RMQB2chSeURYpH40XzUUx31qCj6R0QlrNGPs
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(70206006)(54906003)(6916009)(316002)(4326008)(8936002)(8676002)(41300700001)(36756003)(426003)(336012)(36860700001)(356005)(7636003)(82740400003)(5660300002)(2906002)(47076005)(26005)(2616005)(478600001)(40460700003)(6666004)(40480700001)(86362001)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:20:05.8432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97df51d5-8721-43ec-7df2-08dbca4c055f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-07 at 14:35, Andy Shevchenko wrote:
>On Thu, Sep 07, 2023 at 12:40:49PM +0530, Kartik wrote:
>> Add helper function tegra_fuse_add_lookups() to register Tegra fuse
>> nvmem lookups. So, this can be shared between tegra_fuse_init() and
>> ACPI probe, which is to be introduced later.
>
>...
>
>> +static int tegra_fuse_add_lookups(struct tegra_fuse *fuse)
>> +{
>> +	size_t size;
>> +
>> +	if (!fuse->soc->lookups)
>> +		return 0;
>
>> +	size = size_mul(sizeof(*fuse->lookups), fuse->soc->num_lookups);
>> +
>> +	fuse->lookups = kmemdup(fuse->soc->lookups, size, GFP_KERNEL);
>> +	if (!fuse->lookups)
>> +		return -ENOMEM;
>
>Why not introducing kmemdup_array()?

Introduced this in v4.

>
>> +	nvmem_add_cell_lookups(fuse->lookups, fuse->soc->num_lookups);
>> +
>> +	return 0;
>> +}
>
>...
>
>> +	err = tegra_fuse_add_lookups(fuse);
>> +	if (err) {
>> +		pr_err("failed to add FUSE lookups\n");
>
>Why pr_err() and not dev_err()?

This is called before tegra_fuse_probe in device-tree boot hence the
reason behing using pr_err instead of dev_err.

>
>> +		return err;
>>  	}
>>  
>>  	return 0;
>
>These four lines can be just shortened to
>
>	return err;
>

Updated this in v4.

>-- 
>With Best Regards,
>Andy Shevchenko

Regards,
Kartik
