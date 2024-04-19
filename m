Return-Path: <linux-kernel+bounces-151257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1954E8AAC05
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35A9283AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B985C44;
	Fri, 19 Apr 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dwHJJPHO"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367037C092
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520174; cv=none; b=JuDKh1AT+lSsQY2Ht3qGQ6sf/IQdI5VtojymycangR7UdaAtiJToZzzKo7wfajH4LdrMaSIM01ShO91QZUk3Yks22/pY2Pi+qfdb/j8CfvKauBVbTnSEJ3knABsHytPcO4S2QIEfKaT3w6Wmq3M621lQcX3hUjiQ0diON8ApVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520174; c=relaxed/simple;
	bh=aAxsx+GHEjYnJMiAWqwUDNgaIzi1dYkLjFRqwX4O4Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rs5zQU8hjA9I0rfa8qFGedrupQL/Jc9sWIrasxIs4n2g/490U++B+xYPKDFPVf42ocm4pvk16XItvAz6S8UPL7vFxAHxoSR2Rfvw55QWocPLHx72OrflFv/Ly4qgWug5zKGfGqw33dEk0o/fq/m/nY4G3+SKpxn1H4N/+VA3o+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dwHJJPHO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-439073cd4c9so525431cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520170; x=1714124970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtHT2dnCrKtU2tz1OyJJw1d0hzBN/YL8p+52UQFaJZo=;
        b=dwHJJPHODXiKSarwV6nm3I3I7P1+j5DULH4hERbmBQjxOW8dPVI+RDJZUUshs1f8Sx
         FnQG7TFdVgOvfTpO9qxTZ2PdFm1Zpe+LBeM8luYze/vuxxBN06/Y4hxuEaNATaVdT1aA
         DJ1hYwJj6K8xXoYGNdInHHjg5Zfcq0+/lQfNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520170; x=1714124970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtHT2dnCrKtU2tz1OyJJw1d0hzBN/YL8p+52UQFaJZo=;
        b=t7EfVKAJy4qQpEQWrR0q6OOer3PmHffgCCZZ1DYdCIQbJpmT5fcPkrsKzlykWEm0xO
         9qQ7D0zjEKh0a1tWW4iKJpB+SQqIlsUdUBaHvIQMs5DPbyype8EDcx5gvrJCc0k85/vB
         znoFqkmiQ9VkhvCFkMrTQFMPAkZpPtyaYYUARhUU1SG4P1zf9dSOAw0ZTEOtOC26qOnH
         MYk41e8ZkfqYhG0U/cxrgrhqhKKciW3WBXvpGwPhTjcEZsIKVdAMLe+dvEGusADcKKrf
         6P8ik7x7SjhVg219ZY5xgL+ZfKqAg1he+3hteu3Zd/+exlkomJrwXAZ9rnHgFS1kjDcs
         aJ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWbypCuPQTslNZRL/YpSOc5iQbaADD2EdNxZd4u0fP0lj9BkmT2+MnY8i8dNWl68MLV/8P6QOD2ep0v3al4GR7juU4picgUBF+5geT+
X-Gm-Message-State: AOJu0Yy5Lsoq0ciUUDoT7AVfBYZ4ZyKPo5421NTQUGlIMueHR0dJSoDo
	XncV+gJ4XPx/Dj83gin7TIFp6eD35ccGI672WsZXC9jovUr4iSD7fMWJdl3Rv32mCrEzWDNMGdS
	4aA==
X-Google-Smtp-Source: AGHT+IEq5/HFwcn26nQnIIJ8VXOEY35h4vBPeSOiEtFFD1Z7vC7s7kPOFrGUrC/lVDARzsxRqq1juw==
X-Received: by 2002:a05:622a:1386:b0:437:b995:98b5 with SMTP id o6-20020a05622a138600b00437b99598b5mr1747672qtk.57.1713520170255;
        Fri, 19 Apr 2024 02:49:30 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 Apr 2024 09:47:55 +0000
Subject: [PATCH v2 09/26] media: v4l: async: refactor
 v4l2_async_create_ancillary_links
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-fix-cocci-v2-9-2119e692309c@chromium.org>
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
In-Reply-To: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>, 
 Abylay Ospan <aospan@netup.ru>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Dmitry Osipenko <digetx@gmail.com>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Return 0 without checking IS_ERR or PTR_ERR if CONFIG_MEDIA_CONTROLLER
is not enabled.

This makes cocci happier:

drivers/media/v4l2-core/v4l2-async.c:331:23-30: ERROR: PTR_ERR applied after initialization to constant on line 319

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 4bb073587817..915a9f3ea93c 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -316,9 +316,10 @@ v4l2_async_nf_try_all_subdevs(struct v4l2_async_notifier *notifier);
 static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
 					     struct v4l2_subdev *sd)
 {
-	struct media_link *link = NULL;
+	struct media_link *link;
 
-#if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
+	if (!IS_ENABLED(CONFIG_MEDIA_CONTROLLER))
+		return 0;
 
 	if (sd->entity.function != MEDIA_ENT_F_LENS &&
 	    sd->entity.function != MEDIA_ENT_F_FLASH)
@@ -326,8 +327,6 @@ static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
 
 	link = media_create_ancillary_link(&n->sd->entity, &sd->entity);
 
-#endif
-
 	return IS_ERR(link) ? PTR_ERR(link) : 0;
 }
 

-- 
2.44.0.769.g3c40516874-goog


