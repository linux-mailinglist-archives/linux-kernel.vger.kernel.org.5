Return-Path: <linux-kernel+bounces-31031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEF08327D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C649A1F246FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B144CB24;
	Fri, 19 Jan 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8PDrjNL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5584C3D0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661134; cv=none; b=hQnTIxbt4yefFHROGXbnYBZWF8f719dTy9v/g3D2s6iJe1KKkSLbh3pbJvpQwYxKnvBoC9ADxCVohCDZ61+a1xNw/Lb1VSHnuDsTF8jllpilqGytmaI+oo5c+XXXdzmPmv6o376d4rLYRpRKjD5poEQ0yGwz7/VNZprK5HnSRps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661134; c=relaxed/simple;
	bh=37jpLv6HsDjfq58UT+g6uG00C2Y7+aRvCtuRbHaslLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xni/gs+BM/4DaVO/cFwdG5BkKJGsfqFeIhOMDed7wljbfXUtvuWkFKo/41EjjTtu5tRZ/gnOINrcWWB4JaicEM5rbOFHI0lWrMpbURdnD2pREbub4vXRLXpMuLLWpKif9J/dNm2/+gEPouKwNu4nxFIgI/FHookXfiolRfggpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M8PDrjNL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e60e135a7so5639815e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661131; x=1706265931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H74QYBuoWbNPw1IrHpaPtV5Fr/Jo8QfnPV+pn460u7Q=;
        b=M8PDrjNLebLy9eSHsN/cvhQ311/guZHaF8bjFlOIRwXxQKwsyXEMETqssTV61V/RS0
         qm7SwmDz8dzpqMG0mIm8vnlJNo1GYSlkePKjkvxIDCrvcDvsfmT8u38AKclWqPuIVr8n
         5kH1R4gZl+YhxNTH2zqIlWXy46HhW3+GDcmkGKB1+2W3WAKLfrDJn/JndgWoY3AMVmzm
         HdDdpYgrciw22SFl5612fNrP+dqIi/MSg+GOZEdTNQYJt/VUxviYyF3UeeMHsHJrVnLL
         kOQDSMtqc8Sx2SIkUPXcTxt8xf6hvI+0qdtqXhOqOoz1+sLsRqM9pZidz8vTMYDIdytt
         nXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661131; x=1706265931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H74QYBuoWbNPw1IrHpaPtV5Fr/Jo8QfnPV+pn460u7Q=;
        b=ma4gkNONQgr7B7gnhu4pfpBda9nw6GVU/cL0LWU8gM4NT2KRZYsz3YExHsXXTbsNWa
         nLCIQrWbyvs9YdOVejHzBtqwA2nAtH98JSdv2ATUi5xg5LF0pLMHePAoChMtX3ghMKD9
         4M9QOzh6/QVFbp/7ha3Ma0NMlt7z5FcJKd4E780aYCEBFm/GBlvYvbhZqL1+R6+p2i1j
         Di2nDbVzeRFgRWtXJnDWp5NrOLk3mabi0crlT/1zdRURdlX6WwWXZqWNRm2uFwB9JiNQ
         Elx07ASJEGXlv3iKhsAJFjsEEQUYJrEq+48jiQKNo4CCHwD4PeYlqO4t3Q1KDSPUH+/d
         z/cg==
X-Gm-Message-State: AOJu0YxyKO/NFEIMlMzN2PtQ68jmvM4bU5xf5BInSr+25IOTjpK07JsO
	WcL1O96c7J0rY3ZNx2f5ea93l9tl7DIZlugXkaJ9Rq2aktka9ZiDwqPKM9Ed7AU=
X-Google-Smtp-Source: AGHT+IGe2DxncF/tdHEyEyQetNG3qty4lJaRlXD9UVpv8DePV8y20R67SD2hJpbDmH4wko4vUgqtqQ==
X-Received: by 2002:a05:600c:2152:b0:40e:6587:edc8 with SMTP id v18-20020a05600c215200b0040e6587edc8mr1512939wml.91.1705661130766;
        Fri, 19 Jan 2024 02:45:30 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:30 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/19] dt-bindings: serial: samsung: do not allow reg-io-width for gs101
Date: Fri, 19 Jan 2024 10:45:09 +0000
Message-ID: <20240119104526.1221243-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All gs101 serial ports are restricted to 32-bit register accesses.
This requirement will be inferred from the compatible. Do not allow
the reg-io-width property for the google,gs101-uart compatible.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 133259ed3a34..0f0131026911 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -143,6 +143,8 @@ allOf:
     then:
       required:
         - samsung,uart-fifosize
+      properties:
+        reg-io-width: false
 
 unevaluatedProperties: false
 
-- 
2.43.0.429.g432eaa2c6b-goog


