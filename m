Return-Path: <linux-kernel+bounces-80280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DEB862CDA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5448228330B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388921B95D;
	Sun, 25 Feb 2024 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpAw5+cT"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281419BA5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892926; cv=none; b=cZ3KJ8sn29Zmq12LmFFUyyXzyXhcYotRFp6rrZdROZ/CYeJczT30AQ6Q8SEvNKn1i1a/+DHrf0/X9N3Fn1dL5Xu+KwQTZ/DgWegrougCtKy2zO93XzzWlnP/aPe91n+tjys/hJtxUZYPQ+lwdaK85gqHLdWSv96NO3jSvfmIqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892926; c=relaxed/simple;
	bh=bz7La++wemDtpv2Tj4GKgbBdph0RhPEew+v3vWe9MLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cyTijYX41PbNn8NVaTsk6fM0GDq5OErBswg5Cs4y/wsaPp+E/PczlrYMkPPskLhB4OQGAPfSxdApnU4UjK+ZWgomkEmycJ9lQANhMLggzbWw2V0l50wLpBRXTM7IeHq7FO6gSnQvd5dflRdl0gBnWK5fYvpFp063zWD0E0iNaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VpAw5+cT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3f5808b0dfso330705766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708892923; x=1709497723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQhObH8iYYJ3IoKtoS8QTP3j/Cwz0hevmJwDdAJZbC4=;
        b=VpAw5+cT6zgNRbIxZL+/jHBPm/KZ5do9ByQuKy4u0AusFzhqE+N9tjfA6AJznwX1Qe
         DS1tKlDJJtakxQOEj/zVp9OZTEihJtyguZ6lJ6RS/dNG0GhCdVulzBGomGfjgrVXP0AR
         AODYT/yM+w+V9A2ZetFT0l0EOUDdaQoK+H291B4H4DlkgO1w46z4rlC8TkFirFcB3EVe
         eZsZDfrv19q5sbNChXer3lXakMWLLD2EIOwirDHPOUP53Xl37v2fEQzSZgx6ghnDDkAT
         AlwigDFoaIAemXLd1BA1zeCu7LqQsAu/JzyujCPjdAa18spQIhDmE2BWWStPTN5eK4Eq
         Hx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708892923; x=1709497723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQhObH8iYYJ3IoKtoS8QTP3j/Cwz0hevmJwDdAJZbC4=;
        b=Huy3hqKMzZYQ/K/VqDz1k3YYpvxlXyEIZdOCIzToUY4RPwpxwG8uNkTjmvlt/8VuUY
         EL07q5R65/9cErnOhiwlkQwLbt59kk4loYHjS8EFLw8SvZOZUZdmqcmUD8pDALB2cmFn
         YdX3AAxu962tZW4Pt+00voRG13hWv8OjMPluU38bohVCQgUhqHQE3zep8N07VZ/4VQym
         vagzgSJpLVdENeJAo6oVU4DsOjOBxc4B3jxE8csfcXVoU+4Vmo6G9NeDe7ptvb3UcfA+
         Hzt1OjMwQWGampGCYMIAA3yY2pf8+khck0UXMDueXb5NlHZZkQ0Qjm8XkO0zXCb7rpAI
         8qMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUreN9yxs9haESRSopf1geZAGHocJfLfYDMeiDmQuJL4LCqhL4tPGgPmkMfRBaTwVZOxvAZ99cMkeMuip5J3Qvm73auK/uMt/Eq0mq9
X-Gm-Message-State: AOJu0Yznwj9k5K4EjGs3gBndQyWFtQ9o64xdVgQkWfE9EKAYUH8BRiM7
	CXCj1wk3SXrqrSfgpQqfnPbUAL934+XssjvL3JvJQjysL7Vksc6g7AIKCSKqI0tTgh9JW1AX7g+
	u
X-Google-Smtp-Source: AGHT+IGLKkvTXcaFKTKXQbmn8mt8Fo7Km1jdI5Q0LFi73p9Ni25HthQDDXz3lHv/AM99kDe7iqmryg==
X-Received: by 2002:a17:906:34cd:b0:a3f:870:535c with SMTP id h13-20020a17090634cd00b00a3f0870535cmr3158316ejb.44.1708892923547;
        Sun, 25 Feb 2024 12:28:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id wb5-20020a170907d50500b00a3e48782f08sm1762249ejc.27.2024.02.25.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 12:28:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] hwmon: sis5595: drop unused DIV_TO_REG function
Date: Sun, 25 Feb 2024 21:28:41 +0100
Message-Id: <20240225202841.60740-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'DIV_TO_REG' function is not used:

  sis5595.c:159:18: error: unused function 'DIV_TO_REG' [-Werror,-Wunused-function]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/sis5595.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 641be1f7f9cd..e73b1522f3ce 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -153,13 +153,9 @@ static inline s8 TEMP_TO_REG(long val)
 }
 
 /*
- * FAN DIV: 1, 2, 4, or 8 (defaults to 2)
- * REG: 0, 1, 2, or 3 (respectively) (defaults to 1)
+ * FAN DIV: 1, 2, 4, or 8
+ * REG: 0, 1, 2, or 3 (respectively)
  */
-static inline u8 DIV_TO_REG(int val)
-{
-	return val == 8 ? 3 : val == 4 ? 2 : val == 1 ? 0 : 1;
-}
 #define DIV_FROM_REG(val) (1 << (val))
 
 /*
-- 
2.34.1


