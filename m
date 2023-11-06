Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0E7E1FFD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjKFL2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKFL2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:28:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F998F;
        Mon,  6 Nov 2023 03:28:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DC8C433CC;
        Mon,  6 Nov 2023 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699270111;
        bh=KHYMSuYzfCZFn7iKlZaFmc8xH2hKsNURN3exYOYIYF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uax+WBUGC+X1enzmvLmjGabeE12V0LXoYD77+J300r07tfDIRIziiqnd99eIcc2xe
         4WBQZoJPBW/Tw3TswVDR6L5ZKf3bXfKbPHf+cpL8YlhGv0hKXLed8EYJxBi6OzKfPL
         PKVUyjH1W4qz5PvcblJoPRSRhpNDG2rlwbmaLTo4=
Date:   Mon, 6 Nov 2023 12:28:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 5.4] Revert "ARM: dts: Move am33xx and am43xx mmc nodes
 to sdhci-omap driver"
Message-ID: <2023110613-fringe-ended-5390@gregkh>
References: <20231106095048.8396-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106095048.8396-1-matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:50:48AM +0100, Matthias Schiffer wrote:
> This reverts commit d0c69c722ff16ce2481a5e0932c6d5b172109f21.
> 
> The reverted commit completely breaks MMC on the AM33xx/AM437x for
> multiple reasons:
> 
> - The changed compatible strings ti,am335-sdhci and ti,am437-sdhci
>   aren't supported on Linux 5.4 at all, so no driver is found
> - Even when additionally backporting the support for these compatible
>   strings in the sdhci-omap driver, I could not the the MMC interfaces
>   to work on our TQMa335x SoM - the interface would time out during card
>   initialization for both an eMMC and an SD card.
> 
> I did not investigate the cause of the timeouts further, and instead
> just reverted the commit - switching to a different MMC driver in a stable
> kernel seems like a rather risky change unless it's thoroughly tested,
> which has obviously not happened in this case.
> 
> The reverted commit is also given as a Stable-dep-of commit 2eb502f496f7
> ("ARM: dts: am33xx: Fix MMCHS0 dma properties"), however the conflict
> resulting when only the one commit is reverted is trivial to resolve,
> which leads to working MMC controllers again.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> I have not checked if other stable kernels exhibit the same breakage; it
> might be a good idea to revert the change for all stable branches unless
> it is proven that the sdhci-omap driver actually works.

This was only backported to 5.4.y, thanks for catching this, now queued
up.

greg k-h
