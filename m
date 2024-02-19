Return-Path: <linux-kernel+bounces-71504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C0F85A64D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C768B1C21D43
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A362E419;
	Mon, 19 Feb 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2HRZbqx"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30311EA80
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354061; cv=none; b=h23SwCp4KKcxU7SOdt65xDreloRJUK+AVUqj+xOnT6eR+dIHhOXEYBn108OTLYCjsU66KjxOK2BE+USQQkBIJcmZ7Y2cqV+205i766iQuZGN6pWfc9e2DPr3L7lwHVpGNgrgjRWroXoC/RPI0hjHOskPJthwOSd0T1SQM2hkvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354061; c=relaxed/simple;
	bh=EHbRQ7dLHAog9MqSFM/E+Sdhe/5P8jIuOjtEE4j2X68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FVyvh2YrMZMlLkcruyddQ1DgNZ/nc4KR05KyXPywxQgKCJ3Pkg44n++pk8diRBhHijbc5g8Zhrhgz3+D2GuRsE7rcdr0+WC+l8Qmzd8+QnGAFGQBEpSO/jdVHhGkWjhNY4lm1k4wl+5VQ3BATHn3R9r5VagRFow6JsEOZRZdfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q2HRZbqx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512b3b04995so965409e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708354058; x=1708958858; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5NUo4d1gxTmiY7z7v99UlcjZS6ZKrBDK3bbgjglglyk=;
        b=Q2HRZbqxi1I8dtM5d8BAv2sw1Q1OVcXcwMMutizeRuKueAoguhm6WIkmJqHxkzDIJO
         yv4EDu/qlspXK2lG5Vn8QXPsDpib1ynTROXoKSIi/st4HSvfTL7kXXSit4ayo/2JZxWF
         I88MZbyZOgKihO2x+481kcvG+sR6jMf9tjdcE3r4rHcfgPASxOQSRqsDH/A4+nnsC77p
         mtZOeiAdXjYm/N9g2+AkiVWZnapbDxny2W3xFpIgoXeBImkEnsSgPOfBB2toZZBV/dGX
         72WWc6yq/G7SsSgcbcwOD4srmJJnNInDKRcmWs8od42zP8NmVkbLokGD/3rSBimOiWLC
         iZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354058; x=1708958858;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NUo4d1gxTmiY7z7v99UlcjZS6ZKrBDK3bbgjglglyk=;
        b=Wn82DlLuYUV7Ssr/6+QPelueJsXbnsnvLIDwmo7ucyLf9KSDsDtXRzXFNV6v6Hx5pM
         KijfN6CnohkigTCCQRjKa6ktk7l3FVTnA89VJJR0eTH4Ik+Zgu6AWYI9mfmsiHzUwoCX
         JdBT4zkFY1hq0fPasCvAo+13e62P4lMVG4DsRO45Coz089tkBX9XEpBmhj8N6HnImkRd
         pGu7LTtReHTHOQ+YuC72xnANIPn315YYSTswsYpfcqzbpVcBwKrC6BDufrPHguU6wwR4
         gvNUIpz2mhvgxRqu07s/ywQXQR8HBO7h9tZkiLpsrKEThYabx18VbAYIpev/HHo0+RlA
         6r1w==
X-Forwarded-Encrypted: i=1; AJvYcCW8om5bbl7IZvWLBCNuo9J5pfe7XGxmc3nr9RpY8JQFN7QOH0sf7byhnwpnlqz6qq7PJtJ9a1x0d0zfsZwDjyJWR7gRJ0cwITynBq3x
X-Gm-Message-State: AOJu0YxFHvGHeQYEWjMSD8TyH+6WNTDZuwmLCweG+cKIHUFdKvZXu8Fr
	KAVaZK2OuSx1EY8zOF/wEMHOwjEwLMw/nZwujvGzuU21r9osMwSR0ckWgEKbuA0=
X-Google-Smtp-Source: AGHT+IGsyulPjnmfahOMJZ1D3dlJkcZNdWHiMlP++b2WnCvL2tuMyrc7eh5KbLdlQJgmjRTt56KbhQ==
X-Received: by 2002:a05:6512:6d4:b0:511:e296:e563 with SMTP id u20-20020a05651206d400b00511e296e563mr9724280lff.2.1708354057815;
        Mon, 19 Feb 2024 06:47:37 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v29-20020a056512049d00b005128d5d670csm924254lfq.193.2024.02.19.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 06:47:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 16:47:37 +0200
Subject: [PATCH] irqchip/gic-v3: handle DOMAIN_BUS_ANY in
 gic_irq_domain_select
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-gic-fix-child-domain-v1-1-09f8fd2d9a8f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAhq02UC/x2MQQqAIBAAvxJ7bkHFwPpKdDBdbaEsFCKQ/p50H
 JiZCoUyU4Gpq5Dp5sJnaiD7DtxmUyRk3xiUUFooOWJkh4EfdBvvHv15WE5orDRarDSGMEBLr0z
 N+bfz8r4fqFrqTWYAAAA=
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Anup Patel <apatel@ventanamicro.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=EHbRQ7dLHAog9MqSFM/E+Sdhe/5P8jIuOjtEE4j2X68=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBl02oJZo2K7nEm2susxBahpdq/LMzQO89GN/01X
 IghlhaAWmWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZdNqCQAKCRCLPIo+Aiko
 1dr2B/4iG4WVuvwqRcRvLAR7OJUV4wyiF8CtzhWVKinJ6V3wT+pna+GA8Cn3+mK3WJwaVmFedql
 oJKMb9ykN0akdVxAA7eZh7UWNNdx1Lwn4EnrXWEzhGDq49r+tuJANZoSXrSaPB/rl8Nw8bg2DMm
 dvNnIRyQr5i7MhLceVChQ30DQuVfilQBIHMeXBiRnIjFw9HxuQx7yOApeFBHMV14HsXNvgZeGLw
 ym0wzk/ft10ot8T0Avdnr6wxJs/adnIjDfWI5nBhoaXEuIrsLMcD2tifsXK0LsmR15cqP3zmbmI
 31h4E5so8h3/+aNhdKZUPfqtMcL75NNBnSpKNvFeH/Wa++Yo
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Before the commit de1ff306dcf4 ("genirq/irqdomain: Remove the param
count restriction from select()") the irq_find_matching_fwspec() was
handling the DOMAIN_BUS_ANY on its own. After this commit it is a job of
the select() callback. However the callback of GICv3 (even though it got
modified to handle zero param_count) wasn't prepared to return true for
DOMAIN_BUS_ANY bus_token.

This breaks probing of any of the child IRQ domains, since
platform_irqchip_probe() uses irq_find_matching_host(par_np,
DOMAIN_BUS_ANY) to check for the presence of the parent IRQ domain.

Fixes: 151378251004 ("irqchip/gic-v3: Make gic_irq_domain_select() robust for zero parameter count")
Fixes: de1ff306dcf4 ("genirq/irqdomain: Remove the param count restriction from select()")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 6fb276504bcc..e9e9643c653f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1696,7 +1696,8 @@ static int gic_irq_domain_select(struct irq_domain *d,
 
 	/* Handle pure domain searches */
 	if (!fwspec->param_count)
-		return d->bus_token == bus_token;
+		return d->bus_token == bus_token ||
+			bus_token == DOMAIN_BUS_ANY;
 
 	/* If this is not DT, then we have a single domain */
 	if (!is_of_node(fwspec->fwnode))

---
base-commit: 35a4fdde2466b9d90af297f249436a270ef9d30e
change-id: 20240219-gic-fix-child-domain-8a1840be9ff5

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


