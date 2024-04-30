Return-Path: <linux-kernel+bounces-163584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CDB8B6D53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106DBB21A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFD813C8E9;
	Tue, 30 Apr 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyYTli2u"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4E1422C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466995; cv=none; b=UGVbWY5lWEBDTf+CmwrSALqcFh0sVJvnvZ6LZ7Sb+0fJ+/i0o/QIi0Jm98izT2ORB2YXObLx+aaP/oR2rXdvCB32GsN3S1OEeUSTC9NH347H3jDR2QJEDIKXM5nrh5hdM4J3yY1ksKTofNByeo7I+bGeZOSMor3kLRg5aVqxjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466995; c=relaxed/simple;
	bh=7wjKpcWomeef2GpdyAHv4UimoWYBzexJGiAWn3WFacI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKuRjecIrfEAXSd0QBPNw7m3wKhxiPZgDC8mAv6hlNGYeCfWQUyHqnusaHXSrOHNkSCer6g27jeeuTq0H4xL86mP50kasVfiroE2c2CA9V7oR8MBgR/gmMxjTkc4QcQZVBpzu+8LXI6VYK4ITRWSZCDK0r92jYi6l9a5MLgedmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gyYTli2u; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso70361611fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466992; x=1715071792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ANSD/jTE3niYWWeKByNoivltWAzS/VXBEIFpOF+Ww0=;
        b=gyYTli2ul6euNdGIkxsXsApsV369xwheH8cEIQ2GLpgrYSP2ApgcyjeViV9NWHOdJz
         7/XfqzkH8d8NpG7wT+z2LcI+KOhVY0d9TJUzLaksIxY/Ol1XxdWR+wu+Hb1Yu4T5L9NI
         VexPAdDzTUIDOvfCBc917qo3iVfmKmGqeuU2l2LCe/VwqKwQ7A7+Pfd2s+IEe2H6hE57
         Y/A0UIJwPcoXs1v8rhYQOYRy9RvVIcf1/Sq8F0tqKS7vREzPpF3iKNouG1UiuWzii4kL
         6zCJDKXcRaw6hjlrkscVa67rSD5LTBdLndltsC6RPiQEYWPh6+hejhfqBoPV81mjU/pF
         lOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466992; x=1715071792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ANSD/jTE3niYWWeKByNoivltWAzS/VXBEIFpOF+Ww0=;
        b=cq0OBycyYRRhXq0mJoZxZNY681sDD62kl90HU8qWl925dULT78Kb6c2iXHRLpBNoxn
         VxMS6PKGXIm89UkqsiX/fP0isx2LPyPfF5J0WLKHWNTlk4qPKbrm8cUepoZJvFYlddk/
         6eyyj3H/s5BwZyoQE4aWWknHB0d2Sj8qLgECkFPfQASjD2uavsHTJymrBT9y59Ibbik9
         WsmHWoRzjlIEvN9hP94Bqo2KdnT9eYDBjP+EJKPchinRh66nOpvz1+QQFYwl36hKfqlU
         izwgqrsKpkQYWHNR6tX5pE3k65M0ZK3wmSqRskJsQx8Jz6N++Ds4GLet48MDjQRaIOjH
         rrrQ==
X-Gm-Message-State: AOJu0Yxs4nNUw05Ts7ArEwdJt4uIJ5ULJ6YhWXRXC32coBgLT/QSNAF1
	l+koQB803wMwgWgnhZpDwg6kR2/VpoIrw2se+x70zLi+4eaO14Yy3aO/yuhHgmU=
X-Google-Smtp-Source: AGHT+IFp6rrkNn02DXKwI2QRG8X9c9MLtl56/QYa1nN1F64idZp1YpyuAvKxElUzeYMGz1VOeKteDw==
X-Received: by 2002:a2e:92cb:0:b0:2de:74b1:6007 with SMTP id k11-20020a2e92cb000000b002de74b16007mr8316680ljh.36.1714466991891;
        Tue, 30 Apr 2024 01:49:51 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:50 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/11] dt-bindings: nvmem: Add compatible for SC8280XP
Date: Tue, 30 Apr 2024 09:49:20 +0100
Message-Id: <20240430084921.33387-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=jj6AJwAcUwEN2oFrKiINJaSkA5BYMGMlh/s/nseFbZU=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCNLo0XrhKFBHzKafk8GIzsaolYO2Qdy5zGB dUgbXsAH1GJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjQAKCRB6of1ZxzRV NzfvB/981bnLrl/Sp0m71z2mJ1A45BI9vE39BKGkane7zH/K0DdcAY3vwfVvKERbEAy9tCh0tXB jhrJfx/RLDKb8SAEl74WnjkEYBkNKcCBEyVns1DoxLTC4EyfXjRZE+XVnsC/5x6SXejmsMNsibu hra6T6HtYhXa3rD1dhjsFy8+gttOUa5cKOgyrVji4XzhJ1zbQNhoU6wFy4GbrRWhX7boidhipo4 CHWFBMlvH4YwDZ4HaF4wX35m2jGi6veTcnb+qvKNYMjOAx9Y5AGLbmPfgoxdUztPdiqGCWkC8OE +EaPCfuMmbZmKqSeEKAnIamTN5R2RbhN3yqtFxp7Vi+6bkfy
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Document the QFPROM block found on SC8280XP.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index aed90aff3593..80845c722ae4 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -34,6 +34,7 @@ properties:
           - qcom,qcs404-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom
+          - qcom,sc8280xp-qfprom
           - qcom,sdm630-qfprom
           - qcom,sdm670-qfprom
           - qcom,sdm845-qfprom
-- 
2.25.1


