Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8678EEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjHaNpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjHaNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B359B10E0;
        Thu, 31 Aug 2023 06:45:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A5664109;
        Thu, 31 Aug 2023 13:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC69DC433C8;
        Thu, 31 Aug 2023 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693489520;
        bh=yPxUUb8SdJT2EZzVca/ZY039E10NMFAwKrDGPLTkGrY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mGa4irl1m+svZf4EspWl30Nqwd4NR6RnPBSqxL64cjj9qdpzFSKLu7J+gas7OXmKS
         486Xp6IsqmwY8H7feW88F6mov+rkJZ6VYIghiZ+7pPWMEZAMUrERsbXhuGLDrnNoZ/
         ZphgHpEfpnzNB3aUMyhvwR5NRoORO61JKr18I3cGGOfa8K2nZ+oyulH/Pp8eHAWTDO
         HfAzl+/0tu6x1BhRzfJVMZ+DMfYc1Zgp2Zs0MRfgfcSGReEKiabpE+6z5FFqvI3tD2
         JqBGbOUVJ+qowR0bTgWsWy0M1Wcgd2neJTKadbtV5ixC0L1m6wbG3XsaZBGCVpBkfb
         uBHNJSqrtbS0g==
Message-ID: <ac040329-25a9-121b-b2b4-843b6a8d2a29@kernel.org>
Date:   Thu, 31 Aug 2023 15:45:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
To:     Rand Deeb <deeb.rand@confident.ru>, Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru
References: <20230830082759.23336-1-deeb.rand@confident.ru>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230830082759.23336-1-deeb.rand@confident.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 10:27, Rand Deeb wrote:
> In ssb_calc_clock_rate(), the value of m1 may be zero because it is
> initialized using clkfactor_f6_resolv(). This function could return
> zero, so there is a possibility of dividing by zero, we fixed it by
> checking the values before dividing.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Version your patches and provide changelog after --- .

> 
> Signed-off-by: Rand Deeb <deeb.rand@confident.ru>
> ---
>  drivers/ssb/main.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index 0a26984acb2c..e0776a16d04d 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -903,13 +903,21 @@ u32 ssb_calc_clock_rate(u32 plltype, u32 n, u32 m)
>  		case SSB_CHIPCO_CLK_MC_BYPASS:
>  			return clock;
>  		case SSB_CHIPCO_CLK_MC_M1:
> -			return (clock / m1);
> +			if (m1 !=3D 0)

Nothing improved here.

Don't send patches as quoted-printable via some weird mailers.
Recommendation is to use standard tool - git send-email.

As you can easily see on the web - it is re-formatted for quoted-printable:

https://lore.kernel.org/all/20230830082759.23336-1-deeb.rand@confident.ru/raw

Best regards,
Krzysztof

