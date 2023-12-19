Return-Path: <linux-kernel+bounces-6067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413AC8193D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741F21C25551
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895983D0BD;
	Tue, 19 Dec 2023 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEvo1Bzx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283B39AE7;
	Tue, 19 Dec 2023 22:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39ACC433C8;
	Tue, 19 Dec 2023 22:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703026103;
	bh=bz3qpu+H4Nhc8FfdsM/6RQPGotVSuJ31LNLq39s4kPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEvo1Bzx28mnb80SLMzc7E0t/ysQYsainUfR8Yw/Mo8mtl9zmnz3Jfid0g6qZcLGw
	 Yj++a/J0lfp/zaPG1Y1br2u6XYRLJD/WrJXmZB0cE//NChBcSzR20hk1FozKmolcne
	 r6oUehgrhVN17MN0ofYLosqkx9bmWafTnrvYttIxW32JuyvFiif0s0WcztNQMJFIj1
	 af2atoeiBEL7WGuCZpK5wTG2YInl71SJkd8Ew9mlnUEx6y/583SE5genaTLo0cSju6
	 CzKQkCRFsc8bqJnTk/6FPKHYhN6Glh9t1eBT3rAuyIJFHc3cgOfwcQEzi+k2xEjkSj
	 tqD0hdteZvH2w==
Date: Tue, 19 Dec 2023 15:48:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 4/5] dm verity: Fix I/O priority lost when read
 FEC and hash
Message-ID: <20231219224821.GC38652@quark.localdomain>
References: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
 <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
 <20231218012746.24442-5-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218012746.24442-5-hongyu.jin.cn@gmail.com>

On Mon, Dec 18, 2023 at 09:27:45AM +0800, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> To fix this problem, when read FEC and hash from disk, I/O priority are
> inconsistent with data block and blocked by other I/O with low I/O
> priority.
> 
> Make I/O for FEC and hash has same I/O priority with original data I/O.

"To fix this problem" is supposed to be in the second paragraph, not the first,
right?

> @@ -728,6 +730,7 @@ static void verity_submit_prefetch(struct dm_verity *v, struct dm_verity_io *io)
>  	sector_t block = io->block;
>  	unsigned int n_blocks = io->n_blocks;
>  	struct dm_verity_prefetch_work *pw;
> +	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
>  
>  	if (v->validated_blocks) {
>  		while (n_blocks && test_bit(block, v->validated_blocks)) {

The caller has the bio pointer already, so maybe just add it as a parameter to
verity_submit_prefetch()?

- Eric

