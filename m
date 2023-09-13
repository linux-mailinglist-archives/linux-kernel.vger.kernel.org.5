Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7473B79F298
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjIMUJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIMUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:09:15 -0400
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F9B19AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:09:11 -0700 (PDT)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id A549D300219;
        Thu, 14 Sep 2023 05:08:56 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info A549D300219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1694635737; bh=8LpVTPUsCPQXr1wiITeRmr4X6XXYzbnyOzSEdKAjgqk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ttd6MdBo3xG/+DtOGGfYck1YuM4HBVhWOleDEu+59FeyRZpaA86Zb4vw5cOiIgreB
         Uidv7Gl+GevqpR4vQdE+sXGfLIJUw2Wzt1vDHRCWqyLjLi9FyJ5HF4tk183MwhrdRi
         5EUpJJMm0mtk495jt7KDh7ZaCM2aDTKSPKEaWb0U=
Message-ID: <c0f75cbb-4d5d-0954-4bb6-20a82cfe5e2f@soulik.info>
Date:   Thu, 14 Sep 2023 04:09:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: USB: DMA: mapping existing buffer is not supported?
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
References: <1e783efe-8659-8be1-82b7-15186302e88c@soulik.info>
 <2023091323-trombone-storeroom-cbd3@gregkh>
From:   Randy Li <ayaka@soulik.info>
In-Reply-To: <2023091323-trombone-storeroom-cbd3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/14 03:19, Greg KH wrote:
> On Thu, Sep 14, 2023 at 03:06:58AM +0800, Randy Li wrote:
>> Hello
>>
>> I was trying to understand why USB webcams (UVC) have to copy video data
>> through the CPU (uvc_video_complete() schedules uvc_video_copy_data_work()
>> for this purpose). During my investigation, I noticed that functions
>> like|usb_sg_*() and |usb_buffer_*() are not available since kernel version
>> 2.6.12.
> What do you mean by "not available"?  I see them in the tree today, why
> do you think they are not present?
>
usb_buffer_dmasync_sg(), usb_buffer_map(), usb_buffer_dmasync() and usb_buffer_unmap() are all disabled
by #if 0 in include/usb/usb.h

usb_buffer_map_sg() and usb_buffer_unmap_sg() are just declaration without definition.

>> I can comprehend that USB host controllers such as xHCI, commonly found in
>> embedded implementations like dwc3, do not support IOMMU. However, this
>> should not prevent them from operating on a contiguous buffer.
> Are you sure that the protocol for these devices allow this?
I thought that is what hcd_buffer_alloc() does.
>
>> If the USB subsystem can no longer work with existing buffers, I propose
>> that we consider removing the remaining documentation in the "Working with
>> existing buffers" section of Documentation/driver-api/usb/dma.rst.
> I don't understand, what is wrong with the information there exactly?
> Have you tried following the suggestions there?
Besides my answer to first question, I found no code use them today.
>
> thanks,
>
> greg k-h
