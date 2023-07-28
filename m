Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FE9766A19
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjG1KU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjG1KUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:20:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4AB3A81;
        Fri, 28 Jul 2023 03:20:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5580762099;
        Fri, 28 Jul 2023 10:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB2AC433C7;
        Fri, 28 Jul 2023 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690539650;
        bh=qZC60IgClxhULrjUcadTZkksiKFjYW5USxTj/ronTNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWemFagFvrKr9wzIQ8JTcxuQSfAoOms8ucgVxnZHgZvj+UL2CyoBbRJXwJ0JCMPYc
         oVY72cAbdEJBUzlMAIgD1ZyVe3qAzHobCSiPlgMD2iAqLNv125p8bG3npW0C1QCCgZ
         UkKBxXvsXq7Ggs9AwO+ry+618qvsSAYZdYnywK8naxPiQyWYTrjvxXxaHFH5Pq38WR
         r9zerdcaV9m0XXK6SU0V7BW2EMJ3MG1C2aso814JC3a0X+xbjCGrhN/phSBseYZKL+
         woS69E68ReGpLk+CshisiHAyQx+pmFgK4ohH7kX3R0IehkrpX3bcMni+wHx0xnIIpE
         lWb1SeNijjYvw==
Date:   Fri, 28 Jul 2023 11:20:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/5] Add a multicolor LED driver for groups of
 monochromatic LEDs
Message-ID: <20230728102045.GH8175@google.com>
References: <20230718092527.37516-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718092527.37516-1-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023, Jean-Jacques Hiblot wrote:

> Some HW design implement multicolor LEDs with several monochromatic LEDs.
> Grouping the monochromatic LEDs allows to configure them in sync and use
> the triggers.
> The PWM multicolor LED driver implements such grouping but only for
> PWM-based LEDs. As this feature is also desirable for the other types of
> LEDs, this series implements it for any kind of LED device.
> 
> changes v10->v11:
>   - updated commit logs of patch 2 and 3
>   - Improved comments
> 
> changes v9->v10:
>   - updated comments and kconfig description
>   - renamed all 'led_mcg_xxx' into 'leds_gmc_xxx'
> 
> changes v8->v9:
>   - rebased on top of lee-leds/for-leds-next
>   - updated kernel version and date for /sys/class/leds/<led>/color in
>     Documentation/ABI/testing/sysfs-class-led
>   - dropped patch "leds: class: simplify the implementation of
>     devm_of_led_get()" because __devm_led_get() is now used by
>     devm_led_get()
> 
> changes v7->v8:
>  - consistently use "LEDs group multicolor" throughout the code.
>  - rename some variables with more explicit names.
>  - improve comments.
>  - use the 100-characters per line limit.
> 
> changes v6->v7:
>  - in led_mcg_probe() increment the counter at the end of the loop for
>    clarity.
> 
> changes v5->v6:
>  - restore sysfs access to the leds when the device is removed
> 
> changes v4->v5:
>  - Use "depends on COMPILE_TEST || OF" in Kconfig to indicate that OF
>    is a functional requirement, not just a requirement for the
>    compilation.
>  - in led_mcg_probe() check if devm_of_led_get_optional() returns an
>    error before testing for the end of the list.
>  - use sysfs_emit() instead of sprintf() in color_show().
>  - some grammar fixes in the comments and the commit logs.
> 
> changes v2->v3, only minor changes:
>  - rephrased the Kconfig descritpion
>  - make the sysfs interface of underlying LEDs read-only only if the probe
>    is successful.
>  - sanitize the header files
>  - removed the useless call to dev_set_drvdata()
>  - use dev_fwnode() to get the fwnode to the device.
> 
> changes v1->v2:
>  - Followed Rob Herrings's suggestion to make the dt binding much simpler.
>  - Added a patch to store the color property of a LED in its class
>    structure (struct led_classdev).
> 
> Jean-Jacques Hiblot (5):
>   devres: provide devm_krealloc_array()
>   leds: provide devm_of_led_get_optional()
>   leds: class: store the color index in struct led_classdev
>   dt-bindings: leds: Add binding for a multicolor group of LEDs
>   leds: Add a multicolor LED driver to group monochromatic LEDs
> 
>  Documentation/ABI/testing/sysfs-class-led     |   9 +
>  .../bindings/leds/leds-group-multicolor.yaml  |  64 +++++++
>  drivers/leds/led-class.c                      |  46 +++++
>  drivers/leds/rgb/Kconfig                      |  12 ++
>  drivers/leds/rgb/Makefile                     |   1 +
>  drivers/leds/rgb/leds-group-multicolor.c      | 169 ++++++++++++++++++
>  include/linux/device.h                        |  13 ++
>  include/linux/leds.h                          |   3 +
>  8 files changed, 317 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
>  create mode 100644 drivers/leds/rgb/leds-group-multicolor.c

What base is this set sitting on top of?

It doesn't appear to want to apply to for-leds-next:

https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/log/?h=for-leds-next

Please rebase and submit a [RESEND].

-- 
Lee Jones [李琼斯]
