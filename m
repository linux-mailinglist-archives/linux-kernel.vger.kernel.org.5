Return-Path: <linux-kernel+bounces-75559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3432485EB26
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B68B26EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AF6126F11;
	Wed, 21 Feb 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhR/G7VP"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E86126F00
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551574; cv=none; b=RVo9wXXVYv1p/2rAJerwJI4hYhx0+OkaGR3fWJrNugROjUDRR6e5jUkN4p8nJEWo7uTpvubVp4FRJa1JKwNJbfpK+X2MXUVmkXuAZT401AjhiWs/fFxK9j9iHhEENdBbIrYoxbnydMjoMG9WLHsrTC28b9d5hLBzhbOd/UL/TMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551574; c=relaxed/simple;
	bh=jqYo7h2YXWcMs5AWREXDn7EWPpgSADQ3tsD4mbKIFfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYyr2AnmjYjFS9jmx6C+gfeOyWQ49vgEBrUOjxrXqv9PY7YhjIxC9NXD0dPLYcDtyiO3tEEHx4Eg5rcC7GKc+RrAOPsxEd60T551FWyJn8Yv6eNraRgC+Nq0kFkcF+g/g11RK0Vyd9fTJQLeIvLAWTUKo+ffM0snJ7OmjY7c8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhR/G7VP; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c15b7b36bbso448842b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551572; x=1709156372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5MCkEryFiRa1ysNZ3z0nVCsM2akZXoTubQv06eoNko=;
        b=RhR/G7VPRa2j8yBu2VEWkVGL2Z+7HeHpLpJ60+Ar/w1l+le1dBmH3P7Q8wBATa6q/M
         2yD/V2uwtWA6hnXuUGrhEBi/VRCr27BSyazhgC8hvVP0xVY1gpZC1PH7J1DC4HrLM5Va
         6zodn1ElA2szYc/X6w4gsCU6hS7+G/1y1SBiuDCTc1Q8ttm06ERqkXO1YWUDWhneNqC3
         3MuxtbJaF5jgtd3uQQLcLHROBiCfzciI/2cNk01l9C7J2lj216Q8GVUtZRWWsNEVwzby
         lRBayXUNMHtnPw+VMMya08z5HApyAkBbCvONR6xJAdWCjkhD7kTcyOlE/ONDrbaKRhzB
         6vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551572; x=1709156372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5MCkEryFiRa1ysNZ3z0nVCsM2akZXoTubQv06eoNko=;
        b=f+2Shvl9GIzEna+RJVmFdvBJzs6bEniVdEJzzYCjkTOfROMWivI3H0fCeuqePWauob
         NaBKoj5T7xxY9QHrfNAAjdRi3lBiqMHbnYk1bi/Ww8HyLyIyN85FDA9Sqr6j/JbIW8Qx
         CSl4gFKT1NQ+E+VxbFZyIjfeOrCXW0CZTB+Paa6XB+mxDo2sFtkE5QDoyNv0s+lNg/5i
         Gjb1hsqEk6JiDRQ+lCqUhxobO2uJ8C3ucy5+DdX6F9kg8mgC5nDe9Ntc3me47xwCc4DE
         pfAgTjuw4WknS2geOBGSCrS1XtTMBc1ofiFF0LU99z1gOfn+QhIzObf1IQaXW5mUbBoc
         m8LA==
X-Forwarded-Encrypted: i=1; AJvYcCUPXwBjA8CcvNqktFeCmC1HwIjUtd4pkMJkjasb37ZjmVmKOhGGfpZ69p95UBYCp971segBqgPrZgiYPi8HsoBV05vbaROZGAIv8jUD
X-Gm-Message-State: AOJu0YxkP5jOGmsNvtdppTYgIiCUCrbt/TxPk1NVwBDvswpNveij0EnA
	FGoIXx5hBmp7GhOgTUnTE1TPEcRttli2krrDxMj0ut4+C+xbL7sE3wJthsCZgQ==
X-Google-Smtp-Source: AGHT+IEke1iPYKpZ3QSx5txoAmT+uWXJLLZvmFp3MPBAgWHg4JAZsS7w271x8WQKocYGCSxPXTr1Fw==
X-Received: by 2002:a05:6808:30a9:b0:3c1:6036:8026 with SMTP id bl41-20020a05680830a900b003c160368026mr10133237oib.8.1708551572568;
        Wed, 21 Feb 2024 13:39:32 -0800 (PST)
Received: from FreeCalypso.domain_not_set.invalid ([2806:106e:19:4bb8:77c:948e:6b1f:1907])
        by smtp.gmail.com with ESMTPSA id j17-20020aca1711000000b003c0b874ef8fsm1666773oii.32.2024.02.21.13.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:39:32 -0800 (PST)
From: Alfredo Cruz <alfredo.carlon@gmail.com>
To: linux@armlinux.org.uk,
	arnd@arndb.de,
	u.kleine-koenig@pengutronix.de,
	shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alfredo Cruz <alfredo.carlon@gmail.com>
Subject: [PATCH] ARM: sa1111: fix put_device() before device_add() in error path
Date: Wed, 21 Feb 2024 22:38:37 +0100
Message-ID: <20240221213837.27605-1-alfredo.carlon@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When request_resource() fails, a jump is made to err_resource label which
calls put_device() on &dev->res without adding it first.
Kept the err_resource label and moved put_device() to err_add label.

Signed-off-by: Alfredo Cruz <alfredo.carlon@gmail.com>
---
 arch/arm/common/sa1111.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 1fbd7363cf11..76bf15da5115 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -779,8 +779,8 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 
  err_add:
 	release_resource(&dev->res);
- err_resource:
 	put_device(&dev->dev);
+ err_resource:
  err_alloc:
 	return ret;
 }
-- 
2.43.2


