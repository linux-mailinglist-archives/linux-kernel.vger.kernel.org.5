Return-Path: <linux-kernel+bounces-82069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31280867EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D46EB29D48
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4D12FB39;
	Mon, 26 Feb 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zv+jgdzp"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFEE12F366
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968773; cv=none; b=GdHrj5Q2wRnUgw/0Zpl3kVb6kD//FUfmrGcVjX3NhdrTlugU+Bu+cfTP6sXFFnpSeQAOAxEmo9EoYUQYNiAAsR40WlwyCfD1dnV5OruntmyoxXQgdErenBFWCkjwE7CFcmsHsrOD3V8PYvPuT+PCWciG29h0NqyoDf4Gkh50g7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968773; c=relaxed/simple;
	bh=Wy4cGPpVerRovklUcPnMhjmK9LuSlF+TSnH28VA7whs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWC03D4ZdkcQpnOgnPfCg2tnGJj2OufkNNF8F3ZvTrpIHOaG7LSn2h7rlEbd8jNT8mLvSYG8UTIQHr9JHJVcGVurTLIg5AJlLHWsMuUTFCXn/ux0bi7uMZ7dzd6jJzbeiJ9O9RTV77Df4ybWACSazFrZ+BP8oyzG+VzQke1KVi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zv+jgdzp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-787cb2ef657so94445985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708968770; x=1709573570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZotKd2o47/oKAtdV1I26QivtjRepugTGHOJDDp/ZM4g=;
        b=Zv+jgdzpv7kbxm6d51ljpzyYaHHHaw109ZABdcIgI2J3WR8hcr0j1EpNDHNYlqvDtt
         +7duKGpReSs2CDVHSgcR392oAEnvTVNOUE+fdszHIeuBjG76EGg/w0+GgqHv2MHX7ZKL
         B4WNuqWk5RAIPdGWp15zD/a9kubf6P4nkctjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968770; x=1709573570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZotKd2o47/oKAtdV1I26QivtjRepugTGHOJDDp/ZM4g=;
        b=X7bIAnfhTa3SIdfCUA1i/dz9x9BpZf++SpUfAZjViuK5JDU1g2sNLV/HD04kgs1QOv
         nPnqPZT3vgsxOj0ekvHIx+9eMsdGT4QyW0u5Tt1UcSu7m7XctcsH8TbY75yBfvLqvuMi
         70m/3eqacmU3/YbioqqnoaCnH6+4FN9RZfHztsozBvjGh8vPzkiYQsh/32gntrP5OLCy
         2JFJmqHkPEzVnqMjpsR6yIal19PKPtJT8Co+EBTkMWTKHOA9KcmBMTQC+9uIKfdWPTri
         QCvR7jU1w4RgT2NemLOmyOuejE8oXL9IKlD7yJf64ZNOhcoYQ6vg1y/JUVy1cksn9h9l
         ktrw==
X-Forwarded-Encrypted: i=1; AJvYcCWCloN9SZgWlTkJIurlpwAIiBHvI7d6bkKYe3jQ80wANzjXqVHdTlC7tZIgUESmQ3LtJCi/1QgpmmwQuXzfkuvW6e80tpBToe7+lcCi
X-Gm-Message-State: AOJu0YwRRD3LD/O3D51hvagcOLq5HvVz9FbJj9do1zhL4ha3+fsnq3vL
	kgazjNdS19KmZ7UkCdblLDPka0r3B3VEYayCLA00Pq6VAixr5+8QuXQEKzOzCw==
X-Google-Smtp-Source: AGHT+IH3rAwgd0NXJq8G/TBWJ93nsJy2+AmuJ1+7I538QjgTdtVQQDhSqF/spxCAW7zvWaoaCpSjOA==
X-Received: by 2002:a05:620a:9d7:b0:787:9a1c:fb32 with SMTP id y23-20020a05620a09d700b007879a1cfb32mr8021996qky.2.1708968769789;
        Mon, 26 Feb 2024 09:32:49 -0800 (PST)
Received: from denia.c.googlers.com (115.25.199.35.bc.googleusercontent.com. [35.199.25.115])
        by smtp.gmail.com with ESMTPSA id b11-20020a05620a04eb00b0078725d0345dsm2672669qkh.2.2024.02.26.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:32:49 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 26 Feb 2024 17:32:44 +0000
Subject: [PATCH v2 1/3] media: pci: sta2x11: Fix Wcast-function-type-strict
 warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-fix-clang-warnings-v2-1-fa1bc931d17e@chromium.org>
References: <20240226-fix-clang-warnings-v2-0-fa1bc931d17e@chromium.org>
In-Reply-To: <20240226-fix-clang-warnings-v2-0-fa1bc931d17e@chromium.org>
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

Building with LLVM=1 throws the following warning:
drivers/media/pci/sta2x11/sta2x11_vip.c:1057:6: warning: cast from 'irqreturn_t (*)(int, struct sta2x11_vip *)' (aka 'enum irqreturn (*)(int, struct sta2x11_vip *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Wcast-function-type-strict]

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/sta2x11/sta2x11_vip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
index e4cf9d63e926d..a6456673be3f6 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -757,7 +757,7 @@ static const struct video_device video_dev_template = {
 /**
  * vip_irq - interrupt routine
  * @irq: Number of interrupt ( not used, correct number is assumed )
- * @vip: local data structure containing all information
+ * @data: local data structure containing all information
  *
  * check for both frame interrupts set ( top and bottom ).
  * check FIFO overflow, but limit number of log messages after open.
@@ -767,8 +767,9 @@ static const struct video_device video_dev_template = {
  *
  * IRQ_HANDLED, interrupt done.
  */
-static irqreturn_t vip_irq(int irq, struct sta2x11_vip *vip)
+static irqreturn_t vip_irq(int irq, void *data)
 {
+	struct sta2x11_vip *vip = data;
 	unsigned int status;
 
 	status = reg_read(vip, DVP_ITS);

-- 
2.44.0.rc0.258.g7320e95886-goog


