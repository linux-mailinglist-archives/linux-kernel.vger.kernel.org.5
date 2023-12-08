Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934C80A214
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573571AbjLHLVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjLHLVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:21:50 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AD110CF;
        Fri,  8 Dec 2023 03:21:52 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B8BLh2e002284;
        Fri, 8 Dec 2023 05:21:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702034503;
        bh=oLg0AisyamUAtVSfksyGAW5Md+GYqQaIkcHjjDZN0+M=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JBo6OQEaEjo4IiHFUd8QMeejBINXQLmQfVF8diQajDCYn8bBY/vkw5b6xry6uqAmB
         /4xKovFzdv8OPaPiW6Aukip5ZvsgHoTaj5Bnosqe0Kefv6VRoKTLJM4+lFQq+RC9A/
         e74XqpXBO4g5ECzxGFxNdEkHuQeF177X2DAh+Zec=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B8BLgs7015127
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Dec 2023 05:21:43 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Dec 2023 05:21:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Dec 2023 05:21:42 -0600
Received: from [10.249.48.175] ([10.249.48.175])
        by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B8BLgjq055436;
        Fri, 8 Dec 2023 05:21:42 -0600
Message-ID: <d582b9fa-a2bf-c522-278d-58ddf9353be8@ti.com>
Date:   Fri, 8 Dec 2023 05:21:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/5] remoteproc: k3-r5: Add support for IPC-only mode
 for all R5Fs
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <20220213201246.25952-1-s-anna@ti.com>
 <20220213201246.25952-4-s-anna@ti.com>
 <e0bc7eb5-f1b9-4e99-a39f-ca6f31daa9d8@siemens.com> <ZUPDrlVLkDDgJpWm@p14s>
 <106f3a36-16d8-4272-ad7a-287e6a3acfb5@siemens.com>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <106f3a36-16d8-4272-ad7a-287e6a3acfb5@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/23 11:43, Jan Kiszka wrote:
>>> RTI1 watchdog also powers up R5F core 1. And this could happen either in
>> When writing "... also powers up...", other than R5F core 1, what else is being
>> powered?
> Would be a question for the SoC vendor - I assumed that only mcu_rti1
> [1] goes on when enabling it. But also mcu_r5fss0_core1 is enabled after
> that, at least according to the respective TI-SCI query that the is_on
> handler is performing. I've tested that under Linux and in U-Boot.
> 
As described in section 12.5.2.1 of AM64x TRM 
(https://www.ti.com/lit/pdf/SPRUIM2) -There is a RTI for each CPU core. 
And it is not intended to be use RTI provisioned for a particular CPU 
core with a different core.
And also as shown in section (5.2.2.2.1.3.1) the CPU core and 
corresponding RTI share the same power sub module (LPSC), so enabling 
one powers on the other.

As Suman suggested, it seems more appropriate to enable the RTI watchdog 
timers in the remoteproc driver. Legacy omap remoteproc drivers have 
this support and needs to be extended to k3 remoteproc drivers.
Another option could be to DEFER RTI probe until corresponding 
remoteproc driver is probed.

Any other solutions to maintain this order of enabling remote core and 
the corresponding RTI/WDT?
