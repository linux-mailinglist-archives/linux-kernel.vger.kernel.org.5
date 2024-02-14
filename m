Return-Path: <linux-kernel+bounces-64894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474BC854464
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A9F1C26FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73679EE;
	Wed, 14 Feb 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2/18nlT"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715C125D3;
	Wed, 14 Feb 2024 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900852; cv=none; b=rr3ZxVt7UifkRQSZKiXmHgsXBnPnRmPtdlhJ4tzlxGgjJ3EvCXBnXN7lxob+lLGhDku/pvAZ9zBbqFI87+B+M3gV1Su1EnA6DGlnc9LgaGasi+FDHN1Pkjy0wG2nWUVbxearMZSQt88mUAzbN2BKGsW3fPOxepVoJxS4Hc2DykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900852; c=relaxed/simple;
	bh=JIupEgZdlhi1DwMWARijZBjPHa2nr9YDs+J+OgdUkYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+rWdj/g5Kd4oFwL2HsG5TMBQQScszlzblkkoci8iw54VrOGGlxG68lfneMGNk4O9t4xWFYk5LOLkAurbr/UcH1UxKV+yDLBgxiCTV40IviWKVa1WvrSOWWJLnr8LT+fr9nRWm/mxVBsVPqy4dc/qifpOspvB095OVWgxy3sk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2/18nlT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26fa294e56so705375366b.0;
        Wed, 14 Feb 2024 00:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707900849; x=1708505649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ds/QrOAUfj55fwmiogY89G0c95jjcvTfyeTi82RwVPQ=;
        b=W2/18nlT/wmqK186h0NIRKl/S3O1p8BMibKV64D27f6Mj8+Nfh2eMApn0p1qOmcxRg
         4OLnwrFjGWGXNY01Tasl8gSNAXr7kbsCLWqOZ6iwRnOmqdoR3mVBCGuK/gYeQKS3McTe
         thYksbRtda1PyZd8YH5F837rZGrdzyVOgKjlfjrwsxP1GAIIfD6pGosXodPK2PZRWaN5
         1BLksh7EUKEhsidiZR18XmRBfpOQKuh4kg93v+lNEOFG2daTCUQHc+9zEs/5AB2Z8a/z
         VqCZ6WldIOn/kM7h8gBSut91ac2ad2IWmu558RnUdSWfm+l2jJwYlzOum1BwYx6skhT+
         1O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900849; x=1708505649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ds/QrOAUfj55fwmiogY89G0c95jjcvTfyeTi82RwVPQ=;
        b=lcqDyIpWR7y+pYl5tjRyO2XKRu8rWD8/PIKBsCK2sWuzhEjZLPxTAKNYTj4HbSfxAN
         43W/UeuK8Fm2PAHNbfdofG4JP1netWurbLkkaPqvA679AmA9H14g7+769H0a+fww/eFF
         xYK7XJmFuqAdsPy1Z1jMzItSTUbSI1115z6amGoe9JT7wxfO0CLVTIE+rzYCuoLipZYa
         RwafwnLf1OdvyaUVFACRCvK7IouKTzEPamFqvPHF37mK2OqF2m9lerWGkxKTV5SjF/Dm
         wYlhW3nqDoDkaRlsDMIXmo+yCzSGawMlCXQ9/HEkyKP87Nu10eGD1TC+WMZ97cT81BtA
         86gw==
X-Forwarded-Encrypted: i=1; AJvYcCXanTfprVQBsjYTdix30b3orEpx3jGWONlP0GNwrwmPJpEIOWh02+q5Mej0HaaRWynvdT2VdlwmYSRlZMk+KzKYUcxDrY9xmV+/Cb/jzuZhaqZ/nmoTzLs7iyCQHaXBzRV2TxjzD2uN1xn2TQ7HnYsnUf6x1GQuvlLe63ZGK7smrp2zCQ==
X-Gm-Message-State: AOJu0YwgsUOXihQGyvmFIhxNRdQ2jGHlLRecBndOf7uWf2I5+0O8EAYb
	1PiKqywHTTrHZsvWY4CU6hQMlFh19qJ6cGWmHnILDojPpfHC9Guc
X-Google-Smtp-Source: AGHT+IHtQkkg7cmPOVNhPqSRXK5hIlaovqOGnDqh3sNWSzqQsse6el+sdvq++8Bg64n7SL5C0jJ2WQ==
X-Received: by 2002:a17:906:118d:b0:a3d:4036:4543 with SMTP id n13-20020a170906118d00b00a3d40364543mr858290eja.51.1707900848950;
        Wed, 14 Feb 2024 00:54:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEJYQ2MujHYQ4aClq9TFiI/b7CEexbSpF3JNd4i7OZvcIvbNQufcjzKwdtnXvO0cP9yuL59lijEE++hQo3ZDB1scsWxygqwZ70735Yj0gJB7s3FJ54vSyACtrIe1cVw6b5hfxFHxaWfprgP/DMa5eTF1w4RJkzlKUprjkMcg5HpzJ8eXAPU9FVFpdnR6HCWNFUD9KLOVtLN/rJCIucyHGlCz16qTgGewEwZ7686VR8+aX5hUuL2T7cHkd6BYDy36K23YJH1aaHucoMRHVXG9RgK94pn5+l3BstckIkciTOPKuqpRKqd/NJYSHLgTTrPiqyvvhaa+SSyHKvMvumGCvi4WtmNw0s7RqBhcJHY+a3lQZmDpL0ULk/JU3qBbMuHStaiwkYcNcsS6VYGrxeShvreiFZomM5OCA=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a3cf5450b28sm1617264ejc.189.2024.02.14.00.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:54:08 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Li peiyu <579lpy@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: iio: humidity: hdc3020: add interrupt bindings in example
Date: Wed, 14 Feb 2024 09:53:44 +0100
Message-Id: <20240214085350.19382-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214085350.19382-1-dima.fedrau@gmail.com>
References: <20240214085350.19382-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt bindings in example.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
index 7f6d0f9edc75..8b5dedd1a598 100644
--- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
+++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
@@ -43,6 +43,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -51,5 +52,7 @@ examples:
             compatible = "ti,hdc3021", "ti,hdc3020";
             reg = <0x47>;
             vdd-supply = <&vcc_3v3>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <23 IRQ_TYPE_EDGE_RISING>;
         };
     };
-- 
2.39.2


