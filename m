Return-Path: <linux-kernel+bounces-80276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF9D862CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3787C1C212C9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE41B809;
	Sun, 25 Feb 2024 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEdfdOa4"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0863A5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892751; cv=none; b=Wgp1BYzRweFGZW5PFaXQlbv+41OIXzQ7tiJ9X9KUr8vNG7wSlzDWef4Qf2i8WNqFWlLOGcxEptGbei4gvNEMKJVekHhmnuX9I6irRqX68/sD1crI+uK0llhGWfTImxIDD4QzUxCNDetZ+ajB2WCzdMHUiNPBJX2y1P4OiMYphEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892751; c=relaxed/simple;
	bh=mff2Bx4f88etHoqdVo+jEmdrbqPgNQ/kWaOd8DhYTIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qyb731c0mYRZNk7cXcP4fHlWYeZp6UrKwN3WiZgF6SmA128mrB25GcK8Q/gfCcmjKc3ltB4Ax/kel3TDmfJ3ZNA6XSQi5NANWSDrtH6eGbYSEIcHq12FBTUrs/KTAsa+nsK7QGj1MDLmYWEIAF1Bd34PlPeceB96AxcBDmWhgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEdfdOa4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so297923a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708892748; x=1709497548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2R/XFG9oaY6y18sf9Tff4jPtjEwP6MJBf+0W5rEV324=;
        b=FEdfdOa42388OHWHA+D8OtVM+zbelK8SXIUPZ6xTtm9gElBK/yTcyOdveLJCvI1Kiy
         NB+oJ6IGhNyPv8uVd5fuSnZI4GIapC5G93ocuVQuOzgotaK0hAPbTjPlHhEGoyIgRagL
         r1bB7UQanZ4AnBNqWy4F1fVHRR8iQEl/H1uN7m9vukRLhDYi99XWo7z3mZkzQJSvgR8g
         IVMR+nvaaMnuKdtAM2bZBjbwgn8z3/x6ZByNSdBoOgA9Q1nEIFWgGSt7K/S6h2Rf/iq0
         DJIKHiM6y5t9BCBY+BYGOzZFwhn6HmSIoJ36WULHuwpKKLmfKQ8PTioAZdPzQXVYhR3v
         /ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708892748; x=1709497548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2R/XFG9oaY6y18sf9Tff4jPtjEwP6MJBf+0W5rEV324=;
        b=Pl37ffy/xBYKaYetYbTfAZb981Uy7ZFokrU5cQnmg0lPE77NEN/SNngTHUj+HynjTP
         Orc7T41PLTezT2bJ458ndg+TbkIfC9ir/YQrMhS6ckB7iAhYWtSzJUTYptgyZqRQ39a8
         j7garjIfPzIqAOkMJXWAd2hUsnt49Ph49QgCN1BiD8XTsTW0P5utA8vtshJLKoPA5FXU
         nY9jOy+0WlsnUrEe4lweH8AX9VV74a9/acByvvuevK4EgdbSr/Ahcyc/eic6H4W6bBMx
         FL69kdVjD5Ox7SphIATRMc0948Qi0iU3JAQzVLJxARCg41nr+Nuc7Fww5g6V5c466IMO
         wBug==
X-Forwarded-Encrypted: i=1; AJvYcCWuXx1Yfe2ldk85q8/VQRhY8Nga2B0T0oJ87xT2gqCC4oOKCaHYQAkss1Xl3I+bznU4dqZ6rXj5e7aOQeFp+deH0mbSNnFP/OuZ078V
X-Gm-Message-State: AOJu0YxMshzCVCEcf7q6QnHdBQdZTEcKTJDI4EHPumQlt7TzbMU6WqwG
	cvMbFBzCkySRfRacHYAQo47QwklyI6704cKGoGK5Yc8Oub1bX25RQrN1WKo1OFc=
X-Google-Smtp-Source: AGHT+IGJLb0LFIjQmJVb1XHJRopVy/BJfdLpJRuaWdrDVNDspvP1AdwQpIQuP1OWlnVfy6L/oZZsTQ==
X-Received: by 2002:a17:906:140c:b0:a3e:dcd2:2746 with SMTP id p12-20020a170906140c00b00a3edcd22746mr3685269ejc.3.1708892748480;
        Sun, 25 Feb 2024 12:25:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id a26-20020a170906685a00b00a3f0dbdf106sm1741491ejs.105.2024.02.25.12.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 12:25:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Chris Lew <quic_clew@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] soc: qcom: geni-se: drop unused kerneldoc struct geni_wrapper param
Date: Sun, 25 Feb 2024 21:25:44 +0100
Message-Id: <20240225202545.59113-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop description of non-existing 'struct geni_wrapper' member:

  qcom-geni-se.c:99: warning: Excess struct member 'to_core' description in 'geni_wrapper'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/qcom-geni-se.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index bdcf44b85b2f..2e8f24d5da80 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -89,7 +89,6 @@
  * @base:		Base address of this instance of QUP wrapper core
  * @clks:		Handle to the primary & optional secondary AHB clocks
  * @num_clks:		Count of clocks
- * @to_core:		Core ICC path
  */
 struct geni_wrapper {
 	struct device *dev;
-- 
2.34.1


