Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5697531E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjGNGYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjGNGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:24:43 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D22D57;
        Thu, 13 Jul 2023 23:24:41 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qKCEI-0004vU-Ix; Fri, 14 Jul 2023 08:24:38 +0200
Message-ID: <f61a12c6-9587-9cb4-122e-dc3a74e58bd1@leemhuis.info>
Date:   Fri, 14 Jul 2023 08:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
To:     Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20230713223432.1501133-1-kuba@kernel.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
In-Reply-To: <20230713223432.1501133-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1689315881;382a6c3c;
X-HE-SMSGID: 1qKCEI-0004vU-Ix
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.23 00:34, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.

thx for working on this, much appreciated.

> [...] 
> +Bug reports
> +-----------
> +
> +Maintainers must respond to and address bug reports. The bug reports
> +range from users reporting real life crashes, thru errors discovered
> +in fuzzing to reports of issues with the code found by static analysis
> +tools and new compiler warnings.
> +
> +Volunteer maintainers are only required to address bugs and regressions.
> +It is understood that due to lack of access to documentation and
> +implementation details they may not be able to solve all problems.
> +
> +Commercial vendors are expected to address all issues, on any reasonable
> +platform supported by the Linux kernel, as well as answer ordinary user
> +questions. There is no concept of product End-of-Life in the Linux kernel,
> +the support is required until the subsystem maintainer deletes the code.
> +
> +The volunteer vs commercial vendor distinction could be seen as roughly
> +corresponding to the *Maintained* and *Supported* statuses of the codebase
> +in the MAINTAINERS file.

The first sentence sets a pretty high bar -- one that afaics doesn't
match current practices, as I frequently see maintainers from commercial
vendors ignoring bad and some good bugs reports (like many reports from
CI systems or report that lack in quality). Without any consequences in
the community afaics, unless they ignore a lot of the good bug reports
or repeatedly ignore regressions reports that reached a certain quality
level (really bad ones are ignored as well and I don't really blame
anyone for that).

Also: It's totally normal that commercial vendor contribute basic
drivers with known problems and missing features (some of which will
never be implemented). The latter will be considered a "bug" for quite a
few users that read this. Those suddenly thus might becomes something
they now "must" fix, which leads to questions: how fast? just in
mainline, or in stable, too?

All this also opens questions like "what counts as bug report" -- I'd
assume users that find and read this will expect that a report in
bugzilla.kernel.org is one maintainers "must" respond to. But I assume
you only meant bugs reports by mail or in trackers the MAINTAINERS file
mentions?

And overall I don't really like the way how handling of regressions is
described in that section, as they afaics are expected to be handled
with a higher priority than bugs.

I considered writing something new, but I now feel a bit confused, as
I'm unsure if my world view is off and yours closer to the proper one.
FWIW, I recently published something[1] related that tries to explain to
ordinary users why their bug report might be ignored. It round about
shows my understanding of things:

```
Developers in the scope of the Linux kernel are considered volunteers
that don't owe you anything
---------------------------------------------------------------------
---------------------------

In the scope of upstream Linux kernel development all developers are
considered volunteers – and as such obviously free to decide what to
spend their time on.

That's because developers in the end fall into two groups:

    Companies, universities, government agencies, and other institutions
contribute voluntarily through employees, contractors, students, et. al.

    Individuals contribute voluntarily in their own time.

Not even Linus Torvalds has a handle to make those do something he
wishes, except his reputation and control over what is merged into
mainline. That allows him to motivate and occasionally even compel those
volunteers to do something he wants to see – but even for him that only
works up to some point, as those institutions and individuals otherwise
might stop contributing or even fork the Linux kernel.

That in principle is true even for regressions or severe bugs (e.g.
vulnerabilities, data loss, or hardware damage) – but developers or
maintainers will look into those to avoid a bad reputation, which would
cause trouble for future contributions or might cost them their rank.
That can also happen if developers regularly ignore decent bug reports –
which is among the reasons why developers usually help with them, too.
```

[1]
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

This was downplaying/ignoring the "commercial vendor" aspect on purpose.
I would do that differently for a document like this one.

Ciao, Thorsten
