Return-Path: <linux-kernel+bounces-153046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 064638AC853
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA04B20B36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E213DBA8;
	Mon, 22 Apr 2024 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="2l4xDT7f"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7A13D897
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776629; cv=none; b=bbUyV2OkYUfGvYEREkh6+xOOK7uc3G98HXJfwvi0AxKPct32FiOl4XfIWXw12Ef6OxnbgK3iilY0J7UCPqumepBeuvVQkLNQ0eSZTibkIq+IEUQPb19TCKQSncgQkJ+mEvfbbcWff2e5XJhmkLP6zT0/ixEZsHMyj+NkbBsMwog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776629; c=relaxed/simple;
	bh=qbN6RcoxSrzSImtVV1YcO1nagAcU3+AYt9dUtLCWxOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lH5s3/KoQwCpuCjp/7KGo2IhHekrRZQbEwZq+jf+W5gsnhXfS7mz4GFjB0PUdvf5e9Pb4edyva/sJ/kAZy+yezvFCflJ6dgdqOrAuc7A+Hn2MZzOrw6J+3cd10dRUlrNw9lOQ5KDCajvom+wo1SWrLCfKOR7/9taQpK/R5kx5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=2l4xDT7f; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-233e41de0caso2124221fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713776620; x=1714381420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUQGG/clLJZnAtvPMOoTwY8ItLAOtc+n6AjmJmzIfBY=;
        b=2l4xDT7fOtOyNdGqzcEVICUkg8UFCzc1B4LR0mtRadhjSIsbBEQHPtQjlBFAoXnXY3
         wSwJDvjiKNo4pCtfY7Af3360TY1/a4ZVCjOExozRqXsCcwi4a7EIyU2blZ9AuRd2+/B5
         YfHpBdjkOwTGJDWY/91GIXkP+UPIV2VFBVfGESAN5EKzAacanBstjhGm4LJh4+gdhPaU
         kZ/znRAdSS6cC7tkTBobdtawi5tsmLj1N7qWjZQQoAqbUAR97VsMZ7czV8+pj0VY2QZx
         WkjVhzbxRZYu03QvvIp32MZ7wwpzMA/Q8V+u0gnwgy3XatFOqkyIrZHyubqcQB26hI4M
         bAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776620; x=1714381420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUQGG/clLJZnAtvPMOoTwY8ItLAOtc+n6AjmJmzIfBY=;
        b=HYurdjicbTBa/dEhDFodhtYKJzliQYl/gKfVhYlOcOWfUUzUDb5FXQ5Q0jgkVcJV0Z
         5aAqFOoi/MvMN34xf+9uICEX/dCzhK6+R466d0GBereAEoyO536nq7CqUMK6y7+b74kz
         1Uu1x2VQyGHOH0mHB3F9+9t5B5oojDfx8KAFLsWDASWAfuiutzFF0y90dN0bNSm5pIK1
         q/aVQpgXfluOrIg6Spr16Ejx0n6U+lVtAcZxccN+k8qUnYGicbP6YKQ8eQS0TrctummR
         ckHJV8L6t6E6LUMi1Bez+89UFIOxehV5/YUw1qn+P9e7k1c9S/ndnkQCVmpYYWkphMI8
         PYiA==
X-Forwarded-Encrypted: i=1; AJvYcCX46Yj8k+ILi1HAvZUtfYQ9x1hBsDM36BBjpAsQyV13Nn2eQyGgb7Db0vgVc/A6OmMcHbvU7umgDlviJa5F+ASLLMc7rgR4tNlkHtO+
X-Gm-Message-State: AOJu0YzU/4DFqt8SaWzrJ8ZqmhcGSR8hjZf45KC90WVpiBh4Zsq1yCp0
	B7OlfgH/KrM+PdPtjnY8Gj/X+7KQpXpPEigacUXG9d3zFKsIiv9UM1MyZDvAtTk=
X-Google-Smtp-Source: AGHT+IEVycp3aE84ZI9v6SvOp72fnGMHJ9wpmeuHO8eo0YEEN+3cTZF/H30yn+rU0sWSJY6bMwHS0g==
X-Received: by 2002:a05:6871:50d:b0:233:f233:c3ee with SMTP id s13-20020a056871050d00b00233f233c3eemr11509815oal.50.1713776620440;
        Mon, 22 Apr 2024 02:03:40 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id by42-20020a056a0205aa00b005fdd11c0874sm1919137pgb.64.2024.04.22.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:03:40 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v2 4/7] dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
Date: Mon, 22 Apr 2024 17:03:07 +0800
Message-Id: <20240422090310.3311429-5-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in nicely
with the existing himax-hx83102 driver. Hence, we add a new compatible
with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/himax,hx83102.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index 2e0cd6998ba8..86c349bbbb7b 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -15,6 +15,8 @@ allOf:
 properties:
   compatible:
     enum:
+        # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
+      - boe,nv110wum-l60
         # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
       - starry,himax83102-j02
 
-- 
2.25.1


