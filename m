Return-Path: <linux-kernel+bounces-25086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED382C7CF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB6128524A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5A18E06;
	Fri, 12 Jan 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efRdDqm8"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87D18C28
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbd6e3795eso5412615b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705100649; x=1705705449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7qtz6QdtoP8S0o7HHWZE03iwDGuSX/EUMpLPmn8nUU=;
        b=efRdDqm8ITgMXTBV/AA0+gowby9kmqDhSlr1LU5GuNXarsSYI5sy6rCFk/zupLTH0w
         SiG5xxSgWMcDs4lEnjorhskTc0nkX9omH5gTiACB/I5cSkM2AOG7TGbXXS6BWNP0/XbR
         D8r54Oz8HAkPANifzlNG8NT3OWy2KHBYI1uvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705100649; x=1705705449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7qtz6QdtoP8S0o7HHWZE03iwDGuSX/EUMpLPmn8nUU=;
        b=lCovea7JjpXToSXbrxACUxuwi+BXOZZnV6v9CVXsjIY+RXAZd7/VtRw97xfxwIbdrk
         SVusmCOuxXnb+uBsZKZUiVYW295m7NcB6RAkZW9ILd8BtEkdxdI7cZfvFYvm5kaHj3UN
         Suvf3yZO9c9vv/+IK9/+SApKNCv/1Y6R42DoatpaD1mfvntOtyCDYGOkddT5PCTJ0+oT
         E/Uu9r0EfuBVs7jf/jDmARvTbSRdA85nLQTO2gzTATbKjISN9lqX9CcrYIjd3YxwXVRH
         +u9QargtvqvISRfJFedKYmfGArWa5YcbHpVV977Q0ay9VFRuKlOSQM+ctX5vl7CsZ85T
         tyRA==
X-Gm-Message-State: AOJu0YwOGBshx9zr8fjtytYK/oXBCBRcIGll8/gObkKFYWxjK9PUDcwI
	7w1TbuowZpmyOaavVKgtM7guVKgZCbzx
X-Google-Smtp-Source: AGHT+IEjZrhsp27LYHk0t8+/pkaBORsXAC1es0/wqI168axSz0VmgPaj73/RXKG9OcZI7hRPFyq8Kw==
X-Received: by 2002:a05:6808:221a:b0:3bc:2a41:953 with SMTP id bd26-20020a056808221a00b003bc2a410953mr2203254oib.83.1705100649177;
        Fri, 12 Jan 2024 15:04:09 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3e64:3a29:441b:e07e])
        by smtp.gmail.com with ESMTPSA id fd41-20020a056a002ea900b006d49ed3eff2sm3678612pfb.75.2024.01.12.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:04:08 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Stephen Boyd <swboyd@chromium.org>,
	linux-serial@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: geni-se: Add M_TX_FIFO_NOT_EMPTY bit definition
Date: Fri, 12 Jan 2024 15:03:07 -0800
Message-ID: <20240112150307.1.I7dc0993c1e758a1efedd651e7e1670deb1b430fb@changeid>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the docs I have, bit 21 of the status register is
asserted when the FIFO is _not_ empty. Add the definition.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/soc/qcom/geni-se.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 29e06905bc1f..0f038a1a0330 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -178,6 +178,7 @@ struct geni_se {
 #define M_GP_IRQ_3_EN			BIT(12)
 #define M_GP_IRQ_4_EN			BIT(13)
 #define M_GP_IRQ_5_EN			BIT(14)
+#define M_TX_FIFO_NOT_EMPTY_EN		BIT(21)
 #define M_IO_DATA_DEASSERT_EN		BIT(22)
 #define M_IO_DATA_ASSERT_EN		BIT(23)
 #define M_RX_FIFO_RD_ERR_EN		BIT(24)
-- 
2.43.0.275.g3460e3d667-goog


