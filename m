Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A1A77D9DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbjHPFjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241908AbjHPFii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:38:38 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB383;
        Tue, 15 Aug 2023 22:38:37 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id E0747403BB;
        Wed, 16 Aug 2023 10:38:30 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1692164311; bh=aS3/Q+3Kvd+eXLcU6L4xBEvokWhzPuKVKrew+FxaV58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l7mLNQhsUNFQIYi8ylKj2lKqBGJHdbxj/69aEySIBgn8lEd/ScYOpH5faP82wSmPc
         yKt/K8JO3C+5mLQuLVC1d5mUCpM7idka2OrsbppsBVWzGTblGMHPkKojuuWCO+VjLG
         +TJWdMKwcDo5C7MUHYcUN+UFR0C16XMG+qnL683LD17YHEDWxVm2e1K9GUFU7y904e
         dfYq2ojTepDhlIaer/KfL8hkCPqJN2fYyFmqyB0RJp7kPeMkEtFLlzOqLMKknZdtCk
         x7JGODHMCQRbanfsTnA7Sq7djw84qUH0TANTm2bQ9u7KpfeYnRj9DugBRKw8YO6UfL
         WqYWfXpbKFIHQ==
MIME-Version: 1.0
Date:   Wed, 16 Aug 2023 10:38:29 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: Re: [PATCH v3 0/3] leds: aw2013: Document interrupt and pull-up
 supply
In-Reply-To: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
References: <20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net>
Message-ID: <b16899c6673a34b69ce5903f5372d0ba@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan Gerhold писал(а) 15.08.2023 22:21:
> AW2013 has an optional interrupt pin "INTN" which is used to report 
> completion of started operations (e.g. power up or LED breath effects). 
> The driver does not use it (yet) but it should be already described for 
> completeness inside the DT schema.
> 
> Since the interrupt and I2C lines operate in open drain low active mode 
> a pull-up supply is needed for correct operation. Unfortunately there 
> is no ideal place to describe it in the DT: The pull-up needed for the 
> I2C lines could be described on the I2C bus. However, the pull-up 
> needed for the interrupt line belongs neither directly to the interrupt 
> controller nor to AW2013. Since the AW2013 driver will be typically in 
> control of the power management and interrupt masking it makes more 
> sense to describe it inside the AW2013 device tree node.
> 

Oh indeed, seems like even on the hardware I was initially targeting,
the pull is tied to a regulator, I probably missed it because it was
always on. Thank you both for adding that and fixing up the bindings!

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

Nikita

> Changes in v3:
>   - Rewrite commit messages based on discussion on v2
>   - Also document missing interrupt in DT schema (new patch)
> 
> Discussion on v2:
> https://lore.kernel.org/linux-leds/20230321220825.GA1685482-robh@kernel.org/
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Lin, Meng-Bo (1):
>       leds: aw2013: Enable pull-up supply for interrupt and I2C
> 
> Stephan Gerhold (2):
>       dt-bindings: leds: aw2013: Document interrupt
>       dt-bindings: leds: Document pull-up supply for interrupt and I2C
> 
>  .../devicetree/bindings/leds/leds-aw2013.yaml      | 13 ++++++++
>  drivers/leds/leds-aw2013.c                         | 36 +++++++++++++---------
>  2 files changed, 35 insertions(+), 14 deletions(-)
> ---
> base-commit: 841165267827955bb3295b066cb6a906ba9265c0
> change-id: 20230815-aw2013-vio-92a4566c5863
> 
> Best regards,
