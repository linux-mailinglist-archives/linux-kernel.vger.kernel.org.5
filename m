Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988F17837DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjHVCWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHVCWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:22:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6BDB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBC54646F3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF53CC433C7;
        Tue, 22 Aug 2023 02:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692670952;
        bh=XPEg5hUhI7aGUhMtVHHgnDv/L9i0G9LNRyzRNkNkFdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoWYIIbE+vK0DxVQ4dcG9LGDVUpnwr9HGaXmBDi/yhO9VB71fFJrYQeGbymbpZ4JA
         /Kn75DtzlOoIF//ehC5WIxJ2O2AQqv/m4T2MPBLxZX2hgLo595E7JwvNcHDnYreIIE
         C3EahmqtWp2fzqmAfYEfsFU+qrx9ndALzI/4mwTnd+82aOierotcTrPJx5mOhSH5nP
         9GwKEfPE5eMJX7UNM0X07sR7Cjz2J2Nn/cP1n3MjfqPZvJLfeRZ9V3T5p4mqMDu3zl
         8IyyOpj3lRduE3GoEFZqHR9p8e0U9+r+OuSqMeimNvNQuN0ht+seuT6JxqAaYJXJz6
         0qgqkh2WA58iA==
Date:   Mon, 21 Aug 2023 19:22:29 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 4/4] x86/srso: Use CALL-based return thunks to reduce
 overhead
Message-ID: <20230822022229.xlctyccmgdxiy6ic@treble>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-5-andrew.cooper3@citrix.com>
 <20230821151636.onk2e6tlhmjg5yz5@treble>
 <810fa94b-9417-0076-1232-d263ef882027@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <810fa94b-9417-0076-1232-d263ef882027@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:01:29AM +0100, Andrew Cooper wrote:
> On 21/08/2023 4:16 pm, Josh Poimboeuf wrote:
> > On Mon, Aug 21, 2023 at 12:27:23PM +0100, Andrew Cooper wrote:
> >> The SRSO safety depends on having a CALL to an {ADD,LEA}/RET sequence which
> >> has been made safe in the BTB.  Specifically, there needs to be no pertubance
> >> to the RAS between a correctly predicted CALL and the subsequent RET.
> >>
> >> Use the new infrastructure to CALL to a return thunk.  Remove
> >> srso_fam1?_safe_ret() symbols and point srso_fam1?_return_thunk().
> >>
> >> This removes one taken branch from every function return, which will reduce
> >> the overhead of the mitigation.  It also removes one of three moving pieces
> >> from the SRSO mess.
> > So, the address of whatever instruction comes after the 'CALL
> > srso_*_return_thunk' is added to the RSB/RAS, and that might be
> > speculated to when the thunk returns.  Is that a concern?
> 
> That is very intentional, and key to the safety.
> 
> Replacing a RET with a CALL/{ADD,LEA}/RET sequence is a form of
> retpoline thunk.  The only difference with regular retpolines is that
> the intended target is already on the stack, and not in a GPR.
> 
> 
> If the CALL mispredicts, it doesn't matter.  When decode catches up
> (allegedly either instantaneously on Fam19h, or a few cycles late on
> Fam17h), the top of the RAS is corrected will point at the INT3
> following the CALL instruction.

That's the thing though, at least with my kernel/compiler combo there's
no INT3 after the JMP __x86_return_thunk, and there's no room to patch
one in after the CALL, as the JMP and CALL are both 5 bytes.

-- 
Josh
