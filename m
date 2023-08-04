Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0EB7703CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjHDPCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjHDPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:02:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B284C0C;
        Fri,  4 Aug 2023 08:02:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6C0921888;
        Fri,  4 Aug 2023 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691161334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VNWjSzFu/PyMqv6O223Z6nS9JKkdr9V4bRYfAQix7nk=;
        b=lk1XMNHdUBmmPgv2SbCy1HPgNADs5W9jPaKQk5f95D0ji/Kgs8ioTEuIp8biBXwjs1qmZ1
        DiFaVY7HQOUrW/Ni/kuVUUuHlF9fOwxllYFqY0tab1QiufzfgVh4ZneVj/CAfbnw8UZCx8
        C9Flw2p3O6/4ZMw5+YhH870Kk2vgfAg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B586B133B5;
        Fri,  4 Aug 2023 15:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o4i3K/YSzWSpRwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 04 Aug 2023 15:02:14 +0000
Date:   Fri, 4 Aug 2023 17:02:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3 1/2] nmi_backtrace: Allow excluding an arbitrary CPU
Message-ID: <ZM0S9gKBBiu83kFq@dhcp22.suse.cz>
References: <20230803160649.v3.1.Ia35521b91fc781368945161d7b28538f9996c182@changeid>
 <ZMytyEoCARgP9VR8@dhcp22.suse.cz>
 <CAD=FV=UQ18JG-sMBJHrhXByCWYSgOpCq8tL=3R8pT8CnFEa=pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UQ18JG-sMBJHrhXByCWYSgOpCq8tL=3R8pT8CnFEa=pA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-08-23 06:56:51, Doug Anderson wrote:
> Hi,
> 
> On Fri, Aug 4, 2023 at 12:50 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 03-08-23 16:07:57, Douglas Anderson wrote:
> > > The APIs that allow backtracing across CPUs have always had a way to
> > > exclude the current CPU. This convenience means callers didn't need to
> > > find a place to allocate a CPU mask just to handle the common case.
> > >
> > > Let's extend the API to take a CPU ID to exclude instead of just a
> > > boolean. This isn't any more complex for the API to handle and allows
> > > the hardlockup detector to exclude a different CPU (the one it already
> > > did a trace for) without needing to find space for a CPU mask.
> > >
> > > Arguably, this new API also encourages safer behavior. Specifically if
> > > the caller wants to avoid tracing the current CPU (maybe because they
> > > already traced the current CPU) this makes it more obvious to the
> > > caller that they need to make sure that the current CPU ID can't
> > > change.
> >
> > Yes, this looks like the best way forward.
> >
> > It would have been slightly safer to modify arch_trigger_cpumask_backtrace
> > by switching arguments so that some leftovers are captured easier.
> 
> I'm not sure I understand. Oh, you're saying make the prototype of
> arch_trigger_cpumask_backtrace() incompatible so that if someone is
> directly calling it then it'll be a compile-time error? 

exactly. bool to int promotion would be too easy to miss while the
pointer to int would complain loudly.

> I guess the
> hope is that nobody is calling that directly and they're calling
> through the trigger_...() functions.

Hope is one thing, being preventive another.

> For now I'm going to leave this alone.

If you are going to send another version then please consider this. Not
a hard requirement but better.
 

-- 
Michal Hocko
SUSE Labs
