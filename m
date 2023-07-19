Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFFA7594AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGSLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGSLyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:54:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA9BFD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BOkPk68JD9JjPl7N6uzBVwTk++FD9eCsysl7q06PQSs=; b=TibC/C0FDUsGJLmUzLGDrwA+v5
        NNsZdJWuxsgE+iqEYp30C/p+IiOgAGzyi1opttSXrDaPhh8NFc+oHa/tAut0wFbqAby7ph4YNzk4l
        fyRfe7kKq/981JY5jcBHwksCZLbzUCjplIt/ZILOZ5yfzZjlOp7ofohcgoNGxIk2FCmmvJicCVEg6
        79JhK01sa+avi/nkphzFKslR/MZ4U7e55rC5ru07I1LO3LlasfaSVi6eP81GodOZOM/MZL5xVL3yt
        U5bNDCDA8SKfxoU8Z9he8OmjOCalBJYx++WxOw7M8q6XosxZVE3kD5vCz4yiLUzOoS7JYVLer4q5j
        vxcIX9+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qM5kn-00DWlB-2k;
        Wed, 19 Jul 2023 11:54:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 478B830049D;
        Wed, 19 Jul 2023 13:53:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED1B82137289A; Wed, 19 Jul 2023 13:53:58 +0200 (CEST)
Date:   Wed, 19 Jul 2023 13:53:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rppt@kernel.org
Subject: Re: [RFC PATCH 2/4] sched/fair: Make tg->load_avg per node
Message-ID: <20230719115358.GB3529734@hirez.programming.kicks-ass.net>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-3-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718134120.81199-3-aaron.lu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:41:18PM +0800, Aaron Lu wrote:
> +#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
> +static inline long tg_load_avg(struct task_group *tg)
> +{
> +	long load_avg = 0;
> +	int i;
> +
> +	/*
> +	 * The only path that can give us a root_task_group
> +	 * here is from print_cfs_rq() thus unlikely.
> +	 */
> +	if (unlikely(tg == &root_task_group))
> +		return 0;
> +
> +	for_each_node(i)
> +		load_avg += atomic_long_read(&tg->node_info[i]->load_avg);
> +
> +	return load_avg;
> +}
> +#endif

So I was working on something else numa and noticed that for_each_node()
(and most of the nodemask stuff) is quite moronic, afaict we should do
something like the below.

I now see Mike added the nr_node_ids thing fairly recent, but given
distros have NODES_SHIFT=10 and actual machines typically only have <=4
nodes, this would save a factor of 256 scanning.

Specifically, your for_each_node() would scan the full 1024 bit bitmap
looking for more bits that would never be there.

---

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 8d07116caaf1..c23c0889b8cf 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -109,7 +109,7 @@ extern nodemask_t _unused_nodemask_arg_;
 				__nodemask_pr_bits(maskp)
 static inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
 {
-	return m ? MAX_NUMNODES : 0;
+	return m ? nr_node_ids : 0;
 }
 static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
 {
@@ -137,13 +137,13 @@ static inline void __node_clear(int node, volatile nodemask_t *dstp)
 	clear_bit(node, dstp->bits);
 }
 
-#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
+#define nodes_setall(dst) __nodes_setall(&(dst), nr_node_ids)
 static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
 {
 	bitmap_fill(dstp->bits, nbits);
 }
 
-#define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
+#define nodes_clear(dst) __nodes_clear(&(dst), nr_node_ids)
 static inline void __nodes_clear(nodemask_t *dstp, unsigned int nbits)
 {
 	bitmap_zero(dstp->bits, nbits);
@@ -160,7 +160,7 @@ static inline bool __node_test_and_set(int node, nodemask_t *addr)
 }
 
 #define nodes_and(dst, src1, src2) \
-			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
+			__nodes_and(&(dst), &(src1), &(src2), nr_node_ids)
 static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -168,7 +168,7 @@ static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
 }
 
 #define nodes_or(dst, src1, src2) \
-			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
+			__nodes_or(&(dst), &(src1), &(src2), nr_node_ids)
 static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -176,7 +176,7 @@ static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
 }
 
 #define nodes_xor(dst, src1, src2) \
-			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
+			__nodes_xor(&(dst), &(src1), &(src2), nr_node_ids)
 static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -184,7 +184,7 @@ static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
 }
 
 #define nodes_andnot(dst, src1, src2) \
-			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
+			__nodes_andnot(&(dst), &(src1), &(src2), nr_node_ids)
 static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -192,7 +192,7 @@ static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
 }
 
 #define nodes_complement(dst, src) \
-			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
+			__nodes_complement(&(dst), &(src), nr_node_ids)
 static inline void __nodes_complement(nodemask_t *dstp,
 					const nodemask_t *srcp, unsigned int nbits)
 {
@@ -200,7 +200,7 @@ static inline void __nodes_complement(nodemask_t *dstp,
 }
 
 #define nodes_equal(src1, src2) \
-			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
+			__nodes_equal(&(src1), &(src2), nr_node_ids)
 static inline bool __nodes_equal(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -208,7 +208,7 @@ static inline bool __nodes_equal(const nodemask_t *src1p,
 }
 
 #define nodes_intersects(src1, src2) \
-			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
+			__nodes_intersects(&(src1), &(src2), nr_node_ids)
 static inline bool __nodes_intersects(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
@@ -216,33 +216,33 @@ static inline bool __nodes_intersects(const nodemask_t *src1p,
 }
 
 #define nodes_subset(src1, src2) \
-			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
+			__nodes_subset(&(src1), &(src2), nr_node_ids)
 static inline bool __nodes_subset(const nodemask_t *src1p,
 					const nodemask_t *src2p, unsigned int nbits)
 {
 	return bitmap_subset(src1p->bits, src2p->bits, nbits);
 }
 
-#define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
+#define nodes_empty(src) __nodes_empty(&(src), nr_node_ids)
 static inline bool __nodes_empty(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_empty(srcp->bits, nbits);
 }
 
-#define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
+#define nodes_full(nodemask) __nodes_full(&(nodemask), nr_node_ids)
 static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_full(srcp->bits, nbits);
 }
 
-#define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
+#define nodes_weight(nodemask) __nodes_weight(&(nodemask), nr_node_ids)
 static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
 {
 	return bitmap_weight(srcp->bits, nbits);
 }
 
 #define nodes_shift_right(dst, src, n) \
-			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
+			__nodes_shift_right(&(dst), &(src), (n), nr_node_ids)
 static inline void __nodes_shift_right(nodemask_t *dstp,
 					const nodemask_t *srcp, int n, int nbits)
 {
@@ -250,7 +250,7 @@ static inline void __nodes_shift_right(nodemask_t *dstp,
 }
 
 #define nodes_shift_left(dst, src, n) \
-			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
+			__nodes_shift_left(&(dst), &(src), (n), nr_node_ids)
 static inline void __nodes_shift_left(nodemask_t *dstp,
 					const nodemask_t *srcp, int n, int nbits)
 {
@@ -385,7 +385,7 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 #if MAX_NUMNODES > 1
 #define for_each_node_mask(node, mask)				    \
 	for ((node) = first_node(mask);				    \
-	     (node) < MAX_NUMNODES;				    \
+	     (node) < nr_node_ids;				    \
 	     (node) = next_node((node), (mask)))
 #else /* MAX_NUMNODES == 1 */
 #define for_each_node_mask(node, mask)                                  \
