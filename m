Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3307BED3B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378687AbjJIVW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378713AbjJIVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:21:58 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293A0D62;
        Mon,  9 Oct 2023 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696886465; x=1728422465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RUDwz1l5hzO981PWBA46Zx7o0h4TJAKxWSeZDmBzK9k=;
  b=ZxhReIvWh857zhaZfHhmbLUKzxExV/0XQe04puMuYIQHFnFGL+yl8nXp
   dVq+oUN8A/jh3tuSPhRGwzCaIkj4DS/nvWmRXGJPFg4MK2p/gnyhmLE0X
   ncO/JFwNOTJSlZMPEvR78x7HfWwaXHZ1/Ioh3I9Z97olXrCR6+hCrDxn7
   c=;
X-IronPort-AV: E=Sophos;i="6.03,211,1694736000"; 
   d="scan'208";a="360945226"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 21:21:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-ed19f671.us-west-2.amazon.com (Postfix) with ESMTPS id D8BC380EC0;
        Mon,  9 Oct 2023 21:21:00 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 9 Oct 2023 21:21:00 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 9 Oct 2023 21:20:57 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Kyunghwan Kwon <k@mononn.com>
Subject: [PATCH v4 1/2] Import CBOR library
Date:   Mon, 9 Oct 2023 21:20:52 +0000
Message-ID: <20231009212053.2007-2-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009212053.2007-1-graf@amazon.com>
References: <20231009212053.2007-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fully support the Nitro Secure Module communication protocol, we need
to encode and decode CBOR binary data. Import an MIT licensed library
from https://github.com/libmcu/cbor (commit f3d1696f886) so that we can
easily consume CBOR data.

On top of the upstream code base, I added kernel module as well as
kernel header path awareness and made checkpatch happy.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v3 -> v4:

  - New in v4
---
 MAINTAINERS                  |   8 ++
 include/linux/cbor/base.h    |  94 ++++++++++++++
 include/linux/cbor/cbor.h    |  22 ++++
 include/linux/cbor/decoder.h |  42 ++++++
 include/linux/cbor/encoder.h |  48 +++++++
 include/linux/cbor/helper.h  |  41 ++++++
 include/linux/cbor/ieee754.h |  52 ++++++++
 include/linux/cbor/parser.h  |  32 +++++
 lib/Kconfig                  |   3 +
 lib/Makefile                 |   2 +
 lib/cbor/Makefile            |  12 ++
 lib/cbor/common.c            | 105 +++++++++++++++
 lib/cbor/decoder.c           | 170 ++++++++++++++++++++++++
 lib/cbor/encoder.c           | 218 +++++++++++++++++++++++++++++++
 lib/cbor/helper.c            | 175 +++++++++++++++++++++++++
 lib/cbor/ieee754.c           | 205 +++++++++++++++++++++++++++++
 lib/cbor/parser.c            | 243 +++++++++++++++++++++++++++++++++++
 17 files changed, 1472 insertions(+)
 create mode 100644 include/linux/cbor/base.h
 create mode 100644 include/linux/cbor/cbor.h
 create mode 100644 include/linux/cbor/decoder.h
 create mode 100644 include/linux/cbor/encoder.h
 create mode 100644 include/linux/cbor/helper.h
 create mode 100644 include/linux/cbor/ieee754.h
 create mode 100644 include/linux/cbor/parser.h
 create mode 100644 lib/cbor/Makefile
 create mode 100644 lib/cbor/common.c
 create mode 100644 lib/cbor/decoder.c
 create mode 100644 lib/cbor/encoder.c
 create mode 100644 lib/cbor/helper.c
 create mode 100644 lib/cbor/ieee754.c
 create mode 100644 lib/cbor/parser.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c4cce45a09d..5c23081ede95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4661,6 +4661,14 @@ S:	Odd Fixes
 F:	Documentation/devicetree/bindings/arm/cavium-thunder2.txt
 F:	arch/arm64/boot/dts/cavium/thunder2-99xx*
 
+CBOR LIBRARY
+M:	Alexander Graf <graf@amazon.com>
+L:	linux-kernel@vger.kernel.org
+L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
+S:	Supported
+F:	include/linux/cbor/
+F:	lib/cbor/
+
 CBS/ETF/TAPRIO QDISCS
 M:	Vinicius Costa Gomes <vinicius.gomes@intel.com>
 L:	netdev@vger.kernel.org
diff --git a/include/linux/cbor/base.h b/include/linux/cbor/base.h
new file mode 100644
index 000000000000..db15fb834b4f
--- /dev/null
+++ b/include/linux/cbor/base.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#ifndef CBOR_BASE_H
+#define CBOR_BASE_H
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#if !defined(CBOR_RECURSION_MAX_LEVEL)
+#define CBOR_RECURSION_MAX_LEVEL		8
+#endif
+
+#define CBOR_INDEFINITE_VALUE			(-1)
+#define CBOR_RESERVED_VALUE			(-2)
+
+#define CBOR_ADDITIONAL_INFO_MASK		0x1fu /* the low-order 5 bits */
+#define get_cbor_major_type(data_item)		((data_item) >> 5)
+#define get_cbor_additional_info(major_type)	\
+	((major_type) & CBOR_ADDITIONAL_INFO_MASK)
+
+typedef enum {
+	CBOR_SUCCESS, /**< well-formed */
+	CBOR_ILLEGAL, /**< not well-formed */
+	CBOR_INVALID, /**< well-formed but invalid */
+	CBOR_OVERRUN, /**< more items than given buffer space */
+	CBOR_BREAK,
+	CBOR_EXCESSIVE, /**< recursion more than @ref CBOR_RECURSION_MAX_LEVEL */
+} cbor_error_t;
+
+typedef enum {
+	CBOR_ITEM_UNKNOWN,
+	CBOR_ITEM_INTEGER, /**< unsigned integer and negative integer */
+	CBOR_ITEM_STRING, /**< byte string and text string */
+	CBOR_ITEM_ARRAY,
+	CBOR_ITEM_MAP,
+	CBOR_ITEM_FLOAT,
+	CBOR_ITEM_SIMPLE_VALUE,
+} cbor_item_data_t;
+
+typedef struct {
+	cbor_item_data_t type;
+	size_t offset;
+	size_t size; /**< either of the length of value in bytes or the number
+		       of items in case of container type */
+} cbor_item_t;
+
+typedef struct {
+	uint8_t const *msg;
+	size_t msgsize;
+	size_t msgidx;
+
+	cbor_item_t *items;
+	size_t itemidx;
+	size_t maxitems;
+} cbor_reader_t;
+
+typedef struct {
+	uint8_t *buf;
+	size_t bufsize;
+	size_t bufidx;
+} cbor_writer_t;
+
+/**
+ * Initialize the reader for CBOR encoded messages.
+ *
+ * @param[in,out] reader reader context for the actual encoded message
+ * @param[out] items a pointer to item buffers
+ * @param[in] maxitems the maximum number of items to be stored in @p items
+ */
+void cbor_reader_init(cbor_reader_t *reader, cbor_item_t *items, size_t maxitems);
+void cbor_writer_init(cbor_writer_t *writer, void *buf, size_t bufsize);
+size_t cbor_writer_len(cbor_writer_t const *writer);
+uint8_t const *cbor_writer_get_encoded(cbor_writer_t const *writer);
+
+cbor_item_data_t cbor_get_item_type(cbor_item_t const *item);
+size_t cbor_get_item_size(cbor_item_t const *item);
+
+uint8_t cbor_get_following_bytes(uint8_t additional_info);
+
+size_t cbor_copy(uint8_t *dst, uint8_t const *src, size_t len);
+size_t cbor_copy_be(uint8_t *dst, uint8_t const *src, size_t len);
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* CBOR_BASE_H */
diff --git a/include/linux/cbor/cbor.h b/include/linux/cbor/cbor.h
new file mode 100644
index 000000000000..92d69ac7ae40
--- /dev/null
+++ b/include/linux/cbor/cbor.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#ifndef CBOR_H
+#define CBOR_H
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/cbor/parser.h>
+#include <linux/cbor/decoder.h>
+#include <linux/cbor/encoder.h>
+#include <linux/cbor/helper.h>
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* CBOR_H */
diff --git a/include/linux/cbor/decoder.h b/include/linux/cbor/decoder.h
new file mode 100644
index 000000000000..846f0d215662
--- /dev/null
+++ b/include/linux/cbor/decoder.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#ifndef CBOR_DECODER_H
+#define CBOR_DECODER_H
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/cbor/base.h>
+
+/**
+ * Decode a CBOR data item
+ *
+ * @param[in] reader reader context for the actual encoded message
+ * @param[in] item meta data about the item to be decoded
+ * @param[out] buf the buffer where decoded value to be written in
+ * @param[in] bufsize the buffer size
+ *
+ * @return a code of @ref cbor_error_t
+ */
+cbor_error_t cbor_decode(cbor_reader_t const *reader, cbor_item_t const *item,
+		void *buf, size_t bufsize);
+/**
+ * Get the pointer to an item value
+ *
+ * @param[in] reader reader context for the actual encoded message
+ * @param[in] item meta data about the item to be decoded
+ *
+ * @return the pointer to the item value
+ */
+void const *cbor_decode_pointer(cbor_reader_t const *reader,
+		cbor_item_t const *item);
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* CBOR_DECODER_H */
diff --git a/include/linux/cbor/encoder.h b/include/linux/cbor/encoder.h
new file mode 100644
index 000000000000..360568825454
--- /dev/null
+++ b/include/linux/cbor/encoder.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#ifndef CBOR_ENCODER_H
+#define CBOR_ENCODER_H
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/cbor/base.h>
+
+cbor_error_t cbor_encode_unsigned_integer(cbor_writer_t *writer, uint64_t value);
+cbor_error_t cbor_encode_negative_integer(cbor_writer_t *writer, int64_t value);
+
+cbor_error_t cbor_encode_byte_string(cbor_writer_t *writer,
+		uint8_t const *data, size_t datasize);
+cbor_error_t cbor_encode_byte_string_indefinite(cbor_writer_t *writer);
+
+cbor_error_t cbor_encode_text_string(cbor_writer_t *writer,
+		char const *text, size_t textsize);
+cbor_error_t cbor_encode_null_terminated_text_string(cbor_writer_t *writer,
+		char const *text);
+cbor_error_t cbor_encode_text_string_indefinite(cbor_writer_t *writer);
+
+cbor_error_t cbor_encode_array(cbor_writer_t *writer, size_t length);
+cbor_error_t cbor_encode_array_indefinite(cbor_writer_t *writer);
+
+cbor_error_t cbor_encode_map(cbor_writer_t *writer, size_t length);
+cbor_error_t cbor_encode_map_indefinite(cbor_writer_t *writer);
+
+cbor_error_t cbor_encode_break(cbor_writer_t *writer);
+
+cbor_error_t cbor_encode_simple(cbor_writer_t *writer, uint8_t value);
+cbor_error_t cbor_encode_bool(cbor_writer_t *writer, bool value);
+cbor_error_t cbor_encode_null(cbor_writer_t *writer);
+cbor_error_t cbor_encode_undefined(cbor_writer_t *writer);
+
+cbor_error_t cbor_encode_float(cbor_writer_t *writer, float value);
+cbor_error_t cbor_encode_double(cbor_writer_t *writer, double value);
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* CBOR_ENCODER_H */
diff --git a/include/linux/cbor/helper.h b/include/linux/cbor/helper.h
new file mode 100644
index 000000000000..d366583d2c54
--- /dev/null
+++ b/include/linux/cbor/helper.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#ifndef CBOR_HELPER_H
+#define CBOR_HELPER_H
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/cbor/base.h>
+
+struct cbor_parser {
+	const void *key;
+	size_t keylen;
+	void (*run)(const cbor_reader_t *reader,
+			const struct cbor_parser *parser,
+			const cbor_item_t *item, void *arg);
+};
+
+bool cbor_unmarshal(cbor_reader_t *reader,
+		const struct cbor_parser *parsers, size_t nr_parsers,
+		const void *msg, size_t msglen, void *arg);
+
+size_t cbor_iterate(const cbor_reader_t *reader,
+		    const cbor_item_t *parent,
+		    void (*callback_each)(const cbor_reader_t *reader,
+			    const cbor_item_t *item, const cbor_item_t *parent,
+			    void *arg),
+		    void *arg);
+
+const char *cbor_stringify_error(cbor_error_t err);
+const char *cbor_stringify_item(cbor_item_t *item);
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* CBOR_HELPER_H */
diff --git a/include/linux/cbor/ieee754.h b/include/linux/cbor/ieee754.h
new file mode 100644
index 000000000000..1362f3774d7c
--- /dev/null
+++ b/include/linux/cbor/ieee754.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#ifndef CBOR_IEEE754_H
+#define CBOR_IEEE754_H
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/cbor/base.h>
+
+typedef union {
+	uint16_t value;
+	struct {
+		uint32_t m: 10;
+		uint32_t e: 5;
+		uint32_t sign: 1;
+	} components;
+} ieee754_half_t;
+
+typedef union {
+	float value;
+	struct {
+		uint32_t m: 23;
+		uint32_t e: 8;
+		uint32_t sign: 1;
+	} components;
+} ieee754_single_t;
+
+typedef union {
+	double value;
+	struct {
+		uint64_t m: 52;
+		uint64_t e: 11;
+		uint64_t sign: 1;
+	} components;
+} ieee754_double_t;
+
+uint16_t ieee754_convert_single_to_half(float value);
+double ieee754_convert_half_to_double(uint16_t value);
+
+bool ieee754_is_shrinkable_to_half(float value);
+bool ieee754_is_shrinkable_to_single(double value);
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* CBOR_IEEE754_H */
diff --git a/include/linux/cbor/parser.h b/include/linux/cbor/parser.h
new file mode 100644
index 000000000000..554004799f0a
--- /dev/null
+++ b/include/linux/cbor/parser.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#ifndef CBOR_PARSER_H
+#define CBOR_PARSER_H
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+#include <linux/cbor/base.h>
+
+/**
+ * Parse the encoded CBOR messages into items.
+ *
+ * @param[in,out] reader reader context for the actual encoded message
+ * @param[in] msg CBOR encoded message
+ * @param[in] msgsize the @p msg size in bytes
+ * @param[out] nitems_parsed the number of items parsed gets stored if not null
+ *
+ * @return a code of @ref cbor_error_t
+ */
+cbor_error_t cbor_parse(cbor_reader_t *reader, void const *msg, size_t msgsize,
+		size_t *nitems_parsed);
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* CBOR_PARSER_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index c686f4adc124..12fb3d68cd9a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -764,3 +764,6 @@ config ASN1_ENCODER
 
 config POLYNOMIAL
        tristate
+
+config CBOR
+	tristate
diff --git a/lib/Makefile b/lib/Makefile
index 740109b6e2c8..287f3dcaff31 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -317,6 +317,8 @@ obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
 
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
+obj-$(CONFIG_CBOR) += cbor/
+
 hostprogs	:= gen_crc32table
 hostprogs	+= gen_crc64table
 clean-files	:= crc32table.h
diff --git a/lib/cbor/Makefile b/lib/cbor/Makefile
new file mode 100644
index 000000000000..6b090ae0f4a8
--- /dev/null
+++ b/lib/cbor/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CBOR) += cbor.o
+
+cbor-y := \
+	common.o \
+	decoder.o \
+	encoder.o \
+	helper.o \
+	parser.o \
+
+cbor-$(CONFIG_CBOR_FLOAT) += ieee754.o
diff --git a/lib/cbor/common.c b/lib/cbor/common.c
new file mode 100644
index 000000000000..a4677a9bc0a3
--- /dev/null
+++ b/lib/cbor/common.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: MIT
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#include <linux/cbor/base.h>
+#include <linux/module.h>
+
+#if !defined(assert)
+#define assert(expr)
+#endif
+
+static size_t copy_le(uint8_t *dst, uint8_t const *src, size_t len)
+{
+	for (size_t i = 0; i < len; i++)
+		dst[len - i - 1] = src[i];
+
+	return len;
+}
+
+static size_t copy_be(uint8_t *dst, uint8_t const *src, size_t len)
+{
+	for (size_t i = 0; i < len; i++)
+		dst[i] = src[i];
+
+	return len;
+}
+
+size_t cbor_copy(uint8_t *dst, uint8_t const *src, size_t len)
+{
+#if defined(CBOR_BIG_ENDIAN)
+	return copy_be(dst, src, len);
+#else
+	return copy_le(dst, src, len);
+#endif
+}
+EXPORT_SYMBOL_GPL(cbor_copy);
+
+size_t cbor_copy_be(uint8_t *dst, uint8_t const *src, size_t len)
+{
+	return copy_be(dst, src, len);
+}
+EXPORT_SYMBOL_GPL(cbor_copy_be);
+
+uint8_t cbor_get_following_bytes(uint8_t additional_info)
+{
+	if (additional_info < 24)
+		return 0;
+	else if (additional_info == 31)
+		return (uint8_t)CBOR_INDEFINITE_VALUE;
+	else if (additional_info >= 28)
+		return (uint8_t)CBOR_RESERVED_VALUE;
+
+	return (uint8_t)(1u << (additional_info - 24));
+}
+EXPORT_SYMBOL_GPL(cbor_get_following_bytes);
+
+cbor_item_data_t cbor_get_item_type(cbor_item_t const *item)
+{
+	return item->type;
+}
+EXPORT_SYMBOL_GPL(cbor_get_item_type);
+
+size_t cbor_get_item_size(cbor_item_t const *item)
+{
+	return item->size;
+}
+EXPORT_SYMBOL_GPL(cbor_get_item_size);
+
+void cbor_reader_init(cbor_reader_t *reader, cbor_item_t *items, size_t maxitems)
+{
+	assert(reader != NULL);
+
+	reader->items = items;
+	reader->maxitems = maxitems;
+	reader->itemidx = 0;
+}
+EXPORT_SYMBOL_GPL(cbor_reader_init);
+
+void cbor_writer_init(cbor_writer_t *writer, void *buf, size_t bufsize)
+{
+	assert(writer != NULL);
+	assert(buf != NULL);
+
+	writer->buf = (uint8_t *)buf;
+	writer->bufsize = bufsize;
+	writer->bufidx = 0;
+}
+EXPORT_SYMBOL_GPL(cbor_writer_init);
+
+size_t cbor_writer_len(cbor_writer_t const *writer)
+{
+	return writer->bufidx;
+}
+EXPORT_SYMBOL_GPL(cbor_writer_len);
+
+uint8_t const *cbor_writer_get_encoded(cbor_writer_t const *writer)
+{
+	return (uint8_t const *)writer->buf;
+}
+EXPORT_SYMBOL_GPL(cbor_writer_get_encoded);
+
+MODULE_DESCRIPTION("CBOR helper functions");
+MODULE_AUTHOR("Kyunghwan Kwon");
+MODULE_LICENSE("GPL");
diff --git a/lib/cbor/decoder.c b/lib/cbor/decoder.c
new file mode 100644
index 000000000000..1ec0b17ecf6c
--- /dev/null
+++ b/lib/cbor/decoder.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: MIT
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#include <linux/cbor/decoder.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+#if !defined(MIN)
+#define MIN(a, b)				(((a) > (b)) ? (b) : (a))
+#endif
+
+typedef cbor_error_t (*item_decoder_t)(cbor_item_t const *item,
+		uint8_t const *msg, uint8_t *buf, size_t bufsize);
+
+static cbor_error_t decode_pass(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize);
+static cbor_error_t decode_integer(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize);
+static cbor_error_t decode_string(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize);
+static cbor_error_t decode_float(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize);
+static cbor_error_t decode_simple(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize);
+
+static const item_decoder_t decoders[] = {
+	decode_pass,		/* 0: CBOR_ITEM_UNKNOWN */
+	decode_integer,		/* 1: CBOR_ITEM_INTEGER */
+	decode_string,		/* 2: CBOR_ITEM_STRING */
+	decode_pass,		/* 3: CBOR_ITEM_ARRAY */
+	decode_pass,		/* 4: CBOR_ITEM_MAP */
+	decode_float,		/* 5: CBOR_ITEM_FLOAT */
+	decode_simple,		/* 6: CBOR_ITEM_SIMPLE_VALUE */
+};
+
+static uint8_t get_simple_value(uint8_t val)
+{
+	switch (val) {
+	case 20: /* false */
+		return 0;
+	case 21: /* true */
+		return 1;
+	case 22: /* null */
+		return '\0';
+	case 23: /* undefined */
+	default:
+		return val;
+	}
+}
+
+static bool is_break(cbor_item_t const *item)
+{
+	return item->type == CBOR_ITEM_FLOAT && item->size == 0xff;
+}
+
+static cbor_error_t decode_unsigned_integer(cbor_item_t const *item,
+		uint8_t const *msg, uint8_t *buf, size_t bufsize)
+{
+	uint8_t additional_info = get_cbor_additional_info(msg[item->offset]);
+	uint8_t following_bytes = cbor_get_following_bytes(additional_info);
+
+	if (following_bytes == 0)
+		buf[0] = additional_info;
+
+	cbor_copy(buf, &msg[item->offset + 1], following_bytes);
+
+	(void)bufsize;
+	return CBOR_SUCCESS;
+}
+
+static cbor_error_t decode_negative_integer(cbor_item_t const *item,
+		uint8_t const *msg, uint8_t *buf, size_t bufsize)
+{
+	cbor_error_t err = decode_unsigned_integer(item, msg, buf, bufsize);
+
+	if (err != CBOR_SUCCESS)
+		return err;
+
+	uint64_t val = 0;
+	size_t len = item->size ? item->size : 1;
+
+	cbor_copy_be((uint8_t *)&val, buf, len);
+
+	val = ~val;
+
+	/*
+	 * The value becomes a positive one if the data type size of the
+	 * variable is larger than the value size. So we set MSB first here to
+	 * keep it negative.
+	 */
+	for (uint8_t i = 0; i < MIN(bufsize, 8u); i++)
+		buf[i] = 0xff;
+
+	cbor_copy_be(buf, (uint8_t *)&val, len);
+
+	return CBOR_SUCCESS;
+}
+
+static cbor_error_t decode_integer(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize)
+{
+	switch (get_cbor_major_type(msg[item->offset])) {
+	case 0: /* unsigned integer */
+		return decode_unsigned_integer(item, msg, buf, bufsize);
+	case 1: /* negative integer */
+		return decode_negative_integer(item, msg, buf, bufsize);
+	default:
+		return CBOR_ILLEGAL;
+	}
+}
+
+static cbor_error_t decode_string(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize)
+{
+	for (size_t i = 0; i < item->size; i++)
+		buf[i] = msg[item->offset + i];
+
+	(void)bufsize;
+	return CBOR_SUCCESS;
+}
+
+static cbor_error_t decode_float(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize)
+{
+	return decode_unsigned_integer(item, msg, buf, bufsize);
+}
+
+static cbor_error_t decode_simple(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize)
+{
+	cbor_error_t err = decode_unsigned_integer(item, msg, buf, bufsize);
+
+	buf[0] = get_simple_value(buf[0]);
+
+	return err;
+}
+
+static cbor_error_t decode_pass(cbor_item_t const *item, uint8_t const *msg,
+		uint8_t *buf, size_t bufsize)
+{
+	(void)item;
+	(void)msg;
+	(void)buf;
+	(void)bufsize;
+	return CBOR_SUCCESS;
+}
+
+void const *cbor_decode_pointer(cbor_reader_t const *reader,
+		cbor_item_t const *item)
+{
+	return &reader->msg[item->offset];
+}
+EXPORT_SYMBOL_GPL(cbor_decode_pointer);
+
+cbor_error_t cbor_decode(cbor_reader_t const *reader, cbor_item_t const *item,
+		void *buf, size_t bufsize)
+{
+	if (is_break(item))
+		return CBOR_BREAK;
+	if (item->size > bufsize || bufsize == 0 || buf == NULL)
+		return CBOR_OVERRUN;
+
+	memset(buf, 0, bufsize);
+
+	return decoders[item->type](item, reader->msg, (uint8_t *)buf, bufsize);
+}
+EXPORT_SYMBOL_GPL(cbor_decode);
diff --git a/lib/cbor/encoder.c b/lib/cbor/encoder.c
new file mode 100644
index 000000000000..9b3f8ac8f670
--- /dev/null
+++ b/lib/cbor/encoder.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: MIT
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#include <linux/cbor/encoder.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_CBOR_FLOAT
+#include <linux/cbor/ieee754.h>
+#endif
+
+#define MAJOR_TYPE_BIT			5
+
+#if !defined(MIN)
+#define MIN(a, b)			(((a) > (b)) ? (b) : (a))
+#endif
+
+static uint8_t get_additional_info(uint64_t value)
+{
+	uint8_t additional_info = 0;
+
+	if (value & ~(0x100000000ull - 1)) /* 8-byte following */
+		additional_info = 27;
+	else if (value & ~(0x10000ull - 1)) /* 4-byte following */
+		additional_info = 26;
+	else if (value & ~(0x100ull - 1)) /* 2-byte following */
+		additional_info = 25;
+	else if (value >= 24) /* 1-byte following */
+		additional_info = 24;
+	else /* 0 ~ 23 */
+		additional_info = (uint8_t)value;
+
+	return additional_info;
+}
+
+static cbor_error_t encode_core(cbor_writer_t *writer, uint8_t major_type,
+		uint8_t const *data, uint64_t datasize, bool indefinite)
+{
+	uint8_t *buf = &writer->buf[writer->bufidx];
+	uint8_t additional_info = get_additional_info(datasize);
+	uint8_t following_bytes = cbor_get_following_bytes(additional_info);
+
+	if (indefinite) {
+		additional_info = 31;
+		following_bytes = 0;
+	}
+
+	size_t bytes_to_write = (size_t)datasize + following_bytes + 1;
+	/*
+	 * NOTE: if not string, `datasize` is the actual value to be written.
+	 * And the `following_bytes` is the length of it.
+	 */
+	if (!(major_type == 2 || major_type == 3))
+		bytes_to_write -= (size_t)datasize;
+
+	if (bytes_to_write > (writer->bufsize - writer->bufidx))
+		return CBOR_OVERRUN;
+
+	buf[0] = (uint8_t)(major_type << MAJOR_TYPE_BIT) | additional_info;
+	cbor_copy(&buf[1], (uint8_t const *)&datasize, following_bytes);
+	if (data != NULL)
+		cbor_copy_be(&buf[1 + following_bytes], data, (size_t)datasize);
+
+	writer->bufidx += bytes_to_write;
+
+	return CBOR_SUCCESS;
+}
+
+static cbor_error_t encode_simple(cbor_writer_t *writer, uint8_t value)
+{
+	return encode_core(writer, 7, NULL, value, false);
+}
+
+cbor_error_t cbor_encode_unsigned_integer(cbor_writer_t *writer, uint64_t value)
+{
+	return encode_core(writer, 0, NULL, value, false);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_unsigned_integer);
+
+cbor_error_t cbor_encode_negative_integer(cbor_writer_t *writer, int64_t value)
+{
+	return encode_core(writer, 1, NULL, ((uint64_t)-value) - 1, false);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_negative_integer);
+
+cbor_error_t cbor_encode_byte_string(cbor_writer_t *writer,
+		uint8_t const *data, size_t datasize)
+{
+	return encode_core(writer, 2, data, datasize, false);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_byte_string);
+
+cbor_error_t cbor_encode_byte_string_indefinite(cbor_writer_t *writer)
+{
+	return encode_core(writer, 2, NULL, 0, true);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_byte_string_indefinite);
+
+
+cbor_error_t cbor_encode_text_string(cbor_writer_t *writer,
+		char const *text, size_t textsize)
+{
+	return encode_core(writer, 3,
+			(uint8_t const *)text, textsize, false);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_text_string);
+
+cbor_error_t cbor_encode_null_terminated_text_string(cbor_writer_t *writer,
+		char const *text)
+{
+	size_t len = 0;
+
+	if (text != NULL)
+		len = MIN(strlen(text), writer->bufsize - writer->bufidx);
+
+	return encode_core(writer, 3, (uint8_t const *)text, len, false);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_null_terminated_text_string);
+
+cbor_error_t cbor_encode_array(cbor_writer_t *writer, size_t length)
+{
+	return encode_core(writer, 4, NULL, length, false);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_array);
+
+cbor_error_t cbor_encode_array_indefinite(cbor_writer_t *writer)
+{
+	return encode_core(writer, 4, NULL, 0, true);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_array_indefinite);
+
+cbor_error_t cbor_encode_map(cbor_writer_t *writer, size_t length)
+{
+	return encode_core(writer, 5, NULL, length, false);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_map);
+
+cbor_error_t cbor_encode_map_indefinite(cbor_writer_t *writer)
+{
+	return encode_core(writer, 5, NULL, 0, true);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_map_indefinite);
+
+cbor_error_t cbor_encode_break(cbor_writer_t *writer)
+{
+	return encode_core(writer, 7, NULL, 0xff, true);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_break);
+
+cbor_error_t cbor_encode_simple(cbor_writer_t *writer, uint8_t value)
+{
+	return encode_simple(writer, value);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_simple);
+
+cbor_error_t cbor_encode_bool(cbor_writer_t *writer, bool value)
+{
+	return encode_simple(writer, (uint8_t)(value + 20));
+}
+EXPORT_SYMBOL_GPL(cbor_encode_bool);
+
+cbor_error_t cbor_encode_null(cbor_writer_t *writer)
+{
+	return encode_simple(writer, 22);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_null);
+
+cbor_error_t cbor_encode_undefined(cbor_writer_t *writer)
+{
+	return encode_simple(writer, 23);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_undefined);
+
+#ifdef CONFIG_CBOR_FLOAT
+static cbor_error_t encode_float(cbor_writer_t *writer, float value)
+{
+	if (ieee754_is_shrinkable_to_half(value)) {
+		uint16_t half = ieee754_convert_single_to_half(value);
+
+		writer->buf[writer->bufidx++] = 0xF9;
+		writer->bufidx += cbor_copy(&writer->buf[writer->bufidx],
+				(uint8_t const *)&half, sizeof(half));
+
+		return CBOR_SUCCESS;
+	}
+
+	writer->buf[writer->bufidx++] = 0xFA;
+	writer->bufidx += cbor_copy(&writer->buf[writer->bufidx],
+			(uint8_t const *)&value, sizeof(value));
+
+	return CBOR_SUCCESS;
+}
+
+cbor_error_t cbor_encode_float(cbor_writer_t *writer, float value)
+{
+	return encode_float(writer, value);
+}
+
+cbor_error_t cbor_encode_double(cbor_writer_t *writer, double value)
+{
+	if (ieee754_is_shrinkable_to_single(value))
+		return encode_float(writer, (float)value);
+
+	writer->buf[writer->bufidx++] = 0xFB;
+	writer->bufidx += cbor_copy(&writer->buf[writer->bufidx],
+			(uint8_t const *)&value, sizeof(value));
+
+	return CBOR_SUCCESS;
+}
+#endif
+
+cbor_error_t cbor_encode_text_string_indefinite(cbor_writer_t *writer)
+{
+	return encode_core(writer, 3, NULL, 0, true);
+}
+EXPORT_SYMBOL_GPL(cbor_encode_text_string_indefinite);
diff --git a/lib/cbor/helper.c b/lib/cbor/helper.c
new file mode 100644
index 000000000000..f7b3e7deea67
--- /dev/null
+++ b/lib/cbor/helper.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: MIT
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#include <linux/cbor/helper.h>
+#include <linux/cbor/parser.h>
+#include <linux/cbor/decoder.h>
+
+#include <linux/string.h>
+#include <linux/module.h>
+
+struct parser_ctx {
+	const struct cbor_parser *parsers;
+	size_t nr_parsers;
+	void *arg;
+};
+
+static const struct cbor_parser *get_parser(const struct parser_ctx *ctx,
+		intptr_t intkey, const void *strkey, size_t strkey_len)
+{
+	for (size_t i = 0; i < ctx->nr_parsers; i++) {
+		const struct cbor_parser *p = &ctx->parsers[i];
+
+		if (!p->key)
+			continue;
+
+		if (strkey && strkey_len && p->keylen >= strkey_len) {
+			if (memcmp(p->key, strkey, strkey_len) == 0)
+				return p;
+		} else if (intkey == (intptr_t)p->key) {
+			return p;
+		}
+	}
+
+	return NULL;
+}
+
+static void parse_item(const cbor_reader_t *reader, const cbor_item_t *item,
+		    const cbor_item_t *parent, void *arg)
+{
+	struct parser_ctx *ctx = (struct parser_ctx *)arg;
+	const void *strkey = NULL;
+	size_t strkey_len = 0;
+	intptr_t intkey = -1;
+
+	if (parent && parent->type == CBOR_ITEM_MAP) {
+		if ((item - parent) % 2) { /* key */
+			return;
+		}
+
+		if ((item-1)->type == CBOR_ITEM_INTEGER) {
+			cbor_decode(reader, item-1, &intkey, sizeof(intkey));
+		} else {
+			strkey = cbor_decode_pointer(reader, item-1);
+			strkey_len = (item-1)->size;
+		}
+	}
+
+	if (strkey || intkey != -1) {
+		const struct cbor_parser *parser = get_parser(ctx,
+				intkey, strkey, strkey_len);
+
+		if (parser && parser->run)
+			parser->run(reader, parser, item, ctx->arg);
+	}
+}
+
+static size_t iterate_each(const cbor_reader_t *reader,
+		    const cbor_item_t *items, size_t nr_items,
+		    const cbor_item_t *parent,
+		    void (*callback_each)(const cbor_reader_t *reader,
+			    const cbor_item_t *item, const cbor_item_t *parent,
+			    void *arg),
+		    void *arg)
+{
+	size_t offset = 0;
+	size_t i = 0;
+
+	for (i = 0; i < nr_items; i++) {
+		const cbor_item_t *item = &items[i+offset];
+
+		if (item->type == CBOR_ITEM_MAP
+				|| item->type == CBOR_ITEM_ARRAY) {
+			size_t len = item->type == CBOR_ITEM_MAP ?
+					item->size*2 : item->size;
+			offset += iterate_each(reader, item+1, len, item,
+					callback_each, arg);
+			continue;
+		}
+
+		if (cbor_decode(reader, item, 0, 0) == CBOR_BREAK)
+			break;
+
+		(*callback_each)(reader, item, parent, arg);
+	}
+
+	return i + offset;
+}
+
+bool cbor_unmarshal(cbor_reader_t *reader,
+		const struct cbor_parser *parsers, size_t nr_parsers,
+		const void *msg, size_t msglen, void *arg)
+{
+	size_t n;
+	cbor_error_t err = cbor_parse(reader, msg, msglen, &n);
+
+	if (err != CBOR_SUCCESS && err != CBOR_BREAK)
+		return false;
+
+	struct parser_ctx ctx = {
+		.parsers = parsers,
+		.nr_parsers = nr_parsers,
+		.arg = arg,
+	};
+
+	iterate_each(reader, reader->items, n, 0, parse_item, &ctx);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(cbor_unmarshal);
+
+size_t cbor_iterate(const cbor_reader_t *reader,
+		    const cbor_item_t *parent,
+		    void (*callback_each)(const cbor_reader_t *reader,
+			    const cbor_item_t *item, const cbor_item_t *parent,
+			    void *arg),
+		    void *arg)
+{
+	return iterate_each(reader, reader->items, reader->itemidx,
+			parent, callback_each, arg);
+}
+EXPORT_SYMBOL_GPL(cbor_iterate);
+
+const char *cbor_stringify_error(cbor_error_t err)
+{
+	switch (err) {
+	case CBOR_SUCCESS:
+		return "success";
+	case CBOR_INVALID:
+		return "invalid";
+	case CBOR_OVERRUN:
+		return "out of memory";
+	case CBOR_BREAK:
+		return "break";
+	case CBOR_EXCESSIVE:
+		return "too deep recursion";
+	case CBOR_ILLEGAL:
+	default:
+		return "not well-formed";
+	}
+}
+EXPORT_SYMBOL_GPL(cbor_stringify_error);
+
+const char *cbor_stringify_item(cbor_item_t *item)
+{
+	switch (item->type) {
+	case CBOR_ITEM_INTEGER:
+		return "integer";
+	case CBOR_ITEM_STRING:
+		return "string";
+	case CBOR_ITEM_ARRAY:
+		return "array";
+	case CBOR_ITEM_MAP:
+		return "map";
+	case CBOR_ITEM_FLOAT:
+		return "float";
+	case CBOR_ITEM_SIMPLE_VALUE:
+		return "simple value";
+	case CBOR_ITEM_UNKNOWN:
+	default:
+		return "unknown";
+	}
+}
+EXPORT_SYMBOL_GPL(cbor_stringify_item);
diff --git a/lib/cbor/ieee754.c b/lib/cbor/ieee754.c
new file mode 100644
index 000000000000..acf180a99f01
--- /dev/null
+++ b/lib/cbor/ieee754.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: MIT
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+/*
+ * | precision | sign | exponent | mantissa | bias |   exp range  |
+ * | --------- | ---- | -------- | -------- | ---- | ------------ |
+ * | half      | 1    |  5       | 10       |   15 |   -14 ~   15 |
+ * | single    | 1    |  8       | 23       |  127 |  -126 ~  127 |
+ * | double    | 1    | 11       | 52       | 1023 | -1022 ~ 1023 |
+ *
+ * ## Special cases
+ * | s |   e  | m  |     desc.     |
+ * | - | -----| -- | ------------- |
+ * | 0 |    0 |  0 | +0.0          |
+ * | 1 |    0 |  0 | -0.0          |
+ * | 0 |    0 | !0 | 0.m * 2^-126  |
+ * | 1 |    0 | !0 | -0.m * 2^-126 |
+ * | 0 | 0xff |  0 | infinity      |
+ * | 1 | 0xff |  0 | -infinity     |
+ * | X | 0xff | -1 | Quiet NaN     |
+ * | X | 0xff | !0 | Signaling NaN |
+ *
+ * ## Terms
+ * - f: source bias
+ * - t: target bias
+ * - e: exponent
+ * - m: mantissa
+ */
+
+#include <linux/cbor/ieee754.h>
+
+#define BIAS_HALF				15
+#define BIAS_SINGLE				127
+#define BIAS_DOUBLE				1023
+
+#define E_MASK_HALF				((1u << 5) - 1)
+#define E_MASK_SINGLE				((1ul << 8) - 1)
+#define E_MASK_DOUBLE				((1ul << 11) - 1)
+
+#define M_BIT_HALF				10
+#define M_BIT_SINGLE				23
+#define M_BIT_DOUBLE				52
+
+#define M_MASK_HALF				((1u << M_BIT_HALF) - 1)
+#define M_MASK_SINGLE				((1ul << M_BIT_SINGLE) - 1)
+#define M_MASK_DOUBLE				((1ull << M_BIT_DOUBLE) - 1)
+
+static int find_last_set_bit(unsigned int value)
+{
+	int cnt = 0;
+
+	while (value != 0) {
+		value >>= 1;
+		cnt++;
+	}
+
+	return cnt;
+}
+
+static bool is_over_range(unsigned int e, unsigned int f, unsigned int t)
+{
+	return e > (f + t);
+}
+
+static bool is_under_range(unsigned int e, unsigned int f, unsigned int t)
+{
+	return e < (f - t + 1);
+}
+
+static bool is_in_range(unsigned int e, unsigned int f, unsigned int t)
+{
+	return !is_over_range(e, f, t) && !is_under_range(e, f, t);
+}
+
+static bool is_in_subrange(unsigned int e, unsigned int target_m_bits,
+		unsigned int f, unsigned int t)
+{
+	return is_under_range(e, f, t) && ((f - e - t) < target_m_bits);
+}
+
+static bool is_precision_lost(uint64_t m, unsigned int f, unsigned int t)
+{
+	return (m & ((1ull << (f - t)) - 1)) != 0;
+}
+
+uint16_t ieee754_convert_single_to_half(float value)
+{
+	ieee754_single_t single = { .value = value };
+	ieee754_half_t half = { .value = 0 };
+	uint8_t exp = M_BIT_SINGLE - M_BIT_HALF;
+
+	half.components.sign = single.components.sign;
+	if (single.components.e == E_MASK_SINGLE) { /* NaN or infinity */
+		half.components.e = E_MASK_HALF;
+	} else if (is_over_range(single.components.e, BIAS_SINGLE, BIAS_HALF)) {
+		/* make it NaN */
+		half.components.e = E_MASK_HALF;
+		single.components.m = 0;
+	} else if (is_under_range(single.components.e, BIAS_SINGLE, BIAS_HALF)) {
+		/* expand the exponent to the mantissa to make it subnormal */
+		exp = (uint8_t)(exp + ((BIAS_SINGLE - single.components.e) - BIAS_HALF));
+		single.components.m = M_MASK_SINGLE;
+	} else { /* zero, normal */
+		if (single.components.e != 0) {
+			half.components.e = (uint8_t)(single.components.e
+				- BIAS_SINGLE + BIAS_HALF) & E_MASK_HALF;
+		}
+	}
+
+	/* precision may be lost discarding outrange lower bits */
+	half.components.m = ((uint32_t)single.components.m >> exp) & M_MASK_HALF;
+
+	return half.value;
+}
+
+double ieee754_convert_half_to_double(uint16_t value)
+{
+	ieee754_half_t half = { .value = value };
+	ieee754_double_t d;
+
+	d.components.sign = half.components.sign;
+	d.components.e = half.components.e;
+	d.components.m = half.components.m;
+
+	if (half.components.e == E_MASK_HALF) { /* NaN or infinity */
+		d.components.e = E_MASK_DOUBLE;
+		if (half.components.m == M_MASK_HALF) /* Quiet NaN */
+			d.components.m = M_MASK_DOUBLE;
+		else if (half.components.m != 0) /* Signaling NaN */
+			d.components.m = (1ull << (M_BIT_DOUBLE - 1));
+	} else if (half.components.e == 0) { /* zero or subnormal */
+		if (half.components.m != 0) { /* subnormal */
+			/* find the leading 1 to nomalize */
+			uint64_t leading_shift = (uint64_t)(M_BIT_HALF -
+					find_last_set_bit(half.components.m) + 1);
+			d.components.m <<= leading_shift;
+			d.components.e =
+				(BIAS_DOUBLE - BIAS_HALF - leading_shift + 1)
+				& E_MASK_DOUBLE;
+		}
+	} else { /* normal */
+		d.components.e = (uint32_t)(BIAS_DOUBLE + (half.components.e
+					- BIAS_HALF)) & 0x7FFu/*11-bit*/;
+	}
+
+	d.components.m <<= M_BIT_DOUBLE - M_BIT_HALF;
+
+	return d.value;
+}
+
+bool ieee754_is_shrinkable_to_half(float value)
+{
+	ieee754_single_t single = { .value = value };
+
+	if (single.components.e == 0) {
+		if (single.components.m == 0) { /* zero */
+			return true;
+		}
+		/* subnormal */
+		if (!is_precision_lost(single.components.m,
+					M_BIT_SINGLE, M_BIT_HALF)) {
+			return true;
+		}
+	} else if (single.components.e == E_MASK_SINGLE) { /* NaN or infinity */
+		return true;
+	} else if (is_in_range(single.components.e, BIAS_SINGLE, BIAS_HALF) &&
+			!is_precision_lost(single.components.m, M_BIT_SINGLE,
+				M_BIT_HALF)) {
+		return true;
+	} else if (is_in_subrange(single.components.e, M_BIT_HALF,
+				BIAS_SINGLE, BIAS_HALF)) {
+		return true;
+	}
+
+	return false;
+}
+
+bool ieee754_is_shrinkable_to_single(double value)
+{
+	ieee754_double_t d = { .value = value };
+
+	if (d.components.e == 0) {
+		if (d.components.m == 0) { /* zero */
+			return true;
+		}
+		/* subnormal */
+		if (!is_precision_lost(d.components.m,
+					M_BIT_DOUBLE, M_BIT_SINGLE)) {
+			return true;
+		}
+	} else if (d.components.e == E_MASK_DOUBLE) { /* NaN or infinity */
+		return true;
+	} else if (is_in_range(d.components.e, BIAS_DOUBLE, BIAS_SINGLE) &&
+			!is_precision_lost(d.components.m, M_BIT_DOUBLE,
+				M_BIT_SINGLE)) {
+		return true;
+	} else if (is_in_subrange(d.components.e, M_BIT_SINGLE,
+				BIAS_DOUBLE, BIAS_SINGLE)) {
+		return true;
+	}
+
+	return false;
+}
diff --git a/lib/cbor/parser.c b/lib/cbor/parser.c
new file mode 100644
index 000000000000..c997834f7c48
--- /dev/null
+++ b/lib/cbor/parser.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: MIT
+/*
+ * SPDX-FileCopyrightText: 2021 Kyunghwan Kwon <k@mononn.com>
+ */
+
+#include <linux/cbor/parser.h>
+#include <linux/module.h>
+
+#if !defined(assert)
+#define assert(expr)
+#endif
+
+struct parser_context {
+	cbor_reader_t *reader;
+
+	uint8_t major_type;
+	uint8_t additional_info;
+	uint8_t following_bytes;
+
+	uint8_t recursion_depth;
+
+	_Static_assert(CBOR_RECURSION_MAX_LEVEL < 256, "");
+};
+
+typedef cbor_error_t (*type_parser_t)(struct parser_context *ctx);
+
+static cbor_error_t do_integer(struct parser_context *ctx);
+static cbor_error_t do_string(struct parser_context *ctx);
+static cbor_error_t do_recursive(struct parser_context *ctx);
+static cbor_error_t do_tag(struct parser_context *ctx);
+static cbor_error_t do_float_and_other(struct parser_context *ctx);
+
+/* 8 parsers for 3-bit major type */
+static const type_parser_t parsers[] = {
+	do_integer,		/* 0: unsigned integer */
+	do_integer,		/* 1: negative integer */
+	do_string,		/* 2: byte string */
+	do_string,		/* 3: text string encoded as utf-8 */
+	do_recursive,		/* 4: array */
+	do_recursive,		/* 5: map */
+	do_tag,			/* 6: tag */
+	do_float_and_other,	/* 7: float, simple value, and break */
+};
+
+static bool has_valid_following_bytes(const struct parser_context *ctx,
+		cbor_error_t *err)
+{
+	*err = CBOR_SUCCESS;
+
+	if (ctx->following_bytes == (uint8_t)CBOR_RESERVED_VALUE) {
+		*err = CBOR_ILLEGAL;
+		return false;
+	} else if (ctx->following_bytes == (uint8_t)CBOR_INDEFINITE_VALUE) {
+		return true;
+	}
+
+	if ((ctx->following_bytes + 1u)
+			> ctx->reader->msgsize - ctx->reader->msgidx) {
+		*err = CBOR_ILLEGAL;
+		return false;
+	}
+
+	return true;
+}
+
+static size_t go_get_item_length(struct parser_context *ctx)
+{
+	uint64_t len = 0;
+	size_t offset = 0;
+
+	if (ctx->following_bytes == (uint8_t)CBOR_INDEFINITE_VALUE) {
+		len = (uint64_t)CBOR_INDEFINITE_VALUE;
+	} else if (ctx->following_bytes == 0) {
+		len = ctx->additional_info;
+	} else {
+		const uint8_t *msg = &ctx->reader->msg[ctx->reader->msgidx];
+
+		cbor_copy((uint8_t *)&len, &msg[1], ctx->following_bytes);
+		offset = ctx->following_bytes;
+	}
+
+	ctx->reader->msgidx += offset + 1;
+
+	return (size_t)len;
+}
+
+static cbor_error_t parse(struct parser_context *ctx, size_t maxitems)
+{
+	cbor_error_t err = CBOR_SUCCESS;
+
+	if (++ctx->recursion_depth > CBOR_RECURSION_MAX_LEVEL)
+		return CBOR_EXCESSIVE;
+
+	for (size_t i = 0; i < maxitems &&
+			ctx->reader->itemidx < ctx->reader->maxitems &&
+			ctx->reader->msgidx < ctx->reader->msgsize; i++) {
+		uint8_t val = ctx->reader->msg[ctx->reader->msgidx];
+
+		ctx->major_type = get_cbor_major_type(val);
+		ctx->additional_info = get_cbor_additional_info(val);
+		ctx->following_bytes =
+			cbor_get_following_bytes(ctx->additional_info);
+
+		if (!has_valid_following_bytes(ctx, &err))
+			break;
+
+		err = parsers[ctx->major_type](ctx);
+
+		if (err == CBOR_BREAK) {
+			if ((maxitems == (size_t)CBOR_INDEFINITE_VALUE) ||
+					(ctx->reader->msgidx ==
+						ctx->reader->msgsize)) {
+				break;
+			}
+		} else if (err != CBOR_SUCCESS) {
+			break;
+		}
+
+		err = CBOR_SUCCESS;
+	}
+
+	ctx->recursion_depth--;
+
+	assert(ctx->msgidx <= ctx->msgsize);
+
+	return err;
+}
+
+static cbor_error_t do_integer(struct parser_context *ctx)
+{
+	if (ctx->following_bytes == (uint8_t)CBOR_INDEFINITE_VALUE)
+		return CBOR_ILLEGAL;
+
+	cbor_item_t *item = &ctx->reader->items[ctx->reader->itemidx];
+
+	item->type = CBOR_ITEM_INTEGER;
+	item->size = (size_t)ctx->following_bytes;
+	item->offset = ctx->reader->msgidx;
+
+	ctx->reader->msgidx += (size_t)(ctx->following_bytes + 1);
+	ctx->reader->itemidx++;
+
+	return CBOR_SUCCESS;
+}
+
+static cbor_error_t do_string(struct parser_context *ctx)
+{
+	cbor_item_t *item = &ctx->reader->items[ctx->reader->itemidx];
+	size_t len = go_get_item_length(ctx);
+
+	item->type = CBOR_ITEM_STRING;
+	item->size = len;
+	item->offset = ctx->reader->msgidx;
+
+	if (len == (size_t)CBOR_INDEFINITE_VALUE) {
+		ctx->reader->itemidx++;
+		return parse(ctx, ctx->reader->maxitems - ctx->reader->itemidx);
+	}
+	if (len > ctx->reader->msgsize - ctx->reader->msgidx)
+		return CBOR_ILLEGAL;
+
+	ctx->reader->msgidx += len;
+	ctx->reader->itemidx++;
+
+	return CBOR_SUCCESS;
+}
+
+static cbor_error_t do_recursive(struct parser_context *ctx)
+{
+	size_t current_item_index = ctx->reader->itemidx;
+	cbor_item_t *item = &ctx->reader->items[current_item_index];
+	size_t len = go_get_item_length(ctx);
+
+	item->type = (cbor_item_data_t)(ctx->major_type - 1);
+	item->offset = ctx->reader->msgidx;
+	item->size = len;
+	if (len != (size_t)CBOR_INDEFINITE_VALUE &&
+			len > ctx->reader->msgsize - ctx->reader->msgidx) {
+		return CBOR_ILLEGAL;
+	}
+
+	ctx->reader->itemidx++;
+
+	return parse(ctx, len);
+}
+
+/* TODO: Implement tag */
+static cbor_error_t do_tag(struct parser_context *ctx)
+{
+	(void)ctx;
+	return CBOR_INVALID;
+}
+
+static cbor_error_t do_float_and_other(struct parser_context *ctx)
+{
+	cbor_item_t *item = &ctx->reader->items[ctx->reader->itemidx];
+	cbor_error_t err = CBOR_SUCCESS;
+
+	item->type = CBOR_ITEM_FLOAT;
+	item->size = (size_t)ctx->following_bytes;
+	item->offset = ctx->reader->msgidx;
+
+	if (ctx->following_bytes == (uint8_t)CBOR_INDEFINITE_VALUE) {
+		ctx->reader->msgidx++;
+		ctx->reader->itemidx++;
+		return CBOR_BREAK;
+	} else if (!has_valid_following_bytes(ctx, &err)) {
+		return err;
+	} else if (ctx->following_bytes <= 1) {
+		item->type = CBOR_ITEM_SIMPLE_VALUE;
+	}
+
+	ctx->reader->msgidx += item->size + 1;
+	ctx->reader->itemidx++;
+
+	return err;
+}
+
+cbor_error_t cbor_parse(cbor_reader_t *reader, void const *msg, size_t msgsize,
+		size_t *nitems_parsed)
+{
+	assert(reader->items != NULL);
+	reader->itemidx = 0;
+
+	reader->msg = (uint8_t const *)msg;
+	reader->msgsize = msgsize;
+	reader->msgidx = 0;
+
+	struct parser_context ctx = {
+		.reader = reader,
+	};
+
+	cbor_error_t err = parse(&ctx, reader->maxitems);
+
+	if (err == CBOR_SUCCESS && reader->msgidx < reader->msgsize)
+		err = CBOR_OVERRUN;
+
+	if (nitems_parsed != NULL)
+		*nitems_parsed = reader->itemidx;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(cbor_parse);
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



