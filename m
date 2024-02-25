Return-Path: <linux-kernel+bounces-80123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F22AD862AF0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D27F1F218D1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB05A14A89;
	Sun, 25 Feb 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="frkgL0UM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96035134A9
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874037; cv=none; b=XNCmscd8g+bfIqIfIT32YegLzljYpSAV3aZBQyB319vtep6NWAUvyBpPhVEmRA6BgjTROx0wCemSanUKh/6AGP+5haPaZmVjfDSgVnFS2nyfLOBcNt92TKf1Dh0Y+rv5HqaXgeQe17fXp3G8Gjc5ostvQqd3d024RgVCqD7dPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874037; c=relaxed/simple;
	bh=j5/RCL5+ipaxtCp9MIGqeZWzlRgha0BMJPZ+AfVcsjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGBKY3P79VReoY7M+SdutoEqGEh4LYImLswNH2qqJe4WTb30/D5bvlQ4HOVRAGhDl3D2QfWFHxryJXghfyAJzu6dFAtk/cqHuSZmR/+aD9DDdxoR4Tu4j5tbF1mNtrr+F8+7Q6/eU22dkH6pFk6jHIqXgtrCjapBnHJT3afrYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=frkgL0UM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso2791385a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708874034; x=1709478834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmS4gDNEWmUck8GHVINRNCbZHkdEW63y1bKjUv7oLPQ=;
        b=frkgL0UM863QGwKjkmreLoXPAYHJYNFi8LQTmhmyRF7sVC1xT+EyK32NTnoz7a01Dv
         G6ZC/oZAqU3Tbb6Ax0N/8qdrfIpEzb7Avn59yzAWF+fIhSG+bTJkCj/v+tG8Ya+fokVO
         3Qgnjs3JV+0MpuKELfhx8elOno6AlK/p+UaYrmpR+Ge4r+RLRu24ppZ6es3bAXX1HZgE
         cN8OWNZ2Ps8oMEZX492SZVPafsFxPd3OvId+WH2KAVl9DTVjB0lylD+/dphWVmQee3Or
         20PBM6dTvHY3omcOfdNgDmyr7EXYj11l/mRZOvNF3C0dVmJJIe6BmALce/2TxMU1/vO8
         6Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708874034; x=1709478834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmS4gDNEWmUck8GHVINRNCbZHkdEW63y1bKjUv7oLPQ=;
        b=cfVHvXg7zpuvdJtAAg/EMW0UEayREy7MdHbTzHKWuAspuYL95dx9fFqp1SWLicdlqI
         XTDzZs9fts7OBLP5lL0qxbyorcMMDZvKnRi/GWztvs6tEcstWefz1VkoEiKkPtmxaTxK
         Yxj47iPo9Zm6ZboUshiismlqF0B2Tc1K6KEtjUCuhO/qmqmKf/WHk5Xd+3lpOQSHnPG/
         K1+CsK+bnlLjZai84+TzvQzO1L4OAy74+oeByoLSpSNIMZrmeqyqRucfvxG5lefEXswj
         9ysMq8jFBfObm/rXD9jfWb0E8PRPhDWfjBr8c2u1pF/cHmL1Vm1EQ3pzVw9A7H742EWc
         Kdwg==
X-Forwarded-Encrypted: i=1; AJvYcCU+OGZs9Lw4vW4mGWAgo7JuY3nPDBX+qRqps5AtdI0j5QuBitlKtanVwlloO5rYkejwe+Rk5ltxvV3R5EpZ4liebIxgP5pjUC3Tp1K6
X-Gm-Message-State: AOJu0YxOby/R3jSCMnBjML7D0Kl/YW+AePne6qjFqmsi0p2lsSqGZnJu
	0OPEzS/s71MnjjObvZrL41jjXta1BLf5UGiV/I4wP+Y8SX7rlarB
X-Google-Smtp-Source: AGHT+IEkhbI4nG+Vw4+mL6QrL0isP40UUWu3tf2QCFS7NrKvQ48vP8UHbsY+NMoO6aJCF078nPvsqw==
X-Received: by 2002:aa7:c34b:0:b0:565:d125:221d with SMTP id j11-20020aa7c34b000000b00565d125221dmr1109817edr.32.1708874033937;
        Sun, 25 Feb 2024 07:13:53 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-94e3-d600-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:94e3:d600::e63])
        by smtp.googlemail.com with ESMTPSA id f5-20020a50d545000000b005651ae4ac91sm1588450edj.41.2024.02.25.07.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:13:53 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patrice.chotard@foss.st.com,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/3] clocksource/drivers/arm_global_timer: Make gt_target_rate unsigned long
Date: Sun, 25 Feb 2024 16:13:34 +0100
Message-ID: <20240225151336.2728533-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225151336.2728533-1-martin.blumenstingl@googlemail.com>
References: <20240225151336.2728533-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the data type of gt_target_rate to unsigned long as this is what
we get back from clk_get_rate().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clocksource/arm_global_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 8dd1e46b7176..fb3ffd54c822 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -52,7 +52,8 @@
  */
 static void __iomem *gt_base;
 static struct notifier_block gt_clk_rate_change_nb;
-static u32 gt_psv_new, gt_psv_bck, gt_target_rate;
+static u32 gt_psv_new, gt_psv_bck;
+static unsigned long gt_target_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
 
-- 
2.44.0


