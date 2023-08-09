Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FCE775694
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHIJlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjHIJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:41:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B5E5F;
        Wed,  9 Aug 2023 02:41:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3799f1wE009325;
        Wed, 9 Aug 2023 04:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691574061;
        bh=OyWjbAKLx2ug7QTPnFXEmBy3sp0LxfpOGIRzjFfvRS8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cpenpC/zdXos2H6KYyCpzSTZlyGjEd95MdavRAfwezWhDiuL480EzFE3PRFVzwH7m
         Sinz0Czi/onpSwiyd6W/kalAqEJ7ltc/44oo55tc57WWWu3aff2/bCwtjV4ETNaV6u
         uJFDqCok36WHsVBdy4AKzffdqjL45KMbclG2w2h0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3799f1cg059307
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 04:41:01 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 04:41:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 04:41:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3799f0rH037964;
        Wed, 9 Aug 2023 04:41:00 -0500
Date:   Wed, 9 Aug 2023 15:10:59 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] bus: ti-sysc: Fix build warning for 64-bit build
Message-ID: <20230809094059.7dzf7kihenxoor47@dhruva>
References: <20230809092722.11000-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809092722.11000-1-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 09, 2023 at 12:27:20 +0300, Tony Lindgren wrote:
> Fix "warning: cast from pointer to integer of different size" on 64-bit
> builds.
> 
> Note that this is a cosmetic fix at this point as the driver is not yet
> used for 64-bit systems.
> 
> Fixes: feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/ti-sysc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -3104,7 +3104,7 @@ static int sysc_init_static_data(struct sysc *ddata)
>  
>  	match = soc_device_match(sysc_soc_match);
>  	if (match && match->data)
> -		sysc_soc->soc = (int)match->data;
> +		sysc_soc->soc = (enum sysc_soc)match->data;

Thanks for the suggestion Nishanth,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

Maybe something unrelated to this patch, but the driver has some minor
warning when built with W=1:

make W=1 ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu- drivers/bus/ti-sysc.o

drivers/bus/ti-sysc.c:156: warning: Function parameter or member 'sysconfig' not described in 'sysc'

>  
>  	/*
>  	 * Check and warn about possible old incomplete dtb. We now want to see
> -- 
> 2.41.0

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
