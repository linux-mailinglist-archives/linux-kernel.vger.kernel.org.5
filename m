Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218B4771D50
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjHGJnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjHGJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:43:04 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570F0F9;
        Mon,  7 Aug 2023 02:42:47 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 11241103.A9806
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 11241103;
        Mon,  7 Aug 2023 11:42:43 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691401362;
        bh=2hAp8DsSOdkurCaBVHql6zxWT8yIkzanw2ur0tNmnm0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oHKFSE93vluDkDFWGK2GU3Kgy2X7Z9QxrXbYQBtsdPYUKjWj2Oi8XmzRkSXuCxWNr
         1KIGlqqB/n2X3jStRWVtxZ5lGRH8q5SyeRKj6ylrGdPaQ5evuFZhSxAZgiDzdMbkg+
         PXnoe2xTi0UWIHAty0kzvMmy5GTYLJRoN9JBobh4=
Received: from [192.168.44.147] (ptr-94-109-231-173.dyn.orange.be [94.109.231.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 4512BD4F78D51;
        Mon,  7 Aug 2023 11:42:42 +0200 (CEST)
Message-ID: <a2732938-f3db-a0af-3d68-a18060f66e79@cs.kuleuven.be>
Date:   Mon, 7 Aug 2023 11:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] selftests/sgx: Ensure expected enclave data buffer
 size and placement.
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-5-jo.vanbulck@cs.kuleuven.be>
 <CUE1R4HRQ599.1BX4CEIPSDWRW@seitikki>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <CUE1R4HRQ599.1BX4CEIPSDWRW@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.23 21:19, Jarkko Sakkinen wrote:
> So, when exactly is it optimized away by the compiler? This is missing.

The problem is that declaring encl_buf as static, implies that it will 
only be used in this file and the compiler is allowed to optimize away 
any entries that are never used within this compilation unit (e.g., when 
optimizing out the memcpy calls).

In reality, the tests outside test_encl.elf rely on both the size and 
exact placement of encl_buf at the start of .data.

For example, clang -Os generates the following (legal) code when 
encl_bug is declared as static:

0000000000001020 <do_encl_op_put_to_buf>:
     mov    0x8(%rdi),%al
     mov    %al,0x1fd7(%rip)   # 3000 <encl_buffer.0>
     mov    0x9(%rdi),%al
     mov    %al,0x8fce(%rip)   # a000 <encl_buffer.1.0>
     mov    0xa(%rdi),%al
     mov    %al,0x8fd5(%rip)   # a010 <encl_buffer.1.1>
     mov    0xb(%rdi),%al
     mov    %al,0x8fce(%rip)   # a012 <encl_buffer.1.2>
     mov    0xc(%rdi),%al
     mov    %al,0x8fd3(%rip)   # a020 <encl_buffer.1.3>
     mov    0xd(%rdi),%al
     mov    %al,0x8fce(%rip)   # a024 <encl_buffer.1.4>
     mov    0xe(%rdi),%al
     mov    %al,0x8fd1(%rip)   # a030 <encl_buffer.1.5>
     mov    0xf(%rdi),%al
     mov    %al,0x8fca(%rip)   # a032 <encl_buffer.1.6>
     ret

Disassembly of section .data:

0000000000003000 <encl_buffer.0>:
     3000:       01 00
         ...
0000000000004000 <encl_ssa_tcs1>:

Thus, this proposed patch fixes both the size and location:

1. removing the static keyword from the encl_bug declaration ensures 
that the _entire_ buffer is preserved with expected size, as the 
compiler cannot anymore assume encl_buf is only used in this file.

2. adding _attribute__((section(".data.encl_buffer"))) ensures that we 
can control the expected location at the start of the .data section. I 
think this is optional, as encl_buf always seems to be placed at the 
start of .data in all my tests. But afaik this is not guaranteed as per 
the C standard and such constraints on exact placement should better be 
explicitly controlled in the linker script(?)
