Return-Path: <linux-kernel+bounces-122326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F32488F53E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FBC4B245AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB02577B;
	Thu, 28 Mar 2024 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C883Zlp0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A32575F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592553; cv=none; b=GCdv508ubZOJmJo74IdXhN3drrSsdQLlwdUQO6bW1RC1Q5jsRBu68eeqqkRrBpCZiquCVTDDyt31LDB1GF4/otW8cZDHLBljtxJD+EHDwv+OSuXgrb3fXf6gcTqCi1aJFOLhUAIvutuq+w1XkANb0lm0dUyYxJ0KSeNVklKH++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592553; c=relaxed/simple;
	bh=L5/Fmy6g7Y+ZyLIpx3EGabo/DqpRCmHgqWBb5z2Tcys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2gUgrzXrtcNwYv2FB66Cp0PFpLpP4yGGgihnhGj5CEwEpNNawRFy1s5brypzUHcSRm9v6IfwwuoRF96K31Qei/X7O6/ihSNiQyibk26AyeNrnFdpBUVTiEfrJGG8iTqVEkaLlwnrbs41++xlPxP5l0QHtLdtLkUe7J55ZQKKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C883Zlp0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711592550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT19hp7mBYS8iXGdAPsVB/LvOK360nzUCpzBObpsxZM=;
	b=C883Zlp03l9PzzLetrV/O9ysrUS5PNcBr5doGvyFxfHYngr2tV+xeNyQVyWx14q3pT9ccB
	DEJPDCoV8zlh/XZT8ff6neM/Inw54RBzvUif2mJWwknzu5pPv6ogIGjxezjyUCIua8SiHd
	wtRjG3mOgIkl8hmxqxuB+nlpnycf2Gw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-xvq3fowSPHGTBGeMfoPkFw-1; Wed, 27 Mar 2024 22:22:28 -0400
X-MC-Unique: xvq3fowSPHGTBGeMfoPkFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41D5C8007A1;
	Thu, 28 Mar 2024 02:22:28 +0000 (UTC)
Received: from [10.22.33.225] (unknown [10.22.33.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E61431C060D0;
	Thu, 28 Mar 2024 02:22:27 +0000 (UTC)
Message-ID: <4487c1e6-7344-48d3-876f-9b55062b0417@redhat.com>
Date: Wed, 27 Mar 2024 22:22:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Use try_cmpxchg() in
 qspinlock_paravirt.h
Content-Language: en-US
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <20240325140943.815051-1-ubizjak@gmail.com>
 <20240325140943.815051-2-ubizjak@gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240325140943.815051-2-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


On 3/25/24 10:09, Uros Bizjak wrote:
> Use try_cmpxchg(*ptr, &old, new) instead of
> cmpxchg(*ptr, old, new) == old in qspinlock_paravirt.h
> x86 CMPXCHG instruction returns success in ZF flag, so
> this change saves a compare after cmpxchg.
>
> No functional change intended.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   kernel/locking/qspinlock_paravirt.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index 77ba80bd95f9..3db5f811260f 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -86,9 +86,10 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
>   	 */
>   	for (;;) {
>   		int val = atomic_read(&lock->val);
> +		u8 old = 0;
>   
>   		if (!(val & _Q_LOCKED_PENDING_MASK) &&
> -		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
> +		    try_cmpxchg_acquire(&lock->locked, &old, _Q_LOCKED_VAL)) {
>   			lockevent_inc(pv_lock_stealing);
>   			return true;
>   		}
> @@ -211,8 +212,9 @@ static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
>   	int hopcnt = 0;
>   
>   	for_each_hash_entry(he, offset, hash) {
> +		struct qspinlock *old = NULL;
>   		hopcnt++;
> -		if (!cmpxchg(&he->lock, NULL, lock)) {
> +		if (try_cmpxchg(&he->lock, &old, lock)) {
>   			WRITE_ONCE(he->node, node);
>   			lockevent_pv_hop(hopcnt);
>   			return &he->lock;
> @@ -355,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
>   static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
>   {
>   	struct pv_node *pn = (struct pv_node *)node;
> -
> +	enum vcpu_state old = vcpu_halted;
>   	/*
>   	 * If the vCPU is indeed halted, advance its state to match that of
>   	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
> @@ -372,8 +374,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
>   	 * subsequent writes.
>   	 */
>   	smp_mb__before_atomic();
> -	if (cmpxchg_relaxed(&pn->state, vcpu_halted, vcpu_hashed)
> -	    != vcpu_halted)
> +	if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashed))
>   		return;
>   
>   	/*
> @@ -541,15 +542,14 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
>   #ifndef __pv_queued_spin_unlock
>   __visible __lockfunc void __pv_queued_spin_unlock(struct qspinlock *lock)
>   {
> -	u8 locked;
> +	u8 locked = _Q_LOCKED_VAL;
>   
>   	/*
>   	 * We must not unlock if SLOW, because in that case we must first
>   	 * unhash. Otherwise it would be possible to have multiple @lock
>   	 * entries, which would be BAD.
>   	 */
> -	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
> -	if (likely(locked == _Q_LOCKED_VAL))
> +	if (try_cmpxchg_release(&lock->locked, &locked, 0);
>   		return;
>   
>   	__pv_queued_spin_unlock_slowpath(lock, locked);
Reviewed-by: Waiman Long <longman@redhat.com>


