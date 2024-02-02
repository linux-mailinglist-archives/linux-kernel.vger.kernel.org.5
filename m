Return-Path: <linux-kernel+bounces-50009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8A8472F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F92328A093
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFD51468ED;
	Fri,  2 Feb 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeeBvoVn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AD146902
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887175; cv=none; b=FPg77oNgeIsWELhhLluZQjdE6mFpN3TCDI2sv93JUGw8PwDYHJKQNdvAjpAsambyTNFOfb2wlqp9jX3M/BO53ksxJkDNql3rsIezj9tiSqApndyYV/x43MAhKePuW7xd9VeQgODZJ8KjpEW00f6nGdDDH/YiX/HOkfCY1O1Yeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887175; c=relaxed/simple;
	bh=2Dbxz5xYJkxF7TJ2GJxLcMWWwSL1lpUM3YqACQhdtpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyl+/JcQUgMXmk3w6qmWR+m9Sbjtd5BnKSXxYEpdDgDh43z82ZMX4gH/z3MOxI5nlNHscY09zLNxQFLJA0cxv8T6HE+dIvvWwkBLVrm159pDfFMZet+9oQ54nkoMBsbAaFXA8xDq1b6DRD8lW8e5yaRItETClZLQny0MoM/Anzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WeeBvoVn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706887173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=odElO08YnTHudO0RnXkSSEFFNVCU35WEEp/Vx52s7/Y=;
	b=WeeBvoVnV2h55j1VsTNxq5HbhU9HxCB0/zS8IRZ55Lx70pGWqxv6yn9qxPwDDQ0TvTNDZ0
	x2X5o2RUBMOQdWAKlsxakbaI+n4BYIQ7tQ/y8MpAwfaI5jUF4NAuu4NkMXCWV7JibkuQs7
	/mpqQI8vx9vHeDFA84l/6WjmkxnbU4E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-QE6NjE1MPzSH2RcgRceGjQ-1; Fri,
 02 Feb 2024 10:19:27 -0500
X-MC-Unique: QE6NjE1MPzSH2RcgRceGjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67EC33C000BD;
	Fri,  2 Feb 2024 15:19:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1733A2026D66;
	Fri,  2 Feb 2024 15:19:25 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] rxrpc: Miscellaneous fixes
Date: Fri,  2 Feb 2024 15:19:12 +0000
Message-ID: <20240202151920.2760446-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Here some miscellaneous fixes for AF_RXRPC:

 (1) The zero serial number has a special meaning in an ACK packet serial
     reference, so skip it when assigning serial numbers to transmitted
     packets.

 (2) Don't set the reference serial number in a delayed ACK as the ACK
     cannot be used for RTT calculation.

 (3) Don't emit a DUP ACK response to a PING RESPONSE ACK coming back to a
     call that completed in the meantime.

 (4) Fix the counting of acks and nacks in ACK packet to better drive
     congestion management.  We want to know if there have been new
     acks/nacks since the last ACK packet, not that there are still
     acks/nacks.  This is more complicated as we have to save the old SACK
     table and compare it.

David

---
The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (4):
  rxrpc: Fix generation of serial numbers to skip zero
  rxrpc: Fix delayed ACKs to not set the reference serial number
  rxrpc: Fix response to PING RESPONSE ACKs to a dead call
  rxrpc: Fix counting of new acks and nacks

 include/trace/events/rxrpc.h |   8 ++-
 net/rxrpc/ar-internal.h      |  37 ++++++++---
 net/rxrpc/call_event.c       |  12 ++--
 net/rxrpc/call_object.c      |   1 +
 net/rxrpc/conn_event.c       |  10 ++-
 net/rxrpc/input.c            | 115 +++++++++++++++++++++++++++++------
 net/rxrpc/output.c           |   8 +--
 net/rxrpc/proc.c             |   2 +-
 net/rxrpc/rxkad.c            |   4 +-
 9 files changed, 154 insertions(+), 43 deletions(-)


