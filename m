Return-Path: <linux-kernel+bounces-144992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 121638A4DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96F91F230FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5289B60B9D;
	Mon, 15 Apr 2024 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diDvEDDe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B205D8F6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180903; cv=none; b=bTDQa8OoRSR8TBGV0IhpJ4IFtLEGKBQ2C7t3KDU3RF6l7gcjyJDO4H8xkBFuYed0N+cox6VSj51CwF8wxNmllfmUIXOpsRIq2tBCn1vCvu6Sd/tywiYy2oB4hYkpqpB7NP0lIZRxIegaPQpnjm8mksMTQ+4Dk4jpn5VU1/HaImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180903; c=relaxed/simple;
	bh=oxHCtuxwyM7cOnha78fodnI8/2nPA9V0tYQAbM8xax8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChjomqYl/UmTmSYTxz+hQbAJ4CTa73SUz8doi9c7VmyUGC1bJHfYjnKSrd0rBOnNu/r/xE6SFAHekyA5CkAC963q+pVwAfFH50s972dupDUKmlhP2ZpilSlI+SUdlnP6eg1KoxOtC/0wdoJsU2kb7Qxm3Fwn0/iGJj8uEvgajvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diDvEDDe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713180900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u36oSuZ9892J7+6mnaPBiCYYNXIpRi7HFPb44PW/B8k=;
	b=diDvEDDebmdI+1SW9jJvAQBpOSduQV6+/RZBf7TaVYhIeNgNrW1EIwcnTyVLMU2kriQ+Yh
	WNmyf4UIIvpJ5aP7l8MjdWEGbeqNmMU15I0Y4oH2BkyZSfoSjjZcZhgJvUMv/b1DYbzFoY
	ro7XYadjh71Pvc0GgVO7y2kSV4Cs89c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-tgvuqcLcPsGQ3JJWJejAAw-1; Mon, 15 Apr 2024 07:34:57 -0400
X-MC-Unique: tgvuqcLcPsGQ3JJWJejAAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E87D8059E0;
	Mon, 15 Apr 2024 11:34:56 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.251])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C45C1C0666D;
	Mon, 15 Apr 2024 11:34:53 +0000 (UTC)
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
Subject: [PATCH v5 0/2] tcp/dcpp: Un-pin tw_timer
Date: Mon, 15 Apr 2024 13:34:34 +0200
Message-ID: <20240415113436.3261042-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi,

This is v5 of the series where the tw_timer is un-pinned to get rid of
interferences in isolated CPUs setups.

The first patch is a new one stemming from Jakub's bug reported. It's there
mainly to make the reviewing a bit easier, but as it changes behaviour it should
be squashed with the second one.

Revisions
=========

v4 -> v5
++++++++

o Rebased against latest Linus' tree
o Converted tw_timer into a delayed work following Jakub's bug report on v4
  http://lore.kernel.org/r/20240411100536.224fa1e7@kernel.org

v3 -> v4
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

Valentin Schneider (2):
  SQUASH: tcp/dcpp: Convert timewait timer into a delayed_work
  tcp/dcpp: Un-pin tw_timer

 include/net/inet_timewait_sock.h              |  8 +-
 net/dccp/minisocks.c                          |  9 +--
 net/ipv4/inet_diag.c                          |  2 +-
 net/ipv4/inet_timewait_sock.c                 | 73 +++++++++++++------
 net/ipv4/tcp_ipv4.c                           |  2 +-
 net/ipv4/tcp_minisocks.c                      |  9 +--
 net/ipv6/tcp_ipv6.c                           |  2 +-
 .../selftests/bpf/progs/bpf_iter_tcp4.c       |  2 +-
 .../selftests/bpf/progs/bpf_iter_tcp6.c       |  2 +-
 9 files changed, 69 insertions(+), 40 deletions(-)

--
2.43.0


