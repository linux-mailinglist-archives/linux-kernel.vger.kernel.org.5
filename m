Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87497F542E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbjKVXIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjKVXH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:07:59 -0500
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDAF1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:07:55 -0800 (PST)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTPS
        id 5tU0rV9dvgpyE5wK2rbDyc; Wed, 22 Nov 2023 23:07:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 5wK1reBXw11XZ5wK1rPfBw; Wed, 22 Nov 2023 23:07:54 +0000
X-Authority-Analysis: v=2.4 cv=Z+v/oVdA c=1 sm=1 tr=0 ts=655e89ca
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=EPSwghlcdAVbAxiTEIIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UJYkSgK4L2MCCacRY26ALeLhmT5AloQMJHOEaA6ELE0=; b=RrtEFaYBFl5tan2rInlj8/b2Ge
        e5BOe5JDbJdoolGaTl+4+OUd4bg7cU8qUX3CtVNyycUYTuOPk49sDGLgtvUhupR1L60y8PTRhuScR
        /NmDBI5rk40y5mzbp8Nmb0M/I5k5vf/amB3oYA5OWuVPD8YrxAznOSsnUSC+2TmYY5q5F2SzGEHdm
        JCvZKHgE6dEL/qOt15J4DdUcwLYnp+A++DaHlOqgE2UgEnr8DUKEDL1nhBe3tTfX1Yb0oVFY+ow7L
        +AdO5AE4onSCD8SjiVJXTywawEmM3n9UzkXuk81wUaBUDwQaR0OPmzzFXtXs4erVmcTwkFkLZd5i7
        TTNRbpOA==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:19394 helo=[192.168.0.25])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r5wJz-0007xO-1I;
        Wed, 22 Nov 2023 17:07:51 -0600
Message-ID: <dc30b406-b0f6-469a-bfab-2b692fd6ec9b@embeddedor.com>
Date:   Wed, 22 Nov 2023 17:07:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Robert Richter <rric@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231122222007.3199885-1-arnd@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231122222007.3199885-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r5wJz-0007xO-1I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.25]) [187.184.157.122]:19394
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFWdyxWjDHxD0AHKnokrFledrYCxAf3Dd8nxXkAH3gM/IGJGKFh3RuoFQW1eNpx7ObgPypmdDzCzRl18aNKnllHC4L6pusGpJc0HguO0U6OB+AcGh45A
 CAnp4ZTGB6dM02+YZh6BP2MZMYbY11m0g9M4dFLPIREv+Gk7deMyEb4KoFPK6tATsMJqtY3iIU68cXgTtmf+iopwR7zIPa+3WsM5YQ4XMT2zB0j8fPJiTkf1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/23 16:19, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally") exposes a
> warning for a common bug in the usage of strncat():

Great to see this catching bugs already. :)

> 
> drivers/edac/thunderx_edac.c: In function 'thunderx_ocx_com_threaded_isr':
> drivers/edac/thunderx_edac.c:1136:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>   1136 |                 strncat(msg, other, OCX_MESSAGE_SIZE);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/edac/thunderx_edac.c:1145:33: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>   1145 |                                 strncat(msg, other, OCX_MESSAGE_SIZE);
>        |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/edac/thunderx_edac.c:1150:33: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>   1150 |                                 strncat(msg, other, OCX_MESSAGE_SIZE);
>        |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/edac/thunderx_edac.c: In function 'thunderx_l2c_threaded_isr':
> drivers/edac/thunderx_edac.c:1899:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>   1899 |                 strncat(msg, other, L2C_MESSAGE_SIZE);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/edac/thunderx_edac.c: In function 'thunderx_ocx_lnk_threaded_isr':
> drivers/edac/thunderx_edac.c:1220:17: error: 'strncat' specified bound 1024 equals destination size [-Werror=stringop-overflow=]
>   1220 |                 strncat(msg, other, OCX_MESSAGE_SIZE);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Apparently the author of this driver expected strncat() to behave the
> way that strlcat() does, which uses the size of the destination buffer
> as its third argument rather than the length of the source buffer.
> The result is that there is no check on the size of the allocated
> buffer.
> 
> Change it to use strncat().

s/strncat/strlcat

with that:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> 
> Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/edac/thunderx_edac.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
> index b9c5772da959..90d46e5c4ff0 100644
> --- a/drivers/edac/thunderx_edac.c
> +++ b/drivers/edac/thunderx_edac.c
> @@ -1133,7 +1133,7 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
>   		decode_register(other, OCX_OTHER_SIZE,
>   				ocx_com_errors, ctx->reg_com_int);
>   
> -		strncat(msg, other, OCX_MESSAGE_SIZE);
> +		strlcat(msg, other, OCX_MESSAGE_SIZE);
>   
>   		for (lane = 0; lane < OCX_RX_LANES; lane++)
>   			if (ctx->reg_com_int & BIT(lane)) {
> @@ -1142,12 +1142,12 @@ static irqreturn_t thunderx_ocx_com_threaded_isr(int irq, void *irq_id)
>   					 lane, ctx->reg_lane_int[lane],
>   					 lane, ctx->reg_lane_stat11[lane]);
>   
> -				strncat(msg, other, OCX_MESSAGE_SIZE);
> +				strlcat(msg, other, OCX_MESSAGE_SIZE);
>   
>   				decode_register(other, OCX_OTHER_SIZE,
>   						ocx_lane_errors,
>   						ctx->reg_lane_int[lane]);
> -				strncat(msg, other, OCX_MESSAGE_SIZE);
> +				strlcat(msg, other, OCX_MESSAGE_SIZE);
>   			}
>   
>   		if (ctx->reg_com_int & OCX_COM_INT_CE)
> @@ -1217,7 +1217,7 @@ static irqreturn_t thunderx_ocx_lnk_threaded_isr(int irq, void *irq_id)
>   		decode_register(other, OCX_OTHER_SIZE,
>   				ocx_com_link_errors, ctx->reg_com_link_int);
>   
> -		strncat(msg, other, OCX_MESSAGE_SIZE);
> +		strlcat(msg, other, OCX_MESSAGE_SIZE);
>   
>   		if (ctx->reg_com_link_int & OCX_COM_LINK_INT_UE)
>   			edac_device_handle_ue(ocx->edac_dev, 0, 0, msg);
> @@ -1896,7 +1896,7 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
>   
>   		decode_register(other, L2C_OTHER_SIZE, l2_errors, ctx->reg_int);
>   
> -		strncat(msg, other, L2C_MESSAGE_SIZE);
> +		strlcat(msg, other, L2C_MESSAGE_SIZE);
>   
>   		if (ctx->reg_int & mask_ue)
>   			edac_device_handle_ue(l2c->edac_dev, 0, 0, msg);
