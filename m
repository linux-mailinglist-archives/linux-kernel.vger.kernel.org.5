Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3617F54E4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbjKVXiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKVXiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:38:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2BE110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:38:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAB6C433C8;
        Wed, 22 Nov 2023 23:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700696283;
        bh=pY4Q3NoC3NCM5BEAt3oZvdWzJ/7UpcIw5tLXrWR3Ad4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r50BqofaGGb+dcIeFNtf/2hciNlTX655QJ3WorG39dOfsuyt2e8K/icvJ3KhwqS2T
         Nt+fKDCKFnx9chi/mBy6ygAbeoKafwA3RmesCJ+wQU+JyCHQfePqBWVZ2+wk6MoGqk
         7UIWK0mTVXxJmpVe3TpMMVpKaH+oaIxdSpQHKKHP3iBSe7vUELv6S4D4AsC0heL8dO
         1HaI9MjSlssLBwnqj5/wZjOQd35cFaSk2iGILqvZ5ifrW51lQeRfiWWolgEnDI8VuQ
         c18cynKC4qY578i2ihAWPVDZJQniNeYHIBmw7CYVTsuAOObdP1p5jkhL3c8oZqcur5
         R7O1r+7WQ5BrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 391CFCE0B76; Wed, 22 Nov 2023 15:38:03 -0800 (PST)
Date:   Wed, 22 Nov 2023 15:38:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Petr Malat <oss@malat.biz>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded config
Message-ID: <325042d6-ddd0-4278-a082-9587af77cabe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121231342.193646-1-oss@malat.biz>
 <20231121231342.193646-3-oss@malat.biz>
 <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:47:30PM -0800, Randy Dunlap wrote:
> Hi--
> 
> On 11/21/23 15:13, Petr Malat wrote:
> > Eliminate all allocations in embedded config handling to allow calling
> > it from arch_setup and applying early options.
> > 
> > Config stored in initrd can't be used for early options, because initrd
> > is set up after early options are processed.
> > 
> > Add this information to the documentation and also to the option
> > description.
> > 
> > Signed-off-by: Petr Malat <oss@malat.biz>
> > ---
> >  Documentation/admin-guide/bootconfig.rst |   3 +
> >  init/Kconfig                             |   4 +-
> >  init/main.c                              | 141 ++++++++++++++++++-----
> >  lib/bootconfig.c                         |  20 +++-
> >  4 files changed, 132 insertions(+), 36 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> > index 91339efdcb54..fb085f696f9b 100644
> > --- a/Documentation/admin-guide/bootconfig.rst
> > +++ b/Documentation/admin-guide/bootconfig.rst
> > @@ -161,6 +161,9 @@ Boot Kernel With a Boot Config
> >  There are two options to boot the kernel with bootconfig: attaching the
> >  bootconfig to the initrd image or embedding it in the kernel itself.
> >  
> > +Early options may be specified only in the embedded bootconfig, because
> > +they are processed before the initrd.
> > +
> 
> I'm confused by which options are early options. Are they specified or
> described somewhere?
> How does a user know which options are "early" options?

I don't claim to know the full answer to this question, but those
declared with early_param() are ones that I have run into.  There are
a few hundred of these.  I believe that there are at least a few more
where the parsing is done manually directly out of the buffer, and
some of those might well also qualify as "early".

Would it make sense to add an "EARLY" to the long list of restrictions
in Documentation/admin-guide/kernel-parameters.rst?

							Thanx, Paul

> >  Attaching a Boot Config to Initrd
> >  ---------------------------------
> >  
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 9161d2dbad0c..04de756c935e 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1310,7 +1310,9 @@ config BOOT_CONFIG
> >  	  Extra boot config allows system admin to pass a config file as
> >  	  complemental extension of kernel cmdline when booting.
> >  	  The boot config file must be attached at the end of initramfs
> > -	  with checksum, size and magic word.
> > +	  with checksum, size and magic word. Note that early options may
> > +	  be specified in the embedded bootconfig only. Early options
> > +	  specified in initrd bootconfig will not be applied.
> >  	  See <file:Documentation/admin-guide/bootconfig.rst> for details.
> >  
> >  	  If unsure, say Y.
> > diff --git a/init/main.c b/init/main.c
> > index 0cd738f7f0cf..9aac59673a3a 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> 
> []
> 
> > +
> > +static int __init setup_boot_config_early(void)
> >  {
> >  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> > -	const char *msg, *initrd_data;
> > -	int pos, ret;
> > -	size_t initrd_size, embeded_size = 0;
> > -	char *err, *embeded_data = NULL;
> > +	static int prev_rtn __initdata;
> > +	struct xbc_node *root, *knode, *vnode;
> > +	char *embeded_data, *err;
> > +	const char *val, *msg;
> > +	size_t embeded_size;
> > +	int ret, pos;
> 
> It hurts my eyes to see "embeded" here.
> 
> Thanks.
> -- 
> ~Randy
