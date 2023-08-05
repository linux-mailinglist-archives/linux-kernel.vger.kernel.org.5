Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E77710A1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjHEQqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHEQqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:46:23 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5084200
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 09:46:21 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1C0EF861E6;
        Sat,  5 Aug 2023 18:46:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1691253979;
        bh=RQdRw6SVFAdDjEY7wpgCCM0vKULqBhFkkBBjbtqn5aA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Plf+ZjZPlaPvGj0bCS8eK/kSM7QSub1DewuuyRh/qVNZ4kiXLl3BPzVDcjgyGdq9n
         zVdE1SXgCKokrlufcZTOpbjdlSwQFJYCi3jhYilPHRIOzYvxmUZwmwQqsPouJMQAwy
         oP0pSkxWoFYeSaJ61t/wfxM4lL44PE9jIg4F5NUIwWNymAj9cZR/IphcxTLZPDNNju
         uNLlKMme4sjxDuq+C2r+gBzdV9sxrZnWgzUkC+FaBQxID2zp1O2+B5O3qBkqVPZF5n
         OaSQZmpmwwkk5ig4Y9nh/t/ToP1rRCWg3F6P35vgyo4kpxqRiI8XjvNl/xw1yn9A99
         L6jzw4pTBBSEg==
Message-ID: <5f2f22f5-340b-fdf7-585d-3665a0e8a087@denx.de>
Date:   Sat, 5 Aug 2023 18:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] drm/panel: simple: Fix Innolux G156HCE-L01 LVDS clock
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
References: <20230804151010.834990-1-luca.ceresoli@bootlin.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230804151010.834990-1-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 17:10, Luca Ceresoli wrote:
> This panel has been implemented in commit 225213f24c79 ("drm/panel-simple:
> Add Innolux G156HCE-L01 panel entry") with a higher clock than the typical
> one mentioned on the documentation to avoid flickering on the unit
> tested. Testing on a different unit shows that the panel actually works
> with the intended 70.93 MHz clock and even lower frequencies so the
> flickering is likely caused either by a defective unit or by other
> different components such as the bridge.
> 
> Fixes: 225213f24c79 ("drm/panel-simple: Add Innolux G156HCE-L01 panel entry")
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 56854f78441e..ec3a73bbfe30 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2379,7 +2379,7 @@ static const struct panel_desc innolux_g121x1_l03 = {
>   };
>   
>   static const struct display_timing innolux_g156hce_l01_timings = {
> -	.pixelclock = { 120000000, 144000000, 150000000 },
> +	.pixelclock = { 120000000, 141860000, 150000000 },
>   	.hactive = { 1920, 1920, 1920 },
>   	.hfront_porch = { 80, 90, 100 },
>   	.hback_porch = { 80, 90, 100 },

Odd, now I don't see the flicker anymore.

Tested-by: Marek Vasut <marex@denx.de> # MX8MM with LT9211
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
