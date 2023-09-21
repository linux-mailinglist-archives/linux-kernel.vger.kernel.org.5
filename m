Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E097A9D95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjIUTli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjIUTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:41:32 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0EC113E5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:41:24 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qjGO1-0004Ii-45; Thu, 21 Sep 2023 11:54:17 +0200
Message-ID: <91daa8b6-57c2-424f-8c6c-647e05f2a8c9@leemhuis.info>
Date:   Thu, 21 Sep 2023 11:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Content-Language: en-US, de-DE
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Young <dyoung@redhat.com>
Cc:     Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        kexec@lists.infradead.org, Tom Lendacky <thomas.lendacky@amd.com>,
        x86@kernel.org
References: <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
 <20230913142410.dfqsg3l5v44mr5j3@box>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230913142410.dfqsg3l5v44mr5j3@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695325285;b61dc50d;
X-HE-SMSGID: 1qjGO1-0004Ii-45
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.23 16:24, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 05:57:07PM +0300, Kirill A. Shutemov wrote:
>> On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
>>>> early console in extract_kernel
>>>> input_data: 0x000000807eb433a8
>>>> input_len: 0x0000000000d26271
>>>> output: 0x000000807b000000
>>>> output_len: 0x0000000004800c10
>>>> kernel_total_size: 0x0000000003e28000
>>>> needed_size: 0x0000000004a00000
>>>> trampoline_32bit: 0x000000000009d000
>>>>
>>>> Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_map_64.c!?
>>>> pages->pgt_buf_offset: 0x0000000000006000
>>>> pages->pgt_buf_size: 0x0000000000006000
>>>>
>>>> Error: kernel_ident_mapping_init() failed
> [...]
>> The problem is not limited to unaccepted memory, it also triggers if we
>> reach efi_get_rsdp_addr() in the same setup.
>>
>> I think we have several problems here.
> [...]
>> Any comments?
> 
> I struggle to come up with anything better than increasing the constant to
> a value that "ought to be enough for anybody" ©, let's say 128K.
> 
> And we can eliminate logic on no-KASLR vs. KASLR vs. KASLR+VERBOSE_BOOTUP.
> 
> Objections?

Apparently not, as there was no reply since then (which is why I show up
here, as it looked like fixing this regression stalled).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
