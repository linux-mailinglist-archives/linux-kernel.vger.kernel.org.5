Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0B7F4AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbjKVPgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344411AbjKVPfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:35:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E2E2718;
        Wed, 22 Nov 2023 07:34:12 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r5pEq-00068f-Ii; Wed, 22 Nov 2023 16:34:04 +0100
Message-ID: <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info>
Date:   Wed, 22 Nov 2023 16:34:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to
 CONFIG_MICROCODE_AMD)
Content-Language: en-US, de-DE
To:     Borislav Petkov <bp@alien8.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info>
 <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info>
 <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700667252;7abc7ff4;
X-HE-SMSGID: 1r5pEq-00068f-Ii
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preface: considered CCing Linus here, as it's quite possible that I'm
wrong, as every situation is somewhat different. If anybody disagrees
with what I bring up below to hopefully clarify things thus please do me
a favor an CC Linus so he can clarify things.

Ohh, and sorry for being a PITA. I hate that, but when it comes to
regressions disagreements often happen, as all those discussions linked
at the end of https://docs.kernel.org/process/handling-regressions.html
illustrate.

On 22.11.23 12:58, Borislav Petkov wrote:
> On Wed, Nov 22, 2023 at 10:15:42AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [1] unless you fiddle with things obviously internal; not sure if this
>> case would qualify for him, but somehow I doubt it -- but I might be
>> wrong there.
> 
> Well, think about it - by that logic, if CONFIG_* items are an ABI, we
> will never ever be able to change any of them. [...]

Can't follow your logic (or the one from Lukas in the other reply), as
what's an ABI (or an API) is afaik not the important factor when it
comes to the "no regressions" rule: you can change things (including
ABIs or APIs) all you want, as long as nothing breaks. To quote Linus from
https://lore.kernel.org/all/CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com/

```
The rules about regressions have never been about any kind of
documented behavior, or where the code lives.

The rules about regressions are always about "breaks user workflow".

The other side of the coin is that people who talk about "API
stability" are entirely wrong. API's don't matter either. You can make
any changes to an API you like - as long as nobody notices.

Again, the regression rule is not about documentation, not about
API's, and not about the phase of the moon.

It's entirely about "we caused problems for user space that used to work".
```

>> BTW: I see that this could help preventing problems like the current one
>> to happen in the far future. But how would that help the current
>> situation (e.g. users that have an old dracut and updated the kernel
>> without updating dracut)?
> Update dracut too?

To quote Linus again, this time from
https://lore.kernel.org/lkml/CA+55aFxW7NMAMvYhkvz1UPbUTUJewRt6Yb51QAx5RtrWOwjebg@mail.gmail.com/

```
People should basically always feel like they can update their kernel
and simply not have to worry about it.

I refuse to introduce "you can only update the kernel if you also
update that other program" kind of limitations. If the kernel used to
work for you, the rule is that it continues to work for you.

There have been exceptions, but they are few and far between,
[...]
But if something actually breaks, then the change must get fixed or
reverted. And it gets fixed in the *kernel*. Not by saying "well, fix
your user space then".
```

Are those quotes fitting to the situation at hand? Not totally sure.
Initramfs generators might be special and we have done exceptions for
them in the past if no other solution could be found to prevent a
regression[1]. We'd need Linus to clarify.

Ciao, Thorsten

[1] maybe it's a naive idea, but can't we just avoid the problem at hand
by adding CONFIG_MICROCODE_AMD and CONFIG_MICROCODE_INTEL back as a
hidden config stub and remove those in ~3 years? Yeah, ugly, but we have
done things way more ugly than that to prevent regressions.
