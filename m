Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884DB8036A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345173AbjLDO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbjLDO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:28:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7CF1980;
        Mon,  4 Dec 2023 06:25:45 -0800 (PST)
Received: from [100.73.184.104] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C49AF6602F41;
        Mon,  4 Dec 2023 14:25:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701699943;
        bh=45qXgp1iDx7haVo6dkVdFUgNfcmTAjlnwXu2xpNKsZo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lQniG4ZJYWxPaV1HSOIqtVAWjSzGmKi2vsdfo4cM1yjiu4aYRTHXClqKyEuW868p7
         53cc9cOVW9f6M5KnDqx6E9OkAxvAwOdOxmTNviSbCE+dBZD1lfAcSNaipcpR8NB7A8
         g6kYnNH18Daust2n6vr8wgl03H5pFlAk3sV1ncZijg0faDCKLiJD3WAmBDBRsncrVU
         /T0aNfukD2lspZZpB0LK5T9lO/57th8wW9lcBgghzxnRxVDxYPrQmJq5L1JHYAWqXL
         4HX23oGE5yYfsyeMzrvz0Yyr5EWVRacxLImOtI45GuUpNdaB+Ch3tIQhsJg/07Fj7g
         kzu3Hn8r+x3+A==
Message-ID: <1823eb2d-49bf-40b1-8952-c084fe2f8a88@collabora.com>
Date:   Mon, 4 Dec 2023 16:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/36] media: microchip: Remove useless setting of
 min_buffers_needed
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com
References: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
 <20231204132323.22811-4-benjamin.gaignard@collabora.com>
 <ab06b2c0-a290-46cd-9d97-3f9f6e3bbb36@xs4all.nl>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <ab06b2c0-a290-46cd-9d97-3f9f6e3bbb36@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 16:03, Hans Verkuil wrote:
> On 04/12/2023 14:22, Benjamin Gaignard wrote:
>> This driver uses min_buffers_needed which vb2 uses to ensure
>> start_streaming is called when at least 'min_buffers_needed'
>> buffers are queued. However, this driver doesn't need this,
>> it can stream fine without any buffers queued.
>> Just drop this unnecessary restriction.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> CC: Eugen Hristev <eugen.hristev@collabora.com>
>> ---
>>  drivers/media/platform/microchip/microchip-isc-base.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
>> index 3fba0e2844b6..63c39981f47a 100644
>> --- a/drivers/media/platform/microchip/microchip-isc-base.c
>> +++ b/drivers/media/platform/microchip/microchip-isc-base.c
>> @@ -1821,7 +1821,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>>  	q->mem_ops		= &vb2_dma_contig_memops;
>>  	q->timestamp_flags	= V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>>  	q->lock			= &isc->lock;
>> -	q->min_buffers_needed	= 1;
> 
> I don't think this can be dropped. Looking at the isc_start_streaming() function
> it expects to have at least one buffer queued.

Stream goes frame by frame with DMA directly into the buffers.
Will this still work without any buffers queued ?

> 
> Regards,
> 
> 	Hans
> 
>>  	q->dev			= isc->dev;
>>  
>>  	ret = vb2_queue_init(q);
> 

