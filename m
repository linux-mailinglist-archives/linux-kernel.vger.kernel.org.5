Return-Path: <linux-kernel+bounces-140404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC348A13F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05871C20366
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331A14C5BF;
	Thu, 11 Apr 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dW5jHdo1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898F14B09E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837161; cv=none; b=rLdUOTB7xx3UPjV3yrXHRxcly0eefUtbpOBXJIQ8o6HZqdbP9y21S7NM/SNfRJNEnspkj8v4oAeGDBdCvUS9LzE7C+g+X3EC9cnCb4dywZFqxAe42+1/R23o3GoDcBzGHNxea//aHoKOFNX+qkOEfQg3zVsuSTl5anIPkPuj4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837161; c=relaxed/simple;
	bh=CRfT2nz9BUNbS5W61TqhZC4a5CFzF8Z52TOUInd0dKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c44C188fp417ElqWBSXAFcJ1ZSxcXZdFc5RFL/apUcPs+D5xql0qCmu5XeruE4O1M1/GFQjnTUWM4n4TUsXu8gc1QA+uZ37mxt9mKKO4vBibvO5Qfu/peDri3DSfRyh+fV0I6BUDMFsfQ5WlPPfFyz0d3ChhZy8YH+Ij2hH0y8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dW5jHdo1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712837155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ytNFNKtdcF5mu7UnZA6pPMlfQCsVJ9uzk0MPXgKTnEo=;
	b=dW5jHdo1oMwOJlJu1RRFeymbnr/16d5fqH/c9fcYyPhb7ggkTLvyRaUlbhEuzVyl2XbRTW
	4zJOmQba71Ivx2Ec4b+q2Az3PUjrhRugco0C83FVxsM5oRete2Vsk3xZXX6Nhqhelav+E4
	cBnGQpL2NgvAJ4VjHRw2qXsrNqLz8NM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-JudkfC5UNjaE784uI2zziA-1; Thu, 11 Apr 2024 08:05:51 -0400
X-MC-Unique: JudkfC5UNjaE784uI2zziA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF2F8801797;
	Thu, 11 Apr 2024 12:05:50 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 072EB1C060D1;
	Thu, 11 Apr 2024 12:05:47 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: dccp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	mleitner@redhat.com,
	David Ahern <dsahern@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 0/1] tcp/dcpp: Un-pin tw_timer
Date: Thu, 11 Apr 2024 14:05:34 +0200
Message-ID: <20240411120535.2494067-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi,

This is v4 of the series where the tw_timer is un-pinned to get rid of interferences in
isolated CPUs setups.

Eric mentionned rsk_timer needs looking into, but I haven't had the time to do
that. It doesn't show up in our testing, which might be due to its relatively
low timeout (IIUC 3s).

Revisions
=========

v3 -> v2
++++++++

o Rebased against latest Linus' tree
o Added ehash lock usage to serialize scheduling vs descheduling of the tw_timer
  (Paolo)

v2 -> v3
++++++++

o Dropped bh_disable patch
o Rebased against latest Linus' tree

RFCv1 -> v2
++++++++

o Added comment in inet_twsk_deschedule_put() to highlight the race
o Added bh_disable patch

Valentin Schneider (1):
  tcp/dcpp: Un-pin tw_timer

 include/net/inet_timewait_sock.h |  6 ++--
 net/dccp/minisocks.c             |  9 +++--
 net/ipv4/inet_timewait_sock.c    | 59 +++++++++++++++++++++++---------
 net/ipv4/tcp_minisocks.c         |  9 +++--
 4 files changed, 55 insertions(+), 28 deletions(-)

--
2.43.0


