Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4957CA0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjJPHiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjJPHiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:38:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1BCEB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:37:58 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39G7bRpq047994;
        Mon, 16 Oct 2023 02:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697441847;
        bh=b9VEo3tm6uaO/tVCmnrM+QGxJBsi0zQVdUbCKVA0zSA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=P0/YLcembAhETIOSgkDGXoHNVOHOlwJABxYl2zlfZIO0/6s3wMF1iVjodpiDM2WjR
         +tO6onlzugS9iTSpX+2OeFRReBOajydP9UgKhOtXOJcN1uXF3pkNUavcXun1KYWQwu
         VFRebS9oK4Cyp+j/WpX1KZ+lVhS8fTsDQs6rbN10=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39G7bRm0069417
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Oct 2023 02:37:27 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 02:37:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 02:37:26 -0500
Received: from [172.24.227.6] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39G7bLOK009293;
        Mon, 16 Oct 2023 02:37:22 -0500
Message-ID: <04a6eefa-235c-c973-8c74-eb8a8982abf4@ti.com>
Date:   Mon, 16 Oct 2023 13:07:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/tidss: Power up attached PM domains on probe
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
CC:     <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <r-ravikumar@ti.com>,
        <j-choudhary@ti.com>
References: <20231009075018.2836020-1-devarsht@ti.com>
 <c9f17f9e-b9b5-9685-30ca-6a7d041dd8aa@ti.com>
 <libnfyaftywmfr2gmkdjsv6cptzjyrrx2tkxczusifnwthyh36@olzd2e5hagtr>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <libnfyaftywmfr2gmkdjsv6cptzjyrrx2tkxczusifnwthyh36@olzd2e5hagtr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 12/10/23 18:10, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Oct 12, 2023 at 05:10:06PM +0530, Devarsh Thakkar wrote:
>> On 09/10/23 13:20, Devarsh Thakkar wrote:
>>> Some SoC's such as AM62P have dedicated power domains
>>> for OLDI which need to be powered on separetely along
>>> with display controller.
>>>
>>> So during driver probe, power up all attached PM domains
>>> enumerated in devicetree node for DSS.
>>>
>>> This also prepares base to add display support for AM62P.
>>>
>>
>> NAK, for this patch, as discussed with team there are already plans
>> to have separate OLDI bridge driver which should eventually handle
>> the additional power domains.
> 
> Just for the record in case your current plan doesn't work out and we
> need to revisit this patch: my point was that it's something that
> deviates by a margin from what drivers are usually expected to do, so we
> should document why that deviation is there.
> 

Sure, thanks for suggesting, I agree that if going with this logic, we should
definitely put a comment in driver regarding same.

> The patch itself looks reasonable to me otherwise.

Yes, it's just that we are planning a separate driver for OLDI. We will see if
we need similar logic in that driver too.

Regards
Devarsh

> 
> Maxime
