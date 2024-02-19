Return-Path: <linux-kernel+bounces-70959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203A7859EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D051B28144A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6DA22EED;
	Mon, 19 Feb 2024 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jPBZSxLK"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B3224CB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332400; cv=none; b=uS32zRJNwLyBc8Ub729A2QEtdnRNwgaui4htCiJXYyVg1Pko9S1OrB5ZdRkeRxytWUV6X8f9ftOFN4fE0Cydm0TWgkjrSW0DxrJvl4IUWLlpZZqhDroq3UOR5r1Ao6iEtj0R9l5xzACxB3ASGX14oPUZlOgxLhgJivlucNKYZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332400; c=relaxed/simple;
	bh=FH2htscXk/X8aEEd0rmIn5KlOU57aNG3ziB3k2ZqUEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KH/hM4czxaKhkahX0/5I/WwweZEkCIno4KiNcx3+7RfTnjYojE1yuVtbN0z19NMS97cb86PVZ70sZkjC5JSJrYygDXD+ejQoWAD98uoV3sTPReRocEpHy8VBE2rmpa22QvnFQW1c2XJZFgyFP1hDkkQuhqQDEXTFvlPzgfp8tCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jPBZSxLK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41269c801eeso1098065e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708332397; x=1708937197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWxIJjNp4lMMYstYmlzoB0KFF5EhSJgdyZd5fYccP2w=;
        b=jPBZSxLKaldQR92vgrGGr4ipO7IgUnSm+qx/fTmGKjml/89wHhcKKrf9BUb6yqzBVs
         mJxrpreZ91y5MEAjS69zf3Z4L8kwkyZVwlOCHprsMyMYNG0KHq1bPpHXGa7ZZR9pqyne
         9V9UhpHKhlKouDXSJfXCl277/inv/nbjd+BFKGEioZCsjev4qTKVjZftniua1PGSXFo6
         Y58Ru/T0gXhtJVNo/j0A6/dSGgriBxKBqkwj+ehiNtBzFaUp1xjkre0ZwzwkwWkNDtAc
         hlr0LnVLHDyqhFKJvukMbxYsiEjT1yYB68AtWFqEUz4yQ6vebGE6sfcB6MwfVLdC+cpB
         rP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708332397; x=1708937197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWxIJjNp4lMMYstYmlzoB0KFF5EhSJgdyZd5fYccP2w=;
        b=Fj3gIYVBbkBTVNlYL85A5qD8X4s4WPR8dbKHEUoFPMm6aogRC3nZ+w608fzMVEA5UP
         94i8MXO3s8zut1A66Rr1GsFIE6Y3zLsf+an5yfksxPkStjk8q6OWGjES/4O7GX/9Fjsm
         /0Yk9GujQdaUfWEdArk0V4qFthzpYKUpUScuVLseoutDlq1vNQZ8Zcd8bGb+FL0v8HdZ
         XZ5aKmnuJolGzr65RUHydzHlzRe21/vGD7N67BuFzFZQuFzpqxKijbjfEA8ClbzsFhGB
         Jt3iAH4G2UyEWTak8dxaKSBzx6hhb7ZI5kcdtSkFBy1dxlkEXunuEeHjmrf4S75OjNFu
         9XoA==
X-Forwarded-Encrypted: i=1; AJvYcCXMIdfAXlkKQjWYzp9kgZ7IonkxBwhO8onPbivCpBqZXcDkQw219ZZ/H5y+/98yyffxFAMYubw49UZRmL9nisHs0xZvZGkkGT8q6FGX
X-Gm-Message-State: AOJu0YyHj4zuM1cBwM8a+oyu0PKnVXY+B9Es2DsabFzL+bt2q0uVTHsw
	Ze6Ak1PgPzt/f7NXnBGhcdt9W79vYGwLzyEd8kuDM4rIy4zR9gmDLAxcdhzxK6w=
X-Google-Smtp-Source: AGHT+IGiMU6hAOF7DpkhiIBdIPh+dwo86MJ4mIYy2qRVsWBqOOQjWYGSo6p7sWojI2//46F9vDzvqg==
X-Received: by 2002:a05:600c:3508:b0:412:aca:5a01 with SMTP id h8-20020a05600c350800b004120aca5a01mr7760790wmq.8.1708332396972;
        Mon, 19 Feb 2024 00:46:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:88b:d6c3:a2f2:16d9])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b00410c7912c6esm10804545wmq.14.2024.02.19.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:46:36 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] arm64: defconfig: build ath12k as a module
Date: Mon, 19 Feb 2024 09:46:10 +0100
Message-Id: <20240219084610.11007-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part of
their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
defconfig.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 056a6cc546a4..3f3d3350cf90 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -408,6 +408,7 @@ CONFIG_WCN36XX=m
 CONFIG_ATH11K=m
 CONFIG_ATH11K_AHB=m
 CONFIG_ATH11K_PCI=m
+CONFIG_ATH12K=m
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
-- 
2.40.1


