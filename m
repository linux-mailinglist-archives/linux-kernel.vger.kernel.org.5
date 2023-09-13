Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22579E6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbjIML2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbjIML2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:28:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F191726
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:28:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38DBSOm3003054;
        Wed, 13 Sep 2023 06:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694604504;
        bh=lPBlKm6971IjTYMi/EZXsKwtVnDwVd301Kkc6UIPRkI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BPwnS3T4ssvtjJG5KOmFsym1IjtjrpyZtohTjFl/OpW+xSrN5IkneaA61LGtP1r1B
         pn/qyefvtVYcIcy9SGDhqozpty+FatIRZhROFS8crGCQi0vH75dmDjxRgt5Q1GJLP4
         0zUTpddFe1Pi7CMP6vrxAPqXKLuvuOjp4GHUYo4Q=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38DBSN0Z082517
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 06:28:23 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 06:28:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 06:28:23 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38DBSNOY008291;
        Wed, 13 Sep 2023 06:28:23 -0500
Date:   Wed, 13 Sep 2023 06:28:23 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     Thejasvi Konduru <t-konduru@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] soc: ti: k3-socinfo: Fix the silicon revision misprint
Message-ID: <20230913112823.prv5dmasvv4nt6qv@nuclear>
References: <20230607080349.26671-1-t-konduru@ti.com>
 <20230607104304.iengykppptr3fxe6@reflected>
 <d50e7612-0b17-0f65-872f-90e08bed9948@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d50e7612-0b17-0f65-872f-90e08bed9948@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:07-20230912, Neha Malcom Francis wrote:

[...]

> > > +void
> > > +k3_chipinfo_silicon_rev(unsigned int variant,
> > > +			struct soc_device_attribute *soc_dev_attr)
> > > +{
> > > +	const char *family_name = soc_dev_attr->family;
> > > +	int j721e_lookup_arr_size = ARRAY_SIZE(soc_revision_j721e);
> > > +
> > > +	if (!strcmp(family_name, "J721E") && variant < j721e_lookup_arr_size) {
> > > +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s", soc_revision_j721e[variant]);
> > > +	} else {
> > > +		variant++;
> > > +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
> > > +	}
> > 
> > I am not comfortable with if else here. Why not extend k3_soc_id
> > structure to include the variant LuT? Are there exceptions to this rule
> > (Say AM65x?), those would make sense to handle with a compare against
> > the partno?
> > 
> 
> Trying to revive this patch, I see what you are saying is similar to the way
> detection has already been implemented in U-Boot (drivers/soc/soc_ti_k3.c)
> if I'm not mistaken.

Yes.

> 
> But I can't find any existing exception to this "family --> version" rule
> that forces us to use "partno --> version". Checked through all AM65x device
> TRMs available in ti.com; all seem to use common partno. So maybe I am not
> on the same page, did you mean something else?

https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
CTRLMMR_WKUP_JTAGID:: VARIANT field: SR2.0: 1h SR1.0: 0h
Latest data sheet: https://www.ti.com/lit/ds/symlink/am6548.pdf
indicates SR 2.1

How is this detected?

What I indicated is a LUT table similar to
https://git.ti.com/cgit/k3conf/k3conf/tree/common/socinfo.c#n382

This allows a switch statement to handle custom SR handling schemes or
use LUT with variants that use VARIANT field to handle things properly.

[...]
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
