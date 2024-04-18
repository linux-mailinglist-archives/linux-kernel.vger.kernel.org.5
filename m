Return-Path: <linux-kernel+bounces-150168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCF08A9B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4DD1F23702
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3D015FCED;
	Thu, 18 Apr 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqQA7eu1"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006415FA94;
	Thu, 18 Apr 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446776; cv=none; b=JOo04ZgO/we1hOV3m2dmvEW3BzqDVRfWbXHaiVv9nW4D1fQHQUkYi34+IuswbuWC5M0Ugvdn1lU/7Gc8qG02BMX1fQ31GckUK/YKj3LiqzYnBvM+vtOZfJuKPyi/hpv8m6pq1H+q0ZZhhRriY17pp8Eakx5QATgPlbheoeT5NV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446776; c=relaxed/simple;
	bh=W8loeJgPBjnjnkzn24m+LbcwcKGo+/TYQDyUzZ/j8q0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kdV+ZpyWPsSL39h5XXz1UyVxiVTanUZr8l2I0UCUdAIB7hdoxbGb5+IcsSnivO5dy+jJ8RLghyT3Amm2Q8R31WVflXBXBTrL/e+wtmp9RRMPwL8bJfy7haQlxvVO7uUgAS7sR7WTlxJAE2pdp5zFfBzFxtbKmlvOhNMa6KodDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqQA7eu1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-418c2bf2f55so6267125e9.2;
        Thu, 18 Apr 2024 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713446773; x=1714051573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAjezbYFk4kRuwBAyZVCH+a9cPM1rylHv2qjz+E2Bv8=;
        b=dqQA7eu1t6NUDnFvDRM/uT6RukUzyUVJ6ZwiaWrzJ6c/YiBiVE5gylPyyTN4SHY4Jd
         KkZi+N1QLyNirA75Iw7Xy4ORDaa31mPyQV39F4pJZ2lX6gKLh1K880EV6JVftJVh0Gb6
         aJo7g/uDUUzzZDxcfIqCTli/EK+QWYvj2wLS7rfsplu5OdkzsZs9jkshimvIyXXhCAp3
         9bJ7pgRqzuvLCm+7UiMXH/8bTEzRttZ0xtW7yUPqoRTL24FTEKST45oPg9WsIJD0DZUE
         G8wIAlmvHHQrFdyDLa6BRLUnn2V90HtWuZPNRql21gZDjuxAsSoToB6l9MuJCv7+GmLv
         kBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446773; x=1714051573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAjezbYFk4kRuwBAyZVCH+a9cPM1rylHv2qjz+E2Bv8=;
        b=U0MNd15k5+U3TOuzJDXY+ua0vUJ6phPbjgEUZ7hbv/Z7BNsz8w9HZgdyD72zyBNJO8
         cUQVpmO7yyp8JXzyAc3SjPjlOl/W6ajvettzWkXMeiuFZDTSG16lwrnJBDym/oqfSSWF
         j2byJoYuPaCPWXtsfv6JykRggYfkMX6jZjAZoRSAuYj06GErj+Po4DuLV+lDFZcom3i/
         BLaXQje5B4J/LOBGagqmLtK+0y9Y03e0K/hghFs0s2+BO+aPZyHNomecokivXGCgmSc4
         LaaoORymL0ySuXxvq6Ku7UewbhbUZgkRxrcST3vLpsOjx12xa5EPe2Ljnj4iCTv+PxsX
         w9UA==
X-Forwarded-Encrypted: i=1; AJvYcCUYE8zaoQw65T88IGPBnZtqrocRy74iUxKkN+0Pt60YAAMQ08/NUrq2ukabfucSUwd1/HMLOP5M7N73gKbVLE9TsY9OHmlRb75TmueRgyXtFYI=
X-Gm-Message-State: AOJu0Yy4OWuPpRkdAJblbqu3NuCmbTQKaXNAosMrAGUSXk/c6YNqL91L
	NDKRrfBq295QhcKqmFum79zwxYxRtK2rO6YtpOJ/Dht5kEr4uaUZ
X-Google-Smtp-Source: AGHT+IHxYO+QfxTRPoNL7RDTcNFo5mTVb9cQ2OcGI4ZiHygN0wUQzL0DbxYZeODNTK6uvRDv7tT/Lw==
X-Received: by 2002:a05:6000:927:b0:341:bfe2:4509 with SMTP id cx7-20020a056000092700b00341bfe24509mr1511694wrb.42.1713446772752;
        Thu, 18 Apr 2024 06:26:12 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:2595:4364:d152:dff3])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b00349ff2e0345sm1853396wrn.70.2024.04.18.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:26:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH] reset: Add devm_reset_control_deassert helper
Date: Thu, 18 Apr 2024 14:26:02 +0100
Message-Id: <20240418132602.509313-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

A typical code pattern for reset_control_deassert() call is to call it in
the _probe function and to call reset_control_assert() both from _probe
error path and from _remove function.

Add helper function to replace this bolierplate piece of code. Calling
devm_reset_control_deassert() removes the need for calling
reset_control_assert() both in the probe()'s error path and in the
remove() function.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/reset/core.c  | 22 ++++++++++++++++++++++
 include/linux/reset.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index dba74e857be6..a2a6eff8e599 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -592,6 +592,28 @@ int reset_control_deassert(struct reset_control *rstc)
 }
 EXPORT_SYMBOL_GPL(reset_control_deassert);
 
+static void reset_control_assert_action(void *rstc)
+{
+	reset_control_assert(rstc);
+}
+
+/**
+ * devm_reset_control_deassert - devres-enabled version of reset_control_deassert()
+ * @dev: device that requests the reset control
+ * @rstc: reset controller
+ */
+int devm_reset_control_deassert(struct device *dev, struct reset_control *rstc)
+{
+	int ret;
+
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, reset_control_assert_action, rstc);
+}
+EXPORT_SYMBOL_GPL(devm_reset_control_deassert);
+
 /**
  * reset_control_bulk_deassert - deasserts the reset lines in reverse order
  * @num_rstcs: number of entries in rstcs array
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 514ddf003efc..e41e752ba098 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -31,6 +31,7 @@ int reset_control_reset(struct reset_control *rstc);
 int reset_control_rearm(struct reset_control *rstc);
 int reset_control_assert(struct reset_control *rstc);
 int reset_control_deassert(struct reset_control *rstc);
+int devm_reset_control_deassert(struct device *dev, struct reset_control *rstc);
 int reset_control_status(struct reset_control *rstc);
 int reset_control_acquire(struct reset_control *rstc);
 void reset_control_release(struct reset_control *rstc);
@@ -91,6 +92,11 @@ static inline int reset_control_deassert(struct reset_control *rstc)
 	return 0;
 }
 
+static inline int devm_reset_control_deassert(struct device *dev, struct reset_control *rstc)
+{
+	return 0;
+}
+
 static inline int reset_control_status(struct reset_control *rstc)
 {
 	return 0;
-- 
2.34.1


