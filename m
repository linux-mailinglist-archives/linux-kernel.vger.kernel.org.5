Return-Path: <linux-kernel+bounces-11629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E920F81E937
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE3D282A81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095EC4C9B;
	Tue, 26 Dec 2023 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lg6zEGOV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593E4432
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b7fdde8b26so206711539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618522; x=1704223322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpqenrRUC6bjM3FBUQeM6IW1qxia9n9naxBupjAv3uo=;
        b=lg6zEGOVJELIYZP8LcIUqeyWpjIYPc2ZgojXQgmoqL5txatFJtk/ELRg86mTlcJrAY
         22xSDZciqMVfDmYi+JudnojpMsLhfQskc4E4qDHnRBbNHsZ4FfnMyt6NwqiXgRy3kMLF
         EoZ9/WMDZhexTgoIQzLvp6bxk7lmt0XCwdFcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618522; x=1704223322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpqenrRUC6bjM3FBUQeM6IW1qxia9n9naxBupjAv3uo=;
        b=Y453cvDYWseHD/Gn9rnbChnuQU0aANrqXjBV93FCi5MQI14Fv2hJ9IAZnpcHtMPJN0
         csVhGgfZCIi8nw6T8V6Ze8NivllfE/kweJqLRNgXowdjmakntPsZcaUZjOtqJycDWAeJ
         w/+eSyQHVuqsQDYK5tzEYmbutKPnZ9ze3Y208qbzn367WVf//f0Vk1cH1wmOoKV2irQl
         f/NYQdkoemAyJV4EDFDH91JSidaITEhooudzVTiuKHMZdGH6e7IkI/1UUvTnrfAA1QKn
         j0hla64T7mvIC+KWNGQWoOmWYv6zhOlpeJ6a+T3tw6FRZyi6ALlDUlf9uQidtboCaSw0
         3h3w==
X-Gm-Message-State: AOJu0Ywy36OLB2GKT44PNOjnfDFjisFKx8iLVESvr9qsIyjJOt7FCQvz
	rJR7bBtDTfVC8jmayilnkKuFPavf4YdNoC09TolwOtQ7hc5e
X-Google-Smtp-Source: AGHT+IEnaakr4yflxOfeuRigCCOhCiNNEjEufMoK0+OASnyXoZd6Lu/qchJ7FyR+kZgyYfKQ+nYn2w==
X-Received: by 2002:a6b:ef14:0:b0:7bb:818:9eeb with SMTP id k20-20020a6bef14000000b007bb08189eebmr401147ioh.37.1703618522186;
        Tue, 26 Dec 2023 11:22:02 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:01 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 01/24] resource: Add DEFINE_RES_*_NAMED_FLAGS macro
Date: Tue, 26 Dec 2023 12:21:05 -0700
Message-ID: <20231226122113.v3.1.I59b56ebd2f303784031c27bbb1529cf6ef71ba16@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231226192149.1830592-1-markhas@chromium.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, it would be nice to instantiate a struct resource with
custom flags. For example, creating an IRQ resource with a flag that
marks the interrupt as wake capable.

Add a set of macros to provide custom flag arguments.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v3:
-New patch

 include/linux/ioport.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index db7fe25f33700..a44e73ca058a8 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -163,28 +163,38 @@ enum {
 		.desc = IORES_DESC_NONE,				\
 	}
 
+#define DEFINE_RES_IO_NAMED_FLAGS(_start, _size, _name, _flags)		\
+	DEFINE_RES_NAMED((_start), (_size), (_name), (_flags) | IORESOURCE_IO)
 #define DEFINE_RES_IO_NAMED(_start, _size, _name)			\
-	DEFINE_RES_NAMED((_start), (_size), (_name), IORESOURCE_IO)
+	DEFINE_RES_IO_NAMED_FLAGS((_start), (_size), (_name), 0)
 #define DEFINE_RES_IO(_start, _size)					\
 	DEFINE_RES_IO_NAMED((_start), (_size), NULL)
 
+#define DEFINE_RES_MEM_NAMED_FLAGS(_start, _size, _name, _flags)	\
+	DEFINE_RES_NAMED((_start), (_size), (_name), (_flags) | IORESOURCE_MEM)
 #define DEFINE_RES_MEM_NAMED(_start, _size, _name)			\
-	DEFINE_RES_NAMED((_start), (_size), (_name), IORESOURCE_MEM)
+	DEFINE_RES_MEM_NAMED_FLAGS((_start), (_size), (_name), 0)
 #define DEFINE_RES_MEM(_start, _size)					\
 	DEFINE_RES_MEM_NAMED((_start), (_size), NULL)
 
+#define DEFINE_RES_REG_NAMED_FLAGS(_start, _size, _name, _flags)	\
+	DEFINE_RES_NAMED((_start), (_size), (_name), (_flags) | IORESOURCE_REG)
 #define DEFINE_RES_REG_NAMED(_start, _size, _name)			\
-	DEFINE_RES_NAMED((_start), (_size), (_name), IORESOURCE_REG)
+	DEFINE_RES_REG_NAMED_FLAGS((_start), (_size), (_name), 0)
 #define DEFINE_RES_REG(_start, _size)					\
 	DEFINE_RES_REG_NAMED((_start), (_size), NULL)
 
+#define DEFINE_RES_IRQ_NAMED_FLAGS(_irq, _name, _flags)			\
+	DEFINE_RES_NAMED((_irq), 1, (_name), (_flags) | IORESOURCE_IRQ)
 #define DEFINE_RES_IRQ_NAMED(_irq, _name)				\
-	DEFINE_RES_NAMED((_irq), 1, (_name), IORESOURCE_IRQ)
+	DEFINE_RES_IRQ_NAMED_FLAGS((_irq), (_name), 0)
 #define DEFINE_RES_IRQ(_irq)						\
 	DEFINE_RES_IRQ_NAMED((_irq), NULL)
 
+#define DEFINE_RES_DMA_NAMED_FLAGS(_dma, _name, _flags)			\
+	DEFINE_RES_NAMED((_dma), 1, (_name), (_flags) | IORESOURCE_DMA)
 #define DEFINE_RES_DMA_NAMED(_dma, _name)				\
-	DEFINE_RES_NAMED((_dma), 1, (_name), IORESOURCE_DMA)
+	DEFINE_RES_DMA_NAMED_FLAGS((_dma), (_name), 0)
 #define DEFINE_RES_DMA(_dma)						\
 	DEFINE_RES_DMA_NAMED((_dma), NULL)
 
-- 
2.43.0.472.g3155946c3a-goog


