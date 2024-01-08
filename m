Return-Path: <linux-kernel+bounces-19495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB8826DCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50ED62837A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6711405CD;
	Mon,  8 Jan 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPsGJcl1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0D405C2;
	Mon,  8 Jan 2024 12:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F53C433C7;
	Mon,  8 Jan 2024 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716869;
	bh=XT1YEEoBYL9YDiIX/x8rgxCuvHmV/PTauF415QqPIFQ=;
	h=From:To:Cc:Subject:Date:From;
	b=UPsGJcl1g9EiAthi4CpNsl0yNSWFFCHkd2ZUbk6CPMt34BMDzCtyhQ+yca1YMlyBY
	 Cql7306y2Q7Nn85Nuz1FCd0JTfdsdsmOvi+V4YV+fFxy119KClUTIlxh1NT+KFeoKY
	 MZpaB7OGQETIMSHaflY6/9l4S07nJqm9h+39n1NQ6aOsqa3uDyWEoUod0N46iLPlhi
	 RPnolo36oi829R/GkUy7NdzRIIwkMV/ZnE9kQ0pNJXQDc5nEv1QUcsgDlUmVgSpFNq
	 TXD9HiTkn3unCs6nevPT3VmvnbCyYnaQNWJ7Sm+o2QutC34hu+g0hb9g3xiyQpWTkN
	 /ZukCNaH92M/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Suwan Kim <suwan.kim027@gmail.com>,
	kernel test robot <lkp@intel.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	jasowang@redhat.com,
	axboe@kernel.dk,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 1/8] virtio_blk: fix snprintf truncation compiler warning
Date: Mon,  8 Jan 2024 07:27:17 -0500
Message-ID: <20240108122745.2090122-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.10
Content-Transfer-Encoding: 8bit

From: Stefan Hajnoczi <stefanha@redhat.com>

[ Upstream commit b8e0792449928943c15d1af9f63816911d139267 ]

Commit 4e0400525691 ("virtio-blk: support polling I/O") triggers the
following gcc 13 W=1 warnings:

drivers/block/virtio_blk.c: In function ‘init_vq’:
drivers/block/virtio_blk.c:1077:68: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Wformat-truncation=]
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                                                                    ^~
drivers/block/virtio_blk.c:1077:58: note: directive argument in the range [-2147483648, 65534]
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                                                          ^~~~~~~~~~~~~
drivers/block/virtio_blk.c:1077:17: note: ‘snprintf’ output between 11 and 21 bytes into a destination of size 16
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is a false positive because the lower bound -2147483648 is
incorrect. The true range of i is [0, num_vqs - 1] where 0 < num_vqs <
65536.

The code mixes int, unsigned short, and unsigned int types in addition
to using "%d" for an unsigned value. Use unsigned short and "%u"
consistently to solve the compiler warning.

Cc: Suwan Kim <suwan.kim027@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312041509.DIyvEt9h-lkp@intel.com/
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20231204140743.1487843-1-stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4a4b9bad551e8..225c86c74d4e9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1021,12 +1021,12 @@ static void virtblk_config_changed(struct virtio_device *vdev)
 static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
-	int i;
+	unsigned short i;
 	vq_callback_t **callbacks;
 	const char **names;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
-	unsigned int num_poll_vqs;
+	unsigned short num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -1070,13 +1070,13 @@ static int init_vq(struct virtio_blk *vblk)
 
 	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
 		callbacks[i] = virtblk_done;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
 	for (; i < num_vqs; i++) {
 		callbacks[i] = NULL;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
-- 
2.43.0


