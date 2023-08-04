Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3176FC06
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjHDI3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjHDI30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:29:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A576D4C1F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uj/bHODU4TG/meXv1vL8st7Bph/6XZ2Jf03zIDsI35M=; b=O7Xk9TGxmky6eX+hfAA55ATR8X
        m5EDc7nPQpVR5Lk4hzuDXqdWhRQbtkLMVfI9SFEhRQROVEhqPhHO/I8EiINXngFwaqFWaiWtIMYbF
        u9vm8ccVn74+PU1uRu0my3lco+jMXnWfioyyIPnNYmznLsxwcBG4Be/sC9wOIpiCXQ+a80F2sybXO
        2MfhqVrWcOQdSBJ7ZaWZq7sDYujnNCsnq6Cic2kDLXuXrXP/4FltOABoJhrRQpcHxE4dXcWO3Bk+Y
        IezMbDWR/8mBMjtm2CplCGBuZRY8oUI1uGTGm0pOjitEYM3gOJHkwvMVMdwmIi7ZupLwn6R81+dQJ
        mjZarkrg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRqB4-000EN6-0a;
        Fri, 04 Aug 2023 08:28:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7FDA30007E;
        Fri,  4 Aug 2023 10:28:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A41952107C449; Fri,  4 Aug 2023 10:28:53 +0200 (CEST)
Date:   Fri, 4 Aug 2023 10:28:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] x86/retpoline,kprobes: Fix "Fix position of thunk
 sections with CONFIG_LTO_CLANG"
Message-ID: <20230804082853.GM212435@hirez.programming.kicks-ass.net>
References: <20230803215555.zl5oabntc44ry3uc@treble>
 <20230803230323.1478869-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803230323.1478869-1-andrew.cooper3@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 12:03:23AM +0100, Andrew Cooper wrote:
> Lets hope there are no .text..__x86womble sections around.
> 
> Fixes: 973ab2d61f33 ("x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG")
> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
> CC: Petr Pavlu <petr.pavlu@suse.com>
> CC: Peter Zijlstra (Intel) <peterz@infradead.org>
> CC: Josh Poimboeuf <jpoimboe@kernel.org>
> CC: linux-kernel@vger.kernel.org
> 
> Alternatively,
> 
> int strstarts(const char *s1, const char *s2)
> {
>         return strncmp(s1, s2, strlen(s2));
> }

Durr, I hate C ;-/ And yes, we have a ton of it, lemme try that
strstarts thing.
