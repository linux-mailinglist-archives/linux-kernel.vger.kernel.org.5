Return-Path: <linux-kernel+bounces-73715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760685C7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0E6283AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D5151CEF;
	Tue, 20 Feb 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGNiCvBQ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229E76C9C;
	Tue, 20 Feb 2024 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463702; cv=none; b=BeqBPp8fzd/IpjbksITNsSLrMa/5r28K3aqv25YDpKdeutf0iJHuUMta7zHejI3TQVrhO2Rp/jZ0ds93TuiUNTHkDCPDWBffMnhtgOWh1oZ7SD2dfI27rhGWWWFEX3YD7gbW2CWJaKRD+A0kXjcbw2VbSCZyLvt2/WgbQ1s0WH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463702; c=relaxed/simple;
	bh=DiomlbMoz3C6LjGZH4FFhHtNHPdnMrqXUhRAwWtZwBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VrzDczts5h1hbsXVPWrFciHBT9ZVpAy/wW6CAuYIdhjFRJoqVg2GPuFgQLFvEwKqhtPik2rZgMjrV6HjaQYsS4knqLwbDfQLnYfaJVSp1skmQhK4jbRZHfQEN3d/sXYvC2R36XoLX4quOMfyfRMFzESUGIm4Uv0h6qh7j+dHJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGNiCvBQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d204e102a9so76536181fa.0;
        Tue, 20 Feb 2024 13:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708463698; x=1709068498; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pS4KxtoWOPzkzcC9M2HY0NXw+lpEMhNeKnYkJuLKH58=;
        b=fGNiCvBQDBsUcnZ059epNqcL7aa5K6+lVkZHexJQOEYFQu5u5A/SvN+6lpMunXZdqL
         hIlK7hAtviaUl/fH5vikMFxKjxvWbopHKQ9FD4w6mbrXnTvlhe6YQEhV1n4BwkONBoET
         9wwUJ0gkyxbzY4ombTpJDQjAC61QqbBwhLoNzrUt82Xv1G8b94SprRrEk6Woskrb4pp6
         Hvi6vKD7zgsgKIjG1KnwwttT4OSnskP88cDGC+a20K5ZAPNPfrWT7c3szY0CPPboMDb4
         8r/1W/NY5EKy8uWvTqtLYXf+M35mRSUBmWMrXJmUlhYH+R7xb/U27gFpu66Gd5ELTBib
         kfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708463698; x=1709068498;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS4KxtoWOPzkzcC9M2HY0NXw+lpEMhNeKnYkJuLKH58=;
        b=bMvdJ8HFFjQNwzfnK+xgt5jJpcm5EVUm26QOmrsc8E311s1nfy/ZsATTyaTUnbU5PX
         T3XC2pHnt8dpXGWgjcaJQfpRitVpHWnSSUWFB++aZpZQ2WfqeDhLE+OotcQbBGARQTiK
         tBEwLgy0yst1Jf15nsDrKegjce/XGPg70+JzWn5u9aE4vuiBL4EaO3rJaX2AZF29jk0y
         D3cJ4BWykYBp89z+N4Ss9ceDmjrT9BehNYpH98AS1rhvvAq3FlJbFOZHrMBARF1iv519
         JWGM5Pp8ep/G+IeO1gFA5fPithdwH9JS9WXb8d4rIm7HDSQAtAOEsBEd8KWHte6gyTHo
         E5UA==
X-Forwarded-Encrypted: i=1; AJvYcCU3TK2o9zcVYhKH40s4bBYTlc6+Ic/zKCipI00/Scc87UHL1utO/Ftew3XeZgzlA3MMGnev08pPjy2QuRY+uBRmqTnzbEc87IMFEQfadtQaRox90yu8dZxrtKNid9OOU82wiky/tpRlr690kTy1z9fkOnAdkRDOBYEEMis3Wrh8JHnvDw==
X-Gm-Message-State: AOJu0Yz+iXltK4swHaM+b9VwLWIZht8O+9cBGko8zdGhrHx2kiJcu+Nu
	8xc9iod58SaR9yvnWbTlmRq0Bll22USgHeeKKbKO1htrxEPQlvh8ST4up+yptSyNKw==
X-Google-Smtp-Source: AGHT+IGb22ufiQzQHvKZLn4xzUpaqi++TL9Us/DsUJOm5s9sgZTjNFEES/MLIlc4+RvFHred6PV/Mg==
X-Received: by 2002:a05:651c:548:b0:2d2:2cc0:34af with SMTP id q8-20020a05651c054800b002d22cc034afmr7769024ljp.32.1708463697742;
        Tue, 20 Feb 2024 13:14:57 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d60d-797f-077b-a805.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d60d:797f:77b:a805])
        by smtp.gmail.com with ESMTPSA id fj21-20020a0564022b9500b00564da28dfe2sm538137edb.19.2024.02.20.13.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:14:57 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] iio: humidity: hdc3020: add power and reset management
Date: Tue, 20 Feb 2024 22:14:54 +0100
Message-Id: <20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4W1WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Nz3YyUZGMDIwPdglxdQ3NzSwvjlFTj5MQkJaCGgqLUtMwKsGHRsbW
 1AHHE8C1cAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev-8b532
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708463696; l=2127;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=DiomlbMoz3C6LjGZH4FFhHtNHPdnMrqXUhRAwWtZwBo=;
 b=fX2JLYzSPtRMilwqfz8C/EUlHWnAQWsTo9Qa6XKBO43Pkgc63IfrUaTRhGiBp9iRySOqUv4Wc
 MhSXWfYGzhbA2+Npm3XiAgN5IvhUdS5vX5QC4lztif79c9T2BHSphnt
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series adds power management for the hdc3020 humidity and
temperature sensor as well as control over the reset signal the device
provides.

The hdc3020 carries out measurements automatically, which is not
necessary in low-power modes. Furthermore, if the low-power
configuration turns off the device, proper initialization is required to
account for the setup times and initial status register value.

This device provides an active low reset signal that must be handled if
connected. This signal can be used by the driver to keep the device
under minimal power consumption during low-power modes if the power
supply stays active.

This series requires the last additions to the driver to handle events
[1] as well as the fix to include the entries in the Makefile and
Kconfig files [2]. There is still no branch where everything is
included. Therefore, iio/testing has been used as basis and the fix has
been added to the series as it has been applied to iio/fixes-togreg to
make code testing and validation possible.

[1] https://lore.kernel.org/linux-iio/20240214085350.19382-1-dima.fedrau@gmail.com/
[2] https://lore.kernel.org/linux-iio/20240121135123.71506-1-jic23@kernel.org/

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (3):
      iio: humidity: hdc3020: add power management
      dt-bindings: iio: humidity: hdc3020: add reset-gpios
      iio: humidity: hdc3020: add reset management

Jonathan Cameron (1):
      iio: humidity: hdc3020: Add Makefile, Kconfig and MAINTAINERS entry

 .../bindings/iio/humidity/ti,hdc3020.yaml          |  5 ++
 MAINTAINERS                                        |  8 ++
 drivers/iio/humidity/Kconfig                       | 12 +++
 drivers/iio/humidity/Makefile                      |  1 +
 drivers/iio/humidity/hdc3020.c                     | 97 ++++++++++++++++++----
 5 files changed, 107 insertions(+), 16 deletions(-)
---
base-commit: 3cc5ebd3a2d6247aeba81873d6b040d5d87f7db1
change-id: 20240217-hdc3020-pm-177983de3cab

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


