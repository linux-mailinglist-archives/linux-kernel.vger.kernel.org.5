Return-Path: <linux-kernel+bounces-137863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C0789E872
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82FBB23580
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F2DBA49;
	Wed, 10 Apr 2024 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="QAEFnawA"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020003.outbound.protection.outlook.com [52.101.128.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7A523A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712719867; cv=fail; b=QV4VDzz7RRKI0WfyNqo+fjaJmj6EsjG1Wg8RyTagmk/pSwBi4Hk2oZd9kl9TsVa7UjweXos4fDZ2aTBFrzyBYr9aWyccl02btJUx4know+Hk34pXVCptWd8XCFZjNXU79wAb6flTKb8KGrK+JpQ/hZ2mzBIVreDndaNZ7z9+yJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712719867; c=relaxed/simple;
	bh=4eCZpl8guytdOw6rc3xM9zmUKlqxXfvoCr39gkz4cWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLBSRVFBIf7zBGa+2BZmfIkEaW3D2BRCg9r4MS8PxtPl4Ou9KoWzSVJtENh1QdioorEWWcKkvffbI3ZWjxOh0KCfMWeiUqzQYqtOeQvpXBNcZHIGCMGpaIPS5sLe1ESUknhUavEOWkxauhKE3ZG9+odqKwZx//b+tH+Gxmx5mEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=QAEFnawA; arc=fail smtp.client-ip=52.101.128.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKCAU3S40EuhrMPxRv8lvThlqxWyBe7N4xSGcPsAeq63LqUTSSbXN9gkJeK2QtF/BfCoPlfhnzm3jM1fZQ0V6PLVhsqknNov8cZFi0cVVoEaZefOT5gCitrbDZuIbqqKlQvGWGjuzxo2cy1xTi6y9FisM8n111KqiWR54EmLk0vF4m+LdalEVGtyj7SBDEIUhjfcrjqdKxj8JLkUBbDV1qj+X9FG/HLJSW7g5+0Y5YeWA59V0qZHZdir+yJynxpHA0vDw8ds86d0m8zV5LezG3tUYVrSz5AvGy98z1+apHlJ09UheD0vRC0L0oeLrTd4MxkxxM/CjVFiHThA6bGOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5R+7w7Oz0u730ykQmhihBzpF1xVeY6DZkfSJCKpn8g=;
 b=I9lmtTv/R4GBYoCpyOZW//sRKYQPKY7p0YKUZ0tNIoMJpxqrLQLtEqiRWLDnMbXa9YM+1ZVi2pJ1jA56VQN6gUyaWN0WDAlopNTwAnxhcn76ByU1WIYbGTpBZ0ikMxM8O6wshvCKp6j5HEDe97jHxL9o/wP4A3u2PK/mX7STQ0157wnkvxj7Am4dnaCxJ0Ki/VQkO89tHajYFmqyXnI0iCzGD+ajCRywIHRyIB9QIiHbtzRk920V7qt9dyP0Z7K3P6HIFgs8CXLHX3+NXAcLD8DDLj62d5Dq+Uqynrguj16l6VNb8P58gn/fDXluuPBgnyjJ7fT1dW9HTFol3/DcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5R+7w7Oz0u730ykQmhihBzpF1xVeY6DZkfSJCKpn8g=;
 b=QAEFnawAL4NIUdTzQ6rH1l8bCd4MwAD+jfQ0puzmw1J250DwBQPC0qecfIu/GygaIGiAt33PESDRBHJqQYx+xOYyMN00thg3vWBViaiaYjR8Ze6+gDi1RMd96ekLhdrdGMv89FdDfnCDr5AqeixucxPpAjyinVbO4nCrYvW5ZaJw/Dp0btk1UwuhsgqQpsDlu7zpOyFhlm/YPXedUmnJAbyZjRb3v5zw1JrBHUH3/g+iImuDQxg+uPXQSaGlQmOU134PwRDuVGzzA7gnUBF4I6uDH9Qh20ZHYGZDS8AHB5mclx23kz+klc4tu9sbVms6HCdcsuMMEp2Sp2bBTYzo2A==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by TYSPR06MB7099.apcprd06.prod.outlook.com (2603:1096:405:88::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 03:30:59 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 03:30:59 +0000
From: lyx634449800 <yuxue.liu@jaguarmicro.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: angus.chen@jaguarmicro.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	yuxue.liu@jaguarmicro.com,
	linux-kernel@vger.kernel.org,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH v5] vp_vdpa: don't allocate unused msix vectors
Date: Wed, 10 Apr 2024 11:30:20 +0800
Message-Id: <20240410033020.1310-1-yuxue.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <ffab38f0-2ec6-4ed2-b0f8-398f2829b71d@linux.alibaba.com>
References: <ffab38f0-2ec6-4ed2-b0f8-398f2829b71d@linux.alibaba.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|TYSPR06MB7099:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7Pnvyr28Zjp1LappWqkXnYmzdh7ARXZt8IGl6MBnFRLN7gUUcY6mZmidj/cjhUDtDxAkGHbMzmDXD/coib7P0yR5Jyl3eFHFuXElb9GPSUct/guhRJgTycqRx+M1ZRg8SggSgDBdgL97YXmrKtI1lnTcGCEZ4Fz5EUA86BhzPIs88T7A8IP7YMZwSjzaW17GgSR8FeAngyNHSNxp/zPAH7Nd9XLcSblT6rgBT5InbsO5KeePkKf6dYBhsT0klCPXsbbSEwq9ndRx9OkuiEP+2u4Fk/EMYs5+hTStlRgwwUqvgXfEUm8qEjcNxRpKMq68OKEgpu3CnZqj1o8Eok19tvDBscU8MA11A9rH/MCTISrJk0cfv5KPWHG8ZJj7WSPyk+qQbtCMbNnfOJZTVcGYblJ1WVkOXUF/mflqRvvkQP+8HMvOWXUqx47QRDu36S2j3XEiirmlHs/zkOgceSzc5afaqYU1Qzgl4XBHIWXVMA6nPJImfywUua1EFUO8POOqKhfJljfcCBzucntq1ANjtXuqM9T4+6Ae6MYNlQvu0mBbZJGI0mjskZ55ct33z8CnliwBYVt+xhl/yWSsoAIjCu/+6PP7T7LPog513JbUZSR2MBnWzR++baDKPHH1LL568CYd6a8vfykeDCEfkNVNClIB46ehPxykzMtk+W/0wFR9u//ft1GooMwRGqmFOE5PxM3N5U6G/SSTVETXg+BuaKQXeLJDm/qKnAxwEUzI4nlEt4XU0svMdzNKu1sOJHJT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005)(43062008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FHT6r2LItzC/5fOQgur7HwGWeLe5063W8sAU42VNyIBSUW/E4+cyMaV7zXX8?=
 =?us-ascii?Q?tHi4adxmzgWf0oizg3z7BD+/uDQi2zpC4ACNPs8nN14AZEO6pLLNQNX6L7xB?=
 =?us-ascii?Q?a+adMhmzpvDxSIa8PXi/cJTg46ptX9NebDJd+vR4EMcphQqBkYHydR3TTAvU?=
 =?us-ascii?Q?PLHHm4gm6I+l8wqjxf9AUgt1v+E+A7Hvwvhmue04UaA94f37DjAM/AcsQngD?=
 =?us-ascii?Q?eqzYgB0aFyLDFYnttBvobVFU8zqmrcYgFOZys4dRYgt2SVMzE+wDAfTwwq/t?=
 =?us-ascii?Q?rjCKSGUI+nZQpUZuSh0TJN6nRFFokRki8kUWjwJ1RKQ1Nuheo2gw3s87VP36?=
 =?us-ascii?Q?tdZYbhD64lO4wPn2HK45d3O25IkYzB6GW4YQOm+mUN8g7a4Hbt9qMIKoAgif?=
 =?us-ascii?Q?9oTtoY4IU1uqI7Ckttk2dnDkfwdSVTwviPTxER7h7CjpcJXQebqzNSZa7Ed9?=
 =?us-ascii?Q?nBzrO3YBFOezdwd7SMPmZHzMw5QWeOz6llMQJIQ+gOcMk4QAYhRt0L8PkSgx?=
 =?us-ascii?Q?Cqzf/KwBK8Sb7tmH/3CTkeYaNhWYSOyxIM0gQk3PYMDFBqNCBLZNGo1vfs5e?=
 =?us-ascii?Q?scRzkTTurr0dTozRKrlv9ssdaoomNCjhHwHTY/0EBUSedE9OU8AU9iLMuNK2?=
 =?us-ascii?Q?tCONk8ZGCmqXpBtwBhVNakG5pYnnFruxQsiAGfrNmnoWeP4W5UD11WZpFg/6?=
 =?us-ascii?Q?UKdK8WDmUNeM4q9M9YqnjOqSALY4VmUWXejkq8Pt2cGZQ8G/PjpnHBlPrSNt?=
 =?us-ascii?Q?bIhwwwQ3fn+qmrAIZ4MZZ9sh6kX/CoAAp5fB8lAN0zagsk8cksvoQ6u3hacJ?=
 =?us-ascii?Q?kxmYiFe8hrZruweuAnfpTlgPUf1deveEMuBxtlZvv/bPqioqshRohlvic3sK?=
 =?us-ascii?Q?5Pz84ebCqNbttwbmqv4wBfKJ//afhZbr1FfloEsc2F/ZzKJ4F4pCfYvR1nxz?=
 =?us-ascii?Q?+7oSkorhHPqwuA0+EDM9a25fL0xDlvlz1Ms5zNWE2Uct37k3gXr9c9PAtCnJ?=
 =?us-ascii?Q?XHLJPNpMAcYg5ED0PVgvZEpJUFTJjX5u5XfUIeU1jZh+1CqPQfr861JFvgDH?=
 =?us-ascii?Q?oVXx5eNDOkLfCqxkQLQLEdaHLBZ8ai37nSgrTIoHq3QX7tC94N8E3Mu7IqFS?=
 =?us-ascii?Q?/MjK8X1uKh6Nt+UfOEeaOrjvhQT7DMQ0aRVdFAgXfcD2bTKNYCCBXvsjM9An?=
 =?us-ascii?Q?coOTicTWqBwY5JkEMCxcIp2tDM52HlwMX/oi4qXhv/7kgxzUYrRiygG5vMwj?=
 =?us-ascii?Q?ygaFCJfPj86BQ4JLw8Tnipq5zGvKYkZJDVEXsbu3fhc3Ll08SZUWr72vvAHj?=
 =?us-ascii?Q?/Ud3szrbDWYFMXClSum77see5ljGI4dl4E5/P1mPOgkA11MwAnRJ0lT/Uy37?=
 =?us-ascii?Q?AETK47TyQ14aja33qkptBqq9Iub6RasUD3S3KR+Fjj5TDguFX97d6glCnSsu?=
 =?us-ascii?Q?bA5C+7ybGARjegWN5cOm3jSvYv2W8L0xCtjQZWXU91jIUu1n1rihYvM2HZyV?=
 =?us-ascii?Q?0jgKkYdWtO5YkXPYIHW9DQ+rDio3GgDxEqD6JM/O+IzhvmsbJU0ahOEDUkIv?=
 =?us-ascii?Q?9LPVvXUzA7uu/tMA/mw25eLIJ90ReFMR2Tt+UCD8hfaZJDZ3RR5nAdSmfa2+?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30741ee0-3a67-49b4-f9ee-08dc590ea3a7
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 03:30:59.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Li7rndGAZ7YQu0J0rACN4u4vGBBsr7PEG1JPAKFUXpqk4GStr61wBhc5rxjPgBUikos7q59iIGgIqzDf1pL0y4P6sNNKTUPJ35ou/+dQqVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7099

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
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
---
V5: modify the description of the printout when an exception occurs
V4: update the title and assign values to uninitialized variables
V3: delete unused variables and add validation records
V2: fix when allocating IRQs, scan all queues

 drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index df5f4a3bccb5..8de0224e9ec2 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -160,7 +160,13 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
 	struct pci_dev *pdev = mdev->pci_dev;
 	int i, ret, irq;
 	int queues = vp_vdpa->queues;
-	int vectors = queues + 1;
+	int vectors = 1;
+	int msix_vec = 0;
+
+	for (i = 0; i < queues; i++) {
+		if (vp_vdpa->vring[i].cb.callback)
+			vectors++;
+	}
 
 	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
 	if (ret != vectors) {
@@ -173,9 +179,12 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
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
@@ -185,21 +194,22 @@ static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
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
+			"vp_vdpa: fail to request irq for config: %d\n", ret);
 			goto err;
 	}
-	vp_modern_config_vector(mdev, queues);
+	vp_modern_config_vector(mdev, msix_vec);
 	vp_vdpa->config_irq = irq;
 
 	return 0;
-- 
2.43.0


