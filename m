Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE27DD13B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbjJaQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbjJaQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:09:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C4DA;
        Tue, 31 Oct 2023 09:09:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE7C433C7;
        Tue, 31 Oct 2023 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698768565;
        bh=Updi5rJN/tACb8zx7ul9jZgP9ji6++ULgouBfC6YluY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RcngoR6RnBLevMReebq5NB3m/39AcihK58X4uGyGfVgLqpSAeL7RTNiqDXV3IY64H
         5NJThFceWo0eGTHaogDq9dz2/Bstfooqc99NUuqF4FIyQHa1D/VHoop5w+ROzkFuug
         5AzByfahI9iacWm2oNtRV1QeXxl0i695F0/qHal4Ve8HeqUKZKfFE7M2eyVPfFYgIf
         OOdTSlgZCRbf1KiN1OIyiniOo905AQxowItF/9sKvqFQIYyDc21TZo+leX1rAkioZz
         6LZrk12oHMlnmzzweivy3Qx2alVH7hYJKTx0E4pO4lgom+CJ1nPryogDPKmQ3klXVZ
         Ej1oEwFcz2qbw==
Date:   Tue, 31 Oct 2023 09:09:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] kbuild: dummy-tools: pretend we understand
 -fpatchable-function-entry
Message-ID: <20231031160922.GA995893@dev-arch.thelio-3990X>
References: <20231030113416.5208-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030113416.5208-1-jirislaby@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 12:34:16PM +0100, Jiri Slaby (SUSE) wrote:
> Commit 0f71dcfb4aef (powerpc/ftrace: Add support for
> -fpatchable-function-entry) added a script to check for
> -fpatchable-function-entry compiler support. The script expects compiler
> to emit the section __patchable_function_entries and few nops after a
> function entry.
> 
> If the compiler understands and emits the above,
> CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY is set.
> 
> So teach dummy-tools' gcc about this.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---

This seems reasonable to me. I did not test it but it seems like it
should work based on my reading of gcc-check-fpatchable-function-entry.sh.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One minor nit, there should be quotes around the subject of 0f71dcfb4aef
in the commit message, should there need to be a v2 for some reason.

>  scripts/dummy-tools/gcc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> index 07f6dc4c5cf6..e6c41427c02f 100755
> --- a/scripts/dummy-tools/gcc
> +++ b/scripts/dummy-tools/gcc
> @@ -91,6 +91,16 @@ if arg_contain -S "$@"; then
>  		fi
>  		exit 0
>  	fi
> +
> +	# For arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> +	if arg_contain -m64 "$@" && arg_contain -fpatchable-function-entry=2 "$@"; then
> +		echo "func:"
> +		echo ".section __patchable_function_entries"
> +		echo ".localentry"
> +		echo "  nop"
> +		echo "  nop"
> +		exit 0
> +	fi
>  fi
>  
>  # To set GCC_PLUGINS
> -- 
> 2.42.0
> 
