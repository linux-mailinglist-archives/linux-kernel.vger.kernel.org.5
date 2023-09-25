Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861697AD275
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjIYH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjIYH4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:56:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB9D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:56:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91288C433C7;
        Mon, 25 Sep 2023 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695628584;
        bh=4zCfDdzFtWnLPZPG/z3s85AQ/RSgjNdFct5l5BJMK+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7Cm3zreDhv3tqbUkZfrSYrLYAvXQlLRtpA/ZbPav3E3tfJa9W3KF/BLGh+6apTI0
         FybipWzuf2poOtpPfIbLMm7EgLjylaF+LrNlU0ZHXMf4locwm9gTWr2d7H4AuhVIxm
         oT8vCuUElDJDvcA+wXSIJlJnXfYUUBTV9CTLpZvQOZxpF8z5xtls0L0CQsvNgPWvV3
         ta2rssiSSAOUZ+HsbYTXRYxwl5DqczgvgUA7I9oWgpnYZWws9Q9HAnP8P1mSueO96c
         XVDloyYAIqOa+UCuyNhY8nn5MjjFhc3aFHymh9QDwpNY+CdFOZXGydywLG1sHJbXpo
         nIgoJkK/YwOvg==
Date:   Mon, 25 Sep 2023 08:56:20 +0100
From:   Lee Jones <lee@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     zhangshida <starzhangzsd@gmail.com>, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] mfd: cs42l43: fix defined but not used warnings
Message-ID: <20230925075620.GC9999@google.com>
References: <20230905021209.1412987-1-zhangshida@kylinos.cn>
 <20230920095248.GC13143@google.com>
 <CAMuHMdXVqLdWdbVKU+nj2=jVDyFh9gD6rvuTpjdQehjqTr56mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXVqLdWdbVKU+nj2=jVDyFh9gD6rvuTpjdQehjqTr56mw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Wed, Sep 20, 2023 at 12:07 PM Lee Jones <lee@kernel.org> wrote:
> > On Tue, 05 Sep 2023, zhangshida wrote:
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
> 
> And there's no need to create another fix, as a Good Old fix is
> available (and still not upstream):
> https://lore.kernel.org/all/20230822114914.340359-1-ckeepax@opensource.cirrus.com

I beg to differ;

  eb72d5207008d ("mfd: cs42l43: Use correct macro for new-style PM runtime ops")

:)

-- 
Lee Jones [李琼斯]
