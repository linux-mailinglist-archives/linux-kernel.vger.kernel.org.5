Return-Path: <linux-kernel+bounces-104386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0934587CD1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978A31F23C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3111C6A4;
	Fri, 15 Mar 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8CPO8hk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E61C687
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505091; cv=none; b=CidXnolDvhvhYEQeih7FbHN4XcxRPfcBaj4wwF7Ne+peGx8q/SEG7/6gKUwrrLLVP3nlPsixrftqXP9Ktu8kVA/JPchb3zL22ce6Xm7kGrDpJM7t/PN1ExS4R4m9t0DGS8+OEQRz1oX87u805Da8Jxi7LSyWm4vjA2HDMYRZckA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505091; c=relaxed/simple;
	bh=OXBEZqhs7kDse6BVOLPyb/0TPxks7Uu4zNmjP25UPs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjZczs7uP0emNMMBgEDXVVmDmbXlRDdk0upjEnbFMITwNhBWe47jo84D5EcW3Hm+g4IQWbYfiZYoFgoiUrr/rUOsuHQSjjC2dFj7Ti+9eWHZmQExVT+WtxT1aevLZaRr4XAemjgc9PBxcJ8KUCnWCnP8U/iiS1R6XjaqaHLesuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8CPO8hk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710505089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RkV+0UDwdwnEtpTzSiYVVxf6L/nYIk2GiTDZOWrLMLA=;
	b=O8CPO8hkFsReA0TzyII3P7kY5yAG7zq6uPdT7XywlxFaoDTb/jKmOw9OdndNlH+KlYg200
	gWEWpnZOPsAXpCYu9yuLJWHpL75ehgQ6rriX7wjOP8dpgSX+QvGQ0Lpit2iFB9gJ+aCdKa
	1dlxPVfrM2l1n+yqmbRpbQS4YqKliGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-2P5q7AxxOZCO0dI-vc4yOw-1; Fri, 15 Mar 2024 08:17:50 -0400
X-MC-Unique: 2P5q7AxxOZCO0dI-vc4yOw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E5F5185A781;
	Fri, 15 Mar 2024 12:17:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D18562166B4F;
	Fri, 15 Mar 2024 12:17:35 +0000 (UTC)
Date: Fri, 15 Mar 2024 20:17:31 +0800
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
Message-ID: <ZfQ8Wz9gMqsN02Mv@fedora>
References: <20240313110515.70088-1-nmi@metaspace.dk>
 <20240313110515.70088-2-nmi@metaspace.dk>
 <ZfI8-14RUqGqoRd-@boqun-archlinux>
 <87il1ptck0.fsf@metaspace.dk>
 <CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
 <87plvwsjn5.fsf@metaspace.dk>
 <CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
 <8734ssrkxd.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734ssrkxd.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Fri, Mar 15, 2024 at 08:52:46AM +0100, Andreas Hindborg wrote:
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
> 
> > On Thu, Mar 14, 2024 at 8:23 PM Andreas Hindborg <nmi@metaspace.dk> wrote:
> >>
> >> The way the current code compiles, <kernel::block::mq::Request as
> >> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
> >> module. A relocation for `rust_helper_blk_mq_free_request_internal`
> >> appears in `rnull_mod.ko`. I didn't test it yet, but if
> >> `__blk_mq_free_request` (or the helper) is not exported, I don't think
> >> this would be possible?
> >
> > Yeah, something needs to be exported since there is a generic
> > involved, but even if you want to go the route of exporting only a
> > different symbol, you would still want to put it in the C header so
> > that you don't get the C missing declaration warning and so that we
> > don't have to write the declaration manually in the helper.
> 
> That is what I did:
> 
> @@ -703,6 +703,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
>  		unsigned int set_flags);
>  void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
>  
> +void __blk_mq_free_request(struct request *rq);
>  void blk_mq_free_request(struct request *rq);
>  int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>  		unsigned int poll_flags);

Can you explain in detail why one block layer internal helper is
called into rnull driver directly? It never happens in C driver code.


Thanks,
Ming


