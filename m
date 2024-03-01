Return-Path: <linux-kernel+bounces-88012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE086DC1D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0438C1F23C39
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BD69959;
	Fri,  1 Mar 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L96g6phn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F242031D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278397; cv=none; b=M59b9fD2q1YczQXx7Tn+ZL5vGpDJZPamDej4sM7Idy3FvUf5dFaFX6OpTA0DH4SyMRt8SD/i5q30+kb2GtLc+Hxf57VGfDX693HeT4VsvhYbHlDsDi15phkuVYkP7w4KASogS3EMTN/MBtq2W6WlPEf8nn+xAXJaV9mnlsTzBHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278397; c=relaxed/simple;
	bh=TGr/BP1Gn8/hf8q8u7ex7+naL4H/IsFy7tgVN/sDdjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqORgmm7urZskNs4cebW4+UobFBpsFp8AbHxT1X6ZpRfJq7t0uA1IORg1fss94wBgESGF1LCHCHoUEYoLT7p2xPzragBl7T9DzH0O15Vfp9BAiQJfJsa0SXxQAa6Ko5uTMuS+sk0G0tmGk28pdFQin0KLYT/29cT2zq2jyrMiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L96g6phn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709278395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jpPZGV9V3hnUBn8i3CL2d4Yea6dbDC8URH30r2BRw8I=;
	b=L96g6phneKAPkgQIYWimhtDs0pQuJOq7fZXvS0XmDDKR8FR9RZOYQ4TWk49fDhCDcm/ccJ
	ngpcMW52uWuCGnim/Xzp6fsEQ8H9DUJA7vIMVAjGx4QAxAWM+D71gFaNtFJsJ7SVIm1d2Y
	wnZ8Rl+tXxgkAO79Q9q9cgG4L6C4qSY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-ZhcNaUkXMtWY5njG5DSoPQ-1; Fri,
 01 Mar 2024 02:33:10 -0500
X-MC-Unique: ZhcNaUkXMtWY5njG5DSoPQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA6D228116B8;
	Fri,  1 Mar 2024 07:33:09 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.17.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7B1492BE2;
	Fri,  1 Mar 2024 07:33:09 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben@decadent.org.uk,
	shuah@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH] selftests/mm: Dont fail testsuite due to a lack of hugepages
Date: Fri,  1 Mar 2024 00:33:00 -0700
Message-ID: <20240301073300.287508-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On systems that have large core counts and large page sizes, but limited
memory, the userfaultfd test hugepage requirement is too large.

Exiting early due to missing one test's requirements is a rather aggressive
strategy, and prevents a lot of other tests from running. Remove the
early exit to prevent this.

Fixes: ee00479d6702 ("selftests: vm: Try harder to allocate huge pages")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 246d53a5d7f28..727ea22ba408e 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -173,7 +173,6 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 	if [ "$freepgs" -lt "$needpgs" ]; then
 		printf "Not enough huge pages available (%d < %d)\n" \
 		       "$freepgs" "$needpgs"
-		exit 1
 	fi
 else
 	echo "no hugetlbfs support in kernel?"
-- 
2.43.0


