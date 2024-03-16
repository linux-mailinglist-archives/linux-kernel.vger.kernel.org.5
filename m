Return-Path: <linux-kernel+bounces-105204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C487DA7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDAD1C20CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2401B96B;
	Sat, 16 Mar 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ae6l6hPz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78817C73
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710600539; cv=none; b=hOi0qq4J7YXDM20Et+xF8fgy6SqaH8mhvVxuaHKfRCaYbS0SITUTkeFzejxFQsO9iXBfnik74pbrGKrmwdtrSf120rP8cYBEJEW+LcXt1Rcuc1mtQINamJ07XZ6cKGD124B8ewHsck54voqbn1+qbliiHqo42TeqBxKHJnMrmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710600539; c=relaxed/simple;
	bh=Cgb9z5OdZfefvkcfqjC683bHQkiSELoGDfjtH5bCtEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf4rOgWYQySLRfEOdRjfsagmvwxUwHNS4hgLs+zQeQhFJubt2TJiziUnw3AeX6aDHy5gYMqXzDhTYRC/oaGs0KQmM2+jqTDmZOOxCI05BFEpFjrQyrXUUNPCShaBQ/hUrqbsEGsNcPDXUJ6uBVVhPxqStxBGSyAzGCbszXJteRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ae6l6hPz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710600536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo2DqarebiWIPbXxo7bGyGfbR6Nkvj5WZglfHDEyAIM=;
	b=ae6l6hPzUP3qm4xpT1MGCqRnuhUz8MgzjaeVEHfampkbkziINBvcinhO9BV1GFXWhr70Ey
	losWpKjcBVkBpHpoQCx29joaw17CwS4uTuOwAsF8e/V0ruKOIDvoldFiPew3E9e60N/0KC
	mSUPe8BICncjy4IJETvTf7aEwOJsuno=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-rm1dHkdOPTms9ygCzZbHbg-1; Sat, 16 Mar 2024 10:48:50 -0400
X-MC-Unique: rm1dHkdOPTms9ygCzZbHbg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BCD3185A781;
	Sat, 16 Mar 2024 14:48:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E6B492BD0;
	Sat, 16 Mar 2024 14:48:34 +0000 (UTC)
Date: Sat, 16 Mar 2024 22:48:26 +0800
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
	"gost.dev@samsung.com" <gost.dev@samsung.com>, ming.lei@redhat.com
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Message-ID: <ZfWxOgYLgRN6Pcge@fedora>
References: <ZfI8-14RUqGqoRd-@boqun-archlinux>
 <87il1ptck0.fsf@metaspace.dk>
 <CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
 <87plvwsjn5.fsf@metaspace.dk>
 <CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
 <8734ssrkxd.fsf@metaspace.dk>
 <ZfQ8Wz9gMqsN02Mv@fedora>
 <87o7bfr7bt.fsf@metaspace.dk>
 <ZfRoJxzOLZEIaQK7@fedora>
 <87il1nqtak.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il1nqtak.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Fri, Mar 15, 2024 at 06:49:39PM +0100, Andreas Hindborg wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Fri, Mar 15, 2024 at 01:46:30PM +0100, Andreas Hindborg wrote:
> >> Ming Lei <ming.lei@redhat.com> writes:
> >> > On Fri, Mar 15, 2024 at 08:52:46AM +0100, Andreas Hindborg wrote:
> >> >> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
> >> >> 
> >> >> > On Thu, Mar 14, 2024 at 8:23 PM Andreas Hindborg <nmi@metaspace.dk> wrote:
> >> >> >>
> >> >> >> The way the current code compiles, <kernel::block::mq::Request as
> >> >> >> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
> >> >> >> module. A relocation for `rust_helper_blk_mq_free_request_internal`
> >> >> >> appears in `rnull_mod.ko`. I didn't test it yet, but if
> >> >> >> `__blk_mq_free_request` (or the helper) is not exported, I don't think
> >> >> >> this would be possible?
> >> >> >
> >> >> > Yeah, something needs to be exported since there is a generic
> >> >> > involved, but even if you want to go the route of exporting only a
> >> >> > different symbol, you would still want to put it in the C header so
> >> >> > that you don't get the C missing declaration warning and so that we
> >> >> > don't have to write the declaration manually in the helper.
> >> >> 
> >> >> That is what I did:
> >> >> 
> >> >> @@ -703,6 +703,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
> >> >>  		unsigned int set_flags);
> >> >>  void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
> >> >>  
> >> >> +void __blk_mq_free_request(struct request *rq);
> >> >>  void blk_mq_free_request(struct request *rq);
> >> >>  int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
> >> >>  		unsigned int poll_flags);
> >> >
> >> > Can you explain in detail why one block layer internal helper is
> >> > called into rnull driver directly? It never happens in C driver code.
> >> 
> >> It is not the rust null block driver that calls this symbol directly. It
> >> is called by the Rust block device driver API. But because of inlining,
> >> the symbol is referenced from the loadable object.
> >
> > What is the exact Rust block device driver API? The key point is that how
> > the body of one exported kernel C API(EXPORT_SYMBOL) becomes inlined
> > with Rust driver.
> 
> This happens when `ARef<Request<_>>` is dropped. The drop method
> (destructor) of this smart pointer decrements the refcount and
> potentially calls `__blk_mq_free_request`.
> 
> >> 
> >> The reason we have to call this symbol directly is to ensure proper
> >> lifetime of the `struct request`. For example in C, when a driver
> >
> > Sounds Rust API still calls into __blk_mq_free_request() directly, right?
> 
> Yes, the Rust block device driver API will call this request if an
> `ARef<Request<_>>` is dropped and the refcount goes to 0.
> 
> > If that is the case, the usecase need to be justified, and you need
> > to write one standalone patch with the exact story for exporting
> > __blk_mq_free_request().
> 
> Ok, I can do that.
> 
> >
> >> converts a tag to a request, the developer makes sure to only ask for
> >> requests which are outstanding in the driver. In Rust, for the API to be
> >> sound, we must ensure that the developer cannot write safe code that
> >> obtains a reference to a request that is not owned by the driver.
> >> 
> >> A similar issue exists in the null block driver when timer completions
> >> are enabled. If the request is cancelled and the timer fires after the
> >> request has been recycled, there is a problem because the timer holds a
> >> reference to the request private data area.
> >> 
> >> To that end, I use the `atomic_t ref` field of the C `struct request`
> >> and implement the `AlwaysRefCounted` Rust trait for the request type.
> >> This is a smart pointer that owns a reference to the pointee. In this
> >> way, the request is not freed and recycled until the smart pointer is
> >> dropped. But if the smart pointer holds the last reference when it is
> >> dropped, it must be able to free the request, and hence it has to call
> >> `__blk_mq_free_request`.
> >
> > For callbacks(queue_rq, timeout, complete) implemented by driver, block
> > layer core guaranteed that the passed request reference is live.
> >
> > So driver needn't to worry about request lifetime, same with Rust
> > driver, I think smart pointer isn't necessary for using request in
> > Rust driver.
> 
> Using the C API, there is nothing preventing a driver from using the
> request after the lifetime ends.

Yes, it is true for C, so will Rust-for-linux need to add refcount for
most exported kernel C structure? such as by implementing AlwaysRefCounted
traits?

> With Rust, we have to make it
> impossible.Without the refcount and associated call to
> `__blk_mq_free_request`, it would be possible to write Rust code that
> access the request after the lifetime ends. This is not sound, and it is
> something we need to avoid in the Rust abstractions.
> 
> One concrete way to do write unsound code with a Rust API where lifetime
> is not tracked with refcount, is if the null block timer completion
> callback fires after the request is completed. Perhaps the driver
> cancels the request but forgets to cancel the timer. When the timer
> fires, it will access the request via the context pointer, but the
> request will be invalid.

The issue is less serious for blk-mq request, which is pre-allocated,
and one freed request just means it can be re-allocated for other IO
in same queue, and the pointed memory won't be really freed.

Also as I mentioned, inside driver's ->timeout(), the request is
guaranteed to be live by block layer core(won't be re-allocated to other IO),
the passed-in request is referenced already, please see bt_iter() which
is called from blk_mq_timeout_work(). Here, block layer core just
borrows request, then passed the reference to ->timeout(), when
request is owned by driver actually.

I understand Rust block driver still need to implement ->queue_rq(),
->timeout(), ..., just like C driver, but maybe I am wrong? Or Rust block driver
will re-implement part of block layer core code? such as, get one extra
reference of request no matter block core has done that.

> In C we have to write the driver code so this
> cannot happen. In Rust, the API must prevent this from happening. So any
> driver written in the safe subset of Rust using this API can never
> trigger this behavior.
> 
> By using the refcount, we ensure that the request is alive until all
> users who hold a reference to it are dropped.

block layer has provided such guarantee if Rust driver follows current
block driver model.

> 
> Another concrete example is when a driver calls `blk_mq_tag_to_rq` with
> an invalid tag. This can return a reference to an invalid tag, if the
> driver is not implemented correctly. By using `req_ref_inc_not_zero` we
> can assert that the request is live before we create a Rust reference to
> it, and even if the driver code has bugs, it can never access an invalid
> request, and thus it can be memory safe.
> 
> We move the responsibility of correctness, in relation to memory safety,
> from the driver implementation to the API implementation.

After queue_rq(req) is called, request ownership is actually transferred to
driver like Rust's move, then driver is free to call blk_mq_tag_to_rq(), and
finally return request to block core after the request is completed by driver.

The biggest question should be how Rust block driver will be designed &
implemented? Will rust block driver follow current C driver's model, such
as implementing ->queue_rq(), ->timeout(), ->complete()...?



thanks,
Ming


