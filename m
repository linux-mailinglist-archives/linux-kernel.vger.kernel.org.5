Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D6178F5AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbjHaWlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjHaWlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:41:39 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA78C0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:41:36 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RcGNt3PWDz5s;
        Fri,  1 Sep 2023 00:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693521694; bh=f49rXeOsX2+k9JH8576CfFzxX9BrcwLU5e1ZJ9FXWtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8FHZZkfnpd890D4wjfVSBQyn4Q+ADxpoHIb0MCXAEDSP2tezkNB/UrX2U+/ggh/T
         IlFQ9ehxtjuPIZA3cTjFMFSrntf9VhcQz7W2KyKnFKHTPxqRXfUfjFdnrceH8Ld+fj
         ToZz8o5QOCXag3SVwS+v8L9m/o1Cd/euSXcdBSFeMGijl2jWVy3Yw9v6n5LWgMp6zD
         wCXp91gfU442Ns9kRcO7jdQ4ZrDZR6u2ybFvOycGprMUNI51mvs0qtV9mUFjNBOVuM
         U3K1pnONHprcFFjLfFZMkIUKSYJuvUtHxgIvFNgpnEU+HQR98ZcAPWudG4npO2T4Q/
         gu93s0QjQu1Og==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Fri, 1 Sep 2023 00:41:32 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 3/7] regulator/core: regulator_lock_nested: simplify
 nested locking
Message-ID: <ZPEXHIAMM4+MXaHD@qmqm.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
 <56ae0bf828d942c92ca867afb3aae95fcabd5498.1693416477.git.mirq-linux@rere.qmqm.pl>
 <CAD=FV=Uzu=37nqGZYu4cU7fMMV2u+e8-GF1+izcvusOT+a1f=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Uzu=37nqGZYu4cU7fMMV2u+e8-GF1+izcvusOT+a1f=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:54:21PM -0700, Doug Anderson wrote:
> On Wed, Aug 30, 2023 at 10:35 AM Michał Mirosław
> <mirq-linux@rere.qmqm.pl> wrote:
> >
> > Simplify regulator locking by removing locking around locking.
> > rdev->ref check when unlocking is moved inside the critical section.
> >
> > This patch depends on commit 12235da8c80a ("kernel/locking: Add context
> > to ww_mutex_trylock()").
> >
> > Note: return -EALREADY is removed as no caller depends on it and in that
> > case the lock count is incremented anyway.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/regulator/core.c | 23 ++++++-----------------
> >  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> Note that I didn't actually provide a Reviewed-by on this patch in v1.
> I was hoping for something in the commit message that explained why
> commit 12235da8c80a ("kernel/locking: Add context to
> ww_mutex_trylock()") meant that we didn't need the extra lock. You
> responded to the v1, but didn't add anything to the commit message
> about it.
> 
> Looking at your response to v1, I'm not sure it helps enlighten me on
> why adding the context removed the need for the extra lock. Can you
> add more words? Pretend I don't know anything about ww_mutex, which is
> not far from the truth since every time I look at ww_mutex I have to
> re-learn how it works. :-P Specifically, what would actually have been

Thanks for all your (and Stephen's) questions and comments! I had a bit
more of thinking and reading time about the W/W mutex and how it works.
It turns out I can remove some noise from this commit.

The commit 12235da8c80a dependency is due to text changes: the original
code would need a bit of reordering, all not much different than the
two previous patches.

If ww_mutex_lock() was able to return -EALREADY with NULL ww_ctx,
regulator_lock_nested() could be made even simpler.

Best Regards,
Michał Mirosław
