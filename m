Return-Path: <linux-kernel+bounces-83584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ECB869BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C82728589D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F740148316;
	Tue, 27 Feb 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKk+tzEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC514830B;
	Tue, 27 Feb 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050592; cv=none; b=l7u9wodBiz82hfdvudCjB5g07OJn8foJ+6WZMiCnfZEToNCn+I4uf993l9ZYyHt7N2qHve2WJLOtZ5HosBvEP2nc3psyBuexJAP+kNbLKMS/W/mUwyf0diLJvRlkMPm75h4JJ/vcOztcdHe3JIyuCxVM+SGSYX8AWdVJk1EiIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050592; c=relaxed/simple;
	bh=zGUhntNawTj0DGtuLkweLbg6UYXMPCtS0OX1qkkifiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS4U1M0yCxn9/5gxnkac0oyrT66uQjPJbOuxFwT334HFAWoatmCwRxemgdeNyqO43SBpSQ4GSr4U+P8okGHjxnlpG8vyjEiOgNMCAv1m5NHZ2uGZ3maL2OZmaRtNQ5D3RSkdXMecXoxwtGIKi13KsWm6gI9SJgewmUT2tagnHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKk+tzEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A83C43390;
	Tue, 27 Feb 2024 16:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050590;
	bh=zGUhntNawTj0DGtuLkweLbg6UYXMPCtS0OX1qkkifiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKk+tzEOTqPiH84N1aei7YjuFYKaD2ludAQgGbh38eHSYjl0gxaBABPKpyaEF/Gvn
	 KerupP1LqQ+8viJKEpeej58uFXmYz9YvBlsPKRl/0S3VzE7Uc6Ub3NeFYXVxmXGe/k
	 WqA528WBDPTEaBFcEtGiblpO1N/85Fh9i3DLyHHjMcH2AYOHTsSdpfaisshEO0jSsW
	 9O2w64LWzhoOausXZwFoWbKZ90qB9o30yvrW+HcaM/5D6icRCCTpgzyEZNiQ5Ma6kF
	 j6qa2fqlEaam+s0lg1RsNJ9JOpugEvpLDmplyyJKaJOmYysUitiKBfSTGZQgt97Pb8
	 GunTz0IzSat7w==
Date: Tue, 27 Feb 2024 17:16:27 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Zd4K28_GkRQBn9Ik@localhost.localdomain>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
 <CALm+0cUJ9tMsZpOGby_6B6c=XDBn_CJ6=o2WSFafaCwPzp6_4A@mail.gmail.com>
 <Zd3zptTLlUDCg1L7@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd3zptTLlUDCg1L7@localhost.localdomain>

Le Tue, Feb 27, 2024 at 03:37:26PM +0100, Frederic Weisbecker a écrit :
> Le Tue, Feb 27, 2024 at 02:39:55PM +0800, Z qiang a écrit :
> > > Can the following race happen?
> > >
> > > CPU 0                                                   CPU 1
> > > -----                                                   -----
> > >
> > > // wait_tail == HEAD1
> > > rcu_sr_normal_gp_cleanup() {
> > >     // has passed SR_MAX_USERS_WAKE_FROM_GP
> > >     wait_tail->next = next;
> > >     // done_tail = HEAD1
> > >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > >     queue_work() {
> > >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> > >         __queue_work()
> > >     }
> > > }
> > >
> > >                                                       set_work_pool_and_clear_pending()
> > >                                                       rcu_sr_normal_gp_cleanup_work() {
> > > // new GP, wait_tail == HEAD2
> > > rcu_sr_normal_gp_cleanup() {
> > >     // executes all completion, but stop at HEAD1
> > >     wait_tail->next = HEAD1;
> > >     // done_tail = HEAD2
> > >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > >     queue_work() {
> > >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> > >         __queue_work()
> > >     }
> > > }
> > >                                                           // done = HEAD2
> > >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> > >                                                           // head = HEAD1
> > >                                                           head = done->next;
> > >                                                           done->next = NULL;
> > >                                                           llist_for_each_safe() {
> > >                                                               // completes all callbacks, release HEAD1
> > >                                                           }
> > >                                                       }
> > >                                                       // Process second queue
> > >                                                       set_work_pool_and_clear_pending()
> > >                                                       rcu_sr_normal_gp_cleanup_work() {
> > >                                                           // done = HEAD2
> > >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> > >
> > > // new GP, wait_tail == HEAD3
> > > rcu_sr_normal_gp_cleanup() {
> > >     // Finds HEAD2 with ->next == NULL at the end
> > >     rcu_sr_put_wait_head(HEAD2)
> > 
> > It seems that we should move rcu_sr_put_wait_head() from
> > rcu_sr_normal_gp_cleanup() to
> > rcu_sr_normal_gp_cleanup_work(), if find wait_head->next == NULL, invoke
> > rcu_sr_put_wait_head() to release wait_head.
> 
> Well, rcu_sr_normal_gp_cleanup_work() already put all the wait heads
> that are _after_ srs_done_tail. But it can't put the srs_done_tail itself
> without introducing even worse races...
> 

(I forgot to mention this race actually concerns the last patch (4/4))

