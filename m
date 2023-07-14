Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A4C7542BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjGNSoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjGNSoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331C21FF1;
        Fri, 14 Jul 2023 11:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6858061DCF;
        Fri, 14 Jul 2023 18:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E94C433C8;
        Fri, 14 Jul 2023 18:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689360246;
        bh=asCo0dd5mxRE4px5f2OcxTb7m6Zaxpvf3NvcR8uu61U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gn+DOEFcqLlkcY/4WoNax0oKj6ls87rLsFfTTD8WPgySn3vvfMtKPn+ZX3JgPGNCd
         FDm5Ru12kqKyEtQrpw8eWhZHEiMzjezQtAxWJqdrLSOw7DZaip8ChsOhcVh4XLlwlX
         /Lv4JvjO4R3Xf7fM/4Ex3qeIsneiy75F6Eu5G3XK4ggLCx6b28BobahgmwhU0Tl4Gy
         s0pz5u2QfVrnJOeioAXRIFecdDNn/usfOcjlOLvra00R6w4n4ADI0cITSLwW5ovXLO
         5q5AKGMNfILldBZ3L64L3VQzTGpYJSUIfoJ6wKutfTSPPLSRnsLlsvurNEkfVPwzQ0
         3I4CQNucM7vBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 45F3ACE03B3; Fri, 14 Jul 2023 11:44:06 -0700 (PDT)
Date:   Fri, 14 Jul 2023 11:44:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <453bcbbd-94f4-46da-98f6-c9fa5f931231@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
 <F160D7F8-57DC-4986-90A9-EB50F7C89891@gmail.com>
 <6E5326AD-9A5D-4570-906A-BDE8257B6F0C@gmail.com>
 <e8ee7006-c1d0-4c04-bd25-0f518fb6534b@paulmck-laptop>
 <D042B1CB-2ED4-4DF9-8CF5-5E455E7EAB73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D042B1CB-2ED4-4DF9-8CF5-5E455E7EAB73@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 02:40:08AM +0800, Alan Huang wrote:
> > 2023年7月15日 01:02，Paul E. McKenney <paulmck@kernel.org> 写道：
> > On Fri, Jul 14, 2023 at 11:54:47PM +0800, Alan Huang wrote:
> >>> 2023年7月14日 23:35，Alan Huang <mmpgouride@gmail.com> 写道：
> >>>> 2023年7月14日 10:16，Paul E. McKenney <paulmck@kernel.org> 写道：

[ . . . ]

> >>>>> How can this be solved?
> >>>>> 
> >>>>> 1. Always use a workqueue.  Simple, but is said to have performance
> >>>>> issues.
> >>>>> 
> >>>>> 2. Pass a flag in that indicates whether or not the caller is in an
> >>>>> RCU read-side critical section.  Conceptually simple, but might
> >>>>> or might not be reasonable to actually implement in the code as
> >>>>> it exists now. (You tell me!)
> >>>>> 
> >>>>> 3. Create a function in z_erofs that gives you a decent
> >>>>> approximation, maybe something like the following.
> >>>>> 
> >>>>> 4. Other ideas here.
> >>>> 
> >>>> 5. #3 plus make the corresponding Kconfig option select
> >>>> PREEMPT_COUNT, assuming that any users needing compression in
> >>>> non-preemptible kernels are OK with PREEMPT_COUNT being set.
> >>>> (Some users of non-preemptible kernels object strenuously
> >>>> to the added overhead from CONFIG_PREEMPT_COUNT=y.)
> >>> 
> >>> 6. Set one bit in bio->bi_private, check the bit and flip it in rcu_read_lock() path,
> >>> then in z_erofs_decompressqueue_endio, check if the bit has changed.
> >> 
> >> Seems bad, read and modify bi_private is a bad idea.
> > 
> > Is there some other field that would work?
> 
> Maybe bio->bi_opf, btrfs uses some bits of it.

Sandeep, thoughts?


							Thanx, Paul

> >>> Not sure if this is feasible or acceptable. :)
> >>> 
> >>>> 
> >>>> Thanx, Paul
> >>>> 
> >>>>> The following is untested, and is probably quite buggy, but it should
> >>>>> provide you with a starting point.
> >>>>> 
> >>>>> static bool z_erofs_wq_needed(void)
> >>>>> {
> >>>>> if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
> >>>>> return true;  // RCU reader
> >>>>> if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preemptible())
> >>>>> return true;  // non-preemptible
> >>>>> if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> >>>>> return true;  // non-preeemptible kernel, so play it safe
> >>>>> return false;
> >>>>> }
> >>>>> 
> >>>>> You break it, you buy it!  ;-)
> >>>>> 
> >>>>> Thanx, Paul
> 
> 
