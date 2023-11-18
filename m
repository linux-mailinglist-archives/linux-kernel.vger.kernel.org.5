Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6CB7F0120
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjKRQaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 11:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 11:30:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FC1C5;
        Sat, 18 Nov 2023 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5SU1XXgi7WRBOVAn6Aiqulu56Tn+Irc2m07dBe4hANo=; b=TtVlAvvk5AMDszBIFke/t/u1Ov
        BnDW1LxiyKgpeD3KPGILr+ZccSZeFwieAZulYYeIQfrWFNEmxqNt6zhDGkOKwQIK0NM3FOCKIflKo
        fYTw5zV/FRiyqoHRI8iAIfaAZjmQGqxV/kt3GviiMz6+jhRJ4ljJqzy9GolngEmh8bQ4enSuO8IDC
        BHeaSfGCIY89dP6oWmWmF3r8evqPwOBddqnfQ7M42bcJRTpACeoF6jlRL7ZgQm+EAxwuLLvix2ZxM
        VhYOEbw54Kk8++zp16lGo8LuIy2XdVc7mjykVLfDS3tM2IXcFuDgVNYb9WySqkkDqPYhqXj3RNb4A
        VOjvgRKw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r4OCq-008plr-12;
        Sat, 18 Nov 2023 16:30:04 +0000
Message-ID: <3e879452-bda7-46d9-93fa-0cf01e484798@infradead.org>
Date:   Sat, 18 Nov 2023 08:30:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] kconfig: require an exact match for "is not set" to
 disable CONFIG option
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20231118075912.1303509-1-masahiroy@kernel.org>
 <20231118075912.1303509-5-masahiroy@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231118075912.1303509-5-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/17/23 23:59, Masahiro Yamada wrote:
> Currently, any string starting "is not set" disables a CONFIG option.
> 
> For example, "# CONFIG_FOO is not settled down" is accepted as valid
> input, functioning the same as "# CONFIG_FOO is not set". It is a
> long-standing oddity.
> 
> Check the line against the exact pattern "is not set".
> 

Just to confirm (I hope), using:
CONFIG_FOO=n

will also still work to disable that config option?

Thanks.

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/kconfig/confdata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 795ac6c9378f..958be12cd621 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -454,7 +454,7 @@ int conf_read_simple(const char *name, int def)
>  			if (!p)
>  				continue;
>  			*p++ = 0;
> -			if (strncmp(p, "is not set", 10))
> +			if (strcmp(p, "is not set"))
>  				continue;
>  
>  			val = "n";

-- 
~Randy
