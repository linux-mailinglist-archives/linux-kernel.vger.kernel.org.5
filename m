Return-Path: <linux-kernel+bounces-128937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF18896207
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736B21F237CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479831B952;
	Wed,  3 Apr 2024 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+khp82s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64214A9D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107979; cv=none; b=H49w1RiycFEASOUybxvC5L9XATqsEnOWPf117OleEQi+ekrxZ1q65gfWFwoV++Sy2sW5EdklydojwuKV3yW/uvtoizq3KTtIT38Iv01WHknL1r+znNoRukAlpLlWOrEN9Xel4/7i3PyM2rt8utY1/OPMP91BTLgMjM8Ao2jKYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107979; c=relaxed/simple;
	bh=z1GaugFYICjVSrn2n8rnHfGDwwW/vuxiZSFHEY4qUdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlS0hak/8RfmZShXEABA6/h3j96yDzJSikZe45spqoR0JFe2oprDh3kq20aqp68HpycuFftwjdqbgttTjBjeCgKVMFkDFB/D7CpeEdcixEiIe7aL5humdxzJhVWlqsz/R6J2L64Km8OybogzfWJU2foLJe66CjN4SgtnGfzi5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+khp82s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712107976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PR/NBCt+5qJ4X31foyrecLlAlU9UbBCiiBiwAD7jaH8=;
	b=H+khp82sZxOLI++B7jpOxxre5hhOx5sM7WFXrAEN70n6cDeySi4WSi/vXlNfYur1SEz2IZ
	hKb37eb1nERa2rdpKAq4s2ALMDXWU6NL/ZFh2gfMZ25W2ZZYpKHTlTRUa6DiWb5d5KWumL
	4otW9SD4aoOCrH0UDvqtxoefcJhoJu4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-RtxefYq6NIeYwwSouRjnFA-1; Tue, 02 Apr 2024 21:32:55 -0400
X-MC-Unique: RtxefYq6NIeYwwSouRjnFA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4311dd10102so23842621cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 18:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712107975; x=1712712775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR/NBCt+5qJ4X31foyrecLlAlU9UbBCiiBiwAD7jaH8=;
        b=wb/lKpOpkIOrmyxxmW1AuOAfE8HpJnBlesS3+d3HObVG4hvcUPK0i13sqFSeu1KkfZ
         wTFxwPO7ttzw5BFTaDrzjw1iQR2C019poZAqg10LVrQbmG/9cVIXwZYV1jGCQGLw5ZyO
         X0bosezjGQviUCWJCRwXSZrEyl03ou6Q/CPPxRewrWIksIfCph9hqgjIIwp3NasyQqLz
         xC1H4h9W5zzPPdr8mG9zPCLBgtraCPWra6W/I8/ydpGsunPMiW8DSpeqz1jD6nBylgf5
         lp2gJeLU1Bp3nvClyKFYDDUyZUG3If2Q6ObX6JBW17AwM3r7XBPp63uvOdhGxJQ/nIVG
         43eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTTE0GsaK36eFK06sQAO3VJSy+4eaI/m13e8RqzlyebQyjWydoC5IGLUK8GwUr8KLY9L3tf6OBRVemWjg0ilOVOMEqqyIjtEuNI2Pw
X-Gm-Message-State: AOJu0YypnvXO9XARqAnS+meDTtKSZHM/GFS8QWkLWtNUFwB9DyPkIvb2
	BYtFbY/y/hzyyMOA/lOF/9zzPXUpfpYGe+p1uFOuGTkPMwOmDDBdbGKvENLOJo1DbVeD0V+z3fK
	E9YdSKf6yeO9m5lRHMsDhRHZILvFdKfcS+io+Vu1picmJRSfrbddFreIjpmEcaQ==
X-Received: by 2002:ad4:46d3:0:b0:698:fc78:21ae with SMTP id pm19-20020ad446d3000000b00698fc7821aemr9828987qvb.6.1712107974909;
        Tue, 02 Apr 2024 18:32:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDjHRAOIt7pAcFSSzP58lew6Exi/iOo8/2ozkB/HO9HAPtSJzX+RWcE9OqEaW9cSxSEbXVlA==
X-Received: by 2002:ad4:46d3:0:b0:698:fc78:21ae with SMTP id pm19-20020ad446d3000000b00698fc7821aemr9828970qvb.6.1712107974456;
        Tue, 02 Apr 2024 18:32:54 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b0068ff8bda6c7sm6031687qvb.92.2024.04.02.18.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:32:54 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Ryan Roberts <ryan.roberts@arm.com>,
	loongarch@lists.linux.dev
Subject: [PATCH 3/3] fixup! mm/arch: provide pud_pfn() fallback
Date: Tue,  2 Apr 2024 21:32:49 -0400
Message-ID: <20240403013249.1418299-4-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403013249.1418299-1-peterx@redhat.com>
References: <20240403013249.1418299-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/pgtable.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index fa8f92f6e2d7..0f4b2faa1d71 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1882,9 +1882,13 @@ typedef unsigned int pgtbl_mod_mask;
  * code.  Now it happens too for pud_pfn (and can happen for larger
  * mappings too in the future; we're not there yet).  Instead of defining
  * it for all archs (like pmd_pfn), provide a fallback.
+ *
+ * Note that returning 0 here means any arch that didn't define this can
+ * get severely wrong when it hits a real pud leaf.  It's arch's
+ * responsibility to properly define it when a huge pud is possible.
  */
 #ifndef pud_pfn
-#define pud_pfn(x) ({ BUILD_BUG(); 0; })
+#define pud_pfn(x) 0
 #endif
 
 /*
-- 
2.44.0


