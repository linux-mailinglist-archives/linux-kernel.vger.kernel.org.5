Return-Path: <linux-kernel+bounces-143568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C638A3AE6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35C51C22E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230C535AC;
	Sat, 13 Apr 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TWAL/O62"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71C4D9ED;
	Sat, 13 Apr 2024 03:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980090; cv=fail; b=bxoe7nlohhByQA68d8Rima3+KSwE7iu8BYMaVxZMag44ecaVfBGvxMhre9sYju3JWtqBEG5hZOQCRSWsVVMiGPOxP81IVo8xoKKzEEN0iLpAF9PHE1XZFXq7i3DdPQSPUN1cj+Xd6Y2psD/H9+0YShqxK3Qhsb6tfAr4REna6n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980090; c=relaxed/simple;
	bh=vBCyWM2bIGMpHw4fhXWIgTNp6g8TFzcDWFc2YHHjHuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCS5zlr6BZQsmWTVi1YTYEppkFnDeqpRkpAwpcL9bKyfMgH08TBvFOwa3+EfduxcBAqeVwArcCu4/na38mk3fftM99+fTmF3p8LMPG6LLDy8Yy97pmG811WoCim/bRIhXjzg5Q2sq0mjkDipJqfQ2mrOHza5VhszYSkfQghiFX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TWAL/O62; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQkjMp7w79dtrzw75sKx+U/bHk1qLRv3uTFHuWrUZChtEFzIz91kW6VKWNvd3ENY4gAxOHC6vgmo0yGv5FfE7p+ux5OpH5oTe6OiiZKyOgvnz8ZZz8EM+66AqWtYMp/8aoDXHX4Dz6UVtlLllqCqOg/rWHw1HlsDH5MDFOINgRoI1i+EsrMgKysxPYSkuusjYRrTCoby1r5/yilaq5UY1I6RhjfraymlaXB5E3Rm2oGmJi5PRvNdqulMj56iOMqI9MRIgyc3D32Oqi3t4rY1andQ7UX9mjcGa/6TDR/tKGXVReGksXGxTJGlT/5+3ya/CqyGgGH0KeKWGI0/3HUV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J24VjpM1ZxCsMEsy15/1x3LhaVzpkdYSL1mglvL/kQE=;
 b=Aem1HF4dXh6s2ENRbRpCXQ0H21kjBUOi32278snykSr4cLBPDTghiLfdISZfe5Jx3gmX/N/daha/ndmnJmsAVLNHUNYOgX9pFz3EvRtMDNL8Yj+pg6ScCxvCfWdgV6wpufXYIFSeNo8iXKz5aZW7XTKVjA/fPuxu/BHeM2tTwOSsjts19GNk8MwHdz31+FYv8f6XMX2BFIPOtukmVMX5FvXlR1B3uFYpvz3ZcnQ8gI/xn6qeG/jr2eLBGQr8mU9iR4cCaXtG0dglxyDB5JBHTDeGf6LTlsWO/eYMCVT7tT4sZq01l6JLUDa8zN8h3dkSuXEMcEeXV3RsXG31zAoSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J24VjpM1ZxCsMEsy15/1x3LhaVzpkdYSL1mglvL/kQE=;
 b=TWAL/O626aLxfLiQpiZvniTAJKrnNmH15WAxk4ZywX4SEZH9Y4c2N4RWMde/Uwrj5a1NSDcbnD7DfGHtXB9wwB7EUwXRer/QwAr/VwZ1JGZTyCtqFml5h0hxnkUUksPuCTuAfGt2sEf7ptx8pS38cVQd0BP6FaOr5O5e9JtKDg58A1COJhHAQFomz9W8fAy6W/yjXXAjXaKaX0zbwj/Xzf46YA5OrCd6Ma08x6ieefH1wmEWN4+jLOv2pt8mfD1hr9U0MI9o+ix1pNqb99a3aPevX7g9GNGMqIcLt2UuGa0+CwcsNB4mHTqV/E2KuRez3m88jc+JtVFQHnvMlvnPzQ==
Received: from BL1PR13CA0082.namprd13.prod.outlook.com (2603:10b6:208:2b8::27)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Sat, 13 Apr
 2024 03:48:06 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::95) by BL1PR13CA0082.outlook.office365.com
 (2603:10b6:208:2b8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.8 via Frontend
 Transport; Sat, 13 Apr 2024 03:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:48:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 13/14] iommufd: Add mmap infrastructure
Date: Fri, 12 Apr 2024 20:47:10 -0700
Message-ID: <6fef9ff9944381d51dd18f83ec03785a26754dcf.1712978213.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712978212.git.nicolinc@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8471bda9-bb20-443c-b308-08dc5b6c86c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yozylR5jW2Q4L8QNgdcHUecRCu5BXI7xbTRISUBAuzfFhIg0b8ObpJuKVT3GEY58qUHoin3u4JJPDKy/bQ8wibeV66HVsW24zzVXjf9af5+NIJhipMwZcqflrI1gHxBWDINUOo32v9rY/1huHmYWNtPI9hjoQoxT3XEu8phlmwjd8aL1wSRZakNXVdDdz8FhjnmOTB5JWFL/bZqT1s3Ua/Ckd2QwEyHR6W7Wod30nxFYxAYEPNB6u1/UYIvnK7IK9mxwXU1nYsYi+jycYdXAOruxcuQewDnqbPIWStUvieMaQlJxNNJZFvJoi/7R8H0khkK5sPES0AVYToPbxaCeDJ02hb4xUrgUYUsyaJ1u6+8z30+5FhX1RCi1UP+xW02Q2fs6lxFYM5znHHLlstJHaAq6KZpu1gipIDYt3WfkmTu0DafhViPLdThMiyizQ80wn5KXLwwyAk12UyFE7pMcs6dBujH/JjQv4wSKhBwuEf9ah29zgEUSISJv+RdXxMoK6T4eUig4xRDxzjm2gdjI2tRky8EWwrlRGA6FEzOdCTkehDnGmduQoHogTCdyISW6ihvB+XWnjbTSPDWxJkAbnJeEpc0d/xBoavB8ddmv18NQpZ/RSZ5a2DE1XGeebEgBfva4FJJTxxvyI0gbL9wsXYkICoBNjZRHqR9BAcUMrk8OKZyJAcQvyShjyhGOYYh66eOD/VeB5ujRnn2fAiFeQ/JkbOLyTUsdgLU8O1N49y1UVMDMfLEcvjKZONVQNSlh
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:48:05.3722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8471bda9-bb20-443c-b308-08dc5b6c86c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956

Add for sharing the kernel page with user space. This allows to pass
through HW resource (VCMDQ MMIO pages for example) to user space VMM
and guest OS. Use vma->vm_pgoff as the carrier of a viommu_id.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/main.c | 40 ++++++++++++++++++++++++++++++++++++
 include/linux/iommufd.h      |  4 ++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 96ef81530809..5b401c80cca8 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/bug.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/iommu.h>
 #include <linux/iommufd.h>
 
 #include "io_pagetable.h"
@@ -427,11 +428,50 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 	return ret;
 }
 
+static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct iommufd_ctx *ictx = filp->private_data;
+	size_t size = vma->vm_end - vma->vm_start;
+	u32 viommu_id = (u32)vma->vm_pgoff;
+	struct iommufd_viommu *viommu;
+	unsigned long pfn;
+	int rc;
+
+	if (size > PAGE_SIZE)
+		return -EINVAL;
+
+	viommu = container_of(iommufd_get_object(ictx, viommu_id,
+						 IOMMUFD_OBJ_VIOMMU),
+			      struct iommufd_viommu, obj);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	if (!viommu->ops->get_mmap_pfn) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	pfn = viommu->ops->get_mmap_pfn(viommu, size);
+	if (!pfn) {
+		rc = -ENOMEM;
+		goto out_put_viommu;
+	}
+
+	vma->vm_pgoff = 0;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	rc = remap_pfn_range(vma, vma->vm_start, pfn, size, vma->vm_page_prot);
+out_put_viommu:
+	iommufd_put_object(ictx, &viommu->obj);
+	return rc;
+}
+
 static const struct file_operations iommufd_fops = {
 	.owner = THIS_MODULE,
 	.open = iommufd_fops_open,
 	.release = iommufd_fops_release,
 	.unlocked_ioctl = iommufd_fops_ioctl,
+	.mmap = iommufd_fops_mmap,
 };
 
 /**
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 707b6d4b20a3..4a9c6b281d35 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -104,6 +104,8 @@ struct iommufd_viommu {
  *                the include/uapi/linux/iommufd.h header.
  * @vqueue_free: Free all driver-specific parts of an iommufd_vqueue. The memory
  *               of the iommufd_vqueue will be free-ed by iommufd core
+ * @get_mmap_pfn: Return the PFN of a viommu given a finite size, for user space
+ *                to mmap the page(s).
  */
 struct iommufd_viommu_ops {
 	void (*free)(struct iommufd_viommu *viommu);
@@ -114,6 +116,8 @@ struct iommufd_viommu_ops {
 		struct iommufd_viommu *viommu,
 		const struct iommu_user_data *user_data);
 	void (*vqueue_free)(struct iommufd_vqueue *vqueue);
+	unsigned long (*get_mmap_pfn)(struct iommufd_viommu *viommu,
+				      size_t pgsize);
 };
 
 struct iommufd_vqueue {
-- 
2.43.0


