Return-Path: <linux-kernel+bounces-55415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0554984BC67
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF931F27AC9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF591B977;
	Tue,  6 Feb 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V99u+Uce"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31914003
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241213; cv=none; b=qftxBwEKTQzPiTkvAQ3GB256b/00M9jRP04FOBh7zhOePjt5uJYiGkHGr75hy6ExIYV7Tlm9yNGP0WgReUUcLVUhFCw9s4Kppge7f10HJwWm3P5sQBrtbw55Lh+p2Q+Sd8NrYeK4n1HqhZ056Od7oVhbCY0FZlx4nDPCQAcIc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241213; c=relaxed/simple;
	bh=S1tCYMcNXkihabDiqpDnmfHcIQO8CZnjsn5bQsn7UME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQSzH9F2YykDf9weK8PLn3vFQmtDFhYZkMWoTZi6SI+qDHRaLvBuIfz23/8bL1OSwTuCeD+T1K0zBRuCCjW6ByNl5jaF4mxtKeMgl1JWelbtZQZO+vNC2vWjdl4p/oIfI8vxIiQyxFSpdR+IE8RLQDC6V+AzVzuNIq7A+56S0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V99u+Uce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707241210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9TbiIW7v7P2/Ue8wq2AyQZ0xtrZV7cRznu5SFXHEEQ=;
	b=V99u+UceR2Jpq/vJH/CA10p2Ua53l1j3dJTD3AYNgn53PORQ4SfDQU/tBMhhGaACZpcYk8
	8qQESLy8CdKhpZZGvcG3jLexeyteBVyfjvCL/0NkBWidXcOwEbfkCuTqXcoaAsE7/fTVDG
	1KCEGZtjKf6Uu+8Q/R6LUcaIbEGZrj8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-3Nw8cN53NgCVyR-ABxYhyA-1; Tue, 06 Feb 2024 12:40:06 -0500
X-MC-Unique: 3Nw8cN53NgCVyR-ABxYhyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC028101FA2E;
	Tue,  6 Feb 2024 17:40:04 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D20342026D06;
	Tue,  6 Feb 2024 17:40:00 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	Michael Kelley <mikelley@microsoft.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH v2 4/5] x86/speculation: Make mds_user_clear __ro_after_init
Date: Tue,  6 Feb 2024 18:39:10 +0100
Message-ID: <20240206173911.4131670-5-vschneid@redhat.com>
In-Reply-To: <20240206173911.4131670-1-vschneid@redhat.com>
References: <20240206173911.4131670-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

mds_user_clear is only ever enabled in:
o __init mds_select_mitigation()
o __init taa_select_mitigation()
o __init mmio_select_mitigation()

mark it as __ro_after_init.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab8466b919..bab36096015d8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -112,7 +112,7 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
 /* Control MDS CPU buffer clear before returning to user space */
-DEFINE_STATIC_KEY_FALSE(mds_user_clear);
+DEFINE_STATIC_KEY_FALSE_RO(mds_user_clear);
 EXPORT_SYMBOL_GPL(mds_user_clear);
 /* Control MDS CPU buffer clear before idling (halt, mwait) */
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
-- 
2.43.0


