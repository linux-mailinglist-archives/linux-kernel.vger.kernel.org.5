Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4EB7CE1AB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjJRPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjJRPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:50:17 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016349F;
        Wed, 18 Oct 2023 08:50:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IFo7US091100;
        Wed, 18 Oct 2023 10:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697644207;
        bh=CVoYMsn2ANqZvttwtB6pvnQR6OJFWEUdl/xYmJUllBQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Z4GeSI9u4zRxqSbSe2W83Kyo7P5DdG9zRhWmmc1VgLaaXh5sMABrqDJhJHnHdy0c4
         dOQKjAuH7mxhU8T1N+jisihTqT6i1hSTHmkUtYb716FHCmAbTN6H/8C02BecRi2Vv/
         adnAsChYYkuryr5wjRFibNIMvKxOyvyWrtx0ADbM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IFo7tY008390
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 10:50:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 10:50:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 10:50:07 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IFo76m002997;
        Wed, 18 Oct 2023 10:50:07 -0500
Date:   Wed, 18 Oct 2023 10:50:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <ssantosh@kernel.org>, <t-konduru@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        "Gunasekaran, Ravi" <r-gunasekaran@ti.com>,
        "Quadros, Roger" <rogerq@ti.com>, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] soc: ti: k3-socinfo: Revamp driver to accommodate
 different rev structs
Message-ID: <20231018155007.rpoqiptrkqatyja5@satchel>
References: <20231016101608.993921-1-n-francis@ti.com>
 <20231016101608.993921-4-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016101608.993921-4-n-francis@ti.com>
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

On 15:46-20231016, Neha Malcom Francis wrote:
> k3-socinfo.c driver assumes silicon revisions for every platform are
> incremental and one-to-one, corresponding to JTAG_ID's variant field:
> 1.0, 2.0 etc. This assumption is wrong for SoCs such as J721E, where the
> variant field to revision mapping is 1.0, 1.1. Further, there are SoCs
> such as AM65x where the sub-variant version requires custom decoding of
> other registers.
> 
> Address this by using conditional handling per JTAG ID that requires an
> exception with J721E as the first example. To facilitate this
> conversion, use macros to identify the JTAG_ID part number and map them
> to predefined string array.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Co-developed-by: Thejasvi Konduru <t-konduru@ti.com>
> Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
> ---
> Changes since v2:
> 	- update commit message
> 	- move from double Signed-off-by to Co-developed-by
> 	- make j721e_rev_string_map[] a const char
> 	- drop k3_rev_string_map[] and continue using old
> 	  "variant++" logic for the typical cases
> 	- appropriate error handling with no overrides distinguishing
> 	  between ENODEV and ENOMEM
>  

Thanks to linux-next testing, looks like this created regression in networking.

https://lore.kernel.org/all/20231018140009.1725-1-r-gunasekaran@ti.com/

I will drop this patch for now from my queue. I suggest the following
for the eventual resolution:
a) Do all the prep work in a series of atomic bisectable patches prior to introducing
j721e SR change
b) Please sync with Ravi and netdev maintainers as to how to introduce
the changes
c) also introduce changes (if required) to other SoCs as required.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
