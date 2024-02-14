Return-Path: <linux-kernel+bounces-65982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A612B8554BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E514B23311
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8835E141999;
	Wed, 14 Feb 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQbhTuLn"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5313F009
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945894; cv=none; b=cuzwhufx1bCQ2ClCThyOpwPlyas0FiyqRx79nMpRkhsTgxMUwWdBppU2S3LjAXuyTvbp7M0UEObVYktYOuNrW+mGTXew7PaK1R4YXWUK9tmO2T8F8q29UBVBR6sSNctY92mUWl2ciiuRakAIQaRmufghaSApXEgFTxJ5JAd2Cbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945894; c=relaxed/simple;
	bh=u4L61jxb3pk7DyZvt+6wEP3FQgg6lRJc0FDd03RRCBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxX7nLX2ufJZArknauuKuZ0b3C7QYwNq6TqOBLAq7BTKHIOl9SDj9yzq8Jih8bv2D5z5ODXdQL/d+W6Xy4JH4qziwbJVCOcM/2wee6GA0lJGiKSAFJvLEeEy+sHr+kPPT8x02fHWFSowOTY/FSwDYjP3yrA5B/feokEbyf7v8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQbhTuLn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-561f8b8c058so2486579a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707945891; x=1708550691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXAA6feqe7ITmVt5QxnaZYVqRK0lZp3lcWFLVwQYYf4=;
        b=vQbhTuLnBBk8tsn6NSjB8x7owr8D6w8nrkT9+Rp/GnmyTvlEWBT+nXpZIpWMS3Su6/
         y8MnABSrd25pxPeKVBn/rwobCFwlLBfxJLthuMM1tcSEnD7bRYxJ4OtBAfAlnqog/VVo
         qLq4nhSoJ8MOj9QjyyNvd9ohKIR+t3BNBurDn8YHxU2jv8UokZrvMAC3xchSaQRIK8+j
         QlwI5PaSRkw7/R4M6TT3kYy9qaCKWY6YhI0SPTRT/OLd8QowGuvewsKMV7Ily1B7Gfkx
         g9PtwbGhuUlgQ9wpIJvJ8uDtmgdp0JqdFugjfxSyl4w9YN6U13b6Ts/p8ibZw+MZ0NqE
         CCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707945891; x=1708550691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXAA6feqe7ITmVt5QxnaZYVqRK0lZp3lcWFLVwQYYf4=;
        b=FTGihji6hStUmHFVjaeLfELzX0uSkiYF/z4IZjnw0BtqtnE7sTFj3jzO2SAvfhft6E
         Jc5fVxYAIz0fUb5V7BaOleGGJEtKeRR6qqW5Qkkb1yTiqwvkDOIrEYFsPX2/8DQ2FbT7
         cl7aPzPDjU6Ss3Mp+LeFogH34Z4Fburbqs2EF6b4optTa61QsD4kqeUDOCdu74Pjm1Vq
         Ei2Aw4rQj582QobkbBFGfBt0XNOs0VZ8hnjmjIofiaGs3zIrQTTC8WhteVIe4O4xpma6
         A/TiHBvLzUyt4Mvp/R3k0Dp5fItnyQArxyjgumPgw5vRi60lep1ZnYrdjmNXRTFWGUvF
         TiCg==
X-Forwarded-Encrypted: i=1; AJvYcCX//MyA8xyowJDcv0Vs7zFm+OsoE8dZbz4tk8W21rZS/ru0oIkOAUDo6Ra/fUcmhhJMP6mxVwXf8/o2JwQWHLP+7+zUZyWIAeVVCyPU
X-Gm-Message-State: AOJu0YyyGIfEVALmfh78gOyAltaFf4tIogUsfFFel5UgcV1IUAln5zRr
	bv5DV6xp4WGcPmHWsg8B4HzsCC6h4IT5Kcb3RMjlVvVZ2xE/IKr3ObxOU7rlIuc=
X-Google-Smtp-Source: AGHT+IF3YdfiAMlAsriS7KTo5dpnNgm0uvc6GEJADQtnnnPz3NJxhf3kY+qOs+OADKjIypSLqGno4w==
X-Received: by 2002:aa7:c541:0:b0:562:1a77:19a7 with SMTP id s1-20020aa7c541000000b005621a7719a7mr3030102edr.11.1707945891017;
        Wed, 14 Feb 2024 13:24:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXU0qvhrDFreJ4oK2g+L9nd9ACNCWvB7bhwMxZfDHlCfVObh12ic5ACvPwjBNo6WRBIozr/FRupxZgVbmwKWdrS6vOC+0A14cQ0Y3k/wvZEuva9sopvhkzM+SLtupUac4XA6vzvvy/qlNLNFUEiNg9MFe0N4BxBjWptTZXOueN/Tz7qe6caLz+UTUgg4L3SsMWzG4IjYA0/jcbdlL1IxMKG8s2Ol/Fyj16mvMrFoHm99sjzGZaCPOUQHWDoDxRoFVuXngA4Mxp8YAf3/5Cjoyfy6aZ8tEgKxRvL+ei/SWyabNrZ6GcMrlh7JSRaM2D1lWxH08K1BGkGRuNzovN/hlvD+DL5S/4IgD4XZvI5boLjWSXa4aDg5MYnQtqpwqE+2W3Xe01H4WOOKnYWdlQhoPrqC+d+BBvZ3KOvTwRBubwy2DCGqPStgOksEzTYF/v+fmDnBF87KpUb5gAiYN0OWvlXmdeSI/wfGiAvK2Kr29Iq8hNgY0ds/lRnKs4JvEtqzPsIVQPuI3yU2v8npiHd3VyYoWZpPLoYMdUlHPAt25q+cMfIpObffM4aMXbRtg+5M0UK6C4SGnSRuPX7xp76snfCf/HivY1s9yINsyZabQLXTpi4jt1cMGA4oK+jLs8xa0XGhSXiJY6I6mg4/f+Ey2Ty5eWyn3S/J9z/gWPXbJ4+G5sX52zxwIz8x7OG8HFA4e4=
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7c150000000b0056399fa69absm257298edp.26.2024.02.14.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:24:50 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 14 Feb 2024 23:24:31 +0200
Subject: [PATCH v2 2/4] dt-bindings: display/msm: Document the DPU for
 X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-x1e80100-display-v2-2-cf05ba887453@linaro.org>
References: <20240214-x1e80100-display-v2-0-cf05ba887453@linaro.org>
In-Reply-To: <20240214-x1e80100-display-v2-0-cf05ba887453@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=u4L61jxb3pk7DyZvt+6wEP3FQgg6lRJc0FDd03RRCBk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlzS+YTnSq40dkUznjxwa6aCG1BRHC+ieUtvEV8
 SGNKa5dRd+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZc0vmAAKCRAbX0TJAJUV
 ViaEEACcNVWat66Uto6xWPYY6++Hjv/g3VPUnkDooF/v2K8G5glMpa9wUbHB5xUqxjKXpxvt0+l
 us+AcR9eJeukGm2ZQXCiX2yXXFMcoIneLwYMPSkL6FdRNTac3KDnpNI8JEx+jr6hmzC1reyyeRx
 SBM33s1sZSWQXbGEZd0s3NytgfBkdO5b2TE7h72Z0odSF0fq88O5bpoPX23mFCiifSwpzgSekG4
 WNwOsS4iqv6ioHRI4hl+8FMRFyAEIkvSsXAfpCsWZ1cn/wrTTL5oK4avtDE27KkBEn3urnZZIAz
 TXOFd+Jh9sYBs33SZOaFLLSCbp0HhTQ162E8KAKoPI1tZDpReUWdn66f0p+X7l1NFDcGZhIyM7G
 loliKR5JXRmpr0ygJZiPUOxONV4aV1Wb7jcsC5/Hj1DCe6YXjSGIWqjU/4C8N++U6E7FnGH7gi7
 u6ozqw8c3zUVpHhA78Lrz2TPXiZbSDk9e5Her4MTqQKLan2oD2+EKBRGHhltIlIr6zGNPFRkjcP
 tzLtQPihFlVJxAASF0rO881NHqoNC+umPd0UUttpX1BEALENl2KWMu0R7uyAR1kt96Myy22Aeba
 5kc9CGAOQAZXM1RWUVaOIDd9CgPNKZ7LnnZhNyFeIeKkGlVaVylzydoY3zG4tKUps8x3U+UUQUo
 XMKleu5kRR7fL6Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the DPU for Qualcomm X1E80100 platform in the SM8650 schema, as
they are similar.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index a01d15a03317..c4087cc5abbd 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -13,7 +13,9 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,sm8650-dpu
+    enum:
+      - qcom,sm8650-dpu
+      - qcom,x1e80100-dpu
 
   reg:
     items:

-- 
2.34.1


