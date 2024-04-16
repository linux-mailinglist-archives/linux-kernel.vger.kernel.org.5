Return-Path: <linux-kernel+bounces-147743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3084E8A7873
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537101C20D96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE8013A87E;
	Tue, 16 Apr 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfGBm894"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EA13C68A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309043; cv=none; b=Ze6yMgPHUueQpWPLHE0L2+lcCWauwlJsQHws3dmbIky5/fcOHOWfc5TA3kYMJ6HHg5h14KtDY0dh105MXqDM4brsUHinowqJjqlE0I3fn9MXym4rGAhmL7soKnXuyIWQND5QXqMG5BQWYF7tkbEf1PdNI7lkTTCLVNmN4VStsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309043; c=relaxed/simple;
	bh=WI8fmrwBp1ofD3tVxO42Hyp9KIw8iGof5KffKBZ9SZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJKdm/tXvSwuxgSyq12+UHOx69dhDuAV5RqUL2sWbnCAp3jBH9lzNzAxlhL9YEYxdfrJ+xjWDQ/FgzRRkUPxwBSPsiiJ936f/yttoLYBLKAVZTf+Mdm//9YjA24ii089yBMHieMjf79QBjD9TNjyDuIDboCeV3oOfsynfhjkMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UfGBm894; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d9c2096c29so54122339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713309039; x=1713913839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z83N4jKsM1HzVFePKo/D4IW2qFPh3+IG7+1CQTYdpBk=;
        b=UfGBm894yurH0pv5O4seP1H+l9lxoHpDjFourA3TyOGACshg1760boXBij8T33XzxF
         tmA8jVvDFWs4+1RixxCvvgor3HljcZ9/JWLOMW7+kvpB9fxCF14pR92SV5Laso2u9q/P
         f1/VOqvQuIJjx/NETuTUB7+95z/nE20osoySgikuyUAeuBDoz436DkHtmSnan+uZ/SnX
         1OLbtSVPC9ZSqVCJ27mEOmSws8Y3iSm/MeAV7mmh2u19UBLe9h1i5BEhqndEKrtB5tKw
         WnFoga3GZ7PWgzqGXxJ8k4/bz0kQtGdfW5ObiUD+DO8LWzZI9MO02omuwfqOIBKzw0gy
         qQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309039; x=1713913839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z83N4jKsM1HzVFePKo/D4IW2qFPh3+IG7+1CQTYdpBk=;
        b=XwdsCz7lnw+SgFtAwIarsVFVeVi7wAe7xIlSw3obqxl9UHU3D/dmERG3/l8vHwpB+v
         F9OWhKnNpjyOKnm1GXb488n7Yq+pIIoB4FdS0XnjNbrIGvmpy2DJ/GhHqn5u1Bng7igT
         EZrLKTi+nsA82niDZ4JI8Bg/OasQn/w+8tJpXksxp8zaUMTdh2Ty75tPsgTq62++ovh1
         WH/nLCnHbrkazo1K4kh0J2dNUF2RZT3QGPA5jNhuganfj+Hs1WKab9Ev9tco5tHnLH3W
         HX1j71J9/hmfPek4hnwiGiSDyb0kUiA/aTjVuFzIf1tpK2Wgm6/QWY8q+BfT6IBH5iPf
         yGlw==
X-Forwarded-Encrypted: i=1; AJvYcCUIQHCxX22DUNf2YFoTUP1rwNwhKvd6lSZci9nDqiEEsJuQA0W4YZsaeH6ZqCmGJQYVVP0cBrAYDhpvMcd7azbZXioIlWg7bAc507Rt
X-Gm-Message-State: AOJu0YzvdH1phNIbdDrVBUDtHCntI6yjIHqr27xTxFLJ9NLVcubELg/s
	EIL5bfeinv1IId6gJHBLXQoLcIS5WT4+oaR0NyNvo/Ah8aldcQSFdHaMPITc9DI=
X-Google-Smtp-Source: AGHT+IFTBeknErvCvFVe6jtrX2YCcu0nihQ8rOZsFI6wCzTh4pnTFH17iTssD3wvxxeGfzy+rrchUA==
X-Received: by 2002:a05:6602:3990:b0:7d6:991a:ef17 with SMTP id bw16-20020a056602399000b007d6991aef17mr21220780iob.11.1713309039287;
        Tue, 16 Apr 2024 16:10:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id le9-20020a056638960900b004846ed9fcb1sm372170jab.101.2024.04.16.16.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:10:38 -0700 (PDT)
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
Subject: [PATCH net-next 7/7] net: ipa: sort all includes
Date: Tue, 16 Apr 2024 18:10:18 -0500
Message-Id: <20240416231018.389520-8-elder@linaro.org>
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

Establish the rule that header files are always included in sorted
(POSIX local) order.  Standard and private headers are separated by
a blank line.

Similarly, sort all forward-declarations for structures.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c           | 14 +++++++-------
 drivers/net/ipa/gsi.h           |  4 ++--
 drivers/net/ipa/gsi_reg.c       |  6 +++---
 drivers/net/ipa/gsi_trans.c     | 12 ++++++------
 drivers/net/ipa/gsi_trans.h     |  6 +++---
 drivers/net/ipa/ipa.h           |  8 ++++----
 drivers/net/ipa/ipa_cmd.c       |  8 ++++----
 drivers/net/ipa/ipa_cmd.h       |  4 ++--
 drivers/net/ipa/ipa_data.h      |  4 ++--
 drivers/net/ipa/ipa_endpoint.c  | 14 +++++++-------
 drivers/net/ipa/ipa_gsi.c       |  6 +++---
 drivers/net/ipa/ipa_interrupt.c | 10 +++++-----
 drivers/net/ipa/ipa_interrupt.h |  1 +
 drivers/net/ipa/ipa_main.c      | 21 +++++++++++----------
 drivers/net/ipa/ipa_mem.c       | 11 ++++++-----
 drivers/net/ipa/ipa_modem.c     | 11 ++++++-----
 drivers/net/ipa/ipa_modem.h     |  5 +++--
 drivers/net/ipa/ipa_power.c     |  6 +++---
 drivers/net/ipa/ipa_qmi.c       |  4 ++--
 drivers/net/ipa/ipa_qmi.h       |  1 +
 drivers/net/ipa/ipa_qmi_msg.c   |  3 ++-
 drivers/net/ipa/ipa_qmi_msg.h   |  3 ++-
 drivers/net/ipa/ipa_reg.c       |  4 ++--
 drivers/net/ipa/ipa_smp2p.c     |  7 ++++---
 drivers/net/ipa/ipa_sysfs.c     |  4 ++--
 drivers/net/ipa/ipa_table.c     | 16 ++++++++--------
 drivers/net/ipa/ipa_uc.c        |  8 ++++----
 drivers/net/ipa/reg.h           |  4 ++--
 28 files changed, 107 insertions(+), 98 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index e087074cec4f7..6c8feb640a97e 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -4,23 +4,23 @@
  * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
-#include <linux/types.h>
 #include <linux/bits.h>
-#include <linux/mutex.h>
-#include <linux/completion.h>
 #include <linux/bug.h>
+#include <linux/completion.h>
 #include <linux/interrupt.h>
-#include <linux/platform_device.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
 
 #include "gsi.h"
-#include "reg.h"
-#include "gsi_reg.h"
 #include "gsi_private.h"
+#include "gsi_reg.h"
 #include "gsi_trans.h"
-#include "ipa_gsi.h"
 #include "ipa_data.h"
+#include "ipa_gsi.h"
 #include "ipa_version.h"
+#include "reg.h"
 
 /**
  * DOC: The IPA Generic Software Interface
diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
index 26cc3d368e1b8..833135b35380f 100644
--- a/drivers/net/ipa/gsi.h
+++ b/drivers/net/ipa/gsi.h
@@ -6,10 +6,10 @@
 #ifndef _GSI_H_
 #define _GSI_H_
 
-#include <linux/types.h>
-#include <linux/mutex.h>
 #include <linux/completion.h>
+#include <linux/mutex.h>
 #include <linux/netdevice.h>
+#include <linux/types.h>
 
 #include "ipa_version.h"
 
diff --git a/drivers/net/ipa/gsi_reg.c b/drivers/net/ipa/gsi_reg.c
index 106c43884aef8..825598661188e 100644
--- a/drivers/net/ipa/gsi_reg.c
+++ b/drivers/net/ipa/gsi_reg.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
-#include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include "gsi.h"
-#include "reg.h"
 #include "gsi_reg.h"
+#include "reg.h"
 
 /* Is this register ID valid for the current GSI version? */
 static bool gsi_reg_id_valid(struct gsi *gsi, enum gsi_reg_id reg_id)
diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index ee6fb00b71eb6..19531883864ae 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -1,22 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2022 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
-#include <linux/types.h>
-#include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/dma-direction.h>
 #include <linux/refcount.h>
 #include <linux/scatterlist.h>
-#include <linux/dma-direction.h>
+#include <linux/types.h>
 
 #include "gsi.h"
 #include "gsi_private.h"
 #include "gsi_trans.h"
-#include "ipa_gsi.h"
-#include "ipa_data.h"
 #include "ipa_cmd.h"
+#include "ipa_data.h"
+#include "ipa_gsi.h"
 
 /**
  * DOC: GSI Transactions
diff --git a/drivers/net/ipa/gsi_trans.h b/drivers/net/ipa/gsi_trans.h
index 407c3af24b6e0..c1b3386cbb9d5 100644
--- a/drivers/net/ipa/gsi_trans.h
+++ b/drivers/net/ipa/gsi_trans.h
@@ -6,16 +6,16 @@
 #ifndef _GSI_TRANS_H_
 #define _GSI_TRANS_H_
 
-#include <linux/types.h>
-#include <linux/refcount.h>
 #include <linux/completion.h>
 #include <linux/dma-direction.h>
+#include <linux/refcount.h>
+#include <linux/types.h>
 
 #include "ipa_cmd.h"
 
+struct device;
 struct page;
 struct scatterlist;
-struct device;
 struct sk_buff;
 
 struct gsi;
diff --git a/drivers/net/ipa/ipa.h b/drivers/net/ipa/ipa.h
index 6f4ea1cfa4a91..7ef10a4ff35e1 100644
--- a/drivers/net/ipa/ipa.h
+++ b/drivers/net/ipa/ipa.h
@@ -6,20 +6,20 @@
 #ifndef _IPA_H_
 #define _IPA_H_
 
-#include <linux/types.h>
 #include <linux/notifier.h>
+#include <linux/types.h>
 
-#include "ipa_version.h"
 #include "gsi.h"
+#include "ipa_endpoint.h"
 #include "ipa_mem.h"
 #include "ipa_qmi.h"
-#include "ipa_endpoint.h"
+#include "ipa_version.h"
 
 struct net_device;
 
+struct ipa_interrupt;
 struct ipa_power;
 struct ipa_smp2p;
-struct ipa_interrupt;
 
 /**
  * struct ipa - IPA information
diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index 969b93fe5c495..984311a9a5f2b 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -4,20 +4,20 @@
  * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
-#include <linux/types.h>
 #include <linux/device.h>
-#include <linux/bitfield.h>
 #include <linux/dma-direction.h>
+#include <linux/types.h>
 
 #include "gsi.h"
 #include "gsi_trans.h"
 #include "ipa.h"
+#include "ipa_cmd.h"
 #include "ipa_endpoint.h"
+#include "ipa_mem.h"
 #include "ipa_reg.h"
 #include "ipa_table.h"
-#include "ipa_cmd.h"
-#include "ipa_mem.h"
 
 /**
  * DOC:  IPA Immediate Commands
diff --git a/drivers/net/ipa/ipa_cmd.h b/drivers/net/ipa/ipa_cmd.h
index fa37416ba4bd1..5824bb131ebab 100644
--- a/drivers/net/ipa/ipa_cmd.h
+++ b/drivers/net/ipa/ipa_cmd.h
@@ -8,10 +8,10 @@
 
 #include <linux/types.h>
 
+struct gsi_channel;
+struct gsi_trans;
 struct ipa;
 struct ipa_mem;
-struct gsi_trans;
-struct gsi_channel;
 
 /**
  * enum ipa_cmd_opcode:	IPA immediate commands
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index 2a1605e67b65d..d88cbbbf18b74 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -1,16 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2023 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 #ifndef _IPA_DATA_H_
 #define _IPA_DATA_H_
 
 #include <linux/types.h>
 
-#include "ipa_version.h"
 #include "ipa_endpoint.h"
 #include "ipa_mem.h"
+#include "ipa_version.h"
 
 /**
  * DOC: IPA/GSI Configuration Data
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 27d14b19f9401..0bd9b9fbbf56b 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -4,26 +4,26 @@
  * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
-#include <linux/types.h>
 #include <linux/device.h>
-#include <linux/bitfield.h>
-#include <linux/if_rmnet.h>
 #include <linux/dma-direction.h>
+#include <linux/if_rmnet.h>
+#include <linux/types.h>
 
 #include "gsi.h"
 #include "gsi_trans.h"
 #include "ipa.h"
+#include "ipa_cmd.h"
 #include "ipa_data.h"
 #include "ipa_endpoint.h"
-#include "ipa_cmd.h"
+#include "ipa_gsi.h"
+#include "ipa_interrupt.h"
 #include "ipa_mem.h"
 #include "ipa_modem.h"
+#include "ipa_power.h"
 #include "ipa_reg.h"
 #include "ipa_table.h"
-#include "ipa_gsi.h"
-#include "ipa_power.h"
-#include "ipa_interrupt.h"
 #include "ipa_version.h"
 
 /* Hardware is told about receive buffers once a "batch" has been queued */
diff --git a/drivers/net/ipa/ipa_gsi.c b/drivers/net/ipa/ipa_gsi.c
index 5666a83c32cc4..cb654c7b54981 100644
--- a/drivers/net/ipa/ipa_gsi.c
+++ b/drivers/net/ipa/ipa_gsi.c
@@ -1,16 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2020 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
 #include <linux/types.h>
 
-#include "ipa_gsi.h"
 #include "gsi_trans.h"
 #include "ipa.h"
-#include "ipa_endpoint.h"
 #include "ipa_data.h"
+#include "ipa_endpoint.h"
+#include "ipa_gsi.h"
 #include "ipa_version.h"
 
 void ipa_gsi_trans_complete(struct gsi_trans *trans)
diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index c3e8784d51d91..6823fdbdd48e2 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
 /* DOC: IPA Interrupts
@@ -19,18 +19,18 @@
  * time only these three are supported.
  */
 
-#include <linux/platform_device.h>
-#include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
+#include <linux/types.h>
 
 #include "ipa.h"
-#include "ipa_reg.h"
 #include "ipa_endpoint.h"
+#include "ipa_interrupt.h"
 #include "ipa_power.h"
+#include "ipa_reg.h"
 #include "ipa_uc.h"
-#include "ipa_interrupt.h"
 
 /**
  * struct ipa_interrupt - IPA interrupt information
diff --git a/drivers/net/ipa/ipa_interrupt.h b/drivers/net/ipa/ipa_interrupt.h
index 64bd8cff1a041..d11c4af14fa23 100644
--- a/drivers/net/ipa/ipa_interrupt.h
+++ b/drivers/net/ipa/ipa_interrupt.h
@@ -12,6 +12,7 @@ struct platform_device;
 
 struct ipa;
 struct ipa_interrupt;
+
 enum ipa_irq_id;
 
 /**
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index f8ee9d2839b7d..6523878c0d7f6 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -4,32 +4,33 @@
  * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
-#include <linux/types.h>
 #include <linux/bug.h>
-#include <linux/io.h>
 #include <linux/firmware.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/types.h>
+
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/soc/qcom/mdt_loader.h>
 
 #include "ipa.h"
-#include "ipa_power.h"
+#include "ipa_cmd.h"
 #include "ipa_data.h"
 #include "ipa_endpoint.h"
-#include "ipa_resource.h"
-#include "ipa_cmd.h"
-#include "ipa_reg.h"
+#include "ipa_interrupt.h"
 #include "ipa_mem.h"
-#include "ipa_table.h"
-#include "ipa_smp2p.h"
 #include "ipa_modem.h"
-#include "ipa_uc.h"
-#include "ipa_interrupt.h"
+#include "ipa_power.h"
+#include "ipa_reg.h"
+#include "ipa_resource.h"
+#include "ipa_smp2p.h"
 #include "ipa_sysfs.h"
+#include "ipa_table.h"
+#include "ipa_uc.h"
 #include "ipa_version.h"
 
 /**
diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index bcf125b6439e8..dee985eb08cba 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -4,20 +4,21 @@
  * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
-#include <linux/types.h>
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
-#include <linux/io.h>
+#include <linux/types.h>
+
 #include <linux/soc/qcom/smem.h>
 
+#include "gsi_trans.h"
 #include "ipa.h"
-#include "ipa_reg.h"
-#include "ipa_data.h"
 #include "ipa_cmd.h"
+#include "ipa_data.h"
 #include "ipa_mem.h"
+#include "ipa_reg.h"
 #include "ipa_table.h"
-#include "gsi_trans.h"
 
 /* "Canary" value placed between memory regions to detect overflow */
 #define IPA_MEM_CANARY_VAL		cpu_to_le32(0xdeadbeef)
diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 97e8dbfaa7210..8fe0d0e1a00fd 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -1,25 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
 #include <linux/errno.h>
+#include <linux/etherdevice.h>
 #include <linux/if_arp.h>
+#include <linux/if_rmnet.h>
 #include <linux/netdevice.h>
+#include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
-#include <linux/if_rmnet.h>
-#include <linux/etherdevice.h>
 #include <net/pkt_sched.h>
-#include <linux/pm_runtime.h>
+
 #include <linux/remoteproc/qcom_rproc.h>
 
 #include "ipa.h"
 #include "ipa_endpoint.h"
-#include "ipa_table.h"
 #include "ipa_mem.h"
 #include "ipa_modem.h"
 #include "ipa_smp2p.h"
+#include "ipa_table.h"
 #include "ipa_uc.h"
 
 #define IPA_NETDEV_NAME		"rmnet_ipa%d"
diff --git a/drivers/net/ipa/ipa_modem.h b/drivers/net/ipa/ipa_modem.h
index d85718db9a575..b1d2c80ed096c 100644
--- a/drivers/net/ipa/ipa_modem.h
+++ b/drivers/net/ipa/ipa_modem.h
@@ -1,15 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #ifndef _IPA_MODEM_H_
 #define _IPA_MODEM_H_
 
-struct ipa;
 struct net_device;
 struct sk_buff;
 
+struct ipa;
+
 int ipa_modem_start(struct ipa *ipa);
 int ipa_modem_stop(struct ipa *ipa);
 
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 9569d35d899bd..3a7049923c381 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -13,11 +13,11 @@
 #include "linux/soc/qcom/qcom_aoss.h"
 
 #include "ipa.h"
-#include "ipa_power.h"
-#include "ipa_interrupt.h"
+#include "ipa_data.h"
 #include "ipa_endpoint.h"
+#include "ipa_interrupt.h"
 #include "ipa_modem.h"
-#include "ipa_data.h"
+#include "ipa_power.h"
 
 /**
  * DOC: IPA Power Management
diff --git a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
index 8264e9dcbf22a..d771f3a71f94f 100644
--- a/drivers/net/ipa/ipa_qmi.c
+++ b/drivers/net/ipa/ipa_qmi.c
@@ -4,9 +4,9 @@
  * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
-#include <linux/types.h>
-#include <linux/string.h>
 #include <linux/qrtr.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 #include "ipa.h"
 #include "ipa_mem.h"
diff --git a/drivers/net/ipa/ipa_qmi.h b/drivers/net/ipa/ipa_qmi.h
index ce7bbb97699f2..fb15ea7f47e04 100644
--- a/drivers/net/ipa/ipa_qmi.h
+++ b/drivers/net/ipa/ipa_qmi.h
@@ -8,6 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/workqueue.h>
+
 #include <linux/soc/qcom/qmi.h>
 
 struct ipa;
diff --git a/drivers/net/ipa/ipa_qmi_msg.c b/drivers/net/ipa/ipa_qmi_msg.c
index 894f995172334..51dc13a577a5f 100644
--- a/drivers/net/ipa/ipa_qmi_msg.c
+++ b/drivers/net/ipa/ipa_qmi_msg.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #include <linux/stddef.h>
+
 #include <linux/soc/qcom/qmi.h>
 
 #include "ipa_qmi_msg.h"
diff --git a/drivers/net/ipa/ipa_qmi_msg.h b/drivers/net/ipa/ipa_qmi_msg.h
index b73503552c4da..644b8c27108b6 100644
--- a/drivers/net/ipa/ipa_qmi_msg.h
+++ b/drivers/net/ipa/ipa_qmi_msg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #ifndef _IPA_QMI_MSG_H_
 #define _IPA_QMI_MSG_H_
@@ -9,6 +9,7 @@
 /* === Only "ipa_qmi" and "ipa_qmi_msg.c" should include this file === */
 
 #include <linux/types.h>
+
 #include <linux/soc/qcom/qmi.h>
 
 /* Request/response/indication QMI message ids used for IPA.  Receiving
diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
index 98625956e0bb4..c574f798fdc95 100644
--- a/drivers/net/ipa/ipa_reg.c
+++ b/drivers/net/ipa/ipa_reg.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2023 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
-#include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include "ipa.h"
 #include "ipa_reg.h"
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 17a61649cd4ff..fcaadd111a8a3 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -4,16 +4,17 @@
  * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
-#include <linux/types.h>
-#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/panic_notifier.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/types.h>
+
 #include <linux/soc/qcom/smem_state.h>
 
-#include "ipa_smp2p.h"
 #include "ipa.h"
+#include "ipa_smp2p.h"
 #include "ipa_uc.h"
 
 /**
diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
index 24f4a5ff07c14..a59bd215494c9 100644
--- a/drivers/net/ipa/ipa_sysfs.c
+++ b/drivers/net/ipa/ipa_sysfs.c
@@ -2,13 +2,13 @@
 
 /* Copyright (C) 2021-2024 Linaro Ltd. */
 
-#include <linux/types.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include "ipa.h"
-#include "ipa_version.h"
 #include "ipa_sysfs.h"
+#include "ipa_version.h"
 
 static const char *ipa_version_string(struct ipa *ipa)
 {
diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index f5e1d3f43b57e..45eb24be78a2e 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -4,22 +4,22 @@
  * Copyright (C) 2018-2023 Linaro Ltd.
  */
 
-#include <linux/types.h>
 #include <linux/bitops.h>
-#include <linux/io.h>
 #include <linux/build_bug.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/types.h>
 
+#include "gsi.h"
+#include "gsi_trans.h"
 #include "ipa.h"
-#include "ipa_version.h"
+#include "ipa_cmd.h"
 #include "ipa_endpoint.h"
-#include "ipa_table.h"
-#include "ipa_reg.h"
 #include "ipa_mem.h"
-#include "ipa_cmd.h"
-#include "gsi.h"
-#include "gsi_trans.h"
+#include "ipa_reg.h"
+#include "ipa_table.h"
+#include "ipa_version.h"
 
 /**
  * DOC: IPA Filter and Route Tables
diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index 17352f21d5f87..2963db83ab6b0 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -4,16 +4,16 @@
  * Copyright (C) 2018-2024 Linaro Ltd.
  */
 
-#include <linux/types.h>
-#include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/pm_runtime.h>
+#include <linux/types.h>
 
 #include "ipa.h"
+#include "ipa_interrupt.h"
+#include "ipa_power.h"
 #include "ipa_reg.h"
 #include "ipa_uc.h"
-#include "ipa_power.h"
-#include "ipa_interrupt.h"
 
 /**
  * DOC:  The IPA embedded microcontroller
diff --git a/drivers/net/ipa/reg.h b/drivers/net/ipa/reg.h
index e78eb0c0c6613..53c16e594ea41 100644
--- a/drivers/net/ipa/reg.h
+++ b/drivers/net/ipa/reg.h
@@ -7,9 +7,9 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
-#include <linux/types.h>
-#include <linux/log2.h>
 #include <linux/bug.h>
+#include <linux/log2.h>
+#include <linux/types.h>
 
 /**
  * struct reg - A register descriptor
-- 
2.40.1


