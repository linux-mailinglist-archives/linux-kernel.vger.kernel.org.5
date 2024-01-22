Return-Path: <linux-kernel+bounces-33041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD4D8363C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D57BB2E984
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685A63C07B;
	Mon, 22 Jan 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="csP6n6mx"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD821E878
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927373; cv=none; b=KrnVQ/UjqtoXumzy6yMQRhIA9poNWYC/rTAKAjoy1fOMZ8J4lhhGHfOetgY1SvXlZI3Zx9ZEOA9o8RFZUETtE/sKHUDZHr+CZ81S191tVwGkO+T0hpY5KbZm6ABWNU7U/v9xmlv5QdINOe191vl6yI2V11bGkGQYfGyCIwnCLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927373; c=relaxed/simple;
	bh=ZUJ6olUXWWZ9Xy97W60pYPfaVOPqG4dEd3O1vRP4xD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XcuNsIo7adyLa3j6euLvVTHuafK3oKGp8QryOayynq2Lej/WLlmGcpSovH0QPnIauIZp91jhjydpG8XBPXS1IjcFZO77MEBHJz1fnxDbE1zebXGRiJAPMMmFV2wBBO5DwOoJ7FT3v8gFWZzlWeakMZO8lJLww9/KDNhm4E4U7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=csP6n6mx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e8801221cso31189785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705927370; x=1706532170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ec2WfNOEjcsCbOswwjDp1QQ5YtAmQvipz9vLTu+Chd8=;
        b=csP6n6mxRaDdIExqjEA80VWzkAvvJXdP7fgO1ZVrOHGeN+1+YiDgKTY7jK8jr8d4Mk
         OLAUt/MdxrdGp4uMXLsJy+E42jBHoGLCLOuXEzbRgQm60eNlAXA2GLiuybxBdFP9hjVS
         PkYLxtPeKjlMfpAGLJOsTSerPJ7WbyjZUAEepIDcptrnk7WD+Ute9cZRYQCktthhxZWQ
         a5Ht5pzMSc3Uy2IR4Y1DhNSZL6vu0unXcko8z6/wcg/BsvXdlYllHpCnyv5L0aQCXGbA
         kcACKqXtzrQZSWZ4NWQbnHFHm6pUNL5MDTp/iZJ3WAsJ9+byQFevsWzu/AMFIomry/2H
         25oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927370; x=1706532170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ec2WfNOEjcsCbOswwjDp1QQ5YtAmQvipz9vLTu+Chd8=;
        b=qN9MUZizvewDlLimf/Vps8Cmt41xTGxe2+bmrEWsZC2HmaAwnw+6O8+anRnm8WvEGT
         itUIALjkU1InHwAoFBw/qQIfqSF5gHZgs2G1mFFt1z8h7wo26ExwQ8snWfLqWvPbt6QU
         L+YWkkbcpSlGVeHPxG3i+pVDFDxe00FJETY6e4jccBC+XLSY6fOIO02u66/jjxwZv3t5
         vfGKlkMurySp6/WSs/G3WuelJvPf3Nzl9pJbSbwBjUY+L7U4tDzZVZQebEp2Lr6Wiedi
         aQ+kK+HzKIZizmQdFiiN+5quKEzdiiJCbza/ulfTCRqquO1/CVUbUa0R4hdjwW89NK61
         Z+qQ==
X-Gm-Message-State: AOJu0YyonsRYaaA+r31s7/5otADAKFnxHM82WL0ilWX6CTWxaSObJHdK
	Jrm3jQEpA0yOk9Toj+McMRFizlOs/xxrwfG674ttnovdMeGoOyQ4mIcSSs4OEzo=
X-Google-Smtp-Source: AGHT+IFjnq8eLyzHTt7DORpVaxHSVtTM+TkJfJLYQD2jncOSwWbEuRe/faYidQ5wWhkrtqanCqyysg==
X-Received: by 2002:a05:6000:1ac9:b0:339:3e01:acea with SMTP id i9-20020a0560001ac900b003393e01aceamr427523wry.121.1705927369696;
        Mon, 22 Jan 2024 04:42:49 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d5110000000b0033763a9ea2dsm4671771wrt.63.2024.01.22.04.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:42:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 0/4] genirq/irq_sim: misc updates
Date: Mon, 22 Jan 2024 13:42:39 +0100
Message-Id: <20240122124243.44002-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'm resending it one last time. As it's been almost 5 months since the
initial submission and there were no reviews for the irq_sim part, I'll
take it through the GPIO tree for the next merge window.

--

Here are a couple of updates to the interrupt simulator. Two are minor:
remove an unused field and reorder includes for readability. The third
one simplifies the error paths by using new cleanup macros. To that end
we also add a cleanup definition for dynamic bitmaps.

v1 -> v2:
- add a NULL-pointer check to the bitmap cleanup macro as advised by
  Peter Zijlstra
- initialize managed pointers when declaring them to create a clear pairing
  between the type and the cleanup action

Bartosz Golaszewski (4):
  bitmap: define a cleanup function for bitmaps
  genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
  genirq/irq_sim: order headers alphabetically
  genirq/irq_sim: shrink code by using cleanup helpers

 include/linux/bitmap.h |  3 +++
 kernel/irq/irq_sim.c   | 30 ++++++++++++------------------
 2 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.40.1


