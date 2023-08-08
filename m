Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21C1773E51
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjHHQ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjHHQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7303411F65;
        Tue,  8 Aug 2023 08:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46DE1623A9;
        Tue,  8 Aug 2023 04:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C28C433C7;
        Tue,  8 Aug 2023 04:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691467250;
        bh=cXOL8xc0A6xcrLjiQsPiQrtWN20XM6CeBDpoGxgL8Qk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o+z86DrLNP1vWk8LoTk/wc1ANBL99M0PKRR+UcOivvqI5LtL9A6Smraa0A7fptFev
         ZlN3G2SgelsItMTBWfEuMKgd0HNzOa9AeFF0HJ74Z/jBDAAAmH36gGAKbb/HY9RqRf
         lLo/1em7MTyv5d/rWEfNM86ruz7dXfN2mnPPHtKtjTjhWkQxCjFZvWb2et4QArfLR1
         Dz4KMbciP+gma6aCCOAOZkFFVGifB3xptnoV9P2vRoURp+THmO7sIDruLl5gLmorcD
         l4wpyICePvibViNeouqrXPU8mSJbAdy+bUf8fgUYp9dYsgmo2dWtHpJd7nXdZ1Fbmx
         tM3RZPimzNgZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6F43BCE075B; Mon,  7 Aug 2023 21:00:49 -0700 (PDT)
Date:   Mon, 7 Aug 2023 21:00:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Stultz <jstultz@google.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH rcu 2/2] torture: Add lock_torture writer_fifo module
 parameter
Message-ID: <8ecb0ee9-cbe0-458d-930f-772ee7128003@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <12d34340-6c94-4bfd-aa16-3c39026070d8@paulmck-laptop>
 <20230728032232.816584-2-paulmck@kernel.org>
 <CANDhNCpCrwbMp8oTwvTab+-Q1b52zJvMuZiV9LW-bP2Zgqqyhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCpCrwbMp8oTwvTab+-Q1b52zJvMuZiV9LW-bP2Zgqqyhg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 08:27:29PM -0700, John Stultz wrote:
> On Thu, Jul 27, 2023 at 8:22 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >
> > This commit adds a module parameter that causes the locktorture writer
> > to run at real-time priority.
> >
> > To use it:
> > insmod /lib/modules/torture.ko random_shuffle=1
> > insmod /lib/modules/locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3 writer_fifo=1
> >                                                                                                         ^^^^^^^^^^^^^
> >
> > A predecessor to this patch has been helpful to uncover issues with the
> > proxy-execution series.
> >
> > [ paulmck: Remove locktorture-specific code from kernel/torture.c. ]
> 
> Thanks again for improving this!  I've switched over to your version
> here in my test tree.
> 
> Acked-by: John Stultz <jstultz@google.com>

Thank you both!  I will apply on my next rebase.

							Thanx, Paul
