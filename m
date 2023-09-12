Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DE79CA03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjILIdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjILIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:33:07 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95389B9;
        Tue, 12 Sep 2023 01:33:03 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qfypO-0003Kf-NB; Tue, 12 Sep 2023 10:32:58 +0200
Message-ID: <b30a81fa-6b59-4bac-b109-99a4dca689de@leemhuis.info>
Date:   Tue, 12 Sep 2023 10:32:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in linux-stable
Content-Language: en-US, de-DE
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Timo Sigurdsson <public_timo.s@silentcreek.de>
Cc:     kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        sashal@kernel.org, carnil@debian.org, 1051592@bugs.debian.org
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
 <ZP+bUpxJiFcmTWhy@calendula>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZP+bUpxJiFcmTWhy@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694507583;1f6f9fff;
X-HE-SMSGID: 1qfypO-0003Kf-NB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.23 00:57, Pablo Neira Ayuso wrote:
> On Mon, Sep 11, 2023 at 11:37:50PM +0200, Timo Sigurdsson wrote:
>>
>> recently, Debian updated their stable kernel from 6.1.38 to 6.1.52
>> which broke nftables ruleset loading on one of my machines with lots
>> of "Operation not supported" errors. I've reported this to the
>> Debian project (see link below) and Salvatore Bonaccorso and I
>> identified "netfilter: nf_tables: disallow rule addition to bound
>> chain via NFTA_RULE_CHAIN_ID" (0ebc1064e487) as the offending commit
>> that introduced the regression. Salvatore also found that this issue
>> affects the 5.10 stable tree as well (observed in 5.10.191), but he
>> cannot reproduce it on 6.4.13 and 6.5.2.
>>
>> The issue only occurs with some rulesets. While I can't trigger it
>> with simple/minimal rulesets that I use on some machines, it does
>> occur with a more complex ruleset that has been in use for months
>> (if not years, for large parts of it). I'm attaching a somewhat
>> stripped down version of the ruleset from the machine I originally
>> observed this issue on. It's still not a small or simple ruleset,
>> but I'll try to reduce it further when I have more time.
>>
>> The error messages shown when trying to load the ruleset don't seem
>> to be helpful. Just two simple examples: Just to give two simple
>> examples from the log when nftables fails to start:
>> /etc/nftables.conf:99:4-44: Error: Could not process rule: Operation not supported
>>                         tcp option maxseg size 1-500 counter drop
>>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> /etc/nftables.conf:308:4-27: Error: Could not process rule: Operation not supported
>>                         tcp dport sip-tls accept
>>                         ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I can reproduce this issue with 5.10.191 and 6.1.52 and nftables v1.0.6,
> this is not reproducible with v1.0.7 and v1.0.8.
> 
>> Since the issue only affects some stable trees, Salvatore thought it
>> might be an incomplete backport that causes this.
>>
>> If you need further information, please let me know.
> 
> Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
> kernel check that rejects adding rules to bound chains. The incorrect
> bytecode adds the chain binding, attach it to the rule and it adds the
> rules to the chain binding. I have cherry-picked these three patches
> for nftables v1.0.6 userspace and your ruleset restores fine.
> [...]

Hmmmm. Well, this sounds like a kernel regression to me that normally
should be dealt with on the kernel level, as users after updating the
kernel should never have to update any userspace stuff to continue what
they have been doing before the kernel update.

Can't the kernel somehow detect the incorrect bytecode and do the right
thing(tm) somehow?

But yes, don't worry, I know that reality is not black and white and
that it's crucial that things like package filtering do exactly what the
user expect it to do; that's why this might be one of those rare
situations where "user has to update userspace components to support
newer kernels" might be the better of two bad choices. But I had to ask
to ensure it's something like that.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
