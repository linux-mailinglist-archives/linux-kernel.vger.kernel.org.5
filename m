Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F807AA9AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjIVHFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIVHFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:05:47 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0718F;
        Fri, 22 Sep 2023 00:05:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38M75TbA047640;
        Fri, 22 Sep 2023 02:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695366329;
        bh=LTJ02Jb2rpuPbIq/vd3dyF6Rpb23oYrvV/Lj91cx8s8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=KjciD4qGHxN6BIilDkQZXbEdYWg4sUtgTep9YcYF5vtvAzJ6Be/U+K0QFN/pex5Yd
         kmRzDWTCZB11Bpkb0VlSglU4ycxKPClrH5cORFL5lzt9z06x+H+irJ3EvIEepGjjeR
         g7tBWmYQ7yb+k2cGXZ8IcRwOYGp2y5znCcheHlfw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38M75TjQ078961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Sep 2023 02:05:29 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 02:05:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 02:05:29 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38M75N5F048136;
        Fri, 22 Sep 2023 02:05:24 -0500
Message-ID: <ef27a0e4-6ce6-5690-85de-a2162255bbfb@ti.com>
Date:   Fri, 22 Sep 2023 12:35:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: add TAPRIO offload
 support
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <vladimir.oltean@nxp.com>,
        Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@ti.com>
References: <20230921070031.795788-1-danishanwar@ti.com>
 <b3248b40-38a1-47b0-a61d-e81a451fa0a7@kernel.org>
 <f54b6cd6-3f9f-4a4c-a14d-de2201f1e8b0@lunn.ch>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <f54b6cd6-3f9f-4a4c-a14d-de2201f1e8b0@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/23 22:05, Andrew Lunn wrote:
> On Thu, Sep 21, 2023 at 01:42:36PM +0300, Roger Quadros wrote:
>> Hi Danish,
>>
>> On 21/09/2023 10:00, MD Danish Anwar wrote:
>>
>> Can you please retain patch authorhsip?
>>
>>> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
>>> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
>>> configuration.
> 
> Does the switch version of the firmware support this?
> 

Yes. Switch firmware also supports EST.

>      Andrew

-- 
Thanks and Regards,
Danish
