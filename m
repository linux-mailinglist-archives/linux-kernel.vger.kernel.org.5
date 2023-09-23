Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137F07ABF18
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjIWJAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjIWJAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:00:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE42719E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 02:00:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36134C433C8;
        Sat, 23 Sep 2023 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459636;
        bh=DPfUyGQ+6dasfkt1FqaaCPH41eNMxz10SUv3MLrlYVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6fk7HK2ymgxdtYzNoQl3+kJbplm/i0YMV2jLQAf6N09dSy1rwcrEhuqEr5DgjJUr
         5sO9yfGmRCDHT8LvyCqZNZCoUzYeljDz2xvPICUBX6VF9Mp8KoEiKyasE4mGcRAY+2
         0k5Jo9TFSvu6rU4VpsqC8+yGmcrkHPOu559FrUz5AfOA1EiG+acjGScC83M1PCzH4w
         VsXUVHuN6g/siIUWDaFlnwi/6abym6GyXFrDhIxclPrdbCOrnctQOYgHJfCBJ1LNoO
         gH9mXlnIrwfPAyBMm4wpqhu2w81P32P0yZ0zWUBRPcfGxkybXLwmNk5eKlrQHAEdjX
         6qdId6HZC/DwA==
Date:   Sat, 23 Sep 2023 11:01:39 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] module: Annotate struct module_notes_attrs with
 __counted_by
Message-ID: <ZQ8Z80fUaQO/oPWt@work>
References: <20230922175253.work.237-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175253.work.237-kees@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:52:53AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct module_notes_attrs.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  kernel/module/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
> index c921bf044050..d964167c6658 100644
> --- a/kernel/module/sysfs.c
> +++ b/kernel/module/sysfs.c
> @@ -143,7 +143,7 @@ static void remove_sect_attrs(struct module *mod)
>  struct module_notes_attrs {
>  	struct kobject *dir;
>  	unsigned int notes;
> -	struct bin_attribute attrs[];
> +	struct bin_attribute attrs[] __counted_by(notes);
>  };
>  
>  static ssize_t module_notes_read(struct file *filp, struct kobject *kobj,
> -- 
> 2.34.1
> 
> 
