Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887A7C4192
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbjJJUlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjJJUlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:41:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1728E1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:41:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC287C433C9;
        Tue, 10 Oct 2023 20:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970481;
        bh=Bnd4fS4lpjScJDelZFnaw36gFOCQV836uDYvVRt8kkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZbToJHHyHxLcoLX35DZpTmHZT8E9+CnT+QCi9O3Ap12TByUHcnAU4luy715JPUqB
         6BgyxBmQIewMxNXWzgApFnAvQsG1oJ2UD+i47yIeUokz6VyOjkEHwwep6S0maEnf1f
         tp8vfNqc5+tsWyQCrpCBSYw2Sql76KjTSW8HpfvOV8lvVsqC5g6WyFhIMOUA7Y+UZd
         lDRjyFYanrwzfQcpkc5YvrTfHP7jJxGystAzljEAG6eb+W9+731yMi/44p6KQo7fQq
         H8zhOMRBWeidZOkrLK2ZH8IUzcbwRwXQnu25lnNQDZGGytKy+5c16tfZukuZ/f7e80
         clGoL8NlVEMzQ==
Date:   Tue, 10 Oct 2023 13:41:19 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Kaplan, David" <David.Kaplan@amd.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231010204119.76i7vwecmeo6ex6d@treble>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-4-david.kaplan@amd.com>
 <20231010193643.su6iqjniuxqqke6d@treble>
 <SN6PR12MB2702315F5C39E5354D63E68E94CDA@SN6PR12MB2702.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2702315F5C39E5354D63E68E94CDA@SN6PR12MB2702.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 08:14:33PM +0000, Kaplan, David wrote:
> [AMD Official Use Only - General]
> 
> > -----Original Message-----
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > Sent: Tuesday, October 10, 2023 2:37 PM
> > To: Kaplan, David <David.Kaplan@amd.com>
> > Cc: x86@kernel.org; luto@kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 3/3] x86/retpoline: Ensure default return thunk isn't used
> > at runtime
> >
> > >   *
> > > - * This code is only used during kernel boot or module init.  All
> > > + * This code is only used during kernel boot.  All
> > >   * 'JMP __x86_return_thunk' sites are changed to something else by
> > >   * apply_returns().
> > > + *
> > > + * This thunk is turned into a ud2 to ensure it is never used at runtime.
> > > + * Alternative instructions are applied after apply_returns().
> > >   */
> > >  SYM_CODE_START(__x86_return_thunk)
> > >       UNWIND_HINT_FUNC
> > >       ANNOTATE_NOENDBR
> > > -     ANNOTATE_UNRET_SAFE
> > > -     ret
> > > +     ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2",
> > > + X86_FEATURE_RETHUNK
> >
> > If it's truly never used after boot (even for non-rethunk cases) then can we use
> > X86_FEATURE_ALWAYS?
> >
> 
> I think that could work.  There is one subtlety though I'll point out:
> 
> The use of __x86_return_thunk when X86_FEATURE_RETHUNK is set is a
> potential security issue, as it means the required return thunk is not
> being used.  The use of __x86_return_thunk when X86_FEATURE_RETHUNK is
> not set is only a performance issue, as it means there is a return
> that was not rewritten to be an inline 'ret' by apply_returns().
> 
> The ud2 was primarily intended to capture cases where there is a
> potential security hole, while it is a bit overkill just to point out
> a return that was not optimized.

Even if it's not a security hole, I'd still view it as a major BUG() as
it would directly contradict our understanding (and the comments above)
and could cause performance or other correctness issues that would
otherwise go unnoticed.

So I think an unconditional UD2 is warranted.

-- 
Josh
