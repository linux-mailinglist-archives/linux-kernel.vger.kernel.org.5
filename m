Return-Path: <linux-kernel+bounces-57884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE784DE9C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156CCB21A11
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907956DCF9;
	Thu,  8 Feb 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3vp6zyT"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E1D3399F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389418; cv=none; b=T5vWp76yneYOG+or+9tIAtTqh42Y/vNAWg6RDwnvUciLBwc3oJhcMDWadXnUjZNnfqxMHPTxlYyKnUBtj09V8HPZz84iqBlMgo0JquTT5awe2zen0dPYFCdsd1dXDA2KZ6S/a8AGwH9aXSw3eyNCr5z1q3d5+zOSEyljGhr8LEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389418; c=relaxed/simple;
	bh=Sr8P3Tf0FtXDhvOXC3tlRbWTdTHoLpFXu5pFKXCOKKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PWn+/FV9zoiX0mg5XKVCz2u6X4iSfWqeM9qofiNT4Y/HUNw2o4Mk2ZuKUTwBkprHzrlqututOGBcAQcvq6/nbNTSStCO77QVvMAY8yBum9Lyb3abnUSkERQ2yhgSIF13l9GtfIOq8qMhIZoFuvawrczhA+ZN0OjkhWk/O6RXWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p3vp6zyT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1033008f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389415; x=1707994215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYKL8XFcoc0FjbT81AR/diSA8dcgkvpQY9lcUzsv4wE=;
        b=p3vp6zyTc74gIhPCtOLZZbNERKtkHvdFp7rWFHLI5BdUlsg296Q2y8CQ5w2MoOuLuH
         g/8S87XkRFok8osNlM5qo3jXsTBliev19gcSbi/N23QXKRZt36n6KQLC9XEDYB69UXsO
         vuwLgAOTgDMBz2QUBGXf98ITtzHrkEor2ECdI3HKZAajHB2lq0HVN47E0hV/JJP5myb0
         +KhsQvPGJAafVcndx2ntsM/899YO5MMOxW/+9hRy0HoXuiHdneqQkrbqn3aDF6ksOCTH
         sO9kzhookNDg4n+LEjW9Wda4YH6So/ifl4ykY/8mSyrOkZJgrer18rjwtBAaZ3RUyZU+
         wd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389415; x=1707994215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYKL8XFcoc0FjbT81AR/diSA8dcgkvpQY9lcUzsv4wE=;
        b=erOU7S2c3Sk6jCg1GIA1qk0pEU+4NnAjRP2+PYFMv6Uk7HuivDcxEKugU/seyxF1ts
         8NgwFobQNL4pxedJiWzCyw6fMjfgnwFkCS6eHD5TYZoH+54hs+Qqy5tjAjRgld9xmt/k
         WEn16bjQl0nBvLl77mz1iy/YQUbn1AT3fLMs/Ptr7IgYciz3+0VvlK6kv0mTNIf26LZV
         an/jSw7gB8u06+o2q+QjvXpLvax9CgMIsHF9KJHI/KdgwjaUSV1AbIGHKSmMVqtmNLMU
         22MJFcDwfsnTGn0cgV2dTvZbY4ehMhIc/r/HTAqQSDMrG2pwHSsg0jZVTx+j3+CgJV9g
         JVkA==
X-Forwarded-Encrypted: i=1; AJvYcCWHhtKjHOEsAUbAWm0THjwa4EvfUzSw9bm5htFFuGL/n1serh8tzak8/KR+qRyoPFEuTqxMqLbzqKqZONwEl+CZ8lClTbu15r/MGkUD
X-Gm-Message-State: AOJu0YydfgMpKwXcu5PH06hSW8VkXWJrTMaIsAGBdOp4mmLOaFEaEhK8
	aR0ayeEMjYsdaGuv5d+mkxT+bIYZSooLxhC+nY+6YCJ6MShgQRa+RMtFqqYKCu0=
X-Google-Smtp-Source: AGHT+IEEuMT7A2nJGQWYBalYGGYOIwae7inq6feMGMtSTWH2xCiM9iHS4TySWCsfLuKrtMpmaDEYYw==
X-Received: by 2002:a5d:4a10:0:b0:33b:160a:e506 with SMTP id m16-20020a5d4a10000000b0033b160ae506mr5292110wrq.33.1707389415079;
        Thu, 08 Feb 2024 02:50:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWA9m5ZfSTHk3Jq/wjFol8kRR0Pq/+E3mXtw8zvgNXA1G+UB7Ve5DF8yrIa89TNqhFg/ErIEfMEJVLB3AUOFg1hWjtB6RqYscUQx4uQBRawryx2/5a6gXsAlJap9K9ee4On4MiX65eBqHpYHqNJ5atwkbTJA5PI+Iy4P9TttFdFsO/pdc2ORbqoLnDpBCy6QvHNKgIcOJa/PveAgoB/aDnYJP+BiU/+1Qc9GfkOnj90gNn13mpR
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b0033b59f4d46esm743211wrb.108.2024.02.08.02.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:50:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: codecs: constify static sdw_slave_ops struct
Date: Thu,  8 Feb 2024 11:50:11 +0100
Message-Id: <20240208105011.128294-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct sdw_slave_ops is not modified and sdw_driver takes pointer to
const, so make it a const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/max98363.c        | 2 +-
 sound/soc/codecs/max98373-sdw.c    | 2 +-
 sound/soc/codecs/rt1017-sdca-sdw.c | 2 +-
 sound/soc/codecs/rt712-sdca-dmic.c | 2 +-
 sound/soc/codecs/rt712-sdca-sdw.c  | 2 +-
 sound/soc/codecs/rt722-sdca-sdw.c  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98363.c b/sound/soc/codecs/max98363.c
index a2cca3436c68..950105e5bffd 100644
--- a/sound/soc/codecs/max98363.c
+++ b/sound/soc/codecs/max98363.c
@@ -314,7 +314,7 @@ static int max98363_update_status(struct sdw_slave *slave,
 	return max98363_io_init(slave);
 }
 
-static struct sdw_slave_ops max98363_slave_ops = {
+static const struct sdw_slave_ops max98363_slave_ops = {
 	.read_prop = max98363_read_prop,
 	.update_status = max98363_update_status,
 };
diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index b5cb951af570..383e551f3bc7 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -821,7 +821,7 @@ static int max98373_bus_config(struct sdw_slave *slave,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops max98373_slave_ops = {
+static const struct sdw_slave_ops max98373_slave_ops = {
 	.read_prop = max98373_read_prop,
 	.update_status = max98373_update_status,
 	.bus_config = max98373_bus_config,
diff --git a/sound/soc/codecs/rt1017-sdca-sdw.c b/sound/soc/codecs/rt1017-sdca-sdw.c
index 7295f44c77eb..4dbbd8bdaaac 100644
--- a/sound/soc/codecs/rt1017-sdca-sdw.c
+++ b/sound/soc/codecs/rt1017-sdca-sdw.c
@@ -520,7 +520,7 @@ static const struct snd_soc_dapm_route rt1017_sdca_dapm_routes[] = {
 	{ "DP2TX", NULL, "V Sense" },
 };
 
-static struct sdw_slave_ops rt1017_sdca_slave_ops = {
+static const struct sdw_slave_ops rt1017_sdca_slave_ops = {
 	.read_prop = rt1017_sdca_read_prop,
 	.update_status = rt1017_sdca_update_status,
 };
diff --git a/sound/soc/codecs/rt712-sdca-dmic.c b/sound/soc/codecs/rt712-sdca-dmic.c
index ba08d03e717c..0926b26619bd 100644
--- a/sound/soc/codecs/rt712-sdca-dmic.c
+++ b/sound/soc/codecs/rt712-sdca-dmic.c
@@ -944,7 +944,7 @@ static const struct dev_pm_ops rt712_sdca_dmic_pm = {
 };
 
 
-static struct sdw_slave_ops rt712_sdca_dmic_slave_ops = {
+static const struct sdw_slave_ops rt712_sdca_dmic_slave_ops = {
 	.read_prop = rt712_sdca_dmic_read_prop,
 	.update_status = rt712_sdca_dmic_update_status,
 };
diff --git a/sound/soc/codecs/rt712-sdca-sdw.c b/sound/soc/codecs/rt712-sdca-sdw.c
index 6b644a89c589..01ac555cd79b 100644
--- a/sound/soc/codecs/rt712-sdca-sdw.c
+++ b/sound/soc/codecs/rt712-sdca-sdw.c
@@ -331,7 +331,7 @@ static int rt712_sdca_interrupt_callback(struct sdw_slave *slave,
 	return ret;
 }
 
-static struct sdw_slave_ops rt712_sdca_slave_ops = {
+static const struct sdw_slave_ops rt712_sdca_slave_ops = {
 	.read_prop = rt712_sdca_read_prop,
 	.interrupt_callback = rt712_sdca_interrupt_callback,
 	.update_status = rt712_sdca_update_status,
diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index e24b9cbdc10c..eb76f4c675b6 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -362,7 +362,7 @@ static int rt722_sdca_interrupt_callback(struct sdw_slave *slave,
 	return ret;
 }
 
-static struct sdw_slave_ops rt722_sdca_slave_ops = {
+static const struct sdw_slave_ops rt722_sdca_slave_ops = {
 	.read_prop = rt722_sdca_read_prop,
 	.interrupt_callback = rt722_sdca_interrupt_callback,
 	.update_status = rt722_sdca_update_status,
-- 
2.34.1


