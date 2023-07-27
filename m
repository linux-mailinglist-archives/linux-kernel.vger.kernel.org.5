Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5176430E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjG0AkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjG0AkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F626B8;
        Wed, 26 Jul 2023 17:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A1261CEB;
        Thu, 27 Jul 2023 00:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F6EC433C8;
        Thu, 27 Jul 2023 00:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690418413;
        bh=bIxzDzckDOV+yM7eiBmD39zBN7MRQIJGobg3S+qBGR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=juB5hZK8dFTsZ+utAZedw/NHq9F4gYi+d5wUUMNF2wRplaT9HwYrsLVBrCX5Ps+rz
         GyTBkiTP6G9ndORaSiK6+4+8mtJRRsJvkJ4aoN2WX0QC4rzlTb3SAz0i4ZeIXjdtiF
         luGG0cWpq4giUWbpfCIo4Xznp3gKNt6sx91wI80ktTdL/Fm9I7CYTwA/68aTLVXZNs
         Q7Ogf+ON9Jp3LQxf3Ofc2nNZN+lCjpatC4x8PtLIl+MCTwAXDtP4/tvkQpFveazSqy
         bBAaisKfCfy5VXwJ/WLcXhsbEFLPZzEZuI+7sKdGBQfvrcIducXdpZZ8zDwTMaV7Da
         wRonsR0+r/bqA==
Date:   Thu, 27 Jul 2023 09:40:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/kprobes: Prohibit probing on compiler
 generated CFI checking code
Message-Id: <20230727094007.96e35433ec7ce10e3010359b@kernel.org>
In-Reply-To: <20230726092917.GB3802077@hirez.programming.kicks-ass.net>
References: <168904023542.116016.10540228903086100726.stgit@devnote2>
        <168904025785.116016.12766408611437534723.stgit@devnote2>
        <20230726122317.9058a6bed272835f0c1a3b29@kernel.org>
        <20230726092917.GB3802077@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 11:29:17 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jul 26, 2023 at 12:23:17PM +0900, Masami Hiramatsu wrote:
> > On Tue, 11 Jul 2023 10:50:58 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Prohibit probing on the compiler generated CFI typeid checking code
> > > because it is used for decoding typeid when CFI error happens.
> > > 
> > > The compiler generates the following instruction sequence for indirect
> > > call checks on x86;
> > > 
> > >    movl    -<id>, %r10d       ; 6 bytes
> > >    addl    -4(%reg), %r10d    ; 4 bytes
> > >    je      .Ltmp1             ; 2 bytes
> > >    ud2                        ; <- regs->ip
> > > 
> > > And handle_cfi_failure() decodes these instructions (movl and addl)
> > > for the typeid and the target address. Thus if we put a kprobe on
> > > those instructions, the decode will fail and report a wrong typeid
> > > and target address.
> > > 
> > > 
> > 
> > Hi Peter,
> > 
> > Can I pick this to probes/fixes branch ?
> 
> I'll stick them in tip/x86/core, that ok?

Yes, since it is for CFI change. 

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
