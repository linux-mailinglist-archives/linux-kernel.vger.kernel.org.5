Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D47EB6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjKNTll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNTlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:41:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC72113;
        Tue, 14 Nov 2023 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699990872; x=1700595672; i=wahrenst@gmx.net;
        bh=7XpRZHnFj2Izkoh0Q5WsLmSTskwyxjWzJ7y2oCyz9Lw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=tJhaV+jnx507vsMlPnQXY1AwpaMQLySogxQTZ0zqBy/TxAUezvw/Y29DWQVM7xVL
         JGRKSsq4EY9OVJ/6XM3/zIa6qRJk0s559tEdqW4ZKsEF/7YTwqC6fYey9/lj2hR8a
         kWJSBhizdtz3QQdS2vJCD7UfXPN+boRp54xm6RTQ/4Tke/1kaTgK1o7GdaJbYZVgg
         u8qaUuTGihmCHuX7IxnUlf/bBVRMIIokblygNg78+vG3gqaWSZDl4T0NDbU8Oaio2
         icpfEnDa61PKVRxu8z2yfmFPlMJ5BsC5tVxZpyy/8Z8ey4HPP510pUABTXLY4jBLC
         B2PA0fm5/i/Pk5e3KA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1r1tLg0n5Y-007m2J; Tue, 14
 Nov 2023 20:41:12 +0100
Message-ID: <72f83177-cd34-480a-afcc-a79f85219751@gmx.net>
Date:   Tue, 14 Nov 2023 20:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] media: videobuf2: Allow exporting of a struct
 dmabuf
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-4-umang.jain@ideasonboard.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231109210309.638594-4-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lEtah1+CEXmZfQprroDXTVetOrwED9+nX9BS3arjwJHN6ph6WKM
 ykF928OOJEU4gktD50xI3ZlBHgQB77cNHAmyk2yxOvngrS07BhPacCqEGq8jIsWrH4/FGL7
 qq9tQR/1k5sTTD1cpE9hWk8vjecnWBrMcb+agC34NOdbrWf8dp1+d/yf2IU3oLFbgE9xzhn
 Gz3X6mpsZJo9tmY7VMOZQ==
UI-OutboundReport: notjunk:1;M01:P0:QXnNKUX7WoI=;3LsnX/DFkXNv40xdv2JyNY2Edo/
 JwBaUF7eHGzK8sceqxRe1TxiuGSqMI2w5GvJ9dfmYfDEeLgxKIPkXWYA79tZNObHevFx8W8Tm
 9siwrBgsdaoI/qHMf+wQBBY8i9Cd5YfHs6rZBQXQCgSb7l+CPYe18wIrDF2/3yAjIxauinI6l
 QusjfNzmzhRI+6d31c+UYBi6MsURGRG9dpTBVE114aE2Iy3oieA3+H+JLO3GCtTcRJtKImvX7
 CSo2Oe2AYZqmaMK9DQn9Oj54jeApA0bXUtxXtY74eDOioDNfJbKhH5YXnVZt593dK5IPZ7USK
 6+6uvvgCNB6kNBX1JzxAvmaa+3dxNjtRz17gRbP0K3z8M51kWWDbgneuJpAajjrVXPUMegXTR
 qzurkHwy8z5slGIjNVNxYFRwJ+RrKwzNXCfbjvbJWEAuguz+ze0NGGUYysHVc9NKYXAqAM1zK
 +yOV3gbvUQPUJYkh0B2P4O1gyM+7nc29WVKH3UjAoGuqA300kVOxYhD7f0b01xZLTMl5pHyxJ
 puziENTtdQsXeGRdYULgO0x36Gel+iziIWdjCkJrYR57k1+hTntcK5J42hEjMsRa057QZhtyu
 I6tfi/sggJGW4taFh00Pyh8of/oZY1uc7f5glRhB3eUsF3HFkqw73ETDFxpH3ElMESyxniNAo
 hC84hTalFDpubawYjwHE99IrjLgxJiWdQN3DDioj626OAv9H3mf1Vtd9Wp3A9nPVn3tVRlGnP
 SXZ2HeYSaplnDalUCPPTU1WzrM94fIF/XPmpZgJ3J9dcT/mjtLuABSoswo3LDozC5Zwb7maGu
 ATQWe6YNw3AJ3MxrVuCzH7DeFWr6kp8AvLLem9q9lv04XFrsgmZ1vSJZkM2Lx0MeWxxdRuKuk
 vbkCo8R1XlI9HpHW6V8PNJChrSb7Ug6kqDoVwfI23+2HXzcYuLe25cv7pCJKZm2xZlAJ+xMUv
 WIxRUw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 09.11.23 um 22:02 schrieb Umang Jain:
> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
>
> videobuf2 only allowed exporting a dmabuf as a file descriptor,
> but there are instances where having the struct dma_buf is
> useful within the kernel.
>
> Split the current implementation into two, one step which
> exports a struct dma_buf, and the second which converts that
> into an fd.
>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---

...

> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-co=
re.h
> index 4b6a9d2ea372..cba4e495f6a2 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -925,6 +925,21 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned=
 int type);
>    */
>   int vb2_core_streamoff(struct vb2_queue *q, unsigned int type);
>
> +/**
> + * vb2_core_expbuf_dmabuf() - Export a buffer as a dma_buf structure
> + * @q:         videobuf2 queue
> + * @type:      buffer type
> + * @index:     id number of the buffer
> + * @plane:     index of the plane to be exported, 0 for single plane qu=
eues
> + * @flags:     flags for newly created file, currently only O_CLOEXEC i=
s
> + *             supported, refer to manual of open syscall for more deta=
ils

i think "newly created file" could be confusing here

> + *
> + * Return: Returns the dmabuf pointer
> + */
> +struct dma_buf *vb2_core_expbuf_dmabuf(struct vb2_queue *q, unsigned in=
t type,
> +				       unsigned int index, unsigned int plane,
> +				       unsigned int flags);
> +
>   /**
>    * vb2_core_expbuf() - Export a buffer as a file descriptor.
>    * @q:		pointer to &struct vb2_queue with videobuf2 queue.
