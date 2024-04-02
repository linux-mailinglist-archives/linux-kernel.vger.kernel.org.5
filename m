Return-Path: <linux-kernel+bounces-127234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E893894867
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7CE1F21B36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03816DDD8;
	Tue,  2 Apr 2024 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DppPx11t"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DEDF5C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017065; cv=none; b=byPlUts0CvsekGeeQBT63ntLvlYsuwaDweTcZO8R9iBgEu6POHOiyS/E8S5dTnYe20gVwv08eXPXu690WdEtS9+J08F+bOs/P/RU0jDjY6+/NLhjV9DH5FTiE52VzXCFrGuKiYfc//hUk3drPTDPhbU0pmxDDJ3qHbF6qWcihuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017065; c=relaxed/simple;
	bh=SCrDUhEkZxFSPTEl/r8bXpDqiMbz+gOCwj9dhEfB9cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lkrlwfZ4pmgc9uKjp1vaFLbc4nagKURv8VPBUWlUw/KgL1PvnV3ju1wqAA9FezX7d3eg9gb1rCFgYuSo7E+pDP2bbRcVSxiabnCGRL+kx9LsxlvzkCnj+U5kLQLPXH6E8nkroYQn5Grh046B4Yweg3vd3asdpBJmV8L8TEEq8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DppPx11t; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69185f093f5so32638026d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 17:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712017062; x=1712621862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gW68csmOvBMTYM9kf5jTmocSt+5Cfpv4k9wOl9BtKJ0=;
        b=DppPx11t72+V7A0l0F9uCwbUMJ3EgBIJy3TQLpBd9vvlQv+TRQLQ+cAcXeZx/o7s6b
         SpdDZN0dewMSrJgiP+uRfgBwC6AdKXuoFRIXbiRVZ56jVJPi99NmhXl2FPMRL9U5bC7O
         vn3RiPH6D+vdVvYI6bfi/yNO7LDkLy32bzayH+mnZCHRbch1n9HcLl2+S6FS79P7ffo4
         OiCYZD/GgO873tdhxuxut4OpJzbP5XKTMxW+VcnsFPTfuFKpWGyLFFTdbe0YoWwOoG5u
         00OBm/n6OniAr1mgwdWr3h+5W0+SR7WdcR3zXGsAoPpDJ7ob8c4QypMbV10J712BSCNT
         kMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712017062; x=1712621862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW68csmOvBMTYM9kf5jTmocSt+5Cfpv4k9wOl9BtKJ0=;
        b=eeMNX7iqHW8AFw18+Rxgg67EvP5ZqT+q5Igbh9K4ZpLoc0o/HgVYt2BKGTm32Mii89
         JuksgG9gWKwrIFs27g4J6NFmIIdpc98TZe3mcFncn4DfAnIXMQFOiVddSFv69DXwI/5O
         h/2ODodC2ZyFu3atSIW6E/RmPgTcDma2uT4ItXbHM4n61tS71xNhOcySTReh12n5rGNx
         dndV/x0/shrQjMk+w2OBTXJEz6WzHkc/Gczes2Zv9Rua0gh/e0DkrbSTJi/Pg+6k3Ist
         GrRxdIHKx7fcFOEEsVW5IzP/n9U4KSm4Ls2kot9yvbVWNfeH0Fm1rKF4WrtvOfA+ACuV
         0RrA==
X-Forwarded-Encrypted: i=1; AJvYcCVUf56a1kEyEMbL05ACW6aIfqRwivDWGdKaNWKag8luu+JrlOx/4ddr+f9bDn34Cis7LIc7ONobwS36l3GG/rwABrw5feHNyjpfb7xl
X-Gm-Message-State: AOJu0YxhxmZmjp4w7OUavgTx5LmIq8acvSog3wK3vRAu0YHzUSqvLiQ+
	SicPAT5HeNqHCWR8HhIoQUvlRAHsny4aClgYj5LIhnX7R3zamu/SzpncivLyat4=
X-Google-Smtp-Source: AGHT+IHI1NovuRSzlyW3MYabIw0PVUmZGVgQf3UfVLAx8wFoGSl+V+dNtBDwUZKth1SSmnW9MKt4eA==
X-Received: by 2002:a0c:f707:0:b0:699:bbd:7976 with SMTP id w7-20020a0cf707000000b006990bbd7976mr3538796qvn.22.1712017062196;
        Mon, 01 Apr 2024 17:17:42 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.125])
        by smtp.gmail.com with ESMTPSA id e10-20020a0562141d0a00b00698f9771822sm3013112qvd.83.2024.04.01.17.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 17:17:41 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
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
Subject: [PATCH v10 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Tue,  2 Apr 2024 00:17:36 +0000
Message-Id: <20240402001739.2521623-1-horenchuang@bytedance.com>
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

- v10:
 Thanks to Andrew's and SeongJae's comments,
 * Address kunit compilation errors
 * Resolve the bug of not returning the correct error code in
   `mt_perf_to_adistance`
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

 drivers/dax/kmem.c           |  20 +-----
 include/linux/memory-tiers.h |  14 ++++
 mm/memory-tiers.c            | 127 ++++++++++++++++++++++++++++++-----
 3 files changed, 126 insertions(+), 35 deletions(-)

-- 
Ho-Ren (Jack) Chuang


