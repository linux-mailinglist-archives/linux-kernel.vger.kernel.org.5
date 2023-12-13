Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74753810C40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjLMITk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjLMITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:19:38 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F3CF5;
        Wed, 13 Dec 2023 00:19:44 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BD8JeSL009458;
        Wed, 13 Dec 2023 02:19:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702455580;
        bh=RDDNoCNLrnjnW4tX2j6u4vJDko9IfxbGoJ7f1LTFe14=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cIz8afNPtLB4na8GFoa6lCce0ErAttPZmDFM0ahzWN0Kk88Er/9lfdhpLMUvvM7mM
         nUkKoY+djbnqWApUl02pKCDUO9mnuJ6Nz8o2EuZZduadSPIX1Da8nwM6XbG2q3MP/Z
         3r/rLBLqbHv6etOwt4B48JoOGWh/TXCT1T0d9FgM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BD8Jeb9032208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 02:19:40 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 02:19:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 02:19:40 -0600
Received: from [10.24.69.141] ([10.24.69.141])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BD8Jc4x043359;
        Wed, 13 Dec 2023 02:19:38 -0600
Message-ID: <6ed9778c-d792-5481-144c-905a0cf12d61@ti.com>
Date:   Wed, 13 Dec 2023 13:49:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
To:     Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DMA Engine <dmaengine@vger.kernel.org>
References: <20231212203655.3155565-2-bb@ti.com>
 <1f4bed4e-12e0-4c82-a4fe-a8dee7053a1b@ti.com>
Content-Language: en-US
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <1f4bed4e-12e0-4c82-a4fe-a8dee7053a1b@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 13/12/23 11:32, Vignesh Raghavendra wrote:
> 
> 
> On 13/12/23 2:06 am, Bryan Brattlof wrote:
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> Add PSIL and PDMA data for AM62P.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Bryan Brattlof <bb@ti.com>
>> ---
>>  drivers/dma/ti/Makefile        |   3 +-
>>  drivers/dma/ti/k3-psil-am62p.c | 196 +++++++++++++++++++++++++++++++++
> 
> Does this also include J722s data? I prefer if we could introduce both
> SoC support together as one is superset of the other. Vaishav?
> 

This did not include J722S data and also CSI2RX data for both devices, I have
added those and sent a V2 for this patch:
https://lore.kernel.org/all/20231213081318.26203-1-vaishnav.a@ti.com/

Thanks and Regards,
Vaishnav

> Regards
> Vignesh
> 
> [...]
