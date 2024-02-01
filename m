Return-Path: <linux-kernel+bounces-47629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C4845076
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2891C26EA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587653B190;
	Thu,  1 Feb 2024 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtSY0Pj/"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCFF3CF52
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762807; cv=none; b=RESyq6LlH+dudOJ2kcyHyHJdM7W0Xj7Lc8OaWBoLVS49e/79WNMmFwzc/tatFDKW+5qakwhryNF/GzV53UIhCTia7BrW7h5YRedVqeWFiKvQIu+/HT0ckaB7O3Yw+mc02Ma6ClcK/2hiVyvC7FajdV5tkFMJc6COdQr4r+YeqTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762807; c=relaxed/simple;
	bh=4VGGGcaYk35HxXgdSmdu935kGFSoAd32AIvMtmVqZPQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=MGZADbCS1bW7K5jBbwQ46siHlfCcA0NAOFofRWBm0MoFKmg6yDv6UDsxT25eRUvg+YmyFK7H7prrFuvsJz5zVNcVBAbsvcPwX+V3/qpYlmqSqh5Ikufd2lx9yc65MOZLv87ZhWkV9sxjcleF5+Im+TNRL6vUGy9g1nW9BgWGipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtSY0Pj/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aahila.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8c924c8bbso589575a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706762805; x=1707367605; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uYSo7dLHiN39LMct+TvOkaek+OHlhRLiZBJ+JHrrHE0=;
        b=MtSY0Pj/cyrsCH8V6NyW1kLO7ySRKjHc0+PYyqlrfa3mmN4mkUPx8Gsn9OutO007t+
         Rmxg1nesn9bkf5/O2Zn8/gWqYKmqel1mWZvD/Xn5iNeHtAz2bD5TicAYAXBXMKpYrnyg
         z1IEcHUH5hvlCv0c/W7en6F8ktGwJAjpqaNZQMbhz7cxDLI1L58+boETjp76buNcqoNN
         dwd2+0y1ya7F6UQHncWBpY0P4csOZmCHzRlGWdD9Anno/YCi8rNzM9AjvShzVIFZH5dz
         4LVlljbCzZPQj2zC5ypFH4FqjKkmW+x7G2vEj9OPllsxAHkQTbdqX2bNNf4L7BMUEk7q
         aIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706762805; x=1707367605;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYSo7dLHiN39LMct+TvOkaek+OHlhRLiZBJ+JHrrHE0=;
        b=taUeyTV7DUsjIKxOtVHvwZBGHLFX6xuMUwANzkIn2LAEfk2VSIcKm5K9eftJdKLN5m
         +EBgxdIWkMqFtRln4ODHOvvx34i5SHtTVyPjivNVnBuCoH7WjMRbCgLIJKTCr71amoWi
         dhOAR0WRxmAxOz4aTBOUbORZx5woNKdi+hjQUoRTjM1y7rpCZcue7z9jV9IYY3b1MyiC
         Y9Vq4zQGBRoPgZPE57spD8XmqmsbvZY+99AZrFCupJ/T0+llbW3w215XLceZSMeSnvzR
         Z0REIEbQuvtfYRpISlSjFUKDbQ+uKrVNNjK+VbzfuhB3/eq8zEXuqzOwYXqWAGAChza1
         TD0w==
X-Gm-Message-State: AOJu0Yzm8fPqdGTyreJIDXIIdB1CqqfxJRKuSUvE1dj42l6+zaekqC+a
	2gLoTinrO9Etmqs6r6Wf9sF43dm202VY0arTh6QfhxI6veYRk/9AGlzPsbEOo+FUsiy6GRHugI+
	yWg==
X-Google-Smtp-Source: AGHT+IH1mpGNqqs+VrlIIPUSdBXJXXj54xNBJG7viPKa5/ZRAaOUdYVX8hyYK8Eb2TKfEfxpyqG2TrgIDQI=
X-Received: from aahila.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2f3])
 (user=aahila job=sendgmr) by 2002:a65:6115:0:b0:5d4:e18a:1e5 with SMTP id
 z21-20020a656115000000b005d4e18a01e5mr88518pgu.5.1706762805440; Wed, 31 Jan
 2024 20:46:45 -0800 (PST)
Date: Thu,  1 Feb 2024 04:46:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201044623.374389-1-aahila@google.com>
Subject: [PATCH 1/2] dt-bindings: i2c: designware: allow fine tuning tuning
 waveform from device tree
From: Aahil Awatramani <aahila@google.com>
To: Aahil Awatramani <aahila@google.com>, David Dillow <dillow@google.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The Synopsys i2c driver allows a user to override the parameters
controlling the waveform using ACPI; this is useful for fine tuning when
needed to make spec compliance. Extend this support to the device tree to
allow non-ACPI platforms the same capabilities.

Signed-off-by: Aahil Awatramani <aahila@google.com>
---
 Documentation/devicetree/bindings/i2c/i2c.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index fc3dd7ec0445..3c33c36571f9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -45,6 +45,24 @@ wants to support one of the below features, it should adapt these bindings.
 	Number of nanoseconds the SCL signal takes to rise; t(r) in the I2C
 	specification.
 
+- i2c-scl-ss-hcnt
+	HCNT value for standard speed mode in I2C Controller.
+
+- i2c-scl-ss-lcnt
+	LCNT value for standard speed mode in I2C Controller.
+
+- i2c-scl-fs-hcnt
+	HCNT value for fast speed mode in I2C Controller.
+
+- i2c-scl-fs-lcnt
+	LCNT value for fast speed mode in I2C Controller.
+
+- i2c-scl-hs-hcnt
+	HCNT value for high speed mode in I2C Controller.
+
+- i2c-scl-hs-lcnt
+	LCNT value for high speed mode in I2C Controller.
+
 - i2c-sda-falling-time-ns
 	Number of nanoseconds the SDA signal takes to fall; t(f) in the I2C
 	specification.
-- 
2.43.0.429.g432eaa2c6b-goog


