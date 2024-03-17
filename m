Return-Path: <linux-kernel+bounces-105325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEE187DC47
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 03:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5A51C210BB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 02:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9646112;
	Sun, 17 Mar 2024 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cJ8yxGWZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253D3233;
	Sun, 17 Mar 2024 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710643873; cv=none; b=FkJNEN2jymXk3Os8JtMNd399fFU+nQScvTSMpNhQVefhKP1dkKD4L7mdudTmE3T1a5mJFet4728chTekLy3B89XP8EQV/kBQmvIxpqmuAh48uqS6r5WDTlrQU5JagDwyoT+PByQ3Q9DBANVmqunqx37MXLZBFxPNqxAVV1oLzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710643873; c=relaxed/simple;
	bh=X0xxLbq5eiLdVxjFpLpPM6nLX3tXkRiD6boUh4jYdYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6omZ/MxqC+QevaPKEAROluEqlpFbQ5MIORXt6IZSi535RbVo71eN62rE+WHaLm5jAUqKiN9DNbwOGEBvQ5/6F1jBU3FuWhaCwvH+bF4nk5IO2QoTqBiWiYkWburXRHlkVwxne//Eh+lpE66AHM+pOELpQv3rGwDP/XSKBUurAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cJ8yxGWZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nkEinVD8Z3SeaaGO02qIbMsBmBgYuf9Oa+IwIBedPXY=; b=cJ8yxGWZ1dIEnzG7mvy+UZx1FJ
	Y/weW5AazQmNK6D3jKrpYhl+5dKb4Jzd9atrQc936suZwPuc22B3LsbLF65dYZHVVHTCknuCebb75
	aVvv2lhscgMl1CJ+fd81Vd0l7/xMlCHpTcTQoVfj44PWyr2LCpzssGXU6W6s/DiycpvJO/iIwezgs
	4APj8hgAtZMSrP9kz+4dyNLrpAVv43RdkCyp3kl49znRRztH+4++vSrVggU69RMTCKXSQQR1kH021
	FtNIZfVSttCm710dvM31SweZNWtW/Y1/g6IB0C5N7hYazSl245B64+EMkuJwYpavH7jB4JNSblp+t
	wsCWB85Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlgbt-0000000Dnf7-1Yng;
	Sun, 17 Mar 2024 02:50:53 +0000
Date: Sun, 17 Mar 2024 02:50:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
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
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block
 driver
Message-ID: <ZfZajb_vcRwLacfH@casper.infradead.org>
References: <20240313110515.70088-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313110515.70088-1-nmi@metaspace.dk>

On Wed, Mar 13, 2024 at 12:05:07PM +0100, Andreas Hindborg wrote:
>  - Adopted the folio abstraction where applicable

I don't think this was the correct move.  The memory you're managing
with folios is only used for storing the data being stored in the blkdev.
It's not mapped to userspace, it doesn't make use of the flags (locked,
uptodate, writeback, etc), it doesn't need an LRU list, a mapping,
an index, a refcount or memcg.

I think you should use pages instead of folios to keep a handle on
this memory.  Apologies for the confusion; we're in the middle of a
years-long transition from the overly complex and overused struct page
to splitting it into different data types for different purposes.

More detail on this here, if you're interested:
https://kernelnewbies.org/MatthewWilcox/Memdescs

