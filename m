Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3747D73A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjJYS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJYS4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:56:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83969138
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:47 -0700 (PDT)
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 61E2A420BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698260206;
        bh=72yTSynUrDUHeNGfbDrBCEgB1J8riTYEUtHwwC8rPyQ=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        b=If+kDKHeuT2EMsw92xqfmlqXDH3ramsZx0OPNFo05CzPW6IzPJXEgCM9sqx28lSet
         iO/k+Ed6G8bYm24NN9bCSmPCKB90vXyjsUewYsZET2bIfnPL1C7dyKPUCYh/qsOJQI
         SGqWhbY6wiSTH8A0JeQ0L7yK7xsDlFLCuJ3+eHTVkOpZI2bLp5Qwi6noWjYlZw7Uic
         X0T3HlHZmN4ds6obzGV0kVkXRaof/mnXeUiIpbm9JeywgNEtvcJE4BvzvifW9KWRSK
         qHwddJUubiP4KK9FC+GAN/g7v7bphg8b2xhrKXwYj5MQ2oXbwH/qarlI00hMv04Xhb
         ux4UWtt4U7GLA==
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66d20c7dad2so1017936d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260204; x=1698865004;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72yTSynUrDUHeNGfbDrBCEgB1J8riTYEUtHwwC8rPyQ=;
        b=wrapd+jnfZKCRdTl2sqDkJwPcugm1O5MkATKogwI5ZEZMniVO6LkDqFHUmsxLTkpPU
         KWzGo2OTrgBGGPnbCArwKyvI12JlVt92arjrJRgQk3omm+X5oqk9tuBxcJKbA+s1iA8C
         x9Ototwq1mfC5afFV6enPZThH7NAD95JxqfXU5PtteBLY/c/v6ou4dgm89SQYTt2cRGn
         5At4XwQwp4IgefUmXrMYhOtC8p96Is+zJbRu0XNb9G36DhHXYl16Nb4HeHncGjZqzJeQ
         +MMN7G0CccoxkJmKBE+R8YHLd+uGhbbTKPUay6piu2ZHZJco4ZKHLcC4Dji19LZNRf1L
         sUfw==
X-Gm-Message-State: AOJu0YwqadESz7IRG0cMNGIkA165TJhQ7OCqkINzdOd0n9ZQIXAfmPu+
        nDb1EPQMjtmBupudJhexLZzypibU+4PofvXeDCSceATKaYlqSCBZ134XaC4fVy4VNXOusS9V1aw
        3C2ffyf8refmE1bq9dWrsg0Qq3cMrTC2RC8KxjyB+sX8q5fUfLzV+NaWqDgy/EKmSMw==
X-Received: by 2002:a05:6214:500a:b0:66d:1ff3:31ed with SMTP id jo10-20020a056214500a00b0066d1ff331edmr18230017qvb.52.1698260204377;
        Wed, 25 Oct 2023 11:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqrp3yXMtVysnlSo/32Nx/YVY6NylQz5OO3JSRKcqHPaoXNSn7AoCmimrkLCz7k8X5K09lEujMXAozvhm6Dhg=
MIME-Version: 1.0
X-Received: by 2002:a05:6214:500a:b0:66d:1ff3:31ed with SMTP id
 jo10-20020a056214500a00b0066d1ff331edmr18230005qvb.52.1698260204165; Wed, 25
 Oct 2023 11:56:44 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Oct 2023 11:56:43 -0700
From:   emil.renner.berthing@canonical.com
Date:   Wed, 25 Oct 2023 11:56:43 -0700
Message-ID: <CAJM55Z8XPo=NfzGcu0UVOb2pwGhkuL6nx+Mae7eLy4EDN0=cAw@mail.gmail.com>
Subject: [PATCH 4/4] soc: sifive: ccache: Support cache management operations
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cache controller also supports flushing cache lines by writing
their address to a register. This can be used for cache management on
SoCs with non-coherent DMAs that predate the RISC-V Zicbom extension
such as the StarFive JH7100 SoC.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/soc/sifive/sifive_ccache.c | 45 +++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c
b/drivers/soc/sifive/sifive_ccache.c
index 676468c35859..9bf94c22cad9 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -8,13 +8,16 @@

 #define pr_fmt(fmt) "CCACHE: " fmt

+#include <linux/align.h>
 #include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/device.h>
 #include <linux/bitfield.h>
+#include <asm/cacheflush.h>
 #include <asm/cacheinfo.h>
+#include <asm/dma-noncoherent.h>
 #include <soc/sifive/sifive_ccache.h>

 #define SIFIVE_CCACHE_DIRECCFIX_LOW 0x100
@@ -39,10 +42,14 @@
 #define SIFIVE_CCACHE_CONFIG_SETS_MASK GENMASK_ULL(23, 16)
 #define SIFIVE_CCACHE_CONFIG_BLKS_MASK GENMASK_ULL(31, 24)

+#define SIFIVE_CCACHE_FLUSH64 0x200
+#define SIFIVE_CCACHE_FLUSH32 0x240
+
 #define SIFIVE_CCACHE_WAYENABLE 0x08
 #define SIFIVE_CCACHE_ECCINJECTERR 0x40

 #define SIFIVE_CCACHE_MAX_ECCINTR 4
+#define SIFIVE_CCACHE_LINE_SIZE 64

 static void __iomem *ccache_base;
 static int g_irq[SIFIVE_CCACHE_MAX_ECCINTR];
@@ -125,6 +132,34 @@ int
unregister_sifive_ccache_error_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_sifive_ccache_error_notifier);

+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+static void ccache_flush_range(phys_addr_t start, size_t len)
+{
+	phys_addr_t end = start + len;
+	phys_addr_t line;
+
+	if (!len)
+		return;
+
+	mb();
+	for (line = ALIGN_DOWN(start, SIFIVE_CCACHE_LINE_SIZE); line < end;
+			line += SIFIVE_CCACHE_LINE_SIZE) {
+#ifdef CONFIG_32BIT
+		writel(line >> 4, ccache_base + SIFIVE_CCACHE_FLUSH32);
+#else
+		writeq(line, ccache_base + SIFIVE_CCACHE_FLUSH64);
+#endif
+		mb();
+	}
+}
+
+static const struct riscv_nonstd_cache_ops ccache_mgmt_ops __initdata = {
+	.wback = &ccache_flush_range,
+	.inv = &ccache_flush_range,
+	.wback_inv = &ccache_flush_range,
+};
+#endif /* CONFIG_RISCV_NONSTANDARD_CACHE_OPS */
+
 static int ccache_largest_wayenabled(void)
 {
 	return readl(ccache_base + SIFIVE_CCACHE_WAYENABLE) & 0xFF;
@@ -258,6 +293,14 @@ static int __init sifive_ccache_init(void)
 	}
 	of_node_put(np);

+#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
+	if (of_property_read_bool(np, "sifive,cache-ops")) {
+		riscv_cbom_block_size = SIFIVE_CCACHE_LINE_SIZE;
+		riscv_noncoherent_supported();
+		riscv_noncoherent_register_cache_ops(&ccache_mgmt_ops);
+	}
+#endif
+
 	ccache_config_read();

 	ccache_cache_ops.get_priv_group = ccache_get_priv_group;
@@ -278,4 +321,4 @@ static int __init sifive_ccache_init(void)
 	return rc;
 }

-device_initcall(sifive_ccache_init);
+arch_initcall(sifive_ccache_init);
-- 
2.40.1
