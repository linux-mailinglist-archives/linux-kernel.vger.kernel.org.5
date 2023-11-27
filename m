Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568887F9D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjK0KNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjK0KNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:13:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB0131
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:13:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8059AC433C7;
        Mon, 27 Nov 2023 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701079987;
        bh=fGgNP5lLqq06gIKE/Ay6zDb25xpoQWkuhpClm6E4Od8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gua2LBTgox+kA/7qWhP6aBawjywyAf4plI5DEpsh3Ijh1TglJVJalcbdoLVzj+4dc
         QSMDDVQUYBZq1RQQekKvMiY6PsTT6dCQ73qwrTxCOVqua3ItxtNNh1CT5mMK1rwkOo
         pNmaaaZz8ibyvGn9pVWA4lfTSRxkUENw1NZF/9NxE7CpRhALbo9b8kxwPL+7e+tpwW
         hsJPsy3p5qFhBnTvSRETrsFsNAloxWs+4rOiSkqNw7cPppUIDXmoc2h/jD710Ik/tG
         IqbNDJzviU6gnDPxieDGBRlc5nKcmAT2tWnTWaAy3wiDb1nqr1v6ODL4SEN8gHX01N
         FGTK2menaKnbw==
Date:   Mon, 27 Nov 2023 11:13:00 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        bpf@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
        fengwei.yin@intel.com
Subject: Re: [linus:master] [file] 0ede61d858: will-it-scale.per_thread_ops
 -2.9% regression
Message-ID: <20231127-protokollieren-ermuntern-748cc3855fe8@brauner>
References: <202311201406.2022ca3f-oliver.sang@intel.com>
 <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I took a look at the code generation, and honestly, I think we're
> better off just making __fget_files_rcu() have special logic for this
> all, and not use __get_file_rcu().

My initial massaging of the patch did that btw. Then I sat there
wondering whether it would matter if we just made it possible to reuse
that code and I went through a bunch of iterations. Oh well, it seems to
matter.

> Comments? I also looked at that odd OPTIMIZER_HIDE_VAR() that

Concept looks sane to me.

> __get_file_rcu() does, and I don't get it. Both things come from
> volatile accesses, I don't see the point of those games, but I also
> didn't care, since it's no longer in a critical code path.
> 
> Christian?

Puts his completely imagined "I understand RCU head on".
SLAB_TYPESAFE_BY_RCU makes the RCU consume memory ordering that the
compiler doesn't officialy support (afaik) a bit wonky.

So the thinking was that we could have code patterns where you could
free the object and reallocate it while legitimatly passing the pointer
recheck. In that case there is no memory ordering between the allocation
and the pointer recheck because the last (re)allocation could have been
after the rcu_dereference().

To combat that all future loads were made to have a dependency on the
first load using the hidevar trick.

I guess that might only be theoretically possible but not in practice?
But then I liked that we explicitly commented on it as a reminder.
