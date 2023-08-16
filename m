Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8994877E91A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjHPSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344743AbjHPSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF2C26BE;
        Wed, 16 Aug 2023 11:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70FB6599F;
        Wed, 16 Aug 2023 18:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00935C433C7;
        Wed, 16 Aug 2023 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692212049;
        bh=GaVKoFL4ir5wQAKCJTi8wVVUQWo4ByRUiSfnqWSW7wI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YQmGSkMUHdhjC2FgCoqUheVxMp0mCUP4EF6y48fyRP25egKWkP5QfnptRYr87aMIC
         d2iVw8hhfl8w0uvC50a+rYwW3Vhz/8KfKHt9uznpfjBYvFBD+Ati3sMkD+UiY1r3oI
         5pjJpzhZo1NYdp9vIczURWXsy/6JxPsDPVv3pHxGhQt+NnLrgn9G9XR28l6YeT7/V6
         zCwYpqvIiwrvGsM1tlt1IKqnl5wvGTFgvIyPDnjC9sn+j33bZrZNOh1Eo218yJVR0L
         42b0egroja+Tndb/s+hi40z3ACf1JcwXHASjP3BZ9hRgZ1Okmm50UU1jGRU4eyKWrk
         HOXtFYMiJN7gQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 86F2FCE06FA; Wed, 16 Aug 2023 11:54:08 -0700 (PDT)
Date:   Wed, 16 Aug 2023 11:54:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, keescook@chromium.org,
        elver@google.com, dvyukov@google.com, glider@google.com
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
Message-ID: <9ff0f0fa-438a-4019-afa1-4579041405b5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
 <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816181720.GNZN0SsKi/B4eCsZHu@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:17:20PM +0200, Borislav Petkov wrote:
> Hey Paul,
> 
> On Wed, Aug 16, 2023 at 10:54:09AM -0700, Paul E. McKenney wrote:
> > I hit the splat at the end of this message in recent mainline, and has
> > appeared some time since v6.5-rc1.  Should I be worried?
> 
> does it go away if you try the latest tip:x86/urgent branch?

That is plausible, given that bisection has narrowed things down to
somewhere between v6.5-rc5 and v6.5-rc6.  And it is quite conveniently
currently on a bad commit.  Sometimes you get lucky.  ;-)

So pulling in those commits from -tip, currently headed by this one:

d80c3c9de067 ("x86/srso: Explain the untraining sequences a bit more")

Then merging them with the current bad commit gets me a successful
run.  Thank you!!!

							Thanx, Paul
