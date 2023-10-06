Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30A77BBE58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjJFSGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjJFSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:06:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA452BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hns77BZgXmFK7PEppC14CKmbOkkvfmf08O1Qbd6A6Xjj8PQr3uUcGlLZ5SXI1yxgvw4hq7Ljdd1Su7nsdDW4x7+GStSmpjaSFOFEuKs3oKj+5zp21GYRzD3aNmaDC+BQ8xTkYsmDYHZ4c3hVrwkQcqNcxyYFBXRwkvp9fqsh1DJ3UYbBRRlrgMYoyy7VZiwTYGfZv+iGgjtfA7HrGdrJcneiiGeDxcyq1OXydC0Mzl1Fn+CCp9DmtwNz3dCHZSZq2G0fIfwX80xcbmrYDkOcqb2jjC4qxQuf5JtyK/34ybfhys1VIAol2cKIKfWDlvbFmLv6jP9h5NQhAD5WqouitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FB82+WOPvCPIr0elolHCSVCYbVHkzFZnNf+Hf1BZCzU=;
 b=VLzNFPMS2bsutu4q/lsoQDElBjaHyciqsFgJ1vgkQu10xguj2xRvYKYNBIpgYWuWchkdeY0zATubctdU3e3hjehc6lKFDMQZRmHFHmrJMyz0fimGBPbN71v18/ilx9XaAql4azrU4FcqOIGGLFlNV4r093L8DCOi31aMgA9gLdyKlmC5Mn5Zj5RBtXcMNWBBjsJtfURH66Nn6loQikkUbFIMS4/c8u2imPDPalLKilxUvxYGra/xIq2NKdcswzEwZgyx/LK4QR2I6WgP4NUGWCfaTQnMRP+vhCqa+O6VNE9ZhOOGFyMLaspE+b/esv+B0MKmeiADdOf2BBNbOPnGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB82+WOPvCPIr0elolHCSVCYbVHkzFZnNf+Hf1BZCzU=;
 b=sNXHToIJZTVSzo3m5pdu2Sy6LK8KPaZhUKu6SCzU/ZUvUfBz3b4vetR/5PEpjcaFpcWoIWBqXZMiYmPAitj7fZvqREPIa29hSUvJWLxyVd1Mt6hjASgAlA2lyZ6/vLAt9DuwSow2OHDpzK9h4ySrAv6KsSW76xWNoqPto+JkGfE9Wf6+azy2IRNXiMrCTYR9Sl5387zHn76oKYkHUyaG1Lsy7B8vyh4SpMhsxxcDy1RwL+cTvTR8iSbOKP4EnvzCIVpg4KQT3+V9LPWCK3BmAJPv3kzZq2MdP8R9BRdeoTR37E5qA9V2pVffjhMrUskSnSYetZQ3sPfIVovFUb6VhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Fri, 6 Oct
 2023 18:06:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 18:06:09 +0000
Date:   Fri, 6 Oct 2023 15:06:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
Message-ID: <20231006180607.GA1140589@nvidia.com>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-6-tina.zhang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-6-tina.zhang@intel.com>
X-ClientProxiedBy: MN2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:208:a8::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8b688e-a27e-4c94-4ab1-08dbc696ea8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xc5FKSht8zNN7uYGhGEmtLjjCQs8cZmG4m1M4/uL3600Wca3crhgPHeLYY6Oqe5+/Lvvn/TUC+pOnVe7VeiyEFxgl4zoEcI5o16lY+4CpoMX68sq1OcHfx0Q/g+Es+rR3FsEvLAq8BJ8vRslTevpL11hdbop/HhL6xwnXDZZX9ZhhnU9nEI79G36jlxuTkOurv1JoQQi13xJwbfbY2ic2y0tnYlMGNSY609A2XLbgUJI7kMrZUgOJ6bmbM8Ty+Ta2up7rGWXzghlamtCjLLEE0ynO1iB5QwGrCD1NjOU7EyJFCZ0EJKS4mxNbK+FXfqA5f9/+vH8/qNLdSEAoUZqN/noD4Etbcu7xj9OrDT/QRCSTGHD8lfCGOONAQQWXapaApo+0BZ1SoL586bTu2qAx9ggXfS83ReFcjroIg3ORg6IVNJtrq/kC5gKYf8dhMhku7+o8XkxLJpL0x5LSMKsveKn+BuNWjyHmnWWQ3UjCjrG58CtjL31m2Z/lRdsXOdj8AaNqmFa7Xrh5kJz8JKKemQUdkl/ELxfDAFxvG5xAw2+bPCkxE6W16lswW2hCN7g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(6512007)(4326008)(8676002)(54906003)(66556008)(41300700001)(8936002)(36756003)(6916009)(5660300002)(316002)(478600001)(6506007)(86362001)(38100700002)(2616005)(66946007)(1076003)(33656002)(83380400001)(6486002)(66476007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZWjV9glG1FiIIQH3N9zi1h/9OvXs5FqqCXVszEYch6bBnmE5vmQM+rlJcjUT?=
 =?us-ascii?Q?kf5AqHkhx7X4gY2mHnZFZMsxgMd9x3+2F2/e3H/PM52j2QUNBsepa5nmn0Ku?=
 =?us-ascii?Q?QwK5NINjWPm/qYLMeZzM3FhzKPbJPM3pCPymRd0LKF2HnzRCqz1eQTx3kSb1?=
 =?us-ascii?Q?Oziz5tgu2y4BjBIUrrGib1sLU4ogJhGcg7ShbYbz2lN9NeN8OXklpqbXXlFg?=
 =?us-ascii?Q?ANqApkLhkyU3jMTzT7wnpbuNpTt/yF6ToqubhNVeDgya3Hyx1o6zXBQ08qYC?=
 =?us-ascii?Q?kOnYoMdfQquB+TyuTXZmZoL+p5+d23oRgbGJZmy+hUL2efZp1b7re81Jxjmu?=
 =?us-ascii?Q?zsdzBB1iQ4+vlN1lAnVHNyQnJlf9u6ncQ1UBpbNMnjSjdcfQZXcUcxX3kj66?=
 =?us-ascii?Q?JBzsk4xCVnx4Gnn6HLmK/5WcJRhPaSpoI8hw/lic8g2r1SiYXyIqznu8sna6?=
 =?us-ascii?Q?WQRDtvcY1OAtCIa2S5/I0Xq6wlnR2Dk236SWqTHTUWFxQHdf07vgm0Apfpp/?=
 =?us-ascii?Q?8nHEEfj/uIlAnPqe0l0pSOZsORP2zVZg5kIrnLtjdmSNRPzFyaP1ZYo1jJ4o?=
 =?us-ascii?Q?VJ64mICnAHJQa/p57ThumSlUPF4chLCF5gJ0aIhdsyYQwIk4lgv/HWoAh8BN?=
 =?us-ascii?Q?Qn/+xASzW5X1EfCIRNNDoGosnPjnZiiEQJRae9jK/XKCSVxzDE6QFmUgFAYH?=
 =?us-ascii?Q?vZKaU+4FOHSyUT1jkJ8RD5aXnFMX+SJmO538mC6IEKmxtq7v0HclaUP8kzaL?=
 =?us-ascii?Q?lYu9ADF69dET+YGx58TyDlN9X9RlPf/sqW0EYSpx68w/ntDIKA3L0Hz3rT/i?=
 =?us-ascii?Q?6Fm3hPnlSuWauGHQLLI/51hqtZ7TRbvE57zIuCA2yx75sRbMsRqoXMkjDxCh?=
 =?us-ascii?Q?J9jXXPwhpVA1t4VAURW5ccb+5ncx/B07yqDnDF6/t+6ZXnbqWxawurXE9LIU?=
 =?us-ascii?Q?oox0gNQvxilXI79aartRgahpb2uG6RvIEjd32U9q4qIw1KZwLk/vvoph4bo6?=
 =?us-ascii?Q?50ZuefsK75Gto2Dog+9QCj8NuyZVrsLA41CJjPw1025fCmOH4ROieK9uZhmP?=
 =?us-ascii?Q?qMvoORoxFJFbRzW+UQbndGLtIX5NjUDKyOCgSUkJIjv9uk5e7nVqj6zXetMn?=
 =?us-ascii?Q?I3yrEZDeo5lggfNsryZ7By9poAf++pk+UhJfvHnSSjHXfWROAY/ZjN9bSb+Y?=
 =?us-ascii?Q?ZLERLZDpNnMDZu0rkRLMWaSIT7vdmDvkH+AushDqkKg+xqHrOn33Z2G62Ulf?=
 =?us-ascii?Q?7ZAOdfsg6qlTUxEzNtNenhb/3g73C5cl2Lvhhjh06R3pEBXPqhDhzCsvypzd?=
 =?us-ascii?Q?WTHOMCFwTvBZyk8B+wdei9dROrxxdQOzwlUVxPwEPgktYSMUk0N83SNHpFGS?=
 =?us-ascii?Q?tM2wqM4PAxCiA/6qVlwiHLB8t103asga9PqMPBwK/+a//fA9Rt5T7iFmLHJh?=
 =?us-ascii?Q?EB+xNyq3LsQKOVUAxnWNMlkcDSEtj/CSxkJ6HfWCFcHosrgqwnHITdhSWh1+?=
 =?us-ascii?Q?pt521sJlpdH51bPCcgn0zPVDHMjWl8o82/MyTQGpNaC1URkPvoiI1cpz0oT1?=
 =?us-ascii?Q?uiJAUuE5sB0VE+5VSBMKy2VZgKGv3teYxa3OkqGk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8b688e-a27e-4c94-4ab1-08dbc696ea8f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:06:08.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1C6EUkBvwfMQsa6jtZenVTLrgCsZ1XsoYyW88FnRA0HkIujobRJ8OJ+0zozd42Or
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:38:12AM +0800, Tina Zhang wrote:
> Each mm bound to devices gets a PASID and corresponding sva domains
> allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
> field of the mm. The PASID is released in __mmdrop(), while a sva domain
> is released when no one is using it (the reference count is decremented
> in iommu_sva_unbind_device()). However, although sva domains and their
> PASID are separate objects such that their own life cycles could be
> handled independently, an enqcmd use case may require releasing the
> PASID in releasing the mm (i.e., once a PASID is allocated for a mm, it
> will be permanently used by the mm and won't be released until the end
> of mm) and only allows to drop the PASID after the sva domains are
> released. To this end, mmgrab() is called in iommu_sva_domain_alloc() to
> increment the mm reference count and mmdrop() is invoked in
> iommu_domain_free() to decrement the mm reference count.
> 
> Since the required info of PASID and sva domains is kept in struct
> iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
> field in mm struct. The sva domain list is protected by iommu_sva_lock.
> 
> Besides, this patch removes mm_pasid_init(), as with the introduced
> iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
> 
> Change in v5:
> - Use smp_store_release() & READ_ONCE() in storing and loading mm's
>   pasid value.
> 
> Change in v4:
> - Rebase to v6.6-rc1.
> 
>  drivers/iommu/iommu-sva.c | 40 +++++++++++++++++++++++++++------------
>  include/linux/iommu.h     | 18 +++++++++++-------
>  kernel/fork.c             |  1 -
>  3 files changed, 39 insertions(+), 20 deletions(-)

I was wondering what Nicolin's issue was, didn't see anything.

But I think you should incorporate this into the patch.

And there is a straightforward way to move the global lock into the
iommu_mm_data that we can explore later.

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b2c1db1ae385b0..e712554ea3656f 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -12,34 +12,33 @@
 static DEFINE_MUTEX(iommu_sva_lock);
 
 /* Allocate a PASID for the mm within range (inclusive) */
-static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
+static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm,
+						 struct device *dev)
 {
-	ioasid_t pasid;
 	struct iommu_mm_data *iommu_mm;
-	int ret = 0;
+	ioasid_t pasid;
+
+	lockdep_assert_held(&iommu_sva_lock);
 
 	if (!arch_pgtable_dma_compat(mm))
-		return -EBUSY;
+		return ERR_PTR(-EBUSY);
 
-	mutex_lock(&iommu_sva_lock);
+	iommu_mm = mm->iommu_mm;
 	/* Is a PASID already associated with this mm? */
-	if (mm_valid_pasid(mm)) {
-		if (mm_get_pasid(mm) >= dev->iommu->max_pasids)
-			ret = -EOVERFLOW;
-		goto out;
+	if (iommu_mm) {
+		if (iommu_mm->pasid >= dev->iommu->max_pasids)
+			return ERR_PTR(-EOVERFLOW);
+		return iommu_mm;
 	}
 
 	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
-	if (!iommu_mm) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!iommu_mm)
+		return ERR_PTR(-ENOMEM);
 
 	pasid = iommu_alloc_global_pasid(dev);
 	if (pasid == IOMMU_PASID_INVALID) {
 		kfree(iommu_mm);
-		ret = -ENOSPC;
-		goto out;
+		return ERR_PTR(-ENOSPC);
 	}
 	iommu_mm->pasid = pasid;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
@@ -49,11 +48,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
 	 * valid iommu_mm with uninitialized values.
 	 */
 	smp_store_release(&mm->iommu_mm, iommu_mm);
-
-	ret = 0;
-out:
-	mutex_unlock(&iommu_sva_lock);
-	return ret;
+	return iommu_mm;
 }
 
 /**
@@ -74,23 +69,29 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
  */
 struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
+	struct iommu_mm_data *iommu_mm;
 	struct iommu_domain *domain;
 	struct iommu_sva *handle;
 	int ret;
 
+	mutex_lock(&iommu_sva_lock);
+
 	/* Allocate mm->pasid if necessary. */
-	ret = iommu_sva_alloc_pasid(mm, dev);
-	if (ret)
-		return ERR_PTR(ret);
+	iommu_mm = iommu_alloc_mm_data(mm, dev);
+	if (IS_ERR(iommu_mm)) {
+		ret = PTR_ERR(iommu_mm);
+		goto out_unlock;
+	}
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return ERR_PTR(-ENOMEM);
+	if (!handle) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
 
-	mutex_lock(&iommu_sva_lock);
 	/* Search for an existing domain. */
 	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
-		ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
+		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
 		if (!ret) {
 			domain->users++;
 			goto out;
@@ -104,7 +105,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
+	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
@@ -119,10 +120,9 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 out_free_domain:
 	iommu_domain_free(domain);
+	kfree(handle);
 out_unlock:
 	mutex_unlock(&iommu_sva_lock);
-	kfree(handle);
-
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
@@ -220,9 +220,11 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 
 void mm_pasid_drop(struct mm_struct *mm)
 {
-	if (likely(!mm_valid_pasid(mm)))
+	struct iommu_mm_data *iommu_mm = mm->iommu_mm;
+
+	if (!iommu_mm)
 		return;
 
-	iommu_free_global_pasid(mm_get_pasid(mm));
-	kfree(mm->iommu_mm);
+	iommu_free_global_pasid(iommu_mm->pasid);
+	kfree(iommu_mm);
 }

