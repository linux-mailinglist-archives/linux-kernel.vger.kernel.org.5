Return-Path: <linux-kernel+bounces-78919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA4861A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6FB1C254C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD9142627;
	Fri, 23 Feb 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UMEZ7IPC"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C113BADB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710687; cv=none; b=qVCh9CftlX2O2RWO0gPrxWZYvlZySzvtIS2khImzyZYT61vIgzj8PfmuspU3e82JT7y/aupSKDCSKYnuoWOa7MzDry4OxhasCxmQmfGGPUi6ZmTvPbf/yvSLGGEMgSqDscevLzdNq4owKwGGL7+7Zv6l2a5/sNVnKFflAKQig6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710687; c=relaxed/simple;
	bh=9ZZxPk/a7pO8ytzdAHohcBFzs6TPeMkP0Go5hItHYIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcn8Z3pqCQTcavXi29lW7DPQFnNfqrP/VuIvr3/tfd2i6PG0+oh5biL7sbK2n2dydOLyWs9OWek5eBft5iSX6YcfqEMkooOX63Q76rUilEIFWALY+W5w8RWFlJbLRiCxGcddGP5HYSRbW+w+gpSwOvuZvMmVpXDn2f4I0EnYi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UMEZ7IPC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412985de139so1298885e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708710684; x=1709315484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeCmmTR4nL1DWlLTvSXW5V8GjozKprjftrRX3BjbH5I=;
        b=UMEZ7IPCHok8MuRCYaGAsBqxLLEwSSM666/mNucBM0g0XFPAjGZA3uDJ40Kkc92Qks
         zqyON8lhCx9QqVFvFgyoGq8tuaHaiqGM1TbO5sh76jBuYTvz+tDU78apqF61kLAGHalT
         GtebLbhnOUiNQTi9t6gPmBdqq9jK5V1HbCviCXitCoZj+VVzJ3JxMzEi2mJ6MfBi4Coq
         HgY9JsZwX/VCsqFj8PmHWvRtnLL2TZcZcsCpenq1DLEXeWXvsIFW+RNckQrnF9D3atj7
         DgQCLCEFKVjD+gvpxT94KVddST4/g0ngix49BZjUSKy5sE1Zt0mKA4MdLOY6KsEOJUcS
         uq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710684; x=1709315484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeCmmTR4nL1DWlLTvSXW5V8GjozKprjftrRX3BjbH5I=;
        b=jIHITqhnIVgAs0+wnvsTsF5i9vH+njPSnsSeGwI2UsiRQnYpc4yZQxsYj+uK+QT9QW
         tHw+8bci7HNtkTk/cJSpNJ3KPuVZYMelhZyz5RC0cewuckWjlHYMYPaPJv2BRAkxNy8G
         pCr6rbo7PSQhD9+5qpC5RThEWYl7463zzY2qTEffA4wZDLgoD2Stco7hlv2s/NmvdaLb
         lECwcmksRPSNpiLp/vvKeqeipHJgDmUNmPMUOnSEM6uQbErk1RCKrU8nSIyTb2JkRQOP
         C52PJyqqhcUSmpGrPX4whAzhFK8pybF/Yf/Gr+HKuNn4AlmYHRcqQBX6f7F6GPneQAIB
         pa5w==
X-Forwarded-Encrypted: i=1; AJvYcCUOJ7Fs494rNxl4fBvGtGGne+jXUPP8K1JuwAUSVQ1l7/EDUpo2gixzkBdEbKQt4jp4EDZ2zS0iFu1FRRMA0xrm2MHPFjl7WVBiaX+p
X-Gm-Message-State: AOJu0YxlBe2dg3r50IvMkNazBEAAIsZSuF6yn50Ht+XAQfI8B0hruD06
	rjR+TfrxLfWxh5Vq6y5m/JFhzZYYlNpix9wo8UbUwCmUFDz38yyL3alHMvQOZSA=
X-Google-Smtp-Source: AGHT+IFFxDXAmiB4835JX0wNsSNqu2+o3xJ9l2em0tk9z8iXrduKI7NKlIlcZPE8y6hU/3jd20iOCA==
X-Received: by 2002:a05:600c:4f53:b0:412:96f2:2df9 with SMTP id m19-20020a05600c4f5300b0041296f22df9mr323815wmq.26.1708710684136;
        Fri, 23 Feb 2024 09:51:24 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e8a0:25a6:d4ec:a7ff])
        by smtp.googlemail.com with ESMTPSA id bo10-20020a056000068a00b0033cddadde6esm3711524wrb.80.2024.02.23.09.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:51:23 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 3/6] ASoC: meson: axg-tdm-interface: update error format error traces
Date: Fri, 23 Feb 2024 18:51:09 +0100
Message-ID: <20240223175116.2005407-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223175116.2005407-1-jbrunet@baylibre.com>
References: <20240223175116.2005407-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

ASoC stopped using CBS_CFS and CBM_CFM a few years ago but the traces in
the amlogic tdm interface driver did not follow.

Update this to match the new format names

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 2cedbce73837..bf708717635b 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -133,7 +133,7 @@ static int axg_tdm_iface_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	case SND_SOC_DAIFMT_BP_FC:
 	case SND_SOC_DAIFMT_BC_FP:
-		dev_err(dai->dev, "only CBS_CFS and CBM_CFM are supported\n");
+		dev_err(dai->dev, "only BP_FP and BC_FC are supported\n");
 		fallthrough;
 	default:
 		return -EINVAL;
-- 
2.43.0


