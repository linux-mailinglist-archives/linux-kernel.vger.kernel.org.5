Return-Path: <linux-kernel+bounces-136097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF55989CFF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A151F23772
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779404E1CA;
	Tue,  9 Apr 2024 01:44:41 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E948B4E1A8;
	Tue,  9 Apr 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627081; cv=none; b=rsrtAMtdOsPVs9PH6BgTiIHCsdG0mZSGL9rj7SFEYrv5/7sP++ThY3pXDpINQ7OCTxcViJAIAwCWxSxdMGCmiW93KVZLFiBTB+MveMIWXQR3TKyQqF+uSB4Wm6WzrpmOTNXIgFHtSQaq7hZrhbhWBswTJi/vNx5MTgChHi/E9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627081; c=relaxed/simple;
	bh=X0Ro0EQvQfBNdQaiQRarPTjPl5tuRnyzzAyvFmZYeC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B0t4LnOdNvQe2dOVxPRnAI5FzBD+6U0vgIIUCuVdU3WNytAdmWyKUW+1ncJ0DKM6v+TleCP204Gn4XhPq5XyLCZZWngx44KUkpAZR/TM3btv+po3hKaet16Y515A2vC5Q8ftTGuWmvLvmum7J5F+ag4X+K5A/+48JXpE72/g9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.4])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 57B4A60234E9B;
	Tue,  9 Apr 2024 09:44:27 +0800 (CST)
X-MD-Sfrom: zhangyang@nfschina.com
X-MD-SrcIP: 103.163.180.4
From: zhangyang <zhangyang@nfschina.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangyang <zhangyang@nfschina.com>
Subject: [PATCH] fix aarch64 after hibernate when resume smp_call_function_many was called at in_irq (option hibernate=nocompress)
Date: Tue,  9 Apr 2024 09:44:14 +0800
Message-Id: <20240409014414.162-1-zhangyang@nfschina.com>
X-Mailer: git-send-email 2.39.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[   12.603468] WARNING: CPU: 6 PID: 0 at kernel/smp.c:424 smp_call_function_many+0x2fc/0x390
[   12.612730] Modules linked in: raid10(E) raid456(E) libcrc32c(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) xor(E) xor_neon(E) async_tx(E) raid6_pq(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) hid_generic(E) usbhid(E) hid(E) uhci_hcd(E) ehci_hcd(E) arise_pro(OE) drm_kms_helper(E) evdev(E) efivars(E) clk_scpi(E) sd_mod(E) usbcore(E) drm(E) arm_scpi(E)
[   12.650675] CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        W  OE     5.4.0-100-generic #100.1+m38+21nfs5
[   12.661512] Hardware name: LENOVO INVALID/FD2000ZX200MB1, BIOS W0AKT19B 08/16/2022
[   12.670085] pstate: 20000085 (nzCv daIf -PAN -UAO)
[   12.675506] pc : smp_call_function_many+0x2fc/0x390
[   12.681026] lr : kick_all_cpus_sync+0x34/0x3c
[   12.685954] sp : ffff800010033c40
[   12.689700] x29: ffff800010033c40 x28: ffff80001152a1b8
[   12.695712] x27: 0000000000000006 x26: 0000000000000001
[   12.701723] x25: ffff0000780b8000 x24: 0000000000000000
[   12.707735] x23: 0000000000000000 x22: ffff8000101b6ad0
[   12.713746] x21: 0000000000000006 x20: ffff80001152a1b8
[   12.719758] x19: ffff0026d3e08100 x18: 0000000000000000
[   12.725769] x17: 000000004143b1b7 x16: 0000000000000008
[   12.731781] x15: 0000000000004446 x14: 000000000000ba7e
[   12.737792] x13: 000042cf7b84cf9c x12: 000042cf7b84cf9c
[   12.743804] x11: 00000000000042cf x10: 0000000000000040
[   12.749815] x9 : ffff80001154e748 x8 : ffff80001154e740
[   12.755826] x7 : ffff0026d8400af8 x6 : ffff0026d3e08180
[   12.761837] x5 : 0000000000001000 x4 : ffff0026d0b2f000
[   12.767849] x3 : 0000000000000001 x2 : ffff800011159018
[   12.773860] x1 : 0000000000000080 x0 : 0000000000000000
[   12.779871] Call trace:
[   12.782634]  smp_call_function_many+0x2fc/0x390
[   12.787759]  kick_all_cpus_sync+0x34/0x3c
[   12.792295]  hib_end_io+0x104/0x180
[   12.796240]  bio_endio+0x148/0x1f0
[   12.800086]  blk_update_request+0xd8/0x3b0
[   12.804718]  blk_mq_end_request+0x34/0x150
[   12.809352]  nvme_complete_rq+0x74/0x230
[   12.813788]  nvme_pci_complete_rq+0x5c/0xd0
[   12.818520]  blk_mq_complete_request+0x10c/0x14c
[   12.823743]  nvme_complete_cqes+0xbc/0x1bc
[   12.828375]  nvme_irq+0x13c/0x15c
[   12.832123]  __handle_irq_event_percpu+0x68/0x240
[   12.837445]  handle_irq_event+0x68/0x1ac
[   12.841881]  handle_fasteoi_irq+0xc8/0x23c
[   12.846514]  __handle_domain_irq+0x80/0xe0
[   12.851147]  gic_handle_irq+0xd8/0x180
[   12.855385]  el1_irq+0xb8/0x140
[   12.858934]  arch_cpu_idle+0x40/0x1d0
[   12.863075]  do_idle+0x230/0x2dc
[   12.866722]  cpu_startup_entry+0x30/0xc0
[   12.871159]  secondary_start_kernel+0x138/0x184
[   12.876283] ---[ end trace 9cf7b6db3165264d ]---
---
 kernel/power/swap.c | 59 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 5bc04bfe2..5ee3908af 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -41,7 +41,6 @@ u32 swsusp_hardware_signature;
  * in which case some architectures need these pages cleaning before they
  * can be executed. We don't know which pages these may be, so clean the lot.
  */
-static bool clean_pages_on_read;
 static bool clean_pages_on_decompress;
 
 /*
@@ -256,9 +255,6 @@ static void hib_end_io(struct bio *bio)
 
 	if (bio_data_dir(bio) == WRITE)
 		put_page(page);
-	else if (clean_pages_on_read)
-		flush_icache_range((unsigned long)page_address(page),
-				   (unsigned long)page_address(page) + PAGE_SIZE);
 
 	if (bio->bi_status && !hb->error)
 		hb->error = bio->bi_status;
@@ -1084,6 +1080,50 @@ static int swap_reader_finish(struct swap_map_handle *handle)
 	return 0;
 }
 
+struct swsusp_readpages {
+	unsigned long size;
+	unsigned long cursor;
+	struct page **pages;
+};
+
+static int swsusp_init_readpages(struct swsusp_readpages *read_pages, unsigned int nr_to_read)
+{
+	read_pages->pages = (struct page **)vzalloc(sizeof(struct page *) * nr_to_read);
+	if (!read_pages->pages) {
+		return -ENOMEM;
+	}
+
+	read_pages->size = nr_to_read;
+	read_pages->cursor = 0;
+	
+	return 0;
+}
+
+
+static int swsusp_add_readpage(struct swsusp_readpages *read_pages, void *page_addr)
+{
+	if (read_pages->cursor >= read_pages->size) {
+		return -ENOMEM;
+	}
+
+	read_pages->pages[read_pages->cursor++] = virt_to_page(page_addr);
+	return 0;
+}
+
+static void swsusp_clean_readedpages(struct swsusp_readpages *read_pages, bool flush)
+{
+	unsigned long idx;
+
+	for (idx = 0; idx < read_pages->cursor; idx++) {
+		if (flush && read_pages->pages[idx])
+			flush_icache_range((unsigned long)page_address(read_pages->pages[idx]),
+								(unsigned long)page_address(read_pages->pages[idx] + PAGE_SIZE));
+	}
+
+	vfree(read_pages->pages);
+	return;
+}
+
 /**
  *	load_image - load the image using the swap map handle
  *	@handle and the snapshot handle @snapshot
@@ -1101,10 +1141,14 @@ static int load_image(struct swap_map_handle *handle,
 	struct hib_bio_batch hb;
 	int err2;
 	unsigned nr_pages;
+	struct swsusp_readpages pages_to_clean;
 
 	hib_init_batch(&hb);
+	ret = swsusp_init_readpages(&pages_to_clean, nr_to_read);
+	if (!ret) {
+		return ret;
+	}
 
-	clean_pages_on_read = true;
 	pr_info("Loading image data pages (%u pages)...\n", nr_to_read);
 	m = nr_to_read / 10;
 	if (!m)
@@ -1122,6 +1166,10 @@ static int load_image(struct swap_map_handle *handle,
 			ret = hib_wait_io(&hb);
 		if (ret)
 			break;
+		ret = swsusp_add_readpage(&pages_to_clean, data_of(*snapshot));
+		if (ret)
+			break;
+
 		if (!(nr_pages % m))
 			pr_info("Image loading progress: %3d%%\n",
 				nr_pages / m * 10);
@@ -1132,6 +1180,7 @@ static int load_image(struct swap_map_handle *handle,
 	stop = ktime_get();
 	if (!ret)
 		ret = err2;
+	swsusp_clean_readedpages(&pages_to_clean, !ret);
 	if (!ret) {
 		pr_info("Image loading done\n");
 		ret = snapshot_write_finalize(snapshot);
-- 
2.39.0.windows.1


