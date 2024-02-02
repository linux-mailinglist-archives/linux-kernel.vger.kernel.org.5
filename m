Return-Path: <linux-kernel+bounces-50134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA58474AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB33B28C04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490491474D4;
	Fri,  2 Feb 2024 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSCrlcH6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DC1482E3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891320; cv=none; b=VJGKwcJraexM8CtoAkwo8XZbgsVf3a0Xc5MaNr/lkhlu+/Phbs4omG6Q9+uBCl4tG626bJRH6KKgLHk2j9pnCjNtPgxdOvXYFy5dxNtflXip2pFW/x8xlex0hy903czylbhFdiXK7nj4FYKJOllNIk5dM75/MK0Kzg43VYEtw8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891320; c=relaxed/simple;
	bh=ynb1SuwKDMn/YW6pcXwS9xS4LXsN4oKc3c43owAswdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/88bNwtjwgVMyzBBPWy9J318kYGfbzCnq3FyRZBivhvqRyaXm6TUD1wH9UTUbhVdIeQV5R2EYFPoco7HYDVjjQLI1fWCqlzbrvdTjMuyR7nXPxhFYkS626/PFGTfMZZCXamBlWPM4FP8SHxVQXMK4jaLNJgKYSMy1bkwo21qfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSCrlcH6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706891317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f4sg8ngQV+YCG5W44kOHXLI2B9gQBr0FDRRIE/pWnas=;
	b=KSCrlcH6b5Ni+f45Cee/bP2So1LKIS+KkPfatjmPRxYW0cWKaAlQ7+ZK33xW8GjKdzHLAH
	UcWK6z/d2QUfWW3cdqJ7PYHnT9Eg5tQ4sav9OCFmSLboeAcnUilrRZV8FKUfoYO+E4W5K9
	05lCHNB7M21VEfFdllox9YNFWe/sj4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-UYgdjthcPtK65-7wH90RJA-1; Fri, 02 Feb 2024 11:28:36 -0500
X-MC-Unique: UYgdjthcPtK65-7wH90RJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA6B1827D85;
	Fri,  2 Feb 2024 16:28:35 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F52D2166B31;
	Fri,  2 Feb 2024 16:28:35 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Revert "gfs2: Use GL_NOBLOCK flag for non-blocking lookups"
Date: Fri,  2 Feb 2024 17:28:27 +0100
Message-ID: <20240202162830.1323578-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hello Linus,

please consider pulling the following tag to revert commit "gfs2: Use
GL_NOBLOCK flag for non-blocking lookups".  It turns out that the commit has
several issues, and not all of them have a simple fix:
    
      https://lore.kernel.org/gfs2/20240202050230.GA875515@ZenIV/T/

Thanks,
Andreas

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.8-rc2-revert

for you to fetch changes up to e9f1e6bb55bea4f8cb48f8f7443bbac99b60d285:

  Revert "gfs2: Use GL_NOBLOCK flag for non-blocking lookups" (2024-02-02 17:21:44 +0100)

----------------------------------------------------------------
gfs2: revert this broken commit

----------------------------------------------------------------
Andreas Gruenbacher (1):
      Revert "gfs2: Use GL_NOBLOCK flag for non-blocking lookups"

 fs/gfs2/dentry.c | 23 +++++++++--------------
 fs/gfs2/inode.c  |  8 ++++----
 2 files changed, 13 insertions(+), 18 deletions(-)


