Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CCE792B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjIEQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349788AbjIEE5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01D0CC5;
        Mon,  4 Sep 2023 21:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8246121E;
        Tue,  5 Sep 2023 04:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677BAC433C8;
        Tue,  5 Sep 2023 04:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693889855;
        bh=JIP++cPVdN4nK3wcHg3sRFafmL9acf1KxQP/30bEbZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfxU8DmDHYvBQ5L1+iQFw3IbyQocEjxrHCCnJzwrPA2XPKbDIHPvt5y6+b797wLia
         jJ00w09VMHovvemGQvOANj5vCTBg1/ESHuJotjKx3bseYPHEBYS8of0u0kyiGPFCt7
         inmX63wH7bAuWWqIWp+s/rIpbDVVAZxXtz2tVS9RiYuxoj5fn6yOvgtlvh5s3vIExD
         dJht24iJ4ZfKymIGu19DjkSw+dwq1BjSQ5EGGCRaMdAIKn3tYOn0aUwu2eUHAV0mXB
         TGCyIThhe2kMYtJvDrvrIOEr/I60Mg6wa6gbZTcBq0FFKWJ0qJ1Xz3Ece32rWh2+Bz
         mj8Phk/ngB93w==
Date:   Mon, 4 Sep 2023 21:57:33 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/bugs] x86/srso: Fix vulnerability reporting for
 missing microcode
Message-ID: <20230905045733.tcr7f4x6lxy7djsv@treble>
References: <65556eeb1bf7cb9bd7db8662ef115dd73191db84.1692919072.git.jpoimboe@kernel.org>
 <169295877252.27769.17888941552572030723.tip-bot2@tip-bot2>
 <20230901094053.GDZPGxpcG56GwE0LyG@fat_crate.local>
 <ZPMSbabIw5ZtTqbo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPMSbabIw5ZtTqbo@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 12:46:05PM +0200, Ingo Molnar wrote:
> 
> * Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Fri, Aug 25, 2023 at 10:19:32AM -0000, tip-bot2 for Josh Poimboeuf wrote:
> > > The following commit has been merged into the x86/bugs branch of tip:
> > > 
> > > Commit-ID:     b3be1397be0340b2c30b2dcd7339dbfaa5563e2b
> > > Gitweb:        https://git.kernel.org/tip/b3be1397be0340b2c30b2dcd7339dbfaa5563e2b
> > > Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> > > AuthorDate:    Fri, 25 Aug 2023 00:01:41 -07:00
> > > Committer:     Ingo Molnar <mingo@kernel.org>
> > > CommitterDate: Fri, 25 Aug 2023 11:21:59 +02:00
> > > 
> > > x86/srso: Fix vulnerability reporting for missing microcode
> > > 
> > > The SRSO default safe-ret mitigation is reported as "mitigated" even if
> > > microcode hasn't been updated.  That's wrong because userspace may still
> > > be vulnerable to SRSO attacks due to IBPB not flushing branch type
> > > predictions.
> > > 
> > > Report the safe-ret + !microcode case as vulnerable.
> > > 
> > > Also report the microcode-only case as vulnerable as it leaves the
> > > kernel open to attacks.
> > > 
> > > Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > > Link: https://lore.kernel.org/r/65556eeb1bf7cb9bd7db8662ef115dd73191db84.1692919072.git.jpoimboe@kernel.org
> > > ---
> > >  Documentation/admin-guide/hw-vuln/srso.rst | 22 ++++++++++----
> > >  arch/x86/kernel/cpu/bugs.c                 | 34 ++++++++++++---------
> > >  2 files changed, 37 insertions(+), 19 deletions(-)
> > 
> > This is still unfixed:
> > 
> > https://lore.kernel.org/r/20230825072542.GFZOhXdgXpUidW51lC@fat_crate.local
> > 
> > mingo, do you want fixes ontop or do you wanna rebase this branch?
> 
> Since these are fixes that are supposed to be fully correct,
> I'd suggest we rebase it.
> 
> Josh, mind sending a v3 SRSO series, as a replacement for x86/bugs,
> with Boris's review & testing feedback addressed?

Ok, I'll post a v3 (with Boris' comments integrated).

-- 
Josh
