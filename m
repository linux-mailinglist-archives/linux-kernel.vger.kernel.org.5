Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17647F319D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjKUOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKUOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:52:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3A98;
        Tue, 21 Nov 2023 06:52:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580D7C433C7;
        Tue, 21 Nov 2023 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700578360;
        bh=dGYz6IxNOUY4NpvhlMLeIB3Xxc/hARJYIHJyki7wDHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poue5VPWyYd+HrTAPC2kL1JwV02FvsHlUJ1z3W9FXk/U2czUqklkcawHdmmtSEsoY
         IlPddu/gpJsZ1UpOPQIgrM7BkkvyXf2F3hIfHrb2U18/fsMMvTR4wCzYJDyNBuBtzP
         SpQfWPT1cgV1qEShQyzt0KdJxLEsOUDx610rqzSQ=
Date:   Tue, 21 Nov 2023 15:12:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Timur Tabi <timur@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 20/22] usb: fsl-mph-dr-of: mark fsl_usb2_mpc5121_init()
 static
Message-ID: <2023112114-cried-ramble-b3f9@gregkh>
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-21-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108125843.3806765-21-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 01:58:41PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function is only called locally and should always have been static:
> 
> drivers/usb/host/fsl-mph-dr-of.c:291:5: error: no previous prototype for 'fsl_usb2_mpc5121_init' [-Werror=missing-prototypes]
> 
> Fixes: 230f7ede6c2f ("USB: add USB EHCI support for MPC5121 SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
