Return-Path: <linux-kernel+bounces-125864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F542892D38
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B1F1C20D93
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A635542A93;
	Sat, 30 Mar 2024 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCXk3kiM"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCE8F40
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831411; cv=none; b=gvtONBArJTSb/206aPzkJzc87NjasJzZp5HkdGqDPK0cQKLyP0nyNPnah5k0abRA3QWWxvWk7MOWsB9mLbmXFmWooeRRg2SGa+rNKJ4g5EuAB440qNxFcrFxF3qRMmgDRCoOHIl9g6ov8KhN7vwBcHIK5mJa73fUBWhLGUQeums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831411; c=relaxed/simple;
	bh=5hjA386zwMlffmMn4NRghhyylnCA9pQb83mqNAD1Gws=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o8ymPFJ91PJwrBTiV/eNBRV9pvARGt7umZlU/jeJMoe6qnrTG5vauFJ3YNHLf7H97vGmIGfonKTr4iebC5cpcwacrf5oU0+6p4rrsD4hqMoAbHkeWtB+m3sYywGDRP/iuUKn9DOU+BnMj+vuVGmMfjpQH7y5DFrst7FqR8808Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCXk3kiM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ddd1624beso1813908f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831408; x=1712436208; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7N0D7Kjfk0JATRsxflDv0tI3CZgim2NBK8j/8+EBeA=;
        b=jCXk3kiMjB4k9mCAnqXCTPs0StJUkz3sk/F1pP8ZrY70PhxicgMJJVSOwQDBtAGvEe
         fgcoD9uTPqSPyp177bU2xAit4YbP22qvNzqBt5rkJp/RRUjeAElRCQx6Wz0NvM8J4xN1
         JSj8zbzEVA+JIj+qONUyVfOq74RTCpCr+6dn7m6R9tJGo4pvmXs+GLCtp69w3PRdYNxC
         5HizSq+NOPEt3HXU+5Sqgv9dJLQPAxqkj5Bzv06qBPlrKplNcguEJw57Eftspj/MfyQL
         jYjwjY2JyfN8s3OE0VUIdacOwmSvVoJy1G1OVw6PGho0dUV3XMzEPXDi5h2x2YKBpmeY
         tJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831408; x=1712436208;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7N0D7Kjfk0JATRsxflDv0tI3CZgim2NBK8j/8+EBeA=;
        b=waOJdZ0C11h1ghDzf58mtSvLuZtSTGPnzAaJFWiy3DjPihMnKV9IgW74Rg717bBiZs
         GCpxuc2X3yylsIbBt7HpHiBv29qoCZ8lfJvILwXEfVog1c8U2nj2UM6fC66ukLTrfaNY
         0T5Rex2e/a/zTuPPu0GdzCZCeNRNzu1C1Ou4E5ltofjcpHqYp8iFaHmo0GbL4UcvcyYI
         9wtOCQICh/Ed36Q16K7VRySHmGJ05WCg2QBNokgYaXi5ki6JWwm2XmnYT3FO60kWQ5S0
         x2K3tzVEJ6gLqeXpX/lq87+NR61+YuTqoNfUqn7kQzxqGjjU6+QevBAm8DWRzjq/rj6u
         DIjA==
X-Forwarded-Encrypted: i=1; AJvYcCUjNJ5ZZGmFQjMT++yTDec0/p5FUI/oQ9c818gyOoMiyNmiBMiZKSkW25iUnmxmssa56HDJDytAHgiuq6eCqc/eGEVB9ft4RCIS0CmU
X-Gm-Message-State: AOJu0Yzvg1mpYt1I+hx6roNQpL4XJ/iGYWJyVbKWs+Iweo8FM2sdXcUC
	tSnvsnkJmyA7z7ifhc5/RnYOKT6/upLX7Ebr8uu4hOBybYqaaZjvLnLF1YfmfQ1qhmZ19WhFl3V
	i
X-Google-Smtp-Source: AGHT+IGovvSTbspKm9/uX3uiFBF3Rzq6mLU/EqERkjT+y/Op/qBmj/dbGtOoq0wlVWRETE6RaWnnJA==
X-Received: by 2002:a5d:6043:0:b0:33d:8c9d:419 with SMTP id j3-20020a5d6043000000b0033d8c9d0419mr5302058wrt.24.1711831407999;
        Sat, 30 Mar 2024 13:43:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/11] drm/mediatek: drop driver owner initialization
Date: Sat, 30 Mar 2024 21:43:11 +0100
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF95CGYC/x3MQQqDMBBG4avIrB2IUSl4FXERm992aJPIRG1Bv
 HtDlx883kkZKsg0VCcpDsmSYkFTV3R/uvgAiy8ma2xn2tbw3HFIfn+D0ydC2WvgAC9uw4ud620
 /38xSUiqLVbHI978fp+v6AXV4FlBuAAAA
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5hjA386zwMlffmMn4NRghhyylnCA9pQb83mqNAD1Gws=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHlky5Ab07wRdqkTCAV1panAirUB2C1L0ur5U
 OVvafL4tMqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5ZAAKCRDBN2bmhouD
 10EZD/4w3np5oImOf6K7LQ7H1fmbPZuL+mTQh94jIgP6B7mi7lCuetbrxbmX9ijN8D3RvaGfH6S
 V1+KbFL+cj9L7V76xfnKzZIvbLSKwXqZdxpg6cQqhiFko8NA7d2OrH7Vi4ObyUEGYSuYoZ6s3qK
 U0ZwJlDue5FA1BWh3GmIjkn/tEiDRb5ALIHn2asHTZlqsBn3YN+N0CtSlB6dIFkWmvNa9e9Ewdz
 k0U4Fw7hGPH8aQMRbV64K5ykBTKhpyamK5M88gmp/yDN5JVvr7r+sZJi68lpORSr5bpHGXLU1+Y
 dCYrWy7fPjLbURMCm4IQcTh3bKafPXM3E2gNH+PMz4Bn+iZcgqrBhj750Psn7QTplIwawfFQTQf
 b7jk8TRAVjRiA0FaVx368uEBGtBJKWX2lllipHiiTYkhvPOYvyVPvdc8FDxebngkxuAxDcBaZok
 +soCitosPhDTF7SPeqHqBuuS2OADZzJEVINvuXllxkAZ2EewnUrgj281B0BYhmto1ZX6nqb8tZa
 esoGpfD6kOCoK5BIQUZMPd7CNV6KTXyXzDpaqq1nvwnt4W4KZMn2dEuEmCmZ+g47R4MP6adIfxg
 bJam4PP2V/8geJx70BJY7XJoWix1UrUwTVAtpENs5W1iKjFSggoGibqIHJe6cEQa8/LPMH9s0Xq
 gDCpgluIJFYRuBw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify the code by dropping unnecessary .owner initialization in the
driver.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      drm/mediatek: aal: drop driver owner initialization
      drm/mediatek: ccorr: drop driver owner initialization
      drm/mediatek: color: drop driver owner initialization
      drm/mediatek: gamma: drop driver owner initialization
      drm/mediatek: merge: drop driver owner initialization
      drm/mediatek: ovl: drop driver owner initialization
      drm/mediatek: ovl_adaptor: drop driver owner initialization
      drm/mediatek: rdma: drop driver owner initialization
      drm/mediatek: ethdr: drop driver owner initialization
      drm/mediatek: mdp_rdma: drop driver owner initialization
      drm/mediatek: padding: drop driver owner initialization

 drivers/gpu/drm/mediatek/mtk_disp_aal.c         | 1 -
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c       | 1 -
 drivers/gpu/drm/mediatek/mtk_disp_color.c       | 1 -
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c       | 1 -
 drivers/gpu/drm/mediatek/mtk_disp_merge.c       | 1 -
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c         | 1 -
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 1 -
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c        | 1 -
 drivers/gpu/drm/mediatek/mtk_ethdr.c            | 1 -
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c         | 1 -
 drivers/gpu/drm/mediatek/mtk_padding.c          | 1 -
 11 files changed, 11 deletions(-)
---
base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
change-id: 20240330-b4-module-owner-drm-mediatek-aa525b70f033

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


