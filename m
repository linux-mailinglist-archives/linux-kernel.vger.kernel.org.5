Return-Path: <linux-kernel+bounces-161545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BB48B4D8E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F541F21238
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155AF74422;
	Sun, 28 Apr 2024 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWilYCzn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8E10F1
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714330919; cv=none; b=qY0tzdrPSDWRTSWcsRIIji7jhGrGdlTPyyyOv9vN18Qw+TJ1mK0WjfOipyzJyCfnG1R7/7bZJdjbuNjYCKS+n9U28anCig7u1xg72xDzL0DVo5IrjgkZJ8zSQv7vfbG+DAJ5ykbaI/N1mR8ierDwBuJTWKBsJZueb2ZqwWiS5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714330919; c=relaxed/simple;
	bh=RIQw26BWThK3J1ibTcR5IgYR08UTehW3GYYYG9XrKhY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dMN3sHBpKOLQ34zYfMhriP+trJXD5pmXOaUwNVAxHYC47ReQRLMHc4a4Nd5TiAjobd03H+3IK84ogv/LQPUDWvtYOsqRlynj0M2jBVHK2lyaf5NnYrpufmKOMGq6bETqyGZtP7s0Frn6Us1UdmDGAiuLUb87lTRLavCfc1gh0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWilYCzn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714330916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pkigxwzJ0pF/T4NqveAQpx8gjiN35IK7jok4Q5z8klI=;
	b=HWilYCzniiS/dajtY5AbmQ3AI6fAYAc1Ps3QbkQJaaQpO3ZiaEhHICnA0l1VfpVS/4CW4w
	RNba3rP4im6E3cglfZhV2VZlEHI52rDFNw/umLkNgxqEZkPLUwcLy2mId6y7K5tG4jIJiK
	j2lk+YxQROGbHX1paw0uBf1b5YdKo2E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-cWRYfkhGO9y7x8siwRjuxA-1; Sun, 28 Apr 2024 15:01:54 -0400
X-MC-Unique: cWRYfkhGO9y7x8siwRjuxA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43a3632d56aso15798091cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714330914; x=1714935714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkigxwzJ0pF/T4NqveAQpx8gjiN35IK7jok4Q5z8klI=;
        b=NHmi/ZD1QDYkt88rU61jklgFfd+JgIg/Ej2Stjf5iIhM4R17/3jHLTvDIYpiXGpGt9
         sogFXZ1soX2kmcAu6Ypk+xLCudoq/Bjs9dP32msE7GxAcZIY7C7o9JGdeKAcFnFDL61W
         F2RHRp1tCRap1S+pc/tbmOkdeA20pluxy5qbbglsRxhtiI+fufHMlkoNbdwfH1Y+xuqE
         3LfDEp7JPVaZywhwuQQmYh6dr/EXofdUnE6Z54Tlof/Xi7J42ZO7CSwUi+Whn9SV6V/J
         bZEbXZ3+z+ulg4r7l/gZPVfdulp6bqh/HQXkGXFGKRRSht/OHywa4jVimd0fP5JemCZR
         OYpQ==
X-Gm-Message-State: AOJu0Yw3YUuSpHrmMh+/kmrxjCSGN3wb3d/mvq5JbMuLsMK1pQVdfmyH
	mXBU1z6WvHBNWHaZAkbgxfX0u4zj5ccOvsmiI9RL8Nvl+tdrjgirOB12euSgyu3bHQce+ZyBScS
	pEAigEKL2k2VF+Yaq22RQSouARJkahXx3+tybpLU2exRGdY7tKUZVnvjpdUlxNyrB4hwbK3wOns
	pjXkGX/mtuD79VNeopNjQcWJziH1ezWNNzwJDtA67O6wA=
X-Received: by 2002:a05:620a:17a0:b0:790:e83a:e6eb with SMTP id ay32-20020a05620a17a000b00790e83ae6ebmr4022635qkb.5.1714330913873;
        Sun, 28 Apr 2024 12:01:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc5kc0cZSyusKzQeLAgeOYcB5BLCEjzPmI8Bn8/lrUkN7IeJKwQ4CrGxFGrgIzhwqWtQQFqg==
X-Received: by 2002:a05:620a:17a0:b0:790:e83a:e6eb with SMTP id ay32-20020a05620a17a000b00790e83ae6ebmr4022591qkb.5.1714330913186;
        Sun, 28 Apr 2024 12:01:53 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id oo8-20020a05620a530800b0078d693c0b4bsm9818152qkn.135.2024.04.28.12.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 12:01:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 0/2] mm/gup: Fix hugepd for longterm R/O pin on Power
Date: Sun, 28 Apr 2024 15:01:49 -0400
Message-ID: <20240428190151.201002-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series should apply to both mm-stable and mm-unstable, I am not sure
whether it's even applicable to apply on mm-stable directly, but perhaps
not urgently needed either.  Anyway, it'll apply to either tree.  It also
means cc stable is not needed even if I had the Fixes attached.

Patch 1 fixes that bug in mm-stable, patch 2 enhances the gup_longterm to
be able to discover such issue.

In general, the previous hugetlb rework [1] on gup-slow introduced an issue
with R/O longterm pin.  Nobody yet found it in either a real report or test
case, probably because our test case doesn't yet cover it (not before patch
2), and it's also a pretty rare path: it only happens with Power longterm
R/O pins on a page cache that is installed as a hugepd read-only.

Please read each of the patch for details.

I retested "./run_vmtests.sh -t gup_test -a" on a Power8 system with a
Power8 VM, with 16MB hugepd hugepd entries installed.  Note that I tested
exactly the same matrix before, but patch 2 will change gup_longterm test,
so it's actually slightly different test carried out, and the new test
(gup_longterm.c, when apply patch 2 only) will hang mm-stable on Andrew's
tree with that 16MB huge page.

Thanks,

[1] https://lore.kernel.org/r/20240327152332.950956-1-peterx@redhat.com

Peter Xu (2):
  mm/gup: Fix hugepd handling in hugetlb rework
  mm/selftests: Don't prefault in gup_longterm tests

 mm/gup.c                                  | 64 ++++++++++++++---------
 tools/testing/selftests/mm/gup_longterm.c | 12 +++--
 2 files changed, 48 insertions(+), 28 deletions(-)

-- 
2.44.0


