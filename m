Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9ED7A20FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjIOOa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjIOOa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:30:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A21A2735;
        Fri, 15 Sep 2023 07:30:02 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FETvTi089086;
        Fri, 15 Sep 2023 09:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694788197;
        bh=0VPXjduHx8QmTp7QTVlGk1sE/4TC9BztDnauuRUEaP0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yXsbSBpxwfm23XWT0XPB8K/QWm378Jbq5lEjF1GBgVf/g1ymzh/33WuhaBCVw5gpG
         PLjoXLHxckt1GwKY+30L6BctQ+2bvV/+tsFI7nOrXoelxwbHH7J4/9jzMh2vXjrSxz
         d/emgxBZtQYrVlhyt8HSl6J9lsYtohguLF5sGOwQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FETvH1028498
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 09:29:57 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 09:29:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 09:29:56 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FETtdS006196;
        Fri, 15 Sep 2023 09:29:56 -0500
Date:   Fri, 15 Sep 2023 19:59:55 +0530
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <20230915142955.h4sndeix2begarl5@dhruva>
References: <20230915123103.2493640-1-d-gole@ti.com>
 <b22f9e16-1c65-4a9d-b3ea-9f6571647923@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b22f9e16-1c65-4a9d-b3ea-9f6571647923@sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 15, 2023 at 13:49:23 +0100, Mark Brown wrote:
> On Fri, Sep 15, 2023 at 06:01:04PM +0530, Dhruva Gole wrote:
> > Fix the smatch warnings that were recently introduced in the runtime pm
> > patch [0]:
> > drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
> > unwind goto?
> > 
> > [0] https://lore.kernel.org/all/20230829062706.786637-1-d-gole@ti.com/
> 
> Please use normal fixes tags for things like this and in general

OK, I will resend with fixes tag.

> please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on trains or flights, or while
> otherwise travelling so this is even more pressing for me than just
> being about making things a bit easier to read.

Will keep this in mind!

Also, I think a better fix will do, as I just noticed I am not really
doing a dma_release_channel in this path although I got rid of the
warning.


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
