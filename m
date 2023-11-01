Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE1B7DE712
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347751AbjKAUJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKAUJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:09:54 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BFCDB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1698869385;
        bh=VMJyBzB3ZzkSs54N6fjX3WtEfYJNAknRELhUvgPU8sE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pPUZYDbGA9qmlG1abakLq8iEAwTYCnrFZR5UI2+wl8iKWLMElS9mooeJiNFyo/esp
         ybU0LFz0pMcwnQiUpZDiwi9n6NuFW8084cMxFjta1LszSh0Rdp9e+gfamYvloYvgJm
         fEZpctjb3NMMuGo3sUGb9OxEnk73QKB0AQJeDwteByeqmkTuEYKNkssKnd8m6DY43T
         fKodC/q/kg3t8Es6laXIKzoCtH+vDQ4/bBkUbAuae1Unbn7r9r/nCMWW9C/0E3sZ1d
         tkemcdBcOMoLjwcAjA3PY2BTnvMLAOLLzWYqJwBu/6Kgjpgq4qn48+nvROy+S3Nop+
         dMeHla5uqQkAw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SLJ551YFkz1b7Y;
        Wed,  1 Nov 2023 16:09:45 -0400 (EDT)
Message-ID: <f5bd06bb-da51-48c1-bf79-d1ef92802adf@efficios.com>
Date:   Wed, 1 Nov 2023 16:10:04 -0400
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231027100641.52fbee5d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-27 10:06, Steven Rostedt wrote:
> On Fri, 27 Oct 2023 09:37:26 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2023-10-27 03:53, kernel test robot wrote:
>>> Hi Mathieu,
>>>
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on linus/master]
>>> [also build test WARNING on v6.6-rc7 next-20231026]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> The test robot complains about using <asm/types.h> in uapi headers for
>> !__KERNEL__ case.
>>
>> Steven, was there something wrong with including linux/types.h in uapi
>> headers ?
>>
> 
> Actually, linux/types.h includes asm/types.h so I don't think that was the
> issue. I think the issue was mostly with:
> 
>   #include <asm/byteorder.h>
> 
> Replacing linux/types.h with asm/types.h worked, but may have been
> unnecessary.

Hi Steven,

So what is the minimal change required to make things work on your 
setup? I just tested with a Debian "testing" chroot (with libc 2.37-12) 
and I cannot reproduce your issue.

Should I just submit a patch that removes "#include <asm/byteorder.h>" ? 
I am really unsure which environments are affected though.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

