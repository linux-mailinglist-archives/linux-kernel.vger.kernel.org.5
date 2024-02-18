Return-Path: <linux-kernel+bounces-70292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA068595B6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11831F2232D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1074C10A34;
	Sun, 18 Feb 2024 08:41:15 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF43149E15;
	Sun, 18 Feb 2024 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708245674; cv=none; b=c+wKjM2L8/KfmpGhsN517074frJzveKKOnM+UJUYBjSxC3hoDMf+uYIL0v7xuaJ+cdQthjLJIg1gbB+vjNvgOz8Nc5rrymm9FQzVdLod2jP13mZVzicNuuJuS1LiMHOBYvqVde9byphtIublrV/E1AcYJ3nLtuWFQUl60K4tfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708245674; c=relaxed/simple;
	bh=sMaAPhkoOe/wmvExKDqyxO2hoivL+2zo6774VKxyGTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGAdKAoJRmVjs4+rccgZyo+8nWgejlXM00ymKc+bjprQSuRIYu60l45m+UXHDTB+8fqTgIkXcyWJGj35h8iHZHFTM1Bub/x3+kPfaUi6BJNv0ci9ZTDYHEEuXfIIli8FnuKbha1amA97MucE40JmAUy8T7ycNXarn6NHlbRwfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TczfF0yd4z9v8l;
	Sun, 18 Feb 2024 09:41:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6XKgRyMUJsmE; Sun, 18 Feb 2024 09:41:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TczfD722lz9v6V;
	Sun, 18 Feb 2024 09:41:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E88F28B76C;
	Sun, 18 Feb 2024 09:41:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id QB5cK6e3yLyc; Sun, 18 Feb 2024 09:41:08 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.5])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EFE68B763;
	Sun, 18 Feb 2024 09:41:08 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: [PATCH] PM: hibernate: Don't ignore return from set_memory_ro()
Date: Sun, 18 Feb 2024 09:40:58 +0100
Message-ID: <be49c794567f3bd00ae16e91b54fe8cfe6cb4999.1708245599.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708245658; l=5282; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=sMaAPhkoOe/wmvExKDqyxO2hoivL+2zo6774VKxyGTg=; b=dL54jghPy4GRYknveendqZEnByR39IMPEL7EcmQgTI845XRsjhQMcxlvWY2uTT8Sly/qmJ7Hl aHPgM8klwleCauLxcHkUrwg6i29FHPt1nhd0d6uhyw23wp5PWyFhrUj
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_memory_ro() and set_memory_rw() can fail, leaving memory
unprotected.

Take the returned value into account and abort in case of
failure.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/power/power.h    |  2 +-
 kernel/power/snapshot.c | 25 ++++++++++++++++---------
 kernel/power/swap.c     |  8 ++++----
 kernel/power/user.c     |  4 +++-
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 8499a39c62f4..84d235f491a5 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -148,7 +148,7 @@ extern unsigned int snapshot_additional_pages(struct zone *zone);
 extern unsigned long snapshot_get_image_size(void);
 extern int snapshot_read_next(struct snapshot_handle *handle);
 extern int snapshot_write_next(struct snapshot_handle *handle);
-extern void snapshot_write_finalize(struct snapshot_handle *handle);
+int snapshot_write_finalize(struct snapshot_handle *handle);
 extern int snapshot_image_loaded(struct snapshot_handle *handle);
 
 extern bool hibernate_acquire(void);
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 5c96ff067c64..405eddbda4fc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -58,22 +58,24 @@ static inline void hibernate_restore_protection_end(void)
 	hibernate_restore_protection_active = false;
 }
 
-static inline void hibernate_restore_protect_page(void *page_address)
+static inline int __must_check hibernate_restore_protect_page(void *page_address)
 {
 	if (hibernate_restore_protection_active)
-		set_memory_ro((unsigned long)page_address, 1);
+		return set_memory_ro((unsigned long)page_address, 1);
+	return 0;
 }
 
-static inline void hibernate_restore_unprotect_page(void *page_address)
+static inline int hibernate_restore_unprotect_page(void *page_address)
 {
 	if (hibernate_restore_protection_active)
-		set_memory_rw((unsigned long)page_address, 1);
+		return set_memory_rw((unsigned long)page_address, 1);
+	return 0;
 }
 #else
 static inline void hibernate_restore_protection_begin(void) {}
 static inline void hibernate_restore_protection_end(void) {}
-static inline void hibernate_restore_protect_page(void *page_address) {}
-static inline void hibernate_restore_unprotect_page(void *page_address) {}
+static inline int __must_check hibernate_restore_protect_page(void *page_address) {return 0; }
+static inline int hibernate_restore_unprotect_page(void *page_address) {return 0; }
 #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
 
 
@@ -2832,7 +2834,9 @@ int snapshot_write_next(struct snapshot_handle *handle)
 		}
 	} else {
 		copy_last_highmem_page();
-		hibernate_restore_protect_page(handle->buffer);
+		error = hibernate_restore_protect_page(handle->buffer);
+		if (error)
+			return error;
 		handle->buffer = get_buffer(&orig_bm, &ca);
 		if (IS_ERR(handle->buffer))
 			return PTR_ERR(handle->buffer);
@@ -2858,15 +2862,18 @@ int snapshot_write_next(struct snapshot_handle *handle)
  * stored in highmem.  Additionally, it recycles bitmap memory that's not
  * necessary any more.
  */
-void snapshot_write_finalize(struct snapshot_handle *handle)
+int snapshot_write_finalize(struct snapshot_handle *handle)
 {
+	int error;
+
 	copy_last_highmem_page();
-	hibernate_restore_protect_page(handle->buffer);
+	error = hibernate_restore_protect_page(handle->buffer);
 	/* Do that only if we have loaded the image entirely */
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages + nr_zero_pages) {
 		memory_bm_recycle(&orig_bm);
 		free_highmem_data();
 	}
+	return error;
 }
 
 int snapshot_image_loaded(struct snapshot_handle *handle)
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 6053ddddaf65..b2d708952aae 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1100,8 +1100,8 @@ static int load_image(struct swap_map_handle *handle,
 		ret = err2;
 	if (!ret) {
 		pr_info("Image loading done\n");
-		snapshot_write_finalize(snapshot);
-		if (!snapshot_image_loaded(snapshot))
+		ret = snapshot_write_finalize(snapshot);
+		if (!ret && !snapshot_image_loaded(snapshot))
 			ret = -ENODATA;
 	}
 	swsusp_show_speed(start, stop, nr_to_read, "Read");
@@ -1441,8 +1441,8 @@ static int load_image_lzo(struct swap_map_handle *handle,
 	stop = ktime_get();
 	if (!ret) {
 		pr_info("Image loading done\n");
-		snapshot_write_finalize(snapshot);
-		if (!snapshot_image_loaded(snapshot))
+		ret = snapshot_write_finalize(snapshot);
+		if (!ret && !snapshot_image_loaded(snapshot))
 			ret = -ENODATA;
 		if (!ret) {
 			if (swsusp_header->flags & SF_CRC32_MODE) {
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 3a4e70366f35..3aa41ba22129 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -317,7 +317,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_ATOMIC_RESTORE:
-		snapshot_write_finalize(&data->handle);
+		error = snapshot_write_finalize(&data->handle);
+		if (error)
+			break;
 		if (data->mode != O_WRONLY || !data->frozen ||
 		    !snapshot_image_loaded(&data->handle)) {
 			error = -EPERM;
-- 
2.43.0


