Return-Path: <linux-kernel+bounces-136102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE189D009
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8051F22F45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3C4F898;
	Tue,  9 Apr 2024 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="SMmxoNgk"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2102.outbound.protection.outlook.com [40.107.117.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BA4F881
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627385; cv=fail; b=iyuNeowht7FU+72vLW01HhOsvXaKk6aazAfEGR4sZxbyqToMA0ucFUGnCUtB2s3YeqFl1z0PpBzSIe1SeC+SeeGpnvX4uldtw/QoJIKGrOtm5yzmgKV2OzjhI+6hXojeMkJ/QRUDAfhLZw+BBRhib8fAh+KzViEkVyYMqCoStkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627385; c=relaxed/simple;
	bh=J993L2IyB13upmbFKXLOsvcNWtm95aeqmsSMHI6h7jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gO+p9fbDbegzEQkjQy/mwtHi8+2vHoIP1ul4lm1JVIFF2kMxHZKUxhb3E77R7Zu47hFv6E67QlNGdPAh+cIk4GIxSN1nOIdoxPnRPKI3DxzRmT07WQa0jSICHbrC3MpYSc+Ajtavud5TVjHYyBf13ct7Xz9vF4Fro9xikcRNoO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=SMmxoNgk; arc=fail smtp.client-ip=40.107.117.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiooDFc/6bmPG47H8RQDZ7bLoAD0WkMRC09IKaYq+SnIa1YrVgXN2MXhIPoA4I0Zh5JnWcfgTYSo8g2X7aAQ9YwgbmXB2DAwFDl3ZH2FMrk984ODNSSwE9yowIMq1Wq9hkFneqkbflfibdLjOXZ/ChdHw4e/k8flSM0KCT7qQBfirZQDHAi1y2o2Id6N105Jn5P7URup+daCqJBZTN6czIVmjgj2Cm2Q/kLh82aS9AJ6mP9nqfz+RbdIpWO7hjh0HuLPA7AkAXxVLKMmLVReoEdQ5dlJy8B2kEmJd7k8YXQx+7Om82556XGdyKWZoJvRFiQ2h1Oec35bjtYiCBD9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/2YvXX2cpa9YVQN1WupnEmpMqbJpGbmWaXiT/uRcd8=;
 b=gq1zlcXWkHucSGaeZehu6snDcOVOac1DFChoZGkiIJdYMHA57eL5+mqAN7BTHUGRnIr5mEFQsowMfkADZqgR0eu890DuRVYdfpotIGgH+GAi5olG77ATX1T6J2FKuiwaf/KCh+qdDEJmg434pBcP+hN0MrFggr/GLjeeOOeiw56cMlvOs8SBZ0V81yBOXx2G3Hv6QVP/oqib6Ku/U+dm+rRdDmAxWuY4eoNm6KKMvChDcCCMwUZtCfev7WxkH5WbtQUB/BOatAlDkKB9yHO023isF7z/TKSW+/sNwHrcmcg8XGexKsUfg6TJDMtHaQWaPyO/3RSHYiURwaQMJmC80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/2YvXX2cpa9YVQN1WupnEmpMqbJpGbmWaXiT/uRcd8=;
 b=SMmxoNgkOAioQDCjINQSX7rTyn7FliXmJToYrSfAlHAn0CR8Eg9xukjruK28EUinY/vYhyH7wzLAhpGQSaZ/IGJl4GWBSUHDj1F1UJ6LVdrFqcxuBsTGapYEwHS02cbVDXRY11GQzxqlsCLvw78sbAD6Z1lazTXWX0vxIe5TVdpWgWSzQjqt/eBHacgsoBrJ+Dt+rDoRcAoB7HJu7loNQfuAmKjtrTbwqQL37LrNKf0s6XVc56xattb9O2ilu9TNLtPGomd2022pXL02n9zoyCx6CtkMJTzie6o2BVdWtS5w99ysFneCmcTW4/mZkcn+EGhNonryFtT9WLPym8I5VA==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by TY0PR06MB6839.apcprd06.prod.outlook.com (2603:1096:405:10::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 01:49:39 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%6]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:49:39 +0000
From: lyx634449800 <yuxue.liu@jaguarmicro.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: angus.chen@jaguarmicro.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	yuxue.liu@jaguarmicro.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] vp_vdpa: fix the method of calculating vectors
Date: Tue,  9 Apr 2024 09:49:35 +0800
Message-Id: <20240409014935.944-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240408035346-mutt-send-email-mst@kernel.org>
References: <20240408035346-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0159.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::15) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|TY0PR06MB6839:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+HwAissD9KZA45SpjWOHCMadnG0T0sBC5VjW6us9OtO2CdWreDa4UtboMwgO6h++6+8IB/s2gVlWBILsqnqwQKdleKBU47NbIzgKpjHpKoRbiPeuwJ6WdJ5r47000n5lmj1YlShE8kFdY+mH3OQA55L8GMbmZhCYYx5AdWkujRGuAZWmlbbaWEHk86nUTPSCQD6sEvAsQTwAWGt7qiG7Lf7kIvS96X/UHMiX7dpHJmDm16Kll1hQUiIRiZJhrUysXDoNrg3RpzihTuehoD/jLdOeUTjFLA7ej9sgKeYd3oE3oGdb/MmI7odoG24pTd74be1x94WbFTNjiIvlj/kfui4n2AMjIrjV1w2/t1PzDowLllbdfeIzZ2WRS3h57y0TYHH7DtxOkfOaSK7Bv3rp+8ZzcNNSsk25sS0Uhr5ODdu5jMhuwYObmlJZx/SQYsvE4az3ITip7k2SbcQc7xAc8D1eT2ZCz5PdU8Dj7wnWN+IfVNG5zFrm3N4BqGRlFJI6o/lA3XLYPOgt1h042h3qr+Lw1ldcy6z2QYs3VPBhzCul3V8p6f9z05XETwGhkvkF6NkUnvsB1dKjOvGFwT8xmp98ZYBKXRWqO214fsKg0ktGKXBNxtGFmY5iKanfCOMsa3wmO/LUwR1/wMRYz+cNRECdPMAGqJcyrO+5km4LpRmq4hwMFBpceopxgV75hS0e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005)(43062008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TjrwEwRf8PR2NujH2pno/l4vXzSTep4i4uONJV31usTuNWQFfw6ikdmj7/eE?=
 =?us-ascii?Q?GHk8nYrfIwf9WtskYem5vo83ZqGC44ylUkxz4iClrPv1BtxWUlhPHnkCKhWk?=
 =?us-ascii?Q?3HrEWSDL8/7Bv+FWq1myAMzTwAGWz4452RA7KDKNMYSY1iE6uuph6TDU/uZs?=
 =?us-ascii?Q?xXWfO1YIxaCuxexARbya3MXc0aT5CyeHtkfljM57ffxDS7myXdANMyCVQ002?=
 =?us-ascii?Q?QcH9iDkiYRNDqrQTYyvQ7hxNCV4eQQyf1fMpJySh3R3Mb2oW8UjmOQ3RbPAL?=
 =?us-ascii?Q?t2Kj8saCoCWZy8Kp+KixFqNl6a/En94EUyGVmFmQDrecOD/wfdykcs63t5n/?=
 =?us-ascii?Q?2e35uF5XFWaXyMZqcgV+ybMFxOgwFyUzP+n9FndVyezAPChTjVZRGFGYe4NN?=
 =?us-ascii?Q?E4wU6SJFwxCa0ZwIWNkl1j8t/eXVv13mAVEeZeFN+9T8G2MGcFLP2Cp4sg0C?=
 =?us-ascii?Q?Yft+Hul9hUuNnS2zYvEKPmrIlw3oEz381/2v1dckQOhnaFSfrRvPqYyFBITi?=
 =?us-ascii?Q?RgSM/QokQosI9k2L9E9j8zCHY/hgzDlt7IzUk+gxJzFz6dpZuz7R8bmjp9+W?=
 =?us-ascii?Q?YGYtjSl7AC232wXlLPjRz1EIaQVX4RwPJaGQP2xxFIwi8VMmMieL6eoWanXq?=
 =?us-ascii?Q?gHPL1sZ9U/1RM0eCyr4HjJqMfbFyHud7U8LQ2UN525YY1NQrrH04/fHwXHcG?=
 =?us-ascii?Q?kNbqfiiqveAAAgOlAucbd+4na4b86CAVLYf5yIGuzaGf/zEip4OQiNN0MZuD?=
 =?us-ascii?Q?Ut1V9H4r9EdrJCpUxQVibXVqtU3FNRyQKCR94UjC/Y1DJ2yHPYEM2bimVi0n?=
 =?us-ascii?Q?7iOe2UWvlR0tugwbg/N/suGcjNoLWHa23J4b8c3zIup8mU6cYZKMia8cPAYL?=
 =?us-ascii?Q?agbJsyfUVwpsyjsqnXOzgFhuwRgPOHnqxPfh+lKmu0Mk+dgUCbctO+/+4en8?=
 =?us-ascii?Q?31A+btrtHVfFvy1KQLlPbFL4bOyhR2eqreWX5Yi/FjaA35mxyUOYANAbDKEg?=
 =?us-ascii?Q?zml0/9pAHwKfzwGTYE1UWoZX7i78ve5sGNyc4BwuLotkAyg7tWbNb3ZRffim?=
 =?us-ascii?Q?6Ja6JCevExgTcZf1X7sn59ru4h9puET7D8g7R+/30ddvIfSrCxFBXdgXLK4q?=
 =?us-ascii?Q?xN1heqN9/F9TjCRa6fLgkD36CkjjzQjI7QYTWGvPv7C1dsF/hWTIkf3b5Ud/?=
 =?us-ascii?Q?WSCT4xL+RUTI8GCBipUgOULnmKVcr8lW455uDJX9TZVeUbMz07f3MMvChVKF?=
 =?us-ascii?Q?OyYWb7HL6PwKCCQIvdeX5ITgZbGCvkS2W1ZhOTE54I47KGxNl6BbztOxZ/PI?=
 =?us-ascii?Q?kLp6iGffMF6cAM1Ljo0hu7ybhqCVzFnJ8uxAAlC4Xds/64wPjfxPlvgasz7D?=
 =?us-ascii?Q?aVkz2MeJ5Fiix/w45SkANNAuwI0kpMHaedXAFwG885Dwwt3XNBGedClBWl7A?=
 =?us-ascii?Q?jcIPN3FE3JVKtQd5nIpgL4pnYnprv3d5Ykx97V2fx95Tpuoy/Ku00CKO0ks8?=
 =?us-ascii?Q?O6ibRgmhi/I99azTSycN5F7WcPYwoZlx9ddKJ92runBgDXWGfzbXHL8a/HED?=
 =?us-ascii?Q?luePWpyLAUSNyncrDCBh+Yww/Vp02tx5coocR7Mt0NLgW9Bhy6D3G04leK/t?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0102e1ac-1eab-4cbd-6085-08dc583751a6
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 01:49:39.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxfPuFJ2mGFi3D/kneuFVM/e4S8FSgNcNfxzQS3Labdhh9P4yxLMduntJLfWtuZLQaMwPm+a2AMhafbGW8FJiSOqGOoUYV5mR+UDfwErdYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6839

When there is a ctlq and it doesn't require interrupt
callbacks,the original method of calculating vectors
wastes hardware msi or msix resources as well as system
IRQ resources.

When conducting performance testing using testpmd in the
guest os, it was found that the performance was lower compared
to directly using vfio-pci to passthrough the device

In scenarios where the virtio device in the guest os does
not utilize interrupts, the vdpa driver still configures
the hardware's msix vector. Therefore, the hardware still
sends interrupts to the host os. Because of this unnecessary
action by the hardware, hardware performance decreases, and
it also affects the performance of the host os.

Before modification:(interrupt mode)
 32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
 33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
 34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
 35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config

After modification:(interrupt mode)
 32:  0  0  1  7   PCI-MSI 32768-edge  vp-vdpa[0000:00:02.0]-0
 33: 36  0  3  0   PCI-MSI 32769-edge  vp-vdpa[0000:00:02.0]-1
 34:  0  0  0  0   PCI-MSI 32770-edge  vp-vdpa[0000:00:02.0]-config

Before modification:(virtio pmd mode for guest os)
 32:  0   0  0  0 PCI-MSI 32768-edge    vp-vdpa[0000:00:02.0]-0
 33:  0   0  0  0 PCI-MSI 32769-edge    vp-vdpa[0000:00:02.0]-1
 34:  0   0  0  0 PCI-MSI 32770-edge    vp-vdpa[0000:00:02.0]-2
 35:  0   0  0  0 PCI-MSI 32771-edge    vp-vdpa[0000:00:02.0]-config

After modification:(virtio pmd mode for guest os)
 32: 0  0  0   0   PCI-MSI 32768-edge   vp-vdpa[0000:00:02.0]-config

To verify the use of the virtio PMD mode in the guest operating
system, the following patch needs to be applied to QEMU:
https://lore.kernel.org/all/20240408073311.2049-1-yuxue.liu@jaguarmicro.com

Signed-off-by: lyx634449800 <yuxue.liu@jaguarmicro.com>
---

V3: delete unused variables and add validation records
V2: fix when allocating IRQs, scan all queues

 drivers/vdpa/virtio_pci/vp_vdpa.c | 35 +++++++++++++++++++------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index df5f4a3bccb5..cd3aeb3b8f21 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -160,22 +160,31 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 	struct pci_dev *pdev = mdev->pci_dev;
 	int i, ret, irq;
 	int queues = vp_vdpa->queues;
-	int vectors = queues + 1;
+	int msix_vec, allocated_vectors = 0;
 
-	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
-	if (ret != vectors) {
+	for (i = 0; i < queues; i++) {
+		if (vp_vdpa->vring[i].cb.callback)
+			allocated_vectors++;
+	}
+	allocated_vectors = allocated_vectors + 1;
+
+	ret = pci_alloc_irq_vectors(pdev, allocated_vectors, allocated_vectors,
+								PCI_IRQ_MSIX);
+	if (ret != allocated_vectors) {
 		dev_err(&pdev->dev,
 			"vp_vdpa: fail to allocate irq vectors want %d but %d\n",
-			vectors, ret);
+			allocated_vectors, ret);
 		return ret;
 	}
-
-	vp_vdpa->vectors = vectors;
+	vp_vdpa->vectors = allocated_vectors;
 
 	for (i = 0; i < queues; i++) {
+		if (!vp_vdpa->vring[i].cb.callback)
+			continue;
+
 		snprintf(vp_vdpa->vring[i].msix_name, VP_VDPA_NAME_SIZE,
 			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
-		irq = pci_irq_vector(pdev, i);
+		irq = pci_irq_vector(pdev, msix_vec);
 		ret = devm_request_irq(&pdev->dev, irq,
 				       vp_vdpa_vq_handler,
 				       0, vp_vdpa->vring[i].msix_name,
@@ -185,23 +194,23 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 				"vp_vdpa: fail to request irq for vq %d\n", i);
 			goto err;
 		}
-		vp_modern_queue_vector(mdev, i, i);
+		vp_modern_queue_vector(mdev, i, msix_vec);
 		vp_vdpa->vring[i].irq = irq;
+		msix_vec++;
 	}
 
 	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
-		 pci_name(pdev));
-	irq = pci_irq_vector(pdev, queues);
+			pci_name(pdev));
+	irq = pci_irq_vector(pdev, msix_vec);
 	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
 			       vp_vdpa->msix_name, vp_vdpa);
 	if (ret) {
 		dev_err(&pdev->dev,
-			"vp_vdpa: fail to request irq for vq %d\n", i);
+			"vp_vdpa: fail to request irq for config\n");
 			goto err;
 	}
-	vp_modern_config_vector(mdev, queues);
+	vp_modern_config_vector(mdev, msix_vec);
 	vp_vdpa->config_irq = irq;
-
 	return 0;
 err:
 	vp_vdpa_free_irq(vp_vdpa);
-- 
2.43.0


