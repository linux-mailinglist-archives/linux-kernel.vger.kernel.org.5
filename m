Return-Path: <linux-kernel+bounces-31151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 309ED8329D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED1E1F234B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831E524AD;
	Fri, 19 Jan 2024 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSKS9lGr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9351C38
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669100; cv=none; b=T0LokoFtKxebuO3gx4YXL0Uo2Sxu1Pw2fhVCLBG62f9KWLlm3SypE6YwL3m4DeO/qw7jPL7RER2Q7tgmcLTT+u2CdVI8Es927Y6rcfpIZOwMcOuGX5tK5CU5+RPSAjrhCdzWXfi5DNE4WyAPla30JAlHP27/IIUhn6AXgENktTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669100; c=relaxed/simple;
	bh=9oN8WEtKHa5I91ygCWQnS1mqKVl+6aTCIb+eEtvC21Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6vV+3mWQStj5UjwW/AxKHyqjiFgej28MN9A/Kgtn8XsSbEovYvJp1lD679LHnrgaQqmsfMW4xyixqF+UggD5p/NKReqaDDTelaFZb9S+vjlLtwsHoLI114li4exdiD7/CmPx2V9qpxAn1FQh+ys7n3N2ClRLrUF0FtvqRinunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSKS9lGr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705669097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tSl8vraS51FiTpTDwvXe67q3UpTXFaFfY6Fu62WAl5w=;
	b=aSKS9lGrwXqJJHj1TYgcO3vzw2WJeCu8XJqCHafkVI0Sn/EjwuIQYrsGbF5FEvfiR5PdK1
	Y2F/sypdGIUOKmON9RfMFmJEc9POgUYA57zGr975TL3q0RlBYISN51D3bEX1uzp+yknhCb
	l+TAyoiYYAdCZEf+3LZmxUns7rgzriQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-56YpH6c8NtiCuO0XfASFRw-1; Fri, 19 Jan 2024 07:58:12 -0500
X-MC-Unique: 56YpH6c8NtiCuO0XfASFRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AB5585A597;
	Fri, 19 Jan 2024 12:58:12 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.32.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A227DC1690E;
	Fri, 19 Jan 2024 12:58:11 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	donettom@linux.vnet.ibm.com
Subject: [PATCH] selftests: mm: fix map_hugetlb failure on 64K page size systems
Date: Fri, 19 Jan 2024 05:57:53 -0700
Message-ID: <20240119125753.152354-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On systems with 64k page size and 512M huge page sizes, the allocation
and test succeeds but errors out at the munmap. As the comment states,
munmap will failure if its not HUGEPAGE aligned. This is due to the
length of the mapping being 1/2 the size of the hugepage causing the
munmap to not be hugepage aligned. Fix this by making the mapping length
the full hugepage if the hugepage is larger than the length of the
mapping.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/map_hugetlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/mm/map_hugetlb.c b/tools/testing/selftests/mm/map_hugetlb.c
index 193281560b61..dcb8095fcd45 100644
--- a/tools/testing/selftests/mm/map_hugetlb.c
+++ b/tools/testing/selftests/mm/map_hugetlb.c
@@ -58,10 +58,16 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
+	size_t maplength;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
+	maplength = default_huge_page_size();
+	/* mmap with fail if the length is not page */
+	if (maplength > length)
+		length = maplength;
+
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {
-- 
2.43.0


