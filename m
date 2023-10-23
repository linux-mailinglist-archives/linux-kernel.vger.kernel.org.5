Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C067D28B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjJWCwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJWCwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:52:11 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 68A01119;
        Sun, 22 Oct 2023 19:52:02 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id B6310604889C4;
        Mon, 23 Oct 2023 10:51:59 +0800 (CST)
Message-ID: <d4aa3f76-3e08-a852-a948-b88226a37fdd@nfschina.com>
Date:   Mon, 23 Oct 2023 10:51:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <1698028017.8052797-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/23 10:26, Xuan Zhuo wrote:
>>>> Well, what are the cases where it can happen practically?
>>> Device error. Such as vp_active_vq()
>>>
>>> Thanks.
>> Hmm interesting. OK. But do callers know to recover?
>
> No.
>
> So I think WARN + broken is suitable.
>
> Thanks.
Sorry for the late, is the following code okay?

@@ -2739,7 +2739,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
                      void (*recycle)(struct virtqueue *vq, void *buf))
  {
         struct vring_virtqueue *vq = to_vvq(_vq);
-       int err;
+       int err, err_reset;
  
         if (num > vq->vq.num_max)
                 return -E2BIG;
@@ -2759,7 +2759,15 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
         else
                 err = virtqueue_resize_split(_vq, num);

-       return virtqueue_enable_after_reset(_vq);
+       err_reset = virtqueue_enable_after_reset(_vq);
+
+       if (err) {
+               vq->broken = true;
+               WARN_ON(err_reset);
+               return err;
+       }
+
+       return err_reset;
  }

Thanks.
Su Hui

