Return-Path: <linux-kernel+bounces-19177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79949826953
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2D4B211BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5DFBE6F;
	Mon,  8 Jan 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eSIDp8pI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA8B665
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d45f182fa2so13319485ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704701923; x=1705306723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PajgPkTBW3iluxw6UIGchSAnGs+6/xnB8PBfDDEr3ic=;
        b=eSIDp8pIUHRUnRMpRxvShBcC93mhY4GBatmmS/Et4yMbFzihxilFXskFnVeRsq1UR+
         azfv0ojCvJMg5TCEURzdYa1TkJttmljkwoaP0BfNHFSQHyO8jWiCCQoORok67sVUWRwG
         zgO566agMWhFxA279kj/GOPpZWNG5g4RMgJ60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704701923; x=1705306723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PajgPkTBW3iluxw6UIGchSAnGs+6/xnB8PBfDDEr3ic=;
        b=wOyEqkyycfGhFuJW/LnVwCN5F+ofV+c5IEQ0XFhWYY5lFpW6qft6AqRKrWBab3kLP4
         GRED9yDw44iasM15O0DhtfC3m0HMn/L5z0ywRHEaPc/YfsEKXr9y5N+jIX8mrK7MFGdQ
         7fWkaqd6vwf08fnUQtOIbvbQDAvycgCILGqYebNRm1eYQc/aAZKFoYekQPFlrGcGaCPp
         DlrF8JcacfbcgwWZkNahgaFvCcIwWTt9/YxwuumepiQV2hMYmfTnRK1NGJoGXHZUjCYD
         urb8zCgWbocvW54vcdITYuqUTjxXYvnJ7EugzUQBdyKgPZOpFnVKnzT+RTlMYCHR/FmV
         TcZA==
X-Gm-Message-State: AOJu0YxhgcbBlOj/8NAq9WFt743aP0akTQarn4NFjX1X18Q3EwvxEva5
	QAgxxF3rBETtbsPbJkBCM8lzWYIj8s4A
X-Google-Smtp-Source: AGHT+IHWcp3e1C1pCxpD9ZE1ctDnpB0lvwh36vHDQttf1iujltl/YpMCv6WgVen6qzG0XRhu94epxQ==
X-Received: by 2002:a17:902:dac5:b0:1d0:6ffe:9f5 with SMTP id q5-20020a170902dac500b001d06ffe09f5mr4245569plx.83.1704701923020;
        Mon, 08 Jan 2024 00:18:43 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:6859:f8da:3370:7a74])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d078445059sm5672513plb.143.2024.01.08.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:18:42 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Pin-yen Lin <treapking@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Weiyi Lu <weiyi.lu@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] clk: mediatek: mt8183: Enable need_runtime_pm on mt8183-mfgcfg
Date: Mon,  8 Jan 2024 16:18:16 +0800
Message-ID: <20240108081834.408403-2-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240108081834.408403-1-treapking@chromium.org>
References: <20240108081834.408403-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt8183-mfgcfg has a mutual dependency with genpd during the probing
stage, so enable need_runtim_pm to prevent a deadlock in the following
call stack:

CPU0:  genpd_lock --> clk_prepare_lock
genpd_power_off_work_fn()
 genpd_lock()
 generic_pm_domain::power_off()
    clk_unprepare()
      clk_prepare_lock()

CPU1: clk_prepare_lock --> genpd_lock
clk_register()
  __clk_core_init()
    clk_prepare_lock()
    clk_pm_runtime_get()
      genpd_lock()

Do a runtime PM get at the probe function to make sure clk_register()
won't acquire the genpd lock.

Fixes: acddfc2c261b ("clk: mediatek: Add MT8183 clock support")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

(no changes since v1)

 drivers/clk/mediatek/clk-mt8183-mfgcfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index ba504e19d420..62d876e150e1 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -29,6 +29,7 @@ static const struct mtk_gate mfg_clks[] = {
 static const struct mtk_clk_desc mfg_desc = {
 	.clks = mfg_clks,
 	.num_clks = ARRAY_SIZE(mfg_clks),
+	.need_runtime_pm = true,
 };
 
 static const struct of_device_id of_match_clk_mt8183_mfg[] = {
-- 
2.43.0.472.g3155946c3a-goog


