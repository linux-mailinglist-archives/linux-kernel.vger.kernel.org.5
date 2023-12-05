Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF4805313
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346896AbjLELf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347069AbjLELe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:34:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5426D5A;
        Tue,  5 Dec 2023 03:34:58 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Skyz22Ct0zrVFD;
        Tue,  5 Dec 2023 19:31:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 19:34:56 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        <virtualization@lists.linux.dev>
Subject: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
Date:   Tue, 5 Dec 2023 19:34:44 +0800
Message-ID: <20231205113444.63015-7-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231205113444.63015-1-linyunsheng@huawei.com>
References: <20231205113444.63015-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

introduce vhost_net_test basing on virtio_test to test
vhost_net changing in the kernel.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 tools/virtio/Makefile         |   8 +-
 tools/virtio/vhost_net_test.c | 441 ++++++++++++++++++++++++++++++++++
 2 files changed, 446 insertions(+), 3 deletions(-)
 create mode 100644 tools/virtio/vhost_net_test.c

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index d128925980e0..e25e99c1c3b7 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 all: test mod
-test: virtio_test vringh_test
+test: virtio_test vringh_test vhost_net_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
+vhost_net_test: virtio_ring.o vhost_net_test.o
 
 try-run = $(shell set -e;		\
 	if ($(1)) >/dev/null 2>&1;	\
@@ -49,6 +50,7 @@ oot-clean: OOT_BUILD+=clean
 
 .PHONY: all test mod clean vhost oot oot-clean oot-build
 clean:
-	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
-              vhost_test/Module.symvers vhost_test/modules.order *.d
+	${RM} *.o vringh_test virtio_test vhost_net_test vhost_test/*.o \
+              vhost_test/.*.cmd vhost_test/Module.symvers \
+              vhost_test/modules.order *.d
 -include *.d
diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.c
new file mode 100644
index 000000000000..7e7b7aba3668
--- /dev/null
+++ b/tools/virtio/vhost_net_test.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <getopt.h>
+#include <limits.h>
+#include <string.h>
+#include <poll.h>
+#include <sys/eventfd.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <linux/virtio_types.h>
+#include <linux/vhost.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+
+#define RANDOM_BATCH -1
+
+static int tun_alloc(void)
+{
+	struct ifreq ifr;
+	int fd, e;
+
+	fd = open("/dev/net/tun", O_RDWR);
+	if (fd < 0) {
+		perror("Cannot open /dev/net/tun");
+		return fd;
+	}
+
+	memset(&ifr, 0, sizeof(ifr));
+
+	ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
+	strncpy(ifr.ifr_name, "tun0", IFNAMSIZ);
+
+	e = ioctl(fd, TUNSETIFF, (void *) &ifr);
+	if (e < 0) {
+		perror("ioctl[TUNSETIFF]");
+		close(fd);
+		return e;
+	}
+
+	return fd;
+}
+
+/* Unused */
+void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
+
+struct vq_info {
+	int kick;
+	int call;
+	int num;
+	int idx;
+	void *ring;
+	/* copy used for control */
+	struct vring vring;
+	struct virtqueue *vq;
+};
+
+struct vdev_info {
+	struct virtio_device vdev;
+	int control;
+	struct pollfd fds[1];
+	struct vq_info vqs[1];
+	int nvqs;
+	void *buf;
+	size_t buf_size;
+	struct vhost_memory *mem;
+};
+
+static struct vhost_vring_file no_backend = { .index = 1, .fd = -1 },
+				     backend = { .index = 1, .fd = 1 };
+static const struct vhost_vring_state null_state = {};
+
+bool vq_notify(struct virtqueue *vq)
+{
+	struct vq_info *info = vq->priv;
+	unsigned long long v = 1;
+	int r;
+	r = write(info->kick, &v, sizeof v);
+	assert(r == sizeof v);
+	return true;
+}
+
+void vq_callback(struct virtqueue *vq)
+{
+}
+
+
+void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
+{
+	struct vhost_vring_state state = { .index = info->idx };
+	struct vhost_vring_file file = { .index = info->idx };
+	unsigned long long features = dev->vdev.features;
+	struct vhost_vring_addr addr = {
+		.index = info->idx,
+		.desc_user_addr = (uint64_t)(unsigned long)info->vring.desc,
+		.avail_user_addr = (uint64_t)(unsigned long)info->vring.avail,
+		.used_user_addr = (uint64_t)(unsigned long)info->vring.used,
+	};
+	int r;
+	r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
+	assert(r >= 0);
+	state.num = info->vring.num;
+	r = ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
+	assert(r >= 0);
+	state.num = 0;
+	r = ioctl(dev->control, VHOST_SET_VRING_BASE, &state);
+	assert(r >= 0);
+	r = ioctl(dev->control, VHOST_SET_VRING_ADDR, &addr);
+	assert(r >= 0);
+	file.fd = info->kick;
+	r = ioctl(dev->control, VHOST_SET_VRING_KICK, &file);
+	assert(r >= 0);
+	file.fd = info->call;
+	r = ioctl(dev->control, VHOST_SET_VRING_CALL, &file);
+	assert(r >= 0);
+}
+
+static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
+{
+	if (info->vq)
+		vring_del_virtqueue(info->vq);
+
+	memset(info->ring, 0, vring_size(num, 4096));
+	vring_init(&info->vring, num, info->ring, 4096);
+	info->vq = vring_new_virtqueue(info->idx, num, 4096, vdev, true, false,
+				       info->ring, vq_notify, vq_callback, "test");
+	assert(info->vq);
+	info->vq->priv = info;
+}
+
+static void vq_info_add(struct vdev_info *dev, int num)
+{
+	struct vq_info *info = &dev->vqs[dev->nvqs];
+	int r;
+
+	/* use VHOST_NET_VQ_TX for testing */
+	info->idx = 1;
+	info->kick = eventfd(0, EFD_NONBLOCK);
+	info->call = eventfd(0, EFD_NONBLOCK);
+	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
+	assert(r >= 0);
+	vq_reset(info, num, &dev->vdev);
+	vhost_vq_setup(dev, info);
+	dev->fds[0].fd = info->call;
+	dev->fds[0].events = POLLIN;
+	dev->nvqs++;
+}
+
+static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
+{
+	int r;
+	memset(dev, 0, sizeof *dev);
+	dev->vdev.features = features;
+	INIT_LIST_HEAD(&dev->vdev.vqs);
+	spin_lock_init(&dev->vdev.vqs_list_lock);
+	dev->buf_size = 1024;
+	dev->buf = malloc(dev->buf_size);
+	assert(dev->buf);
+	dev->control = open("/dev/vhost-net", O_RDWR);
+	assert(dev->control >= 0);
+	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
+	assert(r >= 0);
+	dev->mem = malloc(offsetof(struct vhost_memory, regions) +
+			  sizeof dev->mem->regions[0]);
+	assert(dev->mem);
+	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
+                          sizeof dev->mem->regions[0]);
+	dev->mem->nregions = 1;
+	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
+	dev->mem->regions[0].userspace_addr = (long)dev->buf;
+	dev->mem->regions[0].memory_size = dev->buf_size;
+	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
+	assert(r >= 0);
+}
+
+/* TODO: this is pretty bad: we get a cache line bounce
+ * for the wait queue on poll and another one on read,
+ * plus the read which is there just to clear the
+ * current state. */
+static void wait_for_interrupt(struct vdev_info *dev)
+{
+	int i;
+	unsigned long long val;
+	poll(dev->fds, dev->nvqs, -1);
+	for (i = 0; i < dev->nvqs; ++i)
+		if (dev->fds[i].revents & POLLIN) {
+			read(dev->fds[i].fd, &val, sizeof val);
+		}
+}
+
+static void run_test(struct vdev_info *dev, struct vq_info *vq,
+		     bool delayed, int batch, int reset_n, int bufs)
+{
+	struct scatterlist sl;
+	long started = 0, completed = 0, next_reset = reset_n;
+	long completed_before, started_before;
+	int r;
+	unsigned int len;
+	long long spurious = 0;
+	const bool random_batch = batch == RANDOM_BATCH;
+
+	r = ioctl(dev->control, VHOST_NET_SET_BACKEND, &backend);
+	assert(!r);
+
+	if (!reset_n) {
+		next_reset = INT_MAX;
+	}
+
+	for (;;) {
+		virtqueue_disable_cb(vq->vq);
+		completed_before = completed;
+		started_before = started;
+		do {
+			const bool reset = completed > next_reset;
+			if (random_batch)
+				batch = (random() % vq->vring.num) + 1;
+
+			while (started < bufs &&
+			       (started - completed) < batch) {
+				sg_init_one(&sl, dev->buf, dev->buf_size);
+				r = virtqueue_add_outbuf(vq->vq, &sl, 1,
+							 dev->buf + started,
+							 GFP_ATOMIC);
+				if (unlikely(r != 0)) {
+					if (r == -ENOSPC &&
+					    started > started_before)
+						r = 0;
+					else
+						r = -1;
+					break;
+				}
+
+				++started;
+
+				if (unlikely(!virtqueue_kick(vq->vq))) {
+					r = -1;
+					break;
+				}
+			}
+
+			if (started >= bufs)
+				r = -1;
+
+			if (reset) {
+				r = ioctl(dev->control, VHOST_NET_SET_BACKEND,
+					  &no_backend);
+				assert(!r);
+			}
+
+			/* Flush out completed bufs if any */
+			while (virtqueue_get_buf(vq->vq, &len)) {
+				++completed;
+				r = 0;
+			}
+
+			if (reset) {
+				struct vhost_vring_state s = { .index = 0 };
+
+				vq_reset(vq, vq->vring.num, &dev->vdev);
+
+				r = ioctl(dev->control, VHOST_GET_VRING_BASE,
+					  &s);
+				assert(!r);
+
+				s.num = 0;
+				r = ioctl(dev->control, VHOST_SET_VRING_BASE,
+					  &null_state);
+				assert(!r);
+
+				r = ioctl(dev->control, VHOST_NET_SET_BACKEND,
+					  &backend);
+				assert(!r);
+
+				started = completed;
+				while (completed > next_reset)
+					next_reset += completed;
+			}
+		} while (r == 0);
+		if (completed == completed_before && started == started_before)
+			++spurious;
+		assert(completed <= bufs);
+		assert(started <= bufs);
+		if (completed == bufs)
+			break;
+		if (delayed) {
+			if (virtqueue_enable_cb_delayed(vq->vq))
+				wait_for_interrupt(dev);
+		} else {
+			if (virtqueue_enable_cb(vq->vq))
+				wait_for_interrupt(dev);
+		}
+	}
+	fprintf(stderr,
+		"spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
+		spurious, started, completed);
+}
+
+const char optstring[] = "h";
+const struct option longopts[] = {
+	{
+		.name = "help",
+		.val = 'h',
+	},
+	{
+		.name = "event-idx",
+		.val = 'E',
+	},
+	{
+		.name = "no-event-idx",
+		.val = 'e',
+	},
+	{
+		.name = "indirect",
+		.val = 'I',
+	},
+	{
+		.name = "no-indirect",
+		.val = 'i',
+	},
+	{
+		.name = "virtio-1",
+		.val = '1',
+	},
+	{
+		.name = "no-virtio-1",
+		.val = '0',
+	},
+	{
+		.name = "delayed-interrupt",
+		.val = 'D',
+	},
+	{
+		.name = "no-delayed-interrupt",
+		.val = 'd',
+	},
+	{
+		.name = "buf-num",
+		.val = 'n',
+		.has_arg = required_argument,
+	},
+	{
+		.name = "batch",
+		.val = 'b',
+		.has_arg = required_argument,
+	},
+	{
+		.name = "reset",
+		.val = 'r',
+		.has_arg = optional_argument,
+	},
+	{
+	}
+};
+
+static void help(int status)
+{
+	fprintf(stderr, "Usage: virtio_test [--help]"
+		" [--no-indirect]"
+		" [--no-event-idx]"
+		" [--no-virtio-1]"
+		" [--delayed-interrupt]"
+		" [--batch=random/N]"
+		" [--reset=N]"
+		"\n");
+
+	exit(status);
+}
+
+int main(int argc, char **argv)
+{
+	struct vdev_info dev;
+	unsigned long long features = (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
+		(1ULL << VIRTIO_RING_F_EVENT_IDX) | (1ULL << VIRTIO_F_VERSION_1);
+	long batch = 1, reset = 0, nbufs = 0x100000;
+	int o;
+	bool delayed = false;
+
+	for (;;) {
+		o = getopt_long(argc, argv, optstring, longopts, NULL);
+		switch (o) {
+		case -1:
+			goto done;
+		case '?':
+			help(2);
+		case 'e':
+			features &= ~(1ULL << VIRTIO_RING_F_EVENT_IDX);
+			break;
+		case 'h':
+			help(0);
+		case 'i':
+			features &= ~(1ULL << VIRTIO_RING_F_INDIRECT_DESC);
+			break;
+		case '0':
+			features &= ~(1ULL << VIRTIO_F_VERSION_1);
+			break;
+		case 'D':
+			delayed = true;
+			break;
+		case 'b':
+			if (0 == strcmp(optarg, "random")) {
+				batch = RANDOM_BATCH;
+			} else {
+				batch = strtol(optarg, NULL, 10);
+				assert(batch > 0);
+				assert(batch < (long)INT_MAX + 1);
+			}
+			break;
+		case 'r':
+			if (!optarg) {
+				reset = 1;
+			} else {
+				reset = strtol(optarg, NULL, 10);
+				assert(reset > 0);
+				assert(reset < (long)INT_MAX + 1);
+			}
+			break;
+		case 'n':
+			nbufs = strtol(optarg, NULL, 10);
+			assert(nbufs > 0);
+			break;
+		default:
+			assert(0);
+			break;
+		}
+	}
+
+done:
+	backend.fd = tun_alloc();
+	assert(backend.fd >= 0);
+	vdev_info_init(&dev, features);
+	vq_info_add(&dev, 256);
+	run_test(&dev, &dev.vqs[0], delayed, batch, reset, nbufs);
+	return 0;
+}
-- 
2.33.0

