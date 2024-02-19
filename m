Return-Path: <linux-kernel+bounces-71077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE685A061
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A1C280A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8B72556C;
	Mon, 19 Feb 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMigIibA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C013324A1C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336673; cv=none; b=hPc3+ra2w12JyY7J7YPlWQH181nc1kLA2Pcmys9qVBrH6EpnxKrlXfj+rwk67KOjFOuNm8sGfZmovr1m8GYKEq35brCHmt+RkIG+MfbM+4K8SChA/YLfQ+GL1PFy25DQSCE+Jddb7PHZpuPotFEu4jVDBk79nKd9VRgXVN5oHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336673; c=relaxed/simple;
	bh=yQZprAUO9Y649VqM9TcmEKXOmPL5c7uCyFbnjiNJiIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCrEl6pQFV750XkgrdWFvK1fpp95+m43gcZPVG2qCO5pY0UVgecXP+6/+SjhzqpKpf0x2DdaONRzHnPbVMCnBLyAdOTk623uWyqRsvwBzUtCPDPZsmyTmkOJQmmp0NEyLqUW2mDY27eQwMCpLW7Nufpm2FtpTJxfZiOBHKyp8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMigIibA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708336670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QBPYE/u6rB92zok9wzUSH3tsYUrT4F0FkyjBL0qsOhg=;
	b=QMigIibAgVr/28pidzLQteGP+82eu6jNW2GSvDYhJUwt66iIY/8ratX2Hd7Hn2G0p31V39
	0RPtgvwY8W1+WXBRAElZWjCFgBXN6rjBgtSNvW5aj0g33d70PBlUh7+epMpECQVKJXiZMU
	cqDnU2Nni9H8280IZoYP6NYuw3EpOrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-B5JagkbBOC6kl_y96s9-7w-1; Mon, 19 Feb 2024 04:57:47 -0500
X-MC-Unique: B5JagkbBOC6kl_y96s9-7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D32B881C83;
	Mon, 19 Feb 2024 09:57:46 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B3BF8CEC;
	Mon, 19 Feb 2024 09:57:42 +0000 (UTC)
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
Subject: [PATCH v3 0/1] tcp/dcpp: Un-pin tw_timer
Date: Mon, 19 Feb 2024 10:57:28 +0100
Message-ID: <20240219095729.2339914-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi,

This is v3 of the series where the tw_timer is un-pinned to get rid of interferences in
isolated CPUs setups.

Eric mentionned rsk_timer needs looking into, but I haven't had the time to do
that. It doesn't show up in our testing, which might be due to its relatively
low timeout (IIUC 3s).

Revisions
=========

RFCv1 -> v2
++++++++

o Added comment in inet_twsk_deschedule_put() to highlight the race
o Added bh_disable patch

v2 -> v3
++++++++

o Dropped bh_disable patch
o Rebased against latest Linus' tree

Valentin Schneider (1):
  tcp/dcpp: Un-pin tw_timer

 net/dccp/minisocks.c          | 16 +++++++---------
 net/ipv4/inet_timewait_sock.c | 20 +++++++++++++++-----
 net/ipv4/tcp_minisocks.c      | 16 +++++++---------
 3 files changed, 29 insertions(+), 23 deletions(-)

-- 
2.43.0


