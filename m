Return-Path: <linux-kernel+bounces-120291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599B488D568
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF33429B9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F923765;
	Wed, 27 Mar 2024 04:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BvJrjiuz"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C923759
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711513013; cv=none; b=grfFaImmwSR4aT8RjaW6th65BVZRWJu3k5vbfzuqwrvT9NroxXy1Mwl9Jrqrg9hetmp9JonEseItULSYShoKTLbSoClv9ppgrl/1QVdhzFUlURYdFOZBgWeaXTOwpwukJTrvs72D6MTr0W89KCxZxlvQIqmTkdTyoUf0fsGGgTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711513013; c=relaxed/simple;
	bh=zcsNrVfji+EEPmbTMnRib8noXYuBhV9F4dhJWkO7jpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qXMSZMJ/eI90h5rkTtWm3tyM9ySdluuk3HmE/Oa7vejFEW4SXzd8xRgoy7b+uBmyq+O+PoZbX5uHDxyowILuYznetvxLtaoA8bbTf8cp3UJoe1/Xd+KCDr9LiOSYNLDKAhLOGBNLGmCoE816LMbYxMgmrAC1XlHPV8PbnJezh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BvJrjiuz; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430c63d4da9so44654301cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711513010; x=1712117810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMdVp0KhU9BZV6tV0/g9FLJmEvDvjHVVK/qsvqbWJ7I=;
        b=BvJrjiuzjdl4nbixdUKeAR81PJgx6qef1U1toS2O0IfHDXviWVHO71GWoKDEtuVsgG
         ZxHGheX33SPOhV6tzupeAWI3oPw76l7gMofSjAgiJNwvwIpNypI8ACjrXN/dg5FA2eQw
         zZq752vxKupinF1RGHRDn/sMVAqk0IgPetzQfaaDbQArtvATROxWHxxNSPxq1QLuDEL8
         qL1lFA4NtZSa0hWxLKfbYH0vCyrr8IlK8E3sPdgae4/DotmqCQIeNgWKYPFjBaNLqbSt
         wNsHmNMq74SkqdL6cy0SnpsDyaDSyoHC5IEf+qqPr6iqAVd0swVu04N1048XwGx+wNpV
         3Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711513010; x=1712117810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMdVp0KhU9BZV6tV0/g9FLJmEvDvjHVVK/qsvqbWJ7I=;
        b=Ksh3BlaPTT15UrKXFqEvcPmE9P4l+D9O9ByCi0ibjdgiKmU+xPTKe83FMFCeFI6x4a
         xSA/t/3fySY60jOCY09xOqZ0lbU+QgZnWuSHlGsnyEeD89AAH3uhnIr6bgGstZqDdYAl
         UIVEVUUO7/yjc1jF30QthrJ36KMhA1cWztere8DZXud7LC+x8eL+dDMkqF6NJwb+xMuA
         4lOgt2ZCk4TF5tit7f0oaOuz4LUPiuuBwOXEXn/VM44ZayiljbsNNVndsdVJAFMiG97L
         Lpyl4wUICAMqEQL7jmqUiOzesYPsQnSAiTbYjkCcHKK+C2C3r2iJWIRttTJK8XjzE6bR
         ORsw==
X-Forwarded-Encrypted: i=1; AJvYcCW2zUZ945BD/lRTOjWAkGrlwOIkAq3FMnhcrG3343NArDU6ZhSvewfdM3Y7ydzsGScyE7GLqncEJFBftE5L+7vATQo822OlBpHLQFqd
X-Gm-Message-State: AOJu0Ywy7chzOPv9ynSBAci8BEpT5Ts82rB7ddUM2c1UYKGtkSDF73Dr
	EzlcHDxgrBepZQasLs/UDgDcBpcZH1cUwCwxMmwaheRN/fIjBQJRVJ/RciBgKHg=
X-Google-Smtp-Source: AGHT+IFPKIzBXhDWX0vwwecPPOx0TLesoDld5lggWtVvDT+Jl49ZpjG37mTEKqJH3a4f9GmGUE7nhA==
X-Received: by 2002:a05:622a:407:b0:430:f228:5f87 with SMTP id n7-20020a05622a040700b00430f2285f87mr3797120qtx.31.1711513010098;
        Tue, 26 Mar 2024 21:16:50 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.93])
        by smtp.gmail.com with ESMTPSA id hb11-20020a05622a2b4b00b0043123c8b6a6sm4370696qtb.4.2024.03.26.21.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:16:49 -0700 (PDT)
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
Subject: [PATCH v5 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Wed, 27 Mar 2024 04:16:44 +0000
Message-Id: <20240327041646.3258110-1-horenchuang@bytedance.com>
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

-v5:
 Thanks to Ying's comments,
 * Add comments about what is protected by `default_dram_perf_lock`
 * Fix an uninitialized pointer mtype
 * Slightly shorten the time holding `default_dram_perf_lock`
 * Fix a deadlock bug in `mt_perf_to_adistance`
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
 mm/memory-tiers.c            | 117 +++++++++++++++++++++++++++++++----
 3 files changed, 119 insertions(+), 31 deletions(-)

-- 
Ho-Ren (Jack) Chuang


