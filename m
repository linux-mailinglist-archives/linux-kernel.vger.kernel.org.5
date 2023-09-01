Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9078FB0A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348856AbjIAJk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjIAJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:40:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B11510D5;
        Fri,  1 Sep 2023 02:40:53 -0700 (PDT)
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C15BD1EC0851;
        Fri,  1 Sep 2023 11:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693561251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=t+/LYnIYwbjlXbx4fCF6igIjr0FYmqpQBG1b5LR/UAg=;
        b=fHT9sT7bBf6T5ILHyNa32o00pSiSV6wtIYRrG2LzkOPYa4gglxqrf6HIYcqjGgF+x0ytZO
        onZBYK4qQV/kEUqq1hyWYSRCNpPbogu9Rrk0RtgeNlyFG4KSisktSrvGu3cpTy57zB9VPg
        9vOwuhMPRFSlNWtcaKeMuWLBNsyfdOw=
Date:   Fri, 1 Sep 2023 11:40:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: x86/bugs] x86/srso: Fix vulnerability reporting for
 missing microcode
Message-ID: <20230901094053.GDZPGxpcG56GwE0LyG@fat_crate.local>
References: <65556eeb1bf7cb9bd7db8662ef115dd73191db84.1692919072.git.jpoimboe@kernel.org>
 <169295877252.27769.17888941552572030723.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169295877252.27769.17888941552572030723.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:19:32AM -0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the x86/bugs branch of tip:
> 
> Commit-ID:     b3be1397be0340b2c30b2dcd7339dbfaa5563e2b
> Gitweb:        https://git.kernel.org/tip/b3be1397be0340b2c30b2dcd7339dbfaa5563e2b
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Fri, 25 Aug 2023 00:01:41 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 25 Aug 2023 11:21:59 +02:00
> 
> x86/srso: Fix vulnerability reporting for missing microcode
> 
> The SRSO default safe-ret mitigation is reported as "mitigated" even if
> microcode hasn't been updated.  That's wrong because userspace may still
> be vulnerable to SRSO attacks due to IBPB not flushing branch type
> predictions.
> 
> Report the safe-ret + !microcode case as vulnerable.
> 
> Also report the microcode-only case as vulnerable as it leaves the
> kernel open to attacks.
> 
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/65556eeb1bf7cb9bd7db8662ef115dd73191db84.1692919072.git.jpoimboe@kernel.org
> ---
>  Documentation/admin-guide/hw-vuln/srso.rst | 22 ++++++++++----
>  arch/x86/kernel/cpu/bugs.c                 | 34 ++++++++++++---------
>  2 files changed, 37 insertions(+), 19 deletions(-)

This is still unfixed:

https://lore.kernel.org/r/20230825072542.GFZOhXdgXpUidW51lC@fat_crate.local

mingo, do you want fixes ontop or do you wanna rebase this branch?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
