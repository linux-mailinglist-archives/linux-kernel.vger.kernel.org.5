Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380327F3F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjKVID1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjKVIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:03:24 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000089D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:03:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9vgADmLtBJog7Vyh4oZR4cIiU2MjddS4elldFMDIgbLrI9STfVUd5LMOpFBRE2LVkd8vGdhV31ShADNWhz8hjKqZdl18Ie6PB7tj5ZoC9z93fGuNDWnFo8HCzAPp2MlPtiBvoDc8/1bduwiZ3MdWtLB5zKpCheW96KcNfjsG1qVVv+5fcdznC+F6B+Qt5XHD71rXwYrJocEZdhGjxiYbWUVnnUylTb4pCyRNhpPDn96nLS2iPSnU+9HuiE2qq0wWipG681U+8Ra4hS1dRLjxojrFb6Z27PiignokK39z//QSlpOpD28sfjHolaJnZi5d9UneSfdjWpYP4kgfv/k0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL2w59sjEoe9KnO7WaMCfjHu9rSES9QIy7+92rYqmh0=;
 b=XoFNKIylTzwj/a/IrlJkq07L2kdoqyOD7Cmpw12wBUQXMgwoq4cRe5ZEoudtvncNCnYwUFmvZ7dZwsLNW4HJbGJdvvOKnMhfIszc5cYdM8Mwm+lqt/kdxx8Kw4cVYG7IzX1EWx/vJr64q02LvswiIJt0WOxUWojmK0GcQXb/lcktDU1lxgfIZowY+jViBbc45ZgpyLU8vA0BnrZVWzTlDpRI7z5AozWQofGy9NiykvWabc/mHBwdOCoawb+Kx7lNP0LrtoV6OowU7DTmnsgP6nM5p/Il6CdLpgp/ZV1XKt3qt5a1mqQETSUaXHIUHnG1IEFEr7X4oTbTSD5Kp/aFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL2w59sjEoe9KnO7WaMCfjHu9rSES9QIy7+92rYqmh0=;
 b=yEH35Ijus7KJx5r4xBcHmfxSnwzu1oWAIGXhKfObPoLOxNLR5k3vobK+ghbTuZA4aj6IsKNqmsUhbnL5OcVwsOoYOoG3jgY9k5b1LbM/bV8HGzh0AK6w1i3m4QaYL1JBzpH+IuOnTrfyLJ2gO0H0o1upUH8yMEJ+c8Y1AwhRt9U=
Received: from DM6PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:100::48)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 08:03:15 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::b4) by DM6PR03CA0071.outlook.office365.com
 (2603:10b6:5:100::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 08:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 08:03:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 02:03:14 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 02:03:14 -0600
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 02:03:12 -0600
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <Nipun.Gupta@amd.com>
CC:     <puneet.gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <michal.simek@amd.com>, <git@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 1/2] cdx: create sysfs bin files for cdx resources
Date:   Wed, 22 Nov 2023 13:32:59 +0530
Message-ID: <20231122080300.3727388-1-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f94668-4a3b-45d0-4b66-08dbeb317b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzPVzpp8L7X/vocpFcDTM1JRyuf9aX3DdqUV6/LUW9z9I+M5zqgOqzoWkZpC1Cw66qrBBQGQlAY+TGgBnyg9LXxjdEkSUkBe84cenOM+sT2WhntzOdGpuhe0o2gXNCpg3iloYOfFuNauS39k7407pzVqP6Y+HXSrDHXe6JHbhgLyslIQp6pay4Z57PuO86+r2doygUOHwB1LbGyRP641rSWY9DDyFodrcg/57ABx4HD8dkBS4gLpNfZ0yzhas8O9e14QfC5NjH7AZbwKNxpiimlufHgn7PAleC+nX4mTIdTNRekIe8QnzX3EbWLQCG4BE9FWZm4JNke4LEpPEc0bhoABgt47ELAQnqOWXwcCWHHFJRGyc9rO5wByy4LOA5pNUkWf/d74nMlgjLXPo+hVhNJUxe0XahExWxBYpw5GMqNBtrDO48Ie0wYs15zxdm/XNU7w/g2JaxZ/Z3AWHZJlArHh8l8r8coxzRK3bvc6qFO3A7uAIQYJof4gSo0+4+KaGtt7cLkdhPRuAVBZEeYwxMry6YT7PnMBpBrrDwJA5I4pVl8wTLXe6+dY8FmOIBHfEVdMmKPVHheMR9nb368kSsXDZ+MIoqOowz3wQx0beBTTk7X0VEIRMVSjVIs6UbKe0X/zBrACO5o7BYvAP9+H02alz8hg15k5gP1Iv65TsDkLhrHKTKl+bSDhgxDR3yrp7uOJM/MqE5S4fsIuxEZ4euLY5eSfrFWJZI7R1G89LEXoC+2Axi2Bh/PaN04BG7w0FRzGrUNqTAkfNAhsG2dNUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(356005)(336012)(70586007)(2616005)(26005)(1076003)(426003)(36860700001)(4326008)(41300700001)(70206006)(8936002)(8676002)(44832011)(47076005)(2906002)(478600001)(5660300002)(110136005)(54906003)(316002)(83380400001)(6636002)(6666004)(36756003)(81166007)(82740400003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:03:15.2735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f94668-4a3b-45d0-4b66-08dbeb317b0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resource binary file contains the content of the memory regions.
These resources<x> devices can be used to mmap the MMIO regions in
the user-space.

Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx |   7 ++
 drivers/cdx/cdx.c                       | 118 +++++++++++++++++++++++-
 include/linux/cdx/cdx_bus.h             |  10 ++
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 8c067ff99e54..e84277531414 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -98,6 +98,13 @@ Description:
 
 		  # echo 1 > /sys/bus/cdx/devices/.../remove
 
+What:		/sys/bus/cdx/devices/.../resource<N>
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		The resource binary file contains the content of the memory
+		regions. These files can be m'maped from userspace.
+
 What:		/sys/bus/cdx/devices/.../modalias
 Date:		July 2023
 Contact:	nipun.gupta@amd.com
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index c5873980a9d3..4edf64f9e98d 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -78,6 +78,8 @@ static DEFINE_MUTEX(cdx_controller_lock);
 
 static char *compat_node_name = "xlnx,versal-net-cdx";
 
+static void cdx_destroy_res_attr(struct cdx_device *cdx_dev, int num);
+
 /**
  * cdx_dev_reset - Reset a CDX device
  * @dev: CDX device
@@ -146,6 +148,7 @@ static int cdx_unregister_device(struct device *dev,
 		if (cdx_dev->enabled && cdx->ops->bus_disable)
 			cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
 	} else {
+		cdx_destroy_res_attr(cdx_dev, MAX_CDX_DEV_RESOURCES);
 		kfree(cdx_dev->driver_override);
 		cdx_dev->driver_override = NULL;
 	}
@@ -641,11 +644,105 @@ static void cdx_device_release(struct device *dev)
 	kfree(cdx_dev);
 }
 
+static const struct vm_operations_struct cdx_phys_vm_ops = {
+#ifdef CONFIG_HAVE_IOREMAP_PROT
+	.access = generic_access_phys,
+#endif
+};
+
+/**
+ * cdx_mmap_resource - map a CDX resource into user memory space
+ * @fp: File pointer. Not used in this function, but required where
+ *      this API is registered as a callback.
+ * @kobj: kobject for mapping
+ * @attr: struct bin_attribute for the file being mapped
+ * @vma: struct vm_area_struct passed into the mmap
+ *
+ * Use the regular CDX mapping routines to map a CDX resource into userspace.
+ *
+ * Return: true on success, false otherwise.
+ */
+static int cdx_mmap_resource(struct file *fp, struct kobject *kobj,
+			     struct bin_attribute *attr,
+			     struct vm_area_struct *vma)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(kobj_to_dev(kobj));
+	int num = (unsigned long)attr->private;
+	struct resource *res;
+	unsigned long size;
+
+	res = &cdx_dev->res[num];
+	if (iomem_is_exclusive(res->start))
+		return -EINVAL;
+
+	/* Make sure the caller is mapping a valid resource for this device */
+	size = ((cdx_resource_len(cdx_dev, num) - 1) >> PAGE_SHIFT) + 1;
+	if (vma->vm_pgoff + vma_pages(vma) > size)
+		return -EINVAL;
+
+	/*
+	 * Map memory region and vm->vm_pgoff is expected to be an
+	 * offset within that region.
+	 */
+	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
+	vma->vm_pgoff += (cdx_resource_start(cdx_dev, num) >> PAGE_SHIFT);
+	vma->vm_ops = &cdx_phys_vm_ops;
+	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
+static void cdx_destroy_res_attr(struct cdx_device *cdx_dev, int num)
+{
+	int i;
+
+	/* removing the bin attributes */
+	for (i = 0; i < num; i++) {
+		struct bin_attribute *res_attr;
+
+		res_attr = cdx_dev->res_attr[i];
+		if (res_attr) {
+			sysfs_remove_bin_file(&cdx_dev->dev.kobj, res_attr);
+			kfree(res_attr);
+		}
+	}
+}
+
+#define CDX_RES_ATTR_NAME_LEN	10
+static int cdx_create_res_attr(struct cdx_device *cdx_dev, int num)
+{
+	struct bin_attribute *res_attr;
+	char *res_attr_name;
+	int ret;
+
+	res_attr = kzalloc(sizeof(*res_attr) + CDX_RES_ATTR_NAME_LEN, GFP_ATOMIC);
+	if (!res_attr)
+		return -ENOMEM;
+
+	res_attr_name = (char *)(res_attr + 1);
+
+	sysfs_bin_attr_init(res_attr);
+
+	cdx_dev->res_attr[num] = res_attr;
+	sprintf(res_attr_name, "resource%d", num);
+
+	res_attr->mmap = cdx_mmap_resource;
+	res_attr->attr.name = res_attr_name;
+	res_attr->attr.mode = 0600;
+	res_attr->size = cdx_resource_len(cdx_dev, num);
+	res_attr->private = (void *)(unsigned long)num;
+	ret = sysfs_create_bin_file(&cdx_dev->dev.kobj, res_attr);
+	if (ret)
+		kfree(res_attr);
+
+	return ret;
+}
+
 int cdx_device_add(struct cdx_dev_params *dev_params)
 {
 	struct cdx_controller *cdx = dev_params->cdx;
 	struct cdx_device *cdx_dev;
-	int ret;
+	int ret, i;
 
 	cdx_dev = kzalloc(sizeof(*cdx_dev), GFP_KERNEL);
 	if (!cdx_dev)
@@ -696,7 +793,26 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 		goto fail;
 	}
 
+	/* Create resource<N> attributes */
+	for (i = 0; i < MAX_CDX_DEV_RESOURCES; i++) {
+		if (cdx_resource_flags(cdx_dev, i) & IORESOURCE_MEM) {
+			/* skip empty resources */
+			if (!cdx_resource_len(cdx_dev, i))
+				continue;
+
+			ret = cdx_create_res_attr(cdx_dev, i);
+			if (ret != 0) {
+				dev_err(&cdx_dev->dev,
+					"cdx device resource<%d> file creation failed: %d", i, ret);
+				goto resource_create_fail;
+			}
+		}
+	}
+
 	return 0;
+resource_create_fail:
+	cdx_destroy_res_attr(cdx_dev, i);
+	device_del(&cdx_dev->dev);
 fail:
 	/*
 	 * Do not free cdx_dev here as it would be freed in
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index db39835b93d2..3096c31d5b9f 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -154,6 +154,7 @@ struct cdx_device {
 	u8 bus_num;
 	u8 dev_num;
 	struct resource res[MAX_CDX_DEV_RESOURCES];
+	struct bin_attribute *res_attr[MAX_CDX_DEV_RESOURCES];
 	u8 res_count;
 	u64 dma_mask;
 	u16 flags;
@@ -170,6 +171,15 @@ struct cdx_device {
 #define to_cdx_device(_dev) \
 	container_of(_dev, struct cdx_device, dev)
 
+#define cdx_resource_start(dev, num)	((dev)->res[(num)].start)
+#define cdx_resource_end(dev, num)	((dev)->res[(num)].end)
+#define cdx_resource_flags(dev, num)	((dev)->res[(num)].flags)
+#define cdx_resource_len(dev, num) \
+	((cdx_resource_start((dev), (num)) == 0 &&	\
+	  cdx_resource_end((dev), (num)) ==		\
+	  cdx_resource_start((dev), (num))) ? 0 :	\
+	 (cdx_resource_end((dev), (num)) -		\
+	  cdx_resource_start((dev), (num)) + 1))
 /**
  * struct cdx_driver - CDX device driver
  * @driver: Generic device driver
-- 
2.34.1

