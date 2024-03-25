Return-Path: <linux-kernel+bounces-117057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDC888A683
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51261F61F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505E01F5F3;
	Mon, 25 Mar 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNycyUXg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550116A1F4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371009; cv=none; b=HBNtzhsV8zr7ismiltmu38/BdFBkzH8SrTGbNXxjvfX3JKKGgX9IxDjtkZ6+NjSzZmy/hf46Hnj+Lq8Heohhz8grFxda1NO4funG34IU/y4JZ9Qxcw2KyAZ5qFF2LYZbvdhMW0OLGpLeqfcmrb+VklgU5dImM2w0ApZDuVyp5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371009; c=relaxed/simple;
	bh=vAHtlz7EdInjfZGeFUSgT85zxEWB2RvrCTuxA66VMhI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TgBxp8YCl/HBtk6/sV5c32CWrRz1ZDayqJR1EUhemn80+ZSOgfPz6kN7QcmOAk2ItyxLDE1NcsaGLSb2bBIH76+KP4++X1/IXZF6OYr+YlMlY5SVXsgGveHdHOQwTSbQuDq3iqjwAZEOlXenChR5iLQA2XfV/Odnqu5fKvZYCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNycyUXg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711371007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=FQeTg2MSrh+5DBiDfsa1lDw6CBQxljCXYQRwjVGNh/g=;
	b=jNycyUXgRRUKPx5LUdRpQz2iYW/u4vT6Fx8ZwpAVYllUsq7LdNHpso+/mzXcp1aPWGIA/w
	WMo8qY0VDZYQazctyX25cznf7MZsqFuicnp1AcT1wiNsMFbtqK7Fi7hlt84MKyRYR5z3jG
	SoxMhId4gEutkKqYP7+4Ny1lvXm0IQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-5I4bICssOvSChRNKzHocTA-1; Mon, 25 Mar 2024 08:50:03 -0400
X-MC-Unique: 5I4bICssOvSChRNKzHocTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 019EC8F1F15;
	Mon, 25 Mar 2024 12:50:02 +0000 (UTC)
Received: from localhost (unknown [10.22.8.120])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D3F81074E;
	Mon, 25 Mar 2024 12:50:02 +0000 (UTC)
Date: Mon, 25 Mar 2024 09:49:57 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.213-rt105
Message-ID: <ZgFy9au0Gvkzr6gZ@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hello RT-list!

I'm pleased to announce the 5.10.213-rt105 stable release.

This release is an update to the new stable 5.10.213 version and no extra
changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 200d9bf140d7c6c9fde6f7d1ab6d8d973fd47910

Or to build 5.10.213-rt105 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.213.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.213-rt105.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


