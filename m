Return-Path: <linux-kernel+bounces-29443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6311F830E57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193D12843BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A475525555;
	Wed, 17 Jan 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFpHPyfp"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D721DA4C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705525273; cv=none; b=a9PoVZatnsYQaQALhYYFJ4tqTsqkgXKLXb+jGX9zCJ0ECDr3b4uusWovdzLZYqOIDlAQtaaKOyk0k/ZstSJDd3hRh3IB5S5qw9NQ5zbLz7Q5h4RPxryOx1HB9uCE7FLdVulbf3NrfteNuWZ/4CPlLFts2Sm7ETXEuYE5yfhj0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705525273; c=relaxed/simple;
	bh=uvMm1S3nfNq7r0b9X2gPN6BSNpJ+4EP0YbQyOwwVeP4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Received:X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:
	 X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=gQOdA7Lc6iXXjRvPfSy2O/HD8Zm3tjl1+2xV4+p/qAvU3SjETKFJpT7Wb+6M27XBr5WTwmui0hmqziOJk1sGkgk5FALP/UQWki/nyekUzmgsTJTYwUJRmMAOY1Er5+/IVmuRwGeoC9Q9BMcmVvL/1ke/1zmMX45dcLw3AmGqQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFpHPyfp; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-46771fc85cdso2297579137.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705525271; x=1706130071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI4Ytk5XgmbtbQIAh/4kBpIf1r2iodmlOv4hdR7S8Ec=;
        b=IFpHPyfpJEFKOy2QEouJzOeGlhiCyuu3/bJJFPnFcqC7ZaoSeN+8BlOQcCkCDUYaJE
         FsIF/FgJN2XbovP96QGoG8js/ILU2Y8m6tmDM2ks7tt/MCsbQ5B5RJkZGchyzp3QMufN
         D9GEqUlN7av7WLv/LlDT9dqpYPwtIrbkcoCHXv8hlSAslV4Kc1tg88/WRLd2KxTQOYoq
         APu7NCzbCo88eKxihnpMTRMm7Wq9KeIqf8yIQxOYJBG8fACgTm4UjUItzpf/rSgNpXoq
         ySd4vvafxQ62cbEkD8B+3VdB+0LD/v2aGdshAHLXKnnoiZWS4WOKj5glT+OUZ7OApZe8
         H3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705525271; x=1706130071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI4Ytk5XgmbtbQIAh/4kBpIf1r2iodmlOv4hdR7S8Ec=;
        b=JqYdR5hJMxExuvMRb72m9AIzhF/D7e8oqOir+6DMX4umwWahCU8a+grqsh6H2ssO0m
         kVQFH+W7EpAkKNAvbfG/6Cj7Tsd2sXTNNqVsFxkYHFDso/Xw9J7tAvo1de1YsYbBP6JV
         uV/xA0ESZJqwTMShk4GD2Z5Fw0Y00r4hgFJFn+Bw5ibtbM1Ej+URcMi1lU78K6e3nVBF
         RI0ClLR0ned+f6y7F3+CrQdMJ5bptS14FlHzgi1lz20sJP/ehoUwP3YbgVNH8siJ3oa3
         kDBkGLdHbhlsxzpKXJUAggNl8rX/rByGcWll42qmtGZyBcGwUcx+0jc2i4ZDcn2veEue
         YU7Q==
X-Gm-Message-State: AOJu0Yyn3Y34gjzdyfrg5QmUNzEPNt6SykVCBBfiPYYnuiBS5sZq6OxH
	fBzuWxl9SNCZLDUvQI0wRjM=
X-Google-Smtp-Source: AGHT+IFhqozNey5Lbq1EWGqey0FCitKs+zz4gRdme4s52DJqyudYwNYJT7Qd219SFDe8i5k8G/Yydw==
X-Received: by 2002:a05:6102:128c:b0:467:fe88:9ee3 with SMTP id jc12-20020a056102128c00b00467fe889ee3mr5700451vsb.17.1705525269399;
        Wed, 17 Jan 2024 13:01:09 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dd8-20020ad45808000000b00681839bebdesm530497qvb.4.2024.01.17.13.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:01:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id E156127C0078;
	Wed, 17 Jan 2024 15:53:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 Jan 2024 15:53:33 -0500
X-ME-Sender: <xms:TT6oZZwCtH2ChgsXmD4lWRDkorAWE2zybX_F1I1SIAyARc2RBqYriw>
    <xme:TT6oZZRgwzdWDNTq1CRVuJF08CQQoKTUaW0jBcT4r3OT7tXBtyP0cgL3rAwBSKhKU
    yE42vcx-7ranxMQoA>
X-ME-Received: <xmr:TT6oZTVvxZ5EbmWnefWTkniD_-wCnSdu007VC3vjzGvSNJBdWWrx-IU1glrWGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:TT6oZbhjubvx-0S7xQMB9MqtEIJHCZ6LbTpWz1NanCC_CfQRzi_jVA>
    <xmx:TT6oZbCJajfbXiPxpH7ezRjfNla6-bGjx7m2-1_7RNWvLbeBY_ahVQ>
    <xmx:TT6oZUJcN18JdcGum8t6Db2DjNJfKJD1DmVV2JXV0v9TuvDXFy0M0g>
    <xmx:TT6oZf2OslZu0PVAGeJC2TQSNPBVeYWRDwO0_rgutKfUSmRYKNUI_w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 15:53:32 -0500 (EST)
Date: Wed, 17 Jan 2024 12:53:11 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, linux-kernel@vger.kernel.org,
	niuzhiguo84@gmail.com, ke.wang@unisoc.com, xuewen.yan@unisoc.com
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <Zag-N1369ATj400Q@boqun-archlinux>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>

On Wed, Jan 17, 2024 at 03:48:34PM +0800, Zhiguo Niu wrote:
> There is a deadlock scenario between lockdep and rcu when
> rcu nocb feature is enabled, just as following call stack:
> 
>      rcuop/x
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
> -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
> -002|__raw_spin_lock_irqsave(inline)
> -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
> -003|wake_nocb_gp_defer(inline)
> -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
> -004|__call_rcu_common(inline)
> -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
> -005|call_rcu_zapped(inline)
> -005|free_zapped_rcu(ch = ?)// hold graph lock
> -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
> -007|nocb_cb_wait(inline)
> -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
> -008|kthread(_create = 0xFFFFFF80803122C0)
> -009|ret_from_fork(asm)
> 
>      rcuop/y
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> -001|queued_spin_lock()
> -001|lockdep_lock()
> -001|graph_lock() // try to hold graph lock
> -002|lookup_chain_cache_add()
> -002|validate_chain()
> -003|lock_acquire
> -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> -005|lock_timer_base(inline)
> -006|mod_timer(inline)
> -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
> -007|__call_rcu_common(inline)
> -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> -008|call_rcu_hurry(inline)
> -008|rcu_sync_call(inline)
> -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> -010|nocb_cb_wait(inline)
> -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> -011|kthread(_create = 0xFFFFFF8080363740)
> -012|ret_from_fork(asm)
> 
> rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> This patch release the graph lock before lockdep call_rcu.
> 
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> changes of v2: update patch according to Boqun's suggestions.
> ---
> ---
>  kernel/locking/lockdep.c | 47 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3d..ddcaa69 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6184,25 +6184,27 @@ static struct pending_free *get_pending_free(void)
>  static void free_zapped_rcu(struct rcu_head *cb);
>  
>  /*
> - * Schedule an RCU callback if no RCU callback is pending. Must be called with
> - * the graph lock held.
> - */
> -static void call_rcu_zapped(struct pending_free *pf)
> +* See if we need to queue an RCU callback, must called with
> +* the lockdep lock held, returns false if either we don't have
> +* any pending free or the callback is already scheduled.
> +* Otherwise, a call_rcu() must follow this function call.
> +*/
> +static bool prepare_call_rcu_zapped(struct pending_free *pf)
>  {
>  	WARN_ON_ONCE(inside_selftest());
>  
>  	if (list_empty(&pf->zapped))
> -		return;
> +		return false;
>  
>  	if (delayed_free.scheduled)
> -		return;
> +		return false;
>  
>  	delayed_free.scheduled = true;
>  
>  	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
>  	delayed_free.index ^= 1;
>  
> -	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> +	return true;
>  }
>  
>  /* The caller must hold the graph lock. May be called from RCU context. */
> @@ -6228,6 +6230,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
>  {
>  	struct pending_free *pf;
>  	unsigned long flags;
> +	bool need_callback;
>  
>  	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
>  		return;
> @@ -6239,14 +6242,17 @@ static void free_zapped_rcu(struct rcu_head *ch)
>  	pf = delayed_free.pf + (delayed_free.index ^ 1);
>  	__free_zapped_classes(pf);
>  	delayed_free.scheduled = false;
> +	need_callback =
> +		prepare_call_rcu_zapped(delayed_free.pf + delayed_free.index);
> +	lockdep_unlock();
> +	raw_local_irq_restore(flags);
>  
>  	/*
> -	 * If there's anything on the open list, close and start a new callback.
> -	 */
> -	call_rcu_zapped(delayed_free.pf + delayed_free.index);
> +	* If there's anything on the open list, close and start a new callback.
> +	*/
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>  
> -	lockdep_unlock();
> -	raw_local_irq_restore(flags);
>  }
>  
>  /*
> @@ -6286,6 +6292,7 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
>  {
>  	struct pending_free *pf;
>  	unsigned long flags;
> +	bool need_callback;
>  
>  	init_data_structures_once();
>  
> @@ -6293,10 +6300,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
>  	lockdep_lock();
>  	pf = get_pending_free();
>  	__lockdep_free_key_range(pf, start, size);
> -	call_rcu_zapped(pf);
> +	need_callback = prepare_call_rcu_zapped(pf);
>  	lockdep_unlock();
>  	raw_local_irq_restore(flags);
> -
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>  	/*
>  	 * Wait for any possible iterators from look_up_lock_class() to pass
>  	 * before continuing to free the memory they refer to.
> @@ -6390,6 +6398,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
>  	struct pending_free *pf;
>  	unsigned long flags;
>  	int locked;
> +	bool need_callback = false;
>  
>  	raw_local_irq_save(flags);
>  	locked = graph_lock();
> @@ -6398,11 +6407,13 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
>  
>  	pf = get_pending_free();
>  	__lockdep_reset_lock(pf, lock);
> -	call_rcu_zapped(pf);
> +	need_callback = prepare_call_rcu_zapped(pf);
>  
>  	graph_unlock();
>  out_irq:
>  	raw_local_irq_restore(flags);
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>  }
>  
>  /*
> @@ -6446,6 +6457,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
>  	struct pending_free *pf;
>  	unsigned long flags;
>  	bool found = false;
> +	bool need_callback = false;
>  
>  	might_sleep();
>  
> @@ -6466,11 +6478,14 @@ void lockdep_unregister_key(struct lock_class_key *key)
>  	if (found) {
>  		pf = get_pending_free();
>  		__lockdep_free_key_range(pf, key, 1);
> -		call_rcu_zapped(pf);
> +		need_callback = prepare_call_rcu_zapped(pf);
>  	}
>  	lockdep_unlock();
>  	raw_local_irq_restore(flags);
>  
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> +
>  	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
>  	synchronize_rcu();
>  }
> -- 
> 1.9.1
> 

