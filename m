Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3747877429B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjHHRq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjHHRpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DFC900A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FDF625A0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44886C433C8;
        Tue,  8 Aug 2023 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691506836;
        bh=2cQOXwqn6SYODcUa7f0Mx6nUDgwXXurTh8Kk9vcpbVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFTrgJmVK0/2AZWeuZUJkTozX53OlymZF55AVH/LIu5aKeHKmX36OPL2av3VLkW8B
         pudVgn9cxiLPqCVpUyXUdT1EFdruGwhgkXsVfQfofUA86B7KcyHMe94ZLoTXF8l2Dm
         /oC3VGLCWM22fWr//7jzvJj+cSudjm6oduM6AS4UYu+h75LFmb52Qd26FgFyxfxjzh
         ObodANp8hg1jAfKUAlL1BpE6YcYLoLYIBXHvgoGnrpJcREw9/QAn/Si5bJprY+FLii
         hv5DOSG5vgqyJDpIg5AIe+Hlw8FzkbLj0WvwJ04PSgW/len+LRLqAWgqW3xQthFoxh
         O7aX4eb1tfYIQ==
Date:   Tue, 8 Aug 2023 08:00:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Weidong Wang <wangweidong.a@awinic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: aw88261: avoid uninitialized variable
 warning
Message-ID: <20230808150034.GA637683@dev-arch.thelio-3990X>
References: <20230808125703.1611325-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808125703.1611325-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 02:56:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> aw88261_reg_update() returns an unintialized error code in the
> success path:
> 
> sound/soc/codecs/aw88261.c:651:7: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>                 if (aw_dev->prof_cur != aw_dev->prof_index) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/codecs/aw88261.c:660:9: note: uninitialized use occurs here
>         return ret;
>                ^~~
> sound/soc/codecs/aw88261.c:651:3: note: remove the 'if' if its condition is always true
>                 if (aw_dev->prof_cur != aw_dev->prof_index) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Return zero instead here.
> 
> Fixes: 028a2ae256916 ("ASoC: codecs: Add aw88261 amplifier driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Alternatively, it seems like the final 'return ret' can just be replaced
with 'return 0', as every other assignment of ret returns directly if it
is not zero. Regardless:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  sound/soc/codecs/aw88261.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
> index 82923b454dd47..6e2266b713862 100644
> --- a/sound/soc/codecs/aw88261.c
> +++ b/sound/soc/codecs/aw88261.c
> @@ -652,6 +652,8 @@ static int aw88261_reg_update(struct aw88261 *aw88261, bool force)
>  			ret = aw88261_dev_fw_update(aw88261);
>  			if (ret)
>  				return ret;
> +		} else {
> +			ret = 0;
>  		}
>  	}
>  
> -- 
> 2.39.2
> 
