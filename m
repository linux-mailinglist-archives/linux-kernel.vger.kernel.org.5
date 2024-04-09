Return-Path: <linux-kernel+bounces-136510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA6189D4FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D131F21DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBA67E785;
	Tue,  9 Apr 2024 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="Z4iYyUDx"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021006.outbound.protection.outlook.com [52.101.128.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FB3BBD8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653113; cv=fail; b=BzI21kRIV8ix4At5pc2OzsESo7+bEsapAJBh49Xerrx49ugiUiSQ4uzbgspSbqY5IX9pqAQEdRXbXvHj7OOqL2VTviSUx57WtQGMMd9CdP3WEOlFHH5JzYwoil54UAF/VaEibsZHcMM5pioh7wxauGxCMGQGLyNEiPkNw9XZCfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653113; c=relaxed/simple;
	bh=8lUKWByWcEBuG3/zrb57it1J7bmPtt/J74r3Fb3X6Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmNHigQ2tlSOFtTQXD09jjATDWQWfqg+nq1gD4uyJ1vtlblK3X7IvavqKhg9okMDQMhV5rNbiuFexqf3AMd5306u+57h1esA6suDl9rfmdamdhfGXcSIRh9V3VybkTG1/+MxVKhcZDWu/FWLAkqgoztb0fm/7+OpkbgHffsIfEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=Z4iYyUDx; arc=fail smtp.client-ip=52.101.128.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxPvtoZ4f7DV7nOUR7NHRYim3aJYES56oP8VxMU/RU0KgWfgxtcvl4VwZijV5td2BodolDpYB/UJ4JCQyXdLpzkdC8qh0Fv2O1z0z1RQ0jguIMJl6+YS7Q+Ey4UOd4FlBsWc2SjyM3Xo9moz70DQfiUPrA0WDO+2yHP++N3MSeVeHXMxcd66PyCrrdQgKZ0cNgQnf2TapB/jtKiAgj5etbiqrciPPtUErFhS7BP7tM307vIPFHjW4THIEzIEIikjIZC8mVIXKuxKPkDtWjUmaR/LZydswJji0xgyFk7kaCPAkzdO8XUr4J4YMEu+pKrUJ+FyxbH6sXicdDBcIIBbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRrLYt0Jo0riHmXlnHWLHGEtK1bdwxtkkz45HgTy7Jo=;
 b=YK0/2Bf6os8TbMNatTtHMoG99AUcbrP4Bc2bLEWH3ABI+RjTWwZq9XyIlT50BLcr+spfAkagEr01MllNTALuGRgdBeJhrh2JPz95SQYdq2IMBPg3hrE6/uPn2BMrlCL6hHS6XhwkrBC6B0u1Bxvgc7uIHZzfZ+/lPFSkHsICxspnCqkZuxRKJofFyyKNmPqFmUupFr7EP1ZC7Gr+Dr08qJoOvAPs2in19s1LE/EcW0mHDVNnty8wFQvQefZLjCjy70JlbjS6YfX4MFxGLOqU4/IWr49Ew6idZaNESAC6ydb2FGEiOcMModrfyOjZgkYqoGYlUKG7Umw/WBGdxULgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRrLYt0Jo0riHmXlnHWLHGEtK1bdwxtkkz45HgTy7Jo=;
 b=Z4iYyUDxsMcyPv2E+PXO3KWfW5ltkW6BgU9EiQm4y2t0y1DajilGGw1ZhWPn4aRHvHbzm2vVQZRd4WWUh+tFUT/u1Tx8LOe15SlJ1BQSqXC5VNirupC8ZJEYvfbxKsc8RJw1nBM+TtaSqAh0JBtyldr+GixMdklpE4fkoxnaagS266Iej5zVBT7U2rOO7Zfs+yFSyxLagxLMIruXngLagv7v7xFYYNTb02cYEPS6PISoWx+u5O8JdM7SvupFRgmX9QNS7z0caNLW7bRmOp2AYGMQpXWV+F2d9cZJ/WvxQuUXZ5855UJQsL2lO/0d4wOg0sFGv39FZd5fXxYkyGzYoA==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by TYSPR06MB6543.apcprd06.prod.outlook.com (2603:1096:400:474::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 08:58:24 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%6]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 08:58:23 +0000
From: lyx634449800 <yuxue.liu@jaguarmicro.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: angus.chen@jaguarmicro.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	yuxue.liu@jaguarmicro.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] vp_vdpa: don't allocate unused msix vectors
Date: Tue,  9 Apr 2024 16:58:18 +0800
Message-Id: <20240409085818.1242-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240409013020-mutt-send-email-mst@kernel.org>
References: <20240409013020-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To SEYPR06MB6756.apcprd06.prod.outlook.com
 (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|TYSPR06MB6543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uw1ULcO3854JhDNXjjRttQRaA6UuuMKDKWuGZC9eJO8jwWEBWDOYS91u7g05m4BN+QVipu0w7PfrsP7yUZOqChg38expGUjooTPuVYMaDHgmxZo1fNZyO1ZUjuotCMv275Qa4FCbgAD8dEZksen/BPN0Sbe5wiZtKZrnuNDMfH80kjvbFkAh6xZbhdT6TjNkdshwV+4YypTC7qR87aIGYcZZRm8sbUUiMYDI/pHv6bAnWIi0DFF6sMW+G7I+7MdlAvjF3MNveuvYPaVxnpz8ixE30SFKeD33tAcn09Yw1gWa8e64mXkx/cjhDPgv2WrvODqwsxQ/wEevQwY22mpZFtiWWACAX4YL0obmVeXLjEMupjnT0w7UNmK6Du72rrNvESe4Q5XbW6W/8eKFFJEL+P/jtLxljcDJc4SN5EKoCkNCKOvfI8rsfFgWwy9fvF0HjALIYBiwEOCTmpTcfFSrLxRrRmMjbMs9SiRDp1PYaUonV8Jixntb+nIIsS6xNLYQO5Dn9dQI1PHnPlLe+2WapldKaZcrWRbpmD2KpwgTu9EP6jXi/J+67/gMdDqfPNxnvxULDATLEC4+C+VDAL4TVAlI9Z6AEpwQ3p9qqxB92bePs3lq6FKxQDPWxBVVVBevXNNn1LhTtOjDr1GiL1+Um+9lb54veNlKqac5H7KQzUcfgEN2wvZr4EX1oGeucINR8+oQPhkLhiaknysB2hFwdyGM5jGjppwohw2Qov5KZXifro9fX+mlShfwR6A3rp6x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005)(43062008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8A0/mpZ/HUzlLN4m5bfRHJT9+gv81QICSdLxGkICsQCINNtnt6DjlMW2UBsg?=
 =?us-ascii?Q?TWDxuuWFr4DtNZIspo0swqK66ZuXv4S1KbpJ8/YU74fPkBgOz3OW7SqKOE71?=
 =?us-ascii?Q?Xi474E/0tU1JzXlpBHL9+8ogCW8ih6Jphhnw0++7AODEBBj0L7jmf0tw2amg?=
 =?us-ascii?Q?7RXmiOm6HEGdCGwrMJugBu1Qb+5R6dBHrZ7qj3xElkB4Qbv5K4MglIytYKXX?=
 =?us-ascii?Q?SKsFWY4Ui+r48SEtSchjOHM4vFRkPQdv9WCrq2Qffno8JkPLhL+a5K9XWfsm?=
 =?us-ascii?Q?FsaOmSJ3qlXB8a12ZXB2FIyi/yA/MXUuVJ2rIIPFVge7NVdp80zV6Gp6HBti?=
 =?us-ascii?Q?mmzUIaI81dvThJ0FomQOKnlqUnEIifb++JmxUh9cEdNaPY/Fhir558MFQen6?=
 =?us-ascii?Q?+fIPTpjmZjqgouvQgehBjymGiaJviIZ/lgnV+tu6H4GR4+d7QXmTMgnlyXQZ?=
 =?us-ascii?Q?evlm7Umus9a6vqQsSXlGGO+BA0uVoWLjt1XYuVHv+JHtD7b8g6prtez4zGCP?=
 =?us-ascii?Q?xhuCz7/IGnurNt56D+5uylhpVl9a3tOCSv/KueD4Pvchu13ESIt1c07mdmzN?=
 =?us-ascii?Q?1ULVOXoAhKzK19wWo8xrh8cmFagJtUMzrLPW+yVDRTu7a1b+ZBf59SbdNGvR?=
 =?us-ascii?Q?17jRTi2VXkeNMvLf/c0SnS1sM6yBJfZ21Cv9YLyXpLiZbMMbxPBo6ldqwnyM?=
 =?us-ascii?Q?BqrPzuvUD16AOf+zmityBCw9Ddap5/DGmeABTmGKHFRE+N/rAwW4/eF+Ro3t?=
 =?us-ascii?Q?1elMvaJfOsMtz+uwkZ5cLQZ2z+KEahGPCrqPCFz+xBoJcpDdxRF3bMOS15Y+?=
 =?us-ascii?Q?8cyOV44xW9tNKBo9QtGxx51tOECXgV6a9HAUKO/RFM+BhdC1hI0lhNaDHXdS?=
 =?us-ascii?Q?ImJWuhaEk9BW2INSjmqLSbaKDqXZcZCEGlgA8TwS2ZwkFXTPx3lY5HoSehWB?=
 =?us-ascii?Q?///oQTDtfyxSJu1pnelYrX1XFwwByKpR5lOstr5XjSVaJ5CqI69XzADr8/J4?=
 =?us-ascii?Q?PnQIf3cBVr8iX6SbCjRvoie4uGjTUqkxFRRU6HtzHXmmIhXdjXXRWj3HExmm?=
 =?us-ascii?Q?2bJuBIWGr//vzYo53ib7Jdz40iEui/nDNdcIHihM2D5Z1dq4e26IKTMwPe7R?=
 =?us-ascii?Q?9z4BkVM9qpBRneCuJMTVA61pP6UooxntGtgvVwZRcLKNuGSrrzLkWoGUyuBA?=
 =?us-ascii?Q?exUECSdzlaZ2X7qsjCPwOCOR4c6NyjFvW2nLVig5cUPIVelNNFJCOqdO3LH7?=
 =?us-ascii?Q?OKp7GZ47ZkFRAxZp9/BaJ2pcO67lG3Wcyp5jW7e4WGlL7z1CpfceKQ0BKFH2?=
 =?us-ascii?Q?Uz2/uH2fp+/HQNo/3fgq8IZrccsDvjHqiAhorS57T1Nkno287HYSrt37HiNy?=
 =?us-ascii?Q?vM5fs0xeGzpTV089N1qR0HNP8jFHkx862JrHFpAtg6FoG4fJuvG+8IXcCPYH?=
 =?us-ascii?Q?CdxsemTwXoeDceOlsUvf1Kck6QecFtdNoUCk/kj0qQ5/I4Fvjspo8azcB1PG?=
 =?us-ascii?Q?EN6ScPAkUVRe8dqGjkV+ZNxA7B5lJmQTWuocnxYOUicensj9S+EqHpYaHUjr?=
 =?us-ascii?Q?XK+QvgU1w99lk6osEbQty5iSvysjnNxFznoSFvcL2K5mkcoBKlw8wdm+iyuk?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fdee57-3861-4dc0-2b37-08dc58733649
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 08:58:23.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRwcGKOlFeEZkPnesaAaGHIYZZjkEOSQMc93N8N2XNwH6HcjHlnm1JNDC/TtEOPAmZp0Eht/kv0Rl4jvMpocEh9/D2qoxntV6YTI0X4K+rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6543

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

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

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
V4: Update the title and assign values to uninitialized variables
V3: delete unused variables and add validation records
V2: fix when allocating IRQs, scan all queues

 drivers/vdpa/virtio_pci/vp_vdpa.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index df5f4a3bccb5..74bc8adfc7e8 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -160,7 +160,14 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 	struct pci_dev *pdev = mdev->pci_dev;
 	int i, ret, irq;
 	int queues = vp_vdpa->queues;
-	int vectors = queues + 1;
+	int vectors = 0;
+	int msix_vec = 0;
+
+	for (i = 0; i < queues; i++) {
+		if (vp_vdpa->vring[i].cb.callback)
+			vectors++;
+	}
+	vectors++;
 
 	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
 	if (ret != vectors) {
@@ -173,9 +180,12 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 	vp_vdpa->vectors = vectors;
 
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
@@ -185,21 +195,22 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 				"vp_vdpa: fail to request irq for vq %d\n", i);
 			goto err;
 		}
-		vp_modern_queue_vector(mdev, i, i);
+		vp_modern_queue_vector(mdev, i, msix_vec);
 		vp_vdpa->vring[i].irq = irq;
+		msix_vec++;
 	}
 
 	snprintf(vp_vdpa->msix_name, VP_VDPA_NAME_SIZE, "vp-vdpa[%s]-config\n",
 		 pci_name(pdev));
-	irq = pci_irq_vector(pdev, queues);
+	irq = pci_irq_vector(pdev, msix_vec);
 	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
 			       vp_vdpa->msix_name, vp_vdpa);
 	if (ret) {
 		dev_err(&pdev->dev,
-			"vp_vdpa: fail to request irq for vq %d\n", i);
+			"vp_vdpa: fail to request irq for config, ret %d\n", ret);
 			goto err;
 	}
-	vp_modern_config_vector(mdev, queues);
+	vp_modern_config_vector(mdev, msix_vec);
 	vp_vdpa->config_irq = irq;
 
 	return 0;
-- 
2.43.0


