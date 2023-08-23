Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266517861DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbjHWU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbjHWU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2687610D8;
        Wed, 23 Aug 2023 13:57:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 980F66487E;
        Wed, 23 Aug 2023 20:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36F2C433C7;
        Wed, 23 Aug 2023 20:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692824271;
        bh=vTIjKL53Cc3HmTgmH4cZ+J2Kt7DPrw9NybnzwZxQfmY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cbrmTufVKLZzot//qR89HiT1p66NE+54CLJXZEfFKw0fMfNdVaL6Ub9GeSOFXILk/
         ZqsTW/hdRamhp4StIXKaGuUki3QfT6DL1XVzuk9QmuAYryiMOdUaRsQSNeDlwMjMkI
         2VvYfQrRpq9vS4JocWUAvnx6gr+w/KmlK8wfTsNssVChhP2jINEXqDSwfX2RkEvCaF
         yIz7PshUcD86TxtYhmYwVovZRxgrN4vwqWjLWbxwkc9MXji09RiygsQ4FoGYO6gHjd
         LHdQ96pqCXAA/AwMf2HnC0IYmaLFbsZigTrE0Y9/3ij7OfGQ7XYCjDOBRmiQzP8aWx
         zcqo0QF6U3V0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E9DCCE02EE; Wed, 23 Aug 2023 13:57:51 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:57:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rcutorture: Can not Disable RT throttling
Message-ID: <600e1ab4-059b-4b4e-9db2-2c56ac557d3b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CALm+0cVvHb=Fe8kseVLesjS1d=579c7Bn5hxdiqyzBp5Z7SugA@mail.gmail.com>
 <CAEXW_YScFnFG0Y1NgFS7KGS6s9CoXJ3ZQB++6udyK38mcJ=1xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YScFnFG0Y1NgFS7KGS6s9CoXJ3ZQB++6udyK38mcJ=1xg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:50:37AM -0400, Joel Fernandes wrote:
> On Tue, Aug 22, 2023 at 3:37 AM Z qiang <qiang.zhang1211@gmail.com> wrote:
> >
> > When running build-in rcutorture tests in 6.5.0-rc4-rt, and found that,
> > although the value of /proc/sys/kernel/sched_rt_runtime_us is -1,
> >
> > cat /sys/kernel/debug/sched/debug
> > ....
> > rt_rq[6]:
> >   .rt_nr_running                 : 4
> >   .rt_nr_migratory               : 0
> >   .rt_throttled                  : 0
> >   .rt_time                       : 0.000000
> >   .rt_runtime                    : 950.000000
> >
> > but the rt_runtime still is 950.000000.
> > set sysctl_sched_rt_runtime in rcu_torture_disable_rt_throttle()
> > does not disable rt-throttling.
> 
> I think you have hit a bug. I think the problem is
> rcu_torture_disable_rt_throttle() modifies the sysctl knobs, but does
> not change def_rt_bandwidth and reinitialize the rt_rq. I think we
> need to call sched_rt_do_global() like the sysfs handler does, or
> change the sysctl knobs to be earlier in the boot process before the
> rt_rq are initialized.
> 
> Or better yet (not sure if it is possible) trigger the sysctl change
> via the sysctl layer and let it do the same logic.

That would be difficult in built-in rcutorture testing due to the fact
that there is not much in the way of userspace.  I suppose we could
invoke the sysfs handler so as to mock up a userspace access, but that
might not be the most robust approach.

Another way is to disable preemption in the real-time kthreads.  Which
might need careful implementation to avoid "scheduling while atomic"
and friends.

							Thanx, Paul
