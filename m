Return-Path: <linux-kernel+bounces-106693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C774687F211
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674BE1F220AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C6858AAF;
	Mon, 18 Mar 2024 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QB7YwHLe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8841C6C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797118; cv=none; b=lxHry2oPTxtEQsW0WDSiZ1aiWN6uX1jjBj8WXf9wXgZ8dbyxP9k6uNQNYTHU1sgWlmdxyeppPbeVCddaR4hOnDmXP01ho+V5bHqz0rwE04cMfMO66vohEhVEIMU5HwwDRasYkfYJ5hC6R4U4Q49VnWwwDHQmWhGVorFZEwN8++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797118; c=relaxed/simple;
	bh=1yYAUVXg471XBaEkdzLqewpUZFjkuA6bdcdrf5Xw5wA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GBCu8pXUZMOzPYOBQ2hko7IPoplpYoeIXVax+pU+hFm0OUGJMeKsKhlDflxoQ6Q35wmGN50TvvAt3w/jU7tS5Q9fcp8juhcJn4TyFTQ/JGfPt4av6gVeLO04m3D7ArkgQD4ilVgyEqsRyF5hksFSsPZn96DqFfrMA9iQ5CtLrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QB7YwHLe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710797115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UmM1fPWNhj6tjWD2n7+gLLrX2EVWqRmyZvqXhbV7HXk=;
	b=QB7YwHLeOSJa56FCGCGo80QdVcHq/gwpTnfaPKOvnoF4/TLLOv4tn3rkEtdfocl23nh2DP
	GdOWSjMpwQKKudK4+zoEctrIFZFGwahOyBEjozuPy11BrIePCQic0ILEXffcqI9BVllN0n
	AIwbYLWScEcI/cow5aJIyNJReVNLfN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-2vGLZnkgOBiJpvF1xb522w-1; Mon, 18 Mar 2024 17:25:13 -0400
X-MC-Unique: 2vGLZnkgOBiJpvF1xb522w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3218D101A552;
	Mon, 18 Mar 2024 21:25:13 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E566E2166B32;
	Mon, 18 Mar 2024 21:25:12 +0000 (UTC)
Date: Mon, 18 Mar 2024 16:25:07 -0500
From: David Teigland <teigland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Subject: [GIT PULL v2] dlm fixes for 6.9
Message-ID: <ZfixMxRWFNmkf-Ta@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi Linus,

Please pull dlm fixes from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.9

(For v2 I recreated the tag with the same name as before, but now realize
I probably should have left it and used a new tag name.)

I dropped the commit with the bad atomic usage, and replaced it with two
other commits: the first reverts the unnecessary change that began using
atomic_t for lkb_wait_count, and the second adds comments to the recovery
code that forcibly resets the wait_count state.

Thanks,
Dave


Alexander Aring (1):
      dlm: fix user space lkb refcounting

David Teigland (2):
      dlm: revert atomic_t lkb_wait_count
      dlm: add comments about forced waiters reset


 fs/dlm/dlm_internal.h |   2 +-
 fs/dlm/lock.c         | 114 ++++++++++++++++++++++++++++++++++----------------
 fs/dlm/user.c         |  10 ++---
 3 files changed, 84 insertions(+), 42 deletions(-)


