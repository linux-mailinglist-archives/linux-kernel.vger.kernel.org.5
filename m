Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8222978538E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjHWJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjHWJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:09:19 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6932698;
        Wed, 23 Aug 2023 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1692781350; x=1724317350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oI7WaSSzBnMsKCyZ9Y7kcnjkBrkJZzum167IBrJQx+M=;
  b=GyVF6tvnhEkwbadaDFSnyryOu81K5/akWuXR2VoJo+80jvGwGt0C8zsI
   86kcYrtsa4ZknQ0YuKGtT8SYAz5o+6D/9DzIu0MSgTlkeYNwYb728GNon
   dDTLMyNh9l9Vdu7q9jEhAcmiOaK0CSM16IfNyo8MRrynFvmGVhJUZrCfJ
   c=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="346953253"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:01:36 +0000
Received: from EX19D016EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com (Postfix) with ESMTPS id 81EF740D9C;
        Wed, 23 Aug 2023 09:01:34 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19D016EUA004.ant.amazon.com (10.252.50.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 23 Aug 2023 09:01:33 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.9) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 23 Aug 2023 09:01:27 +0000
From:   Babis Chalios <bchalios@amazon.es>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <bchalios@amazon.es>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        <aams@amazon.de>, <dwmw@amazon.co.uk>, <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 2/2] virtio-rng: implement entropy leak feature
Date:   Wed, 23 Aug 2023 11:01:06 +0200
Message-ID: <20230823090107.65749-3-bchalios@amazon.es>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230823090107.65749-1-bchalios@amazon.es>
References: <20230823090107.65749-1-bchalios@amazon.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.1.212.9]
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the virtio-rng entropy leak feature that allows the guest
driver to request from the device to perform certain operations in the
event of an "entropy leak", such as when taking a VM snapshot. The guest
can request one of two operations: (i) fill a buffer with random bytes,
or (ii) perform a memory copy between two buffers.

The feature is similar to Microsoft's Virtual Machine Generation ID and
it can be used to (1) avoid the race-condition that exists in our
current VMGENID implementation, between the time vcpus are resumed and
the ACPI notification is being handled and (2) propagate these events to
user space through the random.c epoch mechanism.

This commit implements the protocol between guest and device.
Moreover, it makes sure that there is always a request from random bytes
in flight. It uses these bytes as fresh entropy upon a snapshot.
Finally, it programs the device to bump the random.c epoch when a
snapshot occurs.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/char/hw_random/virtio-rng.c | 189 +++++++++++++++++++++++++++-
 include/uapi/linux/virtio_rng.h     |   3 +
 2 files changed, 187 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index e41a84e6b4b5..469e0c522dbf 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -13,12 +13,29 @@
 #include <linux/virtio_rng.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/random.h>
 
 static DEFINE_IDA(rng_index_ida);
 
+struct virtrng_leak_queue {
+	/* The underlying virtqueue of this leak queue */
+	struct virtqueue *vq;
+	/* The next epoch value the device should write through this leak queue */
+	struct rand_epoch_data next_epoch;
+};
+
+struct virtrng_leak_queue;
+
 struct virtrng_info {
 	struct hwrng hwrng;
 	struct virtqueue *vq;
+
+	/* Leak queues */
+	bool has_leakqs;
+	struct virtrng_leak_queue leakq[2];
+	int active_leakq;
+	struct rng_epoch_notifier epoch_notifier;
+
 	char name[25];
 	int index;
 	bool hwrng_register_done;
@@ -30,11 +47,118 @@ struct virtrng_info {
 	/* minimal size returned by rng_buffer_size() */
 #if SMP_CACHE_BYTES < 32
 	u8 data[32];
+	u8 leak_data[32];
 #else
 	u8 data[SMP_CACHE_BYTES];
+	u8 leak_data[SMP_CACHE_BYTES];
 #endif
 };
 
+static struct virtrng_leak_queue *vq_to_leakq(struct virtrng_info *vi,
+		struct virtqueue *vq)
+{
+	return &vi->leakq[vq->index - 1];
+}
+
+/*
+ * Swaps the queues and returns the new active leak queue.
+ * It assumes that the leak queues' lock is being held
+ */
+static void swap_leakqs(struct virtrng_info *vi)
+{
+	vi->active_leakq = 1 - vi->active_leakq;
+}
+
+static struct virtrng_leak_queue *get_active_leakq(struct virtrng_info *vi)
+{
+	return &vi->leakq[vi->active_leakq];
+}
+
+/*
+ * Create the next epoch value that we will write through the leak queue.
+ *
+ * Subsequent epoch values will be written through alternate leak queues,
+ * so the next epoch value for each queue will be:
+ *
+ * *-------------*----------------------------------------------*
+ * | notifier_id | (current_epoch + 2) & RNG_EPOCH_COUNTER_MASK |
+ * *-------------*----------------------------------------------*
+ */
+static void prepare_next_epoch(struct virtrng_info *vi, struct virtrng_leak_queue *leakq)
+{
+	leakq->next_epoch.data = ((leakq->next_epoch.data + 2) & RNG_EPOCH_COUNTER_MASK) |
+		 (vi->epoch_notifier.id << RNG_EPOCH_ID_SHIFT);
+}
+
+static int do_fill_on_leak_request(struct virtrng_info *vi, struct virtqueue *vq, void *data,
+				    size_t len)
+{
+	struct scatterlist sg;
+
+	sg_init_one(&sg, data, len);
+	return virtqueue_add_inbuf(vq, &sg, 1, data, GFP_KERNEL);
+}
+
+static int do_copy_on_leak_request(struct virtrng_info *vi, struct virtqueue *vq,
+				   void *to, void *from, size_t len)
+{
+	struct scatterlist out, in, *sgs[2];
+
+	sg_init_one(&out, from, len);
+	sgs[0] = &out;
+	sg_init_one(&in, to, len);
+	sgs[1] = &in;
+
+	return virtqueue_add_sgs(vq, sgs, 1, 1, to, GFP_KERNEL);
+}
+
+static int add_entropy_leak_requests(struct virtrng_info *vi, struct virtrng_leak_queue *leakq)
+{
+	do_fill_on_leak_request(vi, leakq->vq, &vi->leak_data, sizeof(vi->leak_data));
+	/* Make sure the device writes the next valid epoch value */
+	do_copy_on_leak_request(vi, leakq->vq, vi->epoch_notifier.epoch, &leakq->next_epoch,
+			sizeof(u32));
+
+	return 0;
+}
+
+static void entropy_leak_detected(struct virtqueue *vq)
+{
+	struct virtrng_info *vi = vq->vdev->priv;
+	struct virtrng_leak_queue *activeq = get_active_leakq(vi);
+	struct virtrng_leak_queue *leakq = vq_to_leakq(vi, vq);
+	unsigned int len;
+	void *buffer;
+
+	/*
+	 * The first time we see a used buffer in the active leak queue we swap queues
+	 * so that new commands are added in the new active leak queue.
+	 */
+	if (vq == activeq->vq) {
+		pr_info("%s: entropy leak detected!", vi->name);
+		swap_leakqs(vi);
+	}
+
+	/* Drain all the used buffers from the queue */
+	while ((buffer = virtqueue_get_buf(vq, &len)) != NULL) {
+		if (buffer == vi->leak_data) {
+			add_device_randomness(vi->leak_data, sizeof(vi->leak_data));
+
+			/*
+			 * Ensure we always have a pending request for random bytes on entropy
+			 * leak. Do it here, after we have swapped leak queues, so it gets handled
+			 * with the next entropy leak event.
+			 */
+			do_fill_on_leak_request(vi, vq, &vi->leak_data, sizeof(vi->leak_data));
+		} else if (buffer == &vi->epoch_notifier.epoch->data) {
+			/* Also, ensure we always have a pending request for bumping the epoch */
+			prepare_next_epoch(vi, leakq);
+			do_copy_on_leak_request(vi, vq, &vi->epoch_notifier.epoch->data,
+					&leakq->next_epoch, sizeof(leakq->next_epoch));
+		}
+	}
+}
+
 static void random_recv_done(struct virtqueue *vq)
 {
 	struct virtrng_info *vi = vq->vdev->priv;
@@ -126,6 +250,51 @@ static void virtio_cleanup(struct hwrng *rng)
 	complete(&vi->have_data);
 }
 
+static int init_virtqueues(struct virtrng_info *vi, struct virtio_device *vdev)
+{
+	int ret, vqs_nr = 1;
+	struct virtqueue *vqs[3];
+	const char *names[3];
+	vq_callback_t *callbacks[3];
+
+	callbacks[0] = random_recv_done;
+	names[0] = "input";
+
+	if (vi->has_leakqs) {
+		vqs_nr = 3;
+		vi->active_leakq = 0;
+
+		/* Register with random.c to get epoch info */
+		ret = rng_register_epoch_notifier(&vi->epoch_notifier);
+		if (ret)
+			goto err_register_epoch;
+
+		callbacks[1] = entropy_leak_detected;
+		names[1] = "leakq.1";
+		callbacks[2] = entropy_leak_detected;
+		names[2] = "leakq.2";
+	}
+
+	ret = virtio_find_vqs(vdev, vqs_nr, vqs, callbacks, names, NULL);
+	if (ret)
+		goto err_find_vqs;
+
+	vi->vq = vqs[0];
+	if (vi->has_leakqs) {
+		vi->leakq[0].vq = vqs[1];
+		vi->leakq[0].next_epoch.data = 1;
+		vi->leakq[1].vq = vqs[2];
+		vi->leakq[1].next_epoch.data = 2;
+	}
+
+	return 0;
+
+err_find_vqs:
+	rng_unregister_epoch_notifier(&vi->epoch_notifier);
+err_register_epoch:
+	return ret;
+}
+
 static int probe_common(struct virtio_device *vdev)
 {
 	int err, index;
@@ -151,18 +320,22 @@ static int probe_common(struct virtio_device *vdev)
 	};
 	vdev->priv = vi;
 
-	/* We expect a single virtqueue. */
-	vi->vq = virtio_find_single_vq(vdev, random_recv_done, "input");
-	if (IS_ERR(vi->vq)) {
-		err = PTR_ERR(vi->vq);
+	vi->has_leakqs = virtio_has_feature(vdev, VIRTIO_RNG_F_LEAK);
+	err = init_virtqueues(vi, vdev);
+	if (err)
 		goto err_find;
-	}
 
 	virtio_device_ready(vdev);
 
 	/* we always have a pending entropy request */
 	request_entropy(vi);
 
+	if (vi->has_leakqs) {
+		/* we always have entropy-leak requests pending */
+		add_entropy_leak_requests(vi, &vi->leakq[0]);
+		add_entropy_leak_requests(vi, &vi->leakq[1]);
+	}
+
 	return 0;
 
 err_find:
@@ -245,7 +418,13 @@ static const struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
+static unsigned int features[] = {
+	VIRTIO_RNG_F_LEAK,
+};
+
 static struct virtio_driver virtio_rng_driver = {
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
diff --git a/include/uapi/linux/virtio_rng.h b/include/uapi/linux/virtio_rng.h
index c4d5de896f0c..d9774951547e 100644
--- a/include/uapi/linux/virtio_rng.h
+++ b/include/uapi/linux/virtio_rng.h
@@ -5,4 +5,7 @@
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
+/* The feature bitmap for virtio entropy device */
+#define VIRTIO_RNG_F_LEAK 0
+
 #endif /* _LINUX_VIRTIO_RNG_H */
-- 
2.40.1

