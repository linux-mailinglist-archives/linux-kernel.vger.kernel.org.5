Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FA752DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjGMX2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGMX2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:28:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B34E269F;
        Thu, 13 Jul 2023 16:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C790261B9A;
        Thu, 13 Jul 2023 23:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CB0C433C7;
        Thu, 13 Jul 2023 23:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689290932;
        bh=NDO2P9+RW636wRRXRtr7gwSzDOuhmqm37GP4lCYn9IY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dGIlaA5ACD0zbItZfFo5zQ6YW8m63CwBqa6iBL/EIvMwzkmxhHy+Vt3QD8Lfj7jv6
         +fHfJHVFhTJdNfg5s5cdqxNKOIRV7F7i8HYgG/43RP555xzqsSgDENBiG7OgYpNryt
         T4cKkUq0aiidOcxwlqsNmggDCaHZ6gHu4q5trruYmW7pRd6WVa6oau9CYZrDizqRyn
         U4z+XzLF3eaHAqJqMD1hLDIgzF2Md6RtjNXqlwJg/lNjSqEKy7kov61csq8rWYh6nB
         nrqqJW5OO/Gjv6m2PDxGNl1tXJkRwpzr8ff+GZi1TaqQ5k0rLy/U9s7+ZlxJWP0k3b
         ts0UG7Hq1otEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A2BA4CE009E; Thu, 13 Jul 2023 16:28:51 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:28:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sandeep Dhavale <dhavale@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
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
Message-ID: <906e7981-9da2-4b3d-b200-aad7c8057bef@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <CAB=BE-QSaRKvVQg28wu6zVoO9RwiHZgXJzUaEMdbtpieVLmT8A@mail.gmail.com>
 <39923da8-16a1-43a8-99f1-5e13508e4ee4@paulmck-laptop>
 <CAB=BE-QNFhOD=xe09hiZOLmDN7XQxnaxyMz1X=4EeU7SFKaRKA@mail.gmail.com>
 <32b8c9d5-37da-4508-b524-fc0fd326c432@paulmck-laptop>
 <CAB=BE-SwUTDkVvd5s3-NjEzBTqoZnHFdZg0OU-YVK+h3rxnEuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=BE-SwUTDkVvd5s3-NjEzBTqoZnHFdZg0OU-YVK+h3rxnEuw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:08:29PM -0700, Sandeep Dhavale wrote:
> >
> > Sorry, but the current lockdep-support functions need to stay focused
> > on lockdep.  They are not set up for general use, as we already saw
> > with rcu_is_watching().
> >
> Ok, understood.
> 
> > If you get a z_erofs_wq_needed() (or whatever) upstream, and if it turns
> > out that there is an RCU-specific portion that has clean semantics,
> > then I would be willing to look at pulling that portion into RCU.
> > Note "look at" as opposed to "unconditionally agree to".  ;-)
> > > > I have no official opinion myself, but there are quite a few people
> > > ...
> > >
> > > Regarding erofs trying to detect this, I understand few people can
> > > have different
> > > opinions. Not scheduling a thread while being in a thread context itself
> > > is reasonable in my opinion which also has shown performance gains.
> >
> > You still haven't quantified the performance gains.  Presumably they
> > are most compelling with large numbers of small buffers to be decrypted.
> 
> Maybe you missed one of the replies. Link [1] shows the scheduling overhead
> for kworker vs high pri kthread. I think we can all see that there is non-zero
> cost associated with always scheduling vs inline decompression.

Heh!  A reply I was not CCed on back in February.  ;-)

But data like that included directly in the commit log, gathered
specifically for that commit log's patch, would be very helpful.

> > But why not just make a z_erofs_wq_needed() or similar in your own
> > code, and push it upstream?  If the performance gains really are so
> > compelling, one would hope that some sort of reasonable arrangement
> > could be arrived at.
> >
> Yes, we will incorporate additional checks in erofs.

Sounds good to me!

							Thanx, Paul

> Thanks,
> Sandeep.
> 
> [1] https://lore.kernel.org/linux-erofs/20230208093322.75816-1-hsiangkao@linux.alibaba.com/
