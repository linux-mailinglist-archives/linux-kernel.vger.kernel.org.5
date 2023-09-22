Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CBE7AB05A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjIVLOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjIVLOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:14:21 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F1DFB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:14:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qje6w-0008RG-6E; Fri, 22 Sep 2023 13:14:14 +0200
Message-ID: <d44b0746-2aa6-4608-ab22-bcb9efb27a26@leemhuis.info>
Date:   Fri, 22 Sep 2023 13:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695381255;104e41e4;
X-HE-SMSGID: 1qje6w-0008RG-6E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 20.09.23 10:11, Jeremi Piotrowski wrote:
> On Sun, Sep 17, 2023 at 09:12:40PM +0200, Greg Kroah-Hartman wrote:
>> 6.1-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
> 
> Hi Greg/Michal,
> 
> This commit breaks userspace which makes it a bad commit for mainline and an
> even worse commit for stable.
> 
> We ingested 6.1.54 into our nightly testing and found that runc fails to gather
> cgroup statistics (when reading kmem.limit_in_bytes). The same code is vendored
> into kubelet and kubelet fails to start if this operation fails. 6.1.53 is
> fine.
> 
>> Address this by wiping out the file completely and effectively get back to
>> pre 4.5 era and CONFIG_MEMCG_KMEM=n configuration.
> 
> On reads, the runc code checks for MEMCG_KMEM=n by checking
> kmem.usage_in_bytes. If it is present then runc expects the other cgroup files
> to be there (including kmem.limit_in_bytes). So this change is not effectively
> the same.
> 
> Here's a link to the PR that would be needed to handle this change in userspace
> (not merged yet and would need to be propagated through the ecosystem):
> 
> https://github.com/opencontainers/runc/pull/4018.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 86327e8eb94c52
#regzbot title mm, memcg: runc fails to gather cgroup statistics
#regzbot fix: mm, memcg: reconsider kmem.limit_in_bytes deprecation
#regzbot ignore-activity

FWIW, the porposed fix can be found here:
https://lore.kernel.org/all/ZQwnUpX7FlzIOWXP@dhcp22.suse.cz/

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
