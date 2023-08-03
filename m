Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2080376F1F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjHCSka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHCSk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14AF2D49
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:40:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4014C61E5A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9592DC433C8;
        Thu,  3 Aug 2023 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691088027;
        bh=SlK3Ox+0ocdJwi3DN3CTapz5xzAtyIxIzcSd4bpqXOg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rhef91QCTzzwkOvo/b0d4FWvvVMuUF0Y2yw/lKo/0FQxrkjMNZ4HQLntHMgm8BbpJ
         bUs59qwHRz2EBUK2A+9EVngHwGSqFBjVK7Q1cwCx4p2sORfwVtRub8v5Pc3zI/tj9l
         K5rgU5kEE4oULCS67QalPVGKDyB+Mh+1rAeEd9pPRiGFopxAup+yXP284xYI5u8ox8
         iLG/ZT6Z4Z33OrhsPwz2zhYJxB7AzNFMeKxDIO+u/i0j4QPiiHr4YuWAkoh0rKgCq+
         S299bgtxldp4r51/qJ8t2RX1/iA+g9xD0IULjcV+om+olHfqqYHU0UZ/j+yPaxXXDI
         SSbr0uINCyyDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 274CBCE0AE0; Thu,  3 Aug 2023 11:40:27 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:40:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] rcu-tasks: make rcu_tasks_lazy_ms static
Message-ID: <d70f4a6b-4adf-446d-b29c-8ecb4b85d689@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230803080659.99071-1-jiapeng.chong@linux.alibaba.com>
 <CAEXW_YRQkovToQJA1FuPDtfVx0-z=Mp29KZC3irCSd7jDeA35w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRQkovToQJA1FuPDtfVx0-z=Mp29KZC3irCSd7jDeA35w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:11:41PM -0400, Joel Fernandes wrote:
> On Thu, Aug 3, 2023 at 4:07 AM Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com> wrote:
> >
> > The rcu_tasks_lazy_ms are not used outside the file tasks.h, so the
> > modification is defined as static.
> >
> > kernel/rcu/tasks.h:1085:5: warning: symbol 'rcu_tasks_lazy_ms' was not declared. Should it be static?
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6086
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued, thank you both!

							Thanx, Paul

>  - Joel
> 
> 
> > ---
> >  kernel/rcu/tasks.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 83049a893de5..ee1379671798 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1084,7 +1084,7 @@ void rcu_barrier_tasks(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
> >
> > -int rcu_tasks_lazy_ms = -1;
> > +static int rcu_tasks_lazy_ms = -1;
> >  module_param(rcu_tasks_lazy_ms, int, 0444);
> >
> >  static int __init rcu_spawn_tasks_kthread(void)
> > --
> > 2.20.1.7.g153144c
> >
