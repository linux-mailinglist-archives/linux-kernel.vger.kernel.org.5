Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F394C7B4C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjJBHDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjJBHC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:02:56 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE81A5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:02:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3318B20009;
        Mon,  2 Oct 2023 07:02:42 +0000 (UTC)
Message-ID: <8d305ae1-4235-6ae8-7dfb-9f432fdfcd41@ghiti.fr>
Date:   Mon, 2 Oct 2023 09:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] riscv: mm: Update mmap_rnd_bits_max
Content-Language: en-US
To:     Pedro Falcato <pedro.falcato@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230929211155.3910949-4-samitolvanen@google.com>
 <20230929211155.3910949-6-samitolvanen@google.com>
 <202309291452.66ED9B4D83@keescook>
 <CABCJKufxUVoO+yJ+513W5FOFu6u45N=6wZe6a69u+8LU6A_N2Q@mail.gmail.com>
 <20230930-emporium-share-2bbdf7074e54@spud> <202309301400.4E1AD87@keescook>
 <CAKbZUD08W9_HB9F7tQqwreYvVapgVMOkS3QokzwHPcBnFnVMig@mail.gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAKbZUD08W9_HB9F7tQqwreYvVapgVMOkS3QokzwHPcBnFnVMig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2023 17:19, Pedro Falcato wrote:
> On Sun, Oct 1, 2023 at 2:51 AM Kees Cook <keescook@chromium.org> wrote:
>> On Sat, Sep 30, 2023 at 10:02:35AM +0100, Conor Dooley wrote:
>>> On Fri, Sep 29, 2023 at 03:52:22PM -0700, Sami Tolvanen wrote:
>>>> On Fri, Sep 29, 2023 at 2:54 PM Kees Cook <keescook@chromium.org> wrote:
>>>>> On Fri, Sep 29, 2023 at 09:11:58PM +0000, Sami Tolvanen wrote:
>>>>>> ARCH_MMAP_RND_BITS_MAX is based on Sv39, which leaves a few
>>>>>> potential bits of mmap randomness on the table if we end up enabling
>>>>>> 4/5-level paging. Update mmap_rnd_bits_max to take the final address
>>>>>> space size into account. This increases mmap_rnd_bits_max from 24 to
>>>>>> 33 with Sv48/57.
>>>>>>
>>>>>> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>>>>> I like this. Is RISCV the only arch where the paging level can be chosen
>>>>> at boot time?
>>>> I haven't seen this elsewhere, but I also haven't looked at all the
>>>> other architectures that closely. arm64 does something interesting
>>>> with ARM64_VA_BITS_52, but I think we can still handle that in
>>>> Kconfig.
>>> AFAIU, x86-64 can do this also:
>>>
>>>        no4lvl          [RISCV] Disable 4-level and 5-level paging modes. Forces
>>>                        kernel to use 3-level paging instead.
>>>
>>>        no5lvl          [X86-64,RISCV] Disable 5-level paging mode. Forces
>>>                        kernel to use 4-level paging instead.
>> Ah-ha! Okay, well, then let's track this idea:
>> https://github.com/KSPP/linux/issues/346
> (Replying here for visibility, tell me if you want to move this
> discussion to github)
>
> AIUI, x86 cannot do this for compat reasons. Even if you enable LA57,
> mmap only gives you < 48-bit addresses, for compatibility with things
> like JITs, etc that stash information in the upper 16 bits. You need
> to pass a > 48-bit mmap hint to get 57-bit addresses.
>
> I imagine riscv does not have this issue yet, due to little
> accumulated cruft, but it may be wise to check against popular JITters
> for these problems on riscv code.
>

We already encountered those issues and the same solution was recently 
merged (restrict to sv48 unless otherwise specified): 
https://lore.kernel.org/all/20230809232218.849726-1-charlie@rivosinc.com/

