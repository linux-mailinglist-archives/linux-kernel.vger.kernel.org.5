Return-Path: <linux-kernel+bounces-120387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D179188D69B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5381C252B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3252EB05;
	Wed, 27 Mar 2024 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtWPbe5y"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE433995
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521480; cv=none; b=t7Z2zXAmGcWpq2iDwiMjbqjlUIMa5ckdh6lo//eUFiRWcTfXetQzB6OFpFdXwkhv6O1yXQkYR2lrmvtVGzE5LdpxJ/TdnOm9xWqCShcVuW2s9ijxNCiIYLbIL8L+bH5VjwE8rXaNRESnS6xEgQQKTg47OUdz1K6Q04mGogqFCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521480; c=relaxed/simple;
	bh=QbcBc4JXtP8FNrsiFhXtIJGTYDJA6oPqiQ8+qe0RZWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BackCXddlMiI9//HXpl7wC4YJXUpgqykyXREDqPjCFoMPjLP1XEzu6lKBlqjdfxkmAf0d8RUjRxw7iOWyUM4+uPrAOZwBSXafGA/BxSvn2NJFhFKXy2y5OiMTt1a0Y4phDKHPLB+ThACIyO6qN96P6pJOWrFhroNncDP3pL+4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OtWPbe5y; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so398315a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711521478; x=1712126278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bURk46YiZRFAzwI3iGbvVt2z2P0j12npgAvS2/bABok=;
        b=OtWPbe5ysg3syklmGxL+J8f5iP707ds24J3M05fbKtSFaR1OrRgJQ9TlaQ+RrEbKD1
         i/3XjyO4potAMEZAGSO0NlcwOvT8KOKIaDBAW81kxZKvjqhO0XBGFIEgQtSqE9uwXkoA
         RnWR1kSUzhAB57OINLkEk+YWwXEw3HQ7sP7/8cxU2u+BYk5mOvovdRL8XCboOT3qRKFD
         YIMF77Lf84+h8kSlN9tkQwGk/gPYnQ/6P4IQnIiVSeJ10s/l0mp/QKciFRpLOjnj62mZ
         qQT9FDRZGOD/0Wkmbyo9bRdYf2E4fEdJRERD9Pa+p4zx94nHYLbDTYDmEITjxZfJ99qM
         RZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521478; x=1712126278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bURk46YiZRFAzwI3iGbvVt2z2P0j12npgAvS2/bABok=;
        b=WeHFLQMnIOl6GnZ7HiG79PSbmF8BGOE/N6K3xCSE+O4AvHGoU0zoouFS2Xv3vnRo9x
         oVb5IpcrBX030NVimhcVudbOskwHVjboC4hWsNmyZCdyAeqQ73MhS1YFBlwR+tyuXBKY
         AEs2jT3rjtfZZHYJRRioONgZijQwnN5Svd61q0dXVc8DOm5L+bwWJkFLGKoETPpYiB25
         ZlvAP0c2LFMIi2HIvG3ykSeGeX27RACOZs9RIIiNu4mbX3dKKyDuYke2qRIGEZpr59K8
         6w9Y34FpOdSjI//UDabixmqG/dverD9dXUd13e+K0SANq542diw1IHOzOXU6LArlDyZt
         SYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEV7S1Ge9BDHc3I7bmsOVI+eo8oYGpNlio5N0WnTqx75tbSl1fdUa1hWLseRk2e86wUjhTr7j4DtkEbor4+R6BBzQIi39gKAjJ1Hq6
X-Gm-Message-State: AOJu0Ywqh6YeUQiP6ZyRlH8cAHo/tLc1ql83Dp7NHE30IelPahbntLAJ
	IF8MhffzQ4pdcs7t9j5bFZ9jXCVspgIC30CGINsvdpQLeJp2gdpL0BTPMjzH0JI=
X-Google-Smtp-Source: AGHT+IGiOSRG4WswVfIPOXhLIrCEmwf3k2/SarBwimFsXkFNv1QRdA2mSDE830dZcR/t9cA5nnqjhA==
X-Received: by 2002:a17:90a:ac16:b0:2a0:905a:45c with SMTP id o22-20020a17090aac1600b002a0905a045cmr4070004pjq.9.1711521478368;
        Tue, 26 Mar 2024 23:37:58 -0700 (PDT)
Received: from sumit-X1.. ([223.178.208.127])
        by smtp.gmail.com with ESMTPSA id qd5-20020a17090b3cc500b002a02f8d350fsm772765pjb.53.2024.03.26.23.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:37:58 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stephan@gerhold.net,
	caleb.connolly@linaro.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/3] dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
Date: Wed, 27 Mar 2024 12:07:33 +0530
Message-Id: <20240327063734.3236117-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327063734.3236117-1-sumit.garg@linaro.org>
References: <20240327063734.3236117-1-sumit.garg@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible for the Schneider Electric HMIBSC IIoT edge box
core board based on the Qualcomm APQ8016E SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..c8c91754fe04 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -137,6 +137,7 @@ properties:
       - items:
           - enum:
               - qcom,apq8016-sbc
+              - schneider,apq8016-hmibsc
           - const: qcom,apq8016
 
       - items:
-- 
2.34.1


