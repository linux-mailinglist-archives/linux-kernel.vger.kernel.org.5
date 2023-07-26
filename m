Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58FD7631F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjGZJ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjGZJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58E1BCB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4618619FE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E44C433C7;
        Wed, 26 Jul 2023 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690363529;
        bh=Otb0UO4N2L3Nr420yv7K4T9+NTLm69axQu3jhJaqCBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYZ57mN9KKjJtDDq0TzyvIMzYxxERyIv6IhGPmHaQGlXGiFeq9HjQW5+HZGX5jpAT
         rnhz/GnJc8JkCWZW7u1vnuvPsvJ6BAz3rXMjsg9FdvM8s7lc1p+KALRkJgfnH5a//7
         oQDqofmKYGGrHfx0MacthUdTRB01C1/Cd8AQpkHTsu7zVKoBz9RcQnSRvFhJjQCAN2
         YPH7p5sCSQsSUlWmUzKHC65NhFmboHEcUhZnviV2qf7WHuIlyt7pZ9np4IHkZArBOH
         mSklt/C09HvcEnCRZHW8BywsAVYRH1i2OVpuXCbIe1qje+OdjICFD4CTzEwvpGAOMZ
         zKK4PBDtyI7pA==
Date:   Wed, 26 Jul 2023 11:25:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, jack@suse.cz,
        keescook@chromium.org, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Subject: Re: [PATCH] pid: Add the judgment of whether ns is NULL in the
 find_pid_ns
Message-ID: <20230726-tierisch-soweit-7bcefe6957dc@brauner>
References: <20230713071713.5762-1-xuewen.yan@unisoc.com>
 <20230725-hemmschwelle-braten-481527898001@brauner>
 <CAB8ipk9CXWmUg13gEHDECXf3DDUvbYyA0y2yFXUuGsAjMSXv8w@mail.gmail.com>
 <20230725-gespeichert-auffuhr-00ed9e57ec7f@brauner>
 <CAB8ipk_AhvZxoa410F8s=SfLsqCNp+rRi6YgFzdLO7wh+N4KMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk_AhvZxoa410F8s=SfLsqCNp+rRi6YgFzdLO7wh+N4KMA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:23:13AM +0800, Xuewen Yan wrote:
> On Tue, Jul 25, 2023 at 8:47 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 08:24:18PM +0800, Xuewen Yan wrote:
> > > On Tue, Jul 25, 2023 at 4:49 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Thu, Jul 13, 2023 at 03:17:13PM +0800, Xuewen Yan wrote:
> > > > > There is no the judgment of whether namspace is NULL in find_pid_ns.
> > > > > But there is a corner case when ns is null, for example: if user
> > > > > call find_get_pid when current is in exiting, the following stack would
> > > > > set thread_id be null:
> > > > > release_task
> > > > >     __exit_signal(p);
> > > > >         __unhash_process(tsk, group_dead);
> > > > >               detach_pid(p, PIDTYPE_PID);
> > > > >                   __change_pid(task, type, NULL);
> > > > >
> > > > > If user call find_get_pid at now, in find_vpid function, the
> > > >
> > > > I fail to see how this can happen. The code you're referencing is in
> > > > release_task(). If current has gone through that then current obviously
> > > > can't call find_vpid() on itself anymore or anything else for that
> > > > matter.
> > >
> > > This happened when user calls  find_vpid() in irq.
> > >
> > > [72117.635162] Call trace:
> > > [72117.635595]  idr_find+0xc/0x24
> > > [72117.636103]  find_get_pid+0x40/0x68
> > > [72117.636812]  send_event+0x88/0x180 [demux]
> > > [72117.637593]  vbvop_copy_data+0x150/0x344 [demux]
> > > [72117.638434]  dmisr_video_parsing_mpeg12+0x29c/0x42c [demux]
> > > [72117.639393]  dmisr_video_parsing_switch+0x68/0xec [demux]
> > > [72117.640332]  dmisr_handle_video_pes+0x10c/0x26c [demux]
> > > [72117.641108]  tasklet_action_common+0x130/0x224
> > > [72117.641784]  tasklet_action+0x28/0x34
> > > [72117.642366]  __do_softirq+0x128/0x4dc
> > > [72117.642944]  irq_exit+0xf8/0xfc
> > > [72117.643459]  __handle_domain_irq+0xb0/0x108
> > > [72117.644102]  gic_handle_irq+0x6c/0x124
> > > [72117.644691]  el1_irq+0x108/0x200
> > > [72117.645217]  _raw_write_unlock_irq+0x2c/0x5c
> > > [72117.645870]  release_task+0x144/0x1ac   <<<<<<
> > > [72117.646447]  do_exit+0x524/0x94c
> > > [72117.646970]  __do_sys_exit_group+0x0/0x14
> > > [72117.647591]  do_group_exit+0x0/0xa0
> > > [72117.648146]  __se_sys_exit+0x0/0x20
> > > [72117.648704]  el0_svc_common+0xcc/0x1bc
> > > [72117.649292]  el0_svc_handler+0x2c/0x3c
> > > [72117.649881]  el0_svc+0x8/0xc
> > >
> > > In release_task, write_unlock_irq(&tasklist_lock) will open irq, at
> > > this time, if user calls find_get_pid() in irq, because
> > > current->thread_id is NULL,
> > > it will handle the NULL pointer.
> >
> > Uhm, where is that code from? This doesn't seem to be upstream.
> 
> It's from our own platform, we found someone called  find_get_pid() in
> the module, and caused the crash.

So this is a bug report for an out of tree driver which I'm sure you're
aware we consider mostly irrelevant unless this is an upstream issue.

Please work around or better fix this in your out of tree driver or
please show a reproducer how this can happen on upstream kernels.

Otherwise I don't see why we'd care.
