Return-Path: <linux-kernel+bounces-102491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A570787B2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B71528648B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF2251016;
	Wed, 13 Mar 2024 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oRLgsPtD"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96904E1DB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361704; cv=none; b=tAhV8fIt2kquQ8thassxMN1eY9eDwyCPoZAyMmUOlhobxVFqgWjN5rk5HplbIEefEdito5c/fudDtNMKS16K2Tu9ycjkaFO+qCKHutGjIhqkKyWCHrPfOS4JzhRwPivINE77DUJjUSKnn8lWFy8Z8tJrP0dZiy8fsSyEEjDq5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361704; c=relaxed/simple;
	bh=iMCRzKCwtOFIDF9hmdcyBiISQPSwyJVzWj1dCAmbdA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uEeOFSzPr/enbO+5JB1ZQMEQZ7F6QRyDaV+Ko4Go3pc8bK+gK525G+oTYRsfpsEEhIjbFrpLFkc1mXoZY0Tc1wYOAN6khFz8ZFGS3i8ljpdmnNQV1aRCJyIK3q/TaEeFyJjxn9w7wVueC0SkwwhXrf2+k1pswc7ScSf9wAFkUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oRLgsPtD; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c1e992f069so159379b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710361702; x=1710966502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAWRgWU6WLEXQVBoGzfJEbXOKTd+ZWBJGPDK+Tp7qSI=;
        b=oRLgsPtD1jgq5FFcuvFAyA9vruYinPqt5BIzo5MdfSVG4FqBlNzn+UBg6ucGg53hoD
         pv3uFOzuEbGxX5XjGEZpmKEfQAcwUsE3vFb86la4RwxKLu4rJPqP1NRcS9JaW80ax6CR
         1pCGb7pnf3uJdaL1UmMzF7eGFdbul8sWX0eYcNzjzB+JOTxzX27Fc1YdXZAIKonvDMSW
         2cqGUEAUvEFY82ECMRGmqWw9y5O0esewP4gf4c9OnhtbkK7CxgS1R7zKbZyCe0fM0DaN
         SIbhmV6Rgn22oxztjlRXyRNJUgrD74XHmKnG1eUyKpg2+zJJQlfEq2RNLHBeriW6Mgv0
         kqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710361702; x=1710966502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAWRgWU6WLEXQVBoGzfJEbXOKTd+ZWBJGPDK+Tp7qSI=;
        b=DHWRfy85I4X5bbdo2aSB9W1l81ckJdImB4nu4T5zyPNm15WRTGTabCX45ysvErg81B
         lhglPwp0XNWi+f6OK31Y+Z/KC9YU84gXvdcx5CFIrbVCHSiwBeGEyQRPPGzq5TJude+b
         ojpTJpmtLVe6VSs4l+DgoxM9lMQ/vp1UWcBusTma+8YWcVY/Q9yQxZxK0sX0umvx+MhL
         Td/eCkJDPedTOkFnDfT3FLHCEctkE417fxV3Hl8ga9OA8xw7NEPzHil1XiHnFlOk47I6
         BmH7U13jA7XNeoxP0qQ1YVgtAHm8WLMeDvbJxf+5M6+vX+e8EgBjG4nN9z12lPhB7wB6
         JyBw==
X-Forwarded-Encrypted: i=1; AJvYcCWx8717xE5Fjf0UMPLapJUBrwJjMw8b6E9ZM+ERS6hUcbTpl2Fake4TMBul4vgsOnHBBW3gG8Z5o8v2SCdQr8qOGYtdpbbWpJ3dYY+b
X-Gm-Message-State: AOJu0YyyLusnGwzMgttg5RzivcLIiptbHOAIii6jqkUZ+l/Dz9C4mTtz
	e8WjB+F+OOmEpWCZ7dI7/J9Qqtw5mgb2GDJscrHB6W+KKI+hkMhRhWrLUE41v1j8W+9+YKJxQGg
	4
X-Google-Smtp-Source: AGHT+IEOPc5OEL968XGI9Srb8DwBFMxD/2mugMqwuczh3UoC7IERpmKsonAhCJ+UnsiA3uICMUraLA==
X-Received: by 2002:a05:6808:ecd:b0:3c1:d184:98c9 with SMTP id q13-20020a0568080ecd00b003c1d18498c9mr964366oiv.13.1710361701855;
        Wed, 13 Mar 2024 13:28:21 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id s8-20020a9d58c8000000b006e4eaa4ba7esm21520oth.61.2024.03.13.13.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:28:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] docs: iio: new docs for ad7944 driver
Date: Wed, 13 Mar 2024 15:21:50 -0500
Message-ID: <20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Adding documentation for the recently applied ad7944 driver.

Note: this also covers the features added in [1] that hasn't been
applied yet.

[1]: https://lore.kernel.org/linux-iio/20240311-mainline-ad7944-3-wire-mode-v1-1-8e8199efa1f7@baylibre.com/

Also updating the MAINTAINERS file to catch iio documentation since this
seems to have been overlooked.

---
David Lechner (2):
      MAINTAINERS: add Documentation/iio/ to IIO subsystem
      docs: iio: new docs for ad7944 driver

 Documentation/iio/ad7944.rst | 227 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   2 +
 3 files changed, 230 insertions(+)
---
base-commit: bbafdb305d6b00934cc09a90ec1bb659d43e5171
change-id: 20240313-mainline-ad7944-doc-285b47ed6d35

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


