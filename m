Return-Path: <linux-kernel+bounces-150738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AB38AA3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6447A1C210E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0534418410C;
	Thu, 18 Apr 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeaKFxT3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3717B504
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471377; cv=none; b=kkdizQc5mHQ2KEOwraeux4/+grn5AJ7HGyf28+MEx76Eql3zq+fnFdsC1pQzCGr6YakYrqSG03yd4erHoEy1dIiBc83X8A5oJt+Q3R89hA+aHcCYDUCRDdyizGCKDXNXZAU9S9NLi7CgKR5/4OwhO1dXj0LRu2GGBqqDkCYN8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471377; c=relaxed/simple;
	bh=dx2yvgtH5yzxZfh42ugwTqymuzBLhNmK7ll7YG1RdO0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LLC0tYlfvsMF0gSFdLEO2KMoS1yPQSWSIEnkDm1gqmoWZx9hJba9zsIax5nCLOr26yFTGKe81uZIycRxmbRy5HCB5ZYx33QCmoAVLsQQWamfgyAFfpY8zzC7aHoySA3A8NriCZNzn3WLeNBZUq+k6Sgdl2I48z7OQq3x6q25SWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AeaKFxT3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713471374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=RbnlUddStSZoE4ERVOKsgwX95yDpQSDI8hJv+RT7aiA=;
	b=AeaKFxT3cNQ19RqAPEhzdmtOgshJ3vISLJ/E5eUwtBZFKCULvi5lGy3u5Yx8hRy5KmgEs2
	RopoWYKPqrBYmsc11/sbq8fO+4K7AlHcnYodWVRV3WE0jFYReAhlidpEXACRnAIDawU0dj
	EJZYQlx8HQ7sKMLCd1YU74zCgvi27t8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-Jklv0C5YPRe8QU95TSFegA-1; Thu,
 18 Apr 2024 16:16:10 -0400
X-MC-Unique: Jklv0C5YPRe8QU95TSFegA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E278629AA387;
	Thu, 18 Apr 2024 20:16:09 +0000 (UTC)
Received: from localhost (unknown [10.22.10.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D383940829C7;
	Thu, 18 Apr 2024 20:16:08 +0000 (UTC)
Date: Thu, 18 Apr 2024 17:16:07 -0300
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
Subject: [ANNOUNCE] 5.10.214-rt106
Message-ID: <ZiF_h-W4jgLiRag5@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hello RT-list!

I'm pleased to announce the 5.10.214-rt106 stable release.

This release is simply an update to the new stable 5.10.214 version and no
RT-specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 3d208061796d4addeb543c78e0a4ec769b6ce6b2

Or to build 5.10.214-rt106 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.214.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.214-rt106.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


