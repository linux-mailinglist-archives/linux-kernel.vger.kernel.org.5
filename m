Return-Path: <linux-kernel+bounces-106600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 582C887F0D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCE6B21284
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D13A59B45;
	Mon, 18 Mar 2024 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPl4GA9W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DEA59175
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792258; cv=none; b=PE2v0qaQ6ojJtH02uoPnN/MEH0SlW+Ha32qt8G+6xSrR2WEK65vtFuzkVLQ8RNSSpjG6XxjQLDlvM2IafrhowmsxXy1Vvw9liq/iOIkkm1F7XO+xFtWhfINCvZEXeMJVHPpyaJ9vbv/UZt520nkTnwIPBboAX75XKvzjdxm8Ud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792258; c=relaxed/simple;
	bh=iHHSvsdkBOFub0mcOT/89y75sePdz9RiRVPlZT5QMlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQSP7Fy+loyiuijsj2YFDAz38a6angki8pkVxg9u33LtIn0a7uqW3ECt7RwznBlpUv+u0eNhChb1GXdBsdbZXbKgqyaib1oVRHyFRbJvlLJUnbCZ0+RzO7IRSwZghZiLSoX+K86WICNZ+/pAJ5KjzQAFUyM+UTpqY3Y+9pWZvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPl4GA9W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXyJDuJosTa0kFBnhKvW1aqbtapsaxz0OHU+bPr+fnc=;
	b=EPl4GA9WvSWdWpPHlKsn7Rh7Hb+GOHKpJ/eLzmbMCBh5VTcpp8RVHinnSfBITdu2M1xDhv
	8gTEOp38fCtVJBa/pHqf6jgNAveAHbdQ3hQkDiwmVEc/khrN2pogPf+vVCS0w9+CKMyuMW
	tCUuDU5ZqO75kcJX0fu5S+spWXaqf7c=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-UlfJOExmPpSz5mB0RQr7wA-1; Mon, 18 Mar 2024 16:04:14 -0400
X-MC-Unique: UlfJOExmPpSz5mB0RQr7wA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c386baa6feso290842b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792254; x=1711397054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXyJDuJosTa0kFBnhKvW1aqbtapsaxz0OHU+bPr+fnc=;
        b=edNAvDak688+H1lIHTKLSLN63gGie7xil3+wuodSL3yfAkh4i8OYX3rwzRbz7if7r+
         ZoqWpiq4tLaEdXrlZFxjloQCAANdyzq4HWG4RMTKAJXtBWlNjT773vwqjxGnX0iL/g8w
         rDUooxjmfAPki7bG036CBG9OgBdGp8A2CjCGwtMXl4Fu+b5Vwu92wNLHEduzCAdUMOft
         IynDg7jwsv1BjrpOQXt4Nc0yGBW73F3v69zSzstLp6gucWLEh0d6cQk4ZB/PXeuffNHp
         XBVsEyghEfKQjDonnu8hPl/r0hvCgSVvnyI4qQ6uldAtCxcSsGoHeUINhr2K5+OQU7Ou
         hAVA==
X-Gm-Message-State: AOJu0Yzjtwn8sncsgGKmKs0xBVCG+tMsc7zfYrXr9kXqtI6OboV1MNyv
	mKC9LmAY13Gcw8IxeN5g5jmSh0bqUUJrvVgr5sBhFfh6zxmw1WEJpAFzUn64WQY9zsgCyJh7jty
	5G/twXQPkdV9fPG3b1Rquu5zt9abm1DtfQr869U9bgM6ZQx6MDerqWSA86AkkJnBn+7r3Ydw3tD
	h/mD8XB0h5rQ9gHudmWAEswyIgCFYr3JI16nCzHEoPdM8=
X-Received: by 2002:a05:6808:1508:b0:3c3:62e8:b257 with SMTP id u8-20020a056808150800b003c362e8b257mr12175265oiw.2.1710792253782;
        Mon, 18 Mar 2024 13:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUhgF4cxTmP19vnk1XO+36zS6Ji6sYyFBctjoFtXbctIHX3L15GV2lInQmSaTOj2BJ1Nuktg==
X-Received: by 2002:a05:6808:1508:b0:3c3:62e8:b257 with SMTP id u8-20020a056808150800b003c362e8b257mr12175212oiw.2.1710792253188;
        Mon, 18 Mar 2024 13:04:13 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:12 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org,
	peterx@redhat.com,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v2 05/14] mm/sparc: Change pXd_huge() behavior to exclude swap entries
Date: Mon, 18 Mar 2024 16:03:55 -0400
Message-ID: <20240318200404.448346-6-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318200404.448346-1-peterx@redhat.com>
References: <20240318200404.448346-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Please refer to the previous patch on the reasoning for x86.  Now sparc is
the only architecture that will allow swap entries to be reported as
pXd_huge().  After this patch, all architectures should forbid swap entries
in pXd_huge().

Cc: David S. Miller <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/hugetlbpage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index b432500c13a5..d31c2cec35c9 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -409,14 +409,12 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 
 int pmd_huge(pmd_t pmd)
 {
-	return !pmd_none(pmd) &&
-		(pmd_val(pmd) & (_PAGE_VALID|_PAGE_PMD_HUGE)) != _PAGE_VALID;
+	return pmd_leaf(pmd);;
 }
 
 int pud_huge(pud_t pud)
 {
-	return !pud_none(pud) &&
-		(pud_val(pud) & (_PAGE_VALID|_PAGE_PUD_HUGE)) != _PAGE_VALID;
+	return pud_leaf(pud);
 }
 
 static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
-- 
2.44.0


