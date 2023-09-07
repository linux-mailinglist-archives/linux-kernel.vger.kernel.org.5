Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1979747E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbjIGPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbjIGPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBC9CF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GBmm6QGQq2DORJU/HKTN2kES85Y8gNERMZgKrgaDcys=; b=OspJ70kupsgbAzQ88JaHva6gFw
        KAaWrTB68PHNf1ZMy1oDSSvx40wKuNG9JbYG1VlREATWDJgyFQTb/G5ijzqkTjN/SJ2DgEJFMQ7Xi
        1poL5FACnKtJo0TmUa2W71dHKYSzNS6WsmIJozzGAF2s8U9D0+UII69L6eOkPucCG0aivwQ9TfYjF
        FEsP26PIfn/RK0SvyK0MnXhzRUsfhbNaVIcSc1ppgA+iXtF923SgZe8i5zmTBUwew67b4Tqurhcvr
        LVgPZoCnG4WgbrrlLgNvq+l4ZFz1sa+Nm7TN8GDgdP7oZyMQO3LUivgk79+b5dkJoqcBfFlijUV+f
        LcQLUCiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeCuZ-001lPz-18;
        Thu, 07 Sep 2023 11:11:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75553300687; Thu,  7 Sep 2023 13:11:00 +0200 (CEST)
Date:   Thu, 7 Sep 2023 13:11:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230907111100.GA29900@noisy.programming.kicks-ass.net>
References: <20230814114426.057251214@infradead.org>
 <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907110917.GA10955@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 01:09:17PM +0200, Peter Zijlstra wrote:

> Anyway, the 1,3,2 variant spelled out reads like:
> 
> #APP
> # 1563 "../arch/x86/kernel/alternative.c" 1
> # ALT: oldnstr
> 661:
> # ALT: oldnstr
> 661:
> push %rbp
> 662:
> # ALT: padding
> .skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90
> 
>  #   Which evaluates like:
>  #     665f-664f = 3
>  #     662b-661b = 1
>  #     3-1 > 0 = -1
>  #     --1 * (3-1) = 2
>  #
>  #   so two single byte nops get emitted here.
> 
> 663:
> .pushsection .altinstructions,"a"
> .long 661b - .
> .long 664f - .
> .4byte ( 3*32+21)
> .byte 663b-661b
> .byte 665f-664f
> .popsection
> .pushsection .altinstr_replacement, "ax"
> # ALT: replacement
> 664:
> mov %rsp,%rbp
> 665:
> .popsection
> 
> 662:
> # ALT: padding
> .skip -(((665f-664f)-(662b-661b)) > 0) * ((665f-664f)-(662b-661b)),0x90
> 
>  #   And this evaluates to:
>  #     665f-664f = 2
>  #     662b-661b = 3 (because it includes the original 1 byte instruction and 2 bytes padding)
>  #     3-1 > 0 = 0
>  #     0 * (3-1) = 0

copy-paste fail, that needs to read:

	3-3 > 0 = 0
	0 * (3-3) = 0

>  #
>  #   so no extra padding
> 
> 663:
> .pushsection .altinstructions,"a"
> .long 661b - .
> .long 664f - .
> .4byte ( 3*32+21)
> .byte 663b-661b
> .byte 665f-664f
> .popsection
> .pushsection .altinstr_replacement, "ax"
> # ALT: replacement
> 664:
> push %r12
> 665:
> .popsection
> 
> # 0 "" 2
> # ../arch/x86/kernel/alternative.c:1569:        int3_selftest();
> #NO_APP
