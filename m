Return-Path: <linux-kernel+bounces-102408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438E487B1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB1B287E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9760BB9;
	Wed, 13 Mar 2024 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o3d4YVLf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD450278;
	Wed, 13 Mar 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357154; cv=none; b=RKpNG/ljish6dOtgydIPZMznzA6BuxGrZegkQmqoLE7gJidMPvptN9O8xzW2w94d9LPfDIZ19WqpACYqTr2Hn0VdeeBklUfP+Rc/WM9+4tBSO/3nZY0Pzh+etRyFrIrcUwzjB4CFpTSsLHM3py1aZVqD7iY0GxekETywsJIpSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357154; c=relaxed/simple;
	bh=ymKP3IS2cmfQeizc365gbXNTGJ8tjNwTUcgrrr5ZdkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccL4h50kXWiG4fqn8BPL90y1jCrqCYsNOGxbYFALLkBerCbSj4oYfsIRMueVlgWX1nw/0XQ/d5Rre04EfGEtEDVsYQ7J/L6lj5BsbCCahAwDRfqGinpWkRi3rlYATLBeWyoHHqOgtt2d5Jl+l8YQcVFY4mB9rrew8n55ayr/NGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o3d4YVLf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y7M7m8+z9Pxp+WtOGCbb1eIYlLSjTSrvSDU8UY51Iko=; b=o3d4YVLf5C9RxU4fFRGRhqJ8bh
	lSpLcfO+WTl5BlF7HzhfXgpyEFMMReDhLco4YG6HVRf3nAc83qUBTS9hDA5fnMk7Jz8kHzSJY8Vhq
	11V63o5qJfLinTCBh7aEoarX5LpDlZeqErxbuW1Cb6gTarsLaB7CljPOXwMX4ajZEuLhfrHaXJFdO
	kV38rFQSgDOR0YH25ZUH+B9y4TNnl+YhIaNFHHZqmz1jp965FXP2Gax8lYem0HZ0hLL/HRbLemGpS
	nczA0yvF9V50b8QtxWDLfbEsbZGJnq0NSkFDKDe6a+68mcXSEL6Jck+u1wSrze+hE7GRK06z6lZkX
	S7PMNAfw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkU1V-000000064gw-2tQM;
	Wed, 13 Mar 2024 19:12:21 +0000
Date: Wed, 13 Mar 2024 19:12:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
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
Message-ID: <ZfH6lTDQygFd1hz-@casper.infradead.org>
References: <20240313110515.70088-1-nmi@metaspace.dk>
 <855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>

On Wed, Mar 13, 2024 at 11:02:23AM -0700, Bart Van Assche wrote:
> On 3/13/24 04:05, Andreas Hindborg wrote:
> > This is the second version of the Rust block device driver API and the Rust null
> > block driver. The context and motivation can be seen in cover letter of the RFC
> > v1 [1]. If more context is required, a talk about this effort was recorded at
> > LPC [2]. I hope to be able to discuss this series at LSF this year [3].
> 
> Memory safety may land in C++ in the near future (see also
> https://herbsutter.com/2024/03/). If memory-safe C++ or memory-safe C
> would be adopted in the kernel, it would allow writing memory-safe
> drivers without having to add complicated bindings between existing C
> code and new Rust code. Please do not take this as personal criticism -
> I appreciate the effort that has been spent on coming up with great
> Rust bindings for the Linux kernel block layer.

You know, this reminds me of when I was at Intel working on NVMe.
We had a product all ready to ship and a manager suggested that we delay
shipping it until the SCSI-over-PCI standard was finished and ratified
so that the same piece of silicon could support both.

Fortunately, said manager was overruled, but it's a great example of
how this kind of FUD can actually work.

