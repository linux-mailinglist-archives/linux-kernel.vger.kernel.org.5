Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806AA7B3C07
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjI2ViC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjI2Vh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:37:59 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA511B1;
        Fri, 29 Sep 2023 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1696023476; x=1727559476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FotYDl+vI+mT+GII9Dk7MzcKuFcIyX+NWSaWuyboYkU=;
  b=sDSEX9jtRn1KN2t8AKLGfBrswWGB1XGAfv/8ytUqO90vGFfr85G1nuI4
   eP3VIBPA7iJLuDvx67GTPNs/iLktksJKIdwd9JKHn85TgwNoJb6oWrpvR
   vU6NGkw6Fg0Hkr5p0I3ph3+v+KChkPxgSzSirq/z5CJUcX7wQhk0BozJo
   M=;
X-IronPort-AV: E=Sophos;i="6.03,188,1694736000"; 
   d="scan'208";a="242458505"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 21:37:54 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 7FF5D80FC1;
        Fri, 29 Sep 2023 21:37:53 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 21:37:47 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 29 Sep 2023 21:37:45 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-crypto@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Olivia Mackall <olivia@selenic.com>,
        "Petre Eftime" <petre.eftime@gmail.com>,
        Erdem Meydanlli <meydanli@amazon.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v3 2/2] hwrng: Add support for Nitro Secure Module
Date:   Fri, 29 Sep 2023 21:37:39 +0000
Message-ID: <20230929213739.68494-3-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929213739.68494-1-graf@amazon.com>
References: <20230929213739.68494-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running Linux inside a Nitro Enclave, the Nitro Secure Module
provides a virtio message that can be used to receive entropy. This
patch adds support to read that entropy on demand and expose it through
the hwrng device.

Originally-by: Petre Eftime <petre.eftime@gmail.com>
Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - Remove boilerplate

v2 -> v3:

  - Ensure remove only happens on target device
---
 MAINTAINERS                      |   1 +
 drivers/char/hw_random/Kconfig   |  12 ++
 drivers/char/hw_random/Makefile  |   1 +
 drivers/char/hw_random/nsm-rng.c | 275 +++++++++++++++++++++++++++++++
 4 files changed, 289 insertions(+)
 create mode 100644 drivers/char/hw_random/nsm-rng.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d54bf3ea2b9d..da9697639968 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15104,6 +15104,7 @@ L:	linux-kernel@vger.kernel.org
 L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
 S:	Supported
 W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
+F:	drivers/char/hw_random/nsm-rng.c
 F:	drivers/misc/nsm.c
 F:	include/linux/nsm.h
 F:	include/uapi/linux/nsm.h
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 8de74dcfa18c..5d06e24cfdde 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -573,6 +573,18 @@ config HW_RANDOM_JH7110
 	  To compile this driver as a module, choose M here.
 	  The module will be called jh7110-trng.
 
+config HW_RANDOM_NSM
+	tristate "Nitro (Enclaves) Security Module support"
+	depends on NSM
+	help
+	  This driver provides support for the Nitro Security Module
+	  in AWS EC2 Nitro based Enclaves. The driver enables support
+	  for reading RNG data as well as a generic communication
+	  mechanism with the hypervisor.
+
+	  To compile this driver as a module, choose M here.
+	  The module will be called nsm_rng.
+
 endif # HW_RANDOM
 
 config UML_RANDOM
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 32549a1186dc..7e33d1ed40f8 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -49,3 +49,4 @@ obj-$(CONFIG_HW_RANDOM_ARM_SMCCC_TRNG) += arm_smccc_trng.o
 obj-$(CONFIG_HW_RANDOM_CN10K) += cn10k-rng.o
 obj-$(CONFIG_HW_RANDOM_POLARFIRE_SOC) += mpfs-rng.o
 obj-$(CONFIG_HW_RANDOM_JH7110) += jh7110-trng.o
+obj-$(CONFIG_HW_RANDOM_NSM) += nsm-rng.o
diff --git a/drivers/char/hw_random/nsm-rng.c b/drivers/char/hw_random/nsm-rng.c
new file mode 100644
index 000000000000..556535ef87fe
--- /dev/null
+++ b/drivers/char/hw_random/nsm-rng.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Amazon Nitro Secure Module HWRNG driver.
+ *
+ * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <linux/nsm.h>
+#include <linux/hw_random.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/virtio_ids.h>
+
+struct nsm_rng_info {
+	struct hwrng hwrng;
+	struct virtio_device *vdev;
+};
+
+#define CBOR_TYPE_MASK  0xE0
+#define CBOR_TYPE_MAP 0xA0
+#define CBOR_TYPE_TEXT 0x60
+#define CBOR_TYPE_ARRAY 0x40
+#define CBOR_HEADER_SIZE_SHORT 1
+
+#define CBOR_SHORT_SIZE_MAX_VALUE 23
+#define CBOR_LONG_SIZE_U8  24
+#define CBOR_LONG_SIZE_U16 25
+#define CBOR_LONG_SIZE_U32 26
+#define CBOR_LONG_SIZE_U64 27
+
+#define CBOR_HEADER_SIZE_U8  (CBOR_HEADER_SIZE_SHORT + sizeof(u8))
+#define CBOR_HEADER_SIZE_U16 (CBOR_HEADER_SIZE_SHORT + sizeof(u16))
+#define CBOR_HEADER_SIZE_U32 (CBOR_HEADER_SIZE_SHORT + sizeof(u32))
+#define CBOR_HEADER_SIZE_U64 (CBOR_HEADER_SIZE_SHORT + sizeof(u64))
+
+static bool cbor_object_is_array(const u8 *cbor_object, size_t cbor_object_size)
+{
+	if (cbor_object_size == 0 || cbor_object == NULL)
+		return false;
+
+	return (cbor_object[0] & CBOR_TYPE_MASK) == CBOR_TYPE_ARRAY;
+}
+
+static int cbor_object_get_array(u8 *cbor_object, size_t cbor_object_size, u8 **cbor_array)
+{
+	u8 cbor_short_size;
+	u64 array_len;
+	u64 array_offset;
+
+	if (!cbor_object_is_array(cbor_object, cbor_object_size))
+		return -EFAULT;
+
+	if (cbor_array == NULL)
+		return -EFAULT;
+
+	cbor_short_size = (cbor_object[0] & 0x1F);
+
+	/* Decoding byte array length */
+	/* In short field encoding, the object header is 1 byte long and
+	 * contains the type on the 3 MSB and the length on the LSB.
+	 * If the length in the LSB is larger than 23, then the object
+	 * uses long field encoding, and will contain the length over the
+	 * next bytes in the object, depending on the value:
+	 * 24 is u8, 25 is u16, 26 is u32 and 27 is u64.
+	 */
+	if (cbor_short_size <= CBOR_SHORT_SIZE_MAX_VALUE) {
+		/* short encoding */
+		array_len = cbor_short_size;
+		array_offset = CBOR_HEADER_SIZE_SHORT;
+	} else if (cbor_short_size == CBOR_LONG_SIZE_U8) {
+		if (cbor_object_size < CBOR_HEADER_SIZE_U8)
+			return -EFAULT;
+		/* 1 byte */
+		array_len = cbor_object[1];
+		array_offset = CBOR_HEADER_SIZE_U8;
+	} else if (cbor_short_size == CBOR_LONG_SIZE_U16) {
+		if (cbor_object_size < CBOR_HEADER_SIZE_U16)
+			return -EFAULT;
+		/* 2 bytes */
+		array_len = cbor_object[1] << 8 | cbor_object[2];
+		array_offset = CBOR_HEADER_SIZE_U16;
+	} else if (cbor_short_size == CBOR_LONG_SIZE_U32) {
+		if (cbor_object_size < CBOR_HEADER_SIZE_U32)
+			return -EFAULT;
+		/* 4 bytes */
+		array_len = cbor_object[1] << 24 |
+			cbor_object[2] << 16 |
+			cbor_object[3] << 8  |
+			cbor_object[4];
+		array_offset = CBOR_HEADER_SIZE_U32;
+	} else if (cbor_short_size == CBOR_LONG_SIZE_U64) {
+		if (cbor_object_size < CBOR_HEADER_SIZE_U64)
+			return -EFAULT;
+		/* 8 bytes */
+		array_len = (u64) cbor_object[1] << 56 |
+			  (u64) cbor_object[2] << 48 |
+			  (u64) cbor_object[3] << 40 |
+			  (u64) cbor_object[4] << 32 |
+			  (u64) cbor_object[5] << 24 |
+			  (u64) cbor_object[6] << 16 |
+			  (u64) cbor_object[7] << 8  |
+			  (u64) cbor_object[8];
+		array_offset = CBOR_HEADER_SIZE_U64;
+	}
+
+	if (cbor_object_size < array_offset)
+		return -EFAULT;
+
+	if (cbor_object_size - array_offset < array_len)
+		return -EFAULT;
+
+	if (array_len > INT_MAX)
+		return -EFAULT;
+
+	*cbor_array = cbor_object + array_offset;
+	return array_len;
+}
+
+static int nsm_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	struct nsm_rng_info *nsm_rng_info = (struct nsm_rng_info *)rng;
+	struct nsm_kernel_message message = {};
+	int rc = 0;
+	u8 *resp_ptr = NULL;
+	u64 resp_len = 0;
+	u8 *rand_data = NULL;
+	/*
+	 * 69                          # text(9)
+	 *     47657452616E646F6D      # "GetRandom"
+	 */
+	const u8 request[] = { CBOR_TYPE_TEXT + strlen("GetRandom"),
+			       'G', 'e', 't', 'R', 'a', 'n', 'd', 'o', 'm' };
+	/*
+	 * A1                          # map(1)
+	 *     69                      # text(9) - Name of field
+	 *         47657452616E646F6D  # "GetRandom"
+	 * A1                          # map(1) - The field itself
+	 *     66                      # text(6)
+	 *         72616E646F6D        # "random"
+	 *	# The rest of the response should be a byte array
+	 */
+	const u8 response[] = { CBOR_TYPE_MAP + 1,
+				CBOR_TYPE_TEXT + strlen("GetRandom"),
+				'G', 'e', 't', 'R', 'a', 'n', 'd', 'o', 'm',
+				CBOR_TYPE_MAP + 1,
+				CBOR_TYPE_TEXT + strlen("random"),
+				'r', 'a', 'n', 'd', 'o', 'm' };
+
+	/* NSM always needs to wait for a response */
+	if (!wait)
+		return 0;
+
+	/* Set request message */
+	message.request.iov_len = sizeof(request);
+	message.request.iov_base = kmalloc(message.request.iov_len, GFP_KERNEL);
+	if (message.request.iov_base == NULL)
+		goto out;
+	memcpy(message.request.iov_base, request, sizeof(request));
+
+	/* Allocate space for response */
+	message.response.iov_len = NSM_RESPONSE_MAX_SIZE;
+	message.response.iov_base = kmalloc(message.response.iov_len, GFP_KERNEL);
+	if (message.response.iov_base == NULL)
+		goto out;
+
+	/* Send/receive message */
+	rc = nsm_communicate_with_device(nsm_rng_info->vdev, &message);
+	if (rc != 0)
+		goto out;
+
+	resp_ptr = (u8 *) message.response.iov_base;
+	resp_len = message.response.iov_len;
+
+	if (resp_len < sizeof(response) + 1) {
+		pr_err("NSM RNG: Received short response from NSM: Possible error message or invalid response");
+		rc = -EFAULT;
+		goto out;
+	}
+
+	if (memcmp(resp_ptr, response, sizeof(response)) != 0) {
+		pr_err("NSM RNG: Invalid response header: Possible error message or invalid response");
+		rc = -EFAULT;
+		goto out;
+	}
+
+	resp_ptr += sizeof(response);
+	resp_len -= sizeof(response);
+
+	if (!cbor_object_is_array(resp_ptr, resp_len)) {
+		/* not a byte array */
+		pr_err("NSM RNG: Invalid response type: Expecting a byte array response");
+		rc = -EFAULT;
+		goto out;
+	}
+
+	rc = cbor_object_get_array(resp_ptr, resp_len, &rand_data);
+	if (rc < 0) {
+		pr_err("NSM RNG: Invalid CBOR encoding\n");
+		goto out;
+	}
+
+	max = max > INT_MAX ? INT_MAX : max;
+	rc = rc > max ? max : rc;
+	memcpy(data, rand_data, rc);
+
+	pr_debug("NSM RNG: returning rand bytes = %d\n", rc);
+out:
+	kfree(message.request.iov_base);
+	kfree(message.response.iov_base);
+	return rc;
+}
+
+static struct nsm_rng_info nsm_rng_info = {
+	.hwrng = {
+		.read = nsm_rng_read,
+		.name = "nsm-hwrng",
+		.quality = 1000,
+	},
+};
+
+static int nsm_rng_probe(struct virtio_device *vdev)
+{
+	int rc;
+
+	if (nsm_rng_info.vdev)
+		return -EEXIST;
+
+	nsm_rng_info.vdev = vdev;
+	rc = devm_hwrng_register(&vdev->dev, &nsm_rng_info.hwrng);
+
+	if (rc) {
+		pr_err("NSM RNG initialization error: %d.\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void nsm_rng_remove(struct virtio_device *vdev)
+{
+	if (nsm_rng_info.vdev != vdev)
+		return;
+
+	hwrng_unregister(&nsm_rng_info.hwrng);
+	nsm_rng_info.vdev = NULL;
+}
+
+struct nsm_hwrng nsm_hwrng = {
+	.probe = nsm_rng_probe,
+	.remove = nsm_rng_remove,
+};
+
+static int __init nsm_rng_init(void)
+{
+	return nsm_register_hwrng(&nsm_hwrng);
+}
+
+static void __exit nsm_rng_exit(void)
+{
+	nsm_unregister_hwrng(&nsm_hwrng);
+}
+
+module_init(nsm_rng_init);
+module_exit(nsm_rng_exit);
+
+#ifdef MODULE
+static const struct virtio_device_id nsm_id_table[] = {
+	{ VIRTIO_ID_NITRO_SEC_MOD, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+#endif
+
+MODULE_DEVICE_TABLE(virtio, nsm_id_table);
+MODULE_DESCRIPTION("Virtio NSM RNG driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



