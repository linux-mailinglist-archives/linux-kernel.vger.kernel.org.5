Return-Path: <linux-kernel+bounces-94666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BD78742DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55031F2352A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1A1C686;
	Wed,  6 Mar 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS3XLq5h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC51D543
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764702; cv=none; b=o/Iv1zyZIawyQ1PndfTACnxTctKTeTl4n3shp44v4/N14Bx2P6CkCBgEFRBZnT7EbvnbrFA6pWlxAyiPCf4m9g6t6zi3MxFWtXVOpklNT5SZHkkdnj5b0++I2gHn8DmBFM81dI7T9/hd9XJWTFx6wK6QzKRXBB6BwvYzins3QUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764702; c=relaxed/simple;
	bh=ffbOlrqTwYJ/jZ1HLkY21kGOkQvioZziUqhpiJPsuSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdgakL9SnPnKe2gh/QaquQbeFnXbXkwNtx3syRmdK0OFDhnJgzvFryeHhu6rkvx2vX72ESBpjI7gMSfuIIXuy1ww/a+4fGJWWhVegXjQMtG0/A63EwbU/TJ3O+XNOv/bXUly76hb5mIUXddAEFkRkAcWaoFjL4rvFLi7DV1H9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS3XLq5h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709764700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ifJ4/8mTgVXdkLtTQ3Zdd4IQQKyln2F43BUCv9cvQ8=;
	b=CS3XLq5h16WmoVVeP9LX6EpxJDzHxv9ljD+Px7NlYuMl4msGWRj7nI7BhJhYjW5t9kcABm
	4zVxNA0EOopBGLLpQL+K6YBKCWrM3GF3QcbRI22riUtZd8Jq73y+0oOkfPh2aPQwtaOPa7
	MkxrgjxV5+GZSkBhj7d7jAciC5afErs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-mYyl0hfOMk2bG2oTxsARlA-1; Wed,
 06 Mar 2024 17:38:18 -0500
X-MC-Unique: mYyl0hfOMk2bG2oTxsARlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0944F280480C;
	Wed,  6 Mar 2024 22:38:02 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.9.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58820111D792;
	Wed,  6 Mar 2024 22:38:01 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben@decadent.org.uk,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	usama.anjum@collabora.com
Subject: [PATCH v2 0/3] selftests/mm: Improve Hugepage Test Handling in MM Selftests
Date: Wed,  6 Mar 2024 15:37:11 -0700
Message-ID: <20240306223714.320681-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This series addresses issues related to hugepage requirements in the MM
selftests, ensuring tests are skipped rather than failing when the
necessary hugepage count is not met.

This adjustment allows for a more graceful handling for systems with
insufficient hugepages, preventing unnecessary test failures and improving
the overall robustness of the test suite.

Nico Pache (3):
  selftests/mm: Dont fail testsuite due to a lack of hugepages
  selftests/mm: Skip uffd hugetlb tests with insufficient hugepages
  selftests/mm: Skip the hugetlb-madvise tests on unmet hugepage
    requirements

Changes from v1:
  - Added checks to skip tests when hugepage requirements are not met, rather
    than exiting with a failure.

 tools/testing/selftests/mm/hugetlb-madvise.c | 2 +-
 tools/testing/selftests/mm/run_vmtests.sh    | 1 -
 tools/testing/selftests/mm/uffd-stress.c     | 6 ++++++
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.44.0


