Return-Path: <linux-kernel+bounces-89090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFE86EA58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29A21F256F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091CC383AC;
	Fri,  1 Mar 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPc3Av9j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380316FF2A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325034; cv=none; b=QgX1tiS6fU6MKzqkKSvlGM5nBM0oDG30jpn45hh9hZ1p8kqBk1S4uKY7q9KgrdbaaIEDmYjkZ3frPbQjmzjt0xg+jOki69Fwtm+mM34wLAxNYeYBV/GdcUALvg2goxpFHAZwSpOv7GxwLavYNBjaFClqwo0IkklLkb/PUDcAyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325034; c=relaxed/simple;
	bh=t7pqRF9fRBz2eiE5gjDIRduy9WZfkjtR+VuQSDyGcR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7grqdh/DRk7wpYn/DyUSM3+e84lg6f0NON7uk4ac6BVW3fYkAtcz9dVDpxWdcKnHSSvzoavXwImO38oyDiSvAN5iURUDiexyiOdkHve8lWAhziZkmKGV8Do7GrZmMO80VUwX1c3q4HXIQN6OiLLHbE5+J4CDStP+wosGxwr84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPc3Av9j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709325031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p4HV6m6g6G800ZFnvQF0dUMRRFs2reQboirIXeVEjws=;
	b=FPc3Av9j5oJdP3o7ep7UdMPJMXRRGGJXFPjsqAfxqNY5t7eJEHdn9OYyI0OZ4asI76Nk2p
	+IsxhCUilNZwzrg1zq/YkMG2P7KKojeQ2I+kzPltycqQHAFyFl47H2P0IxTIzqt0jL4MOI
	ObWEfOvhvFYrI7CJM43VcwVsUBm5pC0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-6Y1hDfuoONGk5m_HhEMYUQ-1; Fri,
 01 Mar 2024 15:30:28 -0500
X-MC-Unique: 6Y1hDfuoONGk5m_HhEMYUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 320F0380406D;
	Fri,  1 Mar 2024 20:30:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC07A39D6D;
	Fri,  1 Mar 2024 20:30:25 +0000 (UTC)
From: Joel Savitz <jsavitz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Savitz <jsavitz@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org,
	Gonzalo Siero <gsierohu@redhat.com>
Subject: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
Date: Fri,  1 Mar 2024 15:30:23 -0500
Message-ID: <20240301203023.2197451-1-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 64-bit powerpc, usage of a non-16MB-aligned value for the mem= kernel
cmdline parameter results in a system hang at boot.

For example, using 'mem=4198400K' will always reproduce this issue.

This patch fixes the problem by aligning any argument to mem= to 16MB
corresponding with the large page size on powerpc.

Fixes: 2babf5c2ec2f ("[PATCH] powerpc: Unify mem= handling")
Co-developed-by: Gonzalo Siero <gsierohu@redhat.com>
Signed-off-by: Gonzalo Siero <gsierohu@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 arch/powerpc/kernel/prom.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0b5878c3125b..8cd3e2445d8a 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -82,8 +82,12 @@ static int __init early_parse_mem(char *p)
 {
 	if (!p)
 		return 1;
-
+#ifdef CONFIG_PPC64
+	/* Align to 16 MB == size of ppc64 large page */
+	memory_limit = ALIGN(memparse(p, &p), 0x1000000);
+#else
 	memory_limit = PAGE_ALIGN(memparse(p, &p));
+#endif
 	DBG("memory limit = 0x%llx\n", memory_limit);
 
 	return 0;
-- 
2.43.0


