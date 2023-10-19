Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2436F7CED4C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJSBNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJSBNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:13:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6A512E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:13:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IImtCv006120;
        Thu, 19 Oct 2023 01:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=IDcJMsPyKM2GyU6ZB9/xv6m5PTlDgNod8sH4SwkNOK4=;
 b=z0MyfC57BJET8EO662IqosLoeOfIsbcyafH9SeSUdXPB/2uQ0EN8gkVx5CjtQOEOBaUd
 BYwMV555SIEovOWW9lTiPMw+7DgYI1WreSdSuKDmDZ+GitDr8iYRvU59ezJ2VdTE7BaT
 x+C0vQKLx6Z0snijcpMPmi0p5uYW67p56WL6bCk3/QvfZ5PGnApJTKy3p5iP/O8YnJjo
 nJaFqWTE1+0st3CzEe+uPH4TJpLA7CjsrsW6+d3DswHTWe7AT9g4R3/xW3CBy+uRe8nj
 F/N12RN0emJAdUJbrIwROm+inIB73u6en5IDHeTf69nBjfb1aFAA3bNIS2e+Qfj1GbIP vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjynh3n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 01:12:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J0UpS1015251;
        Thu, 19 Oct 2023 01:12:58 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3trg1h8w2d-3;
        Thu, 19 Oct 2023 01:12:58 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] vhost-vdpa: reset vendor specific mapping to initial state in .release
Date:   Wed, 18 Oct 2023 18:10:15 -0700
Message-Id: <1697677818-11371-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
References: <1697677818-11371-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_01,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190007
X-Proofpoint-GUID: RjbT_jVlQfwqzkpHOXDLP1l8Fkz6q7r8
X-Proofpoint-ORIG-GUID: RjbT_jVlQfwqzkpHOXDLP1l8Fkz6q7r8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices with on-chip IOMMU or vendor specific IOTLB implementation
may need to restore iotlb mapping to the initial or default state
using the .reset_map op, as it's desirable for some parent devices
to solely manipulate mappings by its own, independent of virtio device
state. For instance, device reset does not cause mapping go away on
such IOTLB model in need of persistent mapping. Before vhost-vdpa
is going away, give them a chance to reset iotlb back to the initial
state in vhost_vdpa_cleanup().

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vhost/vdpa.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 851535f57b95..a3f8160c9807 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
 	return vhost_vdpa_alloc_as(v, asid);
 }
 
+static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
+{
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (ops->reset_map)
+		ops->reset_map(vdpa, asid);
+}
+
 static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
 {
 	struct vhost_vdpa_as *as = asid_to_as(v, asid);
@@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
 
 	hlist_del(&as->hash_link);
 	vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
+	/*
+	 * Devices with vendor specific IOMMU may need to restore
+	 * iotlb to the initial or default state which is not done
+	 * through device reset, as the IOTLB mapping manipulation
+	 * could be decoupled from the virtio device life cycle.
+	 */
+	vhost_vdpa_reset_map(v, asid);
 	kfree(as);
 
 	return 0;
-- 
2.39.3

