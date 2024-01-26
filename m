Return-Path: <linux-kernel+bounces-40828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC5583E6A0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C201F27B53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC4612CB;
	Fri, 26 Jan 2024 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YF9wJFWW"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A53604D8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310979; cv=none; b=tNWfsriqRx1VtkmBF4x+rJqqz4pRY3Mc+7IBQxdE+zvolFBUV1YdZYDYhLCT42/C0N411zhOciWy6b+RbQcYoSXcuX9YXNftWBHT1uB4T6ALA5WiwwJL6+GRzRvyTDD4Hdb4EBjUYAu7VFvya2380z/wx5GpF4wkQYzg7Clib4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310979; c=relaxed/simple;
	bh=D9jb+fZPg4cu81svPtGcxnqe5Dh39wQmeEcuV3Gqubk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J750ySZZRxOtltLrhwY9Gov2UMeokgKsUDBMTFw3Jg8BQRw1AfY9ZsZTkYW9i7EDAMw6Auh3WuhMgxed6gJgWMpaNd9MDAPKANxQdDffTsOzYNGNJrEIcONYiHOfYaTC//UPbGojDJfCokP/SiQ/ABt+sRQISF98NGyvXZVzMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YF9wJFWW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7831806c51bso75191885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706310976; x=1706915776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppFxbOlS/v6G/Iyc2Jdz2aiKlAo+YrKUjtIhEQOSvas=;
        b=YF9wJFWW8riAvKbdCSLBp5VIkAkfizSXjINh56Ek8ykITvI/uKDpqmBdwavsJvMcXG
         Er4tIHo5oroL+OdkIf6Xj5j6quybpiI0IvFrIuv4AsZ3ZgFeNCD028RPiISUTZ4b9uJU
         AnI61mWZLw6N9Nk3AW7tF1BOYdggr/H7GzYbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310976; x=1706915776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppFxbOlS/v6G/Iyc2Jdz2aiKlAo+YrKUjtIhEQOSvas=;
        b=PTxG3o/p00WTPn+EViuRH7Px9kFmAeWIIXzRUWim5KVVqrnUSc3EwGpIcBwYJtI3yS
         GlO+t6yQpUrxf3VOqW0UQCAQS7uVQAmwUYVKsEphy0Jh0RQDuMb1Yp4aCjTbmbQxaosy
         uXT556c9wEnFZZWk0k30Yu6jmi2xHb3dD1gis6Ha5JkNSY6xPfOfTcMN868GkjAZTBmw
         ey6ufiTOJBLrquMzD11lLv5Du/ErhtWO+WaGurlKzqH6zR3vazJRqZyXTjHTIMVfs0lM
         PSLW8vJ2L2BU/ewXvqe5mHqz6sDXzU55GrvPRWuLKfiT9W+lc/ZBYfDIxrknWmMc5FUS
         uBKg==
X-Gm-Message-State: AOJu0YySakE77bTIztbsB6nHAmpItCpPNsDCmCCtNS9rc0oM2FmOcWr+
	uwlveqOiWKMuiduka5tZgsu6MpIniv4AXw29axeQHGObZn5uiJYllK/UttiNNg==
X-Google-Smtp-Source: AGHT+IGIpAsQSjaDQPGQ6LECGQr9cN1m4828+DZymi0+3bzM+4XluVJo4MprbQD7HbxK6yJ3CFbmNg==
X-Received: by 2002:a05:620a:2182:b0:783:e064:aa09 with SMTP id g2-20020a05620a218200b00783e064aa09mr622459qka.115.1706310976118;
        Fri, 26 Jan 2024 15:16:16 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b00783de3ddf5esm507358qkp.70.2024.01.26.15.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:16:15 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Jan 2024 23:16:09 +0000
Subject: [PATCH 10/17] media: verisilicon: Fix kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-gix-mtk-warnings-v1-10-eed7865fce18@chromium.org>
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

The field is not part of the structure. Remove the doc.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/verisilicon/hantro.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 6f5eb975d0e3..811260dc3c77 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -237,7 +237,6 @@ struct hantro_dev {
  * @codec_ops:		Set of operations related to codec mode.
  * @postproc:		Post-processing context.
  * @h264_dec:		H.264-decoding context.
- * @jpeg_enc:		JPEG-encoding context.
  * @mpeg2_dec:		MPEG-2-decoding context.
  * @vp8_dec:		VP8-decoding context.
  * @hevc_dec:		HEVC-decoding context.

-- 
2.43.0.429.g432eaa2c6b-goog


