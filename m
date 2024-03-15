Return-Path: <linux-kernel+bounces-104574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3387D031
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEFFEB23875
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3153EA77;
	Fri, 15 Mar 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D14Ir4T1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F63D0A8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516293; cv=none; b=QCawpTFkLz0Vwb4Uce7jRyAMQj1d8MH9lms0a+MBv8KycY8JYo0KT9lnW0pJkF8Y+GQ9DvVpA7hUd+rxbntoarO54jxdg6JQKnkCHA05mPaOgrLDcOeeW7LwPnZKXZUmZAe4l//yCEh4kPHEjtV0ibZeVX1U8wDbuR/SAj6+ZRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516293; c=relaxed/simple;
	bh=txagI/T+kcFTGonyWWYBOzz8k+ZSE6z4gBs79vLf9i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlXZ2cXH5OKkDuIitdB6fCIQOIVXm9oQbvpypqf08JtDOt3CGkwIZ6qTMrRGofqywVAVxnkpgwej3IJ4L4G0F513jnkUMhJgcdv2CrL3wfjwaP0qZExox0Cb83NLLgLfKkomRwBu7vKTAasbdli6rK15pZHhAwk+oD3sFZUew+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D14Ir4T1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710516290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FW5Vr1gDYBniy1MSzi0AljuuiEKIG0vHfpgNYvthLcs=;
	b=D14Ir4T1/mWBuP9yGtinAoL+9wChGkitbMJjMmyZ0e9q2cF9/ihckR6uYrKvpzmUUci0IM
	r1xp1GlFARRdX+869ry6PCRZlNwx82s8brNODahlmQG4HFCZWvWp5NnaiEnnoX6uTP/Gro
	9mdDVpVvupTMgquv4Eb1jz+SoPKd9X0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-vri6rDGMO7SzEzKgLnwq5w-1; Fri, 15 Mar 2024 11:24:46 -0400
X-MC-Unique: vri6rDGMO7SzEzKgLnwq5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B2BE101CC6D;
	Fri, 15 Mar 2024 15:24:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FF9B1C060D1;
	Fri, 15 Mar 2024 15:24:30 +0000 (UTC)
Date: Fri, 15 Mar 2024 23:24:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Message-ID: <ZfRoJxzOLZEIaQK7@fedora>
References: <20240313110515.70088-1-nmi@metaspace.dk>
 <20240313110515.70088-2-nmi@metaspace.dk>
 <ZfI8-14RUqGqoRd-@boqun-archlinux>
 <87il1ptck0.fsf@metaspace.dk>
 <CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
 <87plvwsjn5.fsf@metaspace.dk>
 <CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
 <8734ssrkxd.fsf@metaspace.dk>
 <ZfQ8Wz9gMqsN02Mv@fedora>
 <87o7bfr7bt.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7bfr7bt.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Fri, Mar 15, 2024 at 01:46:30PM +0100, Andreas Hindborg wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> > On Fri, Mar 15, 2024 at 08:52:46AM +0100, Andreas Hindborg wrote:
> >> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
> >> 
> >> > On Thu, Mar 14, 2024 at 8:23 PM Andreas Hindborg <nmi@metaspace.dk> wrote:
> >> >>
> >> >> The way the current code compiles, <kernel::block::mq::Request as
> >> >> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
> >> >> module. A relocation for `rust_helper_blk_mq_free_request_internal`
> >> >> appears in `rnull_mod.ko`. I didn't test it yet, but if
> >> >> `__blk_mq_free_request` (or the helper) is not exported, I don't think
> >> >> this would be possible?
> >> >
> >> > Yeah, something needs to be exported since there is a generic
> >> > involved, but even if you want to go the route of exporting only a
> >> > different symbol, you would still want to put it in the C header so
> >> > that you don't get the C missing declaration warning and so that we
> >> > don't have to write the declaration manually in the helper.
> >> 
> >> That is what I did:
> >> 
> >> @@ -703,6 +703,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
> >>  		unsigned int set_flags);
> >>  void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
> >>  
> >> +void __blk_mq_free_request(struct request *rq);
> >>  void blk_mq_free_request(struct request *rq);
> >>  int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
> >>  		unsigned int poll_flags);
> >
> > Can you explain in detail why one block layer internal helper is
> > called into rnull driver directly? It never happens in C driver code.
> 
> It is not the rust null block driver that calls this symbol directly. It
> is called by the Rust block device driver API. But because of inlining,
> the symbol is referenced from the loadable object.

What is the exact Rust block device driver API? The key point is that how
the body of one exported kernel C API(EXPORT_SYMBOL) becomes inlined
with Rust driver.

> 
> The reason we have to call this symbol directly is to ensure proper
> lifetime of the `struct request`. For example in C, when a driver

Sounds Rust API still calls into __blk_mq_free_request() directly, right?

If that is the case, the usecase need to be justified, and you need
to write one standalone patch with the exact story for exporting
__blk_mq_free_request().

> converts a tag to a request, the developer makes sure to only ask for
> requests which are outstanding in the driver. In Rust, for the API to be
> sound, we must ensure that the developer cannot write safe code that
> obtains a reference to a request that is not owned by the driver.
> 
> A similar issue exists in the null block driver when timer completions
> are enabled. If the request is cancelled and the timer fires after the
> request has been recycled, there is a problem because the timer holds a
> reference to the request private data area.
> 
> To that end, I use the `atomic_t ref` field of the C `struct request`
> and implement the `AlwaysRefCounted` Rust trait for the request type.
> This is a smart pointer that owns a reference to the pointee. In this
> way, the request is not freed and recycled until the smart pointer is
> dropped. But if the smart pointer holds the last reference when it is
> dropped, it must be able to free the request, and hence it has to call
> `__blk_mq_free_request`.

For callbacks(queue_rq, timeout, complete) implemented by driver, block
layer core guaranteed that the passed request reference is live.

So driver needn't to worry about request lifetime, same with Rust
driver, I think smart pointer isn't necessary for using request in
Rust driver.



Thanks, 
Ming


