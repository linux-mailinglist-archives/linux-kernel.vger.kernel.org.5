Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884F27CEED7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjJSEyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:54:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D4B9F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:54:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646F4C433C7;
        Thu, 19 Oct 2023 04:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697691281;
        bh=3lWzFUlU/97b/dHwAa2C06N+ewC9NXooDEcnsNFfjJo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GwbdbaWanBnKpKWHI+R6KDatN9lE/1ktRQZf8n7y6cfIiUf9sVuGcti1EQrRuuXQn
         arhNQyhIYyHxw2NgiKDTa6S8K8vac2V+qxrSlpBsCXArusAemLg+rS+FLKAi7fzdvj
         qZLb4Q9JodZBQWZbIuEtDokTW1Gptt6mpFk3xiEvLGsqs+3KGlwgz3ise84xdFoIxu
         dS/LYDeCDP19ZVJOH4NrzYA7Ybge4NUWMKthkK3VwQjFHMbsYa0/MfnZkxZMxgWYj2
         GU9vqyD7c41CEERak5SLGddt7gxtNFHEyWsm1Hb40coRt9cbydjXn/1S/xv/38A0VW
         QFoviAAZPdBDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E308FCE0F15; Wed, 18 Oct 2023 21:54:40 -0700 (PDT)
Date:   Wed, 18 Oct 2023 21:54:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] Fold smp_mb__before_atomic() into
 atomic_set_release()
Message-ID: <f6526ae6-cd52-4d1d-ab2a-7d82e2c818fd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ec86d38e-cfb4-44aa-8fdb-6c925922d93c@paulmck-laptop>
 <722b64d7-281b-b4ab-4d4d-403abc41a36b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <722b64d7-281b-b4ab-4d4d-403abc41a36b@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:07:07AM +0800, Hou Tao wrote:
> Hi Paul,
> 
> On 10/19/2023 6:28 AM, Paul E. McKenney wrote:
> > bpf: Fold smp_mb__before_atomic() into atomic_set_release()
> >
> > The bpf_user_ringbuf_drain() BPF_CALL function uses an atomic_set()
> > immediately preceded by smp_mb__before_atomic() so as to order storing
> > of ring-buffer consumer and producer positions prior to the atomic_set()
> > call's clearing of the ->busy flag, as follows:
> >
> >         smp_mb__before_atomic();
> >         atomic_set(&rb->busy, 0);
> >
> > Although this works given current architectures and implementations, and
> > given that this only needs to order prior writes against a later write.
> > However, it does so by accident because the smp_mb__before_atomic()
> > is only guaranteed to work with read-modify-write atomic operations,
> > and not at all with things like atomic_set() and atomic_read().
> >
> > Note especially that smp_mb__before_atomic() will not, repeat *not*,
> > order the prior write to "a" before the subsequent non-read-modify-write
> > atomic read from "b", even on strongly ordered systems such as x86:
> >
> >         WRITE_ONCE(a, 1);
> >         smp_mb__before_atomic();
> >         r1 = atomic_read(&b);
> 
> The reason is smp_mb__before_atomic() is defined as noop and
> atomic_read() in x86-64 is just READ_ONCE(), right ?

The real reason is that smp_mb__before_atomic() is not defined to do
anything unless followed by an atomic read-modify-write operation,
and atomic_read(), atomic_64read(), atomic_set(), and so on are not
read-modify-write operations.

As you point out, one implementation consequence of this is that
smp_mb__before_atomic() is nothingness on x86.

> And it seems that I also used smp_mb__before_atomic() in a wrong way for
> patch [1]. The memory order in the posted patch is
> 
> process X                                    process Y
>     atomic64_dec_and_test(&map->usercnt)
>     READ_ONCE(timer->timer)
>                                             timer->time = t

The above two lines are supposed to be accessing the same field, correct?
If so, process Y's store really should be WRITE_ONCE().

>                                             // it won't work
>                                             smp_mb__before_atomic()
>                                             atomic64_read(&map->usercnt)
> 
> For the problem, it seems I need to replace smp_mb__before_atomic() by
> smp_mb() to fix the memory order, right ?

Yes, because smp_mb() will order the prior store against that later load.

							Thanx, Paul

> Regards,
> Hou
> 
> [1]:
> https://lore.kernel.org/bpf/20231017125717.241101-2-houtao@huaweicloud.com/
>                                                                 
> 
> >
> > Therefore, replace the smp_mb__before_atomic() and atomic_set() with
> > atomic_set_release() as follows:
> >
> >         atomic_set_release(&rb->busy, 0);
> >
> > This is no slower (and sometimes is faster) than the original, and also
> > provides a formal guarantee of ordering that the original lacks.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Acked-by: David Vernet <void@manifault.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: <bpf@vger.kernel.org>
> >
> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index f045fde632e5..0ee653a936ea 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> > @@ -770,8 +770,7 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> >  	/* Prevent the clearing of the busy-bit from being reordered before the
> >  	 * storing of any rb consumer or producer positions.
> >  	 */
> > -	smp_mb__before_atomic();
> > -	atomic_set(&rb->busy, 0);
> > +	atomic_set_release(&rb->busy, 0);
> >  
> >  	if (flags & BPF_RB_FORCE_WAKEUP)
> >  		irq_work_queue(&rb->work);
> >
> > .
> 
