Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD34877BD95
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjHNQFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHNQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29831115;
        Mon, 14 Aug 2023 09:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBDA263A95;
        Mon, 14 Aug 2023 16:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE16C433C7;
        Mon, 14 Aug 2023 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692029100;
        bh=Ao9BNHmfjKN8nTLb9QaVy1BpS+3zx4V8n3xBXQaUX7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hjq7YHIwyf8y2mxUvDI+DdsLX1oA7oh01LgGHT2/UONK5v3+Cdr/76MLwx4nuxm1Z
         wgkgOfOA0DXIh7jzdMuV55iTjpt0Tv9MdGlVE2yFe0Ks6g1aXoku/fWc5SGFKMzJri
         IjqUGdtijn4S6dP0CoKxbODtxu7ywTdTKRy2huGKPkKdTcFh1eiLHnGDRsZgdTo7sB
         12/tsKNvtNoK7eX0vPW4+v3vSs9d2urwbuj2stsx5ksL43vn49nfrn24eTC/m/SSxC
         7wooSDEoUkNvVfIaq+DFFV73nGzBQ16nAQwF4ec4H4AdBtnYfSFFf5CAfQvLOWZh/m
         xN8WCGJRCur7w==
Date:   Mon, 14 Aug 2023 09:04:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH] serial: mxs-uart: fix Wvoid-pointer-to-enum-cast warning
Message-ID: <20230814160457.GA2836@dev-arch.thelio-3990X>
References: <20230810085042.39252-1-krzysztof.kozlowski@linaro.org>
 <2023081004-lapped-handbag-0324@gregkh>
 <66cbafc5-f490-511c-df9b-02c2e5e40811@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cbafc5-f490-511c-df9b-02c2e5e40811@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 08:58:34AM +0200, Krzysztof Kozlowski wrote:
> On 10/08/2023 17:44, Greg Kroah-Hartman wrote:
> > On Thu, Aug 10, 2023 at 10:50:42AM +0200, Krzysztof Kozlowski wrote:
> >> `devtype` is enum, thus cast of pointer on 64-bit compile test with W=1
> >> causes:
> >>
> >>   mxs-auart.c:1598:15: error: cast to smaller integer type 'enum mxs_auart_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> >>
> >> Cc: Andi Shyti <andi.shyti@kernel.org>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  drivers/tty/serial/mxs-auart.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> >> index 8eeecf8ad359..a9b32722b049 100644
> >> --- a/drivers/tty/serial/mxs-auart.c
> >> +++ b/drivers/tty/serial/mxs-auart.c
> >> @@ -1595,7 +1595,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> -	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
> >> +	s->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
> > 
> > This feels like a compiler issue as devtype is a enum mxs_auart_type
> > variable, so the cast shoudl be correct.
> 
> While the cast is obviously safe here, the warning in general is
> reasonable - people were make too many mistakes by assuming pointers are
> integers...

Yeah, this is just a variant of -Wvoid-pointer-to-int-cast, which itself
is a variant of -Wpointer-to-int-cast. When clang implemented that
warning, it chose to warn for both (int) and (enum ...) casts, whereas
GCC just warns for int casts: https://godbolt.org/z/G8xsYqbzP

I brought up that difference to the clang folks and they justified it
well I think: https://reviews.llvm.org/D72231#1881784

> Just for the record (not saying that others doing is proof of correctness):
> 
> https://lore.kernel.org/lkml/20230809-cbl-1903-v1-1-df9d66a3ba3e@google.com/T/
> 
> But maybe Nathan can share his thoughts whether we should just disable
> this warning for kernel?

Technically, it is disabled for a regular kernel build but it shows up
with W=1:

https://git.kernel.org/linus/82f2bc2fcc0160d6f82dd1ac64518ae0a4dd183f

That was not done because the warning was wrong but because we were working
hard to drive the warning count down to zero and did not want to have to
solve the 90+ instances that were around at that time. Now, with the
patches that you have sent and the ones that Justin is working on, we
are much closer:

https://github.com/ClangBuiltLinux/linux/issues/1910#issuecomment-1675563993

> > And if not, unitptr_t isn't a valid kernel type, so that's not a good
> 
> It is in include/linux/types.h, so do you mean that it is not
> recommended for in-kernel usage? I can go with kernel_ulong_t - which is
> a kernel type - if the cast is agreed.

uintptr_t is used quite a bit in the kernel already, so I don't really
get the "not a valid kernel type" argument. I have seen other folks
prefer 'unsigned long' since Linux assumes it has the same size as a
pointer but that is what uintptr_t is supposed to be...

Cheers,
Nathan
