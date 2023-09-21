Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075E77AA130
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjIUU6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjIUU6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:58:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4D7EA0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DEA6C32798;
        Thu, 21 Sep 2023 10:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695292675;
        bh=l3altaqa2vlkLvvlLcemsJXO+aays1kdpxDpG0qkff4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHKYggjbKElo1leuZD7jc0VoseeE94G/G1cDa+fVm2V6TwbnoGiZFBvtloGDnQoAw
         rfcE2rDFoMlO4FQRpThrm+jetlms/D+UqUa7D0ZkESklLhmjfNsT33v6RkPJjs53vK
         Txd30i7dADjW3NDyOiIQDSA32EWFDpuTg2Rv7nYE2A5l8eSWZvA53oPKfgl8NueTfj
         GB8FRoQ2ytxlaVoumfjcPY1mPsqHrQ9XoaGJvCOJLQAMNqLgml348f0HK+MgXdZBaY
         TztDIH4cRZSNv3X/nHQd2xiDpllTkbPGfUkbL3o7+Vb8iTWVAr6jI/TrP5hKUkn0r7
         RVpD0obEbWfbA==
Date:   Thu, 21 Sep 2023 11:37:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] mfd: cs42l43: fix defined but not used warnings
Message-ID: <20230921103751.GD3449785@google.com>
References: <20230905021209.1412987-1-zhangshida@kylinos.cn>
 <20230920095248.GC13143@google.com>
 <CANubcdVuiBciEQu14hOUvgSYo2+1okQ4ed-tJJa5Xo_3jieGzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANubcdVuiBciEQu14hOUvgSYo2+1okQ4ed-tJJa5Xo_3jieGzg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023, Stephen Zhang wrote:

> Lee Jones <lee@kernel.org> 于2023年9月20日周三 17:52写道：
> >
> > On Tue, 05 Sep 2023, zhangshida wrote:
> >
> > > From: Shida Zhang <zhangshida@kylinos.cn>
> > >
> > > Warnings were generated during compiling for functions like
> > > cs42l43_*_{resume,suspend}:
> > >
> > > ../drivers/mfd/cs42l43.c:1138:12: error: ‘cs42l43_runtime_resume’ defined but not used [-Werror=unused-function]
> > >  1138 | static int cs42l43_runtime_resume(struct device *dev)
> > >       |            ^~~~~~~~~~~~~~~~~~~~~~
> > > ../drivers/mfd/cs42l43.c:1124:12: error: ‘cs42l43_runtime_suspend’ defined but not used [-Werror=unused-function]
> > >  1124 | static int cs42l43_runtime_suspend(struct device *dev)
> > >       |            ^~~~~~~~~~~~~~~~~~~~~~~
> > > ../drivers/mfd/cs42l43.c:1106:12: error: ‘cs42l43_resume’ defined but not used [-Werror=unused-function]
> > >  1106 | static int cs42l43_resume(struct device *dev)
> > >       |            ^~~~~~~~~~~~~~
> > > ../drivers/mfd/cs42l43.c:1076:12: error: ‘cs42l43_suspend’ defined but not used [-Werror=unused-function]
> > >  1076 | static int cs42l43_suspend(struct device *dev)
> > >
> > > Fix it by guarding it with CONFIG_PM/CONFIG_PM_SLEEP.
> > >
> > > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > > ---
> > >  drivers/mfd/cs42l43.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
> > > index 37b23e9bae82..e589a61c118d 100644
> > > --- a/drivers/mfd/cs42l43.c
> > > +++ b/drivers/mfd/cs42l43.c
> > > @@ -1073,6 +1073,7 @@ void cs42l43_dev_remove(struct cs42l43 *cs42l43)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
> > >
> > > +#ifdef CONFIG_PM_SLEEP
> > >  static int cs42l43_suspend(struct device *dev)
> > >  {
> > >       struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> > > @@ -1120,7 +1121,9 @@ static int cs42l43_resume(struct device *dev)
> > >
> > >       return 0;
> > >  }
> > > +#endif
> > >
> > > +#ifdef CONFIG_PM
> > >  static int cs42l43_runtime_suspend(struct device *dev)
> > >  {
> > >       struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> > > @@ -1176,6 +1179,7 @@ static int cs42l43_runtime_resume(struct device *dev)
> > >
> > >       return ret;
> > >  }
> > > +#endif
> > >
> > >  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> > >       SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> >
> > I see a bunch of drivers using PM helpers and not many of them are
> > are being guarded by ugly #ifery.  Please find out what they're doing to
> > solve the same issue and replicate that instead.
> >
> > Here's a really big hint:
> >
> >   `git log --oneline 02313a90095fb`
> >
> 
> Thanks, I've learned something from the hint.
> 
> And I also checked the code:
> -----
> EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
>         SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
>         SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend,
> cs42l43_runtime_resume, NULL)
> };
> ----
> #ifdef CONFIG_PM_SLEEP
> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> #else
> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> #endif
> ----
> #define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>         .suspend = pm_sleep_ptr(suspend_fn), \
>         .resume = pm_sleep_ptr(resume_fn), \
>         .freeze = pm_sleep_ptr(suspend_fn), \
>         .thaw = pm_sleep_ptr(resume_fn), \
>         .poweroff = pm_sleep_ptr(suspend_fn), \
>         .restore = pm_sleep_ptr(resume_fn),
> ----
> The technique has already been used by the marcos, but it still
> reports the defined-but-not-used warning.

The MACROS can use #ifery since they are located in header files.

#ifery in C files is to be avoided if at all possible.

> Maybe some compilers still choose to compile these functions in...
> Anyway, I will just leave it alone since it is really not a big problem...

If you're seeing an error, it should be fixed.

Why is this not an issue anywhere else?

Does the same build complain about all the other drivers too?

-- 
Lee Jones [李琼斯]
