Return-Path: <linux-kernel+bounces-88716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC6E86E5C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9211F27D5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E72C8BE3;
	Fri,  1 Mar 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlVElvrD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54D882D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311098; cv=none; b=pJ38vhuL0RltKtprsVRziPGxYREnpx2Hx9z3jd4MXQJgXOe8mPUQyeUmW2lRxaJURWi0/a9H/ZDfFwf0NVIBJ2iCa66jvZnEX1/fGxhfWWbAvzyoeq8fmfO6CgUQEG+Z25vFChMesmfRCAvERtGaadTgI+H2oJFveKrEb9AyINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311098; c=relaxed/simple;
	bh=eHc3b394Q725AHnvceFtgot1OgP5V1Fgquz0NU91s+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHAkfoDGkApmGWSzcbuoA2Rf3G0IoogJbO0dMeEOSs6iSyDRZjMo/nOs1xcxGA4Bty9CO+ur3gzIzjN/8XtiQtp8Ia0+aIIncowFoRqf/d9RkR+RDZnwiC+O+rdQYcEoWktah4zQL6FpumahLQTEbg79KWx/bsUd+7f+oK9FBgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlVElvrD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FZ9ThxSLb1hIO4s1RwGwCheC8FH3deOOXNVi8s1Z1I4=;
	b=QlVElvrDU6/A8oJZXQ9CwzvrX2c+vq++M7cWJk5YiQ+KK2JZeCbiat8NDxNiMqckpap22O
	TIKLQhaJen5AzGrwPehhRUJUgD/yVAJiwkTzCdWtTreOhs2StVK5K42o5KnaIho8dAAZbh
	KTYDzyLovPYqr19twuiZqT+4gDtMj78=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-hr5kiNF_P_2u4BgQ_AImYw-1; Fri,
 01 Mar 2024 11:38:12 -0500
X-MC-Unique: hr5kiNF_P_2u4BgQ_AImYw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B287D28B7403;
	Fri,  1 Mar 2024 16:38:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7937D492BE2;
	Fri,  1 Mar 2024 16:38:10 +0000 (UTC)
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
Subject: [PATCH net-next 00/21] rxrpc: Miscellaneous changes and make use of MSG_SPLICE_PAGES
Date: Fri,  1 Mar 2024 16:37:32 +0000
Message-ID: <20240301163807.385573-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Here are some changes to AF_RXRPC:

 (1) Cache the transmission serial number of ACK and DATA packets in the
     rxrpc_txbuf struct and log this in the retransmit tracepoint.

 (2) Don't use atomics on rxrpc_txbuf::flags[*] and cache the intended wire
     header flags there too to avoid duplication.

 (3) Cache the wire checksum in rxrpc_txbuf to make it easier to create
     jumbo packets in future (which will require altering the wire header
     to a jumbo header and restoring it back again for retransmission).

 (4) Fix the protocol names in the wire ACK trailer struct.

 (5) Strip all the barriers and atomics out of the call timer tracking[*].

 (6) Remove atomic handling from call->tx_transmitted and
     call->acks_prev_seq[*].

 (7) Don't bother resetting the DF flag after UDP packet transmission.  To
     change it, we now call directly into UDP code, so it's quick just to
     set it every time.

 (8) Merge together the DF/non-DF branches of the DATA transmission to
     reduce duplication in the code.

 (9) Add a kvec array into rxrpc_txbuf and start moving things over to it.
     This paves the way for using page frags.

(10) Split (sub)packet preparation and timestamping out of the DATA
     transmission function.  This helps pave the way for future jumbo
     packet generation.

(11) In rxkad, don't pick values out of the wire header stored in
     rxrpc_txbuf, buf rather find them elsewhere so we can remove the wire
     header from there.

(12) Move rxrpc_send_ACK() to output.c so that it can be merged with
     rxrpc_send_ack_packet().

(13) Use rxrpc_txbuf::kvec[0] to access the wire header for the packet
     rather than directly accessing the copy in rxrpc_txbuf.  This will
     allow that to be removed to a page frag.

(14) Switch from keeping the transmission buffers in rxrpc_txbuf allocated
     in the slab to allocating them using page fragment allocators.  There
     are separate allocators for DATA packets (which persist for a while)
     and control packets (which are discarded immediately).

     We can then turn on MSG_SPLICE_PAGES when transmitting DATA and ACK
     packets.

     We can also get rid of the RCU cleanup on rxrpc_txbufs, preferring
     instead to release the page frags as soon as possible.

(15) Parse received packets before handling timeouts as the former may
     reset the latter.

(16) Make sure we don't retransmit DATA packets after all the packets have
     been ACK'd.

(17) Differentiate traces for PING ACK transmission.

(18) Switch to keeping timeouts as ktime_t rather than a number of jiffies
     as the latter is too coarse a granularity.  Only set the call timer at
     the end of the call event function from the aggregate of all the
     timeouts, thereby reducing the number of timer calls made.  In future,
     it might be possible to reduce the number of timers from one per call
     to one per I/O thread and to use a high-precision timer.

(19) Record RTT probes after successful transmission rather than recording
     it before and then cancelling it after if unsuccessful[*].  This
     allows a number of calls to get the current time to be removed.

(20) Clean up the resend algorithm as there's now no need to walk the
     transmission buffer under lock[*].  DATA packets can be retransmitted
     as soon as they're found rather than being queued up and transmitted
     when the locked is dropped.

(21) When initially parsing a received ACK packet, extract some of the
     fields from the ack info to the skbuff private data.  This makes it
     easier to do path MTU discovery in the future when the call to which a
     PING RESPONSE ACK refers has been deallocated.


[*] Possible with the move of almost all code from softirq context to the
    I/O thread.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/rxrpc-iothread-20240301

And can be found on this branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-iothread

David

David Howells (21):
  rxrpc: Record the Tx serial in the rxrpc_txbuf and retransmit trace
  rxrpc: Convert rxrpc_txbuf::flags into a mask and don't use atomics
  rxrpc: Note cksum in txbuf
  rxrpc: Fix the names of the fields in the ACK trailer struct
  rxrpc: Strip barriers and atomics off of timer tracking
  rxrpc: Remove atomic handling on some fields only used in I/O thread
  rxrpc: Do lazy DF flag resetting
  rxrpc: Merge together DF/non-DF branches of data Tx function
  rxrpc: Add a kvec[] to the rxrpc_txbuf struct
  rxrpc: Split up the DATA packet transmission function
  rxrpc: Don't pick values out of the wire header when setting up
    security
  rxrpc: Move rxrpc_send_ACK() to output.c with rxrpc_send_ack_packet()
  rxrpc: Use rxrpc_txbuf::kvec[0] instead of rxrpc_txbuf::wire
  rxrpc: Do zerocopy using MSG_SPLICE_PAGES and page frags
  rxrpc: Parse received packets before dealing with timeouts
  rxrpc: Don't permit resending after all Tx packets acked
  rxrpc: Differentiate PING ACK transmission traces.
  rxrpc: Use ktimes for call timeout tracking and set the timer lazily
  rxrpc: Record probes after transmission and reduce number of time-gets
  rxrpc: Clean up the resend algorithm
  rxrpc: Extract useful fields from a received ACK to skb priv data

 include/trace/events/rxrpc.h | 198 ++++++++--------
 net/rxrpc/af_rxrpc.c         |  12 +-
 net/rxrpc/ar-internal.h      |  88 ++++---
 net/rxrpc/call_event.c       | 327 ++++++++++++--------------
 net/rxrpc/call_object.c      |  56 ++---
 net/rxrpc/conn_client.c      |   4 +-
 net/rxrpc/conn_event.c       |  16 +-
 net/rxrpc/conn_object.c      |   4 +
 net/rxrpc/input.c            | 116 +++++----
 net/rxrpc/insecure.c         |  11 +-
 net/rxrpc/io_thread.c        |  11 +
 net/rxrpc/local_object.c     |   3 +
 net/rxrpc/misc.c             |   8 +-
 net/rxrpc/output.c           | 441 +++++++++++++++++------------------
 net/rxrpc/proc.c             |  10 +-
 net/rxrpc/protocol.h         |   6 +-
 net/rxrpc/rtt.c              |  36 +--
 net/rxrpc/rxkad.c            |  58 ++---
 net/rxrpc/sendmsg.c          |  63 ++---
 net/rxrpc/sysctl.c           |  16 +-
 net/rxrpc/txbuf.c            | 174 +++++++++++---
 21 files changed, 853 insertions(+), 805 deletions(-)


