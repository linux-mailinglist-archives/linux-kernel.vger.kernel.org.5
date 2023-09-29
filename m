Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E48B7B3B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjI2Uqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjI2Uq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:46:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8991706
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:46:12 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf3f59905so1955172666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1696020371; x=1696625171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAV11pr0FuTWro/Eu3mGKqA2HN52biLtrB5f4YzdMgg=;
        b=D3iXwv3w+2L9obmire2V3YackUOqnhydAfzMfc/a5AB7YlpHs1oi4D46DxTBbCz8fb
         BHTjpdJBfCR30KGdr/fh5pTc2SKWIGdeUiD1fiqgedy23Apc6BwH2RKj9BE7eougSP6b
         lFA9qkEQLp7oyzkooUdJHs/1+VjHBxqq+raWNs6raDq2PFKQqRxysWEbaa94L5CTGbsI
         7G5dM/Z2QxTs8u4FaqUbbWNWN4zUywqoKPinot7UYPXEWkkzaunvcz7QjjHTLWTBSgN2
         Oc1PmhN85eYpABqP8+BoCxrBl4JuSmeOykZvDml0Sl3qtoIS2lIsqbS81x2aP+KV3ytV
         e75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696020371; x=1696625171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAV11pr0FuTWro/Eu3mGKqA2HN52biLtrB5f4YzdMgg=;
        b=hw1t78oCEWwpuinUxHq0vtounZOiIgGk6yip0OeQEi7jYhpfAaG7d1R/DcqQgRt1D5
         lkG23X7p5k3ymJC44l6TO0ErtAnSNmsLNOWfv7G5fkod9I2+rkuzMqskaBO+txogcgBT
         +nzInjFLv0S4mNHIGjp9LWVKw9kfFYttTfoEzUx19AxWdvpY4amSgZRrkULWVwjjJMAB
         tXTvNxx89paD74Q0Heap/hqknIW3TG6+KP8i2wBLXt8gQe0wGKoNuiugVDo/8SpdA5tz
         zVfRIDNCTxZsueS6xnjbXslKABg8J/Akl8AhceMHoInwRhWRyphbnJLHultH8jeK6IRV
         0Wbg==
X-Gm-Message-State: AOJu0YxD1WcaWkdShCDaNPAoWEOcQAxdUCpIXEvaOo5ht6wjOhYom2bw
        nWeJLS7ProWTB6FO6PUDVPbNlw==
X-Google-Smtp-Source: AGHT+IHddVCMf+n0g1If6ZthNNUAYbTRnlAKbt0CGe+MASvKtulcrRNaXqAJY+2ZyBIhuY4ToD7RJg==
X-Received: by 2002:a17:907:b609:b0:9ae:5f51:2e4a with SMTP id vl9-20020a170907b60900b009ae5f512e4amr5122349ejc.36.1696020370735;
        Fri, 29 Sep 2023 13:46:10 -0700 (PDT)
Received: from cloudflare.com (79.184.153.47.ipv4.supernova.orange.pl. [79.184.153.47])
        by smtp.gmail.com with ESMTPSA id lf11-20020a170907174b00b009ad81554c1bsm12898558ejc.55.2023.09.29.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:46:10 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH 1/2] virtio-mmio: Parse a range of IRQ numbers passed on the command line
Date:   Fri, 29 Sep 2023 22:46:03 +0200
Message-ID: <20230929-jakub-os-90-trim-v1-1-a3af0c08f812@cloudflare.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com>
References: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio-mmio devices in theory can use multiple interrupts. However, the
existing virtio-mmio command line configuration format does not provide a
way to express it.

Extend the configuration format so that the user can specify an IRQ
range. This prepares ground for registering multiple IRQs per device.

Because we need to stay backward compatible with VMMs which don't yet use
the new format, fall back to the old one if we fail to find an IRQ range in
the passed parameters.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/virtio/virtio_mmio.c | 77 ++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 97760f611295..06a587b23542 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -39,11 +39,12 @@
  * 3. Kernel module (or command line) parameter. Can be used more than once -
  *    one device will be created for each one. Syntax:
  *
- *		[virtio_mmio.]device=<size>@<baseaddr>:<irq>[:<id>]
+ *		[virtio_mmio.]device=<size>@<baseaddr>:<irq>[-<irq last>][:<id>]
  *    where:
  *		<size>     := size (can use standard suffixes like K, M or G)
  *		<baseaddr> := physical base address
- *		<irq>      := interrupt number (as passed to request_irq())
+ *		<irq>      := first interrupt number (as passed to request_irq())
+ *		<irq last> := (optional) last interrupt number
  *		<id>       := (optional) platform device id
  *    eg.:
  *		virtio_mmio.device=0x100@0x100b0000:48 \
@@ -712,36 +713,38 @@ static int vm_cmdline_set(const char *device,
 		const struct kernel_param *kp)
 {
 	int err;
-	struct resource resources[2] = {};
 	char *str;
 	long long base, size;
-	unsigned int irq;
+	unsigned int irq, irq_last;
 	int processed, consumed = 0;
 	struct platform_device *pdev;
+	struct resource *resources, *res;
+	size_t num_resources;
 
 	/* Consume "size" part of the command line parameter */
 	size = memparse(device, &str);
 
-	/* Get "@<base>:<irq>[:<id>]" chunks */
-	processed = sscanf(str, "@%lli:%u%n:%d%n",
-			&base, &irq, &consumed,
-			&vm_cmdline_id, &consumed);
+	/* Get "@<base>:<irq>-<irq last>[:<id>]" chunks */
+	processed = sscanf(str, "@%lli:%u-%u%n:%d%n",
+			   &base, &irq, &irq_last, &consumed,
+			   &vm_cmdline_id, &consumed);
+	/* Fall back to "@<base>:<irq>[:<id>]" */
+	if (processed < 3) {
+		processed = sscanf(str, "@%lli:%u%n:%d%n",
+				   &base, &irq, &consumed,
+				   &vm_cmdline_id, &consumed);
+		irq_last = irq;
+	}
 
 	/*
 	 * sscanf() must process at least 2 chunks; also there
 	 * must be no extra characters after the last chunk, so
 	 * str[consumed] must be '\0'
 	 */
-	if (processed < 2 || str[consumed] || irq == 0)
+	if (processed < 2 || str[consumed] ||
+	    irq == 0 || irq_last == 0 || irq > irq_last)
 		return -EINVAL;
 
-	resources[0].flags = IORESOURCE_MEM;
-	resources[0].start = base;
-	resources[0].end = base + size - 1;
-
-	resources[1].flags = IORESOURCE_IRQ;
-	resources[1].start = resources[1].end = irq;
-
 	if (!vm_cmdline_parent_registered) {
 		err = device_register(&vm_cmdline_parent);
 		if (err) {
@@ -752,16 +755,34 @@ static int vm_cmdline_set(const char *device,
 		vm_cmdline_parent_registered = 1;
 	}
 
-	pr_info("Registering device virtio-mmio.%d at 0x%llx-0x%llx, IRQ %d.\n",
-		       vm_cmdline_id,
-		       (unsigned long long)resources[0].start,
-		       (unsigned long long)resources[0].end,
-		       (int)resources[1].start);
+	num_resources = 1; /* mem */
+	num_resources += irq_last - irq + 1;
+	resources = devm_kcalloc(&vm_cmdline_parent, num_resources,
+				 sizeof(*resources), GFP_KERNEL);
+	if (!resources)
+		return -ENOMEM;
+
+	resources[0].flags = IORESOURCE_MEM;
+	resources[0].start = base;
+	resources[0].end = base + size - 1;
+
+	for (res = &resources[1]; irq <= irq_last; irq++, res++) {
+		res->flags = IORESOURCE_IRQ;
+		res->start = irq;
+		res->end = irq;
+	}
+
+	pr_info("Registering device virtio-mmio.%d at 0x%llx-0x%llx, IRQs %u-%u.\n",
+		vm_cmdline_id,
+		(unsigned long long)resources[0].start,
+		(unsigned long long)resources[0].end,
+		irq, irq_last);
 
 	pdev = platform_device_register_resndata(&vm_cmdline_parent,
 			"virtio-mmio", vm_cmdline_id++,
-			resources, ARRAY_SIZE(resources), NULL, 0);
+			resources, num_resources, NULL, 0);
 
+	devm_kfree(&vm_cmdline_parent, resources);
 	return PTR_ERR_OR_ZERO(pdev);
 }
 
@@ -770,12 +791,18 @@ static int vm_cmdline_get_device(struct device *dev, void *data)
 	char *buffer = data;
 	unsigned int len = strlen(buffer);
 	struct platform_device *pdev = to_platform_device(dev);
+	size_t nres = pdev->num_resources;
+	bool irq_range = nres > 2;
 
-	snprintf(buffer + len, PAGE_SIZE - len, "0x%llx@0x%llx:%llu:%d\n",
+	len += snprintf(buffer + len, PAGE_SIZE - len, "0x%llx@0x%llx:%llu",
 			pdev->resource[0].end - pdev->resource[0].start + 1ULL,
 			(unsigned long long)pdev->resource[0].start,
-			(unsigned long long)pdev->resource[1].start,
-			pdev->id);
+			(unsigned long long)pdev->resource[1].start);
+	if (irq_range)
+		len += snprintf(buffer + len, PAGE_SIZE - len, "-%llu",
+				(unsigned long long)pdev->resource[nres - 1].start);
+	snprintf(buffer + len, PAGE_SIZE - len, ":%d\n", pdev->id);
+
 	return 0;
 }
 

-- 
2.41.0
