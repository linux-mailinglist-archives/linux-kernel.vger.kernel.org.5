Return-Path: <linux-kernel+bounces-164912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0718B84D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FD51C2278B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754C3A1A2;
	Wed,  1 May 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkogb5WM"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857DEED6
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537633; cv=none; b=J1mbCcZZdglwJtajJ3oSzjehtrwd6+n3epl2f7E52uv1jjb4tyIhGCWE5IZeA3VBnykMBTEYO65+RT2z85QhGf8E4qQkGSyKshFYtRgUxo1uG3UEaPHfh+qdPLRe4Y3uIcTU0gWq5V1Oo92pD2eei2FH/odMOdYzcs05SckA6HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537633; c=relaxed/simple;
	bh=aHre9Cwe/eLQ4im0PjuhhKvsiLtNMpbJZ9HeLhELhHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFi4fKmVmUj5WXXAF4lC2ncpOC7UXe+W3+5ZyoUN/0hMk99zvN30csbmSMRJOqKI9BKngZn8gRH917JYDrwF8/DazlXdv2TXStdNxQt3WiCgToZAndKyBemkXrCKvwZveGViCcGEJ/F/GTJc4xOXBNpogbjFQdYVvvsTsNrqCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkogb5WM; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-618874234c9so74288377b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537631; x=1715142431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=98ec+jViXsbQQ2xh2G7x7x/neBurum8aB5rqKPV5rEE=;
        b=jkogb5WMcvf3GBRja8rAKeH9NkpmoddLtAcekyehTnXwb11DYmUObpDcwNrEOzMOYb
         VrwbJ5GRN8XGBRmwtlh1IF8enmvAjrymE6kmcDf3ylVsIcuNO7EKj7abFyc3vliEP5Ft
         SWULPR+efg5OqSlSxlomUe6kq+mpAzQr3NdzQ5mc3ojFD4k3654b/Y2cWSJY3yTCu76/
         VQwEmXL6/VMvTdYERYbMbB2rIM8mt4PW8qqknYz4sf8bN179A9qd9oaQW2wqLTn6YtvG
         ln3P2FhCZUjRU/gbis6B1HOpu78STgUfTmwh27cbCtsG9nmVq1PlqZjMmiN46BJjMxtI
         /kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537631; x=1715142431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98ec+jViXsbQQ2xh2G7x7x/neBurum8aB5rqKPV5rEE=;
        b=d1CUgiSYIs/e0AWQs/xW/xsq2tx0fVURIZbx3XgQ47TWEkPsdxz7qEJBZ3qqABA8s+
         RsnzaN1NvCUuZysL4yvv6hCTjZ5PkB1/lq+needpkdqE4jD5zdWE3gRqUl1SJis7MSNH
         VTjju6ZDxXPTN3QHprPeSy+uHpSYcC0VlsTnPDGaJ/KWK9Od5CsOEvIDIo1DyoHmnmRY
         pm8Skkkl9xRBE+/SAJ3z0zxG3Y4tJynGODLve/YBl38/PFpAOUfL9V/vc74Z8EDgGh63
         7OnWs8Z7FatmD1fQqKtRcKU62C+EOlGltpySglSbrLh7dnPrEj3IcyEprdiJgLHtpU7i
         OcNw==
X-Forwarded-Encrypted: i=1; AJvYcCU0X5ObM2lnT6+MBnFtzgAogaZ2M4sCSJ2UXC3WH7a8b3mjYfgBATYn0OJFIqX+n9ywKSB7XLV4HzRbCFlHV84G/813t/wHMmSULT/m
X-Gm-Message-State: AOJu0YytMJZqQn0TqvSGG8uY9RZaHv2FQ3DqzDExWLecRik4JQ/XtaRC
	G1Z+7tIb+KTPyROBzESAwTdhbtJvHhLbyDlIJSXPDdzZ5cnSQEYZ
X-Google-Smtp-Source: AGHT+IHvowBnNqumv0l7fBeB+9uEso4P+IK8K5UtLCH8iXyLnfehmiGproDsTQ+1wyUaRyOSgENU+w==
X-Received: by 2002:a05:690c:7090:b0:61b:33fc:ad8f with SMTP id jg16-20020a05690c709000b0061b33fcad8fmr1363257ywb.45.1714537630732;
        Tue, 30 Apr 2024 21:27:10 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id m15-20020a656a0f000000b005dc4806ad7dsm19165970pgu.40.2024.04.30.21.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:27:10 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v4 0/3] Reclaim lazyfree THP without splitting
Date: Wed,  1 May 2024 12:26:57 +0800
Message-Id: <20240501042700.83974-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series adds support for reclaiming PMD-mapped THP marked as lazyfree
without needing to first split the large folio via split_huge_pmd_address().

When the user no longer requires the pages, they would use madvise(MADV_FREE)
to mark the pages as lazy free. Subsequently, they typically would not re-write
to that memory again.

During memory reclaim, if we detect that the large folio and its PMD are both
still marked as clean and there are no unexpected references(such as GUP), so we
can just discard the memory lazily, improving the efficiency of memory
reclamation in this case.

Performance Testing
===================

On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
mem_cgroup_force_empty() results in the following runtimes in seconds
(shorter is better):

--------------------------------------------
|     Old       |      New       |  Change  |
--------------------------------------------
|   0.683426    |    0.049197    |  -92.80% |
--------------------------------------------

---

Changes since v3 [3]
====================
 - mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
    - Resolve compilation errors by handling the case where
      CONFIG_PGTABLE_HAS_HUGE_LEAVES is undefined (thanks to SeongJae Park)
 - mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
    - Remove the unnecessary conditional compilation directives
      (thanks to Barry Song)
    - Resolve compilation errors due to undefined references to
      unmap_huge_pmd_locked and split_huge_pmd_locked (thanks to Barry)

Changes since v2 [2]
====================
 - Update the changelog (thanks to David Hildenbrand)
 - Support try_to_unmap_one() to unmap PMD-mapped folios
   (thanks a lot to David Hildenbrand and Zi Yan)

Changes since v1 [1]
====================
 - Update the changelog
 - Follow the exact same logic as in try_to_unmap_one() (per David Hildenbrand)
 - Remove the extra code from rmap.c (per Matthew Wilcox)

[1] https://lore.kernel.org/linux-mm/20240417141111.77855-1-ioworker0@gmail.com
[2] https://lore.kernel.org/linux-mm/20240422055213.60231-1-ioworker0@gmail.com
[3] https://lore.kernel.org/linux-mm/20240429132308.38794-1-ioworker0@gmail.com

Lance Yang (3):
  mm/rmap: remove duplicated exit code in pagewalk loop
  mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
  mm/vmscan: avoid split lazyfree THP during shrink_folio_list()

 include/linux/huge_mm.h |  29 ++++++++++
 mm/huge_memory.c        | 115 +++++++++++++++++++++++++++++++++-------
 mm/rmap.c               |  67 ++++++++++++-----------
 3 files changed, 160 insertions(+), 51 deletions(-)

-- 
2.33.1


