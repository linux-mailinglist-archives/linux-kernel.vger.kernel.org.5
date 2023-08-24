Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CECF78784F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbjHXS7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243170AbjHXS7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:59:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5FE1BE9;
        Thu, 24 Aug 2023 11:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D436453A;
        Thu, 24 Aug 2023 18:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3098AC433C8;
        Thu, 24 Aug 2023 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692903572;
        bh=tDc6KZfrRI2QPNEn3yvTRshL5wqKtC4JJ7mmZOARMZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcQk8pNFSflZQejLZ8htmq0gKxvnx2wkybB144Wn1rPdnIZEvhIsbiRjdg5A/ZTDJ
         wVunYywEhWyawr/Cnq78ae+j9JhnHGfEIktYCkfySij7WmMujM7mRnDMQcwueAI+Y5
         EDqzld8m36EoQjoo42d7S1eFra6VwOLcoih1skmSffQo80St5r6V2N9ONG4L+losHr
         uQpYjPgvibGjxV7Qc4jNI976V1yuWilcBu0N0ahbE2S+A6FuspjjnUxUsFwZzq018x
         gc0BqmJjTs1H+vSuM1U5fKTi2LBbxNibrtBoM9LXSi5asgd3KBZW6mCdt5MgdxB8WD
         CG6fEX9FLV7cg==
Date:   Thu, 24 Aug 2023 11:59:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: get lib-y objects back to static library
Message-ID: <20230824185930.GA2025001@dev-arch.thelio-3990X>
References: <20230823120816.824352-1-masahiroy@kernel.org>
 <20230823202040.GA2236267@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823202040.GA2236267@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 01:20:42PM -0700, Nathan Chancellor wrote:
> Hi Masahiro,
> 
> On Wed, Aug 23, 2023 at 09:08:16PM +0900, Masahiro Yamada wrote:
> > Revert the following two commits:
> > 
> >  - 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly when CONFIG_MODULES=y")
> >  - 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects reliably")
> > 
> > Now, lib-y is back to static library again, and the link order is
> > consistent w/wo CONFIG_MODULES.
> > 
> > Since commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by
> > modpost"), .vmlinux.export.c contains references to exported symbols.
> > If a symbol in a lib-y object is exported, that object is always linked
> > even without any explicit user in vmlinux.
> > 
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> > 
> >  Makefile | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 87a9eef3fb4b..71e9c65d9eae 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1113,12 +1113,7 @@ export ARCH_DRIVERS	:= $(drivers-y) $(drivers-m)
> >  # Externally visible symbols (used by link-vmlinux.sh)
> >  
> >  KBUILD_VMLINUX_OBJS := ./built-in.a
> > -ifdef CONFIG_MODULES
> > -KBUILD_VMLINUX_OBJS += $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)))
> > -KBUILD_VMLINUX_LIBS := $(filter-out %/, $(libs-y))
> > -else
> >  KBUILD_VMLINUX_LIBS := $(patsubst %/,%/lib.a, $(libs-y))
> > -endif
> >  
> >  export KBUILD_VMLINUX_LIBS
> >  export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
> > -- 
> > 2.39.2
> > 
> 
> The build error that prompted 7273ad2b08f8 from [1] appears to return
> with this patch, for example:
> 
> $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 O=build mrproper virtconfig all
> ...
> ERROR: modpost: "__memcat_p" [drivers/hwtracing/stm/stm_core.ko] undefined!
> ...
> 
> [1]: https://github.com/ClangBuiltLinux/linux/issues/515

One thing I forgot to note with this is this occurs when targeting arm,
arm64, hexagon, i386, powerpc, s390, and x86_64 with various in-tree
configurations (I can provide a list if necessary).

Cheers,
Nathan
