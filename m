Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809A575B2D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjGTPew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjGTPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:34:49 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64F21B6;
        Thu, 20 Jul 2023 08:34:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6GcS4Zjwz9xGXS;
        Thu, 20 Jul 2023 23:21:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBHquXFU7lkGHDRBA--.21759S3;
        Thu, 20 Jul 2023 16:33:57 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 1/9] lib: Add TLV parser
Date:   Thu, 20 Jul 2023 17:32:37 +0200
Message-Id: <20230720153247.3755856-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHquXFU7lkGHDRBA--.21759S3
X-Coremail-Antispam: 1UD129KBjvAXoWfGw15XF1rKrWDArW7Jw18Xwb_yoW8JrWxCo
        ZI9r4Uur4rXr1j9a18Zw48Ar1UXry0gr43Aw1fGrW5ua4I9a45Kr45Kw43G3y5Aws8Kr45
        t3sxX3y3Xw4DKrs3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
        4l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1cdbUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4y-0gAAsS
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a parser of a generic TLV format:

+-----------------+------------------+-----------------+
| data type (u64) | num fields (u64) | total len (u64) | # header
+--------------+--+---------+--------+---------+-------+
| field1 (u64) | len1 (u64) | value1 (u8 len1) |
+--------------+------------+------------------+
|     ...      |    ...     |        ...       |         # data
+--------------+------------+------------------+
| fieldN (u64) | lenN (u64) | valueN (u8 lenN) |
+--------------+------------+------------------+

Each adopter can define its own data types and fields. The TLV parser does
not need to be aware of those, and calls a callback function, supplied by
the adopter, for every encountered field during parsing. The adopter can
decide in the callback function how each defined field should be
handled/parsed.

Normally, calling tlv_parse() is sufficient for most of the use cases. In
addition, tlv_parse_hdr() and tlv_parse_data() are also provided for more
advanced use cases.

Nesting TLVs is also possible, the parser of one field can call tlv_parse()
to parse the inner structure.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 MAINTAINERS                     |   8 ++
 include/linux/tlv_parser.h      |  28 +++++
 include/uapi/linux/tlv_parser.h |  59 ++++++++++
 lib/Kconfig                     |   3 +
 lib/Makefile                    |   3 +
 lib/tlv_parser.c                | 203 ++++++++++++++++++++++++++++++++
 lib/tlv_parser.h                |  17 +++
 7 files changed, 321 insertions(+)
 create mode 100644 include/linux/tlv_parser.h
 create mode 100644 include/uapi/linux/tlv_parser.h
 create mode 100644 lib/tlv_parser.c
 create mode 100644 lib/tlv_parser.h

diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630ec..220463b2e51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21456,6 +21456,14 @@ W:	http://sourceforge.net/projects/tlan/
 F:	Documentation/networking/device_drivers/ethernet/ti/tlan.rst
 F:	drivers/net/ethernet/ti/tlan.*
 
+TLV PARSER
+M:	Roberto Sassu <roberto.sassu@huawei.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	include/linux/tlv_parser.h
+F:	include/uapi/linux/tlv_parser.h
+F:	lib/tlv_parser.*
+
 TMIO/SDHI MMC DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 L:	linux-mmc@vger.kernel.org
diff --git a/include/linux/tlv_parser.h b/include/linux/tlv_parser.h
new file mode 100644
index 00000000000..7c673b5635e
--- /dev/null
+++ b/include/linux/tlv_parser.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of TLV parser.
+ */
+
+#ifndef _LINUX_TLV_PARSER_H
+#define _LINUX_TLV_PARSER_H
+
+#include <uapi/linux/tlv_parser.h>
+
+typedef int (*parse_callback)(void *, __u64, const __u8 *, __u64);
+
+int tlv_parse_hdr(const __u8 **data, size_t *data_len, __u64 *parsed_data_type,
+		  __u64 *parsed_num_fields, __u64 *parsed_total_len,
+		  const char **data_types, __u64 num_data_types);
+int tlv_parse_data(parse_callback callback, void *callback_data,
+		   __u64 parsed_num_fields, const __u8 *data, size_t data_len,
+		   const char **fields, __u64 num_fields);
+int tlv_parse(__u64 expected_data_type, parse_callback callback,
+	      void *callback_data, const __u8 *data, size_t data_len,
+	      const char **data_types, __u64 num_data_types,
+	      const char **fields, __u64 num_fields);
+
+#endif /* _LINUX_TLV_PARSER_H */
diff --git a/include/uapi/linux/tlv_parser.h b/include/uapi/linux/tlv_parser.h
new file mode 100644
index 00000000000..fe87be4914d
--- /dev/null
+++ b/include/uapi/linux/tlv_parser.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the user space interface for the TLV parser.
+ */
+
+#ifndef _UAPI_LINUX_TLV_PARSER_H
+#define _UAPI_LINUX_TLV_PARSER_H
+
+#include <linux/types.h>
+
+/*
+ * TLV format:
+ *
+ * +-----------------+------------------+-----------------+
+ * | data type (u64) | num fields (u64) | total len (u64) | # header
+ * +--------------+--+---------+--------+---------+-------+
+ * | field1 (u64) | len1 (u64) | value1 (u8 len1) |
+ * +--------------+------------+------------------+
+ * |     ...      |    ...     |        ...       |         # data
+ * +--------------+------------+------------------+
+ * | fieldN (u64) | lenN (u64) | valueN (u8 lenN) |
+ * +--------------+------------+------------------+
+ */
+
+/**
+ * struct tlv_hdr - Header of TLV format
+ * @data_type: Type of data to parse
+ * @num_fields: Number of fields provided
+ * @_reserved: Reserved for future use
+ * @total_len: Total length of the data blob, excluding the header
+ *
+ * This structure represents the header of the TLV data format.
+ */
+struct tlv_hdr {
+	__u64 data_type;
+	__u64 num_fields;
+	__u64 _reserved;
+	__u64 total_len;
+} __packed;
+
+/**
+ * struct tlv_entry - Data entry of TLV format
+ * @field: Data field identifier
+ * @length: Data length
+ * @data: Data
+ *
+ * This structure represents a TLV entry of the data part of TLV data format.
+ */
+struct tlv_entry {
+	__u64 field;
+	__u64 length;
+	__u8 data[];
+} __packed;
+
+#endif /* _UAPI_LINUX_TLV_PARSER_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 5c2da561c51..cea8d2c87b1 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -763,3 +763,6 @@ config ASN1_ENCODER
 
 config POLYNOMIAL
        tristate
+
+config TLV_PARSER
+	bool
diff --git a/lib/Makefile b/lib/Makefile
index 42d307ade22..ad55cd6c25b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -432,3 +432,6 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
 ifeq ($(CONFIG_FORTIFY_SOURCE),y)
 $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
 endif
+
+obj-$(CONFIG_TLV_PARSER) += tlv_parser.o
+CFLAGS_tlv_parser.o += -I lib
diff --git a/lib/tlv_parser.c b/lib/tlv_parser.c
new file mode 100644
index 00000000000..c28e5584968
--- /dev/null
+++ b/lib/tlv_parser.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Implement the TLV parser.
+ */
+
+#define pr_fmt(fmt) "TLV PARSER: "fmt
+#include <tlv_parser.h>
+
+/**
+ * tlv_parse_hdr - Parse a TLV header
+ * @data: Data to parse (updated)
+ * @data_len: Length of @data (updated)
+ * @parsed_data_type: Parsed data type (updated)
+ * @parsed_num_fields: Parsed data fields (updated)
+ * @parsed_total_len: Length of parsed data part, excluding the header (updated)
+ * @data_types: Array of data type strings
+ * @num_data_types: Number of elements of @data_types
+ *
+ * Parse the header of the TLV data format, update the data pointer and length,
+ * and provide the data type, number of fields and the length of that element.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int tlv_parse_hdr(const __u8 **data, size_t *data_len, __u64 *parsed_data_type,
+		  __u64 *parsed_num_fields, __u64 *parsed_total_len,
+		  const char **data_types, __u64 num_data_types)
+{
+	struct tlv_hdr *hdr;
+
+	if (*data_len < sizeof(*hdr)) {
+		pr_debug("Data blob too short, %lu bytes, expected %lu\n",
+			 *data_len, sizeof(*hdr));
+		return -EBADMSG;
+	}
+
+	hdr = (struct tlv_hdr *)*data;
+
+	*data += sizeof(*hdr);
+	*data_len -= sizeof(*hdr);
+
+	*parsed_data_type = __be64_to_cpu(hdr->data_type);
+	if (*parsed_data_type >= num_data_types) {
+		pr_debug("Invalid data type %llu, max: %llu\n",
+			 *parsed_data_type, num_data_types - 1);
+		return -EBADMSG;
+	}
+
+	*parsed_num_fields = __be64_to_cpu(hdr->num_fields);
+
+	if (hdr->_reserved != 0) {
+		pr_debug("_reserved must be zero\n");
+		return -EBADMSG;
+	}
+
+	*parsed_total_len = __be64_to_cpu(hdr->total_len);
+	if (*parsed_total_len > *data_len) {
+		pr_debug("Invalid total length %llu, expected: %lu\n",
+			 *parsed_total_len, *data_len);
+		return -EBADMSG;
+	}
+
+	pr_debug("Header: type: %s, num fields: %llu, total len: %lld\n",
+		 data_types[*parsed_data_type], *parsed_num_fields,
+		 *parsed_total_len);
+
+	return 0;
+}
+
+/**
+ * tlv_parse_data - Parse a TLV data
+ * @callback: Callback function to call to parse the fields
+ * @callback_data: Opaque data to supply to the callback function
+ * @parsed_num_fields: Parsed data fields
+ * @data: Data to parse
+ * @data_len: Length of @data
+ * @fields: Array of field strings
+ * @num_fields: Number of elements of @fields
+ *
+ * Parse the data part of the TLV data format and call the supplied callback
+ * function for each data field, passing also the opaque data pointer.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int tlv_parse_data(parse_callback callback, void *callback_data,
+		   __u64 parsed_num_fields, const __u8 *data, size_t data_len,
+		   const char **fields, __u64 num_fields)
+{
+	const __u8 *data_ptr = data;
+	struct tlv_entry *entry;
+	__u64 parsed_field;
+	__u64 len;
+	int ret, i;
+
+	for (i = 0; i < parsed_num_fields; i++) {
+		if (data_len < sizeof(*entry))
+			return -EBADMSG;
+
+		entry = (struct tlv_entry *)data_ptr;
+		data_ptr += sizeof(*entry);
+		data_len -= sizeof(*entry);
+
+		parsed_field = __be64_to_cpu(entry->field);
+		if (parsed_field >= num_fields) {
+			pr_debug("Invalid field %llu, max: %llu\n",
+				 parsed_field, num_fields - 1);
+			return -EBADMSG;
+		}
+
+		len = __be64_to_cpu(entry->length);
+
+		if (data_len < len)
+			return -EBADMSG;
+
+		pr_debug("Data: field: %s, len: %llu\n", fields[parsed_field],
+			 len);
+
+		if (!len)
+			continue;
+
+		ret = callback(callback_data, parsed_field, data_ptr, len);
+		if (ret < 0) {
+			pr_debug("Parsing of field %s failed, ret: %d\n",
+				 fields[parsed_field], ret);
+			return -EBADMSG;
+		}
+
+		data_ptr += len;
+		data_len -= len;
+	}
+
+	if (data_len) {
+		pr_debug("Excess data: %ld bytes\n", data_len);
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
+/**
+ * tlv_parse - Parse data in TLV format
+ * @expected_data_type: Desired data type
+ * @callback: Callback function to call to parse the fields
+ * @callback_data: Opaque data to supply to the callback function
+ * @data: Data to parse
+ * @data_len: Length of @data
+ * @data_types: Array of data type strings
+ * @num_data_types: Number of elements of @data_types
+ * @fields: Array of field strings
+ * @num_fields: Number of elements of @fields
+ *
+ * Parse data in TLV format and call the supplied callback function for each
+ * data field, passing also the opaque data pointer.
+ *
+ * Return: Zero on success, a negative value on error.
+ */
+int tlv_parse(__u64 expected_data_type, parse_callback callback,
+	      void *callback_data, const __u8 *data, size_t data_len,
+	      const char **data_types, __u64 num_data_types,
+	      const char **fields, __u64 num_fields)
+{
+	__u64 parsed_data_type;
+	__u64 parsed_num_fields;
+	__u64 parsed_total_len;
+	int ret = 0;
+
+	pr_debug("Start parsing data blob, size: %ld, expected data type: %s\n",
+		 data_len, data_types[expected_data_type]);
+
+	while (data_len) {
+		ret = tlv_parse_hdr(&data, &data_len, &parsed_data_type,
+				    &parsed_num_fields, &parsed_total_len,
+				    data_types, num_data_types);
+		if (ret < 0)
+			goto out;
+
+		if (parsed_data_type == expected_data_type)
+			break;
+
+		/*
+		 * tlv_parse_hdr() already checked that
+		 * parsed_total_len <= data_len.
+		 */
+		data += parsed_total_len;
+		data_len -= parsed_total_len;
+	}
+
+	if (!data_len) {
+		pr_debug("Data type %s not found\n",
+			 data_types[expected_data_type]);
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = tlv_parse_data(callback, callback_data, parsed_num_fields, data,
+			     parsed_total_len, fields, num_fields);
+out:
+	pr_debug("End of parsing data blob, ret: %d\n", ret);
+	return ret;
+}
diff --git a/lib/tlv_parser.h b/lib/tlv_parser.h
new file mode 100644
index 00000000000..b196c6edbf0
--- /dev/null
+++ b/lib/tlv_parser.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of TLV parser.
+ */
+
+#ifndef _LIB_TLV_PARSER_H
+#define _LIB_TLV_PARSER_H
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/tlv_parser.h>
+
+#endif /* _LIB_TLV_PARSER_H */
-- 
2.34.1

