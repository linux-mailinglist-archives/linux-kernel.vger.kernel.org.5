Return-Path: <linux-kernel+bounces-145650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ACC8A58FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47926281A29
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605282891;
	Mon, 15 Apr 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahLrX+gf"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7DC823CE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201553; cv=none; b=SlXmEoN8OKPFGtfbuVTVHJaU1FIw3y57UETyN+nWprM2m0yUyIDAnvc/N0zIWoxxeQbiWlHGa8tRxiDsSisxO6HygwKYj4NAwBxeV9QaqBoOMSvQw/9+Q2m3uKFOQneRbYePdFIcl7j9bRB47vIlZ/yEhbetz34JeQZvUHx0Z68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201553; c=relaxed/simple;
	bh=ky4LW7ESjyAkqM13kN/Ugp3MW2gsSJx7xRujcmz7vww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BjeN11DUq+rLSGzssSrKZ2TJ6YCkAv+IeQQzBK53tVqq1p3lYaJ+qi9t9ATmyVPQy2ubCwbYHbY9I1PMl/h/fFs7M5MeSzvxun6JmkhEYZLUg3hGYQMeImMcY0oyB4y+r2LKHzjHSSmmuS5+T38yjHG41SQ5Y7MH9IjUvzllf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahLrX+gf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so1932766a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713201552; x=1713806352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhpaLSgvqk0TlKEdREUcJYLS3jjnPGf0yK+OZWmxYdA=;
        b=ahLrX+gfZVvaxT0kTnBJK/WmKgIsa5QXH118i5gry2NAyTOk8LxG8Ii4CmtjnD1LAJ
         wMDjKnZQxBFfCn61TODO/IvlebAy0Tq11iWUTjC1RmuslPJ0TVG+JqqgJu5Y55QyUB9p
         FPxbAxtY3pfnimYbaOKZp8TaMZWOnoG6jTyGhzJg3h78OchtWPGqHCMW4cv4qMrJyWDC
         40GsPUSZBeeqjT77zPmaQsUfPSMPHzqhAm2NbWNNnSSszntUwNnoy6dKZfmXVY7vG743
         Xnf7C2V4EU6jbWnDleCy98JLjWX1WXap6YoJ8yASe6lM0d5Y+4vq1xAP+6pJoyZe/rhE
         PT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201552; x=1713806352;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhpaLSgvqk0TlKEdREUcJYLS3jjnPGf0yK+OZWmxYdA=;
        b=WzGKuexcRTWH3YA0plX6PB64b8+SnGqLrWdznl5/tYM3W5RsTHJzuuZTEIIStO6YYa
         Erp8Jib/4loun93pyk8ZGo65Wpv1ER9eHTRejGydRcu4hJj7i9AUBH2bPAep7gJOTs8q
         jF1BTfzh2LJssHI32AQN68GT72kfD247MXJNXiDDJ9++ZZ6/a0kbMTxf4c+QvvVgU5VO
         unQcq2zPjBgXgZG8GVtyvHyYTfNvUPMiFXftXDvqnhsk0RnYobad2/0iBRwsejYY/+Rf
         jzcjp3X/+muKxbdjUecfi3eVsr4b6ZGBPNkZ8Dw8rgC+i/yjEc56pQXMnizjrgUjeB5H
         ve7g==
X-Forwarded-Encrypted: i=1; AJvYcCV8kkIWe7Edy3tLtz61dA+TaQaTbjhSCw45Gg2BOjr2CYnBfKRPF1+Y9bOw+f049OdznCIWTMwJcGtBvtaLy2Mud9VZGnPBoklq4plf
X-Gm-Message-State: AOJu0YwYSrv9r6rJ/XzOd2MKMUXIjns+ZkBKMxKNRhAVHTMMMAyNt3PW
	39WAsS1ZnrlC2vqQc3+tNxei8wrKjFcotRXuxX46joBjJDJWF95WF+XTf/lI
X-Google-Smtp-Source: AGHT+IH1XygPTZJ8SBU+edViR3oewT4fY61fTFui7u1KllICvytry838XCTHAaadyIDoFojVB+Sv5g==
X-Received: by 2002:a17:90a:df08:b0:2a5:bdd7:bb17 with SMTP id gp8-20020a17090adf0800b002a5bdd7bb17mr9678006pjb.42.1713201551562;
        Mon, 15 Apr 2024 10:19:11 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a537abb536sm8751648pjq.57.2024.04.15.10.19.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 10:19:11 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 0/4] mm/filemap: optimize folio adding and splitting
Date: Tue, 16 Apr 2024 01:18:52 +0800
Message-ID: <20240415171857.19244-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Currently, at least 3 tree walks are needed for filemap folio adding if
the folio is previously evicted. One for getting the order of current slot,
one for ranged conflict check, and one for another order retrieving.
If a split is needed, more walks are needed.

This series is trying to merge these walks, and speed up filemap_add_folio,
I see a 7.5% - 12.5% performance gain for fio stress test.

So instead of doing multiple tree walks, do one optimism range check
with lock hold, and exit if raced with another insertion. If a shadow
exists, check it with a new xas_get_order helper before releasing the
lock to avoid redundant tree walks for getting its order.

Drop the lock and do the allocation only if a split is needed.

In the best case, it only need to walk the tree once. If it needs
to alloc and split, 3 walks are issued (One for first ranged
conflict check and order retrieving, one for the second check after
allocation, one for the insert after split).

Testing with 4K pages, in an 8G cgroup, with 16G brd as block device:

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
    --buffered=1 --ioengine=mmap --rw=randread --time_based \
    --ramp_time=30s --runtime=5m --group_reporting

Before:
bw (  MiB/s): min= 1027, max= 3520, per=100.00%, avg=2445.02, stdev=18.90, samples=8691
iops        : min=263001, max=901288, avg=625924.36, stdev=4837.28, samples=8691

After (+7.3%):
bw (  MiB/s): min=  493, max= 3947, per=100.00%, avg=2625.56, stdev=25.74, samples=8651
iops        : min=126454, max=1010681, avg=672142.61, stdev=6590.48, samples=8651

Test result with THP (do a THP randread then switch to 4K page in hope it
issues a lot of splitting):

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap -thp=1 --readonly \
      --rw=randread --time_based --ramp_time=30s --runtime=10m \
      --group_reporting

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap \
      --rw=randread --time_based --runtime=5s --group_reporting

Before:
bw (  KiB/s): min= 4141, max=14202, per=100.00%, avg=7935.51, stdev=96.85, samples=18976
iops        : min= 1029, max= 3548, avg=1979.52, stdev=24.23, samples=18976·

READ: bw=4545B/s (4545B/s), 4545B/s-4545B/s (4545B/s-4545B/s), io=64.0KiB (65.5kB), run=14419-14419msec

After (+10.4%):
bw (  KiB/s): min= 4611, max=15370, per=100.00%, avg=8928.74, stdev=105.17, samples=19146
iops        : min= 1151, max= 3842, avg=2231.27, stdev=26.29, samples=19146

READ: bw=4635B/s (4635B/s), 4635B/s-4635B/s (4635B/s-4635B/s), io=64.0KiB (65.5kB), run=14137-14137msec

The performance is better for both 4K (+7.5%) and THP (+12.5%) cached read.

V2: https://lore.kernel.org/lkml/20240325171405.99971-1-ryncsn@gmail.com/
Updates from V2:
- Fix the misusage of locks in test module:
  https://lore.kernel.org/oe-lkp/202404151046.448e2d6e-lkp@intel.com

V1: https://lore.kernel.org/lkml/20240319092733.4501-1-ryncsn@gmail.com/
Updates from V1:
- Collect Acks.
- Add tests for new xas_get_order and combined usage of xas_get_order with
  xas_for_each_conflict.
- Fix a memleak for patch 4/4 and modify the function in place instead
  of adding a new helper.
- Update benchmark, I forgot to drop cache and disable THP for pervious
  test, so the result was for mixed usaged of split and add. The result
  is even better now.

Kairui Song (4):
  mm/filemap: return early if failed to allocate memory for split
  mm/filemap: clean up hugetlb exclusion code
  lib/xarray: introduce a new helper xas_get_order
  mm/filemap: optimize filemap folio adding

 include/linux/xarray.h |  6 +++
 lib/test_xarray.c      | 93 ++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c           | 49 ++++++++++++++--------
 mm/filemap.c           | 74 +++++++++++++++++++++------------
 4 files changed, 179 insertions(+), 43 deletions(-)

-- 
2.44.0


