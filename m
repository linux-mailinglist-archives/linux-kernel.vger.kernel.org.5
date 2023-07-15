Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501FE754A79
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjGOR33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjGOR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B9E272B;
        Sat, 15 Jul 2023 10:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB3460BD3;
        Sat, 15 Jul 2023 17:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2E7C433C8;
        Sat, 15 Jul 2023 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689442165;
        bh=rU6LrTFeWjq80dLlbcyG3tVBI//UqyffXEBujbGucAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b48Bjp9Qc7KkFmHJ7Dkr79IXTcGtVX0E0fMtNkf5JmSg35u+kd12O2qZy7J+noAn3
         kzp2/yVoXdVG96B3mOr3ykbiHlUV1BZCYgQjtyBPyHmh7oWu6/p5dNDvDuxdhd0b4v
         IV7QMGtrUYNjnaP5rgeMPNn7iRfV8f7Eu7PvFbqUWebGGk2MRWqe6nE/oEULBwU+Vm
         CtPvxH4dAqUzw4QYJvbAV3xmobhtc29/MKEf6zfwxu7rvhz3ge9eqYuESOwsSOOugL
         ukyAOfM72QmbJ657+sxUcLBXK/jkMZ8SPeQ1xby3DeQQKh77GczU9bAxQUMk8BzyOE
         /ri9C48UQWg/g==
Date:   Sat, 15 Jul 2023 18:29:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: Fix return value check for set_trigger_state()
Message-ID: <20230715182919.5536655e@jic23-huawei>
In-Reply-To: <pndv8eojdey.fsf@axis.com>
References: <pndv8eojdey.fsf@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 12:47:31 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> In `iio_trigger_detach_poll_func()` the return value from
> `trig->ops->set_trigger_state(trig, false)` is checked with `if (ret)`.
> However, in `iio_trigger_attach_poll_func()` it is checked with
> `if (ret < 0)`. Fix this mismatch by only checking for `if (ret)` in
> both places.

I wouldn't have used fix in the title unless you have a case where this
causes problems (so a driver returns > 0 for this callback).

I have no problem with it as a consistency improvement but I don't
really want to see it backported (which will happen with fix in the
title ;)

I'll tweak that and with that done, applied to the togreg branch
of iio.git and pushed out initially as testing to let 0-day see if
it can find anything we missed.

Thanks,

Jonathan


> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  drivers/iio/industrialio-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index f207e36b12cc..18f83158f637 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -313,7 +313,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  	/* Enable trigger in driver */
>  	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
>  		ret = trig->ops->set_trigger_state(trig, true);
> -		if (ret < 0)
> +		if (ret)
>  			goto out_free_irq;
>  	}
>  

