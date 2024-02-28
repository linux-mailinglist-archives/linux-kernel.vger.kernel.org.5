Return-Path: <linux-kernel+bounces-85006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F9586AF0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB21281600
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096D96CDC6;
	Wed, 28 Feb 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="AzDfDmoH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B153BBE6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123075; cv=none; b=UUaEiQtWwuXAKKG/d1uUFAu1Yc/+Cb1ng+ehOTl8xXcaC6PWes5Kwp3Net2QC3Y1TeTAsl7MdhSZXLprS9iCGKnjKKwuQmmFaXKwlQSFmH8p321N8hQ6QaVUYnR3xPfVfPnokMDRNi49S7i6wq1Q5NCYxgNQhRgHIoOLCFr6z4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123075; c=relaxed/simple;
	bh=AXUB+wekpvvQJofmQTqramJpoql+fl6AVK4WIWaHl9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osBUpmuilk8FvMRNO4p0z406TgG1paiZTWfWG6n4rz8GiIYHWiSq/LAuq+QsSgQdSNSA4sa7FTZHA74m6417PFaj0yNeotsvYSZey05ZPfMAP8TQRa1NRzG4g13Av/CJIljTvaDxHjnFoTxZMt8rYURD5dOjlTJ8x/Bv72WUA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=AzDfDmoH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e554f64971so655341b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709123073; x=1709727873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q45nO3W1ZZnJy1jAiZ36rHKY6n1bYehmKJpmPkGfdDM=;
        b=AzDfDmoHAMGdIuv8/CIfRgQykaRbmDZCCe+E6kmkZ7kO4TKacaBATjKvgbuVQKbS54
         NXe341BwN69CaRC9VfhDgOuon94qUlM6V7WQp+Heh3987Gb8XHWs5lh1LdBmZCFGYs8Z
         eUasXniM1oXENFyNiFFbRJq8zChs22E6v/8Ul7RNbrfhWoDLjAY/h+WpyEhdwrutdqJC
         oI6VsFpIDtCzJlY7g/IF7/8VR7mlJD3YZXhmPbItUXWJgtgTAcNT3Yw4/mHsR7nTIX0O
         TH9Z6uML1G5CNulozaxtNNgHnSLkKUQa/whjp1mqLycXYRWlGHwCF0qOKrLaBYn6LMt0
         bevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123073; x=1709727873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q45nO3W1ZZnJy1jAiZ36rHKY6n1bYehmKJpmPkGfdDM=;
        b=JfQtuc3MpV1PXOAH7n6ZZmUumucw9Z2aSvK7GbT3oiXmMzeOWPp8JRomMIVCbtq8Ti
         a3cyNjYZLf8iTxBH/36sVfaXDfN++35+6JpbMSqrggdw9g1bw44sV7+4AjQjC8cBiO4N
         fVWpDMzo9+sFu9QpvMI8fv/D9W9roEwKhHT2X4vj3lUUsSE/V17f25QNBmo0NztfkuGS
         YrrEAlIMuRohmOoGuRypBhUBFnhdCKFtamOTeG8oVBt2J4B0SuIkTwSBqtwSlngJZliu
         bSmqxiLZqFjchxe6jaS/b20T5okWpu5p0mZ2RmD65J/geaBtaWRB7IrkPovqlRsYEj9H
         IZVA==
X-Forwarded-Encrypted: i=1; AJvYcCUq+ASlLdBDqQHvSWzeO3Q/4ihbdc3TKrjcFgtaEclBqPQlGl2+PjA7dh5S9EkIXVyVjf409sgpYdkSI49c1N3uX9qpo0IAfWh5QcVv
X-Gm-Message-State: AOJu0Ywb/H4jeQAqlfmi2c12vYfkSn4bfCgJN2tfttMZ/tN/Phn4YN4v
	DgGhEUFAd3pPmQDWT/SrKdOdisd4em1wcQ8dvsLc/qehwEBLdNYLEcKH3NOBz38=
X-Google-Smtp-Source: AGHT+IEI5Jgu3qicVasTSsPz9ABZJ3eEgxdaUV9ttamRAtixIlMyDWXyuEJDYpsoCVAD3qz31r1K5g==
X-Received: by 2002:a05:6a00:2da8:b0:6e5:1196:6cf5 with SMTP id fb40-20020a056a002da800b006e511966cf5mr3130013pfb.3.1709123073377;
        Wed, 28 Feb 2024 04:24:33 -0800 (PST)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id m3-20020a62f203000000b006dde0724247sm7857587pfh.149.2024.02.28.04.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:24:32 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 2/5] dt-bindings: iio: light: adps9300: Add missing vdd-supply
Date: Wed, 28 Feb 2024 22:54:05 +1030
Message-Id: <20240228122408.18619-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
References: <20240228122408.18619-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All devices covered by the binding have a vdd supply.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v7 -> v8:
 - No change

v6 -> v7:
 - Changed the subject line of the commit
 - Updated commit message
 - Removed wrong patch dependency statement
 - Added tag
   https://lore.kernel.org/all/20240210170112.6528a3d4@jic23-huawei/
   https://lore.kernel.org/all/20240206-gambling-tricycle-510794e20ca8@spud/

v5 -> v6:
 - Separate commit for individual change as per below review:
   Link: https://lore.kernel.org/all/20240121153655.5f734180@jic23-huawei/
---
 .../devicetree/bindings/iio/light/avago,apds9300.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index c610780346e8..a328c8a1daef 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -25,6 +25,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+
 additionalProperties: false
 
 required:
@@ -42,6 +44,7 @@ examples:
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
             interrupts = <29 8>;
+            vdd-supply = <&regulator_3v3>;
         };
     };
 ...
-- 
2.34.1


