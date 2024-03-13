Return-Path: <linux-kernel+bounces-102554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2DE87B3CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0641C22981
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CF85B209;
	Wed, 13 Mar 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSBFT+mU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914B5A0E7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366451; cv=none; b=i/B57xUcVsH29FecSjPoL2zCDICIx1xTtaKnVOBb0IPU7Ok/GJSYYnaaUs6w0U2oSumMx9l6F4VFYPHQtLTuK5SKcpocHKvxkO3KB9pSGGAaFJHLBJGdjFQ3NsenIh59Pr5Q8muwBZD0x5XYBYdaXMI/qaEfKQbJ0s7M/T2MJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366451; c=relaxed/simple;
	bh=XKAmzhpmXEAjAsa42PYgBQQ2HzrzYrw3Lh5/ehBy8nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQSlrwKu1KoL+o5xkcIAMJQgLMqMYglwbu38CvAvr765JdVYGuN1nsOTzE877VNE6tbxlGYUGRTBQqHib2UbYwILI+CdEX5W93p8yoFhfUoqJ1iBuYNIis8YHOpS4In8nM/xMo8V5+pG5zAE+h04z2SXA9dBMFAklpj3Y+KcrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSBFT+mU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OThRyXZFMjugEtcpgf//pX/PpGcoxbD3wNFnQts0Kco=;
	b=bSBFT+mUskdwbhaOexzhgAbYsZCcxOVUaBnObtSESayDLGiVLSeYAB2ELdAvqya9nVsWdl
	L7sHX4jP5mWObAm+mBFFHAVg8/Pkw4KbAFkozyOc8sGlxGbpSqKfSoqLBoOjyxY5PByEIB
	VHAA78kecCjQv33qQDR9SyzCD2Eai84=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-rPtg9c_SPwqo8ZT_LpHlxA-1; Wed, 13 Mar 2024 17:47:27 -0400
X-MC-Unique: rPtg9c_SPwqo8ZT_LpHlxA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-690b5ad0e61so1037426d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366446; x=1710971246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OThRyXZFMjugEtcpgf//pX/PpGcoxbD3wNFnQts0Kco=;
        b=FTTA7Ly6S7UBbDwi00GMyZ0cc/3rWoFdUgNOcUlWZP5achMrHjuYUikTAo/qGIXyNa
         bD1ZdbpKDzoMCEb0mCLsH2I26+5lfvDZ2yvMl/h47LY2+6p+zsWjUkg+kh4OO1FMKq1E
         0/XtKbJ32jaVSUbPPo+zWu9Ivru/kz386ca4FjOjvkgPTQll5R1rt4kqlDMw82PUhzEm
         HhV4+RU3IcZSVLp9eBVtJSxURB5jNSptCURnI0jZjqKDe5lKkAiWS4YmmRiHxuprUe03
         7jir6VlJ3PBJZIyPoVnL45DLrhv8iX03GaQxG5cHb0eKOgTrUYYXu+1Ab/7Yt/LyGmCg
         0ZFA==
X-Gm-Message-State: AOJu0YxYdlOpevmJp+IrynhdgeKHsj4hJcvJcyO63b5anaLRuIgYxSAJ
	kqTOiypQUL4K2sQXSg38/oj/8la8G3ykux67kMgBOQvadk3qNq8e6P2P/SUCQAwSBIlxaARJM4n
	PTEywyis4TdTgMGN4aca482ob7j7ypruv+xalfH3zPoKymPkOHe78A1EB5nEowj6jXggO4ERq6G
	+6KYvvJrOW6cccY56RxEiKXMEx/oKV8Em5zjS07cOQYvs=
X-Received: by 2002:a0c:f508:0:b0:690:b02c:2a5f with SMTP id j8-20020a0cf508000000b00690b02c2a5fmr13464377qvm.4.1710366446077;
        Wed, 13 Mar 2024 14:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXIxC5CVGnx+p2qd8ZmV2KZnCoGCjWGy3mEq+yzfnYrTYJ2FsP7C7aom0bl0ipU8C23yK/Aw==
X-Received: by 2002:a0c:f508:0:b0:690:b02c:2a5f with SMTP id j8-20020a0cf508000000b00690b02c2a5fmr13464349qvm.4.1710366445605;
        Wed, 13 Mar 2024 14:47:25 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:25 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	peterx@redhat.com,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 03/13] mm/gup: Check p4d presence before going on
Date: Wed, 13 Mar 2024 17:47:09 -0400
Message-ID: <20240313214719.253873-4-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313214719.253873-1-peterx@redhat.com>
References: <20240313214719.253873-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Currently there should have no p4d swap entries so it may not matter much,
however this may help us to rule out swap entries in pXd_huge() API, which
will include p4d_huge().  The p4d_present() checks make it 100% clear that
we won't rely on p4d_huge() for swap entries.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 69a777f4fc5c..802987281b2f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -776,7 +776,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 
 	p4dp = p4d_offset(pgdp, address);
 	p4d = READ_ONCE(*p4dp);
-	if (p4d_none(p4d))
+	if (!p4d_present(p4d))
 		return no_page_table(vma, flags);
 	BUILD_BUG_ON(p4d_huge(p4d));
 	if (unlikely(p4d_bad(p4d)))
@@ -3069,7 +3069,7 @@ static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned lo
 		p4d_t p4d = READ_ONCE(*p4dp);
 
 		next = p4d_addr_end(addr, end);
-		if (p4d_none(p4d))
+		if (!p4d_present(p4d))
 			return 0;
 		BUILD_BUG_ON(p4d_huge(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
-- 
2.44.0


