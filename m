Return-Path: <linux-kernel+bounces-41496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCDE83F2D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DC91F22449
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7C3234;
	Sun, 28 Jan 2024 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nk84Iplo"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68B15A4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706407944; cv=none; b=LW17oFu6n/erm0r9rC5jRQjOnDg6zmceyOCFEfK/LkpslL2O8jVkKje1NnCgV7Z1ee3GKj5C6VWoIq3I868yiYfCVNf0mdWn+RLJWNq1mQe9p9yWYNSn9WD4zKLPVxNMbVp3RCPs7jFARosmQdp4XoZqyxJNasDDpW9ISOuj3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706407944; c=relaxed/simple;
	bh=vYXWXYwsJVuOt1QS9UcPPIEtBivA4uOaogtA5hEmjCI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j/SlTfLf/UhOx84D/tp15j1RNI5hLQozU0fuagXf95efapzsoZOKGzdQV+J+38HDRMfyxWKL8+DzCVvLTh3Mz5qbvEq3ss3exzxZkvr5MouUIVQ6zfCAgDtCzTFW7t10f17q1bsbHVfl47Y1/FPaOwq2RhISxQH4AAYsbNxqBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nk84Iplo; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a032cf012so17548301cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 18:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706407941; x=1707012741; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Os4wPtYXMOk5j6YcX2wbCDq2BXooZiO0dAGB9kYAD7I=;
        b=Nk84IploiUS1g3vTp8Zj67z4vXSyo/gP1kIxNlaj6Kk+4fj0H/7IlSDq1bpxg0V1zN
         TJO0S4B1eyrBfHjxLfm15+sjmYwis8W9/Yuzz2kAc5yfrLsx0cBa15RBw60yu3SOjgYj
         9H3f9iIdDxhIxFaX7dQJXWmjfmzXJhb9SUgRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706407941; x=1707012741;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Os4wPtYXMOk5j6YcX2wbCDq2BXooZiO0dAGB9kYAD7I=;
        b=redEPWm4o3iR7mOcRMQdX3wHVIwgptQC2LKGxOgla+oy0FqA1btCUWQS0479qlhqjv
         73LvSF56PFbJs8bfmKKRAxThBg2SaMCdYU+vIJPHYOFzWawtTb+uwr5CT9OmENAEC5MV
         UfC06/Y2JBhF6cHqivWawrrmfQXDUef5merPwM3HDVEyekCtaDGWtbz5PoEbCgTEFZXF
         59qYNw4on+rbAFCZfAWGPGlnH2i2xJgezVCGulq+N+uWKviZtEl0RBph4YSCNi7At1GW
         MCATU9QF7/EE6CqXnRk/IxPHRTJP68iEXBSlpuIxE40r5V017QYL8OazAIXqGFNG0JsA
         2oaQ==
X-Gm-Message-State: AOJu0YzqICKI3pqx02POHADriY2ARc2FofbfEk1sU07Lm7GCV6x/ZwT9
	Hy8IANQmf+DS53SeEdOCatV5e+a9aF9x78KB2mFpMKW/l6F/V8CGdxFiF5/42g==
X-Google-Smtp-Source: AGHT+IH6NXk/WvjaiaDj9r8/fahbRrGy45ANWovc96JmRb+SX77746RDy8yuddFdapSADOOCEgbhNQ==
X-Received: by 2002:ac8:5e0c:0:b0:42a:2ec3:e8d2 with SMTP id h12-20020ac85e0c000000b0042a2ec3e8d2mr3154130qtx.50.1706407941471;
        Sat, 27 Jan 2024 18:12:21 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id ka23-20020a05622a441700b0042a98bf0117sm568061qtb.78.2024.01.27.18.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 18:12:21 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] media: Fix warnings building with LLVM=1
Date: Sun, 28 Jan 2024 02:12:19 +0000
Message-Id: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAO4tWUC/x2MSwqAMAwFryJZG2iD+LuKuNAaa0CqtKBC8e4Gl
 8ObNxkSR+EEfZEh8iVJjqBgywLcNgXPKIsykKHKWGpxlQfdrgveUwwSfMLaWerIVHXjZtDjGVm
 tPzqM7/sBzrWH3GQAAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Mike Isely <isely@pobox.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

LLVM does check -Wcast-function-type-sctrict, which is triggered in a
couple of places in the media subsystem.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (3):
      media: pci: sta2x11: Fix Wcast-function-type-strict warnings
      media: usb: pvrusb2: Fix Wcast-function-type-strict warnings
      media: mediatek: vcodedc: Fix Wcast-function-type-strict warnings

 drivers/media/pci/sta2x11/sta2x11_vip.c                           | 5 +++--
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c | 6 ++++--
 drivers/media/usb/pvrusb2/pvrusb2-context.c                       | 5 +++--
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c                           | 7 ++++---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c                          | 7 ++++---
 5 files changed, 18 insertions(+), 12 deletions(-)
---
base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
change-id: 20240128-fix-clang-warnings-6c12920467cb

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


