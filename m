Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06D7BC32B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjJFX7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjJFX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:59:11 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07C3BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:59:08 -0700 (PDT)
Received: from [IPV6:2601:646:9a00:1821:450e:710e:ed94:8bf9] ([IPv6:2601:646:9a00:1821:450e:710e:ed94:8bf9])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 396NwWoU3314962
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 6 Oct 2023 16:58:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 396NwWoU3314962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1696636713;
        bh=r3NsrdvhrQyVEdBZ/5O/ATEpo5vgoDixa3RODG+aELI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Zwtt9TZo+RnN0lvFS5x/Wngv6w7ANBkidq4nRY5owfLAYGSDvqilcsU/khrUMpq1i
         6Jlv3W7CrA2YM4LPDW0V2cdU3pz4GKune0ZshmkffVeFsPcUD5P9wyRl1MKxEriXiT
         ktQWwFc8EAdUNF41KpkJzidbwlh4tsAABG8wx7h+1EJBuI/bLtFAS3vP5rdsYZq4Tw
         QkV8OJEO0FyGI3PxKE2LsQ+fUCNdPql/rCpUW53hTGGH8T2TIIN1QC/BUUp1dc8HFu
         pKtOfG4OLwXOUI51Jso/lW/nsKha5oJCu+0QUSEUzB3YHK7SivCria1KXMLHx/pwQi
         5txZ5gBra0W0Q==
Message-ID: <a05f751b-9463-c8b9-71bc-8fb8963b162a@zytor.com>
Date:   Fri, 6 Oct 2023 16:58:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/6] x86: Clean up fast syscall return validation
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <20230721161018.50214-1-brgerst@gmail.com>
 <ZR5yTecBhCFsVOtQ@gmail.com>
 <CAMzpN2j7qddPEUdD+ZX3dtyQkPq6e4gzwcu5szkZ2esh_8zm9g@mail.gmail.com>
 <ZR8an4+JbkLS8/Ol@gmail.com> <5def7e28-3949-9685-7ddf-19b550847ef0@zytor.com>
In-Reply-To: <5def7e28-3949-9685-7ddf-19b550847ef0@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 11:59, H. Peter Anvin wrote:
> 
> Incidentally, it is possible to save one instruction and use only *one* 
> alternative immediate:
> 
>      leaq (%rax,%rax),%rdx
>      xorq %rax,%rdx
>      shrq $(63 - LA),%rdx        # Yes, 63, not 64
>      # ZF=1 if canonical
> 
> This works because if bit [x] is set in the output, then bit [x] and 
> [x-1] in the input are different (bit [-1] considered to be zero); and 
> by definition a bit is canonical if and only if all the bits [63:LA] are 
> identical, thus bits [63:LA+1] in the output must all be zero.
> 

Yes, I'm a doofus. Bits [63:LA-1] must be identical, so 64 is correct :$)

	-hpa

