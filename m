Return-Path: <linux-kernel+bounces-151261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B825E8AAC18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA751C20AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7320B7C092;
	Fri, 19 Apr 2024 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RnN4DMb4"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF01292DC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520179; cv=none; b=Ylguoy8pgnGbUtoFHR14SfOVy2d+s1lRlFJZdtXXsBQ3C/ZToPjQFefCoB6YrIab9Uz2fvQiHgrav5ZqZv1zsfo3dJpCOhgfFkdSp96i6Cq82zXBQK95XG91iUhKi/aVc4Vw8sNV88jYcEjakLHSgq20WlhCS+AgYhNtlkwqe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520179; c=relaxed/simple;
	bh=JRKd3ofdoG2gsB+v1DyPD2MPqmJ2Z54LhqVVoekb6tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stVJXSzEYZCHSi/gCxjTEguvkY0gbO7FprPxQk/B9Dgt/A7iPhprv81znkc5RZh26y61Z7KjWiiEUIPy4fY5/uMqd/uCt05IvTQJvFRliNpLL8w84teFPGEygNacBhDAY1T0HE/2q4hBB21s/M9vuuX/gOX/1hXZ9pvPJQivrdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RnN4DMb4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78f04924a96so130039785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520176; x=1714124976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o87/x+VFy7QdGpzFKB0wOlVC4lrWjoCcMvbEo+2HMvU=;
        b=RnN4DMb4B2iXvXrT79a6DmRuZZLEJnUAa8XBBalQ652QGFO0Zc2ctaNYGCtX+U0ax9
         5DxJz0O/GjPrQ+peWhx1OQr0b6H0iBNwRde0wD3yehhjpOcTt8K3CDztTeI9oWDzkP27
         7znqD8b8Qouz0JLOenmZnQIYUDLJggJZ8RwS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520176; x=1714124976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o87/x+VFy7QdGpzFKB0wOlVC4lrWjoCcMvbEo+2HMvU=;
        b=AXW4M7HtwfNR4kMAwBLEe91dR+zS17Dy/Ktsq4ntyxbY1B3rMwK8pdaawNfajlve1n
         4ctGiNIHcjJ4J93D91LhA9u2MBsZeV8RiBVtIyX9v2l1iiBZrstHlnFMOIMcBoreGEm6
         kRC+gASRJYR26h+q3wHQb4A8fcgjmQnbMEWvUYWMJcgzugMURAxkcS80dwqrtuxdci65
         wqsKTzukPqwXX3uU3BsAavXfD+ZBTALC0gmfH+q3uZcQ/0krxbNsvzixuwKvCS9tHq6/
         oiybFCMBYp4N+ZaoK1vQqbd+SVUFzTawSw6Gk62n198Y1g8lSM4325OMru4LjW2+VARk
         NQVw==
X-Forwarded-Encrypted: i=1; AJvYcCV6tZTGXiXcIhGJ8S7Zj/RyoHVo+kqF/Xqc8aVMstfUphfxKtKmNuDGwU+i2iEhXq7E21Hwp56Xted4L8HfAT+lnp4HFuQ31cNCQOYS
X-Gm-Message-State: AOJu0YyXAreMhDeoDA7TbQIgIJz0Ue7CFOpHGyaYepvCVIDOmwAtev0d
	/RVPqOUD46Pokz6OnoY6Ef8bspxQUuLlRa5J0BNiK49/9BUEwQmL8cHR0cyE1A==
X-Google-Smtp-Source: AGHT+IF61myZQzLIJtZThv3LhAjLCPCU5PGkGLiYz8SZp337r7gQKsKEDGbkUPSHG1pPHq3o/FKykg==
X-Received: by 2002:a05:620a:47c2:b0:78d:6ef5:f10d with SMTP id du2-20020a05620a47c200b0078d6ef5f10dmr1532638qkb.65.1713520175867;
        Fri, 19 Apr 2024 02:49:35 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 19 Apr 2024 09:48:00 +0000
Subject: [PATCH v2 14/26] media: dvb-frontends: drx39xyj: Use min macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-fix-cocci-v2-14-2119e692309c@chromium.org>
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

Simplifies the code.

Found by cocci:

drivers/media/dvb-frontends/drx39xyj/drxj.c:1447:23-24: WARNING opportunity for min()
drivers/media/dvb-frontends/drx39xyj/drxj.c:1662:21-22: WARNING opportunity for min()
drivers/media/dvb-frontends/drx39xyj/drxj.c:1685:24-25: WARNING opportunity for min()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-frontends/drx39xyj/drxj.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index 1ef53754bc03..6fcaf07e1b82 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -1445,8 +1445,7 @@ static int drxdap_fasi_read_block(struct i2c_device_addr *dev_addr,
 
 	/* Read block from I2C **************************************************** */
 	do {
-		u16 todo = (datasize < DRXDAP_MAX_RCHUNKSIZE ?
-			      datasize : DRXDAP_MAX_RCHUNKSIZE);
+		u16 todo = min(datasize, DRXDAP_MAX_RCHUNKSIZE);
 
 		bufx = 0;
 
@@ -1660,7 +1659,7 @@ static int drxdap_fasi_write_block(struct i2c_device_addr *dev_addr,
 		   Address must be rewritten because HI is reset after data transport and
 		   expects an address.
 		 */
-		todo = (block_size < datasize ? block_size : datasize);
+		todo = min(block_size, datasize);
 		if (todo == 0) {
 			u16 overhead_size_i2c_addr = 0;
 			u16 data_block_size = 0;
@@ -1682,9 +1681,7 @@ static int drxdap_fasi_write_block(struct i2c_device_addr *dev_addr,
 				first_err = st;
 			}
 			bufx = 0;
-			todo =
-			    (data_block_size <
-			     datasize ? data_block_size : datasize);
+			todo = min(data_block_size, datasize);
 		}
 		memcpy(&buf[bufx], data, todo);
 		/* write (address if can do and) data */

-- 
2.44.0.769.g3c40516874-goog


