Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BCD78AFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjH1MOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjH1MOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C45D8;
        Mon, 28 Aug 2023 05:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC401616D5;
        Mon, 28 Aug 2023 12:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323EAC433C7;
        Mon, 28 Aug 2023 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693224839;
        bh=1h6zNsAq1l/WQb9ACNoRBi9h/GHNSaEsK1/Y2bqC2dE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tl+2tXWmTwiEKCfBiigkL7PI3K4KQZGOPyS/j+LPeeFa/9Gu/1Oz4fTFBrvmI89+n
         6Gt9ltMa1FPWOMQsKXr9EeQR053hDLXQxF9Jm5O4xXRq2j3YXn21kje+W5FMLWa0Wu
         cmHWJ5PWxtJQOFXTP9rwVx9bJKuyAxBPuj3B6RCplGhi5eXJ+4zR7kEN+BcCkcy2LQ
         XT01LneleN3EZdcqtrbjOVV5hEH8Z1eKzgNHGfLu2R1b5TR7T8X8bDtc5kVivUNenM
         EP3Z5eF3s4t7wDZlQdc6sX8/KXiwTAh80M0IOZGhU7+vPN2Ve4rj/1mnmoFmnDYUXc
         4Z5bwUhXqxAAQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qab89-0003Dl-1a;
        Mon, 28 Aug 2023 14:14:05 +0200
Date:   Mon, 28 Aug 2023 14:14:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH] spi: zynqmp-gqspi: fix clock imbalance on probe failure
Message-ID: <ZOyPjWooMqAv3IWQ@hovoldconsulting.com>
References: <20230622082435.7873-1-johan+linaro@kernel.org>
 <168747016057.308826.7806530657100324752.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168747016057.308826.7806530657100324752.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Jun 22, 2023 at 10:42:40PM +0100, Mark Brown wrote:
> On Thu, 22 Jun 2023 10:24:35 +0200, Johan Hovold wrote:
> > Make sure that the device is not runtime suspended before explicitly
> > disabling the clocks on probe failure and on driver unbind to avoid a
> > clock enable-count imbalance.
> > 
> > 
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: zynqmp-gqspi: fix clock imbalance on probe failure
>       commit: 1527b076ae2cb6a9c590a02725ed39399fcad1cf

I noticed that this one is still sitting in your for-next (and for-6.4)
branch but that it wasn't included in your 6.6 (or 6.5) pull request.

Did you intend to send it as a fix during the 6.6 cycle or as it fallen
between the cracks somehow?

Johan
