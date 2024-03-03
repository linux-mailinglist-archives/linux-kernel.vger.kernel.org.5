Return-Path: <linux-kernel+bounces-89790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EEC86F5B4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08E6B24044
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7DF6AFB7;
	Sun,  3 Mar 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Qt2//bnh"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35967A19
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478097; cv=none; b=C4jUUOiO1yFcS9oq35frs17tHcGxjxCnwoPkCaDWvnx4HaK9VmyNmJx1SbxWtG8sbDntUBF/28RjI13X85TR7Py4M6Vfs7INdXLr1wxABnH2bbFxJu/XR6w9+QCojk/r4Da4kov+lQrWp/AIQcP2yS9agfX7zWeRr1VtF6T7bzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478097; c=relaxed/simple;
	bh=BUOiJMJAEpUEY/4J8P8EFUX7DemWfjIpSlIVs71qurE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGD/v6dnTnvrfy97xdXyLK6GPRvjqlppdZ5sCeu6X/Ulab5g/52EqJy0eQrnaE8FTKUY6PeEmCKXV1Vtj6JBmrbkzO21GHvGrGsDeJ6ksqagvImAIUsZONLBHKlKoBks02xKwq6384uzBYS/IRs5Pw9wA6s59gAspvVRxbLGCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Qt2//bnh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a450bedffdfso63009266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709478094; x=1710082894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L12WZQfIjPLa8ST8Z/BOMDM6oqnRCJHCQVsMSwzBc0M=;
        b=Qt2//bnh3TZAGI+9m51FSvWPjhRu3YnmakxQix81idiR0cfKUQUpwVGxY1I3TTXgRS
         BHFV8PnzZpBKTSw/CtTeODNwM9PyfBkWo1UDYrRTrCyHLMNPbE8KaxpPacW+AaXO4Sfp
         JRsjFi3fdoAn3FcknjVrtP4WHSEe44hq0uM2VHKMYxC1uJ2F8rtZl4HpklVaddAzWdNE
         Ecfl0H3Q6jJ1j8p9L1Cvcg3JwUgy3ukekthDhar5JPV4hxupobyCBJ9iuzyUByqAoUrC
         602IafQhESNUoomwdYoWYLwcML52syDaJwLTrWfxN1fJjFz4vM6rlqNW4qhe1g2TmSSA
         LzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478094; x=1710082894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L12WZQfIjPLa8ST8Z/BOMDM6oqnRCJHCQVsMSwzBc0M=;
        b=gQ4bdfUefMXDq6Hl8yR9XVKuop+gEzq1zbcvu2DZ5TwmNrFFD9VhLZADk9N3N5og+4
         TL+IqyPn0qOuC4UGI6nyct+97cPKBVCWsy2W15oIfPXoxnRg6UhrcFGF5KY66JaS/fyi
         Xhek+qf0Rhke7HfArv1mSef685fbLWvGtAWHTKa5QcjjC6bixiC/A5PL9lf+onNiec6E
         CdCTwrGLTJON1jM9B4fc7aRHDe4vlCIN43vo+u7GEBlBgh5CwdvBdEDza6MlWlFqjKua
         0lhTGZvepa78gcpCyW5IqWdDAkcAWy3L2D6ys6ZFRrMpDRK1R+c7O5+LVp7ndhwgJsjv
         9XyA==
X-Forwarded-Encrypted: i=1; AJvYcCVXTSXSWPWo6zeHH/JpVKe1YUbidF2O2QaPQuVD4If2I0Y8/EdtgGXXdCGoJb5d+WMbjbsPXPKVoHHkxGqgRanJ6FYhKdME1GPyP8QA
X-Gm-Message-State: AOJu0Yx9WllXAjZ7PD1GI08sW/AMjXxNp5/vFfbjDgHvrsmVf1+J3XB5
	RfIy/mdFNM2A8H+JqbeoGFi/QnXnUQ4Ha0h4i7xg+BYKYmrN6JqrY92KPCrGzn8=
X-Google-Smtp-Source: AGHT+IHW70cWGZpmNZWU3rtJ73z8LCBjIZw93+By8b7kiMvBnTYxyj+8PGipVGYRTU0OyQfXajoSsA==
X-Received: by 2002:a17:906:4f0a:b0:a45:46f8:a181 with SMTP id t10-20020a1709064f0a00b00a4546f8a181mr125275eju.46.1709478093972;
        Sun, 03 Mar 2024 07:01:33 -0800 (PST)
Received: from brgl-uxlite.. ([77.241.232.10])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm3740293ejb.130.2024.03.03.07.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:01:33 -0800 (PST)
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
Subject: [PATCH v8 11/12] firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
Date: Sun,  3 Mar 2024 16:01:14 +0100
Message-Id: <20240303150115.133633-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303150115.133633-1-brgl@bgdev.pl>
References: <20240303150115.133633-1-brgl@bgdev.pl>
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
index 811f93edac7f..fbacc959b6fa 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -566,6 +566,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
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


