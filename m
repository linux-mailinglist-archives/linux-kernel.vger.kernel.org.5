Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD03377314D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjHGVe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHGVe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B98E7F;
        Mon,  7 Aug 2023 14:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B9DF62262;
        Mon,  7 Aug 2023 21:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0E3C433C7;
        Mon,  7 Aug 2023 21:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691444095;
        bh=2vh5MKnUPvpayE8v3B6yBNfJsLF72v8kjOqfdpQ4ziQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1w4z8FuPe0YjK1E9yk0PGDEUcr8NUMlvZCIR048M0izDsRTHdLgeB00XlXdOJt3h
         9mH+nakIVu2Aev/xlK1SbMGSQi6Et1JjseY7zZuSI6zH2WIts0ZI+KiPvGyC/91iMV
         JD3/L4YQ7MqkG7g5AT1heuwNO+GF5/l/dUVzNSKb3XM4OyaYRmynLmMBiO63CVY0cV
         EhxlMgA+96uVg1r1PImuSp3j3hiLAnZZv9gzlgHXUgHLhIp9KkctRMjYSBCPKbCx3V
         1jkopuLqsXRPHNIDq4OJQLuJcgclPadDh2SURsnPprtfuoy0k37ngN3T0BJHm5vwi6
         c4AujB1SuJ5SA==
Date:   Mon, 7 Aug 2023 23:34:52 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Anton Eliasson <anton.eliasson@axis.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] tty: serial: samsung: Set missing PM ops for hibernation
 support
Message-ID: <20230807213452.aev2ubalxvydmxjv@intel.intel>
References: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
 <20230805213824.ol7sr3b52rwrsfs6@intel.intel>
 <1dbc24c4-b057-0e71-432a-a7d0ce2df2dc@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbc24c4-b057-0e71-432a-a7d0ce2df2dc@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On Mon, Aug 07, 2023 at 11:57:04AM +0200, Anton Eliasson wrote:
> On 05/08/2023 23.38, Andi Shyti wrote:
> > Hi Anton,
> > 
> > On Thu, Aug 03, 2023 at 01:26:42PM +0200, Anton Eliasson wrote:
> > > At least freeze, restore and thaw need to be set in order for the driver
> > > to support system hibernation. The existing suspend/resume functions can
> > > be reused since those functions don't touch the device's power state or
> > > wakeup capability. Use the helper macros SET_SYSTEM_SLEEP_PM_OPS and
> > > SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for symmetry with similar drivers.
> > and why do we need hibernation in this device?
> > 
> > Andi
> 
> Hi!
> 
> I wanted to test whether hibernation is possible on our SoC, even though it
> is not a common feature on embedded ARM systems. This is the only mainline
> driver that I found that needed modification, for my proof-of-concept
> anyway, and I couldn't see any harm in the change.

Thanks, makes sense, mine was just curiosity, can I know which
SoC you are testing that is using the samsung serial device?

You can add my r-b, anyway:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Thanks,
Andi
