Return-Path: <linux-kernel+bounces-110831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED976886474
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A288D1F219C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F1AD52;
	Fri, 22 Mar 2024 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7VP+rvJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996706FD5;
	Fri, 22 Mar 2024 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711067854; cv=none; b=f+AzBGQXF3AALUIhAh4zg+rsXIv301Nb0uX0jFqTUDX59279yAhp0nODQ4HYrkjK38OVYtTb7/VtwqPgJAGomoUhTpH3gyvshCfGe3MlF9oBi8rEOa+xf15ZsvE1G1JRRuxK7DWKjbBRJeLEuQcsC/BfX6M3kjddmR7+XFiMFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711067854; c=relaxed/simple;
	bh=uBFUrX0Ia5VA/PShDsMG3v5eTOEUOmbfza3kV6y9XHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dM2dA/R8Ei4cO3gx8REGIYlU8ceBTqF/xGiBmgH5yovJbJYMJ5pX0bOv9QV69qdy2JKvSnuznsRy1c9wj5I1T6HYYbQSAcYoKk0WO9yjrTCQ5cANLlKoNjz+U/HJDsEG5ouqJAqAccYBN3D59sevxSgdWBUTvbx4cD/W704iZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7VP+rvJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-414633f7a52so15360865e9.0;
        Thu, 21 Mar 2024 17:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711067850; x=1711672650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad+0k2H3FSz/hGCF4DQGSlIo1TTHSEIKfn/JqeYGeeE=;
        b=k7VP+rvJ6EoJ8f4BBPa4pIFAghsNZ1azdr6Gi4ZBP1oIYAIPiGX1330wSLzvt8a0PZ
         TUSwk+w/WvRsSYkS1b1WiakwvUfKnW0vOp9lz8jTGw/lce7WlZUSYw4uqPwKGy9tlFRN
         BDpBrN6en4VqcgqTvHAfbyY7hc+lYze5pB3/vU8Q74NF1sn9/Q3+O30AORVdV26aL/rm
         GAkT6I0CQ1W2g772nltOyNh1Hs40Z74vGlW8isswDsjVsF22A2uEkDoF2sOPkY0se29d
         +I+Uh8srZwjkrtinCPZt65kQnRXBfzPCp9zuO9fd6InLF9Fa7ESgt+mzoWr0lCNaWnLg
         /ZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711067850; x=1711672650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad+0k2H3FSz/hGCF4DQGSlIo1TTHSEIKfn/JqeYGeeE=;
        b=QhTAEWIZy+TTuWPBig67HcIJZeST2u/Mopc6BKhe/8dEdf+OOPxrQEM3l1JD/sDQC+
         WTSLRFUt9FwBLxBYEAbUAvXatRAznZQOzc6Qv20D7O6KSvV74VbofgX6Ry+rok14VwNp
         CG5vX7DPpDLDqmbSWgkpug8rRuz9XO7az+p4VG6Id/opW5F1uRynqUupIhee4U2Gg+Lc
         /uJr5mZi55kaEO4rhcEte4dY421WDdNuwbPfVIrReLgGWK0eoJSFcbHOzAQ8ORHQ64/M
         1KseSJXTyy5e1jOeX0sh/mV9RyGoBawzFEw0/oGM8hlqamsZz+Ws5+yBxxlsKhsYZEUB
         ui3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHi3bwXuFCk95WtiQmYoHI59Yh7m4LEKag0qJMzPYBIEiVwTPsejmee+6LPxSYoDOlV26TvqUzRyKAgoW7Ax6dipBCmEgVJ+unZPuJXbWJJFKtpBOlTktykkBUSMENmIZ+9T8oW3NSQA==
X-Gm-Message-State: AOJu0YxbGe65fAeo78a+dJVLZU7BugROCq2WRryh/InhxS+yL5/O+HVR
	urZN9+K2AFzvnujNN/xU8OFV0HsejoVa4B2Xa9m5rpQfg0f9SRwS
X-Google-Smtp-Source: AGHT+IGX6NSnxjb56yDpUOLZdVoEXUT3GIFgOT/UsC0oXmZ6CPqemqQa1pc3Rn2EvlMDHowmLzQZ6w==
X-Received: by 2002:adf:ec8f:0:b0:33e:cf4d:c583 with SMTP id z15-20020adfec8f000000b0033ecf4dc583mr532834wrn.16.1711067850224;
        Thu, 21 Mar 2024 17:37:30 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906774b00b00a46af0fbf5dsm439950ejn.103.2024.03.21.17.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 17:37:29 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 3/3] dt-bindings: iio: accel: adxl345: Add spi-3wire
Date: Fri, 22 Mar 2024 00:37:13 +0000
Message-Id: <20240322003713.6918-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322003713.6918-1-l.rubusch@gmail.com>
References: <20240322003713.6918-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the optional spi-3wire in the example.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 07cacc3f6..280ed479e 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -32,6 +32,8 @@ properties:
 
   spi-cpol: true
 
+  spi-3wire: true
+
   interrupts:
     maxItems: 1
 
-- 
2.25.1


