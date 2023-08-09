Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38877627E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjHIOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjHIOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E98210A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E1763BE0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FF0C433C7;
        Wed,  9 Aug 2023 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691591403;
        bh=MFK5uGh92qEq1YLPYeOW8l/+naM+KPMX4g9a252PIq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p87ULpwepzMvz3T7OKMoJlsNgVv847O4EHzJ6A5pZnNbMtmBJTtnOP2NKIyihW9Yt
         GLmRx7WChr5lIoHl9vf6C8I7z5I6+xQ8Sk65LUAhqF+VTvACXZIv1pc+WBhAXB/E5o
         11I0PvQTKLAWvdYz0bML9kGs3XWopBYx+nYXRKdFgWGfe57tfwWVmsH0zK7PkBdzn4
         yi8iHOl/FxPKfHacNlE8/Gy9ScmOWv5+bjKmAc5VejPDzdBfrKY2SVIX4Xrl1J+cAk
         /lspXWX+pZdKxR4FQIAuI1Q+AVcwfMrriMBKpdINPKEc2TY/L6Amz0HBZzfcW+DYet
         a7MiSaefg/gdA==
Date:   Wed, 9 Aug 2023 10:30:00 -0400
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 07/17] x86/cpu/kvm: Provide UNTRAIN_RET_VM
Message-ID: <20230809143000.tus4hqdaobk667eo@treble>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.922634286@infradead.org>
 <20230809135004.2xy76kqpptfqxsp5@treble>
 <20230809140644.GP212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809140644.GP212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 04:06:44PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 09, 2023 at 09:50:04AM -0400, Josh Poimboeuf wrote:
> > On Wed, Aug 09, 2023 at 09:12:25AM +0200, Peter Zijlstra wrote:
> > > With the difference being that UNTRAIN_RET_VM uses
> > > X86_FEATURE_IBPB_ON_VMEXIT instead of X86_FEATURE_ENTRY_IBPB.
> > > 
> > > This cures VMEXIT doing potentially unret+IBPB or double IBPB.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/include/asm/nospec-branch.h |   11 +++++++++++
> > >  arch/x86/kernel/cpu/bugs.c           |   17 ++++++++++++++++-
> > >  arch/x86/kvm/svm/vmenter.S           |    7 ++-----
> > >  3 files changed, 29 insertions(+), 6 deletions(-)
> > > 
> > > --- a/arch/x86/include/asm/nospec-branch.h
> > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > @@ -299,6 +299,17 @@
> > >  #endif
> > >  .endm
> > >  
> > > +.macro UNTRAIN_RET_VM
> > > +#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
> > > +	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
> > 
> > Maybe can be simplified?
> > 
> 
> See patches 9 and 10 :-)

Can still be further simplified to CONFIG_RETHUNK?

-- 
Josh
