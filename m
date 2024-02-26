Return-Path: <linux-kernel+bounces-82433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED4868476
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9A81F22D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69D13541D;
	Mon, 26 Feb 2024 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEfcwq7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6B12F394;
	Mon, 26 Feb 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988855; cv=none; b=VehVgsi4BQgKFalRayC+T1DKdXhE/LcCrlSciwwsm5OW+qivnL2vfA9VZUJlxk4vnrp/Pkr+Ehk7dqdgDKa1EqQBptny6L8BRf4TEHN4xJkrVnguSl+NjS9AIvPJ2wQO6mcw/lXke9Xggfwg44bUMKkGabxARc2QKrx0DD0So+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988855; c=relaxed/simple;
	bh=adz6SAgNBJ7AGaeqHuV2mXfoAvBXu435vI2nwYExYEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLg3tQoNyUvXxgzCPlNWV/cDjk3Ob6lA7bjKqBT7dzd7e+PiO2fTxtVOG2q4IDzatOa/VdZMIH9Ze/IBhxLDgOLvF8vNPZC6U67gzzy+gC/oDTEbly+h3HQ2x7oVDJqkBG/ZVjnWncYTRk1xJ4oMPGV1e7jquWY7IEKIU87sGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEfcwq7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D39C433F1;
	Mon, 26 Feb 2024 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708988854;
	bh=adz6SAgNBJ7AGaeqHuV2mXfoAvBXu435vI2nwYExYEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEfcwq7i9f+T6i2I8ee6x7nirzDO3u+1IU5tyQt02L4dTvhh2wLwjl5Vugkduxzru
	 wDwFty/4I4t4rUqmPx4dXLXYbpcuTYxj2j2/nQtI3pbHfTBGDT3ZztHi6PDhn505An
	 2jbi0GIVxhrOAr/jZJDZl+QF9zEk2dcanErt3WoJ9zxNzn6w8gLIfqzgdw0sJgCTk1
	 JZo/NUP+E++QAHJvNA1NeBzZLplrw91QPoOvDOyVi3509yLdRnLGC2w2BJTzYjYMHW
	 6TOEo9Fj/fhgmW/MkTT/Tad5mguVW0Pce7F4MC3BOfDDUkfEFKKPgomLeZO93WKfPa
	 IzeyEZm37RdCA==
Date: Tue, 27 Feb 2024 00:07:32 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Zd0ZtNu+Rt0qXkfS@lothringen>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220183115.74124-3-urezki@gmail.com>

On Tue, Feb 20, 2024 at 07:31:13PM +0100, Uladzislau Rezki (Sony) wrote:
> +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> +{
> +	struct llist_node *done, *rcu, *next, *head;
> +
> +	/*
> +	 * This work execution can potentially execute
> +	 * while a new done tail is being updated by
> +	 * grace period kthread in rcu_sr_normal_gp_cleanup().
> +	 * So, read and updates of done tail need to
> +	 * follow acq-rel semantics.
> +	 *
> +	 * Given that wq semantics guarantees that a single work
> +	 * cannot execute concurrently by multiple kworkers,
> +	 * the done tail list manipulations are protected here.
> +	 */
> +	done = smp_load_acquire(&rcu_state.srs_done_tail);
> +	if (!done)
> +		return;
> +
> +	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> +	head = done->next;
> +	done->next = NULL;

Can the following race happen?

CPU 0                                                   CPU 1
-----                                                   -----

// wait_tail == HEAD1
rcu_sr_normal_gp_cleanup() {
    // has passed SR_MAX_USERS_WAKE_FROM_GP
    wait_tail->next = next;
    // done_tail = HEAD1
    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
    queue_work() {
        test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
        __queue_work()
    }
}

                                                      set_work_pool_and_clear_pending()
                                                      rcu_sr_normal_gp_cleanup_work() {
// new GP, wait_tail == HEAD2
rcu_sr_normal_gp_cleanup() {
    // executes all completion, but stop at HEAD1
    wait_tail->next = HEAD1;
    // done_tail = HEAD2
    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
    queue_work() {
        test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
        __queue_work()
    }
}
                                                          // done = HEAD2
                                                          done = smp_load_acquire(&rcu_state.srs_done_tail);
                                                          // head = HEAD1
                                                          head = done->next;
                                                          done->next = NULL;
                                                          llist_for_each_safe() {
                                                              // completes all callbacks, release HEAD1
                                                          }
                                                      }
                                                      // Process second queue
                                                      set_work_pool_and_clear_pending()
                                                      rcu_sr_normal_gp_cleanup_work() {
                                                          // done = HEAD2
                                                          done = smp_load_acquire(&rcu_state.srs_done_tail);

// new GP, wait_tail == HEAD3
rcu_sr_normal_gp_cleanup() {
    // Finds HEAD2 with ->next == NULL at the end
    rcu_sr_put_wait_head(HEAD2)
    ...

// A few more GPs later
rcu_sr_normal_gp_init() {
     HEAD2 = rcu_sr_get_wait_head();
     llist_add(HEAD2, &rcu_state.srs_next);
                                                          // head == rcu_state.srs_next
                                                          head = done->next;
                                                          done->next = NULL;
                                                          llist_for_each_safe() {
                                                              // EXECUTE CALLBACKS TOO EARLY!!!
                                                          }
                                                      }

