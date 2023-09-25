Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961227AD445
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjIYJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjIYJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:12:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB9BD3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:11:54 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qkhdA-0004Kj-43; Mon, 25 Sep 2023 11:11:52 +0200
Message-ID: <0efa9992-c2f8-4ae3-943f-9b17d0e1b1b7@leemhuis.info>
Date:   Mon, 25 Sep 2023 11:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux regressions report for mainline [2023-09-24]
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <169557219938.3206394.2779757887621800924@leemhuis.info>
 <2023092522-climatic-commend-8c99@gregkh>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2023092522-climatic-commend-8c99@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695633114;21f45c9e;
X-HE-SMSGID: 1qkhdA-0004Kj-43
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.23 10:02, Greg KH wrote:
> On Sun, Sep 24, 2023 at 04:17:40PM +0000, Regzbot (on behalf of Thorsten Leemhuis) wrote:
>> (2) Nearly six weeks ago there was a report that 101bd907b4244a ("misc:
>> rtsx: judge ASPM Mode to set PETXCFG Reg") [v6.5-rc6, v6.4.11, v6.1.46,
>> v5.15.127] broke booting various laptops (many or all of them are Dell).
>> This apparently plagues quite a few users, hence there were multiple
>> reports (see [2] for those I'm aware of). At least Fedora, openSUSE, and
>> nixOS have meanwhile reverted the change in their latest stable kernels
>> [3]. I one and a half week proposed to revert the culprit when I fully
>> noticed it's impact, but Greg wanted to give the developers more time.
>> We finally have a fix in sight now [5]; someone affected replied that it
>> helps. Not sure what's the right way forward now. But overall this to me
>> feels a lot like "this is not how a regression should be handled".
>> That's why I wanted to bring it up here in case to ensure your are aware
>> of this.
> 
> We now have confirmed testing that the proposed fix resolves the issue
> so I'll be getting it to Linus in time for the next -rc.

Many thx!

>  I've been
> traveling all last week and this week for conferences so my response
> times have been a bit slow, sorry.

No worries, I already suspected this[1]. The major aspect in this whole
episode that bugs me a lot is different anyway:

Wouldn't it have been much much better to revert[2] the culprit quickly
once it was known to cause a regression that annoyed some users a whole
lot[3, 4]?

Yes, looking back now it's easy to ask. But I encounter similar
situations all the time: developers and maintainers are
(understandably!) often quite reluctant to revert commits causing
regressions, especially when a fix seems not far off. But in the end it
often (like in this case) takes quite a while to polish the fix, get it
tested, reviewed, in -next for a day or two, into mainline, and (when
needed, like in this case) incorporation in affected stable series.

That's why I wrote the "Expectations and best practices for fixing
regressions" section in Documentation/process/handling-regressions.rst,
which mentions rough time frames to help when a revert is appropriate.
But nobody cares about them -- and I don't blame anyone, as Linus never
ACKed them; even parts that are directly based on statements from Linus
are ignored all the time (often because people simply don't known about
them [5]). That makes my job hard. :-/

Ciao, Thorsten

[1] Sadly I couldn't make it to Bilbao this year; ohh, and BTW, enjoy
Paris this week; wanted to be there, but that didn't work out due to
stupid reasons. :-/

[2] Or would that have cause a big regression for anyone? doesn't look
like it from here, but maybe I'm missing something.

[3] FWIW, I consider it partly my fault that this didn't happen, as I
should have rooted for this way earlier. :-/ I was on vacation when when
the report came in and only realize the full impact much later; then I
finally suggested to revert this ~11 days ago a fix seemed not too far
off. OTOH I still thing a revert at that point would have been the right
thing to do.

[4] And reapply it later (outside of the merge window) together with a
fix or directly in fixed form.

[5] recent example:
https://lore.kernel.org/all/a2839c37-580f-4091-8bbc-50eea96c7c8b@leemhuis.info/
