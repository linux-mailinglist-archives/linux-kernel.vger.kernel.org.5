Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24CA76C7FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjHBIHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjHBIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:07:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CB7E0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:07:30 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qR6tE-0006Bv-5v; Wed, 02 Aug 2023 10:07:28 +0200
Message-ID: <ed9a0b64-b7e7-7735-85f7-d688a3b8e89e@leemhuis.info>
Date:   Wed, 2 Aug 2023 10:07:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel regression tracking/reporting initiatives and KCIDB
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        kernelci@lists.linux.dev, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
References: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690963650;cd605ebb;
X-HE-SMSGID: 1qR6tE-0006Bv-5v
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.23 13:47, Ricardo Cañuelo wrote:
> 
> I'm Ricardo from Collabora. In the past months, we’ve been analyzing the
> current status of CI regression reporting and tracking in the Linux
> kernel: assessing the existing tools, testing their functionalities,
> collecting ideas about desirable features that aren’t available yet and
> sketching some of them.

Thx for your mail.

Side note: I wonder how many people are interested in this topic and if
it would be a good idea to have a session about it at the kernel summit
on this years LPC; there afaik are still a few days left to submit a
session about this; or did somebody already do this?

But FWIW, I'm currently taken back and forth if I want to make the trip
to the US; as things stand currently I likely won't go. Anyway, back to
your mail.

> As part of this effort, we wrote a Regression Tracker tool [1] as a
> proof of concept. It’s a rather simple tool that takes existing
> regression data and reports and uses them to show more context on each
> reported regression, as well as highlighting the relationships between
> them, whether they can be caused by an infrastructure error and other
> additional metadata about their current status.  We’ve been using it
> mostly as a playground for us to explore the current status of the
> functionalities provided by CI systems and to test ideas about new
> features.

/me wanted to say "might be good to call it KernelCI regression tracker
instead to avoid confusion", but then saw that the page behind the the
url "[1]" above already calls it exactly that :-D

> We’re also checking other tools and services provided by the community,
> such as regzbot [2], collaborating with them when possible and thinking
> about how to combine multiple scattered efforts by different people
> towards the same common goal. As a first step, we’ve contributed to
> regzbot and partially integrated its results into the Regression Tracker
> tool.

thx again for those contributions!

> So far, we’ve been using the KernelCI regression data and reports as > data source, we're now wondering if we could tackle the problem with a
> more general approach by building on top of what KCIDB already provides.

That's more your area of expertise, but I have to wonder: doesn't that
mainly depend on what the people/projects want which feed their test
results into KCIDB? I had expected some of them might already have
something to stay on top of regressions found by their systems, to at
least ensure they notice and fix tests that broke for external reasons
-- e.g. a test script going sideways, faulty hardware, a network
miss-configuration or others things which naturally will occur in this
line of work.

> In general, CI systems tend to define regressions as a low-level concept
> which is rather static: a snapshot of a test result at a certain point
> in time. When it comes to reporting them to developers, there's much
> more info that could be added to them.

I wonder if it should be s/could/should/ here, as *if I* would be
running CI systems I'd fear that developers sooner or later might start
ignoring more and more of the reports my systems sends when too many of
them turn out to be bogus/misleading -- which naturally will happen for
various reasons you outlined below yourself (broken
hardware/test/network/...) (and seem to happen regularly, as mentioned
in https://lwn.net/Articles/939538/ ).

That doesn't mean that I think each failed test should be judged by a
human before it's sent to the developers. Compile errors for example
will be helpful often right away, especially for stable-rc.

> In particular, the context of it
> and the fact that a reported regression has a life cycle:
> 
> - did this test also fail on other hardware targets or with other kernel
>   configurations?
> - is it possible that the test failed because of an infrastructure
>   error?
> - does the test fail consistently since that commit or does it show
>   unstable results?
> - does the test output show any traces of already known bugs?
> - has this regression been bisected and reported anywhere?
> - was the regression reported by anyone? If so, is there someone already
>   working on it?
>
> Many of these info points can be extracted from the CI results databases
> and processed to provide additional regression data. That’s what we’re
> trying to do with the Regression Tracker tool, and we think it’d be
> interesting to start experimenting with the data in KCIDB to see how
> this could be improved and what would be the right way to integrate this
> type of functionality.

I (with my likely somewhat biased view due to regzbot and my work with
it) wonder if we have two aspects here that might be wise to keep separated:

* tests suddenly failing in one or multiple CI systems, which might be
due to something going sideways in the tests or a real kernel regression

* regressions found by individuals or CI systems where a human with some
knowledge about the kernel did a sanity check (and also looked for
duplicates) to ensure this most likely is a regression that should be
acted upon -- and thus is also something that definitely should not be
forgotten.

Your regression tracking tool could be the former, regzbot the latter
(which could feed the outcome back to the CI regression tracking
system). But as I said, my view is obviously biased, so maybe I'm to
blinded to see a better solution.

> [1] https://kernel.pages.collabora.com/kernelci-regressions-tracker/
> [2] https://linux-regtracking.leemhuis.info/regzbot/all/

Ciao, Thorsten
