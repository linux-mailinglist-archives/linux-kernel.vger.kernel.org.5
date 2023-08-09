Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE77753FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjHIHTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjHIHTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266EA1724;
        Wed,  9 Aug 2023 00:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A631562FE6;
        Wed,  9 Aug 2023 07:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D5FC433C7;
        Wed,  9 Aug 2023 07:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691565572;
        bh=FWYm/yjpcXX82AB290FN/P0h43hGZT51CajfsF4QqvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l56QuOf4rF5OTqXaNGpOo2iFtcJLfP7+8wi6bdPSq+bj8++LCwUTO3CCgtOmm+nwE
         W+6qE7lhvEDILulkhFhthhXkhF7GhWBkHw2gA0U6e6wPPP05i5Kl7K2ZBBOTj1NE0q
         0dj8hhEjlE39rzB0kEwEYAXafmFSejLSiSrJQYE61d6O7WSMmM2Y/5stYef/1M8Hq5
         m1frj+ZeFGLgyYNzkGsP+DIh5ipadEgFG/2GWnUKO9CLoL6A9u1c+xBCppVrFG7BWO
         FcWxBsVamZWcDCvRFDtyCybgZB2XMwcqsMeF8STGkgzRvocoRIv72jJBXpy9qkyHbd
         +XXMsDbOazfXg==
From:   Michael Walle <mwalle@kernel.org>
To:     linus.walleij@linaro.org
Cc:     brgl@bgdev.pl, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, okan.sahin@analog.com,
        robh+dt@kernel.org, Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH v5 2/2] gpio: ds4520: Add ADI DS4520 GPIO Expander Support
Date:   Wed,  9 Aug 2023 09:17:38 +0200
Message-Id: <20230809071738.2359532-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CACRpkdY02BbfkxSbyb5U+B29CYyNrhxtSADinYmYJ+ZCM04bjQ@mail.gmail.com>
References: <CACRpkdY02BbfkxSbyb5U+B29CYyNrhxtSADinYmYJ+ZCM04bjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Thu, Jul 27, 2023 at 11:55=E2=80=AFAM Okan Sahin <okan.sahin@analog.com>=
>  wrote:
> 
>> The DS4520 is a 9-bit nonvolatile (NV) I/O expander.
>> It offers users a digitally programmable alternative
>> to hardware jumpers and mechanical switches that are
>> being used to control digital logic node.
>>
>> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> 
> Too late to add review tags but just pointing out what a beauty
> this driver is when using regmap GPIO. Total success!

Mh somehow I'm always missing consumers of regmap GPIO.

Linus, Bartosz, what do you think about the patch below?

diff --git a/MAINTAINERS b/MAINTAINERS
index 20a0f7411efd..907f39825733 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8868,6 +8868,7 @@ R:        Michael Walle <michael@walle.cc>
 S:     Maintained
 F:     drivers/gpio/gpio-regmap.c
 F:     include/linux/gpio/regmap.h
+K:     (devm_)?gpio_regmap_(un)?register
 
 GPIO SUBSYSTEM
 M:     Linus Walleij <linus.walleij@linaro.org>

-michael
