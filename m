Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EFD774146
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjHHRRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjHHRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:17:08 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBB8B71F27;
        Tue,  8 Aug 2023 09:07:00 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378CPU0g010517;
        Tue, 8 Aug 2023 07:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691497530;
        bh=nUpsYfRlwTK66Cbczjo0J+0DAcGJ+e7VyMZ9U21DaGA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=l4vjFrusoQBw6tu2thnaTH9B6Hanl0+3l2k0uxERS+JxTn/UlQ/hdnbl0s1I9lQUF
         QtgYBpjLQVhq1uumQnXrc2dR134Lz28kEwZS8h1TpsKIqHga8u0IMrMII9Whnj89X6
         oz/54sB82cA/GN9+F4mKBkJUrnaOt6MuQvrjLb7g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378CPUgC059124
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 07:25:30 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 07:25:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 07:25:29 -0500
Received: from [10.249.48.175] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378CPTm1095997;
        Tue, 8 Aug 2023 07:25:29 -0500
Message-ID: <b9fa7346-9e99-12dd-501d-263e4a561fde@ti.com>
Date:   Tue, 8 Aug 2023 07:25:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] remoteproc: core: Honor device tree /alias entries when
 assigning IDs
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Kevin Cahalan <kevinacahalan@gmail.com>
References: <20230807140247.956255-1-nm@ti.com>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20230807140247.956255-1-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 09:02, Nishanth Menon wrote:
> Assign remoteproc device IDs based on device tree /aliases entries if
> present, falling back to the existing numbering scheme if there is no
> /aliases entry (which includes when the system isn't booted using DT)
> or a numbering conflict. If the alias node is not present, the driver
> behaves as before.
> 
> Cc: Robert Nelson<robertcnelson@gmail.com>
> Reported-by: Kevin Cahalan<kevinacahalan@gmail.com>
> Signed-off-by: Nishanth Menon<nm@ti.com>
> ---
Reviewed-by: Hari Nagalla <hnagalla@ti.com>
