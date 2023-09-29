Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD4D7B31B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjI2Lq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjI2Lqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:46:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE28B1B4;
        Fri, 29 Sep 2023 04:46:36 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qmBx0-00054T-AZ; Fri, 29 Sep 2023 13:46:30 +0200
Message-ID: <89dded30-d250-4b7a-b5a8-b18e3b509bf1@leemhuis.info>
Date:   Fri, 29 Sep 2023 13:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in linux-stable
Content-Language: en-US, de-DE
To:     Florian Westphal <fw@strlen.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Timo Sigurdsson <public_timo.s@silentcreek.de>,
        kadlec@netfilter.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashal@kernel.org, carnil@debian.org,
        1051592@bugs.debian.org
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
 <ZP+bUpxJiFcmTWhy@calendula>
 <b30a81fa-6b59-4bac-b109-99a4dca689de@leemhuis.info>
 <20230912102701.GA13516@breakpoint.cc>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230912102701.GA13516@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695987996;3a87d281;
X-HE-SMSGID: 1qmBx0-00054T-AZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.23 12:27, Florian Westphal wrote:
> Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>> On 12.09.23 00:57, Pablo Neira Ayuso wrote:
>>> Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
>>> kernel check that rejects adding rules to bound chains. The incorrect
>>> bytecode adds the chain binding, attach it to the rule and it adds the
>>> rules to the chain binding. I have cherry-picked these three patches
>>> for nftables v1.0.6 userspace and your ruleset restores fine.
>>> [...]
>>
>> Hmmmm. Well, this sounds like a kernel regression to me that normally
>> should be dealt with on the kernel level, as users after updating the
>> kernel should never have to update any userspace stuff to continue what
>> they have been doing before the kernel update.
> 
> This is a combo of a userspace bug and this new sanity check that
> rejects the incorrect ordering (adding rules to the already-bound
> anonymous chain).
> 
> nf_tables uses a transaction allor-nothing model, this means that any
> error that occurs during a transaction has to be reverse/undo all the
> pending changes.  This has caused a myriad of bugs already.
> 
> So while this can be theoretically fixed in the kernel I don't see
> a sane way to do it.  Error unwinding / recovery from deeply nested
> errors is already too complex for my taste.
> 
>> Can't the kernel somehow detect the incorrect bytecode and do the right
>> thing(tm) somehow?
> 
> Theoretically yes, but I don't feel competent enough to do it, just look
> at all the UaF bugs of the past month.

Thx for the answer. FWIW, as this was a judgement call I mentioned this
in my last regression report to Linus; he didn't reply, so I guess it is
-- and will remove this issue from my tracking:

#regzbot resolve: can be solved by a nftables userspace update; not
nice, but likely best solution in this case
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
