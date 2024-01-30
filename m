Return-Path: <linux-kernel+bounces-44529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F2842352
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0131F25A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43076BB46;
	Tue, 30 Jan 2024 11:38:13 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547466A03A;
	Tue, 30 Jan 2024 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614692; cv=none; b=m4+gmicF33lb2RS+cooG1iLnus8dd9Teu/4dH88p78OiOYtCWwzP45hsun3OExAUxQD2iQ2eEZ/XKv27o2wxHk62/tWK/xTr/W4p6NPsTev5UmKNzuwSVxd1GsfU3AFMLHHhUqpaSsaFw5GmwhnkO1WIfmJh45GkNo9r4MUqNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614692; c=relaxed/simple;
	bh=cexFbN7tkIS6apl/vMvEeGyzs3s1WmkbCvYFJX01Uew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbaui82C6ZhG0szUi1nimgyt5d9s3b8R1n+31BX3c5Wl7tueWi7x0XQXDuYwTbjVoLl9x3V54+NgCDMuXVnQctE377HUd57dtNvbkCAFybvLjuaVaTTeQRfjyWjXhDbyIO17GE1oN1/+JHSo+OSRkew7IbpLvjSVEEE0PhjESwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TPNSk0wTTzLqKg;
	Tue, 30 Jan 2024 19:37:42 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id F00C91400FF;
	Tue, 30 Jan 2024 19:38:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 19:38:07 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>
Subject: [PATCH net-next v4 5/5] tools: virtio: introduce vhost_net_test
Date: Tue, 30 Jan 2024 19:37:10 +0800
Message-ID: <20240130113710.34511-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240130113710.34511-1-linyunsheng@huawei.com>
References: <20240130113710.34511-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

introduce vhost_net_test basing on virtio_test to test
vhost_net changing in the kernel.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 tools/virtio/.gitignore       |   1 +
 tools/virtio/Makefile         |   8 +-
 tools/virtio/vhost_net_test.c | 576 ++++++++++++++++++++++++++++++++++
 3 files changed, 582 insertions(+), 3 deletions(-)
 create mode 100644 tools/virtio/vhost_net_test.c

diff --git a/tools/virtio/.gitignore b/tools/virtio/.gitignore
index 9934d48d9a55..7e47b281c442 100644
--- a/tools/virtio/.gitignore
+++ b/tools/virtio/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 *.d
 virtio_test
+vhost_net_test
 vringh_test
 virtio-trace/trace-agent
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
index 000000000000..e336792a0d77
--- /dev/null
+++ b/tools/virtio/vhost_net_test.c
@@ -0,0 +1,576 @@
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
+#include <linux/in.h>
+#include <linux/if_packet.h>
+#include <netinet/ether.h>
+
+#define RANDOM_BATCH	-1
+#define HDR_LEN		12
+#define TEST_BUF_LEN	256
+#define TEST_PTYPE	ETH_P_LOOPBACK
+
+/* Used by implementation of kmalloc() in tools/virtio/linux/kernel.h */
+void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
+
+struct vq_info {
+	int kick;
+	int call;
+	int idx;
+	long started;
+	long completed;
+	struct pollfd fds;
+	void *ring;
+	/* copy used for control */
+	struct vring vring;
+	struct virtqueue *vq;
+};
+
+struct vdev_info {
+	struct virtio_device vdev;
+	int control;
+	struct vq_info vqs[2];
+	int nvqs;
+	void *buf;
+	size_t buf_size;
+	char *test_buf;
+	char *res_buf;
+	struct vhost_memory *mem;
+	int sock;
+	int ifindex;
+	unsigned char mac[ETHER_ADDR_LEN];
+};
+
+static int tun_alloc(struct vdev_info *dev)
+{
+	struct ifreq ifr;
+	int len = HDR_LEN;
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
+	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
+	snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
+
+	e = ioctl(fd, TUNSETIFF, &ifr);
+	if (e < 0) {
+		perror("ioctl[TUNSETIFF]");
+		close(fd);
+		return e;
+	}
+
+	e = ioctl(fd, TUNSETVNETHDRSZ, &len);
+	if (e < 0) {
+		perror("ioctl[TUNSETVNETHDRSZ]");
+		close(fd);
+		return e;
+	}
+
+	e = ioctl(fd, SIOCGIFHWADDR, &ifr);
+	if (e < 0) {
+		perror("ioctl[SIOCGIFHWADDR]");
+		close(fd);
+		return e;
+	}
+
+	memcpy(dev->mac, &ifr.ifr_hwaddr.sa_data, ETHER_ADDR_LEN);
+	return fd;
+}
+
+static void vdev_create_socket(struct vdev_info *dev)
+{
+	struct ifreq ifr;
+
+	dev->sock = socket(AF_PACKET, SOCK_RAW, htons(TEST_PTYPE));
+	assert(dev->sock != -1);
+
+	snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
+	assert(ioctl(dev->sock, SIOCGIFINDEX, &ifr) >= 0);
+
+	dev->ifindex = ifr.ifr_ifindex;
+
+	/* Set the flags that bring the device up */
+	assert(ioctl(dev->sock, SIOCGIFFLAGS, &ifr) >= 0);
+	ifr.ifr_flags |= (IFF_UP | IFF_RUNNING);
+	assert(ioctl(dev->sock, SIOCSIFFLAGS, &ifr) >= 0);
+}
+
+static void vdev_send_packet(struct vdev_info *dev)
+{
+	char *sendbuf = dev->test_buf + HDR_LEN;
+	struct sockaddr_ll saddrll = {0};
+	int sockfd = dev->sock;
+	int ret;
+
+	saddrll.sll_family = PF_PACKET;
+	saddrll.sll_ifindex = dev->ifindex;
+	saddrll.sll_halen = ETH_ALEN;
+	saddrll.sll_protocol = htons(TEST_PTYPE);
+
+	ret = sendto(sockfd, sendbuf, TEST_BUF_LEN, 0,
+		     (struct sockaddr *)&saddrll,
+		     sizeof(struct sockaddr_ll));
+	assert(ret >= 0);
+}
+
+static bool vq_notify(struct virtqueue *vq)
+{
+	struct vq_info *info = vq->priv;
+	unsigned long long v = 1;
+	int r;
+
+	r = write(info->kick, &v, sizeof(v));
+	assert(r == sizeof(v));
+
+	return true;
+}
+
+static void vq_callback(struct virtqueue *vq)
+{
+}
+
+static void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
+{
+	struct vhost_vring_addr addr = {
+		.index = info->idx,
+		.desc_user_addr = (uint64_t)(unsigned long)info->vring.desc,
+		.avail_user_addr = (uint64_t)(unsigned long)info->vring.avail,
+		.used_user_addr = (uint64_t)(unsigned long)info->vring.used,
+	};
+	struct vhost_vring_state state = { .index = info->idx };
+	struct vhost_vring_file file = { .index = info->idx };
+	int r;
+
+	state.num = info->vring.num;
+	r = ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
+	assert(r >= 0);
+
+	state.num = 0;
+	r = ioctl(dev->control, VHOST_SET_VRING_BASE, &state);
+	assert(r >= 0);
+
+	r = ioctl(dev->control, VHOST_SET_VRING_ADDR, &addr);
+	assert(r >= 0);
+
+	file.fd = info->kick;
+	r = ioctl(dev->control, VHOST_SET_VRING_KICK, &file);
+	assert(r >= 0);
+
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
+static void vq_info_add(struct vdev_info *dev, int idx, int num, int fd)
+{
+	struct vhost_vring_file backend = { .index = idx, .fd = fd };
+	struct vq_info *info = &dev->vqs[idx];
+	int r;
+
+	info->idx = idx;
+	info->kick = eventfd(0, EFD_NONBLOCK);
+	info->call = eventfd(0, EFD_NONBLOCK);
+	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
+	assert(r >= 0);
+	vq_reset(info, num, &dev->vdev);
+	vhost_vq_setup(dev, info);
+	info->fds.fd = info->call;
+	info->fds.events = POLLIN;
+
+	r = ioctl(dev->control, VHOST_NET_SET_BACKEND, &backend);
+	assert(!r);
+}
+
+static void vdev_info_init(struct vdev_info *dev, unsigned long long features)
+{
+	struct ether_header *eh;
+	int i, r;
+
+	dev->vdev.features = features;
+	INIT_LIST_HEAD(&dev->vdev.vqs);
+	spin_lock_init(&dev->vdev.vqs_list_lock);
+
+	dev->buf_size = (HDR_LEN + TEST_BUF_LEN) * 2;
+	dev->buf = malloc(dev->buf_size);
+	assert(dev->buf);
+	dev->test_buf = dev->buf;
+	dev->res_buf = dev->test_buf + HDR_LEN + TEST_BUF_LEN;
+
+	memset(dev->test_buf, 0, HDR_LEN + TEST_BUF_LEN);
+	eh = (struct ether_header *)(dev->test_buf + HDR_LEN);
+	eh->ether_type = htons(TEST_PTYPE);
+	memcpy(eh->ether_dhost, dev->mac, ETHER_ADDR_LEN);
+	memcpy(eh->ether_shost, dev->mac, ETHER_ADDR_LEN);
+
+	for (i = sizeof(*eh); i < TEST_BUF_LEN; i++)
+		dev->test_buf[i + HDR_LEN] = (char)i;
+
+	dev->control = open("/dev/vhost-net", O_RDWR);
+	assert(dev->control >= 0);
+
+	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
+	assert(r >= 0);
+
+	dev->mem = malloc(offsetof(struct vhost_memory, regions) +
+			  sizeof(dev->mem->regions[0]));
+	assert(dev->mem);
+	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
+	       sizeof(dev->mem->regions[0]));
+	dev->mem->nregions = 1;
+	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
+	dev->mem->regions[0].userspace_addr = (long)dev->buf;
+	dev->mem->regions[0].memory_size = dev->buf_size;
+
+	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
+	assert(r >= 0);
+
+	r = ioctl(dev->control, VHOST_SET_FEATURES, &features);
+	assert(r >= 0);
+
+	dev->nvqs = 2;
+}
+
+static void wait_for_interrupt(struct vq_info *vq)
+{
+	unsigned long long val;
+
+	poll(&vq->fds, 1, -1);
+
+	if (vq->fds.revents & POLLIN)
+		read(vq->fds.fd, &val, sizeof(val));
+}
+
+static void verify_res_buf(char *res_buf)
+{
+	int i;
+
+	for (i = ETHER_HDR_LEN; i < TEST_BUF_LEN; i++)
+		assert(res_buf[i] == (char)i);
+}
+
+static void run_tx_test(struct vdev_info *dev, struct vq_info *vq,
+			bool delayed, int batch, int bufs)
+{
+	const bool random_batch = batch == RANDOM_BATCH;
+	long long spurious = 0;
+	struct scatterlist sl;
+	unsigned int len;
+	int r;
+
+	for (;;) {
+		long started_before = vq->started;
+		long completed_before = vq->completed;
+
+		virtqueue_disable_cb(vq->vq);
+		do {
+			if (random_batch)
+				batch = (random() % vq->vring.num) + 1;
+
+			while (vq->started < bufs &&
+			       (vq->started - vq->completed) < batch) {
+				sg_init_one(&sl, dev->test_buf, HDR_LEN + TEST_BUF_LEN);
+				r = virtqueue_add_outbuf(vq->vq, &sl, 1,
+							 dev->test_buf + vq->started,
+							 GFP_ATOMIC);
+				if (unlikely(r != 0)) {
+					if (r == -ENOSPC &&
+					    vq->started > started_before)
+						r = 0;
+					else
+						r = -1;
+					break;
+				}
+
+				++vq->started;
+
+				if (unlikely(!virtqueue_kick(vq->vq))) {
+					r = -1;
+					break;
+				}
+			}
+
+			if (vq->started >= bufs)
+				r = -1;
+
+			/* Flush out completed bufs if any */
+			while (virtqueue_get_buf(vq->vq, &len)) {
+				int n;
+
+				n = recvfrom(dev->sock, dev->res_buf, TEST_BUF_LEN, 0, NULL, NULL);
+				assert(n == TEST_BUF_LEN);
+				verify_res_buf(dev->res_buf);
+
+				++vq->completed;
+				r = 0;
+			}
+		} while (r == 0);
+
+		if (vq->completed == completed_before && vq->started == started_before)
+			++spurious;
+
+		assert(vq->completed <= bufs);
+		assert(vq->started <= bufs);
+		if (vq->completed == bufs)
+			break;
+
+		if (delayed) {
+			if (virtqueue_enable_cb_delayed(vq->vq))
+				wait_for_interrupt(vq);
+		} else {
+			if (virtqueue_enable_cb(vq->vq))
+				wait_for_interrupt(vq);
+		}
+	}
+	printf("TX spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
+	       spurious, vq->started, vq->completed);
+}
+
+static void run_rx_test(struct vdev_info *dev, struct vq_info *vq,
+			bool delayed, int batch, int bufs)
+{
+	const bool random_batch = batch == RANDOM_BATCH;
+	long long spurious = 0;
+	struct scatterlist sl;
+	unsigned int len;
+	int r;
+
+	for (;;) {
+		long started_before = vq->started;
+		long completed_before = vq->completed;
+
+		do {
+			if (random_batch)
+				batch = (random() % vq->vring.num) + 1;
+
+			while (vq->started < bufs &&
+			       (vq->started - vq->completed) < batch) {
+				sg_init_one(&sl, dev->res_buf, HDR_LEN + TEST_BUF_LEN);
+
+				r = virtqueue_add_inbuf(vq->vq, &sl, 1,
+							dev->res_buf + vq->started,
+							GFP_ATOMIC);
+				if (unlikely(r != 0)) {
+					if (r == -ENOSPC &&
+					    vq->started > started_before)
+						r = 0;
+					else
+						r = -1;
+					break;
+				}
+
+				++vq->started;
+
+				vdev_send_packet(dev);
+
+				if (unlikely(!virtqueue_kick(vq->vq))) {
+					r = -1;
+					break;
+				}
+			}
+
+			if (vq->started >= bufs)
+				r = -1;
+
+			/* Flush out completed bufs if any */
+			while (virtqueue_get_buf(vq->vq, &len)) {
+				struct ether_header *eh;
+
+				eh = (struct ether_header *)(dev->res_buf + HDR_LEN);
+
+				/* tun netdev is up and running, ignore the
+				 * non-TEST_PTYPE packet.
+				 */
+				if (eh->ether_type != htons(TEST_PTYPE)) {
+					++vq->completed;
+					r = 0;
+					continue;
+				}
+
+				assert(len == TEST_BUF_LEN + HDR_LEN);
+				verify_res_buf(dev->res_buf + HDR_LEN);
+
+				++vq->completed;
+				r = 0;
+			}
+		} while (r == 0);
+		if (vq->completed == completed_before && vq->started == started_before)
+			++spurious;
+
+		assert(vq->completed <= bufs);
+		assert(vq->started <= bufs);
+		if (vq->completed == bufs)
+			break;
+	}
+
+	printf("RX spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
+	       spurious, vq->started, vq->completed);
+}
+
+static const char optstring[] = "h";
+static const struct option longopts[] = {
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
+	}
+};
+
+static void help(int status)
+{
+	fprintf(stderr, "Usage: vhost_net_test [--help]"
+		" [--no-indirect]"
+		" [--no-event-idx]"
+		" [--no-virtio-1]"
+		" [--delayed-interrupt]"
+		" [--buf-num]"
+		" [--batch=random/N]"
+		"\n");
+
+	exit(status);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long long features = (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
+		(1ULL << VIRTIO_RING_F_EVENT_IDX) | (1ULL << VIRTIO_F_VERSION_1);
+	long batch = 1, nbufs = 0x100000;
+	struct vdev_info dev;
+	bool delayed = false;
+	int o, fd;
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
+			if (!strcmp(optarg, "random")) {
+				batch = RANDOM_BATCH;
+			} else {
+				batch = strtol(optarg, NULL, 10);
+				assert(batch > 0);
+				assert(batch < (long)INT_MAX + 1);
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
+	memset(&dev, 0, sizeof(dev));
+
+	fd = tun_alloc(&dev);
+	assert(fd >= 0);
+
+	vdev_info_init(&dev, features);
+	vq_info_add(&dev, 0, 256, fd);
+	vq_info_add(&dev, 1, 256, fd);
+	vdev_create_socket(&dev);
+
+	run_rx_test(&dev, &dev.vqs[0], delayed, batch, nbufs);
+	run_tx_test(&dev, &dev.vqs[1], delayed, batch, nbufs);
+
+	return 0;
+}
-- 
2.33.0


