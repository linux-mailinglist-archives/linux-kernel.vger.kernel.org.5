Return-Path: <linux-kernel+bounces-84768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5660E86AB49
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEE6288802
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B049B38F98;
	Wed, 28 Feb 2024 09:32:13 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8F6374D3;
	Wed, 28 Feb 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112732; cv=none; b=XU4T78WkAxktTjoh6iuVYB7S+maPRB3KTuYrVnxrlKtRnYIM5I3wiyjr6cihsmJ1By6jrprfZeD92912+1eXOS3daUxnqDGC/JWGsZdhXJVusAi8JvPGAZp1HK96CHGBy9WxyMQ+JUo6HJoLcu8osNhbzq7iFYE1yDLgo9dw9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112732; c=relaxed/simple;
	bh=9XS9MLMpKBUOGCXu0yNvQkNInCb9xS3H/47pxcLSp/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ5mCFk4a5yZN/9GEa9iK52ku6aHaFtS+1TgWj1ErX9LfyZO9TbSHw9AC1rXwA9DoQMyfbg+VTA1RTrZO19MHFWBSL3eIlE5XLyLrfwv+/ynZxQFPqNJM3DISB379maGKneUMVKivGPKS2HhMxwgScI9fPNmzOLoMfGnjA4EpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tl8Fq6gdrz2Bdv9;
	Wed, 28 Feb 2024 17:29:51 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id DFBB11402CC;
	Wed, 28 Feb 2024 17:32:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 17:32:06 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>
Subject: [PATCH net-next v6 5/5] tools: virtio: introduce vhost_net_test
Date: Wed, 28 Feb 2024 17:30:12 +0800
Message-ID: <20240228093013.8263-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240228093013.8263-1-linyunsheng@huawei.com>
References: <20240228093013.8263-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

introduce vhost_net_test for both vhost_net tx and rx basing
on virtio_test to test vhost_net changing in the kernel.

Steps for vhost_net tx testing:
1. Prepare a out buf.
2. Kick the vhost_net to do tx processing.
3. Do the receiving in the tun side.
4. verify the data received by tun is correct.

Steps for vhost_net rx testing:
1. Prepare a in buf.
2. Do the sending in the tun side.
3. Kick the vhost_net to do rx processing.
4. verify the data received by vhost_net is correct.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 tools/virtio/.gitignore            |   1 +
 tools/virtio/Makefile              |   8 +-
 tools/virtio/linux/virtio_config.h |   4 +
 tools/virtio/vhost_net_test.c      | 532 +++++++++++++++++++++++++++++
 4 files changed, 542 insertions(+), 3 deletions(-)
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
diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
index 2a8a70e2a950..42a564f22f2d 100644
--- a/tools/virtio/linux/virtio_config.h
+++ b/tools/virtio/linux/virtio_config.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_VIRTIO_CONFIG_H
+#define LINUX_VIRTIO_CONFIG_H
 #include <linux/virtio_byteorder.h>
 #include <linux/virtio.h>
 #include <uapi/linux/virtio_config.h>
@@ -95,3 +97,5 @@ static inline __virtio64 cpu_to_virtio64(struct virtio_device *vdev, u64 val)
 {
 	return __cpu_to_virtio64(virtio_is_little_endian(vdev), val);
 }
+
+#endif
diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.c
new file mode 100644
index 000000000000..389d99a6d7c7
--- /dev/null
+++ b/tools/virtio/vhost_net_test.c
@@ -0,0 +1,532 @@
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
+#include <linux/vhost.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+#include <linux/in.h>
+#include <linux/if_packet.h>
+#include <linux/virtio_net.h>
+#include <netinet/ether.h>
+
+#define HDR_LEN		sizeof(struct virtio_net_hdr_mrg_rxbuf)
+#define TEST_BUF_LEN	256
+#define TEST_PTYPE	ETH_P_LOOPBACK
+#define DESC_NUM	256
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
+static int tun_alloc(struct vdev_info *dev, char *tun_name)
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
+	strncpy(ifr.ifr_name, tun_name, IFNAMSIZ);
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
+static void vdev_create_socket(struct vdev_info *dev, char *tun_name)
+{
+	struct ifreq ifr;
+
+	dev->sock = socket(AF_PACKET, SOCK_RAW, htons(TEST_PTYPE));
+	assert(dev->sock != -1);
+
+	strncpy(ifr.ifr_name, tun_name, IFNAMSIZ);
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
+				       info->ring, vq_notify, NULL, "test");
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
+	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
+	assert(r >= 0);
+	vq_reset(info, num, &dev->vdev);
+	vhost_vq_setup(dev, info);
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
+	poll(&vq->fds, 1, 100);
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
+			bool delayed, int bufs)
+{
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
+			while (vq->started < bufs &&
+			       (vq->started - vq->completed) < 1) {
+				sg_init_one(&sl, dev->test_buf, HDR_LEN + TEST_BUF_LEN);
+				r = virtqueue_add_outbuf(vq->vq, &sl, 1,
+							 dev->test_buf + vq->started,
+							 GFP_ATOMIC);
+				if (unlikely(r != 0))
+					break;
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
+			bool delayed, int bufs)
+{
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
+			while (vq->started < bufs &&
+			       (vq->started - vq->completed) < 1) {
+				sg_init_one(&sl, dev->res_buf, HDR_LEN + TEST_BUF_LEN);
+
+				r = virtqueue_add_inbuf(vq->vq, &sl, 1,
+							dev->res_buf + vq->started,
+							GFP_ATOMIC);
+				if (unlikely(r != 0))
+					break;
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
+				/* tun netdev is up and running, only handle the
+				 * TEST_PTYPE packet.
+				 */
+				if (eh->ether_type == htons(TEST_PTYPE)) {
+					assert(len == TEST_BUF_LEN + HDR_LEN);
+					verify_res_buf(dev->res_buf + HDR_LEN);
+				}
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
+		"\n");
+
+	exit(status);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long long features = (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
+		(1ULL << VIRTIO_RING_F_EVENT_IDX) | (1ULL << VIRTIO_F_VERSION_1);
+	char tun_name[IFNAMSIZ];
+	long nbufs = 0x100000;
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
+	snprintf(tun_name, IFNAMSIZ, "tun_%d", getpid());
+
+	fd = tun_alloc(&dev, tun_name);
+	assert(fd >= 0);
+
+	vdev_info_init(&dev, features);
+	vq_info_add(&dev, 0, DESC_NUM, fd);
+	vq_info_add(&dev, 1, DESC_NUM, fd);
+	vdev_create_socket(&dev, tun_name);
+
+	run_rx_test(&dev, &dev.vqs[0], delayed, nbufs);
+	run_tx_test(&dev, &dev.vqs[1], delayed, nbufs);
+
+	return 0;
+}
-- 
2.33.0


