Return-Path: <linux-kernel+bounces-151269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE038AAC3B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7841C20A79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E16130A54;
	Fri, 19 Apr 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WgYpMSDD"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB812EBE7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520188; cv=none; b=dH27mbgPLpnpnLAKNuZfCHdsSauEY7ue7h7jnFEDWAVw0FedtkirgMg5/Fn4db7w2mvli77j2hkt1cnS7mESJUTfugEnn2sNEKeNe7WcbIxeX5SdysJNp/ur1M1r4nmcjdy+0tAjEJWZM/uEl7hCeQB0AzxjII4BBtxlblT1iYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520188; c=relaxed/simple;
	bh=jFHnju+ZdbBnojvlGLEr3gz0wIbcoBJYXFqf+F/VYB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GIXRnnG3jWhXoD6fHrnMtRSPncXd+NE7r0TUkNZAtWDu/CVlZ4Q+IyYpAk39jiuie4w+BT+1EGIQTOi7RdGP9Pd2svieLXUDlzoMs9941gViQ90OjMRzpggKqIHQjVrl6KGE0HBcoE3FFh5c65Etlmwmy114QdtO624aPmWrWCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WgYpMSDD; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6eb812370a5so1043431a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520184; x=1714124984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mekpuuLwriZD6IkthqRlN7odC9zWZqgKPV8UcJZ7R9M=;
        b=WgYpMSDDXpDii8zmer7+HldjnDrF7NN8f0zMweQAaxH6rqerHSTRoPUL8lOjVJAgX9
         5j4+qyotpPtLMW0lbsQUQCkEATtngK7kJezpLUUYSI3qWd3JGDuRGnmJkv1Na/euGFfW
         GFUst8h0+ZdlIlNFt+yrA2nZMaarHwVFsDnsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520184; x=1714124984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mekpuuLwriZD6IkthqRlN7odC9zWZqgKPV8UcJZ7R9M=;
        b=YGCMQWbdXqRRTOZmQjh969zlnZrNhXGp2UENL8hj1KssZeZVHgH1ZWzkpoygZtUbSQ
         WQIdSiqMyb/uYQLgST14y84iN8+JgPWZLoaUBNfu7jj49fJLfbXW5QJT/OuQsIpHwu8K
         W7z8CXeS2mhdmuesrkxSuthckAQEkfIEFzpw8Img3nduaXyhtxGSLC4B9AQM3KU23zrL
         aI1nRbr9fSyySmRv2AYccy2968+ojzA5hn5frZGaL9AUmmUT+0EIxj448d1p7b+OlJqs
         SF1FbYQi0226fSA9VPauYx5T3q85zEiM5JVOqIHFvflCqTdBrTd28f+l4RrWNFouEjgf
         bOUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLlQch6sZwmlAs0CGI7gyUcfHfRfpUH5kfJBNVW9gpIOP1xn4xzCbao1qfxlRlP6ABLRW26YEM3kel6CbyLlvmsayS9ReimFBKDOfl
X-Gm-Message-State: AOJu0YxH0Vcx6EqVFvHZWA6MAZtBvYMvg7UXdaOpzi7lypJZevvojEKW
	hOENpHGV3QVem3Wwq+4CxpRTR33BPmC28o5EIoCWpHgas0oBpQtfSES6ScHXMA==
X-Google-Smtp-Source: AGHT+IEYwOxlb1WugYE4t9h28+AXEwcDjQAa28XJBDFMEfi87sd7BKKPg6Joa8eH6oaaPvD2ajlMkw==
X-Received: by 2002:a9d:7f03:0:b0:6ea:1dc5:514c with SMTP id j3-20020a9d7f03000000b006ea1dc5514cmr1695945otq.11.1713520183703;
        Fri, 19 Apr 2024 02:49:43 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:42 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 Apr 2024 09:48:07 +0000
Subject: [PATCH v2 21/26] media: i2c: st-mipid02: Use the correct div
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-fix-cocci-v2-21-2119e692309c@chromium.org>
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

link_freq does not fit in 32 bits.

Found by cocci:
drivers/media/i2c/st-mipid02.c:329:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_s64 instead.

Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/st-mipid02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index f250640729ca..93a40bfda1af 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -326,7 +326,7 @@ static int mipid02_configure_from_rx_speed(struct mipid02_dev *bridge,
 	}
 
 	dev_dbg(&client->dev, "detect link_freq = %lld Hz", link_freq);
-	do_div(ui_4, link_freq);
+	ui_4 = div64_s64(ui_4, link_freq);
 	bridge->r.clk_lane_reg1 |= ui_4 << 2;
 
 	return 0;

-- 
2.44.0.769.g3c40516874-goog


