Return-Path: <linux-kernel+bounces-79893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 899BC862804
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34354B214D3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94A34EB43;
	Sat, 24 Feb 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvedw02t"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFD4EB32;
	Sat, 24 Feb 2024 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814890; cv=none; b=cklziQrqVZadgpPtXyeMgd92xlSaGw828afBnhkjGVltNwb/VEse3zjZEAebjNk1MH/9qe8iKfCR+hcvEeTIzbo+8awnaqlOslghq3PCFNNpsyUWpLHMcOpwEjp1w6Qoy8ZE6jxai2retWyPq01z+USNaVDMUtxVUY7p0Jmc8og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814890; c=relaxed/simple;
	bh=Ta6daWl0ZVd61hh3oEvw2iF0kiGee521SeK6zSYDs70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8HAQCo6O9BuFRUE0hwLXoB26Y//iyofHEGNtavlYD8nNAEigGAuxxrnPOc3hZA7eWhLo//ecu9ZPE29hibvCREdlfLRtSVwQ1azj22rsuwhfrEvhgq/dfMF0xXz7WUakPphZL9avvrXcIhRVBpbMzrszwrj1s9pIZWAhZHtHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvedw02t; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-214ca209184so965367fac.1;
        Sat, 24 Feb 2024 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708814887; x=1709419687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BvzO7ZUsymLO2jBd+mJ7CM2X1lBqtVuXEd4hC3J8wSU=;
        b=lvedw02tLkwDx1DMVpJMIab4oSdK4UU3fVwsb+IQH7QW0U88CAePsW5dMkoRot7A40
         o5BDFvjXmD3mCwyU7kWy9nKHspKT9qWZBgMU4Cu81q6WGR/oxAPh5IcWmkVsyjrWfxxW
         mauC2TD4ybVpau2t66m0quu62eztU6Mj6/42DfJvw2omVgM10O4VZZ4og0xuXNN1a10b
         E/IMiogLekHrGXw7pp5viqSw0WFE7agL/WJ6ctU1qBlgkBLIZpfmGdDT/MGt+GD8ZT22
         u8fXm6zUgN85TfFmjedDGDHH2AZs7wPLrF2Z49YhtZK/x8+lDIxUO17UprGmlj33BfpY
         KvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814887; x=1709419687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvzO7ZUsymLO2jBd+mJ7CM2X1lBqtVuXEd4hC3J8wSU=;
        b=ktK2t2r33JNP/R0YVg3LdM53avy2i7Ez6jDBxBAq43MvBvBpNFTMLo9uaP9IoGH7Dv
         yS5kK5S4CA7hJk4OTetBPkOj6L4cYGEesYVS404ZGrp4IvWvibwe2HkDJMQXDhlS8DEt
         SNjANxNvdetlxet4VWzBmf3dTkTl8+5ubJ55CEUFzcOwtRe7N/hyhbFnCU6A68N4zQNm
         yCXTsLOI/4Rs3v+eTRAOEGDdvSBjTctu/BZ+LzURLoYINjqRdKhKg7RW6/3Yrg3ReNht
         pp5H+EpVvpgbdnlZei1pRRqeh1f6nTPgfHOWD2gQge9vC+CZMz4TOvackgngEcjLH0CQ
         5qCg==
X-Forwarded-Encrypted: i=1; AJvYcCVkS3sC96YaI3i0y+jZUYZysapkTYYqWYIogYmo5Zbq+M0WSi69+Ae9QHykK+69Wb5J8cabqAmZ3aJfxLd1Ftzxs9oxUtU8/GS+
X-Gm-Message-State: AOJu0YxWOG4tu5NXTN24/shuEJuDTRhzFlLcVvFR3Ev7eyHO1xRh0LK9
	1oe1Dj9CQUA5qHvCU2qFduKJ9Ckutqtjp8MiA9tvVtF8zySxxg0Y
X-Google-Smtp-Source: AGHT+IGtgVmOgAMzHE/9QbMi+O3Hk+d0Dl2iKByTn0sco5cLzPXoOU8adxaZX9wsTwzocuE6fNNw6g==
X-Received: by 2002:a05:6870:364c:b0:21f:dc71:c3f4 with SMTP id v12-20020a056870364c00b0021fdc71c3f4mr2515594oak.43.1708814887599;
        Sat, 24 Feb 2024 14:48:07 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:fae4:3bff:fecb:410])
        by smtp.gmail.com with ESMTPSA id fy16-20020a17090b021000b0029aac9c523fsm595754pjb.47.2024.02.24.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 14:48:07 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: corbet@lwn.net,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2] Docs/mm/damon/design: remove the details for pageout as paddr doesn't use MADV_PAGEOUT
Date: Sun, 25 Feb 2024 11:47:51 +1300
Message-Id: <20240224224751.4673-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The doc needs fix. As only in the case of virtual address, we
are calling madvise() with MADV_PAGEOUT. But in the case of
physical address, we are calling reclaim_pages() directly.
MADV_PAGEOUT on virtual address is much more aggresive to
reclaim memory compared to reclaim_pages() on paddr region.
This patch removes the details so that the description can
apply to both cases. And we don't need to couple with the
implementation details.

Cc: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2: decouple with the details according to SeongJae
 -v1: https://lore.kernel.org/linux-mm/20240224215023.5271-1-21cnbao@gmail.com/

 Documentation/mm/damon/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8c89d26f0baa..5620aab9b385 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -315,7 +315,7 @@ that supports each action are as below.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
  - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
- - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
+ - ``pageout``: Reclaim the region.
    Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
-- 
2.34.1


