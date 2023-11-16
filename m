Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662637EE04B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345110AbjKPMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPMBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:01:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1AC4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:01:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005A4C433C8;
        Thu, 16 Nov 2023 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700136076;
        bh=c7gMUttZFyHHQ9COrEEKH4SS+vncMf6Y8hrZnTRxLYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SuKBqNHsU+fNNgXSXPII1Osj2l1CDoO4VvhdYjyiNcPr/CKLB8/IgHL+sH2Zi5Vd3
         OF9GVwgC+Iz1tDkjBPH05TP8xf9cUZvJP27FLs6guK6hcXe+QitVEfeRxycjlrlUHC
         bB0J7i4JVzw0lbczlYUP1gxsDzeA4QFkt0zl2iuQr1J21UAka2f35Gl0hUARiLxa8d
         LRMyXZY1B/HP7oyspTrzBF36zEYurikArcAf6C6+ObpTdJRrqhbO5h4zkkhfRV5Xri
         asFvYLhnhuQaawuRRVLPA38RvdGCETNY6o1wTdnNgYHD8D/fYTKPAmFnROS/p3Z/iZ
         Rt8ZgxgcGVmMg==
Message-ID: <79f3beef-1afe-4b97-8f6e-435c0419b513@kernel.org>
Date:   Thu, 16 Nov 2023 14:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] usb: cdns3-ti: move reg writes from probe into an
 init_hw helper
To:     =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-2-ad1ee714835c@bootlin.com>
 <aabf618e-9352-4555-9059-f213cb16c84f@kernel.org>
 <CWZGC158AQK7.2XQXIEEH6WO2J@tleb-bootlin-xps13-01>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CWZGC158AQK7.2XQXIEEH6WO2J@tleb-bootlin-xps13-01>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/2023 16:23, Théo Lebrun wrote:
> Hello,
> 
> On Wed Nov 15, 2023 at 12:33 PM CET, Roger Quadros wrote:
>>> --- a/drivers/usb/cdns3/cdns3-ti.c
>>> +++ b/drivers/usb/cdns3/cdns3-ti.c
> 
> [...]
> 
>>>  static int cdns_ti_probe(struct platform_device *pdev)
>>>  {
>>>  	struct device *dev = &pdev->dev;
>>>  	struct device_node *node = pdev->dev.of_node;
>>>  	struct cdns_ti *data;
>>> -	int error;
>>> -	u32 reg;
>>> -	int rate_code, i;
>>>  	unsigned long rate;
>>> +	int error, i;
>>
>> Should we leave rate_code and get rid of i?
> 
> I see your point about i being usually a temp variable. Using rate_code
> instead of i means the for-loop becomes rather long (column 87) &
> should ideally be split.
> 
> How about moving the data->usb2_refclk_rate_code assignment up, closer
> to the computation of i? That way we don't reference i three blocks
> down the road, seemingly out of nowhere.

That is much better. Thanks!

-- 
cheers,
-roger
