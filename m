Return-Path: <linux-kernel+bounces-35545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC39B839307
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC21F23366
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C04B60ED4;
	Tue, 23 Jan 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyYVC4eX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF3E6087B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024078; cv=none; b=NSInk5suvnqHmRIgpGF2byDygX0MWSD9q7RMjU3MXHAsFwSQOC/ek6eE7ADqZrrij+elrRvJTZ0FS7PoBmzQxDXjMwXhZx6k/ztuYw3BEZeWuK31h7Os4DyX/2DeRa9RhoQVuq6/7IYVLY3wUu4eCBS4v8DydfM9IV8ukmZkRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024078; c=relaxed/simple;
	bh=LnwHGn88+81X3IqzrKkhOGc1geOo30Jg71Fn2SQpiuw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LTLRbYxbmqctwRMKhuTaZ9N7+rEzs/2etWb422KmaX3PhT3iPHo/lRwVegVOyEqe6xu1xAIP3zyNyhYaVfoD0+SJWNTlQgqHP5Ry9k+YLdU9fiEGG0kN9/nOsDpHhW28JMyQGOkqHpWSgKNqxPpG7ln6nwJptVuEBO+/nI1Osmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyYVC4eX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706024073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ESCqsLfyB1eo9BBxtfoyLfAC1646jR8s7IT62e4/cWw=;
	b=iyYVC4eX9HsTxM/95nPI8grALjKZbsfILOfno/bfZYq7AsAGEaQZ6o806lLOy/f/kO9VBK
	o+E8jgiEu2Hg3G4O4pMvPAtZ0/udo891jZa5vwdHu2VJ+37Xnd8EVm6Toq6RNpLHyqpb5y
	eG+GFcGP4SSwnN7V8eo7tgzztWWXdZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-boRKdBLsOm6wMMgu9_TW_g-1; Tue, 23 Jan 2024 10:34:30 -0500
X-MC-Unique: boRKdBLsOm6wMMgu9_TW_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D440F18A668E;
	Tue, 23 Jan 2024 15:34:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with SMTP id A382A492BCF;
	Tue, 23 Jan 2024 15:34:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jan 2024 16:33:15 +0100 (CET)
Date: Tue, 23 Jan 2024 16:33:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Dylan Hatch <dylanbhatch@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] fs/proc: do_task_stat: use sig->stats_lock
Message-ID: <20240123153313.GA21832@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

do_task_stat() has the same problem as getrusage() had before
getrusage-use-sig-stats_lock-rather-than-lock_task_sighand.patch

3/3 depends on the patch above.

Oleg.

 fs/proc/array.c | 66 ++++++++++++++++++++++++++++++++-------------------------
 kernel/exit.c   | 10 +++------
 2 files changed, 40 insertions(+), 36 deletions(-)


