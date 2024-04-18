Return-Path: <linux-kernel+bounces-149510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1078A9236
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7E51F225C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A57554BFA;
	Thu, 18 Apr 2024 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GS3sXpbi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB3548EA;
	Thu, 18 Apr 2024 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713416228; cv=none; b=l2jIJUMt2b5ET62VEul4WQR3TryBeLRYJsRr9QjAhUPscITxqoub519ApyKKzIb1m8HqGofKAxggpEKExOJAdNSPx+AbzY4fFVlLLCreVKUXwBVrCSJ/sygx4woVP51qwmUcbuefm/9yYqi0/1gEyLPPMvt+9TWgjwMPkHJnAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713416228; c=relaxed/simple;
	bh=bORzf0CPuk0CeUEBeV/TNqqTD59zUbx3CnM4lpUTj8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFSZBMMIpGxyu3EppEve+wX+dK/8n9l3gV32YW0DUsGgT5Qge02xVg/Lm1w9AtQfhV7KuIoifWR/2wn7pkB93S2GCmMt9LC+1eaV+te+KWalA18dBuTq9SXkl+5csQfnZnznjew8rboN3wwhMpTItzZ5hKOIhtCMp4KgkDub0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GS3sXpbi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JyUZV0e9ROSp0RhnA+Pw7XIu/qwjFprUf8qcldrWdDA=; b=GS3sXpbi7PpYkegn/egJYDClE/
	JMGSgJt6XhyfRxBAx+pCWVTbH4S+DqpHkWxf8YX+d0f/SngQi2SRWwQQoDNu6aaOjD2flVulkC3TE
	G3y6lOsHaYhsTXlEyEavTxZj3jpkKO8KCZJAZnI/TRGK+xcg4bGcLZWuQWkw1ch5XSQWgVVR7DB25
	HBJtpxa8l+MA98+KDQJ7WngPzUYfy1CQVWKeHg7iPMJ3MfcqnOG/Yzv5HCcRbla8jbw+J5X6tFsdG
	h+Byz9IYBkvGAsoxmgkGjvzE6AGG4Uv+a9wZbzMv7lagbdXaa5N1rHYUL4EyAppfSiT0cGriVo8Lg
	3C60d2qQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxJpY-00000000wgH-2Vqw;
	Thu, 18 Apr 2024 04:57:04 +0000
Date: Wed, 17 Apr 2024 21:57:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Mike Snitzer <msnitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
Message-ID: <ZiCoIHFLAzCva2lU@infradead.org>
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
 <20240417175538.GP40213@noisy.programming.kicks-ass.net>
 <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 17, 2024 at 08:00:22PM +0200, Mikulas Patocka wrote:
> > > +EXPORT_SYMBOL(wait_for_completion_long_io);
> > 
> > Urgh, why is it a sane thing to circumvent the hang check timer? 
> 
> The block layer already does it - the bios can have arbitrary size, so 
> waiting for them takes arbitrary time.

And as mentioned the last few times around, I think we want a task
state to say that task can sleep long or even forever and not propagate
this hack even further.


