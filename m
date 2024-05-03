Return-Path: <linux-kernel+bounces-167806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0A28BAF64
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67687B217B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D6B6FB8;
	Fri,  3 May 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWKAEuCJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA62B9C0
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748883; cv=none; b=I00nmB+4/cG2/v3atFpT2bkbJJha+kmG9Wsl+j27cU58BYjySTLIzI0ep3qFedfrKXe605oXMom8vUDEoSJn5+Aya1ZBpd8BET+4rY2EKQDu7oNV1ybF8wPRqxlGM7mSM3DflidQZ610Z70sodvzDu8hgCbRQYROPJediafFAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748883; c=relaxed/simple;
	bh=b0RyCsspNCLEfkEJchgK9kipPt/17xk4d+q2C5Xly+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N647vvDRwRHvPQPDJn7sG4Dd/OxcNmc8x+fcPZvUkpw9JqbAu2h51lnkNF1hFpEYv0sDzXMKkK8Zcr1rekC5D12ksvq1hhA2drLyPNt7/l5+NuW7d2uy0uHi0JhRZ2KmxsOgSgXeY0DW5RGXEpzlB6Z9dtJv7V49K5u34+TKQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWKAEuCJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714748879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+qGnbhLIaLNnY3vAMwd+/KE7o7MMYolb+QuU2Kkq8rw=;
	b=PWKAEuCJLmVrzq5zhm9guSzUXY9wtWinTKkztV94qaV075T94IYqaTTixoeoEN8hgxREAf
	o6zuGQyTqJwKxkZr7SN8onJQ00d/FyY5H58YFP9cnh5+DpgsmL6AacgtIHGEurUD8QVxYx
	8UO3VSlJXHUAQmzPTgHwiYXPYaIy8sE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-gCHzGg6fNX6Jd57bLiEErw-1; Fri, 03 May 2024 11:07:56 -0400
X-MC-Unique: gCHzGg6fNX6Jd57bLiEErw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1189A80017B;
	Fri,  3 May 2024 15:07:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71A66203397D;
	Fri,  3 May 2024 15:07:54 +0000 (UTC)
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
Subject: [PATCH net 0/5] rxrpc: Miscellaneous fixes
Date: Fri,  3 May 2024 16:07:38 +0100
Message-ID: <20240503150749.1001323-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Here some miscellaneous fixes for AF_RXRPC:

 (1) Fix the congestion control algorithm to start cwnd at 4 and to not cut
     ssthresh when the peer cuts its rwind size.

 (2) Only transmit a single ACK for all the DATA packets glued together
     into a jumbo packet to reduce the number of ACKs being generated.

 (3) Clean up the generation of flags in the protocol header when creating
     a packet for transmission.  This means we don't carry the old
     REQUEST-ACK bit around from previous transmissions, will make it
     easier to fix the MORE-PACKETS flag and make it easier to do jumbo
     packet assembly in future.

 (4) Fix how the MORE-PACKETS flag is driven.  We shouldn't be setting it
     in sendmsg() as the packet is then queued and the bit is left in that
     state, no matter how long it takes us to transmit the packet - and
     will still be in that state if the packet is retransmitted.

 (5) Request an ACK on an impending transmission stall due to the app layer
     not feeding us new data fast enough.  If we don't request an ACK, we
     may have to hold on to the packet buffers for a significant amount of
     time until the receiver gets bored and sends us an ACK anyway.

David

---
The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David Howells (5):
  rxrpc: Fix congestion control algorithm
  rxrpc: Only transmit one ACK per jumbo packet received
  rxrpc: Clean up Tx header flags generation handling
  rxrpc: Change how the MORE-PACKETS rxrpc wire header flag is driven
  rxrpc: Request an ACK on impending Tx stall

 include/trace/events/rxrpc.h |  2 +-
 net/rxrpc/ar-internal.h      |  2 +-
 net/rxrpc/call_object.c      |  7 +-----
 net/rxrpc/input.c            | 49 +++++++++++++++++++++++++-----------
 net/rxrpc/output.c           | 26 ++++++++++++++-----
 net/rxrpc/proc.c             |  6 ++---
 net/rxrpc/sendmsg.c          |  3 ---
 7 files changed, 61 insertions(+), 34 deletions(-)


