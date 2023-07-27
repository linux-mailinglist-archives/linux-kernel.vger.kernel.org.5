Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E84D764EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjG0JLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjG0JLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CC549D7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690448098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/5paF6Ykf/HR83J793r3ewLreNBy44O4jgk14P4ZU8=;
        b=H955EESaArrm4U0/PbLujsB1wQdnG+cdqIyGTPt0R/JpkbhRqIqhyAXP/9nDbVfYtTXauQ
        /h5nX9Sr3P0cPJE21SP7HzVBNHsLjlroSz5dBmYgA1uNQelOTwTrGacVV7/9786tDOnM+w
        EEsb2l2Y3G67HG5Rc+wEgqdMTSC8RXo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-NryxKjCAMr26Fb2Uoq_plw-1; Thu, 27 Jul 2023 04:54:57 -0400
X-MC-Unique: NryxKjCAMr26Fb2Uoq_plw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99bb3a2c781so40886666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448096; x=1691052896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/5paF6Ykf/HR83J793r3ewLreNBy44O4jgk14P4ZU8=;
        b=VDluOGKaFyBEol/6t29GEnYseJcfqKFaK48LNqz+Op0NxiRgzq7ycCGcriONcoNp5W
         DLpzxtnHiNDmVugRZu0IS/aWUTM1E/7SI7wg+tKLV0l3hJsTM0qFqpbNWIWBpRxm7LOs
         t5tnGbKHTS26wE8GQFaZ2ZeeaR3sQC4b6Dqy18QUMSLScYvHUyifQACUTVckMQe4+O7l
         1oWsZyAILI4Cn8lLg7rYrpCSJgJ0Ed/U8Aze8nMJ+Fv2fGFLtPDu9Y5AozMN2CFeTPtw
         XGB28Rj0l2WpcJfKmg6lwy7Ckhf2nXv/8v/vAtebnvZxsVg5A9aEo5Y5NnK3ELImOO7y
         YMpg==
X-Gm-Message-State: ABy/qLasrSFTUqcIGSSrMaAZWekcquPc49e7z08s9OEK2eVwlm1NGhiX
        Zy/ByPBDPlrrU8aS+Cr9O7bqCTC1IABlnmHxCLduSzptEzAfe1QvOQKiiKDkVzZANOgZO24Xlet
        15nSZUxAEqVb2EOnBdETrGXKL
X-Received: by 2002:a17:906:4e:b0:994:54ff:10f6 with SMTP id 14-20020a170906004e00b0099454ff10f6mr1252762ejg.30.1690448095934;
        Thu, 27 Jul 2023 01:54:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHcD3CURJMdg3NYZ8AZsEK4plNky1gLjXd8Cwvx/xUzv38SfV6WriScq+IHFtwAhFGzRaQCvg==
X-Received: by 2002:a17:906:4e:b0:994:54ff:10f6 with SMTP id 14-20020a170906004e00b0099454ff10f6mr1252744ejg.30.1690448095632;
        Thu, 27 Jul 2023 01:54:55 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.217.102])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906960f00b00988dbbd1f7esm500842ejx.213.2023.07.27.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:54:55 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:54:51 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: MSG_ZEROCOPY flag support
Message-ID: <p4v23nvilf45gl3snuyvypnhi3zfrmbi7qxtrdalluflt773sf@yt6tkgxiliar>
References: <20230720214245.457298-1-AVKrasnov@sberdevices.ru>
 <20230720214245.457298-5-AVKrasnov@sberdevices.ru>
 <091c067b-43a0-da7f-265f-30c8c7e62977@sberdevices.ru>
 <2k3cbz762ua3fmlben5vcm7rs624sktaltbz3ldeevwiguwk2w@klggxj5e3ueu>
 <51022d5f-5b50-b943-ad92-b06f60bef433@sberdevices.ru>
 <3d1d76c9-2fdb-3dfe-222a-b2184cf17708@sberdevices.ru>
 <o6axh6mxd6mxai2zrpax6wa25slns7ysz5xsegntskvfxl53mt@wowjgb3jazt6>
 <f020405e-86af-1b66-c5f4-9bec98298f44@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f020405e-86af-1b66-c5f4-9bec98298f44@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:32:00AM +0300, Arseniy Krasnov wrote:
>On 25.07.2023 15:28, Stefano Garzarella wrote:
>> On Tue, Jul 25, 2023 at 12:16:11PM +0300, Arseniy Krasnov wrote:
>>> On 25.07.2023 11:46, Arseniy Krasnov wrote:
>>>> On 25.07.2023 11:43, Stefano Garzarella wrote:
>>>>> On Fri, Jul 21, 2023 at 08:09:03AM +0300, Arseniy Krasnov wrote:

[...]

>>>>>>> +    t = vsock_core_get_transport(info->vsk);
>>>>>>>
>>>>>>> -        if (msg_data_left(info->msg) == 0 &&
>>>>>>> -            info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
>>>>>>> -            hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>>>>>>> +    if (t->msgzerocopy_check_iov &&
>>>>>>> +        !t->msgzerocopy_check_iov(iov_iter))
>>>>>>> +        return false;
>>>>>
>>>>> I'd avoid adding a new transport callback used only internally in virtio
>>>>> transports.
>>>>
>>>> Ok, I see.
>>>>
>>>>>
>>>>> Usually the transport callbacks are used in af_vsock.c, if we need a
>>>>> callback just for virtio transports, maybe better to add it in struct
>>>>> virtio_vsock_pkt_info or struct virtio_vsock_sock.
>>>
>>> Hm, may be I just need to move this callback from 'struct vsock_transport' to parent 'struct virtio_transport',
>>> after 'send_pkt' callback. In this case:
>>> 1) AF_VSOCK part is not touched.
>>> 2) This callback stays in 'virtio_transport.c' and is set also in this file.
>>>   vhost and loopback are unchanged - only 'send_pkt' still enabled in both
>>>   files for these two transports.
>>
>> Yep, this could also work!
>>
>> Stefano
>
>Great! I'll send this implementation when this patchset for MSG_PEEK will be merged
>to net-next as both conflicts with each other.
>
>https://lore.kernel.org/netdev/20230726060150-mutt-send-email-mst@kernel.org/T/#m56f3b850361a412735616145162d2d9df25f6350

Ack!

Thanks,
Stefano

