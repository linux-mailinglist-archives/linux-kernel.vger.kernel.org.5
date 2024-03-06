Return-Path: <linux-kernel+bounces-94664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43E8742D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF51A1F23667
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D41CD0C;
	Wed,  6 Mar 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="it7Q2Su2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CE1CA89
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764692; cv=none; b=vCHdByEWyzHgNfq2PRxeCFUFzTVv4ohUz4OT1YOBr6G0q/pQ3XXc0mhsXHwpJaxFvBHsqCekKqSAgmJlU8BYZKprRgoTBpfaDAzv8uJQa42JEUjp8Km32YtsloRUFlUUXgzsKKruIQAZlKoTzdcZMR99Be7JDwU2pXKYL1YytVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764692; c=relaxed/simple;
	bh=Ep40Xcm6pZhFQkrUWqmoylBGgAY8tpj9s93wzpMQ1M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d24HIK1r6jsjTBYTMX1q0uiuqxmPNnyTOtsesx1wFFovlmJdRju9XB+5CG4OzgiYGMggwiTKYFcHwSU5KCoSTzdCUmoi8evltiKijFd9uNo9/a/b4WuJ7bgFrzhlMMGWNEKN2LKSaIsyHNITDukskx0wNjpYKuRKfRUitbczSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=it7Q2Su2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709764689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5UoDnaGLpcXO5m45dBk4QmmCIzBiCAc96cRj4x0Prw=;
	b=it7Q2Su2y6yOZxrS0+wtgCIkggOSJxc82PbGDCnbd8tQg/S/172Yk7cRjlfWs8S9h8VJiA
	X63vahlikENO4lDzCX2Sv5BG0DPtaBuHKDw3ChHuGVDjfdkPfyd4tfVrURi4J3LH88MJ5G
	97TekB9HQZoSps5zbMGQagBtkduACr8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-DskwdaCkNtWCQR4R0kgcgQ-1; Wed,
 06 Mar 2024 17:38:04 -0500
X-MC-Unique: DskwdaCkNtWCQR4R0kgcgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E91CD2804808;
	Wed,  6 Mar 2024 22:38:03 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.9.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63AA5111D793;
	Wed,  6 Mar 2024 22:38:03 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben@decadent.org.uk,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	usama.anjum@collabora.com
Subject: [PATCH v2 3/3] selftests/mm: Skip the hugetlb-madvise tests on unmet hugepage requirements
Date: Wed,  6 Mar 2024 15:37:14 -0700
Message-ID: <20240306223714.320681-4-npache@redhat.com>
In-Reply-To: <20240306223714.320681-1-npache@redhat.com>
References: <20240306223714.320681-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Now that run_vmtests.sh does not guarantee that the correct hugepage
count is available, skip the hugetlb-madvise test if the requirements
are not met rather than failing.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/hugetlb-madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index f32d99565c5ea..e74107185324f 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -19,6 +19,7 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include "vm_util.h"
+#include "../kselftest.h"
 
 #define MIN_FREE_PAGES	20
 #define NR_HUGE_PAGES	10	/* common number of pages to map/allocate */
@@ -78,7 +79,7 @@ int main(int argc, char **argv)
 	free_hugepages = get_free_hugepages();
 	if (free_hugepages < MIN_FREE_PAGES) {
 		printf("Not enough free huge pages to test, exiting!\n");
-		exit(1);
+		exit(KSFT_SKIP);
 	}
 
 	fd = memfd_create(argv[0], MFD_HUGETLB);
-- 
2.44.0


