Return-Path: <linux-kernel+bounces-81367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AFE8674E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103DC1C247FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B0F605C6;
	Mon, 26 Feb 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXT/K73t"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2C433C2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950542; cv=none; b=Es00i0594DV4rrG0nHbabYLRXvx4Wz/lPaSxzSBTQJi4SQ92GMEJm5FWdXhGVqMlpS382V0FK2Aq8HFK2c1GEyhg3ESUil9n0N8Mp+1fdcmDw54uAzd1I3jiPFxy3Cxv9w6EDe3iR/86PILZ+hkT9ov49K8YDDi97chyLBCwHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950542; c=relaxed/simple;
	bh=60//XUMfZ76Nh6bqEO3zLMyyLkjiyM71acrIwzF5ypI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JyzGdEa3w3ll6d2rMUH4cd++b+y5jnCFwfcLZrywCD+VQ7Twl++ogTRuAI6AFRZa2ERSI24YE+OmY6Nkxd+WIVnOm5uXfwnyFdfzsrq87/0oasyZSbc5D1pvAJll/WuZ9EVeLhHraM9KP5QH30hibsTyFsT2iQrV+EF0SgPX1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jXT/K73t; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso3726177a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708950538; x=1709555338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zh+/RCKjqlmGphkaMQmnBQf7xeNe6+FLKo+we5BQZGw=;
        b=jXT/K73t+U6tStth3htUwg43/+e9AErItutRcMPzaHXFUblmPnfhwTDUEPUqzilkKq
         G1pAHZDGURAeIF3ggMERJ8meE6PCd9Fpq2DYmOdr+yRYCee3+DyZH/DGpjGRcC8ILOO9
         YgjdUNzJvNWN/mc7GPM4+if/OsIZjDehkwzQaIe0LLSCAB+CUHo0hwqi0NxsT1cOExF1
         +Vy0CApXL7MZUWRwtMLL6drk5isuPgM2a72yuc7zvN2lQlDiMEGrunceima5Ri3X7JIf
         LVCgZenY39x6RQlcT/rNIcsWI8eGHvYdMbqRET+i4DMXF5P9fIS+rDJuS5cJZSsJPJ5E
         KNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950538; x=1709555338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zh+/RCKjqlmGphkaMQmnBQf7xeNe6+FLKo+we5BQZGw=;
        b=kSZT6qKz/Dg1r0ER3OONx0cApczwmQEyyVs/IfodRI/wtTIgXAAshzaE6eQ/k5BjXi
         lvOd3aitgm4JfTqhxqStFgqsj4FiT2AIPXynSQ8Ix5lkUFp1F8/E7Bdz2AqCCJQTvr+B
         LHv3yPOsLfFs/ZMjIixBdQDGlRe/QCGUEU6/Hmyz8Wh0Ae5pmszKb7Ga1zTovVllwCux
         eZaPz9yCGetUKvOTxMtYtTN5vLxOTe0vzXSiuwq8JvdhpTQVBprkAb2XkC7c2GjCSVL0
         8EtAWwgabJUL93Ck07PQ54h90ec662n/hAt0/XrLwjis6BFgTSKeIuf9sQfqNUDubdGU
         j6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVmDM2alFn9PWJwVVtmnQNqSq9h/jgPi//WGUVaETS3Xk3wZu5m3/porX0qVuwZ4dM84Ckobl/iFggaSgNPWNM9XYaXiFaeCVHikReM
X-Gm-Message-State: AOJu0YyvzpY/5PDMzH4EjvowX7UUoCJlUROO0dHQ4Pr0ab0wYwCvDbvz
	181ScXSrZU5atLPjkUL4zFc6UsIdEM8oprZRAXAswaDVBqFXRKH3Ep+hg+5ljH4=
X-Google-Smtp-Source: AGHT+IGJflBwnkc8vd71Co6kRAm4WJGoXl/qpscO8NUz7R0TYuOlHyOJufveR7aHg5Jcx6N5/IA9IQ==
X-Received: by 2002:a17:906:46d3:b0:a43:8916:15f0 with SMTP id k19-20020a17090646d300b00a43891615f0mr275324ejs.64.1708950538058;
        Mon, 26 Feb 2024 04:28:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090699d000b00a4330ad159dsm1340882ejn.179.2024.02.26.04.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:28:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: remoteproc: qcom,glink-rpm-edge: drop redundant type from label
Date: Mon, 26 Feb 2024 13:28:54 +0100
Message-Id: <20240226122854.86197-1-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml      | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
index 884158bccd50..3766d4513b37 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
@@ -18,7 +18,6 @@ properties:
     const: qcom,glink-rpm
 
   label:
-    $ref: /schemas/types.yaml#/definitions/string
     description:
       Name of the edge, used for debugging and identification purposes. The
       node name will be used if this is not present.
-- 
2.34.1


