Return-Path: <linux-kernel+bounces-127947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4CF89532B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1736E284BD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E60983CC5;
	Tue,  2 Apr 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc4zse2B"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F37829B;
	Tue,  2 Apr 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061353; cv=none; b=RVv2QFIEj4d26YIYIpXx4CjPqnNJBhVm7qDHkQvwVvOpo+w1O7HXciGbE/WiJgEckfXB+v+n5JZXmodErCUL5J3JoU1vLN6+ebXUF9vW9CfT9xMH4JwRVXsrK6DAH9++Fg/XvNjb3xX9lqgrOZz3pEdlWerQDuvZlESUs3Rjd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061353; c=relaxed/simple;
	bh=QGWIv2WWvyCrLtr4xkkotCp2unFTxp9w1QhuXHQjPO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W58O5A4wzGbi/gV8rF5d39qDzai33GHRPs9WV9Lqwn0sJrjeoDwAcGalq4r0xZDaZOTnQEZkyk6KBytqfi+hE0hAPWTIOOBCIoCnqlyTdY3hIDkz5Tev813G0FarONjaX5ApyUnRWFUlBNwOXXGyFhu6jgnWuEzrSP8Lx/BPF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc4zse2B; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so9770651a12.1;
        Tue, 02 Apr 2024 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061350; x=1712666150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cpmHlgTYvdBo5BqX4Qj555ThK3EAgjQXbR8aGueU4U=;
        b=Sc4zse2B1UIYq2YXLq8YAUhTIqrlQrXY7ocaKvSKbkgQCJatVaa5IJ48DTvA5P67Z3
         zVDCUAnPTP0SsqLdLMFKkoppukCW2rbpQREzgT2xxvl6EFFrn+lf5+pv5z25QXVzoC9R
         tdqxqXk1kfoWbP4OENQpN/1AHeW5F6KV2qIksmBK7veAQPgjHsn/uIGG6cNwwSEBaZ8J
         LbkGAA+1Dx6OIBmRwGT7+53NkeocY2LZ53zT1ng8RcgD19RSTV5oNeEq87Fe9fV+Q0Ph
         k4vCUqoyjLlelv2I3VCSif4i+sPL0f/rul43NQnRIz5CEsRghYcvN1bJrs/xg+vcjt+m
         hmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061350; x=1712666150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cpmHlgTYvdBo5BqX4Qj555ThK3EAgjQXbR8aGueU4U=;
        b=H7aMbCDSiyVShG4QUKMcdBqH3zxzCszEnJahzRU31n5VNe55ws7U/+SiijBVqiwRhg
         KlnT2oeNcnch5NG1O1p8K2lBiTYmUGFqgbrFbDSRBMsumMwQr9U4OQDVlqfXusrmMJJ9
         NBryHn4gmIW/tL1WLpCX3ZYZeEPWwrqXvcWSn8p14H41vyskSfq3whqQ7g73HH6hcWVJ
         64+sZ30VQMMXeP2AwYqYGT4TG7Ezkiqs+g/gg1dAf+e2KEUHv01X25xsjO8E6/BAq9Xq
         lak0PnAXJLamdUbFTx8YA66T4Z0NL910Hf2XLF0SXj0TvBuJckwmRtMrPqmFBCNml59k
         CstQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0+sockB+mmtsgTvHLf4K9695kltqzew8Z1ELd4tzh1M8XkGo+68vMiauHGl7Qqrh5Gq4MoQndQg+ySDvgIIxsl6TK5DD74iUCDPH3DtrRlFCjVNLdtI7rmnX0+cZhPWZ/dBl46MF8bQL63hS3fNhHR/NId2/0HJkOBunyb9LQiYdBpJLmkPQ=
X-Gm-Message-State: AOJu0Yyr9gjuQ01y0n9SmDpx6OkNRLwAuOYMOVMQZPYhaJG68xjKcBee
	v8YMF1KgHdO1f7YiwpAyzPIm7h6QVPlftKS8kIj5pb7AI/bAx5WgG2USVVCE5iY=
X-Google-Smtp-Source: AGHT+IHUmVMD2FluIhr5k+EwxnCdR9bLzUngmN30gx8pzy2d+rsyrBAY+OZ6dbnVYL8kqsJgXMospg==
X-Received: by 2002:a17:906:714a:b0:a4e:f91:4694 with SMTP id z10-20020a170906714a00b00a4e0f914694mr13159492ejj.27.1712061350286;
        Tue, 02 Apr 2024 05:35:50 -0700 (PDT)
Received: from [127.0.0.1] (net-93-65-126-18.cust.vodafonedsl.it. [93.65.126.18])
        by smtp.googlemail.com with ESMTPSA id x18-20020a1709060a5200b00a46ab3adea5sm6467506ejf.113.2024.04.02.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:35:50 -0700 (PDT)
From: Gianluca Boiano <morf3089@gmail.com>
Date: Tue, 02 Apr 2024 14:35:44 +0200
Subject: [PATCH 3/3] dt-bindings: leds: leds-qcom-lpg: Add support for
 PMI8950 PWM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pmi8950-pwm-support-v1-3-1a66899eeeb3@gmail.com>
References: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
In-Reply-To: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Gianluca Boiano <morf3089@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712061344; l=1158;
 i=morf3089@gmail.com; s=20240402; h=from:subject:message-id;
 bh=QGWIv2WWvyCrLtr4xkkotCp2unFTxp9w1QhuXHQjPO8=;
 b=K3FDOdLTXCrHYVq2laeBVzZJD6MHFNiwfQA9ZD2q523SR3ZZFWZ8TE7yT88PodZFbgYksusEo
 UtWqtgYf1e5ASs8lV6Svh+AoZsdGj+EtPcQ33pPYA5GDgKfOeizR/Ue
X-Developer-Key: i=morf3089@gmail.com; a=ed25519;
 pk=HsGrEQ3ia8BGGGO8/nUM2K2UX9JKvRPV+nbrVDGrYhA=

Update leds-qcom-lpg binding to support PMI8950 PWM.

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 7b9e0ad1ecaa..8b82c45d1a48 100644
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
@@ -146,6 +147,7 @@ allOf:
               - qcom,pm8941-lpg
               - qcom,pm8994-lpg
               - qcom,pmc8180c-lpg
+              - qcom,pmi8950-pwm
               - qcom,pmi8994-lpg
               - qcom,pmi8998-lpg
               - qcom,pmk8550-pwm
@@ -294,5 +296,3 @@ examples:
         label = "blue";
       };
     };
-
-...

-- 
2.44.0


