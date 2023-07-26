Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C944076294C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGZDdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3FC2685;
        Tue, 25 Jul 2023 20:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE5736119C;
        Wed, 26 Jul 2023 03:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45371C433C8;
        Wed, 26 Jul 2023 03:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690342387;
        bh=TBD/nlsw1FkgHYOYupOo1j+OMUUwQlUc3VWLHu2ZULk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L1nxRO78bAOGsttgXI6A+OH+/ywy//VFG8X4JF8UerHuzDt3SmzDLiIgYETVEyp+N
         0iWttkQtNFQ5StTZOzNtzpttyPPCKaCYaRFM2z6mpuw9ecyZjzMV0NmOSliNLvgCLj
         7Gnmy23Zme22qqRWCGQyOCl1mUn3/Nvl1TwRYLQgDGMFSPnMqPUpdK3O2uQpMAuhTk
         vqfh++/0EBaTMwAavhixcFBzB9c+SR/2lPGg6p+7tOyt6/f3Ia5Yi9q0IO3C3O+Ezs
         OWx8iRZW/F+MtQmcQbKnMrEOl/AqzOo42depo1b25ZFuhJb1M2GmQ05x0/WJR5JuQ6
         RFLE1HbTlzb8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C73BBCE0BDC; Tue, 25 Jul 2023 20:33:06 -0700 (PDT)
Date:   Tue, 25 Jul 2023 20:33:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <1c8c257e-55e3-4de9-b2c8-1421c11df664@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230726123230.525202b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726123230.525202b4@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:32:30PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: cmdline_load_proc_show+0x22 (section: .text) -> boot_command_line (section: .init.data)
> 
> Introduced by commit
> 
>   cf9eca90a339 ("fs/proc: Add /proc/cmdline_load for boot loader arguments")

That __initdata needs to be __ro_after_init, doesn't it?  Will fix,
thank you!

							Thanx, Paul
