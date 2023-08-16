Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E56577ED40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346965AbjHPWhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347005AbjHPWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:37:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AA61B2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJq2u8/nq0JnBDEplkAkltTdAIj7VsOEthovJe0ZL/w4aH+NUR27bK5iKAF48EppkZy1NjlCGQBCA1p1YppPbEE8nqE9RjoHWrbVV2hutu8IGczFKNDrnK82UWx7D772HMAgAE3yLgPAnKgRsJWBqcWPQ50TfdxsTFRMs/4M+mUHV+JZWyG52yRlaKanpP35i9/2kwFCbHFGsSi7nH03TtzpOh+GWGUDIdWdGGLzgfgm7JSoWGCFBqmRKnGMS0O2Ta8SvAPf+vB15e/KgQV7AYJM33lQQ4HHKjXyXIh1AmpjUQ5ErlBkuv/jcz3Ffu02aaXweecz8KC+2fU+QcYf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL37bXHPp8xR+9aLkUDAAAkv2580g7eDI9iiN5PH/7A=;
 b=eg7jpvbGCG4IBloAIAcjm6HFjo+0aJeO1mkaSaxprYWezIbr6GkBMNH56M5boACnRGeNXWvowx3KWNOS2D18S6yiQdOavbVXuesdWbNID1H3c5Itz8sJ+6g84g7TXW1aCr5uW1InwnfgVseCXhRuBMJY2RjgpB2tMOFIlIyVDGF6iZAbEkZtmTUpXkgTMDhXyzpgdDyf0UpFWcP2wn+dox835ev+cCYaPBUxKbiOwo8+aYI3dUaqdoHpU58UkZWvKyOZs9oYDdST7QQw89YLpjAFMBHZriHz/QSG2yHfWnWrIbh6UPW+pE+cwYpHCaLlm+kJhT8BEbxq8S3lJXe5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL37bXHPp8xR+9aLkUDAAAkv2580g7eDI9iiN5PH/7A=;
 b=fFTWrtpGZ2zK+bJgYGdFpSbZr4QJymw0Xpm8KVrzGgQ50W9JsMI5LTf3SABZBqsZ4p1ae57gsy7GCBB7A2ndGzGcTKIkqGmPbvOG/bvIcfCSFeQnMtuF2frz+j/7IUlngPP15ydzZpoF0jQE2by+4HipExyOLBVWQBJqNtsBl7NN7i9JJ1PCSaxuVmz289mYK5A3aFUcedV18IwTchhGYJmkGz2oT79Fx+2YWw/euVHtCAMmZ55qQBUqCl+FBE8TtdaXUvTV7bv1/dFEAvd4gvp+7P3fJoAMWT42bxb+8uLkJC/l6Gv0Mzum23Jf9RJaosEAsOI+4TWK9O8o+wrrJg==
Received: from CH2PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:4e::31)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 22:37:14 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::b7) by CH2PR02CA0021.outlook.office365.com
 (2603:10b6:610:4e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 22:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.6 via Frontend Transport; Wed, 16 Aug 2023 22:37:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 15:37:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 15:37:00 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 15:36:59 -0700
Date:   Wed, 16 Aug 2023 15:36:58 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
        <will@kernel.org>, <jean-philippe@linaro.org>, <jgg@nvidia.com>
Subject: Re: [PATCH v6 05/10] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <ZN1Piqq8EpwOy2e6@Asurada-Nvidia>
References: <20230816131925.2521220-1-mshavit@google.com>
 <20230816211849.v6.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816211849.v6.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: e5954fe7-fc3e-4fdb-5eb4-08db9ea95650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEWhzYJgrGqpbQHDsY2zEebUcnICkyeLguu+k1rq61tvQqM91Squ6nepgsHAli1IddYVYnq7Qpc86BWsTC94eTzsoypY0aJrJmA9D/pqE6tmIi/ez6Oi2JNgwv/Ms3ZTYH52BcFRWdRrgN0LUDs9VZgcjhH0Y/w27gcOcfTMO94w8sMHdlwCOvQ6idQlmcJ80SpqWIK5b8oyLmBYE44ZcRanSrZhGRV/h2HlN/03+Dzf75FYR5ja+pyIEDb4bAaIGM8vlOTknT1TN7MLiw1BHfnW8C4RalfQxjmsHMKTMcebSmUYL9nqF5Bga/ROLcBSGZW52ib7SrSHONMwQubmZZybtkHo0epK18DqKZ++sGIyNt+sBpOi9EiXPXZvT21yPETQx8vHbM2NLWpro8InAv2zOk+/kbPRo6+1Yzxyf4EVjeTf1rMFq/P8xuJyYI9aGJRGX/gLvut1OhXRlUD6OWpIzEA4dgAJDQA0ve9bzwWSe51p7lXb7yth5jPBRssUqeYAvsWfhJmteD+vZ2EcCkqB5taFjeCrRSZVfeco5xoVyYT/BDoVIuya9d3f+5eCdY0GQHLJaz4XbOZEwvtVq3+y75QhJPmKfv+pj3iubmMaOKQVp+cRHxL8+EuvdgNCL+ixkw9essufvwrlenr2s1nUzKVbNq+PtLB/QsnuuMsGd5IFGCbMhVvxxjohMgdoa43fO+K8IPOEJSpsCWy7/Vwg+OE08vJgDHPhG2XuvKdtoJWB8PGdujyvVnlB4Lmi
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(66899024)(26005)(86362001)(40480700001)(478600001)(426003)(336012)(107886003)(9686003)(55016003)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(7636003)(70206006)(70586007)(6916009)(8676002)(4326008)(8936002)(33716001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 22:37:13.6888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5954fe7-fc3e-4fdb-5eb4-08db9ea95650
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:18:45PM +0800, Michael Shavit wrote:
 
> +/*
> + * Write the CD to the CD tables for all masters that this domain is attached
> + * to. Note that this is used to update the non-pasid CD entry when SVA takes
> + * over an existing ASID, as well as to write new pasid CD entries when
> + * attaching an SVA domain (although the domain passed as the parameter is the
> + * RID domain that this domain is mapped to).
> + */
> +static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,

Iterating the entire device list of a domain looks like the
arm_smmu_atc_inv_domain(). So it feels to me that it could be
called arm_smmu_write_ctx_desc_domain()? Not a critical thing
though..

> +                                          int ssid,
> +                                          struct arm_smmu_ctx_desc *cd)
> +{
> +       struct arm_smmu_master *master;
> +       unsigned long flags;
> +       int ret;
> +
> +       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +       list_for_each_entry(master, &smmu_domain->devices, domain_head) {
> +               ret = arm_smmu_write_ctx_desc(master, ssid, cd);
> +               if (ret) {
> +                       list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain_head)
> +                               arm_smmu_write_ctx_desc(master, ssid, NULL);
                                                                        ^
Here it always reverts back to NULL, which isn't ideal since
an CD entry could be something valid other than NULL prior to
this function call. IIUIC the conversation in v5, we'd need
another SVA series to clean up domain sharing, so this would
be cleaned up too after that? If so, perhaps we could note it
down in the comments above too.

> @@ -2458,8 +2446,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>                 ret = -EINVAL;
>                 goto out_unlock;
>         } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> -                  smmu_domain->cd_table.stall_enabled !=
> -                          master->stall_enabled) {
> +                  smmu_domain->cd_table.stall_enabled != master->stall_enabled) {
>                 ret = -EINVAL;
>                 goto out_unlock;

This doesn't seem to be a related change? Probably should be in
one of the previous patches, or just dropped.

Thanks
Nicolin
