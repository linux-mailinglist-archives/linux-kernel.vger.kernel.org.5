Return-Path: <linux-kernel+bounces-103782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD9387C46B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57A0281B80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0476400;
	Thu, 14 Mar 2024 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rDOYjRtu"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF30763E8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449247; cv=none; b=VRwktrg5EqxDGZyvj/i6xqiWJkqIR3wgyHwZFQ1HehQmF8S1GFSFxgr3zwtJJ+hhSZSs9nK0M5B0IQtt0VkbetSJIknHBfamviT0GQsngTWGAlmVZiANkUGNPfmNiKz0v7XAla3TRk/zf21sFNozjrXr2PGUQUFexYx34hnmcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449247; c=relaxed/simple;
	bh=du2WT+/IhUMepIGZbpvZTbMkHPvk1mSEq7tDbAeTApc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LuonG1b2JJPl8DLvdQIi+3b20A+bZaQf1wnyoh+cDu9trto1vXUX4UKqbZiLnUobQG/BtGrLXpx+VQHzyEh6C6EClrXlffgvWrZ1UvlcjotwhQTbNdYo4cYEgZFe7zPTMwkLy9yzEFmdP6GBUMqtVRX00rpLFX3hYdNwERotmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rDOYjRtu; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430a0d6c876so4883421cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710449244; x=1711054044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EerKNIlRapC7GXPSamOoOowoFZGKR33EHS6GaKW+Uh8=;
        b=rDOYjRtu2HmbUl4wLBzA5VoTOA36Y7b7QNRPp5Cy5B64Bri9SRmJLwsP6uAtt757W8
         OWwYMMNO8wsp3Iv7UTvU8FYKsjcQ/MkHxuNBQJ9gr4HUiTDzw2O+GeUBFJEubxB0gUZz
         LYVx1f09JYnT1GyIz9pHCxUsPPkHR448rYFRV7lpdKfElbWgSi+uao+6YvRSKdnTiH+X
         nxJjtVovtD+3BUxwUxbg/kZgS52HQArw0gM9EwITChdlJkaxTP91kz5rtLcOr19hLzye
         B/CP1lIlC3pb3gRr3OEF5XlN5NMvmLq3bwmr44q5EYgMBAY2F7v1LiLQLNuuu0xSaRhC
         w6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449244; x=1711054044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EerKNIlRapC7GXPSamOoOowoFZGKR33EHS6GaKW+Uh8=;
        b=klmAXqyI+v8rt4DAMJwvpnGKjQAXGIo+PpA7qDj5YeAgoMFrrig5DBFgFlL3fH4gXk
         KG/FJoWK49X8wgJxNJqW3UMF2ZBVRTtoAbn1DjK3sXwSl3DiJUlDwWltdz9RJb+XMzg6
         Xot56xT2b6Mpo3vvGHs4DDAVDUcN3uSjokPY6LkLQkTNiTHaa4R+byS+l3imsHWkX8kR
         1QyGXsHaZOCwhL9k/KGccgrNrYWhZh57hAFQZ+onJJRLCzZoV96h4jXq1IdWvBf9xSGk
         UGIDe1JaZ5YsNZ+e5BtuW6FUcHVyBlGsHftaqopyJJAWl+rFV/iiv7igJeyxZI9aNqbf
         ln/w==
X-Gm-Message-State: AOJu0YwlbKQS6VTgEbbWGzTyYOJ/igXB1uxfM1L0bXtQzOoEDNS2jvC0
	qf/gwCnFPEsPNvyUcR8fKmU/N9SNy4C4YzY0ZxszBzbtfZdSRO0eNAepmniae0w=
X-Google-Smtp-Source: AGHT+IGl2GL5Qyuks42rePlMkrmMzfUZYkVbUfiyA5FKYet4juESL0lsdZbw/hVxxOgZbGAjHXjPOw==
X-Received: by 2002:a05:622a:5488:b0:42e:b90c:cffb with SMTP id ep8-20020a05622a548800b0042eb90ccffbmr3186362qtb.51.1710449244321;
        Thu, 14 Mar 2024 13:47:24 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id n16-20020ac86750000000b0042eef160b4dsm1165272qtp.76.2024.03.14.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:47:24 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 0/2] pwm: axi-pwmgen: Add support for v2 IP
Date: Thu, 14 Mar 2024 16:47:20 -0400
Message-ID: <20240314204722.1291993-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for v2 of axi-pwmgen, which allows for up to 16 PWM
channels (instead of 4). The series was tested on actual hardware using
a Zedboard. An oscilloscope was used to validate that the generated PWM
signals matched the requested ones.

This series depends on [1] that hasn't been picked up yet.

[1]: https://lore.kernel.org/linux-pwm/20240301173343.1086332-1-tgamblin@baylibre.com/

Trevor Gamblin (2):
  dt-bindings: pwm: adi,axi-pwmgen: Add compatible for v2 IP
  pwm: axi-pwmgen: support version 2.00.a

 .../bindings/pwm/adi,axi-pwmgen.yaml          |  6 +-
 drivers/pwm/pwm-axi-pwmgen.c                  | 62 +++++++++++++++----
 2 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.44.0


