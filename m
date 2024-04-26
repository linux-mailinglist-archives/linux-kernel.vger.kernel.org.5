Return-Path: <linux-kernel+bounces-160290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B499C8B3B79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E25B2600B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ECE149E00;
	Fri, 26 Apr 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L4W5wNvE"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757D14885D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145400; cv=none; b=gI/bRUzUvyovE5LfTdCH1QflcpVOT5c2G3IxnJa6DpDOQ/6dSs3iVWBh8yemR+NB5yNlvo/KzZFEiSaHg5E94qgCu9gXtN9T2YQ7QJZkAq8QdO9ErouOdkHGOptR6d9nylddQrKgCDhchAHbxPSFZlQXZjVAWwpsUz2LLHOUe5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145400; c=relaxed/simple;
	bh=twiWpSK9Cb/9sMit7KrauKpyDpxWaybLQZDeq8xxcKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cytJFvtZXvsJyl7VUpeESOyROCbeE4IqwwH/do/v3vrUKJ4rUJ31Q4UaE+FdtIjZvRRWx1wyTKXNdGbO3yNLaeElKCwebHTp5oa1Ik3MTxCZ548BYrDFjE/O74dfY2qWmh0inOMeJLHlvnlrxkNm2ELDGAa8Gg/ZltBdYxffSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L4W5wNvE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso17372285e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714145396; x=1714750196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj88fGfTuV4/ceY0CRDNjfucEqH3NJ0Iz+8z4tgOcCE=;
        b=L4W5wNvE8ZtGmSLyT5BR0ewkJMXa/cIsH2KFCx9x3kG1k2ItO8x94TAQsU+zVU6faN
         JgJdBg6DzYKgwPOkkgVlV36d972Tc3A70QxQITEU9mwXtaIzQF+R/GcnFB0Do0C6DywQ
         O6EFKMuQOnQWFZoIvsS4a27pWgnqdLU6WBDvdfqTD6zWpv4gEdlHwV/OseJSQ7JkIbty
         +FWaNFARHMX2VmZm5oUKEANx5sTvyTP5EYU77Z7O2KesklZRgf3tvxbsPOkKB52BbIlM
         fWxVM41Rdj/ho1VY3L0UFBM38EzOFAOpzQW12LGLuEzzOD5qleXq9BTA9hbbX88yBi2U
         RvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145396; x=1714750196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj88fGfTuV4/ceY0CRDNjfucEqH3NJ0Iz+8z4tgOcCE=;
        b=tikR30P5uNd21glQlv2+Eh3iRqQLTIIVy6BkqppX/tWRdc9PvVsr7fJ8Nj9rbWKfWI
         rUVcFhMBaUkdnzO4pc4603siojl/wSegCxGxXQCor4jnnTwAB1qyDZkbUmWMpseW2ogt
         VroM4AdqNxl+tIOddWd/hI/ElQYmiX9OvlLNq9NSWGoljRjPzVAO1zFrs+glEMUUrXKw
         uFP3HdUfrpt7nIgDbrQZwB0BaOi/O2RQD/ScUGwaPlUbGVHOYDHwMV/91tQwQBCxrIcu
         NobETf8KuuaNci7ntkFxwKMofMtV2eptNDiL9EtWxS85G6ByfL5BKwChfe0n+Wa2Rr3V
         vNOg==
X-Forwarded-Encrypted: i=1; AJvYcCXUFOYEiIoGFHmcqT5xrdT1YzfqLGDgSIkM53xbM6K9HQ462dsU1lzu86I21clWlpuPwt51iT+ApaxYsItqnUO8jkw+AT+XDOX5364F
X-Gm-Message-State: AOJu0YyCGklHCXwmYLoqC6BgRAGXh++/b8YvD1pezZHYeGmCaJL86ApS
	8VUGG+mOd9PhuI1t2EkKoZVnRmCj0cjnawIG0Rfu2SlELe3c4sl4hLVFHtLKWro=
X-Google-Smtp-Source: AGHT+IEJkZy/zcyYjS/mRx4ZV80tXFjeoyE7of0nB7BlzZ+4FKV/1yBAljbeQBu73IdnjR2X5uGAvA==
X-Received: by 2002:a05:600c:b88:b0:418:f991:8ad4 with SMTP id fl8-20020a05600c0b8800b00418f9918ad4mr113607wmb.6.1714145396564;
        Fri, 26 Apr 2024 08:29:56 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1926:f73e:8b99:1c0a])
        by smtp.googlemail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm22628687wmq.27.2024.04.26.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:29:56 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 2/4] ASoC: meson: axg-card: make links nonatomic
Date: Fri, 26 Apr 2024 17:29:39 +0200
Message-ID: <20240426152946.3078805-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426152946.3078805-1-jbrunet@baylibre.com>
References: <20240426152946.3078805-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Non atomic operations need to be performed in the trigger callback
of the TDM interfaces. Those are BEs but what matters is the nonatomic
flag of the FE in the DPCM context. Just set nonatomic for everything so,
at least, what is done is clear.

Fixes: 7864a79f37b5 ("ASoC: meson: add axg sound card support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 3180aa4d3a15..8c5605c1e34e 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -318,6 +318,7 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 
 	dai_link->cpus = cpu;
 	dai_link->num_cpus = 1;
+	dai_link->nonatomic = true;
 
 	ret = meson_card_parse_dai(card, np, dai_link->cpus);
 	if (ret)
-- 
2.43.0


