Return-Path: <linux-kernel+bounces-25804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC8982D611
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A011F21C01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466A8F50A;
	Mon, 15 Jan 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHWEd3jA"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0DEF4E9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6daa822be30so3513270b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705311290; x=1705916090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ThfGhERU0KfhZHQC506bDD3pPP3ZVwvi9Bi7fPw/F0c=;
        b=eHWEd3jAPVyAd9B8J22UrjtZ/9CqicgGNzngD2MGecxpLVj26FL2MPNRtA3wt6l0Iw
         fnH8XToudBL4TT/xuz6f0SyTyAj+bsic0UEOsrW+IEXwqldcqHVZXn9eYGaXPfpdb7xu
         gWEcv9v6JKHJWXuEhWDcXZxMR8sdgkUMhvwaQXqxTmzb4ElP6eJmIH/XNAgB/b0uRz0T
         GbauN1EkY/Var+i4S37jXhTtPZh+xgDZ6LCbu8euDGn73v07y2ba/WR/bukBcTegR9IS
         Jd2LX6DhX98HbPlkKSTNpMFN2Xmct7u7fjkv98lkB/Nfm6LTszl/yvp888s0NPBuqRz4
         yVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705311290; x=1705916090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThfGhERU0KfhZHQC506bDD3pPP3ZVwvi9Bi7fPw/F0c=;
        b=BSsMFDKF9mWLcKN3zIXSfrv2VGY30hCjRtuEWg4puJ0v9/8xyvKbH4iMOJceDARM4C
         kmWYRJ9IMYEoz49iHFKg5TtlEoaL3vIVYoQWZaE2ygXk13b0tpyXSZ4LOVORUfuLO1gy
         VsA/lako2djzbWn+cTF5nJtoTlxDztSs1FzPMU9+ozmAoBHjJI3g+FZHXn8UEN57kVh7
         ymw343S99JWz9qcRdUZsMtAzpCUi4ATlsN8TXIA+Shd1+FZhFu34RCsJqRjpQZSJUpB9
         ZjM5yRjDmRKkyJibv5hcoCBu4jcrXyocXpPGoK7bxdYz8gILM0MbU147MvAYw1bmSD0e
         YxYg==
X-Gm-Message-State: AOJu0YyLVBqxLOdo+dRzhbHutuhoiCY/Kzrgui5x7LfGmKcULqmT/pZ1
	PT7k24+T0Go880d4UItF8hs=
X-Google-Smtp-Source: AGHT+IHqCDGC6Vyy/n8Cf1ltT0A/n/O86Z1gXbFTHibaTJCtvcYg5x3nHBI5q6VQloE0PzKxJnaAvQ==
X-Received: by 2002:a05:6a00:1a8d:b0:6d9:8e5f:52fe with SMTP id e13-20020a056a001a8d00b006d98e5f52femr2810954pfv.48.1705311290519;
        Mon, 15 Jan 2024 01:34:50 -0800 (PST)
Received: from VERNHAO-MC1.tencent.com ([43.132.98.40])
        by smtp.gmail.com with ESMTPSA id b12-20020aa78ecc000000b006db105027basm7200686pfr.50.2024.01.15.01.34.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jan 2024 01:34:50 -0800 (PST)
From: Vern Hao <haoxing990@gmail.com>
X-Google-Original-From: Vern Hao <vernhao@tencent.com>
To: mgorman@techsingularity.net
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	haoxing990@gmail.com,
	Xin Hao <vernhao@tencent.com>
Subject: [PATCH RFC v1 0/2] mm, pcp: add high order page info in /proc/zoneinfo
Date: Mon, 15 Jan 2024 17:34:34 +0800
Message-ID: <20240115093437.87814-1-vernhao@tencent.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Hao <vernhao@tencent.com>

With /proc/zoneinfo we can simply get the number of pages used each cpu,
but we can't get more detailed information about the distribution of
those pages, such as the count of high order pages, through these
patches, we can know the usage of each order page in detail, which will
be helpful for us to analyze the pcp memory usage of application on the
related cpus.

By the way, on my intel 32 cores machine, i found that the 'struct
per_cpu_pages' size increases 64 bytes, it seems like a bad news,
i did some tests like stress-ng, but it did not see any performance
degradation, and maybe use 'pcp->list' is also a possible way to get
high order pages count, but it will increase the /proc/zoneinfo query
time, so any meaningful suggestions are welcome!

Xin Hao (2):
  mm, pcp: rename pcp->count to pcp->total_count
  mm, pcp: add more detail info about high order page count

 include/linux/mmzone.h |  3 ++-
 mm/page_alloc.c        | 46 +++++++++++++++++++++++-------------------
 mm/show_mem.c          |  6 +++---
 mm/vmstat.c            | 22 ++++++++++++--------
 4 files changed, 44 insertions(+), 33 deletions(-)

-- 
2.31.1


