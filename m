Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA61575BE95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGUGQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGUGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:15:35 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A0749E2;
        Thu, 20 Jul 2023 23:13:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qMjM0-0000FE-Vr; Fri, 21 Jul 2023 08:11:05 +0200
Message-ID: <421602e6-0fe0-34c4-12bb-d805f2a282f4@leemhuis.info>
Date:   Fri, 21 Jul 2023 08:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: 6.4.4 breaks module-free builds of Debian kernel packages
Content-Language: en-US, de-DE
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Brian Lindholm <brian_lindholm@users.sourceforge.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
References: <e7292802-e517-6469-6fbd-a4d30887c99b@gmail.com>
 <63a46a4e-53d4-6d18-7f6e-fee1c9890c79@infradead.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <63a46a4e-53d4-6d18-7f6e-fee1c9890c79@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689919995;b90addbf;
X-HE-SMSGID: 1qMjM0-0000FE-Vr
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.23 06:13, Randy Dunlap wrote:
> On 7/20/23 20:18, Bagas Sanjaya wrote:
>>
>>> I'm on AMD64 with Debian testing (trixie), where I build my own kernels (with CONFIG_MODULES unset) using "make bindeb-pkg". The build proceeds through 99% of the process, but fails here:
>>>
> [...]
>>>
>>> 6.3.13 contained the same error, but I "fixed" that by moving to 6.4.3.  But alas, 6.4.4 now has the same issue.
>>>
>>> I worked around the issue by changing "exit 1" to "exit 0" in the main Makefile (at "modules module_install", per the attached patch), but I don't know if this is a true fix or something that simply happens to work for my particular configuration.
>>
>> See Bugzilla for the full thread and attached patch that ignores the error.
>>
>> Josh: It looks like this regression is caused by a commit of yours
>> (and also 1240dabe8d58b4). Would you like to take a look on it?
>>
>> Anyway, I'm adding this regression to be tracked by regzbot:
>>
>> #regzbot introduced: 4243afdb932677 https://bugzilla.kernel.org/show_bug.cgi?id=217689
>> #regzbot title: always doing modules_install breaks CONFIG_MODULES=n builds

Masahiro Yamada: thx for taking care of this and Greg for picking the
fix up.

BTW, Bagas, this apparently is a regression that only affected stable.
In that case please tell rezbot about the stable commit-id of the
change, as otherwise it will consider the problem a regression in
mainline (and there it's was never a problem or already solved [didn't
look]).

Let me fix this up and tell regzbot about the incoming fix while at it:

#regzbot introduced: 6061ac50f1e04
#regzbot fix: kbuild: make modules_install copy modules.builtin(.modinfo)

>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217689
> 
> Do you also take care of marking the bugzilla entries as completed/fixed/solved
> etc.?

I don't known if Bagas does, but I do not and have no plans to do so.

I consider my work on looking at bugzilla for regressions a courtesy I
perform in the interest of the "no regressions" rule, as some or many of
those report otherwise will be ignored. And that's bad for our reputation.

But that is where my courtesy stops. Those that think having a bugzilla
around should take care of maintaining the state. Bugbot might soon
solve part of the problem. But I guess it won't handle this case.

Ciao, Thorsten
