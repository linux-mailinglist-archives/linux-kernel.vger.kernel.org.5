Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1907694D2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjGaL32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjGaL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F01CD;
        Mon, 31 Jul 2023 04:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFCEF6106C;
        Mon, 31 Jul 2023 11:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7509C433C9;
        Mon, 31 Jul 2023 11:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690802963;
        bh=PiUwuP1rRuNg85mBm3h0tfnKvyXwPsRiypzl3EEp98o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjmk4pdiB5SU1jrvesiynxonXjfTlZOCjUBhJwE71PMHmLd9+Jwozq2QJtsiZy2ZU
         +za4efC7uYUkgtzTqQO2BL5PL86cGvAsFvItct/o8uBQAI/Nb1GP2OAapGu+vjkGQb
         AJoAY/mu4m2E2PsPeEWdt2SCa70V8HhoXFebIcdEIjUKhW+g3tn9GCVtcM2DlD8X6t
         cAXJDT2kzd4W++ftLKBS1Smbdidi3FuDC1kX6g8qAZFurGcqJ/xAwbZnilLo9F6zqv
         vrubxRuFuzg9NbHBWLqrAdojW5YeGnjZc4eDj852aQpRWxpStlU+/L3Pnm9WaV+hnN
         DVryR1qgCrNow==
Date:   Mon, 31 Jul 2023 16:59:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Message-ID: <ZMebD//fpy5TbYyH@matsya>
References: <20230725102532.2567580-1-ckeepax@opensource.cirrus.com>
 <20230725102532.2567580-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725102532.2567580-2-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-23, 11:25, Charles Keepax wrote:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> Currently the in-band alerts for SoundWire peripherals can only
> be communicated to the driver through the interrupt_callback
> function. This however is slightly inconvient for devices that wish to
> share IRQ handling code between SoundWire and I2C/SPI, the later would
> normally register an IRQ handler with the IRQ subsystem. However there
> is no reason the SoundWire in-band IRQs can not also be communicated
> as an actual IRQ to the driver.
> 
> Add support for SoundWire peripherals to register a normal IRQ handler
> to receive SoundWire in-band alerts, allowing code to be shared across
> control buses. Note that we allow users to use both the
> interrupt_callback and the IRQ handler, this is useful for devices which
> must clear additional chip specific SoundWire registers that are not a
> part of the normal IRQ flow, or the SoundWire specification.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
