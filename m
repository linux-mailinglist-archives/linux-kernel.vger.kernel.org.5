Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE147C736C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379559AbjJLQsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379203AbjJLQsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:48:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543ABBE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:48:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75305C433CA;
        Thu, 12 Oct 2023 16:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697129296;
        bh=0de80uOB+SpKXQu5Erh+GY63yoTazWhZ2zzX49im/+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAg6MqhBv2YbjeTTZt4FJI7yhkZs94Mctwz01BGGk4/q5xmAMukI6WbSrBKAPuAwC
         K1aB4dfjxlw7GFL0whc80uOodjKyc03C27H7GmlAfoqUPl+WkiA2V+0JIlPqxcf618
         BZ4txRix90abWc/XWNWSL9hYdyVPRwUnPoLWyieuqykdvft4xdLfXcFEIHvVniz2OO
         gZxLHIshBcPiaC2SbjnwIFhiSkl1+VuwK4mmMEoF2n8/HRS6X0NjhxqHEPVens+TxC
         jYXI3YoE81UpE6F02uVYk/ruyYhfaZNBo0xl6oJKMVXIXN9G70C7R/2TKA1vZ+kEgP
         iYJ1rWLD/jKQw==
Date:   Thu, 12 Oct 2023 09:48:14 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231012164814.oc3r3sovsfrldpop@treble>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
 <20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local>
 <20231011220325.5uje4xnfxuccumm7@treble>
 <20231012072920.GAZSegUJkwHbcernQo@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012072920.GAZSegUJkwHbcernQo@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:29:20AM +0200, Borislav Petkov wrote:
> On Wed, Oct 11, 2023 at 03:03:25PM -0700, Josh Poimboeuf wrote:
> > I wouldn't call it senseless churn.  There are concrete benefits -- for
> > both users and developers -- of having all the mitigation config options
> > living in the same config namespace.
> 
> I don't see it. What does the same namespace give you? So you see in the
> code a bunch of ifdeffery and some or all of them have
> CONFIG_MITIGATION_ prepended. To me it doesn't matter whether they're
> mitigations or not - it is just the next Kconfig symbol.

It adds clarity by making the options more self-documenting.

For users who care about such things it makes it easier to identify
which options they need to enable or disable.  And it makes it clearer
what those options do without having to go read the docs.

For developers it helps code readability: "ah, this nasty code is for a
side channel mitigation".  Also it makes it easier to grep for.

> > Sure, the change might cause pain for users who disable these options,
> > but do those users actually exist?
> 
> Apparently there are use cases where people simply want to disable all
> that mitigation crap because they want their performance back. This
> thread being one. And I know of another one with a similar sentiment.

Right, but we have a global option for that.  I was wondering if anybody
actually uses the individual options (though I agree with Linus they
should exist to help with code readability).

-- 
Josh
