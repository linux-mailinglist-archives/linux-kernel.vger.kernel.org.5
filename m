Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0197F1109
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjKTK5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjKTK4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:56:46 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEDAF4;
        Mon, 20 Nov 2023 02:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PErohMmpIxRK4QMw8WDDj/1lAS30uf8VYTViuVX+yvU=; b=gyci+U9vXHgasjfs8HQnCINXBZ
        ZDoZmXXpDs6km4JJ5GN+f2afjIVMNZlLYWIwBzNxuGhb1MFSjy19O4mMHk/uvdJaEPtagLjaXXYgx
        iZ7DLa036MxGvEZDJS9uWkcaHd6+7S63p3QiD9oaTbE9OcTSjV79jjlg1psAyFzhq1QhbCG/Zw3HM
        gyTjvkHjWqaRZEmmxZNdjqk/jJEoNmxfgLf4M2jpNJb/+uEcoL/xg7TF+J88ZQzjvkJ2UImzMQFT7
        9PJDvI7bQ4VCxmD03RT33OOYV4hvpOfE7P0mfQ0xwHVo9G3GhfzPi0OQRq04zfO6h5t/RNbu3eRgE
        333t+i2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r51wm-00AvJl-1N;
        Mon, 20 Nov 2023 10:56:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B814F300419; Mon, 20 Nov 2023 11:56:06 +0100 (CET)
Date:   Mon, 20 Nov 2023 11:56:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Tobias Huschle <huschle@linux.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com
Subject: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair:
 Add lag based placement)
Message-ID: <20231120105606.GQ8262@noisy.programming.kicks-ass.net>
References: <c7b38bc27cc2c480f0c5383366416455@linux.ibm.com>
 <20231117092318.GJ8262@noisy.programming.kicks-ass.net>
 <2c7509e3-6db0-461e-991b-026553157dbe@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7509e3-6db0-461e-991b-026553157dbe@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 01:14:32PM +0800, Abel Wu wrote:

> Hi Peter, I'm a little confused here. As we adopt placement strategy #1
> when PLACE_LAG is enabled, the lag of that entity needs to be preserved.
> Given that the weight doesn't change, we have:
> 
> 	vl' = vl
> 
> But in fact it is scaled on placement:
> 
> 	vl' = vl * W/(W + w)

(W+w)/W

> 
> Does this intended? 

The scaling, yes that's intended and the comment explains why. So now
you have me confused too :-)

Specifically, I want the lag after placement to be equal to the lag we
come in with. Since placement will affect avg_vruntime (adding one
element to the average changes the average etc..) the placement also
affects the lag as measured after placement.

Or rather, if you enqueue and dequeue, I want the lag to be preserved.
If you do not take placement into consideration, lag will dissipate real
quick.

> And to illustrate my understanding of strategy #1:

> @@ -5162,41 +5165,17 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		 * vl_i is given by:
>  		 *
>  		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
> -		 *      = (W*V + w_i*(V - vl_i)) / (W + w_i)
> -		 *      = (W*V + w_i*V - w_i*vl_i) / (W + w_i)
> -		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
> -		 *      = V - w_i*vl_i / (W + w_i)
> -		 *
> -		 * And the actual lag after adding an entity with vl_i is:
> -		 *
> -		 *   vl'_i = V' - v_i
> -		 *         = V - w_i*vl_i / (W + w_i) - (V - vl_i)
> -		 *         = vl_i - w_i*vl_i / (W + w_i)
> -		 *
> -		 * Which is strictly less than vl_i. So in order to preserve lag
> -		 * we should inflate the lag before placement such that the
> -		 * effective lag after placement comes out right.
> -		 *
> -		 * As such, invert the above relation for vl'_i to get the vl_i
> -		 * we need to use such that the lag after placement is the lag
> -		 * we computed before dequeue.
> +		 *      = (W*V + w_i*(V' - vl_i)) / (W + w_i)
> +		 *      = V - w_i*vl_i / W
>  		 *
> -		 *   vl'_i = vl_i - w_i*vl_i / (W + w_i)
> -		 *         = ((W + w_i)*vl_i - w_i*vl_i) / (W + w_i)
> -		 *
> -		 *   (W + w_i)*vl'_i = (W + w_i)*vl_i - w_i*vl_i
> -		 *                   = W*vl_i
> -		 *
> -		 *   vl_i = (W + w_i)*vl'_i / W
>  		 */
>  		load = cfs_rq->avg_load;
>  		if (curr && curr->on_rq)
>  			load += scale_load_down(curr->load.weight);
> -
> -		lag *= load + scale_load_down(se->load.weight);
>  		if (WARN_ON_ONCE(!load))
>  			load = 1;
> -		lag = div_s64(lag, load);
> +
> +		vruntime -= div_s64(lag * scale_load_down(se->load.weight), load);
>  	}
>  	se->vruntime = vruntime - lag;


So you're proposing we do:

	v = V - (lag * w) / (W + w) - lag

?

That can be written like:

	v = V - (lag * w) / (W+w) - (lag * (W+w)) / (W+w)
	  = V - (lag * (W+w) + lag * w) / (W+w)
	  = V - (lag * (W+2w)) / (W+w)

And that turns into a mess AFAICT.


Let me repeat my earlier argument. Suppose v,w,l are the new element.
V,W are the old avg_vruntime and sum-weight.

Then: V = V*W / W, and by extention: V' = (V*W + v*w) / (W + w).

The new lag, after placement: 

l' = V' - v = (V*W + v*w) / (W+w) - v
            = (V*W + v*w) / (W+w) - v * (W+w) / (W+v)
	    = (V*W + v*w -v*W - v*w) / (W+w)
	    = (V*W - v*W) / (W+w)
	    = W*(V-v) / (W+w)
	    = W/(W+w) * (V-v)

Substitute: v = V - (W+w)/W * l, my scaling thing, to obtain:

l' = W/(W+w) * (V - (V - (W+w)/W * l))
   = W/(W+w) * (V - V + (W+w)/W * l)
   = W/(W+w) * (W+w)/W * l
   = l

So by scaling, we've preserved lag across placement.

That make sense?
