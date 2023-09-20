Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709607A8E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjITVLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjITVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:11:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75BDC9;
        Wed, 20 Sep 2023 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5mvVkHxDzc75LO4BcLLqzyEg+sz+YO60woTJ/QrfPzs=; b=x9+U0lnTN7uFzW8ZVY63lO9a82
        Isf1JGhfx/wIb3EUAUfZoXi4xpQG12OHeHUy8PnRKEBhsTfqlBJ0robaURy1dffdphfy2CYX3tjpF
        A+H/C5R2+O2yyMkwSJ+qGe2CPkgPwn1FrihCkcBQA2uhG1Snd7LjxKwqN/gfZxeFifnztPMmiBoPj
        vjdMyikJy9YURQI8S7IEGHfaQm6Ggnnl2sOMS28+eFkDg51yer5ST1ween7K/CoIvo0rfHZxbmrxe
        Nm1fF+1By2vLjqkuU1HT8b/fnHdBRxDBmLKXwu7QoiLZ2MM6nYVPIKo0tGxSznC4MgXne7xSaBWcT
        Zg2VmFFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj4TJ-004Edi-1f;
        Wed, 20 Sep 2023 21:10:57 +0000
Date:   Wed, 20 Sep 2023 14:10:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] module: Clarify documentation of module_param_call()
Message-ID: <ZQtf4TqRxaps8Opx@bombadil.infradead.org>
References: <20230913235407.gonna.817-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913235407.gonna.817-kees@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:54:14PM -0700, Kees Cook wrote:
> Commit 9bbb9e5a3310 ("param: use ops in struct kernel_param, rather than
> get and set fns directly") added the comment that module_param_call()
> was deprecated, during a large scale refactoring to bring sanity to type
> casting back then. In 2017 following more cleanups, it became useful
> again as it wraps a common pattern of creating an ops struct for a
> given get/set pair:
> 
>   b2f270e87473 ("module: Prepare to convert all module_param_call() prototypes")
>   ece1996a21ee ("module: Do not paper over type mismatches in module_param_call()")
> 
>         static const struct kernel_param_ops __param_ops_##name = \
>                 { .flags = 0, .set = _set, .get = _get }; \
>         __module_param_call(MODULE_PARAM_PREFIX, \
>                             name, &__param_ops_##name, arg, perm, -1, 0)
> 
>         __module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
> 
> Many users of module_param_cb() appear to be almost universally
> open-coding the same thing that module_param_call() does now. Don't
> discourage[1] people from using module_param_call(): clarify the comment
> to show that module_param_cb() is useful if you repeatedly use the same
> pair of get/set functions.
> 
> [1] https://lore.kernel.org/lkml/202308301546.5C789E5EC@keescook/
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Nick Desaulniers <ndesaulniers@gooogle.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: linux-modules@vger.kernel.org
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied and pushed to modules-next, thanks

> ---
> Luis, I note that include/linux/moduleparam.h isn't in the MAINTAINERS
> file pattern. Perhaps you want to use include/linux/module*.h?

Sent patch! Thanks!

  Luis
