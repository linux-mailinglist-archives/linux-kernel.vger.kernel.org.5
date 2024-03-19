Return-Path: <linux-kernel+bounces-107314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F117F87FAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A834F282818
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABFA7D083;
	Tue, 19 Mar 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEkhTND5"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A97D079
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841302; cv=none; b=ZuiRlFx6n7jjJtUcWkXwYlNB69/EU6Sw1SWrtSdvatJk9s/YolhtNwKTCYcL0kW/UGWXz6Vo0mHwNXbICNG/FiA3ZpgkmVTlJNX4VLhpZibX+/NNEOBmjiwoOHIooN5sdKJHjv3qZSPEcWYuXy20T0jlhtPniKvQLak6YqA+//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841302; c=relaxed/simple;
	bh=e9942nq5aT5eyY8hrU8Ph3EpBv6qY/MhoAXI0Jf7c8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpY/ehbr5xxRe1SSrLVkQqaOYsepzsgzweeaQDOXnVEcbNyaD3sDWdntRo2MMqNM7dCEpUpY7z5fFR6U3lL3B67st10njoBnQrW3KCizGRYsE2epFUFElZAjclulL6kqUK4gzrOvdBwcV71otsjz9cA3HlYEW444SPFU9YdYu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEkhTND5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so4922050b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841300; x=1711446100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=puEj9jlVApVqcnYFYETJHMNHyp/J8GRj2biAnc/m+zM=;
        b=jEkhTND59/2Jsej71HO0PAGiVsu7XJSLIPSwlELd2LTcO8b+iATSAwu0LQZulIS+qs
         X5rfXP39mDqF/SuPCUhuiIkA5i6fYKNDPbgXZaDUfA4RpShdB3WOvmwrMdjROVcj2BiL
         Woi40c82gRm+m1rJ91R7oxDUpjFzlq+lBAHFOjPCKB7k+P3wqzwGb61dRcpuLQxNFmOj
         oqQP7+IUDFHOn4T0SLpHGVwdqtnstQEth0XUPrQAlUAxYD+1STlRlf+t2qA41JiRgddR
         oGE67Pi46RlREexy8RMM9EP8tFuD5CCWKbHnxScAdqPUfIG/NYNKrmzZdHndtgVRSmJL
         Crrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841300; x=1711446100;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puEj9jlVApVqcnYFYETJHMNHyp/J8GRj2biAnc/m+zM=;
        b=Bb9hmTzn+UCR+a60LQ33nXGbgFEDPc+wLHO/Jex/FqOUfsiGI6nx82582sLN+R/E8d
         F49mr2ByfqUnjQWt7FOJZJXRvWsfh2ge+7Ffvj3g1erVlz/rLRPbOQ+p7+9swVt6ZOym
         Th2H52Yb0c5d+BxlZKhgtJ6Vdv2ChEJmBIscUvTuhgcW68S+ior6bh8r0nDnr2dWJ8zX
         gBAG024RDc8LfedoD1zV3fHUr9YeobRVC/No4Jibj6UEDfNmoGWQM0OCtqnCHkHxg75f
         QE2RFnJv5VZmFj+HZJtEt3/MIi0TYeaMRaRxjI9JHygxL+UAGcf+v5IaMpXwBY3uycc3
         rSEg==
X-Forwarded-Encrypted: i=1; AJvYcCW9K/gHTIlqGwMatvxbYt2IoyRZyh0QuaTOwzJyGju+RbhUMYFvB0Sq3puLJyjidmvCYrbR1chtuVX+PRzfDaUkBiUhhirNA9j2iJ9c
X-Gm-Message-State: AOJu0YytJojcMGNEZ1KBewy6XC1Bx+TUJfUjU//EtJj4Q0zYMyxoOC1X
	RzeODKEulTdDzSQAeJTIGb2W3EB84/NR744DbuBPug0nSxh8uEIQ9Xptj6htYoGvw5jV
X-Google-Smtp-Source: AGHT+IG4o+wBrs96/pLzi9W1461HZ72r8FyQRkQy+dgKMIyHVuf32UmjCcid72BjHEib7UXR5q9H/Q==
X-Received: by 2002:a05:6a00:2301:b0:6e5:64cd:8f52 with SMTP id h1-20020a056a00230100b006e564cd8f52mr18473179pfh.0.1710841299968;
        Tue, 19 Mar 2024 02:41:39 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id i185-20020a62c1c2000000b006e583a649b4sm9708761pfg.210.2024.03.19.02.41.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Mar 2024 02:41:39 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/4] mm/filemap: optimize folio adding and splitting
Date: Tue, 19 Mar 2024 17:27:29 +0800
Message-ID: <20240319092733.4501-1-ryncsn@gmail.com>
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

Currently, at least 3 tree walks are needed for filemap folio adding a
previously evicted folio. One for getting the order, one for ranged conflict
check, and one for another order retrieving. If a split is needed, more walks
are needed.

This series is trying to merge these walks, and speed up filemap_add_folio.

Instead of doing multiple tree walks, do one optimism range check
with lock hold, and exit if raced with another insertion. If a shadow
exists, check it with a new xas_get_order helper before releasing the
lock to avoid redundant tree walks for getting its order.

Drop the lock and do the allocation only if a split is needed.

In the best case, it only need to walk the tree once. If it needs
to alloc and split, 3 walks are issued (One for first ranced
conflict check and order retrieving, one for the second check after
allocation, one for the insert after split).

Testing with 4k pages, in an 8G cgroup, with 20G brd as block device:

fio -name=cached --numjobs=16 --filename=/mnt/test.img \
  --buffered=1 --ioengine=mmap --rw=randread --time_based \
  --ramp_time=30s --runtime=5m --group_reporting

Before:
bw (  MiB/s): min=  790, max= 3665, per=100.00%, avg=2499.17, stdev=20.64, samples=8698
iops        : min=202295, max=938417, avg=639785.81, stdev=5284.08, samples=8698

After (+4%):
bw (  MiB/s): min=  451, max= 3868, per=100.00%, avg=2599.83, stdev=23.39, samples=8653
iops        : min=115596, max=990364, avg=665556.34, stdev=5988.20, samples=8653

Test result with THP (do a THP test then switch to 4K page in hope it
issues a lot of splitting):

fio -name=cached --numjobs=16 --filename=/mnt/test.img \
  --buffered=1 --ioengine mmap -thp=1 --readonly \
  --rw=randread --random_distribution=random \
  --time_based --runtime=5m --group_reporting

fio -name=cached --numjobs=16 --filename=/mnt/test.img \
  --buffered=1 --ioengine mmap --readonly \
  --rw=randread --random_distribution=random \
  --time_based --runtime=5s --group_reporting

Before:
bw (  KiB/s): min=28071, max=62359, per=100.00%, avg=53542.44, stdev=179.77, samples=9520
iops        : min= 7012, max=15586, avg=13379.39, stdev=44.94, samples=9520
bw (  MiB/s): min= 2457, max= 6193, per=100.00%, avg=3923.21, stdev=82.48, samples=144
iops        : min=629220, max=1585642, avg=1004340.78, stdev=21116.07, samples=144

After (+-0.0%):
bw (  KiB/s): min=30561, max=63064, per=100.00%, avg=53635.82, stdev=177.21, samples=9520
iops        : min= 7636, max=15762, avg=13402.82, stdev=44.29, samples=9520
bw (  MiB/s): min= 2449, max= 6145, per=100.00%, avg=3914.68, stdev=81.15, samples=144
iops        : min=627106, max=1573156, avg=1002158.11, stdev=20774.77, samples=144

The performance is better (+4%) for 4K cached read and unchanged for THP.

Kairui Song (4):
  mm/filemap: return early if failed to allocate memory for split
  mm/filemap: clean up hugetlb exclusion code
  lib/xarray: introduce a new helper xas_get_order
  mm/filemap: optimize filemap folio adding

 include/linux/xarray.h |   6 ++
 lib/xarray.c           |  49 +++++++++-----
 mm/filemap.c           | 145 ++++++++++++++++++++++++-----------------
 3 files changed, 121 insertions(+), 79 deletions(-)

-- 
2.43.0


