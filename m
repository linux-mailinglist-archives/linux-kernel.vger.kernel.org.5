Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AA97808E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359336AbjHRJqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359372AbjHRJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:46:22 -0400
X-Greylist: delayed 58841 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:46:21 PDT
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8DC2D7D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:46:21 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RRxpJ6GBQzMq6Lp;
        Fri, 18 Aug 2023 09:46:16 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RRxpH1Xz5zMpnPk;
        Fri, 18 Aug 2023 11:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692351976;
        bh=VX0u3iEdidR+CiLRoGDyOiMFbwAq0F/xGLYbnfjrIes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLQpvPkA9tTwXJWH9zWADo/gTYLHQ6/Cb1aCxfxYLw7I+U9flEtIBz2pxwsfSj28C
         QtIflE5IN6exXf4PE86EaQs8vjD7O6g2T1/Hpl7g/3lZrUGVXOvM6mnput/hedK7O4
         KmQArjOVk4dr66kc5ucqj+cmTrqFsa1th2Yxsaec=
Date:   Fri, 18 Aug 2023 11:46:10 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] landlock: Annotate struct landlock_rule with __counted_by
Message-ID: <20230818.Iuwi4Okaey0A@digikod.net>
References: <20230817210257.never.920-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817210257.never.920-kees@kernel.org>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! Applied to my next tree. Feel free to carry it yourself if you
prefer.

On Thu, Aug 17, 2023 at 02:03:01PM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct landlock_rule.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "Mickaël Salaün" <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/landlock/ruleset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index d43231b783e4..55b1df8f66a8 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -67,7 +67,7 @@ struct landlock_rule {
>  	 * @layers: Stack of layers, from the latest to the newest, implemented
>  	 * as a flexible array member (FAM).
>  	 */
> -	struct landlock_layer layers[];
> +	struct landlock_layer layers[] __counted_by(num_layers);
>  };
>  
>  /**
> -- 
> 2.34.1
> 
