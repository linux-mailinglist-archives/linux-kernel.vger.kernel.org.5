Return-Path: <linux-kernel+bounces-153458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5868ACE55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92C2281653
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDC11509BB;
	Mon, 22 Apr 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTHxds5d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC914F9D8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792802; cv=none; b=oEwYyM/+KTJdJfkBKcdorsKyKxf3A0rloXiHI+eEj8q4eyXXXzyUZittTuG4uk0TMzCPOlI5M+NUWDA/46pCHgQ+zJuLq6RrJTW0TUiwRja1TegoIwewA/NZ+iSeAe+fg58XGYfHDfiJkLmfTsf8VBe8Q0/UTKPkdXchNw1HHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792802; c=relaxed/simple;
	bh=4Ob8Zycf6XNs5PfydV0Z9JFRZRZj+ue557ZvcL3Ls8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOJ+IRYNLQ3hc0NY0lm3J6x8SVE7YJWpCF6QMj6Su5H0r9X18zJos6zUo6WQqHC2QUsEXZe8RiGrgdcde/Q653OT/E0XL7da6/AMKDw4J3opmAEa0xoOmS52SzyQQ9xPWba2xTXgMtINdjr5KgupRROgYwsS19YN/4ovQ9oVCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTHxds5d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713792800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TsLvrrpgeWiaazNPsZyT6zMTgXSV8fNIsFxUi4A9ymE=;
	b=bTHxds5dS/0yGHXTPigfzIiBNBZlIw6w61E8pK7SgzWq2nyrkE/y9qB324bru8E8XDgtz2
	rpTusST3i1fi7g5NgJp7paH4ii4kVortH7Od4UK5uBzzN9e+n5t1j91uPesuvYmus0S1W8
	ZbGZU5RHJp1Gz6gpY2qwtZJWAPk8qEM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-jBQQlG_wMMqj3J5Qu783QA-1; Mon, 22 Apr 2024 09:33:18 -0400
X-MC-Unique: jBQQlG_wMMqj3J5Qu783QA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ade3de68c1so275156a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792797; x=1714397597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsLvrrpgeWiaazNPsZyT6zMTgXSV8fNIsFxUi4A9ymE=;
        b=BmHL6dVc3oa1aW3rqcarcgPDyn9CJ2UMbF4dE95VCWS30HqUOSn/H+PD+XLbMAMDqf
         y76x8/c/nhMe3U7TgnrF78Ioi53bJPHxkT4VcXdDf3pc09EA0zeObV3eQ9vwHyFAZ25D
         YiOL9QtBurly2wf3+0K2RBuyXtF9Hz2ZhluhWPlRg7T93vbcm+A++eLKJxcdjp0L1xVz
         Nwsn8zk4iDkIoFvD/QA8gUlwl3MacH88zzbkpSE5SGBWRlx2OShstfgRwl+2DoCJn1ji
         ej/4lrO999qVR9fYM96RugTtprfsQc+mSbZlOl/g2n/yI7dcPv9SOtHrSPY5GDAOxxfy
         s8xw==
X-Gm-Message-State: AOJu0Yxy9bz6nJV1EQG8UdU5M9hc2D1enTYhn2ZlbVLJrCqRGIegpSFk
	vgG8ERIAu0Gg76eXHD63xK6waXKXZYTZYs/+xB+gTsV6gIaKkNs4dsw5mAvaM9oRDaBkkqF5hNR
	7167DMRLMsi38FrFawRpYYL9jyYIlu7xTPC2+/gNuaeaWeTc0oKrjzUYVzEzC1bBijC+ZVMIs/P
	CKXbiqCPjzvCpkoaL5Hy1q6VAgFgVPagg7BrKm0jvahFk=
X-Received: by 2002:a17:902:7b87:b0:1dd:e128:16b1 with SMTP id w7-20020a1709027b8700b001dde12816b1mr11644776pll.6.1713792797391;
        Mon, 22 Apr 2024 06:33:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs+daoEIT53Szg5CEW494B5kmIIY0NotIcW6GQlEiEV8dnhii0L57FjTPcisCk2Mis3NrHgw==
X-Received: by 2002:a17:902:7b87:b0:1dd:e128:16b1 with SMTP id w7-20020a1709027b8700b001dde12816b1mr11644713pll.6.1713792796619;
        Mon, 22 Apr 2024 06:33:16 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709029a9100b001e2a4663179sm8101993plp.258.2024.04.22.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:33:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: peterx@redhat.com,
	Nadav Amit <nadav.amit@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com
Subject: [PATCH] mm/userfaultfd: Reset ptes when close() for wr-protected ones
Date: Mon, 22 Apr 2024 09:33:11 -0400
Message-ID: <20240422133311.2987675-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userfaultfd unregister includes a step to remove wr-protect bits from all
the relevant pgtable entries, but that only covered an explicit
UFFDIO_UNREGISTER ioctl, not a close() on the userfaultfd itself.  Cover
that too.

Link: https://lore.kernel.org/all/000000000000ca4df20616a0fe16@google.com/
Analyzed-by: David Hildenbrand <david@redhat.com>
Reported-by: syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3e6ddda6f159..d2c3879745e5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -898,6 +898,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			prev = vma;
 			continue;
 		}
+		/* Reset ptes for the whole vma range if wr-protected */
+		if (userfaultfd_wp(vma))
+			uffd_wp_range(vma, vma->vm_start,
+				      vma->vm_end - vma->vm_start, false);
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
 		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
 					    vma->vm_end, new_flags,
-- 
2.44.0


