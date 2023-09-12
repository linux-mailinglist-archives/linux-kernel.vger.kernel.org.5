Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730F679D03F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjILLkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjILLkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:40:11 -0400
Received: from dd20004.kasserver.com (dd20004.kasserver.com [85.13.150.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6468BBE;
        Tue, 12 Sep 2023 04:40:02 -0700 (PDT)
Received: from dd20004.kasserver.com (dd0804.kasserver.com [85.13.146.35])
        by dd20004.kasserver.com (Postfix) with ESMTPSA id 8F8B26321005;
        Tue, 12 Sep 2023 13:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silentcreek.de;
        s=kas202306171005; t=1694518799;
        bh=UrbQBqd8zMpLmeGK23sKwCxYqAihgygn61K/bBr1bGs=;
        h=Subject:To:References:Cc:From:In-Reply-To:Date:From;
        b=cn0C0vw94X2JRKKegIgoHqYuGPWIRMuiFhGrd+8SqrDCQox3OpTxTZQFwTXIB3MPK
         HvkT1urbRT/uB5BNQ69MNapFhhl36sBoIKx2b+3awAEuQAOKmemGj04Zccp9/SE0tO
         lei5q2l1Ot5YJ8kRMC5T1T9FV+GNu+zmlMJgXnOMyrWVDJUvvelpHG7r0Xq4GJ5e2g
         fuzCJ9k59v9mrZJBcczWfooMR7LvDKVIZCAQqN4/3dC6/WmzZe2yIVemL1suWNe8SK
         apVM6Mlk3MazTsTJx9KFekyr2mwFraGDxypZwcliaaQT6xucOQwg/oLBd0mqknxsLy
         3bF1pnZQUnzWQ==
Subject: Re: Regression: Commit "netfilter: nf_tables: disallow rule addition
 to bound chain via NFTA_RULE_CHAIN_ID" breaks ruleset loading in linux-stable
To:     pablo@netfilter.org
References: <20230911213750.5B4B663206F5@dd20004.kasserver.com><ZP+bUpxJiFcmTWhy@calendula>
Cc:     kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev,
        sashal@kernel.org, carnil@debian.org, 1051592@bugs.debian.org
From:   "Timo Sigurdsson" <public_timo.s@silentcreek.de>
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 89.246.188.214
MIME-Version: 1.0
In-Reply-To: <ZP+bUpxJiFcmTWhy@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20230912113959.8F8B26321005@dd20004.kasserver.com>
Date:   Tue, 12 Sep 2023 13:39:59 +0200 (CEST)
X-Spamd-Bar: /
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pablo,

Pablo Neira Ayuso schrieb am 12.09.2023 00:57 (GMT +02:00):

> Hi Timo,
> 
> On Mon, Sep 11, 2023 at 11:37:50PM +0200, Timo Sigurdsson wrote:
>> Hi,
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
>> /etc/nftables.conf:99:4-44: Error: Could not process rule: Operation not
>> supported
>>                         tcp option maxseg size 1-500 counter drop
>>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> /etc/nftables.conf:308:4-27: Error: Could not process rule: Operation not
>> supported
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

hmm, that doesn't explain why Salvatore didn't observe this with more recent kernels.

Salvatore, did you use newer userspace components when you tested your 6.4.13 and 6.5.2 builds?

As for the regression and how it be dealt with: Personally, I don't really care whether the regression is solved in the kernel or userspace. If everybody agrees that this is the best or only viable option and Debian decides to push a nftables update to fix this, that works for me. But I do feel the burden to justify this should be high. A kernel change that leaves users without a working packet filter after upgrading their machines is serious, if you ask me. And since it affects several stable/longterm trees, I would assume this will hit other stable (non-rolling) distributions as well, since they will also use older userspace components (unless this is behavior specific to nftables 1.0.6 but not older versions). They probably should get a heads up then.


Regards,

Timo
