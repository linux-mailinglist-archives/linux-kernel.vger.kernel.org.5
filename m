Return-Path: <linux-kernel+bounces-35883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10047839823
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDDE1F252D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295A823BC;
	Tue, 23 Jan 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuQDEgZd"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A581217
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035561; cv=none; b=hQipIvqs6jjVlyIxIdbrZeGhAWzxgMaSbNyngTkFebXDmpXwKYGW4QA4m9+veIqmVqkPD2mQG+IPctiy+ZGX2GbtYHxdmO7MWrKFnTWRV4eAmLSrThkbIVt8pumYdObVgY+t1i+tNiR+cVeJBlQxgu/6p1Un0eAZEG77nN3FE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035561; c=relaxed/simple;
	bh=owxqIseSlumBRRdDHl0OytbX/BgcnFQjn6aKUzuarYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l28ereUg6nw/HhuKhOWUXBdYPD85fM/Pxkz3wpiEY9eXtXBveGPSUHU5Tq841/7PXUEL3DvA38KKPkAKSACOXHq3DkJz1gGqFhpigZDmvQkwwjv7d2Q6wCmPZvrhXQwojfsJo0LQ02B7Qx7uG0QEEjBs2v8ZALsynKGKxNKkOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuQDEgZd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d70a986c4aso20228715ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706035559; x=1706640359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0gfHlWpVUijxd+/zOQuAtY2BByIFtyAPQHUVgEt0ks=;
        b=CuQDEgZdoAaN8v4XGrNhaC+Gh/K62PDPhBJMuH0DuEILcvmjKPbqWjjQquDGo3tJ5t
         37/iNtrjN9GTaXfNF9RS6ScDp3igc7h1iwmmEqCeWs6WyvBnMi/DM1j+NejBxmkLLLvq
         7yoqCE0YbqlrFNn5Qlmf/HqTmuSz07V/kcXBBo0yKNnnCgMWpMHQMEkk0cnSlqlaiswh
         LunqBpzqjPhTua1lx5vLi7VFMICJUZ0p82jLzgz4RbE/EMrRzzVeRqAvv3ewq0VJfsGg
         opvj7Mw2/ccwO7nwAME0tNe+yvB40lw90FwvbtRrXg9oR+/cRFWgb/92k2atPrMaSIjf
         vm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035559; x=1706640359;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0gfHlWpVUijxd+/zOQuAtY2BByIFtyAPQHUVgEt0ks=;
        b=Q1Myu71GMLN5r88gr2L1/Jtj3wMgtOPxZn3CxzL/buLQlH1TSS1c593afUj954Ml1m
         nWo4RQNpJ6ufe/YeD7XCUWFVuErSntn73uhQEvPSnp2f/tksXAJBMkLs8oR57YHLJtwb
         yUIjHwsCvgc8UXTUgi1JFMzxt590uFITetVwRG0lsEvhOS2gmVf4kYGOpLBTIenXdNN7
         HSPJimJCE3JU6U/NVnnOOFo3m2/GGCnxMFUzBMGyN4DZE/nEtRdoYD49ryL65NJXDub9
         YOMHw1F5jufrUj9B5cBBS09nVrLT/5cQKqgNztkNCn5xIsFqgGdQ2/0AoHiwtJDoL/IR
         +NZg==
X-Gm-Message-State: AOJu0YwTOslnWAK2SI04SF7/iD5ro09cZtVpK8D3LUtW3a39pi/q43fw
	VDQACkfqrUzuSmHaU4/m78oE+qldyhkruXwbNsWee3LEqw1pt9gQ
X-Google-Smtp-Source: AGHT+IGON/iWnemM36uXYUE9iFJrD/NcRYwOXW0byNszw6qV2WjB4uiKaurl4vKO+wse/3YxjfK+XA==
X-Received: by 2002:a17:902:b205:b0:1d5:ebbb:973c with SMTP id t5-20020a170902b20500b001d5ebbb973cmr3865892plr.1.1706035559165;
        Tue, 23 Jan 2024 10:45:59 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902b70500b001d74c285b55sm4035196pls.67.2024.01.23.10.45.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jan 2024 10:45:58 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 0/3] mm, lru_gen: batch update pages when aging
Date: Wed, 24 Jan 2024 02:45:49 +0800
Message-ID: <20240123184552.59758-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Link V1:
https://lore.kernel.org/linux-mm/20231222102255.56993-1-ryncsn@gmail.com/

Link V2:
https://lore.kernel.org/linux-mm/20240111183321.19984-1-ryncsn@gmail.com/

Currently when MGLRU ages, it moves the pages one by one and updates mm
counter page by page, which is correct but the overhead can be optimized
by batching these operations.

I did a rebase and applied more tests to see if there are any regressions or
improvements, it seems everything looks OK except the memtier test where I
tuned down the repeat time (-x) compared to V1 and V2 and simply test more
times instead. It now seems to have a minor regression. If it's true,
it's caused by the prefetch patch. But the noise (Standard Deviation) is
a bit high so not sure if that test is credible. The test result of each
individual patch is in the commit message.

Test 1: Ramdisk fio ro test in a 4G memcg on a EPYC 7K62:
  fio -name=mglru --numjobs=16 --directory=/mnt --size=960m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=zipf:0.5 --norandommap \
    --time_based --ramp_time=1m --runtime=6m --group_reporting

Before this series:
bw (  MiB/s): min= 7758, max= 9239, per=100.00%, avg=8747.59, stdev=16.51, samples=11488
iops        : min=1986251, max=2365323, avg=2239380.87, stdev=4225.93, samples=11488

After this series (+7.1%):
bw (  MiB/s): min= 8359, max= 9796, per=100.00%, avg=9367.29, stdev=15.75, samples=11488
iops        : min=2140113, max=2507928, avg=2398024.65, stdev=4033.07, samples=11488

Test 2: Ramdisk fio hybrid test for 30m in a 4G memcg on a EPYC 7K62 (3 times):
  fio --buffered=1 --numjobs=8 --size=960m --directory=/mnt \
    --time_based --ramp_time=1m --runtime=30m \
    --ioengine=io_uring --iodepth=128 --iodepth_batch_submit=32 \
    --iodepth_batch_complete=32 --norandommap \
    --name=mglru-ro --rw=randread --random_distribution=zipf:0.7 \
    --name=mglru-rw --rw=randrw --random_distribution=zipf:0.7

Before this series:
 READ: 6622.0 MiB/s, Stdev: 22.090722
WRITE: 1256.3 MiB/s, Stdev: 5.249339

After this series (+5.4%, +3.9%):
 READ: 6981.0 MiB/s, Stdev: 15.556349
WRITE: 1305.7 MiB/s, Stdev: 2.357023

Test 3: 30m of MySQL test in 6G memcg with swap (12 times):
  echo 'set GLOBAL innodb_buffer_pool_size=16106127360;' | \
    mysql -u USER -h localhost --password=PASS
  sysbench /usr/share/sysbench/oltp_read_only.lua \
    --mysql-user=USER --mysql-password=PASS --mysql-db=DB \
    --tables=48 --table-size=2000000 --threads=16 --time=1800 run

Before this series
Avg: 134743.714545 qps. Stdev: 582.242189

After this series (+0.3%):
Avg: 135099.210000 qps. Stdev: 351.488863

Test 4: Build linux kernel in 2G memcg with make -j48 with swap
        (for memory stress, 18 times):

Before this series:
Avg: 1456.768899 s. Stdev: 20.106973

After this series (-0.5%):
Avg: 1464.178154 s. Stdev: 17.992974

Test 5: Memtier test in a 4G cgroup using brd as swap (18 times):
  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 16 -B binary &
  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys \
    --key-minimum=1 --key-maximum=16000000 -d 1024 \
    --ratio=1:0 --key-pattern=P:P -c 1 -t 16 --pipeline 8 -x 3

Before this series:
Avg: 50317.984000 Ops/sec. Stdev: 2568.965458

After this series (-2.7%):
Avg: 48959.374118 Ops/sec. Stdev: 3488.559744

Updates from V2:
- Add more tests and simplify patch 2/3 to contain only one gen info for
  batch, as Wei Xu suggests that the batch struct may use too much stack.
- Add more tests, and test individual patch as requested by Wei Xu.
- Fix typo as pointed out by Andrew Morton.

Update from V1:
- Fix function argument type as suggested by Chris Li.

Kairui Song (3):
  mm, lru_gen: try to prefetch next page when scanning LRU
  mm, lru_gen: batch update counters on aging
  mm, lru_gen: move pages in bulk when aging

 mm/vmscan.c | 145 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 125 insertions(+), 20 deletions(-)

-- 
2.43.0


