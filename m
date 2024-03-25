Return-Path: <linux-kernel+bounces-118183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F388B58E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FD21F63AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9E284D11;
	Mon, 25 Mar 2024 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iey6gU2o"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9880C00
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410622; cv=none; b=B/J0Q/cRplPN5Aw+m0Gtaw30udlJ6o29VRjYf+gUuprEC8PzcSbH0RNmlX1ZGDF3oxgf9ycrEN/IwXAJlC6yZkwuo2OIxKhsz8uhjJCLhxyeVaQDFY31dC3zZf6F7BvwqL041i/dCIRaSFGKkJ5Ij9cv2SCn5JEgMEOd3B9W5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410622; c=relaxed/simple;
	bh=I+qES3UJlPOzSxFqpz3x9sn9+78tIxxGG1ieiOOlj/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gUQqZRFW0BcvsSiw4tVCsenM+JnZUH8+CvSEbZLrKnc+VvEtgck2zJ0PEhjycBMtXG35BqSHyykmuY0bVc4Y8wfBhJctVifnw9iw8hf1nCQH8pMolOd7cV+aYpeBdKT+PKG1dRO4lRbyQ6r0TgQxEfocwXpe+zaJEili2YXtHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iey6gU2o; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso8522886276.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711410620; x=1712015420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u7aBwaC4ODAeR/XYxC4V8jgRmUuIBcBfSCKvbyeibW0=;
        b=iey6gU2oY5kI54lKa7u7x5rqI+Jk51kH+SRNHQuKz5vCQHvX/ZDL8sno7Q9v7kM+PS
         GftTaE18vECMAUgf/ctN7vk9QjtVPoydeD/S9h+bj82LQYRIpJ2H9jUWfZjbzYIS2aMB
         EdhS+CpSahI/QFOuIVco7Q3Gaa1oS/N4Zcy89xs5uCkjCwMd3Gc4xy7cPdq/M6cfHkSn
         qo5LlE6aPNC8dP8BMsmxG1Aah6MyPaabMAPH0gTVI/kr4mvLFRo9yzXlMYS87nbE2kFK
         SKcx3Q9lGQQXt62mcDvQNZ79HThdAa32Gyhwd12lRx9hKHq/v4ZEsObNPYa+3eBNhA1M
         UZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410620; x=1712015420;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7aBwaC4ODAeR/XYxC4V8jgRmUuIBcBfSCKvbyeibW0=;
        b=JY4Ciub4+fiOy0ZHXR2I0wqUoL2Mw72SkifHwj6959hm9VA7swy4cF2sIyl++DNSPK
         XeTZNzZOky6d5t6HilYIka4LUdDXEShYtuKAItmutd1NPsYJFuHa12jvxXto8wT9r4kv
         qfvGMplSLmDXyi4dvQTaL9ITDU3/6Ev9htiA/UXHT5JnbFTVhPI4udDnT7wMEplU0X+P
         c8kUNEoigeaZhm05ZxU2cNyTCUm7wQouAFeNn3ADsvM50cx9gf/iS+EoMQ52SsDNAH4P
         Bj12T/Uy4yEVcyup8wpnKarlZGU58lbWjLoLe4DWIaJHlQCGIgckZQlRdpifdd+9UsbQ
         QRXw==
X-Forwarded-Encrypted: i=1; AJvYcCXosXepE7ukkVNBR4puOwS0aA1xdkrwuP11oLucv0Yf/8sBxUYNSgzye3U2CRWzsyVLLODBHgwCEgLyAlYcT71wdv5ocM9JVajT00OF
X-Gm-Message-State: AOJu0Yw7Xk6AHhew5fOsulsiU/ZbY2onuQYQp5WOr0rJ2dnkxlIqZRzl
	GpTPtaMDhfKkX/72JY397abkpEqjcLp2g5dTOH23kvFqmyNtVd0MD73wVWIPpLSNuvisJJTmx6r
	K4gcU88kvsJoMis4yhQ==
X-Google-Smtp-Source: AGHT+IFCdSCNI12vl7kQFBLpUa6o4Lix7+E5B+fsD9bW1doNy+Mmb1MlgwxyNG6gk4wPRI3jQ5rMwciD3YXfahGz
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2388:b0:dda:ce5f:b4c3 with
 SMTP id dp8-20020a056902238800b00ddace5fb4c3mr2112625ybb.1.1711410620214;
 Mon, 25 Mar 2024 16:50:20 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:50:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325235018.2028408-1-yosryahmed@google.com>
Subject: [RFC PATCH 0/9] zswap: store zero-filled pages more efficiently
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series drops the support for non-zero same-filled pages from
zswap and makes storing zero-filled pages faster and more efficient.
Non-zero same-filled pages should not be nearly as common as zero-filled
pages, so dropping support for them in favor of improving the more
common zero-filled pages makes sense. It also allows for a lot of code
cleanups.

Patch 1 is a small cleanup for zswap_store() cleanup path that also
implies a small behavioral change.

Patches 2-4 are groundword refactoring.

Patch 5 removes the userspace tunable to enable same-filled pages
handling. It arguably makes no sense anyway.

Patch 6 drops the support for non-zero same-filled pages, and patch 7
allows for storing them more efficiently. Both of these patch cause
around 1.4% improvement in the system time on kernbench. The kernel
build test only produces around 1.5% zero-filled pages. Some real
workloads are expected to have higher ratios of zero-filled pages and
hence more improvement. They also save a little bit of memory. Exact
numbers are in the commit logs.

Patch 8 drops the limit checks before handling zero-filled pages and
patch 9 does a followup cleanup of zswap_store() made possible by this
series.

This series is tagged as an RFC because it makes some potentially
controversial decisions :)

The series is based on a slightly outdated mm-unstable.

Yosry Ahmed (9):
  mm: zswap: always shrink in zswap_store() if zswap_pool_reached_full
  mm: zswap: refactor storing to the tree out of zswap_store()
  mm: zswap: refactor limit checking from zswap_store()
  mm: zswap: move more same-filled pages checks outside of zswap_store()
  mm: zswap: remove zswap_same_filled_pages_enabled
  mm: zswap: drop support for non-zero same-filled pages handling
  mm: zswap: store zero-filled pages without a zswap_entry
  mm: zswap: do not check the global limit for zero-filled pages
  mm: zswap: use zswap_entry_free() for partially initialized entries

 mm/zswap.c | 297 +++++++++++++++++++++++++----------------------------
 1 file changed, 139 insertions(+), 158 deletions(-)

-- 
2.44.0.396.g6e790dbe36-goog


