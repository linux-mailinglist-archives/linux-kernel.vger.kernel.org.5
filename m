Return-Path: <linux-kernel+bounces-86331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B035A86C3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659361F24BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017CA54F86;
	Thu, 29 Feb 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0As4Sxm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997054BEB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196225; cv=none; b=IVTBX0njz1s34wrG320Gm+pUMYIHL/Yh36nOc4pkF5PBRkNQG7ZaJNzDXd6m7c40w9joZJIHjAsdbgs90XvYgJeB3Kit5gCm0utqg0ryIcRJgiVHkfnYq9aJczCFb12ZBXqrIuTPVnDKhyWC1Ogli5mp3i4ins9qBjCPuF6pM1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196225; c=relaxed/simple;
	bh=njYfx4VOrh4eajU7r6f648jwhb+vCfyXtqOuH9tux5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6jesGN9NhoUNSupXjyh6dA1r32ng2RsFUD1jF4cGE/tWInYl87QM4g9mHRnca9dIt9gHwYcKFYs/OHoFoZMozy0Q19CNfcLERHkClEDx4Bz5IWzOaAqo0g3leTMgnhTrGpCYvGH+moYfrBwJrphfu2XXlkm/mxSFvfwosTHGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0As4Sxm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709196222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vaO5rUUUwqL4Op281F/k7Urm37If4ycpPAb8kcf+Fps=;
	b=d0As4SxmGalLUkvl8Ku4sGbyQOpQt1j9fcZxEZ1svm4xTa2UWs2eWZ0SLeHOeNB/yXy677
	PZwAIxH0nDIMNDJKd36xGlOcRVqyfbSrHRQce+4stlUEoa9VNbIYt9HFXpWbLtJTskXpzd
	m5+SiyPyp0ujPSr5xuACcTw1InaJu9Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Kkkwr2teMLKh8mWF0KV25w-1; Thu,
 29 Feb 2024 03:43:37 -0500
X-MC-Unique: Kkkwr2teMLKh8mWF0KV25w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBFF93C025B8;
	Thu, 29 Feb 2024 08:43:36 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3759D28D;
	Thu, 29 Feb 2024 08:43:29 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 4/7] mm/x86: Drop two unnecessary pud_leaf() definitions
Date: Thu, 29 Feb 2024 16:42:55 +0800
Message-ID: <20240229084258.599774-5-peterx@redhat.com>
In-Reply-To: <20240229084258.599774-1-peterx@redhat.com>
References: <20240229084258.599774-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: Peter Xu <peterx@redhat.com>

pud_leaf() has a fallback macro defined in include/linux/pgtable.h already.
Drop the extra two for x86.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h      | 1 -
 include/asm-generic/pgtable-nopmd.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 69ed0ea0641b..f884d5162507 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1097,7 +1097,6 @@ static inline int pud_bad(pud_t pud)
 	return (pud_flags(pud) & ~(_KERNPG_TABLE | _PAGE_USER)) != 0;
 }
 #else
-#define pud_leaf	pud_large
 static inline int pud_large(pud_t pud)
 {
 	return 0;
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24c..fa27e16bbe1b 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -31,7 +31,6 @@ static inline int pud_none(pud_t pud)		{ return 0; }
 static inline int pud_bad(pud_t pud)		{ return 0; }
 static inline int pud_present(pud_t pud)	{ return 1; }
 static inline int pud_user(pud_t pud)		{ return 0; }
-static inline int pud_leaf(pud_t pud)		{ return 0; }
 static inline void pud_clear(pud_t *pud)	{ }
 #define pmd_ERROR(pmd)				(pud_ERROR((pmd).pud))
 
-- 
2.43.0


