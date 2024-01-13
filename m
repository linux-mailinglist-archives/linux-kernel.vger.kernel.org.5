Return-Path: <linux-kernel+bounces-25143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE47182C86F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF00A1C22D80
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45656F4FB;
	Sat, 13 Jan 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seVOur25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8AA28;
	Sat, 13 Jan 2024 00:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC59FC43390;
	Sat, 13 Jan 2024 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705106297;
	bh=/eeFF6/JtaBBkHTd6iYnBzPQb/6NBh8oA+UF/0yDTRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seVOur25lNIR/X3Cq31wwPlG6ywe+zK8wg4yPuMaL1cTEZXUcbnd+tqbqLEol7Wxp
	 E3GLCl08xmNZu3iJ3CnGJP73ya57Nb90ZEj5wQ4gPX0ojmV9p7KIDNhBkUaC7KYkik
	 2923k8sJTcCmqm+lN7VqdrGVqDqHMvJNzYeDNVovP2Gv8H2e6/oeNPlzakAXuUY+Pn
	 LBZpEhaGsee4aWqzYtaFSrWyAacKMM7bmrnYd5BzANsQ1+X5fepEGWkcbXMze+kF2B
	 3WyYGZ4EfnsUn34tA4LlH2190cdAF5qElUsR+fKvuy975c5FHH6vgUE6cAR7u8wj13
	 CITxHtTBcPqbQ==
Date: Fri, 12 Jan 2024 16:38:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 1/3] locking: Add rwsem_assert_held() and
 rwsem_assert_held_write()
Message-ID: <20240113003816.GB722975@frogsfrogsfrogs>
References: <20240111212424.3572189-1-willy@infradead.org>
 <20240111212424.3572189-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111212424.3572189-2-willy@infradead.org>

On Thu, Jan 11, 2024 at 09:24:22PM +0000, Matthew Wilcox (Oracle) wrote:
> Modelled after lockdep_assert_held() and lockdep_assert_held_write(),
> but are always active, even when lockdep is disabled.  Of course, they
> don't test that _this_ thread is the owner, but it's sufficient to catch
> many bugs and doesn't incur the same performance penalty as lockdep.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Looks good to me, having read this patchset backwards.
Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/rwbase_rt.h |  9 ++++++--
>  include/linux/rwsem.h     | 46 ++++++++++++++++++++++++++++++++++-----
>  2 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> index 1d264dd08625..29c4e4f243e4 100644
> --- a/include/linux/rwbase_rt.h
> +++ b/include/linux/rwbase_rt.h
> @@ -26,12 +26,17 @@ struct rwbase_rt {
>  	} while (0)
>  
>  
> -static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
> +static __always_inline bool rw_base_is_locked(const struct rwbase_rt *rwb)
>  {
>  	return atomic_read(&rwb->readers) != READER_BIAS;
>  }
>  
> -static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
> +static inline void rw_base_assert_held_write(const struct rwbase_rt *rwb)
> +{
> +	WARN_ON(atomic_read(&rwb->readers) != WRITER_BIAS);
> +}
> +
> +static __always_inline bool rw_base_is_contended(const struct rwbase_rt *rwb)
>  {
>  	return atomic_read(&rwb->readers) > 0;
>  }
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 9c29689ff505..4f1c18992f76 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -66,14 +66,24 @@ struct rw_semaphore {
>  #endif
>  };
>  
> -/* In all implementations count != 0 means locked */
> +#define RWSEM_UNLOCKED_VALUE		0UL
> +#define RWSEM_WRITER_LOCKED		(1UL << 0)
> +#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
> +
>  static inline int rwsem_is_locked(struct rw_semaphore *sem)
>  {
> -	return atomic_long_read(&sem->count) != 0;
> +	return atomic_long_read(&sem->count) != RWSEM_UNLOCKED_VALUE;
>  }
>  
> -#define RWSEM_UNLOCKED_VALUE		0L
> -#define __RWSEM_COUNT_INIT(name)	.count = ATOMIC_LONG_INIT(RWSEM_UNLOCKED_VALUE)
> +static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
> +{
> +	WARN_ON(atomic_long_read(&sem->count) == RWSEM_UNLOCKED_VALUE);
> +}
> +
> +static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> +{
> +	WARN_ON(!(atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED));
> +}
>  
>  /* Common initializer macros and functions */
>  
> @@ -152,11 +162,21 @@ do {								\
>  	__init_rwsem((sem), #sem, &__key);			\
>  } while (0)
>  
> -static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
> +static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
>  {
>  	return rw_base_is_locked(&sem->rwbase);
>  }
>  
> +static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
> +{
> +	WARN_ON(!rwsem_is_locked(sem));
> +}
> +
> +static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> +{
> +	rw_base_assert_held_write(sem);
> +}
> +
>  static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
>  {
>  	return rw_base_is_contended(&sem->rwbase);
> @@ -169,6 +189,22 @@ static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
>   * the RT specific variant.
>   */
>  
> +static inline void rwsem_assert_held(const struct rw_semaphore *sem)
> +{
> +	if (IS_ENABLED(CONFIG_LOCKDEP))
> +		lockdep_assert_held(sem);
> +	else
> +		rwsem_assert_held_nolockdep(sem);
> +}
> +
> +static inline void rwsem_assert_held_write(const struct rw_semaphore *sem)
> +{
> +	if (IS_ENABLED(CONFIG_LOCKDEP))
> +		lockdep_assert_held_write(sem);
> +	else
> +		rwsem_assert_held_write_nolockdep(sem);
> +}
> +
>  /*
>   * lock for reading
>   */
> -- 
> 2.43.0
> 
> 

