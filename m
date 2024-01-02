Return-Path: <linux-kernel+bounces-14825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570378222EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B09B20C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A83168CC;
	Tue,  2 Jan 2024 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Joo2LHIv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBF1643A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7baa8da5692so421987239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229724; x=1704834524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AULYiml6H3I+b2G8tlhMxcx/1ZvVdi4KizI4u111pxQ=;
        b=Joo2LHIvGCuK3aFERRxNSEtajHNauRc0yJaLHBjfMAMzRY8w7hVez0nRhsg3zc2dlN
         5Up3Ht5heS20vtfDdGVUfDzWfCgfhs8QzZkJe6f9GOz2RddQH99u8O+exxZW46folbED
         T4xTPIQDzWuehQ0jdIS/SkAHnIMxQeG/QB46Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229724; x=1704834524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AULYiml6H3I+b2G8tlhMxcx/1ZvVdi4KizI4u111pxQ=;
        b=hPV0JlNixzp9tr7jsaCqkErLnKWM2GBwIs4JbgdaT/4RFsIU+y6S2vYTC4qssRr78W
         Y+eVM6QQIGjYwdssLn04Ad+Onejxd3zGwc6HQehBRmvcQ1OJp/JLI5WhRqk/xshoinPW
         ErJ8jBMTp2Y3eJtDORIvH/WOYG8333FnBkCIYy7HgvZ/VHn7KRPBWTwFeS8nhfS2Wgxr
         k4SqxW4EKcfWOYNHpOIyvccuQ7h5j6ru5b5Ntw3IgHB0i2QcLsWLmNn6SiFV2nzi33Fp
         2eWgTGnHKw+xNqcKhIqFkvlJ58zcPgGGvjtvSNKJhKsNFI+80iWPadHZVLd+/R7lJ7if
         N5dA==
X-Gm-Message-State: AOJu0YzcB+yrMpt6hkZsX9ikkRzTG/BkixGnWUNe5GZH8nlQJbVS9x01
	9NWxpaY+rqnVqNIZuqRDavC9W7J1IOszs4CyVQ+SXIOe7weM
X-Google-Smtp-Source: AGHT+IGQBwti5F/Jz854DmDNd9H038Pgm18QGidKZCnQxemnfJmFjyL/+xNqP1TRhwZsuOi9BMzzkQ==
X-Received: by 2002:a5e:a70b:0:b0:7b7:3d:6452 with SMTP id b11-20020a5ea70b000000b007b7003d6452mr18789276iod.5.1704229724386;
        Tue, 02 Jan 2024 13:08:44 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:08:44 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 01/24] resource: Add DEFINE_RES_*_NAMED_FLAGS macro
Date: Tue,  2 Jan 2024 14:07:25 -0700
Message-ID: <20240102140734.v4.1.I59b56ebd2f303784031c27bbb1529cf6ef71ba16@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240102210820.2604667-1-markhas@chromium.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
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

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v4:
-Update Andy's email to @linux.intel.com
-Add Reviewed-by tag

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


