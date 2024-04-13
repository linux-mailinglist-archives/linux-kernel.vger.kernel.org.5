Return-Path: <linux-kernel+bounces-143788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1909A8A3D7C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395A42824E1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27D481AB;
	Sat, 13 Apr 2024 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/wT2yKd"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C046421;
	Sat, 13 Apr 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713022690; cv=none; b=u9fW3S+4bdsCJ7CcVUO7i6qYGk8wKrCheg5XxEaAuCZALMKqrxN2GOqGBF7FiuJ2h2HRvtJlujLTnX95nfJQZELMSkzt0C9brjVLvKoUb7Jz/i0ki+rXfPekVtFCR3NUOtMw8HTV+mWmJ/Yop7NdN5olVlBiM25LSiBIdxfoeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713022690; c=relaxed/simple;
	bh=SGx1zIyqnN1z+tgQVDcYUHrcu8NObV2jamTP00d5gPc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=YhsLwxBbkEtq8zfHu1mVeHPH9OMhteursWhZLYj2OTWZJQKoCPlYTNxZCjSq27revxMjCLDcoFgSU87R1oiTaNWdHZ9YpAVC5sy8gD1xiMeC70RaHN1eeQ1xMNCWhhsPKu7Nn9FgJLoa7ww6pmBCvGjJ3/WQUL/k9ZxwMq6o6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/wT2yKd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a520410b7c0so196482766b.0;
        Sat, 13 Apr 2024 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713022687; x=1713627487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ExJoTB3hhXa5q9DtvmCjzuPMuLoa33GZY+I61ZoNag=;
        b=b/wT2yKdu9MJo7f0GHK9CEtPPwlnBJy4KIat+CR9B/Z1o6aBqhGRlW/1RkYCZddRKH
         maRdItDILAAt/Q7W6RyJ2KQsMzMVLn6QOoa26Ri0fHdr1t32jhHXv+LH1iQ3utd+w2Ih
         PYBUJ4WOfuNEKzdY23mpxphl1cvP+2Oi5zHO00YSW4wE5sr12YoPVxqu+UKxP3SY6W+X
         qg+1FaeS2FvXTVlPuRInHjrYwIlgPdxeMq8Eb4rSu10/6Ro4oreUMvWTVJ7i2M7fu2gb
         1me3iiLURj/VUoJpBWr8M4bN3JIFh2Q+iMeaBvXbT7U9IdD4vHObCjUE07pK8hbmuT9D
         wdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713022687; x=1713627487;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3ExJoTB3hhXa5q9DtvmCjzuPMuLoa33GZY+I61ZoNag=;
        b=GgfwWyBofHmB1/Iu7YfjqsXQzm4KWicELg3YXdHLkZytkabIhmorDNSCApJwQSOPDt
         XSWPs6u762IYyfATPpNekecyg5bBJSv2felmeBCgOptD23cMjlRhTBcsGcDGm8/xaXn/
         oowZyKB3Fpo9R4C9ON2O3g0QpfbAJiCmvSVSOJsuUskw8s58ldTIXJb1t06xWFsr+90L
         1VAX3jx5wsE/gHW6fWS5W8MRA+JHg00EDP7ricn9zL6qN4PgzRhSckrq4DPo6bwIL8nw
         R2SyI9xLBmZfxsN+5zfhBx1PBslM6A7o2ujny7yb71lmVkgLlU4pTYoYl+Mhc4mmyHKs
         kBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwlyP3LURqKqrbna7sMiGY5KU2MIYs2H2iGvKG/9xDpJj3yMH1+UZjexi+lfKSaJSalJWVUdnI/wQBLDvibkyKAYCoAaDhANUAhBfM9BXPbRxLZjM0+FT0TmXKARzvbZSE9TYWO2vQwA==
X-Gm-Message-State: AOJu0Yyra+YX2kaM+lyjSt3IXheHuh6Z1RVQ+I+OUMpf7dnQlVytNoH1
	qQZlVzFG+ZrGSzHhzr9pG27uNDenhVcgUiz0xJyiOARs1BlHlpTD
X-Google-Smtp-Source: AGHT+IEEl2sbrq/BBwP47g9sQFrSN4a3dH6bzRegvZZXLOpd9zEimISYPga1ISSsuvLUCDhddb9hpg==
X-Received: by 2002:a17:906:dffa:b0:a52:52e5:bb19 with SMTP id lc26-20020a170906dffa00b00a5252e5bb19mr758772ejc.40.1713022687356;
        Sat, 13 Apr 2024 08:38:07 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cx10-20020a170906c80a00b00a51b5282837sm3131680ejb.15.2024.04.13.08.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 08:38:07 -0700 (PDT)
Message-ID: <3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com>
Date: Sat, 13 Apr 2024 17:38:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/3] dt-bindings: display: add #sound-dai-cells property to
 rockchip dw hdmi
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, markyao0591@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Rockchip DWC HDMI TX Encoder can take one I2S input and transmit it
over the HDMI output. Add #sound-dai-cells (= 0) to the binding for it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/display/rockchip/rockchip,dw-hdmi.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
index af638b6c0d21..2aac62219ff6 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
@@ -15,6 +15,7 @@ description: |

 allOf:
   - $ref: ../bridge/synopsys,dw-hdmi.yaml#
+  - $ref: /schemas/sound/dai-common.yaml#

 properties:
   compatible:
@@ -124,6 +125,9 @@ properties:
     description:
       phandle to the GRF to mux vopl/vopb.

+  "#sound-dai-cells":
+    const: 0
+
 required:
   - compatible
   - reg
@@ -153,6 +157,7 @@ examples:
         ddc-i2c-bus = <&i2c5>;
         power-domains = <&power RK3288_PD_VIO>;
         rockchip,grf = <&grf>;
+        #sound-dai-cells = <0>;

         ports {
             #address-cells = <1>;
--
2.39.2


