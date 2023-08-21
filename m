Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933BF782AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjHUNgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbjHUNgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:36:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2CF9B9;
        Mon, 21 Aug 2023 06:36:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1E942F4;
        Mon, 21 Aug 2023 06:36:43 -0700 (PDT)
Received: from [10.57.3.137] (unknown [10.57.3.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6A1B3F740;
        Mon, 21 Aug 2023 06:36:00 -0700 (PDT)
Message-ID: <e91dde98-b1ec-6e68-b823-9b5232a4774d@arm.com>
Date:   Mon, 21 Aug 2023 14:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Content-Language: en-GB
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        yuji2.ishikawa@toshiba.co.jp
Cc:     krzysztof.kozlowski@linaro.org, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, broonie@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
 <20230714015059.18775-3-yuji2.ishikawa@toshiba.co.jp>
 <0d0cec7f-030f-ebc1-11f0-06214197a351@linaro.org>
 <TYAPR01MB620105AC2EDF36751EE654C89203A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <20230821131903.GI10135@pendragon.ideasonboard.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230821131903.GI10135@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-21 14:19, Laurent Pinchart wrote:
[...]
>>>> +	viif_dev->tables =
>>>> +		dma_alloc_wc(dev, sizeof(struct viif_table_area), &tables_dma, GFP_KERNEL);
>>>> +	if (!viif_dev->tables) {
>>>> +		dev_err(dev, "dma_alloc_wc failed\n");
>>>
>>> Are you sure DMA memory allocation errors shall be printed?
>>
>> Printing this error is useless for users in general?
>> If so, I'll drop this debug output.
> 
> Failures to allocate memory in the kernel generally result in warning
> messages being printed by the allocation function, so there's no need to
> do so manually in drivers. This being said, I check dma_alloc_wc()
> (which is a wrapper around dma_alloc_attrs()), and unless I'm missing
> something, it can return NULL without printing any error. I don't know
> if this is an oversight in some code paths taken by dma_alloc_attrs() or
> if it's on purpose. Maybe Christoph, Marek or Roben will known.

Yeah, there might be a few edge cases, but in most cases 
dma_alloc_attrs() will end up falling back to the page allocator as a 
last resort if all the more preferred allocation options fail, and thus 
complete failure should eventually cause that to scream unless 
DMA_ATTR_NO_WARN was specified.

Thanks,
Robin.
