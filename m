Return-Path: <linux-kernel+bounces-50505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE61847A02
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B14B26C34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24D8061A;
	Fri,  2 Feb 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3q5u1cCV"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE681729
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903754; cv=none; b=QtGwmV0yRCfvtFoh5obVhjvR6e408I19ojCPDthaZePZdG1amyneJldgyGPDTWq15wea4CEBuN8N93uJTAHxNPKSzA5nv/ETW0GoZKIzfMR0s5oVNfTpf+PO+qShydh5Ncb+XL7cyq109/0+889a4y/z6G5urQaEtJ1jWLZw1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903754; c=relaxed/simple;
	bh=95AIW4KlBus8wL5x7I3bZqt4SU9vj3L1+DdUDs0U47A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2XaVe9GbKuwWPgRCQQvfS4A6wQ+W20R5FFKtqCWMf/IZvLIQEqhiaIeIu1E+9W+pRPxJ8rJFuHrV0AdEwiUCCe8Lry/s3qprCTOIkmJ1dAyT+fcN825QV1NZGBeZyPU82gqrK3Xhs1t4gCtA+/Sj0HZ2xK1ZMy/T8V4+adTSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3q5u1cCV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso2243921a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 11:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706903752; x=1707508552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZtrhHWJ+pfqN2QJR+1RI9NqKi6clgmRoBV9BxjkVtU=;
        b=3q5u1cCVKm1xSPBC/s3j0vV32NK6X40U46RrKBQ036aW7IAOs/n5DbzDhhPbK+6hHF
         SrPMFvHBLaHb4IWoQu0ANShvga7ZMRgFoZirM7QBwPVQS9pWuKIzZ55ircUbv+qO8ze8
         1C5CJyWwJQxvVDngVbQz68mEE8V0wWWxmiyXbbcIVw2phtkP4d4tL8v99NYE38EpwErU
         xkLVJ9jL2LULzkZkpfj4dl0pAEVM89zm/Dc8fCTW0tRtOrgR78FVdhvhq8g3oFhyMFVz
         rNZ0DGuPKVzvUq31LhrpBqsslZvuyQw8q268d1YsJ03BPLUeNpD1tZkeyHzJuDD1sqVf
         TCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706903752; x=1707508552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZtrhHWJ+pfqN2QJR+1RI9NqKi6clgmRoBV9BxjkVtU=;
        b=BcGrNWxSk6zaNJmJMjqOSYbQzHpf+EVA3Gn8iDCGydFTHwppDLXc5tbKJfZzwnUaVk
         IUKYav3yHFcDHlxXRfwtrccTEyELDGp/Is/xbTVgbhgxp3Bq4VIUuKxMiY9xsVV8c+CW
         65NBOTxnrkF7F3rWRvcVwy00o88uTlpnRt0YAjw2MujcxZtLWNPxr6UQLb9h0jkG3oa/
         n/NG2v/ToBFMLkMRw2mvLYtEh6Wpggkc5JaqC+abm4z9HuEgj+wJe28RnHMOyICjbHKb
         nXsko8l/JqgJFwDucp13RohzG7it36MVthruc/Ml9m3ZpPhjp8a86/Rb2fkcaLrdGUNm
         4uug==
X-Gm-Message-State: AOJu0Yy4ZHSKaROfsrvw1MNP81/NgyhGOZNTRckFO6gDHX2NOo8IRfzD
	Pps1Q6k0jOKHRRdPpyZDxpFZmkHS2ieQJg82t9W61REv7pUm2Y16RqxnunnCaA==
X-Google-Smtp-Source: AGHT+IHWl6n81+OmfaV8OHrK/X4KkCArIuT/WLGKLp1Ihm6VXAnHLRBuZZzCf/NxdXGw+/dzX+SrdA==
X-Received: by 2002:a05:6a20:b1a:b0:199:29c5:12f7 with SMTP id x26-20020a056a200b1a00b0019929c512f7mr2617689pzf.29.1706903751992;
        Fri, 02 Feb 2024 11:55:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXxciM+FwBaRLlPGM5QHe7rCQbUPfryauCO3qLegJCU1O3MxuD/uidBPNCFlhYFpemEbwKy5/niV//aa96GoLsQNB1DQ821roJb5To7xHWQBdkH7oklgTGQqcJFaHIlkhRHCOPZvhZxP8R1hVrnX7luJU3j5rKRgsHTTtoLLit/QxnZubgxYjTS7zoJq7QQOuTyPA3sTdUeVi7dIxH+lMb2uo0YzdZ4qAknHK1kToyWqjt6Upqni13yfcHYumvL+Pl7Yj1T25ED/y3R2JW+dt7/wkCc6f80JuBQkPjOP3k6/fwQIpkagTqEdG9f3XmZUyLO4C+nFq40kZFPEEIT+YYLOJphBRcPxQYR
Received: from google.com (152.33.83.34.bc.googleusercontent.com. [34.83.33.152])
        by smtp.gmail.com with ESMTPSA id c26-20020aa7881a000000b006d9be753ac7sm2017429pfo.108.2024.02.02.11.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:55:51 -0800 (PST)
Date: Fri, 2 Feb 2024 19:55:48 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, hongyu.jin@unisoc.com, stable@vger.kernel.org
Subject: Re: [PATCH V3] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <Zb1IxNd54z2Ib1N3@google.com>
References: <1706861676-26574-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706861676-26574-1-git-send-email-zhiguo.niu@unisoc.com>

On Fri, Feb 02, 2024 at 04:14:36PM +0800, Zhiguo Niu wrote:
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
> Cc: <stable@vger.kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> changes of v3: correct code comments and add Cc tag.
> changes of v2: update patch according to Boqun's suggestions.
> ---

It seems v3 should have collected the review tags from Boqun and Waiman.
Also, I'm actually Cc'ing stable here. I hope that is enough.
FWIW, this looks fine to me.

Reviewed-by: Carlos Llamas <cmllamas@google.com>

Thanks

