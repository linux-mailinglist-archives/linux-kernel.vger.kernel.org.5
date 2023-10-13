Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3659B7C841E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjJMLLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjJMLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:11:21 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93074BD;
        Fri, 13 Oct 2023 04:11:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39DBB26B024931;
        Fri, 13 Oct 2023 06:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697195462;
        bh=BAlapzkRWHzVFJ6S6sO0/lwo/UPnEom59HZeYwg6iwA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HOkjapG3b3gfOck6k1IZmPJymPveCY6JC7bw/l0QEGU8zDlPxlyanghmPWCeE1gia
         /sYILAp8hgDfVRZTl/wP8AK/VjT3TG6YsdiBqRJMCRGcLnv9TEdrU5MPrNY25yqR53
         SwJn9nQEhQ5btlmVd6tBHE9+MKjf97E00Z3V85Zc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39DBB18f015952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Oct 2023 06:11:01 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 06:11:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 06:11:01 -0500
Received: from [10.24.69.31] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39DBAutq025442;
        Fri, 13 Oct 2023 06:10:57 -0500
Message-ID: <7b0a02ad-d23c-2c04-6672-58f16f2cca5a@ti.com>
Date:   Fri, 13 Oct 2023 16:40:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] net: ethernet: ti: Fix mixed module-builtin object
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20231013100549.3198564-1-danishanwar@ti.com>
 <4a53722d-e31d-4598-a4a9-cf374c84bc44@app.fastmail.com>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <4a53722d-e31d-4598-a4a9-cf374c84bc44@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 13/10/23 16:08, Arnd Bergmann wrote:
> On Fri, Oct 13, 2023, at 12:05, MD Danish Anwar wrote:
>> With CONFIG_TI_K3_AM65_CPSW_NUSS=y and CONFIG_TI_ICSSG_PRUETH=m,
>> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
>> the expected CFLAGS are different between builtins and modules.
>>
>> The build system is complaining about the following:
>>
>> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
>> ti-am65-cpsw-nuss
>>
>> Introduce the new module, k3-cppi-desc-pool, to provide the common
>> functions to ti-am65-cpsw-nuss and icssg-prueth.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> I submitted a different patch for this a while ago:
> https://lore.kernel.org/lkml/20230612124024.520720-3-arnd@kernel.org/
> 
> I think I never sent a v2 of that, but I still have a
> working version in my local tree. I've replaced my version
> with yours for testing now, to see if you still need something
> beyond that.
> 

I see your patch addresses different modules. My patch introduces a new
module for k3-cppi-desc-pool which is used by both am65-cpsw-nuss and
icssg-prueth driver. Where as your patch addresses modules common across
different cpsw drivers (davinci-emac, cpsw, cpsw-switchdev, netcp,
netcp_ethss and am65-cpsw-nuss). So I think that both these patches are
addressing differet warnings.

>     Arnd

-- 
Thanks and Regards,
Danish
