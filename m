Return-Path: <linux-kernel+bounces-29299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BFF830C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D3B24316
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A878F22EF8;
	Wed, 17 Jan 2024 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hayWYpGZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAD22635
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514454; cv=none; b=WYLxJIz8u1juE6zjfcyVMo+F8VQqlXfqwB1cYql9Kk167UXQBf5vYNV5vAUq11mzJvUx8Hvb2/8VtJ8ssTce/ifAfcDKCQywXqYXClX2pWi8R8LsfBiwsmLe9VG2OdsbVd9PlB1ObmkW+7LB/xK+EM5nUx4iBB5LnN17w3wMWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514454; c=relaxed/simple;
	bh=8IXAWHXrSjNXM0FpElCzk0WtxnO106w/8hSLLnHdKKc=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By; b=AYmly08yeJA/f4vRYnt+MHJvFIrWPE3mmm0YBk8b1J57tJuJlQz9fEq8PGmGLy327Q9VpRahNnV6MSkmQce5vDeP2NJFn3XW1EgdqCzi2V2/DAMbaHzItFoDkuzehcsao79qF6vHBN4xkvHnSsqliQ6L4PLKACcvyhOhN/2WWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hayWYpGZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705514451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v7mWtbZkBfydRoZ1KTKCUbcKjYFh0CTp/T1jJ9CpJ+g=;
	b=hayWYpGZna3WrmdhcZPNADL1KR8MdzedixDojumMecmc5zha+wWxbSMNe8i198O59kPcly
	FomO4OR7JsWaiyOn08H2uoIGUrlSQVZ0dIam9rfhR3UmgWOPTwPYI8XuNwSoW8q9qlqTtS
	zap26jITBAGdzSSeBCSRjlt/jh+KizQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-RXAB2irYP0KW7RzaKLEjpw-1; Wed,
 17 Jan 2024 13:00:49 -0500
X-MC-Unique: RXAB2irYP0KW7RzaKLEjpw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E76851C18CD3;
	Wed, 17 Jan 2024 18:00:48 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.34.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7AADA492BC6;
	Wed, 17 Jan 2024 18:00:48 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org
Subject: [PATCH] selftests: mm: Perform some system cleanup before using hugepages
Date: Wed, 17 Jan 2024 11:00:37 -0700
Message-ID: <20240117180037.15734-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

When running with CATEGORY= (thp | hugetlb) we see a large numbers of
tests failing. These failures are due to not being able to allocate a
hugepage and normally occur on memory contrainted systems or when using
large page sizes.

drop_cache and compact_memory before the tests for a higher chance at a
successful hugepage allocation.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 246d53a5d7f2..040f27e21f47 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -206,6 +206,15 @@ pretty_name() {
 # Usage: run_test [test binary] [arbitrary test arguments...]
 run_test() {
 	if test_selected ${CATEGORY}; then
+		# On memory constrainted systems some tests can fail to allocate hugepages.
+		# perform some cleanup before the test for a higher success rate.
+		if [ ${CATEGORY} == "thp" ] | [ ${CATEGORY} == "hugetlb" ]; then
+			echo 3 > /proc/sys/vm/drop_caches
+			sleep 2
+			echo 1 > /proc/sys/vm/compact_memory
+			sleep 2
+		fi
+
 		local test=$(pretty_name "$*")
 		local title="running $*"
 		local sep=$(echo -n "$title" | tr "[:graph:][:space:]" -)
-- 
2.43.0


