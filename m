Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27917775255
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjHIFpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjHIFpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:45:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD57A1FC3;
        Tue,  8 Aug 2023 22:45:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3795j5EH022413;
        Wed, 9 Aug 2023 00:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691559905;
        bh=zEcuKzS0gCAty82D73zHMICONifLrgF5S7N1zElgfXc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oR8Tf+jkfquSs0pm02VJK2TZzb2lyZGwzeF+LEzlhX1maqCW9QfoDwsep2zf47EFO
         gW+1QhfKi+lDdcPAAkX+eelJYpkiWZVtTlwWOppr9Wz4GXTkvDIR2JIF4fIc8zhOyw
         GzcmZZpKMspp3lMYa1fWGOk5DKB/PRGywvUIKc48=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3795j4eN088292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Aug 2023 00:45:05 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Aug 2023 00:45:04 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Aug 2023 00:45:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3795j3Pt063775;
        Wed, 9 Aug 2023 00:45:03 -0500
Date:   Wed, 9 Aug 2023 11:15:02 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2 v2] pinctrl: bcm: Use dev_err_probe()
Message-ID: <20230809054502.c5ujbw67o3qyq7oc@dhruva>
References: <20230808180733.2081353-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230808180733.2081353-1-florian.fainelli@broadcom.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 08, 2023 at 11:07:31 -0700, Florian Fainelli wrote:
> These two drivers were giving "unable to add GPIO chip data" which
> was slightly concerning but did not have any functional impact.
> 
> Changes in v2:
> 
> - return from dev_err_probe() directly (Andy)

For the series,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> Florian Fainelli (2):
>   pinctrl: iproc-gpio: Silence probe deferral messages
>   pinctrl: nsp-gpio:  Silence probe deferral messages
> 
>  drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 6 ++----
>  drivers/pinctrl/bcm/pinctrl-nsp-gpio.c   | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> -- 
> 2.34.1
> 



-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
