Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7C7B22D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjI1Qtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjI1Qtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:49:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384011A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDSIES7u2eQBZmpcDACVTbq6Ad8YqUj2GX9K/N2pPiqhOgU1arflO5FkFlubop2YVbX5fcvcfSOxjg9Z8S7bNu7qnOPgeKZ89Pr+iceiLmZ9seIqQhofnuu3Aj7IXo/h2rBz6J3eAfw9NEpxm2vC1y0/+J5JMdC6ulR1aX9Eo/99UrkEfL5Y/PhDmfnhby8IGUWT20pHhoD5N48i09tbP6IZGDuBGQgdIxsqSi1nlqtJErMLxYLtT9GA0Q0XH64tvD9Iwrp4w1zOKQzLBX/dn7WUG6Ff8RK9uBHvrVX41BdU+QHGXaL3XrwCf4b1j7pOJTAZpreI4mdxr+NkK8RbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=Ksw1+PGEvR/xzuOYZuiO4owASpDRcbnJJqXayB6TlSQCN227jsveLc3mJH/Nu7Qw7xy4NSPnFB3XsWjF1uB2XrYhLLOVLA3sw1oC6j8keeJ3VSa5fuHfQZbCwhEdovIsG29qZrqn+AoMmwMWjjmaE64YASZkrU7nDySXD/RlUePvrmXVC+vpYoLKGWp2C1hQKTMNp4kPuaadb+nkTqBklQ7G7RfSDchGFObN5jhHFbLtcUmWMnL2+KWt9EzjMtiFqZv5LEX4R1dmgfHP3KhUKexjU0BDlHtSvHSW0aYq+0mu99gCE3Zo/4Rem7bfcShr9/wvZnhJGcyXvbXk4q7chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs2p5Im8kifm/aJ1lEAfNpIB6nh0RoaB6CA/cNIHKDA=;
 b=Tu7V1LR0tp/7qvW+VaL73wYbd2BHqNvVm/1XJc15u+JkXOG4YVrl5VOwe7mO71MmNpkGrnF/cZ0z7x553emgbnITrYOzBnhPscXFxk3Vju+hwIiknHrhjuC0z84JXniGJCLAqW/rera0CcTaOGASSM8HBAF6PpgUjGeXU7/V3lE+mUe0cwfijZvvzYzPYg/t2Kt7Dj+oirDZi3EYkZv87RTWmfNy9liFHy3aP4lwQOQhWLVynbA5BOd93skJKWVsjz1PGl81cgGnc4XVkWgrc+RcS9eHK3d0/kj73Q6jZWhtewhORpjTRUrcEOD6FuMUh4jz9FingTXtoamaEvkENw==
Received: from CYZPR14CA0028.namprd14.prod.outlook.com (2603:10b6:930:a0::7)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 16:49:38 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:a0:cafe::17) by CYZPR14CA0028.outlook.office365.com
 (2603:10b6:930:a0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 16:49:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:28 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:26 -0700
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     <eperezma@redhat.com>, <gal@nvidia.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     <virtualization@lists.linux-foundation.org>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost 02/16] vdpa: introduce dedicated descriptor group for virtqueue
Date:   Thu, 28 Sep 2023 19:45:13 +0300
Message-ID: <20230928164550.980832-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ad0b10-3665-4d65-9f2e-08dbc042e72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kj5BJN6WuunciC+HjKzFmr1Z1UbWRPaNZJJvkWG82YHBBxVX0EUY/J5eFG3LnP/nMCZGiKJ1pCDx14rNcjGiyC2DEgkAW6/KeIGdFdg2rCAlG4Cfz/Fz92ePJCFS7ENxwXk7BqkOUYMD7HHT05XbLmC1ZfYgqKlfqFiwWqIpdKs8VXpl5MQwbYPhrS6czKPKS8FVRhWm1jUSrLuCbdpbxpdaDnc9xkXS8tW9mZXm6RZbej/Oj158huyWPAa+9jmbI3etxCv8sN+7koqUparj8k7Ypw1qFeWjppPOsodCAjuoZKkBCCAF+rukH1/APuhtbfM6X4muFShzOrA7+Osi107nTk5TqKehCWAmtkJRvV/3qqabs+U29VR/J/UaTLtHvp1VLs8ooT/4loPlGCOH7fTwOrU6mmYdlR4fSVOHXJ13KaTSAm9NnFv4BRXEcfoZ+V5rjyHnhJ4pu5kL23zUCk9aY4rNugGeNTE2iBRjpMJO4QHRz3eaOTWcIQmNMtHfGQT/NdzYjCMJ1kyQSNp/blBFHLWFcAX1kppX4tezH7q977m1RZBiSgNl1LhzMpDT9RLQkeAXlEYeCJhn8rsgvT8a9dRHfi6DDPUlc0+u4k+wiGU4wh5+t/lfb2hZPseZ2F3zv8X/jtwKPswnEFCB7GIvpr4QZovNMEpu0gbXW4ARo64727jMYHbt3c/Pmn1/B/8UfXEpMHCR2sNrCvXSVdPjtaQuJbUxyxme4E3ZfQKwIlExJSOaPDyVx3FsUx9f
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(336012)(26005)(2906002)(66574015)(6666004)(1076003)(2616005)(426003)(83380400001)(478600001)(8676002)(36860700001)(4326008)(8936002)(5660300002)(47076005)(316002)(70586007)(70206006)(82740400003)(54906003)(7636003)(356005)(110136005)(41300700001)(40480700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:49:38.1086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ad0b10-3665-4d65-9f2e-08dbc042e72e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Si-Wei Liu <si-wei.liu@oracle.com>

In some cases, the access to the virtqueue's descriptor area, device
and driver areas (precluding indirect descriptor table in guest memory)
may have to be confined to a different address space than where its
buffers reside. Without loss of simplicity and generality with already
established terminology, let's fold up these 3 areas and call them
as a whole as descriptor table group, or descriptor group for short.
Specifically, in case of split virtqueues, descriptor group consists of
regions for Descriptor Table, Available Ring and Used Ring; for packed
virtqueues layout, descriptor group contains Descriptor Ring, Driver
and Device Event Suppression structures.

The group ID for a dedicated descriptor group can be obtained through a
new .get_vq_desc_group() op. If driver implements this op, it means that
the descriptor, device and driver areas of the virtqueue may reside
in a dedicated group than where its buffers reside, a.k.a the default
virtqueue group through the .get_vq_group() op.

In principle, the descriptor group may or may not have same group ID
as the default group. Even if the descriptor group has a different ID,
meaning the vq's descriptor group areas can optionally move to a
separate address space than where guest memory resides, the descriptor
group may still start from a default address space, same as where its
buffers reside. To move the descriptor group to a different address
space, .set_group_asid() has to be called to change the ASID binding
for the group, which is no different than what needs to be done on any
other virtqueue group. On the other hand, the .reset() semantics also
applies on descriptor table group, meaning the device reset will clear
all ASID bindings and move all virtqueue groups including descriptor
group back to the default address space, i.e. in ASID 0.

QEMU's shadow virtqueue is going to utilize dedicated descriptor group
to speed up map and unmap operations, yielding tremendous downtime
reduction by avoiding the full and slow remap cycle in SVQ switching.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 0e652026b776..d376309b99cf 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -204,6 +204,16 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns u32: group id for this virtqueue
+ * @get_vq_desc_group:		Get the group id for the descriptor table of
+ *				a specific virtqueue (optional)
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				Returns u32: group id for the descriptor table
+ *				portion of this virtqueue. Could be different
+ *				than the one from @get_vq_group, in which case
+ *				the access to the descriptor table can be
+ *				confined to a separate asid, isolating from
+ *				the virtqueue's buffer address access.
  * @get_device_features:	Get virtio features supported by the device
  *				@vdev: vdpa device
  *				Returns the virtio features support by the
@@ -360,6 +370,7 @@ struct vdpa_config_ops {
 	/* Device ops */
 	u32 (*get_vq_align)(struct vdpa_device *vdev);
 	u32 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);
+	u32 (*get_vq_desc_group)(struct vdpa_device *vdev, u16 idx);
 	u64 (*get_device_features)(struct vdpa_device *vdev);
 	u64 (*get_backend_features)(const struct vdpa_device *vdev);
 	int (*set_driver_features)(struct vdpa_device *vdev, u64 features);
-- 
2.41.0

