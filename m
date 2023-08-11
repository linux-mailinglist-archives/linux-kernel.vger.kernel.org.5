Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDE7778990
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjHKJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjHKJQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8852BE68
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691745348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LQBmta8pc+NYKoro9UNdo+KD0UPE0FKfj4Wbe449MU4=;
        b=JiPEmRmgKWq/4WpY/jQbYcMGRPlzd0nNlRWeB3SOUMbUI3bj2pc2QlnG7NCeGKLlizB7Nk
        SoHN7PCQYLJuK+ULbpHjFN2fbRxBzUziY8fR1aQLS5ZEZudInspZ9fDrDfO0ho9wIMSEP4
        mnnORW/kMl8Tdb2HYnca4vgiBpjjRhk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-Sxx8NVRtOrmMa9s-m51a-Q-1; Fri, 11 Aug 2023 05:15:45 -0400
X-MC-Unique: Sxx8NVRtOrmMa9s-m51a-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36913817078;
        Fri, 11 Aug 2023 09:15:45 +0000 (UTC)
Received: from dell-per430-12.lab.eng.pek2.redhat.com (dell-per430-12.lab.eng.pek2.redhat.com [10.73.196.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E568492B0F;
        Fri, 11 Aug 2023 09:15:42 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com
Subject: [PATCH] virtio_vdpa: build affinity masks conditionally
Date:   Fri, 11 Aug 2023 05:15:39 -0400
Message-Id: <20230811091539.1359865-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We try to build affinity mask via create_affinity_masks()
unconditionally which may lead several issues:

- the affinity mask is not used for parent without affinity support
  (only VDUSE support the affinity now)
- the logic of create_affinity_masks() might not work for devices
  other than block. For example it's not rare in the networking device
  where the number of queues could exceed the number of CPUs. Such
  case breaks the current affinity logic which is based on
  group_cpus_evenly() who assumes the number of CPUs are not less than
  the number of groups. This can trigger a warning[1]:

	if (ret >= 0)
		WARN_ON(nr_present + nr_others < numgrps);

Fixing this by only build the affinity masks only when

- Driver passes affinity descriptor, driver like virtio-blk can make
  sure to limit the number of queues when it exceeds the number of CPUs
- Parent support affinity setting config ops

This help to avoid the warning. More optimizations could be done on
top.

[1]
[  682.146655] WARNING: CPU: 6 PID: 1550 at lib/group_cpus.c:400 group_cpus_evenly+0x1aa/0x1c0
[  682.146668] CPU: 6 PID: 1550 Comm: vdpa Not tainted 6.5.0-rc5jason+ #79
[  682.146671] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[  682.146673] RIP: 0010:group_cpus_evenly+0x1aa/0x1c0
[  682.146676] Code: 4c 89 e0 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc e8 1b c4 74 ff 48 89 ef e8 13 ac 98 ff 4c 89 e7 45 31 e4 e8 08 ac 98 ff eb c2 <0f> 0b eb b6 e8 fd 05 c3 00 45 31 e4 eb e5 cc cc cc cc cc cc cc cc
[  682.146679] RSP: 0018:ffffc9000215f498 EFLAGS: 00010293
[  682.146682] RAX: 000000000001f1e0 RBX: 0000000000000041 RCX: 0000000000000000
[  682.146684] RDX: ffff888109922058 RSI: 0000000000000041 RDI: 0000000000000030
[  682.146686] RBP: ffff888109922058 R08: ffffc9000215f498 R09: ffffc9000215f4a0
[  682.146687] R10: 00000000000198d0 R11: 0000000000000030 R12: ffff888107e02800
[  682.146689] R13: 0000000000000030 R14: 0000000000000030 R15: 0000000000000041
[  682.146692] FS:  00007fef52315740(0000) GS:ffff888237380000(0000) knlGS:0000000000000000
[  682.146695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  682.146696] CR2: 00007fef52509000 CR3: 0000000110dbc004 CR4: 0000000000370ee0
[  682.146698] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  682.146700] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  682.146701] Call Trace:
[  682.146703]  <TASK>
[  682.146705]  ? __warn+0x7b/0x130
[  682.146709]  ? group_cpus_evenly+0x1aa/0x1c0
[  682.146712]  ? report_bug+0x1c8/0x1e0
[  682.146717]  ? handle_bug+0x3c/0x70
[  682.146721]  ? exc_invalid_op+0x14/0x70
[  682.146723]  ? asm_exc_invalid_op+0x16/0x20
[  682.146727]  ? group_cpus_evenly+0x1aa/0x1c0
[  682.146729]  ? group_cpus_evenly+0x15c/0x1c0
[  682.146731]  create_affinity_masks+0xaf/0x1a0
[  682.146735]  virtio_vdpa_find_vqs+0x83/0x1d0
[  682.146738]  ? __pfx_default_calc_sets+0x10/0x10
[  682.146742]  virtnet_find_vqs+0x1f0/0x370
[  682.146747]  virtnet_probe+0x501/0xcd0
[  682.146749]  ? vp_modern_get_status+0x12/0x20
[  682.146751]  ? get_cap_addr.isra.0+0x10/0xc0
[  682.146754]  virtio_dev_probe+0x1af/0x260
[  682.146759]  really_probe+0x1a5/0x410

Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading mechanism")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 961161da5900..06ce6d8c2e00 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -366,11 +366,14 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	struct irq_affinity default_affd = { 0 };
 	struct cpumask *masks;
 	struct vdpa_callback cb;
+	bool has_affinity = desc && ops->set_vq_affinity;
 	int i, err, queue_idx = 0;
 
-	masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
-	if (!masks)
-		return -ENOMEM;
+	if (has_affinity) {
+		masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
+		if (!masks)
+			return -ENOMEM;
+	}
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
@@ -386,20 +389,22 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			goto err_setup_vq;
 		}
 
-		if (ops->set_vq_affinity)
+		if (has_affinity)
 			ops->set_vq_affinity(vdpa, i, &masks[i]);
 	}
 
 	cb.callback = virtio_vdpa_config_cb;
 	cb.private = vd_dev;
 	ops->set_config_cb(vdpa, &cb);
-	kfree(masks);
+	if (has_affinity)
+		kfree(masks);
 
 	return 0;
 
 err_setup_vq:
 	virtio_vdpa_del_vqs(vdev);
-	kfree(masks);
+	if (has_affinity)
+		kfree(masks);
 	return err;
 }
 
-- 
2.39.3

