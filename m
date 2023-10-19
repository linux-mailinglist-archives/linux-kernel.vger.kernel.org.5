Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0C7CFCCA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbjJSOdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbjJSOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:33:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3448710DB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:32:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86DE0210EA;
        Thu, 19 Oct 2023 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697725948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFw3BFzNgR6Y8k558tesln7UDDifhhF8E5WljQRYxcQ=;
        b=v/1+7FbsqBDKWQ3FAyisSAjNJeTOrWHvujOxCqm3mJwCttfa2BywKyEl8DRQslHrGC3lCA
        97+QPqS0jsZIharafjjHAVLch8nm+Ql0ie93i59BL6d6NibAovvOrGXkT4lgEujlymHDuV
        aXlBWQ7tkbskew7UjucmCqkgYAlOM6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697725948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFw3BFzNgR6Y8k558tesln7UDDifhhF8E5WljQRYxcQ=;
        b=m1xYoHlrTf8kbA7y/12fwXuyP5obCIUUbghMHUbPelnrgIMpWAUgMXWwyuyb7Ka0Vw876q
        FlHak9+BbY2ER9Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C5B3139C2;
        Thu, 19 Oct 2023 14:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 98VPGPw9MWVBBAAAMHmgww
        (envelope-from <aporta@suse.de>); Thu, 19 Oct 2023 14:32:28 +0000
Date:   Thu, 19 Oct 2023 16:32:27 +0200
From:   Andrea della Porta <aporta@suse.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com
Subject: Re: [PATCH 2/4] arm64/process: Make loading of 32bit processes
 depend on aarch32_enabled()
Message-ID: <ZTE9-4ie8R6zw9od@apocalypse>
Mail-Followup-To: Mark Rutland <mark.rutland@arm.com>,
        Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com
References: <cover.1697614386.git.andrea.porta@suse.com>
 <a40565807874c9ca82d60c118225ee65fe668fcd.1697614386.git.andrea.porta@suse.com>
 <ZS_VJ29tFbEwNHAS@FVFF77S0Q05N.cambridge.arm.com>
 <ZTEjSD4_4xsJWkEi@apocalypse>
 <ZTE86PK5YJGV1xVq@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTE86PK5YJGV1xVq@FVFF77S0Q05N.cambridge.arm.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.20
X-Spamd-Result: default: False [-8.20 / 50.00];
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
         BAYES_HAM(-0.60)[81.82%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:27 Thu 19 Oct     , Mark Rutland wrote:
> On Thu, Oct 19, 2023 at 02:38:32PM +0200, Andrea della Porta wrote:
> > On 13:52 Wed 18 Oct     , Mark Rutland wrote:
> > > On Wed, Oct 18, 2023 at 01:13:20PM +0200, Andrea della Porta wrote:
> > > > Major aspect of Aarch32 emulation is the ability to load 32bit
> > > > processes.
> > > > That's currently decided (among others) by compat_elf_check_arch().
> > > > 
> > > > Make the macro use aarch32_enabled() to decide if Aarch32 compat is
> > > > enabled before loading a 32bit process.
> > > > 
> > > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > 
> > > Why can't you make system_supports_32bit_el0() take the option into account
> > > instead?
> > >
> > 
> > I may be wrong here, but it seems to me that system_supports_32bit_el0()
> > answers teh question "can this system supports compat execution?" rather than
> > "do I want this system to run any compat execution?". That's the point of
> > aarch32_enabled(), to state whether we want teh system to run A32 code or not,
> > regardless of the system supporting it (of course, if the system does not
> > support A32 in EL0, this is a no-no, but that's another story).
> 
> That's what the implementation does today, but we're really using it as a "do
> we intend for 32-bit EL0 to work?" predicate, and generally the
> system_supports_${FEATURE}() helpers are affected by the combination of actual
> HW support, kernel config options, *and* kernel command line options. For
> example, system_supports_sve() is affected by both CONFIG_ARM64_SVE and the
> "arm64.nosve" command line option.
> 
> Thanks,
> Mark.

Many thanks for the explanation, then inserting aach32_enabled() in
system_supports_32bit_el0() is the way to go.

Andrea
