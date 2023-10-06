Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB947BB2D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjJFIIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjJFIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:08:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935DBCA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igaYtZ7vx0m6yI+7STWPhBEZ097Pqd+bgsCW933pL4tOkw1aow6IWwYaA79PjntrNFiRjpkH0bGsFTkYrQ20YMV7ha+XOSIAbsLhiobgSr05wVHx7a0HcpRS22sU3US6mXxV/kdWQWiLdkHPUM4nu41fYe1/Rx9ra4SkxRsD74psdOzpAhsE5qUv91OzLSiQU+y5g4sHEB8KUYQtqMy2MfdMf3QobqzT+mkMXG7NWgQ2+wiVSkq2PZS3maqV2pkO5QLxxJbMh76iks5ZjiG8ogPyiarZNEkRvkYfxfuve6eu/Db07P/0tN9Q6DxYqYsM+mAHSTGBucKjvpEBLfq4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3t6owkzQNtSllX+rIeO4Isg2iDU5UsGvZyfHdwIK1Y=;
 b=QXHXqV68Q+2OtvkijOUBoWXfwSjyQbHwXWixGxe5cdNRdabpVIVBV5uadv6Bte/NETuidWtX7oeATGmZxTWDO9VisVdk/mbPii4dXMVXzRRlqol5sfrt5O55RDpsqB0ZtOlXombGWnX+B0ZJj8jEiWrjlMpO4dQEebv5L3MQDtdmIrhYWO7vLVy8o50zVYRNH8VM8vvHKi5CDMwukrdvDZu8euXzgr7G4WTOD6Fnlu3DmgZWWzWzYx4CeHuC/Oh9Izy366NwooIjb2twaCw8AGddqMVUXknbmylTxjnyJga4fLPVeMWOKFSTKac4y8ogWl+4ux+thf/z7pvLLw57tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3t6owkzQNtSllX+rIeO4Isg2iDU5UsGvZyfHdwIK1Y=;
 b=SOzfuaCrl+cCYG+Sil8EUyjeHvq4zj0LQ30CitBjRYlWfY2SBRbMhAdNqqNw06kR3eYlUB1p314Y236ybrS1w5fuhIr7rvk9zQVVJ58eYy8i9i/2oCXnWSNO92w5LQtZHd6JyLUdyUGNpiLskKMkalqqBN2cPXSriDg5TVSg8uFk0hu8sbgF2BLE6rJf+lmdGFhHORKvyjBVFr2wvt8GaZZefgcWJEbxCexdq9zrTPztDsNS4RgcB6RnGfN2L0hB0RzB8TWFJ+BfS/6PRoqCoQB+3USnDE80s8xfFxRKw6kKoN5sYvOWJY+E8YSoIpspjq7FhYlR/mSAwr7CtCauAA==
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 08:07:56 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::b7) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Fri, 6 Oct 2023 08:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 08:07:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 01:07:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 6 Oct 2023 01:07:45 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 6 Oct 2023 01:07:45 -0700
Date:   Fri, 6 Oct 2023 01:07:43 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Tina Zhang <tina.zhang@intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        "Vasant Hegde" <vasant.hegde@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/6] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZR/ATxpIfCPRJO6r@Asurada-Nvidia>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-6-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-6-tina.zhang@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 284e342a-6f45-4597-6f40-08dbc64358c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq6YTs0pqwHEKNKIDp4T9ZU0Jz/yh/Xt3rmUO41CW+2w4DJAP145LkJbYrBWU+q28fyLUZikg8iih8OoV4Kye1xCtWF5jibhXnBoUac/LcE27W3tXQXXp3O4znkSSCd21lTL8C7RjbBylPhEuLIcPPnwTbJNVFpMaKKRmvwoF2bH07poi5vVTqYfogDSRBpRJiYFNXOosO77HD/txfC+BuWD6ci5NM0QnXR31YuUe1vhwfrOkQHAAJ5xpuDXac1o/vIOwZY2O/9mALnlI9fKfM81p8IC+r0L6Z0piNju4J1dlkgAx6dKz8kPpZrzjcIc2o43vuelRpcaydXGp3Wer4C3iG8zSddlpjU8d2IrkcwQGESSL9FypVzIRscJvkJHzPjfMaK+lkdruW5QUo6Ow6RkWYVk2KR6Rb6E/xONrErDxfDt/C/sKAVy7ScK23i69u/azkKINxThtZ8SBzWoMS2Jqf9aWMr2H40ThzOlCljBgaLw3pgKCU5KDaQqPhi0lwu7p5Vh16OxgeUjILR0qxBdkpSSDfWapSSp+1vKjw8iSWudaFLIFJe51iLpJsJsIF22AcY9FS9iudmLJgBsid2PdJcD/km22bhfYUGsa99LSk1Xb0jIdvn2AqW+DGpeKXAYf7ws8MIND6+esEY9Z3qU4W/v9w0r0Mnm3lvtcsfvKQ0SZVBOr+F+MCcEbnU6tF4hXGThR1CwEM3HBybF7baAxQFi7rLt3Y0H4Pm6jREwWVFb34s9Nn3R3DcQAzsH
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(55016003)(40480700001)(4326008)(8676002)(8936002)(5660300002)(41300700001)(86362001)(33716001)(6916009)(316002)(47076005)(70206006)(70586007)(478600001)(9686003)(54906003)(336012)(426003)(36860700001)(356005)(7636003)(83380400001)(26005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 08:07:55.6627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 284e342a-6f45-4597-6f40-08dbc64358c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tina,

On Sun, Sep 24, 2023 at 07:38:12PM -0700, Tina Zhang wrote:

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

> @@ -128,8 +142,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>         struct device *dev = handle->dev;
> 
>         mutex_lock(&iommu_sva_lock);
> +       iommu_detach_device_pasid(domain, dev, pasid);
>         if (--domain->users == 0) {
> -               iommu_detach_device_pasid(domain, dev, pasid);
> +               list_del(&domain->next);
>                 iommu_domain_free(domain);
>         }
>         mutex_unlock(&iommu_sva_lock);
> @@ -209,4 +224,5 @@ void mm_pasid_drop(struct mm_struct *mm)
>                 return;
> 
>         iommu_free_global_pasid(mm_get_pasid(mm));
> +       kfree(mm->iommu_mm);

I ran some SVA tests by applying this series on top of my local
SMMUv3 tree, though it is not exactly a vanilla mainline tree.
And I see a WARN_ON introduced by this patch (did git-bisect):

[  364.237319] ------------[ cut here ]------------
[  364.237328] ida_free called for id=12 which is not allocated.
[  364.237346] WARNING: CPU: 2 PID: 11003 at lib/idr.c:525 ida_free+0x10c/0x1d0
....
[  364.237415] pc : ida_free+0x10c/0x1d0
[  364.237416] lr : ida_free+0x10c/0x1d0
....
[  364.237439] Call trace:
[  364.237440]  ida_free+0x10c/0x1d0
[  364.237442]  iommu_free_global_pasid+0x30/0x50
[  364.237449]  mm_pasid_drop+0x44/0x70
[  364.237452]  __mmdrop+0xf4/0x210
[  364.237457]  finish_task_switch.isra.0+0x238/0x2e8
[  364.237460]  schedule_tail+0x1c/0x1b8
[  364.237462]  ret_from_fork+0x4/0x20
[  364.237466] irq event stamp: 0
[  364.237467] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  364.237470] hardirqs last disabled at (0): [<ffffc0c16022e558>] copy_process+0x770/0x1c78
[  364.237473] softirqs last  enabled at (0): [<ffffc0c16022e558>] copy_process+0x770/0x1c78
[  364.237475] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  364.237476] ---[ end trace 0000000000000000 ]---

I haven't traced it closely to see what's wrong, due to some other
tasks. Yet, if you have some idea about this or something that you
want me to try, let me know.

Thanks
Nicolin
