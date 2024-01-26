Return-Path: <linux-kernel+bounces-40824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A5F83E690
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA4B1F2623B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B360871;
	Fri, 26 Jan 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZpkHrIYg"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A725C5E2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310975; cv=none; b=DqMrcse/MgD/YHIkQJhTzJlz4VRTjCcpXb13sdz9VVjxVn8Njq9rpBi6CF9F/Ai7Cx2XPOirR+UFFSiBb2LREXXG6A42sWOHJhBSRlZjn6xQkZxr44b1tRQ0ghLPWjq/Z9x1V0TzR9czODS+s7jR9dGRZOBofJlHjGnwMQWAoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310975; c=relaxed/simple;
	bh=uKwiWzeO0xFAMIWvpeHxHonS+sA78lVm8Pf7e/oU4ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8XikJoWq016dPeocF4BBOETtXC94tZZY2/PbiLMaiaAid1Wsk7iC4tbeht4gfSQ1zChlMAXB8PqlgUiqkSloN3xjPPgLXnB0pnqsK/Ffa1ukjS0deCQVd1eNyyI4STCyKLtHxfHdwz84W3EqLQFnHa+t/xYniDTfijjoizfDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZpkHrIYg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7835aea8012so87055185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706310971; x=1706915771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dgr7uAnKOP7T5XfeX17z97swkwNkCZ42zeC6YgDi/s=;
        b=ZpkHrIYgvrgSSRwCjIODgfyT521vqnUhVzVOlxSw4FbJDpqdPaGv9O0Iv81ilqsOQX
         KoT6Wy5Elfh9UaCVc3jN4rYeM0bhQXEHscM0ws4aumCcC/S2uxTGU5xEBYnUq0SSx0uI
         316FhRwj/pMp/ng4WzjalFS86CKPO8woAaUXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310971; x=1706915771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dgr7uAnKOP7T5XfeX17z97swkwNkCZ42zeC6YgDi/s=;
        b=o8mW80yANbG8oUgtDbjxjJG7v1G9McqdMX5ir5l6HoPNzssFjl1KUsEYYxWCC/JIhg
         QuAtqqga8SKuAKLSDy1LtRTOj0ne7wms9fIQ4oo+seRgt6CJBtZ+poIy9UyQL3Kf+zG3
         D24n0rJAkCafeDkYJ05TkiSAM57WsNFxSyZAVhu0mzI7NnydxagSDcmbziw4tOi52h3R
         rU41ywsxceLMqdFyeN9lwHKGCVCFiex1HrOsLCUBTQP9+jG6GMe//RnupB3N4CINdDvv
         iFCnIckJwx4faDYNmuZt1mcZcdv3OQ/ztSLdsKdlj8PXlqVXhJ52HKPQXKCUWqH2puMS
         A4NQ==
X-Gm-Message-State: AOJu0YwKjkz3VAI1t//16fnNMnlRaNoicsMRQtLNRCs7X6uQyYvdLYCR
	kStgOVBohaY/goUvXYpwoxP2GVutov6kkxD9Q0eWXySWxQXSFdM8vFUVb7KquA==
X-Google-Smtp-Source: AGHT+IHsMkOc7Y1zxu9ngxPBQ4/Ve5FRbTtg/VBTpnZVoIwUFy4DQtcLLUh2LbUFnAzoTvCw0KH84Q==
X-Received: by 2002:ae9:e917:0:b0:783:4dfb:11ae with SMTP id x23-20020ae9e917000000b007834dfb11aemr522337qkf.63.1706310971522;
        Fri, 26 Jan 2024 15:16:11 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b00783de3ddf5esm507358qkp.70.2024.01.26.15.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:16:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Jan 2024 23:16:05 +0000
Subject: [PATCH 06/17] media: i2c: css-quirk.h: Fix kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-gix-mtk-warnings-v1-6-eed7865fce18@chromium.org>
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

Kerneldoc does not seem to understand that embed doc:
drivers/media/i2c/ccs/ccs-quirk.h:50: warning: Excess struct member 'write' description in 'ccs_quirk'
drivers/media/i2c/ccs/ccs-quirk.h:50: warning: Excess struct member 'reg' description in 'ccs_quirk'
drivers/media/i2c/ccs/ccs-quirk.h:50: warning: Excess struct member 'val' description in 'ccs_quirk'

Convert into a standard doc.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/ccs/ccs-quirk.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-quirk.h b/drivers/media/i2c/ccs/ccs-quirk.h
index 0b1a64958d71..392c97109617 100644
--- a/drivers/media/i2c/ccs/ccs-quirk.h
+++ b/drivers/media/i2c/ccs/ccs-quirk.h
@@ -28,11 +28,11 @@ struct ccs_sensor;
  * @reg_access: Register access quirk. The quirk may divert the access
  *		to another register, or no register at all.
  *
- *		@write: Is this read (false) or write (true) access?
- *		@reg: Pointer to the register to access
- *		@value: Register value, set by the caller on write, or
+ *		-write: Is this read (false) or write (true) access?
+ *		-reg:   Pointer to the register to access
+ *		-val:   Register value, set by the caller on write, or
  *			by the quirk on read
- *		@return: 0 on success, -ENOIOCTLCMD if no register
+ *		-return: 0 on success, -ENOIOCTLCMD if no register
  *			 access may be done by the caller (default read
  *			 value is zero), else negative error code on error
  * @flags: Quirk flags

-- 
2.43.0.429.g432eaa2c6b-goog


