Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52417ABF28
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjIWJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjIWJDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:03:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5072010E4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 02:02:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FF1C433C9;
        Sat, 23 Sep 2023 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459752;
        bh=wLwMXei8xd94rYvt7YUim5VACHPexOivfcfPG9ycbrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoyfEevdTufTER9i9/vR0DfAxebgy1i7TrhkUjNg7Uhj7jBCVslA2eZQyQ/5oSLZz
         e8f6FEnawP5K5+2t8+8Bq8SUdyUdqnBG6cqrtXyySTjB6CR/e3j1XExEmYP9N+H7Wj
         mYKHXOvkuUGhhHdwGgVxj5cg5/D3cvh1bNlvW33HEKYUUhSbV5GSma1//ssmSCoTa+
         b8o78Hdmhtf0gWxK9rQqj0NKCq7Exs5gfpiz6UztwVPDjOUtLCQAyEn9mhmTyFd29w
         867MxfZNdFmTNL0FOkQt3qi6S+wVDuMM+H9r+ob4JIQV6QPJMP1xpeb1rMG3PuWgfs
         amKtglvvbUdpQ==
Date:   Sat, 23 Sep 2023 11:03:28 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] regulator: mc13xxx: Annotate struct
 mc13xxx_regulator_priv with __counted_by
Message-ID: <ZQ8aYLzv9zknGrXa@work>
References: <20230922175402.work.819-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175402.work.819-kees@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:54:02AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mc13xxx_regulator_priv.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/regulator/mc13xxx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/mc13xxx.h b/drivers/regulator/mc13xxx.h
> index e03279dc43f4..057aaef6f086 100644
> --- a/drivers/regulator/mc13xxx.h
> +++ b/drivers/regulator/mc13xxx.h
> @@ -24,7 +24,7 @@ struct mc13xxx_regulator_priv {
>  	u32 powermisc_pwgt_state;
>  	struct mc13xxx_regulator *mc13xxx_regulators;
>  	int num_regulators;
> -	struct regulator_dev *regulators[];
> +	struct regulator_dev *regulators[] __counted_by(num_regulators);
>  };
>  
>  extern int mc13xxx_fixed_regulator_set_voltage(struct regulator_dev *rdev,
> -- 
> 2.34.1
> 
> 
