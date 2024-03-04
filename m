Return-Path: <linux-kernel+bounces-90217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F886FC16
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8B51C21173
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BB6199A2;
	Mon,  4 Mar 2024 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f05vvqjL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281241B277
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541814; cv=none; b=Hca8T5IkKNrpAQ/2OG5aR7uOeeb9DBApCGfMz0A3bc+fEScWZg2tC/GGPrjxQVmRFaZ8Cx3v96FvF903Ywtp49XLryv4oLjMsAXpYAaIXJVvf0HeqwcELc79Iu9ABFdDZscgaBXxUdSqZm+AVmmuDXIQq1vIP+bQC4zOkx4m7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541814; c=relaxed/simple;
	bh=2a8e9yJluIei1FwA1D+jyuquzMDivOTglLd0lRW8Pvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdDJnCDDwJHxWZelejA1gf/o1fbzFf1EMjuT19NDYIrbG0IzTfxw99LXLheKnb3eP90bZlBz0l84UFRMe+3ffo/eIjo5CEMB8Q+hBDTAV5xLA5lAhXR+jmh47mrB7LZLTCbcAFADIf6R1cgepwfu6ChZULB4A+cqEQheb1N1PQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f05vvqjL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709541810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i8LrRtiDs1LrFKu4I7wcrqf4WPdyvx0Cz5wdMs5DYrM=;
	b=f05vvqjLrnbnfpfjgA8f9li5jgp3mtoBqTjbDSMU8PEJas3964gNVwMm03VBMTuBQuQf3Z
	FOV5w0eRzFFfKZv4ZVqKjlAxKsS92B/JhTiZ51lX/DObmH1I5jLpVlOECNX3059i4j1MyR
	Aju61QjLSCGr/T6J5DJe5qnlZaI6JRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-sMGjttG8PI-cjTth81S1yQ-1; Mon, 04 Mar 2024 03:43:26 -0500
X-MC-Unique: sMGjttG8PI-cjTth81S1yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ED8C85A58F;
	Mon,  4 Mar 2024 08:43:26 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B90EF96F8;
	Mon,  4 Mar 2024 08:43:24 +0000 (UTC)
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
Subject: [PATCH net-next v2 00/21] rxrpc: Miscellaneous changes and make use of MSG_SPLICE_PAGES
Date: Mon,  4 Mar 2024 08:42:57 +0000
Message-ID: <20240304084322.705539-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/rxrpc-iothread-20240304

And can be found on this branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-iothread

David

Link: https://lore.kernel.org/r/20240301163807.385573-1-dhowells@redhat.com/ # v1

Changes
=======
ver #2)
 - Removed an unused variable.
 - Use ktime_to_us() rather than dividing a ktime by 1000 in tracepoints.

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


