Return-Path: <linux-kernel+bounces-40975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CFA83E92C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077A41F2936C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1401BA22;
	Sat, 27 Jan 2024 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jTFswpDR"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378A2F3A;
	Sat, 27 Jan 2024 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320884; cv=none; b=n18KofAukUBzVwqygr6f6XCcS++U6zx0IPnB3iECSMT4pEhSANqIHbszLt4X46hqI/wFh8gMbNssyz5tnlJ4I6X8NEvdSnTmuDUwCQ1bT3O75i/yzWKjc689vxz5+alp+1T/cW0/DCzezu4q7UwDc/ikqjep+2W1SmeexkVm+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320884; c=relaxed/simple;
	bh=iy4bbPlcTHR5BujKxgwpeH6pLrpzI4Fhpz5iOUvrDBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsIJQuaAzXrT3+h4bE3ALKTMGPtoByr/13u5MzEAjs9c0TbEvuGRjDI3k3KGfH1OOiVSDPhv8mmW3QOW6EFDxCpWHZuWLK29XX9tsKhdy+ss095u9/gx2sL17urRNCXJstk9YUEbl9pWxYTHFJuO3bGJm8+ZOeU4W7hP+EK0zH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jTFswpDR; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706320879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3mxHfQelYlqL6oP1Hnoe6QZezCLAhWkLAbAnrEYZUDY=;
	b=jTFswpDRYA+jkiETjI/gfWRf08taHsK/aVZvXqWCGXMdjSIgz69OD0xCLALCZwEQ28TjAA
	VNv4HhxX4J4c4A7y7jsuhMHrs+I/Pa4txUGFkqiFJ9ycOBUEKlhQVZaatFlM22qCKibxTg
	DM5z9B9BdJCqHFaWR/Aaj+g93ZO1hD4=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vgerkernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	peterz@infradead.org,
	boqun.feng@gmail.com
Subject: [PATCH 0/4] lockdep cmp fn conversions
Date: Fri, 26 Jan 2024 21:01:04 -0500
Message-ID: <20240127020111.487218-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

rationale:
*_lock_nested() is fundamentally broken - in order for lockdep to work
we need to be able to check that we're following some defined ordering,
and it's not possible to define a total ordering of an arbitrary number
of objects with only a small fixed size enum.

so it needs to go. awhile back I added the ability to set a comparison
function for a lock class, and this is the start of hopefully a slow
steady trickle of patches as time allows to convert code to use it.

Kent Overstreet (4):
  fs/pipe: Convert to lockdep_cmp_fn
  pktcdvd: kill mutex_lock_nested() usage
  net: Convert sk->sk_peer_lock to lock_set_cmp_fn_ptr_order()
  af_unix: convert to lock_cmp_fn

 drivers/block/pktcdvd.c  |  8 ++---
 fs/pipe.c                | 77 ++++++++++++++++------------------------
 include/linux/lockdep.h  |  3 ++
 include/net/af_unix.h    |  3 --
 kernel/locking/lockdep.c |  6 ++++
 net/core/sock.c          |  1 +
 net/unix/af_unix.c       | 24 ++++++-------
 net/unix/diag.c          |  2 +-
 8 files changed, 55 insertions(+), 69 deletions(-)

-- 
2.43.0


