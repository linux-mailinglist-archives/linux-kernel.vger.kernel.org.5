Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37576296A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjGZDsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2396E268E;
        Tue, 25 Jul 2023 20:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9EE06119B;
        Wed, 26 Jul 2023 03:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB0DC433C8;
        Wed, 26 Jul 2023 03:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690343294;
        bh=rs6jcTA1tX2fj6DzRO8UEWlSFdaKRM/QU3ygXAa8lZo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CnqKeJo6CGqzPFUB8YPh2EHgarE+dwQT/J7e5XPflVEWQvvGOl/BqF0y6X9wWHGIR
         3X/dplWk1JXxPV8bEqC9Xf5nDjTh2327mQLFunltJHCWpkAkyzTtA168wKQQ/jYdpw
         btXzZJEUUdm0DPjQABYZx05jlTMxdZ7PcKAJM2lXmd66roLGdkbLw7ixRVTt1EQf2/
         G8XZf0Enq/ddZPZcgJuYWyC2OVZvTndmfIDKz3ODXRLNbPI/3R4p4Bo4gUCq0nigxV
         ewvz8lrq2K77wBjQcNkZcmjR9MLhghpBWWzs9tCj5ojZPpjafn3mbXSqe5wTdzeHBg
         arpz+acOG0d3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AC93BCE0BDC; Tue, 25 Jul 2023 20:48:13 -0700 (PDT)
Date:   Tue, 25 Jul 2023 20:48:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <adba817d-a02b-49fb-bf3d-a22779303764@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230726123230.525202b4@canb.auug.org.au>
 <1c8c257e-55e3-4de9-b2c8-1421c11df664@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c8c257e-55e3-4de9-b2c8-1421c11df664@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:33:06PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 26, 2023 at 12:32:30PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
> > produced this warning:
> > 
> > WARNING: modpost: vmlinux: section mismatch in reference: cmdline_load_proc_show+0x22 (section: .text) -> boot_command_line (section: .init.data)
> > 
> > Introduced by commit
> > 
> >   cf9eca90a339 ("fs/proc: Add /proc/cmdline_load for boot loader arguments")
> 
> That __initdata needs to be __ro_after_init, doesn't it?  Will fix,
> thank you!

Sigh.  Hit "send" too soon.  :-/

Does the following incremental diff (to be squashed into the original) help?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/init/main.c b/init/main.c
index c946ab87783a..981170da0b1c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
 void (*__initdata late_time_init)(void);
 
 /* Untouched command line saved by arch-specific code. */
-char __initdata boot_command_line[COMMAND_LINE_SIZE];
+char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
 /* Untouched saved command line (eg. for /proc) */
 char *saved_command_line __ro_after_init;
 unsigned int saved_command_line_len __ro_after_init;
