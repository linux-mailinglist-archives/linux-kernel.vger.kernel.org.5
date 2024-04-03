Return-Path: <linux-kernel+bounces-130615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB98897A93
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB58288E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C496156679;
	Wed,  3 Apr 2024 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asBXV72o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DB156650
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179311; cv=none; b=uUpBhaU9sr48Hc3FHduHEJJ6mwe3Qy4Vk7GU8ra1fzEywzDQg6mUrQ57KHWvpbCgcCGysufy6ZlOnJDJ8j2S5OWR1PMwSIpevAvao8QezPP0bPYHtoXgcDewaoivmxOk9nJA09MI12SUg1WPp4+faCHJYaRzZEhxhnMMvBN4bEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179311; c=relaxed/simple;
	bh=OOG/7FbXBEc0Hzs08T8bHH7F0B0m9Dezfw0FoeyKG7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMSxEHz6FdDlmqKzZmFXkKj1sBAhoRp9h9I+jd1QkoeTW+034ClK8n/tWSPbAY5rgxG2XYdZo9ttCPtm8b5Ru9Jg7/3YQWqZi6JwtysjP/4ERz9mi5dCtH/znWhculfnYOo72Ulm7BgmjTlBydXhW7sZDhHFRHZ7MUQuZNXdeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asBXV72o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712179308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FBBcDMAj2JPHjs8hqyTFLFBiCM24FpZuuFwCRwuga2E=;
	b=asBXV72ooSTjJaj8E7SY1oowp6dgTLvYUxGDB4gsNmgy4qumo0O2g7a4WceD0MJAIjzBEv
	KNpL8fx0ND2ceJDpgh+I8M1lx1Q+kRiIx8iMkY4PkcoiJqxQxAPZxxVwgHpwX+WopVkchK
	0Bt3EjNAvw22i9AN5sOR0m6Ppg9hO5M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-re2vfINaNi6nhzm7UomUJA-1; Wed,
 03 Apr 2024 17:21:44 -0400
X-MC-Unique: re2vfINaNi6nhzm7UomUJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 521421C01B2A;
	Wed,  3 Apr 2024 21:21:40 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B30291121312;
	Wed,  3 Apr 2024 21:21:36 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Fei Li <fei1.li@intel.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 0/3] x86/mm/pat: fix VM_PAT handling in COW mappings
Date: Wed,  3 Apr 2024 23:21:28 +0200
Message-ID: <20240403212131.929421-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Rebased on latest mm-unstable. As we have a conflict now with a cleanup
from Chrostoph, temporarily revert that one, so we can apply the fix,
and reapply the adjusted cleanup on top. I squashed the fixups
sitting in Andrew's tree for that patch.

The fix should likely go in first via the hotfix route, that's why I'm
moving it to the front.

Tested with my reproducer.

v1 -> v2:
 * Rebased to latest mm-unstable
 * "x86/mm/pat: fix VM_PAT handling in COW mappings"
  -> Fix function parameter indentation
  -> Add Ingos Ack

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fei Li <fei1.li@intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>

Christoph Hellwig (1):
  mm: move follow_phys to arch/x86/mm/pat/memtype.c

David Hildenbrand (2):
  [mm-unstable] Revert "mm: move follow_phys to
    arch/x86/mm/pat/memtype.c"
  x86/mm/pat: fix VM_PAT handling in COW mappings

 arch/x86/mm/pat/memtype.c | 56 +++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 14 deletions(-)

-- 
2.44.0


