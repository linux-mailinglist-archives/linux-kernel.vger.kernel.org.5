Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FA57F65A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbjKWRkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbjKWRkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:40:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C6D48
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:40:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3621AC433C7;
        Thu, 23 Nov 2023 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700761247;
        bh=gnDODl7o18vzYHVWqkkDGx2v9e3OnjLtCOQP/maml08=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iddskcFkf9PiDtXplJ2/wkQeRvGKtMsaXD1Z+WG6Tl26T6jCnKj2V5eiFxZLNwdyB
         nfeMsHdCfvJMUqZsXV9iUsJFFyToH9eYt863A0q3zaCumbRivTlhpjQVyFfr73Iq79
         yvK58Vq5KEYVF07UGGnU7jJEC6jkl9Qj9Ht1g0nonpAgYWa14/S3RB/w49PwOA6J3b
         U7Sd9htwVOQqachyh1jcrZdE0YMcG7yQPTcMrbnuWIweSN73Vh2LhE2/XzU19Plhc7
         jMw2zpIRogxkbA5e/0gCjx1SIa9MahfEeGAgJb2WbZtCVT86PifZqVwFQDwko26m0A
         TfMdIBx74nXfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C16E7CE0D0D; Thu, 23 Nov 2023 09:40:46 -0800 (PST)
Date:   Thu, 23 Nov 2023 09:40:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Petr Malat <oss@malat.biz>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded config
Message-ID: <6c8a0ea0-42a0-4bff-b0c0-b512c9136fff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121231342.193646-1-oss@malat.biz>
 <20231121231342.193646-3-oss@malat.biz>
 <4a67b4bb-d211-4726-8f43-d3f159127dd9@infradead.org>
 <325042d6-ddd0-4278-a082-9587af77cabe@paulmck-laptop>
 <20231123112207.417b502144a01fc94ad6f87d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123112207.417b502144a01fc94ad6f87d@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:22:07AM +0900, Masami Hiramatsu wrote:
> On Wed, 22 Nov 2023 15:38:03 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Wed, Nov 22, 2023 at 02:47:30PM -0800, Randy Dunlap wrote:
> > > Hi--
> > > 
> > > On 11/21/23 15:13, Petr Malat wrote:
> > > > Eliminate all allocations in embedded config handling to allow calling
> > > > it from arch_setup and applying early options.
> > > > 
> > > > Config stored in initrd can't be used for early options, because initrd
> > > > is set up after early options are processed.
> > > > 
> > > > Add this information to the documentation and also to the option
> > > > description.
> > > > 
> > > > Signed-off-by: Petr Malat <oss@malat.biz>
> > > > ---
> > > >  Documentation/admin-guide/bootconfig.rst |   3 +
> > > >  init/Kconfig                             |   4 +-
> > > >  init/main.c                              | 141 ++++++++++++++++++-----
> > > >  lib/bootconfig.c                         |  20 +++-
> > > >  4 files changed, 132 insertions(+), 36 deletions(-)
> > > > 
> > > > diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> > > > index 91339efdcb54..fb085f696f9b 100644
> > > > --- a/Documentation/admin-guide/bootconfig.rst
> > > > +++ b/Documentation/admin-guide/bootconfig.rst
> > > > @@ -161,6 +161,9 @@ Boot Kernel With a Boot Config
> > > >  There are two options to boot the kernel with bootconfig: attaching the
> > > >  bootconfig to the initrd image or embedding it in the kernel itself.
> > > >  
> > > > +Early options may be specified only in the embedded bootconfig, because
> > > > +they are processed before the initrd.
> > > > +
> > > 
> > > I'm confused by which options are early options. Are they specified or
> > > described somewhere?
> > > How does a user know which options are "early" options?
> > 
> > I don't claim to know the full answer to this question, but those
> > declared with early_param() are ones that I have run into.  There are
> > a few hundred of these.  I believe that there are at least a few more
> > where the parsing is done manually directly out of the buffer, and
> > some of those might well also qualify as "early".
> > 
> > Would it make sense to add an "EARLY" to the long list of restrictions
> > in Documentation/admin-guide/kernel-parameters.rst?
> 
> Agreed. For the bootconfig, we need to do this...

Very good, I will put something together by early next week.

There will likely be early_setup() parameters that are not documented
in kernel-parameters.txt.  I propose leaving those undocumented, but
upgrading the header comment on early_param() to explain the situation.

Seem reasonable, or would something else work better?

> BTW, we also need to make a block-list for some early params. some of those
> MUST be passed from the bootloader. E.g. initrd address and size will be
> passed from the bootloader via commandline. Thus such params in the embedded
> bootconfig should be filtered at the build time.

Given a list of them, I would be happy to generate the patches to the
documentation.

							Thanx, Paul

> > > >  Attaching a Boot Config to Initrd
> > > >  ---------------------------------
> > > >  
> > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > index 9161d2dbad0c..04de756c935e 100644
> > > > --- a/init/Kconfig
> > > > +++ b/init/Kconfig
> > > > @@ -1310,7 +1310,9 @@ config BOOT_CONFIG
> > > >  	  Extra boot config allows system admin to pass a config file as
> > > >  	  complemental extension of kernel cmdline when booting.
> > > >  	  The boot config file must be attached at the end of initramfs
> > > > -	  with checksum, size and magic word.
> > > > +	  with checksum, size and magic word. Note that early options may
> > > > +	  be specified in the embedded bootconfig only. Early options
> > > > +	  specified in initrd bootconfig will not be applied.
> > > >  	  See <file:Documentation/admin-guide/bootconfig.rst> for details.
> > > >  
> > > >  	  If unsure, say Y.
> > > > diff --git a/init/main.c b/init/main.c
> > > > index 0cd738f7f0cf..9aac59673a3a 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > 
> > > []
> > > 
> > > > +
> > > > +static int __init setup_boot_config_early(void)
> > > >  {
> > > >  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> > > > -	const char *msg, *initrd_data;
> > > > -	int pos, ret;
> > > > -	size_t initrd_size, embeded_size = 0;
> > > > -	char *err, *embeded_data = NULL;
> > > > +	static int prev_rtn __initdata;
> > > > +	struct xbc_node *root, *knode, *vnode;
> > > > +	char *embeded_data, *err;
> > > > +	const char *val, *msg;
> > > > +	size_t embeded_size;
> > > > +	int ret, pos;
> > > 
> > > It hurts my eyes to see "embeded" here.
> > > 
> > > Thanks.
> > > -- 
> > > ~Randy
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
