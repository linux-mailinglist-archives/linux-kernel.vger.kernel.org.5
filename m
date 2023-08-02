Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1827676D202
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjHBPdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjHBPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D43C6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E725D619F7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DB8C433C7;
        Wed,  2 Aug 2023 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690990416;
        bh=Ez5+2vJiHKIAGFjOyiWARiCilKqtd3RW9Vc2MHXyn+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NosK2U+UNwpW1zYvI//1Fr5FKqQFFec+Fc6C8y8WAnVebOKrZsFu7p7qIroiy9CKD
         w2T4JCPRMtcbA7yVfHO0T8c3SthX9JJkSnJno9VRxVlrvAOdcF5zSdPVUG2cyestBy
         GPHHXY7DIg0AeVZ74iYBD7Ugf6hBD3yxIYqMncxmQPHIYwkg/UrU+Kc2kKsqfzmGjE
         1DkHAszD2xBxh8ozgjUkab/pgU2jv+SwtKd7T69tE7545dMC/A/RdAzH9vFCQPvh4q
         QXROMyOgIAFoxdKZGCKHGu8h+vuajaYSm9UwaDqgCs6nUDficYY3095IftACsdCx5h
         OaB3AIJcCuOUA==
Date:   Wed, 2 Aug 2023 18:32:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de
Subject: Re: [PATCH 2/2] mm,nodemask: Use nr_node_ids
Message-ID: <20230802153251.GF2607694@kernel.org>
References: <20230802112458.230221601@infradead.org>
 <20230802112525.633758009@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802112525.633758009@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 01:25:00PM +0200, Peter Zijlstra wrote:
> Just like how cpumask uses nr_cpu_ids to limit the bitmap scanning,
> make nodemask use nr_node_ids.
> 
> Since current users expect MAX_NUMNODES as the end-of-bitmap marker,
> retain this behaviour for now.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Some nits in comments, otherwise 

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/nodemask.h |  121 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 89 insertions(+), 32 deletions(-)
> 
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -99,6 +99,48 @@
>  typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
>  extern nodemask_t _unused_nodemask_arg_;
>  
> +#if MAX_NUMNODES > 1
> +extern unsigned int nr_node_ids;
> +#else
> +#define nr_node_ids		1U
> +#endif
> +
> +/*
> + * We have several different "preferred sizes" for the nodemask
> + * operations, depending on operation.
> + *
> + * For example, the bitmap scanning and operating operations have
> + * optimized routines that work for the single-word case, but only when
> + * the size is constant. So if NR_CPUS fits in one single word, we are

                                ^ MAX_NUMNODES?

> + * better off using that small constant, in order to trigger the
> + * optimized bit finding. That is 'small_nodemask_size'.
> + *
> + * The clearing and copying operations will similarly perform better
> + * with a constant size, but we limit that size arbitrarily to four
> + * words. We call this 'large_nodemask_size'.
> + *
> + * Finally, some operations just want the exact limit, either because
> + * they set bits or just don't have any faster fixed-sized versions. We
> + * call this just 'nr_nodemask_bits'.
> + *
> + * Note that these optional constants are always guaranteed to be at
> + * least as big as 'nr_node_ids' itself is, and all our nodemask
> + * allocations are at least that size (see nodemask_size()). The

We don't have nodemask_size(). NODEMASK_ALLOC() actually allocates memory
only when NODE_SHIFT > 8 and it always uses the static size.

> + * optimization comes from being able to potentially use a compile-time
> + * constant instead of a run-time generated exact number of CPUs.

                                                              ^ nodes?
> + */
> +#if MAX_NUMNODES <= BITS_PER_LONG
> +  #define small_nodemask_bits ((unsigned int)MAX_NUMNODES)
> +  #define large_nodemask_bits ((unsigned int)MAX_NUMNODES)
> +#elif MAX_NUMNODES <= 4*BITS_PER_LONG
> +  #define small_nodemask_bits nr_node_ids
> +  #define large_nodemask_bits ((unsigned int)MAX_NUMNODES)
> +#else
> +  #define small_nodemask_bits nr_node_ids
> +  #define large_nodemask_bits nr_node_ids
> +#endif
> +#define nr_nodemask_bits nr_node_ids
> +
>  /**
>   * nodemask_pr_args - printf args to output a nodemask
>   * @maskp: nodemask to be printed
> @@ -109,7 +151,7 @@ extern nodemask_t _unused_nodemask_arg_;
>  				__nodemask_pr_bits(maskp)
>  static inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
>  {
> -	return m ? MAX_NUMNODES : 0;
> +	return m ? nr_nodemask_bits : 0;
>  }
>  static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
>  {
> @@ -137,13 +179,13 @@ static inline void __node_clear(int node
>  	clear_bit(node, dstp->bits);
>  }
>  
> -#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
> +#define nodes_setall(dst) __nodes_setall(&(dst), large_nodemask_bits)
>  static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
>  {
>  	bitmap_fill(dstp->bits, nbits);
>  }
>  
> -#define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
> +#define nodes_clear(dst) __nodes_clear(&(dst), large_nodemask_bits)
>  static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
>  {
>  	bitmap_zero(dstp->bits, nbits);
> @@ -160,7 +202,7 @@ static inline bool __node_test_and_set(i
>  }
>  
>  #define nodes_and(dst, src1, src2) \
> -			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
> +			__nodes_and(&(dst), &(src1), &(src2), small_nodemask_bits)
>  static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -168,7 +210,7 @@ static inline void __nodes_and(nodemask_
>  }
>  
>  #define nodes_or(dst, src1, src2) \
> -			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
> +			__nodes_or(&(dst), &(src1), &(src2), small_nodemask_bits)
>  static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -176,7 +218,7 @@ static inline void __nodes_or(nodemask_t
>  }
>  
>  #define nodes_xor(dst, src1, src2) \
> -			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
> +			__nodes_xor(&(dst), &(src1), &(src2), small_nodemask_bits)
>  static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -184,7 +226,7 @@ static inline void __nodes_xor(nodemask_
>  }
>  
>  #define nodes_andnot(dst, src1, src2) \
> -			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
> +			__nodes_andnot(&(dst), &(src1), &(src2), small_nodemask_bits)
>  static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -192,7 +234,7 @@ static inline void __nodes_andnot(nodema
>  }
>  
>  #define nodes_complement(dst, src) \
> -			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
> +			__nodes_complement(&(dst), &(src), small_nodemask_bits)
>  static inline void __nodes_complement(nodemask_t *dstp,
>  					const nodemask_t *srcp, unsigned int nbits)
>  {
> @@ -200,7 +242,7 @@ static inline void __nodes_complement(no
>  }
>  
>  #define nodes_equal(src1, src2) \
> -			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
> +			__nodes_equal(&(src1), &(src2), small_nodemask_bits)
>  static inline bool __nodes_equal(const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -208,7 +250,7 @@ static inline bool __nodes_equal(const n
>  }
>  
>  #define nodes_intersects(src1, src2) \
> -			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
> +			__nodes_intersects(&(src1), &(src2), small_nodemask_bits)
>  static inline bool __nodes_intersects(const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
> @@ -216,33 +258,33 @@ static inline bool __nodes_intersects(co
>  }
>  
>  #define nodes_subset(src1, src2) \
> -			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
> +			__nodes_subset(&(src1), &(src2), small_nodemask_bits)
>  static inline bool __nodes_subset(const nodemask_t *src1p,
>  					const nodemask_t *src2p, unsigned int nbits)
>  {
>  	return bitmap_subset(src1p->bits, src2p->bits, nbits);
>  }
>  
> -#define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
> +#define nodes_empty(src) __nodes_empty(&(src), small_nodemask_bits)
>  static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
>  {
>  	return bitmap_empty(srcp->bits, nbits);
>  }
>  
> -#define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
> +#define nodes_full(nodemask) __nodes_full(&(nodemask), small_nodemask_bits)
>  static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
>  {
>  	return bitmap_full(srcp->bits, nbits);
>  }
>  
> -#define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
> +#define nodes_weight(nodemask) __nodes_weight(&(nodemask), small_nodemask_bits)
>  static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
>  {
>  	return bitmap_weight(srcp->bits, nbits);
>  }
>  
>  #define nodes_shift_right(dst, src, n) \
> -			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
> +			__nodes_shift_right(&(dst), &(src), (n), small_nodemask_bits)
>  static inline void __nodes_shift_right(nodemask_t *dstp,
>  					const nodemask_t *srcp, int n, int nbits)
>  {
> @@ -250,26 +292,38 @@ static inline void __nodes_shift_right(n
>  }
>  
>  #define nodes_shift_left(dst, src, n) \
> -			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
> +			__nodes_shift_left(&(dst), &(src), (n), small_nodemask_bits)
>  static inline void __nodes_shift_left(nodemask_t *dstp,
>  					const nodemask_t *srcp, int n, int nbits)
>  {
>  	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
>  }
>  
> -/* FIXME: better would be to fix all architectures to never return
> -          > MAX_NUMNODES, then the silly min_ts could be dropped. */
> +/*
> + * FIXME: audit tree to move end-of-nodemask to >= nr_nodemask_bits;
> + *        for now, map it to >= MAX_NUMNODES.
> + */
>  
>  #define first_node(src) __first_node(&(src))
>  static inline unsigned int __first_node(const nodemask_t *srcp)
>  {
> -	return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
> +	unsigned int bit = find_first_bit(srcp->bits, small_nodemask_bits);
> +
> +	if (bit >= nr_nodemask_bits)
> +		bit = MAX_NUMNODES;
> +
> +	return bit;
>  }
>  
>  #define next_node(n, src) __next_node((n), &(src))
>  static inline unsigned int __next_node(int n, const nodemask_t *srcp)
>  {
> -	return min_t(unsigned int, MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
> +	unsigned int bit = find_next_bit(srcp->bits, small_nodemask_bits, n+1);
> +
> +	if (bit >= nr_nodemask_bits)
> +		bit = MAX_NUMNODES;
> +
> +	return bit;
>  }
>  
>  /*
> @@ -283,6 +337,7 @@ static inline unsigned int __next_node_i
>  
>  	if (ret == MAX_NUMNODES)
>  		ret = __first_node(srcp);
> +
>  	return ret;
>  }
>  
> @@ -306,8 +361,12 @@ static inline void init_nodemask_of_node
>  #define first_unset_node(mask) __first_unset_node(&(mask))
>  static inline unsigned int __first_unset_node(const nodemask_t *maskp)
>  {
> -	return min_t(unsigned int, MAX_NUMNODES,
> -			find_first_zero_bit(maskp->bits, MAX_NUMNODES));
> +	unsigned int bit = find_first_zero_bit(maskp->bits, small_nodemask_bits);
> +
> +	if (bit >= nr_nodemask_bits)
> +		bit = MAX_NUMNODES;
> +
> +	return bit;
>  }
>  
>  #define NODE_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(MAX_NUMNODES)
> @@ -337,21 +396,21 @@ static inline unsigned int __first_unset
>  #define nodes_addr(src) ((src).bits)
>  
>  #define nodemask_parse_user(ubuf, ulen, dst) \
> -		__nodemask_parse_user((ubuf), (ulen), &(dst), MAX_NUMNODES)
> +		__nodemask_parse_user((ubuf), (ulen), &(dst), nr_nodemask_bits)
>  static inline int __nodemask_parse_user(const char __user *buf, int len,
>  					nodemask_t *dstp, int nbits)
>  {
>  	return bitmap_parse_user(buf, len, dstp->bits, nbits);
>  }
>  
> -#define nodelist_parse(buf, dst) __nodelist_parse((buf), &(dst), MAX_NUMNODES)
> +#define nodelist_parse(buf, dst) __nodelist_parse((buf), &(dst), nr_nodemask_bits)
>  static inline int __nodelist_parse(const char *buf, nodemask_t *dstp, int nbits)
>  {
>  	return bitmap_parselist(buf, dstp->bits, nbits);
>  }
>  
>  #define node_remap(oldbit, old, new) \
> -		__node_remap((oldbit), &(old), &(new), MAX_NUMNODES)
> +		__node_remap((oldbit), &(old), &(new), nr_nodemask_bits)
>  static inline int __node_remap(int oldbit,
>  		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
>  {
> @@ -359,7 +418,7 @@ static inline int __node_remap(int oldbi
>  }
>  
>  #define nodes_remap(dst, src, old, new) \
> -		__nodes_remap(&(dst), &(src), &(old), &(new), MAX_NUMNODES)
> +		__nodes_remap(&(dst), &(src), &(old), &(new), nr_nodemask_bits)
>  static inline void __nodes_remap(nodemask_t *dstp, const nodemask_t *srcp,
>  		const nodemask_t *oldp, const nodemask_t *newp, int nbits)
>  {
> @@ -367,7 +426,7 @@ static inline void __nodes_remap(nodemas
>  }
>  
>  #define nodes_onto(dst, orig, relmap) \
> -		__nodes_onto(&(dst), &(orig), &(relmap), MAX_NUMNODES)
> +		__nodes_onto(&(dst), &(orig), &(relmap), nr_nodemask_bits)
>  static inline void __nodes_onto(nodemask_t *dstp, const nodemask_t *origp,
>  		const nodemask_t *relmapp, int nbits)
>  {
> @@ -375,7 +434,7 @@ static inline void __nodes_onto(nodemask
>  }
>  
>  #define nodes_fold(dst, orig, sz) \
> -		__nodes_fold(&(dst), &(orig), sz, MAX_NUMNODES)
> +		__nodes_fold(&(dst), &(orig), sz, nr_nodemask_bits)
>  static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
>  		int sz, int nbits)
>  {
> @@ -385,7 +444,7 @@ static inline void __nodes_fold(nodemask
>  #if MAX_NUMNODES > 1
>  #define for_each_node_mask(node, mask)				    \
>  	for ((node) = first_node(mask);				    \
> -	     (node) < MAX_NUMNODES;				    \
> +	     (node) < nr_nodemask_bits;				    \
>  	     (node) = next_node((node), (mask)))
>  #else /* MAX_NUMNODES == 1 */
>  #define for_each_node_mask(node, mask)                                  \
> @@ -452,7 +511,6 @@ static inline unsigned int next_memory_n
>  	return next_node(nid, node_states[N_MEMORY]);
>  }
>  
> -extern unsigned int nr_node_ids;
>  extern unsigned int nr_online_nodes;
>  
>  static inline void node_set_online(int nid)
> @@ -494,7 +552,6 @@ static inline int num_node_state(enum no
>  #define first_memory_node	0
>  #define next_online_node(nid)	(MAX_NUMNODES)
>  #define next_memory_node(nid)	(MAX_NUMNODES)
> -#define nr_node_ids		1U
>  #define nr_online_nodes		1U
>  
>  #define node_set_online(node)	   node_set_state((node), N_ONLINE)
> @@ -516,7 +573,7 @@ static inline int node_random(const node
>  		bit = first_node(*maskp);
>  		break;
>  	default:
> -		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_u32_below(w));
> +		bit = find_nth_bit(maskp->bits, nr_node_ids, get_random_u32_below(w));
>  		break;
>  	}
>  	return bit;
> 
> 

-- 
Sincerely yours,
Mike.
