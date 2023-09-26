Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80DA7AEB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjIZLen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjIZLei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:34:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107EBEB;
        Tue, 26 Sep 2023 04:34:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QBYJV1033214;
        Tue, 26 Sep 2023 06:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695728059;
        bh=lXn6zrPZQgN2DQTU1obSLQ/tnQoBkpcvB0Vo912nkVE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GbOSMxC1SxbhuQBb2GCBR4DN+gSRSPKRh7ZBBL1wc2uTNi2dqMA8qFMp2QnEAQkGP
         Oe797N5+CA9psBdM9NqfonaupfILkvc9PZB9hIwhOxCAkUL+ioFeAfxJ/+DwcKIQtQ
         l4vWuXd7JTIQpwYtpKeQupLIoEsfMaKed4p5icow=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QBYJmG018146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 06:34:19 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 06:34:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 06:34:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QBYHDN025434;
        Tue, 26 Sep 2023 06:34:18 -0500
Date:   Tue, 26 Sep 2023 17:04:17 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH V2] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <20230926113417.eys5qtaq3eshx3si@dhruva>
References: <20230919074658.41666-1-d-gole@ti.com>
 <ZRK+oDrT4vaZ0R/G@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZRK+oDrT4vaZ0R/G@finisterre.sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2023 at 13:21:04 +0200, Mark Brown wrote:
> On Tue, Sep 19, 2023 at 01:16:59PM +0530, Dhruva Gole wrote:
> > The following smatch warnings [0] were recently introduced:
> > 
> > drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
> > unwind goto?
> 
> This doesn't apply against current code, please check and resend.

OK, will rebase and send along with the fixed closes tag.



-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
