Return-Path: <linux-kernel+bounces-56832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628B084CFE5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A44C28AAC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75DF83CC6;
	Wed,  7 Feb 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="Er00PaUp"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38482C64
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327669; cv=none; b=UyN4vDXq6+Z5y4X3emK+0lxIytAPhwKQuMtqxTJMdl+h8KwyD4zFA7faaF/iSUdxFBSg+c9+tupluXgEiofYi2cCRORmLO7InltyMjl0zpKVH/F4niO9NMo7vqZfC0uVwj0bPvrcfkurU8tETiAmU+bqJW1sni9mnf3NKLB47jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327669; c=relaxed/simple;
	bh=Pts1Ollg+kHIJn7gcBTh60hwuP/+5EbYctTIjn8gNGo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W7wBDLLSlCgvjwOdzy+HxXRk4u73rmr4FTaVXSTrwQwyjkVZ6kPvs04zihMp3VxJQDjB8/uuI1YXLMnt5FAVrppJO3dJRYNkvoETea2Ri+yzZEFKFeCp5OZab5F5n2uf85aUA/AhI5CefP8oZUJjetQmcBKOEemV+QiRH3VQHC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=Er00PaUp reason="key not found in DNS"; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60492003050so8625657b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707327665; x=1707932465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=si3iSYQzW/wS10JKxA6PCTvsO4f4p9drxSnRwVUScZU=;
        b=Er00PaUpSH/5jhHWznyDOQ1DfmcMQSAL15LHJFisVQQTL/nGgEfw+XgJx5X6dgsQ4q
         RU9qdlHpmxcCfGn7HI1DyVo31+NSJKzE/Or8OrD1m3mcDlYYAagUWBnNbO/btxSw5XOH
         Lqz3GWZCgo435t4YvZ3qhm1i+hy0IbnfaqdGS1mbvpXD5sdasMvQVyHJ3czkuSXYXJmk
         gsMiK+/+9YC6Vo/68DLNFPezjHxHHBb33m9BAEimpFiLS/+7VNZKN+127ZIfPRxgH+QD
         wOIxgMi2K2onpDYo2mBpHLB/t8iRvJ2BplzJhnoq0WLNJ0+uMKueyXMLDwdD+Hl1ad/U
         2UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707327665; x=1707932465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=si3iSYQzW/wS10JKxA6PCTvsO4f4p9drxSnRwVUScZU=;
        b=KhMZqsRhRWK/hUfm65ae8vqUjwWnLN3ZvrZuFi8f4jvyMG+0wd7D3Bc02J8g/QODYb
         K2c3jmTVchdrMB9YHv7KolXWVnwhrjoSkN7dxNbbibi5/TVQhR3yQJ4o38jGUR5/VGNg
         feqn7wxMTRmmSzpGPJE070Rvit6v/ThTuOsEW6p0Xa5nkV/E7yE+6ysWZmnVBSBBo+g3
         VQMuWsDUvACwXJ6jDefd7gBqcvuf3CAdKVwP9hdSgE4cNfznYX1EF4mk9Hp2hyanQVIx
         aHveUXj089JGAsksfwXPgkkHKq/EQ8u4LEAQ+mV/nfX8kEqaUd0pC/LOKf/vI/zRcqTq
         XzZA==
X-Forwarded-Encrypted: i=1; AJvYcCUybzF07HezVgXCslhfKuzXgHxvfs7YSDOTfjdyMz8kwECUtAxKZ2ZAbCzGaIhJK5+UANQL15PgPZjD9rZCQz7fGmOpnuSVkz7lA54I
X-Gm-Message-State: AOJu0YyQTk+JLyr3oUkV7Lw38I5a9cbC2dIcIiInjwjm3WMB3ahcKzZS
	J6t7JBTexb6ty4AGRpCtRynMKfw66ZFFa7/RSVcM+EC6VJQ78CR6vkBsq8St4jo=
X-Google-Smtp-Source: AGHT+IEEHU0Zq486UjgccXih/doHmjMJ7ii4hv+46i8KhFxxFLmJqhnzWQ3qz8k37AV1xp4vGAJu6A==
X-Received: by 2002:a0d:d641:0:b0:604:9fd4:a0ec with SMTP id y62-20020a0dd641000000b006049fd4a0ecmr668771ywd.5.1707327665531;
        Wed, 07 Feb 2024 09:41:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkpA1e8or7NcUr/WsWjrzjdXlKnYP7Brox9OXywH4gDbvfn48o3nQvHRI3pVbQX4O+aXkOe6P1Hn3x8IUM5XVB16c5XA7JXuzZH5fDUuhC3U9N1bfEbkfjgV7/xqboIkaeaOm372F/MkZZVEq0wEc2DJuJkyXvpBTbqVylv+rD5YWo0/G+Kg3OD5182kxWb9kzCZ+UE/n0vaD+CRG2C1kuzz4SmrQ6NdqQbHPuKYn6WxVgQS1Scls5HHdhjkF410H1Jnetb2wUH9Vej4DTNp8scc0RM4g+s3dGiuedxcYwU/O4lWzNLDnUo/WA9DCIOYKmjzvnmxeBED3dOwxSJ7FMF3P7X+3ERyu7sWGAfJMo4dSW5siDWi6HZiZ5MqA9leEV73ZV1Xm1wucVQ9wsQHZulJm4UYSoAVTYaQ9clHXTJ+boA8TvSi+pQFaIkTmzILrZcCnP/v9+gZF2G3b2d2KFGmqYSgG0gGaeKeptMhY5zBZ5TXiR5vMzoVLgPLdposs2r8L4pNbOEWF0zi6izX845ny9/Y8ba709mNUr9BsTXTdpXOH32jdwZUB1rRUPT4dFPtw6nyl8BmXWI3DBiZnpBu47RgCKYnZfBSXFi2q0ZTfGpY6vkE0+pNUelxzhMwP9YImd8mz8ORz8gfk0sj2DMsm151dgQmX/uC9RcMuoN0PSwo42yRz7KspGOG5eic/E2f2nSxwgMyWgDE8l4BZ6AqGYqlwpCJ66J1Li+1ikKsc722qVzr+fdFigDGJDZehHFCM8B1EdQjx8ub/jH9/P26lDifl1VjFAc3AA4Kvvsyo6yhiOJofANrUTNPO6SqS0jzDMXufYMQZIoY+HTiBjvj6aFjyMPao63IIQYiOrKr6uAeYBxKTyEUYAz6+FQVqHMG28i+uK+/VCIFl4wemd2x3yQ34RfasOYy5M2vSNaEUDOn3DeO3cOzE+rNZYkpbwNh
 uQLZgO5OgShpDB5RC7nx4T4vJMHBLV4gdTrXKpcq5xKTKPg4L5nfJnheTA51MSe4dZHDfknxqft58Yp2qBaw3tvo3OmilhNVPPJyw5F7OKhNnu0H7PXSEV9GbfUQKNfMuv2lOfWpHHyZl+skgBoEfMVKO2/jKOJPnWm8ioObQVd6L2344T1EtRFasW0zYPwG9TQRQE+RZfpHFZr/v5NAy7nVe2HWfQmZ+TNHgtBJ8saOFbD+lqsTZ7loaKSaE51S/rACmqjiUEXw9S+tAJKyFQ8s6HaQikjgoPGoTP71vIid3a11OqK/EgMvScjkeqG0vU9tuvtXKomcd+gn/P3WY+qXKHpd9ClUllsbc/g4f39izeoO+NuBgrOyc8DAKyHdSA7OvsYgwTXHlopChDAFWRMic7m+I6ke8MGRJUTc5D9/kmWyxIE8uXkDBqWdSKuVjeQqEFojdrrbHmALXwMRaHOqgrUm+TD21Sq/eQwjWSfH+Z
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b007854018044bsm696310qki.134.2024.02.07.09.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:41:05 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v4 00/10] IOMMU memory observability
Date: Wed,  7 Feb 2024 17:40:52 +0000
Message-ID: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

----------------------------------------------------------------------
Changelog
----------------------------------------------------------------------
v4:
- Synced with v6.8-rc3 
- Updated commit log for "iommu: account IOMMU allocated memory" as
  suggested by Michal Koutný
- Added more Acked-bys David Rientjes and Thierry Reding
- Added Tested-by Bagas Sanjaya.

v3:
- Sync with v6.7-rc7
- Addressed comments from David Rientjes: s/pages/page/, added
  unlikely() into the branches, expanded comment for
  iommu_free_pages_list().
- Added Acked-bys: David Rientjes

v2:
- Added Reviewed-by Janne Grunau
- Sync with 6.7.0-rc3
- Separated form the series patches:
vhost-vdpa: account iommu allocations
https://lore.kernel.org/all/20231130200447.2319543-1-pasha.tatashin@soleen.com
vfio: account iommu allocations
https://lore.kernel.org/all/20231130200900.2320829-1-pasha.tatashin@soleen.com
as suggested by Jason Gunthorpe
- Fixed SPARC build issue detected by kernel test robot
- Drop the following patches as they do account iommu page tables:
iommu/dma: use page allocation function provided by iommu-pages.h
iommu/fsl: use page allocation function provided by iommu-pages.h
iommu/iommufd: use page allocation function provided by iommu-pages.h
as suggested by Robin Murphy. These patches are not related to IOMMU
page tables. We might need to do a separate work to support DMA
observability.
- Remove support iommu/io-pgtable-arm-v7s as the 2nd level pages are
under a page size, thanks Robin Murphy for pointing this out.

----------------------------------------------------------------------
Description
----------------------------------------------------------------------
IOMMU subsystem may contain state that is in gigabytes. Majority of that
state is iommu page tables. Yet, there is currently, no way to observe
how much memory is actually used by the iommu subsystem.

This patch series solves this problem by adding both observability to
all pages that are allocated by IOMMU, and also accountability, so
admins can limit the amount if via cgroups.

The system-wide observability is using /proc/meminfo:
SecPageTables:    438176 kB

Contains IOMMU and KVM memory.

Per-node observability:
/sys/devices/system/node/nodeN/meminfo
Node N SecPageTables:    422204 kB

Contains IOMMU and KVM memory in the given NUMA node.

Per-node IOMMU only observability:
/sys/devices/system/node/nodeN/vmstat
nr_iommu_pages 105555

Contains number of pages IOMMU allocated in the given node.

Accountability: using sec_pagetables cgroup-v2 memory.stat entry.

With the change, iova_stress[1] stops as limit is reached:

$ ./iova_stress
iova space:     0T      free memory:   497G
iova space:     1T      free memory:   495G
iova space:     2T      free memory:   493G
iova space:     3T      free memory:   491G

stops as limit is reached.

This series encorporates suggestions that came from the discussion
at LPC [2].
----------------------------------------------------------------------
[1] https://github.com/soleen/iova_stress
[2] https://lpc.events/event/17/contributions/1466
----------------------------------------------------------------------
Previous versions
v1: https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com
v2: https://lore.kernel.org/linux-mm/20231130201504.2322355-1-pasha.tatashin@soleen.com
v3: https://lore.kernel.org/all/20231226200205.562565-1-pasha.tatashin@soleen.com
----------------------------------------------------------------------

Pasha Tatashin (10):
  iommu/vt-d: add wrapper functions for page allocations
  iommu/amd: use page allocation function provided by iommu-pages.h
  iommu/io-pgtable-arm: use page allocation function provided by
    iommu-pages.h
  iommu/io-pgtable-dart: use page allocation function provided by
    iommu-pages.h
  iommu/exynos: use page allocation function provided by iommu-pages.h
  iommu/rockchip: use page allocation function provided by iommu-pages.h
  iommu/sun50i: use page allocation function provided by iommu-pages.h
  iommu/tegra-smmu: use page allocation function provided by
    iommu-pages.h
  iommu: observability of the IOMMU allocations
  iommu: account IOMMU allocated memory

 Documentation/admin-guide/cgroup-v2.rst |   2 +-
 Documentation/filesystems/proc.rst      |   4 +-
 drivers/iommu/amd/amd_iommu.h           |   8 -
 drivers/iommu/amd/init.c                |  91 +++++----
 drivers/iommu/amd/io_pgtable.c          |  13 +-
 drivers/iommu/amd/io_pgtable_v2.c       |  20 +-
 drivers/iommu/amd/iommu.c               |  13 +-
 drivers/iommu/exynos-iommu.c            |  14 +-
 drivers/iommu/intel/dmar.c              |  10 +-
 drivers/iommu/intel/iommu.c             |  47 ++---
 drivers/iommu/intel/iommu.h             |   2 -
 drivers/iommu/intel/irq_remapping.c     |  10 +-
 drivers/iommu/intel/pasid.c             |  12 +-
 drivers/iommu/intel/svm.c               |   7 +-
 drivers/iommu/io-pgtable-arm.c          |  15 +-
 drivers/iommu/io-pgtable-dart.c         |  37 ++--
 drivers/iommu/iommu-pages.h             | 236 ++++++++++++++++++++++++
 drivers/iommu/rockchip-iommu.c          |  14 +-
 drivers/iommu/sun50i-iommu.c            |   7 +-
 drivers/iommu/tegra-smmu.c              |  18 +-
 include/linux/mmzone.h                  |   5 +-
 mm/vmstat.c                             |   3 +
 22 files changed, 397 insertions(+), 191 deletions(-)
 create mode 100644 drivers/iommu/iommu-pages.h

-- 
2.43.0.594.gd9cf4e227d-goog


