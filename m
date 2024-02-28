Return-Path: <linux-kernel+bounces-85096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4B386B063
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941251C2299B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949D714C5B6;
	Wed, 28 Feb 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVFKWhz5"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A39B73508;
	Wed, 28 Feb 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127171; cv=none; b=Pk86fr8XCnZ4tmgsQXXv090DH7KAaeAdpGXOTTwu0LCkEzsQwxNLbqmHFuqcamhAtTqwUJlRRMJNMCagK33hzlDXQgxsFxKHef9dCfy8DQSsR1tHzT5ktenwDRtnz14rI3jRilGSWeP1yswU7UnJcR6s4ovApDoFuceroBn+MJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127171; c=relaxed/simple;
	bh=Lby5HVffdFeSTS3gB0WIyrCXbyHZBM8gbK0CvSpYeWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=myBxf4aI/35elz+s/shdw0cDP4aymybRFYfLn4cjvOgLFpZStHnG8B8GL9oK6k5059pCsAr1DchICeEoKxnybkiwr/FK15hb1F8E9kxgZo1KCubLkv/bYdVcVrdQxAeHdns5zSpLdBbz/PjcYB8OIx5x4atduk3f9bnHsYJYaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVFKWhz5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e706f50beso692900666b.0;
        Wed, 28 Feb 2024 05:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709127168; x=1709731968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGffkzKw9aWjyaI9NbO+R8+MY5GFHI3Uh82PpzNp7MM=;
        b=LVFKWhz5RuGHRXZbmhnKmS/oJ3YlHR6a4RjqZBpBiNZ1V1xhlZm8WUcEipdKsvli91
         B0KQ0Yw4GjUS2bvvHAhnfj+ODCe46jR8+IboHFXrDsA93A9PH80OugO0mTerbL2CzEEU
         2TyuCzPKjoWc9cZLwyUGpTMTIpUMT6k4SFVx3WKUo1scBu1PQoqavgbd7zBWmLuhwGsO
         KqYPncYCX5y6GNQnTQscNCF+yn3TXaaNkZKyzbMDeBch3lv5NjLRuETWTWkIym6FIJmu
         pXuLrt3FLfOaqUWjyUF+/FT0lPBDORnN9MOuL7fQ6luFTXmIF7uqYzMU8wlSRZu+XYrb
         kJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709127168; x=1709731968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGffkzKw9aWjyaI9NbO+R8+MY5GFHI3Uh82PpzNp7MM=;
        b=RMyjAtV3TVm35Onok7fSbr3pd44aX8URYlUVH1zAljitMrqlPt6H1RcPvw8rJAP7Ez
         PHHxCLtkMNKKqagGn3Q9yTdYl0WdrLMoa0dRcs02ApK/sikF0zEfz8X3Ra3yeUJkg843
         6Q1kmCE+ZadZWTgL5GIwC+SQ9bvv4r3l9DLHTYHaXLfzKdnrvcLYFYOFnPPpgCOdxWRK
         J8DFKa7TJbRgVEh8FgflOuYLg9WJJ+pU2jB5ne44r9SUa9g3PR9e8lx4EkzATniT+d8b
         /I0G8i6ysjFvjiefv5UR0CuRJtoeCLg7jY1kFDEOilr/lM7s6XtsZmky6rtrg8Wq0jZf
         k9vA==
X-Forwarded-Encrypted: i=1; AJvYcCX/PW9n0Y9UPgXv41a/HqlfXFtnGYfZFt95AsoQuVB+81hK5baHeY7uWmRAXBfGNPX9YfKPUo7BeF6mLsRcXdMPalJb3WVO/IDfDG0XJK/koq69a30D1YwMuIAQIA/dwRYpHD/iJy+q
X-Gm-Message-State: AOJu0YyMDwtqrdMFO7jN9ptqP3suGaPoz/3wyPk4aON6v2rnM5aG6K0+
	2eBoLj7Wpw0QbNs7/dgmHaq7PHM0UKt+/N44m4Ead/FqTmk057Zg
X-Google-Smtp-Source: AGHT+IGPOSENBkXJ6r3twcDCRGjLZbrarMIbvH/bzYAeDf7C/m2WcywcK/hzqgY+P81KEUTFBhToqQ==
X-Received: by 2002:a17:906:191a:b0:a43:fac5:8e87 with SMTP id a26-20020a170906191a00b00a43fac58e87mr1250562eje.65.1709127168409;
        Wed, 28 Feb 2024 05:32:48 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id vx5-20020a170907a78500b00a3f20a8d2f6sm1856952ejc.112.2024.02.28.05.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:32:47 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 0/3] pwm: add support for NXPs high-side switch MC33XS2410
Date: Wed, 28 Feb 2024 14:32:32 +0100
Message-Id: <20240228133236.748225-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MC33XS2410 is a four channel high-side switch. Featuring advanced
monitoring and control function, the device is operational from 3.0 V to
60 V. The device is controlled by SPI port for configuration.

Dimitri Fedrau (3):
  dt-bindings: pwm: add support for MC33XS2410
  pwm: add support for NXPs high-side switch MC33XS2410
  pwm: mc33xs2410: add support for direct inputs

 .../bindings/pwm/nxp,mc33xs2410.yaml          | 105 +++++
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-mc33xs2410.c                  | 418 ++++++++++++++++++
 4 files changed, 536 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.yaml
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c

-- 
2.39.2


