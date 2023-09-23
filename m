Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723F47ABF2A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjIWJDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjIWJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:03:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFFE10FA;
        Sat, 23 Sep 2023 02:02:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FAAC433C9;
        Sat, 23 Sep 2023 09:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459775;
        bh=beUDTH2SBcqXVSV8MIa8cGP10apCUMSTqUPttyIdHE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsZ+iaCI7XxFhc0qct7PgM/2I8ZGKvhTAg/GQIaR1L+0R9sRGTxB0ndMdaurVys+4
         3Zd+bzDYOLzxLuI6ZeZt64tdeEiymc6HtnyZiIqeu1V9R3lTxoK+z/K3kDJwriFmZy
         2M4LKltCSQrpxfkkWqKROZsFq1XeCsUbCCDOlhhdEvjKBLzSROZXskn2242wSvZmOU
         SrZLrl4sSXMLIPh6YL5WX2d16FlotZABVAo7D+FZgJc9gtzokPbjqxJk33oTw886xT
         IzCTZY9yAAxQESxM8kTAYayBShEVtj2ysyXOSO+KmUrpJ33BrpKsN7ceHjVUWQCUgx
         RwiQQjBhPtkVA==
Date:   Sat, 23 Sep 2023 11:03:56 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] power: supply: axp20x_usb_power: Annotate struct
 axp20x_usb_power with __counted_by
Message-ID: <ZQ8afIKwo5DtIciT@work>
References: <20230922175358.work.774-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175358.work.774-kees@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:53:58AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct axp20x_usb_power.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/power/supply/axp20x_usb_power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index bde17406c130..e23308ad4cc7 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -73,7 +73,7 @@ struct axp20x_usb_power {
>  	unsigned int old_status;
>  	unsigned int online;
>  	unsigned int num_irqs;
> -	unsigned int irqs[];
> +	unsigned int irqs[] __counted_by(num_irqs);
>  };
>  
>  static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
> -- 
> 2.34.1
> 
> 
