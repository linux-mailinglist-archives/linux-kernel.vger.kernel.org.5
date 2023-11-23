Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E467F5660
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjKWCWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjKWCWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:22:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4341A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:22:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0ADC433C8;
        Thu, 23 Nov 2023 02:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700706131;
        bh=JjpRzvqk7rGbitnp+bRWtZKcgw+/OkruS5I8jMUqY14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gXER3oo2lGXYnylgbw3OWj1qwy+PhijCHuMi0fyzW5Zar4P3X5z8IpqPBaA7nw7rZ
         hBVTKn//lij7Eelu98gonJqsI6ZSWZLPdixlt8fzn7wq3HWnE7lruzYAA50p/92BBI
         Ocqzcep/6zqvWjPN2c0OjdCqDEdKqbj3D89+uMp/m7oUhrjLZMiYjROIdtD4Y3gnja
         y28+lh+RxVkSeB7X+hahBvoVCrU1m9fecHozXJP1Kc5CNSEwgOVLPgsgdg8Y29Ar1n
         moE4KVgjs2I+5W3IjTt2utMR8AfeQ4KPvqJgoxCzz5QcFIm9ry8Htma7EbUhxGT0HD
         zq4tlA3a9P5vQ==
Date:   Thu, 23 Nov 2023 11:22:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Petr Malat <oss@malat.biz>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded
 config
Message-Id: <20231123112207.417b502144a01fc94ad6f87d@kernel.org>
In-Reply-To: <325042d6-ddd0-4278-a082-9587af77cabe@paulmck-laptop>
References: <20231121231342.193646-1-oss@malat.biz>
        <20231121231342.193646-3-oss@malat.biz>
        <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
        <325042d6-ddd0-4278-a082-9587af77cabe@paulmck-laptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 15:38:03 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Wed, Nov 22, 2023 at 02:47:30PM -0800, Randy Dunlap wrote:
> > Hi--
> > 
> > On 11/21/23 15:13, Petr Malat wrote:
> > > Eliminate all allocations in embedded config handling to allow calling
> > > it from arch_setup and applying early options.
> > > 
> > > Config stored in initrd can't be used for early options, because initrd
> > > is set up after early options are processed.
> > > 
> > > Add this information to the documentation and also to the option
> > > description.
> > > 
> > > Signed-off-by: Petr Malat <oss@malat.biz>
> > > ---
> > >  Documentation/admin-guide/bootconfig.rst |   3 +
> > >  init/Kconfig                             |   4 +-
> > >  init/main.c                              | 141 ++++++++++++++++++-----
> > >  lib/bootconfig.c                         |  20 +++-
> > >  4 files changed, 132 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> > > index 91339efdcb54..fb085f696f9b 100644
> > > --- a/Documentation/admin-guide/bootconfig.rst
> > > +++ b/Documentation/admin-guide/bootconfig.rst
> > > @@ -161,6 +161,9 @@ Boot Kernel With a Boot Config
> > >  There are two options to boot the kernel with bootconfig: attaching the
> > >  bootconfig to the initrd image or embedding it in the kernel itself.
> > >  
> > > +Early options may be specified only in the embedded bootconfig, because
> > > +they are processed before the initrd.
> > > +
> > 
> > I'm confused by which options are early options. Are they specified or
> > described somewhere?
> > How does a user know which options are "early" options?
> 
> I don't claim to know the full answer to this question, but those
> declared with early_param() are ones that I have run into.  There are
> a few hundred of these.  I believe that there are at least a few more
> where the parsing is done manually directly out of the buffer, and
> some of those might well also qualify as "early".
> 
> Would it make sense to add an "EARLY" to the long list of restrictions
> in Documentation/admin-guide/kernel-parameters.rst?

Agreed. For the bootconfig, we need to do this...

BTW, we also need to make a block-list for some early params. some of those
MUST be passed from the bootloader. E.g. initrd address and size will be
passed from the bootloader via commandline. Thus such params in the embedded
bootconfig should be filtered at the build time.

Thank you,

> 
> 							Thanx, Paul
> 
> > >  Attaching a Boot Config to Initrd
> > >  ---------------------------------
> > >  
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 9161d2dbad0c..04de756c935e 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1310,7 +1310,9 @@ config BOOT_CONFIG
> > >  	  Extra boot config allows system admin to pass a config file as
> > >  	  complemental extension of kernel cmdline when booting.
> > >  	  The boot config file must be attached at the end of initramfs
> > > -	  with checksum, size and magic word.
> > > +	  with checksum, size and magic word. Note that early options may
> > > +	  be specified in the embedded bootconfig only. Early options
> > > +	  specified in initrd bootconfig will not be applied.
> > >  	  See <file:Documentation/admin-guide/bootconfig.rst> for details.
> > >  
> > >  	  If unsure, say Y.
> > > diff --git a/init/main.c b/init/main.c
> > > index 0cd738f7f0cf..9aac59673a3a 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > 
> > []
> > 
> > > +
> > > +static int __init setup_boot_config_early(void)
> > >  {
> > >  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> > > -	const char *msg, *initrd_data;
> > > -	int pos, ret;
> > > -	size_t initrd_size, embeded_size = 0;
> > > -	char *err, *embeded_data = NULL;
> > > +	static int prev_rtn __initdata;
> > > +	struct xbc_node *root, *knode, *vnode;
> > > +	char *embeded_data, *err;
> > > +	const char *val, *msg;
> > > +	size_t embeded_size;
> > > +	int ret, pos;
> > 
> > It hurts my eyes to see "embeded" here.
> > 
> > Thanks.
> > -- 
> > ~Randy


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
