Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6670E7CF3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbjJSJRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjJSJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:17:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F013131
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:17:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2E181FD91;
        Thu, 19 Oct 2023 09:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697707020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZprsuHZTxDGGvkpD70ElLcVpDjdCC6AMdVMYjcnRnhI=;
        b=T3uCxO2RX/VCsAwxswLlNr9T+uYeTq/jP11mL2rPUI0bgMoLC6tcgB19uGJ2vIlGaQZvGj
        8p3OAOwqbC9uNSCAb5RK6CSDQmXAdoUep708lm9AG7UHPwDyygvH4jDPHFWfh87GunwdZp
        ucopG1IAHQatVTODx1g9tpU3TuSHUzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697707020;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZprsuHZTxDGGvkpD70ElLcVpDjdCC6AMdVMYjcnRnhI=;
        b=5/lVFspdxsQdL4g7iVg/loSdldfyf99T75JLfM6IkwsaXbmGy4vM+InrlM9AkwCh6SdiE+
        QdXqORzJDw894UDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACDF7139C2;
        Thu, 19 Oct 2023 09:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TQPCKAz0MGW9VQAAMHmgww
        (envelope-from <aporta@suse.de>); Thu, 19 Oct 2023 09:17:00 +0000
Date:   Thu, 19 Oct 2023 11:17:00 +0200
From:   Andrea della Porta <aporta@suse.de>
To:     Will Deacon <will@kernel.org>
Cc:     Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, arnd@arndb.de, keescook@chromium.org
Subject: Re: [PATCH 0/4] arm64: Make Aarch32 compatibility enablement
 optional at boot
Message-ID: <ZTD0DAes-J-YQ2eu@apocalypse>
Mail-Followup-To: Will Deacon <will@kernel.org>,
        Andrea della Porta <andrea.porta@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com, arnd@arndb.de, keescook@chromium.org
References: <cover.1697614386.git.andrea.porta@suse.com>
 <20231018122729.GA18556@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122729.GA18556@willie-the-truck>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.61
X-Spamd-Result: default: False [-7.61 / 50.00];
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
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.01)[51.25%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:27 Wed 18 Oct     , Will Deacon wrote:
> Hi,
> 
> On Wed, Oct 18, 2023 at 01:13:18PM +0200, Andrea della Porta wrote:
> > Aarch32 compatibility mode is enabled at compile time through
> > CONFIG_COMPAT Kconfig option. This patchset lets 32-bit support
> > (for both processes and syscalls) be enabled at boot time using
> > a kernel parameter. Also, it provides a mean for distributions 
> > to set their own default without sacrificing compatibility support,
> > that is users can override default behaviour through the kernel
> > parameter.
> 
> I proposed something similar in the past:
> 
> https://lkml.kernel.org/linux-fsdevel/20210916131816.8841-1-will@kernel.org/
> 
> bu the conclusion there (see the reply from Kees) was that it was better
> to either use existing seccomp mechanisms or add something to control
> which binfmts can be loaded.
> 
> Will

I see. Seccomp sounds like a really good idea, since just blocking the compat
binfmt would not avoid the call to 32-bit syscalls per se: it's true that
ARM64 enforce the transition from A64 to A32 only on exception return and
PSTATE.nRW flag can change only from EL1, maybe though some exploitation
may arise in the future to do just that (I'm not aware of any or come up
with a proof off the top of my head, but I can't exclude it either). So,
assuming by absurd a switch to A32 is feasible, the further step of embedding
A32 instruction in a A64 ELF executable is a breeze. Hence blocking the 
syscall (and not only the binfmt loading) could prove necessary. I know all
of this is higly speculative right now, maybe it's worth thinking nonetheless.

Andrea
