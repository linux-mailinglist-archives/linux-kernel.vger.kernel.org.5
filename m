Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C197A285D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjIOUpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjIOUok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:44:40 -0400
Received: from dd20004.kasserver.com (dd20004.kasserver.com [85.13.150.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAED818D;
        Fri, 15 Sep 2023 13:44:31 -0700 (PDT)
Received: from dd20004.kasserver.com (dd0806.kasserver.com [85.13.161.252])
        by dd20004.kasserver.com (Postfix) with ESMTPSA id 37CC96320BA2;
        Fri, 15 Sep 2023 22:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silentcreek.de;
        s=kas202306171005; t=1694810669;
        bh=GTAOtFXfmJE5tMJE+b2ZF9kJaBinx/6Zrq5uUHmsRiY=;
        h=Subject:To:References:Cc:From:In-Reply-To:Date:From;
        b=MLShIkK3WmQ5Jthg3oQker3OrjJzHIR+RHpiZ+vylYdomMeOjvP8EVCmtaqBAkcrk
         NxCUHrpC8HrGnQOjvCcy2iBzQEgDq+HCJvOqHFPp7JxVsCW7lhgfin93Kxvxu9nw5H
         qfVF8j/GIAt/1Sx9UGQWHHJ1/8AUqDxgRfMmvxUoV/hh6mV+xALtgFRJKW0mdmpdjq
         oC/vaQExav7xH4AItkRgx81Wm+/J+goaJzeIv+cW1uwhGH51tudeayMBPiqWvPGWk7
         HUCPNKkG56jozD+SP1EqtWvHVWLGdfRkaEpSNW7KB70+XPjnzv0OZH55eShLF9mG7W
         nXSjDMjZ2qEXw==
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in linux-stable
To:     carnil@debian.org
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com>
 <ZP+bUpxJiFcmTWhy@calendula>
 <20230912113959.8F8B26321005@dd20004.kasserver.com><ZQC4bcVVK99Q8WrO@eldamar.lan>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, sashal@kernel.org,
        1051592@bugs.debian.org, arturo@debian.org
From:   "Timo Sigurdsson" <public_timo.s@silentcreek.de>
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 89.246.185.100
MIME-Version: 1.0
In-Reply-To: <ZQC4bcVVK99Q8WrO@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230915204429.37CC96320BA2@dd20004.kasserver.com>
Date:   Fri, 15 Sep 2023 22:44:29 +0200 (CEST)
X-Spamd-Bar: /
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Salvatore Bonaccorso schrieb am 12.09.2023 21:13 (GMT +02:00):

> Hi Timo,
> 
> On Tue, Sep 12, 2023 at 01:39:59PM +0200, Timo Sigurdsson wrote:
>> Hi Pablo,
>> 
>> Pablo Neira Ayuso schrieb am 12.09.2023 00:57 (GMT +02:00):
>> 
>> > Hi Timo,
>> > 
>> > On Mon, Sep 11, 2023 at 11:37:50PM +0200, Timo Sigurdsson wrote:
>> >> Hi,
>> >> 
>> >> recently, Debian updated their stable kernel from 6.1.38 to 6.1.52
>> >> which broke nftables ruleset loading on one of my machines with lots
>> >> of "Operation not supported" errors. I've reported this to the
>> >> Debian project (see link below) and Salvatore Bonaccorso and I
>> >> identified "netfilter: nf_tables: disallow rule addition to bound
>> >> chain via NFTA_RULE_CHAIN_ID" (0ebc1064e487) as the offending commit
>> >> that introduced the regression. Salvatore also found that this issue
>> >> affects the 5.10 stable tree as well (observed in 5.10.191), but he
>> >> cannot reproduce it on 6.4.13 and 6.5.2.
>> >> 
>> >> The issue only occurs with some rulesets. While I can't trigger it
>> >> with simple/minimal rulesets that I use on some machines, it does
>> >> occur with a more complex ruleset that has been in use for months
>> >> (if not years, for large parts of it). I'm attaching a somewhat
>> >> stripped down version of the ruleset from the machine I originally
>> >> observed this issue on. It's still not a small or simple ruleset,
>> >> but I'll try to reduce it further when I have more time.
>> >> 
>> >> The error messages shown when trying to load the ruleset don't seem
>> >> to be helpful. Just two simple examples: Just to give two simple
>> >> examples from the log when nftables fails to start:
>> >> /etc/nftables.conf:99:4-44: Error: Could not process rule: Operation not
>> >> supported
>> >>                         tcp option maxseg size 1-500 counter drop
>> >>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> >> /etc/nftables.conf:308:4-27: Error: Could not process rule: Operation not
>> >> supported
>> >>                         tcp dport sip-tls accept
>> >>                         ^^^^^^^^^^^^^^^^^^^^^^^^
>> > 
>> > I can reproduce this issue with 5.10.191 and 6.1.52 and nftables v1.0.6,
>> > this is not reproducible with v1.0.7 and v1.0.8.
>> > 
>> >> Since the issue only affects some stable trees, Salvatore thought it
>> >> might be an incomplete backport that causes this.
>> >> 
>> >> If you need further information, please let me know.
>> > 
>> > Userspace nftables v1.0.6 generates incorrect bytecode that hits a new
>> > kernel check that rejects adding rules to bound chains. The incorrect
>> > bytecode adds the chain binding, attach it to the rule and it adds the
>> > rules to the chain binding. I have cherry-picked these three patches
>> > for nftables v1.0.6 userspace and your ruleset restores fine.
>> 
>> hmm, that doesn't explain why Salvatore didn't observe this with
>> more recent kernels.
>> 
>> Salvatore, did you use newer userspace components when you tested
>> your 6.4.13 and 6.5.2 builds?
> 
> It does explain now because understanding the issue better. While one
> while experinting should only change each one constraint for the
> 6.4.13 and 6.5.2 testing I indeed switched to a Debian unstable
> system, which has newer userpace nftables and so not triggering the
> issue. This was missleading for the report.
> 
>> As for the regression and how it be dealt with: Personally, I don't
>> really care whether the regression is solved in the kernel or
>> userspace. If everybody agrees that this is the best or only viable
>> option and Debian decides to push a nftables update to fix this,
>> that works for me. But I do feel the burden to justify this should
>> be high. A kernel change that leaves users without a working packet
>> filter after upgrading their machines is serious, if you ask me. And
>> since it affects several stable/longterm trees, I would assume this
>> will hit other stable (non-rolling) distributions as well, since
>> they will also use older userspace components (unless this is
>> behavior specific to nftables 1.0.6 but not older versions). They
>> probably should get a heads up then.
> 
> So if it is generally believed on kernel side there should not happen
> any further changes to work with older userland, I guess in Debian we
> will need to patch nftables. I'm CC'ing Arturo Borrero Gonzalez
> <arturo@debian.org>, maintainer for the package. The update should go
> ideally in the next point releases from October (and maybe released
> earlier as well trough the stable-updates mechanism).

So, I built nftables 1.0.6-2+deb12u1 with the three cherry-picked patches from Pablo and can confirm that they resolve the issue for me on bookworm. I can now run linux 6.1.52-1 and load my original nftables ruleset again.
 
> FWIW: In Debian bullseye we have 0.9.8 based nftables, in bookworm
> 1.0.6, so both will need those fixes.
> 
> As 0ebc1064e487 is to address CVE-2023-4147 other distros picking the
> fix will likely encounter the problem at some point. It looks Red Hat
> has taken it (some RHSA's were released), I assume Ubuntu will shortly
> as well release USN's containing a fix.

SUSE has also picked this patch for SLES/SLED. I hope maintainers follow the mailing lists cc'ed here or that someone gives them a heads up before this hits more production systems.

Thanks and regards,

Timo
