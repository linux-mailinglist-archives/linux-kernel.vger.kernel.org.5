Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26307C788F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442890AbjJLVW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442934AbjJLVWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:22:25 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68133A9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:22:24 -0700 (PDT)
Received: from [IPV6:2601:646:9a00:1821:7c45:267e:5aad:82e7] ([IPv6:2601:646:9a00:1821:7c45:267e:5aad:82e7])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39CLLiXS1851702
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 12 Oct 2023 14:21:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39CLLiXS1851702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1697145706;
        bh=DkV9ockDXHygDK8vfHAm86izvNjg/lx4TtVVSQpgW6s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i5vz1mkPWunh4gIMlTKwj14PtENV6wuJHkZSEnXbtAYpjeKZpNxplcosRKlCGMD/1
         aleLTy5iWUddNvYM0c5UcTyMpiYwRTiTFgNJiEfryIo+vbgKyFl+Pm3PimAGjd8gI0
         WDdQnAqdwzTB+nSTfm0xZzhKuH3nUD3LE9EhXr7rl+vfKOxjzaLZ7x4ZXaBWJaQoZb
         ovA92Vc2b7iGm9RUoj43nkptJGKn087njRBmArQKptXO3OP/SIJLVe31PWuHzYv0oe
         e05dyw10uZbbV4/ttog0qetMzMM2jyfr+LYOa/YtbpVoXtGt+e3t7kykvwtiOj2hnz
         dtKLDMSJQiIww==
Message-ID: <5694b2bd-de40-45c0-8b38-ac01bc11798a@zytor.com>
Date:   Thu, 12 Oct 2023 14:21:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Introduce %rip-relative addressing to PER_CPU_VAR
 macro
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20231012201743.292149-1-ubizjak@gmail.com>
 <3af8dcec-66ec-4bd4-b7bf-4bc6f5f3c70f@intel.com>
 <CAFULd4byzHyoz4xM1gL_T1wFkNE-ab8K4upXfPirxM9PdX5JWg@mail.gmail.com>
 <5722e74b-6fc6-4d6e-be25-069ea6385990@zytor.com>
 <CAFULd4afhj-kJwneh7wz0sExWqOmPicG4fcfF++_fUMHpoNbXA@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAFULd4afhj-kJwneh7wz0sExWqOmPicG4fcfF++_fUMHpoNbXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 14:17, Uros Bizjak wrote:
>>
>> Are you PIC-adjusting the percpu variables as well?
> 
> After this patch (and after fixing percpu_stable_op to use "a" operand
> modifier on GCC), the only *one* remaining absolute reference to
> percpu variable remain in xen-head.S, where:
> 
>      movq    $INIT_PER_CPU_VAR(fixed_percpu_data),%rax
> 
> should be changed to use leaq.
> 
> All others should then be (%rip)-relative.
> 

I mean, the symbols themselves are relative, not absolute?

	-hpa

