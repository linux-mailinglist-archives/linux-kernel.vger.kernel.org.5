Return-Path: <linux-kernel+bounces-43442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807968413EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082EDB258AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1747602C;
	Mon, 29 Jan 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NXfcgfDi"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECA76023
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558178; cv=none; b=Od4y6u0V9PtPfvmXgdUh+vcYEI5UD8ABJLLhMosuGrMJhdoc4DmYqTuBsTUpjsnhTWAyxxk5kd38MbJiY1zB4nIecC/ozfKGfwSyN1wnD14rp45F7SBcrJ0GoM3M0gGmuPAgaYO7tHhK6q3fNhrBc0bZSRpTWw1GR0vyz1HnGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558178; c=relaxed/simple;
	bh=WKnf9MfuM5XBqCZF7IHpqB7IouVtcWbHOl6JCQfOI6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpELV9JRfoQK2ZYrhC+gLGw1zTmBL2PTVpRG0TI4tyg2LjDZ8qBm20Xk5JyjrzGILEbtWNGqGYQo2hB6NvSpr4yuFypSW//jSbgFzNNw+vR+sqs4306yLhht4953I34ySiexB+5ttcsG+THTS/b9zDqNabSMYX8U0/eB4mBsVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NXfcgfDi; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-214410e969cso2218441fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706558175; x=1707162975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tm6MgMGMMZQzwZ0RmB4Y37DLBho3Fm2lfE4k1nbWfj8=;
        b=NXfcgfDiZmTjRSZXnDhE3F0D8Dh1EkkAQwsTvRvNCL5wWw98elbVklDL10mjE28RL7
         tL13npX1WDRYqMgfTwwrX3vewTMtmSQc5eK/9hFVE31alWtUT2cKTpTqciiRHWe419BG
         rHUkCjJ//sx3d5RyyM17DstpXww8brtydHqhhbDOUEEyuF1EJFqm1U5f2aYM1R0Ie99e
         8GUx/v/Gbt3n0GVeu8NPNpJ1iBYGS5/8TQ38rMsYGI30T5/dWsXfwXHwFMhT96GlkX05
         IiFcqp8P944Q0MnOePYotaK3LRPqKTxKsneSaVas7nraPtgxk0hJx5afATTlnAwXxSKh
         veag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558175; x=1707162975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tm6MgMGMMZQzwZ0RmB4Y37DLBho3Fm2lfE4k1nbWfj8=;
        b=jFxv7AlfKC3Y2ac+YrCQkvY5IZPBOQlxGG21DZHK9+Z3xXzU6Agqg0pufQDMrqPWRi
         +ev7Y2gC5xoBgU7O6Lw3O0380A4kXlGHHVwjLjoI4QbPGDyXnyAkh4lDW8Q5eb8nlXw/
         3TGkE46v5IbD0vGFQFASAsCPERmtu+XzXF4jgnKXNfRs+E22QalWNN6ONQ5PbKlNnONi
         QV8bvjbpS3SC5Q2/1Q+IfKeEHylDJb+U3Qj7dliPDxftu4ulvZdxuo+CRJje8Xrbt47w
         5noU+/I4lp0vuMZSCUmfplKQBc9FUlGqzdsW+jOpS+uUJPUXlco0PYe+tjaRFAxJXo1Z
         NRSw==
X-Gm-Message-State: AOJu0YxjR3cs6F2FwT3Vr1Hwi/oL1wS+Ff1BNxGF9qHElP1OwbehLLt3
	XK8QKKBADvfNtXhlZQCBceJuQmD16eNAiSjZ8Vrzjh/Z7j9y8B5ZxlZeTvAUTUs=
X-Google-Smtp-Source: AGHT+IF0qIjPSZ9RLIUuVCTXwstOjGJ8iZuVhLk2Tku7zAmemRe0HhJXEKR1MerpbsdS++z10NMGHA==
X-Received: by 2002:a05:6870:831f:b0:215:e6:8145 with SMTP id p31-20020a056870831f00b0021500e68145mr2235682oae.0.1706558174942;
        Mon, 29 Jan 2024 11:56:14 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id r11-20020a056830134b00b006e129d7b833sm641292otq.39.2024.01.29.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:56:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: adc: ad7380: fix sparse warnings
Date: Mon, 29 Jan 2024 13:56:06 -0600
Message-ID: <20240129195611.701611-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the sparse warnings reported in [1].

[1] https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/

v2 changes:
* fix typo in "iio: adc: ad7380: don't use bool in FIELD_PREP"

David Lechner (2):
  iio: adc: ad7380: make ad7380_regmap_config static
  iio: adc: ad7380: don't use bool in FIELD_PREP

 drivers/iio/adc/ad7380.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.43.0


