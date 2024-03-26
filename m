Return-Path: <linux-kernel+bounces-120046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7ED88D0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBEBB22430
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1112B13E3F8;
	Tue, 26 Mar 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhRd12f7"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548B1F61C;
	Tue, 26 Mar 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492205; cv=none; b=MDm5ZXYR5N0od2bipuCyshIhSTCnwuhxzE5jc5WCzR0/n9Y+rgCJQY/sX9OP0NL1nDoBElhVZgC9tDozU4X9qfQfrL3xAQyMiBvA/GmdStEDDdWjHivc18jQGxVKq9SR86gXo5bhtoHbNzW2y6K4Q32QYPjyDBFwnrW5PuhwbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492205; c=relaxed/simple;
	bh=qFmXNPqUc7gduLPOXircsQfDl6z4dtGtk7mEji1PhTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ejI4OEl7c8G60pjSFKeWrqxxbG07o+U48gftY1IyI35cNG/Pk5j4gG4rDVd9GS985MWW7glrvugnDAFDAQ+6FdpKusW8e5yz3C06A9yPfBtM8DbrcTMPmAazCJguTCMmUGqIpCsvOOygfoPPnZqCKhwLETeg47n+UtQua6S1JbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhRd12f7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33edbc5932bso4271463f8f.3;
        Tue, 26 Mar 2024 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492202; x=1712097002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohJJQxLFbEg3u3dqq9yefZu6nixhdieVYsl2IVgizdA=;
        b=PhRd12f7o07jaurhM2XzDtFvo1T4clDK5KCAyCvt+XFLNWv2Z9WHt+huBB/GsKKHZm
         9E2ejbScbJp/i8Q9aFgJDJ4YN1rrOfZVPc8L0pRlE7EtJr5278iIf3+tZS82xK7mkyrR
         P3GWB6YcsKKfcpyk+2oM2jlLayAjVEGv9ByItLvBtE/4MhLPk0NZi+t4Ea68ZST+VbFU
         Ja4qfhZD86dAe70dmWcfaATu++l/IynU/pDmt1PdhDduchipHvQxsvZWuIl01u5hVUtI
         NZGWH7LTTEYmzbpL3AqBrB4YkOWX8wIifEDmV8aR5kGrG0Xc5wtTqIU8e763Z5XgY0fa
         zcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492202; x=1712097002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohJJQxLFbEg3u3dqq9yefZu6nixhdieVYsl2IVgizdA=;
        b=Pwe38lKJcbm0cZnWKK7Gn1jvW+3lYhLgbA6oc8BGUyE4kX1vHhQIvLoVRVr5o4cW1i
         XAzVt1Otfr2dKEb9q+GPwfBRgFFfbFldvgclvFRIZ2ebOLJDMoynYVfoelcymY6hXtyR
         oYJE4pK+raB6cUe9EJ6CBfF3Z765VKs/CEhOSOhBzevEcXH8aaPVov0LTdXvkYRj8PHH
         9xwLFgpBVrqDpdpvnYmuyp4ulbohp64u/vgV89ftlgvYUbX/traoWuZ9yDhm8SFXyq6A
         za8rNYEhGeVUV+kssDfv7QK8HT76sIdCUm3aHwLbZENzwYkK+6eB3gjHpAc2ytnZRecK
         POJA==
X-Forwarded-Encrypted: i=1; AJvYcCWEJALpfwgIJHFjK1/Z1anwKngeNsL5DR/qZYCys2Y/aEVyOqoAi4ebcQOKHs3V0WY/ywc0e6bPaQm5ctFV7lCqP60au3gVbL/fyfx4uXvAm8I6ZBKbJ0nnpQeWfMTp/2N3PR3sxqpKyT21P693+27k8hZaLWwkZkGEGOxf2uQiLbo6ha4=
X-Gm-Message-State: AOJu0Yyq1v1zL1z0m1udmDUopASsCS0PvYRM7O0tqLaNtQJrHqAjJGcL
	LvVhkviyjaOJFZfFh4qir7WFsCsVIM25UYLmsfifmFUYC63fatOF
X-Google-Smtp-Source: AGHT+IF9r73ePlThd37uiocuW1pDDFlQ17+q38ybNH8DnK1yncu8sypWKrjVTWJiHvZD8dWdWJ5ymg==
X-Received: by 2002:a5d:6785:0:b0:341:a802:3d25 with SMTP id v5-20020a5d6785000000b00341a8023d25mr1694963wru.53.1711492201975;
        Tue, 26 Mar 2024 15:30:01 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:01 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 03/13] pinctrl: renesas: pinctrl-rzg2l: Remove extra space in function parameter
Date: Tue, 26 Mar 2024 22:28:34 +0000
Message-Id: <20240326222844.1422948-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove unnecessary space in rzg2l_pinctrl_pm_setup_pfc() function
parameter.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index eb5a8c654260..fccac6d199cd 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2502,7 +2502,7 @@ static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pctrl, b
 	}
 }
 
-static void rzg2l_pinctrl_pm_setup_pfc(struct  rzg2l_pinctrl *pctrl)
+static void rzg2l_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
 {
 	u32 nports = pctrl->data->n_port_pins / RZG2L_PINS_PER_PORT;
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
-- 
2.34.1


