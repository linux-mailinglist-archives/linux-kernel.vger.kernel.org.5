Return-Path: <linux-kernel+bounces-50660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0377C847C39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967C71F29BA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602EC126F0C;
	Fri,  2 Feb 2024 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phyAE+Ko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4588063B;
	Fri,  2 Feb 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912642; cv=none; b=MgD8d3VpVfnWbtFg4RK0c99+QX2I7mp2GyiRSXi3q5fcjh4UYgiwZMAuxQnEHBK7vMxKemTcxHQLLk3Vwk/Drz28ZWvDMBtLF/PpDU7S2vph3Nq1q5xKmPn9HW11g8rgZB1jmi6UCDvq7BL8vMcXF/s/mkkdxz8OnsoxJu1hMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912642; c=relaxed/simple;
	bh=C/CYJZBG3i/DIyUhlBjJCtToyWXY31JklYyQfK4p5Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f0UPkSfh8v02CgbG75zNIwZCelimhWIclDClzkL0QZz1FTObYlv1Ga/+M0hDEoRTvYQ2rcbUPdlLntRO7Ub6Y42gchdyRQu95junMX8o0QdUu4HoycJj3JpuljOR/D4kAvZeqyX9HzjqkhWQCde1ing1CGCKOKbmk0+fP4Z30oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phyAE+Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E239CC433C7;
	Fri,  2 Feb 2024 22:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706912642;
	bh=C/CYJZBG3i/DIyUhlBjJCtToyWXY31JklYyQfK4p5Xs=;
	h=From:To:Cc:Subject:Date:From;
	b=phyAE+Kofe/7UiVFZUcD3ltS/LmIs3A68MWwhjqrVZGbJ/BXGEBVNyL98dvGQDz4y
	 +zc1YSzsKRhRGvwA2fSVuSnUfza67EQ/bM4vjOVjdbvGvc4PMpW6IMhoOsQ2F4yxgs
	 0AypCAp87Uut8mlZgd+7ai+pIsISB90aCx9eRg+lqCZEt0x3VsfmNF+lMOlwxWUP8f
	 VW6DUlE2V/5Usqcc7G5LlO/TD8hvXssfOW+1WiZuvvTjTe8jIuc45hZylFOnxh9iC3
	 d0fmPTp2SKTCXvMjgN3SGIfnj/Y/DgYhAJAG+ppJh0IC7Rtt/U4LKxeZ9TH3Af0FhY
	 qpGlKO0Eii4lw==
From: Rob Herring <robh@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: mvebu: Fix "unevaluatedProperties" to be false
Date: Fri,  2 Feb 2024 16:23:51 -0600
Message-ID: <20240202222352.1652745-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Schemas need "unevaluatedProperties" or "additionalProperties" to be
false in order to disallow undefined properties. Only common or
otherwise incomplete schemas should allow undefined properties.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
index f1bd1e6b2e1f..33d4e4716516 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
@@ -115,7 +115,7 @@ allOf:
       required:
         - reg
 
-unevaluatedProperties: true
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.43.0


