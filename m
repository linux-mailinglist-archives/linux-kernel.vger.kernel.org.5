Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E047778B9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjH1VBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjH1VB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:01:28 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEEC195
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:01:24 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RZNJf6x6WzB9;
        Mon, 28 Aug 2023 23:01:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693256483; bh=BtWGvnZ6HanSm2dtgHHulHkjBoOdtX8R0lF4vWpGpXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naglXjRKQid+y7j4nXaxyR74dlj2SvmVV49ZW2LqS3SIHsHPNag4AQuJTozTuOJJO
         Rjz3ooCddwEAuqTNnY2bzCQUiMly/3UvaSdnk5+0PlDniT79gjB3Y4P8vnCdsFGpBO
         WD/FewKGhJrhqeLttSyFc4/IMl7eomHVJKDI3tJxqZ3lvwox5/6zC44L0KGI+j52Un
         7mHJqEciyGP4T8JeXe8t8/2txnuDkjoIwaRKF2U8eej3LdFEIRdStmO9TJnwp2/sY8
         DbsaDnNW7ZMyaX/U0eA85sYNqXaGLAafOU1fqAANn4+je+MBdnkmPePHxNeMfKOn9f
         ArZCde2a7E9OA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Mon, 28 Aug 2023 23:01:21 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] regulator: core: simplify nested locking
Message-ID: <ZO0LIY36mPO4pjJf@qmqm.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
 <7d678e7b55e88e630491086f59120253fabeb386.1692484240.git.mirq-linux@rere.qmqm.pl>
 <CAD=FV=VHvi-2GPxXsDaiPKzgJHqBpX1a6+0CUwp1y8vfr8-Xtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VHvi-2GPxXsDaiPKzgJHqBpX1a6+0CUwp1y8vfr8-Xtg@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:50:32AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sat, Aug 19, 2023 at 3:46 PM Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> >
> > Simplify regulator locking by removing locking around locking.
> > rdev->ref check when unlocking is moved inside the critical section.
> >
> > This patch depends on 12235da8c80a ("kernel/locking: Add context to
> > ww_mutex_trylock()").
> 
> nit: when I run checkpatch, it always wants me to put the word
> "commit" before the git hash when I refer to a commit. ;-)

> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/regulator/core.c | 19 +++++--------------
> >  1 file changed, 5 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index 921c7039baa3..87e54b776a0f 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -34,7 +34,6 @@
> >  #include "internal.h"
> >
> >  static DEFINE_WW_CLASS(regulator_ww_class);
> > -static DEFINE_MUTEX(regulator_nesting_mutex);
> >  static DEFINE_MUTEX(regulator_list_mutex);
> >  static LIST_HEAD(regulator_map_list);
> >  static LIST_HEAD(regulator_ena_gpio_list);
> > @@ -143,23 +142,18 @@ static inline int regulator_lock_nested(struct regulator_dev *rdev,
> >  {
> >         int ret = 0;
> 
> nit: remove initialization of "ret" to 0 since changing "return ret"
> to "return 0" below. Those changes belong in one of the previous
> patch, too.

Will do.

> > -       mutex_lock(&regulator_nesting_mutex);
> > -
> >         if (!ww_mutex_trylock(&rdev->mutex, ww_ctx) &&
> > -           rdev->mutex_owner != current) {
> > -               mutex_unlock(&regulator_nesting_mutex);
> > +           READ_ONCE(rdev->mutex_owner) != current) {
> >                 ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
> > +
> >                 if (ret == -EDEADLK)
> >                         return ret;
> > -               mutex_lock(&regulator_nesting_mutex);
> >         }
> >
> >         rdev->ref_cnt++;
> >         rdev->mutex_owner = current;
> >
> > -       mutex_unlock(&regulator_nesting_mutex);
> > -
> > -       return ret;
> > +       return 0;
> >  }
> >
> >  /**
> > @@ -186,16 +180,13 @@ static void regulator_lock(struct regulator_dev *rdev)
> >   */
> >  static void regulator_unlock(struct regulator_dev *rdev)
> >  {
> > -       mutex_lock(&regulator_nesting_mutex);
> > +       if (WARN_ON_ONCE(rdev->ref_cnt <= 0))
> > +               return;
> >
> >         if (--rdev->ref_cnt == 0) {
> >                 rdev->mutex_owner = NULL;
> >                 ww_mutex_unlock(&rdev->mutex);
> >         }
> > -
> > -       WARN_ON_ONCE(rdev->ref_cnt < 0);
> > -
> > -       mutex_unlock(&regulator_nesting_mutex);
> 
> I guess the "fix" you talked about in the cover letter is moving the
> WARN_ON up? That could be done in patch #1 and marked as a "Fix",
> right?

The fix is patch #5. (And has a Fixes line to mark it. :-)

Moving WARN_ON up is needed to keep it from touching ref_cnt outside of
the locked code (the regulator_nesting_mutex was protecting it before).

> I'm not 100% sure why we needed the "regulator_nesting_mutex" to begin
> with. I'm also not 100% sure why we depend on commit 12235da8c80a
> ("kernel/locking: Add context to ww_mutex_trylock()"). Could you add
> something to the commit message to make this more obvious so I don't
> need to work so hard to figure it out? ;-)

Commit 12235da8c80a is needed as it enables ww_mutex_trylock() to
correcly account the lock in ww_ctx if it was able to grab it.

Best Regards
Michał Mirosław
