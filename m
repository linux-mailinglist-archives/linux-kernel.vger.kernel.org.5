Return-Path: <linux-kernel+bounces-147742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B48A7870
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8491C20BED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751813C8EE;
	Tue, 16 Apr 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGStYX6D"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8EF13C3E7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309040; cv=none; b=I5grNa8+47VvIbbVXV1QCF6biWi/1OFh2R0STBqvcd+uQZS0SK4PH57vivveC7+taIjGILM2RIeQkG0hwpaCl8YO0z5fsGUQFX0GeBcBbnVZovslC4LIEbBrGY95zQHBj96zgZO0vXvaLEqgiCSk+wyqSkRyRM27yVQlIV7IpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309040; c=relaxed/simple;
	bh=3rzbKK+iysK338HKY7E+Rv9wS6LIAPoY2j9HwOUEMh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9F+BXlPOyUD6849QbTWISqJa9ggczjOvVxVvXY6FYdJmEbjlLuype5/9ib7NasPQwrK/8N3ylMjqsnE2KP30chdlCfxfYxRyZM5zIkkq/XlC1zclqEkpHrGEK6vRaoU1dHDpdWIbukqDoR9BJDTITb7gbRMyc060PZRIjtgmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qGStYX6D; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5e4097a9aso202099139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713309038; x=1713913838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inJu4oodCMrwDs6u0bWGF99EZNy/SL5Zt8O1MgLAhmo=;
        b=qGStYX6DoIkaHu/viL5TFkzhxAR+2GP5UO3/urns1i8W245ZcLklkE83k3CqgZB+Dp
         jGzV/emaCcvXt3nkHfh9q/kJ26HOq2s+24NHDEjP8TllNBjCNhPbGyCLf7ezq7fbc4VV
         f6l3Fj7/mULKj7d40vE6mcP44/CuIUn1DjrjpF8AoTwhkNQwhZ6uNRRFbfqrofrIwP1g
         4oZ/1kv3jMBWnIuQNhmrJBuZNxwVRAsZUOEBw+Gu4vjYIcoAxOsK4pToybcCL20x74mW
         8x+gyT2vMl4tyKNSQCcodmpXzR9hhi9pik59yFwhFwLHdNeOxFjZ5+kkDGOIvLCKGvTO
         klaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309038; x=1713913838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inJu4oodCMrwDs6u0bWGF99EZNy/SL5Zt8O1MgLAhmo=;
        b=ZVUoI4O7C9g7GgkA9j2/x2S5x5xc1hAuH/6rRqqTJBzVn1Eo6v8BuIvEMezq9MrOJZ
         WdUIMBzJve9hkxyHv5iFYYd5WKXqE5pbi44THXivCq9pfMCCuKEoR1AL9VmJxAXWqS1B
         wFrzjBC6socY2RIfs20Z3PPEv/XJBc97bXQxAtN3MIbPVFy+DAr83Mms3WTw06OLED/B
         xXiFKoqZFrzd7ZaSAUc+/ezMgy2XYnbNHe8mqT+tR+yyYCZsLcpeIJpMz4TU48pcP/E2
         +6+8vdwB4ZfZSOOskKs0FZLjjodNh8BYhBNO5/nrjTMZScrmH/UM3b/Umzauyiqs/Iqo
         tySA==
X-Forwarded-Encrypted: i=1; AJvYcCXQxwJfooBOc+a1mKOyax5vomW/DcqSpa5r7uO91RqCALh1NYGZWr9Nnh4L4qdk0alks5L+mbFE0sFtzIbIpuDHjq89PZdjLRLs9lKo
X-Gm-Message-State: AOJu0Yw9XAVSpRLG735iwfxJUAKO/kKo3OBtb/0JDhuYBOECdd5YDUHr
	aVyBODMggOn7ClfRtxmoRPDYv3eBaUT23TV6/tEPJ0Ri1VPaFdC3hW9SFkJU1yQ=
X-Google-Smtp-Source: AGHT+IGoqFvY1AdjhA4LNvzNQWxk+VHMIetkErljcR+10aZU301gZiahFfqqBhnvjDLJElbF7IDINw==
X-Received: by 2002:a05:6602:368b:b0:7d5:e944:bf7e with SMTP id bf11-20020a056602368b00b007d5e944bf7emr20397601iob.19.1713309037950;
        Tue, 16 Apr 2024 16:10:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id le9-20020a056638960900b004846ed9fcb1sm372170jab.101.2024.04.16.16.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:10:37 -0700 (PDT)
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
Subject: [PATCH net-next 6/7] net: ipa: more include file cleanup
Date: Tue, 16 Apr 2024 18:10:17 -0500
Message-Id: <20240416231018.389520-7-elder@linaro.org>
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

All of the config data files and all of the register definition
files (plus a few others) use GSI_EE_AP, which is defined in
"ipa_version.h".  Include that header where it's needed.

All of the IPA register definition files include "../ipa.h", though
none of them need anything defined there.  Similarly, all of the GSI
register definition files include "../gsi.h", but don't need anything
defined there.  Remove these unnneded includes.

All of the configuration data files include "../gsi.h", though none
of them need anything defined there, so remove these includes.

Remove other includes of local header files that are not required.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/data/ipa_data-v3.1.c   | 2 +-
 drivers/net/ipa/data/ipa_data-v3.5.1.c | 2 +-
 drivers/net/ipa/data/ipa_data-v4.11.c  | 2 +-
 drivers/net/ipa/data/ipa_data-v4.2.c   | 2 +-
 drivers/net/ipa/data/ipa_data-v4.5.c   | 2 +-
 drivers/net/ipa/data/ipa_data-v4.7.c   | 2 +-
 drivers/net/ipa/data/ipa_data-v4.9.c   | 2 +-
 drivers/net/ipa/data/ipa_data-v5.0.c   | 2 +-
 drivers/net/ipa/data/ipa_data-v5.5.c   | 2 +-
 drivers/net/ipa/ipa_endpoint.c         | 1 +
 drivers/net/ipa/ipa_endpoint.h         | 2 +-
 drivers/net/ipa/ipa_gsi.c              | 1 +
 drivers/net/ipa/ipa_main.c             | 2 +-
 drivers/net/ipa/ipa_modem.c            | 3 ---
 drivers/net/ipa/ipa_qmi.c              | 2 --
 drivers/net/ipa/ipa_reg.h              | 1 -
 drivers/net/ipa/reg/gsi_reg-v3.1.c     | 4 ++--
 drivers/net/ipa/reg/gsi_reg-v3.5.1.c   | 4 ++--
 drivers/net/ipa/reg/gsi_reg-v4.0.c     | 4 ++--
 drivers/net/ipa/reg/gsi_reg-v4.11.c    | 4 ++--
 drivers/net/ipa/reg/gsi_reg-v4.5.c     | 4 ++--
 drivers/net/ipa/reg/gsi_reg-v4.9.c     | 4 ++--
 drivers/net/ipa/reg/gsi_reg-v5.0.c     | 4 ++--
 drivers/net/ipa/reg/ipa_reg-v3.1.c     | 2 +-
 drivers/net/ipa/reg/ipa_reg-v3.5.1.c   | 2 +-
 drivers/net/ipa/reg/ipa_reg-v4.11.c    | 2 +-
 drivers/net/ipa/reg/ipa_reg-v4.2.c     | 2 +-
 drivers/net/ipa/reg/ipa_reg-v4.5.c     | 2 +-
 drivers/net/ipa/reg/ipa_reg-v4.7.c     | 2 +-
 drivers/net/ipa/reg/ipa_reg-v4.9.c     | 2 +-
 drivers/net/ipa/reg/ipa_reg-v5.0.c     | 2 +-
 drivers/net/ipa/reg/ipa_reg-v5.5.c     | 1 -
 32 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ipa/data/ipa_data-v3.1.c b/drivers/net/ipa/data/ipa_data-v3.1.c
index 58fe2a4fe37ce..e902d731776da 100644
--- a/drivers/net/ipa/data/ipa_data-v3.1.c
+++ b/drivers/net/ipa/data/ipa_data-v3.1.c
@@ -7,10 +7,10 @@
 #include <linux/array_size.h>
 #include <linux/log2.h>
 
-#include "../gsi.h"
 #include "../ipa_data.h"
 #include "../ipa_endpoint.h"
 #include "../ipa_mem.h"
+#include "../ipa_version.h"
 
 /** enum ipa_resource_type - IPA resource types for an SoC having IPA v3.1 */
 enum ipa_resource_type {
diff --git a/drivers/net/ipa/data/ipa_data-v3.5.1.c b/drivers/net/ipa/data/ipa_data-v3.5.1.c
index c71e585ed3f1c..f632aab56f4c3 100644
--- a/drivers/net/ipa/data/ipa_data-v3.5.1.c
+++ b/drivers/net/ipa/data/ipa_data-v3.5.1.c
@@ -7,10 +7,10 @@
 #include <linux/array_size.h>
 #include <linux/log2.h>
 
-#include "../gsi.h"
 #include "../ipa_data.h"
 #include "../ipa_endpoint.h"
 #include "../ipa_mem.h"
+#include "../ipa_version.h"
 
 /** enum ipa_resource_type - IPA resource types for an SoC having IPA v3.5.1 */
 enum ipa_resource_type {
diff --git a/drivers/net/ipa/data/ipa_data-v4.11.c b/drivers/net/ipa/data/ipa_data-v4.11.c
index d1289de3ecf01..c1428483ca34d 100644
--- a/drivers/net/ipa/data/ipa_data-v4.11.c
+++ b/drivers/net/ipa/data/ipa_data-v4.11.c
@@ -5,10 +5,10 @@
 #include <linux/array_size.h>
 #include <linux/log2.h>
 
-#include "../gsi.h"
 #include "../ipa_data.h"
 #include "../ipa_endpoint.h"
 #include "../ipa_mem.h"
+#include "../ipa_version.h"
 
 /** enum ipa_resource_type - IPA resource types for an SoC having IPA v4.11 */
 enum ipa_resource_type {
diff --git a/drivers/net/ipa/data/ipa_data-v4.2.c b/drivers/net/ipa/data/ipa_data-v4.2.c
index 25194519df8e3..2c7e8cb429b9c 100644
--- a/drivers/net/ipa/data/ipa_data-v4.2.c
+++ b/drivers/net/ipa/data/ipa_data-v4.2.c
@@ -5,10 +5,10 @@
 #include <linux/array_size.h>
 #include <linux/log2.h>
 
-#include "../gsi.h"
 #include "../ipa_data.h"
 #include "../ipa_endpoint.h"
 #include "../ipa_mem.h"
+#include "../ipa_version.h"
 
 /** enum ipa_resource_type - IPA resource types for an SoC having IPA v4.2 */
 enum ipa_resource_type {
diff --git a/drivers/net/ipa/data/ipa_data-v4.5.c b/drivers/net/ipa/data/ipa_data-v4.5.c
index e9e375d530765..57dc78c526b06 100644
--- a/drivers/net/ipa/data/ipa_data-v4.5.c
+++ b/drivers/net/ipa/data/ipa_data-v4.5.c
@@ -5,10 +5,10 @@
 #include <linux/array_size.h>
 #include <linux/log2.h>
 
-#include "../gsi.h"
 #include "../ipa_data.h"
 #include "../ipa_endpoint.h"
 #include "../ipa_mem.h"
+#include "../ipa_version.h"
 
 /** enum ipa_resource_type - IPA resource types for an SoC having IPA v4.5 */
 enum ipa_resource_type {
diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index f3444c009fea8..c8c23d9be961b 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -5,10 +5,10 @@
 #include <linux/array_size.h>
 #include <linux/log2.h>
 
-#include "../gsi.h"
 #include "../ipa_data.h"
 #include "../ipa_endpoint.h"
 #include "../ipa_mem.h"
+#include "../ipa_version.h"
 
 /** enum ipa_resource_type - IPA resource types for an SoC having IPA v4.7 */
 enum ipa_resource_type {
diff --git a/drivers/net/ipa/data/ipa_data-v4.9.c b/drivers/net/ipa/data/ipa_data-v4.9.c
index 5284312c02f33..4eb9c909d5b3f 100644
--- a/drivers/net/ipa/data/ipa_data-v4.9.c
+++ b/drivers/net/ipa/data/ipa_data-v4.9.c
@@ -5,10 +5,10 @@
 #include <linux/array_size.h>
 #include <linux/log2.h>
 
-#include "../gsi.h"
 #include "../ipa_data.h"
 #include "../ipa_endpoint.h"
 #include "../ipa_mem.h"
+#include "../ipa_version.h"
 
 /** enum ipa_resource_type - IPA resource types for an SoC having IPA v4.9 */
 enum ipa_resource_type {
diff --git a/drivers/net/ipa/data/ipa_data-v5.0.c b/drivers/net/ipa/data/ipa_data-v5.0.c
index 615750c412fc7..050580c99b65c 100644
--- a/drivers/net/ipa/data/ipa_data-v5.0.c
+++ b/drivers/net/ipa/data/ipa_data-v5.0.c
@@ -5,10 +5,10 @@
 #include <linux/array_size.h>
 #include <linux/log2.h>
 
-#include "../gsi.h"
 #include "../ipa_data.h"
 #include "../ipa_endpoint.h"
 #include "../ipa_mem.h"
+#include "../ipa_version.h"
 
 /** enum ipa_resource_type - IPA resource types for an SoC having IPA v5.0 */
 enum ipa_resource_type {
diff --git a/drivers/net/ipa/data/ipa_data-v5.5.c b/drivers/net/ipa/data/ipa_data-v5.5.c
index 2c5bfa6d7101d..0e6663e225333 100644
--- a/drivers/net/ipa/data/ipa_data-v5.5.c
+++ b/drivers/net/ipa/data/ipa_data-v5.5.c
@@ -3,12 +3,12 @@
 /* Copyright (C) 2023-2024 Linaro Ltd. */
 
 #include <linux/array_size.h>
-#include <linux/kernel.h>
 #include <linux/log2.h>
 
 #include "../ipa_data.h"
 #include "../ipa_endpoint.h"
 #include "../ipa_mem.h"
+#include "../ipa_version.h"
 
 /** enum ipa_resource_type - IPA resource types for an SoC having IPA v5.5 */
 enum ipa_resource_type {
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 8284b0a1178c3..27d14b19f9401 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -24,6 +24,7 @@
 #include "ipa_gsi.h"
 #include "ipa_power.h"
 #include "ipa_interrupt.h"
+#include "ipa_version.h"
 
 /* Hardware is told about receive buffers once a "batch" has been queued */
 #define IPA_REPLENISH_BATCH	16		/* Must be non-zero */
diff --git a/drivers/net/ipa/ipa_endpoint.h b/drivers/net/ipa/ipa_endpoint.h
index 47259616c679d..328b90dfd1695 100644
--- a/drivers/net/ipa/ipa_endpoint.h
+++ b/drivers/net/ipa/ipa_endpoint.h
@@ -9,8 +9,8 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
-#include "gsi.h"
 #include "ipa_reg.h"
+#include "ipa_version.h"
 
 struct net_device;
 struct sk_buff;
diff --git a/drivers/net/ipa/ipa_gsi.c b/drivers/net/ipa/ipa_gsi.c
index d323adb03383f..5666a83c32cc4 100644
--- a/drivers/net/ipa/ipa_gsi.c
+++ b/drivers/net/ipa/ipa_gsi.c
@@ -11,6 +11,7 @@
 #include "ipa.h"
 #include "ipa_endpoint.h"
 #include "ipa_data.h"
+#include "ipa_version.h"
 
 void ipa_gsi_trans_complete(struct gsi_trans *trans)
 {
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 82d23eac13f52..f8ee9d2839b7d 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -29,8 +29,8 @@
 #include "ipa_modem.h"
 #include "ipa_uc.h"
 #include "ipa_interrupt.h"
-#include "gsi_trans.h"
 #include "ipa_sysfs.h"
+#include "ipa_version.h"
 
 /**
  * DOC: The IP Accelerator
diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index c27ca3f27f7d4..97e8dbfaa7210 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -15,15 +15,12 @@
 #include <linux/remoteproc/qcom_rproc.h>
 
 #include "ipa.h"
-#include "ipa_data.h"
 #include "ipa_endpoint.h"
 #include "ipa_table.h"
 #include "ipa_mem.h"
 #include "ipa_modem.h"
 #include "ipa_smp2p.h"
-#include "ipa_qmi.h"
 #include "ipa_uc.h"
-#include "ipa_power.h"
 
 #define IPA_NETDEV_NAME		"rmnet_ipa%d"
 #define IPA_NETDEV_TAILROOM	0	/* for padding by mux layer */
diff --git a/drivers/net/ipa/ipa_qmi.c b/drivers/net/ipa/ipa_qmi.c
index 2873e26168fbe..8264e9dcbf22a 100644
--- a/drivers/net/ipa/ipa_qmi.c
+++ b/drivers/net/ipa/ipa_qmi.c
@@ -9,9 +9,7 @@
 #include <linux/qrtr.h>
 
 #include "ipa.h"
-#include "ipa_endpoint.h"
 #include "ipa_mem.h"
-#include "ipa_table.h"
 #include "ipa_modem.h"
 #include "ipa_qmi_msg.h"
 
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index 34150a893c532..61b7c441ae95d 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -6,7 +6,6 @@
 #ifndef _IPA_REG_H_
 #define _IPA_REG_H_
 
-#include "ipa_version.h"
 #include "reg.h"
 
 struct platform_device;
diff --git a/drivers/net/ipa/reg/gsi_reg-v3.1.c b/drivers/net/ipa/reg/gsi_reg-v3.1.c
index 8d76d04058d57..8c577b8b5c7a8 100644
--- a/drivers/net/ipa/reg/gsi_reg-v3.1.c
+++ b/drivers/net/ipa/reg/gsi_reg-v3.1.c
@@ -6,9 +6,9 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../gsi.h"
-#include "../reg.h"
 #include "../gsi_reg.h"
+#include "../ipa_version.h"
+#include "../reg.h"
 
 REG(INTER_EE_SRC_CH_IRQ_MSK, inter_ee_src_ch_irq_msk,
     0x0000c020 + 0x1000 * GSI_EE_AP);
diff --git a/drivers/net/ipa/reg/gsi_reg-v3.5.1.c b/drivers/net/ipa/reg/gsi_reg-v3.5.1.c
index f66c67996ff4c..a1c609f40d998 100644
--- a/drivers/net/ipa/reg/gsi_reg-v3.5.1.c
+++ b/drivers/net/ipa/reg/gsi_reg-v3.5.1.c
@@ -6,9 +6,9 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../gsi.h"
-#include "../reg.h"
 #include "../gsi_reg.h"
+#include "../ipa_version.h"
+#include "../reg.h"
 
 REG(INTER_EE_SRC_CH_IRQ_MSK, inter_ee_src_ch_irq_msk,
     0x0000c020 + 0x1000 * GSI_EE_AP);
diff --git a/drivers/net/ipa/reg/gsi_reg-v4.0.c b/drivers/net/ipa/reg/gsi_reg-v4.0.c
index 8e689edc792b8..ff1fb1ca47dd4 100644
--- a/drivers/net/ipa/reg/gsi_reg-v4.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v4.0.c
@@ -6,9 +6,9 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../gsi.h"
-#include "../reg.h"
 #include "../gsi_reg.h"
+#include "../ipa_version.h"
+#include "../reg.h"
 
 REG(INTER_EE_SRC_CH_IRQ_MSK, inter_ee_src_ch_irq_msk,
     0x0000c020 + 0x1000 * GSI_EE_AP);
diff --git a/drivers/net/ipa/reg/gsi_reg-v4.11.c b/drivers/net/ipa/reg/gsi_reg-v4.11.c
index 6d3ed0441f518..ab9757ce42e74 100644
--- a/drivers/net/ipa/reg/gsi_reg-v4.11.c
+++ b/drivers/net/ipa/reg/gsi_reg-v4.11.c
@@ -6,9 +6,9 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../gsi.h"
-#include "../reg.h"
 #include "../gsi_reg.h"
+#include "../ipa_version.h"
+#include "../reg.h"
 
 REG(INTER_EE_SRC_CH_IRQ_MSK, inter_ee_src_ch_irq_msk,
     0x0000c020 + 0x1000 * GSI_EE_AP);
diff --git a/drivers/net/ipa/reg/gsi_reg-v4.5.c b/drivers/net/ipa/reg/gsi_reg-v4.5.c
index 544db5852f499..01b45f79c3157 100644
--- a/drivers/net/ipa/reg/gsi_reg-v4.5.c
+++ b/drivers/net/ipa/reg/gsi_reg-v4.5.c
@@ -6,9 +6,9 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../gsi.h"
-#include "../reg.h"
 #include "../gsi_reg.h"
+#include "../ipa_version.h"
+#include "../reg.h"
 
 REG(INTER_EE_SRC_CH_IRQ_MSK, inter_ee_src_ch_irq_msk,
     0x0000c020 + 0x1000 * GSI_EE_AP);
diff --git a/drivers/net/ipa/reg/gsi_reg-v4.9.c b/drivers/net/ipa/reg/gsi_reg-v4.9.c
index a6d0584ab7996..783eaaee2936a 100644
--- a/drivers/net/ipa/reg/gsi_reg-v4.9.c
+++ b/drivers/net/ipa/reg/gsi_reg-v4.9.c
@@ -6,9 +6,9 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../gsi.h"
-#include "../reg.h"
 #include "../gsi_reg.h"
+#include "../ipa_version.h"
+#include "../reg.h"
 
 REG(INTER_EE_SRC_CH_IRQ_MSK, inter_ee_src_ch_irq_msk,
     0x0000c020 + 0x1000 * GSI_EE_AP);
diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
index a7b7f345c11a9..36d1e65df71bb 100644
--- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
@@ -6,9 +6,9 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../gsi.h"
-#include "../reg.h"
 #include "../gsi_reg.h"
+#include "../ipa_version.h"
+#include "../reg.h"
 
 REG(INTER_EE_SRC_CH_IRQ_MSK, inter_ee_src_ch_irq_msk,
     0x0000c01c + 0x1000 * GSI_EE_AP);
diff --git a/drivers/net/ipa/reg/ipa_reg-v3.1.c b/drivers/net/ipa/reg/ipa_reg-v3.1.c
index c05b382933ad8..63a44dce88353 100644
--- a/drivers/net/ipa/reg/ipa_reg-v3.1.c
+++ b/drivers/net/ipa/reg/ipa_reg-v3.1.c
@@ -6,8 +6,8 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../ipa.h"
 #include "../ipa_reg.h"
+#include "../ipa_version.h"
 
 static const u32 reg_comp_cfg_fmask[] = {
 	[COMP_CFG_ENABLE]				= BIT(0),
diff --git a/drivers/net/ipa/reg/ipa_reg-v3.5.1.c b/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
index afbe042b166be..4a7b6d92207de 100644
--- a/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
+++ b/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
@@ -6,8 +6,8 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../ipa.h"
 #include "../ipa_reg.h"
+#include "../ipa_version.h"
 
 static const u32 reg_comp_cfg_fmask[] = {
 	[COMP_CFG_ENABLE]				= BIT(0),
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.11.c b/drivers/net/ipa/reg/ipa_reg-v4.11.c
index 1d6b8ea9c5c80..257eaff9436e5 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.11.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.11.c
@@ -6,8 +6,8 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../ipa.h"
 #include "../ipa_reg.h"
+#include "../ipa_version.h"
 
 static const u32 reg_comp_cfg_fmask[] = {
 	[RAM_ARB_PRI_CLIENT_SAMP_FIX_DIS]		= BIT(0),
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.2.c b/drivers/net/ipa/reg/ipa_reg-v4.2.c
index 93a78352c3c81..e78dd71e8b032 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.2.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.2.c
@@ -6,8 +6,8 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../ipa.h"
 #include "../ipa_reg.h"
+#include "../ipa_version.h"
 
 static const u32 reg_comp_cfg_fmask[] = {
 						/* Bit 0 reserved */
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.5.c b/drivers/net/ipa/reg/ipa_reg-v4.5.c
index 9e23e503d4013..dc396344d868a 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.5.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.5.c
@@ -6,8 +6,8 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../ipa.h"
 #include "../ipa_reg.h"
+#include "../ipa_version.h"
 
 static const u32 reg_comp_cfg_fmask[] = {
 						/* Bit 0 reserved */
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.7.c b/drivers/net/ipa/reg/ipa_reg-v4.7.c
index 728ab90dc8d43..37a2e466e4755 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.7.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.7.c
@@ -6,8 +6,8 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../ipa.h"
 #include "../ipa_reg.h"
+#include "../ipa_version.h"
 
 static const u32 reg_comp_cfg_fmask[] = {
 	[RAM_ARB_PRI_CLIENT_SAMP_FIX_DIS]		= BIT(0),
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.9.c b/drivers/net/ipa/reg/ipa_reg-v4.9.c
index f61b66d36607f..09755d700784e 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.9.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.9.c
@@ -6,8 +6,8 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../ipa.h"
 #include "../ipa_reg.h"
+#include "../ipa_version.h"
 
 static const u32 reg_comp_cfg_fmask[] = {
 	[RAM_ARB_PRI_CLIENT_SAMP_FIX_DIS]		= BIT(0),
diff --git a/drivers/net/ipa/reg/ipa_reg-v5.0.c b/drivers/net/ipa/reg/ipa_reg-v5.0.c
index cba5be34106db..b26b5f57ac03d 100644
--- a/drivers/net/ipa/reg/ipa_reg-v5.0.c
+++ b/drivers/net/ipa/reg/ipa_reg-v5.0.c
@@ -6,8 +6,8 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
-#include "../ipa.h"
 #include "../ipa_reg.h"
+#include "../ipa_version.h"
 
 static const u32 reg_flavor_0_fmask[] = {
 	[MAX_PIPES]					= GENMASK(7, 0),
diff --git a/drivers/net/ipa/reg/ipa_reg-v5.5.c b/drivers/net/ipa/reg/ipa_reg-v5.5.c
index fe0b4b50c62a7..abb0c443ef660 100644
--- a/drivers/net/ipa/reg/ipa_reg-v5.5.c
+++ b/drivers/net/ipa/reg/ipa_reg-v5.5.c
@@ -4,7 +4,6 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
-#include <linux/kernel.h>
 #include <linux/types.h>
 
 #include "../ipa_reg.h"
-- 
2.40.1


