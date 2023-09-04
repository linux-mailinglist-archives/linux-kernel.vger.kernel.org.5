Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F9779199F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349143AbjIDO13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjIDO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB3CC8;
        Mon,  4 Sep 2023 07:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10366612B4;
        Mon,  4 Sep 2023 14:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8F0C433C7;
        Mon,  4 Sep 2023 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693837644;
        bh=C3brLRwlEVnjDBLps6JTkkIjEzKkSs+Sjv0Eo3AGAp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nnta60zQUNQ7MXOoKWGQxw0gXdbgTKmMzEvts4bfzajeyvdcA9gVFEFaNosOxtsVc
         /RTMXMRXMmhoevsNxBfM4a9A/lk1cItNmX8P66Qcu8NKZk0wR4Z/1gdu23pxoPmK0E
         nyGauJya4nopHWwHwxaMnEGBSIBXHR9+aYqkTX9XfPR8BuE3ScMDF0ia3ezliv/mPC
         Fc3/IYm61exkgyzF3roe2AUdhVMGOS+6UyBopL2JEO4JdSUSWOkVU6+xppmh+uytXD
         Cu7vWvLKQE7ptNF7d3GZgIJ6wIYJQ4jngZksYpkuPFfp4a910jxs3o4In1u2bLNwBl
         WR0J2bdoX0Pug==
Date:   Mon, 4 Sep 2023 15:27:17 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: (subset) [PATCH v6 06/10 RESEND] power: supply: rt5033_charger:
 Add cable detection and USB OTG supply
Message-ID: <20230904142717.GD13143@google.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
 <223b440ab6831f2e7302d2c49b2cfd7779d5effd.1684182964.git.jahau@rocketmail.com>
 <169226510772.947223.494995318945916008.b4-ty@kernel.org>
 <20230822070737.GP1380343@google.com>
 <20230822212909.mcnziqsuu523e4gk@mercury.elektranox.org>
 <96c08475-72e7-9ef4-2f16-e962f9338e78@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96c08475-72e7-9ef4-2f16-e962f9338e78@rocketmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2023, Jakob Hauser wrote:

> Hi Sebastian,
> 
> On 22.08.23 23:29, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Tue, Aug 22, 2023 at 08:07:37AM +0100, Lee Jones wrote:
> > > On Thu, 17 Aug 2023, Lee Jones wrote:
> > > 
> > > > On Mon, 15 May 2023 22:57:15 +0200, Jakob Hauser wrote:
> > > > > Implement cable detection by extcon and handle the driver according to the
> > > > > connector type.
> > > > > 
> > > > > There are basically three types of action: "set_charging", "set_otg" and
> > > > > "set_disconnect".
> > > > > 
> > > > > A forth helper function to "unset_otg" was added because this is used in both
> > > > > "set_charging" and "set_disconnect". In the first case it covers the rather
> > > > > rare event that someone changes from OTG to charging without disconnect. In
> > > > > the second case, when disconnecting, the values are set back to the ones from
> > > > > initialization to return into a defined state.
> > > > > 
> > > > > [...]
> > > > 
> > > > Applied, thanks!
> > > > 
> > > > [06/10] power: supply: rt5033_charger: Add cable detection and USB OTG supply
> > > >          commit: c1af6bcc8583b0a1083338cd26c2090d0bcb0810
> > > 
> > > Multiple fixes now follow this patch, so I am unapplying it.
> > > 
> > > Sebastian, would you mind collecting it up please?
> > 
> > I'm leaving for a two week hiking trip (with basically no internet
> > access) in some hours. My planed return date is basically when Linus
> > is expected to tag 6.6-rc1, so I will not queue any more patches and
> > send my pull request early (within the next few hours).
> > 
> > I planned to catch up with the power-supply backlog last week during
> > Chaos Communication Camp, but it was too hot to do any sensible
> > review. Now I expect to process the power-supply backlog in the
> > week after the merge window.
> 
> The patch 6 of the rt5033-charger series v6 gathered some issues. For all of
> them a solution was provided. Thanks to everyone involved! However, I don't
> know what's the best way to put them together.
> 
> - As the patch 6 was forgotten to apply with the others of the
>   patchset, in the meantime another small patch by Rob sneaked in. The
>   patch 6 needs to be rebased on Rob's patch. It affects the includes.
>   Would be nice to order them alphabetically after rebase.
> 
> - After patch 6 was added on top of Rob's patch in linux-next, there
>   was a build failure. This is because "linux/of.h" now explicitly
>   needs to be added to the rt5033-charger driver. Stephen Rothwell
>   provided a fix. I'm not sure on the order: Maybe that needs to be
>   added before adding patch 6 to avoid the build failure when the
>   kernel test bot checks each commit separately.
> 
> https://lore.kernel.org/linux-next/20230821125741.3a2474d7@canb.auug.org.au/T/#u
> 
> - Beyond that, the kernel test bot also complained about undefined
>   reference related to extcon. I didn't understand why this happens
>   because the driver has "linux/extcon.h" included. Randy was attentive
>   and provided a fix. Here again I'm not sure about the order, I guess
>   this should be added before adding patch 6 to avoid build failures if
>   each commit is tested separately.
>   Kernel test bot complaints:
>     x86_64 clang https://lore.kernel.org/oe-kbuild-all/202308220324.LsI8q3ML-lkp@intel.com/T/#u
>     x86_64 gcc https://lore.kernel.org/oe-kbuild-all/202308240723.O2rW0InU-lkp@intel.com/T/#u
>     arm gcc https://lore.kernel.org/oe-kbuild-all/202308250617.ue4uQxWa-lkp@intel.com/T/#u
>   Fix by Randy:
> 
> https://lore.kernel.org/linux-pm/20230828224201.26823-1-rdunlap@infradead.org/T/#u
> 
> - Yang noticed that the mutex_unlock() is not handled correctly in
>   some error path and provided a fix:
> 
> https://lore.kernel.org/linux-pm/20230822030207.644738-1-yangyingliang@huawei.com/T/#u
> 
> - There are two clean-up patches by me. They need to be rebased to the
>   patches mentioned above but there shouldn't be conflicts with them.
> 
> https://lore.kernel.org/linux-pm/cover.1686948074.git.jahau@rocketmail.com/T/#u
> 
> Please also note that the commit hash in the linked fixes above refers to
> linux-next, where the patch 6 had been applied. As the patch was dropped
> later on, I don't know what this means for the commit hashes in the fixes.
> 
> What's the best way to proceed? Can you put these patches together? Or do
> you want me something to do?

You need to do this yourself.

Rebase all of the fixes on top of v6.6-rc1 (which will be released in a
little under a week).  Ensure that each patch builds as it's applied so
as not to harm bisecability.  If you have to squash them to prevent
built-breakages, then so be it, but don't forget to credit the
contributors.  Once complete, post as a set and we'll take it from
there.

-- 
Lee Jones [李琼斯]
