Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C467DDD1E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjKAHYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKAHYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:24:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E4E4;
        Wed,  1 Nov 2023 00:24:31 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qy5aW-0000Pd-To; Wed, 01 Nov 2023 08:24:28 +0100
Message-ID: <d186d562-7706-44ba-b213-dafee3f15704@leemhuis.info>
Date:   Wed, 1 Nov 2023 08:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mainline build failure due to 5cfd69775eb5 ("bcachefs: Array
 bounds fixes")
Content-Language: en-US, de-DE
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
References: <ZUF8bYTl5SBlbBBJ@debian>
 <20231031222455.mbhbhxiykq7dnuvl@moria.home.lan>
 <CADVatmMc-ZjPj0oNEidG4JK+k6YZ7XXPmMCCuYe_fnJ83xV5pw@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CADVatmMc-ZjPj0oNEidG4JK+k6YZ7XXPmMCCuYe_fnJ83xV5pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698823471;c866e10b;
X-HE-SMSGID: 1qy5aW-0000Pd-To
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.23 06:18, Sudip Mukherjee wrote:
> On Tue, 31 Oct 2023 at 22:24, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>> On Tue, Oct 31, 2023 at 10:15:09PM +0000, Sudip Mukherjee (Codethink) wrote:
>>>
>>> The latest mainline kernel branch fails to build arm64 allmodconfig
>>> with a native build on an arm64 host with the error:
>>[...]
>> Following patch should resolve everything:
>[...]
> Thanks, and I can confirm that fixes the build for me too on the arm hosts.

>> -- >8 --
>> From ad77f25f730ec9a0eb04be5adc591628654b85ae Mon Sep 17 00:00:00 2001
>> From: Kent Overstreet <kent.overstreet@linux.dev>
>> Date: Tue, 31 Oct 2023 18:05:22 -0400
>> Subject: [PATCH] bcachefs: Fix build errors with gcc 10
>>
>> gcc 10 seems to complain about array bounds in situations where gcc 11
>> does not - curious.
>>
>> This unfortunately requires adding some casts for now; we may
>> investigate getting rid of our __u64 _data[] VLA in a future patch so
>> that our start[0] members can be VLAs.
>>
>> Reported-by: John Stoffel <john@stoffel.org>
>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> 
> Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Kent, thx for handling this so quickly. If you want to do me a favor,
please in the future include a "Link:" or "Closes:" tag with a URL to
the report in cases like this, as explained in the docs (it's important
for regression tracking, but also for future code archeologists);
checkpatch should have pointed this out for this patch.

Anyway, no big deal here, let me tell regzbot directly about the fix:

#regzbot fix: bcachefs: Fix build errors with gcc 10

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
