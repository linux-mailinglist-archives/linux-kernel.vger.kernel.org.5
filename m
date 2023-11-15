Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2D7EC772
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjKOPgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKOPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:36:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E86195
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:36:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC442228BD;
        Wed, 15 Nov 2023 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700062584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3DXW2C3GNEVWBnq6hYRcSZ/Y+xEDNUpXyZ4rIaBwuvw=;
        b=np/etrMeI8W8tOAQxH2AbdsTB/O38Yvryklly1VrkkLhqkflwCqDqgG6N5x7gDn6i8orZe
        oYjf9ueY+IeQY/NTk4LTRGlNzpyPMqtluKXs2EvMPxPcQeZS49UAWPRSiVIFxf13a6WzL+
        uJlaQ5JJWdwVQVjlOd9tIkFiVOs5j/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700062584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3DXW2C3GNEVWBnq6hYRcSZ/Y+xEDNUpXyZ4rIaBwuvw=;
        b=62OkW6aQ8Rqjk8+U9KIjzlrGSucY/PFCgpO7zSesLdTs/Ptc+ALf4VtwMdquE4mzobPdwl
        h7JcrwqPDBeWciDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1E9213587;
        Wed, 15 Nov 2023 15:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oxmpJXjlVGVDCwAAMHmgww
        (envelope-from <aporta@suse.de>); Wed, 15 Nov 2023 15:36:24 +0000
Date:   Wed, 15 Nov 2023 16:36:24 +0100
From:   Andrea della Porta <aporta@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v2 1/4] arm64: Introduce aarch32_enabled()
Message-ID: <ZVTleETzfFUchs77@apocalypse>
Mail-Followup-To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com
References: <cover.1698069331.git.andrea.porta@suse.com>
 <1dec05cc8f54d0b85acffce69d929f13e6d81313.1698069331.git.andrea.porta@suse.com>
 <e13d8d85-67d7-4a5e-893c-69dacb3a6d24@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13d8d85-67d7-4a5e-893c-69dacb3a6d24@arm.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.46
X-Spamd-Result: default: False [-5.46 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.86)[94.20%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:56 Tue 24 Oct     , Robin Murphy wrote:
> On 23/10/2023 3:42 pm, Andrea della Porta wrote:
> > Aarch32 bit support on 64bit kernels depends on whether CONFIG_COMPAT
> > is selected or not. As it is a compile time option it doesn't
> > provide the flexibility to have distributions set their own policy for
> > Aarch32 support and give the user the flexibility to override it.
> > 
> > As a first step introduce aarch32_enabled() which abstracts whether 32
> > bit compat is turned on or off. Upcoming patches will implement
> > the ability to set Aarch32 compat state at boot time.
> 
> Other than patch #3, which as previously mentioned should be unnecessary if
> the kernel correctly never starts an "unsupported" AArch32 process to begin
> with, what does this do that simply overriding ID_AA64PFR0_EL1.EL0 via the
> existing idreg-override mechanism wouldn't?
> 
> Thanks,
> Robin

You're right, I guess we can simpluy leverage system_supports_32bit_el0()
calling id_aa64pfr0_32bit_el0() and override the el0 nibble from command line,
instead of inventing a new kernel parameter. For the sake of simplicity,
maybe we can add a new alias in idreg-override, something like 'arm64.no32bit-el0'.

Thanks,
Andrea
