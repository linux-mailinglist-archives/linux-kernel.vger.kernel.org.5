Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6BC7DE704
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjKAUvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjKAUvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:51:14 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1235A11C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698871863;
        bh=+MuUQ7FS66koShvyTlTaOH84DYO2F+juD3CotMhyqqU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QehCGBvKJDRkhdLW4wmvM0+EDA/ghxOCZiEUfMtd8+APJFajCwkuj2g/zHzNA+BLc
         5GcaHTJDL2ZpjTk29R6eTGdtXOijtwhFxZsqs76v6cfV20PuY5cEp397y7ngPrMPOm
         8rYql1e7GBpQa237jGHu5RXE5mwcgBue4bMChFvQeEq/ymz8yfywGHt0i3OiCtlhKJ
         1X9C9TMrerw4L8bTDOV9rU59PsjULRmr8Sg11vm/M20yFrWPG+qWVo1dfc+55g7Rzo
         YPcCQZJ4qOOj3f0oLr8/YLflgGKT7o6BmTePGcxaLBJkOtK/m1qkJkEFijuwZB+K1y
         082AvFrqFxyIg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SLK0l49LCz1b9S;
        Wed,  1 Nov 2023 16:51:03 -0400 (EDT)
Message-ID: <bdb00d83-279b-4b73-aa5b-50a9f275d102@efficios.com>
Date:   Wed, 1 Nov 2023 16:51:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix: rseq uapi: Adapt header includes to follow glibc
 header changes
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
References: <20231025214811.2066376-1-mathieu.desnoyers@efficios.com>
 <202310271556.LunB8KLv-lkp@intel.com>
 <81d2fd04-572d-48cd-bb5c-9a77937a79a0@efficios.com>
 <20231027100641.52fbee5d@gandalf.local.home>
 <f5bd06bb-da51-48c1-bf79-d1ef92802adf@efficios.com>
 <20231101164415.7f198500@gandalf.local.home>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231101164415.7f198500@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-01 16:44, Steven Rostedt wrote:
> On Wed, 1 Nov 2023 16:10:04 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> So what is the minimal change required to make things work on your
>> setup? I just tested with a Debian "testing" chroot (with libc 2.37-12)
>> and I cannot reproduce your issue.
>>
>> Should I just submit a patch that removes "#include <asm/byteorder.h>" ?
>> I am really unsure which environments are affected though.
>>
> 
> I guess you can drop it :-p

OK, let's drop this patch then. I may respin the removal of asm/byteorder.h
include as a cleanup in the future, but there is really no hurry.

Thanks,

Mathieu

> 
> When I tried to reproduce it with hand writing 'gcc', I couldn't. But when
> I did:
> 
>   $ make foo
> 
> It gave me the error. I was confused for a bit. Then I looked at what my
> Makefile was doing and what I was doing. The only difference was that the
> make included:
> 
>     -I.
> 
> Removing that from the Makefile worked!
> 
> My Makefile added to the CFLAGS "-I." and I forgot that this directory has
> a "linux/"  directory in it that I used years ago to test kernel functions.
> The git history shows it was last touched in 2016 (when I was still at Red Hat)
> 
> Removing -I. now makes everything work.
> 
> I have no idea why it suddenly stopped working just a few months ago. Maybe
> something was moved out of the gcc headers so my local headers no longer
> see it. That is, perhaps the glibc headers moved something out and added a
> #include to it, where my local headers did not have that change. I don't
> know and I don't care.
> 
> Well, at least now I know why I was getting errors on my build, but
> couldn't find anything on the internet showing why others were not!
> 
> Sorry for the noise. :-/
> 
> -- Steve
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

