Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF6A808133
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377764AbjLGGv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377734AbjLGGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:51:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBDA1735
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:50:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7998AC433C8;
        Thu,  7 Dec 2023 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701931854;
        bh=pnIdKiT+bON/xCNZGUM/Uq8e1AWP7hNVCHxLJbzR0us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQN2dWoL36aLwsT1eLWhMsAa5I3P+sAOVlGrvLF52zU4G77OImp7uJJ2eB6xXL6d2
         s8ypmac5WZ7u1/oCqxD3FKpvq/v2jDtyP9s9g2NR8E+9zOH1yF1lqNh09IOM1QmMqB
         pWak8HAm65qEfa87U6CALD3V9h3rbym3K4fRNy2E=
Date:   Thu, 7 Dec 2023 10:44:33 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     jirislaby@kernel.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/7] serial: sc16is7xx: fix snprintf format specifier in
 sc16is7xx_regmap_name()
Message-ID: <2023120748-swimming-precinct-722c@gregkh>
References: <20231130191050.3165862-1-hugo@hugovil.com>
 <20231130191050.3165862-2-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130191050.3165862-2-hugo@hugovil.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 02:10:43PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Change snprint format specifier from %d to %u since port_id is unsigned.
> 
> Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> Cc: stable@vger.kernel.org # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> I did not originally add a "Cc: stable" tag for commit 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
> as it was intended only to improve debugging using debugfs. But
> since then, I have been able to confirm that it also fixes a long standing
> bug in our system where the Tx interrupt are no longer enabled at some
> point when transmitting large RS-485 paquets (> 64 bytes, which is the size
> of the FIFO). I have been investigating why, but so far I haven't found the
> exact cause, altough I suspect it has something to do with regmap caching.
> Therefore, I have added it as a prerequisite for this patch so that it is
> automatically added to the stable kernels.

Looks like the 0-day test bot found problems with this, so I'll hold off
on taking this patch and the rest of the series until that's fixed up
with a new version of this series.

thanks,

greg k-h
