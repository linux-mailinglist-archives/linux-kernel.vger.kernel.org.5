Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338DC7900A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345151AbjIAQYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjIAQYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:24:22 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429F010D4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693585457;
        bh=yPsU/zPFGjhm+BAPgqggM92cWvwSaqwkmftlEUdpQTI=;
        h=Date:To:References:From:Cc:Subject:In-Reply-To;
        b=JpFKBe7X7WmMjhiCxPoXNRWL+bf2/UZ52wfSl3VPDwBl+DNov5UvAuhSlN46Kzyk+
         9UqNVRDTw2xsHtkrSESyXBzKm0pefVT1KyerAjd7bXzsoNUc6zC5wk/f/LwwLVaAcS
         0P0Gcb3i2fYQou3M4V6WkFb8fUVPvDl7HU473QnN5MWyhFGy7x3ruC1wgHp/jtE8T+
         Xh3E9A1SxpvKbhq09H0hRnmwLm2chWnMc0VnwMa/zjoXD2cyBjr3JZBAdBi43r7bo5
         JSjaOnI5RS+Wyum3tjkW9JG7ZG6c2kyQ8KHbaThmvw21AbFqXX4PX7ooQ5UzzY4ZUF
         WSy5ithOBmv4w==
Received: from [10.20.0.2] (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 300E424B39E;
        Fri,  1 Sep 2023 23:24:15 +0700 (WIB)
Message-ID: <dbce949f-d8b5-fb88-af63-21a82e431aa3@gnuweeb.org>
Date:   Fri, 1 Sep 2023 23:24:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Joshua Hudson <joshudson@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     x86-ml <x86@kernel.org>
Subject: Re: System Call trashing registers
In-Reply-To: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 11:15 PM, Joshua Hudson wrote:
> 1) A lot of my old 32-bit programs don't work on x64 linux anymore
> because int 80h now trashes ecx and edx. This hasn't been a serious
> problem for me.

Do you have a reproducer? It doesn't trash ecx and edx on my machine.

Linux 6.5.0-rc5-af-home-2023-08-08-gf01d31303231
```
#include <stdio.h>

static void do_int80(void)
{
	int ecx = 0x11111;
	int edx = 0x22222;
	int eax = 158; // sched_yield

	__asm__ volatile (
		"int $0x80"
		: "+a"(eax), "+c"(ecx), "+d"(edx)
		:
		: "memory"
	);
	printf("ecx = %#x\n", ecx);
	printf("edx = %#x\n", edx);
}

int main(void)
{
	int i;

	for (i = 0; i < 3; i++)
		do_int80();

	return 0;
}
```

ammarfaizi2@integral2:/tmp$ gcc -Wall -Wextra -Os z.c -o z
ammarfaizi2@integral2:/tmp$ ./z
ecx = 0x11111
edx = 0x22222
ecx = 0x11111
edx = 0x22222
ecx = 0x11111
edx = 0x22222


> 2) syscall is documented to trash rcx and r11.
> 
> What I don't understand is why this hasn't ever led to a security
> issue due to leaking values from kernel space (in the trashed
> registers) back to userspace.

That behavior is architectural. It's the 'syscall' instruction that
clobbers %rcx and %r11. Not the kernel.

The kernel's syscall entry point even saves %rcx and %r11, but at that
point they've already been overwritten by the syscall instruction
itself with the original %rip and %rflags values. So they contain
userspace values. No internal kernel data is leaked in %rcx and %r11.

-- 
Ammar Faizi
