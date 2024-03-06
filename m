Return-Path: <linux-kernel+bounces-94662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63518742D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AE2B218E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200361C6BC;
	Wed,  6 Mar 2024 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+jfCp4F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56271B59D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764689; cv=none; b=qvdQKVbCGT534OzxRrSV7AieJwq/STa00eNmDLCgmuKudi245j9QvD84tueNBizYrjhb0nVW1yaepSefdGJ2gGqSZ5Uj+JH1SMDSMzNTQZGYc29am6z1xRYOC21jlQrWpn3rmBzzxcV/ROHgqvWZh9V1CJksMVehWYHOM2rg4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764689; c=relaxed/simple;
	bh=QMHws1QctT5NyUyniNy/i1yS7FjuctqycFRrFidhZb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfZB9rC54eWa5fbaq7r9A/lWPXlrxSaP6UGQW0lkiBl2Q/e3ElRAO0SsUxSFc2FjhgAAMSMR/e4OJC/H/wxdCmk/IZhXkn8PN0UEiPDm50UoxIs2K91zYoZzS/BRhTXLRspBm2j9CLMPHop7/xszHN3qurW9J8mMDJg9P73lJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+jfCp4F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709764686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhvHTa8E6KIfz47SC53e3jlZc8KPDvEvRYf6GRtCMqU=;
	b=T+jfCp4FWDI03kwn11+06p4n/obom/VYctpr/0dxrlzoPtlPSPQjslzI6xl8g2uI2MkPUM
	Tr4GTpic9kc8An4uYC780TIhWR5b4XPUhUu3sek1Or4xfsaAh3uvvIRlT0NDHee9CWwH86
	6sghB+KHGhNqRO0I1VMmr+RcMKfwnvg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-QO_v-DYrOPqLzMUdIsx2gA-1; Wed, 06 Mar 2024 17:38:03 -0500
X-MC-Unique: QO_v-DYrOPqLzMUdIsx2gA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A430E857A81;
	Wed,  6 Mar 2024 22:38:02 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.9.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E907111D793;
	Wed,  6 Mar 2024 22:38:02 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben@decadent.org.uk,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	usama.anjum@collabora.com
Subject: [PATCH v2 1/3] selftests/mm: Dont fail testsuite due to a lack of hugepages
Date: Wed,  6 Mar 2024 15:37:12 -0700
Message-ID: <20240306223714.320681-2-npache@redhat.com>
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
2.44.0


