Return-Path: <linux-kernel+bounces-80229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ACC862C52
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782DA2813E1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216019BA5;
	Sun, 25 Feb 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGS+H85B"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E07A18AF8
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882427; cv=none; b=cv8O23LiVxRKxcPzPKbdbyMFkNikX8Vg07cID5AJCnBIVX/kWn6WaLJP5msudfBhStqfHL9ToUJzdfjrJZOiXGKshxUnUCcWaVOR1D8xTgxBTjfL4nyYHM6zAttd9Nhf5SRpgUaqE0RO7a3zfYmqjLBfRbmaNpIZEl+fiodHP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882427; c=relaxed/simple;
	bh=qjkOQIYrB+b3SDuD/Mmb+CjT+hxWEsGBCNd0xK0IDgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HP6UoYLrqGE5a8IJe7Cnk0Hn3mii0KCHTASuZzCBSZNeLR30Ef0+G8jzRngPJoC/HD9sqgYUxf0EcyrJywaFLbQTZaxHlqT6Cy6uRkavhWzJ/CIdsFe7R7dnEV4H+kvSwwGy0ZdDFTHnKB5dv44SA8QUCn7P51Jqsih7PC64Vu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGS+H85B; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41296dce264so14965145e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882425; x=1709487225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytGyvZO1YlLW5fNgsIpaBkD9SXVxmGLiy1vtvLCSkQ8=;
        b=OGS+H85BvEvLlQ7pH0nenaH+j4KathprLiM2gPUfhkYRFhKRT325vQTRrAQv1GMIF/
         dIHsdNQvA1dbdEqqi65KgQMA+bz6s5xypG0FwyFj0u0VcnarKCNKcjz4F1BepkVOuwRr
         wnAzGZZbyPkbBDT4Z6LYigMrved/QHA297uzZ55HaJNCH5MUp7D5OFjxOsMuUUBTbEAi
         kKZcjDZMIHfp2SCe5l2Rlos0skniIqwxHxGhc/UwvSQo6Qza5Setz2hgC1YeIZ1aOfN4
         vHgWTw6W8mWdCvDQmqIsNxJ6C1NM4EYdz4ubvsRg5hLoeNJQSnd0TRT77d+17KL5XZ6K
         qmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882425; x=1709487225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytGyvZO1YlLW5fNgsIpaBkD9SXVxmGLiy1vtvLCSkQ8=;
        b=tYa7g88kyhfoWa4pCu6zim+36/m+s08KlyJHGCTyqrjKxcZQkMZ7tOtSikGkVpEml+
         NhJPJkIiewOayZX0PeEAYaF5apLU2P2oiWapDa3H9PWX6qD17rBHGsYT4ySalRLFBML5
         OTOBMifo5kGtfB7ijfWrxtlDS585BEvwivRuvLiNroHCTyFlS0iUYpYiSeyrHiywH3BH
         BPD2+mEd4SQ3Du7oxwxlKrjpA/G7F8cX/5lc48OLI6v83rv9uMPhR5h4zdcjpGELRXtc
         aP3wHSEwcXORwuN5DYoUUpPYAiFilpYxCELRfUTTTfPmVTC5T6Q8Tk38HhSDolofE/H/
         8MLA==
X-Forwarded-Encrypted: i=1; AJvYcCV4UuSyyFHOmvZyYq7Qc3d8ppxHr8uQqE5P84roiRr4XsYgabTXyHpOArYZlCIHo9Q0F2LQY3c289GVBAObIin4SYx4UF7XylNrSVo7
X-Gm-Message-State: AOJu0YxGeLT31/iZpoyXDntWpLvmKt+avtGae4ranZatbK5E6zoGy2gE
	pEeg1ukCl4PGYvbMnN1tG7eYolQKrZlM4A1ZWa1qW58FIci3VEEg
X-Google-Smtp-Source: AGHT+IG3Fzm7unubc19KRHGByezVBRcxLtmEKwPtHEZJeLOKIByYV2vnHk7uw9gbD3KuukGJSUYqWg==
X-Received: by 2002:a05:600c:450c:b0:412:981d:8da2 with SMTP id t12-20020a05600c450c00b00412981d8da2mr3462869wmo.36.1708882424628;
        Sun, 25 Feb 2024 09:33:44 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:79c9:6db8:8198:3c60])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm9400108wmc.27.2024.02.25.09.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:44 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Fix defines in rf69.h
Date: Sun, 25 Feb 2024 19:33:37 +0200
Message-Id: <20240225173341.1278918-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes several misuses of the define statement in rf69.h
Duplicted defines.
Define in header instead of source file.
Unused define.

Shahar Avidar (4):
  staging: pi433: Remove a duplicated F_OSC define
  staging: pi433: Remove the unused FREQUENCY define
  staging: pi433: Remove a duplicated FIFO_SIZE define
  staging: pi433: Move FIFO_THRESHOLD define to source file

 drivers/staging/pi433/pi433_if.c | 1 +
 drivers/staging/pi433/rf69.c     | 3 +--
 drivers/staging/pi433/rf69.h     | 4 ----
 3 files changed, 2 insertions(+), 6 deletions(-)


base-commit: 455c5e12a3b7d08c2ab47b7dd54944901c69cdcd
-- 
2.34.1


