Return-Path: <linux-kernel+bounces-162514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554768B5C80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DFC282826
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E7823A9;
	Mon, 29 Apr 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MenOWM3u"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101E81745
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403090; cv=none; b=kv9vmxnC3rsOPiweWV1eAoBY0jnbEZhMv2rhmc71/pqTJpaiET54PO0fyz/CElEjODluHpRySe359vKWRp4zyQxKWJs7IdVg3CT2de0PguEqAXO33LuH1DIzvCbSbRA1LR14cApJ0KhM7KHa3oiR9TFPvmEe6QIg0gX+88GRK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403090; c=relaxed/simple;
	bh=4VxVD/ZvDgbL8FzmgqVV94mI8OoBWP6NSF7Mr+JIpbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFYmOsBuCz6W0eF9MyIVvyM8YXF6wDG/P1RfuGhpxHR5+KudgXXKOm/AC5mXdR5XobkG9Fw3x6zwb4GXijXyw4M7QDkcRRjA390gJpuHFDLckuekA9Xvevp9GOH98aU5o6hF8AxgEmOP4nMSwZ3T6VkP0zUl8ErZha3a96VKNVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MenOWM3u; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78f04924a96so385464985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714403087; x=1715007887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ANA0Ymw4Lt0Uz9R7FMbv4c7Ba86EanvWiJ79X90fJk=;
        b=MenOWM3uj9X2UrbvZmiDjqbaMu/PNOfm/XBGxRzEPuq89DxBY9Mj6imja1HYQp7eDY
         xT4PDrr24mQMLdodH+LcMx9QEazzYRBXyUp5FCBvcvDgr2sToyZpfgoDKhR02tbuX4iq
         /SPXLIuo/NTtFeJ6cvkL0gGV5s7WsvvRrufvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403087; x=1715007887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ANA0Ymw4Lt0Uz9R7FMbv4c7Ba86EanvWiJ79X90fJk=;
        b=C90Y6GKKYAyM70xWOFwbR+ImGl1OUM2UdFHlCDqpjPFaLecNbAn8aFv2ZWbSaQGRCn
         ZWoZZwvxcFQnSU6xop3dluXgx81FVmiGhwELuidSGNi8tAgKJ6RV6ZVYfeB/ZDTFU+q0
         D5KiCb60GlcLjCc7aYknAxxALZ+wyBWzegc2fas6cVztTeI+nlMwpdfoVjrufnp50FOB
         vNxLDOZNg5Lm5JjWiA7d44zH4ux671uj98dmXMRnd5G7WwutHCYHsuAyDFaxeyDKK0sx
         lU1hCZ7S7GV1jQ++KJ6KGM3QUWcjabQUXNuMubM0c9OrYvKQYpa+q8jf1AoAkoKIGgKE
         gpuw==
X-Forwarded-Encrypted: i=1; AJvYcCUm4+z0dWfYrhpdRTPx/nxWH+huwVas4Z/j3BofGsGpsKz/M8zyNUQqgpHYsrMTY/y1+2xbC6RVAXIdby/W51XHXeEnrYv8pS18sb4s
X-Gm-Message-State: AOJu0YwjA1vTs6ZOkK59a72eUOFfkekVtsOnS3UraklK23P/jUL0NKBD
	izePiEK+vO0ltaQ9TRfpzea3fCKNgntyOkbnBtDyp6sWfYbJ2c/tI6XBn0Y0mQ==
X-Google-Smtp-Source: AGHT+IEnQjn3WLm+y+PPKHAe/yfoK7DsUlbFKzqXGLCHhSBuNgNTvG4+ilDw6HzfNC7wT8W0tTtiYw==
X-Received: by 2002:a37:c449:0:b0:790:98ba:67c5 with SMTP id h9-20020a37c449000000b0079098ba67c5mr11283245qkm.33.1714403087305;
        Mon, 29 Apr 2024 08:04:47 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b0078d3b9139edsm10568591qkp.97.2024.04.29.08.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:04:47 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Apr 2024 15:04:43 +0000
Subject: [PATCH v3 04/26] media: uvcvideo: Use max() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-fix-cocci-v3-4-3c4865f5a4b0@chromium.org>
References: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org>
In-Reply-To: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org>
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
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>
X-Mailer: b4 0.12.4

It makes the code slightly more clear and makes cocci incredibly happy:

drivers/media/usb/uvc/uvc_ctrl.c:839:22-23: WARNING opportunity for max()

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index a4a987913430..4b685f883e4d 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -836,7 +836,7 @@ static s32 uvc_get_le_value(struct uvc_control_mapping *mapping,
 	while (1) {
 		u8 byte = *data & mask;
 		value |= offset > 0 ? (byte >> offset) : (byte << (-offset));
-		bits -= 8 - (offset > 0 ? offset : 0);
+		bits -= 8 - max(offset, 0);
 		if (bits <= 0)
 			break;
 

-- 
2.44.0.769.g3c40516874-goog


