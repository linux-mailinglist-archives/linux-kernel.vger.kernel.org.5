Return-Path: <linux-kernel+bounces-106358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38F687ED05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFEA281520
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1A4535B3;
	Mon, 18 Mar 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTrfiD1T"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304B52F98;
	Mon, 18 Mar 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778121; cv=none; b=WhGcqiwYEaO8uD6E5/AHvczPMBGLB1WxXHYewqteRvHYJzvmqY2qfMKnReJqADLhDdF0iUvVRwVCu/qcBQn7IOv03tCuu1Dh4ktjSz/B1H7CeWZcqlOlfaUXEt+XmOZJ1VjADZQd5EwH+noE4FRxUrX8SlhglSN1PRoAIij2SdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778121; c=relaxed/simple;
	bh=FXXmbfSgyLdoYngCzGKDoruFs5aExQBWmxqiyxHJDwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idUtedsjq6m4pvX7aSWSVrcDuvy1lwqgPkPHsGx8g0ebAHNDpaOFCA12sMg3L5tQNngYmk/91rJNv7deYqZz5oIUnavuCdC+ycZHzIN4C7c68SiZLAsLLIsPRbVf3NoBkuYlsSPlwo04yA9nA7+QtTTOR1eUfIMBRlQBfq7RRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTrfiD1T; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41400a9844aso16776705e9.0;
        Mon, 18 Mar 2024 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710778118; x=1711382918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fbpQMkfZaX5INkuBjSVpwa5qc/5XkUdqga/e118bvw=;
        b=eTrfiD1TgqJBx95Fjk3X2/6ZOCO+y/HhPtknhwhatuK83KyGfILa7vyU07bZV0ngnb
         G06C3sa528vrQYjiMy6qQMVS4rAQ61ahSu4aHoPlogCWcyqCf3L4sAuW5OritAcMFv3K
         akuW8bZgHF0BA55kiEXQT0owddFWyVRCadXPzjy0/aasBDJafiCaoSLMIQEM2GE8BkLa
         2b/G7RDsGel2Bawmw65j0EGVJMOwpjnM6YhBFCuwfDX2Tk/D91qhoEu0OHPJsn8xCveF
         w7K+50u/OSDP/DkkpbhC3/ovLZeM9WHKsh0FNYuPQ956DzlkSyKgSegDLL/LgiFhCZns
         jESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778118; x=1711382918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fbpQMkfZaX5INkuBjSVpwa5qc/5XkUdqga/e118bvw=;
        b=PAVT7s0Lsga8ln7bAGgqtx0EUAf4x+iCqenS95Y3RbIAmg4SHcP0F41fRWMr/8j6rT
         JUql8PBxqKBi9ylrRy4olLrQtYty+GoQoCNADjtqlkl30KtG9cWB0a6KmW+35DscfCPZ
         FtPEnyYjCy9fgmEI62T5FjhMPuxv5H0OIJ2b5NulaG0KvQzQ2jqGGmyHqSjESHu95MX4
         kppZhK+r/Jm0Q1dz4FyO466mJa7tJX9PHRsYsG8IqoZ0wWcpq12kPGuSQbnYWR3NfoUE
         J7vtRosaxxsjMbQgedEGMHsTjqqPWZJGqAUBzX+fV07OaYytHHepo2NHw9qM6UbUjqNw
         76sA==
X-Forwarded-Encrypted: i=1; AJvYcCW3QLRXLloGl31HLojpIdR706hn1WTfAy29sqRTTxiULeY6X+NnTGxiRyntVC1857HtlCVrNSjqFuLuGZjkPJZqWJcbWncU4ZZ+eCDb4nm8v0zzwVlS54IX3z3RLOW4KZVhoVHjq3G1wTGugUJL
X-Gm-Message-State: AOJu0YxuwT4A/r+ndTj78DXLfvsyphtl8keXGtPqrfABcGra8e3EbVp8
	6oXWySIGksImXN6sDw209g1szd2a4DpUBTq1hvduO699tBfiHgpo
X-Google-Smtp-Source: AGHT+IE74yhlHY4MIRVcFaXw+E1nSdwe+31gdfYl8+RtQpT4F+Pxrmi24u9ry4Xg946BKjk9W2oKCA==
X-Received: by 2002:a5d:64a5:0:b0:33e:b787:5beb with SMTP id m5-20020a5d64a5000000b0033eb7875bebmr105697wrp.0.1710778118371;
        Mon, 18 Mar 2024 09:08:38 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:c23f:76ae:8149:291])
        by smtp.gmail.com with ESMTPSA id by19-20020a056000099300b0034174875850sm2686930wrb.70.2024.03.18.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 09:08:37 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC
Date: Mon, 18 Mar 2024 16:07:30 +0000
Message-Id: <20240318160731.33960-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the General Timer Module (a.k.a OSTM) block on Renesas RZ/V2H(P)
("R9A09G057") SoC, which is identical to the one found on the RZ/A1H and
RZ/G2L SoCs. Add the "renesas,r9a09g057-ostm" compatible string for the
RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
index 8b06a681764e..e8c642166462 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -26,6 +26,7 @@ properties:
           - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ostm # RZ/G2{L,LC}
           - renesas,r9a07g054-ostm # RZ/V2L
+          - renesas,r9a09g057-ostm # RZ/V2H(P)
       - const: renesas,ostm        # Generic
 
   reg:
@@ -58,6 +59,7 @@ if:
           - renesas,r9a07g043-ostm
           - renesas,r9a07g044-ostm
           - renesas,r9a07g054-ostm
+          - renesas,r9a09g057-ostm
 then:
   required:
     - resets
-- 
2.34.1


