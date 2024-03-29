Return-Path: <linux-kernel+bounces-124163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C489133E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7182A1F21ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29623CF7E;
	Fri, 29 Mar 2024 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EqTcYTM0"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8A3C082
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690444; cv=none; b=L8VqsEaTY6jFkwXoktCCUyJQLmM+2fVcdZZzhHrGTkkLgT7tSD5VblZQof4AKHlH35uxaplq3hP13ff2B0Ua2Ff1NkvhiMpAXMtc1bw3NT/qgBiEPZPpQeDvXQn8gR/xpUIjj4n7Buy6X+ploem1JLl1r7dbA9cXZLfHwfQFXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690444; c=relaxed/simple;
	bh=ImreSG/HUgwp6aJbvn8E9oQAkoz2niDIQh3XRiMc0II=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TSIJlIyetQjp6H4iIIKMYLRCUA+K5ZE7fYfEuJJNzdm52SWlig23MAXwLDIBgjwPZXcGWv1AaIez0jgY98xQnPlDC8SdY9Fd7KzgECXjShOraBaHeBekaYGHLaFnMPTe+K9nPJRerqI9awRpA8ZHofjKTvj4atRCdFj6l+SS3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EqTcYTM0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430a0d6c876so10415361cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711690440; x=1712295240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzD9bp4lfPKjq881EZTr8X35H33UpZ0U2oJTGnZVwgs=;
        b=EqTcYTM00C/gUsn3XF2WJs1zcEhTVUJTRDacCzOOvnuGy84VQTaGKAWCo6q9cRzoOP
         fhnbjvTdPEo5XeecRjMv004VizxrCVRdVQ2KSW9P2mI70Fy9qjjDX0F9SQFeW5sPJRJ4
         CJjonR+ngB42q/K5SRVoHuXYyt51MJOXQtTYLDSRU3hiziXHsAZssk3f3eSuLRy7MG8q
         ZesBt57o48Z763QvQtqqDoLbh/wsBpmR47xRSbVDSCyzuXcV2IdewMwAYEjCMoMGeKtH
         /ruNv8kW+ZtHsJjSExd2Wb6NgEmkKVa//0okKd5HSnqbe+q6F2Zcqc1QjXFwj7ZTeCn6
         CaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711690440; x=1712295240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzD9bp4lfPKjq881EZTr8X35H33UpZ0U2oJTGnZVwgs=;
        b=OF1KoMeRFnmXKPvI03g9kumg63cpKoYOS32+rb93qlPRPES4uQEV8TZp1r2O6fpmkc
         As3alHBIgy01XtcSro/7R3UioAI6u7/l8ruHTeEe+xIgyzaFB6HFMzYSyxnldki7XBE4
         nJ9rKgv8Srl6mlYYmd7iVkk7fuc3jgBz1Y0N3VGK1D3i5TQT5JgRRF5NzQbPjaAwVo40
         dwf/6u930Iru81kL+Xx94uS2B5pvWOZf5K8zS/FfMG2UKOYUXiqkLLRHYO7pUCWaooaR
         ++jMgthSjIHQEEt8FA2p8wUeUaI0XIIhxOGGP6G3SISTDde8Snn9V55AW2IcTJRlfs9l
         g88w==
X-Forwarded-Encrypted: i=1; AJvYcCVSlXA4fRSVJPU3pa3uyjVpyavDcxefi2P+44S/gZfMZxxna+gzrfZ6ru/S2KWJ0WEmq9Nbx9zRCHuIpEb5zDWIjuZm17eA6ARHh40o
X-Gm-Message-State: AOJu0YyFKNWKkKQSurzdsOpqMjJPvcjrBveLdV15Q3UVr9uzuPisdig+
	lg7Yo4Jr9t7ZDLBM4PqYMRHmDSeBdLHpybLzIuwVtwIV0nHo+n+YLuIpb1+2NNk=
X-Google-Smtp-Source: AGHT+IEPCB5hxd4bBd3zlijyd5nzuuMHJJeNzrT0TX98AmIg0/OG0kaxC+8voIkqbdWtPzxYHjpC/A==
X-Received: by 2002:a05:622a:40e:b0:432:c50a:3d65 with SMTP id n14-20020a05622a040e00b00432c50a3d65mr152679qtx.36.1711690440563;
        Thu, 28 Mar 2024 22:34:00 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.85])
        by smtp.gmail.com with ESMTPSA id jd25-20020a05622a719900b00430bf59ebccsm1293700qtb.11.2024.03.28.22.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 22:34:00 -0700 (PDT)
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
Subject: [PATCH v9 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Fri, 29 Mar 2024 05:33:51 +0000
Message-Id: <20240329053353.309557-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable
from normal DRAM in terms of memory tiering with the current implementation.
The current memory tiering assigns all detected normal memory nodes
to the same DRAM tier. This results in normal memory devices with
different attributions being unable to be assigned to the correct memory tier,
leading to the inability to migrate pages between different types of memory.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the initialization
of memory tiers for CPUless NUMA nodes until they obtain HMAT information
and after all devices are initialized at boot time, eliminating the need
for user intervention. If no HMAT is specified, it falls back to
using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

-v9:
 * Address corner cases in `memory_tier_late_init`. Thank Ying's comments.
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
 include/linux/memory-tiers.h |  13 ++++
 mm/memory-tiers.c            | 125 ++++++++++++++++++++++++++++++-----
 3 files changed, 124 insertions(+), 34 deletions(-)

-- 
Ho-Ren (Jack) Chuang


