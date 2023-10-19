Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D75C7CF958
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbjJSMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345698AbjJSMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:50:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2981112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:50:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 486701F45B;
        Thu, 19 Oct 2023 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697719814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lW0oi5t9RJVIfyM9NQMzhwbPShfe2mX7ZAVw1vE6IBc=;
        b=y8sv0dBdsT8JSiB68qv++9wi0gXNI78pEbuvU6KJ6HJXOc3roUjfOh/MXt8odUK8ck8HyJ
        BvxMoj/gGMBFhY9W7akTLw5Y3jwS8T6lIyvtawsahEpsECCbJK7WXcoJWfaGk6yRPmmoYn
        CPt/I1+7kmlUy9gm/KbckfRwuCAle2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697719814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lW0oi5t9RJVIfyM9NQMzhwbPShfe2mX7ZAVw1vE6IBc=;
        b=tfomFNiMemAO/QOMmicfalJ6LTcv/H0WnZIniw2O+OWrweLH3CV8J8yqS2Tgb8o58VPfa3
        XlOz32fGfPYWC3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CFEB1357F;
        Thu, 19 Oct 2023 12:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yF8WCQYmMWXUSgAAMHmgww
        (envelope-from <aporta@suse.de>); Thu, 19 Oct 2023 12:50:14 +0000
Date:   Thu, 19 Oct 2023 14:50:13 +0200
From:   Andrea della Porta <aporta@suse.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com
Subject: Re: [PATCH 4/4] arm64: Make Aarch32 emulation boot time configurable
Message-ID: <ZTEmBU73nLnYMfEC@apocalypse>
Mail-Followup-To: Mark Rutland <mark.rutland@arm.com>,
        Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com
References: <cover.1697614386.git.andrea.porta@suse.com>
 <1029761eb218702d4aafa58d83c4bf9d3a760264.1697614386.git.andrea.porta@suse.com>
 <ZS_XYwHovY6B7Whp@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS_XYwHovY6B7Whp@FVFF77S0Q05N.cambridge.arm.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -10.60
X-Spamd-Result: default: False [-10.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:02 Wed 18 Oct     , Mark Rutland wrote:
> On Wed, Oct 18, 2023 at 01:13:22PM +0200, Andrea della Porta wrote:
> > Distributions would like to reduce their attack surface as much as
> > possible but at the same time they'd want to retain flexibility to
> > cater to a variety of legacy software. This stems from the conjecture
> > that compat layer is likely rarely tested and could have latent
> > security bugs. Ideally distributions will set their default policy
> > and also give users the ability to override it as appropriate.
> > 
> > To enable this use case, introduce CONFIG_AARCH32_EMULATION_DEFAULT_DISABLED
> > compile time option, which controls whether 32bit processes/syscalls
> > should be allowed or not. This option is aimed mainly at distributions
> > to set their preferred default behavior in their kernels.
> > 
> > To allow users to override the distro's policy, introduce the
> > 'aarch32_emulation' parameter which allows overriding
> > CONFIG_AARCH32_EMULATION_DEFAULT_DISABLED state at boot time.
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
> >  arch/arm64/Kconfig                              | 9 +++++++++
> >  arch/arm64/kernel/entry-common.c                | 8 +++++++-
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 0a1731a0f0ef..a41c5e6f5d2e 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1,3 +1,10 @@
> > +	aarch32_emulation=	[ARM64]
> > +			Format: <bool>
> > +			When true, allows loading 32-bit programs and executing
> > +			32-bit syscalls, essentially overriding
> > +			AARCH32_EMULATION_DEFAULT_DISABLED at boot time. when false,
> > +			unconditionally disables AARCH32 emulation.
> 
> Can we please drop the 'emulation' part of the name? We don't use that
> terminology on arm64 for regular execution of compat tasks, and only use that
> to refer to true emulation of deprecated instructions.
> 
> We already have the 'allow_mismatched_32bit_el0' option; can we please us a
> name that aligns with that? e.g. 'allow_32bit_el0=false' to disable support.
> 

Sure, 'allow_mismatched_32bit_el0' will do. I'll prepare a patch accordingly.

Andrea
