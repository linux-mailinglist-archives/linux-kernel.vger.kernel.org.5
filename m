Return-Path: <linux-kernel+bounces-163577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0408B6D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15101F23426
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49D61292D7;
	Tue, 30 Apr 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzYThJ4z"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7115A127E30
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466984; cv=none; b=rONZTduSdhDUWedXTxdCjVpHefvYH1RIVTNUcKVxLRuarOuBGkHR7gTa/uEqXhC9Bou0z5XSFKYUrJChJIXfXICCCOL6zT6zcmt3fqCzHUFwS5mBWsVrcGu0QE9x+RLN8FnN7UanCzXqc+OrTX3NDIjfItb8uLRM9NI0rYm7t/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466984; c=relaxed/simple;
	bh=whBrFCn2ZJMelUxny/X0zP0mtodOHx0u8mad3GretRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUnZZN9Ib90+qmb110431+SQDg8H+M1RcsAS+10yBh+aXfcpniSIay6Zm4juw8y9VhalH4BKBSjqlkxcvggESC6Lu/r4nm8G4HG3/RvvtZ5ws/b5HkvdnkrM1VRVWX0icLjHD+/lc5y+z/CFZcxi4oMUMrMx8sPodpev3FQZ7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EzYThJ4z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so62239231fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466981; x=1715071781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAVaQkyGi+dcd5QQZoQH7lMz8NhaO4AcFJrwdOegWLw=;
        b=EzYThJ4zIiy4Vh0MtljqnVmDWtFjrj8nnyy1XlNhQGuv72NlOaf/4kyOaSNKwWTY6y
         aXxm71OzcQPsSDTOK4WS0DXzx8Kct3xQIQCOMJh970hp5NgY8nIflly65Ki8FodkHQul
         qm9AL46v2Y5YilnGWOKKK2WejUrgh29PjZKnKcT7tv6AmU3B8QOcwcdfDgq7s92V9bLq
         Zaie0Rhvfktk8VvBtCNrGibS3YaKWvFS7tWzsW0Sb6eGciNTTXbKGzWwFlVYpkk6kRr9
         z+TZRfmeCxuzeImp/ISn1pDEKIQ/L73bdutakwRMZ0SzRTqcdXSKKoYF6FM6tF/KTnlt
         e5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466981; x=1715071781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAVaQkyGi+dcd5QQZoQH7lMz8NhaO4AcFJrwdOegWLw=;
        b=o/YQDCpC9F4dP2/NqRVJAoFPPaQWjHNB++f2xmtm9oG5eRK6KGkwy/CsO+Ld5ZPy0j
         3vfLk4HqJ4BVUkZWdVb6ly2zQ4B5OCeKDNsvzD3mLVdkiBBwUeczbqh4wo/8Em15XLOZ
         C8KBW3l/EVM34lXnXoHnAoONVxeYC5uNUCDx6hszP7WLQHwteIFtr22JhXGz3dV+2OpL
         vxGVXmh5Y6j0HD+glyOYSrCY0FikxxsABo+90phn69Aokokdo9crw8mcPzB9i7G2NpR+
         PhRSY9tU8TYDkn0NEuJ4GjXid9JqAPmBlmAr7sMQYUvJZtYcz/Kat6AGTiPYS8QkYAks
         BQhQ==
X-Gm-Message-State: AOJu0Yw87gkEF4XzMzaxtD3KEPGyoHx5nvSPJsPjSvUopKy1kGT9le6g
	98hcZKrdANA5wtPJeShA279AgV6TquCw3yKRxInJdtFqd89qd3ieE9HDHeF/Q1Y=
X-Google-Smtp-Source: AGHT+IGKTayhivqDn2XP6Dh38GcPve4XajVnSsNjZbHShLaw/cwE0KtV8orWe5ibDMLjycgw8rmA0Q==
X-Received: by 2002:a05:651c:153:b0:2df:6cb8:c911 with SMTP id c19-20020a05651c015300b002df6cb8c911mr6849342ljd.24.1714466980548;
        Tue, 30 Apr 2024 01:49:40 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:39 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/11] nvmem: layouts: sl28vpd: drop driver owner initialization
Date: Tue, 30 Apr 2024 09:49:13 +0100
Message-Id: <20240430084921.33387-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=90Q2eLm6ZQo08kKIGlLE4sE8mRn3e+jbkOWrjELX9e8=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCMXYGkKC3FtvsH+dmAjOeyOrk7JhcnMSbak 3Iizhqpu0yJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjAAKCRB6of1ZxzRV N3HdB/0UiFCQ21tDkPkhuV20rOIC+fyZbmjTDR440lSJBnhX6IPiX9jXRCOBnaIZiLp/xKENlja NU+5IfdDLto202SgFrG5/v0iUITZ89hF15wON0XCX9Elj009l53pjEndIHhaF2JphO/xzE/fvy5 CdTUI+Zu51eNvD0BCvGyieHckXDC4HiLiQeE15n/pihfl0lyPDBm9MfIMIqGBwGtNJM8YvlirAN PhN6YM4u2cMGZ+rqaUupVDP5h/tvR/BYo4Nx6fny1lUvNb4GhH+Pj8UcaXakXJE8060RJf6P8fb weA0NNFJjyij6eBeVpQ9+J9/Np+O9Ul37oLwvuFONNZ54Et8
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Core in nvmem_layout_driver_register() already sets the .owner, so
driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts/sl28vpd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 53fa50f17dca..e93b020b0836 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -156,7 +156,6 @@ MODULE_DEVICE_TABLE(of, sl28vpd_of_match_table);
 
 static struct nvmem_layout_driver sl28vpd_layout = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "kontron-sl28vpd-layout",
 		.of_match_table = sl28vpd_of_match_table,
 	},
-- 
2.25.1


