Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933E37DF7DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376886AbjKBQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKBQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:40:16 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB0513A;
        Thu,  2 Nov 2023 09:40:13 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qyajp-0003p8-7D; Thu, 02 Nov 2023 17:40:09 +0100
Message-ID: <54124220-3ce8-47c7-8303-d186c9e570dd@leemhuis.info>
Date:   Thu, 2 Nov 2023 17:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mainline build failure due to 9c66dc94b62a ("bpf: Introduce
 css_task open-coded iterator kfuncs")
Content-Language: en-US, de-DE
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZUNiwMLBsL52X9wa@debian>
 <79260ece-5819-4292-bfac-dc21a3701813@bytedance.com>
 <7ade1b4d-71ad-4f32-9b19-9d8eac8e595b@leemhuis.info>
 <CADVatmNkXXH5xwEe25cZeESRT5FscKQuGEoSZ=1tiGTtLO-+pg@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CADVatmNkXXH5xwEe25cZeESRT5FscKQuGEoSZ=1tiGTtLO-+pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698943213;26473bd7;
X-HE-SMSGID: 1qyajp-0003p8-7D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.23 17:04, Sudip Mukherjee wrote:
> On Thu, 2 Nov 2023 at 09:13, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>> On 02.11.23 09:53, Chuyi Zhou wrote:
>>> 在 2023/11/2 16:50, Sudip Mukherjee (Codethink) 写道:
>>>> The latest mainline kernel branch fails to build mips
>>>> decstation_64_defconfig,
>>>> decstation_defconfig and decstation_r4k_defconfig with the error:
>>>>
>>>> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
>>>> kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared
>>>> (first use in this function)
>>>>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>>>>        |              ^~~~~~~~~~~~~~~~~~~
>>> [...]
>>>> git bisect pointed to 9c66dc94b62a ("bpf: Introduce css_task
>>>> open-coded iterator kfuncs")
>>>
>>> Thanks for the report! This issue has been solved by Jiri.[1]
>>>
>>> [1]:https://lore.kernel.org/all/169890482505.9002.10852784674164703819.git-patchwork-notify@kernel.org/
>>
>> Thx, I was just about to reply something similar. :-D
>>
>> Sudip, maybe you know about this already, but in case you don't, here is
>> a quick tip that might be useful for you: in cases like this it's often
>> wise to search for earlier reports on lore using an even more
>> abbreviated commit-id followed by a wildcard (e.g. "9c66dc94*"). That at
>> least was how I found the fix quickly.
> 
> Yes, but the failure is still in the mainline. And it has happened in
> the past that the fix has been submitted and taken by the maintainer
> but was not sent to Linus.
> In the last release cycle I had to send a reminder around the time of
> -rc3 and in that case also the fix was submitted when I sent the build
> failure mail.

Yes, that can happen, I have an eye on such situations as well, but I
don't add all those cases to rezgbot, as some of them get quickly
resolved in a day or two. But you are totally free to get regzbot
involved if you want!

> But  like you said I will search and will not add Cc to rezbot in
> cases where a fix has been submitted.

No, sorry, please don't read my reply like that. Feel free to tell
regzbot about such cases. But you could do me a favor in cases that are
similar like this: when adding the issue to the tracking use "#regzbot
monitor <url>" to point to the fix and "#regzbot fix <subject>" to
mention its subject, as that makes it clear that a fix is under review
and/or incoming; and when it landed regzbot will automatically consider
the regressions resolved, too.

> Also if Linus wants then I will
> not even send mails in these cases.

That's up to Linus, but I guess he and others that got your report all
receive enough mail already; so if you ask me, for issues that are known
and handled already I'd say its best to send them just to the regression
list while making it obvious that a fix is in the works (see above); if
things are not resolved more people can be brought in later. But that's
just how I would handle it.

Ciao, Thorsten
