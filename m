Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7C7C4071
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjJJT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJJT5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:57:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5C38E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:57:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CB4C433C7;
        Tue, 10 Oct 2023 19:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696967843;
        bh=ebhIkz6leoFsUxci+Od1cGHvCe9Dc0bDHHFkxrY3AT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BeCHDQRRZYafZRmb6LLUT1d3ufjAM8Yg4hRlEsqCc8WorbRWRNA9a9NWFUMBVIf3v
         LkN1N57hDU688nj9zRURbdWowqVLSo7iUFXOylO7mRtRaOPQbCN7Xc53bXJ+J5K8po
         GS0nQv0phaYCsG+EONdrTT+19nYmiIk2d3XZSaTyFKgnaedWQ8ByLC4v3Z18c6BNoa
         D8CgjC6HcOYv0w4R25Y8kotCIj0j6lcoKugNnGATZ3tPCseVWcIDCMyTjjaakgd36H
         K9ubmwwX3+RemkK4ea96293jbtINOzheS1xmF/3LSqGbw5ErkqxMawjskxojCZV5Kn
         TZc5C25vo6Reg==
Date:   Tue, 10 Oct 2023 12:57:21 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231010195721.p5pb273kevg7ydxz@treble>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010174833.GG14330@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:48:33PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 10, 2023 at 12:10:18PM -0500, David Kaplan wrote:
> 
> >  arch/x86/kernel/vmlinux.lds.S | 3 +++
> >  arch/x86/lib/retpoline.S      | 2 ++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index 9cdb1a7332c4..54a5596adaa6 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -132,7 +132,10 @@ SECTIONS
> >  		LOCK_TEXT
> >  		KPROBES_TEXT
> >  		SOFTIRQENTRY_TEXT
> > +#ifdef CONFIG_RETPOLINE
> >  		*(.text..__x86.indirect_thunk)
> > +		*(.text..__x86.return_thunk)
> > +#endif
> >  		STATIC_CALL_TEXT
> >  
> >  		ALIGN_ENTRY_TEXT_BEGIN
> > diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> > index db813113e637..3da768a71cf9 100644
> > --- a/arch/x86/lib/retpoline.S
> > +++ b/arch/x86/lib/retpoline.S
> > @@ -129,6 +129,8 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
> >  
> >  #ifdef CONFIG_RETHUNK
> 
> Perhaps elucidate the future reader with a comment here? Lest someone
> tries removing it again.

Yes, please.

Also we could make objtool properly detect the non-relocated jump
target.  But this works for now.

-- 
Josh
