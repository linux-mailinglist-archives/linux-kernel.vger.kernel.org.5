Return-Path: <linux-kernel+bounces-27578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F08C82F271
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DE11F24564
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1917742;
	Tue, 16 Jan 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j4+aRxFd"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5264411
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 16 Jan 2024 11:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705422815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmg3GNzcBPYLObsoIfvSxUxLh5vptfBkI448dFbt8lE=;
	b=j4+aRxFdAqzj7afHUsSGmCZkGwuFsGL9Rin5g+/GIY1r1mb1khkvEhsfUHIyHIEh3B5VZK
	hRSGCvbE5bGVGw+o+ANcHYMj9VMFnMK5TSR/43ZwqPdhYiGP3mAEq4IGYLGeNOES5tK8Gh
	qij/C9YTh6Gi/+3l5ZG7Q1JelykPRWw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, 
	linux-bcachefs@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: remove redundant variable tmp
Message-ID: <zoopxygtnqakxp566audzvwtnpordw7k47um4afdq3xoeyognn@6mvubblz6525>
References: <20240116110723.2247265-1-colin.i.king@gmail.com>
 <ZaaMIYDL/4AzG758@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaaMIYDL/4AzG758@bfoster>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 16, 2024 at 09:01:05AM -0500, Brian Foster wrote:
> On Tue, Jan 16, 2024 at 11:07:23AM +0000, Colin Ian King wrote:
> > The variable tmp is being assigned a value but it isn't being
> > read afterwards. The assignment is redundant and so tmp can be
> > removed.
> > 
> 
> I assume this intends to refer to s/tmp/ret/ ...
> 
> > Cleans up clang scan build warning:
> > warning: Although the value stored to 'ret' is used in the enclosing
> > expression, the value is never actually read from 'ret'
> > [deadcode.DeadStores]
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  fs/bcachefs/rebalance.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/fs/bcachefs/rebalance.c b/fs/bcachefs/rebalance.c
> > index 95f46cb3b5bd..827316a27431 100644
> > --- a/fs/bcachefs/rebalance.c
> > +++ b/fs/bcachefs/rebalance.c
> > @@ -385,7 +385,6 @@ static int bch2_rebalance_thread(void *arg)
> >  	struct bch_fs *c = arg;
> >  	struct bch_fs_rebalance *r = &c->rebalance;
> >  	struct moving_context ctxt;
> > -	int ret;
> >  
> >  	set_freezable();
> >  
> > @@ -393,8 +392,7 @@ static int bch2_rebalance_thread(void *arg)
> >  			      writepoint_ptr(&c->rebalance_write_point),
> >  			      true);
> >  
> > -	while (!kthread_should_stop() &&
> > -	       !(ret = do_rebalance(&ctxt)))
> > +	while (!kthread_should_stop() && !do_rebalance(&ctxt))
> 
> Part of me wonders if this was intended to return ret, as that appears
> to bubble back through kthread_stop(). That said, we don't check for
> error there either (i.e. bch2_rebalance_stop()), so this seems
> reasonable enough to me to address the warning:

yeah, the only reason to return errors here is to log them, and they've
already been logged at this point.

Thanks, applying this

