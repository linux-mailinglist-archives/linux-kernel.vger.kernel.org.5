Return-Path: <linux-kernel+bounces-101282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269BF87A505
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DBAB21486
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694420B3D;
	Wed, 13 Mar 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RETG+2Ov"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D920310
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322258; cv=none; b=BR+QwwOfNXgfLWmD0FGDwkJtbhfre+mlEBgz+XpLXSJqddfs9yqUK2PKJgdQ0lq2oO11+XRoUOB60UYXyRL7nS8X14cph2otXt21+UcaZ4rEs3wT8k61Yz+aukrjqehYKQqPPM9AgupveL0KHT+nve8Xh0yjo/yN2xdyiYH7b8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322258; c=relaxed/simple;
	bh=YF7fTtdvfzFITVVZ7CSzpov04FdfNLIQqExickCxZeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=faCk7yb8L4ly9AdZ/iJ4LTFm67H9ZP2KEEwl22mtFH5YaAshXMOSqW0PMnH3q+z0lusRmUTzdcU2ka4CH3tNO4wQFS9oWr1EGkg4vkR++3CC2bFVD2U3HwfwxDJc8VRYNuWb6bco8IxMTLNFmmEZlz8MmXnklTjJS+K2ZHA9UmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RETG+2Ov; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e5978fc1bso2962809f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710322253; x=1710927053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iaQ6hYyfIjuTV/f0JHvHCFbfoBb3uN3YSYBT/944sI=;
        b=RETG+2Ovv1zAj9PIIkkOw5sRzu14cdI8VB2AIPUtjnjlay1wYb+w2gB5GYSr3ujWPl
         XXt4nmVXrgjwTtqsPi56MmocNydKDqQOmpeP4ldMLiT7dJz+tn6bDxyYEZrRdg63DApX
         IBOqpbv2eu2lkFwiPWIesFtM7P5qJ6RnSJ5g4tt++/UhQY5JufHzhEmRz/o/82hjsUXd
         tpC9Pm/0JdT5xnIORBITPwrkx4aLuZkffAuCFYkDHghtge0R04AbSL9+IR0VTChRJT7/
         dQZ5KsgMQpzbFbqxNsizT0NoNpWAdwzJxYpKHVMMzn+dC6/9iTmd44//QWse+zCIb/zj
         2fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710322253; x=1710927053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iaQ6hYyfIjuTV/f0JHvHCFbfoBb3uN3YSYBT/944sI=;
        b=CLgzt9yaaB5yaVBesGAwqKcbSfnNHcAmNbdiumkchzfXPAlq8D8egCtv02FaKVBrtk
         kp0hetN4X0m1z/AxstrNoMQRd6ChUd4thsh65kEV1VIcp/YFWzfUQf5fC2JxPz5a0G0D
         bmO8iC7jvn6lNqHG2nTlz4/60YZLz24UgO9kCpKd7AeXTJvwjGg2oFcuM9K/p7ZgIt5c
         /kBbQuvmr6QePrrnetqc3XpAj2h7OnEGSivU/XVuq5lalnytHn8GKjSKambZj4QHBiWZ
         igH7liDKzb+iZeynnoQzOnt/ntFxWOwSuwwI0VOCC24pSznyw9h0a3LKKw3/gRKTiN5P
         1bxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlDcp1wxkEVf9TqaTTefKvSaNc7GcQ4rtTgl7KrV7kvuLG/YHbl1+xQ5N3ReTr+F1SvbAxV0Iqre0qLsCsbr+EWD6p46virUaLAzf9
X-Gm-Message-State: AOJu0Ywtged8pnuk65KWpTkkQeZGQeLtzhEK9/ZdggxGLYZrzO6BasfA
	yVCcp2l/wAJLu/iOPYOmJYCROtVIer3bFOZdMV2CRHmyzDHbusqbRAmxLSgGYp0=
X-Google-Smtp-Source: AGHT+IHOxW2fc6sifUNboDvsgW2TAK2bJxYdUATmykFu8/IURNo6dLiw5NA23jNocx0yffVbPmsmHw==
X-Received: by 2002:a5d:6189:0:b0:33d:269e:132a with SMTP id j9-20020a5d6189000000b0033d269e132amr1388116wru.15.1710322252904;
        Wed, 13 Mar 2024 02:30:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id q18-20020adf9dd2000000b0033e90e98886sm8630674wre.71.2024.03.13.02.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 02:30:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>
Subject: [PATCH] mmc: renesas_sdhi: Set the SDBUF after reset
Date: Wed, 13 Mar 2024 11:30:31 +0200
Message-Id: <20240313093031.3507979-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

For development purpose, renesas_sdhi_probe() could be called w/
dma_ops = NULL to force the usage of PIO mode. In this case the
renesas_sdhi_enable_dma() will not be called before transferring data.

If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
call from renesas_sdhi_probe() will configure SDBUF by calling the
renesas_sdhi_sdbuf_width() function, but then SDBUF will be reseted in
tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.

To fix this call again the renesas_sdhi_sdbuf_width(host, 16); in
renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
removed from renesas_sdhi_clk_enable() as the host->reset() is optional.

Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c675dec587ef..b51e04fa5445 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -589,6 +589,12 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 			priv->needs_adjust_hs400 = false;
 			renesas_sdhi_set_clock(host, host->clk_cache);
+
+			/*
+			 * In case the controller works in PIO mode the SDBUF needs to be set as its
+			 * reset value is zero.
+			 */
+			renesas_sdhi_sdbuf_width(host, 16);
 		} else if (priv->scc_ctl) {
 			renesas_sdhi_scc_reset(host, priv);
 		}
-- 
2.39.2


