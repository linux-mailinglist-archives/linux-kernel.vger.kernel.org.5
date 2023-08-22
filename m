Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6EE7847E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjHVQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjHVQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:42:42 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E7184
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYmKGdMDP+QSqObSsMS/8G23yi4iqHlZWJPo0tw0S4xJW8gtJY9WqY0o0TWoo8E4cuKcBi9z0eXPpsJWqQ3tvv/GSEnwolcFMwtfvc6i7eKJ87Z5DmdNVZziy5146XkbVR/ATV13oeClqQQCwkdWDg9Rhf4jpm3NaNP5z0ugXWJQGws8FMYY0rEquwtuazmMpON02twlTGCHmBynEgdIAJNq/z6Ww4uKnkSNbgQO6qoxMcaVOphzKxk1aOh0NGDSmxfJ1Au02O878gV9kEri4fhbBnAUiMuNUfdDAkd63cjPGL18Dyhz38cImyqsIWPnsCMkaWm9IYQiqlChuEGWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJQKxnLxcC//oL9DEtfa2OZNdWtL3xoBNGgf9sNMvMg=;
 b=cnixjP7sLskoGXJyDC/JT/tijmiCn1r8VCpX8lz72RutgzYrYerhwdU24r6i1ERA6ZEYPKPySpqb57b8bQtSslqORpyWGjoLKym8cklJ2QcIgYszJz2ZzTAopW1U51LvSVZX/x6f1ml051UZRxKWtuDEtJX47KMkismEXXlkAXor5Ke/wvEc1jfXBJ3I6hovcT+msrcp44Ff/gzIz4zP162VMTWifILnBxFnD0OgqZ9DX5BA28RpebLjAFAR/+i6MCZfEPLFN8HwmWLadpxo8fUoTaOBZ4ME6eG2uS0qhkzpHVs6k0y3o1PpmCeBvUJrTpa+YVyyjTbzsZt6AzoXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJQKxnLxcC//oL9DEtfa2OZNdWtL3xoBNGgf9sNMvMg=;
 b=bnCXzz15ed+E6DIVk9s27hkLfKgnRuXlbSD9oudwFFCDKMESXC/8c5Nu455vQxPMkysgT8rOROqV1H3fSxKXWRbK2I7Gy6loIj558MvyOMnXnVa2OeC7dcM4wo98mz0ox+X65D2jnYbYZ07LiuTA6bGeKZyR0wJUAKd9ILGAUmSdE/qrBkOmIXkNHtvVh7z0Ype4G/DO+JWadq9sKxhNYT/siWiie9IS68Mvawip0MOOAeaTgID7iSdnwI0h6+32CouE9H0mGMRBw2h8TLM3zSQwayq5uUKocB6xFbI+wU9huFXh4uSBMdkvTh5iMvan2vQ3Azt1Nszhc5iDhvXqzg==
Received: from SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 16:42:39 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::ae) by SA9PR10CA0021.outlook.office365.com
 (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Tue, 22 Aug 2023 16:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 16:42:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 09:42:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 22 Aug
 2023 09:42:27 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 09:42:26 -0700
Date:   Tue, 22 Aug 2023 09:42:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <jgg@nvidia.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: adf08785-83b3-44c1-6326-08dba32ecc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZ31wwFD/XQnf+Dehd4apqcrAxgOH8ygHUftwRfAs7BEMNqDPnor4LaDJO/cCwzdVsHpeLfCWYO6nvG/GasnjLTs49YAeYpjJI9MlBozN4Tiw1FlQIpLHtEdv09LJk1Av8k/xOqe4VzYn8R1rG4A+xFnq0DB1PKshOVxuyhNW1C1dWL5oFXrwlBxWcmaYd9oAKmmgJvdYutn3sZ07To6ZCXhkpTjGGG+3eJpDWvEDiX5xGt1ovjcsoAFqDVXAWtoJBHMVOh/ZLgD1WC9BudYMvke+lkw3UCsWpBrjAqhSp4CNay0N92wW8QrzslmtoaHKvrfHFkW068DtfFcA35FpJS3lklLBRZEs4EWWQ1wni/1yT2iaoaH9sqTiJW5g1UhxlZPIZphiSYi/tERakik5WkALJ4F5rhIy6pDM3Fkw2YR9wXmhW4J1SqGTClft6STnpChDaCdeOLYrEb9ZJbiWLxVSEH5evIVfK16j+knZ/OKJ+Wt3+Y8OC6pHBhAMAIbvuYmYCm8PHuU9aSbKs89JYNrObQuMY+TsWZUU1IU8bZ7g1n4vb7QbKFTGDR/lylqlyRB2h8oE9uSoO3JQmPv/VdLmE9ZhT627/1ffCOB/kQe34AzPC8U/VFfIlkZzpO0CNh/OnCMLrMWlPeWW1W+hSjL8u0k4PCBZe4HFLDX2cwxYCyx0yYCF2G/GMBei2F+2Gb9ZHOLnkeG7uZb2ZNDHw6iesttVjGXfOErbbxoh2Ha57PZ23xl1xgmjPPQ9jLc
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(6916009)(9686003)(70586007)(316002)(70206006)(8676002)(8936002)(4326008)(33716001)(7636003)(40460700003)(41300700001)(356005)(82740400003)(478600001)(55016003)(40480700001)(83380400001)(4744005)(2906002)(47076005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 16:42:39.1066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf08785-83b3-44c1-6326-08dba32ecc2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:19:21AM +0100, Robin Murphy wrote:

> >   out_free_data:
> > @@ -1071,6 +1073,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> >                                         ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
> >       if (cfg->coherent_walk)
> >               cfg->arm_mali_lpae_cfg.transtab |= ARM_MALI_LPAE_TTBR_SHARE_OUTER;
> > +     cfg->nents_per_pgtable = 1 << data->bits_per_level;
> 
> The result of this highly complex and expensive calculation is clearly
> redundant with the existing bits_per_level field, so why do we need to
> waste space storing when the driver could simply use bits_per_level?

bits_per_level is in the private struct arm_lpae_io_pgtable, while
drivers can only access struct io_pgtable_cfg. Are you suggesting
to move bits_per_level out of the private struct arm_lpae_io_pgtable
to the public struct io_pgtable_cfg?

Or am I missing another bits_per_level?

Thanks
Nicolin
