Return-Path: <linux-kernel+bounces-156548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5038B0461
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E5AB23A46
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166EF158A17;
	Wed, 24 Apr 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zOzFc02S"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4A15887D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947561; cv=none; b=I1QpGRk+Tj5stjMUiXeSarNPlhdj/45qTchsNGJyIppq8L1UEkISTwxWn537Y2ReI90emZ+V3dkNiabskTJNOjoVTK29DTLg9XIATGsOJkzwGRd2QkAABgvr/3ozOkXcNGyqGk4AjvpIGZk/Ed2zbzPVDcTfOByUNCcliUVTlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947561; c=relaxed/simple;
	bh=Nd1bgTVjgi9p7vv+1Y4Uuyn8I8FqAUXdlNCoV8Y46J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMfaco6r3kZ8SEn0/Rr48w92zDpd/nYa5TtQ76LYWY6DOqbUxErjY2W9/dlsd17kD9mVHKjeo/Vm049Qb7a4okJ6TCh6Zx678bdhs9X1yTOk2ZTHeGBgdhrUxfbJj25q2UgRAQNv1kMOBgQ82lNzxWAKJ9QLI0Z99H5IcYaccwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zOzFc02S; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343f62d8124so5345711f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713947558; x=1714552358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLHS3+ZUjTJNffXycRi6d4Rz3IVVM3HVGPOh5lwyW50=;
        b=zOzFc02S0vp6M2XYz3m0D/dWhT/VPPzt60LKfuEg4/L4ak9egHzbHfcVjpW7NmYuTU
         qk/tRamRHnAYHnz+3+4GvqZXFtCrvGaY+1IJ7sz7uyG9KHhOW4B+HD7HdmMfr+/k+SGI
         pUkMyH7gSAmBemSbGsMwTnBaBFdIhu+y5JuUxc3eW+mdWQYBaD9Lup5F1qIWvKXxT6oI
         MbgBe5EYJAMJF3MWtHQtB81aGaIeKDrYdGlf5WrKl7PxWqSHVd5i11BsCql5zCAlNC4D
         3WE7AlYKpuLHI+xG8iKBcPpSIpA60BwUGhYJ771BCxc6VsrhgeaNAirNW7dVE8tlWfo+
         gIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713947558; x=1714552358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLHS3+ZUjTJNffXycRi6d4Rz3IVVM3HVGPOh5lwyW50=;
        b=b+HYIKw7PQaeuSpJZhdgraiogmokuIQiSgsNXNHOSOUUrHsHyfD4Jw47EoXs5QWm40
         Fpvrn2Sn2O8BM/DnSr7DzWIUbfttxNJT1H3/UjnVHYYEazGFyrKkTHSh2joE1PYfvS7i
         P4R9tx2K4E59TpiRrHvBS0qNUwJmSwUUdY/T6tjqTyWVAzbzfiC+ifxr6y7M3TzS+tSN
         f6HLMO7w5ZhaAPGQ0lZov8aKduA/wm1dFlhe4rosK2gLbmYBy3sbVguT8dBqKCeE8raT
         11EJRHcpiUIE9Pz5Z4pgz84IGKIylOnt6YyY2/VzZf7ANEAPgC6UWoeQsUwY7B1hIGZG
         1A5A==
X-Forwarded-Encrypted: i=1; AJvYcCXY1x+kLo6TrbeyPk1biwI6fkTNA2BFk+AxS3Zsrno+CQ2WSBGa2oOKCwoAOAJWe2+QjhQVJfIisWYVbwOPgBj3ms9ePEKz2XueZQeG
X-Gm-Message-State: AOJu0YwCQaIK4AGc1jQP86oUYxFgEbDmUHGpQ+7hnu5zTlEGtqno205t
	iD/W+POAvO/Sasg1NPuudBAb0GJki/O0p5RGjXMI05jwRHT3ozqFIz661dMKcS0=
X-Google-Smtp-Source: AGHT+IGArv/PKwCNVRfSNQIOq0HP3+i5+0+jmKEk0nq7jsWXUI28avbMiVTgMVQl6vbdh5wAA+aAEg==
X-Received: by 2002:adf:e28f:0:b0:34a:ce8b:7b79 with SMTP id v15-20020adfe28f000000b0034ace8b7b79mr1189245wri.1.1713947558289;
        Wed, 24 Apr 2024 01:32:38 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:da66:dc78:acc5:bb9c])
        by smtp.gmail.com with ESMTPSA id u9-20020adfb209000000b0034330c9eccasm16739469wra.79.2024.04.24.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 01:32:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v2] gpio: brcmstb: Use dynamic GPIO base numbers
Date: Wed, 24 Apr 2024 10:32:35 +0200
Message-Id: <171394754631.73221.157701463636057136.b4-ty@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423184605.2094376-1-opendmb@gmail.com>
References: <20240423184605.2094376-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 23 Apr 2024 11:46:05 -0700, Doug Berger wrote:
> Forcing a gpiochip to have a fixed base number now leads to a warning
> message. Remove the need to do so by using the offset value of the
> gpiochip.
> 
> 

Applied, thanks!

[1/1] gpio: brcmstb: Use dynamic GPIO base numbers
      commit: ec37529e544c59bb8ba35fd950c7bec28e5d54ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

