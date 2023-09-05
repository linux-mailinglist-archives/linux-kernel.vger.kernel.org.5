Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A3792A87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbjIEQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351203AbjIEFIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:08:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DD5CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 21445CE09CF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B6FC433C8;
        Tue,  5 Sep 2023 05:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890511;
        bh=gf6SttoaSH0sOjsaORIGiC4NYTXZKwN2303coDHs8Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srqYmoxpgZ0o7WqwcKJkol2PDBrOuJx2wJwE0q8fry1SoLVKGfJ5oM5+60mmahwjN
         xAyNdI5mPDwXl2WhZeZc2rg9JhPAokqeMPPGD4kS1oKcyifUgonCOflYVqslUYgjDp
         9m/VJVAoBn42GIqTrnzo6c8Z7vonsmML13m4Gvl9kZoh06UvGPlxS8jUD+kN18Febe
         wJfShylOhh4lWmoKsQOCV4U/MLEp2mu9UQaIfc433GcK15w3vIFt2Wf5yKSjsnLkzA
         1TxUVmtkzAy6yf4l7EQMXKBZeGwvhqs7ReUp/LXCOTjvA+2LCo+jbaLzSsWCfsBmzc
         XWVpBsq0j7UFw==
Date:   Mon, 4 Sep 2023 22:08:28 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 16/23] x86/bugs: Remove default case for fully switched
 enums
Message-ID: <20230905050828.2y5rx4qqq2zertk2@treble>
References: <cover.1692919072.git.jpoimboe@kernel.org>
 <858e6f4ef71cd531e64db2903d8ac4763bec0af4.1692919072.git.jpoimboe@kernel.org>
 <20230902090216.GAZPL6GF8qIT9AGc9a@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230902090216.GAZPL6GF8qIT9AGc9a@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 11:02:16AM +0200, Borislav Petkov wrote:
> On Fri, Aug 25, 2023 at 12:01:47AM -0700, Josh Poimboeuf wrote:
> > For enum switch statements which handle all possible cases, remove the
> > default case so a compiler warning gets printed if one of the enums gets
> > accidentally omitted from the switch statement.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> You could just as well take care of the default: cases in
> update_srbds_msr(), retbleed_select_mitigation(), unpriv_ebpf_notify(),
> spectre_v2_parse_user_cmdline() and cpu_show_common() and get rid of
> them all in this file and have the compiler warn for all of them.

I tried that, but adding all the unused cases adds a LOT of noise.  For
example the switch statement in spectre_v2_parse_user_cmdline() has
eight unused enums.  'default' is much more compact and readable than a
big list of all the unused enums which aren't really relevant there.

And in other places it added confusion. e.g., "RETBLEED_MITIGATION_NONE
isn't possible here, why is it being checked?"

It's a balance between readability and robustness (which is itself
affected by readability).  So I just constrained the patch to switch
statements which already handle all possible cases (as described above).

-- 
Josh
