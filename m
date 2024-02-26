Return-Path: <linux-kernel+bounces-81372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D0867504
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56F3B20394
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEBA605C7;
	Mon, 26 Feb 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jy5de7Cg"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499482134A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950610; cv=none; b=eByr6h+8Nb7KdmoyoLV6MGIwVY7DMuf+5UdENkcHFIK5J6mA+QY1zNZ+kArFVS+fFOCbN4x88yUbrfVCjnrps8k+vXh8bN+pcw0fc6WH0ct7KAS76dsyP5I68JeZ44fn/1qKujVOJLpn/K0El723xAPf1vWcMVRZ9srtC2TrLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950610; c=relaxed/simple;
	bh=Fm0clYVbu6hATD7ktts/psh5VC7LgiUZrv1c7nxuh8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dmo0dIwoWeF39j9Q4o9rCRiR0/TBefV/0vVHaKQOQ/+/cWOaaUjaoDbeJ7NGT1Df2c69jeIeUWwhq244eRlVE8z+wOCgoq6cMkZXEr1I9SCPuor5xo+ISlGDZCr9wXvXtrxHcAChBdnXV45t647dJ0hyIP4MjuBDlGldJijfOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jy5de7Cg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so3873983a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708950608; x=1709555408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wt7/2Uaa0FnEMeuY5Q17SqUB4gQ48xOd96E2rO+drXs=;
        b=Jy5de7CgyoGYlNr/r1VckpETDTSePRTAx74ouBeNn5kroB2TkV+o5/kNpjf1szlZtC
         clTu7rIFbHzknlsdVPtlhodsf56qw0Zmpen6lIudnQzeeEjdSyI4tIz8/UmTcOo7VyFb
         qgjT1LfXv5GSTHQy2xprGNZmJCDYdOOt7472He64tStHwPluCdOqhn4nrEUAZ+38xgPd
         y2yK/YDHmEk4rOwWIn09tT62jm/H0B+X7FRze1/1k8zpjsYY3wKxcqisdn8sqmzYI8NV
         XGQICDXaCqeqGqX4yXeQ/WhMecPGOkO7kUMe12yjfD1kaZyjciWdX1iMFJ7wOGYpRsJr
         Cl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950608; x=1709555408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wt7/2Uaa0FnEMeuY5Q17SqUB4gQ48xOd96E2rO+drXs=;
        b=OA9yDOi8sAGVQpw0qMRpwYUr1xZUTVDmhoSHInVTQHJ4KzfQwRUQzk+Z1GuOX0synp
         kNKxCU0uuqLTTOBAf2Us911EC9eSr3CtKw0pAsFArjEI0rK6LzuIdZAENAYoGfaya4x1
         UtRx3UuUdlGSORk1vuSybcQ8BEvKzugE9yPZkP0FnZkvoca88XeMno0w/o8hCXtQCwUb
         tZMrURNiYC+205gmCH6uL1K/CN4Ka0GZ5TKuPhKEbU7EU2B0q1M11SklKyioqcRPKa3n
         /uBJch8+hzD/hIUOLiLEpaYa7NYwn1R/9XkWJ9yLN0QXSJGS0OrB3O1pgPsSK4Q6OUu8
         LLOA==
X-Forwarded-Encrypted: i=1; AJvYcCX3twEbIV60J5k+Ci0nHoSvYgmerMTYgpBlbK3xHN0jAeD5073KqvdoLrs1Pc6dL+G0o/jfvfkKTTRofjnTImNsdD/bNYX7FYGp0Ws5
X-Gm-Message-State: AOJu0YySuZtMfTl23Ulhx+GXAgPXtecLUJcD+RBarA+GDbk21F5DnKGs
	PfkXOv16EmssicSoZ+FySwaT148V8TjTFMLXLh6ghiw7yohDo9cERQJODu4jyXTBdB0Tm3Hezdv
	A
X-Google-Smtp-Source: AGHT+IHufhSjvKYboP4wKOqIELJB1hIkhyZjjsJ3/BEPDVaM2knYJ2Nr4lDKOKoceGuTC9pNeuV9lw==
X-Received: by 2002:a05:6402:14d4:b0:565:dce3:670c with SMTP id f20-20020a05640214d400b00565dce3670cmr1974804edx.41.1708950607820;
        Mon, 26 Feb 2024 04:30:07 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b00563f8233ba8sm2289585edq.7.2024.02.26.04.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:30:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: adc: drop redundant type from label
Date: Mon, 26 Feb 2024 13:30:04 +0100
Message-Id: <20240226123004.91061-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dtschema defines label as string, so $ref in other bindings is
redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml            | 1 -
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 261601729745..36775f8f71df 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -22,7 +22,6 @@ properties:
     maxItems: 1
 
   label:
-    $ref: /schemas/types.yaml#/definitions/string
     description: Unique name to identify which channel this is.
 
   bipolar:
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index 40fa0710f1f0..c28db0d635a0 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -75,7 +75,6 @@ patternProperties:
           in the PMIC-specific files in include/dt-bindings/iio/.
 
       label:
-        $ref: /schemas/types.yaml#/definitions/string
         description: |
             ADC input of the platform as seen in the schematics.
             For thermistor inputs connected to generic AMUX or GPIO inputs
-- 
2.34.1


