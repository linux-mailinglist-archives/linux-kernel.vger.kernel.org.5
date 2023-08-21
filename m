Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85865782801
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjHULep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjHULem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:34:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F6E2;
        Mon, 21 Aug 2023 04:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3jKql/YhifnpEhiDq7aIlslEsO/IrVhWcj3eM8PQMjaQzrwIaZKq4laJ24vI8fN/FCidag24j4KIaNJwCMmARD5WCe0u/eWqPJanV91v4ZziD524AOAtAx/dz65hyTXJLCtkYiS3yxtRSx6GAzNzVIyVjdPBw60yeTTQQ3bWJlHRtqg7dj1c7rrXSWyvdIuK3HqsRmCRvuuWKJ88ANnLG08qJUojQGsmLAiY5tDsuC1SDBc6RjbLn4zd6Hz8XoV35bdbYfUR2LNmR7gOxv8hMfckpzl5ZgE4kKS1aaH06K+B8MIYgfRxCnU39O+3tjx0eiGxPM80O+lNZ0+KRXdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DUpij2rLrf7qbpLB+ZGKEJWd3M7+TWsCYK7NlDFyCA=;
 b=EHdy5CMIQbJjfdubuXE1JIpG7Nzh9flIdNHFKbdDMOt0s4Uqt4Eh0OapMA2DuaP8vI0yvQlquvdSezaPTL+Ysrmxj070AmhkUuoMaHNbLAIq4RuzvyIWdGPMlEIEIIacxvFvNgNwHxqZfcOmHagYAD5RGq5eiqcJj4udpKXFm/XmraYcjp50P45M7LGEaVXY3EyZIAPyn6CelkiWZkSl70heffW/O3c/XIbEwQPb/bGVDgqYYF73HD71URP6W8MTlquau73G20n2GwvDYnb0bswrRMaod3sxM0VYbNJMw00AQH26OTSr+avhgp0hBoqS5NWNTovm2mO3oBsjl1vsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DUpij2rLrf7qbpLB+ZGKEJWd3M7+TWsCYK7NlDFyCA=;
 b=knSUkDM1i1H1EXZn1GVLoQ3DDcUIFiDNUyoxf+IUz8LJNiPMd57pyKjgPTB6K3bzfE75ow4MhznCj9i7T4P50eiDmnHH/Whu0xmmo4pYqi5SJPGscNfCKBaeUPlsR0Ice5W8VmBLbB1tE2ePVLwB+QQtTU4AkCnPSNKLhRN1GRBcoPFhiYlBh9ms9IbX4ZXDoKef29SpGzImBr+FX3lx5yTtVkuZQA3DOE88RDxkuuf53hqKqCve8Z0YVu7PO6PQRyxg4IDfeRz1vhUDUh8a9lRQVChaJZ/lP06dLDfTXlrhYaRggOkxuVz/Kzvr4hrdu8I5U5njcY3v0U4IZCj0Lw==
Received: from MW4PR03CA0169.namprd03.prod.outlook.com (2603:10b6:303:8d::24)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:34:37 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::80) by MW4PR03CA0169.outlook.office365.com
 (2603:10b6:303:8d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 11:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.2 via Frontend Transport; Mon, 21 Aug 2023 11:34:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 04:34:23 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 21 Aug
 2023 04:34:22 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 21 Aug 2023 04:34:18 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <arnd@arndb.de>, <digetx@gmail.com>, <frank.li@vivo.com>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <pdeschrijver@nvidia.com>, <petlozup@nvidia.com>,
        <pshete@nvidia.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <sumitg@nvidia.com>, <thierry.reding@gmail.com>, <windhl@126.com>
Subject: Re: [PATCH 2/6] soc/tegra: fuse: Add function to register nvmem
Date:   Mon, 21 Aug 2023 17:04:09 +0530
Message-ID: <20230821113409.4292-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZN93L/9vBdBvZMA9@smile.fi.intel.com>
References: <ZN93L/9vBdBvZMA9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|BN9PR12MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c32bd7d-03cf-408c-8736-08dba23a993f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mt1g2OtrLiv1mA0kTz2kSyIjnSmulKfmPwogA/Y6pLLIv2PZuxpqOTfTmwYmKUfxf9rTntFtH10ffDQXXL/gRdJYZpvOgOqvBo+I0rsY+3fYUy0kVLQmejOtxf2UVrOQ4dqFGkVwoR6tLxGTPw3mLGBZhvDl5eSwxzqJp//J7XhWVtddrSFv1fE5B1lvqG/4j1ww0kWOBH4PDiBpbYj65TKofN0AMcC9Besxn/pKmZ1IfXKVx0xkQP+u43GvBgZNGfvTKPFzClNWUpPnS7ps4Fu4+0E4frmF4je+Lnih0xCUIE2aHNoe0C6laPKDCKuHPALAiBQCwnuvJ7lhyMDoyX+hsCTeykCpEWKzj613JD+QWVzuKmm/k7xeB7iZig3ny687QuTk/rZ2i0QwxOnqrCFVRT1MefFzRKCvc28g1evqvtaK3ph0BdcqwetLfdz9dnGveyVjjZPpsj2K3+bMvwkBl7sTv/Yu/FrBl/fCBcASIj0NB6zkZNK18d4Mz30iMvgWZ2/qdc3toAkKvCJT+dYF7TLjXuMjJqivzTpluuEYgeIQpRNVIBIErB+7aaO/9WF/LSydq0uG0MPDXYeeax56DzV/AFI/8rUhXizQp/huKZTpXMU0vGvSOaONvD/dWBwmxlu6K7VtVIl7qnjJLqJaLmdD2WebkOA6VneUh4aEU5WWZepIchHCdy8hG1nsR+xaYFkmLE3sHpzszfNRHCMgF/8evSySuVP1JRxuzSlQwb8QL/nDn1nuZwTp1lsd
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(4744005)(40480700001)(83380400001)(5660300002)(336012)(426003)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(6916009)(70586007)(478600001)(82740400003)(356005)(6666004)(36756003)(41300700001)(40460700003)(7636003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:34:36.4531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c32bd7d-03cf-408c-8736-08dba23a993f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-18 at 16:50 +0300, Andy Shevchenko wrote:

>On Fri, Aug 18, 2023 at 03:00:24PM +0530, Kartik wrote:
>> Add helper function tegra_fuse_nvmem_register() to register
>> Tegra Fuse nvmem and use it in tegra_fuse_probe(). So, this can be
>> shared between device-tree and ACPI probe, which is to be introduced
>> later.
>
>...
>
>> +	fuse->nvmem = devm_nvmem_register(dev, &nvmem);
>> +	if (IS_ERR(fuse->nvmem)) {
>
>> +		err = PTR_ERR(fuse->nvmem);
>> +		dev_err(dev, "failed to register NVMEM device: %d\n",
>> +			err);
>> +		return err;
>
>		return dev_err_probe();
>
>> +	}
>> +
>> +	return 0;
>> +}
>
>...
>
>Seems it comes from the original code, so consider this as a suggestion for
>an additional improvement.
>
>-- 
>With Best Regards,
>Andy Shevchenko

Thanks Andy, I will update this.


Regards,
Kartik
