Return-Path: <linux-kernel+bounces-23364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6BC82ABA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363061C24D55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C044112E5A;
	Thu, 11 Jan 2024 10:13:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E311737;
	Thu, 11 Jan 2024 10:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A62EC433C7;
	Thu, 11 Jan 2024 10:13:03 +0000 (UTC)
Date: Thu, 11 Jan 2024 10:13:01 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com, john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZZ-_LWz_4KxOkRsA@arm.com>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
 <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <ZZ2AqZT4dD-s01q9@shredder>
 <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>
 <ZZ7atzgT6_kOvWnJ@arm.com>
 <ZZ-ky9UCoHwbyqfn@shredder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ-ky9UCoHwbyqfn@shredder>

On Thu, Jan 11, 2024 at 10:20:27AM +0200, Ido Schimmel wrote:
> On Wed, Jan 10, 2024 at 05:58:15PM +0000, Catalin Marinas wrote:
> > Transient false positives are possible, especially as the code doesn't
> > use a double-linked list (for the latter, kmemleak does checksumming and
> > detects the prev/next change, defers the reporting until the object
> > becomes stable). That said, if a new scan is forced (echo scan >
> > /sys/kernel/debug/kmemleak), are the same objects still listed as leaks?
> > If yes, they may not be transient.
> 
> We are doing "scan" and "clear" after each test. I will disable the
> "clear" and see if the leaks persist.

If it is indeed a false positive, you can try the patch below (I haven't
given it any run-time test, only compiled):

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index 2cb00b53339f..7d784e03f3f9 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -161,6 +161,7 @@ See the include/linux/kmemleak.h header for the functions prototype.
 - ``kmemleak_free_percpu``	 - notify of a percpu memory block freeing
 - ``kmemleak_update_trace``	 - update object allocation stack trace
 - ``kmemleak_not_leak``	 - mark an object as not a leak
+- ``kmemleak_transient_leak``	 - mark an object as a transient leak
 - ``kmemleak_ignore``		 - do not scan or report an object as leak
 - ``kmemleak_scan_area``	 - add scan areas inside a memory block
 - ``kmemleak_no_scan``	 - do not scan a memory block
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d30e453d0fb4..c1d0775080ff 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/iova.h>
+#include <linux/kmemleak.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -730,6 +731,11 @@ static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
 {
 	struct iova_magazine *mag = rcache->depot;
 
+	/*
+	 * As the mag->next pointer is moved to rcache->depot and reset via
+	 * the mag->size assignment, mark the transient false positive.
+	 */
+	kmemleak_transient_leak(mag->next);
 	rcache->depot = mag->next;
 	mag->size = IOVA_MAG_SIZE;
 	rcache->depot_size--;
diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 6a3cd1bf4680..93a73c076d16 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -26,6 +26,7 @@ extern void kmemleak_free_part(const void *ptr, size_t size) __ref;
 extern void kmemleak_free_percpu(const void __percpu *ptr) __ref;
 extern void kmemleak_update_trace(const void *ptr) __ref;
 extern void kmemleak_not_leak(const void *ptr) __ref;
+extern void kmemleak_transient_leak(const void *ptr) __ref;
 extern void kmemleak_ignore(const void *ptr) __ref;
 extern void kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp) __ref;
 extern void kmemleak_no_scan(const void *ptr) __ref;
@@ -93,6 +94,9 @@ static inline void kmemleak_update_trace(const void *ptr)
 static inline void kmemleak_not_leak(const void *ptr)
 {
 }
+static inline void kmemleak_transient_leak(const void *ptr)
+{
+}
 static inline void kmemleak_ignore(const void *ptr)
 {
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5501363d6b31..9fd338063cea 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -915,6 +915,28 @@ static void make_black_object(unsigned long ptr, bool is_phys)
 	paint_ptr(ptr, KMEMLEAK_BLACK, is_phys);
 }
 
+/*
+ * Reset the checksum of an object. The immediate effect is that it will not
+ * be reported as a leak during the next scan until its checksum is updated.
+ */
+static void reset_checksum(unsigned long ptr)
+{
+	unsigned long flags;
+	struct kmemleak_object *object;
+
+	object = find_and_get_object(ptr, 0);
+	if (!object) {
+		kmemleak_warn("Not resetting the checksum of an unknown object at 0x%08lx\n",
+			      ptr);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&object->lock, flags);
+	object->checksum = 0;
+	raw_spin_unlock_irqrestore(&object->lock, flags);
+	put_object(object);
+}
+
 /*
  * Add a scanning area to the object. If at least one such area is added,
  * kmemleak will only scan these ranges rather than the whole memory block.
@@ -1194,6 +1216,23 @@ void __ref kmemleak_not_leak(const void *ptr)
 }
 EXPORT_SYMBOL(kmemleak_not_leak);
 
+/**
+ * kmemleak_transient_leak - mark an allocated object as transient false positive
+ * @ptr:	pointer to beginning of the object
+ *
+ * Calling this function on an object will cause the memory block to not be
+ * reported as a leak temporarily. This may happen, for example, if the object
+ * is part of a singly linked list and the ->next reference it is changed.
+ */
+void __ref kmemleak_transient_leak(const void *ptr)
+{
+	pr_debug("%s(0x%px)\n", __func__, ptr);
+
+	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+		reset_checksum((unsigned long)ptr);
+}
+EXPORT_SYMBOL(kmemleak_transient_leak);
+
 /**
  * kmemleak_ignore - ignore an allocated object
  * @ptr:	pointer to beginning of the object

-- 
Catalin

