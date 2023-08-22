Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4D784CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjHVWSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHVWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A28CCB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D534C62877
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A277FC433C8;
        Tue, 22 Aug 2023 22:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692742711;
        bh=68hXbjLaCQXJJIn/fZKNn5XJdGeUPJs/ti87OYETE0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGpLFj9yB+VprPQ1IUQvNZJdHrRpy3jA9dB6CA+s3budJIkFoFpAAh9WbYeMEcjHd
         DyXvkai5Ko8eAar3pQzCD8t0fx8OcHnouWGhG+HpQ+P/eIfz12wOcMP1st2Y/VXNC6
         tT8msZ8JEdHWHHDhYvIgVvxIcoaWBOcbbNBWU/oxQH0Lr35QHslL9UhM6TFfa0MrUL
         SaIi1bnVQKiFEn68LSS2+ZieT0b2HtXLOl8bepM8PRRZxFycyZfsk7E8mVk3tA57dl
         iqaExesmN4pYpHsXYZgWw86oEj36h7t5PtdnmfV1zp2TNSwAe/J6h9LDQ0WxmLjdF2
         JaEXbwBKhvUTA==
Date:   Tue, 22 Aug 2023 15:18:28 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 4/4] x86/srso: Use CALL-based return thunks to reduce
 overhead
Message-ID: <20230822221828.htnwidmr22gtjhcd@treble>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-5-andrew.cooper3@citrix.com>
 <20230821151636.onk2e6tlhmjg5yz5@treble>
 <810fa94b-9417-0076-1232-d263ef882027@citrix.com>
 <20230822022229.xlctyccmgdxiy6ic@treble>
 <9565380a-4654-f267-c8ac-a4d6ab81156a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9565380a-4654-f267-c8ac-a4d6ab81156a@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 09:45:07AM +0300, Nikolay Borisov wrote:
> 
> 
> On 22.08.23 г. 5:22 ч., Josh Poimboeuf wrote:
> > On Tue, Aug 22, 2023 at 12:01:29AM +0100, Andrew Cooper wrote:
> > > On 21/08/2023 4:16 pm, Josh Poimboeuf wrote:
> > > > On Mon, Aug 21, 2023 at 12:27:23PM +0100, Andrew Cooper wrote:
> > > > > The SRSO safety depends on having a CALL to an {ADD,LEA}/RET sequence which
> > > > > has been made safe in the BTB.  Specifically, there needs to be no pertubance
> > > > > to the RAS between a correctly predicted CALL and the subsequent RET.
> > > > > 
> > > > > Use the new infrastructure to CALL to a return thunk.  Remove
> > > > > srso_fam1?_safe_ret() symbols and point srso_fam1?_return_thunk().
> > > > > 
> > > > > This removes one taken branch from every function return, which will reduce
> > > > > the overhead of the mitigation.  It also removes one of three moving pieces
> > > > > from the SRSO mess.
> > > > So, the address of whatever instruction comes after the 'CALL
> > > > srso_*_return_thunk' is added to the RSB/RAS, and that might be
> > > > speculated to when the thunk returns.  Is that a concern?
> > > 
> > > That is very intentional, and key to the safety.
> > > 
> > > Replacing a RET with a CALL/{ADD,LEA}/RET sequence is a form of
> > > retpoline thunk.  The only difference with regular retpolines is that
> > > the intended target is already on the stack, and not in a GPR.
> > > 
> > > 
> > > If the CALL mispredicts, it doesn't matter.  When decode catches up
> > > (allegedly either instantaneously on Fam19h, or a few cycles late on
> > > Fam17h), the top of the RAS is corrected will point at the INT3
> > > following the CALL instruction.
> > 
> > That's the thing though, at least with my kernel/compiler combo there's
> > no INT3 after the JMP __x86_return_thunk, and there's no room to patch
> > one in after the CALL, as the JMP and CALL are both 5 bytes.
> 
> FWIW gcc's mfunction-return=thunk-return only ever generates a jmp,
> thunk/thunk-inline OTOH generates a "full fledged" thunk with all the
> necessary speculation catching tricks.
> 
> For reference:
> 
> https://godbolt.org/z/M1avYc63b

The problem is the call-site, not the thunk.  Ideally we'd have an
option which adds an INT3 after the 'JMP __x86_return_thunk'.

-- 
Josh
