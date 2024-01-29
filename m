Return-Path: <linux-kernel+bounces-42889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DA840828
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E61F210FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F50265BC7;
	Mon, 29 Jan 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlUY5qtZ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46D65BB4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538087; cv=none; b=uY95gspQRuppJpDoWkw6BzyN5egy2dz/rk0irlT43/6n2dnxHaN3xHb0BA/tt1vl0QGBBsszSFyvcWJn2MpSa8IaU2dNABLEKTJPLnJPPl1wopPvl0/746cHB3Nr03RrF7haYs5xs6mwvcpdvFFgehU4s1HDnQanXFJ9VkwcdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538087; c=relaxed/simple;
	bh=6ooVY3tCH+LuZLs3fS116FlZFUTRKgmzzxCB52sqz2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eKn/ZDLxPNmvHOHHrTBr7MSSuDs4fe7RBO2Gc5GJrJKiYPSfpNbombK/okOT7WXyVV7FHSIvwtpsyej475kXCOtOlrU2TKb6cinqnt+V4Cu8SgClvljyIEG4lv04V8+2o+IZ2nFYnwoci24ObpiMcRUrFhXok9DsyxFpssewrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IlUY5qtZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a30f7c9574eso291784966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706538084; x=1707142884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xvAQ4GfJSx9uAg2g1Cik9jmurTFuIkBcKsMco4Ol/M=;
        b=IlUY5qtZrNnt/HMEReAMXpKx2J1wkKRIpzCqi6epixM95fzv0ArgpCJb/Fho+f1IEI
         Kc+nMZJvh4ErwZeJVufUN1JenKkFC0ynkaSl7J1KdZlcMDI3PLdHDGQc/OQJahXROwpV
         tX7lcnfgzws36FAEPrX549EHHMoPriRNTyuos/CtLpsp77biLnjB/nAdo7ull8YIwlP2
         t9fNmam/OK2cgZfYRsqDAUYlaPeH0eS9BrX9BEjXvlFT1afmDL3dldCtgnziDzM+rUuP
         B1HiLhqMU3kFy0454Ejrccu5BuZOe+KzdzUIIqD+T6LXhrBQviEyzAe8LBjr1AXatUgL
         zpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538084; x=1707142884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xvAQ4GfJSx9uAg2g1Cik9jmurTFuIkBcKsMco4Ol/M=;
        b=oQ1ksNcpHJo3nRlF6EZA5MEZUk6E2l92XXhohVs3CV12WnzpBRwkO9UbVN16Dp0924
         QEBUH58+Yfahd7Bxc9qje6P1A57CyvvjT7cGMZQuont7SF6AwY/tfkO5nNi1THmLpifR
         Cod67W3HavtpeFtWlFGnUQsPTRyt1HaDIV5B4Wam2qnBvuOwwQw73A6bxr2SYY65Kxci
         sO9BmFgqpLRxO0t7G7pBWn6xe6hxEvq6WWl7p4jNRGDPR3/g0YKMQEY8jYYHeogiHker
         6qlQF55zT6v6xRr4/n8opPlFvLv9U9/Vyx54p9U3dBVedge+Q/akFBnfAd7sWhL9p00N
         F1xg==
X-Gm-Message-State: AOJu0YxMJSwCNWxzIZgTh9+Ah3XSPPtEuikvuzqHo11/MmYokAnFX/En
	Jbv142bQw5JVoSKYsnKmY2L+3bKZgJJRMyfkw0uAUU0Rx3MuRXIFiLKFABniABM=
X-Google-Smtp-Source: AGHT+IHAFInFVHJG6lhAU3fcYvwUQbSAsGy/m19hvlbJSjKaDCVxBsf8RHHwydjEm/2wZmsKlD3aLw==
X-Received: by 2002:a17:906:b48:b0:a35:cd66:3e32 with SMTP id v8-20020a1709060b4800b00a35cd663e32mr1394848ejg.35.1706538084240;
        Mon, 29 Jan 2024 06:21:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090699cc00b00a2cd74b743csm3979681ejn.3.2024.01.29.06.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:21:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: net: qcom,ipa: do not override firmware-name $ref
Date: Mon, 29 Jan 2024 15:21:21 +0100
Message-Id: <20240129142121.102450-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dtschema package defines firmware-name as string-array, so individual
bindings should not make it a string but instead just narrow the number
of expected firmware file names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index c30218684cfe..53cae71d9957 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -159,7 +159,7 @@ properties:
       when the AP (not the modem) performs early initialization.
 
   firmware-name:
-    $ref: /schemas/types.yaml#/definitions/string
+    maxItems: 1
     description:
       If present, name (or relative path) of the file within the
       firmware search path containing the firmware image used when
-- 
2.34.1


