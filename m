Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121397C7863
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442825AbjJLVJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442372AbjJLVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:09:27 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA8CBB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:09:26 -0700 (PDT)
Received: from [IPV6:2601:646:9a00:1821:7c45:267e:5aad:82e7] ([IPv6:2601:646:9a00:1821:7c45:267e:5aad:82e7])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39CL85OK1848892
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 12 Oct 2023 14:08:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39CL85OK1848892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1697144918;
        bh=5f4ZuSY/L+s9vY5S3iUWDxa4pn0Fv0h26nvn9vsXOh8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CLH/fKVyVCKi3f7nz9Xt95SNxAMKfTC56revfWZPlk7FnV0QxckBQRjosSB01pRaj
         vE0dTFncCytc2nDfXo3vhd12zuqb2J0YJ26/GCMIQQgLPYGgJ3vLO2ZKWd1O3K5wh7
         NfzItHdBcD2s3YsmvY2z9W4WUXKJ3ShcL5o/Lipp4LKC7rAE0IMd8gHr5buq5rbbJ9
         0BaHVfK1kpPsc9wq4tnTIVrIr+5BMMm17KiWAC/heWLcGyIX7PoJHUEDamDjOMLX7N
         LPHgK8ga6ttRod6tstkkY8BKRuHPXkkxJWeUMz4qEGkXbiGKJecOpU1OdE55BGgaLU
         AtBVNLtLfbSAQ==
Message-ID: <5722e74b-6fc6-4d6e-be25-069ea6385990@zytor.com>
Date:   Thu, 12 Oct 2023 14:08:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Introduce %rip-relative addressing to PER_CPU_VAR
 macro
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20231012201743.292149-1-ubizjak@gmail.com>
 <3af8dcec-66ec-4bd4-b7bf-4bc6f5f3c70f@intel.com>
 <CAFULd4byzHyoz4xM1gL_T1wFkNE-ab8K4upXfPirxM9PdX5JWg@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAFULd4byzHyoz4xM1gL_T1wFkNE-ab8K4upXfPirxM9PdX5JWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 13:59, Uros Bizjak wrote:
> On Thu, Oct 12, 2023 at 10:53 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 10/12/23 13:12, Uros Bizjak wrote:
>>> The last patch introduces (%rip) suffix and uses it for x86_64 target,
>>> resulting in a small code size decrease: text data bss dec hex filename
>>> 25510677 4386685 808388 30705750 1d48856 vmlinux-new.o 25510629 4386685
>>> 808388 30705702 1d48826 vmlinux-old.o
>>
>> I feel like I'm missing some of the motivation here.
>>
>> 50 bytes is great and all, but it isn't without the cost of changing
>> some rules and introducing potential PER_CPU_ARG() vs. PER_CPU_VAR()
>> confusion.
>>
>> Are there some other side benefits?  What else does this enable?
> 
> These changes are necessary to build the kernel as Position
> Independent Executable (PIE) on x86_64 [1]. And since I was working in
> percpu area I thought that it was worth implementing them.
> 
> [1] https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@antgroup.com/
> 

Are you PIC-adjusting the percpu variables as well?

	-hpa
