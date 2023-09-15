Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E087A17BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjIOHrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjIOHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:47:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF4A1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+VnSDWZeJ1nWnlbOizXr+arVmZib71qUYMJ8RDptxek=; b=SukXiH3/ICd0FPnMJfN2/TiSCf
        aoeyfnh3Hgjgr4Qnu5z3cbL8q3ycbtuhwAyJiATnow4oK3panbA3qdqo1rOFhbJcAnHtZqDajfRAz
        mCohhm1bm0+SL3Uy72k6yz9DolZMrsaI/ZnHjSCWwz9+DDsQQBrV9eaEm+dDrMiH305W5ZFOBGNKZ
        I77NWJbwZvj2pHWCLp3/VzdZbavcSMrS3nDxHI3B8URUrHVpcbGH4oDxWebFmcI8JlJYijQ5ZmsJs
        4JA9BBNSfVSxqBEH5qRVQ+BYLcupfSvA31iI3sI9U59FvObLLDlMAGvYuVoT/FaWAFED/aTKO7Ro4
        s8KrH7rA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qh3XK-008ouS-2h;
        Fri, 15 Sep 2023 07:46:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAAD03003F2; Fri, 15 Sep 2023 09:46:47 +0200 (CEST)
Date:   Fri, 15 Sep 2023 09:46:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230915074647.GA6721@noisy.programming.kicks-ass.net>
References: <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
 <20230912092709.GE35261@noisy.programming.kicks-ass.net>
 <20230912094441.GA13926@noisy.programming.kicks-ass.net>
 <20230913043738.GCZQE8kuw8p3WsnCXd@fat_crate.local>
 <20230913084658.GA692@noisy.programming.kicks-ass.net>
 <20230913143847.GBZQHJd24PX0l0gLG+@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913143847.GBZQHJd24PX0l0gLG+@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:38:47PM +0200, Borislav Petkov wrote:

>   [ bp: Make labels unique and thus all sizing use unambiguous labels.
>     Add more info. ]

> +#define __ALTERNATIVE(oldinstr, newinstr, ft_flags, n)			\
> +	OLDINSTR(oldinstr, n)						\
> +	ALTINSTR_ENTRY(ft_flags)					\
> +	ALTINSTR_REPLACEMENT(newinstr)

> +#define ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
> +	__ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),		\
> +		    newinst2, flag2, 1)

> +#define ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
> +		      newinst3, flag3)					\
> +	__ALTERNATIVE(ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
> +		    newinst3, flag3, 2)


So I see what you did with that @n argument, but urgh, do we really need
this? I mean, it just makes things harder to use and it doesn't actually
fix anything.. :/
