Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD3790763
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351997AbjIBKpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:45:20 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC48CC;
        Sat,  2 Sep 2023 03:45:17 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 382Aiq0Q052850;
        Sat, 2 Sep 2023 05:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693651492;
        bh=MTknmprLmnJQFCQzNZrSewxgOvvJ97mCk4oPPBtNwDw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=dZniak8IzFjCeDlVFVk1v5VGKK7EfUikHGUm46hCdYjObmfF2789xJ08NHl/EtgIf
         WkYapRH751NYiNgQv6idpB5SUsfSmEfrVxhjvYxfFYJOneqdfl7sy8+s4yhDlzWAGT
         gQ0imQgr31/gr9PDv+8ZEdyNgmgXrxwUBmhJGNZE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 382AiqMr004272
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 2 Sep 2023 05:44:52 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 2
 Sep 2023 05:44:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 2 Sep 2023 05:44:51 -0500
Received: from [10.249.48.175] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 382Aipkg000497;
        Sat, 2 Sep 2023 05:44:51 -0500
Message-ID: <10acb196-b7e4-1b19-6015-c44e72bea1cc@ti.com>
Date:   Sat, 2 Sep 2023 05:44:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 4/5] remoteproc: k3: Split out functions common with M4
 driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <andersson@kernel.org>, <p.zabel@pengutronix.de>,
        <martyn.welch@collabora.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20230808044529.25925-1-hnagalla@ti.com>
 <20230808044529.25925-5-hnagalla@ti.com> <ZO5LVy9bx7Q3iILi@p14s>
Content-Language: en-US
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <ZO5LVy9bx7Q3iILi@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 8/29/23 14:47, Mathieu Poirier wrote:
>> Signed-off-by: Martyn Welch<martyn.welch@collabora.com>
>> Signed-off-by: Hari Nagalla<hnagalla@ti.com>
>> ---
>> Changes since v2:
>>   - New patch (reordered refactored from v2)
>>
>> Changes since v3:
>>   - Removed "ipc_only" element from k3_rproc structure
>>   - Refactored to bring 3 more common functions
>>   
>> Changes since v4:
>>   - None
>>
>>   drivers/remoteproc/Makefile               |   2 +-
>>   drivers/remoteproc/ti_k3_common.c         | 513 +++++++++++++++++++
>>   drivers/remoteproc/ti_k3_common.h         | 103 ++++
>>   drivers/remoteproc/ti_k3_dsp_remoteproc.c | 598 ++--------------------
>>   4 files changed, 646 insertions(+), 570 deletions(-)
>>   create mode 100644 drivers/remoteproc/ti_k3_common.c
>>   create mode 100644 drivers/remoteproc/ti_k3_common.h
> This patch is hard to follow because of all the things it does.  Please do the
> structures in one patch and the functions in another.
> 
I will re-structure the patches as you suggested for driver and also 
separate the device tree node patches to avoid clutter.

Thanks
