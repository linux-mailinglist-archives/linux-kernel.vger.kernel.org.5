Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE7797407
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbjIGPdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343927AbjIGPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6C1FD3;
        Thu,  7 Sep 2023 08:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7W9IaYz0n+Fi5k+ILT1wsRO3jGn2UGyfBJ7t8lDjUNnmMI1EJpgI1KgqZc/5uwmpeBuaAk362d2f6Y/VBZTpvV2B6lrjuJ/e9u5dHySk8GixxpXhDj45Q5pnMiWc2QtdUo8nRbc3H+1Bzf6u6lw9szE7mktUv5H3U0Mw7PdukBTwmllDxgkDHYLaAjPBgDWGq4gvtxBb/XhUjQ91eQJVF8kAZgLjRbiSrNX3xASwjUnKlYULOjMljWGx3dZFBqeAgbyENFHe16sKfUObb4txzpGWbilz7ZKVvyFdx83E3cf4io1ruMZLFCuoJxSMu3Y8RavpkwwDuXXOTxpw+XU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khmazL8FMs5x5kHt879GALiZFyoiqcR+DbnF6JEhzBk=;
 b=e860lL00grJMDuhr/8fd7fPp/5Y9Ym+xCrO+RctZ3CV6GqP/fWNL/8Z9Z1d/Q3Tzbukhv1h0KCdiDoUCQ/g0sUVnHF1/21xAK7c8UD2J6cAQBNElfyIGajxSJFc7cI2YthvF4kSUZQabxXU2/Es0vCTeRd7YIK7+J9o0OxeggGeKHwGA0waXu+G94Vnbmbi0dSbVotu9ZxPgKDFa+ANvF07JILDbQnZkrqtJSye5/NBsz8EOQxyyHuZ25va9Pcm1O5mryohviOhXE+sbJ0PGJN12edI+oUyeYeKSIAyBo+gqvaqJtOL3Owd9J/5mhl/HrwbWUFkDNE/yi48fCbfETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khmazL8FMs5x5kHt879GALiZFyoiqcR+DbnF6JEhzBk=;
 b=QLBFR87bkAUcjj5YDxD08yiuvVormiONTuN0/5kvtz3PcB+5w5Yylj+R0DL4FJh6l/EqHlHKszsT2yPlKRjAvcXmRlzf88cu3tTNVRS18pCwGjUnppReJ6hHLpTppxI385J1K4hvB2zrvHOquX0huugD7wsPBPKTPAy8jbk2X5Hpj6OBkqLtR/DXqajy6Zy26/gT1OKjFEw9XUvrrVlRd5VMfIRTLDAfsWRH4ru/cTir5wcv74Qz+ZwfWqQ/Wtxa9nTqpPah6JIL1ijFHOJbqn9BXukT5uC5i2WL/vkWny1NJT3D9ah507o8Pv5Rz0027IiWH0/0iVqbOQI1vzL9uA==
Received: from SA9PR11CA0025.namprd11.prod.outlook.com (2603:10b6:806:6e::30)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:11:59 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:6e:cafe::42) by SA9PR11CA0025.outlook.office365.com
 (2603:10b6:806:6e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 07:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.26 via Frontend Transport; Thu, 7 Sep 2023 07:11:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 00:11:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 7 Sep 2023 00:11:44 -0700
Received: from localhost.localdomain (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 7 Sep 2023 00:11:40 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <andriy.shevchenko@linux.intel.com>
CC:     <arnd@arndb.de>, <digetx@gmail.com>, <frank.li@vivo.com>,
        <jonathanh@nvidia.com>, <kkartik@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <pdeschrijver@nvidia.com>, <petlozup@nvidia.com>,
        <pshete@nvidia.com>, <robh@kernel.org>, <stefank@nvidia.com>,
        <sumitg@nvidia.com>, <thierry.reding@gmail.com>, <windhl@126.com>
Subject: Re: [PATCH v2 0/6] soc/tegra: fuse: Add ACPI support
Date:   Thu, 7 Sep 2023 12:41:33 +0530
Message-ID: <20230907071133.3936-1-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZPiTFXa0/D2UN1SE@smile.fi.intel.com>
References: <ZPiTFXa0/D2UN1SE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d44317-9f0c-410f-975d-08dbaf71b9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLtnNzHxUXzss6JUvgdj7wzwmDtb/1vbG9Mf2OBnRKOsn4QzYNEZt05enSHjj5h4jRcaIFhB0uiNx6VgKLii1hrWVJ18tXHqqbtiNonf3X0CrIe8aDAPFsgDaisyes9IMMHrwJrQe/uiP6TciqVP5XrrNPLPwfLJuIbYVYUEeS4VH5pGGAJcMZBg86bW1vn12acliAFLLUCVlDO0RBVDOA0l3fM7PhuAwA3bzBs6SfG/bJsZnxJyuVPpGU9OzKDsxHcS5Bz+gZgX1l7XOBnQHs2P2t7q9/1Z3bTTsvV9FNgVubj+XWbCXKB3imuCM1Ra3UjHpxoamiys8FQO6txpz61yhXMDcDr0s5R2QGCtEc0MAljsiJZ+qWkQ3zxbNrT4Fw+qJuYjlqNmvMy2tMIJK/zhPEOOmXzJ9B6L5igMvnorbApjve9MpseaTdgxQUnbTDsypujXp1T5sGq+3+T6DwY6kHyZ8m884W1YBoSIt3Xv2dLpfjyA9oL4jSzkRFppL/qeBDUMOuqou0frbqy5S/6YJlpk+d8PSlt/LvRFnbZzPvnfnKCp+vrMaqGKJLDmk5uvjt+L0ViHfeBEggziXW59vpDFW4HlrrYbfxmYUzkD6yz7jYNpSh5vIkkEoHi2BcJiwfk9rz2J6MOaxuShUQVLq0VpT6lraFQ/0bc5urEEWjsE0pAabEkWB0INQ6jt/gw+Yvlwlurw1QhpI2ipqceN+ePPslZWRdh48nkXIp4ov2gnFraMJiOT2cp93hKP
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(36756003)(316002)(2906002)(41300700001)(4744005)(40460700003)(82740400003)(86362001)(40480700001)(356005)(5660300002)(7636003)(2616005)(36860700001)(426003)(8936002)(4326008)(8676002)(47076005)(26005)(1076003)(336012)(6666004)(54906003)(478600001)(70206006)(70586007)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:11:58.7983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d44317-9f0c-410f-975d-08dbaf71b9f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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

On Wed, 2023-09-06 at 17:56 +0300, Andy Shevchenko wrote:
>On Tue, Sep 05, 2023 at 06:28:18PM +0530, Kartik wrote:
>> This series of patches add ACPI support for Tegra194 and Tegra234 in
>> Tegra fuse and apbmisc drivers. It also adds support for Tegra241
>> which uses ACPI boot.
>
>Neither here, nor in the individual patches I do _not_ see the changelog.
>What's going on?
>
>--
>With Best Regards,
>Andy Shevchenko

Apologies for the confusion. I've posted v3 of this series with changelogs.

Regards,
Kartik
