Return-Path: <linux-kernel+bounces-144495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2768A4712
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58971C2165F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73A117C6D;
	Mon, 15 Apr 2024 02:46:27 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0C9921772F;
	Mon, 15 Apr 2024 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149183; cv=none; b=WVuBg9J16Mmqi9HOCTknhoaRbAv/k0LPmSp7cmeWNYvxLOYJdA+av2XqAGoX3t7K9o4GzZbVNFX6Ir59fER0lEpgo5BeWPMhOcOxoRHj4ViW6K+MiVkeaAlXBi153WOI/VF7BkwYTFt5EO/5Z7WimbOn8fR6FiYxjGjnBj0Rnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149183; c=relaxed/simple;
	bh=Z4DaAAq1iZqfINFe16KHcUGYUNHb9+kEuA4ycXYF9vQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vtetdf25VXOfdp+wQ23iUbMISuMHdD8EZcDf8lE7oo1PiispTK7MNO+Sg86/r8YPI/x05J3ZsBHqEQ2bjY6nllRPwzWoKi+EQaQFnsqfMUkxc5vZ25H+fIaxoDMUMZ3hiEqj/J4N3KQmnQbcQQBC2+UrHD6FdALu8T5AAcWC1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.4])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 7A8B9602DBF32;
	Mon, 15 Apr 2024 10:45:41 +0800 (CST)
X-MD-Sfrom: zhangyang@nfschina.com
X-MD-SrcIP: 103.163.180.4
From: zhangyang <zhangyang@nfschina.com>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangyang <zhangyang@nfschina.com>
Subject: [PATCH] fix hib resume pages cache clean called in_irq (option hibernate=nocompress) When kernel cmd option hibernate=nocompress,load_image call  swap_read_page. after every page read finished  hib_end_io call page cache clean, in aarch6464 flush_icache_range not allow call in interrupt.  This patch fix this problem by record all pages read in load_image,after all pages read finished  call flush_icache_range clean all reags in load_image,flush_icache_range called in task.  call trace info: [   12.603468] WARNING: CPU: 6 PID: 0 at kernel/smp.c:424 smp_call_function_many+0x2fc/0x390 [   12.612730] Modules linked in: raid10(E) raid456(E) libcrc32c(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) xor(E) xor_neon(E) async_tx(E) raid6_pq(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) hid_generic(E) usbhid(E) hid(E) uhci_hcd(E) ehci_hcd(E) arise_pro(OE) drm_kms_helper(E) evdev(E) efivars(E) clk_scpi(E) sd_mod(E) usbcore(E) drm(E) arm_scpi(E) [   12.650675] CP
 U: 6 PID: 0 Comm: swapper/6 Tainted: G        W  OE 5.4.0-100-generic #100.1+m38+21nfs5 [   12.661512] Hardware name: LENOVO INVALID/FD2000ZX200MB1, BIOS W0AKT19B 08/16/2022 [   12.670085] pstate: 20000085 (nzCv daIf -PAN -UAO) [   12.675506] pc : smp_call_function_many+0x2fc/0x390 [   12.681026] lr : kick_all_cpus_sync+0x34/0x3c [   12.685954] sp : ffff800010033c40 [   12.689700] x29: ffff800010033c40 x28: ffff80001152a1b8 [   12.695712] x27: 0000000000000006 x26: 0000000000000001 [   12.701723] x25: ffff0000780b8000 x24: 0000000000000000 [   12.707735] x23: 0000000000000000 x22: ffff8000101b6ad0 [   12.713746] x21: 0000000000000006 x20: ffff80001152a1b8 [ 12.719758] x19: ffff0026d3e08100 x18: 0000000000000000 [   12.725769] x17: 000000004143b1b7 x16: 0000000000000008 [   12.731781] x15: 0000000000004446 x14: 000000000000ba7e [   12.737792] x13: 000042cf7b84cf9c x12: 000042cf7b84cf9c [   12.743804] x11: 00000000000042cf x10: 0000000000000040 [ 12.749815] x9 : ffff80001154e748 x8 : 
 ffff80001154e740 [   12.755826] x7 : ffff0026d8400af8 x6 : ffff0026d3e08180 [   12.761837] x5 : 0000000000001000 x4 : ffff0026d0b2f000 [   12.767849] x3 : 0000000000000001 x2 : ffff800011159018 [   12.773860] x1 : 0000000000000080 x0 : 0000000000000000 [ 12.779871] Call trace: [   12.782634]  smp_call_function_many+0x2fc/0x390 [ 12.787759]  kick_all_cpus_sync+0x34/0x3c [   12.792295]  hib_end_io+0x104/0x180 [   12.796240]  bio_endio+0x148/0x1f0 [   12.800086]  blk_update_request+0xd8/0x3b0 [   12.804718]  blk_mq_end_request+0x34/0x150 [ 12.809352]  nvme_complete_rq+0x74/0x230 [   12.813788]  nvme_pci_complete_rq+0x5c/0xd0 [   12.818520]  blk_mq_complete_request+0x10c/0x14c [   12.823743]  nvme_complete_cqes+0xbc/0x1bc [   12.828375]  nvme_irq+0x13c/0x15c [   12.832123]  __handle_irq_event_percpu+0x68/0x240 [   12.837445]  handle_irq_event+0x68/0x1ac [   12.841881]  handle_fasteoi_irq+0xc8/0x23c [   12.846514]  __handle_domain_irq+0x80/0xe0 [   12.851147]  gic_handle_irq+0xd8/0x180 [
    12.855385]  el1_irq+0xb8/0x140 [   12.858934]  arch_cpu_idle+0x40/0x1d0 [   12.863075]  do_idle+0x230/0x2dc [   12.866722]  cpu_startup_entry+0x30/0xc0 [   12.871159]  secondary_start_kernel+0x138/0x184 [   12.876283] ---[ end trace 9cf7b6db3165264d ]---
Date: Mon, 15 Apr 2024 10:45:21 +0800
Message-Id: <20240415024521.1842-1-zhangyang@nfschina.com>
X-Mailer: git-send-email 2.39.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 kernel/power/swap.c | 3385 ++++++++++++++++++++++---------------------
 1 file changed, 1717 insertions(+), 1668 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 5bc04bfe2..70b84dc38 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1,1668 +1,1717 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/kernel/power/swap.c
- *
- * This file provides functions for reading the suspend image from
- * and writing it to a swap partition.
- *
- * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@ucw.cz>
- * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
- * Copyright (C) 2010-2012 Bojan Smojver <bojan@rexursive.com>
- */
-
-#define pr_fmt(fmt) "PM: " fmt
-
-#include <linux/module.h>
-#include <linux/file.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-#include <linux/device.h>
-#include <linux/bio.h>
-#include <linux/blkdev.h>
-#include <linux/swap.h>
-#include <linux/swapops.h>
-#include <linux/pm.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/cpumask.h>
-#include <linux/atomic.h>
-#include <linux/kthread.h>
-#include <linux/crc32.h>
-#include <linux/ktime.h>
-
-#include "power.h"
-
-#define HIBERNATE_SIG	"S1SUSPEND"
-
-u32 swsusp_hardware_signature;
-
-/*
- * When reading an {un,}compressed image, we may restore pages in place,
- * in which case some architectures need these pages cleaning before they
- * can be executed. We don't know which pages these may be, so clean the l=
ot.
- */
-static bool clean_pages_on_read;
-static bool clean_pages_on_decompress;
-
-/*
- *	The swap map is a data structure used for keeping track of each page
- *	written to a swap partition.  It consists of many swap_map_page
- *	structures that contain each an array of MAP_PAGE_ENTRIES swap entries.
- *	These structures are stored on the swap and linked together with the
- *	help of the .next_swap member.
- *
- *	The swap map is created during suspend.  The swap map pages are
- *	allocated and populated one at a time, so we only need one memory
- *	page to set up the entire structure.
- *
- *	During resume we pick up all swap_map_page structures into a list.
- */
-
-#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(sector_t) - 1)
-
-/*
- * Number of free pages that are not high.
- */
-static inline unsigned long low_free_pages(void)
-{
-	return nr_free_pages() - nr_free_highpages();
-}
-
-/*
- * Number of pages required to be kept free while writing the image. Always
- * half of all available low pages before the writing starts.
- */
-static inline unsigned long reqd_free_pages(void)
-{
-	return low_free_pages() / 2;
-}
-
-struct swap_map_page {
-	sector_t entries[MAP_PAGE_ENTRIES];
-	sector_t next_swap;
-};
-
-struct swap_map_page_list {
-	struct swap_map_page *map;
-	struct swap_map_page_list *next;
-};
-
-/*
- *	The swap_map_handle structure is used for handling swap in
- *	a file-alike way
- */
-
-struct swap_map_handle {
-	struct swap_map_page *cur;
-	struct swap_map_page_list *maps;
-	sector_t cur_swap;
-	sector_t first_sector;
-	unsigned int k;
-	unsigned long reqd_free_pages;
-	u32 crc32;
-};
-
-struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) -
-	              sizeof(u32) - sizeof(u32)];
-	u32	hw_sig;
-	u32	crc32;
-	sector_t image;
-	unsigned int flags;	/* Flags to pass to the "boot" kernel */
-	char	orig_sig[10];
-	char	sig[10];
-} __packed;
-
-static struct swsusp_header *swsusp_header;
-
-/*
- *	The following functions are used for tracing the allocated
- *	swap pages, so that they can be freed in case of an error.
- */
-
-struct swsusp_extent {
-	struct rb_node node;
-	unsigned long start;
-	unsigned long end;
-};
-
-static struct rb_root swsusp_extents =3D RB_ROOT;
-
-static int swsusp_extents_insert(unsigned long swap_offset)
-{
-	struct rb_node **new =3D &(swsusp_extents.rb_node);
-	struct rb_node *parent =3D NULL;
-	struct swsusp_extent *ext;
-
-	/* Figure out where to put the new node */
-	while (*new) {
-		ext =3D rb_entry(*new, struct swsusp_extent, node);
-		parent =3D *new;
-		if (swap_offset < ext->start) {
-			/* Try to merge */
-			if (swap_offset =3D=3D ext->start - 1) {
-				ext->start--;
-				return 0;
-			}
-			new =3D &((*new)->rb_left);
-		} else if (swap_offset > ext->end) {
-			/* Try to merge */
-			if (swap_offset =3D=3D ext->end + 1) {
-				ext->end++;
-				return 0;
-			}
-			new =3D &((*new)->rb_right);
-		} else {
-			/* It already is in the tree */
-			return -EINVAL;
-		}
-	}
-	/* Add the new node and rebalance the tree. */
-	ext =3D kzalloc(sizeof(struct swsusp_extent), GFP_KERNEL);
-	if (!ext)
-		return -ENOMEM;
-
-	ext->start =3D swap_offset;
-	ext->end =3D swap_offset;
-	rb_link_node(&ext->node, parent, new);
-	rb_insert_color(&ext->node, &swsusp_extents);
-	return 0;
-}
-
-/*
- *	alloc_swapdev_block - allocate a swap page and register that it has
- *	been allocated, so that it can be freed in case of an error.
- */
-
-sector_t alloc_swapdev_block(int swap)
-{
-	unsigned long offset;
-
-	offset =3D swp_offset(get_swap_page_of_type(swap));
-	if (offset) {
-		if (swsusp_extents_insert(offset))
-			swap_free(swp_entry(swap, offset));
-		else
-			return swapdev_block(swap, offset);
-	}
-	return 0;
-}
-
-/*
- *	free_all_swap_pages - free swap pages allocated for saving image data.
- *	It also frees the extents used to register which swap entries had been
- *	allocated.
- */
-
-void free_all_swap_pages(int swap)
-{
-	struct rb_node *node;
-
-	while ((node =3D swsusp_extents.rb_node)) {
-		struct swsusp_extent *ext;
-		unsigned long offset;
-
-		ext =3D rb_entry(node, struct swsusp_extent, node);
-		rb_erase(node, &swsusp_extents);
-		for (offset =3D ext->start; offset <=3D ext->end; offset++)
-			swap_free(swp_entry(swap, offset));
-
-		kfree(ext);
-	}
-}
-
-int swsusp_swap_in_use(void)
-{
-	return (swsusp_extents.rb_node !=3D NULL);
-}
-
-/*
- * General things
- */
-
-static unsigned short root_swap =3D 0xffff;
-static struct file *hib_resume_bdev_file;
-
-struct hib_bio_batch {
-	atomic_t		count;
-	wait_queue_head_t	wait;
-	blk_status_t		error;
-	struct blk_plug		plug;
-};
-
-static void hib_init_batch(struct hib_bio_batch *hb)
-{
-	atomic_set(&hb->count, 0);
-	init_waitqueue_head(&hb->wait);
-	hb->error =3D BLK_STS_OK;
-	blk_start_plug(&hb->plug);
-}
-
-static void hib_finish_batch(struct hib_bio_batch *hb)
-{
-	blk_finish_plug(&hb->plug);
-}
-
-static void hib_end_io(struct bio *bio)
-{
-	struct hib_bio_batch *hb =3D bio->bi_private;
-	struct page *page =3D bio_first_page_all(bio);
-
-	if (bio->bi_status) {
-		pr_alert("Read-error on swap-device (%u:%u:%Lu)\n",
-			 MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
-			 (unsigned long long)bio->bi_iter.bi_sector);
-	}
-
-	if (bio_data_dir(bio) =3D=3D WRITE)
-		put_page(page);
-	else if (clean_pages_on_read)
-		flush_icache_range((unsigned long)page_address(page),
-				   (unsigned long)page_address(page) + PAGE_SIZE);
-
-	if (bio->bi_status && !hb->error)
-		hb->error =3D bio->bi_status;
-	if (atomic_dec_and_test(&hb->count))
-		wake_up(&hb->wait);
-
-	bio_put(bio);
-}
-
-static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
-			 struct hib_bio_batch *hb)
-{
-	struct page *page =3D virt_to_page(addr);
-	struct bio *bio;
-	int error =3D 0;
-
-	bio =3D bio_alloc(file_bdev(hib_resume_bdev_file), 1, opf,
-			GFP_NOIO | __GFP_HIGH);
-	bio->bi_iter.bi_sector =3D page_off * (PAGE_SIZE >> 9);
-
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
-		pr_err("Adding page to bio failed at %llu\n",
-		       (unsigned long long)bio->bi_iter.bi_sector);
-		bio_put(bio);
-		return -EFAULT;
-	}
-
-	if (hb) {
-		bio->bi_end_io =3D hib_end_io;
-		bio->bi_private =3D hb;
-		atomic_inc(&hb->count);
-		submit_bio(bio);
-	} else {
-		error =3D submit_bio_wait(bio);
-		bio_put(bio);
-	}
-
-	return error;
-}
-
-static int hib_wait_io(struct hib_bio_batch *hb)
-{
-	/*
-	 * We are relying on the behavior of blk_plug that a thread with
-	 * a plug will flush the plug list before sleeping.
-	 */
-	wait_event(hb->wait, atomic_read(&hb->count) =3D=3D 0);
-	return blk_status_to_errno(hb->error);
-}
-
-/*
- * Saving part
- */
-static int mark_swapfiles(struct swap_map_handle *handle, unsigned int fla=
gs)
-{
-	int error;
-
-	hib_submit_io(REQ_OP_READ, swsusp_resume_block, swsusp_header, NULL);
-	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
-	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
-		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
-		memcpy(swsusp_header->sig, HIBERNATE_SIG, 10);
-		swsusp_header->image =3D handle->first_sector;
-		if (swsusp_hardware_signature) {
-			swsusp_header->hw_sig =3D swsusp_hardware_signature;
-			flags |=3D SF_HW_SIG;
-		}
-		swsusp_header->flags =3D flags;
-		if (flags & SF_CRC32_MODE)
-			swsusp_header->crc32 =3D handle->crc32;
-		error =3D hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
-				      swsusp_resume_block, swsusp_header, NULL);
-	} else {
-		pr_err("Swap header not found!\n");
-		error =3D -ENODEV;
-	}
-	return error;
-}
-
-/*
- * Hold the swsusp_header flag. This is used in software_resume() in
- * 'kernel/power/hibernate' to check if the image is compressed and query
- * for the compression algorithm support(if so).
- */
-unsigned int swsusp_header_flags;
-
-/**
- *	swsusp_swap_check - check if the resume device is a swap device
- *	and get its index (if so)
- *
- *	This is called before saving image
- */
-static int swsusp_swap_check(void)
-{
-	int res;
-
-	if (swsusp_resume_device)
-		res =3D swap_type_of(swsusp_resume_device, swsusp_resume_block);
-	else
-		res =3D find_first_swap(&swsusp_resume_device);
-	if (res < 0)
-		return res;
-	root_swap =3D res;
-
-	hib_resume_bdev_file =3D bdev_file_open_by_dev(swsusp_resume_device,
-			BLK_OPEN_WRITE, NULL, NULL);
-	if (IS_ERR(hib_resume_bdev_file))
-		return PTR_ERR(hib_resume_bdev_file);
-
-	res =3D set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
-	if (res < 0)
-		fput(hib_resume_bdev_file);
-
-	return res;
-}
-
-/**
- *	write_page - Write one page to given swap location.
- *	@buf:		Address we're writing.
- *	@offset:	Offset of the swap page we're writing to.
- *	@hb:		bio completion batch
- */
-
-static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
-{
-	void *src;
-	int ret;
-
-	if (!offset)
-		return -ENOSPC;
-
-	if (hb) {
-		src =3D (void *)__get_free_page(GFP_NOIO | __GFP_NOWARN |
-		                              __GFP_NORETRY);
-		if (src) {
-			copy_page(src, buf);
-		} else {
-			ret =3D hib_wait_io(hb); /* Free pages */
-			if (ret)
-				return ret;
-			src =3D (void *)__get_free_page(GFP_NOIO |
-			                              __GFP_NOWARN |
-			                              __GFP_NORETRY);
-			if (src) {
-				copy_page(src, buf);
-			} else {
-				WARN_ON_ONCE(1);
-				hb =3D NULL;	/* Go synchronous */
-				src =3D buf;
-			}
-		}
-	} else {
-		src =3D buf;
-	}
-	return hib_submit_io(REQ_OP_WRITE | REQ_SYNC, offset, src, hb);
-}
-
-static void release_swap_writer(struct swap_map_handle *handle)
-{
-	if (handle->cur)
-		free_page((unsigned long)handle->cur);
-	handle->cur =3D NULL;
-}
-
-static int get_swap_writer(struct swap_map_handle *handle)
-{
-	int ret;
-
-	ret =3D swsusp_swap_check();
-	if (ret) {
-		if (ret !=3D -ENOSPC)
-			pr_err("Cannot find swap device, try swapon -a\n");
-		return ret;
-	}
-	handle->cur =3D (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);
-	if (!handle->cur) {
-		ret =3D -ENOMEM;
-		goto err_close;
-	}
-	handle->cur_swap =3D alloc_swapdev_block(root_swap);
-	if (!handle->cur_swap) {
-		ret =3D -ENOSPC;
-		goto err_rel;
-	}
-	handle->k =3D 0;
-	handle->reqd_free_pages =3D reqd_free_pages();
-	handle->first_sector =3D handle->cur_swap;
-	return 0;
-err_rel:
-	release_swap_writer(handle);
-err_close:
-	swsusp_close();
-	return ret;
-}
-
-static int swap_write_page(struct swap_map_handle *handle, void *buf,
-		struct hib_bio_batch *hb)
-{
-	int error;
-	sector_t offset;
-
-	if (!handle->cur)
-		return -EINVAL;
-	offset =3D alloc_swapdev_block(root_swap);
-	error =3D write_page(buf, offset, hb);
-	if (error)
-		return error;
-	handle->cur->entries[handle->k++] =3D offset;
-	if (handle->k >=3D MAP_PAGE_ENTRIES) {
-		offset =3D alloc_swapdev_block(root_swap);
-		if (!offset)
-			return -ENOSPC;
-		handle->cur->next_swap =3D offset;
-		error =3D write_page(handle->cur, handle->cur_swap, hb);
-		if (error)
-			goto out;
-		clear_page(handle->cur);
-		handle->cur_swap =3D offset;
-		handle->k =3D 0;
-
-		if (hb && low_free_pages() <=3D handle->reqd_free_pages) {
-			error =3D hib_wait_io(hb);
-			if (error)
-				goto out;
-			/*
-			 * Recalculate the number of required free pages, to
-			 * make sure we never take more than half.
-			 */
-			handle->reqd_free_pages =3D reqd_free_pages();
-		}
-	}
- out:
-	return error;
-}
-
-static int flush_swap_writer(struct swap_map_handle *handle)
-{
-	if (handle->cur && handle->cur_swap)
-		return write_page(handle->cur, handle->cur_swap, NULL);
-	else
-		return -EINVAL;
-}
-
-static int swap_writer_finish(struct swap_map_handle *handle,
-		unsigned int flags, int error)
-{
-	if (!error) {
-		pr_info("S");
-		error =3D mark_swapfiles(handle, flags);
-		pr_cont("|\n");
-		flush_swap_writer(handle);
-	}
-
-	if (error)
-		free_all_swap_pages(root_swap);
-	release_swap_writer(handle);
-	swsusp_close();
-
-	return error;
-}
-
-/*
- * Bytes we need for compressed data in worst case. We assume(limitation)
- * this is the worst of all the compression algorithms.
- */
-#define bytes_worst_compress(x) ((x) + ((x) / 16) + 64 + 3 + 2)
-
-/* We need to remember how much compressed data we need to read. */
-#define CMP_HEADER	sizeof(size_t)
-
-/* Number of pages/bytes we'll compress at one time. */
-#define UNC_PAGES	32
-#define UNC_SIZE	(UNC_PAGES * PAGE_SIZE)
-
-/* Number of pages we need for compressed data (worst case). */
-#define CMP_PAGES	DIV_ROUND_UP(bytes_worst_compress(UNC_SIZE) + \
-				CMP_HEADER, PAGE_SIZE)
-#define CMP_SIZE	(CMP_PAGES * PAGE_SIZE)
-
-/* Maximum number of threads for compression/decompression. */
-#define CMP_THREADS	3
-
-/* Minimum/maximum number of pages for read buffering. */
-#define CMP_MIN_RD_PAGES	1024
-#define CMP_MAX_RD_PAGES	8192
-
-/**
- *	save_image - save the suspend image data
- */
-
-static int save_image(struct swap_map_handle *handle,
-                      struct snapshot_handle *snapshot,
-                      unsigned int nr_to_write)
-{
-	unsigned int m;
-	int ret;
-	int nr_pages;
-	int err2;
-	struct hib_bio_batch hb;
-	ktime_t start;
-	ktime_t stop;
-
-	hib_init_batch(&hb);
-
-	pr_info("Saving image data pages (%u pages)...\n",
-		nr_to_write);
-	m =3D nr_to_write / 10;
-	if (!m)
-		m =3D 1;
-	nr_pages =3D 0;
-	start =3D ktime_get();
-	while (1) {
-		ret =3D snapshot_read_next(snapshot);
-		if (ret <=3D 0)
-			break;
-		ret =3D swap_write_page(handle, data_of(*snapshot), &hb);
-		if (ret)
-			break;
-		if (!(nr_pages % m))
-			pr_info("Image saving progress: %3d%%\n",
-				nr_pages / m * 10);
-		nr_pages++;
-	}
-	err2 =3D hib_wait_io(&hb);
-	hib_finish_batch(&hb);
-	stop =3D ktime_get();
-	if (!ret)
-		ret =3D err2;
-	if (!ret)
-		pr_info("Image saving done\n");
-	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
-	return ret;
-}
-
-/*
- * Structure used for CRC32.
- */
-struct crc_data {
-	struct task_struct *thr;                  /* thread */
-	atomic_t ready;                           /* ready to start flag */
-	atomic_t stop;                            /* ready to stop flag */
-	unsigned run_threads;                     /* nr current threads */
-	wait_queue_head_t go;                     /* start crc update */
-	wait_queue_head_t done;                   /* crc update done */
-	u32 *crc32;                               /* points to handle's crc32 */
-	size_t *unc_len[CMP_THREADS];             /* uncompressed lengths */
-	unsigned char *unc[CMP_THREADS];          /* uncompressed data */
-};
-
-/*
- * CRC32 update function that runs in its own thread.
- */
-static int crc32_threadfn(void *data)
-{
-	struct crc_data *d =3D data;
-	unsigned i;
-
-	while (1) {
-		wait_event(d->go, atomic_read_acquire(&d->ready) ||
-		                  kthread_should_stop());
-		if (kthread_should_stop()) {
-			d->thr =3D NULL;
-			atomic_set_release(&d->stop, 1);
-			wake_up(&d->done);
-			break;
-		}
-		atomic_set(&d->ready, 0);
-
-		for (i =3D 0; i < d->run_threads; i++)
-			*d->crc32 =3D crc32_le(*d->crc32,
-			                     d->unc[i], *d->unc_len[i]);
-		atomic_set_release(&d->stop, 1);
-		wake_up(&d->done);
-	}
-	return 0;
-}
-/*
- * Structure used for data compression.
- */
-struct cmp_data {
-	struct task_struct *thr;                  /* thread */
-	struct crypto_comp *cc;                   /* crypto compressor stream */
-	atomic_t ready;                           /* ready to start flag */
-	atomic_t stop;                            /* ready to stop flag */
-	int ret;                                  /* return code */
-	wait_queue_head_t go;                     /* start compression */
-	wait_queue_head_t done;                   /* compression done */
-	size_t unc_len;                           /* uncompressed length */
-	size_t cmp_len;                           /* compressed length */
-	unsigned char unc[UNC_SIZE];              /* uncompressed buffer */
-	unsigned char cmp[CMP_SIZE];              /* compressed buffer */
-};
-
-/* Indicates the image size after compression */
-static atomic_t compressed_size =3D ATOMIC_INIT(0);
-
-/*
- * Compression function that runs in its own thread.
- */
-static int compress_threadfn(void *data)
-{
-	struct cmp_data *d =3D data;
-	unsigned int cmp_len =3D 0;
-
-	while (1) {
-		wait_event(d->go, atomic_read_acquire(&d->ready) ||
-		                  kthread_should_stop());
-		if (kthread_should_stop()) {
-			d->thr =3D NULL;
-			d->ret =3D -1;
-			atomic_set_release(&d->stop, 1);
-			wake_up(&d->done);
-			break;
-		}
-		atomic_set(&d->ready, 0);
-
-		cmp_len =3D CMP_SIZE - CMP_HEADER;
-		d->ret =3D crypto_comp_compress(d->cc, d->unc, d->unc_len,
-					      d->cmp + CMP_HEADER,
-					      &cmp_len);
-		d->cmp_len =3D cmp_len;
-
-		atomic_set(&compressed_size, atomic_read(&compressed_size) + d->cmp_len);
-		atomic_set_release(&d->stop, 1);
-		wake_up(&d->done);
-	}
-	return 0;
-}
-
-/**
- * save_compressed_image - Save the suspend image data after compression.
- * @handle: Swap map handle to use for saving the image.
- * @snapshot: Image to read data from.
- * @nr_to_write: Number of pages to save.
- */
-static int save_compressed_image(struct swap_map_handle *handle,
-				 struct snapshot_handle *snapshot,
-				 unsigned int nr_to_write)
-{
-	unsigned int m;
-	int ret =3D 0;
-	int nr_pages;
-	int err2;
-	struct hib_bio_batch hb;
-	ktime_t start;
-	ktime_t stop;
-	size_t off;
-	unsigned thr, run_threads, nr_threads;
-	unsigned char *page =3D NULL;
-	struct cmp_data *data =3D NULL;
-	struct crc_data *crc =3D NULL;
-
-	hib_init_batch(&hb);
-
-	atomic_set(&compressed_size, 0);
-
-	/*
-	 * We'll limit the number of threads for compression to limit memory
-	 * footprint.
-	 */
-	nr_threads =3D num_online_cpus() - 1;
-	nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);
-
-	page =3D (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
-	if (!page) {
-		pr_err("Failed to allocate %s page\n", hib_comp_algo);
-		ret =3D -ENOMEM;
-		goto out_clean;
-	}
-
-	data =3D vzalloc(array_size(nr_threads, sizeof(*data)));
-	if (!data) {
-		pr_err("Failed to allocate %s data\n", hib_comp_algo);
-		ret =3D -ENOMEM;
-		goto out_clean;
-	}
-
-	crc =3D kzalloc(sizeof(*crc), GFP_KERNEL);
-	if (!crc) {
-		pr_err("Failed to allocate crc\n");
-		ret =3D -ENOMEM;
-		goto out_clean;
-	}
-
-	/*
-	 * Start the compression threads.
-	 */
-	for (thr =3D 0; thr < nr_threads; thr++) {
-		init_waitqueue_head(&data[thr].go);
-		init_waitqueue_head(&data[thr].done);
-
-		data[thr].cc =3D crypto_alloc_comp(hib_comp_algo, 0, 0);
-		if (IS_ERR_OR_NULL(data[thr].cc)) {
-			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));
-			ret =3D -EFAULT;
-			goto out_clean;
-		}
-
-		data[thr].thr =3D kthread_run(compress_threadfn,
-		                            &data[thr],
-		                            "image_compress/%u", thr);
-		if (IS_ERR(data[thr].thr)) {
-			data[thr].thr =3D NULL;
-			pr_err("Cannot start compression threads\n");
-			ret =3D -ENOMEM;
-			goto out_clean;
-		}
-	}
-
-	/*
-	 * Start the CRC32 thread.
-	 */
-	init_waitqueue_head(&crc->go);
-	init_waitqueue_head(&crc->done);
-
-	handle->crc32 =3D 0;
-	crc->crc32 =3D &handle->crc32;
-	for (thr =3D 0; thr < nr_threads; thr++) {
-		crc->unc[thr] =3D data[thr].unc;
-		crc->unc_len[thr] =3D &data[thr].unc_len;
-	}
-
-	crc->thr =3D kthread_run(crc32_threadfn, crc, "image_crc32");
-	if (IS_ERR(crc->thr)) {
-		crc->thr =3D NULL;
-		pr_err("Cannot start CRC32 thread\n");
-		ret =3D -ENOMEM;
-		goto out_clean;
-	}
-
-	/*
-	 * Adjust the number of required free pages after all allocations have
-	 * been done. We don't want to run out of pages when writing.
-	 */
-	handle->reqd_free_pages =3D reqd_free_pages();
-
-	pr_info("Using %u thread(s) for %s compression\n", nr_threads, hib_comp_a=
lgo);
-	pr_info("Compressing and saving image data (%u pages)...\n",
-		nr_to_write);
-	m =3D nr_to_write / 10;
-	if (!m)
-		m =3D 1;
-	nr_pages =3D 0;
-	start =3D ktime_get();
-	for (;;) {
-		for (thr =3D 0; thr < nr_threads; thr++) {
-			for (off =3D 0; off < UNC_SIZE; off +=3D PAGE_SIZE) {
-				ret =3D snapshot_read_next(snapshot);
-				if (ret < 0)
-					goto out_finish;
-
-				if (!ret)
-					break;
-
-				memcpy(data[thr].unc + off,
-				       data_of(*snapshot), PAGE_SIZE);
-
-				if (!(nr_pages % m))
-					pr_info("Image saving progress: %3d%%\n",
-						nr_pages / m * 10);
-				nr_pages++;
-			}
-			if (!off)
-				break;
-
-			data[thr].unc_len =3D off;
-
-			atomic_set_release(&data[thr].ready, 1);
-			wake_up(&data[thr].go);
-		}
-
-		if (!thr)
-			break;
-
-		crc->run_threads =3D thr;
-		atomic_set_release(&crc->ready, 1);
-		wake_up(&crc->go);
-
-		for (run_threads =3D thr, thr =3D 0; thr < run_threads; thr++) {
-			wait_event(data[thr].done,
-				atomic_read_acquire(&data[thr].stop));
-			atomic_set(&data[thr].stop, 0);
-
-			ret =3D data[thr].ret;
-
-			if (ret < 0) {
-				pr_err("%s compression failed\n", hib_comp_algo);
-				goto out_finish;
-			}
-
-			if (unlikely(!data[thr].cmp_len ||
-			             data[thr].cmp_len >
-				     bytes_worst_compress(data[thr].unc_len))) {
-				pr_err("Invalid %s compressed length\n", hib_comp_algo);
-				ret =3D -1;
-				goto out_finish;
-			}
-
-			*(size_t *)data[thr].cmp =3D data[thr].cmp_len;
-
-			/*
-			 * Given we are writing one page at a time to disk, we
-			 * copy that much from the buffer, although the last
-			 * bit will likely be smaller than full page. This is
-			 * OK - we saved the length of the compressed data, so
-			 * any garbage at the end will be discarded when we
-			 * read it.
-			 */
-			for (off =3D 0;
-			     off < CMP_HEADER + data[thr].cmp_len;
-			     off +=3D PAGE_SIZE) {
-				memcpy(page, data[thr].cmp + off, PAGE_SIZE);
-
-				ret =3D swap_write_page(handle, page, &hb);
-				if (ret)
-					goto out_finish;
-			}
-		}
-
-		wait_event(crc->done, atomic_read_acquire(&crc->stop));
-		atomic_set(&crc->stop, 0);
-	}
-
-out_finish:
-	err2 =3D hib_wait_io(&hb);
-	stop =3D ktime_get();
-	if (!ret)
-		ret =3D err2;
-	if (!ret)
-		pr_info("Image saving done\n");
-	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
-	pr_info("Image size after compression: %d kbytes\n",
-		(atomic_read(&compressed_size) / 1024));
-
-out_clean:
-	hib_finish_batch(&hb);
-	if (crc) {
-		if (crc->thr)
-			kthread_stop(crc->thr);
-		kfree(crc);
-	}
-	if (data) {
-		for (thr =3D 0; thr < nr_threads; thr++) {
-			if (data[thr].thr)
-				kthread_stop(data[thr].thr);
-			if (data[thr].cc)
-				crypto_free_comp(data[thr].cc);
-		}
-		vfree(data);
-	}
-	if (page) free_page((unsigned long)page);
-
-	return ret;
-}
-
-/**
- *	enough_swap - Make sure we have enough swap to save the image.
- *
- *	Returns TRUE or FALSE after checking the total amount of swap
- *	space available from the resume partition.
- */
-
-static int enough_swap(unsigned int nr_pages)
-{
-	unsigned int free_swap =3D count_swap_pages(root_swap, 1);
-	unsigned int required;
-
-	pr_debug("Free swap pages: %u\n", free_swap);
-
-	required =3D PAGES_FOR_IO + nr_pages;
-	return free_swap > required;
-}
-
-/**
- *	swsusp_write - Write entire image and metadata.
- *	@flags: flags to pass to the "boot" kernel in the image header
- *
- *	It is important _NOT_ to umount filesystems at this point. We want
- *	them synced (in case something goes wrong) but we DO not want to mark
- *	filesystem clean: it is not. (And it does not matter, if we resume
- *	correctly, we'll mark system clean, anyway.)
- */
-
-int swsusp_write(unsigned int flags)
-{
-	struct swap_map_handle handle;
-	struct snapshot_handle snapshot;
-	struct swsusp_info *header;
-	unsigned long pages;
-	int error;
-
-	pages =3D snapshot_get_image_size();
-	error =3D get_swap_writer(&handle);
-	if (error) {
-		pr_err("Cannot get swap writer\n");
-		return error;
-	}
-	if (flags & SF_NOCOMPRESS_MODE) {
-		if (!enough_swap(pages)) {
-			pr_err("Not enough free swap\n");
-			error =3D -ENOSPC;
-			goto out_finish;
-		}
-	}
-	memset(&snapshot, 0, sizeof(struct snapshot_handle));
-	error =3D snapshot_read_next(&snapshot);
-	if (error < (int)PAGE_SIZE) {
-		if (error >=3D 0)
-			error =3D -EFAULT;
-
-		goto out_finish;
-	}
-	header =3D (struct swsusp_info *)data_of(snapshot);
-	error =3D swap_write_page(&handle, header, NULL);
-	if (!error) {
-		error =3D (flags & SF_NOCOMPRESS_MODE) ?
-			save_image(&handle, &snapshot, pages - 1) :
-			save_compressed_image(&handle, &snapshot, pages - 1);
-	}
-out_finish:
-	error =3D swap_writer_finish(&handle, flags, error);
-	return error;
-}
-
-/*
- *	The following functions allow us to read data using a swap map
- *	in a file-like way.
- */
-
-static void release_swap_reader(struct swap_map_handle *handle)
-{
-	struct swap_map_page_list *tmp;
-
-	while (handle->maps) {
-		if (handle->maps->map)
-			free_page((unsigned long)handle->maps->map);
-		tmp =3D handle->maps;
-		handle->maps =3D handle->maps->next;
-		kfree(tmp);
-	}
-	handle->cur =3D NULL;
-}
-
-static int get_swap_reader(struct swap_map_handle *handle,
-		unsigned int *flags_p)
-{
-	int error;
-	struct swap_map_page_list *tmp, *last;
-	sector_t offset;
-
-	*flags_p =3D swsusp_header->flags;
-
-	if (!swsusp_header->image) /* how can this happen? */
-		return -EINVAL;
-
-	handle->cur =3D NULL;
-	last =3D handle->maps =3D NULL;
-	offset =3D swsusp_header->image;
-	while (offset) {
-		tmp =3D kzalloc(sizeof(*handle->maps), GFP_KERNEL);
-		if (!tmp) {
-			release_swap_reader(handle);
-			return -ENOMEM;
-		}
-		if (!handle->maps)
-			handle->maps =3D tmp;
-		if (last)
-			last->next =3D tmp;
-		last =3D tmp;
-
-		tmp->map =3D (struct swap_map_page *)
-			   __get_free_page(GFP_NOIO | __GFP_HIGH);
-		if (!tmp->map) {
-			release_swap_reader(handle);
-			return -ENOMEM;
-		}
-
-		error =3D hib_submit_io(REQ_OP_READ, offset, tmp->map, NULL);
-		if (error) {
-			release_swap_reader(handle);
-			return error;
-		}
-		offset =3D tmp->map->next_swap;
-	}
-	handle->k =3D 0;
-	handle->cur =3D handle->maps->map;
-	return 0;
-}
-
-static int swap_read_page(struct swap_map_handle *handle, void *buf,
-		struct hib_bio_batch *hb)
-{
-	sector_t offset;
-	int error;
-	struct swap_map_page_list *tmp;
-
-	if (!handle->cur)
-		return -EINVAL;
-	offset =3D handle->cur->entries[handle->k];
-	if (!offset)
-		return -EFAULT;
-	error =3D hib_submit_io(REQ_OP_READ, offset, buf, hb);
-	if (error)
-		return error;
-	if (++handle->k >=3D MAP_PAGE_ENTRIES) {
-		handle->k =3D 0;
-		free_page((unsigned long)handle->maps->map);
-		tmp =3D handle->maps;
-		handle->maps =3D handle->maps->next;
-		kfree(tmp);
-		if (!handle->maps)
-			release_swap_reader(handle);
-		else
-			handle->cur =3D handle->maps->map;
-	}
-	return error;
-}
-
-static int swap_reader_finish(struct swap_map_handle *handle)
-{
-	release_swap_reader(handle);
-
-	return 0;
-}
-
-/**
- *	load_image - load the image using the swap map handle
- *	@handle and the snapshot handle @snapshot
- *	(assume there are @nr_pages pages to load)
- */
-
-static int load_image(struct swap_map_handle *handle,
-                      struct snapshot_handle *snapshot,
-                      unsigned int nr_to_read)
-{
-	unsigned int m;
-	int ret =3D 0;
-	ktime_t start;
-	ktime_t stop;
-	struct hib_bio_batch hb;
-	int err2;
-	unsigned nr_pages;
-
-	hib_init_batch(&hb);
-
-	clean_pages_on_read =3D true;
-	pr_info("Loading image data pages (%u pages)...\n", nr_to_read);
-	m =3D nr_to_read / 10;
-	if (!m)
-		m =3D 1;
-	nr_pages =3D 0;
-	start =3D ktime_get();
-	for ( ; ; ) {
-		ret =3D snapshot_write_next(snapshot);
-		if (ret <=3D 0)
-			break;
-		ret =3D swap_read_page(handle, data_of(*snapshot), &hb);
-		if (ret)
-			break;
-		if (snapshot->sync_read)
-			ret =3D hib_wait_io(&hb);
-		if (ret)
-			break;
-		if (!(nr_pages % m))
-			pr_info("Image loading progress: %3d%%\n",
-				nr_pages / m * 10);
-		nr_pages++;
-	}
-	err2 =3D hib_wait_io(&hb);
-	hib_finish_batch(&hb);
-	stop =3D ktime_get();
-	if (!ret)
-		ret =3D err2;
-	if (!ret) {
-		pr_info("Image loading done\n");
-		ret =3D snapshot_write_finalize(snapshot);
-		if (!ret && !snapshot_image_loaded(snapshot))
-			ret =3D -ENODATA;
-	}
-	swsusp_show_speed(start, stop, nr_to_read, "Read");
-	return ret;
-}
-
-/*
- * Structure used for data decompression.
- */
-struct dec_data {
-	struct task_struct *thr;                  /* thread */
-	struct crypto_comp *cc;                   /* crypto compressor stream */
-	atomic_t ready;                           /* ready to start flag */
-	atomic_t stop;                            /* ready to stop flag */
-	int ret;                                  /* return code */
-	wait_queue_head_t go;                     /* start decompression */
-	wait_queue_head_t done;                   /* decompression done */
-	size_t unc_len;                           /* uncompressed length */
-	size_t cmp_len;                           /* compressed length */
-	unsigned char unc[UNC_SIZE];              /* uncompressed buffer */
-	unsigned char cmp[CMP_SIZE];              /* compressed buffer */
-};
-
-/*
- * Decompression function that runs in its own thread.
- */
-static int decompress_threadfn(void *data)
-{
-	struct dec_data *d =3D data;
-	unsigned int unc_len =3D 0;
-
-	while (1) {
-		wait_event(d->go, atomic_read_acquire(&d->ready) ||
-		                  kthread_should_stop());
-		if (kthread_should_stop()) {
-			d->thr =3D NULL;
-			d->ret =3D -1;
-			atomic_set_release(&d->stop, 1);
-			wake_up(&d->done);
-			break;
-		}
-		atomic_set(&d->ready, 0);
-
-		unc_len =3D UNC_SIZE;
-		d->ret =3D crypto_comp_decompress(d->cc, d->cmp + CMP_HEADER, d->cmp_len,
-						d->unc, &unc_len);
-		d->unc_len =3D unc_len;
-
-		if (clean_pages_on_decompress)
-			flush_icache_range((unsigned long)d->unc,
-					   (unsigned long)d->unc + d->unc_len);
-
-		atomic_set_release(&d->stop, 1);
-		wake_up(&d->done);
-	}
-	return 0;
-}
-
-/**
- * load_compressed_image - Load compressed image data and decompress it.
- * @handle: Swap map handle to use for loading data.
- * @snapshot: Image to copy uncompressed data into.
- * @nr_to_read: Number of pages to load.
- */
-static int load_compressed_image(struct swap_map_handle *handle,
-				 struct snapshot_handle *snapshot,
-				 unsigned int nr_to_read)
-{
-	unsigned int m;
-	int ret =3D 0;
-	int eof =3D 0;
-	struct hib_bio_batch hb;
-	ktime_t start;
-	ktime_t stop;
-	unsigned nr_pages;
-	size_t off;
-	unsigned i, thr, run_threads, nr_threads;
-	unsigned ring =3D 0, pg =3D 0, ring_size =3D 0,
-	         have =3D 0, want, need, asked =3D 0;
-	unsigned long read_pages =3D 0;
-	unsigned char **page =3D NULL;
-	struct dec_data *data =3D NULL;
-	struct crc_data *crc =3D NULL;
-
-	hib_init_batch(&hb);
-
-	/*
-	 * We'll limit the number of threads for decompression to limit memory
-	 * footprint.
-	 */
-	nr_threads =3D num_online_cpus() - 1;
-	nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);
-
-	page =3D vmalloc(array_size(CMP_MAX_RD_PAGES, sizeof(*page)));
-	if (!page) {
-		pr_err("Failed to allocate %s page\n", hib_comp_algo);
-		ret =3D -ENOMEM;
-		goto out_clean;
-	}
-
-	data =3D vzalloc(array_size(nr_threads, sizeof(*data)));
-	if (!data) {
-		pr_err("Failed to allocate %s data\n", hib_comp_algo);
-		ret =3D -ENOMEM;
-		goto out_clean;
-	}
-
-	crc =3D kzalloc(sizeof(*crc), GFP_KERNEL);
-	if (!crc) {
-		pr_err("Failed to allocate crc\n");
-		ret =3D -ENOMEM;
-		goto out_clean;
-	}
-
-	clean_pages_on_decompress =3D true;
-
-	/*
-	 * Start the decompression threads.
-	 */
-	for (thr =3D 0; thr < nr_threads; thr++) {
-		init_waitqueue_head(&data[thr].go);
-		init_waitqueue_head(&data[thr].done);
-
-		data[thr].cc =3D crypto_alloc_comp(hib_comp_algo, 0, 0);
-		if (IS_ERR_OR_NULL(data[thr].cc)) {
-			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));
-			ret =3D -EFAULT;
-			goto out_clean;
-		}
-
-		data[thr].thr =3D kthread_run(decompress_threadfn,
-		                            &data[thr],
-		                            "image_decompress/%u", thr);
-		if (IS_ERR(data[thr].thr)) {
-			data[thr].thr =3D NULL;
-			pr_err("Cannot start decompression threads\n");
-			ret =3D -ENOMEM;
-			goto out_clean;
-		}
-	}
-
-	/*
-	 * Start the CRC32 thread.
-	 */
-	init_waitqueue_head(&crc->go);
-	init_waitqueue_head(&crc->done);
-
-	handle->crc32 =3D 0;
-	crc->crc32 =3D &handle->crc32;
-	for (thr =3D 0; thr < nr_threads; thr++) {
-		crc->unc[thr] =3D data[thr].unc;
-		crc->unc_len[thr] =3D &data[thr].unc_len;
-	}
-
-	crc->thr =3D kthread_run(crc32_threadfn, crc, "image_crc32");
-	if (IS_ERR(crc->thr)) {
-		crc->thr =3D NULL;
-		pr_err("Cannot start CRC32 thread\n");
-		ret =3D -ENOMEM;
-		goto out_clean;
-	}
-
-	/*
-	 * Set the number of pages for read buffering.
-	 * This is complete guesswork, because we'll only know the real
-	 * picture once prepare_image() is called, which is much later on
-	 * during the image load phase. We'll assume the worst case and
-	 * say that none of the image pages are from high memory.
-	 */
-	if (low_free_pages() > snapshot_get_image_size())
-		read_pages =3D (low_free_pages() - snapshot_get_image_size()) / 2;
-	read_pages =3D clamp_val(read_pages, CMP_MIN_RD_PAGES, CMP_MAX_RD_PAGES);
-
-	for (i =3D 0; i < read_pages; i++) {
-		page[i] =3D (void *)__get_free_page(i < CMP_PAGES ?
-						  GFP_NOIO | __GFP_HIGH :
-						  GFP_NOIO | __GFP_NOWARN |
-						  __GFP_NORETRY);
-
-		if (!page[i]) {
-			if (i < CMP_PAGES) {
-				ring_size =3D i;
-				pr_err("Failed to allocate %s pages\n", hib_comp_algo);
-				ret =3D -ENOMEM;
-				goto out_clean;
-			} else {
-				break;
-			}
-		}
-	}
-	want =3D ring_size =3D i;
-
-	pr_info("Using %u thread(s) for %s decompression\n", nr_threads, hib_comp=
_algo);
-	pr_info("Loading and decompressing image data (%u pages)...\n",
-		nr_to_read);
-	m =3D nr_to_read / 10;
-	if (!m)
-		m =3D 1;
-	nr_pages =3D 0;
-	start =3D ktime_get();
-
-	ret =3D snapshot_write_next(snapshot);
-	if (ret <=3D 0)
-		goto out_finish;
-
-	for(;;) {
-		for (i =3D 0; !eof && i < want; i++) {
-			ret =3D swap_read_page(handle, page[ring], &hb);
-			if (ret) {
-				/*
-				 * On real read error, finish. On end of data,
-				 * set EOF flag and just exit the read loop.
-				 */
-				if (handle->cur &&
-				    handle->cur->entries[handle->k]) {
-					goto out_finish;
-				} else {
-					eof =3D 1;
-					break;
-				}
-			}
-			if (++ring >=3D ring_size)
-				ring =3D 0;
-		}
-		asked +=3D i;
-		want -=3D i;
-
-		/*
-		 * We are out of data, wait for some more.
-		 */
-		if (!have) {
-			if (!asked)
-				break;
-
-			ret =3D hib_wait_io(&hb);
-			if (ret)
-				goto out_finish;
-			have +=3D asked;
-			asked =3D 0;
-			if (eof)
-				eof =3D 2;
-		}
-
-		if (crc->run_threads) {
-			wait_event(crc->done, atomic_read_acquire(&crc->stop));
-			atomic_set(&crc->stop, 0);
-			crc->run_threads =3D 0;
-		}
-
-		for (thr =3D 0; have && thr < nr_threads; thr++) {
-			data[thr].cmp_len =3D *(size_t *)page[pg];
-			if (unlikely(!data[thr].cmp_len ||
-			             data[thr].cmp_len >
-					bytes_worst_compress(UNC_SIZE))) {
-				pr_err("Invalid %s compressed length\n", hib_comp_algo);
-				ret =3D -1;
-				goto out_finish;
-			}
-
-			need =3D DIV_ROUND_UP(data[thr].cmp_len + CMP_HEADER,
-			                    PAGE_SIZE);
-			if (need > have) {
-				if (eof > 1) {
-					ret =3D -1;
-					goto out_finish;
-				}
-				break;
-			}
-
-			for (off =3D 0;
-			     off < CMP_HEADER + data[thr].cmp_len;
-			     off +=3D PAGE_SIZE) {
-				memcpy(data[thr].cmp + off,
-				       page[pg], PAGE_SIZE);
-				have--;
-				want++;
-				if (++pg >=3D ring_size)
-					pg =3D 0;
-			}
-
-			atomic_set_release(&data[thr].ready, 1);
-			wake_up(&data[thr].go);
-		}
-
-		/*
-		 * Wait for more data while we are decompressing.
-		 */
-		if (have < CMP_PAGES && asked) {
-			ret =3D hib_wait_io(&hb);
-			if (ret)
-				goto out_finish;
-			have +=3D asked;
-			asked =3D 0;
-			if (eof)
-				eof =3D 2;
-		}
-
-		for (run_threads =3D thr, thr =3D 0; thr < run_threads; thr++) {
-			wait_event(data[thr].done,
-				atomic_read_acquire(&data[thr].stop));
-			atomic_set(&data[thr].stop, 0);
-
-			ret =3D data[thr].ret;
-
-			if (ret < 0) {
-				pr_err("%s decompression failed\n", hib_comp_algo);
-				goto out_finish;
-			}
-
-			if (unlikely(!data[thr].unc_len ||
-				data[thr].unc_len > UNC_SIZE ||
-				data[thr].unc_len & (PAGE_SIZE - 1))) {
-				pr_err("Invalid %s uncompressed length\n", hib_comp_algo);
-				ret =3D -1;
-				goto out_finish;
-			}
-
-			for (off =3D 0;
-			     off < data[thr].unc_len; off +=3D PAGE_SIZE) {
-				memcpy(data_of(*snapshot),
-				       data[thr].unc + off, PAGE_SIZE);
-
-				if (!(nr_pages % m))
-					pr_info("Image loading progress: %3d%%\n",
-						nr_pages / m * 10);
-				nr_pages++;
-
-				ret =3D snapshot_write_next(snapshot);
-				if (ret <=3D 0) {
-					crc->run_threads =3D thr + 1;
-					atomic_set_release(&crc->ready, 1);
-					wake_up(&crc->go);
-					goto out_finish;
-				}
-			}
-		}
-
-		crc->run_threads =3D thr;
-		atomic_set_release(&crc->ready, 1);
-		wake_up(&crc->go);
-	}
-
-out_finish:
-	if (crc->run_threads) {
-		wait_event(crc->done, atomic_read_acquire(&crc->stop));
-		atomic_set(&crc->stop, 0);
-	}
-	stop =3D ktime_get();
-	if (!ret) {
-		pr_info("Image loading done\n");
-		ret =3D snapshot_write_finalize(snapshot);
-		if (!ret && !snapshot_image_loaded(snapshot))
-			ret =3D -ENODATA;
-		if (!ret) {
-			if (swsusp_header->flags & SF_CRC32_MODE) {
-				if(handle->crc32 !=3D swsusp_header->crc32) {
-					pr_err("Invalid image CRC32!\n");
-					ret =3D -ENODATA;
-				}
-			}
-		}
-	}
-	swsusp_show_speed(start, stop, nr_to_read, "Read");
-out_clean:
-	hib_finish_batch(&hb);
-	for (i =3D 0; i < ring_size; i++)
-		free_page((unsigned long)page[i]);
-	if (crc) {
-		if (crc->thr)
-			kthread_stop(crc->thr);
-		kfree(crc);
-	}
-	if (data) {
-		for (thr =3D 0; thr < nr_threads; thr++) {
-			if (data[thr].thr)
-				kthread_stop(data[thr].thr);
-			if (data[thr].cc)
-				crypto_free_comp(data[thr].cc);
-		}
-		vfree(data);
-	}
-	vfree(page);
-
-	return ret;
-}
-
-/**
- *	swsusp_read - read the hibernation image.
- *	@flags_p: flags passed by the "frozen" kernel in the image header should
- *		  be written into this memory location
- */
-
-int swsusp_read(unsigned int *flags_p)
-{
-	int error;
-	struct swap_map_handle handle;
-	struct snapshot_handle snapshot;
-	struct swsusp_info *header;
-
-	memset(&snapshot, 0, sizeof(struct snapshot_handle));
-	error =3D snapshot_write_next(&snapshot);
-	if (error < (int)PAGE_SIZE)
-		return error < 0 ? error : -EFAULT;
-	header =3D (struct swsusp_info *)data_of(snapshot);
-	error =3D get_swap_reader(&handle, flags_p);
-	if (error)
-		goto end;
-	if (!error)
-		error =3D swap_read_page(&handle, header, NULL);
-	if (!error) {
-		error =3D (*flags_p & SF_NOCOMPRESS_MODE) ?
-			load_image(&handle, &snapshot, header->pages - 1) :
-			load_compressed_image(&handle, &snapshot, header->pages - 1);
-	}
-	swap_reader_finish(&handle);
-end:
-	if (!error)
-		pr_debug("Image successfully loaded\n");
-	else
-		pr_debug("Error %d resuming\n", error);
-	return error;
-}
-
-static void *swsusp_holder;
-
-/**
- * swsusp_check - Open the resume device and check for the swsusp signatur=
e.
- * @exclusive: Open the resume device exclusively.
- */
-
-int swsusp_check(bool exclusive)
-{
-	void *holder =3D exclusive ? &swsusp_holder : NULL;
-	int error;
-
-	hib_resume_bdev_file =3D bdev_file_open_by_dev(swsusp_resume_device,
-				BLK_OPEN_READ, holder, NULL);
-	if (!IS_ERR(hib_resume_bdev_file)) {
-		set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
-		clear_page(swsusp_header);
-		error =3D hib_submit_io(REQ_OP_READ, swsusp_resume_block,
-					swsusp_header, NULL);
-		if (error)
-			goto put;
-
-		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
-			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
-			swsusp_header_flags =3D swsusp_header->flags;
-			/* Reset swap signature now */
-			error =3D hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
-						swsusp_resume_block,
-						swsusp_header, NULL);
-		} else {
-			error =3D -EINVAL;
-		}
-		if (!error && swsusp_header->flags & SF_HW_SIG &&
-		    swsusp_header->hw_sig !=3D swsusp_hardware_signature) {
-			pr_info("Suspend image hardware signature mismatch (%08x now %08x); abo=
rting resume.\n",
-				swsusp_header->hw_sig, swsusp_hardware_signature);
-			error =3D -EINVAL;
-		}
-
-put:
-		if (error)
-			fput(hib_resume_bdev_file);
-		else
-			pr_debug("Image signature found, resuming\n");
-	} else {
-		error =3D PTR_ERR(hib_resume_bdev_file);
-	}
-
-	if (error)
-		pr_debug("Image not found (code %d)\n", error);
-
-	return error;
-}
-
-/**
- * swsusp_close - close resume device.
- */
-
-void swsusp_close(void)
-{
-	if (IS_ERR(hib_resume_bdev_file)) {
-		pr_debug("Image device not initialised\n");
-		return;
-	}
-
-	fput(hib_resume_bdev_file);
-}
-
-/**
- *      swsusp_unmark - Unmark swsusp signature in the resume device
- */
-
-#ifdef CONFIG_SUSPEND
-int swsusp_unmark(void)
-{
-	int error;
-
-	hib_submit_io(REQ_OP_READ, swsusp_resume_block,
-			swsusp_header, NULL);
-	if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {
-		memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);
-		error =3D hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
-					swsusp_resume_block,
-					swsusp_header, NULL);
-	} else {
-		pr_err("Cannot find swsusp signature!\n");
-		error =3D -ENODEV;
-	}
-
-	/*
-	 * We just returned from suspend, we don't need the image any more.
-	 */
-	free_all_swap_pages(root_swap);
-
-	return error;
-}
-#endif
-
-static int __init swsusp_header_init(void)
-{
-	swsusp_header =3D (struct swsusp_header*) __get_free_page(GFP_KERNEL);
-	if (!swsusp_header)
-		panic("Could not allocate memory for swsusp_header\n");
-	return 0;
-}
-
-core_initcall(swsusp_header_init);
+// SPDX-License-Identifier: GPL-2.0-only=0D
+/*=0D
+ * linux/kernel/power/swap.c=0D
+ *=0D
+ * This file provides functions for reading the suspend image from=0D
+ * and writing it to a swap partition.=0D
+ *=0D
+ * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@ucw.cz>=0D
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>=0D
+ * Copyright (C) 2010-2012 Bojan Smojver <bojan@rexursive.com>=0D
+ */=0D
+=0D
+#define pr_fmt(fmt) "PM: " fmt=0D
+=0D
+#include <linux/module.h>=0D
+#include <linux/file.h>=0D
+#include <linux/delay.h>=0D
+#include <linux/bitops.h>=0D
+#include <linux/device.h>=0D
+#include <linux/bio.h>=0D
+#include <linux/blkdev.h>=0D
+#include <linux/swap.h>=0D
+#include <linux/swapops.h>=0D
+#include <linux/pm.h>=0D
+#include <linux/slab.h>=0D
+#include <linux/vmalloc.h>=0D
+#include <linux/cpumask.h>=0D
+#include <linux/atomic.h>=0D
+#include <linux/kthread.h>=0D
+#include <linux/crc32.h>=0D
+#include <linux/ktime.h>=0D
+=0D
+#include "power.h"=0D
+=0D
+#define HIBERNATE_SIG	"S1SUSPEND"=0D
+=0D
+u32 swsusp_hardware_signature;=0D
+=0D
+/*=0D
+ * When reading an {un,}compressed image, we may restore pages in place,=0D
+ * in which case some architectures need these pages cleaning before they=
=0D
+ * can be executed. We don't know which pages these may be, so clean the l=
ot.=0D
+ */=0D
+static bool clean_pages_on_decompress;=0D
+=0D
+/*=0D
+ *	The swap map is a data structure used for keeping track of each page=0D
+ *	written to a swap partition.  It consists of many swap_map_page=0D
+ *	structures that contain each an array of MAP_PAGE_ENTRIES swap entries.=
=0D
+ *	These structures are stored on the swap and linked together with the=0D
+ *	help of the .next_swap member.=0D
+ *=0D
+ *	The swap map is created during suspend.  The swap map pages are=0D
+ *	allocated and populated one at a time, so we only need one memory=0D
+ *	page to set up the entire structure.=0D
+ *=0D
+ *	During resume we pick up all swap_map_page structures into a list.=0D
+ */=0D
+=0D
+#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(sector_t) - 1)=0D
+=0D
+/*=0D
+ * Number of free pages that are not high.=0D
+ */=0D
+static inline unsigned long low_free_pages(void)=0D
+{=0D
+	return nr_free_pages() - nr_free_highpages();=0D
+}=0D
+=0D
+/*=0D
+ * Number of pages required to be kept free while writing the image. Alway=
s=0D
+ * half of all available low pages before the writing starts.=0D
+ */=0D
+static inline unsigned long reqd_free_pages(void)=0D
+{=0D
+	return low_free_pages() / 2;=0D
+}=0D
+=0D
+struct swap_map_page {=0D
+	sector_t entries[MAP_PAGE_ENTRIES];=0D
+	sector_t next_swap;=0D
+};=0D
+=0D
+struct swap_map_page_list {=0D
+	struct swap_map_page *map;=0D
+	struct swap_map_page_list *next;=0D
+};=0D
+=0D
+/*=0D
+ *	The swap_map_handle structure is used for handling swap in=0D
+ *	a file-alike way=0D
+ */=0D
+=0D
+struct swap_map_handle {=0D
+	struct swap_map_page *cur;=0D
+	struct swap_map_page_list *maps;=0D
+	sector_t cur_swap;=0D
+	sector_t first_sector;=0D
+	unsigned int k;=0D
+	unsigned long reqd_free_pages;=0D
+	u32 crc32;=0D
+};=0D
+=0D
+struct swsusp_header {=0D
+	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int) -=0D
+	              sizeof(u32) - sizeof(u32)];=0D
+	u32	hw_sig;=0D
+	u32	crc32;=0D
+	sector_t image;=0D
+	unsigned int flags;	/* Flags to pass to the "boot" kernel */=0D
+	char	orig_sig[10];=0D
+	char	sig[10];=0D
+} __packed;=0D
+=0D
+static struct swsusp_header *swsusp_header;=0D
+=0D
+/*=0D
+ *	The following functions are used for tracing the allocated=0D
+ *	swap pages, so that they can be freed in case of an error.=0D
+ */=0D
+=0D
+struct swsusp_extent {=0D
+	struct rb_node node;=0D
+	unsigned long start;=0D
+	unsigned long end;=0D
+};=0D
+=0D
+static struct rb_root swsusp_extents =3D RB_ROOT;=0D
+=0D
+static int swsusp_extents_insert(unsigned long swap_offset)=0D
+{=0D
+	struct rb_node **new =3D &(swsusp_extents.rb_node);=0D
+	struct rb_node *parent =3D NULL;=0D
+	struct swsusp_extent *ext;=0D
+=0D
+	/* Figure out where to put the new node */=0D
+	while (*new) {=0D
+		ext =3D rb_entry(*new, struct swsusp_extent, node);=0D
+		parent =3D *new;=0D
+		if (swap_offset < ext->start) {=0D
+			/* Try to merge */=0D
+			if (swap_offset =3D=3D ext->start - 1) {=0D
+				ext->start--;=0D
+				return 0;=0D
+			}=0D
+			new =3D &((*new)->rb_left);=0D
+		} else if (swap_offset > ext->end) {=0D
+			/* Try to merge */=0D
+			if (swap_offset =3D=3D ext->end + 1) {=0D
+				ext->end++;=0D
+				return 0;=0D
+			}=0D
+			new =3D &((*new)->rb_right);=0D
+		} else {=0D
+			/* It already is in the tree */=0D
+			return -EINVAL;=0D
+		}=0D
+	}=0D
+	/* Add the new node and rebalance the tree. */=0D
+	ext =3D kzalloc(sizeof(struct swsusp_extent), GFP_KERNEL);=0D
+	if (!ext)=0D
+		return -ENOMEM;=0D
+=0D
+	ext->start =3D swap_offset;=0D
+	ext->end =3D swap_offset;=0D
+	rb_link_node(&ext->node, parent, new);=0D
+	rb_insert_color(&ext->node, &swsusp_extents);=0D
+	return 0;=0D
+}=0D
+=0D
+/*=0D
+ *	alloc_swapdev_block - allocate a swap page and register that it has=0D
+ *	been allocated, so that it can be freed in case of an error.=0D
+ */=0D
+=0D
+sector_t alloc_swapdev_block(int swap)=0D
+{=0D
+	unsigned long offset;=0D
+=0D
+	offset =3D swp_offset(get_swap_page_of_type(swap));=0D
+	if (offset) {=0D
+		if (swsusp_extents_insert(offset))=0D
+			swap_free(swp_entry(swap, offset));=0D
+		else=0D
+			return swapdev_block(swap, offset);=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+/*=0D
+ *	free_all_swap_pages - free swap pages allocated for saving image data.=
=0D
+ *	It also frees the extents used to register which swap entries had been=
=0D
+ *	allocated.=0D
+ */=0D
+=0D
+void free_all_swap_pages(int swap)=0D
+{=0D
+	struct rb_node *node;=0D
+=0D
+	while ((node =3D swsusp_extents.rb_node)) {=0D
+		struct swsusp_extent *ext;=0D
+		unsigned long offset;=0D
+=0D
+		ext =3D rb_entry(node, struct swsusp_extent, node);=0D
+		rb_erase(node, &swsusp_extents);=0D
+		for (offset =3D ext->start; offset <=3D ext->end; offset++)=0D
+			swap_free(swp_entry(swap, offset));=0D
+=0D
+		kfree(ext);=0D
+	}=0D
+}=0D
+=0D
+int swsusp_swap_in_use(void)=0D
+{=0D
+	return (swsusp_extents.rb_node !=3D NULL);=0D
+}=0D
+=0D
+/*=0D
+ * General things=0D
+ */=0D
+=0D
+static unsigned short root_swap =3D 0xffff;=0D
+static struct file *hib_resume_bdev_file;=0D
+=0D
+struct hib_bio_batch {=0D
+	atomic_t		count;=0D
+	wait_queue_head_t	wait;=0D
+	blk_status_t		error;=0D
+	struct blk_plug		plug;=0D
+};=0D
+=0D
+static void hib_init_batch(struct hib_bio_batch *hb)=0D
+{=0D
+	atomic_set(&hb->count, 0);=0D
+	init_waitqueue_head(&hb->wait);=0D
+	hb->error =3D BLK_STS_OK;=0D
+	blk_start_plug(&hb->plug);=0D
+}=0D
+=0D
+static void hib_finish_batch(struct hib_bio_batch *hb)=0D
+{=0D
+	blk_finish_plug(&hb->plug);=0D
+}=0D
+=0D
+static void hib_end_io(struct bio *bio)=0D
+{=0D
+	struct hib_bio_batch *hb =3D bio->bi_private;=0D
+	struct page *page =3D bio_first_page_all(bio);=0D
+=0D
+	if (bio->bi_status) {=0D
+		pr_alert("Read-error on swap-device (%u:%u:%Lu)\n",=0D
+			 MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),=0D
+			 (unsigned long long)bio->bi_iter.bi_sector);=0D
+	}=0D
+=0D
+	if (bio_data_dir(bio) =3D=3D WRITE)=0D
+		put_page(page);=0D
+=0D
+	if (bio->bi_status && !hb->error)=0D
+		hb->error =3D bio->bi_status;=0D
+	if (atomic_dec_and_test(&hb->count))=0D
+		wake_up(&hb->wait);=0D
+=0D
+	bio_put(bio);=0D
+}=0D
+=0D
+static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,=0D
+			 struct hib_bio_batch *hb)=0D
+{=0D
+	struct page *page =3D virt_to_page(addr);=0D
+	struct bio *bio;=0D
+	int error =3D 0;=0D
+=0D
+	bio =3D bio_alloc(file_bdev(hib_resume_bdev_file), 1, opf,=0D
+			GFP_NOIO | __GFP_HIGH);=0D
+	bio->bi_iter.bi_sector =3D page_off * (PAGE_SIZE >> 9);=0D
+=0D
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {=0D
+		pr_err("Adding page to bio failed at %llu\n",=0D
+		       (unsigned long long)bio->bi_iter.bi_sector);=0D
+		bio_put(bio);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	if (hb) {=0D
+		bio->bi_end_io =3D hib_end_io;=0D
+		bio->bi_private =3D hb;=0D
+		atomic_inc(&hb->count);=0D
+		submit_bio(bio);=0D
+	} else {=0D
+		error =3D submit_bio_wait(bio);=0D
+		bio_put(bio);=0D
+	}=0D
+=0D
+	return error;=0D
+}=0D
+=0D
+static int hib_wait_io(struct hib_bio_batch *hb)=0D
+{=0D
+	/*=0D
+	 * We are relying on the behavior of blk_plug that a thread with=0D
+	 * a plug will flush the plug list before sleeping.=0D
+	 */=0D
+	wait_event(hb->wait, atomic_read(&hb->count) =3D=3D 0);=0D
+	return blk_status_to_errno(hb->error);=0D
+}=0D
+=0D
+/*=0D
+ * Saving part=0D
+ */=0D
+static int mark_swapfiles(struct swap_map_handle *handle, unsigned int fla=
gs)=0D
+{=0D
+	int error;=0D
+=0D
+	hib_submit_io(REQ_OP_READ, swsusp_resume_block, swsusp_header, NULL);=0D
+	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||=0D
+	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {=0D
+		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);=0D
+		memcpy(swsusp_header->sig, HIBERNATE_SIG, 10);=0D
+		swsusp_header->image =3D handle->first_sector;=0D
+		if (swsusp_hardware_signature) {=0D
+			swsusp_header->hw_sig =3D swsusp_hardware_signature;=0D
+			flags |=3D SF_HW_SIG;=0D
+		}=0D
+		swsusp_header->flags =3D flags;=0D
+		if (flags & SF_CRC32_MODE)=0D
+			swsusp_header->crc32 =3D handle->crc32;=0D
+		error =3D hib_submit_io(REQ_OP_WRITE | REQ_SYNC,=0D
+				      swsusp_resume_block, swsusp_header, NULL);=0D
+	} else {=0D
+		pr_err("Swap header not found!\n");=0D
+		error =3D -ENODEV;=0D
+	}=0D
+	return error;=0D
+}=0D
+=0D
+/*=0D
+ * Hold the swsusp_header flag. This is used in software_resume() in=0D
+ * 'kernel/power/hibernate' to check if the image is compressed and query=
=0D
+ * for the compression algorithm support(if so).=0D
+ */=0D
+unsigned int swsusp_header_flags;=0D
+=0D
+/**=0D
+ *	swsusp_swap_check - check if the resume device is a swap device=0D
+ *	and get its index (if so)=0D
+ *=0D
+ *	This is called before saving image=0D
+ */=0D
+static int swsusp_swap_check(void)=0D
+{=0D
+	int res;=0D
+=0D
+	if (swsusp_resume_device)=0D
+		res =3D swap_type_of(swsusp_resume_device, swsusp_resume_block);=0D
+	else=0D
+		res =3D find_first_swap(&swsusp_resume_device);=0D
+	if (res < 0)=0D
+		return res;=0D
+	root_swap =3D res;=0D
+=0D
+	hib_resume_bdev_file =3D bdev_file_open_by_dev(swsusp_resume_device,=0D
+			BLK_OPEN_WRITE, NULL, NULL);=0D
+	if (IS_ERR(hib_resume_bdev_file))=0D
+		return PTR_ERR(hib_resume_bdev_file);=0D
+=0D
+	res =3D set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);=0D
+	if (res < 0)=0D
+		fput(hib_resume_bdev_file);=0D
+=0D
+	return res;=0D
+}=0D
+=0D
+/**=0D
+ *	write_page - Write one page to given swap location.=0D
+ *	@buf:		Address we're writing.=0D
+ *	@offset:	Offset of the swap page we're writing to.=0D
+ *	@hb:		bio completion batch=0D
+ */=0D
+=0D
+static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb=
)=0D
+{=0D
+	void *src;=0D
+	int ret;=0D
+=0D
+	if (!offset)=0D
+		return -ENOSPC;=0D
+=0D
+	if (hb) {=0D
+		src =3D (void *)__get_free_page(GFP_NOIO | __GFP_NOWARN |=0D
+		                              __GFP_NORETRY);=0D
+		if (src) {=0D
+			copy_page(src, buf);=0D
+		} else {=0D
+			ret =3D hib_wait_io(hb); /* Free pages */=0D
+			if (ret)=0D
+				return ret;=0D
+			src =3D (void *)__get_free_page(GFP_NOIO |=0D
+			                              __GFP_NOWARN |=0D
+			                              __GFP_NORETRY);=0D
+			if (src) {=0D
+				copy_page(src, buf);=0D
+			} else {=0D
+				WARN_ON_ONCE(1);=0D
+				hb =3D NULL;	/* Go synchronous */=0D
+				src =3D buf;=0D
+			}=0D
+		}=0D
+	} else {=0D
+		src =3D buf;=0D
+	}=0D
+	return hib_submit_io(REQ_OP_WRITE | REQ_SYNC, offset, src, hb);=0D
+}=0D
+=0D
+static void release_swap_writer(struct swap_map_handle *handle)=0D
+{=0D
+	if (handle->cur)=0D
+		free_page((unsigned long)handle->cur);=0D
+	handle->cur =3D NULL;=0D
+}=0D
+=0D
+static int get_swap_writer(struct swap_map_handle *handle)=0D
+{=0D
+	int ret;=0D
+=0D
+	ret =3D swsusp_swap_check();=0D
+	if (ret) {=0D
+		if (ret !=3D -ENOSPC)=0D
+			pr_err("Cannot find swap device, try swapon -a\n");=0D
+		return ret;=0D
+	}=0D
+	handle->cur =3D (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);=0D
+	if (!handle->cur) {=0D
+		ret =3D -ENOMEM;=0D
+		goto err_close;=0D
+	}=0D
+	handle->cur_swap =3D alloc_swapdev_block(root_swap);=0D
+	if (!handle->cur_swap) {=0D
+		ret =3D -ENOSPC;=0D
+		goto err_rel;=0D
+	}=0D
+	handle->k =3D 0;=0D
+	handle->reqd_free_pages =3D reqd_free_pages();=0D
+	handle->first_sector =3D handle->cur_swap;=0D
+	return 0;=0D
+err_rel:=0D
+	release_swap_writer(handle);=0D
+err_close:=0D
+	swsusp_close();=0D
+	return ret;=0D
+}=0D
+=0D
+static int swap_write_page(struct swap_map_handle *handle, void *buf,=0D
+		struct hib_bio_batch *hb)=0D
+{=0D
+	int error;=0D
+	sector_t offset;=0D
+=0D
+	if (!handle->cur)=0D
+		return -EINVAL;=0D
+	offset =3D alloc_swapdev_block(root_swap);=0D
+	error =3D write_page(buf, offset, hb);=0D
+	if (error)=0D
+		return error;=0D
+	handle->cur->entries[handle->k++] =3D offset;=0D
+	if (handle->k >=3D MAP_PAGE_ENTRIES) {=0D
+		offset =3D alloc_swapdev_block(root_swap);=0D
+		if (!offset)=0D
+			return -ENOSPC;=0D
+		handle->cur->next_swap =3D offset;=0D
+		error =3D write_page(handle->cur, handle->cur_swap, hb);=0D
+		if (error)=0D
+			goto out;=0D
+		clear_page(handle->cur);=0D
+		handle->cur_swap =3D offset;=0D
+		handle->k =3D 0;=0D
+=0D
+		if (hb && low_free_pages() <=3D handle->reqd_free_pages) {=0D
+			error =3D hib_wait_io(hb);=0D
+			if (error)=0D
+				goto out;=0D
+			/*=0D
+			 * Recalculate the number of required free pages, to=0D
+			 * make sure we never take more than half.=0D
+			 */=0D
+			handle->reqd_free_pages =3D reqd_free_pages();=0D
+		}=0D
+	}=0D
+ out:=0D
+	return error;=0D
+}=0D
+=0D
+static int flush_swap_writer(struct swap_map_handle *handle)=0D
+{=0D
+	if (handle->cur && handle->cur_swap)=0D
+		return write_page(handle->cur, handle->cur_swap, NULL);=0D
+	else=0D
+		return -EINVAL;=0D
+}=0D
+=0D
+static int swap_writer_finish(struct swap_map_handle *handle,=0D
+		unsigned int flags, int error)=0D
+{=0D
+	if (!error) {=0D
+		pr_info("S");=0D
+		error =3D mark_swapfiles(handle, flags);=0D
+		pr_cont("|\n");=0D
+		flush_swap_writer(handle);=0D
+	}=0D
+=0D
+	if (error)=0D
+		free_all_swap_pages(root_swap);=0D
+	release_swap_writer(handle);=0D
+	swsusp_close();=0D
+=0D
+	return error;=0D
+}=0D
+=0D
+/*=0D
+ * Bytes we need for compressed data in worst case. We assume(limitation)=
=0D
+ * this is the worst of all the compression algorithms.=0D
+ */=0D
+#define bytes_worst_compress(x) ((x) + ((x) / 16) + 64 + 3 + 2)=0D
+=0D
+/* We need to remember how much compressed data we need to read. */=0D
+#define CMP_HEADER	sizeof(size_t)=0D
+=0D
+/* Number of pages/bytes we'll compress at one time. */=0D
+#define UNC_PAGES	32=0D
+#define UNC_SIZE	(UNC_PAGES * PAGE_SIZE)=0D
+=0D
+/* Number of pages we need for compressed data (worst case). */=0D
+#define CMP_PAGES	DIV_ROUND_UP(bytes_worst_compress(UNC_SIZE) + \=0D
+				CMP_HEADER, PAGE_SIZE)=0D
+#define CMP_SIZE	(CMP_PAGES * PAGE_SIZE)=0D
+=0D
+/* Maximum number of threads for compression/decompression. */=0D
+#define CMP_THREADS	3=0D
+=0D
+/* Minimum/maximum number of pages for read buffering. */=0D
+#define CMP_MIN_RD_PAGES	1024=0D
+#define CMP_MAX_RD_PAGES	8192=0D
+=0D
+/**=0D
+ *	save_image - save the suspend image data=0D
+ */=0D
+=0D
+static int save_image(struct swap_map_handle *handle,=0D
+                      struct snapshot_handle *snapshot,=0D
+                      unsigned int nr_to_write)=0D
+{=0D
+	unsigned int m;=0D
+	int ret;=0D
+	int nr_pages;=0D
+	int err2;=0D
+	struct hib_bio_batch hb;=0D
+	ktime_t start;=0D
+	ktime_t stop;=0D
+=0D
+	hib_init_batch(&hb);=0D
+=0D
+	pr_info("Saving image data pages (%u pages)...\n",=0D
+		nr_to_write);=0D
+	m =3D nr_to_write / 10;=0D
+	if (!m)=0D
+		m =3D 1;=0D
+	nr_pages =3D 0;=0D
+	start =3D ktime_get();=0D
+	while (1) {=0D
+		ret =3D snapshot_read_next(snapshot);=0D
+		if (ret <=3D 0)=0D
+			break;=0D
+		ret =3D swap_write_page(handle, data_of(*snapshot), &hb);=0D
+		if (ret)=0D
+			break;=0D
+		if (!(nr_pages % m))=0D
+			pr_info("Image saving progress: %3d%%\n",=0D
+				nr_pages / m * 10);=0D
+		nr_pages++;=0D
+	}=0D
+	err2 =3D hib_wait_io(&hb);=0D
+	hib_finish_batch(&hb);=0D
+	stop =3D ktime_get();=0D
+	if (!ret)=0D
+		ret =3D err2;=0D
+	if (!ret)=0D
+		pr_info("Image saving done\n");=0D
+	swsusp_show_speed(start, stop, nr_to_write, "Wrote");=0D
+	return ret;=0D
+}=0D
+=0D
+/*=0D
+ * Structure used for CRC32.=0D
+ */=0D
+struct crc_data {=0D
+	struct task_struct *thr;                  /* thread */=0D
+	atomic_t ready;                           /* ready to start flag */=0D
+	atomic_t stop;                            /* ready to stop flag */=0D
+	unsigned run_threads;                     /* nr current threads */=0D
+	wait_queue_head_t go;                     /* start crc update */=0D
+	wait_queue_head_t done;                   /* crc update done */=0D
+	u32 *crc32;                               /* points to handle's crc32 */=
=0D
+	size_t *unc_len[CMP_THREADS];             /* uncompressed lengths */=0D
+	unsigned char *unc[CMP_THREADS];          /* uncompressed data */=0D
+};=0D
+=0D
+/*=0D
+ * CRC32 update function that runs in its own thread.=0D
+ */=0D
+static int crc32_threadfn(void *data)=0D
+{=0D
+	struct crc_data *d =3D data;=0D
+	unsigned i;=0D
+=0D
+	while (1) {=0D
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||=0D
+		                  kthread_should_stop());=0D
+		if (kthread_should_stop()) {=0D
+			d->thr =3D NULL;=0D
+			atomic_set_release(&d->stop, 1);=0D
+			wake_up(&d->done);=0D
+			break;=0D
+		}=0D
+		atomic_set(&d->ready, 0);=0D
+=0D
+		for (i =3D 0; i < d->run_threads; i++)=0D
+			*d->crc32 =3D crc32_le(*d->crc32,=0D
+			                     d->unc[i], *d->unc_len[i]);=0D
+		atomic_set_release(&d->stop, 1);=0D
+		wake_up(&d->done);=0D
+	}=0D
+	return 0;=0D
+}=0D
+/*=0D
+ * Structure used for data compression.=0D
+ */=0D
+struct cmp_data {=0D
+	struct task_struct *thr;                  /* thread */=0D
+	struct crypto_comp *cc;                   /* crypto compressor stream */=
=0D
+	atomic_t ready;                           /* ready to start flag */=0D
+	atomic_t stop;                            /* ready to stop flag */=0D
+	int ret;                                  /* return code */=0D
+	wait_queue_head_t go;                     /* start compression */=0D
+	wait_queue_head_t done;                   /* compression done */=0D
+	size_t unc_len;                           /* uncompressed length */=0D
+	size_t cmp_len;                           /* compressed length */=0D
+	unsigned char unc[UNC_SIZE];              /* uncompressed buffer */=0D
+	unsigned char cmp[CMP_SIZE];              /* compressed buffer */=0D
+};=0D
+=0D
+/* Indicates the image size after compression */=0D
+static atomic_t compressed_size =3D ATOMIC_INIT(0);=0D
+=0D
+/*=0D
+ * Compression function that runs in its own thread.=0D
+ */=0D
+static int compress_threadfn(void *data)=0D
+{=0D
+	struct cmp_data *d =3D data;=0D
+	unsigned int cmp_len =3D 0;=0D
+=0D
+	while (1) {=0D
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||=0D
+		                  kthread_should_stop());=0D
+		if (kthread_should_stop()) {=0D
+			d->thr =3D NULL;=0D
+			d->ret =3D -1;=0D
+			atomic_set_release(&d->stop, 1);=0D
+			wake_up(&d->done);=0D
+			break;=0D
+		}=0D
+		atomic_set(&d->ready, 0);=0D
+=0D
+		cmp_len =3D CMP_SIZE - CMP_HEADER;=0D
+		d->ret =3D crypto_comp_compress(d->cc, d->unc, d->unc_len,=0D
+					      d->cmp + CMP_HEADER,=0D
+					      &cmp_len);=0D
+		d->cmp_len =3D cmp_len;=0D
+=0D
+		atomic_set(&compressed_size, atomic_read(&compressed_size) + d->cmp_len)=
;=0D
+		atomic_set_release(&d->stop, 1);=0D
+		wake_up(&d->done);=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * save_compressed_image - Save the suspend image data after compression.=
=0D
+ * @handle: Swap map handle to use for saving the image.=0D
+ * @snapshot: Image to read data from.=0D
+ * @nr_to_write: Number of pages to save.=0D
+ */=0D
+static int save_compressed_image(struct swap_map_handle *handle,=0D
+				 struct snapshot_handle *snapshot,=0D
+				 unsigned int nr_to_write)=0D
+{=0D
+	unsigned int m;=0D
+	int ret =3D 0;=0D
+	int nr_pages;=0D
+	int err2;=0D
+	struct hib_bio_batch hb;=0D
+	ktime_t start;=0D
+	ktime_t stop;=0D
+	size_t off;=0D
+	unsigned thr, run_threads, nr_threads;=0D
+	unsigned char *page =3D NULL;=0D
+	struct cmp_data *data =3D NULL;=0D
+	struct crc_data *crc =3D NULL;=0D
+=0D
+	hib_init_batch(&hb);=0D
+=0D
+	atomic_set(&compressed_size, 0);=0D
+=0D
+	/*=0D
+	 * We'll limit the number of threads for compression to limit memory=0D
+	 * footprint.=0D
+	 */=0D
+	nr_threads =3D num_online_cpus() - 1;=0D
+	nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);=0D
+=0D
+	page =3D (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);=0D
+	if (!page) {=0D
+		pr_err("Failed to allocate %s page\n", hib_comp_algo);=0D
+		ret =3D -ENOMEM;=0D
+		goto out_clean;=0D
+	}=0D
+=0D
+	data =3D vzalloc(array_size(nr_threads, sizeof(*data)));=0D
+	if (!data) {=0D
+		pr_err("Failed to allocate %s data\n", hib_comp_algo);=0D
+		ret =3D -ENOMEM;=0D
+		goto out_clean;=0D
+	}=0D
+=0D
+	crc =3D kzalloc(sizeof(*crc), GFP_KERNEL);=0D
+	if (!crc) {=0D
+		pr_err("Failed to allocate crc\n");=0D
+		ret =3D -ENOMEM;=0D
+		goto out_clean;=0D
+	}=0D
+=0D
+	/*=0D
+	 * Start the compression threads.=0D
+	 */=0D
+	for (thr =3D 0; thr < nr_threads; thr++) {=0D
+		init_waitqueue_head(&data[thr].go);=0D
+		init_waitqueue_head(&data[thr].done);=0D
+=0D
+		data[thr].cc =3D crypto_alloc_comp(hib_comp_algo, 0, 0);=0D
+		if (IS_ERR_OR_NULL(data[thr].cc)) {=0D
+			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));=
=0D
+			ret =3D -EFAULT;=0D
+			goto out_clean;=0D
+		}=0D
+=0D
+		data[thr].thr =3D kthread_run(compress_threadfn,=0D
+		                            &data[thr],=0D
+		                            "image_compress/%u", thr);=0D
+		if (IS_ERR(data[thr].thr)) {=0D
+			data[thr].thr =3D NULL;=0D
+			pr_err("Cannot start compression threads\n");=0D
+			ret =3D -ENOMEM;=0D
+			goto out_clean;=0D
+		}=0D
+	}=0D
+=0D
+	/*=0D
+	 * Start the CRC32 thread.=0D
+	 */=0D
+	init_waitqueue_head(&crc->go);=0D
+	init_waitqueue_head(&crc->done);=0D
+=0D
+	handle->crc32 =3D 0;=0D
+	crc->crc32 =3D &handle->crc32;=0D
+	for (thr =3D 0; thr < nr_threads; thr++) {=0D
+		crc->unc[thr] =3D data[thr].unc;=0D
+		crc->unc_len[thr] =3D &data[thr].unc_len;=0D
+	}=0D
+=0D
+	crc->thr =3D kthread_run(crc32_threadfn, crc, "image_crc32");=0D
+	if (IS_ERR(crc->thr)) {=0D
+		crc->thr =3D NULL;=0D
+		pr_err("Cannot start CRC32 thread\n");=0D
+		ret =3D -ENOMEM;=0D
+		goto out_clean;=0D
+	}=0D
+=0D
+	/*=0D
+	 * Adjust the number of required free pages after all allocations have=0D
+	 * been done. We don't want to run out of pages when writing.=0D
+	 */=0D
+	handle->reqd_free_pages =3D reqd_free_pages();=0D
+=0D
+	pr_info("Using %u thread(s) for %s compression\n", nr_threads, hib_comp_a=
lgo);=0D
+	pr_info("Compressing and saving image data (%u pages)...\n",=0D
+		nr_to_write);=0D
+	m =3D nr_to_write / 10;=0D
+	if (!m)=0D
+		m =3D 1;=0D
+	nr_pages =3D 0;=0D
+	start =3D ktime_get();=0D
+	for (;;) {=0D
+		for (thr =3D 0; thr < nr_threads; thr++) {=0D
+			for (off =3D 0; off < UNC_SIZE; off +=3D PAGE_SIZE) {=0D
+				ret =3D snapshot_read_next(snapshot);=0D
+				if (ret < 0)=0D
+					goto out_finish;=0D
+=0D
+				if (!ret)=0D
+					break;=0D
+=0D
+				memcpy(data[thr].unc + off,=0D
+				       data_of(*snapshot), PAGE_SIZE);=0D
+=0D
+				if (!(nr_pages % m))=0D
+					pr_info("Image saving progress: %3d%%\n",=0D
+						nr_pages / m * 10);=0D
+				nr_pages++;=0D
+			}=0D
+			if (!off)=0D
+				break;=0D
+=0D
+			data[thr].unc_len =3D off;=0D
+=0D
+			atomic_set_release(&data[thr].ready, 1);=0D
+			wake_up(&data[thr].go);=0D
+		}=0D
+=0D
+		if (!thr)=0D
+			break;=0D
+=0D
+		crc->run_threads =3D thr;=0D
+		atomic_set_release(&crc->ready, 1);=0D
+		wake_up(&crc->go);=0D
+=0D
+		for (run_threads =3D thr, thr =3D 0; thr < run_threads; thr++) {=0D
+			wait_event(data[thr].done,=0D
+				atomic_read_acquire(&data[thr].stop));=0D
+			atomic_set(&data[thr].stop, 0);=0D
+=0D
+			ret =3D data[thr].ret;=0D
+=0D
+			if (ret < 0) {=0D
+				pr_err("%s compression failed\n", hib_comp_algo);=0D
+				goto out_finish;=0D
+			}=0D
+=0D
+			if (unlikely(!data[thr].cmp_len ||=0D
+			             data[thr].cmp_len >=0D
+				     bytes_worst_compress(data[thr].unc_len))) {=0D
+				pr_err("Invalid %s compressed length\n", hib_comp_algo);=0D
+				ret =3D -1;=0D
+				goto out_finish;=0D
+			}=0D
+=0D
+			*(size_t *)data[thr].cmp =3D data[thr].cmp_len;=0D
+=0D
+			/*=0D
+			 * Given we are writing one page at a time to disk, we=0D
+			 * copy that much from the buffer, although the last=0D
+			 * bit will likely be smaller than full page. This is=0D
+			 * OK - we saved the length of the compressed data, so=0D
+			 * any garbage at the end will be discarded when we=0D
+			 * read it.=0D
+			 */=0D
+			for (off =3D 0;=0D
+			     off < CMP_HEADER + data[thr].cmp_len;=0D
+			     off +=3D PAGE_SIZE) {=0D
+				memcpy(page, data[thr].cmp + off, PAGE_SIZE);=0D
+=0D
+				ret =3D swap_write_page(handle, page, &hb);=0D
+				if (ret)=0D
+					goto out_finish;=0D
+			}=0D
+		}=0D
+=0D
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));=0D
+		atomic_set(&crc->stop, 0);=0D
+	}=0D
+=0D
+out_finish:=0D
+	err2 =3D hib_wait_io(&hb);=0D
+	stop =3D ktime_get();=0D
+	if (!ret)=0D
+		ret =3D err2;=0D
+	if (!ret)=0D
+		pr_info("Image saving done\n");=0D
+	swsusp_show_speed(start, stop, nr_to_write, "Wrote");=0D
+	pr_info("Image size after compression: %d kbytes\n",=0D
+		(atomic_read(&compressed_size) / 1024));=0D
+=0D
+out_clean:=0D
+	hib_finish_batch(&hb);=0D
+	if (crc) {=0D
+		if (crc->thr)=0D
+			kthread_stop(crc->thr);=0D
+		kfree(crc);=0D
+	}=0D
+	if (data) {=0D
+		for (thr =3D 0; thr < nr_threads; thr++) {=0D
+			if (data[thr].thr)=0D
+				kthread_stop(data[thr].thr);=0D
+			if (data[thr].cc)=0D
+				crypto_free_comp(data[thr].cc);=0D
+		}=0D
+		vfree(data);=0D
+	}=0D
+	if (page) free_page((unsigned long)page);=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+/**=0D
+ *	enough_swap - Make sure we have enough swap to save the image.=0D
+ *=0D
+ *	Returns TRUE or FALSE after checking the total amount of swap=0D
+ *	space available from the resume partition.=0D
+ */=0D
+=0D
+static int enough_swap(unsigned int nr_pages)=0D
+{=0D
+	unsigned int free_swap =3D count_swap_pages(root_swap, 1);=0D
+	unsigned int required;=0D
+=0D
+	pr_debug("Free swap pages: %u\n", free_swap);=0D
+=0D
+	required =3D PAGES_FOR_IO + nr_pages;=0D
+	return free_swap > required;=0D
+}=0D
+=0D
+/**=0D
+ *	swsusp_write - Write entire image and metadata.=0D
+ *	@flags: flags to pass to the "boot" kernel in the image header=0D
+ *=0D
+ *	It is important _NOT_ to umount filesystems at this point. We want=0D
+ *	them synced (in case something goes wrong) but we DO not want to mark=0D
+ *	filesystem clean: it is not. (And it does not matter, if we resume=0D
+ *	correctly, we'll mark system clean, anyway.)=0D
+ */=0D
+=0D
+int swsusp_write(unsigned int flags)=0D
+{=0D
+	struct swap_map_handle handle;=0D
+	struct snapshot_handle snapshot;=0D
+	struct swsusp_info *header;=0D
+	unsigned long pages;=0D
+	int error;=0D
+=0D
+	pages =3D snapshot_get_image_size();=0D
+	error =3D get_swap_writer(&handle);=0D
+	if (error) {=0D
+		pr_err("Cannot get swap writer\n");=0D
+		return error;=0D
+	}=0D
+	if (flags & SF_NOCOMPRESS_MODE) {=0D
+		if (!enough_swap(pages)) {=0D
+			pr_err("Not enough free swap\n");=0D
+			error =3D -ENOSPC;=0D
+			goto out_finish;=0D
+		}=0D
+	}=0D
+	memset(&snapshot, 0, sizeof(struct snapshot_handle));=0D
+	error =3D snapshot_read_next(&snapshot);=0D
+	if (error < (int)PAGE_SIZE) {=0D
+		if (error >=3D 0)=0D
+			error =3D -EFAULT;=0D
+=0D
+		goto out_finish;=0D
+	}=0D
+	header =3D (struct swsusp_info *)data_of(snapshot);=0D
+	error =3D swap_write_page(&handle, header, NULL);=0D
+	if (!error) {=0D
+		error =3D (flags & SF_NOCOMPRESS_MODE) ?=0D
+			save_image(&handle, &snapshot, pages - 1) :=0D
+			save_compressed_image(&handle, &snapshot, pages - 1);=0D
+	}=0D
+out_finish:=0D
+	error =3D swap_writer_finish(&handle, flags, error);=0D
+	return error;=0D
+}=0D
+=0D
+/*=0D
+ *	The following functions allow us to read data using a swap map=0D
+ *	in a file-like way.=0D
+ */=0D
+=0D
+static void release_swap_reader(struct swap_map_handle *handle)=0D
+{=0D
+	struct swap_map_page_list *tmp;=0D
+=0D
+	while (handle->maps) {=0D
+		if (handle->maps->map)=0D
+			free_page((unsigned long)handle->maps->map);=0D
+		tmp =3D handle->maps;=0D
+		handle->maps =3D handle->maps->next;=0D
+		kfree(tmp);=0D
+	}=0D
+	handle->cur =3D NULL;=0D
+}=0D
+=0D
+static int get_swap_reader(struct swap_map_handle *handle,=0D
+		unsigned int *flags_p)=0D
+{=0D
+	int error;=0D
+	struct swap_map_page_list *tmp, *last;=0D
+	sector_t offset;=0D
+=0D
+	*flags_p =3D swsusp_header->flags;=0D
+=0D
+	if (!swsusp_header->image) /* how can this happen? */=0D
+		return -EINVAL;=0D
+=0D
+	handle->cur =3D NULL;=0D
+	last =3D handle->maps =3D NULL;=0D
+	offset =3D swsusp_header->image;=0D
+	while (offset) {=0D
+		tmp =3D kzalloc(sizeof(*handle->maps), GFP_KERNEL);=0D
+		if (!tmp) {=0D
+			release_swap_reader(handle);=0D
+			return -ENOMEM;=0D
+		}=0D
+		if (!handle->maps)=0D
+			handle->maps =3D tmp;=0D
+		if (last)=0D
+			last->next =3D tmp;=0D
+		last =3D tmp;=0D
+=0D
+		tmp->map =3D (struct swap_map_page *)=0D
+			   __get_free_page(GFP_NOIO | __GFP_HIGH);=0D
+		if (!tmp->map) {=0D
+			release_swap_reader(handle);=0D
+			return -ENOMEM;=0D
+		}=0D
+=0D
+		error =3D hib_submit_io(REQ_OP_READ, offset, tmp->map, NULL);=0D
+		if (error) {=0D
+			release_swap_reader(handle);=0D
+			return error;=0D
+		}=0D
+		offset =3D tmp->map->next_swap;=0D
+	}=0D
+	handle->k =3D 0;=0D
+	handle->cur =3D handle->maps->map;=0D
+	return 0;=0D
+}=0D
+=0D
+static int swap_read_page(struct swap_map_handle *handle, void *buf,=0D
+		struct hib_bio_batch *hb)=0D
+{=0D
+	sector_t offset;=0D
+	int error;=0D
+	struct swap_map_page_list *tmp;=0D
+=0D
+	if (!handle->cur)=0D
+		return -EINVAL;=0D
+	offset =3D handle->cur->entries[handle->k];=0D
+	if (!offset)=0D
+		return -EFAULT;=0D
+	error =3D hib_submit_io(REQ_OP_READ, offset, buf, hb);=0D
+	if (error)=0D
+		return error;=0D
+	if (++handle->k >=3D MAP_PAGE_ENTRIES) {=0D
+		handle->k =3D 0;=0D
+		free_page((unsigned long)handle->maps->map);=0D
+		tmp =3D handle->maps;=0D
+		handle->maps =3D handle->maps->next;=0D
+		kfree(tmp);=0D
+		if (!handle->maps)=0D
+			release_swap_reader(handle);=0D
+		else=0D
+			handle->cur =3D handle->maps->map;=0D
+	}=0D
+	return error;=0D
+}=0D
+=0D
+static int swap_reader_finish(struct swap_map_handle *handle)=0D
+{=0D
+	release_swap_reader(handle);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+struct swsusp_readpages {=0D
+	unsigned long size;=0D
+	unsigned long cursor;=0D
+	struct page **pages;=0D
+};=0D
+=0D
+static int swsusp_init_readpages(struct swsusp_readpages *read_pages, unsi=
gned int nr_to_read)=0D
+{=0D
+	read_pages->pages =3D (struct page **)vzalloc(sizeof(struct page *) * nr_=
to_read);=0D
+	if (!read_pages->pages) {=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	read_pages->size =3D nr_to_read;=0D
+	read_pages->cursor =3D 0;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+=0D
+static int swsusp_add_readpage(struct swsusp_readpages *read_pages, void *=
page_addr)=0D
+{=0D
+	if (read_pages->cursor >=3D read_pages->size) {=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	read_pages->pages[read_pages->cursor++] =3D virt_to_page(page_addr);=0D
+	return 0;=0D
+}=0D
+=0D
+static void swsusp_clean_readedpages(struct swsusp_readpages *read_pages, =
bool flush)=0D
+{=0D
+	unsigned long idx;=0D
+=0D
+	for (idx =3D 0; idx < read_pages->cursor; idx++) {=0D
+		if (flush && read_pages->pages[idx])=0D
+			flush_icache_range((unsigned long)page_address(read_pages->pages[idx]),=
=0D
+								(unsigned long)page_address(read_pages->pages[idx] + PAGE_SIZE));=
=0D
+	}=0D
+=0D
+	vfree(read_pages->pages);=0D
+	return;=0D
+}=0D
+=0D
+/**=0D
+ *	load_image - load the image using the swap map handle=0D
+ *	@handle and the snapshot handle @snapshot=0D
+ *	(assume there are @nr_pages pages to load)=0D
+ */=0D
+=0D
+static int load_image(struct swap_map_handle *handle,=0D
+                      struct snapshot_handle *snapshot,=0D
+                      unsigned int nr_to_read)=0D
+{=0D
+	unsigned int m;=0D
+	int ret =3D 0;=0D
+	ktime_t start;=0D
+	ktime_t stop;=0D
+	struct hib_bio_batch hb;=0D
+	int err2;=0D
+	unsigned nr_pages;=0D
+	struct swsusp_readpages pages_to_clean;=0D
+=0D
+	hib_init_batch(&hb);=0D
+	ret =3D swsusp_init_readpages(&pages_to_clean, nr_to_read);=0D
+	if (!ret) {=0D
+		return ret;=0D
+	}=0D
+=0D
+	pr_info("Loading image data pages (%u pages)...\n", nr_to_read);=0D
+	m =3D nr_to_read / 10;=0D
+	if (!m)=0D
+		m =3D 1;=0D
+	nr_pages =3D 0;=0D
+	start =3D ktime_get();=0D
+	for ( ; ; ) {=0D
+		ret =3D snapshot_write_next(snapshot);=0D
+		if (ret <=3D 0)=0D
+			break;=0D
+		ret =3D swap_read_page(handle, data_of(*snapshot), &hb);=0D
+		if (ret)=0D
+			break;=0D
+		if (snapshot->sync_read)=0D
+			ret =3D hib_wait_io(&hb);=0D
+		if (ret)=0D
+			break;=0D
+		ret =3D swsusp_add_readpage(&pages_to_clean, data_of(*snapshot));=0D
+		if (ret)=0D
+			break;=0D
+=0D
+		if (!(nr_pages % m))=0D
+			pr_info("Image loading progress: %3d%%\n",=0D
+				nr_pages / m * 10);=0D
+		nr_pages++;=0D
+	}=0D
+	err2 =3D hib_wait_io(&hb);=0D
+	hib_finish_batch(&hb);=0D
+	stop =3D ktime_get();=0D
+	if (!ret)=0D
+		ret =3D err2;=0D
+	swsusp_clean_readedpages(&pages_to_clean, !ret);=0D
+	if (!ret) {=0D
+		pr_info("Image loading done\n");=0D
+		ret =3D snapshot_write_finalize(snapshot);=0D
+		if (!ret && !snapshot_image_loaded(snapshot))=0D
+			ret =3D -ENODATA;=0D
+	}=0D
+	swsusp_show_speed(start, stop, nr_to_read, "Read");=0D
+	return ret;=0D
+}=0D
+=0D
+/*=0D
+ * Structure used for data decompression.=0D
+ */=0D
+struct dec_data {=0D
+	struct task_struct *thr;                  /* thread */=0D
+	struct crypto_comp *cc;                   /* crypto compressor stream */=
=0D
+	atomic_t ready;                           /* ready to start flag */=0D
+	atomic_t stop;                            /* ready to stop flag */=0D
+	int ret;                                  /* return code */=0D
+	wait_queue_head_t go;                     /* start decompression */=0D
+	wait_queue_head_t done;                   /* decompression done */=0D
+	size_t unc_len;                           /* uncompressed length */=0D
+	size_t cmp_len;                           /* compressed length */=0D
+	unsigned char unc[UNC_SIZE];              /* uncompressed buffer */=0D
+	unsigned char cmp[CMP_SIZE];              /* compressed buffer */=0D
+};=0D
+=0D
+/*=0D
+ * Decompression function that runs in its own thread.=0D
+ */=0D
+static int decompress_threadfn(void *data)=0D
+{=0D
+	struct dec_data *d =3D data;=0D
+	unsigned int unc_len =3D 0;=0D
+=0D
+	while (1) {=0D
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||=0D
+		                  kthread_should_stop());=0D
+		if (kthread_should_stop()) {=0D
+			d->thr =3D NULL;=0D
+			d->ret =3D -1;=0D
+			atomic_set_release(&d->stop, 1);=0D
+			wake_up(&d->done);=0D
+			break;=0D
+		}=0D
+		atomic_set(&d->ready, 0);=0D
+=0D
+		unc_len =3D UNC_SIZE;=0D
+		d->ret =3D crypto_comp_decompress(d->cc, d->cmp + CMP_HEADER, d->cmp_len=
,=0D
+						d->unc, &unc_len);=0D
+		d->unc_len =3D unc_len;=0D
+=0D
+		if (clean_pages_on_decompress)=0D
+			flush_icache_range((unsigned long)d->unc,=0D
+					   (unsigned long)d->unc + d->unc_len);=0D
+=0D
+		atomic_set_release(&d->stop, 1);=0D
+		wake_up(&d->done);=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * load_compressed_image - Load compressed image data and decompress it.=0D
+ * @handle: Swap map handle to use for loading data.=0D
+ * @snapshot: Image to copy uncompressed data into.=0D
+ * @nr_to_read: Number of pages to load.=0D
+ */=0D
+static int load_compressed_image(struct swap_map_handle *handle,=0D
+				 struct snapshot_handle *snapshot,=0D
+				 unsigned int nr_to_read)=0D
+{=0D
+	unsigned int m;=0D
+	int ret =3D 0;=0D
+	int eof =3D 0;=0D
+	struct hib_bio_batch hb;=0D
+	ktime_t start;=0D
+	ktime_t stop;=0D
+	unsigned nr_pages;=0D
+	size_t off;=0D
+	unsigned i, thr, run_threads, nr_threads;=0D
+	unsigned ring =3D 0, pg =3D 0, ring_size =3D 0,=0D
+	         have =3D 0, want, need, asked =3D 0;=0D
+	unsigned long read_pages =3D 0;=0D
+	unsigned char **page =3D NULL;=0D
+	struct dec_data *data =3D NULL;=0D
+	struct crc_data *crc =3D NULL;=0D
+=0D
+	hib_init_batch(&hb);=0D
+=0D
+	/*=0D
+	 * We'll limit the number of threads for decompression to limit memory=0D
+	 * footprint.=0D
+	 */=0D
+	nr_threads =3D num_online_cpus() - 1;=0D
+	nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);=0D
+=0D
+	page =3D vmalloc(array_size(CMP_MAX_RD_PAGES, sizeof(*page)));=0D
+	if (!page) {=0D
+		pr_err("Failed to allocate %s page\n", hib_comp_algo);=0D
+		ret =3D -ENOMEM;=0D
+		goto out_clean;=0D
+	}=0D
+=0D
+	data =3D vzalloc(array_size(nr_threads, sizeof(*data)));=0D
+	if (!data) {=0D
+		pr_err("Failed to allocate %s data\n", hib_comp_algo);=0D
+		ret =3D -ENOMEM;=0D
+		goto out_clean;=0D
+	}=0D
+=0D
+	crc =3D kzalloc(sizeof(*crc), GFP_KERNEL);=0D
+	if (!crc) {=0D
+		pr_err("Failed to allocate crc\n");=0D
+		ret =3D -ENOMEM;=0D
+		goto out_clean;=0D
+	}=0D
+=0D
+	clean_pages_on_decompress =3D true;=0D
+=0D
+	/*=0D
+	 * Start the decompression threads.=0D
+	 */=0D
+	for (thr =3D 0; thr < nr_threads; thr++) {=0D
+		init_waitqueue_head(&data[thr].go);=0D
+		init_waitqueue_head(&data[thr].done);=0D
+=0D
+		data[thr].cc =3D crypto_alloc_comp(hib_comp_algo, 0, 0);=0D
+		if (IS_ERR_OR_NULL(data[thr].cc)) {=0D
+			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));=
=0D
+			ret =3D -EFAULT;=0D
+			goto out_clean;=0D
+		}=0D
+=0D
+		data[thr].thr =3D kthread_run(decompress_threadfn,=0D
+		                            &data[thr],=0D
+		                            "image_decompress/%u", thr);=0D
+		if (IS_ERR(data[thr].thr)) {=0D
+			data[thr].thr =3D NULL;=0D
+			pr_err("Cannot start decompression threads\n");=0D
+			ret =3D -ENOMEM;=0D
+			goto out_clean;=0D
+		}=0D
+	}=0D
+=0D
+	/*=0D
+	 * Start the CRC32 thread.=0D
+	 */=0D
+	init_waitqueue_head(&crc->go);=0D
+	init_waitqueue_head(&crc->done);=0D
+=0D
+	handle->crc32 =3D 0;=0D
+	crc->crc32 =3D &handle->crc32;=0D
+	for (thr =3D 0; thr < nr_threads; thr++) {=0D
+		crc->unc[thr] =3D data[thr].unc;=0D
+		crc->unc_len[thr] =3D &data[thr].unc_len;=0D
+	}=0D
+=0D
+	crc->thr =3D kthread_run(crc32_threadfn, crc, "image_crc32");=0D
+	if (IS_ERR(crc->thr)) {=0D
+		crc->thr =3D NULL;=0D
+		pr_err("Cannot start CRC32 thread\n");=0D
+		ret =3D -ENOMEM;=0D
+		goto out_clean;=0D
+	}=0D
+=0D
+	/*=0D
+	 * Set the number of pages for read buffering.=0D
+	 * This is complete guesswork, because we'll only know the real=0D
+	 * picture once prepare_image() is called, which is much later on=0D
+	 * during the image load phase. We'll assume the worst case and=0D
+	 * say that none of the image pages are from high memory.=0D
+	 */=0D
+	if (low_free_pages() > snapshot_get_image_size())=0D
+		read_pages =3D (low_free_pages() - snapshot_get_image_size()) / 2;=0D
+	read_pages =3D clamp_val(read_pages, CMP_MIN_RD_PAGES, CMP_MAX_RD_PAGES);=
=0D
+=0D
+	for (i =3D 0; i < read_pages; i++) {=0D
+		page[i] =3D (void *)__get_free_page(i < CMP_PAGES ?=0D
+						  GFP_NOIO | __GFP_HIGH :=0D
+						  GFP_NOIO | __GFP_NOWARN |=0D
+						  __GFP_NORETRY);=0D
+=0D
+		if (!page[i]) {=0D
+			if (i < CMP_PAGES) {=0D
+				ring_size =3D i;=0D
+				pr_err("Failed to allocate %s pages\n", hib_comp_algo);=0D
+				ret =3D -ENOMEM;=0D
+				goto out_clean;=0D
+			} else {=0D
+				break;=0D
+			}=0D
+		}=0D
+	}=0D
+	want =3D ring_size =3D i;=0D
+=0D
+	pr_info("Using %u thread(s) for %s decompression\n", nr_threads, hib_comp=
_algo);=0D
+	pr_info("Loading and decompressing image data (%u pages)...\n",=0D
+		nr_to_read);=0D
+	m =3D nr_to_read / 10;=0D
+	if (!m)=0D
+		m =3D 1;=0D
+	nr_pages =3D 0;=0D
+	start =3D ktime_get();=0D
+=0D
+	ret =3D snapshot_write_next(snapshot);=0D
+	if (ret <=3D 0)=0D
+		goto out_finish;=0D
+=0D
+	for(;;) {=0D
+		for (i =3D 0; !eof && i < want; i++) {=0D
+			ret =3D swap_read_page(handle, page[ring], &hb);=0D
+			if (ret) {=0D
+				/*=0D
+				 * On real read error, finish. On end of data,=0D
+				 * set EOF flag and just exit the read loop.=0D
+				 */=0D
+				if (handle->cur &&=0D
+				    handle->cur->entries[handle->k]) {=0D
+					goto out_finish;=0D
+				} else {=0D
+					eof =3D 1;=0D
+					break;=0D
+				}=0D
+			}=0D
+			if (++ring >=3D ring_size)=0D
+				ring =3D 0;=0D
+		}=0D
+		asked +=3D i;=0D
+		want -=3D i;=0D
+=0D
+		/*=0D
+		 * We are out of data, wait for some more.=0D
+		 */=0D
+		if (!have) {=0D
+			if (!asked)=0D
+				break;=0D
+=0D
+			ret =3D hib_wait_io(&hb);=0D
+			if (ret)=0D
+				goto out_finish;=0D
+			have +=3D asked;=0D
+			asked =3D 0;=0D
+			if (eof)=0D
+				eof =3D 2;=0D
+		}=0D
+=0D
+		if (crc->run_threads) {=0D
+			wait_event(crc->done, atomic_read_acquire(&crc->stop));=0D
+			atomic_set(&crc->stop, 0);=0D
+			crc->run_threads =3D 0;=0D
+		}=0D
+=0D
+		for (thr =3D 0; have && thr < nr_threads; thr++) {=0D
+			data[thr].cmp_len =3D *(size_t *)page[pg];=0D
+			if (unlikely(!data[thr].cmp_len ||=0D
+			             data[thr].cmp_len >=0D
+					bytes_worst_compress(UNC_SIZE))) {=0D
+				pr_err("Invalid %s compressed length\n", hib_comp_algo);=0D
+				ret =3D -1;=0D
+				goto out_finish;=0D
+			}=0D
+=0D
+			need =3D DIV_ROUND_UP(data[thr].cmp_len + CMP_HEADER,=0D
+			                    PAGE_SIZE);=0D
+			if (need > have) {=0D
+				if (eof > 1) {=0D
+					ret =3D -1;=0D
+					goto out_finish;=0D
+				}=0D
+				break;=0D
+			}=0D
+=0D
+			for (off =3D 0;=0D
+			     off < CMP_HEADER + data[thr].cmp_len;=0D
+			     off +=3D PAGE_SIZE) {=0D
+				memcpy(data[thr].cmp + off,=0D
+				       page[pg], PAGE_SIZE);=0D
+				have--;=0D
+				want++;=0D
+				if (++pg >=3D ring_size)=0D
+					pg =3D 0;=0D
+			}=0D
+=0D
+			atomic_set_release(&data[thr].ready, 1);=0D
+			wake_up(&data[thr].go);=0D
+		}=0D
+=0D
+		/*=0D
+		 * Wait for more data while we are decompressing.=0D
+		 */=0D
+		if (have < CMP_PAGES && asked) {=0D
+			ret =3D hib_wait_io(&hb);=0D
+			if (ret)=0D
+				goto out_finish;=0D
+			have +=3D asked;=0D
+			asked =3D 0;=0D
+			if (eof)=0D
+				eof =3D 2;=0D
+		}=0D
+=0D
+		for (run_threads =3D thr, thr =3D 0; thr < run_threads; thr++) {=0D
+			wait_event(data[thr].done,=0D
+				atomic_read_acquire(&data[thr].stop));=0D
+			atomic_set(&data[thr].stop, 0);=0D
+=0D
+			ret =3D data[thr].ret;=0D
+=0D
+			if (ret < 0) {=0D
+				pr_err("%s decompression failed\n", hib_comp_algo);=0D
+				goto out_finish;=0D
+			}=0D
+=0D
+			if (unlikely(!data[thr].unc_len ||=0D
+				data[thr].unc_len > UNC_SIZE ||=0D
+				data[thr].unc_len & (PAGE_SIZE - 1))) {=0D
+				pr_err("Invalid %s uncompressed length\n", hib_comp_algo);=0D
+				ret =3D -1;=0D
+				goto out_finish;=0D
+			}=0D
+=0D
+			for (off =3D 0;=0D
+			     off < data[thr].unc_len; off +=3D PAGE_SIZE) {=0D
+				memcpy(data_of(*snapshot),=0D
+				       data[thr].unc + off, PAGE_SIZE);=0D
+=0D
+				if (!(nr_pages % m))=0D
+					pr_info("Image loading progress: %3d%%\n",=0D
+						nr_pages / m * 10);=0D
+				nr_pages++;=0D
+=0D
+				ret =3D snapshot_write_next(snapshot);=0D
+				if (ret <=3D 0) {=0D
+					crc->run_threads =3D thr + 1;=0D
+					atomic_set_release(&crc->ready, 1);=0D
+					wake_up(&crc->go);=0D
+					goto out_finish;=0D
+				}=0D
+			}=0D
+		}=0D
+=0D
+		crc->run_threads =3D thr;=0D
+		atomic_set_release(&crc->ready, 1);=0D
+		wake_up(&crc->go);=0D
+	}=0D
+=0D
+out_finish:=0D
+	if (crc->run_threads) {=0D
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));=0D
+		atomic_set(&crc->stop, 0);=0D
+	}=0D
+	stop =3D ktime_get();=0D
+	if (!ret) {=0D
+		pr_info("Image loading done\n");=0D
+		ret =3D snapshot_write_finalize(snapshot);=0D
+		if (!ret && !snapshot_image_loaded(snapshot))=0D
+			ret =3D -ENODATA;=0D
+		if (!ret) {=0D
+			if (swsusp_header->flags & SF_CRC32_MODE) {=0D
+				if(handle->crc32 !=3D swsusp_header->crc32) {=0D
+					pr_err("Invalid image CRC32!\n");=0D
+					ret =3D -ENODATA;=0D
+				}=0D
+			}=0D
+		}=0D
+	}=0D
+	swsusp_show_speed(start, stop, nr_to_read, "Read");=0D
+out_clean:=0D
+	hib_finish_batch(&hb);=0D
+	for (i =3D 0; i < ring_size; i++)=0D
+		free_page((unsigned long)page[i]);=0D
+	if (crc) {=0D
+		if (crc->thr)=0D
+			kthread_stop(crc->thr);=0D
+		kfree(crc);=0D
+	}=0D
+	if (data) {=0D
+		for (thr =3D 0; thr < nr_threads; thr++) {=0D
+			if (data[thr].thr)=0D
+				kthread_stop(data[thr].thr);=0D
+			if (data[thr].cc)=0D
+				crypto_free_comp(data[thr].cc);=0D
+		}=0D
+		vfree(data);=0D
+	}=0D
+	vfree(page);=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
+/**=0D
+ *	swsusp_read - read the hibernation image.=0D
+ *	@flags_p: flags passed by the "frozen" kernel in the image header shoul=
d=0D
+ *		  be written into this memory location=0D
+ */=0D
+=0D
+int swsusp_read(unsigned int *flags_p)=0D
+{=0D
+	int error;=0D
+	struct swap_map_handle handle;=0D
+	struct snapshot_handle snapshot;=0D
+	struct swsusp_info *header;=0D
+=0D
+	memset(&snapshot, 0, sizeof(struct snapshot_handle));=0D
+	error =3D snapshot_write_next(&snapshot);=0D
+	if (error < (int)PAGE_SIZE)=0D
+		return error < 0 ? error : -EFAULT;=0D
+	header =3D (struct swsusp_info *)data_of(snapshot);=0D
+	error =3D get_swap_reader(&handle, flags_p);=0D
+	if (error)=0D
+		goto end;=0D
+	if (!error)=0D
+		error =3D swap_read_page(&handle, header, NULL);=0D
+	if (!error) {=0D
+		error =3D (*flags_p & SF_NOCOMPRESS_MODE) ?=0D
+			load_image(&handle, &snapshot, header->pages - 1) :=0D
+			load_compressed_image(&handle, &snapshot, header->pages - 1);=0D
+	}=0D
+	swap_reader_finish(&handle);=0D
+end:=0D
+	if (!error)=0D
+		pr_debug("Image successfully loaded\n");=0D
+	else=0D
+		pr_debug("Error %d resuming\n", error);=0D
+	return error;=0D
+}=0D
+=0D
+static void *swsusp_holder;=0D
+=0D
+/**=0D
+ * swsusp_check - Open the resume device and check for the swsusp signatur=
e.=0D
+ * @exclusive: Open the resume device exclusively.=0D
+ */=0D
+=0D
+int swsusp_check(bool exclusive)=0D
+{=0D
+	void *holder =3D exclusive ? &swsusp_holder : NULL;=0D
+	int error;=0D
+=0D
+	hib_resume_bdev_file =3D bdev_file_open_by_dev(swsusp_resume_device,=0D
+				BLK_OPEN_READ, holder, NULL);=0D
+	if (!IS_ERR(hib_resume_bdev_file)) {=0D
+		set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);=0D
+		clear_page(swsusp_header);=0D
+		error =3D hib_submit_io(REQ_OP_READ, swsusp_resume_block,=0D
+					swsusp_header, NULL);=0D
+		if (error)=0D
+			goto put;=0D
+=0D
+		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {=0D
+			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);=0D
+			swsusp_header_flags =3D swsusp_header->flags;=0D
+			/* Reset swap signature now */=0D
+			error =3D hib_submit_io(REQ_OP_WRITE | REQ_SYNC,=0D
+						swsusp_resume_block,=0D
+						swsusp_header, NULL);=0D
+		} else {=0D
+			error =3D -EINVAL;=0D
+		}=0D
+		if (!error && swsusp_header->flags & SF_HW_SIG &&=0D
+		    swsusp_header->hw_sig !=3D swsusp_hardware_signature) {=0D
+			pr_info("Suspend image hardware signature mismatch (%08x now %08x); abo=
rting resume.\n",=0D
+				swsusp_header->hw_sig, swsusp_hardware_signature);=0D
+			error =3D -EINVAL;=0D
+		}=0D
+=0D
+put:=0D
+		if (error)=0D
+			fput(hib_resume_bdev_file);=0D
+		else=0D
+			pr_debug("Image signature found, resuming\n");=0D
+	} else {=0D
+		error =3D PTR_ERR(hib_resume_bdev_file);=0D
+	}=0D
+=0D
+	if (error)=0D
+		pr_debug("Image not found (code %d)\n", error);=0D
+=0D
+	return error;=0D
+}=0D
+=0D
+/**=0D
+ * swsusp_close - close resume device.=0D
+ */=0D
+=0D
+void swsusp_close(void)=0D
+{=0D
+	if (IS_ERR(hib_resume_bdev_file)) {=0D
+		pr_debug("Image device not initialised\n");=0D
+		return;=0D
+	}=0D
+=0D
+	fput(hib_resume_bdev_file);=0D
+}=0D
+=0D
+/**=0D
+ *      swsusp_unmark - Unmark swsusp signature in the resume device=0D
+ */=0D
+=0D
+#ifdef CONFIG_SUSPEND=0D
+int swsusp_unmark(void)=0D
+{=0D
+	int error;=0D
+=0D
+	hib_submit_io(REQ_OP_READ, swsusp_resume_block,=0D
+			swsusp_header, NULL);=0D
+	if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {=0D
+		memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);=0D
+		error =3D hib_submit_io(REQ_OP_WRITE | REQ_SYNC,=0D
+					swsusp_resume_block,=0D
+					swsusp_header, NULL);=0D
+	} else {=0D
+		pr_err("Cannot find swsusp signature!\n");=0D
+		error =3D -ENODEV;=0D
+	}=0D
+=0D
+	/*=0D
+	 * We just returned from suspend, we don't need the image any more.=0D
+	 */=0D
+	free_all_swap_pages(root_swap);=0D
+=0D
+	return error;=0D
+}=0D
+#endif=0D
+=0D
+static int __init swsusp_header_init(void)=0D
+{=0D
+	swsusp_header =3D (struct swsusp_header*) __get_free_page(GFP_KERNEL);=0D
+	if (!swsusp_header)=0D
+		panic("Could not allocate memory for swsusp_header\n");=0D
+	return 0;=0D
+}=0D
+=0D
+core_initcall(swsusp_header_init);=0D
--=20
2.25.1


