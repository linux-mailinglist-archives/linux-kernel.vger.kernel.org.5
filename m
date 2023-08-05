Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA027710E9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjHERXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHERXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:23:36 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1A6A6;
        Sat,  5 Aug 2023 10:23:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 375HNPlx031530;
        Sat, 5 Aug 2023 12:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691256205;
        bh=hZBwlg14xih624c/A24lGt3GF8niDIXlMd6SqBRp/qY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FkfVU/WMyQtHuJE5IyKo9dBwbV/ZpTF8CEr5vOgaffgH1RQkuYwTja6qAmfk8FwN2
         z30h8dmRaxPxRx4flFd5R/N/BJLbr67reELoO20ZRu195NuEB2tcr7nr0X6cZbjpo0
         naP3cH1SQborXDT4g5KUwtDfJC1XaZ/b4u7SSWJw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 375HNPXB004364
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 5 Aug 2023 12:23:25 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 5
 Aug 2023 12:23:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 5 Aug 2023 12:23:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 375HNP9d051940;
        Sat, 5 Aug 2023 12:23:25 -0500
Date:   Sat, 5 Aug 2023 12:23:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        "Dave Gerlach" <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>,
        "Kevin Hilman" <khilman@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] bus: ti-sysc: Fix build warning for 64-bit build
Message-ID: <20230805172325.4vjb4lb3vtu3dgfe@commodity>
References: <20230804103859.57458-1-tony@atomide.com>
 <20230805051753.vpwhg52zttpbbntx@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230805051753.vpwhg52zttpbbntx@dhruva>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:47-20230805, Dhruva Gole wrote:
> Hi Tony,
> 
> On Aug 04, 2023 at 13:38:57 +0300, Tony Lindgren wrote:
> > Fix "warning: cast from pointer to integer of different size" on 64-bit
> > builds.
> 
> Thanks for enabling this on 64 bit, will help us in K3 SOCs.
> 
> > 
> > Note that this is a cosmetic fix at this point as the driver is not yet
> > used for 64-bit systems.
> > 
> > Fixes: feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/bus/ti-sysc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> > --- a/drivers/bus/ti-sysc.c
> > +++ b/drivers/bus/ti-sysc.c
> > @@ -3104,7 +3104,7 @@ static int sysc_init_static_data(struct sysc *ddata)
> >  
> >  	match = soc_device_match(sysc_soc_match);
> >  	if (match && match->data)
> > -		sysc_soc->soc = (int)match->data;
> > +		sysc_soc->soc = (unsigned long)match->data;
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Dumb q: is'nt this an enum? Is it better to cast it as (enum
sysc_soc)match->data ?

> 
> >  
> >  	/*
> >  	 * Check and warn about possible old incomplete dtb. We now want to see
> > -- 
> > 2.41.0
> 
> -- 
> Best regards,
> Dhruva Gole <d-gole@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
