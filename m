Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64F875E2A0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGWO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A05E57
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5DA660DC0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283B8C433C8;
        Sun, 23 Jul 2023 14:27:44 +0000 (UTC)
Date:   Sun, 23 Jul 2023 10:27:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <kabe@vega.pgw.jp>
Cc:     regressions@lists.linux.dev, bagasdotme@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        kkabe@vega.pgw.jp
Subject: Re: radeon.ko/i586: BUG: kernel NULL pointer
 dereference,address:00000004
Message-ID: <20230723102733.70baeb1a@rorschach.local.home>
In-Reply-To: <230722113014.M0204460@vega.pgw.jp>
References: <230721083955.M0102626@vega.pgw.jp>
        <230722113014.M0204460@vega.pgw.jp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2023 11:30:14 +0900
<kabe@vega.pgw.jp> wrote:

> >> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> >> index 897cf02c20b1..801f4414da3e 100644
> >> --- a/arch/x86/include/asm/ftrace.h
> >> +++ b/arch/x86/include/asm/ftrace.h
> >> @@ -13,7 +13,7 @@
> >>  #ifdef CONFIG_HAVE_FENTRY
> >>  # include <asm/ibt.h>
> >>  /* Add offset for endbr64 if IBT enabled */
> >> -# define FTRACE_MCOUNT_MAX_OFFSET	ENDBR_INSN_SIZE
> >> +# define FTRACE_MCOUNT_MAX_OFFSET	(ENDBR_INSN_SIZE + MCOUNT_INSN_SIZE)
> >>  #endif
> >>  
> >>  #ifdef CONFIG_DYNAMIC_FTRACE
> >>   
> 
> Above patch didn't work, but
> Does it matter that I am compiling with "gcc -fcf-protection=none"
> to not emit endbr32 instructions for i586?

This patch is supposed to address the case when ENDBR_INSN_SIZE is
zero. So I would think that that wouldn't matter.

-- Steve
