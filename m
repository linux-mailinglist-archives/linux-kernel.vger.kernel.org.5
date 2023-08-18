Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFD7780FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbjHRQHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378445AbjHRQGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47E52722;
        Fri, 18 Aug 2023 09:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79A4A63175;
        Fri, 18 Aug 2023 16:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68564C433C9;
        Fri, 18 Aug 2023 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692374810;
        bh=+NA2WLlc0ioQpdRPaFNB11YSeaAKy1bVtQlwDgFUEoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzcz+YC2HQsxrgLgwl+XJwklqZxe5Ipwdsf1x95O36+DedmrBNm5cbeDPDCg4LzW6
         5oWzHf0ZOZPafOMmeVH7J6YsbXn7HEaE/qQQNe5icJbJaPobbvXSRDJj77GfW1i+ha
         U3NamJ82Tdj6X7GYDGSxBMC98EdI1qH8ChYkCZl7pKXGPUO/LqYAkmfMI9XmiMU8cp
         YJxs1kyqpk30W08JlfLWixg7/ZpHckBcm2eh2XVlSjHmqQThtNpNEFOweYpVCkI5oD
         +nC4LnIzFWTtIQf7huKiNDGuXeA92hXXjV4UYXSR2F9GW1tvtk+3obCcLFL+K4Fp8R
         ooYAH4r95ppng==
Date:   Fri, 18 Aug 2023 09:06:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>, Pavel Machek <pavel@ucw.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] leds: pca955x: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <20230818160648.GA939927@dev-arch.thelio-3990X>
References: <20230816-void-drivers-leds-leds-pca955x-v1-1-2967e4c1bdcc@google.com>
 <20230818160154.GZ986605@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818160154.GZ986605@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:01:54PM +0100, Lee Jones wrote:
> On Wed, 16 Aug 2023, Justin Stitt wrote:
> 
> > When building with clang 18 I see the following warning:
> > |      drivers/leds/leds-pca955x.c:487:15: warning: cast to smaller integer
> > |      type 'enum pca955x_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> > |        487 |                 chip_type = (enum pca955x_type)md;
> > 
> > This is due to the fact that `md` is a void* while `enum pca995x_type` has the
> > size of an int.
> > 
> > Add uintptr_t cast to silence clang warning while also keeping enum cast
> > for readability and consistency with other `chip_type` assignment just a
> > few lines below:
> > |	chip_type = (enum pca955x_type)id->driver_data;
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> 
> A review from Nathan would be good here.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Also please make checkpatch.pl happy before resending, thanks.
> 
> > ---
> > 
> > 
> > leds: pca955x: fix -Wvoid-pointer-to-enum-cast warning
> > ---
> > Note: I've opted to keep the initial `enum pca955x_type` cast and just
> > place the uintptr_t cast first to silence the warning. It seemed weird
> > to me to see the same variable being assigned to two different casted
> > values within just a few lines.
> > ---
> >  drivers/leds/leds-pca955x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
> > index b10e1ef38db0..1d7fa0cd97bf 100644
> > --- a/drivers/leds/leds-pca955x.c
> > +++ b/drivers/leds/leds-pca955x.c
> > @@ -484,7 +484,7 @@ static int pca955x_probe(struct i2c_client *client)
> >  	const void *md = device_get_match_data(&client->dev);
> >  
> >  	if (md) {
> > -		chip_type = (enum pca955x_type)md;
> > +		chip_type = (enum pca955x_type)(uintptr_t)md;
> >  	} else {
> >  		const struct i2c_device_id *id = i2c_match_id(pca955x_id,
> >  							      client);
> > 
> > ---
> > base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
> > change-id: 20230816-void-drivers-leds-leds-pca955x-7002cc67a291
> > 
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> > 
> 
> -- 
> Lee Jones [李琼斯]
