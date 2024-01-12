Return-Path: <linux-kernel+bounces-24443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D441482BC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BC71C251D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D58155786;
	Fri, 12 Jan 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CuzGRTsw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uhIVYCUR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FFB14F66;
	Fri, 12 Jan 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Jan 2024 10:01:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705050102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYtWY9hDXkpJN3n4nxz2ZUDW4riO9eRN9qxUsjklYiE=;
	b=CuzGRTswnalzZbMOffuEnmxQw7N8eG94OCB9DMMcd/yHLwwSkHiizA9uj2Wh8R7IDzbYRb
	53+qCoZiqbpWFhBp3zRIOyD/Bq6YpVy39M2ssOHnCmQXwbGahKkb3/Nt0FLkul3VQCmnQ/
	/arUdwpmpZGSLdkKkWGfvqfEA4HoF5EKrxv8Wjo/7haxNb9C8JEj6I6zt1S3LV37IA2a1L
	SKHaCMD35rJvUopI7dEKXmG8UV4ltjyOhYe/zZZ80SSJpcnGcETzYlO+Md7w9uH3c1a2Kx
	DU4iHR/q0u/rjRm5s29P7Ntq8h1apcEwhAX9k5oTqnmpgU2QiRD1ah65idA2gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705050102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYtWY9hDXkpJN3n4nxz2ZUDW4riO9eRN9qxUsjklYiE=;
	b=uhIVYCURSTw9wJBjiY3yz2qpg2LnjrnOiCtlGBOUBjwOMmeyLS5bjCly/h4q2ivDmycAWV
	ExgLPgVwEai9cgBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH net-next 03/24] net: Use __napi_alloc_frag_align()
 instead of open coding it.
Message-ID: <20240112090140.u5Lac1X9@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215171020.687342-4-bigeasy@linutronix.de>
 <9d4e1a18e6402f5476ebaaafd4a40a925daf19e6.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d4e1a18e6402f5476ebaaafd4a40a925daf19e6.camel@redhat.com>

On 2023-12-18 08:48:56 [+0100], Paolo Abeni wrote:
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index b157efea5dea8..de9397e45718a 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -311,11 +311,8 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
> >  
> >  		data = page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align_mask);
> >  	} else {
> > -		struct napi_alloc_cache *nc;
> > -
> >  		local_bh_disable();
> > -		nc = this_cpu_ptr(&napi_alloc_cache);
> > -		data = page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
> 
> There is a:
> 
> 	fragsz = SKB_DATA_ALIGN(fragsz);
> 
> statement just before the enclosing 'if'. I would consider moving such
> assignment inside the 'then' branch - since __napi_alloc_frag_align()
> already include that.

Okay, moved.

> /P
Sebastian

