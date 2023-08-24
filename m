Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6A7867EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbjHXG5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbjHXG4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:56:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B5D1AD;
        Wed, 23 Aug 2023 23:56:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O6uKqQ048141;
        Thu, 24 Aug 2023 01:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692860180;
        bh=2P/1sjNnNdtOb3AE6gta0LQ2FB1wM5ZQeZn6CxhMBig=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Inyn/XdkE7yem0ocCTzALQf3RT9rlUTB1PfyesBhjmmGEYy2h5Y0EfmK+PNZrQU54
         kG7pXPx2t/x8AX+qLUenu2JzMD1jfXPzLwfAvkRxAGYoXCdtH7UOgRbvRWJjA8xQuL
         LAlUIIkZqbKR+kfIBk3sw0Ylx0jayEKTQSiKq6Ng=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O6uKqs070627
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 01:56:20 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 01:56:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 01:56:19 -0500
Received: from [172.24.227.35] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O6uChu085376;
        Thu, 24 Aug 2023 01:56:13 -0500
Message-ID: <8ef0017f-9ba2-2ac1-702e-a9194f75652f@ti.com>
Date:   Thu, 24 Aug 2023 12:26:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v6 4/5] net: ti: icssg-prueth: add packet
 timestamping and ptp support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230823113254.292603-1-danishanwar@ti.com>
 <20230823113254.292603-5-danishanwar@ti.com>
 <d07213a9-6cf5-3577-a2c7-d0f2773a8247@linaro.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <d07213a9-6cf5-3577-a2c7-d0f2773a8247@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/23 12:17 pm, Krzysztof Kozlowski wrote:
> On 23/08/2023 13:32, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> Add packet timestamping TS and PTP PHC clock support.
>>
>> For AM65x and AM64x:
>>  - IEP1 is not used
>>  - IEP0 is configured in shadow mode with 1ms cycle and shared between
>> Linux and FW. It provides time and TS in number cycles, so special
>> conversation in ns is required.
>>  - IEP0 shared between PRUeth ports.
>>  - IEP0 supports PPS, periodic output.
>>  - IEP0 settime() and enabling PPS required FW interraction.
>>  - RX TS provided with each packet in CPPI5 descriptor.
>>  - TX TS returned through separate ICSSG hw queues for each port. TX TS
>> readiness is signaled by INTC IRQ. Only one packet at time can be requested
>> for TX TS.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Co-developed-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> 
> How patch author could review or not review its own code? How does it
> even work? I write a patch and for example judge - oh no, it is wrong,
> but I will still send it, just without my review. Or I write a patch -
> oh, I like it, I wrote excellent code, let me add review tag for my own
> code!
> 

He didn't review this patch explicitly. He gave RB for entire series, b4 [1]
must have added his RB to all patches instead of only adding to those patches
for which he is not the author. I will manually remove his RBs in the patches
where he is the author.

[1] https://b4.docs.kernel.org/en/latest/index.html

>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Where?
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Danish.
