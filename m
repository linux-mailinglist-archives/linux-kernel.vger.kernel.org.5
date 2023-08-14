Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE66777BD93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjHNQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHNQE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:04:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE76115;
        Mon, 14 Aug 2023 09:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC0E63B8C;
        Mon, 14 Aug 2023 16:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD2FC433C7;
        Mon, 14 Aug 2023 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692029064;
        bh=pRpAJLUc7dGKoDe04Q0MY/DgnG2HzORkQMrUx8SAsjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1E6/EL1QiurAq9zYumlRoJMXAWrk2rLzxtFB8WZ9f8aS5k/5XOl5pfwVt0W/YQgKV
         +Vb7ZKusuHLXkDPyZ2p1tBfALidALwe23Dji3AWx2DGkHf5LDMbCy/w/FfnVL7wCY4
         ThgECuSap/+Q56BzT5WqQMBDnbGGaB746qcoz2PU=
Date:   Mon, 14 Aug 2023 18:04:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
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
Message-ID: <2023081413-simmering-snap-bb8e@gregkh>
References: <20230810085042.39252-1-krzysztof.kozlowski@linaro.org>
 <2023081004-lapped-handbag-0324@gregkh>
 <66cbafc5-f490-511c-df9b-02c2e5e40811@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cbafc5-f490-511c-df9b-02c2e5e40811@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

But this isn't a pointer, it's an enumerated type thrown into a void *,
so cast it properly (void * == unsigned long).

> Just for the record (not saying that others doing is proof of correctness):
> 
> https://lore.kernel.org/lkml/20230809-cbl-1903-v1-1-df9d66a3ba3e@google.com/T/
> 
> But maybe Nathan can share his thoughts whether we should just disable
> this warning for kernel?

I thought that Linus had some objection to the compilers doing something
foolish here as well, but I can't find it in my archives at the moment
(am traveling).

> > And if not, unitptr_t isn't a valid kernel type, so that's not a good
> 
> It is in include/linux/types.h, so do you mean that it is not
> recommended for in-kernel usage? I can go with kernel_ulong_t - which is
> a kernel type - if the cast is agreed.

not recommended for in-kernel usage.

thanks,

greg k-h
