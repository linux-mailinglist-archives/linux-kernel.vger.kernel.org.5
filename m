Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB17179DFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbjIMGZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjIMGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:25:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C551730;
        Tue, 12 Sep 2023 23:25:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38D6P4XT055729;
        Wed, 13 Sep 2023 01:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694586304;
        bh=Ednb1lEMgz1nicD/9l1CelW4FhvjacjJehHXRFGfZW8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=YPErQhtmOk4nzJMcppANkf7JGtPRbOZD6D7mM3U3mW0G8JVywfrHAmHc1qrBmoCTU
         NrbqqAMv//pPkcdnRMXm2A+QX4oFU1kgC6mBTVuRdqvQ+WxkdKXbz+J5c6/zGHv7ZB
         WtKyUL6UTqbFn/pJN1z26aBwcUx5Xca5BaOp7y1w=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38D6P3KD054801
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 01:25:03 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 01:25:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 01:25:02 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38D6OuxL051680;
        Wed, 13 Sep 2023 01:24:57 -0500
Message-ID: <e8f51337-5e49-fabc-6d9f-186ecc646a54@ti.com>
Date:   Wed, 13 Sep 2023 11:54:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: [PATCH] net: ti: icssg-prueth: add PTP dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Roger Quadros <rogerq@ti.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230912185509.2430563-1-arnd@kernel.org>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20230912185509.2430563-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/23 00:24, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver can now use PTP if enabled but fails to link built-in
> if PTP is a loadable module:
> 
> aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
> icss_iep.c:(.text+0x200): undefined reference to `ptp_clock_index'
> 
> Add the usual dependency to avoid this.
> 
> Fixes: 186734c158865 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

> ---
>  drivers/net/ethernet/ti/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 7f3e2e96c6e20..26ddc26fc7b8d 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -201,6 +201,7 @@ config TI_ICSSG_PRUETH
>  
>  config TI_ICSS_IEP
>  	tristate "TI PRU ICSS IEP driver"
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	depends on TI_PRUSS
>  	default TI_PRUSS
>  	help

-- 
Thanks and Regards,
Danish
