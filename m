Return-Path: <linux-kernel+bounces-94865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91687461C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771DE286451
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686CF611E;
	Thu,  7 Mar 2024 02:33:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BBF1847
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709778784; cv=none; b=W9UAO5hKyjYPf4CL1a+jDuvSzF4J/VC3FUMXTRnVIjrXU+GnaWYGrMHkmOSDtbFNVLXr4XwIQB7KgWne1aNB53lba4oa+259iGx2+mnGad9WIvtHJ0W8GMCJfY3yBiw7SOGIHp8W+sC+YMdCW1Nq92r9flqXPiLu7PF+xK6UPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709778784; c=relaxed/simple;
	bh=pkoOFmAvrD3wDqGDRfFIlNPEWvvmWyCwnppqJZic2vE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyTw4p3m4jPU7wElUq8utnXkkR6GBzD0NQAuZ1t7ybqQ44BT4r5TT3xFXjtXzkOequwCP+3Yzrf//yKA9+WF15JE0gnRhZ+b2o+YnQgDXI4ARHILM902X8q5GSeK84+Ahzya5H/gDV/LHz1iDS5uRup6dJkoYi1YRgnAlrBghDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF49C433F1;
	Thu,  7 Mar 2024 02:33:02 +0000 (UTC)
Date: Wed, 6 Mar 2024 21:34:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>, Sam Sun <samsun1006219@gmail.com>,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 xrivendell7@gmail.com, ardb@kernel.org, peterz@infradead.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [Bug] WARNING in static_key_disable_cpuslocked
Message-ID: <20240306213453.72f9a925@gandalf.local.home>
In-Reply-To: <20240307013009.erbnug2mopx5yrnf@treble>
References: <CAEkJfYNNZftjpYBpnH4tEnm82orKtQ6SQn9i3sg7YNO-Df3tSQ@mail.gmail.com>
	<20240306105420.6a6bea2c@gandalf.local.home>
	<20240306193101.s2g33o4viqi2azf3@treble>
	<854e523c-c467-47f6-b977-933cbaadeb62@akamai.com>
	<20240306221650.sw3lha7kca2quv63@treble>
	<8f586bd2-c436-4334-92af-762a284e1101@akamai.com>
	<20240306234253.zporv6cypoc7yihs@treble>
	<20240307013009.erbnug2mopx5yrnf@treble>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 17:30:09 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> So, I think we can simplify this nicely by getting rid of the whole -1
> thing altogether:
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index d9c822bbffb8..ef7eda7685b2 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -194,20 +194,15 @@ void static_key_enable_cpuslocked(struct static_key *key)
>  	STATIC_KEY_CHECK_USE(key);
>  	lockdep_assert_cpus_held();
>  
> -	if (atomic_read(&key->enabled) > 0) {
> -		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
> +	if (atomic_read(&key->enabled) == 1)
>  		return;
> -	}
> -
>  	jump_label_lock();
> -	if (atomic_read(&key->enabled) == 0) {
> -		atomic_set(&key->enabled, -1);
> +
> +	if (atomic_cmpxchg(&key->enabled, 0, 1) == 0)
>  		jump_label_update(key);
> -		/*
> -		 * See static_key_slow_inc().
> -		 */
> -		atomic_set_release(&key->enabled, 1);
> -	}
> +	else
> +		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
> +
>  	jump_label_unlock();

You may be able to clean it up more with:

	int tmp;

	tmp = atomic_read(&key->enabled);
	if (tmp == 1)
		return;

	jump_label_lock();

	if (!tmp && atomic_try_cmpxchg(&key->enabled, &tmp, 1))
		jump_label_update(key);
	else
		WARN_ON_ONCE(tmp != 1);

	jump_label_unlock();

 ;-)

-- Steve


>  }
>  EXPORT_SYMBOL_GPL(static_key_enable_cpuslocked);
> @@ -225,14 +220,16 @@ void static_key_disable_cpuslocked(struct static_key *key)
>  	STATIC_KEY_CHECK_USE(key);
>  	lockdep_assert_cpus_held();
>  
> -	if (atomic_read(&key->enabled) != 1) {
> -		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
> +	if (atomic_read(&key->enabled) == 0)
>  		return;
> -	}
>  
>  	jump_label_lock();
> -	if (atomic_cmpxchg(&key->enabled, 1, 0))
> +
> +	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
>  		jump_label_update(key);
> +	else
> +		WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
> +
>  	jump_label_unlock();
>  }
>  EXPORT_SYMBOL_GPL(static_key_disable_cpuslocked);


