Return-Path: <linux-kernel+bounces-40834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631F83E6B9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E257028EB33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9F6605B6;
	Fri, 26 Jan 2024 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bmnSpJaX"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7326281E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310985; cv=none; b=TwxsputxdMtNMXXp3uCIvWSKKibokCkyFgPo+6dOzYoD/CYKeicKaw2Fsg1QurDh9BQuN3kGAUiNabeQZUPRm+5DbqvZVsmjnPNU8EoD44pivzbW8kOZcK3yNvLVEUalRtoG7n1KTN+ehRPG9yVvV6qRqUoUiEnSPA6VRiYHlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310985; c=relaxed/simple;
	bh=VR34VGLdsIhpkmSEIe7z+ZhO5WpYZFRPBYv6zPfcQU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sM06PS65M5UHPQmXmj337vVscBRAfC2txzf3660QpHYN5lVLHmg1mb8yjEHaWKWKd+FjVWltSLKMtrrcb05tAj2O41ePF+v8y13plROJK7t/LRYmG1QXQpRRggJCIRhySNaY8aWNrYCZQyncenDFXFB3JbaR2Rkkcg6VKWIIQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bmnSpJaX; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783cd265c76so51237185a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706310982; x=1706915782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTQuVZL8YGJGo91HZaWDjGYZpj4eaCPL+PrXyKe44Kc=;
        b=bmnSpJaXMlO1bQrm/KvBelNvxr/2Is291GCihLjN9rCsHLgmXbw2hp/gQYp/tQ/ofJ
         alOFQNO9fsU+X5TCsoQtY9ZgQ9lJ71hSRSoym88L2rpGxF3k8zs8niTo0FJhaN8Q4oK9
         QSgYC6/rzp/FkZVm0mhCa0DvmUaP7ABT/NghY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310982; x=1706915782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTQuVZL8YGJGo91HZaWDjGYZpj4eaCPL+PrXyKe44Kc=;
        b=gE7d+NNmbA2hgAMgX6CCuGR2I75rk7Kn/U8IxpoDJejFDd56j88hfzlDqE7QTTXQKl
         leZwJHBvOB1X7Pl7HOOxezKchFeCccRu8Ns3xcglmc0/fqWSHTjhcbn2UXcw9CVkLWDJ
         GnKplx1+1wOwBl6qglWewAU3DgEqicPvabC0Ggu+Sc0X/tjmb9rd15ZDjNO/5RKLkccG
         BEIjfxXjDgqJZIc7IfxSF70Op6jEmQfHImB1L713mPH9i5L6IHVzTP4UGSLTOqz/pIhF
         QquJkzvfwa262UMDhh3/RBz5NJ4vwZEccvhAsXZg6mTCGCWDaKUPkhxEn7tbQ7Sxp/5J
         riLQ==
X-Gm-Message-State: AOJu0YwOppaQlvX+9xHh4cyRruj0qxOBhgZ5pAhli02iqg36EkXL0oug
	aMThBAIHIQgIZufy9xsSir+DfmYwsod0K9mzSyGcEoLi2o+i0ry076Wq/DilBA==
X-Google-Smtp-Source: AGHT+IEphMi3U2VaLxz1TX+i8gpYrzavZfgthHPoIK0is3/PzYweSa+k/yEg+NZuAGKrkSdAEIRBPw==
X-Received: by 2002:a05:620a:22e:b0:783:d13c:cfa0 with SMTP id u14-20020a05620a022e00b00783d13ccfa0mr539361qkm.12.1706310982441;
        Fri, 26 Jan 2024 15:16:22 -0800 (PST)
Received: from denia.c.googlers.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b00783de3ddf5esm507358qkp.70.2024.01.26.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 15:16:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Jan 2024 23:16:15 +0000
Subject: [PATCH 16/17] media: staging: meson: Fix kerneldoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-gix-mtk-warnings-v1-16-eed7865fce18@chromium.org>
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

Remove documentation from missing field.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/meson/vdec/vdec.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.h b/drivers/staging/media/meson/vdec/vdec.h
index 0906b8fb5cc6..258685177700 100644
--- a/drivers/staging/media/meson/vdec/vdec.h
+++ b/drivers/staging/media/meson/vdec/vdec.h
@@ -101,7 +101,6 @@ struct amvdec_core {
  * @conf_esparser: mandatory call to let the vdec configure the ESPARSER
  * @vififo_level: mandatory call to get the current amount of data
  *		  in the VIFIFO
- * @use_offsets: mandatory call. Returns 1 if the VDEC supports vififo offsets
  */
 struct amvdec_ops {
 	int (*start)(struct amvdec_session *sess);

-- 
2.43.0.429.g432eaa2c6b-goog


