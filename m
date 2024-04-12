Return-Path: <linux-kernel+bounces-142159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E78A2855
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3C21F23186
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349554CB35;
	Fri, 12 Apr 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBym2JCC"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2131B5AA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907480; cv=none; b=htBTtjahy6k27qTKWgKR1slZ4E015QqT0cbIK7kKgTGysZnc0C3gqMUFVnSqQMlBiLUuEya0YdHMXqjXMYB0NU3fprmgibaSiiRHPIx1Y4PdIsEbIc+rmVlLsId65q1iXhI7vEfbmgqk19kFz6a+AFh4jFwZzkXey0aSdqdyHLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907480; c=relaxed/simple;
	bh=6sqzzhJkpUQDFb0NIOIGCwLMbM60sBT/lKp5mFA9t4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FLiZri2ESe628ZiI/6diw7nNzypKhJwwadNom3izXolg/mOmo0A8XG6tk/x/unwvZg+wDEPYsvHGbfPnqphBc2EfbZApYv9t6CXmnIRZLnT85pQyqi5TNUigw2FUU4iT/nHsbpTCZ/o1pGzJvflssuygL1c/3xuIp81bOrmlD9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBym2JCC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e50a04c317so3863545ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712907478; x=1713512278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8Uou6ceHlqIama13YYiFU7oji+lihhby0gYb2Jomk0=;
        b=JBym2JCCpjr3Eeu9UPPvt0qnducKWyuNA4TegAJEv7v55earChEUIgdstfhfQOGoL1
         JvXrbmWZbA5JkLEdmM6vyUb2FgWvDTmBPm3yTeVptseOb83UWMPT47bm8eYDwLr45Jgf
         zZILA9otOQlKztqR2DPv2F9kzGQijRrIelqvXZ9gFvtQkPiOu2aUlsuq4xo3TtrscYbL
         qHyIKdQbL6/xXgLJ2PyH3/FFmCnqabmKOWMMOChfjCeVB5yvJM9jrCAf0Q2+cXiU2VQ3
         xQ1w326DcJfk0UJLzGFcRnXAwTGg+CeoYSuVVAYaYFWtVVvyAacAkyrNZGoglnL60O0Z
         V3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907478; x=1713512278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8Uou6ceHlqIama13YYiFU7oji+lihhby0gYb2Jomk0=;
        b=R4iWZMQ4ZDkwM2qaekaPcLEByYpPBloOVjJpveZdMcIuFCacWq1MbQV2rwoE8CI4gr
         fjcEX8Dm1DInMjzsd9zgn03UbX5AfsJC9+oz3+etIh3tBa75PpvVw/gCEw7vG2oXgdY4
         xa+E6lwrq/EEjPIpsyYMbEI2PrYXhZesxcuAq9JjfH9ix4YNqAr13BSSyCuW31AjKzch
         c57GruAvIaLnJB6toD+CFP7CuQDzZAshG1Y4WaTw0MS6X+BVBvLlKEs2ETAM62rv2KUJ
         QFVVTc5U0TgFaYPZDf6IirHwRRyL/CbBuK/IlccRn4l1m7NVc2Dk2DYY1WoTDHIiHqpj
         nMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWesJPQRN+8CMg6K4ojSAGA6rggzViK31H5uTrJsjtgI57Ey8/TkmruiPwdg2R0jOef2vy8SCsZBfqYCP3npuFZbqsZDnqOu8BNLJZD
X-Gm-Message-State: AOJu0YwtV3lajKZyzPsUxokVx/3/6G+gP3iNogIHpxxbFRzDtGrkhvAZ
	tWuTEFzzMHK4utAMFqJQ2Z7CdVoR3HWBoQptc47hrAKN7qUBQ9fB
X-Google-Smtp-Source: AGHT+IFF1RQ+qoT47FkJAuq1ppdbZf8q0nwvGmfKUv2rJD3pj9qmNMR05kZO48tt0XGhqSCJfLm0bQ==
X-Received: by 2002:a17:902:cecb:b0:1e4:2451:c2b5 with SMTP id d11-20020a170902cecb00b001e42451c2b5mr1895200plg.13.1712907478445;
        Fri, 12 Apr 2024 00:37:58 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b001e478f359bdsm2344011plh.127.2024.04.12.00.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:37:58 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	corbet@lwn.net
Subject: [PATCH v5 0/4] mm: add per-order mTHP alloc and swpout counters
Date: Fri, 12 Apr 2024 19:37:36 +1200
Message-Id: <20240412073740.294272-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The patchset introduces a framework to facilitate mTHP counters, starting
with the allocation and swap-out counters. Currently, only four new nodes
are appended to the stats directory for each mTHP size.

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
	anon_fault_alloc
	anon_fault_fallback
	anon_fault_fallback_charge
	anon_swpout
	anon_swpout_fallback

These nodes are crucial for us to monitor the fragmentation levels of
both the buddy system and the swap partitions. In the future, we may
consider adding additional nodes for further insights.

-v5:
  * rename anon_alloc to anon_fault_alloc, Barry/Ryan;
  * add anon_fault_fallback_charge, Ryan;
  * move to dynamic alloc_percpu as powerpc's PMD_ORDER is not const,
    kernel test robot;
  * make anon_fault_alloc and anon_fault_fallback more consistent
    with thp_fault_alloc and thp_fault_fallback, Ryan;
  * handle cpu hotplug properly, Ryan;
  * add docs for new sysfs nodes and ABI, Andrew.

-v4:
  * Many thanks to David and Ryan for your patience and valuable insights
    throughout the numerous renaming efforts!
  * Guard the case order > PMD_ORDER in count func rather than in callers,
    Ryan;
  * Add swpout counters;
  * Add a helper DEFINE_MTHP_STAT_ATTR to avoid code duplication for various
    counters;
  link:
  https://lore.kernel.org/linux-mm/20240405102704.77559-1-21cnbao@gmail.com/

-v3:
  https://lore.kernel.org/linux-mm/20240403035502.71356-1-21cnbao@gmail.com/

Barry Song (2):
  mm: add per-order mTHP anon_alloc and anon_alloc_fallback counters
  mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters
  mm: add docs for per-order mTHP counters and transhuge_page ABI
  mm: correct the docs for thp_fault_alloc and thp_fault_fallback

 .../sys-kernel-mm-transparent-hugepage        | 17 +++++
 Documentation/admin-guide/mm/transhuge.rst    | 32 ++++++++-
 include/linux/huge_mm.h                       | 53 +++++++++++++++
 mm/huge_memory.c                              | 65 +++++++++++++++++++
 mm/memory.c                                   |  3 +
 mm/page_alloc.c                               |  4 ++
 mm/page_io.c                                  |  1 +
 mm/vmscan.c                                   |  3 +
 8 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage

-- 
2.34.1


