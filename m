Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5283F768611
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjG3Ofd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjG3Ofb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:35:31 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100DCA;
        Sun, 30 Jul 2023 07:35:27 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RDP6g2JTYz9smf;
        Sun, 30 Jul 2023 16:35:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1690727723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bdkZw+5OexTIqy6VC2aAhofq/fEzheO0a4LXAdcAmDA=;
        b=ZnwkIkq1SNE5PT0XM3qpb7q7yY7agwh0P/TEUH94GaabicNSjmgx2/KO/qM9gkWmiMU5YS
        zcMb5bWc/iC24DGmmsaVy50Fdl6z8FRMPuxalhv1cxQwXnABoJIK+0SqhPZfOgueIu7exa
        EOOrwZP5vtFZFvBfhm/OfW475XsGXF4IDP2+MiU3GAnk9wcSyZHmqEgYanfCFGXZVPo7Bf
        T6mzW7JTjpU1ZPO5p5+xZHA0UdjIq2aKXPzxpSInJyyaInOcYs4uH64dCgqP7CUdTrpRzf
        MWXxeGz8Pez70LXWAC1hqeZGTPNvoO2rfZf/B7ie+9CDIsWzrhldDFgzU3WKVQ==
References: <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
 <875y7y1f0d.fsf@oltmanns.dev>
 <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6>
 <87a5x41w5r.fsf@oltmanns.dev>
 <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54>
 <87bkhbhnol.fsf@oltmanns.dev>
 <yj6ss64s7p2uaslodj5zklrwhegz54bgh4l4wmldv6cccggepz@yombds4hij3c>
 <87pm4xg2ub.fsf@oltmanns.dev>
 <ycdinzk5633ig5r3ao3czn4p53j32fir4jjsgue3pvi7rcovkn@sptpsyt72ir7>
 <871qgzqa08.fsf@oltmanns.dev>
 <q4mwg2dhwaxofbaaiyao7nmyfh4mat4ic2avxbzpmwhq6fmzyx@dflrio4loms5>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
In-reply-to: <q4mwg2dhwaxofbaaiyao7nmyfh4mat4ic2avxbzpmwhq6fmzyx@dflrio4loms5>
Date:   Sun, 30 Jul 2023 16:35:08 +0200
Message-ID: <87sf95fowz.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

First of all, I appreciate that you take time out of your schedule to
get to the bottom of this.

I understand that you want to go without the patch and that's okay. I
just don't want to trick you into accepting the patchset (minus the
patch under discussion [1]) without fully grasping the consequences.

On 2023-07-25 at 15:55:39 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> [[PGP Signed Part:Undecided]]
> On Sun, Jul 23, 2023 at 10:59:03AM +0200, Frank Oltmanns wrote:
>> Hi Maxime,
>>
>> On 2023-07-17 at 16:06:02 +0200, Maxime Ripard <mripard@kernel.org> wrote:
>> > [[PGP Signed Part:Undecided]]
>> > On Wed, Jul 12, 2023 at 06:39:56AM +0200, Frank Oltmanns wrote:
>> >> Hi Maxime,
>> >>
>> >> On 2023-06-19 at 20:05:44 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
>> >> > [[PGP Signed Part:Undecided]]
>> >> > On Mon, Jun 19, 2023 at 10:16:26AM +0200, Frank Oltmanns wrote:
>> >> >> Hi Maxime,
>> >> >>
>> >> >> the essence of my following ramblings:
>> >> >>  - I do think it is reasonable that nkm is asking its parent for the
>> >> >>    rate that nkm actually needs from said parent to fulfill the request.
>> >> >>  - I don't think nkm should make assumptions about the rounding
>> >> >>    behaviour of the parent.
>> >> >
>> >> > I guess we agree :)
>> >> >
>> >> > And I would go even further and say that we shouldn't make *any*
>> >> > assumption about the behaviour of the parent.

Just to make sure that we are on the same page: This is no longer a
requirement, correct?

My understanding is that you accept that pll-mipi (an nkm clock) relies
on the fact that the parent clock rounds up if pll-mipi requests a rate
that is 1 Hz lower than what pll-mipi actually needs. The patch we're
discussing [1] makes sure, that pll-mipi (or any other nkm clock) does
not have to "make any assumption about the behaviour of the parent."

As this apparently is no longer a requirement, I can (having protested
enough) remove the patch [1] from my series. I'd prefer not to, but I
will do it, if you ask me to.

>> >> >> The reason is, that I want to prevent users of ccu_nkm from making
>> >> >> mistakes when defining their clocks (which includes the parent of their
>> >> >> nkm clock).
>> >> >>
>> >> >> Please read below the details on why I think that.
>> >> >>
>> >> >> [...]
>> >> >>
>> >> >> >> No. I didn't. My assumption is: If ccu_nkm_find_best is asked for the
>> >> >> >> best rate for rate = 449035712, it should try to include 449035712 in
>> >> >> >> its candidates, agreed?
>> >> >> >>
>> >> >> >> Example 1:
>> >> >> >> ==========
>> >> >> >> rate=449035712, n=11, k=3, m=16:
>> >> >> >> We should as for a parent rate of 217714285, because:
>> >> >> >> 217714285 * 11 * 3 / 16 = 449035712
>> >> >> >>
>> >> >> >> How do we get from 449035712 to 217714285, you ask?
>> >> >> >>
>> >> >> >>       DIV_ROUND_UP(rate * m, n * k)
>> >> >> >
>> >> >> > Why are we rounding up? I don't think the hardware will round up there.
>> >> >>
>> >> >> Being a "software guy" it is also my understanding that the hardware
>> >> >> does not round up here (or round down for that matter).
>> >> >
>> >> > That's my understanding as well.
>> >> >
>> >> >> But anyway, my concern is the rate's representation *in software*. The
>> >> >> clk drivers are using unsigned long to represent the actual rate. This
>> >> >> is not a lossless representation. In other words, the value (i.e. the
>> >> >> software representation) of that rate is, of course, a "lie". The
>> >> >> hardware clock is running at some rate that is hopefully close to what
>> >> >> we represent in software, but still it's an abstraction.
>> >> >>
>> >> >> For example, the user (e.g. in my example a panel) asks us for a rate
>> >> >> that is represented in softwares as 449035712. Given the values n=11,
>> >> >> k=3, m=16, we can *only* represent this value in software if the parent
>> >> >> gives us a rate that is represented in software as 217714285. Therefore,
>> >> >> I think it is reasonable to ask the parent for that rate (217714285).
>> >> >
>> >> > I somewhat agree, but I still don't think it's worth rounding up.
>> >> >
>> >> > If we don't round up (and assuming the parent itself won't round the
>> >> > clock), we end up with a rate of 449035710 using the dividers you
>> >> > mentioned. It's a .0000005% deviation (I hope I didn't screw up the
>> >> > number of 0s). It's negligible for all practical purposes, and it's not
>> >> > worth making the code inconsistent and eyebrow raising.
>> >> >
>> >> >> >> Do you agree that we should ask the parent for 217714285 in case we want
>> >> >> >> a rate of 449035712 and we're currently evaluating the case n=11, k=3,
>> >> >> >> m=16?
>> >> >> >>
>> >> >> >> We should not ask for a parent rate of 217714284, because:
>> >> >> >> 217714284 * 11 * 3 / 16 = 449035710
>> >> >> >>
>> >> >> >> Example 2:
>> >> >> >> ==========
>> >> >> >> rate=500000000, n=11, k=3, m=16:
>> >> >> >> Here we should not ask the parent for
>> >> >> >>       DIV_ROUND_UP(rate * m, n * k)
>> >> >> >> because that would be 242424243.
>> >> >> >>
>> >> >> >> 242424243 * 11 * 3 / 16 = 500000001
>> >> >> >>
>> >> >> >> We (the NKM clock, not the parent!) would overshoot (please see at the
>> >> >> >> end of this mail, why (for now) I don't want to support overshooting in
>> >> >> >> the NKM clock).
>> >> >> >>
>> >> >> >> Instead we should as for a parent rate of 242424242, because:
>> >> >> >> 242424242 * 11 * 3 / 16 = 499999999
>> >> >> >>
>> >> >> >> In conclusion, there are cases, where we (the NKM clock) have to ask the
>> >> >> >> parent for
>> >> >> >>       DIV_ROUND_UP(rate * m, n * k)
>> >> >> >> And there are also cases, where we have to ask the parent for
>> >> >> >>       rate * m / (n * k)
>> >> >> >
>> >> >> > I mean, I think you're overthinking this.
>> >> >> >
>> >> >> > If you never round up and mimic how the hardware behaves, and test all
>> >> >> > combination, then eventually you'll find the closest rate.
>> >> >> >
>> >> >> > If you don't because the parent doesn't look for the closest rate, then
>> >> >> > the parent should be changed too.
>> >> >> >
>> >> >> > It really is that simple.
>> >> >> >
>> >> >> >> This is what the code is trying to do. Maybe it's easier to look at V2
>> >> >> >> because I extracted the calcultion of the optimal parent rate into a
>> >> >> >> separate function hoping that this makes things clearer.
>> >> >> >>
>> >> >> >> Let me stress this: When calculating the optimal rate for the parent,
>> >> >> >> I'm not making any assumptions here about how the PARENT clock rounds.
>> >> >> >> In fact, I assume that the parent could be perfect and always provides
>> >> >> >> the rate it is asked for. I only take into account how the nkm clock
>> >> >> >> rounds.
>> >> >> >
>> >> >> > At the very least, you assume that the parent rounding can be "wrong"
>> >> >> > and try to work around that.
>> >> >>
>> >> >> No. I'm not assuming anything about the parent. But I *know* that if we
>> >> >> (nkm) want to get a rate that is represented in softwares as 449035712
>> >> >> and given the values n=11, k=3, m=16, we (nkm) must get the rate from
>> >> >> the parent that the parent represents in software as 217714285, because
>> >> >> I know that we (nkm) calculate *our* (nkm) rate using
>> >> >>     parent * n * k / m
>> >> >>
>> >> >> So if (!) we want to give the user the rate that they ask for, why not
>> >> >> ask the parent for the rate that we need (217714285)?
>> >> >>
>> >> >> I admit that I'm making assumptions here. My assumptions are that we
>> >> >>  a. want to at least try to give the user what they asked for
>> >> >>  b. without making assumptions about the parent's behaviour.
>> >> >>
>> >> >> Those assumptions could of course be wrong, but, honestly, I would find
>> >> >> that confusing.
>> >> >
>> >> > I guess my point leans more towards the "social" side than the
>> >> > mathematical one. If I followed you so far, the precision you expect to
>> >> > gain is in the <1Hz range (and I've been in sick leave for a while, so
>> >> > sorry if I didn't before). The rate is in the 100MHz range.
>> >> >
>> >> > So the precision gain is pretty much nothing. Sure, it's closer from a
>> >> > mathematical standpoint. But there's zero benefit from it.
>> >> >
>> >> > However, it comes at the cost of a code that is definitely more
>> >> > complicated (or less naive, depending on how you look at it I guess :))
>> >> > and will be harder to figure out for someone that jumps into the driver.
>> >> >
>> >> > So the trade-off doesn't really make fixing it worth it to me.
>> >> >
>> >> >> >> > you ask the parent to compute whatever is closest to that optimal parent
>> >> >> >> > rate.
>> >> >> >> >
>> >> >> >> > It's the parent responsibility now. It's the parent decision to figure
>> >> >> >> > out what "the closest" means, if it can change rate, if it has any range
>> >> >> >> > limitation, etc. You can't work around that.
>> >> >> >> >
>> >> >> >> > What you actually want there is the parent to actually provide the
>> >> >> >> > closest rate, even if it means overshooting.
>> >> >> >> >
>> >> >> >>
>> >> >> >> I want to ask the parent for a rate, that would actually result in the
>> >> >> >> rate that nkm_find_best was asked for. Are you asking me to instead ask
>> >> >> >> the parent for a rate that doesn't fit that criterion?
>> >> >> >
>> >> >> > No. I'm asking to call clk_hw_round_rate(parent_hw, rate * m / (n * k))
>> >> >> > and use whatever value it returned.
>> >> >> >
>> >> >> > If it requires changing the parent clock to improve its round_rate
>> >> >> > behaviour, then do that too.
>> >> >> >
>> >> >>
>> >> >> Hmmm... Okay. So you *are* saying, that I should make changes to the
>> >> >> parent so that we do not need to request the exact rate we want from the
>> >> >> parent. But I really don't understand why.
>> >> >
>> >> > No, sorry. I initially thought that you were working around "divider"
>> >> > rounding issue (as opposed to integer like you mentionned above) with
>> >> > the parent not providing its optimal rate, and you adjusting based on
>> >> > that offset.
>> >> >
>> >> >> As I wrote above, I'm not making any assumptions of how and if the
>> >> >> parent rounds. My code is rounding *prior* to asking the parent. Your
>> >> >> proposal on the other hand *requires* changing the parent to round
>> >> >> closest where mine does not.
>> >> >>
>> >> >> My concern is, that we could then end up with the situation that someone
>> >> >> defines an nkm clock in their SoC which has CLK_SET_RATE_PARENT set, but
>> >> >> does not set the ROUND_CLOSEST flag on the parent, because it's not
>> >> >> immediately apparent why they should do that.
>> >> >
>> >> > It's going to happen, and probably happens at the moment already,
>> >> > because not only the NKM clocks are affected, but virtually all of them,
>> >> > and most don't use ROUND_CLOSEST.
>> >> >
>> >> > And to some extent, it's fine. We would handle it like any other bug: if
>> >> > we ever encounter one, we'll write a fix, backport it to stable and all
>> >> > will be fine.
>> >> >
>> >> > You can't figure out all the use-cases we'll require in the future
>> >> > anyway.
>> >> >
>> >> >> Let's assume that hypothetical board were the A64, the nkm clock were pll-mipi,
>> >> >> and the parent were pll-video0 and we "forget" to set ROUND_CLOSEST on
>> >> >> pll-video0:
>> >> >>
>> >> >> When pll-mipi nkm clock is asked via determine_rate() for a rate of
>> >> >> 449064000 it would return 449035712 and a parent rate of 217714285
>> >> >> (using n=11, k=3, m=16, but those details aren't returned by
>> >> >> determine_rate()).
>> >> >>
>> >> >> Eventually, determine_rate() will be called again, but this time for a
>> >> >> rate of 449035712. The user already knows that we can provide that,
>> >> >> because we told them (see previous paragraph). But since we're
>> >> >> truncating when calculating the rate that we'd like the parent to
>> >> >> provide, we end up asking the parent for 217714284 when we actually need
>> >> >> it to provide 217714285. So we now *require* the parent to find the
>> >> >> closest and additionally we must *hope* that the parent is incapable of
>> >> >> providing the rate that we asked for.
>> >> >
>> >> > I mean... yeah. It's what abstraction is all about. For all we know, the
>> >> > parent to pll-mipi could be a crystal that can't change its frequency
>> >> > and we should deal with that. Or it could be an ideal clock that always
>> >> > returns the rate you ask for. Or a firmware clock that behaves like an
>> >> > ideal clock but lies about it :)
>> >> >
>> >> > It's that clock responsibility to do its best to provide the rate we ask
>> >> > for.
>> >> >
>> >> > And if we need to make it behave better, then it's fine too. So your
>> >> > example is indeed true, but it's more of a case of "let's send another
>> >> > patch" rather than trying to figure out all possible cases and try to
>> >> > figure things out accordingly. Because you won't be able to figure out
>> >> > all possible cases for the current SoCs and the next ones, and the
>> >> > workloads that people are going to run on those SoCs anyway.
>> >> >
>> >> >> >> If you carefully look at ccu_mp, you will see that it would ignore
>> >> >> >> cases when its parent had rounded up. ccu_nkm is no different.
>> >> >> >> Teaching all of sunxi-ng's clocks to respect ROUND_CLOSEST is a
>> >> >> >> totally different beast. For now, sunxi-ng always expects rounding
>> >> >> >> down.
>> >> >> >
>> >> >> > Then change that?
>> >> >>
>> >> >> You told me that both over- and undershooting are fine when
>> >> >> determining the rate, *but also* "it's a bit context specific which one
>> >> >> we should favour. If we were to do anything, it would be to support both
>> >> >> and let the clock driver select which behaviour it wants." (see
>> >> >> https://lore.kernel.org/all/flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq/)
>> >> >>
>> >> >> So, I can't just change NKM's parent's default behavior (which is an NM
>> >> >> clock in my case), because, if I understand correctly, I would have to
>> >> >> introduce a "ROUND_CLOSEST" flag for NM clocks.
>> >> >
>> >> > Sure
>> >> >
>> >> >> But then I feel like I would have to document somewhere that when
>> >> >> setting CLK_SET_RATE_PARENT for an NKM clock, that the parent clock
>> >> >> needs to ROUND_CLOSEST, in order to avoid drifting away from the
>> >> >> requested rate in the successive calls that are made to
>> >> >> ccu_nkm_determine_rate(), which I tried to explain above and in previous
>> >> >> messages.
>> >> >
>> >> > That's kind of what I meant too. Whether "drifting away" is an issue is
>> >> > context specific too. for some clocks it just doesn't matter. Nobody
>> >> > ever complained that the register clock of the MMC controller was
>> >> > drifting away, because it doesn't affect the system in the slightest.
>> >> >
>> >> > The video clock tree (and possibly others) will be affected though, and
>> >> > we'll indeed need to add that flag. But we're doing it all the time (and
>> >> > sometimes get it wrong) for things like which clocks should be left
>> >> > enabled for example.
>> >>
>> >> I'm afraid we have to re-visit this decision. I found a case, where the
>> >> drifting causes a problem.
>> >
>> > I'm sure it can cause a lot of issues everywhere. My point was that the
>> > solution is to add the flag so the issue goes away, and not to try to
>> > workaround a driver that might or not have the flag. We should assume
>> > it's properly set, and properly set it.
>>
>> I want you to be aware that this might result in a situation that will
>> waste many hours of development time for people trying to use the
>> SET_PARENT_RATE flag on NKM clocks in their SoCs. Because it has
>> surprising side effects that I lay out below.
>>
>> How do we tell developers that they *must* use CCU_ROUND closest on the
>> whole clk branch starting at whe nkm clock's parent if they want to use
>> SET_PARENT_RATE on a NKM clock.
>
> That's exagerating the issue a bit.

Where exactly do I exagerate? I don't see it. Don't you think it could
take hours?

> They will get from their parent the
> lower, closest, rate than they ask for that it can meet. This is what
> the framework has always guaranteed.

Yes, of course. But the consequences that come from the lower rate are
new. And really, *I* wouldn't expect a clock to ask its parent for a
rate that in reality doesn't want. That's what I find surprising. But
you already said you are fine with that. So I let it go, because it
meant that the rate of the nkm clock (and in consequence its children)
is just a little bit lower than expected. It's likely that no developer
(and certainly no end-user) would notice, so they might not chase a bug,
because they didn't get the exact rate they were expecting.

But then I discovered that the rate of tcon-data-clock is off by 33%. I
just wanted to let you know that it's no longer the tiny percentage that
we discussed previously. So people will notice and start (IMO
unnecessarily) chasing bugs. I'm still convinced that the 24 lines will
make those people's lifes easier.

But I accept that you don't see it that way.

> You want to change that, fine.

I want a good refresh rate for my pinephone's panel without relying on
third party patches. :) Therefore, I asked if it was okay to set the
rate of pll-video0 to 297MHz.

This was refused by Jernej who said it would be better if the rate
selection was immune to initial values [5]. My conclusion was that the
nkm clock should set its parent's rate. So, here we are.

> But now of course the parent might have
> to overshoot its target to meet that requirement. So the parent driver
> needs to be modified as such. That's very much the expectation.

Ok, that is of course your decision, not mine. I may not like it, but I
can certainly accept it.

>> They must do it from the beginning or they will need to start chasing
>> errors. This could easily prevented by applying this patch [1].
>>
>> Because, if they don't the following will happen:
>>
>> >> Setting pll-mipi's SET_PARENT_RATE flag, but not setting the tree's
>> >> CCU_FEATURE_CLOSEST_RATE flag results in the following tree:
>> >>
>> >>     clock                     rate
>> >>     -----------------------------------
>> >>     pll-video0                201000000
>> >>        hdmi-phy-clk            50250000
>> >>        hdmi                   201000000
>> >>        tcon1                  201000000
>> >>        pll-mipi               414562500
>> >>           tcon0               414562500
>> >>              tcon-data-clock  138187500
>> >>
>> >> Note, that tcon-data-clock's rate is garbage. It should be tcon0/4, but
>> >> it is tcon0/3.
>>
>> ^
>> |
>> Now, *that* is surprising, isn't it? Well at least for me it was. I set
>> the SET_PARENT_RATE on pll-mipi and suddenly tcon-data-clock is garbage.
>> How can that be?
>>
>> Ok, let's start debugging:
>>
>> >>
>> >> I added some logging to ccu_find_best*() to understand, as to why that
>> >> is:
>> >>
>> >>     ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
>> >>     ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
>> >>     ccu_nkm_find_best_with_parent_adj: rate=414577776, best_rate=414562500, best_parent_rate=201000000, n=11, k=3, m=16
>> >>     ccu_nkm_find_best_with_parent_adj: rate=414562500, best_rate=414562500, best_parent_rate=201000000, n=11, k=3, m=16
>> >>     ccu_nkm_find_best: rate=414562500, best_rate=414562500, parent_rate=201000000, n=11, k=3, m=16
>> >>
>> >> We can see that the rate is drifting over the successive calls. We've
>> >> seen it before and deemed it no big deal.
>> >>
>> >> To highlight the issue a bit more, I added some logging at the end of
>> >> sun4i_dclk_round_rate() and sun4i_dclk_set_rate.
>> >>
>> >>     ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
>> >>     sun4i_dclk_round_rate: rate=103650000, best_rate=103644444, best_parent=414577776, best_div=4
>> >>     ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
>> >>     sun4i_dclk_round_rate: rate=103650000, best_rate=103644444, best_parent=414577776, best_div=4
>> >>
>> >> Here we can see that sun4i_dclk now has determined that 103644444 is its
>> >> best rate, based on the parent rate of 414577776.
>> >>
>> >> But now, the nkm clock pll-mipi changes its mind and thinks that it
>> >> cannot provide 414577776 any more, instead it wants to provide
>> >> 414562500.
>> >
>> > That's a bit surprising, but not entirely.
>>
>> The drifting itself is not suprising at all to me. It is the topic of
>> this whole mail thread. :-)
>>
>> > For example, one of the
>> > parent clock of our parent might have changed rate between our
>> > round_rate and set_rate calls.
>>
>> That's not the reason here. The reason is that I added the
>> SET_PARENT_RATE flag, but did not add CCU_FEATURE_ROUND_CLOSEST to
>> pll-mipi's parent and all its descendants.
>>
>> *I* know, that I shouldn't do that. But will Jane and Joe SoC-Developer?
>
> How many Jane and Joe SoC-developer are writing a clock driver without
> any knowledge of how the clock framework operates?
>
>> How do we tell them? Will the necessary documentation really be easier
>> to maintain than the 24 line patch [1] I submitted?
>
> We have different perspectives on the issue. Yours is that it should be
> absolutely correct even if it isn't. I get where you're coming from.
>
> The thing is, from mine, yes, it's going to be much easier to maintain.
> Those 24 lines of code are fairly intricate, I had to exchange literally
> dozen of mails to get what it was about.

Yes, that's on me and I'm really sorry. But I do think, it's properly
documented now and has a good commit message as well. But ok, let's drop
it and instead document the fact that an nkm clock needs a parent that
is able to round up.

> Do you really expect us + Jane
> and Joe kernel developer to do as much when they read and try to
> understand that code? Let alone review another patch that would affect
> that code.
>
> And for all I know, you might be gone as soon as that patch is merged so
> we wouldn't get your help either.

Fair point. I hereby offer that you may include me in discussions about
all code in my patch series.

> FWIW, I'm open to adding that flag everywhere it's needed, not just on
> the A64.

Cool! I don't know where it's needed, as I don't have any other sunxi
boards, but still cool. :)

>> Again, without the patch NKM clocks are making assumptions about the
>> parent clock. They now depend on:
>>  a. The parent clock rounding to the closest requested rate.
>
> It doesn't depend on anything, really. It depends on the parent to
> provide a rate as close as possible to what was requested, but that was
> always the case.

No. As described below: If the panel requests 103650000 from tcon0, it
will get 138187500 if pll-video0 does not have the
CCU_FEATURE_CLOSEST_RATE flag set. Before my patch series that was not
the case. Therefore it now depends on the parent rounding to the closest
rate.

>>  b. The parent clock not supporting the rate the NKM requests.
>
> I'm not sure what you mean by that.

In the example below in step 9 the nkm will ask the parent for 282666665
Hz even though the nkm clock needs 282666666 Hz from its parent. So,
without the patch the nkm clock depends on the fact the parent will
round to 282666666 and not provide 282666665 Hz. That's what I mean when
I wrote that the nkm clock depends on "the parent clock not supporting
the rate the NKM requests". If the parent were an ideal clock that
always provides the rate that is requested, it breaks the nkm clock's
children (tcon-data-clock in case of the A64).

>> If either of the two is not true, it will break tcon-data-clock.
>>
>> > Why does it change its mind?
>>
>> Because the parent does not round to the closest rate.
>
> And it doesn't round to the closest rate because it's not expected to,
> or asked to.

No, the nkm clock does in fact *expect* the parent to round to the
closest rate. But if the parent is not *asked* to, it will break
tcon-data-clock.

>> This is what happens, if the parent does not fulfill the two
>> requirements:
>>
>>   1. tcon0 (or someone else, this is just an example) asks the NKM clock
>>      (pll-mipi) for rate A (e.g. 414600000).
>>   2. The NKM clock tries out all combinations of N, K, and M and each
>>      time asks the parent for a rate, that is close to the "optimal"
>>      parent rate.
>>   3. At some point the NKM clock asks its parent for rate B (282681818).
>>   4. The parent will respond that it doesn't support rate B, but rate B'
>>      (282666666) could be used.
>>   5. Using that information, NKM tells the clk framework that it can't
>>      provide rate A (414600000), but it could provide A' (414577776).
>>   6. The clk framework tells tcon0 that. tcon0 agrees and says: "Fine,
>>      clk framework, let's go with rate A'."
>>   7. clk framework asks the NKM clock, for rate A' (414577776).
>>   8. Like in step 2 the NKM goes through all combinations and asks the
>>      parent for a rate that is optimal to the "optimal" parent rate.
>>   9. Without the patch [1] at some point the NKM clock will ask the
>>      parent for B'' (282666665) (!) due to integer rounding.
>>  11. The parent will respond that it doesn't support rate B'', but rate
>>      B''' could be used. (I don't know what rate that is, but it's now
>>      so bad that the previous combination of N, K, and M is no longer
>>      the best combination.)
>>  12. Using that information, NKM tells the clk framework that it can't
>>      provide rate A' (414577776), but it could provide A'' (414562500).
>>      That's what I meant, that the nkm clock "changed its mind".
>>
>> Actually, steps 7-12 are performed a few times and each time the rate
>> could get a little bit worse. Not by much, so you said it's not worth
>> adding patch [1], because "there's zero benefit from it". [2]
>>
>> The new information I'm trying to convey here, is that tcon0 has based
>> its round_rate result on A' because the clk framework told it so.
>> Apparently, the clk framework expects that when a clock claims it can
>> provide rate A' when asked for rate A, that it will also respond with A'
>> when asked for A'.
>
> Yeah, that sounds reasonable. I'm afraid tackling this for all our
> clocks would be a major overhaul so I would consider this to be out of
> scope if we ever want to get this series merged.

Okay, I wasn't aware of that. I'm fairly certain that at least the nkm
clock provides rate A' when asked for A' when the SET_PARENT_RATE flag
is not set. So, this behavior is something that is introduced by my
patch series (if you don't take PATCH 4 [1]).

I've submitted a patch [4] with integration tests that tests all
possible exact rates of an nkm clock with a parent that runs at 192MHz
(just as an example). This is a patch on top of sunxi/for-next, i.e. it
does not contain the patch series we're currently discussing [3]. The
nkm clock consistently provides the requested rate if the requested rate
is something that the parent can provide. That means, up until today's
sunxi/for-next the nkm clock fulfills the reasonable requirenment.

In conclusion, the nkm clock becomes a bad player within the clk
framework if the series [3] is applied and [4] is dropped in cases where
the nkm clock's parent does not have the CCU_FEATURE_CLOSEST_RATE set.
This should be documented somewhere.

>> I don't think that's an unreasonable requirement for clocks [footnote
>> A]. But the NKM clock does not always fulfill it, if it can set its
>> parent rate but doesn't have patch [1].
>>
>> This is not some kind of race condition as you described above. It
>> happens 100% of the time when a clock (tcon0) asks an nkm clock
>> (pll-mipi) for an "unfortunate" rate and the nkm's parent (pll-video0)
>> does not support rounding up.
>
> Which, again, has a super simple fix now.

Sure! The fix is to set CCU_FEATURE_CLOSEST_RATE on the parent, right?
But we can't say that the SET_PARENT_FLAG for nkm clocks works without
the parent having CCU_FEATURE_CLOSEST_RATE.

>> "Unfortunate" is a rate where the best parent rate can not be calculated
>> by the simple formula:
>>     rate * m / (n * k)
>>
>> You wrote in [2]:
>> > We're back to the trade-off I was mentioning earlier. I'm not against
>> > it on principle. However, if it's not absolutely required, then I
>> > don't think it's a good idea to merge it.
>> >
>> > Especially if it's to workaround a parent flag missing. A clock flag
>> > patch is easy to read, write, understand, review, merge and maintain.
>> > It's basically a nop to merge provided the commit log is decent
>> > enough.
>>
>> I'm at a point where I have to disagree that a clock flag patch is easy
>> to write and understand. You asked me, why the clock is changing its
>> mind and we had already discussed it a lot. I don't see why this
>> discussion would be different in 6 months or 2 years. IMO the discussion
>> we're having is not a "nop". And for a developer to find out that they
>> need to set the parent's ROUND_CLOSEST flag is not a "nop" either.
>
> You're talking about identifying a given problem. I was talking about
> finding, writing, merging and maintaining a solution for it. I know all
> too well how difficult identifying clock issues can be.
>
>> The patch [1] makes the life of SoC developers easier
>
> Unless they have to debug or modify it.
>
>> while it makes the nkm clock maintainer's life harder.
>
> Let's not create any undue opposition, there's no need to. Developers
> end up doing some part of the maintenance when they identify and fix
> bugs and maintainers are usually the most active developers. It's not
> like either are in some kind of ivory tower.
>
>> So the question is, how much easier is the developer's life (a lot,
>> IMO) and how much harder is the maintainer's life (a little, IMO).
>
> We strongly disagree on that.

Yes, we do.

>> In conclusion, for me applying patch [1] is the best option we have. It
>> not only prevents but also documents the issue in a clean way.
>
> And I disagree with that too. It might be for you, but all that is subjective.

Allright. I understand that you are fine that the nkm's SET_PARENT_RATE
depends on the parent having CCU_FEATURE_CLOSEST_RATE.

Do you have a suggestion, where I could document that
expectation? I'm thinking about adding a few sentences to the
existing description of struct ccu_nkm in ccu_nkm.h.

Thanks,
  Frank

[1]: https://lore.kernel.org/all/20230717-pll-mipi_set_rate_parent-v4-3-04acf1d39765@oltmanns.dev/
[2]: https://lore.kernel.org/all/yj6ss64s7p2uaslodj5zklrwhegz54bgh4l4wmldv6cccggepz@yombds4hij3c/
[3]: https://lore.kernel.org/all/20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev/
[4]: https://lore.kernel.org/all/20230730-nkm_clk_tests-v1-1-ed4aad26a815@oltmanns.dev/
[5]: https://lore.kernel.org/all/4831731.31r3eYUQgx@jernej-laptop/

> Maxime
>
> [[End of PGP Signed Part]]
