Return-Path: <linux-kernel+bounces-95235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F040874B11
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A495EB246F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079E83CBB;
	Thu,  7 Mar 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfXRQltR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963477F32;
	Thu,  7 Mar 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709804349; cv=none; b=Zvm62815O4zWiWGCpYHtAae5gr++PHHl3dI6NnLZcTq8NHaj3viTKiEKujpcvBtu/EY98O0If0bvwPpkMsFBJ7CgCJU8Na1txCptuqu0mRLIiaffRc4QFy03vP/RlnHmCyys91hAFQtPaijflOjLwGK1hvar1hB5MwcYIAO+3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709804349; c=relaxed/simple;
	bh=pQfO9MkGegbpJaVePbtheGM5NzjGuY54SIXm9ZQ1w7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKK2+lYNP7UNbLx1ZFC7x0of9/Nh/mkpdgthLHKteUJ0AmtDSgBj5tc9wKtoXG4w/HBsOcGKQ9lF1lwXrzbHLs0Tgr+WpcHqcsnhLa0VwqYoTCH+0L+t0/uHxAcrRqmJgHAWIsGoEmfjo+xWksZnvvjVnFLVLUHRrBWbay69qRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfXRQltR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CFAC433F1;
	Thu,  7 Mar 2024 09:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709804348;
	bh=pQfO9MkGegbpJaVePbtheGM5NzjGuY54SIXm9ZQ1w7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfXRQltREYb2dzSNMAa4ZPGIV175P+OVFx/w9mvjRBqPct/iSj5UvhGTLX2NTogw8
	 UoBX++mstCpz6Oqnfj1utGiKE4hJWOz+qG3BI9rf2KhSkKZYWc5oJYBV6knrti6un6
	 OsHJM3pmGrP+SYsQNiTkxvP8/P+N4Sg4bYpnw4+y6IHrHAOOqA3O2YG5ytdTeTTfW5
	 HIKOimuo5i8Qp8s6hmudOARqJiTd0KMpOtX6Z3o5Um+1YEBxWFspmFtpiEf3J1vhCY
	 mc/5NmcMADKW5rkC9Z19l1+qdKuXR+6Y94UCqzJ0FmQEHBaLe4JpxEvGlReZnz+bO4
	 k076Lhpzufx4A==
Date: Thu, 7 Mar 2024 09:39:03 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 00/21] rxrpc: Miscellaneous changes and make
 use of MSG_SPLICE_PAGES
Message-ID: <20240307093903.GJ281974@kernel.org>
References: <20240306000655.1100294-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306000655.1100294-1-dhowells@redhat.com>

On Wed, Mar 06, 2024 at 12:06:30AM +0000, David Howells wrote:
> Here are some changes to AF_RXRPC:
> 
>  (1) Cache the transmission serial number of ACK and DATA packets in the
>      rxrpc_txbuf struct and log this in the retransmit tracepoint.
> 
>  (2) Don't use atomics on rxrpc_txbuf::flags[*] and cache the intended wire
>      header flags there too to avoid duplication.
> 
>  (3) Cache the wire checksum in rxrpc_txbuf to make it easier to create
>      jumbo packets in future (which will require altering the wire header
>      to a jumbo header and restoring it back again for retransmission).
> 
>  (4) Fix the protocol names in the wire ACK trailer struct.
> 
>  (5) Strip all the barriers and atomics out of the call timer tracking[*].
> 
>  (6) Remove atomic handling from call->tx_transmitted and
>      call->acks_prev_seq[*].
> 
>  (7) Don't bother resetting the DF flag after UDP packet transmission.  To
>      change it, we now call directly into UDP code, so it's quick just to
>      set it every time.
> 
>  (8) Merge together the DF/non-DF branches of the DATA transmission to
>      reduce duplication in the code.
> 
>  (9) Add a kvec array into rxrpc_txbuf and start moving things over to it.
>      This paves the way for using page frags.
> 
> (10) Split (sub)packet preparation and timestamping out of the DATA
>      transmission function.  This helps pave the way for future jumbo
>      packet generation.
> 
> (11) In rxkad, don't pick values out of the wire header stored in
>      rxrpc_txbuf, buf rather find them elsewhere so we can remove the wire
>      header from there.
> 
> (12) Move rxrpc_send_ACK() to output.c so that it can be merged with
>      rxrpc_send_ack_packet().
> 
> (13) Use rxrpc_txbuf::kvec[0] to access the wire header for the packet
>      rather than directly accessing the copy in rxrpc_txbuf.  This will
>      allow that to be removed to a page frag.
> 
> (14) Switch from keeping the transmission buffers in rxrpc_txbuf allocated
>      in the slab to allocating them using page fragment allocators.  There
>      are separate allocators for DATA packets (which persist for a while)
>      and control packets (which are discarded immediately).
> 
>      We can then turn on MSG_SPLICE_PAGES when transmitting DATA and ACK
>      packets.
> 
>      We can also get rid of the RCU cleanup on rxrpc_txbufs, preferring
>      instead to release the page frags as soon as possible.
> 
> (15) Parse received packets before handling timeouts as the former may
>      reset the latter.
> 
> (16) Make sure we don't retransmit DATA packets after all the packets have
>      been ACK'd.
> 
> (17) Differentiate traces for PING ACK transmission.
> 
> (18) Switch to keeping timeouts as ktime_t rather than a number of jiffies
>      as the latter is too coarse a granularity.  Only set the call timer at
>      the end of the call event function from the aggregate of all the
>      timeouts, thereby reducing the number of timer calls made.  In future,
>      it might be possible to reduce the number of timers from one per call
>      to one per I/O thread and to use a high-precision timer.
> 
> (19) Record RTT probes after successful transmission rather than recording
>      it before and then cancelling it after if unsuccessful[*].  This
>      allows a number of calls to get the current time to be removed.
> 
> (20) Clean up the resend algorithm as there's now no need to walk the
>      transmission buffer under lock[*].  DATA packets can be retransmitted
>      as soon as they're found rather than being queued up and transmitted
>      when the locked is dropped.
> 
> (21) When initially parsing a received ACK packet, extract some of the
>      fields from the ack info to the skbuff private data.  This makes it
>      easier to do path MTU discovery in the future when the call to which a
>      PING RESPONSE ACK refers has been deallocated.
> 
> 
> [*] Possible with the move of almost all code from softirq context to the
>     I/O thread.
> 
> The patches are tagged here:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/rxrpc-iothread-20240305
> 
> And can be found on this branch:
> 
> 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-iothread
> 
> David
> 
> Link: https://lore.kernel.org/r/20240301163807.385573-1-dhowells@redhat.com/ # v1
> Link: https://lore.kernel.org/r/20240304084322.705539-1-dhowells@redhat.com/ # v2
> 
> Changes
> =======
> ver #3)
>  - Use passed-in gfp in rxkad_alloc_txbuf() rather than GFP_KRNEL.

Hi David,

Thanks for the update above.
For the record, I don't have anything to flag in this revision of the patchset.

>  - Adjust rxkad_alloc_txbuf()'s txb check to put return in if-statement.
> 
> ver #2)
>  - Removed an unused variable.
>  - Use ktime_to_us() rather than dividing a ktime by 1000 in tracepoints.

..

