Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535037880BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbjHYHPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbjHYHPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD019B0;
        Fri, 25 Aug 2023 00:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9686266798;
        Fri, 25 Aug 2023 07:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA50C433C7;
        Fri, 25 Aug 2023 07:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692947715;
        bh=JLsSZDXLKc5glBFhzwQ6UlaoXdzLUq4UKNtCPROpmgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Icujbchq2KE69jLiNDRzCfoaMuLd8AvDhe30LVIIXZ2QAUTA40rlmOUOfmAb0/ZQl
         HSgUYDB7R8FhpgtogKB0yy7/iSvWbiqqRj4XkdzoBfvlwqrYAhepnAIWssa4BmUDEZ
         mcrAiNd0ZIEAdpiztq1+zJH8+btq5IhKk1n5fd6OaD+0dyuk+nzgQkO5IVebtGAlLN
         vpCUBGk8qAN/+fgCHS4azptOlfXU+5Yx7DQOhYeyEA8KOsf7vfZSpo3vawj2+pJ8fR
         34NBMz/3Po2kN5sQdDLtbju88w5RJwzxQqoZ0K3z3oS+RlSzfHEsQHwl6lJ+jzg3bS
         WYoWko9xcpF9w==
Date:   Fri, 25 Aug 2023 00:15:12 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, keescook@chromium.org,
        elver@google.com, dvyukov@google.com, glider@google.com
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
Message-ID: <20230825071512.yqtpmrie2zma3qcp@treble>
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
 <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
 <2023082458-vividness-habitable-cbc8@gregkh>
 <20230825063302.GBZOhLHgdvhIw1d6f1@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230825063302.GBZOhLHgdvhIw1d6f1@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 08:33:02AM +0200, Borislav Petkov wrote:
> On Thu, Aug 24, 2023 at 03:52:56PM +0200, Greg KH wrote:
> > On Wed, Aug 16, 2023 at 08:17:20PM +0200, Borislav Petkov wrote:
> > > Hey Paul,
> > > 
> > > On Wed, Aug 16, 2023 at 10:54:09AM -0700, Paul E. McKenney wrote:
> > > > I hit the splat at the end of this message in recent mainline, and has
> > > > appeared some time since v6.5-rc1.  Should I be worried?
> > > 
> > > does it go away if you try the latest tip:x86/urgent branch?
> > 
> > Note, this problem is showing up in the 6.1.y branch right now, due to
> > one objtool patch not being able to be backported there easily (i.e. I
> > tried and gave up.)
> > 
> > 4ae68b26c3ab ("objtool/x86: Fix SRSO mess") being the commit that I
> > can't seem to get to work properly, my attempt can be seen here:
> > 	https://lore.kernel.org/r/2023082212-pregnant-lizard-80e0@gregkh
> > 
> > Just a heads up as this will start to affect users of the next 6.1.y
> > release, and probably older releases, as they are taking portions of the
> > "fixes for fixes" but not the above mentioned one.
> 
> Hmm, Peter and I are away, I guess maybe Josh might have an idea how and
> what to backport to 6.1 to get this sorted out...
> 
> CCed.

Sure, will take a look tomorrow.

-- 
Josh
