Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068CB7F7759
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbjKXPKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbjKXPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:10:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB099E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:10:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D03CC4339A;
        Fri, 24 Nov 2023 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700838608;
        bh=QxrbIT5Wo7+n11EAmFM6PF7w4fT/TeJFxzoyxl9Pbpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fadlzKonJvR3LMvMuZsWgk0kZdxbJ5yscnILoUTkQEHT3VFuMC7bkHbnIhQvMKRvS
         e4hIolAn+ge2y8/NGb6gXrfR52TzA0vw2A/Rs4WeEratB9x/xGiZfVphD/2onlmxDW
         5sg7CPvfnzOfrFhfUWunchhjarIiS8g5LP666VE8=
Date:   Fri, 24 Nov 2023 15:10:06 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 2/3] driver core: introduce prioritized device
 shutdown sequence
Message-ID: <2023112425-prepaid-diffusive-aced@gregkh>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <20231124145338.3112416-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124145338.3112416-3-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 03:53:37PM +0100, Oleksij Rempel wrote:
> This commit revises the device shutdown mechanism to implement a
> prioritized shutdown sequence. The new function,
> prioritized_device_shutdown, ensures devices are shut down in reverse
> order, mirroring the system construction order. Within this process,
> devices are shut down based on their assigned priority levels.
> Additionally, this patch ensures that a device inherits its shutdown
> priority from its parent, maintaining hierarchy integrity. This is
> crucial to prevent child nodes of high-priority parents from being
> orphaned in the shutdown sequence.
> 
> This change is vital in scenarios like power drops with limited backup
> energy, where shutdown time is constrained. By prioritizing critical
> devices, particularly storage, the focus is on maintaining device
> integrity by ensuring they are properly shut down. This approach reduces
> the risk of hardware damage and enhances system resilience during
> emergency shutdowns.

So you are going to race the power drain and just hope and pray that the
kernel gets to shut down the hardware before the capacitors discharge?

That seems ripe for loads of problems, as you are trying to achive
something that software just can not do, as the hardware isn't
supporting it at all.

You are making a promise here that the kernel can never achive, sorry.
I understand your wish to try to fix broken hardware with software, but
please go back and tell those hardware engineers that they need to fix
this properly if they don't want broken devices as this is just not
going to work at all.

One naming nit:

> -void device_shutdown(void)
> +void prioritized_device_shutdown(void)

It's the driver core, please prefix stuff correctly, so this would be
device_shutdown_prioritized() if we were to take this.

Anyway, good luck with the hardware engineers!

greg k-h
