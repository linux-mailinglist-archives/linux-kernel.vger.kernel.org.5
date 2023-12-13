Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB05F81110E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378343AbjLMMW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377400AbjLMMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:22:56 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000B7E4;
        Wed, 13 Dec 2023 04:23:01 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDCMc4o007280;
        Wed, 13 Dec 2023 06:22:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702470158;
        bh=UJ5ge6ggjYltoh6aHN5Qr8NuSnhDvuFCmhxZ1zOvfu8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=R8h3Qy/lzE55xVZiHRs5GhQchOOMZBCwL0x66Z3nXT68Xgxhl8YD20GyopJc4LYtg
         wZ5YnD/3znquK3Pcv8mE03KiiYHsnbE+hEGbko6Sq8isUmtrdnGwVUEOxXmprerGkU
         tWh2UTov/iACLhjUeI1RxuC3sZhN2PpXZf9dC+pM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDCMcKm054153
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 06:22:38 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 06:22:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 06:22:38 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDCMZGD061772;
        Wed, 13 Dec 2023 06:22:36 -0600
Message-ID: <62762227-04e5-475e-aab7-ac594f99e317@ti.com>
Date:   Wed, 13 Dec 2023 17:52:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: rti_wdt: Drop RPM count when unused
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     Tero Kristo <kristo@kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>
References: <20231122041642.2015936-1-vigneshr@ti.com>
 <98c12c55-1f9f-4529-ae34-cb9f22471dbe@roeck-us.net>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <98c12c55-1f9f-4529-ae34-cb9f22471dbe@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/23 20:57, Guenter Roeck wrote:
> On 11/21/23 20:16, Vignesh Raghavendra wrote:
>> Do a RPM put if watchdog is not already started during probe and re
>> enable it in watchdog start.
>>
>> On K3 SoCs, watchdogs and their corresponding CPUs are under same PD, so
>> if the reference count of unused watchdogs aren't dropped, it will lead
>> to CPU hotplug failures as Device Management firmware won't allow to
>> turn off the PD due to dangling reference count.
>>
>> Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> I always find it amazing that people think everyone would understand the
> TLAs
> (three-letter-acronyms) they use. While those who don't might find it
> confusing
> why a watchdog driver would need or want to drop rotation-per-minute
> counts,
> and what that has to do with police departments, that isn't worth
> arguing about
> 

Oops, my apologies. I will respin with TLAs expanded

> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 

Thanks!

> Guenter
> 

-- 
Regards
Vignesh
