Return-Path: <linux-kernel+bounces-94765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D184F8744F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC541C22292
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FDF17F8;
	Thu,  7 Mar 2024 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbo5OexW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB70ED9;
	Thu,  7 Mar 2024 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769869; cv=none; b=amg43NfiqVB0rdCsWLlj694/xfqxFFDKeczMQ5uPWl2/5mVoq7ZzcLueaJu9NQHdNXRrdMqvqO736Vx5K1vydadCeJ4+qJjh6+ao6xlZ5eDQ1oz4INlmakB0NDslhGLsj+SpUnQUqUw0PzWHD7V5TneK1G9zKxcFAvfqbz5/XVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769869; c=relaxed/simple;
	bh=+W6hvbt5EEqgiR4S3fDu1Rhs7u+YAG3HxUAFWBzgCCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsqZJCjGVoNfuTlF3HxKOHRyK/NNBVwawFRPwyALQhW2lTC5ZvbVLKldRhuhsfU2h+wrtBu7eUJPgdEocKL62lL3Uy8yZyFhu7/e6fdkGaRyUuHrIIbXFCN6GwD/8nzcZMPJEPCk5KdWvtCiRxXVmw2eXx/yiFI6MUb+zSVGQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbo5OexW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C22CC433F1;
	Thu,  7 Mar 2024 00:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709769868;
	bh=+W6hvbt5EEqgiR4S3fDu1Rhs7u+YAG3HxUAFWBzgCCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbo5OexWpCB8imBP66fHNUASvxTRfjAx4U8M8fWzj27f3+XmVZl4hz4YKkc53LTfC
	 qpFrRWIYcqwIqay8iLEUrBcwpsK5plXqYDXwooxAHwVMHaA0L5scKaBebz5gKlU6YU
	 cNFgWstKzKNBtfZ3sJCJJslNJxQSUW3gr595ohaNAfDubD2l5WpDws6aV/NnkUpbKa
	 ieCtvdPvmuEOL7J4GRFAvoMT6rQewoQsG4z4peIzGIT+wcpqmNrvlqxN/9cb7Sw3Kk
	 Mp0RQl0zh0U+D9mFw19qiZmrUUpkhyChPhDVam4UEw2cKtSvOTpIsKg7HLq2BaUYZj
	 SzcZsUcHDyg6g==
Date: Thu, 7 Mar 2024 01:04:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Message-ID: <ZekEiXZes38y_Rmq@localhost.localdomain>
References: <20240305195720.42687-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305195720.42687-1-urezki@gmail.com>

Le Tue, Mar 05, 2024 at 08:57:19PM +0100, Uladzislau Rezki (Sony) a écrit :
> Fix a below race by not releasing a wait-head from the
> GP-kthread as it can lead for reusing it whereas a worker
> can still access it thus execute newly added callbacks too
> early.
> 
> CPU 0                              CPU 1
> -----                              -----
> 
> // wait_tail == HEAD1
> rcu_sr_normal_gp_cleanup() {
>     // has passed SR_MAX_USERS_WAKE_FROM_GP
>     wait_tail->next = next;
>     // done_tail = HEAD1
>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>     queue_work() {
>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>         __queue_work()
>     }
> }
> 
>                                set_work_pool_and_clear_pending()
>                                rcu_sr_normal_gp_cleanup_work() {
> // new GP, wait_tail == HEAD2
> rcu_sr_normal_gp_cleanup() {
>     // executes all completion, but stop at HEAD1
>     wait_tail->next = HEAD1;
>     // done_tail = HEAD2
>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>     queue_work() {
>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>         __queue_work()
>     }
> }
>                                  // done = HEAD2
>                                  done = smp_load_acquire(&rcu_state.srs_done_tail);
>                                  // head = HEAD1
>                                  head = done->next;
>                                  done->next = NULL;
>                                  llist_for_each_safe() {
>                                  // completes all callbacks, release HEAD1
>                                  }
>                                }
>                                // Process second queue
>                                set_work_pool_and_clear_pending()
>                                rcu_sr_normal_gp_cleanup_work() {
>                                // done = HEAD2
>                                done = smp_load_acquire(&rcu_state.srs_done_tail);
> 
> // new GP, wait_tail == HEAD3
> rcu_sr_normal_gp_cleanup() {
>     // Finds HEAD2 with ->next == NULL at the end
>     rcu_sr_put_wait_head(HEAD2)
>     ...
> 
> // A few more GPs later
> rcu_sr_normal_gp_init() {
>      HEAD2 = rcu_sr_get_wait_head();
>      llist_add(HEAD2, &rcu_state.srs_next);
>                                // head == rcu_state.srs_next
>                                head = done->next;
>                                done->next = NULL;
>                                llist_for_each_safe() {
>                                 // EXECUTE CALLBACKS TOO EARLY!!!
>                                 }
>                                }
> 
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

