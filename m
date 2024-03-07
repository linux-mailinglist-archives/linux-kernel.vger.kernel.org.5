Return-Path: <linux-kernel+bounces-96126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1F87576E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1469B220F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCE3136995;
	Thu,  7 Mar 2024 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eauGu7pU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590D41A88
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840792; cv=none; b=o+nB1o7/vi/Ms5e+++3Zd9GJltrj5NLP6SQGFzJugMa56LiLxnuNCQkzccwRddhd52FtwzZoESJfPRv6umlFbpmj4PT9OOH6r9lLsKfnn3ofppHO1vHwZEFTTd27JC6lt6aqxkW+AcchI8sEnkBasK3mCInJk6Me9ZlcQwkO+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840792; c=relaxed/simple;
	bh=ZkoLriIFMqvbtvNzCDlOVN4ynWY6JZVhyoE0r2/dOLc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iDV4W6O0qWg1tIJP09l3fYCEsTQ3TjEAMktNqBFxR7wr7Vd8eGxNfdb8V64u1RcSv+QGaHdL2lwu9Q49st9sqr54o2u9YmgLNgMxBc+DSORGWbnex7L+PqxDOmbObLnA0jPu6vhWAdXi3/JfISVKrj+T3802i58Tx4J77jX1LEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eauGu7pU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E5CC433C7;
	Thu,  7 Mar 2024 19:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709840791;
	bh=ZkoLriIFMqvbtvNzCDlOVN4ynWY6JZVhyoE0r2/dOLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eauGu7pU2cnbm5PxdoOPGqcJrKJWzalQoLQXnotDT8SMjSUVteZDfVN0M4hjcp6h0
	 NkY5wvnlqgftIA9ras3eqMPnZ7Zl7YvRJSlUqpa8FE6Mb5kIbdDPnY6TuLkLieCcBR
	 EGimGhHMtu4+jQFG2i4YN7Ri0mdT9wMGljK3Etdc=
Date: Thu, 7 Mar 2024 11:46:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Audra Mitchell <aubaker@redhat.com>
Subject: Re: [PATCH v2] mm/kmemleak: Don't hold kmemleak_lock when calling
 printk()
Message-Id: <20240307114630.32702099ac24c182b91da517@linux-foundation.org>
In-Reply-To: <20240307184707.961255-1-longman@redhat.com>
References: <20240307184707.961255-1-longman@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 13:47:07 -0500 Waiman Long <longman@redhat.com> wrote:

> When some error conditions happen (like OOM), some kmemleak functions
> call printk() to dump out some useful debugging information while holding
> the kmemleak_lock. This may cause deadlock as the printk() function
> may need to allocate additional memory leading to a create_object()
> call acquiring kmemleak_lock again.
> 
> An abbreviated lockdep splat is as follows:
>
> ...
> 
> Fix this deadlock issue by making sure that printk() is only called
> after releasing the kmemleak_lock.
> 
> ...
>
> @@ -427,9 +442,19 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
>  		else if (untagged_objp == untagged_ptr || alias)
>  			return object;
>  		else {
> +			if (!get_object(object))
> +				break;
> +			/*
> +			 * Release kmemleak_lock temporarily to avoid deadlock
> +			 * in printk(). dump_object_info() is called without
> +			 * holding object->lock (race unlikely).
> +			 */
> +			raw_spin_unlock(&kmemleak_lock);
>  			kmemleak_warn("Found object by alias at 0x%08lx\n",
>  				      ptr);
>  			dump_object_info(object);
> +			put_object(object);
> +			raw_spin_lock(&kmemleak_lock);
>  			break;

Please include a full description of why this is safe.  Once we've
dropped that lock, the tree is in an unknown state and we shouldn't
touch it again.  This consideration should be added to the relevant
functions' interface documentation and the code should be reviewed to
ensure that we're actually adhering to this.  Or something like that.

To simply drop and reacquire a lock without supporting analysis and
comments does not inspire confidence!

