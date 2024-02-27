Return-Path: <linux-kernel+bounces-83260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39088690EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0068A1C2399A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE51513AA20;
	Tue, 27 Feb 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfqxeQy8"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E813A88D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038399; cv=none; b=rDZJFnzD6lFLls5mSDrdric191ENhCdzF2B13HeDzPc/1DJyODWjNlxbudzqitdzAM15dqAhvisyhAb95RDJUcLWBqUFk8xHldyPirZbSURapYwfyaf2qXcU6cBZr8MKkW9IUKPT6lDEFuDImCPMfnf/rSLRXl/B+5Zc5gaL3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038399; c=relaxed/simple;
	bh=9v2YqYFq6Eba9WIeYwnHuas7fhnenBEEd3lTTms3eAQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CAtl0YvVivgQud5CaQIPutOVAz6tFRoxefCEvi+v2fdzEmhEZanGP2WHvarVlJmOlIgHWjUetaTuEr5iZHAl2g/5e4vGXfrbNDJ54GGJ8FvVSzSLCDsp5WlWJ4Sf8l3ixH+tkjfgyhZDowVJpZGsQKsQbUbz9fAaIFKxfDSjM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YfqxeQy8; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bba50cd318so3078900b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709038396; x=1709643196; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uoA1zhsK924eVhGPcbYMs8zJoN9s6XNb2dqpxg85Fdo=;
        b=YfqxeQy86hS5BT0SThjq7zkJcwUFk9cjRm04zcSmQyXMfk24TaTVn4BjerLXnEiRWg
         +D3d8YtFbbeCyuYTnaK0Lbsau3Ai6MZnMX7/Yz8V+P1bNpSy4gPgGX70jUj/NmAZpO0c
         PO4N2WH8aCHHEFVuofmM6nrQAuX+9fa0GXBYXViW47TVucMpaqvHHlAqoYogH7A2jqrv
         fwz88KlvvJXAbm4dpGfCZqTq6Dlvoqds5sAEFGkT5UBEwVZvALx6wlFlLPSV5Whcr6l6
         lETtkEEYs9s8LTIcyT65ZZHgbfmCKGTBekhfcvA05F7W2WVsaoOCKYOeRwPHeGaXYKry
         o5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038396; x=1709643196;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoA1zhsK924eVhGPcbYMs8zJoN9s6XNb2dqpxg85Fdo=;
        b=if+1LjU1N6cGql2nZUEtWOdXDCwWMlNDeD3SSu/7V/OU9/BS9/oXvM6zBbSmPSwR9F
         nTU9psNBf+QrYVnUcxAeUqOWBs4vnRBU412h3UnKgwpE85q2Q0dOAZ5BfNm7/o6Aum9W
         SaPzpOpNxusT6n3pHL32CMATPS65WOfrMNCW8hdbFyuunlfd8wMhGsEH6CFZDWS4GG23
         lnPlpaUcLb7vXgdiCl2Em1GOFD84Ngvk0O+miG9cNnhidsWBkek+sIssC/HkMrEAg0EG
         Zy9n0TBLPUJcV6sUs4KcCSeecskBlXzkmU/S3SRzjiw8AHHrHERXbTI+SyDTObxICWRv
         eXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO49w0JNcWzIXvF7flPaTN5WdqHFtv/ZGZEbQRb/He0QXXFG0wXlCIVz5j33ny0C8U/AT71L7c7wrmmeELy7DI3LDlmavlGBamniCW
X-Gm-Message-State: AOJu0YxdV04FwYT94oSLDsm8MHDQUJ5u6l4VdLELJy9rmHFX5dTYNI6i
	q7qDpMJ//ZVBqqo58WuD7/msoj6vunsvEY32f6i8RjXarpPSVvVxmklfx5HF77xScWf9zce0Urq
	wWQ0=
X-Google-Smtp-Source: AGHT+IFXt0AWM4aki4nvdSvJ0KxEyjUS84ufrgN7stn3/bYNGPNiDnA2HKV39diFQRffFKURdQ50NA==
X-Received: by 2002:a05:6870:c903:b0:21f:c9f5:c326 with SMTP id hj3-20020a056870c90300b0021fc9f5c326mr13577354oab.51.1709038396654;
        Tue, 27 Feb 2024 04:53:16 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020aa78b87000000b006e48b04d8c0sm5841193pfd.64.2024.02.27.04.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:53:16 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] arm64: dts: qcom: sm8[456]50: add missing
 qcom,non-secure-domain property
Date: Tue, 27 Feb 2024 13:53:03 +0100
Message-Id: <20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-v1-0-15c4c864310f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/b3WUC/x2Nuw7CMAwAf6XyjKUkpSrwK4jBSlzwkIfsFlWq+
 u9EbHfL3QHGKmzwGA5Q/opJLV38ZYD4ofJmlNQdggtXF8KMa20S0fJtnxxuzVZlyrhQhxax1IL
 GcVPGVDNJQQp+nCn5ux8n6NWmvMj+Pz5f5/kD393u5YEAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9v2YqYFq6Eba9WIeYwnHuas7fhnenBEEd3lTTms3eAQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl3ds1XklfY59Ruwag5ecZYZOVvtWytUcFbBZV2xD/
 8+QY4kOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZd3bNQAKCRB33NvayMhJ0ZkQEA
 CRf9vi9+UcJwUwn8iSQg/ZuJijJ4px5h3/5QM3sdEr/jOgtKNOlgqjEznjVjf6/lrdCNtB+pxyxYrj
 1LSD+gAjqx8wOI3RifOG+PPZkmwCZ9VZx1YsvdE8/8XjNhAuPSaeqKGjowuylMbP3wPB3+kCk9paB8
 pRit8jXWme+NUfIcIbLOO3fX4VLriy5ZyBpdKmJmaprRH4my30H6eQPaI1KlurwKYlpTNrVaCveUKW
 7joOGTK52UiHLk+VZqiWDgxYhuFizPvUlBfjp8HH5rnIxdivOCobZEa40lfS+ef8OKjiyDXjIPaZOC
 DYVHf9EMkr7peWDL4FgpHhNszDfGYHXE/45HjgG5v/X5kXz+o4AlcZWdLNIofwncpWC+vnoFhvi0kN
 rhK4fgDlvhNj1x6A/onOTGOhgjCSjJPFItD4I5Bbh+u+1Wtv+deke8Zidl6IFBcPyhwNm1gncCuakP
 c7sY5AUHsaBNRVGy0L/5MB+SVuEyRcrV6mRG5VqRUJJX9yaYtRJzIlcm8Fn1oQU7T08i8wboVS7V+0
 oTEPA+4vug77UJ6UQwYOxDO85HbB3lDq/kmmr1hHY4gZqj5kul/lspkCZOo9nI8Z1+v8BYpu3ZMrKR
 WRmAU1rZtmo89LREGpz7dWq7cbBUuxANo4ALpc6EILKmEA+psuw1+UnEpFoA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

By default the DSP domains are non secure, add the missing
qcom,non-secure-domain property to SM8450, SM8550 and SM8650
in order to mark them as non-secure.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      arm64: dts: qcom: sm8450: add missing qcom,non-secure-domain property
      arm64: dts: qcom: sm8550: add missing qcom,non-secure-domain property
      arm64: dts: qcom: sm8650: add missing qcom,non-secure-domain property

 arch/arm64/boot/dts/qcom/sm8450.dtsi | 3 +++
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 4 ++++
 3 files changed, 9 insertions(+)
---
base-commit: 22ba90670a51a18c6b36d285fddf92b9887c0bc3
change-id: 20240227-topic-sm8x50-upstream-fastrpc-non-secure-domain-a2137ad19135

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


