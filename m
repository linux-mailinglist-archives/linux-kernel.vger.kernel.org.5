Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863CE78551C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHWKOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjHWKOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293B4E62;
        Wed, 23 Aug 2023 03:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B440265EE8;
        Wed, 23 Aug 2023 10:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E8CC433C8;
        Wed, 23 Aug 2023 10:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692785653;
        bh=T1mQJXJIX5ikkwJQ9CV0e3ioAe53oBJdQkfOUjV1+tE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ugCFy6PHgpeno5INSU/6PDZ3XoZaejkHEVAJUYH01I3+f4URBO6hMYuKqlbtajBw9
         3IWCo7sqHGjo1cj0afHmJuh2XeSpOOvaoFGkQzQS9Ex2AljH8zdEoUPotHXgIoDVpz
         HABoyuQSiL6m3dOLg1a73/jgvFfsFjDAg+9/4pmRZUWHTalg77/1gNwJeskRaKbY/q
         0L7/dg3+4Gjl4Toz7wl0j2YdiYpTYLJ4ldhDTujPlwGn3i3eh5ZC/JETKHFqMwifdv
         Hr9kNbqtgpvhbmqvU3CyfnGCzMTdlGH+bB2ZoLNlKbBBls6K8ih4raemrHwbP9+HpQ
         0YlvbqgvTbaHQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ilgaz =?utf-8?Q?=C3=96cal?= <ilgaz@ilgaz.gen.tr>,
        kernel@pengutronix.de
Subject: Re: [PATCH] wifi: rtw88: usb: kill and free rx urbs on probe failure
References: <20230823075021.588596-1-s.hauer@pengutronix.de>
Date:   Wed, 23 Aug 2023 13:14:10 +0300
In-Reply-To: <20230823075021.588596-1-s.hauer@pengutronix.de> (Sascha Hauer's
        message of "Wed, 23 Aug 2023 09:50:21 +0200")
Message-ID: <87ttsqgj65.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> After rtw_usb_alloc_rx_bufs() has been called rx urbs have been
> allocated and must be freed in the error path. After rtw_usb_init_rx()
> has been called they are submitted, so they also must be killed.
>
> Add these forgotten steps to the probe error path.
>
> Besides the lost memory this also fixes a problem when the driver
> fails to download the firmware in rtw_chip_info_setup(). In this
> case it can happen that the completion of the rx urbs handler runs
> at a time when we already freed our data structures resulting in
> a kernel crash.
>
> fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")

This should be:

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")

I can fix that, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
