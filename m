Return-Path: <linux-kernel+bounces-151248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD618AABDD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491CA1F21CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350117C081;
	Fri, 19 Apr 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Idfbl1l6"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A49676402
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520161; cv=none; b=e0mq9G272ux42W1Ddiiqc0LsIkXqiTdHWaeqU8cAOZT3kDFP9w8woOhayRHdLE/4uKVvljykX88tILutKei/3fbhzSOcpalWVy02Q2DHhcp/s17IlGcx/ztKLRLGGMzlcslxmkqMYYw/vjQI6tG+4IqmS77YjtjVX62r3QAdtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520161; c=relaxed/simple;
	bh=pKDV/DDljfYbyJBEoKPsy5J2SxcCvPCQTO74udVktBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jR1JUAbC0MG4ig/Z2GaX+cKMi+dcIhdiEDesyMlWtPRWOQyywTo3JDt2xC0SMazZNROD0LCp/6G1Ovl7GekHLIYjaPK4/KWbn/6nJWRYYY5jyCuPEgAD02rzQEnnWzGkdRAQ/q17tKM85hDn+SnLckSQw/qWxu72ZWm8ksP6chM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Idfbl1l6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78d62c1e82bso124684285a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713520158; x=1714124958; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRNZApPOWNGUw9rh6uD/J/LwtHi/yERWjgUEfHZaap4=;
        b=Idfbl1l6Bz8rBtDI/g5CHK5dcpqZcXJSkObZTfqMpExfgp9orquZpn7wc/v3hMmPfI
         HtlvRYCkWQomDW7iiWg8NkG4rmfoA0N1cij5+HYu0Td4s1SG+kbTC27pBXLvUWbcntvm
         sOtEgfIKf6+u3q6TIxjF7U4HoroB2CttxP10w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520158; x=1714124958;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRNZApPOWNGUw9rh6uD/J/LwtHi/yERWjgUEfHZaap4=;
        b=JsVfM1nIX/R6i7OiCxG8eFxSIP1YGQxaqawUHugfzB9k7BG2zFY/0ruSIjVb8gh/Gf
         jX93kguPkklXaKOkzVrhCazcxNZlo89edYKyDAM94dKnw0JnipjVtmf/P5E9BMFTSUSc
         lj+9Bi017M9S9O1LDsWGNZHWCHMr+XEzlkpalYV15zz/hztl/CItYsRmaUhk3UmenkhB
         nJJHPM8QfT91FMtbko81/Ar7bmGX69GdOzQinryw81thT+dcgzcWUoUydA2jfL3OYnRI
         blRiLn/PK7FNrphQw9v9JhbK1A1Z2+4aGGamgHru5IMUr5khvMETY/a96VSFvPbQN1rU
         bs3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7jyyF5xpLPrjkqIYd7522Dnngm3LK78AuOLstkeGepOKQy02gKJ8EGsvptTVuLgFeXa/+GyHQQpqLH82OJS4ZjQQggpXoBuKmxGfu
X-Gm-Message-State: AOJu0YxzmeZRBwE09QluS8XmcBDxao2v5EDSz/oxjB5kpkL9KB+te6wI
	3QGEgR7pgWNTCX+S/7ss1QL6FC8O0BK1ath5oBeXdfaqpGoTo6TQDmEMHAxwkg==
X-Google-Smtp-Source: AGHT+IEwFEqraeOqWxkPQAAFkUs5oWfyDBRxF4A8wk2qhAECZd6CFNAdYxUvmXxXTuoou68/E0VA+g==
X-Received: by 2002:a05:620a:5a4f:b0:78d:6c05:b498 with SMTP id wx15-20020a05620a5a4f00b0078d6c05b498mr1754759qkn.14.1713520158006;
        Fri, 19 Apr 2024 02:49:18 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id dt14-20020a05620a478e00b0078d735ca917sm1434532qkb.123.2024.04.19.02.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:49:17 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 00/26] media: Fix coccinelle warning/errors
Date: Fri, 19 Apr 2024 09:47:46 +0000
Message-Id: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMI9ImYC/22MQQ7CIBBFr9LMWgxMUYwr72G6oBTKLFrMoETTc
 Hexa5fv/5e3QfZMPsO124B9oUxpbYCHDly06+wFTY0BJWqp1UkEeguXnCOBU+h9QLTnYKD5D/b
 t3Fv3oXGk/Ez82dNF/dZ/laKEFNoYG0bsDV7Gm4ucFnotx8QzDLXWL2eD/W6lAAAA
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
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.12.4

After this set is applied, these are the only warnings left:
drivers/media/pci/ivtv/ivtv-fileops.c:223:4-10: preceding lock on line 267
drivers/media/pci/ivtv/ivtv-fileops.c:230:3-9: preceding lock on line 267
drivers/media/pci/ivtv/ivtv-fileops.c:236:4-10: preceding lock on line 267
drivers/media/pci/ivtv/ivtv-fileops.c:245:3-9: preceding lock on line 267
drivers/media/pci/ivtv/ivtv-fileops.c:251:3-9: preceding lock on line 267
drivers/media/pci/ivtv/ivtv-fileops.c:257:3-9: preceding lock on line 267
drivers/media/pci/ivtv/ivtv-fileops.c:272:3-9: preceding lock on line 267
drivers/media/pci/ivtv/ivtv-fileops.c:598:4-10: preceding lock on line 627
drivers/media/pci/ivtv/ivtv-fileops.c:598:4-10: preceding lock on line 689
drivers/media/pci/ivtv/ivtv-fileops.c:606:3-9: preceding lock on line 627
drivers/media/pci/ivtv/ivtv-fileops.c:606:3-9: preceding lock on line 689
drivers/media/pci/ivtv/ivtv-fileops.c:648:3-9: preceding lock on line 627
drivers/media/pci/ivtv/ivtv-fileops.c:648:3-9: preceding lock on line 689
drivers/media/pci/ivtv/ivtv-fileops.c:692:4-10: preceding lock on line 689
drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2776
drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2786
drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2809
drivers/media/dvb-frontends/stv090x.c:799:1-7: preceding lock on line 768
drivers/media/usb/go7007/go7007-i2c.c:125:1-7: preceding lock on line 61
drivers/media/rc/imon.c:1167:1-7: preceding lock on line 1153
drivers/media/pci/cx18/cx18-scb.h:261:22-29: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:77:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:85:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:154:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:171:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:180:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:189:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:201:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:220:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:230:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:764:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1008:43-60: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1014:36-46: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1041:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1088:39-51: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1093:5-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1144:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1239:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1267:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1272:4-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/common/siano/smscoreapi.h:619:5-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/common/siano/smscoreapi.h:669:6-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/common/siano/smscoreapi.h:1049:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/common/siano/smscoreapi.h:1055:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/dvb-frontends/mxl5xx_defs.h:171:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/dvb-frontends/mxl5xx_defs.h:182:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/allegro-dvt/nal-hevc.h:102:14-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/xilinx/xilinx-dma.h:100:19-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/staging/media/atomisp/pci/atomisp_tpg.h:30:18-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

CI tested:
https://gitlab.freedesktop.org/linux-media/media-staging/-/commit/055b5211c68e721c3a7090be5373cf44859da1a7/pipelines?ref=ribalda%2Ftest-cocci

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Remove all the min() retval, and send a patch for cocci:  https://lore.kernel.org/lkml/20240415-minimax-v1-1-5feb20d66a79@chromium.org/T/#u
- platform_get_irq() cannot return 0, fix that (Thanks Dan).
- Fix stb0800 patch. chip_id can be 0 (Thanks Dan).
- Use runtime (IS_ENABLED), code looks nicer. (Thanks Dan).
- Do not replace do_div for venus (Thanks Dan).
- Do not replace do_div for tda10048 (Thanks Dan).
- Link to v1: https://lore.kernel.org/r/20240415-fix-cocci-v1-0-477afb23728b@chromium.org

---
Ricardo Ribalda (26):
      media: pci: mgb4: Refactor struct resources
      media: stb0899: Simplify check
      media: uvcvideo: Refactor iterators
      media: uvcvideo: Use max() macro
      media: go7007: Use min and max macros
      media: stm32-dcmipp: Remove redundant printk
      media: staging: sun6i-isp: Remove redundant printk
      media: dvb-frontends: tda18271c2dd: Remove casting during div
      media: v4l: async: refactor v4l2_async_create_ancillary_links
      staging: media: tegra-video: Use swap macro
      media: s2255: Use refcount_t instead of atomic_t for num_channels
      media: platform: mtk-mdp3: Use refcount_t for job_count
      media: common: saa7146: Use min macro
      media: dvb-frontends: drx39xyj: Use min macro
      media: netup_unidvb: Use min macro
      media: au0828: Use min macro
      media: flexcop-usb: Use min macro
      media: gspca: cpia1: Use min macro
      media: stk1160: Use min macro
      media: tegra-vde: Refactor timeout handling
      media: i2c: st-mipid02: Use the correct div function
      media: tc358746: Use the correct div_ function
      media: venus: vdec: Make explicit the range of us_per_frame
      media: venus: venc: Make explicit the range of us_per_frame
      media: dvb-frontends: tda10048: Fix integer overflow
      media: dvb-frontends: tda10048: Make explicit the range of z.

 drivers/media/common/saa7146/saa7146_hlp.c         |  8 +++----
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |  9 +++-----
 drivers/media/dvb-frontends/stb0899_drv.c          |  2 +-
 drivers/media/dvb-frontends/tda10048.c             | 13 +++++++----
 drivers/media/dvb-frontends/tda18271c2dd.c         |  4 ++--
 drivers/media/i2c/st-mipid02.c                     |  2 +-
 drivers/media/i2c/tc358746.c                       |  3 +--
 drivers/media/pci/mgb4/mgb4_core.c                 |  4 ++--
 drivers/media/pci/mgb4/mgb4_regs.c                 |  2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c  |  2 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   | 10 ++++-----
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |  6 ++---
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |  2 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |  6 ++---
 drivers/media/platform/nvidia/tegra-vde/h264.c     |  6 ++---
 drivers/media/platform/qcom/venus/vdec.c           |  7 ++----
 drivers/media/platform/qcom/venus/venc.c           |  7 ++----
 .../platform/st/stm32/stm32-dcmipp/dcmipp-core.c   |  7 ++----
 drivers/media/usb/au0828/au0828-video.c            |  5 +----
 drivers/media/usb/b2c2/flexcop-usb.c               |  5 +----
 drivers/media/usb/go7007/go7007-fw.c               |  4 ++--
 drivers/media/usb/gspca/cpia1.c                    |  6 ++---
 drivers/media/usb/s2255/s2255drv.c                 | 20 ++++++++---------
 drivers/media/usb/stk1160/stk1160-video.c          | 10 ++-------
 drivers/media/usb/uvc/uvc_ctrl.c                   | 26 ++++++++++++----------
 drivers/media/v4l2-core/v4l2-async.c               |  7 +++---
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c  |  3 +--
 drivers/staging/media/tegra-video/tegra20.c        |  9 ++------
 28 files changed, 84 insertions(+), 111 deletions(-)
---
base-commit: 836e2548524d2dfcb5acaf3be78f203b6b4bde6f
change-id: 20240415-fix-cocci-2df3ef22a6f7

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


