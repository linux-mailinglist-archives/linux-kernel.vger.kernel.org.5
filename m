Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C86757803
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjGRJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjGRJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:28:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACC5186
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE024614EA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E37C433C8;
        Tue, 18 Jul 2023 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689672537;
        bh=/cGfBekDmE+BR4ZDOyJIAZUw5e6tGf6HSK7pUmBl3oI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=azgiJ+0Ur8pGuAGjT6ILrF9o5NYoWyE/NERtLdI0upCbK62KaTC1hrwpPmBEs5TMK
         WNst5b5welfijI3kS54b+CP4W1asS3XSpp301vVdnCwbfr4Lhts41Z4YkfCavd8cmq
         6jaXSylHgqsSBLdbZ1Cehj28Enjr/j6Qt5WCAXMTbSkbfjiRZhK76E0mmMW3w+JIv7
         vmrhgQi8dVylgvcpqrGpV8k4rKV3mekpNemCtUzLATHrMDGuKHpWMmogUqCcT4Jhad
         tD42vWNI/Kjs1/N1P4t7T+CEWmSWGQB/WXfXFfgZovT2CrkWE2cARB+q67Ucz2rnaH
         9lH57D0nlbsvA==
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 11:28:53 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH] mtd: spi-nor: rename method for enabling or disabling
 octal DTR
In-Reply-To: <20230714150757.15372-1-tudor.ambarus@linaro.org>
References: <20230616050600.8793-1-Takahiro.Kuwano@infineon.com>
 <20230714150757.15372-1-tudor.ambarus@linaro.org>
Message-ID: <b85368d2e3bf829809344406247193ea@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw. this was threaded within another thread. At least on the
netdev (and spi) ML this is discouraged.

Am 2023-07-14 17:07, schrieb Tudor Ambarus:
> Having an *_enable(..., bool enable) definition was misleading
> as the method is used both to enable and to disable the octal DTR
> mode. Splitting the method in the core in two, one to enable and
> another to disable the octal DTR mode does not make sense as the
> method is straight forward and we'd introduce code duplication.
> 
> Update the core to use:
> int (*set_octal_dtr)(struct spi_nor *nor, bool enable);
> 
> Manufacturer drivers use different sequences of commands to enable
> and disable the octal DTR mode, thus for clarity they shall
> implement it as:
> static int manufacturer_snor_set_octal_dtr(struct spi_nor *nor, bool 
> enable)
> {
> 	return enable ? manufacturer_snor_octal_dtr_enable() :
> 			manufacturer_snor_octal_dtr_disable();
> }
> 

I don't care much for this naming. I've also seen _enable() functions
which take a bool and then actually disable something in the kernel.

So I'm fine either way:

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael
