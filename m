Return-Path: <linux-kernel+bounces-164718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBF8B81A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB0EB225EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259EF1BED72;
	Tue, 30 Apr 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/kP6YaG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E6C1A38E5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509659; cv=none; b=lBrfQSf5ELeY4lO06OBZOoGbZIZTgR9gv8bwzTHvuPwndDS66NvsADjuTStDlyfXFQauisPcqih5CRGaZ9+QVFMscP+U37IJqs6do4x55yRzFzIv1w6uDkijFnWtPp/N75ywvnvvAr64vMftKRi4+p3JC/zFWqhyk7MaWXU0yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509659; c=relaxed/simple;
	bh=hUPGLZZdKc8svvazAhagE3csCx3nW1eQdg89W1BMfQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+oZdzdvr6mtIgB9ZJ4STAwoAlGdodJo4nnIK87ZCnDuIQsSpeb2VgTDAiyitYuXMvogyvBByNUL4sCD0KnTpcINa5Ggk0l9bGs1OxMLK8mmj0XJ+GGiHJvYfZ5Vcnrw1kDlDnHAf7cwIO/YNrPkmg4CH+iE9RbSJQ1nthhiodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/kP6YaG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714509657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+xMysOaTLOUYcuh4ijK9OYwvDDRj3hF0BT7ZxHVSLo=;
	b=I/kP6YaGSh2+VzWxmdGxvrwfy3VGPmFArNZgEkEBum+5IuxxOEmGknGY09mH4/8R/+RYLb
	YZWN1xu7osBDqzURnwaVuGxPFXst/ZedpdC7pz2xGzkmy+btu7Xr7cBGPWlyMmppCOYWl3
	FKycmh52jyAS/rCo8cDEKV4rUBJRgZc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-YnVIUqY2MHGA4ILpxZDr4A-1; Tue,
 30 Apr 2024 16:40:55 -0400
X-MC-Unique: YnVIUqY2MHGA4ILpxZDr4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 093CA3C000AA;
	Tue, 30 Apr 2024 20:40:55 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 288E9C13FA1;
	Tue, 30 Apr 2024 20:40:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 2/2] mm/rmap: sanity check that zeropages are not passed to RMAP
Date: Tue, 30 Apr 2024 22:40:44 +0200
Message-ID: <20240430204044.52755-3-david@redhat.com>
In-Reply-To: <20240430204044.52755-1-david@redhat.com>
References: <20240430204044.52755-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Using insert_page() we might have previously ended up passing the zeropage
into rmap code. Make sure that won't happen again.

Note that we won't check the huge zeropage for now, which might still
end up in RMAP code.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 7229b9baf20d8..5cb0d419a1d75 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -200,6 +200,9 @@ static inline void __folio_rmap_sanity_checks(struct folio *folio,
 	/* hugetlb folios are handled separately. */
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 
+	/* When (un)mapping zeropages, we should never touch ref+mapcount. */
+	VM_WARN_ON_FOLIO(is_zero_folio(folio), folio);
+
 	/*
 	 * TODO: we get driver-allocated folios that have nothing to do with
 	 * the rmap using vm_insert_page(); therefore, we cannot assume that
-- 
2.44.0


