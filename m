Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA97BCA89
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344169AbjJGXmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJGXl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:41:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532B6BD
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 16:41:54 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59f55c276c3so41850487b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696722113; x=1697326913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOuUNdwvZlulrqKW4ZtzVfW59vH9ggRFsvCVeOVQqIU=;
        b=YNLLiIpOuG8csRi8Ya9vNoBAyrQxwikAeP/Pw69lSBd7sjOjbN+T0BeWROiItTngFF
         RJ0+1wR6dBsr2T/XCvkBOHUgwj4RXqx7yd4q2hT9APR91DuP2143EZww4oj9oVO5SICF
         QCvIQ+oF5OivuU+RvR4WIsM9gXcT0t9vbKU/rrP0aJB2SpvAZ1sgyhixPB29YZvax30+
         6G3b1CMM7HPZUhH6TckPBKtewZhKiTZ+G/sMOFqX6V2nFjVA5dQCL2olhn5CMqv2Hxmr
         kqqDKNItszQ3Hf9J2ZZZJaPJ/W/fJkq/oIbU5jtz9JQe5IvIW2DWNcJ3gEmdWDBD1mBN
         j15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696722113; x=1697326913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOuUNdwvZlulrqKW4ZtzVfW59vH9ggRFsvCVeOVQqIU=;
        b=rzJQaBuxMR80A6Bk81+qGzbfrWPCloV9lJU06I3LVxY+9uUkZ/rRI9uxoQdm691PZV
         ov05WmraMgJmOuF3CcMwFPhif6FcGmMQSGVI66LRYLP+5ac+FRXUfc/34ijIJcypu4iB
         EdSpluODEcon92FdjBeDWe3ZWBFjJR3YmZQ1mNSbqQbwC9HQ7RObS9VlG7w9cCpd9WJw
         kRpwj4wAzdwYrPcXKJwGG1yoLztUGWMaNfTxn2F2XhyoEEK7twAY3jjqIk9KW8QK3g4v
         t77YWYemuoMrNa9r39BlqTQ95Gvmw0DCuo4oK8TpU35rBWugmNp4/tcAAlbhaZWbOedG
         LeyA==
X-Gm-Message-State: AOJu0YxbYptHVA9tIh41jqSnLW1PFGxsqXpOFPOPHELRBDiAhcL6WE51
        NmjP017Q/YcchcQe/h1UTJtlQ8wXUZbV4Q==
X-Google-Smtp-Source: AGHT+IEw3Pr2GJDzNkXIsUD0i/b75Dhor0F7kerz+rGpbt+ZJIcd6fNBGzm6VjG8N4RZrNCVDxWF6g==
X-Received: by 2002:a81:91cf:0:b0:59b:bea7:29cb with SMTP id i198-20020a8191cf000000b0059bbea729cbmr12791741ywg.1.1696722112604;
        Sat, 07 Oct 2023 16:41:52 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b00274a9f8e82asm7476527pjx.51.2023.10.07.16.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 16:41:52 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Seo <james@equiv.tech>, Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Rae Moar <rmoar@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/2] lib/bitmap: split-out string-related operations to a separate files
Date:   Sat,  7 Oct 2023 16:35:10 -0700
Message-Id: <20231007233510.2097166-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007233510.2097166-1-yury.norov@gmail.com>
References: <20231007233510.2097166-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/bitmap.c and corresponding include/linux/bitmap.h are intended to
hold functions related to operations on bitmaps, like bitmap_shift or
bitmap_set. Historically, some string-related operations like
bitmap_parse are also reside in lib/bitmap.c.

Now that the subsystem evolves, string-related bitmap operations became a
significant part of the file. Because they are quite different from the
other bitmap functions by nature, it's worth to split them to a separate
source/header files.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS                |   2 +
 include/linux/bitmap-str.h |  16 ++
 include/linux/bitmap.h     |  17 +-
 lib/Makefile               |   2 +-
 lib/bitmap-str.c           | 510 ++++++++++++++++++++++++++++++++++++
 lib/bitmap.c               | 512 -------------------------------------
 6 files changed, 530 insertions(+), 529 deletions(-)
 create mode 100644 include/linux/bitmap-str.h
 create mode 100644 lib/bitmap-str.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 81d5fc0bba68..d507dd2582f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3506,12 +3506,14 @@ R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:	Maintained
 F:	include/linux/bitfield.h
+F:	include/linux/bitmap-str.h
 F:	include/linux/bitmap.h
 F:	include/linux/bits.h
 F:	include/linux/cpumask.h
 F:	include/linux/find.h
 F:	include/linux/nodemask.h
 F:	include/vdso/bits.h
+F:	lib/bitmap-str.c
 F:	lib/bitmap.c
 F:	lib/cpumask.c
 F:	lib/cpumask_kunit.c
diff --git a/include/linux/bitmap-str.h b/include/linux/bitmap-str.h
new file mode 100644
index 000000000000..17caeca94cab
--- /dev/null
+++ b/include/linux/bitmap-str.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_BITMAP_STR_H
+#define __LINUX_BITMAP_STR_H
+
+int bitmap_parse_user(const char __user *ubuf, unsigned int ulen, unsigned long *dst, int nbits);
+int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp, int nmaskbits);
+extern int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
+					int nmaskbits, loff_t off, size_t count);
+extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
+					int nmaskbits, loff_t off, size_t count);
+int bitmap_parse(const char *buf, unsigned int buflen, unsigned long *dst, int nbits);
+int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits);
+int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
+					unsigned long *dst, int nbits);
+
+#endif /* __LINUX_BITMAP_STR_H */
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index ce8fcd8736f1..67d47e35d285 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -10,6 +10,7 @@
 #include <linux/limits.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/bitmap-str.h>
 
 /*
  * bitmaps provide bit arrays that consume one or more unsigned
@@ -192,14 +193,6 @@ bitmap_find_next_zero_area(unsigned long *map,
 					      align_mask, 0);
 }
 
-int bitmap_parse(const char *buf, unsigned int buflen,
-			unsigned long *dst, int nbits);
-int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
-			unsigned long *dst, int nbits);
-int bitmap_parselist(const char *buf, unsigned long *maskp,
-			int nmaskbits);
-int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
-			unsigned long *dst, int nbits);
 void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new, unsigned int nbits);
 int bitmap_bitremap(int oldbit,
@@ -217,14 +210,6 @@ void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int n
 #else
 #define bitmap_copy_le bitmap_copy
 #endif
-int bitmap_print_to_pagebuf(bool list, char *buf,
-				   const unsigned long *maskp, int nmaskbits);
-
-extern int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
-				      int nmaskbits, loff_t off, size_t count);
-
-extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
-				      int nmaskbits, loff_t off, size_t count);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
diff --git a/lib/Makefile b/lib/Makefile
index 740109b6e2c8..9e8f9f6dd3b2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -48,7 +48,7 @@ obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
-	 generic-radix-tree.o
+	 generic-radix-tree.o bitmap-str.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
diff --git a/lib/bitmap-str.c b/lib/bitmap-str.c
new file mode 100644
index 000000000000..be745209507a
--- /dev/null
+++ b/lib/bitmap-str.c
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitmap.h>
+#include <linux/ctype.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/hex.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/string.h>
+
+#include "kstrtox.h"
+
+/**
+ * bitmap_parse_user - convert an ASCII hex string in a user buffer into a bitmap
+ *
+ * @ubuf: pointer to user buffer containing string.
+ * @ulen: buffer size in bytes.  If string is smaller than this
+ *    then it must be terminated with a \0.
+ * @maskp: pointer to bitmap array that will contain result.
+ * @nmaskbits: size of bitmap, in bits.
+ */
+int bitmap_parse_user(const char __user *ubuf,
+			unsigned int ulen, unsigned long *maskp,
+			int nmaskbits)
+{
+	char *buf;
+	int ret;
+
+	buf = memdup_user_nul(ubuf, ulen);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = bitmap_parse(buf, UINT_MAX, maskp, nmaskbits);
+
+	kfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL(bitmap_parse_user);
+
+/**
+ * bitmap_print_to_pagebuf - convert bitmap to list or hex format ASCII string
+ * @list: indicates whether the bitmap must be list
+ * @buf: page aligned buffer into which string is placed
+ * @maskp: pointer to bitmap to convert
+ * @nmaskbits: size of bitmap, in bits
+ *
+ * Output format is a comma-separated list of decimal numbers and
+ * ranges if list is specified or hex digits grouped into comma-separated
+ * sets of 8 digits/set. Returns the number of characters written to buf.
+ *
+ * It is assumed that @buf is a pointer into a PAGE_SIZE, page-aligned
+ * area and that sufficient storage remains at @buf to accommodate the
+ * bitmap_print_to_pagebuf() output. Returns the number of characters
+ * actually printed to @buf, excluding terminating '\0'.
+ */
+int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
+			    int nmaskbits)
+{
+	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
+
+	return list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
+		      scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
+}
+EXPORT_SYMBOL(bitmap_print_to_pagebuf);
+
+/**
+ * bitmap_print_to_buf  - convert bitmap to list or hex format ASCII string
+ * @list: indicates whether the bitmap must be list
+ *      true:  print in decimal list format
+ *      false: print in hexadecimal bitmask format
+ * @buf: buffer into which string is placed
+ * @maskp: pointer to bitmap to convert
+ * @nmaskbits: size of bitmap, in bits
+ * @off: in the string from which we are copying, We copy to @buf
+ * @count: the maximum number of bytes to print
+ */
+static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
+		int nmaskbits, loff_t off, size_t count)
+{
+	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
+	ssize_t size;
+	void *data;
+
+	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
+	if (!data)
+		return -ENOMEM;
+
+	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
+	kfree(data);
+
+	return size;
+}
+
+/**
+ * bitmap_print_bitmask_to_buf  - convert bitmap to hex bitmask format ASCII string
+ * @buf: buffer into which string is placed
+ * @maskp: pointer to bitmap to convert
+ * @nmaskbits: size of bitmap, in bits
+ * @off: in the string from which we are copying, We copy to @buf
+ * @count: the maximum number of bytes to print
+ *
+ * The bitmap_print_to_pagebuf() is used indirectly via its cpumap wrapper
+ * cpumap_print_to_pagebuf() or directly by drivers to export hexadecimal
+ * bitmask and decimal list to userspace by sysfs ABI.
+ * Drivers might be using a normal attribute for this kind of ABIs. A
+ * normal attribute typically has show entry as below::
+ *
+ *   static ssize_t example_attribute_show(struct device *dev,
+ *		struct device_attribute *attr, char *buf)
+ *   {
+ *	...
+ *	return bitmap_print_to_pagebuf(true, buf, &mask, nr_trig_max);
+ *   }
+ *
+ * show entry of attribute has no offset and count parameters and this
+ * means the file is limited to one page only.
+ * bitmap_print_to_pagebuf() API works terribly well for this kind of
+ * normal attribute with buf parameter and without offset, count::
+ *
+ *   bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
+ *			   int nmaskbits)
+ *   {
+ *   }
+ *
+ * The problem is once we have a large bitmap, we have a chance to get a
+ * bitmask or list more than one page. Especially for list, it could be
+ * as complex as 0,3,5,7,9,... We have no simple way to know it exact size.
+ * It turns out bin_attribute is a way to break this limit. bin_attribute
+ * has show entry as below::
+ *
+ *   static ssize_t
+ *   example_bin_attribute_show(struct file *filp, struct kobject *kobj,
+ *		struct bin_attribute *attr, char *buf,
+ *		loff_t offset, size_t count)
+ *   {
+ *	...
+ *   }
+ *
+ * With the new offset and count parameters, this makes sysfs ABI be able
+ * to support file size more than one page. For example, offset could be
+ * >= 4096.
+ * bitmap_print_bitmask_to_buf(), bitmap_print_list_to_buf() wit their
+ * cpumap wrapper cpumap_print_bitmask_to_buf(), cpumap_print_list_to_buf()
+ * make those drivers be able to support large bitmask and list after they
+ * move to use bin_attribute. In result, we have to pass the corresponding
+ * parameters such as off, count from bin_attribute show entry to this API.
+ *
+ * The role of cpumap_print_bitmask_to_buf() and cpumap_print_list_to_buf()
+ * is similar with cpumap_print_to_pagebuf(),  the difference is that
+ * bitmap_print_to_pagebuf() mainly serves sysfs attribute with the assumption
+ * the destination buffer is exactly one page and won't be more than one page.
+ * cpumap_print_bitmask_to_buf() and cpumap_print_list_to_buf(), on the other
+ * hand, mainly serves bin_attribute which doesn't work with exact one page,
+ * and it can break the size limit of converted decimal list and hexadecimal
+ * bitmask.
+ *
+ * WARNING!
+ *
+ * This function is not a replacement for sprintf() or bitmap_print_to_pagebuf().
+ * It is intended to workaround sysfs limitations discussed above and should be
+ * used carefully in general case for the following reasons:
+ *
+ *  - Time complexity is O(nbits^2/count), comparing to O(nbits) for snprintf().
+ *  - Memory complexity is O(nbits), comparing to O(1) for snprintf().
+ *  - @off and @count are NOT offset and number of bits to print.
+ *  - If printing part of bitmap as list, the resulting string is not a correct
+ *    list representation of bitmap. Particularly, some bits within or out of
+ *    related interval may be erroneously set or unset. The format of the string
+ *    may be broken, so bitmap_parselist-like parser may fail parsing it.
+ *  - If printing the whole bitmap as list by parts, user must ensure the order
+ *    of calls of the function such that the offset is incremented linearly.
+ *  - If printing the whole bitmap as list by parts, user must keep bitmap
+ *    unchanged between the very first and very last call. Otherwise concatenated
+ *    result may be incorrect, and format may be broken.
+ *
+ * Returns the number of characters actually printed to @buf
+ */
+int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
+				int nmaskbits, loff_t off, size_t count)
+{
+	return bitmap_print_to_buf(false, buf, maskp, nmaskbits, off, count);
+}
+EXPORT_SYMBOL(bitmap_print_bitmask_to_buf);
+
+/**
+ * bitmap_print_list_to_buf  - convert bitmap to decimal list format ASCII string
+ * @buf: buffer into which string is placed
+ * @maskp: pointer to bitmap to convert
+ * @nmaskbits: size of bitmap, in bits
+ * @off: in the string from which we are copying, We copy to @buf
+ * @count: the maximum number of bytes to print
+ *
+ * Everything is same with the above bitmap_print_bitmask_to_buf() except
+ * the print format.
+ */
+int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
+			     int nmaskbits, loff_t off, size_t count)
+{
+	return bitmap_print_to_buf(true, buf, maskp, nmaskbits, off, count);
+}
+EXPORT_SYMBOL(bitmap_print_list_to_buf);
+
+/*
+ * Region 9-38:4/10 describes the following bitmap structure:
+ * 0	   9  12    18			38	     N
+ * .........****......****......****..................
+ *	    ^  ^     ^			 ^	     ^
+ *      start  off   group_len	       end	 nbits
+ */
+struct region {
+	unsigned int start;
+	unsigned int off;
+	unsigned int group_len;
+	unsigned int end;
+	unsigned int nbits;
+};
+
+static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
+{
+	unsigned int start;
+
+	for (start = r->start; start <= r->end; start += r->group_len)
+		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
+}
+
+static int bitmap_check_region(const struct region *r)
+{
+	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
+		return -EINVAL;
+
+	if (r->end >= r->nbits)
+		return -ERANGE;
+
+	return 0;
+}
+
+static const char *bitmap_getnum(const char *str, unsigned int *num,
+				 unsigned int lastbit)
+{
+	unsigned long long n;
+	unsigned int len;
+
+	if (str[0] == 'N') {
+		*num = lastbit;
+		return str + 1;
+	}
+
+	len = _parse_integer(str, 10, &n);
+	if (!len)
+		return ERR_PTR(-EINVAL);
+	if (len & KSTRTOX_OVERFLOW || n != (unsigned int)n)
+		return ERR_PTR(-EOVERFLOW);
+
+	*num = n;
+	return str + len;
+}
+
+static inline bool end_of_str(char c)
+{
+	return c == '\0' || c == '\n';
+}
+
+static inline bool __end_of_region(char c)
+{
+	return isspace(c) || c == ',';
+}
+
+static inline bool end_of_region(char c)
+{
+	return __end_of_region(c) || end_of_str(c);
+}
+
+/*
+ * The format allows commas and whitespaces at the beginning
+ * of the region.
+ */
+static const char *bitmap_find_region(const char *str)
+{
+	while (__end_of_region(*str))
+		str++;
+
+	return end_of_str(*str) ? NULL : str;
+}
+
+static const char *bitmap_find_region_reverse(const char *start, const char *end)
+{
+	while (start <= end && __end_of_region(*end))
+		end--;
+
+	return end;
+}
+
+static const char *bitmap_parse_region(const char *str, struct region *r)
+{
+	unsigned int lastbit = r->nbits - 1;
+
+	if (!strncasecmp(str, "all", 3)) {
+		r->start = 0;
+		r->end = lastbit;
+		str += 3;
+
+		goto check_pattern;
+	}
+
+	str = bitmap_getnum(str, &r->start, lastbit);
+	if (IS_ERR(str))
+		return str;
+
+	if (end_of_region(*str))
+		goto no_end;
+
+	if (*str != '-')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(str + 1, &r->end, lastbit);
+	if (IS_ERR(str))
+		return str;
+
+check_pattern:
+	if (end_of_region(*str))
+		goto no_pattern;
+
+	if (*str != ':')
+		return ERR_PTR(-EINVAL);
+
+	str = bitmap_getnum(str + 1, &r->off, lastbit);
+	if (IS_ERR(str))
+		return str;
+
+	if (*str != '/')
+		return ERR_PTR(-EINVAL);
+
+	return bitmap_getnum(str + 1, &r->group_len, lastbit);
+
+no_end:
+	r->end = r->start;
+no_pattern:
+	r->off = r->end + 1;
+	r->group_len = r->end + 1;
+
+	return end_of_str(*str) ? NULL : str;
+}
+
+/**
+ * bitmap_parselist - convert list format ASCII string to bitmap
+ * @buf: read user string from this buffer; must be terminated
+ *    with a \0 or \n.
+ * @maskp: write resulting mask here
+ * @nmaskbits: number of bits in mask to be written
+ *
+ * Input format is a comma-separated list of decimal numbers and
+ * ranges.  Consecutively set bits are shown as two hyphen-separated
+ * decimal numbers, the smallest and largest bit numbers set in
+ * the range.
+ * Optionally each range can be postfixed to denote that only parts of it
+ * should be set. The range will divided to groups of specific size.
+ * From each group will be used only defined amount of bits.
+ * Syntax: range:used_size/group_size
+ * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
+ * The value 'N' can be used as a dynamically substituted token for the
+ * maximum allowed value; i.e (nmaskbits - 1).  Keep in mind that it is
+ * dynamic, so if system changes cause the bitmap width to change, such
+ * as more cores in a CPU list, then any ranges using N will also change.
+ *
+ * Returns: 0 on success, -errno on invalid input strings. Error values:
+ *
+ *   - ``-EINVAL``: wrong region format
+ *   - ``-EINVAL``: invalid character in string
+ *   - ``-ERANGE``: bit number specified too large for mask
+ *   - ``-EOVERFLOW``: integer overflow in the input parameters
+ */
+int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
+{
+	struct region r;
+	long ret;
+
+	r.nbits = nmaskbits;
+	bitmap_zero(maskp, r.nbits);
+
+	while (buf) {
+		buf = bitmap_find_region(buf);
+		if (buf == NULL)
+			return 0;
+
+		buf = bitmap_parse_region(buf, &r);
+		if (IS_ERR(buf))
+			return PTR_ERR(buf);
+
+		ret = bitmap_check_region(&r);
+		if (ret)
+			return ret;
+
+		bitmap_set_region(&r, maskp);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(bitmap_parselist);
+
+
+/**
+ * bitmap_parselist_user() - convert user buffer's list format ASCII
+ * string to bitmap
+ *
+ * @ubuf: pointer to user buffer containing string.
+ * @ulen: buffer size in bytes.  If string is smaller than this
+ *    then it must be terminated with a \0.
+ * @maskp: pointer to bitmap array that will contain result.
+ * @nmaskbits: size of bitmap, in bits.
+ *
+ * Wrapper for bitmap_parselist(), providing it with user buffer.
+ */
+int bitmap_parselist_user(const char __user *ubuf,
+			unsigned int ulen, unsigned long *maskp,
+			int nmaskbits)
+{
+	char *buf;
+	int ret;
+
+	buf = memdup_user_nul(ubuf, ulen);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = bitmap_parselist(buf, maskp, nmaskbits);
+
+	kfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL(bitmap_parselist_user);
+
+static const char *bitmap_get_x32_reverse(const char *start,
+					const char *end, u32 *num)
+{
+	u32 ret = 0;
+	int c, i;
+
+	for (i = 0; i < 32; i += 4) {
+		c = hex_to_bin(*end--);
+		if (c < 0)
+			return ERR_PTR(-EINVAL);
+
+		ret |= c << i;
+
+		if (start > end || __end_of_region(*end))
+			goto out;
+	}
+
+	if (hex_to_bin(*end--) >= 0)
+		return ERR_PTR(-EOVERFLOW);
+out:
+	*num = ret;
+	return end;
+}
+
+/**
+ * bitmap_parse - convert an ASCII hex string into a bitmap.
+ * @start: pointer to buffer containing string.
+ * @buflen: buffer size in bytes.  If string is smaller than this
+ *    then it must be terminated with a \0 or \n. In that case,
+ *    UINT_MAX may be provided instead of string length.
+ * @maskp: pointer to bitmap array that will contain result.
+ * @nmaskbits: size of bitmap, in bits.
+ *
+ * Commas group hex digits into chunks.  Each chunk defines exactly 32
+ * bits of the resultant bitmask.  No chunk may specify a value larger
+ * than 32 bits (%-EOVERFLOW), and if a chunk specifies a smaller value
+ * then leading 0-bits are prepended.  %-EINVAL is returned for illegal
+ * characters. Grouping such as "1,,5", ",44", "," or "" is allowed.
+ * Leading, embedded and trailing whitespace accepted.
+ */
+int bitmap_parse(const char *start, unsigned int buflen,
+		unsigned long *maskp, int nmaskbits)
+{
+	const char *end = strnchrnul(start, buflen, '\n') - 1;
+	int chunks = BITS_TO_U32(nmaskbits);
+	u32 *bitmap = (u32 *)maskp;
+	int unset_bit;
+	int chunk;
+
+	for (chunk = 0; ; chunk++) {
+		end = bitmap_find_region_reverse(start, end);
+		if (start > end)
+			break;
+
+		if (!chunks--)
+			return -EOVERFLOW;
+
+#if defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)
+		end = bitmap_get_x32_reverse(start, end, &bitmap[chunk ^ 1]);
+#else
+		end = bitmap_get_x32_reverse(start, end, &bitmap[chunk]);
+#endif
+		if (IS_ERR(end))
+			return PTR_ERR(end);
+	}
+
+	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
+	if (unset_bit < nmaskbits) {
+		bitmap_clear(maskp, unset_bit, nmaskbits - unset_bit);
+		return 0;
+	}
+
+	if (find_next_bit(maskp, unset_bit, nmaskbits) != unset_bit)
+		return -EOVERFLOW;
+
+	return 0;
+}
+EXPORT_SYMBOL(bitmap_parse);
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 41f32fa3a80f..283bc7232cbd 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -6,20 +6,10 @@
 
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
-#include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/thread_info.h>
-#include <linux/uaccess.h>
-
-#include <asm/page.h>
-
-#include "kstrtox.h"
 
 /**
  * DOC: bitmap introduction
@@ -439,508 +429,6 @@ unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
 }
 EXPORT_SYMBOL(bitmap_find_next_zero_area_off);
 
-/*
- * Bitmap printing & parsing functions: first version by Nadia Yvette Chambers,
- * second version by Paul Jackson, third by Joe Korty.
- */
-
-/**
- * bitmap_parse_user - convert an ASCII hex string in a user buffer into a bitmap
- *
- * @ubuf: pointer to user buffer containing string.
- * @ulen: buffer size in bytes.  If string is smaller than this
- *    then it must be terminated with a \0.
- * @maskp: pointer to bitmap array that will contain result.
- * @nmaskbits: size of bitmap, in bits.
- */
-int bitmap_parse_user(const char __user *ubuf,
-			unsigned int ulen, unsigned long *maskp,
-			int nmaskbits)
-{
-	char *buf;
-	int ret;
-
-	buf = memdup_user_nul(ubuf, ulen);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
-	ret = bitmap_parse(buf, UINT_MAX, maskp, nmaskbits);
-
-	kfree(buf);
-	return ret;
-}
-EXPORT_SYMBOL(bitmap_parse_user);
-
-/**
- * bitmap_print_to_pagebuf - convert bitmap to list or hex format ASCII string
- * @list: indicates whether the bitmap must be list
- * @buf: page aligned buffer into which string is placed
- * @maskp: pointer to bitmap to convert
- * @nmaskbits: size of bitmap, in bits
- *
- * Output format is a comma-separated list of decimal numbers and
- * ranges if list is specified or hex digits grouped into comma-separated
- * sets of 8 digits/set. Returns the number of characters written to buf.
- *
- * It is assumed that @buf is a pointer into a PAGE_SIZE, page-aligned
- * area and that sufficient storage remains at @buf to accommodate the
- * bitmap_print_to_pagebuf() output. Returns the number of characters
- * actually printed to @buf, excluding terminating '\0'.
- */
-int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
-			    int nmaskbits)
-{
-	ptrdiff_t len = PAGE_SIZE - offset_in_page(buf);
-
-	return list ? scnprintf(buf, len, "%*pbl\n", nmaskbits, maskp) :
-		      scnprintf(buf, len, "%*pb\n", nmaskbits, maskp);
-}
-EXPORT_SYMBOL(bitmap_print_to_pagebuf);
-
-/**
- * bitmap_print_to_buf  - convert bitmap to list or hex format ASCII string
- * @list: indicates whether the bitmap must be list
- *      true:  print in decimal list format
- *      false: print in hexadecimal bitmask format
- * @buf: buffer into which string is placed
- * @maskp: pointer to bitmap to convert
- * @nmaskbits: size of bitmap, in bits
- * @off: in the string from which we are copying, We copy to @buf
- * @count: the maximum number of bytes to print
- */
-static int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
-		int nmaskbits, loff_t off, size_t count)
-{
-	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
-	ssize_t size;
-	void *data;
-
-	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
-	if (!data)
-		return -ENOMEM;
-
-	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
-	kfree(data);
-
-	return size;
-}
-
-/**
- * bitmap_print_bitmask_to_buf  - convert bitmap to hex bitmask format ASCII string
- * @buf: buffer into which string is placed
- * @maskp: pointer to bitmap to convert
- * @nmaskbits: size of bitmap, in bits
- * @off: in the string from which we are copying, We copy to @buf
- * @count: the maximum number of bytes to print
- *
- * The bitmap_print_to_pagebuf() is used indirectly via its cpumap wrapper
- * cpumap_print_to_pagebuf() or directly by drivers to export hexadecimal
- * bitmask and decimal list to userspace by sysfs ABI.
- * Drivers might be using a normal attribute for this kind of ABIs. A
- * normal attribute typically has show entry as below::
- *
- *   static ssize_t example_attribute_show(struct device *dev,
- * 		struct device_attribute *attr, char *buf)
- *   {
- * 	...
- * 	return bitmap_print_to_pagebuf(true, buf, &mask, nr_trig_max);
- *   }
- *
- * show entry of attribute has no offset and count parameters and this
- * means the file is limited to one page only.
- * bitmap_print_to_pagebuf() API works terribly well for this kind of
- * normal attribute with buf parameter and without offset, count::
- *
- *   bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp,
- * 			   int nmaskbits)
- *   {
- *   }
- *
- * The problem is once we have a large bitmap, we have a chance to get a
- * bitmask or list more than one page. Especially for list, it could be
- * as complex as 0,3,5,7,9,... We have no simple way to know it exact size.
- * It turns out bin_attribute is a way to break this limit. bin_attribute
- * has show entry as below::
- *
- *   static ssize_t
- *   example_bin_attribute_show(struct file *filp, struct kobject *kobj,
- * 		struct bin_attribute *attr, char *buf,
- * 		loff_t offset, size_t count)
- *   {
- * 	...
- *   }
- *
- * With the new offset and count parameters, this makes sysfs ABI be able
- * to support file size more than one page. For example, offset could be
- * >= 4096.
- * bitmap_print_bitmask_to_buf(), bitmap_print_list_to_buf() wit their
- * cpumap wrapper cpumap_print_bitmask_to_buf(), cpumap_print_list_to_buf()
- * make those drivers be able to support large bitmask and list after they
- * move to use bin_attribute. In result, we have to pass the corresponding
- * parameters such as off, count from bin_attribute show entry to this API.
- *
- * The role of cpumap_print_bitmask_to_buf() and cpumap_print_list_to_buf()
- * is similar with cpumap_print_to_pagebuf(),  the difference is that
- * bitmap_print_to_pagebuf() mainly serves sysfs attribute with the assumption
- * the destination buffer is exactly one page and won't be more than one page.
- * cpumap_print_bitmask_to_buf() and cpumap_print_list_to_buf(), on the other
- * hand, mainly serves bin_attribute which doesn't work with exact one page,
- * and it can break the size limit of converted decimal list and hexadecimal
- * bitmask.
- *
- * WARNING!
- *
- * This function is not a replacement for sprintf() or bitmap_print_to_pagebuf().
- * It is intended to workaround sysfs limitations discussed above and should be
- * used carefully in general case for the following reasons:
- *
- *  - Time complexity is O(nbits^2/count), comparing to O(nbits) for snprintf().
- *  - Memory complexity is O(nbits), comparing to O(1) for snprintf().
- *  - @off and @count are NOT offset and number of bits to print.
- *  - If printing part of bitmap as list, the resulting string is not a correct
- *    list representation of bitmap. Particularly, some bits within or out of
- *    related interval may be erroneously set or unset. The format of the string
- *    may be broken, so bitmap_parselist-like parser may fail parsing it.
- *  - If printing the whole bitmap as list by parts, user must ensure the order
- *    of calls of the function such that the offset is incremented linearly.
- *  - If printing the whole bitmap as list by parts, user must keep bitmap
- *    unchanged between the very first and very last call. Otherwise concatenated
- *    result may be incorrect, and format may be broken.
- *
- * Returns the number of characters actually printed to @buf
- */
-int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
-				int nmaskbits, loff_t off, size_t count)
-{
-	return bitmap_print_to_buf(false, buf, maskp, nmaskbits, off, count);
-}
-EXPORT_SYMBOL(bitmap_print_bitmask_to_buf);
-
-/**
- * bitmap_print_list_to_buf  - convert bitmap to decimal list format ASCII string
- * @buf: buffer into which string is placed
- * @maskp: pointer to bitmap to convert
- * @nmaskbits: size of bitmap, in bits
- * @off: in the string from which we are copying, We copy to @buf
- * @count: the maximum number of bytes to print
- *
- * Everything is same with the above bitmap_print_bitmask_to_buf() except
- * the print format.
- */
-int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
-			     int nmaskbits, loff_t off, size_t count)
-{
-	return bitmap_print_to_buf(true, buf, maskp, nmaskbits, off, count);
-}
-EXPORT_SYMBOL(bitmap_print_list_to_buf);
-
-/*
- * Region 9-38:4/10 describes the following bitmap structure:
- * 0	   9  12    18			38	     N
- * .........****......****......****..................
- *	    ^  ^     ^			 ^	     ^
- *      start  off   group_len	       end	 nbits
- */
-struct region {
-	unsigned int start;
-	unsigned int off;
-	unsigned int group_len;
-	unsigned int end;
-	unsigned int nbits;
-};
-
-static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
-{
-	unsigned int start;
-
-	for (start = r->start; start <= r->end; start += r->group_len)
-		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
-}
-
-static int bitmap_check_region(const struct region *r)
-{
-	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
-		return -EINVAL;
-
-	if (r->end >= r->nbits)
-		return -ERANGE;
-
-	return 0;
-}
-
-static const char *bitmap_getnum(const char *str, unsigned int *num,
-				 unsigned int lastbit)
-{
-	unsigned long long n;
-	unsigned int len;
-
-	if (str[0] == 'N') {
-		*num = lastbit;
-		return str + 1;
-	}
-
-	len = _parse_integer(str, 10, &n);
-	if (!len)
-		return ERR_PTR(-EINVAL);
-	if (len & KSTRTOX_OVERFLOW || n != (unsigned int)n)
-		return ERR_PTR(-EOVERFLOW);
-
-	*num = n;
-	return str + len;
-}
-
-static inline bool end_of_str(char c)
-{
-	return c == '\0' || c == '\n';
-}
-
-static inline bool __end_of_region(char c)
-{
-	return isspace(c) || c == ',';
-}
-
-static inline bool end_of_region(char c)
-{
-	return __end_of_region(c) || end_of_str(c);
-}
-
-/*
- * The format allows commas and whitespaces at the beginning
- * of the region.
- */
-static const char *bitmap_find_region(const char *str)
-{
-	while (__end_of_region(*str))
-		str++;
-
-	return end_of_str(*str) ? NULL : str;
-}
-
-static const char *bitmap_find_region_reverse(const char *start, const char *end)
-{
-	while (start <= end && __end_of_region(*end))
-		end--;
-
-	return end;
-}
-
-static const char *bitmap_parse_region(const char *str, struct region *r)
-{
-	unsigned int lastbit = r->nbits - 1;
-
-	if (!strncasecmp(str, "all", 3)) {
-		r->start = 0;
-		r->end = lastbit;
-		str += 3;
-
-		goto check_pattern;
-	}
-
-	str = bitmap_getnum(str, &r->start, lastbit);
-	if (IS_ERR(str))
-		return str;
-
-	if (end_of_region(*str))
-		goto no_end;
-
-	if (*str != '-')
-		return ERR_PTR(-EINVAL);
-
-	str = bitmap_getnum(str + 1, &r->end, lastbit);
-	if (IS_ERR(str))
-		return str;
-
-check_pattern:
-	if (end_of_region(*str))
-		goto no_pattern;
-
-	if (*str != ':')
-		return ERR_PTR(-EINVAL);
-
-	str = bitmap_getnum(str + 1, &r->off, lastbit);
-	if (IS_ERR(str))
-		return str;
-
-	if (*str != '/')
-		return ERR_PTR(-EINVAL);
-
-	return bitmap_getnum(str + 1, &r->group_len, lastbit);
-
-no_end:
-	r->end = r->start;
-no_pattern:
-	r->off = r->end + 1;
-	r->group_len = r->end + 1;
-
-	return end_of_str(*str) ? NULL : str;
-}
-
-/**
- * bitmap_parselist - convert list format ASCII string to bitmap
- * @buf: read user string from this buffer; must be terminated
- *    with a \0 or \n.
- * @maskp: write resulting mask here
- * @nmaskbits: number of bits in mask to be written
- *
- * Input format is a comma-separated list of decimal numbers and
- * ranges.  Consecutively set bits are shown as two hyphen-separated
- * decimal numbers, the smallest and largest bit numbers set in
- * the range.
- * Optionally each range can be postfixed to denote that only parts of it
- * should be set. The range will divided to groups of specific size.
- * From each group will be used only defined amount of bits.
- * Syntax: range:used_size/group_size
- * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
- * The value 'N' can be used as a dynamically substituted token for the
- * maximum allowed value; i.e (nmaskbits - 1).  Keep in mind that it is
- * dynamic, so if system changes cause the bitmap width to change, such
- * as more cores in a CPU list, then any ranges using N will also change.
- *
- * Returns: 0 on success, -errno on invalid input strings. Error values:
- *
- *   - ``-EINVAL``: wrong region format
- *   - ``-EINVAL``: invalid character in string
- *   - ``-ERANGE``: bit number specified too large for mask
- *   - ``-EOVERFLOW``: integer overflow in the input parameters
- */
-int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
-{
-	struct region r;
-	long ret;
-
-	r.nbits = nmaskbits;
-	bitmap_zero(maskp, r.nbits);
-
-	while (buf) {
-		buf = bitmap_find_region(buf);
-		if (buf == NULL)
-			return 0;
-
-		buf = bitmap_parse_region(buf, &r);
-		if (IS_ERR(buf))
-			return PTR_ERR(buf);
-
-		ret = bitmap_check_region(&r);
-		if (ret)
-			return ret;
-
-		bitmap_set_region(&r, maskp);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(bitmap_parselist);
-
-
-/**
- * bitmap_parselist_user() - convert user buffer's list format ASCII
- * string to bitmap
- *
- * @ubuf: pointer to user buffer containing string.
- * @ulen: buffer size in bytes.  If string is smaller than this
- *    then it must be terminated with a \0.
- * @maskp: pointer to bitmap array that will contain result.
- * @nmaskbits: size of bitmap, in bits.
- *
- * Wrapper for bitmap_parselist(), providing it with user buffer.
- */
-int bitmap_parselist_user(const char __user *ubuf,
-			unsigned int ulen, unsigned long *maskp,
-			int nmaskbits)
-{
-	char *buf;
-	int ret;
-
-	buf = memdup_user_nul(ubuf, ulen);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
-	ret = bitmap_parselist(buf, maskp, nmaskbits);
-
-	kfree(buf);
-	return ret;
-}
-EXPORT_SYMBOL(bitmap_parselist_user);
-
-static const char *bitmap_get_x32_reverse(const char *start,
-					const char *end, u32 *num)
-{
-	u32 ret = 0;
-	int c, i;
-
-	for (i = 0; i < 32; i += 4) {
-		c = hex_to_bin(*end--);
-		if (c < 0)
-			return ERR_PTR(-EINVAL);
-
-		ret |= c << i;
-
-		if (start > end || __end_of_region(*end))
-			goto out;
-	}
-
-	if (hex_to_bin(*end--) >= 0)
-		return ERR_PTR(-EOVERFLOW);
-out:
-	*num = ret;
-	return end;
-}
-
-/**
- * bitmap_parse - convert an ASCII hex string into a bitmap.
- * @start: pointer to buffer containing string.
- * @buflen: buffer size in bytes.  If string is smaller than this
- *    then it must be terminated with a \0 or \n. In that case,
- *    UINT_MAX may be provided instead of string length.
- * @maskp: pointer to bitmap array that will contain result.
- * @nmaskbits: size of bitmap, in bits.
- *
- * Commas group hex digits into chunks.  Each chunk defines exactly 32
- * bits of the resultant bitmask.  No chunk may specify a value larger
- * than 32 bits (%-EOVERFLOW), and if a chunk specifies a smaller value
- * then leading 0-bits are prepended.  %-EINVAL is returned for illegal
- * characters. Grouping such as "1,,5", ",44", "," or "" is allowed.
- * Leading, embedded and trailing whitespace accepted.
- */
-int bitmap_parse(const char *start, unsigned int buflen,
-		unsigned long *maskp, int nmaskbits)
-{
-	const char *end = strnchrnul(start, buflen, '\n') - 1;
-	int chunks = BITS_TO_U32(nmaskbits);
-	u32 *bitmap = (u32 *)maskp;
-	int unset_bit;
-	int chunk;
-
-	for (chunk = 0; ; chunk++) {
-		end = bitmap_find_region_reverse(start, end);
-		if (start > end)
-			break;
-
-		if (!chunks--)
-			return -EOVERFLOW;
-
-#if defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)
-		end = bitmap_get_x32_reverse(start, end, &bitmap[chunk ^ 1]);
-#else
-		end = bitmap_get_x32_reverse(start, end, &bitmap[chunk]);
-#endif
-		if (IS_ERR(end))
-			return PTR_ERR(end);
-	}
-
-	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
-	if (unset_bit < nmaskbits) {
-		bitmap_clear(maskp, unset_bit, nmaskbits - unset_bit);
-		return 0;
-	}
-
-	if (find_next_bit(maskp, unset_bit, nmaskbits) != unset_bit)
-		return -EOVERFLOW;
-
-	return 0;
-}
-EXPORT_SYMBOL(bitmap_parse);
-
 /**
  * bitmap_pos_to_ord - find ordinal of set bit at given position in bitmap
  *	@buf: pointer to a bitmap
-- 
2.39.2

