Return-Path: <linux-kernel+bounces-32976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1398362B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2ED1C23647
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621893AC1B;
	Mon, 22 Jan 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSjPafiN"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05926AD5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924642; cv=none; b=DHw3KXoIV9W1NXRG+/QE/NJZKx0RVOnqaYf2IFcrca6b7N1KRN3KrTBclXvYp7cv2ggH28txEx04aUQfNyge6Lqa2f3XTrA1ofaVDaWVtDQZ6BlFbPX5iPxSV36rWxcCpODjC78FLa93cNs+UKZEhk2ex+SI0Z1lx1uo3tS44IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924642; c=relaxed/simple;
	bh=tsbrmP1+O18HOPGSjrHTKuZbGshwEn40LJCinS7VhYI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DzFagk/fGI0fj8Yzjgj8X+3oGsYDUFa+iG6QjW6kpOXoH6jtJ8GefktAAPXcsxDCoy0KeND5y7ekoBlA5jILuaQq9rR6yZqLquUrNt92+9ajCjX21W6Ks0OkFPu2qKcpL1pD669TodNKJMjNw1FwKB0YNTG1uUqO/Quy0yyzm5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PSjPafiN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a29058bb2ceso277073966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705924639; x=1706529439; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmH8rXJqUXY/i/aOBMn68OVWCaEf5ZmAXSQpd6FELw8=;
        b=PSjPafiN7jWLdXnrlyds98QXnpIZ8K8oxpSmDpYnS4tq31yKX72M61QplFMsk6TyS9
         idUK2Y5mqAMqDU+//BfIQQxdodKa0bm4EfHFqhVPMzEYtQ2pajST4qHf5xESeJ4OfRWn
         eGmn2uMwj60r53z/vys+H3uraB7+V6m6JQZM+cVD1b60/UF7Ef8tY92JV3yFY4o0+SIY
         rDjMg4NBCBtkD0jpymrxfmRDulrgYlEtZ/6qYbNNkBGH1YTtyXHNaoe9Ub1L1DOTfeES
         B9ORElYxZ8LPvx5hRfSatoEOYA7c2iLnig39kYwUBKz3B2KYvv8hQTjDe6utSsyjbLl3
         eGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705924639; x=1706529439;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmH8rXJqUXY/i/aOBMn68OVWCaEf5ZmAXSQpd6FELw8=;
        b=jYzXTiMuMCzs7V1yQQaciOvyDH6/eMDtRQi+kfjspw5j5ta3ioEiXYw0fbzEOpDb+O
         y//ymZtNKLC++xe206Gl0X0WCbT+IJ4V4W/T23qfzlRGqWiBrK0HPR0nJX6gNkr3OKsm
         HoEuRzqyLwcOInv0M+s9NN5u7EY1E/U1Ot2Ot/9TXF9CWHE9eKUEGQ7crF3VESTyIYaj
         mjS7kxDZ+PXJ252Q14cgC/UfoKPT6mknvMv7SdltdsMKP7U6tcXQKkosfeC6UHB2RKhY
         cm+RFJ+n0QHPAbFzoJxmHXx4RoFVxTXhjSW/amu8EjiywGGw5dmtaSfxoCHRojosD1j4
         mUYg==
X-Gm-Message-State: AOJu0YyWYvUHEjRafGY0h80AExdOvtyGxxBW8GhUK1SK408vOCGUoczq
	U/qpmfvNTU8nvZrwYfLfMd3ierK3hM8roY8plyK90SRg6G4q0bz1ejRSQjads7Q=
X-Google-Smtp-Source: AGHT+IHKZPYkFC9314WpcTSOIuVlAzqptNC+bZeUMyszvkcPbzvVLtDAdNhgyFoHYu3/qtjtR7hIyw==
X-Received: by 2002:a17:906:c448:b0:a2a:a4c4:5229 with SMTP id ck8-20020a170906c44800b00a2aa4c45229mr1231745ejb.90.1705924639386;
        Mon, 22 Jan 2024 03:57:19 -0800 (PST)
Received: from [10.167.154.1] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id k3-20020a170906a38300b00a298d735a1bsm13481349ejz.149.2024.01.22.03.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:57:19 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Remove QDF2xxx pinctrl drivers
Date: Mon, 22 Jan 2024 12:57:11 +0100
Message-Id: <20240122-topic-qdf_cleanup_pinctrl-v1-0-0c619ea25091@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdYrmUC/x2NUQqDMBAFryL73YBJW2x7lSKSbNa6ENY00VIQ7
 +7i5zyYNxtUKkwVXs0GhX5ceRYFe2kAJy8fMhyVwbXu1lrnzDJnRvON44CJvKx5yCy4lGSeD7I
 dxnDt7gHUD76SCcULTvoga0o65kIj/8/gu9/3A1a2VICAAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705924637; l=720;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tsbrmP1+O18HOPGSjrHTKuZbGshwEn40LJCinS7VhYI=;
 b=k4G0Vxq2PK79h8IRxX6rBTWSZfrg962X7w9xIpHP0Cp3uP/+FXkolaSwdiPnr/h9nVCcfTeMc
 MSIUtuT9/MXCFFCBNqOyzFMHYR5NP5Eo61FxohYZInShnvKl/2VV2+N
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The SoC line was never productized, remove the maintenance burden.

Compile-tested only.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      pinctrl: qcom: Remove QDF2xxx support
      arm64: defconfig: Remove QDF24XX pinctrl

 arch/arm64/configs/defconfig           |   1 -
 drivers/pinctrl/qcom/Kconfig.msm       |   7 --
 drivers/pinctrl/qcom/Makefile          |   1 -
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 164 ---------------------------------
 4 files changed, 173 deletions(-)
---
base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
change-id: 20240122-topic-qdf_cleanup_pinctrl-98e17cdb375b

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


