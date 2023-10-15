Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD3D7C995C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjJOOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJOOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 10:11:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA4C1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 07:11:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D07C433C8;
        Sun, 15 Oct 2023 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697379109;
        bh=LFNdNsGAMbqe7hSeH1fGRFeRTjU002PIz9XKawV1Jzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skSL6MG8l7wMkAGqXvF0oJSKdTWKSwCtreJt4iU3vrdia+jazYFbeFh9ga4kFr0t2
         SFof4vJLThtIW7J5PEvtHq+vZCIY2gRxipBudDHBo5a8ycvbU4/dO7HHmxXCoeH1QM
         l/ZvHKdWZ9z7OZE+BkgzgQvFmX9xSSnjnTrwR4DA4Ojstc6neVFx83HPkEo80VY459
         4wW25wZFKcR1qML96cT7WnjviyydeaQ9s3BMwwlN8+lpWn4HnB0VcJLXOfz8rd0ML6
         qgfFyWCDXc3PHUQ1JfrT2+syhy6ZNIx0zsUDCmW/1TCh8VL1MPbjlAzpxr819M6dLF
         8RPX3Ei2Mwbvw==
Date:   Sun, 15 Oct 2023 07:11:47 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de, bp@alien8.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231015141147.qeczgcfnl73zcqao@treble>
References: <20231010103028.4192223-1-leitao@debian.org>
 <ZSca08rnmZfkONEH@gmail.com>
 <ZSfucR6docdnLznb@gmail.com>
 <20231012170548.o5vi4kgpvpjyld7s@treble>
 <ZShALJDaxJ9VJvek@gmail.com>
 <20231012204347.4aei5jr64fsv2iv5@treble>
 <ZSkhE2GWfGRW+9Hh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSkhE2GWfGRW+9Hh@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:50:59PM +0200, Ingo Molnar wrote:
> 
> * Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > On Thu, Oct 12, 2023 at 08:51:24PM +0200, Ingo Molnar wrote:
> > > > Another way to avoid ifdeffery:
> > > > 
> > > > static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
> > > > 	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
> > > 
> > > I think we could make it a simple:
> > > 
> > > 	static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init = IS_ENABLED(CONFIG_MITIGATION_RETBLEED);
> > > 
> > > Because RETBLEED_CMD_AUTO && RETBLEED_CMD_OFF maps naturally to 1 and 0. 
> > > Maybe add a comment to the enum to maintain this property in the future 
> > > too.
> > 
> > Hm, that both obfuscates the default and makes it fragile.  The fact
> > that it would need a comment to try to prevent breaking it in the future
> > is a clue that maybe we shouldn't do it ;-)
> 
> Can be enforced with BUILD_BUG_ON().

That replaces fragility with brittleness.  If we change a default then
we have to go rearrange the corresponding enum, and update the
BUILD_BUG_ONs.

More importantly, it's still less readable because the reader now has to
go read the enum values to cross-reference the hard-coded values of 0
and 1 with the enums which are used everywhere else.

-- 
Josh
