Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B83813508
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573861AbjLNPls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjLNPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:41:47 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758D111;
        Thu, 14 Dec 2023 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702568512;
        bh=AwBqTH3jxYY2SxYvwm4RiTxswXu1qwwNdGeqdtO0ynw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DATtQ2jW6I9h/uNNbShGq4bU04cLoI87NzvIJUU4Lx04d5wDrvFigL3GNhYuLk4NL
         e/ikmviXtmHaS2xBzjYCYW29jx5altAcA4X1P98I89Z0KWMgu73Rt9A6f2Lx87Z/h+
         PTy2M0tU+i4flGj0s2sJwO9FkfO6yJTbnRy5i2daXtMRdwJnS3uwc1DGkcgL7paKzp
         6gRJ+kSDA6TjK3shglv4+NlqBz1tRshV0xj9YaGCVgJ26X66eKgWN73cgLk42bT5K+
         9k+XZ2sT9YeMoGyeCdD8La9D9E8yjuiXqh4Lzp/h9BF9aOY+8QMHuSB4uasVTk+DLO
         5iB9QttJB4f2Q==
Received: from [100.93.89.217] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2C1A13781485;
        Thu, 14 Dec 2023 15:41:52 +0000 (UTC)
Message-ID: <0e64b778-e4ff-4b2f-9864-b5d58f642e0e@collabora.com>
Date:   Thu, 14 Dec 2023 16:41:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] videobuf2: core: Rename min_buffers_needed field
 to vb2_queue
To:     Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com
References: <20231211133251.150999-1-benjamin.gaignard@collabora.com>
 <20231211133251.150999-2-benjamin.gaignard@collabora.com>
 <839535af-acba-4240-b9c6-d592d898dc4c@xs4all.nl>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <839535af-acba-4240-b9c6-d592d898dc4c@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 13/12/2023 à 17:39, Hans Verkuil a écrit :
> Hi Benjamin,
>
> On 11/12/2023 14:32, Benjamin Gaignard wrote:
>> Rename min_buffers_needed into min_queued_buffers and update
>> the documentation about it.
> I merged this patch, but not the others. I also dropped one functional
> change:
>
> <snip>
>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index 40d89f29fa33..8912dff5bde3 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -865,7 +865,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>>   	/*
>>   	 * Make sure the requested values and current defaults are sane.
>>   	 */
>> -	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
>> +	num_buffers = max_t(unsigned int, *count, q->min_queued_buffers + 1);
>>   	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
>>   	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
>>   	/*
> That "+ 1" didn't really belong here, since everything else was just renaming a
> field. Such a patch shouldn't make any other changes.
>
> There were also three more occurrences of min_buffers_needed (one in a comment,
> two in a vivid function argument), and I renamed those as well.
>
> 'git grep min_buffers_needed' now no longer shows any hits.
>
> I decided not to take the other patches, I think it is best if you rebase
> and repost the series on top of staging and in the new year we'll continue with
> it. I did not feel that I had enough time to really review the remaining patches.

Do you want me to re-post only the two missing patches or should I add the patches for
delete buffers feature since it is the ultimate goal of this ?

Regards,
Benjamin

>
> However, it is nice to have this large rename patch merged. It touches on a lot
> of files, so it is annoying to have to carry that around. And now was a good
> moment to merge it.
>
> Regards,
>
> 	Hans
>
