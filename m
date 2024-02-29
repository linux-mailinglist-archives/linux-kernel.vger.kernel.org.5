Return-Path: <linux-kernel+bounces-86687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2856986C907
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2D31F24B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08FE7D080;
	Thu, 29 Feb 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OO9bLWQ6"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DFE7CF2F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209229; cv=none; b=UhWDZblOwX1qe0C7gTCAs9mCt9Q/SGtshx52Pf4Ka0M5ZAJOVs/Yiok8cVFPRVDLvpdZRdwy1sGxI1U/DE53u0qWeUjmY806oEKryVMnT/sHjOjEDATAssrVXLkjSL/gSULQv9uO1oA7pkpk9pLm2znFnLDEFQG7XoxQD6Wp4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209229; c=relaxed/simple;
	bh=LWsIkAYDWf7LqGpD23VVrUWalygC0mmJCNlJ0GD9kxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEM/l7fUHDjmyIACGBEwZJ/z2NjL/P+8+nDeEQ04wSWZWoPCqdSpQPiSu+X60qdkWcjGHeNRMvrzPc9s8PhOC6wVjYrsUhA1+seUVYOGm2QWD8VOamup2RM6KZybr36uUuubaljnMbG/QUjMBcM0WFrVR/3sDVwD7xjiSwwTVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OO9bLWQ6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412b99eb5cfso5653005e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709209226; x=1709814026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4M9b5DpBPobgh8Mhjoui4tnMINgMrMyk8rX4fi/AOw=;
        b=OO9bLWQ6ZFKVFtbEr6BldoYEJMTASYFVC+/LAjj21y5ohQfaQHr0U9SF80vbZ9W3Bj
         IMa/fsIAffiDaswrsBIyXKVI9n5GsZSyUjp+XsAYyxmpyfI/HmEmXQ54OaFOfzDBk0b2
         T94m3AxKfrL7soJOf2/oDCVXep8L/cl9QdMTBQ3UIK/ebK9MPQch22lU8MSnmiFCA8vs
         KdBNj4WCyU4pKIOEnCzXz4x7BDnAJKURWzIwnoh1W76dlyOp8dIelAwhBlyAKUTurnRP
         /p1dzmKjUyOk1k9ZAZA3d5dAlwq2YKN6ke8In6LR/Rfy0wU6v0yIrJ21KDEvR1VQMM28
         Uomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709209226; x=1709814026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4M9b5DpBPobgh8Mhjoui4tnMINgMrMyk8rX4fi/AOw=;
        b=PSpbU12SNYU93TSXLN+X+DgEHdRmg1nW1OxDQcJJa1y2ty8ySdUWYDJbF8127RMNs3
         9d/OUPpNpHdsTapMkOORRXMvu5m70VdkvyvoWN1NItwPz+vpxNhZJk+lLJpbhuLIkoC5
         kaIl+0dWgIyLN94nxJRCYF4+yPbBa/ZMped9ofqVvKzqnxIrycQyyfNXB6SGjM981kqK
         4DzN0DKjpT6nVV7Bgt7hlZpPRp+aCVFBps4kmaMEJwtvILvXeIrTfmo3iC09Z+DjULT2
         wQGbmkpfz1HHPA1XQMgS3xa3vSwiVoW5QkobXlIwFbCYAtTMf0+TrTvMkyLgh0vL66wJ
         Vp9g==
X-Forwarded-Encrypted: i=1; AJvYcCWy4aBXhzTjeGF3eAt63HDwC+I8ogS/cvvajmFUipQg4V00DChlFWAjZ+24/Pz7/Jqs0WTgp7VEBqx+k9BkyzKs1KUaktOlwGuT08w+
X-Gm-Message-State: AOJu0Yy08VelYqiYhEZCoLYi6bR8wF8+Ms5ed5Q1hqTNkwNsMvcNErIJ
	X9uf1adXDGn8y4GzlcyUUQgrWekG0mlRevaqLkyZbRMWjkD6+Lg3KS8KRghkSJA=
X-Google-Smtp-Source: AGHT+IGAJkhlBfG2CKT06QC7y4mjYnfFUhJwTLNBtPVcIKi9pc7xcY/jG0JFUbXbt+Xke0czdy+XHA==
X-Received: by 2002:a05:600c:4e41:b0:412:b53f:99e4 with SMTP id e1-20020a05600c4e4100b00412b53f99e4mr1373760wmq.40.1709209225925;
        Thu, 29 Feb 2024 04:20:25 -0800 (PST)
Received: from ta2.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id dx14-20020a05600c63ce00b004129f28e2cdsm5009121wmb.3.2024.02.29.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:20:24 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	semen.protsenko@linaro.org
Cc: alim.akhtar@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	peter.griffin@linaro.org,
	andre.draszik@linaro.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 1/4] clk: samsung: introduce nMUX for MUX clks that can reparented
Date: Thu, 29 Feb 2024 12:20:18 +0000
Message-ID: <20240229122021.1901785-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240229122021.1901785-1-tudor.ambarus@linaro.org>
References: <20240229122021.1901785-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All samsung MUX clocks that are defined with MUX() set the
CLK_SET_RATE_NO_REPARENT flag in __MUX(), which prevents muxes to be
reparented during clk_set_rate.

Introduce nMUX() for MUX clocks that can be reparented. GS101 SoC will use
nMUX as there are MUX clocks which are dedicated per IP, thus
reparenting the MUX will not affect other IPs. Exynos850 can use it too.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/clk/samsung/clk.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index a763309e6f12..75e2fa8d7da9 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -146,6 +146,26 @@ struct samsung_mux_clock {
 #define MUX_F(_id, cname, pnames, o, s, w, f, mf)		\
 	__MUX(_id, cname, pnames, o, s, w, f, mf)
 
+/* Used by MUX clocks where reparenting is allowed. */
+#define __nMUX(_id, cname, pnames, o, s, w, f, mf)		\
+	{							\
+		.id		= _id,				\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.offset		= o,				\
+		.shift		= s,				\
+		.width		= w,				\
+		.mux_flags	= mf,				\
+	}
+
+#define nMUX(_id, cname, pnames, o, s, w)			\
+	__nMUX(_id, cname, pnames, o, s, w, 0, 0)
+
+#define nMUX_F(_id, cname, pnames, o, s, w, f, mf)		\
+	__nMUX(_id, cname, pnames, o, s, w, f, mf)
+
 /**
  * struct samsung_div_clock - information about div clock
  * @id: platform specific id of the clock
-- 
2.44.0.278.ge034bb2e1d-goog


