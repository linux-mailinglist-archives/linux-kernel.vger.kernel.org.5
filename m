Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1471811239
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378972AbjLMNAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjLMNAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:00:21 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE810A;
        Wed, 13 Dec 2023 05:00:24 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDD0LhY071761;
        Wed, 13 Dec 2023 07:00:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702472421;
        bh=zHaG9EOvhGw+Eye9IXKEwTb6wGAx5Oy0OLqMaoyNSkw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hraHSnTbJk5zNmG03Cr3rgSGkrwOvYZXWdhPndDps0ur9oeMVBHHPSVCxdj2M+01x
         I2RPZeMFww6uBVYxWGo0vUkzSZr6A/SHoo6ur7vKo82ZL/Zm8Q7RKueI1ilAYdGQJ9
         ZFZ1n+SacrPkQZ3KnIytMAqtTa5l0Lpm54bEDO+c=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDD0LRu008914
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 07:00:21 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 07:00:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 07:00:20 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDD0Kxl104648;
        Wed, 13 Dec 2023 07:00:20 -0600
Date:   Wed, 13 Dec 2023 07:00:20 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DMA Engine <dmaengine@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
Message-ID: <20231213130020.d3tpi3q5tnxz37c3@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231212203655.3155565-2-bb@ti.com>
 <1f4bed4e-12e0-4c82-a4fe-a8dee7053a1b@ti.com>
 <6ed9778c-d792-5481-144c-905a0cf12d61@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <6ed9778c-d792-5481-144c-905a0cf12d61@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 13, 2023 thus sayeth Vaishnav Achath:
> Hi Vignesh,
> 
> On 13/12/23 11:32, Vignesh Raghavendra wrote:
> > 
> > 
> > On 13/12/23 2:06 am, Bryan Brattlof wrote:
> >> From: Vignesh Raghavendra <vigneshr@ti.com>
> >>
> >> Add PSIL and PDMA data for AM62P.
> >>
> >> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> >> Signed-off-by: Bryan Brattlof <bb@ti.com>
> >> ---
> >>  drivers/dma/ti/Makefile        |   3 +-
> >>  drivers/dma/ti/k3-psil-am62p.c | 196 +++++++++++++++++++++++++++++++++
> > 
> > Does this also include J722s data? I prefer if we could introduce both
> > SoC support together as one is superset of the other. Vaishav?
> > 
> 
> This did not include J722S data and also CSI2RX data for both devices, I have
> added those and sent a V2 for this patch:
> https://lore.kernel.org/all/20231213081318.26203-1-vaishnav.a@ti.com/
> 

Ah yeah! I like doing this all in one shot. 

Thanks Vaishnav and Vignesh.

~Bryan
