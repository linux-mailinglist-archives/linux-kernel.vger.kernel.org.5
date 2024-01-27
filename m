Return-Path: <linux-kernel+bounces-41009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785AD83E995
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC7B1C231EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA45413AF8;
	Sat, 27 Jan 2024 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OSEMzeJT"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26494125A7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706321324; cv=none; b=YUKlaExRXWSD6dXlZ/pwyNeIFcq7EnZiW7iGr7hihcFQCoWPEuiokpvhrN2nxyvhb7o6K0XcqKWlGHmC19IoaukmLN/BNqp36jFeX7EUxOR2RtBrwEkR3rbSeqxme0jAu6ubWu50kisI28proLxp0axBCm+iYRFDpzLJaXpwIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706321324; c=relaxed/simple;
	bh=iy4bbPlcTHR5BujKxgwpeH6pLrpzI4Fhpz5iOUvrDBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vd5HwkspCwUvu4symr9b0Y/ZVMFaS2VE7UnQa6sMgCpmE6Fq/aA9BQ9dHdZNhDY5Qc7jClssdz+ehODNHbNmZzW6OFtBW//FtKO88Jm3iUhwvCQVjPTVNZ8XZUOSi+YhkvLlehX33oJLFFhnrYKePyN8VlYIsbCJb6KElIUHcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OSEMzeJT; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706321320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3mxHfQelYlqL6oP1Hnoe6QZezCLAhWkLAbAnrEYZUDY=;
	b=OSEMzeJTWSmablzulvFvVfNX5hGQRamLGo2HX4EUeO9P2OMLBXPodf+HaSi4Ws2B10k6FB
	LFdSHAH/6v9tW82PDrv8NhWtuj3XCcRtl9PWY27sYpY2Lbr7fmLbShK9BjrQyPNEZ5BKeG
	R6aEmWU7ZAd9wBrxp91RNt6GZyYPJP0=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	peterz@infradead.org,
	boqun.feng@gmail.com
Subject: [PATCH 0/4] lockdep cmp fn conversions
Date: Fri, 26 Jan 2024 21:08:27 -0500
Message-ID: <20240127020833.487907-1-kent.overstreet@linux.dev>
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


