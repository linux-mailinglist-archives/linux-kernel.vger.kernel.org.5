Return-Path: <linux-kernel+bounces-147739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B238A7869
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071F31F211A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826C813C3D8;
	Tue, 16 Apr 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4s07QsZ"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879E13AA3E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309037; cv=none; b=W96wmhmyEVoATcR5qKhQqdEpZ4WAZ/jFwmkfmjlp1xEsH5WZ8yY+XIDzOK6qgZxym9YUBBV500SEMN70V+too+ItZULjL4UlLukJOiQkC+RjQpxWzqyCLaPRZiFzy7CHGY20Itg6tOt4aKZZMs5B0Lm5ycSCdWrlNu1cFrYoIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309037; c=relaxed/simple;
	bh=3UPhKAV2eGB7qIhnd7A8W04iWjDSndRcXDDgqxtM4BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aczbB/HLL8G32i0Cwzd1hRR27AIN11a45ouebodd0neSy5tn3Ej6H/AWXvdU2iIyDRsaNabB1sTGDWIfmT4Ex5pQCjed2VhhcVHX9RLfgPd3vSCDU3tKNdUaNzXBmI0y3FzrSJX7DNmJO5XX8FBKdKfx2MSGdhLTRUUm2dCvVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y4s07QsZ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5de651252so230933139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713309033; x=1713913833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9FjhA/cFsDH2qqD4vdpl3ficCKrtPLZj5U8CtK/eWA=;
        b=y4s07QsZAcXO6VB9OddLFTnQgOcfUL260b6UUigirYtXF8cIN2E8G/0zhVeHsI3Ius
         NIGBy/IFWNdJbyzeqh511Hf8K7VEt46nBvNMB+38r0djVD1pUHrAt5qDq14B9GUEuewM
         AoR62OLF9I6dogsVZS0pswDGNhNfPFrZ9SS6toyY47l+T1hT/eLyE9bldXxjJItrW2Oz
         hbc3ax1JUb3Yxzoo3lAJNeVRugkjnVqVO8jnWxjkX7fDzuOmYVBn/Obo+2hE9sSS3lpI
         xM5KgGNqYGORT4tvyaQA/eH3s6uTWl5rLA+suSOB6w8adVxSG8opJq0or6hAgPc2HkT4
         hlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309033; x=1713913833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9FjhA/cFsDH2qqD4vdpl3ficCKrtPLZj5U8CtK/eWA=;
        b=p11gZSLjdvv0+BLLvhszfPWz/gRR8TmTEcZ0yRFNBbsxgUi0AU7bXgCBDcjelHEGNI
         9uEGF3oXz6GvtCavwPiLvUpKSrRXSZBwFE7s24lOcHo+9THUXhzsOCSCTZxpMIc1f7R+
         zTIEhGqQX7pUHqYJ8SWidV7uBU/iIFXBreiS4cwp3R7GQNVt2z6CfnSH7R6QxiIIVvEU
         4K7UuV4/FkrCfn58PsJPBlO1j+PPVBgT0Eii6lYjdjOZEOZ4NkcVqZ6ecsx+BG8FMUYS
         sRPfy5/F2xiFpgxggqTeFJHNWiMIIpkurMaXsBq0cCPKK/ig/h+K7sg0RCEiNtstds84
         u3ng==
X-Forwarded-Encrypted: i=1; AJvYcCWF7s2WNrrBos7xX45U8qv/DXnWzBDrLbTHJcI4m4HhwUB1+uGPal9vpQoUkv1BgSi/N8QnL4zE2pOKWK0Hq04j+xEExnXqq/1TwNZN
X-Gm-Message-State: AOJu0YxZp14P7ZpUzNDxnRI8i2CsvTJeJBsNC8w0qyivwbv9jpwQoZ9O
	UnfzkxGNNyioHKKPC3nUOGSyFwJBBztgyNF3ntEGQ2E4aCBqUvTwURzl8OL8AVw=
X-Google-Smtp-Source: AGHT+IHmpH5NluyPkr0pKUYPo6EzpBuWIpiIjHdBQk5YntL97Lk4C8wD1xRcQ9alhzvHhiLX7JmQTQ==
X-Received: by 2002:a6b:c306:0:b0:7d9:594b:70cd with SMTP id t6-20020a6bc306000000b007d9594b70cdmr9860311iof.18.1713309032661;
        Tue, 16 Apr 2024 16:10:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id le9-20020a056638960900b004846ed9fcb1sm372170jab.101.2024.04.16.16.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:10:31 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/7] net: ipa: remove unneeded standard includes
Date: Tue, 16 Apr 2024 18:10:13 -0500
Message-Id: <20240416231018.389520-3-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416231018.389520-1-elder@linaro.org>
References: <20240416231018.389520-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some IPA header files include one or more other standard header
files despite not directly needing anything defined in the included
files.  Remove these unnecessary includes.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c              | 4 +---
 drivers/net/ipa/gsi.h              | 4 +---
 drivers/net/ipa/ipa.h              | 4 +---
 drivers/net/ipa/ipa_cmd.c          | 1 -
 drivers/net/ipa/ipa_cmd.h          | 3 +--
 drivers/net/ipa/ipa_endpoint.c     | 1 -
 drivers/net/ipa/ipa_endpoint.h     | 1 -
 drivers/net/ipa/ipa_interrupt.h    | 3 +--
 drivers/net/ipa/ipa_main.c         | 4 +---
 drivers/net/ipa/ipa_mem.c          | 4 +---
 drivers/net/ipa/ipa_qmi.c          | 4 +---
 drivers/net/ipa/ipa_reg.h          | 5 +----
 drivers/net/ipa/ipa_resource.c     | 3 +--
 drivers/net/ipa/ipa_smp2p.c        | 3 +--
 drivers/net/ipa/ipa_sysfs.c        | 3 +--
 drivers/net/ipa/ipa_table.c        | 3 ---
 drivers/net/ipa/reg/ipa_reg-v5.5.c | 1 -
 17 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 9a0b1fe4a93a8..e087074cec4f7 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1,15 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2023 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
 #include <linux/types.h>
 #include <linux/bits.h>
-#include <linux/bitfield.h>
 #include <linux/mutex.h>
 #include <linux/completion.h>
-#include <linux/io.h>
 #include <linux/bug.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index 42063b227c185..3bf1a1cc972c2 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -1,16 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2023 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #ifndef _GSI_H_
 #define _GSI_H_
 
 #include <linux/types.h>
-#include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/completion.h>
-#include <linux/platform_device.h>
 #include <linux/netdevice.h>
 
 #include "ipa_version.h"
diff --git a/drivers/net/ipa/ipa.h b/drivers/net/ipa/ipa.h
index 334cd62cf2866..968175019a5e3 100644
--- a/drivers/net/ipa/ipa.h
+++ b/drivers/net/ipa/ipa.h
@@ -1,15 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #ifndef _IPA_H_
 #define _IPA_H_
 
 #include <linux/types.h>
-#include <linux/device.h>
 #include <linux/notifier.h>
-#include <linux/pm_wakeup.h>
 
 #include "ipa_version.h"
 #include "gsi.h"
diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index ae489557bf355..2e7762171e480 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -7,7 +7,6 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/device.h>
-#include <linux/slab.h>
 #include <linux/bitfield.h>
 #include <linux/dma-direction.h>
 
diff --git a/drivers/net/ipa/ipa_cmd.h b/drivers/net/ipa/ipa_cmd.h
index e2cf1c2b0ef24..86ad4cd68d1aa 100644
--- a/drivers/net/ipa/ipa_cmd.h
+++ b/drivers/net/ipa/ipa_cmd.h
@@ -1,13 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2022 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 #ifndef _IPA_CMD_H_
 #define _IPA_CMD_H_
 
 #include <linux/types.h>
-#include <linux/dma-direction.h>
 
 struct sk_buff;
 struct scatterlist;
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 0522267a7988a..4e8849c1f32d9 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -7,7 +7,6 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/device.h>
-#include <linux/slab.h>
 #include <linux/bitfield.h>
 #include <linux/if_rmnet.h>
 #include <linux/dma-direction.h>
diff --git a/drivers/net/ipa/ipa_endpoint.h b/drivers/net/ipa/ipa_endpoint.h
index 3ad2e802040aa..995f12af1623f 100644
--- a/drivers/net/ipa/ipa_endpoint.h
+++ b/drivers/net/ipa/ipa_endpoint.h
@@ -8,7 +8,6 @@
 
 #include <linux/types.h>
 #include <linux/workqueue.h>
-#include <linux/if_ether.h>
 
 #include "gsi.h"
 #include "ipa_reg.h"
diff --git a/drivers/net/ipa/ipa_interrupt.h b/drivers/net/ipa/ipa_interrupt.h
index f3f4f4330a597..7f8ea8aff7fd4 100644
--- a/drivers/net/ipa/ipa_interrupt.h
+++ b/drivers/net/ipa/ipa_interrupt.h
@@ -1,13 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #ifndef _IPA_INTERRUPT_H_
 #define _IPA_INTERRUPT_H_
 
 #include <linux/types.h>
-#include <linux/bits.h>
 
 struct ipa;
 struct ipa_interrupt;
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 57b241417e8cd..82d23eac13f52 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -1,12 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2023 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
 #include <linux/types.h>
-#include <linux/atomic.h>
-#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/io.h>
 #include <linux/firmware.h>
diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index 709f061ede617..bcf125b6439e8 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -1,12 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2023 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
 #include <linux/types.h>
-#include <linux/bitfield.h>
-#include <linux/bug.h>
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
diff --git a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
index 65c40e207802a..2873e26168fbe 100644
--- a/drivers/net/ipa/ipa_qmi.c
+++ b/drivers/net/ipa/ipa_qmi.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2013-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
 #include <linux/types.h>
 #include <linux/string.h>
-#include <linux/slab.h>
 #include <linux/qrtr.h>
-#include <linux/soc/qcom/qmi.h>
 
 #include "ipa.h"
 #include "ipa_endpoint.h"
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index 62c62495b7968..34150a893c532 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -1,14 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2023 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #ifndef _IPA_REG_H_
 #define _IPA_REG_H_
 
-#include <linux/bitfield.h>
-#include <linux/bug.h>
-
 #include "ipa_version.h"
 #include "reg.h"
 
diff --git a/drivers/net/ipa/ipa_resource.c b/drivers/net/ipa/ipa_resource.c
index 82c88a744d102..1b0c4695c32ac 100644
--- a/drivers/net/ipa/ipa_resource.c
+++ b/drivers/net/ipa/ipa_resource.c
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
 #include <linux/types.h>
-#include <linux/kernel.h>
 
 #include "ipa.h"
 #include "ipa_data.h"
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 2f917582c423e..17a61649cd4ff 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2022 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
 #include <linux/types.h>
@@ -10,7 +10,6 @@
 #include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/pm_runtime.h>
-#include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
 
 #include "ipa_smp2p.h"
diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
index 2ff09ce343b73..24f4a5ff07c14 100644
--- a/drivers/net/ipa/ipa_sysfs.c
+++ b/drivers/net/ipa/ipa_sysfs.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2021-2022 Linaro Ltd. */
+/* Copyright (C) 2021-2024 Linaro Ltd. */
 
-#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index a24ac11b8893d..f5e1d3f43b57e 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -5,10 +5,7 @@
  */
 
 #include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/bits.h>
 #include <linux/bitops.h>
-#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/build_bug.h>
 #include <linux/device.h>
diff --git a/drivers/net/ipa/reg/ipa_reg-v5.5.c b/drivers/net/ipa/reg/ipa_reg-v5.5.c
index 2436d3489cf2b..fe0b4b50c62a7 100644
--- a/drivers/net/ipa/reg/ipa_reg-v5.5.c
+++ b/drivers/net/ipa/reg/ipa_reg-v5.5.c
@@ -6,7 +6,6 @@
 #include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/bits.h>
 
 #include "../ipa_reg.h"
 #include "../ipa_version.h"
-- 
2.40.1


