Return-Path: <linux-kernel+bounces-107598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D402287FEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BB1B2458F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863F8060A;
	Tue, 19 Mar 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gYd8uPut"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ADA7F471
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855490; cv=none; b=mYi0wZmqV6qs5aXEp9TNI3PohFbhjxmLgrfWrkuU+KsnDozTGCBL0Sph90izt9Ma17uTKSGuv/AvzWdJTcZRPCfrt/IvipMj3If+pZzE5fT8vHo/P2KNFhLZtYmuc4db8Ec+O+dNtMwx3fAn/Ljd+vuGcmLGDjTAa9HCwbX1ugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855490; c=relaxed/simple;
	bh=o/6gOedeKupUsZdMk2WoQJQXGAXsC7pO0bndXDxVQKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQCC2q7nwgd6QhZXxOutn9bI259qHI6MlBSN5k9FXpfB+X66XiA4dL3rZ77QTpSRCxv7KOOY1RR4skFA6dL+3MNROCc7b8GY9dRFpFnDfsRQ20xAj5sm2j+vdw+mufg21PFfvIZcs+h+uqoqf35lNeaspvTEoIR2WZRBpsMX3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gYd8uPut; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AHNy8s6ZrHehAjXb/cw60DwcMUbPfB3PEodeOCrE1Bo=; b=gYd8uPutBI/6Y7n9awDf8GMkwS
	R+Oiyb+4sgiFlC1HFyRVtsKriNPeLyoyE0yS324AA6JRc2kK+RI7GiivMpOHE0RvRIUIK1VfAwgRY
	7x5MxGr7EZof3TlfqqVQ8DzO++QvW2khbJOirOy26wpDjXRGoc0aj9US74oSc8rk7b81htUS3ergI
	+f4JgqMulhxKQ9Vy8Swop5QEjTlz7fz7yYQC/nof72TyOm8eI5f4ls3KANQ+EFdNAhnib7FZyLrsM
	AE53q4ZxQIrZc56YYg4D7BLbVI0y/SzcerlPxa9yaCJ4H4xZOC8Sztmy+yup/R04yQX9/Gegm8via
	6NH0Dmog==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmZfK-000000022AA-2y7C;
	Tue, 19 Mar 2024 13:38:06 +0000
Date: Tue, 19 Mar 2024 13:38:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] Locking: Let PREEMPT_RT compile again with new rwsem
 asserts.
Message-ID: <ZfmVPid-d7cpf6Yt@casper.infradead.org>
References: <20240319070550.ws_uO21-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319070550.ws_uO21-@linutronix.de>

On Tue, Mar 19, 2024 at 08:05:50AM +0100, Sebastian Andrzej Siewior wrote:
> -static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> +static __always_inline bool rwsem_held_write(const struct rw_semaphore *sem)

The locking maintainers were very clear that this predicate Should Not
Exist.  It encourages people to write bad code.  Assertions only!

>  {
> -	rw_base_assert_held_write(sem);
> +	return rw_base_is_write_locked(&sem->rwbase);
> +}
> +
> +static __always_inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> +{
> +	WARN_ON(!rwsem_held_write(sem));
>  }
>  
>  static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
> -- 
> 2.43.0
> 

