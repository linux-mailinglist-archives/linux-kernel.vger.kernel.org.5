Return-Path: <linux-kernel+bounces-162357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22118B59C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC41282F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0057302;
	Mon, 29 Apr 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb2sPXRY"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9A548EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397003; cv=none; b=pVKax7atY5Bi0gcQksa5daehpz1Ce37ti4Sh+ZmXkDVsfnp0gKSspBmCiiX/qXW5urQ8sAcP1fNFH9yWcjKBUG1dYW8o/gnnnd40hZjU8EBcHMvWiEUyYBOOpEj7T0muLia9r9j4G1RllGTiUiCQNAolTGMZkFfj7mR2cyWVGYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397003; c=relaxed/simple;
	bh=Kes/RpeaM6LVq/t0id2xze5x4OW+FfQKx7uRWMYQSnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZWqbU1CHhM0ReIJ2OBICSrzCftJPoTLmaDJGH4NwOyNVNS6GnjxIYC7d4aD42gLcGQaMCcJnJ57jFGUh60mLy5wtRGT5Gw7KtgPVKJRDp8j5sUj/1ggj3KXRcqYkFco0Gb+UvpCEez4H4xTfuk3owCpDrhOPCrPmedcdU6KWFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb2sPXRY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-602801ea164so2968472a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714397001; x=1715001801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIUyZIi7TzY1sCJM9AY9M3QfemgaOle6/RPmVuxxVxA=;
        b=Mb2sPXRYnbkjq8w9Uk/lIsJNl6DcSTs7XxqNXqkKhx1mzUV/WzQSAZWkJoEbsVlEWa
         vn8ok41j5EmcowkC594ubbhk5k60l4LUZmv+8SD1l4BTH5PGACwHUIBd7Oal18E7VX8G
         T1OA52MmyS606LcURIK3lRD6JsJ1+DxlFYongvpSO/MhDsldvYyK2CxZ5KvbSOrHTcGT
         Vfb39qSB8jg4ak83YpfEr1BoQ+587dVumtmu/XtrRWaeJTp2OOS61PweoKUkexQDEzNS
         IeAc1j83R8JFMuF7uO/5qlKXDbrBt6DtDKjrae7o0gQKyN5rP2ErejTfoW4SsCd5A56U
         WMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397001; x=1715001801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIUyZIi7TzY1sCJM9AY9M3QfemgaOle6/RPmVuxxVxA=;
        b=kQntZtDobdmFD4PxXYda1568xrf3aPRiLU+0/y8pJqHvNTiS8BGDueUORiQH/asta4
         ytudJw+46SSxC0q3qepIVEcCTCT7G4A5XhhOztbIc5JpHIRXRUc24I59upmu9mDon86H
         5m3SYQl4SRp9+bX+MIwI4+/j4sj0kSwoZI7BdCkg9ZQ2Imi7NViJK1+B06LUyc/K43of
         ZFKeh0runudy2h2dRFl13zDiwTIiEhz2jcjK1FOoyrHtEcyArQa+Wgn0kCzMNTYStl0t
         Xv39/9ertdAHHP/y8/6mPLNUETfQXR6n82PABsq/Dr+LrMGUnKJYCz5ldNXnIjhPefIV
         fqNA==
X-Forwarded-Encrypted: i=1; AJvYcCXfRGFFAzzvCJXFLm5ZUU3qAz6zsACECXshw7258PXvpca6kxgKAfobq0TDSM7KIF9f7W9rCw6hnw3I3raD8Ro9q3eIkD2NUXRqnXgJ
X-Gm-Message-State: AOJu0YxWnVwUhMV2T/lBV7vSooZ05G8VaoyRDSQQo+oDjVCbeI9MaYxQ
	0iV2gac8Dof1YVQmmIbhkD+H+Nqp2EFxz1GNPcukn0VeC82bfI0v
X-Google-Smtp-Source: AGHT+IGCo9M+a2pMrkha4e/8Rr8qhMrUJ+s7wzyuSxRDLnHms8qMV3zHtJCRRj8F9yPHPGVyB/vniQ==
X-Received: by 2002:a17:90a:6c88:b0:2b1:bb1:7061 with SMTP id y8-20020a17090a6c8800b002b10bb17061mr4615812pjj.44.1714397001267;
        Mon, 29 Apr 2024 06:23:21 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.242])
        by smtp.gmail.com with ESMTPSA id pa5-20020a17090b264500b002b113ad5f10sm3562203pjb.12.2024.04.29.06.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:23:20 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
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
Subject: [PATCH v3 0/3] Reclaim lazyfree THP without splitting
Date: Mon, 29 Apr 2024 21:23:05 +0800
Message-Id: <20240429132308.38794-1-ioworker0@gmail.com>
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

Lance Yang (3):
  mm/rmap: remove duplicated exit code in pagewalk loop
  mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
  mm/vmscan: avoid split lazyfree THP during shrink_folio_list()

 include/linux/huge_mm.h |   4 ++
 mm/huge_memory.c        | 117 +++++++++++++++++++++++++++++++++-------
 mm/rmap.c               |  69 +++++++++++++-----------
 3 files changed, 139 insertions(+), 51 deletions(-)

-- 
2.33.1


