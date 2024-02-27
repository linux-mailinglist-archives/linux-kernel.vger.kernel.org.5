Return-Path: <linux-kernel+bounces-84100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F006086A22F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE01F21A96
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF201534F4;
	Tue, 27 Feb 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTTFApCl"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0C150981
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071849; cv=none; b=KJJABNF9WzzE+ylR5dqg201C65iglwntkChUGSGi84yOZpBt1A2/rq2+s82bMUWrUXPuEevqlaJp7oNYHGynuVMfnLfIZulZD+/CnS94KCA3KaPnCYa7eEVQxOuG2SxkuNIjDbVLGu9oUi+JG/NUr91neKvKsM0L0AFny0I47EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071849; c=relaxed/simple;
	bh=IdCiQBJhitT9Oq1nzunZ0J4RNw5mODISj+FFI6ItdDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G1hIAHH/rOblV4JEcWAlUPThZULtTKgWbq3IEXWSD5g5kC2nSTzaOSbQXvveu8dbcPs/RwgTW/i9yEgczWaJn+dEntCzaVZ6DFlzYtPDl1ZaxFFtI7Ym0ALd8rzYW/OEvpVrwlfrBsq5SACYDQk6RPEbwfc6AhWWwtufS8cKirY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTTFApCl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412b272799aso1794995e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071846; x=1709676646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgkeChhdzdsl3VVE43LHMpQmdoDgIDk5tOvZY9oXyW8=;
        b=fTTFApCln2O7WQ33wHJwI2p0NjLBzXIf94iHQbJgki7vklsfKz/DUb844h9Mm7QVnN
         yL/eaXAV/zDP8LiUTW5I+9KcsJ8S17XABvOko2Q89vpqLVYhlUUCclbZZaKcmhtz+aHl
         8UukSKq+h4WtcCVN3yjzU/9zobvSV8ge/dJtSkyz1RWfVterJgLGJG2VhfjkxiD4K8A/
         /0jfn/1a9pW8wHluGAegrmssRorfWwTKrI1XTaAkfZxvWGRHgpZZYVmFDiG/2EG3TisT
         tB3oQF1/ezOfa7jEuPzqEwH7MdXu3KAY2JQsjs7W1hKOD6YwFefmaVVJchW/U3FRbLNi
         1yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071846; x=1709676646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgkeChhdzdsl3VVE43LHMpQmdoDgIDk5tOvZY9oXyW8=;
        b=Wnw3X6GxiTcyTBCWuVHQv7RmTWfDUx3LoVNrbn+zYflIXpuOyjFdIuNothBASRLsjX
         bQ8hAdDk0ySZqNd3zBXu/AW2mBVBUd3Crtp8NOut4zNw4ozktirECgp/ovagaqUmubaE
         puV09bupymJiM4PHJ/VWWREQrKhb7D02j/tWSUVA1ulaxdz2QszRFxJZ4zPuSEwkv6ze
         IW+UNi2+eKQoX0RXVP14PMIX4/ZpsoyTzziQ7Z80PIoBkZrT85UubEtCrCMUzbsIcdCj
         i0rZBrzRmKGmXyubvri/2Ukf6O8HgJybiK4Ibml/AB6p72qumS8e98u0jhyzubQn8wpr
         JOGw==
X-Forwarded-Encrypted: i=1; AJvYcCVc1yQdL2Y5RmUFbqJXtWWwvaQukJ6Fg/WSgic1/gtsipVUJCdNDdu7udIxm5W2H84m04jp60DrfM0TdHyw+whmmrB8dtB2SstXh5HU
X-Gm-Message-State: AOJu0Yy1Yr/9sZzz/iUJ9VYk7rg+cTLV4iwHWxX7CQpJ8+vvRpDWuCwn
	j8dQS4XPsy/ZHtV0w4iHvPfUMmoj4s2ZHsyVOzu8l3QiEwZUJRsg
X-Google-Smtp-Source: AGHT+IEfemwGujGA6Kgnpbu0SwK/+RHs5EYZ9cW5+iN1tIWmNWpoZkRPCzE6At+BVFPrI+MqP+TH9Q==
X-Received: by 2002:adf:ce83:0:b0:33d:27cf:6208 with SMTP id r3-20020adfce83000000b0033d27cf6208mr8420087wrn.7.1709071846024;
        Tue, 27 Feb 2024 14:10:46 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b0033cf5094fcesm12562384wrc.36.2024.02.27.14.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:10:45 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Fix defines in rf69.h
Date: Wed, 28 Feb 2024 00:10:38 +0200
Message-Id: <20240227221043.532938-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes several misuses of the define statement in rf69.h.
Duplicted defines.
Define in header instead of source file.
Unused define.
Using units.h macro to define frequency.

v2->v1:
- Fix grammer in commit messages.
- Use units.h macro to define frequency.
- Reorder patches to ensure no conflicts.

Shahar Avidar (5):
  staging: pi433: Remove a duplicated FIFO_SIZE define
  staging: pi433: Remove a duplicated F_OSC define
  staging: pi433: Redefine F_OSC using units.h macro
  staging: pi433: Remove the unused FREQUENCY define
  staging: pi433: Move FIFO_THRESHOLD define to source file

 drivers/staging/pi433/pi433_if.c | 1 +
 drivers/staging/pi433/rf69.c     | 4 ++--
 drivers/staging/pi433/rf69.h     | 4 ----
 3 files changed, 3 insertions(+), 6 deletions(-)


base-commit: 455c5e12a3b7d08c2ab47b7dd54944901c69cdcd
-- 
2.34.1


