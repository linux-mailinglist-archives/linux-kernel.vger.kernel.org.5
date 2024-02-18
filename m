Return-Path: <linux-kernel+bounces-70490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C64859890
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402AD1C20831
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495F5EE6B;
	Sun, 18 Feb 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVvpPZWc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC721E57E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708281053; cv=none; b=jON9/fXUyDfTnoqbno9oBeexpM1WInosf4WoeqG1RiZzSzy/D1fStCgug6wqSXBl9cR2J9zCl0MEyIOelr29ycT18M1/QJSrUDbia/tuf3SMP1N0yX2YoQLgmIy0T8sU8ks04vqagWP5TDa2/RxZp7FR4gcL6v08Q2WSt4vFaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708281053; c=relaxed/simple;
	bh=FCZ5Z+doCgbKmdH968w5rToklrffFSqNnKk6PSCx9jY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cfwmKFfhWG4kr9jnBZjACoA35sGGd9n2Itz55J2g6CwYtH4MqhxmvBPtcfzd3nNhBowFJCxPmKNmwBg8cQzIJqygxQyuP+S4bW+BZTSsH4MwTkMSdI1mckNlq1b9QgJXNepC2MGgOf0ro+XZ2JH3JBNbaIvk5JLxGEyzzlPItc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LVvpPZWc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso16663645e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708281050; x=1708885850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7FCgCwlRfN6Rmb7d2KV2HK+f4QpGUL2vs+0cArZ3fk=;
        b=LVvpPZWciAeN8vrpKpI+DViwIffyywBkE3k+AFuBTSfK8ZxF7JhOMMjHtaqmvGwMKL
         nTqJKr3llCK2CJQhkTbIVYDqn8+fCfuzrItVJrsGieM9sDYOKrebFGd4TCu82GTyIsVZ
         Q+zcZJ7jIyUAxrSWmNPx7IeRC5BhYD3budhidFA/A1LlWfnLJ8DVFI4xVzIFyiuzDEW5
         hx3rX3gK6EJ2qBlz3Uo+sADOUV6TlKXPXo6SUcAWIwJeKGSP5jgv+Lvo1IBQwvpCn/uz
         9Kj/jCyd9ZfcdK2IQCAy+iUupxe3jtfU1U4aKrozYNbumjnT2yl7Ncy1aTglzBVJTh4l
         1gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708281050; x=1708885850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7FCgCwlRfN6Rmb7d2KV2HK+f4QpGUL2vs+0cArZ3fk=;
        b=TcBKALDKnO7avJK41ldc7MpcIaSCmn8K+UOjKVfDAJbTJlwaD16Ze9JVWXL2+R1qN5
         r9VBTQSUO7tX9QoKZz36WImjvPGH0kNwUqA/8od+hSiL4q+HUgD1RZOqJ/qvv/PqL+x1
         KfWqlPoqWmkue2J2yQDsZc9w2IRP0Rg+sobS4tbrvH04ffJ5SCTGfYPx8tIR7JApbd03
         rhz2o+FqaoawFH97jwykyhxCQ7fC4FK7gw/Xrs1Wq/76yeOIfdUnIzp9YanqG8mQVDHQ
         s9rh7Z+NFVtRG+9NjE2Tq4uwzTvcxvay+5E87nbGKhUsDveAdelZYPSzknaa0zPwDqKb
         uHuA==
X-Forwarded-Encrypted: i=1; AJvYcCUgE/8t7h2RR5PbwuZltMrRT0EJpoINVWfXoz9Hys76mfRZFoNB7hborhW3/mL2smFMLJqi5bBc7sIoxjclYwpF4yrhfJZPcHjw6cyd
X-Gm-Message-State: AOJu0Yw2K82D/MdYNI4vkIjADT8TRtWsVfX4KWU2vKdy3RaAiZmTEE+M
	bMOrp/lkrDSnz/WcZ8IXuG+lRCqNUegJ4EXiWw3HotByzbB7Ui6zKn9/NIyXosaadumd96koe/x
	+Glk=
X-Google-Smtp-Source: AGHT+IE2yxBKnqBhnzWTpjKIap5XJovO94zJgJH4oFVjKVM6qkHqdtJLguzXgSdCvSg2WcSKN7H2wA==
X-Received: by 2002:adf:f187:0:b0:33d:82a:14af with SMTP id h7-20020adff187000000b0033d082a14afmr6003543wro.64.1708281050256;
        Sun, 18 Feb 2024 10:30:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c4f0500b0041253692606sm7111845wmq.17.2024.02.18.10.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 10:30:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.9
Date: Sun, 18 Feb 2024 19:30:46 +0100
Message-Id: <20240218183046.32721-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.9

for you to fetch changes up to 2f542c937c48c2bd5a8ddf180b417fbe7152559f:

  dt-bindings: memory-controllers: narrow regex for unit address to hex numbers (2024-01-25 12:04:09 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.9

1. TI EMIF: Simplify handling CONFIG_DEBUG_FS, CONFIG_OF and
   platform_driver_probe().
2. Narrow regex in Nvidia Tegra20 EMC binding.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      dt-bindings: memory-controllers: narrow regex for unit address to hex numbers

Uwe Kleine-König (3):
      memory: emif: Simplify code handling CONFIG_DEBUG_FS
      memory: emif: Simplify code handling CONFIG_OF
      memory: emif: Drop usage of platform_driver_probe()

 .../memory-controllers/nvidia,tegra20-emc.yaml     |  2 +-
 drivers/memory/emif.c                              | 65 ++++++++--------------
 2 files changed, 25 insertions(+), 42 deletions(-)

