Return-Path: <linux-kernel+bounces-132280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F389926A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49C12885DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3C17FF;
	Fri,  5 Apr 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K4pDD4Pg"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB5393
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275632; cv=none; b=UIufDad5y6JYDREAEfTmyxKwdkezDVzz8GoPWmRokbk+dc7ChKZvNrdivLUMEt3cflljd5niCl3jIZXq8pVJaOo86yVQo8qAvqyfnODZWwW3ay8xLzklS6u5SjIozHomtagGaLMO9HyuswXRdY5Kk7Oy1Q4mrA77XMrWpVrNoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275632; c=relaxed/simple;
	bh=FDoinf5ATmma6u2gGG8DW8Fyy4C4wZjoT6NU9B/hgyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oulHy8ORX8p6tKxRr+pYfZsWsQWYAasrRTJ0UWDI4TLldt/DvW9VR8SI4OOeq4kdgB7sBHuvzTvuMmL3zExzIfx39QTttzImlCCA7tAjd4FY0zrBfSIDe26/V55tt1NYcPkXgQ0cjTuvJRsTZyHqigH9qcMp8vlhmOVrMNn92Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K4pDD4Pg; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d455c5da6so53535485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712275630; x=1712880430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=borPtC2Lw74++f4OJFhInHLKkc0dmWJsVuLGMvV8fMY=;
        b=K4pDD4Pg1sTfrdMY5v4dDHENr1OQcdcxwO99qgdXgBPral/4vnZyESTOHAy2EOllxG
         E8DU+3XjSOfyWp8Rj0cxiJWkDBzhcpA6eT9LQlxRpUWw8AFARmvKOv3owoF/Lc2SMJqM
         K0y1Ymfn5KVgzLQ7jUj11HBbnH/k91RvohzrWTh74Km0tB1/sWWVa0NkgNuuqZL6BQDi
         mDbH5XNdUoY7dlmuP3UlEOypHEL4F4zfPpAZWSj+yUokNzGPhi0EHpzjRh4/pQBRZ4/P
         gGdcz6zKIwWoGw9P+eofz0Zofo9MCJHPgEX7ZpzOTmLBrlBquejXE1RJlMjelPJMjWKd
         3UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275630; x=1712880430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=borPtC2Lw74++f4OJFhInHLKkc0dmWJsVuLGMvV8fMY=;
        b=UWKBlTgnJ6SEoF0n9af1M4x83zWcWHiO0A9nPPfS4YuQG31G8dCRDKwPflidQlXkd9
         /KlevnYvoMIsBePa15luUXcKpGxauM7rovWQTR4ScjBJhdM3WvSbnhuFmAI2ft7jRFOI
         ahefMrO8P/7Egv58w6WRvsgz5ELJW3KYXgrnb93F6s54EI4krycXPRxT6B/JztErb6v9
         UPe98IChGLHaQV7SoD4QJbE513xSwd+5+y8T6QVL50/ou10CGrQffLvCaQatOTyjkuke
         ns5YGQ0JfaWw5vgyFuqbnTNnXc8CjNmptssI3m8YrK2FRE+BWrVzz2bVkQXyVpSEApwS
         qTiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+GbkoQRJWj/sRRt91wGCa14svXP/0a5q+s8YaQ18PAf+BwvnaNyNvgPCzMRYYW6T/Yoanch0+MgBDTfrJIK4RCGg/23DwpTznAu4b
X-Gm-Message-State: AOJu0YyNYL/aW4ZGRyBSeZ9K/hAc4fBh6mckhufPNxBKS6WJTlfEh/bV
	GV5fLnOUUt2iTec109+g2KCk1+H6O3RjGGWbbtYPfLGOggBWuzssVSd959szBRcrM4bzyHE0A9o
	8
X-Google-Smtp-Source: AGHT+IEZxsVQpcVtfVYtGZzcm88UlnMi4FCOp8lekdMsqoU3bR6MAdrGWYFbzpWmRgOIJsDUml+1Gg==
X-Received: by 2002:a05:620a:136e:b0:789:e524:933b with SMTP id d14-20020a05620a136e00b00789e524933bmr3831084qkl.31.1712275630015;
        Thu, 04 Apr 2024 17:07:10 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.118])
        by smtp.gmail.com with ESMTPSA id d4-20020a37c404000000b0078835bfddb8sm191433qki.84.2024.04.04.17.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 17:07:09 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Srinivasulu Thanneeru" <sthanneeru@micron.com>,
	"SeongJae Park" <sj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v11 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Fri,  5 Apr 2024 00:07:04 +0000
Message-Id: <20240405000707.2670063-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable from
normal DRAM in terms of memory tiering with the current implementation.
The current memory tiering assigns all detected normal memory nodes to
the same DRAM tier. This results in normal memory devices with different
attributions being unable to be assigned to the correct memory tier,
leading to the inability to migrate pages between different
types of memory.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the
initialization of memory tiers for CPUless NUMA nodes until they obtain
HMAT information and after all devices are initialized at boot time,
eliminating the need for user intervention. If no HMAT is specified,
it falls back to using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance
attributes through QEMU, and the guest now sees memory nodes with
performance attributes in HMAT. With this change, we enable the
guest kernel to construct the correct memory tiering for the memory nodes.

- v11:
 Thanks to comments from Jonathan,
 * Replace `mutex_lock()` with `guard(mutex)()`
 * Reorder some modifications within the patchset
 * Rewrite the code for improved readability and fixing alignment issues
 * Pass all strict rules in checkpatch.pl
- v10:
 Thanks to Andrew's and SeongJae's comments,
 * Address kunit compilation errors
 * Resolve the bug of not returning the correct error code in
   `mt_perf_to_adistance`
 * https://lore.kernel.org/lkml/20240402001739.2521623-1-horenchuang@bytedance.com/T/#u
-v9:
 * Address corner cases in `memory_tier_late_init`. Thank Ying's comments.
 * https://lore.kernel.org/lkml/20240329053353.309557-1-horenchuang@bytedance.com/T/#u
-v8:
 * Fix email format
 * https://lore.kernel.org/lkml/20240329004815.195476-1-horenchuang@bytedance.com/T/#u
-v7:
 * Add Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
-v6:
 Thanks to Ying's comments,
 * Move `default_dram_perf_lock` to the function's beginning for clarity
 * Fix double unlocking at v5
 * https://lore.kernel.org/lkml/20240327072729.3381685-1-horenchuang@bytedance.com/T/#u
-v5:
 Thanks to Ying's comments,
 * Add comments about what is protected by `default_dram_perf_lock`
 * Fix an uninitialized pointer mtype
 * Slightly shorten the time holding `default_dram_perf_lock`
 * Fix a deadlock bug in `mt_perf_to_adistance`
 * https://lore.kernel.org/lkml/20240327041646.3258110-1-horenchuang@bytedance.com/T/#u
-v4:
 Thanks to Ying's comments,
 * Remove redundant code
 * Reorganize patches accordingly
 * https://lore.kernel.org/lkml/20240322070356.315922-1-horenchuang@bytedance.com/T/#u
-v3:
 Thanks to Ying's comments,
 * Make the newly added code independent of HMAT
 * Upgrade set_node_memory_tier to support more cases
 * Put all non-driver-initialized memory types into default_memory_types
   instead of using hmat_memory_types
 * find_alloc_memory_type -> mt_find_alloc_memory_type
 * https://lore.kernel.org/lkml/20240320061041.3246828-1-horenchuang@bytedance.com/T/#u
-v2:
 Thanks to Ying's comments,
 * Rewrite cover letter & patch description
 * Rename functions, don't use _hmat
 * Abstract common functions into find_alloc_memory_type()
 * Use the expected way to use set_node_memory_tier instead of modifying it
 * https://lore.kernel.org/lkml/20240312061729.1997111-1-horenchuang@bytedance.com/T/#u
-v1:
 * https://lore.kernel.org/lkml/20240301082248.3456086-1-horenchuang@bytedance.com/T/#u

Ho-Ren (Jack) Chuang (2):
  memory tier: dax/kmem: introduce an abstract layer for finding,
    allocating, and putting memory types
  memory tier: create CPUless memory tiers after obtaining HMAT info

 drivers/dax/kmem.c           |  30 ++-------
 include/linux/memory-tiers.h |  13 ++++
 mm/memory-tiers.c            | 123 ++++++++++++++++++++++++++++-------
 3 files changed, 116 insertions(+), 50 deletions(-)

-- 
Ho-Ren (Jack) Chuang


