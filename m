Return-Path: <linux-kernel+bounces-161547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF58B4D90
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085431F2149F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F3574BF0;
	Sun, 28 Apr 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz2vYaYP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593773537
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714330921; cv=none; b=nAs0B8inVh5T93CqtEDYeDXG95gGoZfxPueIUfusVtzpryDaR8145pbUXvOAQUS2Q3XYrNVvIWq1rFdofbzHEEw9v8RXu6ymorMhQOhJtpJN9yinrDGsDJnJvUhYOjDVHaMF8bRHltJ/WLUbp++egS8XmVQb02/vdSNZhZUn5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714330921; c=relaxed/simple;
	bh=SNAxFei4D1lMKt3YFLNoNLtx7wz6h8jeISB69f4sVMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tM5BheuWzICPUBiesUx4WR2iytoYyRrGMXDSZEThzPiUpvbHr9Zo5CBZ0gL8ra/cWOI/RoGKmEhia7cvmlBXM30dSvnA8HQVEiMMXF5kAx0XmWSTbQOqeQurxkLSkr/pQgoymwVEYulIFx1p4p3ovbi3jrDZA12BMox4Q8R9w8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sz2vYaYP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714330918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TChkYNJLokf0R7TU3fj1Jd4fvD6sn29Wrs03bf1LQhQ=;
	b=Sz2vYaYP7kU0T7mh+rtQ3NBXpG0rWURetf5YAPrnzr9dcpxIrUL+KRfeJeL3BQ2N9cHE1p
	EDwOW3rs9xwVc9tppGLthFHEOMIr/HI9MxuZH7BkKIkVO/OjSHnIfLnTaF9tJtwKg4SuAO
	juIueuQgJcNaKc3k5LbNpD+sDpnudRI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-Um-PCDxmOzyheBuURA9szw-1; Sun, 28 Apr 2024 15:01:57 -0400
X-MC-Unique: Um-PCDxmOzyheBuURA9szw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5acdbfb49dbso1252088eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714330916; x=1714935716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TChkYNJLokf0R7TU3fj1Jd4fvD6sn29Wrs03bf1LQhQ=;
        b=XjkLilRxMoKi3aA6IbRgD5mOb6svZo08X2S18ZI3DfEDy3vsvAmLwbaiyjOYrwmv+m
         Mu683oeVFGsMHEBnqfOA2jD/fppG9SQL5HcvkpkxhjO70/+2kGi0AlvcjifhspR5x6Vp
         V63DyVahsa5XWz8PTtnFPJCEhidu9j9RDyv+MWUVvmVDhyAA23XBjpwXTj2tSG1zfmFA
         mlzccy2gURAE7V5VgbSTsnoJdxWRTl2YEzqWBXW2WzHph53eZhdkvFXhYyw+TqIZ/s73
         2mas7ChXB/ecsFszsKIT8lD6VF24AoMK6MWa/1c7MtcIb++FslVGjMdRn7odbxyFB1+6
         RzbA==
X-Gm-Message-State: AOJu0Yy1CEcSPIfVDraRSZLhMFrcI2tN8o/u2VPMFRCpPbs/LHPOlykr
	OFc6dJkcpdcl+xbZKdkopJsctHvvTTlPThIJwg4FrpIQfr5lrS9EaYFoZPAjSn5P8gTQ/mJ0riz
	p5H3QPoTriHDRBHwQjJXQqOPrNT8u7dr7wM2F7BmwV1RZ4KNjfsF0CBdY43w9Ka5RQe/HQ+zoyD
	CDMfwxE/2ibHKnROmzJMuKoYoPbsgb5/xw63oN6sRqLlE=
X-Received: by 2002:a05:6830:7193:b0:6ed:ffd4:f871 with SMTP id el19-20020a056830719300b006edffd4f871mr5375208otb.0.1714330916292;
        Sun, 28 Apr 2024 12:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbfCPhcOZyAaf7bBZJaTYiO0a8lHR2gVf15VHmfKPjl2t1+bRyODyi0XieC0TmXGWNmTdCnA==
X-Received: by 2002:a05:6830:7193:b0:6ed:ffd4:f871 with SMTP id el19-20020a056830719300b006edffd4f871mr5375155otb.0.1714330915677;
        Sun, 28 Apr 2024 12:01:55 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id oo8-20020a05620a530800b0078d693c0b4bsm9818152qkn.135.2024.04.28.12.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 12:01:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 2/2] mm/selftests: Don't prefault in gup_longterm tests
Date: Sun, 28 Apr 2024 15:01:51 -0400
Message-ID: <20240428190151.201002-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240428190151.201002-1-peterx@redhat.com>
References: <20240428190151.201002-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefault, especially with RW, makes the GUP test too easy, and may not yet
reach the core of the test.

For example, R/O longterm pins will just hit, pte_write()==true for
whatever cases, the unsharing logic won't be ever tested.

This patch remove the prefault.  This tortures more code paths at least to
cover the unshare care for R/O longterm pins, in which case the first R/O
GUP attempt will fault in the page R/O first, then the 2nd will go through
the unshare path, checking whether an unshare is needed.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index ad168d35b23b..488e32186246 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -119,10 +119,16 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 	}
 
 	/*
-	 * Fault in the page writable such that GUP-fast can eventually pin
-	 * it immediately.
+	 * Explicitly avoid pre-faulting in the page, this can help testing
+	 * more code paths.
+	 *
+	 * Take example of an upcoming R/O pin test, if we RW prefault the
+	 * page, such pin will directly skip R/O unsharing and the longterm
+	 * pin will success mostly always.  When not prefaulted, R/O
+	 * longterm pin will first fault in a RO page, then the 2nd round
+	 * it'll go via the unshare check.  Otherwise those paths aren't
+	 * covered.
 	 */
-	memset(mem, 0, size);
 
 	switch (type) {
 	case TEST_TYPE_RO:
-- 
2.44.0


