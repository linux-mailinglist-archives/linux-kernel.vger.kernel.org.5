Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF177762000
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGYRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:21:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74900E7B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 135B161802
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 17:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A83C433C7;
        Tue, 25 Jul 2023 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690305669;
        bh=lURcrrt2daMFZ583HhOvfgTzAd/PQvOn7GsRbPQmPL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWhbPk6w4y+syXxkPzxSt31VwPPRMHuZJacuxPSysODSAn7OC4h71O/AWq/S0Jjyy
         Q19VQMLnwZFVE7QxN7lt9IfTD7967np4EoDj1aH8Kz71ozS2bgkFaAkzofAqXVdg7S
         u2MAEgtTlzvOW475lpnO+1V6pmUcqlRIdkLkWIWBOsSY7KEy3n2JrQaiMYVdZR9AcF
         gWaQPbMzDuWOLnkGyKQLbkLVsO9kSGXEUcWU8r9mpCJ0oDxkBGFCP+4SBRSqGDRszy
         bb2JrSs2h8zC1PawwN5r70IjeaE5OpGR09zps4DVCfGGc7671NAQS7UlHkq4EPIU6N
         TfWXg1Dw+5Q3w==
Date:   Tue, 25 Jul 2023 18:21:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] scripts/faddr2line: Ignore non-function symbols in
 readelf output
Message-ID: <20230725172104.GA16719@willie-the-truck>
References: <20230724174517.15736-1-will@kernel.org>
 <20230724174517.15736-2-will@kernel.org>
 <20230724234734.zy67gm674vl3p3wv@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724234734.zy67gm674vl3p3wv@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 04:47:34PM -0700, Josh Poimboeuf wrote:
> On Mon, Jul 24, 2023 at 06:45:16PM +0100, Will Deacon wrote:
> > Non-function symbols emitted in the readelf output can confuse the
> > 'faddr2line' symbol size calculation, resulting in the erroneous
> > rejection of valid offsets. This is especially prevalent when building
> > an arm64 kernel with CONFIG_CFI_CLANG=y, where most functions are
> > prefixed with a 32-bit data value in a '$d.n' section. For example:
> > 
> > 447538: ffff800080014b80   548 FUNC    GLOBAL DEFAULT    2 do_one_initcall
> >    104: ffff800080014c74     0 NOTYPE  LOCAL  DEFAULT    2 $x.73
> >    106: ffff800080014d30     0 NOTYPE  LOCAL  DEFAULT    2 $x.75
> >    111: ffff800080014da4     0 NOTYPE  LOCAL  DEFAULT    2 $d.78
> >    112: ffff800080014da8     0 NOTYPE  LOCAL  DEFAULT    2 $x.79
> >     36: ffff800080014de0   200 FUNC    LOCAL  DEFAULT    2 run_init_process
> > 
> > Adding a warning to do_one_initcall() results in:
> > 
> >   | WARNING: CPU: 0 PID: 1 at init/main.c:1236 do_one_initcall+0xf4/0x260
> > 
> > Which 'faddr2line' refuses to accept:
> > 
> > $ ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
> > skipping do_one_initcall address at 0xffff800080014c74 due to size mismatch (0x260 != 0x224)
> > no match for do_one_initcall+0xf4/0x260
> > 
> > Filter out entries from readelf that are not "FUNC" type, so that the
> > size of a symbol is calculated as a delta to the next function address.
> 
> Problem is, I think the kernel's symbol printing code prints the nearest
> kallsyms symbol, and there are some valid non-FUNC code symbols.  For
> example, syscall_return_via_sysret.  This patch would cause those valid
> symbols to get missed.

Damn, yes, I can see a few of those in the arm64 vmlinux too. Thanks for
pointing it out.

> I presume these '$x.*' symbols don't end up in System.map?  How do they
> get filtered out?  By the linker maybe?

See the horrible ad-hoc list of ignored symbol types which get regexed
out by scripts/mksysmap.

> We may want to use whatever criteria used there, e.g. have faddr2line
> ignore symbols starting with '$' or so?

My first hack for this did exactly that (ignore symbols starting with '$'),
but then I tried to find ways to make it a bit more general. Lemme have a
crack at factoring out the stuff from mksysmap before I resort back to
checking for the '$' prefix.

Will
