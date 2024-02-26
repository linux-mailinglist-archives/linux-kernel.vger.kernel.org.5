Return-Path: <linux-kernel+bounces-82068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D5867E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61F01F21ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800E12F59E;
	Mon, 26 Feb 2024 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QKy55Zx2"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324012EBFA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968771; cv=none; b=EprikaYjPbNxq5E8rRamzsOBRr96ELPskBRKG5IwK84fOi4CKEIz1E9XROQnUGOzgM+QKEz9T+9odvV736zs0zGCWLz6y1OWHpqCXnKIduazK4texbvWPdEwx5uoBfVEneIr3n1uV2Pc7u3vSuOH1V7tDeUL3HHWhQersoqBHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968771; c=relaxed/simple;
	bh=w2ALZt/64adjKX506ThshIXHvJN/vMxdfdgFwiM9u6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MgH+0sbjRTkviczjD4CyF+s9NyFF4zU3hfrsZSw2ZUN7U/x0VtZmsrLhlKmxP76GP/2X3GlBseSjmBtH0niGVEAtbELVNwD39m6y0llpPC5qFyidj7TFYv5erg4wDIje2WUxuh7WylsayUnRunCr6OjSjaXBbzF73PMT8QkIv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QKy55Zx2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-781753f52afso214388385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708968769; x=1709573569; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPhOUUbGfyPt95d+thIFpKzftMVi7roAfhqv80cpO4Q=;
        b=QKy55Zx2thuva1klKLSMjiuFdWsKldSwcrH3NaWJN08GmrnRUbZN8FimyqZ85WTBY/
         KwE1gYSkxNcwzHSoCiEl6EnpoY4mZuj7jCCicsSx1c13ttz3x+5/YO94t4wXqpfLp8JV
         I9Ag3nD+bK+e4oZeszIpcD2+0eOFY0uTs7pW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968769; x=1709573569;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPhOUUbGfyPt95d+thIFpKzftMVi7roAfhqv80cpO4Q=;
        b=Ap7TxgEdaBNE0/+tFb7UI2f1gLvjMK2b32Q+AOQjTPmx9hfhBciLnjLU6E7+AL5Kz+
         Fsev0AczQ9epu1mLKsHZ3wUTzFJ9+WaPwkvR31YfH28oT3v3ZoDcKeS5/uSTgD4nqyBh
         FjVfto7g4yLfC6MLRPh8BIa+VBTs9pzYMe+dfYSWTtUFnrCY16rYtvTmXOc4naNE+c1j
         jW9jFXf7X66oeeLKBSPV7MN5JSHTyGcnODZH+5a0r80Dw16yQIU7WCdK/gsK25MF3hPo
         4ADtFLtHzCtICkGmgZe9ec7bNMy0sLQh37A6xDloMBax0TN8Y9GHHXlRDH+1K+tBGY3j
         Nnuw==
X-Forwarded-Encrypted: i=1; AJvYcCVte1DgysmIe9xkXv8YF7xdSVNJk5HbsqXyQFkTKtXeptc+gaCtrfKykm9fyOsxKGA0THO9LQJzpyBtQgM2TjvfOxCiCRD+26+AC8qc
X-Gm-Message-State: AOJu0YxP+Uxa89F1vAanfKH7DfurAIW3GvjcnTC6DPBFB2wfOSJpyJeI
	v5nVtF7BKmV9M3ufRN9pIQWD8rnbtpyDbgnjHG3isZT8fhaW1+NPfeBBMRUdqQ==
X-Google-Smtp-Source: AGHT+IHvLZz0JMsMLxrxZ5LeCz16I0q4crWk7ffwcs10kKwH096y5KdYOmJIsU/8SW+PQA+90LYoog==
X-Received: by 2002:a37:e113:0:b0:785:c9d1:8636 with SMTP id c19-20020a37e113000000b00785c9d18636mr6773215qkm.59.1708968768956;
        Mon, 26 Feb 2024 09:32:48 -0800 (PST)
Received: from denia.c.googlers.com (115.25.199.35.bc.googleusercontent.com. [35.199.25.115])
        by smtp.gmail.com with ESMTPSA id b11-20020a05620a04eb00b0078725d0345dsm2672669qkh.2.2024.02.26.09.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:32:48 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/3] media: Fix warnings building with LLVM=1
Date: Mon, 26 Feb 2024 17:32:43 +0000
Message-Id: <20240226-fix-clang-warnings-v2-0-fa1bc931d17e@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADvL3GUC/32NSw6CMBCGr0Jm7ZjO2KC48h6GRS0VJpHWTBU1h
 LtbOYDL73/OkINKyHCsZtAwSZYUC/CmAj+42AeUrjCwYWuID3iVN/pbcfDlNErsM9aeuGFj672
 /QCneNZTUOnpuCw+SH0k/68dEP/Xv3ERokLrG1oZ2zjKd/KBplOe4TdpDuyzLF1e5fQq3AAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Mike Isely <isely@pobox.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

LLVM does check -Wcast-function-type-sctrict, which is triggered in a
couple of places in the media subsystem.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Refactor media: mediatek patchset
- sta2x11: Fix Christmas tree order
- Link to v1: https://lore.kernel.org/r/20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org

---
Ricardo Ribalda (3):
      media: pci: sta2x11: Fix Wcast-function-type-strict warnings
      media: usb: pvrusb2: Fix Wcast-function-type-strict warnings
      media: mediatek: vcodedc: Fix Wcast-function-type-strict warnings

 drivers/media/pci/sta2x11/sta2x11_vip.c                      |  5 +++--
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c          | 12 ++++++------
 .../media/platform/mediatek/vcodec/common/mtk_vcodec_fw.h    |  2 +-
 .../platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c      | 10 +---------
 drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c |  2 +-
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c |  2 +-
 drivers/media/usb/pvrusb2/pvrusb2-context.c                  |  5 +++--
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c                      |  7 ++++---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c                     |  7 ++++---
 drivers/remoteproc/mtk_scp.c                                 |  4 ++--
 include/linux/remoteproc/mtk_scp.h                           |  2 +-
 include/linux/rpmsg/mtk_rpmsg.h                              |  2 +-
 12 files changed, 28 insertions(+), 32 deletions(-)
---
base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
change-id: 20240128-fix-clang-warnings-6c12920467cb

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


