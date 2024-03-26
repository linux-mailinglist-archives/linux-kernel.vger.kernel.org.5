Return-Path: <linux-kernel+bounces-120049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D3B88D0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364B7B2337F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41BF13E6DC;
	Tue, 26 Mar 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REaK8O9h"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527713E413;
	Tue, 26 Mar 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492209; cv=none; b=C7aUEdjFkptahRy5cEr65yeR8gL+PA05IwZnIJbMDbwUVRKHk0g5LCMX6C5L98QzWy1bJaUXreQZQ9Wxrc6LkvMCimIoHfsERu02B2rp/SMMWnvpP1aeUZDr2rexw0IV52ex3888kvINc79idhlV+mjIQldX7KfmakDYmGB9ko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492209; c=relaxed/simple;
	bh=G1FREJmgcUsk+GMF47Ku1uU6ZZU4d26S4OPEd6UM5F0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWELowAW5e0ekiw5z62BVQXVfUjc/cYArUT0d/cfUySSPvWrvBGCYvb4MH924+7kxgJkD4kGz9MM/UO/om3vuuJukGtRwui+eoUBFlYOQIHlu/ySa+UvDYa2SSwbhpqVgJYa1tnQYRq4K0BbwisOvW2rmx6T43J+RwqjJn1WlkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REaK8O9h; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ececeb19eso4017949f8f.3;
        Tue, 26 Mar 2024 15:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492206; x=1712097006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMiTWsMKQUkHwbX3xcVwucmg3pH3xhNFm3FsyybLIuw=;
        b=REaK8O9h2kScKTsGi4t2kFSovZC18h6JhfIkcoDa9WW/Tnp8GWLQx0vfZKxLZxAGkV
         6AP1jMzzn8GrdyyL/klNy3pT1EqXwBWSuwfSrVUROpb/mh1zlWFucEe5/3p3zAEU7cXn
         APx+CS7Av1ZteE66rKDzQWZVJviTDQKpU3lDE4HZduzRwNPLyEsKLzypqEIR16eAz6DR
         xVKq89qTKZAd46RkiC/Gt1W4VhGn3uGIx4D2wXneqV+z9rFlWrpTlw4P3HOVZa7InJXu
         /b8EYHYaF/sIYv9HdTdITZN+8vQMTMV6YzjKzovHfg07/JbsDbYC1qiEbv8YFjBI62Ln
         udUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492206; x=1712097006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMiTWsMKQUkHwbX3xcVwucmg3pH3xhNFm3FsyybLIuw=;
        b=JqppT4TC1GM79D2mA0MSNZFlWN7l5AsfsdYB0FlhjT3IUfe15v/D5rBxZIR1S9vgRa
         DCwvrnbs7DpdmFcFYyqV8z3nRBHBh/RufFxBRBqtqKLuosttEBJhFaxM2gIzknkWc6iA
         diyHYaAylObGwH2RFeVQVzr9IhlakGbv+Vs3w8SGU/2QlOWvolKaLfrmiFqgW/Nk4UHR
         xXMM37Af4g4GLqeenR2nOrUl2B6u3K+k9z0z8kiXC32mPFkTUAePJOXwkLXibxzB7UgP
         C4wnKIZX6giU0uNqBEbjyDd6azzOIKBuxApmhOI5eE1g5hbsh0x6gKDNc6ivbYGKWmMp
         BXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLSDdS94KQM5ledEBzj4c/hv5BwlYjqfeDEXd+PTvrmFjeX3GNanN2R9ocgzOjSB9g/e2XTLJizSGDxTBNvxZ2g1NiF1oNdrWyYpn94wEXTqoQpJaHmoUdxKRE2IIb/x90RwiHRwO7ZzxrqygiI16mosbAT3LhYB56sxt1neVqrAvlBKs=
X-Gm-Message-State: AOJu0YwOH3NyDEwuXvAuHJ7m3gaIZuTmWHhaZOoE3pUrsK2lle+scFW3
	UJYLUj1i/J3ELHJe+SnmPnDiTZdB593bA4/SysSK2/5Z+iocIylt
X-Google-Smtp-Source: AGHT+IHzlQZgHd7VQJLmUYWux8BGBJV6oO+i8et7nP8IzjyiR13CAPhi+rC4IHjytmfAYw5J37WmRA==
X-Received: by 2002:a5d:410f:0:b0:341:db72:14f0 with SMTP id l15-20020a5d410f000000b00341db7214f0mr584290wrp.19.1711492205825;
        Tue, 26 Mar 2024 15:30:05 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:30:05 -0700 (PDT)
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
Subject: [RFC PATCH 06/13] pinctrl: renesas: pinctrl-rzg2l: Make cfg to u64 in struct rzg2l_variable_pin_cfg
Date: Tue, 26 Mar 2024 22:28:37 +0000
Message-Id: <20240326222844.1422948-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Now that we have updated the macro PIN_CFG_MASK to allow for the maximum
configuration bits, update the size of 'cfg' to 'u64' in the
'struct rzg2l_variable_pin_cfg'.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index da3a54b7b06a..348fdccaff72 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -241,7 +241,7 @@ struct rzg2l_dedicated_configs {
  * @pin: port pin
  */
 struct rzg2l_variable_pin_cfg {
-	u32 cfg:20;
+	u64 cfg:46;
 	u32 port:5;
 	u32 pin:3;
 };
-- 
2.34.1


