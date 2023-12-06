Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A99A806F50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377889AbjLFL7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377792AbjLFL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:59:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CAC112;
        Wed,  6 Dec 2023 03:59:29 -0800 (PST)
Received: from [100.122.216.38] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 166CD6607365;
        Wed,  6 Dec 2023 11:59:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701863967;
        bh=NQVRc6GiFEVTdKMxJaUtDzeg9fI0AYeC0jB8pgFpeUw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YWeG38ivXhQAXgqNhclFEjHJTFB+oP5vWkd1sKkLh0un3upmJX4Oiil5sHcYDYnVz
         HG3jXdqC1s67QcP8DLBd8wZrzwuqrybVTMdE4s5DEucJ0NiZxpDI3n0ChYOz0cxzWX
         GAOXcwFHwzW+ZM+J+ddpOYf/rVfs+J/kVzBI6m6kGvtOuv8EH/oj5TCXGgCZ9SAA8D
         FLze+zn4clZOOlxuTtb64Zk2826QeW2oFIhuv9QhtU2h8Ep8iEEnPXuDcxTXcbjISk
         s3JqoXrTsTQb2OEreh0iaT+wKxA7j9cr2QT6Nn9koR501kZiOZUWXN+Um0GljfjfIP
         YjMzlKRPzT6mg==
Message-ID: <34558f91-4253-4a1f-997c-1c8b02786fcb@collabora.com>
Date:   Wed, 6 Dec 2023 12:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] videobuf2: core: Rename min_buffers_needed field
 to vb2_queue
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com
References: <20231206085608.33246-1-benjamin.gaignard@collabora.com>
 <20231206085608.33246-2-benjamin.gaignard@collabora.com>
 <a2011bd9-8d1d-486d-8a54-794193dc99ec@suswa.mountain>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <a2011bd9-8d1d-486d-8a54-794193dc99ec@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 06/12/2023 à 10:54, Dan Carpenter a écrit :
> On Wed, Dec 06, 2023 at 09:56:07AM +0100, Benjamin Gaignard wrote:
>> Rename min_buffers_needed into min_queued_buffers and update
>> the documentation about it.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> [ snip ]
>
>> diff --git a/drivers/media/pci/zoran/zoran_driver.c b/drivers/media/pci/zoran/zoran_driver.c
>> index fa672cc8bc67..2c91f75e8d79 100644
>> --- a/drivers/media/pci/zoran/zoran_driver.c
>> +++ b/drivers/media/pci/zoran/zoran_driver.c
>> @@ -749,9 +749,6 @@ static int zr_vb2_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers, unsi
>>   
>>   	zr->buf_in_reserve = 0;
>>   
>> -	if (*nbuffers < vq->min_buffers_needed)
>> -		*nbuffers = vq->min_buffers_needed;
>> -
>>   	if (*nplanes) {
>>   		if (sizes[0] < size)
>>   			return -EINVAL;
> This was not mentioned in the commit message.  And anyway, please do
> that as a separate commit.

It is a mistake, I don't want to change the drivers code.
I will restore these lines in next version.

Same for vdec driver below.

Regards,
Benjamin

>
> regards,
> dan carpenter
>
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
