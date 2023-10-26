Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46A7D7D79
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbjJZHRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZHRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:17:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71298129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:17:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q3IwDq026220;
        Thu, 26 Oct 2023 07:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=XMke14vYG8UhRAuK8/FbiZ7AEIT4nF/4fIUeZ85zpTE=;
 b=Xa7jnPMrl+wrKfOMrQoVQyn9TCLQsA/mT++ti49h5mvKvibcatJgSbr3TY67ee8gR0CT
 P3qc6+Eam036bKuprn7oHovMjGeFqLuOjaRV+BrixkZSxVBH2yBqQk716Ezm9N+Luu97
 0DvzISsJZS+AMEfqyfO+okqMPBcQmUy4puSlmcJTIln4xIUZ8OW6jYTQLla5Ap/yw2VH
 uRPaCR5IpPoIHuLTWwX57X0UO5uDfB621UH1Nr/86o4AFjAsYdyhXUPdFEiCUcaYee5x
 fMGNWl6tBVuW1SjgChcdvT+fjFZQlM+e0D0dfRmtOcr/AfF5Q9esnzvzyKN62ol5HWm9 wQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52e2bvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 07:17:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q6tbAG015200;
        Thu, 26 Oct 2023 07:17:27 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv537t53r-3;
        Thu, 26 Oct 2023 07:17:27 +0000
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        sgarzare@redhat.com, dtatulea@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/7] vhost-vdpa: reset vendor specific mapping to initial state in .release
Date:   Thu, 26 Oct 2023 00:14:35 -0700
Message-Id: <1698304480-18463-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
References: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260060
X-Proofpoint-ORIG-GUID: fzDfqj1sz6XISLEWFKDdIR-3bLDD2bz7
X-Proofpoint-GUID: fzDfqj1sz6XISLEWFKDdIR-3bLDD2bz7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices with on-chip IOMMU or vendor specific IOTLB implementation may
need to restore iotlb mapping to the initial or default state using the
.reset_map op, as it's desirable for some parent devices to not work
with DMA ops and maintain a simple IOMMU model with .reset_map. In
particular, device reset should not cause mapping to go away on such
IOTLB model, so persistent mapping is implied across reset. Before the
userspace process using vhost-vdpa is gone, give it a chance to reset
iotlb back to the initial state in vhost_vdpa_cleanup().

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vhost/vdpa.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 851535f57b95..c6bfe9bdde42 100644
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
@@ -140,6 +149,14 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
 
 	hlist_del(&as->hash_link);
 	vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
+	/*
+	 * Devices with vendor specific IOMMU may need to restore
+	 * iotlb to the initial or default state, which cannot be
+	 * cleaned up in the all range unmap call above. Give them
+	 * a chance to clean up or reset the map to the desired
+	 * state.
+	 */
+	vhost_vdpa_reset_map(v, asid);
 	kfree(as);
 
 	return 0;
-- 
2.39.3

