Return-Path: <linux-kernel+bounces-78918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA383861A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44F71C21394
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3940137C2B;
	Fri, 23 Feb 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cn0snWVT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A638DC9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710687; cv=none; b=bIB7FJLZ0/A/kkG20/o1dUpnHDhWrzPSC2FkVIplqJoDw4ZNmvMGaY8DKLtwsm5hQLq93fE9x2X5a2YBeSZCNYq0sqvKqVRgReJ5dGmjKsJhBXUcQ7+ThSKubs18uCCoVzxGE8i9eJpl0IwpRxYZo/P9dpPXq7KYd2WpmIjQLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710687; c=relaxed/simple;
	bh=9iTKsLd2naG6/LuO6Oah0bN0yvaYH3+/7aYFeVuI/cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJG09n0uGqGBV7ZdPyYGQud9TCsIPgooP/N5Fx+sLqsY6hvpmA183G+3n3dwZ1IsaVHN6Ektt7ds6g0ikdJf1rgzjMQanzufR6Z3gyaSooisVAySVW+UG+fz9spVt+EK57a9ja8YrSZnrY646bYUaf7q672Ae4D/6nFi+dm9Kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cn0snWVT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412985a51ecso1455245e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708710681; x=1709315481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yu1bwk/GIByUriwvGbqNE3H0ftJWcJoKT333Tzyi/Co=;
        b=Cn0snWVTyTMDtJLiuZ02xKW7NEUd3Cp6PCwRM42HFlZy7QyYm9Dqs/h3aDhei38UCs
         h31cSlb7SEw67Ig0iIRkDCQMVDVALos+Gc3CpjAJHMq2YGDFVuTItMebAg1nToVWHdqT
         l6ZZrwB3VmUmFH8z0AmwDEoYikI2/5GO6+S5+WhtLHhjGuNW2drY0WVnJ1AZySCXH7Pt
         QYe190kwzdD3BLlr1kyXcPjFlmMRkEeedC1FZ8b+Z1vTd6UPizdjuZSPXF1ComM7oMrr
         KbN1s02k6fxJqPnYqXz7fQWgyggQOZkqwb1hc9jWAoRgznudSOlfdCbGLp37RjZ75Gb3
         KpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710681; x=1709315481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yu1bwk/GIByUriwvGbqNE3H0ftJWcJoKT333Tzyi/Co=;
        b=NYzfX7aRkZGZGkPRzmklz+ipm3u7XWnyfgXLneeo5I75p2AJl8cR4zq5R4PQI2uzx6
         pAUooYX43I/F/A/uyzU0YxoczVAHOc9SVhCGjNHGO1JbOa4GHaMByfOzlLB2zM2S3+X0
         fskf3+DoHlkwoUm83MEuznTiNcHSZsztBmEupp4+AJZ3Ei1lejiJY/VXIlo/SOThu2IG
         44N7Q5QeH+cMZQq7OCUh5NJTXoAHuBolBxmrDCEe5dQU/DO5GRq1v2tECyqdXPmEKjxe
         ItsR7x5aneBSiXO4mcyxMu5ifkDdJLl1frGTk2ZnBllvbeGg3czmAZtXQaA3PaDnV9Z2
         kESw==
X-Forwarded-Encrypted: i=1; AJvYcCWIPNb5kzmbVEaL7/J7/hQP51G4BXYioNCrqSk8RiiDy1zgcrAnkO35nFqUpcKDjD4IpglrBaqWqne6KrQVaCtd+/2KzJ/q7BBQyahY
X-Gm-Message-State: AOJu0Yz5e2+rU4Aqmnx5A2jWF8DAAGJOOIw19lued4nmagvB61j2G3ay
	clxZbzOJruOLJDvxyKJrUEDMs8IdP0Vg/qkV4Ge4/SPJZC0xnHMgihbttAkF1iI=
X-Google-Smtp-Source: AGHT+IFkYJrBJtukK9q7sO/gOkuklYt7sfbCdKw6TBDgo/yenxFPlAQU3wk00xs7vV/eLiTHDjjHeA==
X-Received: by 2002:a05:600c:1e13:b0:412:94b6:bb75 with SMTP id ay19-20020a05600c1e1300b0041294b6bb75mr362379wmb.30.1708710681574;
        Fri, 23 Feb 2024 09:51:21 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e8a0:25a6:d4ec:a7ff])
        by smtp.googlemail.com with ESMTPSA id bo10-20020a056000068a00b0033cddadde6esm3711524wrb.80.2024.02.23.09.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:51:21 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 0/6] ASoC: meson: axg fixes and clean-up
Date: Fri, 23 Feb 2024 18:51:06 +0100
Message-ID: <20240223175116.2005407-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

This are various fixes and clean up gathered while working on Amlogic audio
support. These help better handle higher and unusual clock configuration
for TDM, SPDIF or PDM.

Jerome Brunet (6):
  ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
  ASoC: meson: axg-tdm-interface: add frame rate constraint
  ASoC: meson: axg-tdm-interface: update error format error traces
  ASoC: meson: axg-spdifin: use max width for rate detection
  ASoC: meson: axg-fifo: take continuous rates
  ASoC: meson: axg-fifo: use FIELD helpers

 sound/soc/meson/axg-fifo.c          | 24 +++++++++++-----------
 sound/soc/meson/axg-fifo.h          | 14 +++++--------
 sound/soc/meson/axg-frddr.c         | 12 +++++++----
 sound/soc/meson/axg-spdifin.c       |  6 +++---
 sound/soc/meson/axg-tdm-interface.c | 31 +++++++++++++++++++----------
 sound/soc/meson/axg-toddr.c         | 29 ++++++++++++++-------------
 6 files changed, 64 insertions(+), 52 deletions(-)

-- 
2.43.0


