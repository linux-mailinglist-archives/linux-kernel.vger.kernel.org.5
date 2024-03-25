Return-Path: <linux-kernel+bounces-116792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789D88AB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D54BE455C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CA41836D6;
	Mon, 25 Mar 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="awcdaXQe"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105B1966AF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361064; cv=none; b=V+myZ87eYTeUrS9izAkkfb5CqOqUuV8g3xSz4x4+Q4MBukg3ayQju1uetxCWWb5vHKtTiDgVUrbFFrPjNfg0RFz0j6OpSoGwZDl3QodzCXYDK7/nAA/TPyyPIDpvwQoQJTnkA8oc26Mbtl1sr4rytiCTetlLi3Y/oLFb0Xs6SSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361064; c=relaxed/simple;
	bh=QWs5yD7pCzhRl7RqY1eyIygDCxtu2ITbSn6PwROjTD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGnIcDpPsYHbV8Xkf/aMZr93tV87xKJVe3b5P4Ov0aIK9PZe3GgC7dJc6OZyGR4u7eBoJOklO2I9L06QJMm6XLo3iuUxEVmJHkmDD0LEO6QYGc9mvmK+yCaMBHJ9AggP2YFW9O1nLpuI3QZtzGCYJBrTTFIyJF2btixcf/HChCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=awcdaXQe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341cce3e5f0so795839f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711361060; x=1711965860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vea42ognBMGcSaAHWG2mdmwkMm3Lc8ado5KZvfpR8+M=;
        b=awcdaXQeFvSmG/GFRsh+dLMO8JexYG9uCvB8cJpIzJY4QwcgmmM85vch2eRfg5o01P
         Q+XsP04eLMnXDSnINFouUB83z4vQGc4zifpUlSdwHxA5LmHaLypyizYGOym6sNSLb75B
         l9bOy1U2HDwoNZZmMm1iesR98B140CM9vQchMBx2YGgBNwKoa44Ib6K5U6SL27buHLn1
         ZCKD57Gd/0wW8bJDdrAOHIkpWtupWAvHcfxy0MyHsSD8Iq5K+v8i7y7zedGUWt3G4yx0
         LxjfhqkmiaEFGTMq38Ykqh8CXQ7OlXwDxch1o2xjyLXXY+zmi3K5kOfrAI6azEcZUHz2
         pBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361060; x=1711965860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vea42ognBMGcSaAHWG2mdmwkMm3Lc8ado5KZvfpR8+M=;
        b=BA2ehamcqjH1YDwkVTMRRS0cF8y9bW8WQI+NA9CEvX6k8rMQ1NjSzSVvS399Ie2bYw
         gEHEewMuVkA5iJu4O5KnCDrgO9p+2OqcRFupk3ZejQ0aY50HPQ9EsA3yi6f0TWse9XrU
         AD9pHfl+j+wtQxa4lfjZuHLqhfJ3X4gpMbl8glt3/0ZsYijT8TAOTaVAdw7177cn63i2
         JFur0ONQrvLTGB7DWhaYXsePtr/3UoQtuLRi5St7m78xn+zDsSGLrNF/C6mIj7sumq6e
         9iAHoC5FXRLRiBmVRMOuU4w6nKGk2YgLbfPMgOVh4Xglv28KZ60SLfjWIzfsIGa1qEXr
         stOw==
X-Forwarded-Encrypted: i=1; AJvYcCWu52PEhehbY7saXG8biWaaS47B6e10dpQ8WYs9He7yjtk6YDDWmH26nbEqvAwgn0yNVU1uZ0zVQM4/MmlCuM+SUTOzEc9Q3tTDGuno
X-Gm-Message-State: AOJu0Yy8gSSaTV0RnWuG/jkLyttiLcbjSuXpN3posUJytfwxumjssh1W
	M/ejnREl+9UgzWMmW71qn8Y+TPlczjuDzQvvgnrYwdBGw6izKU5TVHeWznU0CU2l91AnvMcKy9Y
	k
X-Google-Smtp-Source: AGHT+IHkCZySHrP6x9NbzchPEUB1+eY0Z3c8mhgqYy6D1q3Q3MuEQvHmA/zyMe9GnYYIHuG6ThLpMQ==
X-Received: by 2002:adf:f483:0:b0:33d:c2cb:c18d with SMTP id l3-20020adff483000000b0033dc2cbc18dmr5631688wro.32.1711361059941;
        Mon, 25 Mar 2024 03:04:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id dv13-20020a0560000d8d00b0033e25c39ac3sm9086874wrb.80.2024.03.25.03.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:04:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [PATCH v9 12/13] firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
Date: Mon, 25 Mar 2024 11:03:58 +0100
Message-Id: <20240325100359.17001-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325100359.17001-1-brgl@bgdev.pl>
References: <20240325100359.17001-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The "memory protection" mechanism mentioned in the comment is the SHM
Bridge. This is also the reason why we do not convert this call to using
the TZ memory allocator.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 7a8d67c7b71c..1972757f8931 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -563,6 +563,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	 * During the scm call memory protection will be enabled for the meta
 	 * data blob, so make sure it's physically contiguous, 4K aligned and
 	 * non-cachable to avoid XPU violations.
+	 *
+	 * For PIL calls the hypervisor creates SHM Bridges for the blob
+	 * buffers on behalf of Linus so we must not do it ourselves hence
+	 * not using the TZMem allocator here.
+	 *
+	 * If we pass a buffer that is already part of an SHM Bridge to this
+	 * call, it will fail.
 	 */
 	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
 				       GFP_KERNEL);
-- 
2.40.1


