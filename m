Return-Path: <linux-kernel+bounces-151249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C78AABE3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BA01C21446
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00AC7E582;
	Fri, 19 Apr 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e8JZWmxy"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B037C0A9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520163; cv=none; b=O9cuj1woddl4fV4VMXfTMVToKSwBjSQibcIMrvbMhCVCFXxbavcHTjFpoRW9R5YpumKL1NaVsm6N7GIlby19MhPG5dmOjZ//2EtwNAdYEqB7Mw1eihNMRYB2Pcfn3K/SopgiqztGBfqDDQp5PTEOUwA0hXPT+zNDNj1+cW8mivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520163; c=relaxed/simple;
	bh=Oy36FoyBGe72y+nQ9C/xUGn3HkAwEUaNB0CeLr8vc+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tk686wlBrmrbv1dFItW/nV5llZ7mWAl09jwNoq5yoTchg0I7Pwixhrg0BT5vXc6sjKSopGHyM9qfEY3WdPIdgriJVtMyQdzxxz/gxyjEpYsoX4Hihm44Y3z68g/0fpe8n7Lno2+7THwm2E7E/a9vkulnt5hLAm8VDzGDNGiNShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e8JZWmxy; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78efd533a00so105605385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520160; x=1714124960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xe5eM9+2rh+qYMrEZDkgx2/xN2LnDn/yiZVZC6+s6fs=;
        b=e8JZWmxyofnDazG93BvCeq1J2pZysTZUwMS2Obi4PMx42Tytz857AQxhLTiXRWNKWG
         SN2u/My91DWhbn0tZ20qRZTwm/Zi5RAlaLv0Tzkv9ljd55QRfWDhmhdLtl9ONFLnI2nm
         iq5wk46Ex3bKFLxs6uDzoUXtpn92IFrS5Gm9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520160; x=1714124960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe5eM9+2rh+qYMrEZDkgx2/xN2LnDn/yiZVZC6+s6fs=;
        b=OgbVPyibOlFLjuBqsWfOPxsCSD8cSRswpmRX9QR/xhGjtNKhX+v5tLqICahSN0UBhj
         ujkyKaDAqfSg0TMBczHD4OR68RxxMUQZJLgiDsJEgELtAHjRnWEGq3p+kZzmZ4kishld
         Zdtl8w1qbV+0rdT5BlCkhYyCinyoiu0M5RrEvlESC5TZ1NBfBzth/MXz7oeUxnSBNBJA
         0SNaYlIRFWs7uCEA1PhmvQE3jXH70Enm/v5WMhP5gAGKmlOYk1CD+J7oLiWSB0lmN2Ss
         zgLAWqTOE0v5P9X0Zp8UpxcoW44XCqd3JdHsR6JdD2w4fXDKPKZB64v1l4B33f2P8DfC
         oSSg==
X-Forwarded-Encrypted: i=1; AJvYcCWCsC87NhR6+R8vxd5kltLq4iBrn6XJHws8+LHQL43NTH/6XgSbW/gGkSzSXfZNptvNyktclacxlOPUVzksVqoQafxe6s/DLglIC5xx
X-Gm-Message-State: AOJu0YyGBm1OuztqUtAr+hRQwLHG2+DdWd6A0Jiv5dpMgJGkZTxSbWFX
	XyGI9xEX9D5/K5t+7U3VmHUCsi3TdYM8seRmG/0hAD7HLITUWC6jQKqZJyOZrA==
X-Google-Smtp-Source: AGHT+IHKE5I6bNN/ygxYDQdIMuWr0dmGCsznmTcTgLl7Ioa5cL0u9qYtPjL85KqnZCORUNl4F1qURw==
X-Received: by 2002:ae9:c119:0:b0:78e:ca95:81c5 with SMTP id z25-20020ae9c119000000b0078eca9581c5mr1646405qki.77.1713520160591;
        Fri, 19 Apr 2024 02:49:20 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:19 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 Apr 2024 09:47:48 +0000
Subject: [PATCH v2 02/26] media: stb0899: Simplify check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-fix-cocci-v2-2-2119e692309c@chromium.org>
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

chip_id is an unsigned number, it can never be < 0

Fixes cocci check:
drivers/media/dvb-frontends/stb0899_drv.c:1280:8-15: WARNING: Unsigned expression compared with zero: chip_id > 0

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-frontends/stb0899_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/stb0899_drv.c b/drivers/media/dvb-frontends/stb0899_drv.c
index 2f4d8fb400cd..35634f9a8ab5 100644
--- a/drivers/media/dvb-frontends/stb0899_drv.c
+++ b/drivers/media/dvb-frontends/stb0899_drv.c
@@ -1277,7 +1277,7 @@ static int stb0899_get_dev_id(struct stb0899_state *state)
 	dprintk(state->verbose, FE_ERROR, 1, "Demodulator Core ID=[%s], Version=[%d]", (char *) &demod_str, demod_ver);
 	CONVERT32(STB0899_READ_S2REG(STB0899_S2FEC, FEC_CORE_ID_REG), (char *)&fec_str);
 	fec_ver = STB0899_READ_S2REG(STB0899_S2FEC, FEC_VER_ID_REG);
-	if (! (chip_id > 0)) {
+	if (!chip_id) {
 		dprintk(state->verbose, FE_ERROR, 1, "couldn't find a STB 0899");
 
 		return -ENODEV;

-- 
2.44.0.769.g3c40516874-goog


