Return-Path: <linux-kernel+bounces-56657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3948784CD45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C7EB23E0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099C7F7C3;
	Wed,  7 Feb 2024 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0y8W84DJ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AC7F7C8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317498; cv=none; b=rwbtTjLF6C0Yu43LBRmO0yXSbk1rCO58OxBP8aLrt8Jfb7t25+pvUFImo2O4fDfwvrVH/FT6AJgtMhAdsy3FFefS4stZY2oC475Mb20YhGAxkEw9FxISI3Hcnp3YuGB86HniALS+UuNshF7/kDsMQWYxadW9iHBhx9q5NtuHEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317498; c=relaxed/simple;
	bh=Rc68f1N6Iy8oorIc3UH9kaq70w1Q2Jws8w9qN0/Jgi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e3uRRKN2JoDwWTgVcgxTMsdol2ZvrITio1zdaB6wHuJkh5E/R4yadgpjwoBNtMYF79I2/EMe+ydXedCMy7G6j7c3Iv+ZyLBXRzlVSPKUTHAsIw/xRfIKKMoU1OjkSFqMWpqDdYMCKBhoXSLQDX6k4E0xVkNx2cvFAgikCljwn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0y8W84DJ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bfd3db19baso348641b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707317493; x=1707922293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/afwf2NkbgkZ1rkOTlzyALgxFNJdkSRgNQuxay44NQ=;
        b=0y8W84DJ+a3wORlmYQGTXycqt0fnBloKO8vXT2XHO+0oRksxIextcQcC78ELxOcojq
         Hz1KA2gnExx52WwJFuW3eVl1Ny8L3LdB1DkFOO5nnAygjiEvRXRBToYbQSLZYJk9EKqb
         YusPKa5oLYQejMlEo59t+E9U3XC9zU4ztNE1q/pYVfSB74rJC3Rs3+YoEy6QvOsnEBKT
         PaylF57HGt4iWrNlABeybNLSwuq+uDV02+AKAi3HuBUu2WdIMKO9cE62D0GyXIwsixUC
         4xBb1Pkg8kBWfcXc5qFxXmUTw9TBMf7ojTncEWFrxovYfqdESFhnA+QKXzXIPBEyHobb
         x42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317493; x=1707922293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/afwf2NkbgkZ1rkOTlzyALgxFNJdkSRgNQuxay44NQ=;
        b=jsTTMYq0glWzoV+2TeBctdzn681mEBP3LITYHsMg0XnLXBkiLwnyj4iF5MHlQZOJIY
         xcre9WUnEGgMAYSDdv1KA8tSvY5qYNGeqr7GBKhcLu6GxrtBK2oAhug0ZG1oh9bLZkh4
         f+vJl5/SdJwW1TV7qdHBl6nS8R9bi67n1iHENMyUIqnRjEHOI3GdVWqHjIEMS3wuZ/U9
         ni5cMr8iWZ810qCNxZvCx7dJw88wrFqCA7H0iVaDqFLsrpuyXFu75l3rQI6lYgckqdZ2
         msQWR54fqA4E2ZjGQ98Zr4nna0HY9vAxrzj3be2cEr/c/HrTyhlWheyZDXBfeTH4JVsJ
         Rbuw==
X-Gm-Message-State: AOJu0YxkJIYAXiPdWRlFhqss30uA18MkUcvYm1R6OZk/0lGVRJcG3xnC
	E/xjSisD5xz/ua+ll+MdfKxSVtzBHi7/tJPeZMTO0IgvFSF2ZymAJfhNyMhOwV0=
X-Google-Smtp-Source: AGHT+IEnBwn2pUL/ilCbbmzO3aC5GWyy4lJHanJ/joH7ZSSOIMMGSDJvsV6XOkzyBYTmrbpkIFAzGA==
X-Received: by 2002:a05:6808:6409:b0:3bf:d775:616e with SMTP id fg9-20020a056808640900b003bfd775616emr6948635oib.53.1707317493592;
        Wed, 07 Feb 2024 06:51:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbhg8D7YSXnNzCsq8Bs+gXmYdasDGqkdND/53ktKPsJ7KJjxx9bRrB7cpP2v2OgdmjLk6Mbm1ar5pOz9Gxhudmt/G/ylUU9RbF8wVc3FogmBMlJGo1fmyAzJhc4x+lBVPkgvDpE9x7pN3KBMG9DHKuzL1LJ3lzdBDn3XFDw+oiJXJ/GjutXIfqGrgKS+oxrpg7IQ==
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id k26-20020a05680808da00b003bfe05691f3sm205856oij.9.2024.02.07.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:51:33 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] spi: axi-spi-engine: performance improvements
Date: Wed,  7 Feb 2024 08:51:23 -0600
Message-ID: <20240207-axi-spi-engine-round-2-1-v2-0-40c0b4e85352@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

While researching potential performance improvements in the core SPI
code, we found a few low-hanging opportunities for improvements in the
AXI SPI engine driver.

---
Changes in v2:
- Remove include of linux/idr.h header.
- Picked up Nuno's review tags.
- Link to v1: https://lore.kernel.org/r/20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com

---
David Lechner (2):
      spi: axi-spi-engine: remove use of ida for sync id
      spi: axi-spi-engine: move msg finalization out of irq handler

 drivers/spi/spi-axi-spi-engine.c | 68 +++++++++++++---------------------------
 1 file changed, 21 insertions(+), 47 deletions(-)
---
base-commit: 80fa6a033ac8c395a3de4840e204638e92b8b371
change-id: 20240206-axi-spi-engine-round-2-1-bb73990abac3


