Return-Path: <linux-kernel+bounces-81236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278EF867267
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5946F1C27A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014931EA7C;
	Mon, 26 Feb 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2x3oXBw"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D71F95F;
	Mon, 26 Feb 2024 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945105; cv=none; b=kdz1MVQjDFAEIsGY9N6BArP/YZhbGzv1H8VXhscQgeqc5xTc9/1HPjpN44JOa53jVclbvkjxhO4qPbxV7kmfEBP/gX7VteBjoKsT5TUrvzDzDNP8XXnDE1SfFUuKWZFqzpm6ai/Krgv16mMeXClC/XQzaujHWGwWuUOnbCG1x8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945105; c=relaxed/simple;
	bh=syIKjrq+WfVbdCOG9H5+mA0Dtw4SFgTRKx0qyz1gHOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7zl0Z93+DqZjIJmVmfXEktmUuVQOWq7AfRWvKxNg4Qgo1tsOl832uSGVCdeZUhQLzSSqyTxgf4OsRdX1l5fF4NzQU7cBQLUtLjivGJSvsayi7rnp9jA1CNouAqt1qqp+Kt2N1DAR2Ysl0jX1qhQ8WUHAjM52SzdRi++ef04y08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2x3oXBw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2823622a12.3;
        Mon, 26 Feb 2024 02:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708945102; x=1709549902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBDj39VHM+FDO/ilMiBO91UzViz/2NlYW/IEBlun9BA=;
        b=W2x3oXBw6hESK6Kr9e6eHbhd7/tVYYYVLV0O00LBUY7hL5nA7PONDX7fQMJ1S1t6Dk
         MKd/htzWOy2QkvIK+2T5g33jJzPl2OBBMrJi7UWMj76o7W0XKpcyyKc5UsJpkINuFXz1
         GaUTJa4LsICIldNYFM36sEOrSeujZ0LX7KQF0JN8X4a90XnxIeE5gyimCyhurm0NqHMF
         1WmW5EprmTFbPfK0Uqu86ZQ1XubTcb2SbA+oSQE41WMQDLZysP7CKRzGHPFhjxXsFdVx
         Ml7svCmJ6cr7GBzttFRXzlmMzUfHWewNIIny2Y0gB5+qF8kV0+yQYajZLb01Xy4pFkVc
         duGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945102; x=1709549902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBDj39VHM+FDO/ilMiBO91UzViz/2NlYW/IEBlun9BA=;
        b=RfqlGEIScqooqoUSzqsd1LxbTfYrhF0Z4wsN+J6i5O6SvfELmgXZCUI0cArzda3V5h
         Grl9SFH5Ghk1C9DFVc8+JXWZXBrSTNI3d0Zp1NjLClwSf/FeY44+WlCUGCsTlYEAfdLB
         s9g0jnzioBkPse3Z6qi01SeseddUolbxha7C3W+QBKrG9hy50S8HF24Y1F74aHRWWm1Y
         hqz1EDriaXC/mQoI8u1FdceB2pWq5zSA7d1RNvgQWEzdmG5iH/0KurTeRbztmvBojVlH
         KjjRD/dUj/Ww+ldwihBA5bbHejU4jO+VhEGEwRvC78M/DijzekW/Kqw6TfE4c2cUrCbX
         m3WA==
X-Forwarded-Encrypted: i=1; AJvYcCViQn6fCcLCGQ2Gkj5G51+jtfdztSGqAt8wfhG/akkDubP0zHqHAoSjmNP1LrFYP4i20XhmeXUrLJMMlsAyTo6bWuxb/v7qD2qhHCydWy+Q/uvb/l0CwyqIRRgk9mwofEaRMR2Mvz0e0JQmRKOLUnZ4PFOvPQNya3yHJcnsafy/aebep+pLElT2mhE7b0QWb32G4iUSUZBTbNjvQkoiv/ZDuxMs
X-Gm-Message-State: AOJu0Yzj1y/igwSqbhCiwsWX7OqUFrp+OxfvcCR8KzhOpmEQBFlpL9s0
	D8NE3MWnWO3YwUl3gXSFjlYUpNN3tg8pS3sX5C1VibMUW5hZC5xM
X-Google-Smtp-Source: AGHT+IE/y1ci9MXRfiPgQnFC6LdOJVkxE6PHyMV7TApmLIy0YhG+GXnU7uQVslHHQrluXFFjBZvrPg==
X-Received: by 2002:a17:906:150b:b0:a3f:d742:f353 with SMTP id b11-20020a170906150b00b00a3fd742f353mr4359261ejd.57.1708945102074;
        Mon, 26 Feb 2024 02:58:22 -0800 (PST)
Received: from unknown.netbird.cloud (net-93-65-126-20.cust.vodafonedsl.it. [93.65.126.20])
        by smtp.googlemail.com with ESMTPSA id f19-20020a170906085300b00a3fce8c0f99sm2315769ejd.191.2024.02.26.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:58:21 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH 3/3] dt-bindings: leds: leds-qcom-lpg: Add support for PMI8950 PWM
Date: Mon, 26 Feb 2024 11:57:47 +0100
Message-ID: <20240226105747.3547856-3-morf3089@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240226105747.3547856-1-morf3089@gmail.com>
References: <d17121a0-ca14-41fd-9802-bb4118629e34@linaro.org>
 <20240226105747.3547856-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update leds-qcom-lpg binding to support PMI8950 PWM.

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
Changes:
- Add missing entry for if
- Rebase on top of https://lore.kernel.org/linux-devicetree/20240226073713.19045-1-krzysztof.kozlowski@linaro.org/T/#t
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 6649ca2ec805..e93e9b30660b 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,pm8994-lpg
           - qcom,pmc8180c-lpg
           - qcom,pmi632-lpg
+          - qcom,pmi8950-pwm
           - qcom,pmi8994-lpg
           - qcom,pmi8998-lpg
           - qcom,pmk8550-pwm
@@ -148,6 +149,7 @@ allOf:
             enum:
               - qcom,pm8350c-pwm
               - qcom,pm8550-pwm
+              - qcom,pmi8950-pwm
     then:
       properties:
         nvmem:
-- 
2.44.0


