Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF447CE77F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjJRTON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJRTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:14:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C023CAB;
        Wed, 18 Oct 2023 12:14:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C838C433C7;
        Wed, 18 Oct 2023 19:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697656449;
        bh=dFRqduN7YTqHc7HQ6JGA9+8GGHtLEMQGa5F7wvBiPHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERr6Rza2enKVLtJLaYvNUvT3qymcYtjkxskJfJNvUezR7q5EiZujK8LY2HXB9L00Q
         9kqYQTYAYz5hb+otyknNMAizUtiHBKDOUK/x0MxPaS7/nwv+/pxMUHXDM45wsOhzWv
         ab6/CY7i45HGx4N0ZAERFxvasZJi/k8FQr4/ilHv7oavWDqb1FRLBq2P9iEu9j3t01
         ihYJYtIgLy+WKR5WDXxFYqVtCzzbZAnOwtszI2xVGMyGQejLhKOYNUV3aI3dHTiAfY
         0LrcNQXUhB+v1ZcR01rZka5Bz5BgbN8o7UWl/l9n3T4hKenAjBHvg104KR3Fn2PENu
         4nUHyDrZhi7uQ==
Date:   Wed, 18 Oct 2023 12:14:07 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018191407.n4ys6vefbio7z3sn@treble>
References: <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
 <ZS/f8DeEIWhBtBeb@gmail.com>
 <20231018151245.GCZS/17QhDGe7q6K+w@fat_crate.local>
 <20231018155433.z4auwckr5s27wnig@treble>
 <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <20231018181431.skre6i6vzrxsprck@treble>
 <20231018182223.GFZTAiX4BJ6FT8bHzz@fat_crate.local>
 <20231018183915.xwamzzqjf6gehaou@treble>
 <20231018184431.GGZTAnj8V/R54S5KK9@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018184431.GGZTAnj8V/R54S5KK9@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:44:31PM +0200, Borislav Petkov wrote:
> On Wed, Oct 18, 2023 at 11:39:15AM -0700, Josh Poimboeuf wrote:
> > And see my reply to that?  Not trying to be daft, I just didn't see how
> > your reply was responsive.
> > 
> > A single WARN_ONCE() has the benefit of not overflowing dmesg, while
> > also making the warning available to those looking at dmesg (or the
> > taint flag), as those who care should be.
> 
> A single WARN once is not enough as this is security-sensitive. Warns do
> get ignored.
> 
> > A rate-limited WARN() is problematic, as it overflows dmesg (and
> > possibly wrapping other logs), potentially obscuring other important
> > data.
> 
> This will hopefully make people look by screaming louder. But no
> guarantee. Not saying it is the right thing.
> 
> UDing without any output is not the right thing either.
> 
> All I'm saying is, there's no good solution for how to catch this and
> make people report it.
> 
> Make more sense?

There are a lot of warnings which could become security concerns.

By definition, a warning means something is seriously wrong.  If it's
ignored, all bets are off.  That's why we taint the kernel.

-- 
Josh
