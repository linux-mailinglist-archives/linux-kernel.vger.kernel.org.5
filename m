Return-Path: <linux-kernel+bounces-125880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBEB892D5E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57FD282C53
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1483843ADC;
	Sat, 30 Mar 2024 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2eWEyHx"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977508F40
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711832251; cv=none; b=Qw46E0XT03KJXSscZyzP3q7F8UrF2+CARE9yW817n9LK9goAUswzTfQ9IKP1XSya4+IekrH/U8k5szNhiuhOGnKPreuV5ODebZ/WsYlvzGZ4706zDIk7Yy1Aug9uMd7bUENrt7m4HGku22K3uK0fepmSW/CWRpWnSDso1sdBSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711832251; c=relaxed/simple;
	bh=EsW5PlhNZA4nrmCzHQvVnRmu8IhwsHdjmZw5KyUnzq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLRCg1x8ha0LWWjCkmF4Whw8l/lZQGKNHo42zArOQTn3WKOMYvz8696okH9C6q0RXXTsOR8oX+lMmPBBW31C7MGjogMfRV6p9FNvv/G9YUk04oEGhuYrgWcw5IDUB6dhm/PW0rsIpcawVjc0ALASRsn6TsasABhXU/Dm77qEEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h2eWEyHx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41555c45497so5829275e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711832248; x=1712437048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOcnmbZfU1ZiQoZSbx6LjXgQfqNdNpX1u85iKsWkJ+o=;
        b=h2eWEyHxPUiRUSMJtyicXqrqwwzrNtW2vDfz1KTPEZ6v3trWnsMatiZcmtEnaFQOA2
         6urT+uN6r2WfwXcHn74m0KDL4pIy3vx0++Dhs6I0f/OifMtqNbkB1pEwraMVTLH6M8SA
         gAWoXroONklTUpD59dswEfP9xqidATOvj7CD1x6/uADqrHSTB0M7EujS/qQ4hTFuNwEs
         0C3maPlGTH0kVIz9IjzYav2iYhEA8yFyHHQGR0iRj7lsqzTWT3266ZkQj0kMoFjah+Qj
         TWwerzyEuEIuwSJpqOps3JE9FhQa11Qat47Jrk3orK/nQ1BmGYiSpawz6lro6T6R2j+C
         jhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711832248; x=1712437048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOcnmbZfU1ZiQoZSbx6LjXgQfqNdNpX1u85iKsWkJ+o=;
        b=Pn+p5FacJjVJ2l8uXo1PRGnzyZa8eWecIG3tjVmziUN0zEk3TqbcumczJUODWRHqxp
         JSzegmGZIlbIr0wM7p48C2ZpbqvAOhK+ar/PuF67EfNWKZppE/UddP24blZuNSpzckc5
         CdEP3KMlI1I/JVkRu8/H0QfVgCere2lj3hoshlW0iT45wAHDvG0ZrDrZ+opseOp89KO7
         99kSbYCyd/C2JzrqKm7IiBiMxbCCrUbrQp7ksTD2FH0hYHVTGCyv7ToJCeL9KB2RqHoc
         0aaIX0REfuI60BoeAkrjgso6/4RajNxdxSHYpGFxl4jVVIZeiwfDSiBRQ2KLyCqex8uN
         hQjw==
X-Forwarded-Encrypted: i=1; AJvYcCWKy6cw7fgKNfagXdTlGu236/pTAgZZ4GtGfBoRRe5qn8ij6nL8zH/Vq2im4IVFkHqHdVVAkU/IBptF5LNZiIVdqOnQD/NxUqadDgFN
X-Gm-Message-State: AOJu0YzynRN3Esugz1YrVIa3jIK/zE49h4x63flvch4vAPGgC5ncsXsS
	AXtgm1YlZJQm4A/x0FuTea+qS2hJHTn8NdefH+qAIsfHI/0cXbZgxyawW+imKls=
X-Google-Smtp-Source: AGHT+IEacBpcrAN0Ls7+iM21Siwj/4TlxwR/SuY/ASdUZKiHFJIkasN4tmpfSt6yVMGmanK2stqDnQ==
X-Received: by 2002:a05:600c:558c:b0:415:55a8:e1a6 with SMTP id jp12-20020a05600c558c00b0041555a8e1a6mr2208719wmb.4.1711832247884;
        Sat, 30 Mar 2024 13:57:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b004154e48bcdesm6295786wmq.14.2024.03.30.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:57:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/6] drm/sti: hdmi: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:57:21 +0100
Message-Id: <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

I forgot two drivers.
 drivers/gpu/drm/sti/sti_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 500936d5743c..b0d84440a87b 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1485,7 +1485,6 @@ static void sti_hdmi_remove(struct platform_device *pdev)
 struct platform_driver sti_hdmi_driver = {
 	.driver = {
 		.name = "sti-hdmi",
-		.owner = THIS_MODULE,
 		.of_match_table = hdmi_of_match,
 	},
 	.probe = sti_hdmi_probe,
-- 
2.34.1


