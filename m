Return-Path: <linux-kernel+bounces-111688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADA886FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA7B1C2286F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FBD5789E;
	Fri, 22 Mar 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF8JbSRd"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A34E1C4;
	Fri, 22 Mar 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120430; cv=none; b=MU/iFWND1f7MT1dbhE0AWC9zUwQzi2lFmWs3WYTc2iGl3tGeT7VR+aVqFPYywX4js+evXgxODhQRy+syoNFiNpWO4HqSH/DQcT0KHNMBosJbA2R73beLpT0/9vPAMDG+uOkUeSA+NOpl8qIu6p2NNWJ2egbiUIEFamWuUind/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120430; c=relaxed/simple;
	bh=aEiwvFe1b6yF+StEQZ1rr1/VhFvd+gqzOrSn6S08Psw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GUOs/p5Q8dKD+SJVa/edKL65GOIQjTC+ijxuTHWtc9X17wZjKYP4CNtRs1TDTxTUQGURFx5Whr5qDcRUs2v/peGnkhkCNIkeMpEMM0OF+UfX3EKNtMZ9OzeswvODaABxSQkVViAyXvY3iQ09rfsl8bPA+BoeC8aRfvZcd3dwvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF8JbSRd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-414787c73c7so8261155e9.0;
        Fri, 22 Mar 2024 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711120427; x=1711725227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwFqtu9cCN48eR2VP1yO+BUGDJO89kd/raVOaSi/YaE=;
        b=HF8JbSRdRNXTUpKRm+8Gxk3C74RbWDpW2ZhBXu/ukJ6p/0AFRyBeO01FM5nJQuDe7J
         TftpE3pFl2XMV22KdoD4L6LOvhPbhWKi6YlxlJizqcZiBU9kM3ghnjLxJ9sAvk+IhSoa
         qqr1GzTmC5dNwjtQx8VZ2RQgVDCiYjmNbp9DxcD7XcnCbLDkrybTucm/jf8TlwisWy8I
         P6UFT9v1lppCnVLarS+Fjv37qFwDfDmKc1RwY5RBqI8vkoExB+DImT75aT+TpBirnuiw
         ZyUrNhIiHrfwkIBDYjA9PNr0kcWs+dkzzJlUdehFuJMiFBom1ClyXf4JBrJmIDI0ZbIs
         JJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120427; x=1711725227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwFqtu9cCN48eR2VP1yO+BUGDJO89kd/raVOaSi/YaE=;
        b=p2Qc/8QOJhSNtduFksby/WwUSlOqAc0PwdKy9IgYEWbuAJfniv+DcC6yUzExIXW0MX
         Zam3P5rclcMlR8+aHREMwWQ0SCkBf6VGmJugPQCgNhsgpGHJHqSmUWuBDmECQI9ZMxml
         CgT3vZIyPzo3B3ojVxaBnp2J/bM/UMnQXAxdtCrgNDhZzqajn+yjSTBgWxsz0bNSKhN2
         LOE7mdFoIId/iGjO//uULRPyKrDJXTbN3kqWSacFbbDCLyjcbtO6dKanLE6fYOc2Pmvs
         UN2A/jgES9+1ZciyksRzoAeJYv/vKpN4UZUz0mwj609p1cYdRRYpOcdC894U8si/HRou
         oevQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn6Yyqy8zWN8xEbweO1oIqhoCptrJiYboWFs2D6vw9ODhGf3TzWzFztVz1bi32dPskz1HKrt5Tq2UCv3iySMJtI3Tj/PjLwLk0l01GpBaa0I8yKO8nKf42ub4by7nqTSFlLuHh59ec3f9tY7q2
X-Gm-Message-State: AOJu0YzWPX93eihme8m3uRiup7JYLYlcmVwFvWWMjoDRIJ2XlPzc7Kd/
	FbvN+cJw8kBFkNxPXh/a93MJ3MzpfheUSZIEWBsqptEVk3MiXcIp
X-Google-Smtp-Source: AGHT+IHZNeSZB4uvwIbaQvYaMT6aOs5dhwK5eOPl9RrKRfxIl1ZJULyy64o1gTX5Dx2isLcaInjLRg==
X-Received: by 2002:a05:600c:5596:b0:414:c42:e114 with SMTP id jp22-20020a05600c559600b004140c42e114mr1824737wmb.39.1711120427360;
        Fri, 22 Mar 2024 08:13:47 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:7b89:721b:d6b0:d7e8])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b004146d736fcdsm8626677wmo.36.2024.03.22.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:13:46 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Brandt <chris.brandt@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] clocksource/drivers/renesas-ostm: Allow OSTM driver to reprobe for RZ/V2H(P) SoC
Date: Fri, 22 Mar 2024 15:12:19 +0000
Message-Id: <20240322151219.885832-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322151219.885832-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322151219.885832-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/V2H(P) (R9A09G057) SoC is equipped with the Generic Timer Module,
also known as OSTM. Similar to the RZ/G2L SoC, the OSTM on the RZ/V2H(P)
SoC requires the reset line to be deasserted before accessing any
registers.

Early call to ostm_init() happens through TIMER_OF_DECLARE() which always
fails with -EPROBE_DEFER, as resets are not available that early in the
boot process.  To address this issue on the RZ/V2H(P) SoC, enable the OSTM
driver to be reprobed through the platform driver probe mechanism.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- Updated commit description
- Dropped usage of IS_ENABLED() and used defined() instead
---
 drivers/clocksource/renesas-ostm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 8da972dc1713..39487d05a009 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -224,7 +224,7 @@ static int __init ostm_init(struct device_node *np)
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
 
-#ifdef CONFIG_ARCH_RZG2L
+#if defined(CONFIG_ARCH_RZG2L) || defined(CONFIG_ARCH_R9A09G057)
 static int __init ostm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.34.1


