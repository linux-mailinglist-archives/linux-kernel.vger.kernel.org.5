Return-Path: <linux-kernel+bounces-120044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A66A88D0CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9188AB219AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E6913DDAB;
	Tue, 26 Mar 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwFXfbWq"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EED1CAAE;
	Tue, 26 Mar 2024 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492202; cv=none; b=iccQygX1oHmdK3kVkVXhF9SfSGL0Mwpato2uDIux27XCH9UL3L63nKiUGjgJ2BLOClUhYiklwqz+kCCZ8tJxID0X0Tbu8GsIqpNjNJC39RPsJ9n5Pem/x14cLqCSqdNeW4nYEiolzb+jGEJ92XEIWCmD1ICUwouDfMSQT94sn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492202; c=relaxed/simple;
	bh=bugga9cZQ1roDkO5l268TivF8rxs6k+Y5Y4rN4jKL9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=orS9Uels7hUclMjh7tmrOFA/qjSmhWzrFVC2wYBREbZdlrD3omZTnpNsJH5RCphGlusD9BNK+y0jTOOLwVY28PoiRtCCMgnx/wQ2syGnh3WNnLu6XYsIHPym1rYSn5Y/NaBYaYlbuEuXOodiKB6Gl4g3PEs+peiCvIeTFHTOM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwFXfbWq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so4090090f8f.2;
        Tue, 26 Mar 2024 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492199; x=1712096999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+RRCFo/tZsR/Haja5eHVQcmQZbdp2NA025wefazOWY=;
        b=iwFXfbWqP/iyA+xTG0cKs/65NMdJxtR3I8+IVVVZEKqYTErQAYbd1hOkZdauYpViP0
         HEU2MD40/4dcs0qXCvSXNxM5DcSjduNXi1+8k2FApZFhCtF6oMkxEE5gKrve8Spcp4NW
         mGmV49Bs27kHAEszMI8hjk4/JjVJkMLKZX9usATURkjPLrKjSNEwPn6xA2zINQAtQxR/
         4AV0tnI/2hFXo2+k2AsuyeFDmRKYm83HgpUk03/Hcj6DaEOlZSQ5WI8/xD6M2W/4B8pM
         OYJHEOJfOnf4WXNTS6GZs1EyTQ7uuX30bwzXYtLqxaz+/hKjTbhydF/cUFX0l2VxKaSs
         YvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492199; x=1712096999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+RRCFo/tZsR/Haja5eHVQcmQZbdp2NA025wefazOWY=;
        b=Pc3ndrZulzAtkosU5e/7poJESRCQmCjQuHvS/C9hqT7tfwQxwLb5ChuT131olBWc8R
         Z+z7NNWHB+xGdzF9SmoL3RkxDtjxLVloaS9pvJW2Kurwf67kOq/UuUFsINMqoeAQd/9k
         4qDsud0ZtKizJChtFmQ2BqaEtgTdtMq4mN95r+03ybRK2cNfvUveRFuen/bdS8c9EiOD
         tK9uSwb6AAGdDeURjwkkqDxV+7uZPjvYYpzVVlz+ntL1qlZEulHvNiDDdnA2yPRVgVdj
         3ImZ+gxDWXdS1ng/+uHo3kTBu676c/caYJ/KSVkuYgI3Sk6A9dLO0gkBX+hnWJdej4lx
         4fKw==
X-Forwarded-Encrypted: i=1; AJvYcCUe0ZRu7oWaCS3g9zsczEA//rR2WDH71KEE773XCNU++weiJMZHIWja3Nyu1Zf17pU0jayzdQdmxjRF54YsjEggcsg1+d3lAJhXjTqZ2/sJ8y5S2JAiVSJj58kCfWKIm85N3SEb+pAcPCJX3I8ADrBkBlf/y3uJFfmRzk4FRwlp8HX6wWo=
X-Gm-Message-State: AOJu0YzzXoUAzJUG9C1/kirhXnq/s2QhbaBX2ZflwGwTCq7aRpjyTYrl
	8JmgAavfkK1oOJq1C264VKSIzImDjOwhruvYrwxud4ctAjxctBznhPRk9Xyr
X-Google-Smtp-Source: AGHT+IEPMrUBUUwtny3YepxD28JQ5sY0RhOEuq5NO31RpVzVMT8KqCp09tGGnE9tOks4vlCR1wElgQ==
X-Received: by 2002:a05:6000:e52:b0:33e:d229:35a1 with SMTP id dy18-20020a0560000e5200b0033ed22935a1mr7899822wrb.65.1711492199205;
        Tue, 26 Mar 2024 15:29:59 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:90ec:252a:cdf5:54e9])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b00341de138a2esm600647wrb.94.2024.03.26.15.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:29:58 -0700 (PDT)
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
Subject: [RFC PATCH 01/13] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Remove the check from the object
Date: Tue, 26 Mar 2024 22:28:32 +0000
Message-Id: <20240326222844.1422948-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Drop the bogus check from object as this didn't really add restriction check.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 4d5a957fa232..881e992adca3 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -79,21 +79,6 @@ additionalProperties:
         - $ref: pincfg-node.yaml#
         - $ref: pinmux-node.yaml#
 
-        - if:
-            properties:
-              compatible:
-                contains:
-                  enum:
-                    - renesas,r9a08g045-pinctrl
-          then:
-            properties:
-              drive-strength: false
-              output-impedance-ohms: false
-              slew-rate: false
-          else:
-            properties:
-              drive-strength-microamp: false
-
       description:
         Pin controller client devices use pin configuration subnodes (children
         and grandchildren) for desired pin configuration.
-- 
2.34.1


