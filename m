Return-Path: <linux-kernel+bounces-48294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC268459B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAE2285F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CC5F476;
	Thu,  1 Feb 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6KCgJfD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8185D499
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796739; cv=none; b=h8y62R/7Vb+80Fe7YKN4spaXg1iJdQxgT0onYX+REgEd0Yx3T+kW56hgFF0plzxcS61gYj1z2Dwqoh6WDWc7z7wiSew3ARTlOw1Q0WZt0MtCyT+43oGY7ay15AwQBcM15ES5KTW6drWfMv4n5d2OYOeGXn1ED+xB2c9lGUo0NFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796739; c=relaxed/simple;
	bh=WBVM3neXLXU2Mk3vMLp7/mqFO+dt8lVAj2XCpTmISys=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PffZd1OPAfhIe/jr6zCxatN6ex2Uzyuz5rZ4kqg5aK1HJhSLcDaDrHGE6Q6qV1HJRu2Z6zZ5CL7QJcfMR0do0u/4kbdfEIVR5lOWBzioMik0iOdjrFwaA5o6D0p2ce9SsvqAPDQMIWkqYjs83Fark0Nxbumu1/BCBzmZoXPi6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6KCgJfD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706796737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=aQU410ABE1pym2sA3RLoHJZ1Td4guFKftSlr219gO7g=;
	b=N6KCgJfDeFlWB8+LvWZbCu1jB7tHj6dgdw+rOkMg0fsMZYth7IgAzWVKbxuT3snT6O8aRG
	6QRsqsRwk/7Bgi9IN/Q0fWCYNPVp1ePW5TpidDB0SSBe8F6s/wP8zuvNaObIg9Mezb45fs
	FJqXWS+aHIf8U9eQ1EebV1/ZajBsCFI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-JzGJ8wBrMBOnn9HQiXhiVg-1; Thu, 01 Feb 2024 09:12:10 -0500
X-MC-Unique: JzGJ8wBrMBOnn9HQiXhiVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A66BF85A588;
	Thu,  1 Feb 2024 14:12:07 +0000 (UTC)
Received: from localhost (unknown [10.22.32.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F02E72166B31;
	Thu,  1 Feb 2024 14:12:06 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:12:02 -0300
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
	Mark Gross <markgross@kernel.org>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.336-rt159
Message-ID: <ZbumspYp6S14TONh@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hello RT-list!

I'm pleased to announce the 4.14.336-rt159 stable release.

Please remember that this is the LAST 4.14.y-rt kernel to be released.
Refer to Greg Kroah-Hartman's announce of 4.14.336 for more information:

  https://lore.kernel.org/lkml/2024011046-ecology-tiptoeing-ce50@gregkh/

Again, 4.14.y is officially end-of-life. So is the RT counterpart.

This release is just an update to the new stable 4.14.336 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 998ff9c899891ef962ca1cb42bf807dc5d223ebf

Or to build 4.14.336-rt159 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.336.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.336-rt159.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


