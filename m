Return-Path: <linux-kernel+bounces-40835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4776F83E6BE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE41C22BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02995EE67;
	Fri, 26 Jan 2024 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l6pzT6fi"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D8627E4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310986; cv=none; b=Z5jPxEc3SCAu0NSJhAMXuizxvs1n345dcpdA4T4ndINCnpGwGPuT4N8ns0E/jAIiN8oEDbyUU/OEfpNQ39wuXS8AzRAw0gyXgCqHGqMWjaPsbf6a2G8RiatcgxOTssSuuJEA3k30DX97WlfmVFo9fOoRXCRnwpFKAtFvSe/gqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310986; c=relaxed/simple;
	bh=3a/r7kXdAIFtktUyOV8TMLOQckxM8aU1T8MlUOBhuxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlYF886X2ccwQTN5DnwqsCMZvmvWlJwRW6Scr0VY7Qx8PJPpM/VMmt/o19J2x3+A2yBuTIL8JqXtlHpgcPptD3Pod7nppgYspndJdK9YvnpY9G4UB5QRd1zG2SHutOE5iVKGXL9vva2oX9OEmS57m/9GWU3ei25/Wkrxif+AD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l6pzT6fi; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783d4b3ad96so78746785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706310983; x=1706915783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtltgslBdQHae+oLD1399tQsPexikCLm+b/oIxSwL94=;
        b=l6pzT6fiQre9odpIZATrtgsshg4nH0dv4jI7iWbvVve7/y8ej97RVaZAbruMZD0pSu
         B1WrPPkVG8OazVZ5fOMdinRIfskfwkL+35PAKDYHJHka/PQkwiggwB2lp7erSeiw49zn
         Ugr+lr9r2rK/FoUdl8b2zxcprozmtlRXpE930=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310983; x=1706915783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtltgslBdQHae+oLD1399tQsPexikCLm+b/oIxSwL94=;
        b=BCjmbLDQgDrmULb9gm7uZTGMkDrOTXHGInif6YFM9X01uNQhpP08fj3dU+gFQ/gsTu
         R7O8m2qy26IdVp6uJjL6ED6B88AW8lCRniEY8e3KoinntnPany3ujxDRF8hp/m1kJext
         xGUKHCMvm3T7OMi422xhg3bQfSrgZbFkL4R21favxRVzk6t+vSIDTmSCJ5oRPXiuMsyj
         di7VcCg/SY6dM9TBy4aCwc3ghlFxN2yTeCYv4sW9P2IysfUmiIguCL8wHjQtq0gzJIuI
         q4/o9vFe7kdNj/jmxJtx9fSvq3jKPwDKy298nP4VRx9bP/FAo8Cpbsd0l86/0OkaGzZM
         sc0w==
X-Gm-Message-State: AOJu0Yy0xtSISz1j4ZqMPzx1Te9WRjGy8RJLRAR7UA3sKXVgxRbUI4Ow
	QLtYdbVI5PP/c5hSg+jxKj7Ro79OEk65JdqdeODQECrPQSuchlkq6/4szn9C7A==
X-Google-Smtp-Source: AGHT+IFr6+3pqj0JMsLxQ2GW7atIeRCtD6HJIvow5am3DYJqsXSoZPigBa/gFlr3DGsp4f3R3YcSBQ==
X-Received: by 2002:a05:620a:618e:b0:783:4cbd:9ed7 with SMTP id or14-20020a05620a618e00b007834cbd9ed7mr711408qkn.38.1706310983521;
        Fri, 26 Jan 2024 15:16:23 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b00783de3ddf5esm507358qkp.70.2024.01.26.15.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:16:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Jan 2024 23:16:16 +0000
Subject: [PATCH 17/17] linux: v4l2-vp9.h: Fix kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-gix-mtk-warnings-v1-17-eed7865fce18@chromium.org>
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
To: Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Bin Liu <bin.liu@mediatek.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
 Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.3

Kerneldoc cannot understand arrays defined like
v4l2_frame_symbol_counts.

Adding an asterisk to the name does do the trick.

Disable the kerneldoc notation for now, it is already ignored:
https://docs.kernel.org/search.html?q=v4l2_vp9_frame_symbol_counts

include/media/v4l2-vp9.h:144: warning: Excess struct member 'partition' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'skip' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'intra_inter' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'tx32p' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'tx16p' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'tx8p' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'y_mode' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'uv_mode' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'comp' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'comp_ref' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'single_ref' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'mv_mode' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'filter' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'mv_joint' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'sign' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'classes' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'class0' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'bits' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'class0_fp' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'fp' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'class0_hp' description in 'v4l2_vp9_frame_symbol_counts'
include/media/v4l2-vp9.h:144: warning: Excess struct member 'hp' description in 'v4l2_vp9_frame_symbol_counts'

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/media/v4l2-vp9.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/media/v4l2-vp9.h b/include/media/v4l2-vp9.h
index 05478ad6d4ab..f0d80273bd61 100644
--- a/include/media/v4l2-vp9.h
+++ b/include/media/v4l2-vp9.h
@@ -83,7 +83,11 @@ struct v4l2_vp9_frame_context {
 	struct v4l2_vp9_frame_mv_context mv;
 };
 
-/**
+/*
+ * NOTE: This is not a kerneldoc, because the (*name) notation confuses the
+ *	 parser.
+ */
+/*
  * struct v4l2_vp9_frame_symbol_counts - pointers to arrays of symbol counts
  *
  * @partition: partition counts.

-- 
2.43.0.429.g432eaa2c6b-goog


