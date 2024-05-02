Return-Path: <linux-kernel+bounces-167070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE358BA40B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B21C21F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BA124A08;
	Thu,  2 May 2024 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ShbcrhK7"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8FC1CD1B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692890; cv=none; b=aGkp303g/IfBwk6GHtYTw8MKbVDhLwX/fTozS6ViVLTO9lNoThm6vYeZdVEPnCNL2FppFjze1s5mGpQCe6lW08cbd6E0MjFEfIhaBgN/6ub305y6ttzx57aPoWFPfSKthyYUhDy9mhiM4Nk9ElFJtYOZFXdcIAcwYKXUZvETa08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692890; c=relaxed/simple;
	bh=+oAJcfJZ0iVz0HfgcZd1hd5sbZu4K44B4j8j7JhkyHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsUE0eP0hNxOEAtp6VUpHWSSSB107WnBjmHM+JgPnWfMVE8ZilOw5ygVrYuHx2HWHMuDBV6nICUDLKY1YaUlKCvoQcVAPD/aKtqs+fojGf3wXpxzS2AIrZ6HbkJAAJoAS3Lc1VI2bXFUaKieq1vX/Gp62pZpem25Jd9haQfHSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ShbcrhK7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so17578615ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714692889; x=1715297689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZPhCGRyt2DJnFXWEm7SVWPd/lIZ+/DjudobDa5jvRA=;
        b=ShbcrhK79YCaE+8vdxf9bQ4lT28FqavP9bDy3bkQL/POUWHvb6aUl6i2pP5hpbqkbN
         GsI6K5U21uxUJrM+fAS/6PD6nTiAvr0IvotLAz1x/70LfiGCc8S79OdY1YqI+QoGJKb1
         DfphW5zkE2bwXkNGums5OJCaEeio/IX6IRza4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692889; x=1715297689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZPhCGRyt2DJnFXWEm7SVWPd/lIZ+/DjudobDa5jvRA=;
        b=WBeCmX8gJfNwAt/6d8RybP4+sVp+JWNmfojqnSGYjb8whZCu1vf96qKSiWtsnwz6c/
         VZAaxhweLB+cv941Pgw1DWHsVah3Uu1ea3sEbE4ukwWZDs8IZoiE22MjbpdU2OZ//elr
         DGT6UGoIEhUV0cwcQiIavl6VlnY/T4xHrw9HzW1WDKSYjcmUtFmCKeOtsSxSxrcJZDnE
         +Wpq+1KUjcPpA4FOuYEzgyS87GuLc2AadrlhZ/okkDPeYF+ud9Ycub0T+bYLLbiqoxu8
         lH5VuqrHVLHyh0VmGKcHNlCdNmtWGSXxw4anjyP1McOlIFSs0U8SgjtP5vwRzqABjjdn
         ggWA==
X-Gm-Message-State: AOJu0Yw+1d95zz58OPYCDVQcGzRN81vhd31jiq0skbCOtOvhc0/Mv3gl
	pK88iKSKyasMCm/dbRo/dAwKeZ5s7gY4TrdeBbznukFL6faZfkQ5Sk5uWUBftA==
X-Google-Smtp-Source: AGHT+IFKEyZC+FYK5ZAlKbPbSEB4TliBsHleowx8lMo5aBrupO2xayGkJ0+wK22L0fS4s7UHuycCxg==
X-Received: by 2002:a17:902:b085:b0:1ec:7084:3d8d with SMTP id p5-20020a170902b08500b001ec70843d8dmr5177281plr.9.1714692888764;
        Thu, 02 May 2024 16:34:48 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id la13-20020a170902fa0d00b001ec412676adsm1903006plb.275.2024.05.02.16.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 16:34:48 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	dann frazier <dann.frazier@canonical.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Mark hisi_161010101_oem_info const
Date: Thu,  2 May 2024 16:34:46 -0700
Message-ID: <20240502233447.420888-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This isn't modified at runtime. Mark it const so it can move to
read-only data.

Cc: dann frazier <dann.frazier@canonical.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 8d4a52056684..5bb43cc1a8df 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -331,7 +331,7 @@ static u64 notrace hisi_161010101_read_cntvct_el0(void)
 	return __hisi_161010101_read_reg(cntvct_el0);
 }
 
-static struct ate_acpi_oem_info hisi_161010101_oem_info[] = {
+static const struct ate_acpi_oem_info hisi_161010101_oem_info[] = {
 	/*
 	 * Note that trailing spaces are required to properly match
 	 * the OEM table information.

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
https://chromeos.dev


