Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2BB7D28DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjJWDHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjJWDG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:06:58 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0BB0AD51;
        Sun, 22 Oct 2023 20:06:53 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id A9E0C6048B9C3;
        Mon, 23 Oct 2023 11:06:48 +0800 (CST)
Message-ID: <46aee820-6c01-ed8a-613b-5c57258d749e@nfschina.com>
Date:   Mon, 23 Oct 2023 11:06:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <1698029596.5404413-3-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/23 10:53, Xuan Zhuo wrote:
> On Mon, 23 Oct 2023 10:51:59 +0800, Su Hui <suhui@nfschina.com> wrote:
>> On 2023/10/23 10:26, Xuan Zhuo wrote:
>>>>>> Well, what are the cases where it can happen practically?
>>>>> Device error. Such as vp_active_vq()
>>>>>
>>>>> Thanks.
>>>> Hmm interesting. OK. But do callers know to recover?
>>> No.
>>>
>>> So I think WARN + broken is suitable.
>>>
>>> Thanks.
>> Sorry for the late, is the following code okay?
>>
>> @@ -2739,7 +2739,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>>                        void (*recycle)(struct virtqueue *vq, void *buf))
>>    {
>>           struct vring_virtqueue *vq = to_vvq(_vq);
>> -       int err;
>> +       int err, err_reset;
>>
>>           if (num > vq->vq.num_max)
>>                   return -E2BIG;
>> @@ -2759,7 +2759,15 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>>           else
>>                   err = virtqueue_resize_split(_vq, num);
>>
>> -       return virtqueue_enable_after_reset(_vq);
>> +       err_reset = virtqueue_enable_after_reset(_vq);
>> +
>> +       if (err) {
> No err.
>
> err is not important.
> You can remove that.

Emm, I'm a little confused that which code should I remove ?

> Thanks.
>
>
>> +               vq->broken = true;
>> +               WARN_ON(err_reset);
>> +               return err;
>> +       }
>> +
>> +       return err_reset;
>>    }
>>
>> Thanks.
>> Su Hui
>>
