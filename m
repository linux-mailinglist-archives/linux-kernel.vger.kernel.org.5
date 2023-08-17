Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2614977FD6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354195AbjHQSCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354179AbjHQSBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FB1FD;
        Thu, 17 Aug 2023 11:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 785ED65A9C;
        Thu, 17 Aug 2023 18:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91426C433C8;
        Thu, 17 Aug 2023 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692295298;
        bh=VZruZXx9EU0/YoaC/ouk/5A6xD8c1SyPddqP/6Pz+CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iV6+Bm2hPeW6amkSFbOlztn/UfFiWJL4Rn7iVGJVj7uI5jQbAJ0TWPzWC3pbPGYD2
         juPQjmwRYQqKBjCinYc9aFaJFdFc63X5XOdi9mAx23DXdSvMxLqea6MKOOL//KiXUl
         6NPN71qMBs9/Rxu5F7PXQlobCZPkOS6eG1yLLfpmGn7yJc2PPLFwQCnuU+PfbHSVxS
         yd0vz7N7GGt9utma2GfIuPpCqtulbiFubtgPf4wis29fbJQfHz9mlCZtP3akRUo1O4
         6TM1Rp/Qe5tCeTmiz9YNvkuOEKFzAsccXxbSwJ0kKUQQ7RzfFiVUbTn4TVDF8Ki61u
         oAhRIpP1kYSMg==
Received: (nullmailer pid 1876770 invoked by uid 1000);
        Thu, 17 Aug 2023 18:01:35 -0000
Date:   Thu, 17 Aug 2023 13:01:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v10 4/6] serial: sc16is7xx: fix regression with GPIO
 configuration
Message-ID: <20230817180135.GA1874231-robh@kernel.org>
References: <20230807214556.540627-1-hugo@hugovil.com>
 <20230807214556.540627-5-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807214556.540627-5-hugo@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 05:45:54PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> changed the function of the GPIOs pins to act as modem control
> lines without any possibility of selecting GPIO function.
> 
> As a consequence, applications that depends on GPIO lines configured
> by default as GPIO pins no longer work as expected.
> 
> Also, the change to select modem control lines function was done only
> for channel A of dual UART variants (752/762). This was not documented
> in the log message.
> 
> Allow to specify GPIO or modem control line function in the device
> tree, and for each of the ports (A or B).
> 
> Do so by using the new device-tree property named
> "nxp,modem-control-line-ports" (property added in separate patch).
> 
> When registering GPIO chip controller, mask-out GPIO pins declared as
> modem control lines according to this new DT property.
> 
> Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 143 +++++++++++++++++++++++++--------
>  1 file changed, 108 insertions(+), 35 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
