Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53B67CC3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbjJQM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343728AbjJQM6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:58:13 -0400
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED8F5;
        Tue, 17 Oct 2023 05:58:07 -0700 (PDT)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 17 Oct 2023 14:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1697547483; bh=97MgYvgdqzLPd2gI6ijumoj36CDV9Sd4NpCfimvnEs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUExJXx9XB2uOSEDmLBP3K0Y0F8KDXN5wEAgECdfsh1XstLKc8mJvS8RHdh4Wbv9G
         nOsWo6BHY+km+JWue3bnVsMHNEGhe54YBj/IOBNEqRGlGmlKwFWr5NwuQMs+yjGgTd
         5346vq9sz+JI/BZfPKEzjKxpGee/bWEYDnomP1zc=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 60A8C81EC9;
        Tue, 17 Oct 2023 14:58:04 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 52E5B180CD9; Tue, 17 Oct 2023 14:58:04 +0200 (CEST)
Date:   Tue, 17 Oct 2023 14:58:04 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH 4/4] kbuild: refactor module BTF rule
Message-ID: <ZS6E3EA68GOjonB8@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20231017103742.130927-1-masahiroy@kernel.org>
 <20231017103742.130927-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017103742.130927-4-masahiroy@kernel.org>
X-purgate-ID: 149429::1697547482-1BFC5D95-0CF5C96D/0/0
X-purgate-type: clean
X-purgate-size: 2447
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 07:37:42PM +0900, Masahiro Yamada wrote:
> newer_prereqs_except and if_changed_except are ugly hacks of the
> newer_prereqs and if_changed in scripts/Kbuild.include.

newer-prereqs

> 
> Remove.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.modfinal | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 9fd7a26e4fe9..6ab10dba05c7 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -19,6 +19,9 @@ vmlinux :=
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  ifneq ($(wildcard vmlinux),)
>  vmlinux := vmlinux
> +cmd_btf = ; \

while reading, I stumpled over this semicolon, but probably it's a good
reminder that cmd_btf is only a cmd extension.

> +	LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
> +	$(RESOLVE_BTFIDS) -b vmlinux $@
>  else
>  $(warning Skipping BTF generation due to unavailability of vmlinux)
>  endif
> @@ -41,27 +44,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>        cmd_ld_ko_o +=							\
>  	$(LD) -r $(KBUILD_LDFLAGS)					\
>  		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
> -		-T scripts/module.lds -o $@ $(filter %.o, $^)
> +		-T scripts/module.lds -o $@ $(filter %.o, $^)		\
> +	$(cmd_btf)
>  
> -quiet_cmd_btf_ko = BTF [M] $@
> -      cmd_btf_ko = 							\
> -		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
> -		$(RESOLVE_BTFIDS) -b vmlinux $@
> -
> -# Same as newer-prereqs, but allows to exclude specified extra dependencies
> -newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
> -
> -# Same as if_changed, but allows to exclude specified extra dependencies
> -if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
> -	$(cmd);                                                              \
> -	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
> -
> -# Re-generate module BTFs if either module's .ko or vmlinux changed
>  %.ko: %.o %.mod.o scripts/module.lds $(vmlinux) FORCE
>  	+$(call if_changed_except,ld_ko_o,vmlinux)

This should probably be:

  +$(call if_changed,ld_ko_o)


> -ifdef vmlinux
> -	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> -endif
>  
>  targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o)
>  
> -- 
> 2.40.1
> 
