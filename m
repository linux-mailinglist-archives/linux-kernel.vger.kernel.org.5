Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75D2754F9C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjGPQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGPQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 12:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2F31B6;
        Sun, 16 Jul 2023 09:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ECE060D3E;
        Sun, 16 Jul 2023 16:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42ACCC433C7;
        Sun, 16 Jul 2023 16:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689523903;
        bh=HWacphPikmgnJGPNvAFWGmB20TdoOVVM6awomSy4Ta0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=knNOaZ9qd+WUqdFq9dwM5hdG6A+frOIqYpllVHOECE3TfXXPC/x+2sx82LOZNIm7S
         0LZhL1w+lh9KBi3xhqI7dbrIm+27WUDmo5Kqv4p463llAezp16NB7ncS9plQV2hnym
         TQ0VxpSUfAMAS7Pdib7UcwY6eWyuax6oQzEid3KwueBw1hS631/+0OJTqZV6vHPPDD
         Pu9vkRzGFobMh/Bfpk1PIMVmIzS6FsCw+l4cV7XFYSWXZ1PWb/TAn+awGtFkvNNkY0
         GQ2Gq7pf0FHC9d5vaMa6AQUrieIKdqFMj8vrze/ewirh6zMvyP08320I+hC03Gml4U
         +oAPZoqakzWDg==
Date:   Sun, 16 Jul 2023 17:11:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 0/3] iio: adc: meson: tune init sequence
Message-ID: <20230716171134.43d05c45@jic23-huawei>
In-Reply-To: <20230715110654.6035-1-gnstark@sberdevices.ru>
References: <20230715110654.6035-1-gnstark@sberdevices.ru>
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

On Sat, 15 Jul 2023 14:05:57 +0300
George Stark <gnstark@sberdevices.ru> wrote:

> This patch is a part of effort to support meson a1 SoC and make meson saradc driver
> independent from vendor boot code initialization in common.
> 
> Information was taken from vendor kernel 5.4, 4.19 and vendor uboot 2019.
> Most of the bits are undocumented at all or it's not said how they affect measuring.
> 
> All those bits are already initialized in bl* code and since kernel driver dosn't
> rewrite or reset any registers but only changes some bits at init stage everything
> works fine.
> 
> Test procedure is rather simple - one can change those bits in runtime
> (e.g. using devmem) and try to read channels (cat /sys/bus/platform/drivers/meson-saradc/.../iio:device0/*)
> changing some of those bits leads to measure procedure errors or abnormal results.
> Another test is build meson saradc as module, reset adc by reset bit, reload module
> and compare measure results to those got before reset.
> 
> George Stark (3):
>   iio: adc: meson: init channels 0,1 input muxes
>   iio: adc: meson: init internal continuous ring counter
>   iio: adc: meson: init voltage control bits
> 
>  drivers/iio/adc/meson_saradc.c | 73 ++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
These look fine to me, but I'd like them to sit on list a little while
on off chance anyone else has feedback on them.

Thanks,

Jonathan


