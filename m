Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032977C4AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345752AbjJKGnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbjJKGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01D3B8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697006579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8XfKBq2pmFc/Yny5pdd3hd4sd8TR2HWxYu52ROyThk=;
        b=d12E2CWimQfAHJTaeBq5l3vl1whAGzrP97mYzBi1C1Ljl0sKpkHS0Jwt7KEUnjaQIUd5oW
        xzVOQBIkQ8fdRyOcmhhb+G+AzAZKrPKLX55l2QXCd3CIyE5Hl4fe08nPOlFyVYNviiCe+b
        fPrtBkIbcOlDS3LLjcQL56ZDpQT50UU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-6Uomc1_pNba6ikcqIYWJBQ-1; Wed, 11 Oct 2023 02:42:55 -0400
X-MC-Unique: 6Uomc1_pNba6ikcqIYWJBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 997D28F5DA3;
        Wed, 11 Oct 2023 06:42:55 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07AD01C06533;
        Wed, 11 Oct 2023 06:42:52 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, jasowang@redhat.com, mst@redhat.com,
        xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
        maxime.coquelin@redhat.com
Subject: [PATCH v1 4/4] vduse: update the vq_info in ioctl
Date:   Wed, 11 Oct 2023 14:42:08 +0800
Message-Id: <20231011064208.2143245-5-lulu@redhat.com>
In-Reply-To: <20231011064208.2143245-1-lulu@redhat.com>
References: <20231011064208.2143245-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In VDUSE_VQ_GET_INFO, the driver will sync the last_avail_idx
with reconnect info, After mapping the reconnect pages to userspace
The userspace App will update the reconnect_time in
struct vhost_reconnect_vring, If this is not 0 then it means this
vq is reconnected and will update the last_avail_idx

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0f15e7ac716b..42e7a90ab74c 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1213,6 +1213,9 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		struct vduse_vq_info vq_info;
 		struct vduse_virtqueue *vq;
 		u32 index;
+		struct vdpa_reconnect_info *area;
+		struct vhost_reconnect_vring *vq_reconnect;
+		struct vhost_reconnect_data *dev_reconnect;
 
 		ret = -EFAULT;
 		if (copy_from_user(&vq_info, argp, sizeof(vq_info)))
@@ -1244,6 +1247,19 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 
 		vq_info.ready = vq->ready;
 
+		area = &dev->reconnect_status;
+		dev_reconnect = (struct vhost_reconnect_data *)area->vaddr;
+
+		area = &vq->reconnect_info;
+		vq_reconnect = (struct vhost_reconnect_vring *)area->vaddr;
+		/*check if the vq is reconnect, if yes then update the last_avail_idx*/
+		if ((vq_reconnect->last_avail_idx !=
+		     vq_info.split.avail_index) &&
+		    (dev_reconnect->reconnect_time != 0)) {
+			vq_info.split.avail_index =
+				vq_reconnect->last_avail_idx;
+		}
+
 		ret = -EFAULT;
 		if (copy_to_user(argp, &vq_info, sizeof(vq_info)))
 			break;
-- 
2.34.3

